from flask import Flask, render_template, request, session, redirect, url_for
import mysql.connector
from werkzeug.security import generate_password_hash, check_password_hash
import os
from dotenv import load_dotenv

load_dotenv()

app = Flask(__name__)

app.secret_key = "cyber-risk-secret-key"

db = mysql.connector.connect(
    host=os.getenv("DB_HOST"),
    user=os.getenv("DB_USER"),
    password=os.getenv("DB_PASSWORD"),
    database=os.getenv("DB_NAME")
)

@app.route("/")
def home():
    return render_template("index.html")


@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        email = request.form["email"]
        password = request.form["password"]

        cursor = db.cursor(dictionary=True)

        sql = "SELECT * FROM users WHERE email = %s"
        cursor.execute(sql, (email,))
        user = cursor.fetchone()

        cursor.close()

        if user and check_password_hash(user["password"], password):
            session["user_id"] = user["id"]
            session["user_name"] = user["name"]

            return redirect(url_for("dashboard"))

        return "Invalid email or password"

    return render_template("login.html")


@app.route("/register", methods=["GET", "POST"])
def register():

    if request.method == "POST":

        name = request.form["name"]
        email = request.form["email"]
        password = request.form["password"]
        confirm_password = request.form["confirm_password"]

        # Check password confirmation
        if password != confirm_password:
            return "Passwords do not match"

        cursor = db.cursor(dictionary=True)

        # Check whether email already exists
        cursor.execute(
            "SELECT id FROM users WHERE email = %s",
            (email,)
        )

        existing_user = cursor.fetchone()

        if existing_user:
            cursor.close()
            return "Email already registered. Please use a different email."

        # Hash password
        hashed_password = generate_password_hash(password)

        # Create new user
        cursor = db.cursor()

        sql = """
            INSERT INTO users (name, email, password)
            VALUES (%s, %s, %s)
        """

        cursor.execute(
            sql,
            (name, email, hashed_password)
        )

        db.commit()
        cursor.close()

        return redirect(url_for("login"))

    return render_template("register.html")


@app.route("/business-profile", methods=["GET", "POST"])
def business_profile():

    if request.method == "POST":

        user_id = session.get("user_id")

        if not user_id:
            return redirect(url_for("login"))

        business_name = request.form["business_name"]
        business_type = request.form["business_type"]
        employees = request.form["employees"]
        digital_services = request.form["digital_services"]
        data_handled = request.form["data_handled"]

        cursor = db.cursor()

        sql = """
            INSERT INTO businesses
            (name, industry, user_id, employees, digital_services, data_handled)
            VALUES (%s, %s, %s, %s, %s, %s)
        """

        cursor.execute(
            sql,
            (
                business_name,
                business_type,
                user_id,
                employees,
                digital_services,
                data_handled
            )
        )

        db.commit()
        cursor.close()

        return redirect(url_for("dashboard"))

    return render_template("business_profile.html")


