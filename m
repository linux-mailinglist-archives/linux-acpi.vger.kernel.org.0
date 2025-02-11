Return-Path: <linux-acpi+bounces-11032-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C76A3159A
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 20:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3CE18820ED
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 19:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00781E47B3;
	Tue, 11 Feb 2025 19:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AevZ0nYj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD5026E659;
	Tue, 11 Feb 2025 19:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303191; cv=none; b=jp4FcELdNyTIiY1lSU1vafC1WuPhlE+rgWRpic2xcC1rA2IuHBuAhbPka3CZJdK1wjmR4hgTznbkeDX/4gijLNgLy6Vvp7KZeBzucp4PXR0KxexXFKVn3O/eFa+fh4b0p4IPNYHYhGDNnDk3hbQItnWQaB4blpicVoLAy580sKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303191; c=relaxed/simple;
	bh=aWJmVmjzQS1ECgDv7o5K7l5ZvaKWihh1ZJL/R6XH5jg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EEgUK4LrbTFoKWejZuSLDFo1oDrTB7fOVMSjrydLd2vorUpzsdteKxeHwFNcrmt7fqwituUkWud2Kx1f9/SdbZyQguBEOjp6fVr/tesP+UXDzt6Xxkkkd80TdOvKiFA7vOpgLEXHa0koWKdv9Tpoi2uemjGpljA/6MlAnyf86rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AevZ0nYj; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739303190; x=1770839190;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aWJmVmjzQS1ECgDv7o5K7l5ZvaKWihh1ZJL/R6XH5jg=;
  b=AevZ0nYjztvteMVPXD518bWrNF/gAu2h//H8vPpssCZmKKrwWxxrio9p
   YQutxNY+Ke3k5LaTI9UW/Sag1A6uDShSgCUq7BzbqrPcG6DPZKUn3Ny0e
   mGc2V378lldc5jaMuIT+k/+gjWv5gV5nxrkpN14dVys9tfpNEK3HfA/CV
   Lv6o0AH6FAwfnkMEwiD39DnafckKAm/Ys68MZUJp2ggsyMR371BSTc5Om
   L6Rg2EQ1aHP5L+4H7XvAljOTS3rDAdUHpTAAIavovXid8FMiRtKa4ycSL
   XvN6I50ynj4iXJe0RdJu62GU2w4m/9K4M9hnBc5n5LHGYoVVmfKrxNhwa
   g==;
X-CSE-ConnectionGUID: t8hiI62hSYCCAYDgtiiMJA==
X-CSE-MsgGUID: CeA2CeQCR0mQ7/UpcceIIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39854775"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39854775"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 11:46:28 -0800
X-CSE-ConnectionGUID: XEK8Je+8TkqjxwyZGopdEQ==
X-CSE-MsgGUID: jJz7N6gTQvO9f5ZKmLwwsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="143519247"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa001.fm.intel.com with ESMTP; 11 Feb 2025 11:46:27 -0800
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
Subject: [PATCH v2 00/17] Prepare for new Intel Family numbers
Date: Tue, 11 Feb 2025 19:43:50 +0000
Message-ID: <20250211194407.2577252-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---Summary---
Mainstream Intel processors have been using Family 6 for a couple of decades.
Audit all the Intel Family-model checks to get ready for the upcoming Family 18
and 19 models.

Patch 1: Preparatory cleanup in smpboot.
Patch 2-7: Fixes in arch/x86 and drivers.
Patch 8-17: Cleanups in arch/x86 to convert x86_model checks to VFM ones.

This series does not include cleanups in drivers/.

Please feel free to pick up whichever patches seem ready. Most of the patches
can be applied out of order except patches 1 and 2 which should be applied
together.

---v2 changes---

* Improve commit messages.
* Split and reorder patches for better readability.
* Added a cleanup patch in the beginning.

RFC-v1: https://lore.kernel.org/lkml/20241220213711.1892696-1-sohil.mehta@intel.com/

