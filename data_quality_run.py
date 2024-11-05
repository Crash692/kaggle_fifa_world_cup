import subprocess
import os
import pandas as pd

# Define folder paths
data_quality_checks_folder = "data_quality_checks"
results_folder = "data_quality_results"

# Ensure the results folder exists
if not os.path.exists(results_folder):
    os.makedirs(results_folder)

# Data quality check scripts with paths
scripts = {
    "accuracy": os.path.join(data_quality_checks_folder, "accuracy_check.py"),
    "completeness": os.path.join(data_quality_checks_folder, "completeness_check.py"),
    "consistency": os.path.join(data_quality_checks_folder, "consistency_check.py"),
    "timeliness": os.path.join(data_quality_checks_folder, "timeliness_check.py"),
    "uniqueness": os.path.join(data_quality_checks_folder, "uniqueness_check.py")
}

# Run each data quality check script
for name, script_path in scripts.items():
    if os.path.exists(script_path):
        try:
            subprocess.run(["python", script_path], check=True)
        except subprocess.CalledProcessError as e:
            print(f"Error running {script_path}: {e}")
    else:
        print(f"Script {script_path} not found. Skipping {name} check.")

# Function to calculate KPIs and compile results
def calculate_kpis():
    kpi_data = []

    # Accuracy KPI
    try:
        accuracy_df = pd.read_csv(f"{results_folder}/matches_accuracy_results.csv")
        accuracy_rate = (accuracy_df["Accuracy_Status"] == "Accurate").mean() * 100
        kpi_data.append({"Check": "Accuracy", "KPI (%)": accuracy_rate})
    except FileNotFoundError:
        print("Accuracy results file not found.")

    # Completeness KPI
    try:
        completeness_df = pd.read_csv(f"{results_folder}/completeness_results.csv")
        completeness_rate = completeness_df["Completeness (%)"].mean()
        kpi_data.append({"Check": "Completeness", "KPI (%)": completeness_rate})
    except FileNotFoundError:
        print("Completeness results file not found.")

    # Consistency KPI
    try:
        consistency_df = pd.read_csv(f"{results_folder}/consistency.csv")
        inconsistency_count = consistency_df["Missing References"].sum()
        total_rows_checked = consistency_df["Total Rows Checked"].sum()
        consistency_rate = ((total_rows_checked - inconsistency_count) / total_rows_checked) * 100
        kpi_data.append({"Check": "Consistency", "KPI (%)": consistency_rate})
    except FileNotFoundError:
        print("Consistency results file not found.")

    # Timeliness KPI
    timeliness_files = [f for f in os.listdir(results_folder) if "timeliness" in f]
    timeliness_rates = []
    for file in timeliness_files:
        timeliness_df = pd.read_csv(os.path.join(results_folder, file))
        pass_rate = (timeliness_df["Timeliness_Result"] == "Pass").mean() * 100
        timeliness_rates.append(pass_rate)
    timeliness_kpi = sum(timeliness_rates) / len(timeliness_rates) if timeliness_rates else None
    if timeliness_kpi is not None:
        kpi_data.append({"Check": "Timeliness", "KPI (%)": timeliness_kpi})
    else:
        print("No timeliness results found.")

    # Uniqueness KPI
    try:
        uniqueness_df = pd.read_csv(f"{results_folder}/uniqueness_results.csv")
        uniqueness_rate = uniqueness_df["Uniqueness (%)"].mean()
        kpi_data.append({"Check": "Uniqueness", "KPI (%)": uniqueness_rate})
    except FileNotFoundError:
        print("Uniqueness results file not found.")

    # Save KPI summary
    kpi_summary_df = pd.DataFrame(kpi_data)
    kpi_summary_df.to_csv(f"{results_folder}/kpi_summary.csv", index=False)
    print("KPI Summary saved to 'kpi_summary.csv'.")

    return kpi_summary_df

if __name__ == "__main__":
    kpi_summary = calculate_kpis()
    print(kpi_summary)
