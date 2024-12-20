Return-Path: <linux-acpi+bounces-10223-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 948909F9C14
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 22:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02A0316D9C4
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 21:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEA42288D1;
	Fri, 20 Dec 2024 21:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RJOMpupn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9625322687C;
	Fri, 20 Dec 2024 21:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734730760; cv=none; b=ITZKiH1dkc1Wz1Uix21Ulh/jrMY4lvnHme4rjP+ZrN6mBfdMWZkBjq18hFEXNCsbYlrrQqR2IqyDmetj9N2nanL6W2XOv5jHzl3hZoOmGV5wP4qnHFaOZc4LGsoNzIMqDlr1fChMz4oJ3erNfrXlsBCColEvtcAN8JkzNJ/jnYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734730760; c=relaxed/simple;
	bh=2gP+CtCrc5rkz2Pvmazx/u1oV3mo36Q6cxwLGcuRBdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ThomjsgHZ4dvxYug8eAsCegcqMueQhKqwItrcwZUSMUurGbB/dnT8i0seqEhu8HaawdYGZFwSsBqOlQNnHrqxC7cCvy0JuzYuGyM+kEryAbGCWrS/DhSAhflo2Uvi3vvhb5wT2SpeVVB4c45ryEwOXqfGyFS8dcAAtP4jE+RLPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RJOMpupn; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734730759; x=1766266759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2gP+CtCrc5rkz2Pvmazx/u1oV3mo36Q6cxwLGcuRBdY=;
  b=RJOMpupnvjYzQNkOSesviR4Q70w/ENCWkGjwuNkRXSw0YG9+X3OA4vvK
   WCQkK92Ury+iwrwULk/wRhstInR3S3eZk9t6ZmJQdAeYVavqymXYUR7P3
   MUhmIfW/7iZtAE372tn/Y/YuoFdxKKjOr29H3eeHKq4qCbMdPBTrdGw8V
   sgKDe0HaExtqlqlLl7MfHT3qDuMPyNVOxA/aTQDW1LK2omjsU1m22/qhQ
   S/eB0+Z6veRj4ScsujvGneiOaZpKvqx+D+b1h4gG9WPMceUNdURLFFPaZ
   5KL4Ok+/BJyP2/42nqSKtPgDmWjc0Zs8vZ2a5Em8ArB+3E9D2mDd5oN2F
   g==;
X-CSE-ConnectionGUID: h8Io7ZpiSxO5nxL6rG8KpQ==
X-CSE-MsgGUID: KKhG7lGxSP+a44zw33qSRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="39070654"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="39070654"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 13:39:16 -0800
X-CSE-ConnectionGUID: z1wT93DdRuafVZNCbYP0Ig==
X-CSE-MsgGUID: G3ak4Tt9TOq/u2dy0GsdVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103223838"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa005.fm.intel.com with ESMTP; 20 Dec 2024 13:39:15 -0800
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
Subject: [RFC PATCH 04/15] cpufreq: Fix the efficient idle check for Intel extended families
Date: Fri, 20 Dec 2024 21:36:59 +0000
Message-ID: <20241220213711.1892696-5-sohil.mehta@intel.com>
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

should_io_be_busy() only considers certain family 6 CPUs as having
efficient idling. However, Arjan (the original author) says that choice
was due to the lack of testing done on the old systems. He suggests to
consider all Intel processors as having efficient idle.

Extend the check to all processors starting with family 6.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 drivers/cpufreq/cpufreq_ondemand.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index a7c38b8b3e78..dfafb161f1c4 100644
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
@@ -32,8 +36,7 @@ static unsigned int default_powersave_bias;
 /*
  * Not all CPUs want IO time to be accounted as busy; this depends on how
  * efficient idling at a higher frequency/voltage is.
- * Pavel Machek says this is not so for various generations of AMD and old
- * Intel systems.
+ * Pavel Machek says this is not so for various generations of AMD.
  * Mike Chan (android.com) claims this is also not true for ARM.
  * Because of this, whitelist specific known (series) of CPUs by default, and
  * leave all others up to the user.
@@ -42,11 +45,11 @@ static int should_io_be_busy(void)
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


