Return-Path: <linux-acpi+bounces-17682-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E52BCA03E
	for <lists+linux-acpi@lfdr.de>; Thu, 09 Oct 2025 18:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC3851A64F06
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Oct 2025 16:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581A82F0681;
	Thu,  9 Oct 2025 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRdsyckx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0DB2ED843;
	Thu,  9 Oct 2025 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025525; cv=none; b=NndI3Q5QWWyZ7B7tARQERU74f6143QUt/SHUQXa5Ehq5nfSkbdJ52TzIMdcJ3SuZDwJirfgrW1XjgB8OI3mL+vgdk3oegtc1aIGY6XNwPZhKhT1sd/sJY1xTdiqBWda+X+4uEbRviC/c0Zpnikf/80bzoW2mw3jnapUy7OYKwjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025525; c=relaxed/simple;
	bh=c0/yRtuZB6nBDaoZ+fv+2NsdU6TXVA1P0+fsZjZuOls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WkEU9Gq22yBTHnmz5McHqfrEjGkfvPXJliVM4zyw4iQKnW2Tfg1kbJ9a+U9FbBQxq7WzFx4X5oQwudzKNwgViYwszUMMk55vxK/03czU2ia64wXm8ca+YVls94e5RFTd81vO39wH4I8/z50kKv+qgR4tAfaai7Mz5lKU2vYT7Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRdsyckx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4220CC4CEE7;
	Thu,  9 Oct 2025 15:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025525;
	bh=c0/yRtuZB6nBDaoZ+fv+2NsdU6TXVA1P0+fsZjZuOls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VRdsyckxe79GzY+WgOZ/lD4ihRmWBiEqmctQitu3YMj48/m//Wgy2FprK3c7Zkh9+
	 PT/wKkosaX/WupFDW+6pj+M/n5zkKPYLi7VXh5q/9ZgGVHVZnPLVZvwK3CVKBU7OjV
	 UFznXJCQxc/NzLy3YNJgybaKnTCRmveBRich2BSK3GW3w6j0HZUQ26g+xgoMq6Kmw2
	 BRKa/niPlKITlWZwTfRgC+isW4c/hZ0sAcLHOxv4gWwIidduQt/zjJwTzZCSV1JQhR
	 jGky6/F56AZvyJREvKpJbwAboIVg14kaBFXu6NpdT6fhyYPQQkwP9HaIVnaMN4WIYO
	 Gl+0v7xuTqkhw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: "Shang song (Lenovo)" <shangsong2@foxmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-5.15] ACPI: PRM: Skip handlers with NULL handler_address or NULL VA
Date: Thu,  9 Oct 2025 11:54:55 -0400
Message-ID: <20251009155752.773732-29-sashal@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Shang song (Lenovo)" <shangsong2@foxmail.com>

[ Upstream commit 311942ce763e21dacef7e53996d5a1e19b8adab1 ]

If handler_address or mapped VA is NULL, the related buffer address and
VA can be ignored, so make acpi_parse_prmt() skip the current handler
in those cases.

