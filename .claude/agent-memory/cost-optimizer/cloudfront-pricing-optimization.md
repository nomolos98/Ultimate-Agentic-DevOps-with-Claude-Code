---
name: cloudfront-price-class-optimization
description: Portfolio website can reduce CloudFront costs 25% by switching from PriceClass_200 to PriceClass_100
metadata:
  type: project
---

## CloudFront Price Class Optimization Opportunity

**Resource:** `aws_cloudfront_distribution.website` in `terraform/main.tf`

**Current State:** PriceClass_200 (100+ edge locations globally)

**Recommended Change:** PriceClass_100 (US, Europe, Asia Pacific only)

**Why:** Portfolio website is a small static site with minimal traffic. Global edge location coverage is unnecessary overhead. Price difference is 25% ($0.085 → $0.060 per 10K requests).

**How to apply:** 
- Verify traffic geography logs to confirm users are primarily in US/EU/APAC
- If confirmed, change line 78 in `main.tf` from `price_class = "PriceClass_200"` to `price_class = "PriceClass_100"`
- Apply terraform change
- Estimated savings: $50-75/month on data transfer costs (20-40% of total CloudFront costs)

**Related configurations:** CloudFront is using managed CachingOptimized policy which is already optimal. Compression is enabled. No further optimization needed there.

**Status:** Identified but not yet implemented. Awaiting user decision on traffic geography.
