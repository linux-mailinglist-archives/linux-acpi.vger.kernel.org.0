Return-Path: <linux-acpi+bounces-19139-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D79C73E21
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Nov 2025 13:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 342C04E6F60
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Nov 2025 12:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4343E32E733;
	Thu, 20 Nov 2025 12:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKHrVLkh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178E520459A;
	Thu, 20 Nov 2025 12:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763640527; cv=none; b=tLtsRIEvlCLyOsrlRFtDA1aIcaXgnuSqJExqCVzd1X8oNtIOwjqIc/QY6KFTkCDKMPjLvNwCp2gizkG4t0Vg3zxSjyAmHubEtV4B2EpVjZWWXsIyUTugbhv0kXE54W30tDhp2a1OeQhOvakuPpiZD8EDcp9UMmhSk8aOD8FYSxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763640527; c=relaxed/simple;
	bh=j7Co4OxTEZ4CrlT1U0i7c2HLKp7Y8nlM3jKDiCoJiZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N45FC0xkiFdhopUVSX34Vnd0sKOPws+eZz6B7lTiK7icpU+OLxJeV5ch6zNbbh054XxlSvppwyp9L812bf/hjJ5+5a7GDwvgZgyiV1l0/t8hCgdZ0x6GozU8cjLdNb6+Cm57wwYbsBI2UY86DmsavOX1U2qfO2NT8EXYAjgk8x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKHrVLkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79CBC4CEF1;
	Thu, 20 Nov 2025 12:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763640524;
	bh=j7Co4OxTEZ4CrlT1U0i7c2HLKp7Y8nlM3jKDiCoJiZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kKHrVLkh4V4Z3glqLlzug0jZzMyR5Z29NrsC/RnwCpr0mZz/zdQTX+nGDhn5wFzdH
	 DkFUudXcYjzPYjGg02WN2niSdwoJ+iGHOT3D1um7fgDojIyvjmnChEeHx1tAW+vISt
	 tEZ9XaLV2RHIQJEsIpQtseJKLxNyGdI2lROJc9eTcgWvEW1+mPxZtGG5oh+1ywJsyv
	 7npbGQjqiNViIZnNlEwfksa7n/hT0o+zdF8VxAn86w84KcuDzamVTMKJAymPGlHu/q
	 fFYUf7ztNww5DxkvkbHXBao4jpNSt+BrAtLl1V3L8K/s1wu8YppYwD+Y4lQNLClLQo
	 NSYx1UiXgaAgA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17] ACPI: MRRM: Fix memory leaks and improve error handling
Date: Thu, 20 Nov 2025 07:08:13 -0500
Message-ID: <20251120120838.1754634-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120120838.1754634-1-sashal@kernel.org>
References: <20251120120838.1754634-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.8
Content-Transfer-Encoding: 8bit

From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>

[ Upstream commit 4b93d211bbffd3dce76664d95f2306d23e7215ce ]

Add proper error handling and resource cleanup to prevent memory leaks
in add_boot_memory_ranges(). The function now checks for NULL return
from kobject_create_and_add(), uses local buffer for range names to
avoid dynamic allocation, and implements a cleanup path that removes
previously created sysfs groups and kobjects on failure.

This prevents resource leaks when kobject creation or sysfs group
creation fails during boot memory range initialization.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://patch.msgid.link/20251030023228.3956296-1-kaushlendra.kumar@intel.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

The following analysis evaluates whether the commit "ACPI: MRRM: Fix
memory leaks and improve error handling" should be backported to stable
kernel trees.

### 1. Comprehensive Analysis

**A. Problem Description**
The commit addresses multiple defects in the `add_boot_memory_ranges()`
function within `drivers/acpi/acpi_mrrm.c`:
1. **Memory Leak (Critical):** The original code used `name =
   kasprintf(GFP_KERNEL, "range%d", i)` inside a loop to generate
   kobject names. `kobject_create_and_add()` makes its own copy of the
   name. The original pointer `name` was never freed, leading to a
   memory leak for every memory range entry every time the system boots.
2. **Missing Error Checks:**
    - The code failed to check if the parent kobject `pkobj` was
      successfully created (NULL check missing).
    - The code failed to check if the child kobject `kobj` was
      successfully created before passing it to `sysfs_create_groups()`.
      If `kobj` were NULL (e.g., OOM), `sysfs_create_groups()` would
      dereference it, causing a crash.
3. **Incomplete Cleanup:** If an error occurred during the loop (e.g.,
   one range failed to create), the function returned an error code but
   left previously created kobjects and sysfs groups valid and attached,
   leading to a partially initialized and potentially unstable state.

