resource "aws_cloudwatch_dashboard" "cloudx" {
  dashboard_name = "cloudx"

  dashboard_body = <<EOF
{
  "widgets": [
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 8,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/EC2",
            "CPUUtilization"
          ]
        ],
        "period": 60,
        "stat": "Maximum",
        "region": "us-east-1",
        "title": "EC2|CPU Utilization"
      }
    }
  ]
}
EOF
}