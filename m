Return-Path: <linux-acpi+bounces-10228-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FF49F9C2E
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 22:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8A651898E1A
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 21:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED15622A800;
	Fri, 20 Dec 2024 21:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CsLfLkAa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CDE229666;
	Fri, 20 Dec 2024 21:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734730763; cv=none; b=WIuxLHGTpyEAfNd5Bi1/njt8W8b2XQ9reovyJ79hxNLr2ZuivYdsMiDw++Me37Vp4+H+Ek8IgAyHoUYzwzbWt9TDTDfI+R3XSIfPEZDjJqe/9YqzWN8ANu3oLeXBrlcxMUbuwQVBsVcBktl5hT3dd68g9VZd2WTQn8vYb/lgrkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734730763; c=relaxed/simple;
	bh=O4ncBifRTq9YBhwAqZ5RW1n+vh570dNEbVhOk1ZSBJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5pMk70WUQj2DsyaD6CIoXyQMZaG79pnJQsqDuCGXGRCz7+Y1ma8MY7nQaj2quk4O2HYGKeF9pyBYd3qVOfJwwt2g9iN8E7xNVuUnkSP2/3xCZcVU6dbPNFTKE4V/kQM2j0sw5SK9p1ZkjdP13t239WZ0BbeRphuebjISc3ADuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CsLfLkAa; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734730762; x=1766266762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O4ncBifRTq9YBhwAqZ5RW1n+vh570dNEbVhOk1ZSBJw=;
  b=CsLfLkAaDAADh0VprZQPtof4KuTsLHECDjiQbfHkBeH7lHDm7ClOmrm4
   HS+JmQ8rG8n5JR0dIhv9KUsxJ838GMrhOt+LWlCGyM63aNYmBCigNQqT0
   KOlpLTZ7Ky8d5O8HmUzmlURnADp4Gtn2HhpGcEL5ZM+V3DPc+dW+9aBvk
   0k3Lka7PkVpGWrGns8KbNrLO+nRkyt+glLh4g1b9jHt6ke8eoqR/MnmpE
   D5k0dbos5t6CL7IVUdKL419TmM5m45iasn6NNNbuzWo5HDoKLprXU7yoD
   zk+wtvyNrW9TkYJctvVPpgbRLtgeELro/l0fq4x8VEhm27YzoyQZDKFn4
   A==;
X-CSE-ConnectionGUID: 81DmAPlCSb6Edh3JRDVrjg==
X-CSE-MsgGUID: EpAjN+TNSMaJHbqcwO81+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="39070724"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="39070724"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 13:39:18 -0800
X-CSE-ConnectionGUID: WRYG0StfRiiG+cO98DSeDA==
X-CSE-MsgGUID: uRlwZ5epSAySRexzZPD09w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103223853"
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
Subject: [RFC PATCH 09/15] x86/cpu/intel: Replace family 15 checks with VFM ones
Date: Fri, 20 Dec 2024 21:37:04 +0000
Message-ID: <20241220213711.1892696-10-sohil.mehta@intel.com>
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

Introduce names for some old pentium 4 models and replace with VFM based
checks.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/include/asm/intel-family.h | 4 ++++
 arch/x86/kernel/cpu/intel.c         | 6 +++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 41278093bcd4..79cfd42c849f 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -182,6 +182,10 @@
 /* Family 5 */
 #define INTEL_QUARK_X1000		IFM(5, 0x09) /* Quark X1000 SoC */
 
+/* Family 15 */
+#define INTEL_P4_WILLAMETTE		IFM(15, 0x01) /* Also Xeon Foster */
+#define INTEL_P4_PRESCOTT		IFM(15, 0x03)
+
 /* Family 19 */
 #define INTEL_PANTHERCOVE_X		IFM(19, 0x01) /* Diamond Rapids */
 
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index cde8f45ccd57..26221f38db70 100644
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
@@ -430,7 +430,7 @@ static void intel_workarounds(struct cpuinfo_x86 *c)
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


