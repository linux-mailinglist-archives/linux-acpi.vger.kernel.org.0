Return-Path: <linux-acpi+bounces-10229-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4469F9C30
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 22:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CBA4188F122
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 21:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446D022ACC6;
	Fri, 20 Dec 2024 21:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lS19NCqK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEA322967E;
	Fri, 20 Dec 2024 21:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734730764; cv=none; b=CX/dAL1i67Lc8nqwRd1qiRPMyDMH1NR/EJntjdo1dHq31uJfX8rOoHYCR1oOEowBa6fd6TtRvS7X4ulQqmT8sMToX+0fjHCTNQYu4h+yUjMG4zo4+P70UfkXNWwSYA++Nx2/wIKndgDgFQB2/vtNVxjDonBWKDftj/EIPHsi0zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734730764; c=relaxed/simple;
	bh=aRVoNC6xFppjLAQNekbF747ddhqNf7rFuzG74RxiCzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IbiGI9v68ZX7HJ7G5vc9ZyLtTeHi//M0Dm+uQFTKc+TikMOdQR3bSQKhaoxJPx/MmYs9AGxU0odrBq9Z0xfAQmSb8t32qTZnZrtM6mU2tVBHEiSSGW40OFSbz+1fsyo+87pYV9sU1rRcmJDY/IDTRR30R/xc77CBUBcEpvp0QTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lS19NCqK; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734730763; x=1766266763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aRVoNC6xFppjLAQNekbF747ddhqNf7rFuzG74RxiCzY=;
  b=lS19NCqKt/vh4lp/rFnR1BQTk3q95+KqKenh8A5fA0VNX/pNxITd6vSM
   nANp3rgo3VnNBi3EE1BxEXN3qMsu5U+9BmmDRigIcL29qVs8kaUlhXGz2
   UGOhhW/1DcdBk5m+Qb9KS1oaFaN4KInkzDSyIKgGBQ6p2ChTMKLuL01IX
   +eaNWGDX1QuTgzzHJsSVehHOibZ3NpUuifgeCSEHJccXwAj47MZB4ELCx
   j9OnIb9Uq0BsI2Ac5iIXoA2hTh1yTNwKI6xToxomrQjePWsslzJTGhoqp
   Y1P57k3UYKVq6ZOgERyjS30MOkEnfyMKFYyYnJ/6N9Ysf+XEjRJAZSxLh
   Q==;
X-CSE-ConnectionGUID: Kr+OVlLHRpSNRPY7YlOiAw==
X-CSE-MsgGUID: GWoLIEnqQtOiZA93xHbTKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="39070735"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="39070735"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 13:39:18 -0800
X-CSE-ConnectionGUID: WFmrtmXiQvavyC5yeTWcoQ==
X-CSE-MsgGUID: 5Pg55BtcS/2yUi1o3T+wMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103223856"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa005.fm.intel.com with ESMTP; 20 Dec 2024 13:39:17 -0800
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
Subject: [RFC PATCH 10/15] x86/cpu/intel: Replace family 5 model checks with VFM ones
Date: Fri, 20 Dec 2024 21:37:05 +0000
Message-ID: <20241220213711.1892696-11-sohil.mehta@intel.com>
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

Introduce names for some family 5 models and convert VFM based checks.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/include/asm/intel-family.h |  3 +++
 arch/x86/kernel/cpu/intel.c         | 11 +++++------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 79cfd42c849f..025d091be98e 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -180,6 +180,9 @@
 #define INTEL_XEON_PHI_KNM		IFM(6, 0x85) /* Knights Mill */
 
 /* Family 5 */
+#define INTEL_FAM5_START		IFM(5, 0x00) /* Notational marker, also P5 A-step */
+#define INTEL_PENTIUM_75		IFM(5, 0x02) /* P54C - Need a better name */
+#define INTEL_PENTIUM_MMX		IFM(5, 0x04) /* P55C */
 #define INTEL_QUARK_X1000		IFM(5, 0x09) /* Quark X1000 SoC */
 
 /* Family 15 */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 26221f38db70..26962a602e86 100644
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
 
@@ -626,7 +625,7 @@ static unsigned int intel_size_cache(struct cpuinfo_x86 *c, unsigned int size)
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


