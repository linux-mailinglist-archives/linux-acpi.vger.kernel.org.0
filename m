Return-Path: <linux-acpi+bounces-11037-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71953A315AC
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 20:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0C501884F15
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 19:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979CF26461D;
	Tue, 11 Feb 2025 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B+grnBHm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99A9263880;
	Tue, 11 Feb 2025 19:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303195; cv=none; b=GhKdyAvA1JSnDEAHR1IL6NEi10yQl8Z2NqP8HxNfRoRNbZed9+jMwjW8iVH7IPvF3N5K3oaxJUNWyxaH9783CY9+5CFUK9eDDXWRdgZjT4a0xZ0CIicsDWSzfbrbXYKmp7lTwz9O8FKndCzfE7wdcNi+O1D4tNMelws8pwTBDGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303195; c=relaxed/simple;
	bh=PTWFvN/AlaLI/WFK2WrvrVLqOWDpjLMalpJ7CzdW408=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K41MCalgrRhLvi/WIV0jZva/KGz2fesAhY7jCdZsijC8tDzjv8Q925B/flxG3USWLIxIHGuYR84cpDPswacbSKkCuSHJiSs1SYQ8nSO3LwMtBhumlw6UPc4xPGl9Lc9V0pdnt/zdge4aM8EnIN4GpBOBC+Cp8NNXKtmXLe0yljI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B+grnBHm; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739303194; x=1770839194;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PTWFvN/AlaLI/WFK2WrvrVLqOWDpjLMalpJ7CzdW408=;
  b=B+grnBHmarmkUUcuiUPFdJv0Y52RsYpefXYfEG3f6Flgmi8/vGqDQIQL
   E2JjHJRfW6qbnLqmvPP1vYJs1goFhMFkb6p/eiyGgkyFQne/UXN7Nu+XV
   u+9vdp4ksBsEXlrY9GXU2IYAnKDuS9cDNc+UEWUsZQg0z3Es6YBV2eZt1
   L21kMMxeWxx3JtpguM4zgcYIk/vMx78wOECTEuT+/fBUcdRlkfDUrt5yo
   3vPMk825ZysvWF86Nwe+SasWEV4HUhuZ63EQd/nhF+/PGg6zt55aXRLKe
   UUwgDVjBjHT0AB0y5QVRO1sBqFOQS86btEjXXbbcQTEGWFwR9mlCY9AOC
   A==;
X-CSE-ConnectionGUID: ORYNFRUaSM+lDu7ob/S8yg==
X-CSE-MsgGUID: zW3zVuQcQG645sEuvLiCgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39854857"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39854857"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 11:46:31 -0800
X-CSE-ConnectionGUID: fNiW41TJQh2Mi0h/1SD10A==
X-CSE-MsgGUID: oWRURfaFSPy9KAYXjwLl8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="143519269"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa001.fm.intel.com with ESMTP; 11 Feb 2025 11:46:31 -0800
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
Subject: [PATCH v2 05/17] x86/cpu/intel: Fix page copy performance for extended Families
Date: Tue, 11 Feb 2025 19:43:55 +0000
Message-ID: <20250211194407.2577252-6-sohil.mehta@intel.com>
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

X86_FEATURE_REP_GOOD is a linux defined feature flag to track whether
fast string operations should be used for copy_page(). It is also used
as a backup alternative for clear_page() if enhanced fast string
operations (ERMS) are not available.

Currently, the flag is only set for Family 6 processors. Extend the
check to include upcoming processors in Family 18 and 19.

It is uncertain whether X86_FEATURE_REP_GOOD should be set for Family 15
(Pentium 4) as well. Commit 185f3b9da24c ("x86: make intel.c have 64-bit
support code") that originally set the flag also set the
x86_cache_alignment preference for Family 15 processors in the same
commit. The omission of the Family 15 may have been intentional.

Also, move the check before a related check in early_init_intel() to
avoid resetting the flag.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>

---

v2: Separate out the REP_GOOD (copy page) specific change into a
separate commit.

From the archives, it wasn't exactly clear why the set_cpu_cap() and
clear_cpu_cap() calls for X86_FEATURE_REP_GOOD are in distinct
locations. Also, why there is a difference between 32-bit and 64-bit.
Any insight there would be useful. For now, I have kept the change
minimal based on my limited understanding.

---
 arch/x86/kernel/cpu/intel.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index e5f34a90963e..4f8b02cbe8c5 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -297,6 +297,14 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	    c->x86_vfm <= INTEL_CORE_YONAH)
 		clear_cpu_cap(c, X86_FEATURE_PAT);
 
+	/*
+	 * Modern CPUs are generally expected to have a sane fast string
+	 * implementation. However, the BIOS may disable it on certain CPUs
+	 * via the architectural FAST_STRING bit.
+	 */
+	if (IS_ENABLED(CONFIG_X86_64) && (c->x86 == 6 || c->x86 > 15))
+		set_cpu_cap(c, X86_FEATURE_REP_GOOD);
+
 	/*
 	 * If fast string is not enabled in IA32_MISC_ENABLE for any reason,
 	 * clear the fast string and enhanced fast string CPU capabilities.
@@ -556,8 +564,6 @@ static void init_intel(struct cpuinfo_x86 *c)
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