Signed-off-by: Shang song (Lenovo) <shangsong2@foxmail.com>
Link: https://patch.msgid.link/20250826030229.834901-1-shangsong2@foxmail.com
[ rjw: Subject and changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## **Backport Status: YES**

### Extensive Analysis

#### **Commit Context and Subsystem History**

This commit is part of a series of fixes and improvements to the ACPI
PRM (Platform Runtime Mechanism) subsystem that has been actively
maintained throughout 2024-2025:

1. **October 2024** - Commit 088984c8d54c: Fixed critical bug where PRM
   handlers caused paging errors due to incorrect memory type usage
   (marked for stable, had Fixes tag)

2. **January 2025** - Commit 7f5704b6a143b: Fixed regression from above
   where overly strict NULL checks broke real hardware. According to PRM
   specification section 4.1.2, `static_data_buffer_address` and
   `acpi_param_buffer_address` can legitimately be NULL. This was a real
   bug reported by Shi Liu from Tencent (marked Cc: stable)

3. **July 2025** - Commit aae68a5f4844e/3db5648c4d608: Reduced
   unnecessary warning messages that confused users when legitimate NULL
   addresses were encountered per PRM spec

4. **August 2025** - Current commit 311942ce763e2: Adds handler skipping
   logic for NULL addresses

#### **What This Commit Actually Fixes**

The commit adds two defensive checks in `acpi_parse_prmt()` at
drivers/acpi/prmt.c:133-186:

**First Check (lines 150+):**
```c
if (unlikely(!handler_info->handler_address)) {
    pr_info("Skipping handler with NULL address for GUID: %pUL", ...);
    continue;
}
```
Detects when ACPI firmware table provides a handler with NULL physical
address - indicates buggy/malformed firmware.

**Second Check (lines 159+):**
```c
if (unlikely(!th->handler_addr)) {
    pr_warn("Failed to find VA of handler for GUID: %pUL, PA: 0x%llx",
...);
    continue;  // <-- NEW
}
```
Adds `continue` statement when VA lookup fails (previously just printed
warning and continued processing).

#### **Current vs. New Behavior**

**Before this fix:**
- Handlers with NULL physical addresses or failed VA lookups are added
  to the `tm->handlers[]` array
- They waste memory allocation
- Warning messages are printed during initialization
- Later runtime check at line 312 in `acpi_platformrt_space_handler()`
  catches attempts to use NULL handlers and returns error
- Potentially confusing for users/debugging

**After this fix:**
- Handlers with NULL addresses are still partially added (GUID is copied
  before the check), but VA lookup and buffer address initialization are
  skipped
- Clearer, more specific error messages (pr_info for NULL PA, pr_warn
  for failed VA lookup)
- Slightly more efficient initialization (skips unnecessary
  efi_pa_va_lookup calls)
- Better fail-fast behavior during parsing vs. runtime

#### **Why This Should Be Backported**

**1. Robustness Improvement in Active Bugfix Area**
The ACPI PRM subsystem has had multiple real-world bugs requiring stable
backports (commits 088984c8d54c and 7f5704b6a143b both marked for
stable). This continues the pattern of hardening this code against edge
cases and firmware bugs.

**2. Handles Real-World Firmware Issues**
While the code comment states NULL handler_addr "is not expected to ever
happen," the fact that this check exists and multiple firmware-related
fixes have been needed suggests buggy ACPI tables do exist in the field.
The author (from Lenovo) likely encountered this on actual hardware.

**3. Improves Error Reporting**
Users encountering this condition get clearer, more actionable messages:
- "Skipping handler with NULL address" (pr_info) vs. just a warning
- Distinguishes between NULL PA from firmware vs. failed VA lookup

**4. Low Regression Risk**
- Changes are minimal (adds 2 checks with `continue` statements)
- Only affects edge case error path (NULL handlers)
- Existing runtime check at line 312 provides safety net
- Code is well-commented and reviewed by subsystem maintainer Rafael
  Wysocki

**5. Prevents Wasted Resources**
Skips unnecessary efi_pa_va_lookup() calls and buffer address setup for
handlers that will never be usable.

**6. Follows Stable Backport Criteria**
- ✓ Obviously correct and contained
- ✓ Fixes handling of buggy firmware (real issue users may encounter)
- ✓ Doesn't introduce new features
- ✓ No architectural changes
- ✓ Minimal risk
- ✓ Confined to ACPI PRM subsystem

#### **Potential Concerns**

The implementation has a minor quirk: handlers are partially initialized
(GUID copied before checks) before being skipped, leaving "holes" in the
handlers array. However, this doesn't cause functional problems because:
- The `find_guid_info()` function searches by GUID matching
- Incomplete handlers won't match lookup requests (or will fail runtime
  check if somehow matched)
- This is actually similar to existing behavior

#### **Evidence of Selection for Backporting**

The commit was authored Aug 25, 2025 and committed Sep 4, 2025 by Rafael
Wysocki (ACPI subsystem maintainer), indicating it passed review and was
deemed important enough for mainline. While there's no explicit "Cc:
stable" tag, the pattern of recent PRM fixes being backported suggests
this fits the stable criteria.

#### **Conclusion**

**YES - This commit should be backported to stable kernel trees.**

While not fixing a critical crash or security vulnerability, it improves
robustness and error handling in a subsystem with documented real-world
firmware issues. The change is small, safe, well-contained, and follows
recent patterns of PRM hardening that have been successfully backported.
The improvement in error detection and reporting provides value to users
encountering buggy ACPI firmware implementations.

 drivers/acpi/prmt.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index be033bbb126a4..6792d4385eee4 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -150,15 +150,28 @@ acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
 		th = &tm->handlers[cur_handler];
 
 		guid_copy(&th->guid, (guid_t *)handler_info->handler_guid);
+
+		/*
+		 * Print an error message if handler_address is NULL, the parse of VA also
+		 * can be skipped.
+		 */
+		if (unlikely(!handler_info->handler_address)) {
+			pr_info("Skipping handler with NULL address for GUID: %pUL",
+					(guid_t *)handler_info->handler_guid);
+			continue;
+		}
+
 		th->handler_addr =
 			(void *)efi_pa_va_lookup(&th->guid, handler_info->handler_address);
 		/*
-		 * Print a warning message if handler_addr is zero which is not expected to
-		 * ever happen.
+		 * Print a warning message and skip the parse of VA if handler_addr is zero
+		 * which is not expected to ever happen.
 		 */
-		if (unlikely(!th->handler_addr))
+		if (unlikely(!th->handler_addr)) {
 			pr_warn("Failed to find VA of handler for GUID: %pUL, PA: 0x%llx",
 				&th->guid, handler_info->handler_address);
+			continue;
+		}
 
 		th->static_data_buffer_addr =
 			efi_pa_va_lookup(&th->guid, handler_info->static_data_buffer_address);
-- 
2.51.0