---Background---
The last mainstream Intel processors that deviated from Family 6 were the
Netburst architecture based Pentium 4s that had a Family number of 15. Intel
has recently started to introduce extended Family numbers greater than 15, as
seen in commit d1fb034b75a8 ("x86/cpu: Add two Intel CPU model numbers").
Though newer CPUs can have any Family number, the currently planned CPUs lie in
Families 18 and 19.

Some kernel code assumes that the Family number would always remain 6.  There
are checks that apply to recent Family 6 models such as Lunar Lake and
Clearwater Forest but don't automatically extend to Family 19 models such as
Diamond Rapids. This series aims to fix and cleanup all of such Intel specific
checks (mainly in arch/x86) to avoid such issues in the future. It also
converts almost all of the x86_model checks in arch/x86 to the new VFM ones.

OTOH, x86_model usage in drivers/ is a huge mess. Some drivers might need to be
completely rewritten to make them future-proof. I have attempted a couple of
fixes in cpufreq and hwmon, but they are mostly superficial.  A more thorough
clean up of drivers is needed to replace all x86_model usage with the new VFM
checks.

---Assumptions and Trade-offs---
Newer CPUs will have model numbers only in Family 6 or after Family 15.  No new
processors would be added between Family 6 and 15.

As a convention, Intel Family numbers are referenced using decimals (Family 15,
19, etc.) even though the AMD-specific code might prefer hexadecimals in
similar situations.

It would be preferable to have simpler and more maintainable checks that might
in a rare situation change the behavior on really old platforms. If someone
pops up with an issue, the code would be fixed later.
For example, the check,
	c->x86_vfm >= INTEL_PENTIUM_PRO
is preferred over,
	c->x86 == 6 || c->x86 > 15
if the likelihood of adversely affecting Family 15 is low.

Also, the CPU defines in intel-family.h have been added as and when needed to
make reviewing and applying patches out of order easier.

Sohil Mehta (17):
  x86/smpboot: Remove confusing quirk usage in INIT delay
  x86/smpboot: Fix INIT delay optimization for extended Intel Families
  x86/apic: Fix 32-bit APIC initialization for extended Intel Families
  x86/cpu/intel: Fix the movsl alignment preference for extended
    Families
  x86/cpu/intel: Fix page copy performance for extended Families
  cpufreq: Fix the efficient idle check for Intel extended Families
  hwmon: Fix Intel Family-model checks to include extended Families
  x86/microcode: Update the Intel processor flag scan check
  x86/mtrr: Modify a x86_model check to an Intel VFM check
  x86/cpu/intel: Replace early Family 6 checks with VFM ones
  x86/cpu/intel: Replace Family 15 checks with VFM ones
  x86/cpu/intel: Replace Family 5 model checks with VFM ones
  x86/pat: Replace Intel x86_model checks with VFM ones
  x86/acpi/cstate: Improve Intel Family model checks
  x86/cpu/intel: Bound the non-architectural constant_tsc model checks
  perf/x86: Simplify P6 PMU initialization
  perf/x86/p4: Replace Pentium 4 model checks with VFM ones

 arch/x86/events/intel/p4.c            |  7 +--
 arch/x86/events/intel/p6.c            | 28 +++--------
 arch/x86/include/asm/intel-family.h   | 21 ++++++++-
 arch/x86/kernel/acpi/cstate.c         |  8 ++--
 arch/x86/kernel/apic/apic.c           |  4 +-
 arch/x86/kernel/cpu/intel.c           | 68 +++++++++++++--------------
 arch/x86/kernel/cpu/microcode/intel.c |  2 +-
 arch/x86/kernel/cpu/mtrr/generic.c    |  4 +-
 arch/x86/kernel/smpboot.c             | 17 ++++---
 arch/x86/mm/pat/memtype.c             |  7 +--
 drivers/cpufreq/cpufreq_ondemand.c    | 15 +++---
 drivers/hwmon/coretemp.c              | 26 ++++++----
 12 files changed, 111 insertions(+), 96 deletions(-)

-- 
2.43.0


