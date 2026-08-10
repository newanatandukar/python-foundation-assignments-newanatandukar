"""
Exercise: Pipeline Health Status
Student: Newana Tandukar
Day: 1
"""


def evaluate_pipeline(rows_loaded, rows_failed, runtime_minutes):
    """Print the failure rate and health status for one pipeline run."""
    total_rows = rows_loaded + rows_failed
    failure_rate = (rows_failed / total_rows) * 100

    if failure_rate <= 2 and runtime_minutes <= 20:
        status = "Healthy"
    elif failure_rate <= 5:
        status = "Warning"
    else:
        status = "Critical"

    print(f"Failure rate: {failure_rate:.2f}%")
    print(f"Pipeline status: {status}")


# Sample pipeline runs
evaluate_pipeline(9800, 200, 18)
evaluate_pipeline(9500, 500, 15)
evaluate_pipeline(9900, 100, 30)
