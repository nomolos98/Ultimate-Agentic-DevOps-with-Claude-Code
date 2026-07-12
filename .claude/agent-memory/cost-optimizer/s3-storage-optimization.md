---
name: s3-storage-class-optimization
description: S3 bucket for static portfolio can use Intelligent-Tiering for future cost optimization
metadata:
  type: project
---

## S3 Storage Class Optimization

**Resource:** `aws_s3_bucket.website` in `terraform/main.tf`

**Current State:** Default to Standard storage class, no lifecycle policies

**Optimization Options:**
1. **Intelligent-Tiering** (recommended for uncertain access patterns)
   - Automatic tiering after 90-180 days
   - No retrieval fees within tiers
   - Cost: Minimal monitoring overhead ($0.0025/1000 objects)

2. **Standard-IA + Lifecycle** (if you want manual control)
   - Transition after 30 days to cheaper tier
   - Small retrieval fees ($0.01 per 1K requests)
   - Savings only materialize if objects age

**Why:** Portfolio content is static and rarely accessed directly (goes through CloudFront). Transitioning old objects to cheaper storage tiers is prudent.

**How to apply:**
- Add `aws_s3_bucket_intelligent_tiering_configuration` resource block to `main.tf`
- Or add `aws_s3_bucket_lifecycle_configuration` resource with 30-day transition rule

**Impact:** <$1/month current (portfolio is <100MB). Value is establishing good cost practices for future growth.

**Status:** Identified but low-priority. Optional to implement.
