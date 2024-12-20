Return-Path: <linux-acpi+bounces-10219-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C38E19F9C08
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 22:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A756E188D3AB
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 21:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87891222568;
	Fri, 20 Dec 2024 21:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="etc0qJCb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0924C21B1AA;
	Fri, 20 Dec 2024 21:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734730757; cv=none; b=ejRoIWFSRXQ3FxAoFXf0o/buc7sZVRkLT9Dc+kCKlsUo6POXC1+8R2p1lnrZjHDanafWBmSxbVcI/kUUs3+ozMzp05Xr1ulEVtGeIQSwPHNXXabJmUSKH5d2zjQHmuw7+9gAu10XR4z9CTmrKvBaT9oAUcw5wmY6Ocw5KrOTgpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734730757; c=relaxed/simple;
	bh=ljLmLUYUgAtyG8G99rXQ56EnVq57jHlL/48SlXuyQx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L45coFB73dIVB9/ubllCuzdvMyN3z2oenLn4oHEEkyrzYWxPlfWZ+hTPngFTJ/GAKsnxmdhug/ZgnKKSsgcPFo5iR9kH/OM1R1kBFU3BJev9YpLK9bBAGXfuMaVzFvHVi6M68cN/361bAYib2kBI+N3GOllD0dZOB5ejrPOw7fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=etc0qJCb; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734730755; x=1766266755;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ljLmLUYUgAtyG8G99rXQ56EnVq57jHlL/48SlXuyQx8=;
  b=etc0qJCbM07ulH1SckiQd3qdHh7yEzS3lZ56NJI3kh66Mb9YcFfrNSyV
   UZ7USRJoUB+y//5BkkWetrYb9WyCV4mUMT5VJfnCImSc/3h64gogCrPRU
   oQJejHGkozBMx8UJS/eYZ2NDlq1WWtEvaWDCjUpCE5mxlF9FLFB4i2ozO
   fwYInB+LHUmv+/xNhnBnY8h2HnWDke7iQBLOzeXHX63jqHgtiny5WbIy5
   7kFDUbjaJSDRyqD1eBSsx1RVwqUBdA1Al7x+DpyC4CdJpQAS9/F0Bt/Pq
   eLuXvZd4D5jxJNJNgfXVkWSySWev/JmCzg0tcefzUr6WjECDWGDuZX3/m
   g==;
X-CSE-ConnectionGUID: dT1itH73TceykF5ctGYo4Q==
X-CSE-MsgGUID: HbrG41DnS2CZd7Jvk2/AIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="39070605"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="39070605"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 13:39:15 -0800
X-CSE-ConnectionGUID: zGmtfSqqRfet1r1cH5PXsA==
X-CSE-MsgGUID: k6lZbLLKSDqRmHNbYha0jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103223822"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa005.fm.intel.com with ESMTP; 20 Dec 2024 13:39:13 -0800
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
Subject: [RFC PATCH 00/15]  Prepare for new Intel family models
Date: Fri, 20 Dec 2024 21:36:55 +0000
Message-ID: <20241220213711.1892696-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---Tl;Dr---
Audit all the Intel family model checks to get ready for the upcoming family 18
and 19 models.
Patches 1-5: Fixes in arch/x86 and drivers
Patches 6-15: Cleanups in arch/x86 to convert x86_model checks to VFM ones.

This series does not include cleanups in drivers/

---Background---
Mainstream Intel processors have been using family number 6 for a couple of
decades. The last deviation from this were the Netburst architecture based
Pentium 4s that had a family number of 15. Intel has recently started to
introduce extended family numbers greater than 15 [1]. Though newer CPUs can
have any family number, the currently planned CPUs lie in families 18 and 19.

Some kernel code assumes that the family number would always remain 6.  There
are checks that apply to recent family 6 models such as Lunar Lake and
Clearwater Forest but don't automatically extend to family 19 models such as
Diamond Rapids. This series aims to fix and cleanup all of such Intel specific
checks (mainly in arch/x86) to avoid such issues in the future. It also
converts almost all of the x86_model checks in arch/x86 to the new VFM ones.

OTOH, x86_model usage in drivers/ is a huge mess. Some drivers might need to be
completely rewritten to make them future proof. I have attempted a couple of
fixes in cpufreq and hwmon but I am uncertain of their efficacy.  A more
thorough clean up of drivers is needed to replace all x86_model usage with
the new VFM checks.

---Assumptions and Trade-offs---
Newer CPUs will have model numbers only in family 6 or after family 15.  No new
processors would be added between family 6 and 15. There are a couple of
related quirks that have been described below.

