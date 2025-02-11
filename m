Return-Path: <linux-acpi+bounces-11046-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3981BA315D5
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 20:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AA3F7A172A
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 19:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FD726B2AA;
	Tue, 11 Feb 2025 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eZ1TrJH8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEFA269CF0;
	Tue, 11 Feb 2025 19:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303203; cv=none; b=T1kIbi5cPrfLxTJS+DHTQ+gMfCseXWPC7rdJ1/Pv/izQythZXjaXsYtZE/RGInxmDPf32C5VKJTflHqgDSopiQZHmgOPk6TOh5N8nTjtrYvs3rT79ApqxHMiSz00jw3q4N2sUjCYD+hW3fy+qQ/+uFy502zO5TwkeHvtuIXuOks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303203; c=relaxed/simple;
	bh=uqKiQ714BjJ7ANDmd0HiU941l2gzoRNEv9cXh1UGXTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4T+gmk+qj3YxkwhrLEcLi48WBX8Oe/eAWfLMrjtP4RHkISmUjJFGwFE0WsSTckE1MkQIAorHr0eX/vIckfoGSjLaVyx8o2jYbWs+MlqSqY7FwpYU+YUIoUI9Ma9/4J/hANAPyNr4YUp5Hl32gUSRtxAv2E55aVacbSSEWwI7gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eZ1TrJH8; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739303202; x=1770839202;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uqKiQ714BjJ7ANDmd0HiU941l2gzoRNEv9cXh1UGXTg=;
  b=eZ1TrJH8TEg9dZOA+46W9UyZ2VVDx7f3IVLRn5u4S6y7n4mrX2U3Gi8e
   F4x87u6W++5js1nG3ve6rfGKNtPt/H5qmTFbcDL98eT8dtjqca80mFig+
   JLVMZ+d95OKVojM1xVHMBrGwGN8an7YJSuU+eksKbId8QzAVsFnDLk8/9
   TNgxMHQNBzRLSwZ7VGkfxAHnm3KKOI6TZVYd1pyYn5YHorr7tVfcNOANn
   yZVJKarmUpScRGf0nYTlmDE194EK85GRmAX77zRnQYNdl9glXfgjJGRH5
   G+Zl6yd6o2Unm2rD9UM9mg2/1wax9v4TvaHV5+YGaVgc/meSUQwOb7Vkj
   Q==;
X-CSE-ConnectionGUID: aliz9sLhR1+9gsuN6UvbuA==
X-CSE-MsgGUID: WVXVMzaRRTKby/emdM+ZJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39855015"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39855015"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 11:46:37 -0800
X-CSE-ConnectionGUID: FA+WwvtKRBays9aeg2PjtA==
X-CSE-MsgGUID: mjez5CfLQ+iOcRlUF7vkVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="143519312"
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
Subject: [PATCH v2 15/17] x86/cpu/intel: Bound the non-architectural constant_tsc model checks
Date: Tue, 11 Feb 2025 19:44:05 +0000
Message-ID: <20250211194407.2577252-16-sohil.mehta@intel.com>
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

Constant TSC has been architectural on Intel CPUs for a while. Supported
CPUs use the architectural Invariant TSC bit in CPUID.80000007. A
Family-model check is not required for these CPUs.

Prevent unnecessary confusion but restricting the model specific checks
to CPUs that need it and moving it closer to the architectural check.

Invariant TSC was likely introduced around the Nehalam timeframe on the
Xeon side and Saltwell timeframe on the Atom side.  Due to interspersed
model numbers extend the non-architectural capability setting until
Ivybridge to be safe.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>

---

v2: No change.

---
 arch/x86/kernel/cpu/intel.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 1b01ef4dfda2..ab195dcea50b 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -210,10 +210,6 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 {
 	u64 misc_enable;
 
-	if ((c->x86 == 0xf && c->x86_model >= 0x03) ||
-		(c->x86 == 0x6 && c->x86_model >= 0x0e))
-		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
-
 	if (c->x86 >= 6 && !cpu_has(c, X86_FEATURE_IA64))
 		c->microcode = intel_get_microcode_revision();
 
@@ -272,6 +268,11 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
 	}
 
+	/* Some older CPUs have invariant TSC but may not report it architecturally via 8000_0007 */
+	if ((c->x86_vfm >= INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_WILLAMETTE) ||
+	    (c->x86_vfm >= INTEL_CORE_YONAH && c->x86_vfm <= INTEL_IVYBRIDGE))
+		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
+
 	/* Penwell and Cloverview have the TSC which doesn't sleep on S3 */
 	switch (c->x86_vfm) {
 	case INTEL_ATOM_SALTWELL_MID:
-- 
2.43.0


