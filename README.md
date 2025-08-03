# Uber Supply-Demand Gap Analysis

## Project Overview

This project performs an **Exploratory Data Analysis (EDA)** on Uber ride request data to identify patterns, gaps, and challenges in Uber's supply-demand dynamics across different city zones and times of the day. The primary goal is to uncover actionable insights that can help optimize driver allocation, reduce cancellations, and improve overall service efficiency.

## Data Description

- The dataset contains **6,745 Uber ride requests**, with key fields including:
  - `Request id`: Unique identifier for each ride request.
  - `Pickup point`: Indicates the pickup location category (`City` or `Airport`).
  - `Driver id`: Assigned driver’s unique identifier (may be missing for unfulfilled or failed trips).
  - `Status`: Ride outcome, which may be one of `Trip Completed`, `Cancelled`, or `No Cars Available`.
  - `Request timestamp`: Date and time when the ride was requested.
  - `Drop timestamp`: Date and time when the ride ended (may be missing for incomplete trips).

## Project Objectives

- Analyze Uber's supply and demand to identify:
  - When and where demand exceeds driver availability.
  - Patterns of trip cancellations and failures.
  - Peak hours and zones with high unmet demand.
- Generate insights through visualizations and statistical summaries.
- Provide strategic recommendations to improve Uber's operational efficiency.

## Work Done

### 1. Data Cleaning and Wrangling
- Checked for and confirmed absence of duplicate records.
- Converted timestamp columns to datetime objects.
- Handled missing values meaningfully, especially in `Driver id` and `Drop timestamp` columns.
- Extracted temporal features like hour of the day for time series analysis.

### 2. Exploratory Data Analysis
- Studied distribution of requests by pickup point and status.
- Analyzed cancellation and “No Cars Available” occurrences by location and time.
- Investigated the gap between demand (requests) and supply (completed trips) hourly.
- Visualized driver performance via completed trips to identify high and low performers.
- Generated multiple plots including bar charts, line charts, heatmaps, and histograms to better understand the data.

### 3. Insights and Findings
- More than 55% of ride requests were not fulfilled, showing a substantial supply-demand mismatch.
- Airport pickups face significant shortages in evening hours leading to many “No Cars Available” cases.
- City pickups experience higher cancellation rates, particularly in morning hours.
- Driver activity is uneven, with a few drivers completing most trips.
- Most completed trips are short in duration, important for dynamic fare or route optimization.

### 4. Recommendations
- Enhance driver availability at the Airport during peaks via incentives.
- Investigate and address causes of cancellations in the City.
- Implement dynamic driver allocation based on real-time demand.
- Use driver performance data to reward top performers and support lower performers through training.

## How to Run the Analysis

1. Clone the repository.
2. Ensure Python 3.x is installed.
3. Install required packages:
