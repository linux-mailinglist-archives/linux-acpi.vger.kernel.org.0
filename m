Return-Path: <linux-acpi+bounces-11038-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38963A315B7
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 20:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13CE63A9B92
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 19:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D729F264F8B;
	Tue, 11 Feb 2025 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PRUuzCrv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000CF2638AC;
	Tue, 11 Feb 2025 19:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303195; cv=none; b=q3iHAT8plM+ZT9ll6B6Ebw8Q2H6wSoRiN/22AV4xl58KbKeaNIcFNhbLXIOZjLE/7vZWaXpLliiz88UrOwb8kJRYYdUiLWQGk2Ie3eU3RqJuWODqX4P0Ix2zLJDO8faGoLmbmynzeH6fjHyoW44g9FE9Pic+cRgI6uJiYNCiEhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303195; c=relaxed/simple;
	bh=UJAvG1jigca5lIA6pwMy0uKJY5UsaQ/LXhbyxsZnADc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMg4EvS6ng7DalcvYkhAQEiefXtxZIbE+nQE5wv/mTW7PdzjNEBX4h786dJtsJDwGmcdN8tX04UiJRXhuvsbcCO2tBo14GOcnk5ftma59NRks0DsY5BB1aw4f+urBFeGTsvQNF0ARaIXKiWGygszNcLjx/+Gkv+qk7Pzgux1YdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PRUuzCrv; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739303194; x=1770839194;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UJAvG1jigca5lIA6pwMy0uKJY5UsaQ/LXhbyxsZnADc=;
  b=PRUuzCrvqGA2glGK6EX68rnOfPY1Q0SLvU22trChBpzGL/wZ504ZmMnh
   ziidvZmbQk/UeWz1Np5sU+U3FGBWdHJZBmnJeuRupy1EMynS8QXetKLoR
   mbdW7qBY+xfLVCw9MAFOMcD4izOvzCwRw0PFRGmvPCQn0bRUGqhOkInPl
   DIzf00A/QS1+6s7dqQzusHH13fYX2YxDowGMxGgHiyXvWMJOLACVzD4gU
   9pAFJBvfn0PG0uuGDUzAPWyTiFW/a5RWwCpaq+5R3YEkm0UWTYTYTVVjt
   KyHogWlN1j0vl2IlPidj29luret0i/Z2oBY/3eftC3thqlGQQ8LgBGq4R
   A==;
X-CSE-ConnectionGUID: GsNPeIyaSnW1UkaDbWegQg==
X-CSE-MsgGUID: qoStRDC0RsydDUr6SHkrMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39854880"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39854880"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 11:46:32 -0800
X-CSE-ConnectionGUID: iJJLIjOWRQat8XwnT7y0zA==
X-CSE-MsgGUID: Y5QTbKMKQUSKPWqutvaibg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="143519276"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa001.fm.intel.com with ESMTP; 11 Feb 2025 11:46:31 -0800
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
Subject: [PATCH v2 06/17] cpufreq: Fix the efficient idle check for Intel extended Families
Date: Tue, 11 Feb 2025 19:43:56 +0000
Message-ID: <20250211194407.2577252-7-sohil.mehta@intel.com>
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

IO time is considered as busy by default for modern Intel processors.
However the check doesn't include the upcoming Family 18 and 19
processors. Also, Arjan van de Ven says the current nature of the check
was mainly due to lack of testing on old systems. He suggests
considering all Intel processors as having efficient idle.

Extend the IO busy classification to all Intel processors starting with
Family 6.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>

---

v2: Improve commit message and code comments.

---
 drivers/cpufreq/cpufreq_ondemand.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index a7c38b8b3e78..b13f197707f4 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -15,6 +15,10 @@
 #include <linux/tick.h>
 #include <linux/sched/cpufreq.h>
 
+#ifdef CONFIG_X86
+#include <asm/cpu_device_id.h>
+#endif
+
 #include "cpufreq_ondemand.h"
 
 /* On-demand governor macros */
@@ -32,21 +36,20 @@ static unsigned int default_powersave_bias;
 /*
  * Not all CPUs want IO time to be accounted as busy; this depends on how
  * efficient idling at a higher frequency/voltage is.
- * Pavel Machek says this is not so for various generations of AMD and old
- * Intel systems.
+ * Pavel Machek says this is not so for various generations of AMD.
  * Mike Chan (android.com) claims this is also not true for ARM.
- * Because of this, whitelist specific known (series) of CPUs by default, and
+ * Because of this, select known series of CPUs by default, and
  * leave all others up to the user.
  */
 static int should_io_be_busy(void)
 {
 #if defined(CONFIG_X86)
 	/*
-	 * For Intel, Core 2 (model 15) and later have an efficient idle.
+	 * Starting with Family 6 consider all Intel CPUs to have an
+	 * efficient idle.
 	 */
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
-			boot_cpu_data.x86 == 6 &&
-			boot_cpu_data.x86_model >= 15)
+	    boot_cpu_data.x86_vfm >= INTEL_PENTIUM_PRO)
 		return 1;
 #endif
 	return 0;
-- 
2.43.0