**B. Code Research & Fix Verification**
- **Leak Fix:** The commit replaces `kasprintf` (dynamic allocation)
  with `char name[16]` and `scnprintf` (stack allocation). The format
  string is "range%d". Since `range` is 5 bytes and `%d` (integer) is at
  most 10 digits + sign, 16 bytes is sufficient to hold the string
  without overflow. This completely eliminates the memory leak.
- **Robustness:** It adds explicit checks (`if (!pkobj)`, `if (!kobj)`)
  which prevents potential NULL pointer dereferences.
- **Cleanup:** It allocates a temporary array `kobjs` to track created
  objects. If any step fails, the `cleanup` label iterates through this
  array to unwind the changes (`sysfs_remove_groups` and `kobject_put`),
  ensuring "all-or-nothing" semantics.

**C. Context & History**
- The affected file `drivers/acpi/acpi_mrrm.c` was introduced in kernel
  v6.16 (commit `b9020bdb9f76`).
- The buggy function `add_boot_memory_ranges` was introduced shortly
  after in the same cycle.
- Since the current HEAD is `stable/linux-6.17.y`, this code is present
  and buggy in the current stable tree (6.17.y) and the previous one
  (6.16.y).

### 2. Stable Kernel Rules Assessment

- **Obviously Correct and Tested:** **Yes.** The fix uses standard
  kernel APIs (`kcalloc`, `kfree`, `kobject_put`) and standard error
  handling patterns. The stack buffer size is safe.
- **Fixes a Real Bug:** **Yes.** It fixes a guaranteed memory leak on
  boot and prevents crashes under low-memory conditions.
- **Important Issue:** **Yes.** While the leak size per boot is small
  (number of memory ranges), memory leaks are considered defects that
  should be fixed in stable, especially when the fix is low-risk. The
  crash prevention (NULL dereference) is also significant.
- **Small and Contained:** **Yes.** The changes are limited to one
  function `add_boot_memory_ranges` in one file.
- **No New Features/APIs:** **Yes.** The logic remains the same; only
  the implementation implementation is made correct and robust.

### 3. Risk vs. Benefit

- **Benefit:** Stops memory leaks on supported hardware. Prevents
  potential kernel oops during boot if memory is constrained. Ensures
  clean failure state.
- **Risk:** **Low.** The new cleanup logic is straightforward. The array
  allocation `kcalloc` is checked. The logic handles the `acpi_mrrm`
  subsystem which is a specific driver, limiting the blast radius of any
  regression to just this ACPI feature.

### 4. Conclusion

This commit is a textbook stable backport candidate. It fixes a clear
implementation flaw (allocated memory never freed) and missing error
checks in code that exists in currently supported stable trees. The fix
is safe, correct, and improves kernel reliability.

**YES**

 drivers/acpi/acpi_mrrm.c | 43 ++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpi_mrrm.c b/drivers/acpi/acpi_mrrm.c
index a6dbf623e5571..6d69554c940ed 100644
--- a/drivers/acpi/acpi_mrrm.c
+++ b/drivers/acpi/acpi_mrrm.c
@@ -152,26 +152,49 @@ ATTRIBUTE_GROUPS(memory_range);
 
 static __init int add_boot_memory_ranges(void)
 {
-	struct kobject *pkobj, *kobj;
+	struct kobject *pkobj, *kobj, **kobjs;
 	int ret = -EINVAL;
-	char *name;
+	char name[16];
+	int i;
 
 	pkobj = kobject_create_and_add("memory_ranges", acpi_kobj);
+	if (!pkobj)
+		return -ENOMEM;
 
-	for (int i = 0; i < mrrm_mem_entry_num; i++) {
-		name = kasprintf(GFP_KERNEL, "range%d", i);
-		if (!name) {
-			ret = -ENOMEM;
-			break;
-		}
+	kobjs = kcalloc(mrrm_mem_entry_num, sizeof(*kobjs), GFP_KERNEL);
+	if (!kobjs) {
+		kobject_put(pkobj);
+		return -ENOMEM;
+	}
 
+	for (i = 0; i < mrrm_mem_entry_num; i++) {
+		scnprintf(name, sizeof(name), "range%d", i);
 		kobj = kobject_create_and_add(name, pkobj);
+		if (!kobj) {
+			ret = -ENOMEM;
+			goto cleanup;
+		}
 
 		ret = sysfs_create_groups(kobj, memory_range_groups);
-		if (ret)
-			return ret;
+		if (ret) {
+			kobject_put(kobj);
+			goto cleanup;
+		}
+		kobjs[i] = kobj;
 	}
 
+	kfree(kobjs);
+	return 0;
+
+cleanup:
+	for (int j = 0; j < i; j++) {
+		if (kobjs[j]) {
+			sysfs_remove_groups(kobjs[j], memory_range_groups);
+			kobject_put(kobjs[j]);
+		}
+	}
+	kfree(kobjs);
+	kobject_put(pkobj);
 	return ret;
 }
 
-- 
2.51.0


