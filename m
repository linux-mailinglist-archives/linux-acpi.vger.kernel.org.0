Return-Path: <linux-acpi+bounces-11042-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ECFA315BD
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 20:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618EA188981A
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 19:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA5F267B94;
	Tue, 11 Feb 2025 19:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lDScgHHc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E5F265CA5;
	Tue, 11 Feb 2025 19:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303198; cv=none; b=DG7+OrgsFLfmHL+UobMY1wu5C0wsMyu9mWy1o+rk1fP/zl/luBxsjSDK5/Bg26WjYDyMMYsFh6f1nsBjK3cEPQARyk4y5UCuqrhKBnghmr3ZDHhLGzA+Khpdm90cCC+sMt4sfx0uqPBDaQDKRF5AdYdkajc4v9cOStT6YhisOAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303198; c=relaxed/simple;
	bh=RW1ny/tYzrCYc8zeQqvO3ayjEhUrOOQFk5fWlGTpPRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1ym/S3LwsX55yDAiQ0yfqP2JEruO8yGLVvyYcG/jfrX9VnVEKsYvCWt3tcraPMbEfx1oKoJoXJiHAQz7eQeRfQXpQyMfcybUEGcjp229Yg9cEH3S23eurtvTwgbf1RmBvEfIdCM4Va/amNLt8kM2qY6ZpNcfVXhv3Ajp+mtdRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lDScgHHc; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739303197; x=1770839197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RW1ny/tYzrCYc8zeQqvO3ayjEhUrOOQFk5fWlGTpPRI=;
  b=lDScgHHc4MtPEVjEj0BU8DlgiCfNPrs53UdLCcdR5xmXbzCFaD6HzyOl
   rsXHpQ55pTNdeIbrTqlgVQOJ2NYyu8gdCZIMgx7GxuodD9td2Zd5QNzJ/
   vHoy+CQ8n7qn23W/3w6djx905tpG4MSPDCT+W+4EW00/+faWuQg4oPWEI
   fr/W1xDDu3EyzOKa8NW8owvTjk5/WpNiIEXR3vpP7EohXrro8moy17H8+
   UdGNgxnikg9fWTvY6njbkf9ZXUfEykp3Mk1qgIeN0C7eejWSidSHLryOy
   /oM5iQ3BO4CmxLC8s8sYpdf0l9/YdbFH0XF0NcznnSpqh3Gql8qa85Qcm
   g==;
X-CSE-ConnectionGUID: vuV/8ReCR3uMN6MzDd0yaw==
X-CSE-MsgGUID: BY4JY2TiQouMZh1HSOf6KA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39854944"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39854944"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 11:46:34 -0800
X-CSE-ConnectionGUID: 6QzRga5jTEGQhiDKHYAbug==
X-CSE-MsgGUID: l2jWCZXDRUK5uVe/JIIVpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="143519292"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa001.fm.intel.com with ESMTP; 11 Feb 2025 11:46:34 -0800
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
	Zhang Rui <rui.zhang@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	David Laight <david.laight.linux@gmail.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH v2 10/17] x86/cpu/intel: Replace early Family 6 checks with VFM ones
Date: Tue, 11 Feb 2025 19:44:00 +0000
Message-ID: <20250211194407.2577252-11-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250211194407.2577252-1-sohil.mehta@intel.com>
References: <20250211194407.2577252-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce names for some old pentium models and replace the x86_model
checks with VFM ones.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>

---

v2: No change

---
 arch/x86/include/asm/intel-family.h |  4 ++++
 arch/x86/kernel/cpu/intel.c         | 13 ++++++-------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index cccc932d761e..c1a081585fcb 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -45,8 +45,12 @@
 /* Wildcard match so X86_MATCH_VFM(ANY) works */
 #define INTEL_ANY			IFM(X86_FAMILY_ANY, X86_MODEL_ANY)
 
+/* Family 6 */
 #define INTEL_PENTIUM_PRO		IFM(6, 0x01)
+#define INTEL_PENTIUM_II_KLAMATH	IFM(6, 0x03)
 #define INTEL_PENTIUM_III_DESCHUTES	IFM(6, 0x05)
+#define INTEL_PENTIUM_III_TUALATIN	IFM(6, 0x0B)
+#define INTEL_PENTIUM_M_DOTHAN		IFM(6, 0x0D)
 
 #define INTEL_CORE_YONAH		IFM(6, 0x0E)
 
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 4f8b02cbe8c5..1b6e077a037a 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -195,7 +195,7 @@ void intel_unlock_cpuid_leafs(struct cpuinfo_x86 *c)
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return;
 
-	if (c->x86 < 6 || (c->x86 == 6 && c->x86_model < 0xd))
+	if (c->x86_vfm < INTEL_PENTIUM_M_DOTHAN)
 		return;
 
 	/*
@@ -309,7 +309,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	 * If fast string is not enabled in IA32_MISC_ENABLE for any reason,
 	 * clear the fast string and enhanced fast string CPU capabilities.
 	 */
-	if (c->x86 > 6 || (c->x86 == 6 && c->x86_model >= 0xd)) {
+	if (c->x86_vfm >= INTEL_PENTIUM_M_DOTHAN) {
 		rdmsrl(MSR_IA32_MISC_ENABLE, misc_enable);
 		if (!(misc_enable & MSR_IA32_MISC_ENABLE_FAST_STRING)) {
 			pr_info("Disabled fast string operations\n");
@@ -358,9 +358,7 @@ static void bsp_init_intel(struct cpuinfo_x86 *c)
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
@@ -421,7 +419,8 @@ static void intel_workarounds(struct cpuinfo_x86 *c)
 	 * SEP CPUID bug: Pentium Pro reports SEP but doesn't have it until
 	 * model 3 mask 3
 	 */
-	if ((c->x86<<8 | c->x86_model<<4 | c->x86_stepping) < 0x633)
+	if ((c->x86_vfm == INTEL_PENTIUM_II_KLAMATH && c->x86_stepping < 3) ||
+	    c->x86_vfm < INTEL_PENTIUM_II_KLAMATH)
 		clear_cpu_cap(c, X86_FEATURE_SEP);
 
 	/*
@@ -621,7 +620,7 @@ static unsigned int intel_size_cache(struct cpuinfo_x86 *c, unsigned int size)
 	 * to determine which, so we use a boottime override
 	 * for the 512kb model, and assume 256 otherwise.
 	 */
-	if ((c->x86 == 6) && (c->x86_model == 11) && (size == 0))
+	if (c->x86_vfm == INTEL_PENTIUM_III_TUALATIN && size == 0)
 		size = 256;
 
 	/*
-- 
2.43.0