@app.route("/questionnaire", methods=["GET", "POST"])
def questionnaire():

    if request.method == "POST":

        cursor = db.cursor()

        # Get logged-in user
        user_id = session.get("user_id")

        if not user_id:
            cursor.close()
            return redirect(url_for("login"))

        # Get business belonging to this user
        cursor.execute(
            "SELECT id FROM businesses WHERE user_id = %s ORDER BY id DESC LIMIT 1",
            (user_id,)
        )

        business = cursor.fetchone()

        if not business:
            cursor.close()
            return redirect(url_for("business_profile"))

        business_id = business[0]

        # Create assessment
        cursor.execute(
            "INSERT INTO assessments (business_id) VALUES (%s)",
            (business_id,)
        )

        assessment_id = cursor.lastrowid

        # Risk information
        risk_data = {
            1: ("Weak Passwords", 4, 4),
            2: ("No Multi-Factor Authentication", 5, 5),
            3: ("Inadequate Firewall Protection", 4, 5),
            4: ("Inadequate Antivirus Protection", 4, 4),
            5: ("Lack of Data Backup", 3, 5),
            6: ("Lack of Employee Training", 4, 4),
            7: ("Poor Access Control", 4, 5),
            8: ("Poor Data Protection", 4, 5),
            9: ("No Incident Response Plan", 3, 4)
        }

        recommendations = {
            1: "Use strong and unique passwords for all business accounts.",
            2: "Enable Multi-Factor Authentication for important accounts.",
            3: "Configure and maintain a firewall to protect the business network.",
            4: "Install and regularly update antivirus software.",
            5: "Maintain regular backups of important business data.",
            6: "Provide regular cybersecurity awareness training to employees.",
            7: "Restrict access to sensitive data to authorized employees.",
            8: "Use appropriate security controls to protect sensitive business data.",
            9: "Create and maintain a cybersecurity incident response plan."
        }

        # Get questions
        cursor.execute("SELECT id FROM questions")
        questions = cursor.fetchall()

        total_score = 0
        risk_count = 0

        for question in questions:

            question_id = question[0]

            selected_option = request.form.get(
                f"question_{question_id}"
            )

            if selected_option:

                # Store answer
                sql = """
                    INSERT INTO answers
                    (question_id, selected_option)
                    VALUES (%s, %s)
                """

                cursor.execute(
                    sql,
                    (question_id, selected_option)
                )

                # If answer is No, create risk
                if selected_option.lower() == "no":

                    description, likelihood, impact = risk_data[question_id]

                    risk_score = likelihood * impact

                    if risk_score <= 5:
                        severity = "LOW"
                    elif risk_score <= 10:
                        severity = "MEDIUM"
                    elif risk_score <= 20:
                        severity = "HIGH"
                    else:
                        severity = "CRITICAL"

                    # Store risk
                    sql = """
                        INSERT INTO risks
                        (
                            assessment_id,
                            description,
                            severity,
                            likelihood,
                            impact,
                            risk_score
                        )
                        VALUES (%s, %s, %s, %s, %s, %s)
                    """

                    cursor.execute(
                        sql,
                        (
                            assessment_id,
                            description,
                            severity,
                            likelihood,
                            impact,
                            risk_score
                        )
                    )

                    # Store recommendation
                    sql = """
                        INSERT INTO recommendations
                        (assessment_id, action_item)
                        VALUES (%s, %s)
                    """

                    cursor.execute(
                        sql,
                        (
                            assessment_id,
                            recommendations[question_id]
                        )
                    )

                    total_score += risk_score
                    risk_count += 1

        db.commit()
        cursor.close()

        # Calculate overall risk
        if risk_count == 0:
            overall_risk = "LOW"
        elif total_score <= 20:
            overall_risk = "MEDIUM"
        elif total_score <= 50:
            overall_risk = "HIGH"
        else:
            overall_risk = "CRITICAL"

        # Calculate security score
        security_score = 100 - total_score

        if security_score < 0:
            security_score = 0

        # Get risks for this assessment
        cursor = db.cursor(dictionary=True)

        cursor.execute(
            """
            SELECT description AS risk_name, severity
            FROM risks
            WHERE assessment_id = %s
            """,
            (assessment_id,)
        )

        risks = cursor.fetchall()

        # Get recommendations for this assessment
        cursor.execute(
            """
            SELECT action_item
            FROM recommendations
            WHERE assessment_id = %s
            """,
            (assessment_id,)
        )

        recommendations_list = cursor.fetchall()

        cursor.close()

        return render_template(
            "risk_result.html",
            security_score=security_score,
            total_score=total_score,
            risk_count=risk_count,
            overall_risk=overall_risk,
            risks=risks,
            recommendations=recommendations_list
        )

    # Display questionnaire
    cursor = db.cursor(dictionary=True)

    cursor.execute("SELECT * FROM questions")
    questions = cursor.fetchall()

    cursor.close()

    return render_template(
        "questionnaire.html",
        questions=questions
    )


@app.route("/test-db")
def test_db():

    cursor = db.cursor()

    cursor.execute("SELECT 1")

    result = cursor.fetchone()

    cursor.close()

    return f"MySQL connected successfully! Result: {result[0]}"


@app.route("/logout")
def logout():

    session.clear()

    return redirect(url_for("login"))


@app.route("/assessment/<int:assessment_id>")
def assessment_details(assessment_id):

    user_id = session.get("user_id")

    if not user_id:
        return redirect(url_for("login"))

    cursor = db.cursor(dictionary=True)

    # Check that the assessment belongs to the logged-in user's business
    cursor.execute(
        """
        SELECT a.id, a.created_at
        FROM assessments a
        JOIN businesses b ON a.business_id = b.id
        WHERE a.id = %s
        AND b.user_id = %s
        """,
        (assessment_id, user_id)
    )

    assessment = cursor.fetchone()

    if not assessment:
        cursor.close()
        return "Assessment not found", 404

    # Get risks
    cursor.execute(
        """
        SELECT description, severity, likelihood, impact, risk_score
        FROM risks
        WHERE assessment_id = %s
        """,
        (assessment_id,)
    )

    risks = cursor.fetchall()

    # Get recommendations
    cursor.execute(
        """
        SELECT action_item
        FROM recommendations
        WHERE assessment_id = %s
        """,
        (assessment_id,)
    )

    recommendations = cursor.fetchall()

    cursor.close()

    # Calculate total risk score
    total_risk_score = sum(
        risk["risk_score"] for risk in risks
    )

    # Calculate security score
    security_score = 100 - total_risk_score

    if security_score < 0:
        security_score = 0

    # Calculate overall risk
    risk_count = len(risks)

    if risk_count == 0:
        overall_risk = "LOW"
    elif total_risk_score <= 20:
        overall_risk = "MEDIUM"
    elif total_risk_score <= 50:
        overall_risk = "HIGH"
    else:
        overall_risk = "CRITICAL"

    assessment["security_score"] = security_score
    assessment["risk_count"] = risk_count
    assessment["overall_risk"] = overall_risk

    return render_template(
        "Assessment.html",
        assessment=assessment,
        risks=risks,
        recommendations=recommendations
    )


