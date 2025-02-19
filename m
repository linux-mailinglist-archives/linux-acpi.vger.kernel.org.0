Return-Path: <linux-acpi+bounces-11316-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E6AA3C8D1
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 20:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC6B43A2433
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 19:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040FA2356B7;
	Wed, 19 Feb 2025 19:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YarBi1iG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4102423314C;
	Wed, 19 Feb 2025 19:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739993393; cv=none; b=XZO954yts68sbKHbZ+aMK2sJ0njIqse9ecrS4D+2ri0yQVbT1gWtcuUUAd/FIuOqlqyzmiXjX3GLMVXjyrYYVZ0FtVKNEFIvoEzp+bQAoP8I7RGBBD3oj6SCQikOkKXfOgENhvCyfR8kQ0u1drQacYPh9cOQkB2vAUIzLrexzcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739993393; c=relaxed/simple;
	bh=GmXwBXf7o6X1iHu+tHqsXntz3Xo5SDeaPBJSRIAxMDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IaURz0kkbhXromYMxsMIKvl+B8LgXoZ+Tn3e+ii6grGFlCLlOYDOKht1BE5MevP9tRvpvAbri6jRJcydwfpnVsY+tZI9HUduLYu9KrHNuAA8LhYsGAHIEMzbrU13nGO4c3vHj4dyhNY2Gsm4t24HUeeI+CanczDz5oNjaa9Lzs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YarBi1iG; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739993392; x=1771529392;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GmXwBXf7o6X1iHu+tHqsXntz3Xo5SDeaPBJSRIAxMDU=;
  b=YarBi1iGnEuQ05r/kIcFaygk1k29EAcYIW4IauUyMRt9YVZQWMDveCsB
   GatyJxe80dfEMDfcmPZVVp/jLu1UWFf+ybXE7ce2+QlgIJR4ElPIC/MM7
   t/O2hDHIh+BPWHTUdn0QZXqDqF/rpAJRECRagMqCzubVi+3My4HNEEgji
   ebTo0cNh3GVBPRYzmm5q7/oggvu3WrQpjuJRBh2L6U+fPeN2ws/xW9R0n
   O7/oepEFBDwlNzIn1uk/YmXuT6tqgm+I1xFkbv7dtoNH6no6s8aexaaeY
   IyyimtbgwRg+OZuLxDPJl41vJIZrzHUdH6fJnVYZoczF1XadxkeOG/sZF
   w==;
X-CSE-ConnectionGUID: +IDdg6V8Sd2a/ARZrC4fmQ==
X-CSE-MsgGUID: V5CmblIYQNq1wO8x0DXahw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52183067"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52183067"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 11:29:51 -0800
X-CSE-ConnectionGUID: 5TYVdDi5SWCIpXUNqA0fHw==
X-CSE-MsgGUID: JKgeboEKRKisXI+7sHYqvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="115344070"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa010.fm.intel.com with ESMTP; 19 Feb 2025 10:50:19 -0800
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
Subject: [PATCH v3 13/15] x86/cpu/intel: Bound the non-architectural constant_tsc model checks
Date: Wed, 19 Feb 2025 18:41:31 +0000
Message-ID: <20250219184133.816753-14-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219184133.816753-1-sohil.mehta@intel.com>
References: <20250219184133.816753-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

X86_FEATURE_CONSTANT_TSC is a Linux-defined, synthesized feature flag.
It is used across several vendors. Intel CPUs will set the feature when
the architectural CPUID.80000007.EDX[1] bit is set. There are also some
Intel CPUs that have the X86_FEATURE_CONSTANT_TSC behavior but don't
enumerate it with the architectural bit.  Those currently have a model
range check.

Today, virtually all of the CPUs that have the CPUID bit *also* match
the "model >= 0x0e" check. This is confusing. Instead of an open-ended
check, pick some models (INTEL_IVYBRIDGE and P4_WILLAMETTE) as the end
of goofy CPUs that should enumerate the bit but don't.  These models are
relatively arbitrary but conservative pick for this.

This makes it obvious that later CPUs (like Family 18+) no longer need
to synthesize X86_FEATURE_CONSTANT_TSC.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v3: Make the non-architectural model checks more explicit.
    Improve commit message.

v2: No change.
---
 arch/x86/kernel/cpu/intel.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index fc68561d9f92..4fbc5465ca67 100644
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
 
@@ -266,10 +262,16 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	 *
 	 * It is also reliable across cores and sockets. (but not across
 	 * cabinets - we turn it off in that case explicitly.)
+	 *
+	 * Use a model-specific check for some older CPUs that have invariant
+	 * TSC but may not report it architecturally via 8000_0007.
 	 */
 	if (c->x86_power & (1 << 8)) {
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
 		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
+	} else if ((c->x86_vfm >= INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_WILLAMETTE) ||
+		   (c->x86_vfm >= INTEL_CORE_YONAH  && c->x86_vfm <= INTEL_IVYBRIDGE)) {
+		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
 	}
 
 	/* Penwell and Cloverview have the TSC which doesn't sleep on S3 */
-- 
2.43.0


