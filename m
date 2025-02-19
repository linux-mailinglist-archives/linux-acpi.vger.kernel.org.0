Return-Path: <linux-acpi+bounces-11310-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62184A3C8B5
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 20:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2773A1100
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 19:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1AC22F152;
	Wed, 19 Feb 2025 19:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q1Ma5BZE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4839722D7BA;
	Wed, 19 Feb 2025 19:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739993359; cv=none; b=ACaC+dPm/JxHrdhaNl5l6Mp4JBZh4R+mTvC/Te8MO0etFkKk2F5uQKJh84ONZaukvEqX6J2rm+v2yYREYOs+i1Au5V18WLWDRNWvbW54idNX95UatJyeql+GkqTbSUqzML4Vc7mB1tLRKLy17UHpSjnKcV+PlErlaTyJc3Exi+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739993359; c=relaxed/simple;
	bh=lQKLUlUSGZP50W6KTqoKN+hX0s24dtJkBUC4fQJlixE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AwImYry4ExaKsh4agKG0DkEhL0BhC+NAJMlRPVFrSoOVgxOcYJ7Brho2J8NBeq9BdjqTlSEi0V3XICA5fStTQQQwXWtYdKM/ZblHqC6KDzhM55iBqWRfHuKoPCoICHqLUamuIAcOMihC9BKJ7vQAQNKngynFiy2JXReYZqcMfhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q1Ma5BZE; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739993357; x=1771529357;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lQKLUlUSGZP50W6KTqoKN+hX0s24dtJkBUC4fQJlixE=;
  b=Q1Ma5BZE42LfVkKgqOOBAJ1BeBpGh1LIDVBJUrSYptwTgbwlst1qRBJP
   fRSJaY/dXe1X3T6tN+yxcaUmlmjjCyxuU2UnZvI1Ln0ysAdFHpRCqtM/x
   D1M6AWqk/ysqqWUwe/Ygx9d69oxzzJYpZB8Z6Ht0g6GkFUTaJEyBvs18P
   1i2tHbxqdPxg6KiVYpWcEQzBagRb2AEHOjLEEzapQXJIb+12HYu4G/RQD
   FZov5YUeCtWL4PQbQItIMQEDGOQIpA8qX8hsYpeTbfM+SHs35+4ZQLgCC
   QQf/Ez9/S5hfVRmnezG9x2DowRizhxaxOL9c4Rwwa8pe4LZxWaXIcNNkj
   A==;
X-CSE-ConnectionGUID: yVxGRnBZQXa+N6L9Z5z8gg==
X-CSE-MsgGUID: v8cwJYRsSqWjxJ8ejgJ7mQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52182906"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52182906"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 11:29:17 -0800
X-CSE-ConnectionGUID: MXjDvxrtQKSOXL9vpvw0nQ==
X-CSE-MsgGUID: s6eTw20zQU6lDpbLxpfUDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="115344030"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa010.fm.intel.com with ESMTP; 19 Feb 2025 10:47:53 -0800
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
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Zhang Rui <rui.zhang@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	David Laight <david.laight.linux@gmail.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 07/15] x86/cpu/intel: Replace Family 5 model checks with VFM ones
Date: Wed, 19 Feb 2025 18:41:25 +0000
Message-ID: <20250219184133.816753-8-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219184133.816753-1-sohil.mehta@intel.com>
References: <20250219184133.816753-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce names for some Family 5 models and convert some of the checks
to be VFM based.

Also, to keep the file sorted by family, move Family 5 to the top of the
header file.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
---
v3: Picked up Dave's Ack.
v2: Reorder the Family 5 models to be at the top of the file.
---
 arch/x86/include/asm/intel-family.h |  9 ++++++---
 arch/x86/kernel/cpu/intel.c         | 11 +++++------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index f509061b8c7e..9e6a13f03f0e 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -45,6 +45,12 @@
 /* Wildcard match so X86_MATCH_VFM(ANY) works */
 #define INTEL_ANY			IFM(X86_FAMILY_ANY, X86_MODEL_ANY)
 
+/* Family 5 */
+#define INTEL_FAM5_START		IFM(5, 0x00) /* Notational marker, also P5 A-step */
+#define INTEL_PENTIUM_75		IFM(5, 0x02) /* P54C */
+#define INTEL_PENTIUM_MMX		IFM(5, 0x04) /* P55C */
+#define INTEL_QUARK_X1000		IFM(5, 0x09) /* Quark X1000 SoC */
+
 /* Family 6 */
 #define INTEL_PENTIUM_PRO		IFM(6, 0x01)
 #define INTEL_PENTIUM_II_KLAMATH	IFM(6, 0x03)
@@ -181,9 +187,6 @@
 #define INTEL_XEON_PHI_KNL		IFM(6, 0x57) /* Knights Landing */
 #define INTEL_XEON_PHI_KNM		IFM(6, 0x85) /* Knights Mill */
 
-/* Family 5 */
-#define INTEL_QUARK_X1000		IFM(5, 0x09) /* Quark X1000 SoC */
-
 /* Family 15 - NetBurst */
 #define INTEL_P4_WILLAMETTE		IFM(15, 0x01) /* Also Xeon Foster */
 #define INTEL_P4_PRESCOTT		IFM(15, 0x03)
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 30f3812ba62c..48aad9bcf300 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -367,9 +367,8 @@ static void intel_smp_check(struct cpuinfo_x86 *c)
 	/*
 	 * Mask B, Pentium, but not Pentium MMX
 	 */
-	if (c->x86 == 5 &&
-	    c->x86_stepping >= 1 && c->x86_stepping <= 4 &&
-	    c->x86_model <= 3) {
+	if (c->x86_vfm >= INTEL_FAM5_START && c->x86_vfm < INTEL_PENTIUM_MMX &&
+	    c->x86_stepping >= 1 && c->x86_stepping <= 4) {
 		/*
 		 * Remember we have B step Pentia with bugs
 		 */
@@ -396,7 +395,7 @@ static void intel_workarounds(struct cpuinfo_x86 *c)
 	 * The Quark is also family 5, but does not have the same bug.
 	 */
 	clear_cpu_bug(c, X86_BUG_F00F);
-	if (c->x86 == 5 && c->x86_model < 9) {
+	if (c->x86_vfm >= INTEL_FAM5_START && c->x86_vfm < INTEL_QUARK_X1000) {
 		static int f00f_workaround_enabled;
 
 		set_cpu_bug(c, X86_BUG_F00F);
@@ -444,7 +443,7 @@ static void intel_workarounds(struct cpuinfo_x86 *c)
 	 * integrated APIC (see 11AP erratum in "Pentium Processor
 	 * Specification Update").
 	 */
-	if (boot_cpu_has(X86_FEATURE_APIC) && (c->x86<<8 | c->x86_model<<4) == 0x520 &&
+	if (boot_cpu_has(X86_FEATURE_APIC) && c->x86_vfm == INTEL_PENTIUM_75 &&
 	    (c->x86_stepping < 0x6 || c->x86_stepping == 0xb))
 		set_cpu_bug(c, X86_BUG_11AP);
 
@@ -621,7 +620,7 @@ static unsigned int intel_size_cache(struct cpuinfo_x86 *c, unsigned int size)
 	 * Intel Quark SoC X1000 contains a 4-way set associative
 	 * 16K cache with a 16 byte cache line and 256 lines per tag
 	 */
-	if ((c->x86 == 5) && (c->x86_model == 9))
+	if (c->x86_vfm == INTEL_QUARK_X1000)
 		size = 16;
 	return size;
 }
-- 
2.43.0


