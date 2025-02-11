Return-Path: <linux-acpi+bounces-11048-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1428FA315E0
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 20:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE00E3A91EB
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 19:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A565A26D5A5;
	Tue, 11 Feb 2025 19:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9BKt5Mp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE6F269CEF;
	Tue, 11 Feb 2025 19:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303204; cv=none; b=SAZf5LTdpEJVTjp047p4PWzXJqCDcnRBwH/imuk9MsuOx0p28FsUDYj2XMG8UrxLuhk34xKwNiEN/ykIlYr6+LpF2bYiflSpqWXeAtpud7u1+G4PcuiMjzhpqKnqoavyPu9gKWtGBRx/ZOtkrJgl7zDoQ6EZ5Xi+nYDPCH61XJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303204; c=relaxed/simple;
	bh=zc8rXlTX5Ht3PzLU/txMXtYoBxP3G1MDHe0W5dQiEsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sIWaurO3zonN8T7p5BLgOeU38vcgsnITxqKG5/kN4z66EoiHVIHc5Btse8rXSLIw3c6RSjd8yZDcB2NiRXTAGbxn1OmUi/5wNoCq95F8OP6DAsPawvl4JwWcKMNLhokW/C5nDn2Gibe7xpm29q2EkFKoKw0hFrAKov0AW/PtnJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9BKt5Mp; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739303202; x=1770839202;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zc8rXlTX5Ht3PzLU/txMXtYoBxP3G1MDHe0W5dQiEsg=;
  b=f9BKt5Mp46RfFkyv2Lrywt259WKoyU3NDz7rxjgNeK2OP+swf7NHm9AK
   5Fib8cAYImPbD1IMUScSEEvDxhSuErWUnrqkMSEMgA8MJ1YgqlCPQPoFa
   G9ySfLW6bxa2YHHbdmcb8G/sXIcyIyRVd4DWWX3RUNwQ2hSvjcgdNXB/o
   IOyp9MsBY2MsxujfnV/AmgrN3ZYz189u++1gJGWN3Ln1KSFq2rdHVUruY
   2qSaKB8J4qorlNXUZnzQ8SqyDUHG7WXJZzKa0n60LA9hOBz9x0u/o8nCM
   CWXHNVPvSYVUiyI953YhKOtF146ewD7ABAtycqHJltMFPKlUwKgIhRKb+
   Q==;
X-CSE-ConnectionGUID: EV36C4P2Q1uzAXpK//Y2EA==
X-CSE-MsgGUID: +5Iv4kQaSeSnK5z4iAzhFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39855029"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39855029"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 11:46:37 -0800
X-CSE-ConnectionGUID: CA9spOHLT1i+GCi+S+jTKg==
X-CSE-MsgGUID: 0/OfcbVdQaa1ala7LvkDpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="143519315"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa001.fm.intel.com with ESMTP; 11 Feb 2025 11:46:36 -0800
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
Subject: [PATCH v2 16/17] perf/x86: Simplify P6 PMU initialization
Date: Tue, 11 Feb 2025 19:44:06 +0000
Message-ID: <20250211194407.2577252-17-sohil.mehta@intel.com>
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

A switch case is unnecessary when only a single case matters. Also, the
gaps in the case numbers are due to no CPU with those model numbers
being released.

Avoid the switch case and combine the cases into simpler VFM checks.
Also, this gets rid of one last few Intel x86_model comparisons.

No functional change intended.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>

---

v2: No change.

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


