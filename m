Return-Path: <linux-acpi+bounces-17681-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E45BCA059
	for <lists+linux-acpi@lfdr.de>; Thu, 09 Oct 2025 18:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DD2B188CCE0
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Oct 2025 16:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73752F90D6;
	Thu,  9 Oct 2025 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvAqOh2X"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDDE2F90CE;
	Thu,  9 Oct 2025 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025516; cv=none; b=CTuksV3dNGNXy8NOn7A9WD0Taa8VCywEuhg4Wi6Vrzx9dVlPdF+RY8+/PAt4u5Q2F3GhD4wym+ge6U4em1eveyoldt+Gy7okV1m0OWLCIwmeYZtJXspPyKJAciEEZGG2sOLuH4+68rowEN9aLvCXJ77FS+LxA2okiZtcvsSckto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025516; c=relaxed/simple;
	bh=2VMRvZUR+GylLpvVOPJszoF+rm4fGpiTvpbNyNrFZls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=efy6ze2Yismut1nlQkQzSZdi+5857RCwmbVvcOhwOn3aJ3Oh04hJGSCkUPj5VSsUxfo+I8ng/29eb86tEPSRyLQo+eEzjZZVgHgv8BgH4SFRu1d02y3aCBsaTD6sqvRcvBATsDaRMbPC32AStb3nfyQNSHtgdZutvd9xCwW3zVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvAqOh2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70538C4CEE7;
	Thu,  9 Oct 2025 15:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025516;
	bh=2VMRvZUR+GylLpvVOPJszoF+rm4fGpiTvpbNyNrFZls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gvAqOh2Xefl3rUnSp/skeGZHKddCwagaKLoKUqFoQPCuU+f39HoHLH4Rj6bFek/zu
	 WDP2kTH/mjIvGZ4vFyiTLQXg4pwrwWWpRGgHmIZCmvm8RjeMGoYuhOA4uuyyHpZE5V
	 xeHAmIFyv6ZsQPsW4HBwf66ldDg4+UAVLQv3LFbd9CPBNB/zeRhwJWGJJrbhjQOPPF
	 CJRq7c1zMLZd+xe5p3NEr2qTY7wcnz621dMf43cHpZmD0UzXWwWChHPjhaINi7Xy9U
	 znniGygT3YPl9AR1WmZWFZFIKtIYqQ1H8xJJGoaJkt7iU9SoB28cYRF856YlblgoVS
	 if6m14XNH6Z9g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.12] ACPI: sysfs: Use ACPI_FREE() for freeing an ACPI object
Date: Thu,  9 Oct 2025 11:54:51 -0400
Message-ID: <20251009155752.773732-25-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009155752.773732-1-sashal@kernel.org>
References: <20251009155752.773732-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.1
Content-Transfer-Encoding: 8bit

From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>

[ Upstream commit 149139ddcb99583fdec8d1eaf7dada41e5896101 ]

Since str_obj is allocated by ACPICA in acpi_evaluate_object_typed(),
it should be free with ACPI_FREE() rather than with kfree(), so use
the former instead of the latter for freeing it.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Link: https://patch.msgid.link/20250822061946.472594-1-kaushlendra.kumar@intel.com
[ rjw: Subject and changelog rewrite ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my comprehensive investigation of this commit and the ACPICA
memory management infrastructure, here is my analysis:

## Analysis Summary

**Backport Status: YES** (with low priority - code correctness/cleanup
fix)

## Detailed Technical Analysis

### What This Commit Fixes

This commit changes one line in `drivers/acpi/device_sysfs.c:467`:
- **Before**: `kfree(str_obj);`
- **After**: `ACPI_FREE(str_obj);`

The `str_obj` is allocated by `acpi_evaluate_object_typed()` at line
447, which uses ACPICA's internal allocation mechanism.

### The Core Issue

In the Linux kernel's ACPICA implementation, there are two possible
memory management paths:

1. **Normal Linux kernel builds** (ACPI_DBG_TRACK_ALLOCATIONS disabled):
   - `ACPI_FREE()` expands to `acpi_os_free()`
   - `acpi_os_free()` is implemented as `kfree()` (see
     `include/acpi/platform/aclinuxex.h:62-65`)
   - **Functionally equivalent**: `ACPI_FREE()` == `kfree()`

2. **ACPI debugging builds** (ACPI_DBG_TRACK_ALLOCATIONS enabled, only
   for acpi_exec utility):
   - `ACPI_FREE()` expands to `acpi_ut_free_and_track()`
   - This tracks allocations for memory leak detection
   - Using `kfree()` directly **breaks allocation tracking**

### Is This a Real Bug?

**In production Linux kernels: NO** - The code is functionally correct
because `ACPI_FREE()` and `kfree()` are equivalent.

**For ACPICA coding standards: YES** - Memory allocated by ACPICA
functions (like `acpi_evaluate_object_typed()`) should be freed using
`ACPI_FREE()` to maintain consistency and support debugging builds.

### Pattern of Similar Fixes

Multiple commits have addressed this same issue:
- `c00901e98b1e9`: "ACPI: pfr_update: use ACPI_FREE() to free
  acpi_object"
- `ae3075b54fa8d`: "ACPI: pfr_telemetry: use ACPI_FREE() to free
  acpi_object"
- `252f006676d1b`: "net: wwan: iosm: use ACPI_FREE() but not kfree()"

All cite the same rationale: "we need to track the allocation of
acpi_object when ACPI_DBG_TRACK_ALLOCATIONS enabled"

### Why This Should Be Backported

1. **Code correctness**: Follows ACPICA conventions -
   allocation/deallocation should use matching functions
2. **Extremely low risk**: In the kernel, this is a no-op change since
   the functions are equivalent
3. **Consistency**: Part of a wider effort to fix this pattern across
   the kernel
4. **Debugging support**: Enables proper memory leak detection in ACPICA
   debugging tools
5. **Small, contained change**: Single line modification with no side
   effects
6. **Already backported**: This commit is itself a stable backport
   (upstream: `149139ddcb99`)

### Why This Has Low Priority

1. **No user-visible impact**: Does not fix crashes, data corruption, or
   functional bugs
2. **No security implications**: Not exploitable or security-related
3. **Cleanup/style fix**: Primarily about code correctness rather than
   fixing broken functionality

### Conclusion

This is a **low-priority correctness fix** suitable for backporting.
While it doesn't fix a critical bug affecting users, it:
- Maintains proper ACPICA coding standards
- Has zero risk of regression (equivalent functions)
- Aligns with a consistent pattern of similar fixes in stable trees
- Improves code maintainability and debugging capability

The commit follows stable kernel rules by being a small, safe
improvement with clear benefits and no downsides.

 drivers/acpi/device_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 3961fc47152c0..cd199fbe4dc90 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -464,7 +464,7 @@ static ssize_t description_show(struct device *dev,
 
 	buf[result++] = '\n';
 
-	kfree(str_obj);
+	ACPI_FREE(str_obj);
 
 	return result;
 }
-- 
2.51.0


