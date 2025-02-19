Return-Path: <linux-acpi+bounces-11317-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23ABBA3C8CB
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 20:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FBC0189BD8B
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 19:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6268F23645F;
	Wed, 19 Feb 2025 19:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BVCweETQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E34236431;
	Wed, 19 Feb 2025 19:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739993397; cv=none; b=dQB1wIepVPdpfRjWzQbuTlM9GEp1VsNos5y/toShqS5aR7ifH8rVPDqMXJMfgmR4a47wIpdhDdBphA5UM5nE3F3i3TmGmSnIRmqHP+5oV9oNpNbZoCTRDlppoOs+2pwkCFU4y5CGrFrAMggCRo4zsU4th7pJTt1Ci1OXo+mb1FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739993397; c=relaxed/simple;
	bh=8LoKO9cw3zNi1Qfr0RD+m3/lR+uSJtFclDYDi2rbLok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWoqrLoA4BOiRoV61e+PiN0E947WOfXxp/IFhimz7G4q0mL9r9DT6S5GZRY2DiGzk2SFsa/U1mQjmQDm1D7dNJ6UBms7Pz9ZoKVa14KWBdMQ9exTDQMoIONZL9nikGVIrR0i5l5FC2yLaHXWX7MQuC4gt6lKWu8i2Gg3ZKhHpz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BVCweETQ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739993396; x=1771529396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8LoKO9cw3zNi1Qfr0RD+m3/lR+uSJtFclDYDi2rbLok=;
  b=BVCweETQto34E0wHtgjA0LQ03LXkVO/DIDTpE8hpImd5VfBZ2UXpygff
   fzitGAxXU2TBmkP7hXmmMQ/10Qst32zqcT1kNhU885ugqiS++PBve7R4V
   3fKw5/Rs2yUbU7TUe+3yGgISADnfB8MxZRALm7siZQmhV1kjyG0z1dmpG
   qbkaBi4O+VFb+tzgAwErb4tOGECkZrmU3KZlT2FHRn6jmvsAFObn1mrih
   eJUynbmJfYK7wO8oJKc9I6MXvMmIOY6hoM03kJljdkC3fbKEhGp2NG9fu
   szHAdcg1G8upQiuZzmmt51zGDn2/MwRybQPvNFTXl26TwaUBtN1oeftQO
   g==;
X-CSE-ConnectionGUID: LjrM5gDNRv6/1BvfC+NrHQ==
X-CSE-MsgGUID: +qNyOP2DQVOwPo8XRtBDRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52183085"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52183085"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 11:29:54 -0800
X-CSE-ConnectionGUID: AYq4ccKZSyibwbKEBZkWxg==
X-CSE-MsgGUID: FyUU+0r1QaC800I/t8dmwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="115344073"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa010.fm.intel.com with ESMTP; 19 Feb 2025 10:50:24 -0800
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
Subject: [PATCH v3 14/15] perf/x86: Simplify Intel PMU initialization
Date: Wed, 19 Feb 2025 18:41:32 +0000
Message-ID: <20250219184133.816753-15-sohil.mehta@intel.com>
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

Architectural Perfmon was introduced on the Family 6 "Core" processors
starting with Yonah. Processors before Yonah need their own customized
PMU initialization.

p6_pmu_init() is expected to provide that initialization for early
Family 6 processors. But, due to the unrestricted call to p6_pmu_init(),
it could get called for any Family 6 processor if the architectural
perfmon feature is disabled on that processor.

To simplify, restrict the call to p6_pmu_init() to early Family 6
processors that do not have architectural perfmon support. As a result,
the "unsupported" console print becomes practically unreachable because
all the released P6 processors are covered by the switch cases.

Move the console print to a common location where it can cover all
modern processors that do not have architectural perfmon support.

Also, use this opportunity to get rid of the unnecessary switch cases in
p6_pmu_init().  Only the Pentium Pro processor needs a quirk, and the
rest of the processors do not need any special handling. The gaps in the
case numbers are only due to no processor with those model numbers being
released.

Converting to a VFM based check gets rid of one last few Intel x86_model
comparisons.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v3: Restrict calling p6_pmu_init() to only when needed.
    Move the console print to a common location.

v2: No change.
---
 arch/x86/events/intel/core.c | 16 +++++++++++-----
 arch/x86/events/intel/p6.c   | 26 +++-----------------------
 2 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7601196d1d18..c645d8c8ab87 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6466,16 +6466,22 @@ __init int intel_pmu_init(void)
 	char *name;
 	struct x86_hybrid_pmu *pmu;
 
+	/* Architectural Perfmon was introduced starting with INTEL_CORE_YONAH */
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
+		default:
+			pr_cont("unsupported CPU family %d model %d ",
+				boot_cpu_data.x86, boot_cpu_data.x86_model);
+			return -ENODEV;
 		}
-		return -ENODEV;
 	}
 
 	/*
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


