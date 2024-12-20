Return-Path: <linux-acpi+bounces-10234-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F549F9C3D
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 22:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A15C716DF70
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 21:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BC122D4C2;
	Fri, 20 Dec 2024 21:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fB5rg8Tu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6BD22B8B0;
	Fri, 20 Dec 2024 21:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734730767; cv=none; b=FP0D1tY4EOOd4a/mcJ6Ga2pR1vDBNGqhp157/mGfpPXhB1QlDqtPoUIsaliibCZEnig3Bfl34+g0a13TwYn9/MmpAATrIr4/BMNV+FLy/WXZcu6SBchLB0z8OKim7Ux0bppq79pry4LjK1+BNa17gDpWT6hHJPHryw9efyaPImw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734730767; c=relaxed/simple;
	bh=IY7m0pnKYc6827kwQJ/ud1WEARNr4WSixtaPdx1SIcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dv3mntVI+pWKS87YGDTc9JeDXxmb8Wilao0QqaQiSnIDGpZj+kPyc0n+VP2hujNrCwkus1+O+4/e6CaIFILLayt4wWF1Eo/5D0+X49epA24evwGFGiSveGVyYtnlxJl9/pj2mb/BrTdbIIv3aW7t8VA4Zu71/uLXbuR0V9QpgKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fB5rg8Tu; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734730766; x=1766266766;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IY7m0pnKYc6827kwQJ/ud1WEARNr4WSixtaPdx1SIcw=;
  b=fB5rg8Tuiwx7OHLjfYy3b2TBeHmATaVccBYlk8SLZ69u74grseCsWNnV
   d4UJYr1GZW504o6nnCjKH7HQ6asOQjzcJ9hQOjxbhD8g9kiI3g9h2QcOv
   Y/qvAg1Gm5ZnE3dmQMdZFUpNxQtZdjRVHgOi4Gq0FKiT33SQzX0iTVqnb
   dnAT7kOXuBeTCfXUBzVLAsG8qZuMQBXbfnPdg4nvHVPxW05nOXBb19CnY
   c8WBZ3aPt7GLiDA8HwmVDMtl+KEB/AbNkEtxf7M1mTi8MMjT4t/+oiiMu
   gfNDY4mTbAYNlLQ6r3V3Uom9E0qPu6RjlGlhsqjU4KYCbfOSVXFESyIhV
   Q==;
X-CSE-ConnectionGUID: BJa2STe8SsegExI0dYY1fA==
X-CSE-MsgGUID: V3sEdgYrSLGWYtZet2ZnIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="39070780"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="39070780"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 13:39:20 -0800
X-CSE-ConnectionGUID: 7aXvm4FOS3aLBLKlNQfO5w==
X-CSE-MsgGUID: yJSFAI3+RuGqA8CR4R0AaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103223869"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa005.fm.intel.com with ESMTP; 20 Dec 2024 13:39:19 -0800
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
Subject: [RFC PATCH 14/15] perf/x86: Simplify p6_pmu_init()
Date: Fri, 20 Dec 2024 21:37:09 +0000
Message-ID: <20241220213711.1892696-15-sohil.mehta@intel.com>
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

A switch case is unnecessary when only a single case matters. Also, the
gaps in the case numbers are due to no CPU with those model numbers
being released.

Avoid the switch case and combine the cases into simpler VFM checks.
Also, this gets rid of one last few Intel x86_model comparisons. No
functional change intended.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/events/intel/p6.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/arch/x86/events/intel/p6.c b/arch/x86/events/intel/p6.c
index a6cffb4f4ef5..37e3beb6d633 100644
--- a/arch/x86/events/intel/p6.c
+++ b/arch/x86/events/intel/p6.c
@@ -2,6 +2,8 @@
 #include <linux/perf_event.h>
 #include <linux/types.h>
 
+#include <asm/cpu_device_id.h>
+
 #include "../perf_event.h"
 
 /*
@@ -244,35 +246,19 @@ static __init void p6_pmu_rdpmc_quirk(void)
 	}
 }
 
+/* Only called for Family 6 CPUs without X86_FEATURE_ARCH_PERFMON */
 __init int p6_pmu_init(void)
 {
 	x86_pmu = p6_pmu;
 
-	switch (boot_cpu_data.x86_model) {
-	case  1: /* Pentium Pro */
-		x86_add_quirk(p6_pmu_rdpmc_quirk);
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
+	if (boot_cpu_data.x86_vfm >= INTEL_CORE_YONAH) {
 		pr_cont("unsupported p6 CPU model %d ", boot_cpu_data.x86_model);
 		return -ENODEV;
 	}
 
+	if (boot_cpu_data.x86_vfm == INTEL_PENTIUM_PRO)
+		x86_add_quirk(p6_pmu_rdpmc_quirk);
+
 	memcpy(hw_cache_event_ids, p6_hw_cache_event_ids,
 		sizeof(hw_cache_event_ids));
 
-- 
2.43.0


