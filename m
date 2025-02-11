Return-Path: <linux-acpi+bounces-11043-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF317A315C7
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 20:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DF71161E71
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 19:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3F4261369;
	Tue, 11 Feb 2025 19:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jE83T6iD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DF4265CCF;
	Tue, 11 Feb 2025 19:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303199; cv=none; b=qO5u4XwCHnrs8Abldt4ZjZsvEKpogCiPtUGgVuE3XEPmTLS/ZCJoxP+DAojXd5iBkopnSkYkZapmEQa/N6pv/MlowpaGtpgTnXrhxRU/5ODfgVsCGpv+EfOxhOKbl048UTCkNSHym9JQ0UDoHwZOVMPFQBC5n48FfSsGlWiZnKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303199; c=relaxed/simple;
	bh=kkvrwAEWRYbo3CCgrEPYSsGus2xbUKPJsVCbtAeBNS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRdyUMrPqfaUqlhfXXUFaJtijf/aWyOEdXXC5B5jBsg6W7rEgIlfVbOb4BbknyIZQgdRQITLG4W42IgJ7QV46YONLFtRPqFiFrcWAE+eW8iRIC5BnAueRixadEEBgbLE1c9y2oac9JbttqtsFtnYOyyyYrLoLpSY+ulO+JlbtZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jE83T6iD; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739303198; x=1770839198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kkvrwAEWRYbo3CCgrEPYSsGus2xbUKPJsVCbtAeBNS4=;
  b=jE83T6iD6t+qiiNoo7ipygTF91TSEHxs7TerE8omfc3L3NQxU6hOTKVd
   XbmgVWjRJOosIl7suBSJptcnFiH4kFpSkFyBzwvnck8ldgYrcZoIYhDh/
   K8tdfs5mddDrUdPojWuVFOYvQHFhP9RmQR8S28DM7rodQ8qMo39NaQtof
   V80IAeBiPxH+fN1nQfxZHHry/AkHCSrFc8B48RW+BuD1Absrj/LBud8yF
   Dpz/ediYPBTFWpnp+QiUrU6qpkoHOO9xt/FI0XUEUR8I8NsM4eIqoOGOG
   Aty++xyntZuTJlK5sSylpA67QoauAxlpzEnMz473f9KwSZqX5ioueEeGh
   Q==;
X-CSE-ConnectionGUID: JYY5NpXhS7OVJQfbEZSKaA==
X-CSE-MsgGUID: hoZzqk3sQPCcD2WAzjC2vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39854960"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39854960"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 11:46:35 -0800
X-CSE-ConnectionGUID: +4iRSLP0RtWxiUAUmSnfPQ==
X-CSE-MsgGUID: vGhJj6H2R9+NI/lmv4Q7Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="143519295"
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
Subject: [PATCH v2 11/17] x86/cpu/intel: Replace Family 15 checks with VFM ones
Date: Tue, 11 Feb 2025 19:44:01 +0000
Message-ID: <20250211194407.2577252-12-sohil.mehta@intel.com>
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

Introduce names for some old pentium 4 models and replace the x86_model
checks with VFM ones.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>

---

v2: No change.

---
 arch/x86/include/asm/intel-family.h | 4 ++++
 arch/x86/kernel/cpu/intel.c         | 6 +++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index c1a081585fcb..f509061b8c7e 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -184,6 +184,10 @@
 /* Family 5 */
 #define INTEL_QUARK_X1000		IFM(5, 0x09) /* Quark X1000 SoC */
 
+/* Family 15 - NetBurst */
+#define INTEL_P4_WILLAMETTE		IFM(15, 0x01) /* Also Xeon Foster */
+#define INTEL_P4_PRESCOTT		IFM(15, 0x03)
+
 /* Family 19 */
 #define INTEL_PANTHERCOVE_X		IFM(19, 0x01) /* Diamond Rapids */
 
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 1b6e077a037a..507cb4c6d587 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -256,8 +256,8 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 #endif
 
 	/* CPUID workaround for 0F33/0F34 CPU */
-	if (c->x86 == 0xF && c->x86_model == 0x3
-	    && (c->x86_stepping == 0x3 || c->x86_stepping == 0x4))
+	if (c->x86_vfm == INTEL_P4_PRESCOTT &&
+	    (c->x86_stepping == 0x3 || c->x86_stepping == 0x4))
 		c->x86_phys_bits = 36;
 
 	/*
@@ -438,7 +438,7 @@ static void intel_workarounds(struct cpuinfo_x86 *c)
 	 * P4 Xeon erratum 037 workaround.
 	 * Hardware prefetcher may cause stale data to be loaded into the cache.
 	 */
-	if ((c->x86 == 15) && (c->x86_model == 1) && (c->x86_stepping == 1)) {
+	if (c->x86_vfm == INTEL_P4_WILLAMETTE && c->x86_stepping == 1) {
 		if (msr_set_bit(MSR_IA32_MISC_ENABLE,
 				MSR_IA32_MISC_ENABLE_PREFETCH_DISABLE_BIT) > 0) {
 			pr_info("CPU: C0 stepping P4 Xeon detected.\n");
-- 
2.43.0


