Return-Path: <linux-acpi+bounces-13985-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD08AAC8EA0
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 14:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48DD3501DB4
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 12:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C95525C822;
	Fri, 30 May 2025 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrkgsG5W"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F62725A342;
	Fri, 30 May 2025 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748608829; cv=none; b=RIMjxESWx+tqtDhB4ACtiHwywUOKrabse+/FCI1vOfd2gJncj0BGCFArEVhDtMgrx3xv5LtypOY79LHV71w7jLZPIp2URwd9AVkYBdBo975hwtKUovGYsHMOOUXutFTVu2o4HqtjhfnvDPX8Wzz1nRlczTbgHr/LaYPpn5JG3r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748608829; c=relaxed/simple;
	bh=XhSm2w8DpQzfSf6Ufq34HMXOAaNGdv9qtku8IsmBlTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VeXEmjgHATndIqNSX4pDZ8y33UVKVKZEg5Prm7ZpYEeUhZUbU8MlzJnByZXu8psl2edrTq7b+YtGHCVFm2bUcLH3JNKT7eHfyRUIa+czwCCwyn2IoyAY8N+4rm9bh0kR08ze9fEVnR5VfxD3bOOWQP1smxr8hGMNNAUYiQdDSsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrkgsG5W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21C7C4CEEA;
	Fri, 30 May 2025 12:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748608828;
	bh=XhSm2w8DpQzfSf6Ufq34HMXOAaNGdv9qtku8IsmBlTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IrkgsG5WXZZTzz9OxAgHWr3eutmnOiPd414PASrpcR6FRwfhWjjWpv9RYHfc4AAdY
	 zL4Jmv/r1v5BhIzLIjP3kNpTN6nvsjsL40EYlg9wG8/XFeu+HL/SxNCkAeiJORuPE6
	 4jUUbai56T1ZS6+khae3vqarYGPGwS+37lHlhDE6sRM1lY+bH/xfooMXio2PcOuRks
	 UGXK71j8vkCLtPOw5zQcepVfsYq9DBYor25vMSllUTDYtBCIMz+vlYAvK1HHGN/vrl
	 E+qtXnJhjBKq1jlxooQdqxyxl9FwT3AKwk92rJtdBAbWyxTISZhOzrvEZeX8E/J2qN
	 SFdoJhgaSh6Dg==
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
Subject: [PATCH AUTOSEL 6.12 12/26] ACPI: Add missing prototype for non CONFIG_SUSPEND/CONFIG_X86 case
Date: Fri, 30 May 2025 08:39:58 -0400
Message-Id: <20250530124012.2575409-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530124012.2575409-1-sashal@kernel.org>
References: <20250530124012.2575409-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.31
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
index 4d5ee84c468ba..f826bb59556af 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1110,13 +1110,13 @@ void acpi_os_set_prepare_extended_sleep(int (*func)(u8 sleep_state,
 
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
@@ -1125,6 +1125,13 @@ static inline int acpi_get_lps0_constraint(struct device *dev)
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


