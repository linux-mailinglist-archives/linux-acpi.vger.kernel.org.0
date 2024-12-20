Return-Path: <linux-acpi+bounces-10221-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E34599F9C0F
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 22:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5230916DCF2
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 21:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CFC227B86;
	Fri, 20 Dec 2024 21:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="beJ3aNfK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706802210C0;
	Fri, 20 Dec 2024 21:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734730759; cv=none; b=RXbXpYP3pVxhQ3ai+SwDNwiLDdshAHvFFreVPVZGz/9xcdW5YR0f3ZiHxySuCTHeEPsKv1nYmiL8DKEaNacCYNs51PQnz/5Dn5lvbv3qM1bMY0FEQ0la4+OK/WEguJKu4pjKl3t2PzY8gg4djLlcJC4fh3605REZIx7+5hawbZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734730759; c=relaxed/simple;
	bh=mCrZEKcq0bU/X4Zpv9YkufkdbaRSoGmsrcDiM/WKDGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BrVO28dXZSQW/rXOcDYdFA3o838R+7z62IbQsMRiLaUfWogKNRL+BdS4qBOkh4IMu7NkPd9VvHbdz2+WbUblGAkdIXX6allg6fbnbtE+VsAmUKjRH/w2T+m6HIMTfBVYO+Y6ORtxm8y4lKB4Gep44tWTqRZx+PFdDlao1hr5ExE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=beJ3aNfK; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734730758; x=1766266758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mCrZEKcq0bU/X4Zpv9YkufkdbaRSoGmsrcDiM/WKDGo=;
  b=beJ3aNfK0xIUsuKmrb9A3uDUx5i2nuQl+7KBg+/k0xBDRug0PV68z+m8
   xxHwFrRsgVv0Edz3UHL3WsyScgcgWzVwanT6MKOeQRMkN8Fe6E7XuiQqG
   lsaeBR+WxyxVNGhZRsFCWmTpmKOF5kQAmXPnECCjIndZnMonjPoK0LF3S
   6lD30CpIT+Lf296sRDQgEcc3ztP6aYABQVlyhVHmrHOpW+sAUvSE+p7fr
   pYItFszWSth9/R+xu2GVuxkrbTJgRSIf+vQzi99YDfZuEnRPrAkX1NlNv
   wFqv3AQnIVmNlMR6HbPs+16cXKFE4eAmvyWGAt2qklLVuRNS3i6pQ9AN1
   Q==;
X-CSE-ConnectionGUID: EPOm5H3GSly2myUMI152jQ==
X-CSE-MsgGUID: mdMl1OHITECa/g7tSqUSnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="39070629"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="39070629"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 13:39:15 -0800
X-CSE-ConnectionGUID: ogqVXgK+Qa6uo5r7INgAzw==
X-CSE-MsgGUID: M2zFWnTuTlS402OPAjjQjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103223832"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa005.fm.intel.com with ESMTP; 20 Dec 2024 13:39:14 -0800
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
Subject: [RFC PATCH 02/15] x86/apic: Fix smp init delay for extended Intel families
Date: Fri, 20 Dec 2024 21:36:57 +0000
Message-ID: <20241220213711.1892696-3-sohil.mehta@intel.com>
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

The MP specification version 1.4 references the i486 and early Pentium
processors in family 5. However, all processors starting with family 6
likely do not need the 10 msec INIT delay. The omission of the Pentium
4s (family 15) seems like an oversight in the original check.

With some risk, choose a simpler check and extend the quirk to all
recent and upcoming Intel processors.

While at it, fix the command line parameter comment to match with the
actual name.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/kernel/smpboot.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index b5a8f0891135..6c98e9178963 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -668,7 +668,7 @@ static void impress_friends(void)
  * But that slows boot and resume on modern processors, which include
  * many cores and don't require that delay.
  *
- * Cmdline "init_cpu_udelay=" is available to over-ride this delay.
+ * Cmdline "cpu_init_udelay=" is available to override this delay.
  * Modern processor families are quirked to remove the delay entirely.
  */
 #define UDELAY_10MS_DEFAULT 10000
@@ -690,9 +690,9 @@ static void __init smp_quirk_init_udelay(void)
 		return;
 
 	/* if modern processor, use no delay */
-	if (((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) && (boot_cpu_data.x86 == 6)) ||
-	    ((boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) && (boot_cpu_data.x86 >= 0x18)) ||
-	    ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) && (boot_cpu_data.x86 >= 0xF))) {
+	if ((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL && boot_cpu_data.x86_vfm >= INTEL_PENTIUM_PRO) ||
+	    (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON && boot_cpu_data.x86 >= 0x18) ||
+	    (boot_cpu_data.x86_vendor == X86_VENDOR_AMD && boot_cpu_data.x86 >= 0xF)) {
 		init_udelay = 0;
 		return;
 	}
-- 
2.43.0


