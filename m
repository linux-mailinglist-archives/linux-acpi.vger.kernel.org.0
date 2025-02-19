Return-Path: <linux-acpi+bounces-11314-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BF9A3C8C3
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 20:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FFB0189C6F7
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 19:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0BA22E3F7;
	Wed, 19 Feb 2025 19:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UfGCuuaM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3222422AE55;
	Wed, 19 Feb 2025 19:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739993390; cv=none; b=IBTZYz/lx2c52bf5Izza4RANGDf9mf14odpdGdrcq3R69s4OAmC4EmPIro+hghhCA+8nhiOuIjNK5tJGQK8wTKcgmjQEN9TXTFt0l/wH+1uwjzJ+gbBWHEzow4Wk9jgGhFkJNzCvzG6OuPrIbCnNNzfJ7oz6GQ0a0ncb5d5cCfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739993390; c=relaxed/simple;
	bh=kfnGOt0+eNdaQoCOZBz02E74O7l/rkUOG6IfNzeHRzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qv6LUqmgQpIxfOHLL6yFDSIMQ2A3iG1qpXgwMgQKTZ3fQnmxnxByNStLb158B41d2yZVfQ9aZW0f+VX9HgKB0JLtCaKpZlf28+eE668l5Q0FHa3OzS7X87gAka3vadPBeWJkFFiRTPN9YJajcRpWSZws2foR55nBReuuazUMA7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UfGCuuaM; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739993389; x=1771529389;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kfnGOt0+eNdaQoCOZBz02E74O7l/rkUOG6IfNzeHRzY=;
  b=UfGCuuaMit6VEGk1+qNl36nW9mt/nnZhd+FKeNNNuf/FWl+TAx/Fvh0k
   s3QnI8c4l59XIbCKftfivBW6ds3SQbXqfcovKNR0mpoWp2wiFL6wd1z+D
   8EspGZtHc30F/cP2I8hk/mwyFH4T2Gu9Td3ECT0RECC1tBU9YTwmdMv/F
   lRsRT1TvTO9MqXFDisl/BgxdVHSXOiWm/xfW9/2+MB/7j1B6n7ENG/V2J
   MdIj0poejk+IvVhoumetvPCAatLj6f9vx8nErseEAoEkBRx72aqTwrCo6
   2zntPlIisodCe9msxufEoGEEQRpHM5smrCKyLNxxyBkwiU95a5fLYv0Bl
   A==;
X-CSE-ConnectionGUID: Z9CpoZbqTjuZ4uWlDNQNeQ==
X-CSE-MsgGUID: AyX66Op+Rk2IpR8cnQtxRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52183033"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52183033"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 11:29:47 -0800
X-CSE-ConnectionGUID: arUhFe+LQByrjdFsDbdoAg==
X-CSE-MsgGUID: 4EQ0QxjcRaqQhB5tzwEZcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="115344060"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa010.fm.intel.com with ESMTP; 19 Feb 2025 10:49:34 -0800
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
Subject: [PATCH v3 11/15] x86/cpu/intel: Fix fast string initialization for extended Families
Date: Wed, 19 Feb 2025 18:41:29 +0000
Message-ID: <20250219184133.816753-12-sohil.mehta@intel.com>
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

X86_FEATURE_REP_GOOD is a linux defined feature flag to track whether
fast string operations should be used for copy_page(). It is also used
as a second alternative for clear_page() if enhanced fast string
operations (ERMS) are not available.

X86_FEATURE_ERMS is an Intel-specific hardware-defined feature flag that
tracks hardware support for Enhanced Fast strings.  It is used to track
whether Fast strings should be used for similar memory copy and memory
clearing operations.

On top of these, there is a FAST_STRING enable bit in the
IA32_MISC_ENABLE MSR. It is typically controlled by the BIOS to provide
a hint to the hardware and the OS on whether fast string operations are
preferred.

commit 161ec53c702c ("x86, mem, intel: Initialize Enhanced REP
MOVSB/STOSB") introduced a mechanism to honor the BIOS preference for
fast string operations and clear the above feature flags if needed.
Unfortunately, the current initialization code for Intel to set and
clear these bits is confusing at best and likely incorrect.

X86_FEATURE_REP_GOOD is cleared in early_init_intel() if
MISC_ENABLE.FAST_STRING is 0. But it gets set later on unconditionally
for all Family 6 processors in init_intel(). This not only overrides the
BIOS preference but also contradicts the earlier check.

Fix this by combining the related checks and always relying on the BIOS
provided preference for fast string operations. This simplification
makes sure the upcoming Intel Family 18 and 19 models are covered as
well.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v3: Combine the REP_GOOD checks to one place.
    Improve code comments.

v2: Separate out the REP_GOOD (copy page) specific change into a
    separate commit.
---
 arch/x86/kernel/cpu/intel.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 48aad9bcf300..fc68561d9f92 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -298,12 +298,19 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 		clear_cpu_cap(c, X86_FEATURE_PAT);
 
 	/*
-	 * If fast string is not enabled in IA32_MISC_ENABLE for any reason,
-	 * clear the fast string and enhanced fast string CPU capabilities.
+	 * Modern CPUs are generally expected to have a sane fast string
+	 * implementation. However, BIOSes typically have a knob to tweak
+	 * the architectural MISC_ENABLE.FAST_STRING enable bit.
+	 *
+	 * Adhere to the preference and program the linux-defined fast
+	 * string flag and enhanced fast string capabilities accordingly.
 	 */
-	if (c->x86 > 6 || (c->x86 == 6 && c->x86_model >= 0xd)) {
+	if (c->x86_vfm >= INTEL_PENTIUM_M_DOTHAN) {
 		rdmsrl(MSR_IA32_MISC_ENABLE, misc_enable);
-		if (!(misc_enable & MSR_IA32_MISC_ENABLE_FAST_STRING)) {
+		if (misc_enable & MSR_IA32_MISC_ENABLE_FAST_STRING) {
+			/* X86_FEATURE_ERMS is set based on CPUID */
+			set_cpu_cap(c, X86_FEATURE_REP_GOOD);
+		} else {
 			pr_info("Disabled fast string operations\n");
 			setup_clear_cpu_cap(X86_FEATURE_REP_GOOD);
 			setup_clear_cpu_cap(X86_FEATURE_ERMS);
@@ -554,8 +561,6 @@ static void init_intel(struct cpuinfo_x86 *c)
 #ifdef CONFIG_X86_64
 	if (c->x86 == 15)
 		c->x86_cache_alignment = c->x86_clflush_size * 2;
-	if (c->x86 == 6)
-		set_cpu_cap(c, X86_FEATURE_REP_GOOD);
 #else
 	/*
 	 * Names for the Pentium II/Celeron processors
-- 
2.43.0


