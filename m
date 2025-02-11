Return-Path: <linux-acpi+bounces-11033-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ECAA315A2
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 20:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E63C3A304F
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 19:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A68262179;
	Tue, 11 Feb 2025 19:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ub0ZnyjL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4ED155336;
	Tue, 11 Feb 2025 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303192; cv=none; b=uHRrrd7BXwVll3y7lsDvA56neo3WUTsWSZMcmzzgIaKXAFrza2XhhDpnEyjYbvaG/RyohRDjK8GCQql1bfHkcyFFGBPZRQDvTVjIl9oJ5twaKennG0/1rXPsByF+b/rHbZxS1zk0G2/dAk8l6H5Fun5Ih5TucKBIkPu4LTPgt7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303192; c=relaxed/simple;
	bh=fT0p7F49xGJQhA3HYcRls8JCok0zDR6dL4ef892583k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTGFkyTCo825AcCS9eAknNkzEladJDTGbKvpGNJox0lAJ1RAGoN+0bwCDkooG+s2NPJQN9bHP4bSjycjfpCiINqRP2Oaa6qDDrS30mpMHFiDPu2UbIACAgTla2XSuRRf0e2zvz0RUHGpTOKr9Br1xNzv+9Xpo/GrS+IuZHKnXSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ub0ZnyjL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739303191; x=1770839191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fT0p7F49xGJQhA3HYcRls8JCok0zDR6dL4ef892583k=;
  b=Ub0ZnyjL9iLwW1No0jOu5PcK1liiOJqaWic8aONniiGNm9HMD7OfDkgG
   ZqNyM+kyjBFF2OselKokk+J5CQC9q7uYe7N5ydalHun5NJkHawfnBxjXK
   60F6MVSveNeVv9nuWo+EkXvbAOmPvqtcjUT7x261zSMP3ep2HVdmRpFBd
   xopEN6lacPcAzKqXKSGNMD1GRaeca1O/DnAvjaEvK/bAgldABjPks5bOh
   YNqKCr+9NM7W0LmYGcjRUVn9cV/p9wj5kJ9Yo66KhUxLWpMumvKLZhElS
   MfdPTQE4IUyNIZoaVrEWENmOsqk2jNecEfK1jVDB/dfjpKe/quBWz1U84
   Q==;
X-CSE-ConnectionGUID: 0d58RR0vTXmsFSU+jKKmAg==
X-CSE-MsgGUID: SKskLenaSVO2jtW0pYFBwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39854786"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39854786"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 11:46:29 -0800
X-CSE-ConnectionGUID: GrAC5Kk5T/GRC2xJ4tGWcg==
X-CSE-MsgGUID: evzs/8SmSaODRcvgLLAMSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="143519252"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa001.fm.intel.com with ESMTP; 11 Feb 2025 11:46:28 -0800
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
Subject: [PATCH v2 01/17] x86/smpboot: Remove confusing quirk usage in INIT delay
Date: Tue, 11 Feb 2025 19:43:51 +0000
Message-ID: <20250211194407.2577252-2-sohil.mehta@intel.com>
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

The usage of the "quirk" wording while setting the INIT assert -
de-assert delay is misleading. The comments suggest that modern
processors need the quirk (to clear init_udelay) while legacy processors
don't need the quirk (to use the default init_udelay).

With a lot more modern processors, the wording should be inverted if at
all needed. Instead, simplify the comments and the code by getting rid of
"quirk" usage altogether.

No functional change.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>

---

v2: New patch

---
 arch/x86/kernel/smpboot.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index c10850ae6f09..eb91ed0f2a06 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -654,10 +654,9 @@ static void impress_friends(void)
  * But that slows boot and resume on modern processors, which include
  * many cores and don't require that delay.
  *
- * Cmdline "init_cpu_udelay=" is available to over-ride this delay.
- * Modern processor families are quirked to remove the delay entirely.
+ * Cmdline "cpu_init_udelay=" is available to override this delay.
  */
-#define UDELAY_10MS_DEFAULT 10000
+#define UDELAY_10MS_LEGACY 10000
 
 static unsigned int init_udelay = UINT_MAX;
 
@@ -669,7 +668,7 @@ static int __init cpu_init_udelay(char *str)
 }
 early_param("cpu_init_udelay", cpu_init_udelay);
 
-static void __init smp_quirk_init_udelay(void)
+static void __init smp_set_init_udelay(void)
 {
 	/* if cmdline changed it from default, leave it alone */
 	if (init_udelay != UINT_MAX)
@@ -683,7 +682,7 @@ static void __init smp_quirk_init_udelay(void)
 		return;
 	}
 	/* else, use legacy delay */
-	init_udelay = UDELAY_10MS_DEFAULT;
+	init_udelay = UDELAY_10MS_LEGACY;
 }
 
 /*
@@ -1094,7 +1093,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 
 	uv_system_init();
 
-	smp_quirk_init_udelay();
+	smp_set_init_udelay();
 
 	speculative_store_bypass_ht_init();
 
-- 
2.43.0


