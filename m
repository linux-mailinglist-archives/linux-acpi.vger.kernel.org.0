Return-Path: <linux-acpi+bounces-13977-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0D6AC8E66
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 14:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2533BEC90
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 12:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEB7242D70;
	Fri, 30 May 2025 12:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzBviZV+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEBD242D68;
	Fri, 30 May 2025 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748608793; cv=none; b=H9CFeErPJed7z6GiQ42WT6wWlw2942r5bbXbhi+maizxAmmn/5AlKUEQIMi/KVR5IGXJ/FppPBcvtfNqKThjvJEnlurAhWXznBMLTToaCrDFtTIL0K0irJ3prt3p017sMCH5CvSvhEKvK39bKoXS2987BXfKLLNtbuSo2g3VWc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748608793; c=relaxed/simple;
	bh=DyXVDph6+VFcImZS7cgW2MbkpTVHvHW+pXJnqZBmWqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r7aJlaYOm98fyxaSviQyZC0xt8LnG0aBR1xgpsmnRcl8SU5RBZB4rv/XF5YX+2QrIllLSggoZB3SG/w1FE/RPyigQ6jNYB0Ex1SAF/Q5B57KCn5PPEj0xqujBCee4JXoQBs2wXWTQkoD7HstOEbHgALJURiKI2lvfz9paQTUXrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzBviZV+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAEB2C4CEEA;
	Fri, 30 May 2025 12:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748608792;
	bh=DyXVDph6+VFcImZS7cgW2MbkpTVHvHW+pXJnqZBmWqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SzBviZV+cV5M45FfemHYXEOpErzWnd5mtJqdyYreMcwpp47oABuVWU8LGTRurn1/x
	 VDT+N1QWct9TnI9HwtFC1sAVdaMWdWIHtnvrHdrV84F3pn2zLlfAbNGu+GdzCCQk7o
	 A8Go+r0Jo/lNZBhOQBkMVqzFCxAZU/suOGITKD9/hIavXxaKbCDE72B0aupIrShyZi
	 jcfYf/RAfaolpcgCLXjsTFjAwpg5o/hMIguWoBZsg1SDjCLPu/LMsOTgrpH1jrf1Y/
	 MN0jnphPW532lRM6sW/HS0BEsTG8a6UqN+kgStv/8xhL6j8Xz4xIIYFbqBlDBKuRte
	 uuOoGsyNxx3tw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	kernel test robot <lkp@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rjw@rjwysocki.net,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 14/28] ACPI: Add missing prototype for non CONFIG_SUSPEND/CONFIG_X86 case
Date: Fri, 30 May 2025 08:39:20 -0400
Message-Id: <20250530123934.2574748-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530123934.2574748-1-sashal@kernel.org>
References: <20250530123934.2574748-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit e1bdbbc98279164d910d2de82a745f090a8b249f ]

acpi_register_lps0_dev() and acpi_unregister_lps0_dev() may be used
in drivers that don't require CONFIG_SUSPEND or compile on !X86.

Add prototypes for those cases.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502191627.fRgoBwcZ-lkp@intel.com/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://patch.msgid.link/20250407183656.1503446-1-superm1@kernel.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees.
**Analysis:** This commit fixes a clear build error that affects users
in specific, but valid, kernel configurations. Here's the detailed
analysis: **1. Clear Bug Fix:** The commit addresses missing function
prototypes for `acpi_register_lps0_dev()` and
`acpi_unregister_lps0_dev()` when `CONFIG_SUSPEND` or `CONFIG_X86` are
not enabled. This causes compilation failures when drivers that use
these functions are built without these config options. **2. Code
Changes Analysis:** - **File Modified:** `include/linux/acpi.h` at lines
1108-1162 - **Before:** The `struct acpi_s2idle_dev_ops` was only
defined within the `#if defined(CONFIG_SUSPEND) && defined(CONFIG_X86)`
block, and the stub functions for `acpi_register_lps0_dev()` and
`acpi_unregister_lps0_dev()` were missing from the `#else` clause. -
**After:** The struct definition is moved outside the conditional block,
and stub functions are added in the `#else` clause that return `-ENODEV`
for registration and do nothing for unregistration. **3. Real-world
Impact:** From examining the kernel tree, several drivers use these
functions: - `/home/sasha/linux/drivers/platform/x86/amd/pmc/pmc.c` -
AMD PMC driver calls `acpi_register_lps0_dev()` and
`acpi_unregister_lps0_dev()` -
`/home/sasha/linux/arch/x86/platform/atom/punit_atom_debug.c` - Intel
Atom debug driver - `/home/sasha/linux/drivers/platform/x86/pmc_atom.c`
- Intel PMC Atom driver These drivers can be enabled on platforms or
configurations where `CONFIG_SUSPEND` or `CONFIG_X86` might not be set,
causing build failures. **4. Minimal Risk:** - **Size:** Very small
change - only adds stub function prototypes - **Scope:** Limited to
header file, no runtime behavior changes for existing working
configurations - **Side Effects:** None - the stubs return appropriate
error codes and maintain API compatibility **5. Comparison with Similar
Commits:** Looking at the provided similar commits, this follows the
same pattern as commits #2, #3, and #4 (all marked as NO), which were
prototype/warning fixes. However, this commit differs crucially because:
- It fixes actual **build failures** (not just warnings) - The kernel
test robot specifically reported compilation errors - It affects **real
drivers** that are in use **6. Stable Tree Criteria Compliance:** - ✅
Fixes important bugs (build failures) - ✅ Doesn't introduce new features
- ✅ Doesn't make architectural changes - ✅ Has minimal risk of
regression - ✅ Is confined to a specific subsystem (ACPI headers) The
commit message explicitly mentions "kernel test robot" reporting build
failures, indicating this is a real issue affecting automated testing
and potentially user builds. The fix is exactly what's needed for proper
API completeness - providing stub implementations when the real
functionality isn't available.

 include/linux/acpi.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4e495b29c640f..8d2abe5dede93 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1115,13 +1115,13 @@ void acpi_os_set_prepare_extended_sleep(int (*func)(u8 sleep_state,
 
 acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state,
 					   u32 val_a, u32 val_b);
-#if defined(CONFIG_SUSPEND) && defined(CONFIG_X86)
 struct acpi_s2idle_dev_ops {
 	struct list_head list_node;
 	void (*prepare)(void);
 	void (*check)(void);
 	void (*restore)(void);
 };
+#if defined(CONFIG_SUSPEND) && defined(CONFIG_X86)
 int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
 void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg);
 int acpi_get_lps0_constraint(struct acpi_device *adev);
@@ -1130,6 +1130,13 @@ static inline int acpi_get_lps0_constraint(struct device *dev)
 {
 	return ACPI_STATE_UNKNOWN;
 }
+static inline int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg)
+{
+	return -ENODEV;
+}
+static inline void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg)
+{
+}
 #endif /* CONFIG_SUSPEND && CONFIG_X86 */
 void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
 #else
-- 
2.39.5