@app.route("/history")
def history():

    user_id = session.get("user_id")

    if not user_id:
        return redirect(url_for("login"))

    cursor = db.cursor(dictionary=True)

    # Get the user's business
    cursor.execute(
        """
        SELECT id
        FROM businesses
        WHERE user_id = %s
        ORDER BY id DESC
        LIMIT 1
        """,
        (user_id,)
    )

    business = cursor.fetchone()

    if not business:
        cursor.close()
        return redirect(url_for("business_profile"))

    business_id = business["id"]

    # Get all assessments for this business
    cursor.execute(
        """
        SELECT id, created_at
        FROM assessments
        WHERE business_id = %s
        ORDER BY id DESC
        """,
        (business_id,)
    )

    assessment_rows = cursor.fetchall()

    assessments = []

    for assessment in assessment_rows:

        assessment_id = assessment["id"]

        # Get risks for this assessment
        cursor.execute(
            """
            SELECT risk_score
            FROM risks
            WHERE assessment_id = %s
            """,
            (assessment_id,)
        )

        risks = cursor.fetchall()

        risk_count = len(risks)

        total_risk_score = sum(
            risk["risk_score"] for risk in risks
        )

        # Calculate security score
        security_score = 100 - total_risk_score

        if security_score < 0:
            security_score = 0

        # Calculate overall risk
        if risk_count == 0:
            overall_risk = "LOW"
        elif total_risk_score <= 20:
            overall_risk = "MEDIUM"
        elif total_risk_score <= 50:
            overall_risk = "HIGH"
        else:
            overall_risk = "CRITICAL"

        assessments.append({
            "id": assessment_id,
            "created_at": assessment["created_at"],
            "security_score": security_score,
            "risk_count": risk_count,
            "overall_risk": overall_risk
        })

    cursor.close()

    return render_template(
        "history.html",
        assessments=assessments
    )


@app.route("/dashboard")
def dashboard():

    user_id = session.get("user_id")

    if not user_id:
        return redirect(url_for("login"))

    cursor = db.cursor(dictionary=True)

    # Get logged-in user and latest business
    cursor.execute(
        """
        SELECT u.name AS user_name,
               b.id AS business_id,
               b.name AS business_name
        FROM users u
        LEFT JOIN businesses b ON u.id = b.user_id
        WHERE u.id = %s
        ORDER BY b.id DESC
        LIMIT 1
        """,
        (user_id,)
    )

    user_data = cursor.fetchone()

    if not user_data or not user_data["business_id"]:
        cursor.close()
        return redirect(url_for("business_profile"))

    business_id = user_data["business_id"]

    # Count assessments
    cursor.execute(
        """
        SELECT COUNT(*) AS assessment_count
        FROM assessments
        WHERE business_id = %s
        """,
        (business_id,)
    )

    assessment_data = cursor.fetchone()

    assessment_count = assessment_data["assessment_count"]

    # Get latest assessment
    cursor.execute(
        """
        SELECT id, created_at
        FROM assessments
        WHERE business_id = %s
        ORDER BY id DESC
        LIMIT 1
        """,
        (business_id,)
    )

    latest_assessment = cursor.fetchone()

    # Default values
    security_score = 100
    risk_count = 0
    overall_risk = "LOW"
    latest_assessment_date = None

    if latest_assessment:

        assessment_id = latest_assessment["id"]

        # Get latest assessment date
        latest_assessment_date = latest_assessment["created_at"]

        # Get risks from latest assessment
        cursor.execute(
            """
            SELECT risk_score
            FROM risks
            WHERE assessment_id = %s
            """,
            (assessment_id,)
        )

        risks = cursor.fetchall()

        risk_count = len(risks)

        # Calculate total risk score
        total_risk_score = sum(
            risk["risk_score"] for risk in risks
        )

        # Calculate security score
        security_score = 100 - total_risk_score

        if security_score < 0:
            security_score = 0

        # Calculate overall risk
        if risk_count == 0:
            overall_risk = "LOW"
        elif total_risk_score <= 20:
            overall_risk = "MEDIUM"
        elif total_risk_score <= 50:
            overall_risk = "HIGH"
        else:
            overall_risk = "CRITICAL"

    cursor.close()

    return render_template(
        "dashboard.html",
        user_name=user_data["user_name"],
        business_name=user_data["business_name"],
        security_score=security_score,
        overall_risk=overall_risk,
        risk_count=risk_count,
        assessment_count=assessment_count,
        latest_assessment_date=latest_assessment_date
    )


if __name__ == "__main__":
    app.run(debug=True, port=5001)

