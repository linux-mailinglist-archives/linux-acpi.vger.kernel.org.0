Return-Path: <linux-acpi+bounces-13969-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C3EAC8DFB
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 14:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A2DA40FE1
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 12:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFFE233701;
	Fri, 30 May 2025 12:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWjBczjK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFCC233155;
	Fri, 30 May 2025 12:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748608753; cv=none; b=mkmxVyC8u2enk8OItOKMxrHyXwZEyrIvptVAMPWffU4kKT3ZO/VHTRf5OvShs5UzsM9SHs6OOf1nkhSIpfrlLMDcjmfn53G0i8+lb2+mIA40g19W3BjormHgbluxQVRtukak1zRR9SXUYNY9Bd+nzCuUdeJkjwEINq2LrD0H5Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748608753; c=relaxed/simple;
	bh=w4Rwff7iiK+vRyCc4SdbMl5Ob5KEJMg+Sm/6d3oiCLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gA5/jBtH/myFlb1Hsz2OGnTWOTSeDiSW+0lAVZT2WBzz++BBzCeoIAhvVSQxbEYgTZJOwKn+/emHO+ygH5PO5qg9ALxXC564UpDD9Yc74BbjOVlag5NoIxN+M9j8J/iz/7c6e6Mg1lOZpDEfPwMx02uhOw6Gw5Pkmy6tCCkobC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWjBczjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C79DC4CEEF;
	Fri, 30 May 2025 12:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748608753;
	bh=w4Rwff7iiK+vRyCc4SdbMl5Ob5KEJMg+Sm/6d3oiCLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YWjBczjKx9IcpiIJdVlEkdzqmS2mOgfTDszJuS0GxqJRz7wNmuXI5066q0k1it5I7
	 HLRxcg84s1WDkwq2jmFVf/4I4wxTTbD39vjDyTW9jB628JFVSxV3gLMWWefjMfAhYs
	 NueJl+9jGMwsKMDdfA8k55qAWL0Q8R80F7hkdylvtCHGGHJx3EB6gs6iB7oKxJJrxp
	 f+1VJl1VZj7u4M6ngb6p69CZ05ljxAbIEWIvHHeWsZlASI5RP+0EMFQ66bSJ3NEODL
	 4yScbOBvxNt/bPCW854zWJPenEoIZgSKl5iqJEhjobYUbQeCXdx0mhDp7egl7HwOg6
	 CH/9uR/phmTTQ==
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
Subject: [PATCH AUTOSEL 6.15 15/30] ACPI: Add missing prototype for non CONFIG_SUSPEND/CONFIG_X86 case
Date: Fri, 30 May 2025 08:38:37 -0400
Message-Id: <20250530123852.2574030-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530123852.2574030-1-sashal@kernel.org>
References: <20250530123852.2574030-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15
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
index 3f2e93ed97301..fc372bbaa5476 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1125,13 +1125,13 @@ void acpi_os_set_prepare_extended_sleep(int (*func)(u8 sleep_state,
 
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
@@ -1140,6 +1140,13 @@ static inline int acpi_get_lps0_constraint(struct device *dev)
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