As a convention, Intel family numbers are referenced using decimals (family 15,
19, etc.) even though the AMD specific code might prefer hexadecimals in
similar situations.

It would be preferable to have simpler and more maintainable checks that might
in a rare situation change the behavior on really old platforms. If someone
pops up with an issue, the code would be fixed later.
For example, the check,
	c->x86_vfm >= INTEL_PENTIUM_PRO
is preferred over,
	c->x86 == 6 || c->x86 > 15
if the likelihood of adversely affecting family 15 is low.

Also, the CPU defines in intel-family.h have been added as and when needed to
make reviewing and applying patches out of order easier. Please let me know if
it would be preferable to add all the defines in a single patch at the
beginning.

---Noteworthy quirks---
Pentium II Overdrive - A unique family number:
  Wikipedia says[2], In Intel's "Family/Model/Stepping" scheme, the Pentium II
  OverDrive CPU identifies itself as family 6, model 3, though this is 
  misleading, as it is not based on the family 6/model 3 Klamath core. As 
  mentioned in the Pentium II Processor update documentation from Intel, 
  "although this processor has a CPUID of 163xh, it uses a Pentium II processor 
  CPUID 065xh processor core."

  A dump of the microcode file 06-03-02 shows:
    001/001: sig 0x00001632, pf_mask 0x00, 1998-06-10, rev 0x0002, size 2048
  An archived CPUID dump [3] also says:
    CPUID 00000001: 00001632-00000000-00000000-0183FBFF

  That would translate to a family number of 22 (0x16). This aberration is 
  not explicitly handled anywhere in the kernel so the platform might already 
  be broken. This series might make it worse for the platform if the latest 
  kernel works on it by chance.

Xeon Phi coprocessors:
  The first couple of Knights line of products (Knights Ferry and Knights
  Corner) have a family number of 11. But they were released purely as
  coprocessors and would not directly boot mainline Linux. The later
  versions Knights Landing and Knights Mill could act as a host processor
  but they used family number 6. So, the changes in this series should not
  affect any of these platforms.

---Links---
[1]: commit d1fb034b75a8 ("x86/cpu: Add two Intel CPU model numbers")
[2]: https://en.wikipedia.org/wiki/Pentium_II#Pentium_II_OverDrive
[3]: https://github.com/InstLatx64/InstLatx64/blob/master/GenuineIntel/GenuineIntel0000632_P2OD_CPUID.txt

The series has only been lightly tested on a couple of family 6 systems.
Planning to test it on more systems in the future. Any testing on legacy
platforms would be greatly helpful.

Many thanks to Tony and Dave for guiding me through this historical maze.

Sohil Mehta (15):
  x86/apic: Fix 32-bit APIC initialization for extended Intel families
  x86/apic: Fix smp init delay for extended Intel families
  x86/cpu/intel: Fix init_intel() checks for extended family numbers
  cpufreq: Fix the efficient idle check for Intel extended families
  hwmon: Fix Intel family checks to include extended family numbers
  x86/microcode: Update the Intel processor flag scan check
  x86/mtrr: Modify a x86_model check to an Intel VFM check
  x86/cpu/intel: Replace early family 6 checks with VFM ones
  x86/cpu/intel: Replace family 15 checks with VFM ones
  x86/cpu/intel: Replace family 5 model checks with VFM ones
  x86/pat: Replace Intel model checks with VFM ones
  x86/acpi/cstate: Improve Intel family model checks
  x86/cpu/intel: Bound the non-architectural constant_tsc model checks
  perf/x86: Simplify p6_pmu_init()
  perf/x86/p4: Replace Pentium 4 model checks with VFM ones

 arch/x86/events/intel/p4.c            |  7 ++--
 arch/x86/events/intel/p6.c            | 28 ++++---------
 arch/x86/include/asm/intel-family.h   | 16 ++++++++
 arch/x86/kernel/acpi/cstate.c         |  8 ++--
 arch/x86/kernel/apic/apic.c           |  4 +-
 arch/x86/kernel/cpu/intel.c           | 58 ++++++++++++---------------
 arch/x86/kernel/cpu/microcode/intel.c |  3 +-
 arch/x86/kernel/cpu/mtrr/generic.c    |  4 +-
 arch/x86/kernel/smpboot.c             |  8 ++--
 arch/x86/mm/pat/memtype.c             |  7 ++--
 drivers/cpufreq/cpufreq_ondemand.c    | 13 +++---
 drivers/hwmon/coretemp.c              | 26 ++++++++----
 12 files changed, 96 insertions(+), 86 deletions(-)


base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
-- 
2.43.0


