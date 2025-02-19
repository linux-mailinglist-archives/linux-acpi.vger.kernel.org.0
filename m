Return-Path: <linux-acpi+bounces-11308-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFE7A3C8B1
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 20:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42D71189B848
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 19:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD07322CBC7;
	Wed, 19 Feb 2025 19:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FjoWcgqO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD5A22AE5E;
	Wed, 19 Feb 2025 19:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739993355; cv=none; b=CvYbQZkZOfixG+4NSyl+OUQWz+qK4YGWAUwCRgJKyGMm5Vyl5Ra+BTmCGWesZH6xWPv0RatdtiJZihG/myLbQshAocW3gAjT3KMmtklrZlL7lKErvFv0QPcM0aVjAtVfM5Qbv6BxMupAevJPLE58dCChJPOn16BiXMx4jcFnLLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739993355; c=relaxed/simple;
	bh=2SmzUbbDEc07NOQm9JqvNZnwNZ90VP9jDICztH0L0P4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cX26gvPbDLzIsYW5aTiZYLNHiveV6KHIBfi94ieNUy54Ut6KN6e6NmNbHlaBQmwR1NjXFTGaN3NuINjAA0GRnDmspntDMMHrKVrGhF9YScS5aKAnkSeaVmb+nI8MOYp2ysZrQOFR0MycAWoNqWge4XFxU/pPwIHhprOJHoQHdKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FjoWcgqO; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739993354; x=1771529354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2SmzUbbDEc07NOQm9JqvNZnwNZ90VP9jDICztH0L0P4=;
  b=FjoWcgqOEMy9HCKGxiw/5nCeNm3fnLC3ghvPBFR8QCtVB9D+nJ1ZnMdC
   KSUGYy1YdsIjBOdbWzYuKJeQh2kfzBSbozfdakELsEz6MWFgH43AJsELx
   f5DLxYIOTmGAsgKd3e1thwiIC1FrCqZNaGjBlVfge9fnLSHVn7Xv9pXGH
   guA4iaBRXEYOSZjUuBdfIYdWCTnoTIXtCqQOq6nk45yT+7VJh8H3Ttrjy
   H2j1a4oV5GPYZAuKOxznQpBoAEauFEtGfyZ1NHSzRiuDuIrnjoX2MFcE/
   SezqURh5/vQRTvknTgXTpiRnltmivooAuyylEL0YSpWxYAP8KXCr9iQDv
   w==;
X-CSE-ConnectionGUID: hdxFHQo+QDeVTUTwRzmZcw==
X-CSE-MsgGUID: y5m34wtSQpikZEacq9uQcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52182873"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52182873"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 11:29:13 -0800
X-CSE-ConnectionGUID: HCqRkrYdQJKW/N4Mb1UZbQ==
X-CSE-MsgGUID: bykoVxlrTVOo+qXyh4q+Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="115344022"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa010.fm.intel.com with ESMTP; 19 Feb 2025 10:46:59 -0800
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
Subject: [PATCH v3 05/15] x86/cpu/intel: Replace early Family 6 checks with VFM ones
Date: Wed, 19 Feb 2025 18:41:23 +0000
Message-ID: <20250219184133.816753-6-sohil.mehta@intel.com>
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

Introduce names for some old pentium models and replace the x86_model
checks with VFM ones.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
---
v3: Picked up Dave's Ack.
v2: No change
---
 arch/x86/include/asm/intel-family.h |  4 ++++
 arch/x86/kernel/cpu/intel.c         | 11 +++++------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index cccc932d761e..c1a081585fcb 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -45,8 +45,12 @@
 /* Wildcard match so X86_MATCH_VFM(ANY) works */
 #define INTEL_ANY			IFM(X86_FAMILY_ANY, X86_MODEL_ANY)
 
+/* Family 6 */
 #define INTEL_PENTIUM_PRO		IFM(6, 0x01)
+#define INTEL_PENTIUM_II_KLAMATH	IFM(6, 0x03)
 #define INTEL_PENTIUM_III_DESCHUTES	IFM(6, 0x05)
+#define INTEL_PENTIUM_III_TUALATIN	IFM(6, 0x0B)
+#define INTEL_PENTIUM_M_DOTHAN		IFM(6, 0x0D)
 
 #define INTEL_CORE_YONAH		IFM(6, 0x0E)
 
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index e5f34a90963e..8e67d1ef4c73 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -195,7 +195,7 @@ void intel_unlock_cpuid_leafs(struct cpuinfo_x86 *c)
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return;
 
-	if (c->x86 < 6 || (c->x86 == 6 && c->x86_model < 0xd))
+	if (c->x86_vfm < INTEL_PENTIUM_M_DOTHAN)
 		return;
 
 	/*
@@ -350,9 +350,7 @@ static void bsp_init_intel(struct cpuinfo_x86 *c)
 int ppro_with_ram_bug(void)
 {
 	/* Uses data from early_cpu_detect now */
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
-	    boot_cpu_data.x86 == 6 &&
-	    boot_cpu_data.x86_model == 1 &&
+	if (boot_cpu_data.x86_vfm == INTEL_PENTIUM_PRO &&
 	    boot_cpu_data.x86_stepping < 8) {
 		pr_info("Pentium Pro with Errata#50 detected. Taking evasive action.\n");
 		return 1;
@@ -413,7 +411,8 @@ static void intel_workarounds(struct cpuinfo_x86 *c)
 	 * SEP CPUID bug: Pentium Pro reports SEP but doesn't have it until
 	 * model 3 mask 3
 	 */
-	if ((c->x86<<8 | c->x86_model<<4 | c->x86_stepping) < 0x633)
+	if ((c->x86_vfm == INTEL_PENTIUM_II_KLAMATH && c->x86_stepping < 3) ||
+	    c->x86_vfm < INTEL_PENTIUM_II_KLAMATH)
 		clear_cpu_cap(c, X86_FEATURE_SEP);
 
 	/*
@@ -615,7 +614,7 @@ static unsigned int intel_size_cache(struct cpuinfo_x86 *c, unsigned int size)
 	 * to determine which, so we use a boottime override
 	 * for the 512kb model, and assume 256 otherwise.
 	 */
-	if ((c->x86 == 6) && (c->x86_model == 11) && (size == 0))
+	if (c->x86_vfm == INTEL_PENTIUM_III_TUALATIN && size == 0)
 		size = 256;
 
 	/*
-- 
2.43.0


