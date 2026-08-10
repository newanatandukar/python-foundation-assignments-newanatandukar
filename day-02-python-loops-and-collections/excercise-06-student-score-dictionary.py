"""
Exercise: Student Score Dictionary
Student: Newana Tandukar
Day: 2
"""

# Input
student_scores = {
    "Anisha": 78,
    "Ravi": 55,
    "Maya": 92,
    "Sagar": 61,
    "Nima": 48
}

# Print every student and score.
print("Student Score List")
for name, score in student_scores.items():
    print(f" {name}: {score}")

# Create a dictionary containing only students who scored at least 60.
distinction_students = {name: score for name, score in student_scores.items() if score >= 60}
print("\nStudents with score at least 60:\n", distinction_students)


# Find the student with the highest score.
top_student = max(student_scores, key=student_scores.get)
print("\nTop student:\n", top_student, "with score", student_scores[top_student])

# Average score
average_score = sum(student_scores.values()) / len(student_scores)
print("\nAverage score: ", average_score)
