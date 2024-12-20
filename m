Return-Path: <linux-acpi+bounces-10227-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A17E9F9C2A
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 22:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E26A41892632
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 21:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C9622A1E5;
	Fri, 20 Dec 2024 21:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yw/lTK6w"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3CF229130;
	Fri, 20 Dec 2024 21:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734730763; cv=none; b=rLsTxzb8B3ZAxgza79Xz1yTrdeQf0dKafgn7Yd34nyqp6PRY7ErFhsv+rTCbIVlz9yePJXCE+W1H6EFxAFo2OI+ASNIiPCYejPbJ+zZO+M/9iqjmBv3/MS7XNE8MHYgH5qMprmaTPpyWj5gR+vP8Hyy+i441tzprKj0EJInNugc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734730763; c=relaxed/simple;
	bh=khcbHN+6/uEv0zea4Ln5lsuwyhVArEvDUPEFThN18B0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EsUf3bPckbBVlRsyOryH0zNeez9NZU69rol4aT2RQch8CFPC4UcJthZDkcUan1a36AAZsfZX9WBF6fUzxslC9A9aBx6QeR6AR0nCPu97sXj9ViOxx70qqD+LHrDaSepPPCtyoE9GhCLePArrsjdHn9qe9AL1RsMmisslAlmt32s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yw/lTK6w; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734730762; x=1766266762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=khcbHN+6/uEv0zea4Ln5lsuwyhVArEvDUPEFThN18B0=;
  b=Yw/lTK6wQeOBcTnxpLi7jtElnDtFfKZ5gGoFL2OtDAPJ5+LD8KLEuT4L
   ChuwgsgxPO22jDrYXdFnAv/x4obh6cHVsu6q+i1/cLVpZT+FKFMT8Hjcb
   qQZzu4xJTFfpdQZ5jTR4oVYf35gW552dN0fTb82neuhR15Dflv+ZLujIo
   wLsiNiLrjk+pkHGoZwhMEkSqKytbKYBWwblu8QUv3kMpFXLZ1BS0Qw4IU
   xdZgR8SEbpi6b4+GJYroMOwUwj78/emwv3aF0K+VJku3ZYkOSlCJVwSGW
   qEEr/bnzNf4obzve/T0BzV/eWIJghFq37A8arejjRv9cLoAezpbFWtGNY
   Q==;
X-CSE-ConnectionGUID: 670lzGn0Ro2sTBLnwheH8Q==
X-CSE-MsgGUID: gB+bBP4xTRGaiz5XqMVPNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="39070701"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="39070701"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 13:39:17 -0800
X-CSE-ConnectionGUID: 5VroBSZYTgqwRrTN7cx7yQ==
X-CSE-MsgGUID: GbSPoW/XRVSuVJcmu/w4LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103223850"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa005.fm.intel.com with ESMTP; 20 Dec 2024 13:39:16 -0800
From: Sohil Mehta <sohil.mehta@intel.com>
To: x86@kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [RFC PATCH 08/15] x86/cpu/intel: Replace early family 6 checks with VFM ones
Date: Fri, 20 Dec 2024 21:37:03 +0000
Message-ID: <20241220213711.1892696-9-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220213711.1892696-1-sohil.mehta@intel.com>
References: <20241220213711.1892696-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce names for some old pentium models and replace with VFM based
checks.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/include/asm/intel-family.h |  3 +++
 arch/x86/kernel/cpu/intel.c         | 13 ++++++-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 6d7b04ffc5fd..41278093bcd4 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -46,6 +46,9 @@
 #define INTEL_ANY			IFM(X86_FAMILY_ANY, X86_MODEL_ANY)
 
 #define INTEL_PENTIUM_PRO		IFM(6, 0x01)
+#define INTEL_PENTIUM_II_KLAMATH	IFM(6, 0x03)
+#define INTEL_PENTIUM_III_TUALATIN	IFM(6, 0x0B)
+#define INTEL_PENTIUM_M_DOTHAN		IFM(6, 0x0D)
 
 #define INTEL_CORE_YONAH		IFM(6, 0x0E)
 
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index f44b2e618fb3..cde8f45ccd57 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -195,7 +195,7 @@ void intel_unlock_cpuid_leafs(struct cpuinfo_x86 *c)
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return;
 
-	if (c->x86 < 6 || (c->x86 == 6 && c->x86_model < 0xd))
+	if (c->x86_vfm < INTEL_PENTIUM_M_DOTHAN)
 		return;
 
 	/*
@@ -301,7 +301,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	 * If fast string is not enabled in IA32_MISC_ENABLE for any reason,
 	 * clear the fast string and enhanced fast string CPU capabilities.
 	 */
-	if (c->x86 > 6 || (c->x86 == 6 && c->x86_model >= 0xd)) {
+	if (c->x86_vfm >= INTEL_PENTIUM_M_DOTHAN) {
 		rdmsrl(MSR_IA32_MISC_ENABLE, misc_enable);
 		if (!(misc_enable & MSR_IA32_MISC_ENABLE_FAST_STRING)) {
 			pr_info("Disabled fast string operations\n");
@@ -350,9 +350,7 @@ static void bsp_init_intel(struct cpuinfo_x86 *c)
 int ppro_with_ram_bug(void)
 {
 	/* Uses data from early_cpu_detect now */
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
-	    boot_cpu_data.x86 == 6 &&
-	    boot_cpu_data.x86_model == 1 &&
+	if (boot_cpu_data.x86_vfm == INTEL_PENTIUM_PRO &&
 	    boot_cpu_data.x86_stepping < 8) {
 		pr_info("Pentium Pro with Errata#50 detected. Taking evasive action.\n");
 		return 1;
@@ -413,7 +411,8 @@ static void intel_workarounds(struct cpuinfo_x86 *c)
 	 * SEP CPUID bug: Pentium Pro reports SEP but doesn't have it until
 	 * model 3 mask 3
 	 */
-	if ((c->x86<<8 | c->x86_model<<4 | c->x86_stepping) < 0x633)
+	if ((c->x86_vfm == INTEL_PENTIUM_II_KLAMATH && c->x86_stepping < 3) ||
+	    c->x86_vfm < INTEL_PENTIUM_II_KLAMATH)
 		clear_cpu_cap(c, X86_FEATURE_SEP);
 
 	/*
@@ -620,7 +619,7 @@ static unsigned int intel_size_cache(struct cpuinfo_x86 *c, unsigned int size)
 	 * to determine which, so we use a boottime override
 	 * for the 512kb model, and assume 256 otherwise.
 	 */
-	if ((c->x86 == 6) && (c->x86_model == 11) && (size == 0))
+	if (c->x86_vfm == INTEL_PENTIUM_III_TUALATIN && size == 0)
 		size = 256;
 
 	/*
-- 
2.43.0


