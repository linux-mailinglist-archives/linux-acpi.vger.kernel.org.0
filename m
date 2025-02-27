Return-Path: <linux-acpi+bounces-11525-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34168A47017
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 01:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E35D3AE1A6
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 00:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D242563;
	Thu, 27 Feb 2025 00:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iDD0iNjF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B35A55;
	Thu, 27 Feb 2025 00:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740615514; cv=none; b=ty0lk4sl//UpXJSjzTjK+3EY5ajb4PVx4lSg+uXxm9Jfz1UsGxMGA+vCy2qwvcSz64t4WQyFk8kmAbK0PDir6MVdGhJQsrDkXep5dms9gFa4Fc84Xo7f51zrfA+9Nrr3+7DwiA83xq1p/KUUB04Ioo/qH3YbfdCpReftvYJmmLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740615514; c=relaxed/simple;
	bh=zy/JC+sJhhNV8yGVMMwVPJdDAc7mBSWAHJKrnS3U5tI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sofr++uFbOwbskBX/tFu4spS6nDIuDJvoCqEuLFN2CfncI4HAmSfZTLoDh5sl8eAWkasLbmGdmnWSkRW/JS2kcELN5Vs6PKPZOP8NV9GuK5G1HfmKZR7C5qffDlGlQM3Dv+cfTzkXuzQfc3MrPa4Olgr843xmc5i1eh8UOCjmH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iDD0iNjF; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740615513; x=1772151513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zy/JC+sJhhNV8yGVMMwVPJdDAc7mBSWAHJKrnS3U5tI=;
  b=iDD0iNjFxbRBTBlxLFKuedeYhEZAlB/LBujeEUyPlAobKGng1cLubBZY
   aJf1xMPW+7oVNs2OzQ8ORkIXtGY9fBxOLqDXsvYMvSUG18n8GrfYTatMI
   ie+7UbbLC3nbiPYpjUfuw07nRz+6BwWBGSjFUwNC74AnFvx0Tcmm2r74D
   3HPk/p9++Y5lNPk2vp14wf/hk93w0mRhgwLoIIvXBch9VTYbhMMDOY1Mq
   MTfCH+cGPpPLFiv07PmoTPMS0G5qskbH86bBUUflr9y1olBW5XwlB66Sg
   vstz05UW3qw77TMGc5OdM2MmzDKqFhxm/Z80B8YVO6M2mQMMM+zWMa/0/
   A==;
X-CSE-ConnectionGUID: 9rhi4EZ6QbCB1y6jwip5bg==
X-CSE-MsgGUID: J5Kn6D6bTE2pzX/17FwjpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41687877"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41687877"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 16:18:30 -0800
X-CSE-ConnectionGUID: q3bKHKf9QhS0Sk5zTXJc3A==
X-CSE-MsgGUID: nv5vN+BjR+uo9yCn+g0iAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="116889473"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa006.jf.intel.com with ESMTP; 26 Feb 2025 16:18:29 -0800
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
Subject: [PATCH v3.1 14/15] perf/x86: Simplify Intel PMU initialization
Date: Thu, 27 Feb 2025 00:16:15 +0000
Message-ID: <20250227001615.1231958-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219184133.816753-15-sohil.mehta@intel.com>
References: <20250219184133.816753-15-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Architectural Perfmon was introduced on the Family 6 "Core" processors
starting with Yonah. Processors before Yonah need their own customized
PMU initialization.

p6_pmu_init() is expected to provide that initialization for early
Family 6 processors. But, currently, it could get called for any Family
6 processor if the architectural perfmon feature is disabled on that
processor. To simplify, restrict the P6 PMU initialization to early
Family 6 processors that do not have architectural perfmon support and
truly need the special handling.

As a result, the "unsupported" console print becomes practically
unreachable because all the released P6 processors are covered by the
switch cases. Move the console print to a common location where it can
cover all modern processors (including Family >15) that may not have
architectural perfmon support enumerated.

Also, use this opportunity to get rid of the unnecessary switch cases in
P6 initialization. Only the Pentium Pro processor needs a quirk, and the
rest of the processors do not need any special handling. The gaps in the
case numbers are only due to no processor with those model numbers being
released.

Use decimal numbers for Intel Family numbers. Also, convert one of the
last few Intel x86_model comparison to a VFM based one.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
Sending an updated version for this one since it's the only one with a
change. This would make it feasible to pickup the entire patchset in
this cycle if desired.

v3.1: Move the default case outside of the switch.
      Pickup the Reviewed-by tag from Kan Liang.

v3: Restrict calling p6_pmu_init() to only when needed.
    Move the console print to a common location.

v2: No change.
---
 arch/x86/events/intel/core.c | 14 ++++++++++----
 arch/x86/events/intel/p6.c   | 26 +++-----------------------
 2 files changed, 13 insertions(+), 27 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7601196d1d18..ef59643a9d23 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6466,15 +6466,21 @@ __init int intel_pmu_init(void)
 	char *name;
 	struct x86_hybrid_pmu *pmu;
 
+	/* Architectural Perfmon was introduced starting with Core "Yonah" */
 	if (!cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
 		switch (boot_cpu_data.x86) {
-		case 0x6:
-			return p6_pmu_init();
-		case 0xb:
+		case 6:
+			if (boot_cpu_data.x86_vfm < INTEL_CORE_YONAH)
+				return p6_pmu_init();
+			break;
+		case 11:
 			return knc_pmu_init();
-		case 0xf:
+		case 15:
 			return p4_pmu_init();
 		}
+
+		pr_cont("unsupported CPU family %d model %d ",
+			boot_cpu_data.x86, boot_cpu_data.x86_model);
 		return -ENODEV;
 	}
 
diff --git a/arch/x86/events/intel/p6.c b/arch/x86/events/intel/p6.c
index a6cffb4f4ef5..65b45e9d7016 100644
--- a/arch/x86/events/intel/p6.c
+++ b/arch/x86/events/intel/p6.c
@@ -2,6 +2,8 @@
 #include <linux/perf_event.h>
 #include <linux/types.h>
 
+#include <asm/cpu_device_id.h>
+
 #include "../perf_event.h"
 
 /*
@@ -248,30 +250,8 @@ __init int p6_pmu_init(void)
 {
 	x86_pmu = p6_pmu;
 
-	switch (boot_cpu_data.x86_model) {
-	case  1: /* Pentium Pro */
+	if (boot_cpu_data.x86_vfm == INTEL_PENTIUM_PRO)
 		x86_add_quirk(p6_pmu_rdpmc_quirk);
-		break;
-
-	case  3: /* Pentium II - Klamath */
-	case  5: /* Pentium II - Deschutes */
-	case  6: /* Pentium II - Mendocino */
-		break;
-
-	case  7: /* Pentium III - Katmai */
-	case  8: /* Pentium III - Coppermine */
-	case 10: /* Pentium III Xeon */
-	case 11: /* Pentium III - Tualatin */
-		break;
-
-	case  9: /* Pentium M - Banias */
-	case 13: /* Pentium M - Dothan */
-		break;
-
-	default:
-		pr_cont("unsupported p6 CPU model %d ", boot_cpu_data.x86_model);
-		return -ENODEV;
-	}
 
 	memcpy(hw_cache_event_ids, p6_hw_cache_event_ids,
 		sizeof(hw_cache_event_ids));
-- 
2.43.0


