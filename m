Return-Path: <linux-acpi+bounces-11044-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0CDA315CF
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 20:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 053A43A4AA4
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 19:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909212690DB;
	Tue, 11 Feb 2025 19:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GsQA4DVY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C97267B84;
	Tue, 11 Feb 2025 19:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303200; cv=none; b=ZT2QZctDq8fZPnT6EkC+w8IkljOQzh4fzzauehi3cO0u/q9JWan/N6GF1tJyvbzlgBl6w42W61bVXun36iolGWdWSG3IGhGCjHr5BaMpyjbDVgLwcxVO+qMuekMNfzbremvCYqwD3ItvRSdhosR6xiqrhRMadovvdRT7aAWc7A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303200; c=relaxed/simple;
	bh=ovSvGTD2eoxGo/w6M7zOZJrTYNbTQnNqk+N7Hm0U4M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WpR5gJD2ycU9GnNta4MO/G6UPesGmv8c/mQKBjkK32G1+fhVQ4Qtkt35EXn4Ns11ojR+5YL4zW0V05ahubLvH3gemj+TBk8dVHNtkP7KyizJzcVhpvtMNuDZBmT3hTz7NUfarq4I0lq1lLLdz4yqOFdVQGdQzk2/jAY86YQr6ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GsQA4DVY; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739303199; x=1770839199;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ovSvGTD2eoxGo/w6M7zOZJrTYNbTQnNqk+N7Hm0U4M4=;
  b=GsQA4DVYnivsMaTmPatta0kDNgLc5Kk8hoPAzUR9gPtq19H7Gu5eJLmu
   8p7CbRgACldVeaGLOXjjlnjqK8ua986CeDWo5Vvj63k5YsZpY/O3CqfHg
   YCBa5uBGQ2UWHS0apX0MFJgWkZEUMIgmlFbZnI5W/7yZWIX9Asb2RYfbK
   Fb1Rct8bbIe3o1rvIHqOxk3fbzkt692iHbclopWK80Jxlrjw3BVBvJk1v
   ds6QpNHJi7lBoaM1XG6DpRHdyIzldjI9fkrCLwg8E8ca0ibDkyYKKpZ8L
   yB25wH0uTaianqJL/aARIbmyPWhnd2wY5j+6UpgxybFSCa1b8uKbdMx76
   Q==;
X-CSE-ConnectionGUID: PdUxOQFsT2KQkRZJJnjPFA==
X-CSE-MsgGUID: UITlqjPgQxeLWB6SnEIOpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39854973"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39854973"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 11:46:35 -0800
X-CSE-ConnectionGUID: mOkwpg8cRJmcQtKP9JbZsw==
X-CSE-MsgGUID: uU2Bpy/mRyO4VQQoMIuYRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="143519301"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa001.fm.intel.com with ESMTP; 11 Feb 2025 11:46:35 -0800
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
Subject: [PATCH v2 12/17] x86/cpu/intel: Replace Family 5 model checks with VFM ones
Date: Tue, 11 Feb 2025 19:44:02 +0000
Message-ID: <20250211194407.2577252-13-sohil.mehta@intel.com>
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

Introduce names for some Family 5 models and convert some of the checks
to be VFM based.

Also, to keep the file sorted by family, move Family 5 to the top of the
header file.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>

---

v2: Reorder the Family 5 models to be at the top of the file.

---
 arch/x86/include/asm/intel-family.h |  9 ++++++---
 arch/x86/kernel/cpu/intel.c         | 11 +++++------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index f509061b8c7e..9e6a13f03f0e 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -45,6 +45,12 @@
 /* Wildcard match so X86_MATCH_VFM(ANY) works */
 #define INTEL_ANY			IFM(X86_FAMILY_ANY, X86_MODEL_ANY)
 
+/* Family 5 */
+#define INTEL_FAM5_START		IFM(5, 0x00) /* Notational marker, also P5 A-step */
+#define INTEL_PENTIUM_75		IFM(5, 0x02) /* P54C */
+#define INTEL_PENTIUM_MMX		IFM(5, 0x04) /* P55C */
+#define INTEL_QUARK_X1000		IFM(5, 0x09) /* Quark X1000 SoC */
+
 /* Family 6 */
 #define INTEL_PENTIUM_PRO		IFM(6, 0x01)
 #define INTEL_PENTIUM_II_KLAMATH	IFM(6, 0x03)
@@ -181,9 +187,6 @@
 #define INTEL_XEON_PHI_KNL		IFM(6, 0x57) /* Knights Landing */
 #define INTEL_XEON_PHI_KNM		IFM(6, 0x85) /* Knights Mill */
 
-/* Family 5 */
-#define INTEL_QUARK_X1000		IFM(5, 0x09) /* Quark X1000 SoC */
-
 /* Family 15 - NetBurst */
 #define INTEL_P4_WILLAMETTE		IFM(15, 0x01) /* Also Xeon Foster */
 #define INTEL_P4_PRESCOTT		IFM(15, 0x03)
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 507cb4c6d587..1b01ef4dfda2 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -375,9 +375,8 @@ static void intel_smp_check(struct cpuinfo_x86 *c)
 	/*
 	 * Mask B, Pentium, but not Pentium MMX
 	 */
-	if (c->x86 == 5 &&
-	    c->x86_stepping >= 1 && c->x86_stepping <= 4 &&
-	    c->x86_model <= 3) {
+	if (c->x86_vfm >= INTEL_FAM5_START && c->x86_vfm < INTEL_PENTIUM_MMX &&
+	    c->x86_stepping >= 1 && c->x86_stepping <= 4) {
 		/*
 		 * Remember we have B step Pentia with bugs
 		 */
@@ -404,7 +403,7 @@ static void intel_workarounds(struct cpuinfo_x86 *c)
 	 * The Quark is also family 5, but does not have the same bug.
 	 */
 	clear_cpu_bug(c, X86_BUG_F00F);
-	if (c->x86 == 5 && c->x86_model < 9) {
+	if (c->x86_vfm >= INTEL_FAM5_START && c->x86_vfm < INTEL_QUARK_X1000) {
 		static int f00f_workaround_enabled;
 
 		set_cpu_bug(c, X86_BUG_F00F);
@@ -452,7 +451,7 @@ static void intel_workarounds(struct cpuinfo_x86 *c)
 	 * integrated APIC (see 11AP erratum in "Pentium Processor
 	 * Specification Update").
 	 */
-	if (boot_cpu_has(X86_FEATURE_APIC) && (c->x86<<8 | c->x86_model<<4) == 0x520 &&
+	if (boot_cpu_has(X86_FEATURE_APIC) && c->x86_vfm == INTEL_PENTIUM_75 &&
 	    (c->x86_stepping < 0x6 || c->x86_stepping == 0xb))
 		set_cpu_bug(c, X86_BUG_11AP);
 
@@ -627,7 +626,7 @@ static unsigned int intel_size_cache(struct cpuinfo_x86 *c, unsigned int size)
 	 * Intel Quark SoC X1000 contains a 4-way set associative
 	 * 16K cache with a 16 byte cache line and 256 lines per tag
 	 */
-	if ((c->x86 == 5) && (c->x86_model == 9))
+	if (c->x86_vfm == INTEL_QUARK_X1000)
 		size = 16;
 	return size;
 }
-- 
2.43.0


