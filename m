Return-Path: <linux-acpi+bounces-11303-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 733B8A3C897
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 20:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EABB1757F5
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 19:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C760422ACDA;
	Wed, 19 Feb 2025 19:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QkeHyHxq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AFD22ACD3;
	Wed, 19 Feb 2025 19:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739993295; cv=none; b=bzakNKuVOpEmkup1JNp3fe7AbZmrRw0JU3cF5+l7Ka/CPKH2yvuhNndMOT5aKPTLtrv7R7FICQaD7d9YoVdEoB1qiml2yCATUfudBTu+8JCPHsmNVSvYHf3zRxO9xHpTIN0QlTd6rNbRPky7r/sdoW4Hw4FjKTzjm3RdCYKkKXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739993295; c=relaxed/simple;
	bh=GFfGVKb+6rQlP2ieo37lV1hk+auSeCSnZwEleBMmL24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oR/e77X129F3CBcsqmxksSX+zXbGpNttDQZW7TTVSRxT826RC7xBnfLLhxysJ+baiVKdv87W43YnXbAZw09RJ5HHCVjEFAo3zES71yIo34lsW2oZLr9QAPqih2BhZotM2LjiRih9rfWLiWJinhPrAkLBsAgsNNd9VtdT7W4z4Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QkeHyHxq; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739993294; x=1771529294;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GFfGVKb+6rQlP2ieo37lV1hk+auSeCSnZwEleBMmL24=;
  b=QkeHyHxq49FzB4WaGQtIgGh5firEejFLPxu94nNsbA1sp0pTZ5HzykH+
   AfpPAv0gVsRGcs3E7wYGFd+6SY9yWfMLRFC4qYw7hSTs3Ahwc/gPMyyZo
   pWWyq622Zd7lIRrt0OUBprN8AaUYDrVuQ6O1onKYQFE2uG/yLxmeXYpvS
   5AyxmxXLhL32i5E1JqLTP33fV3Amc1qE4T735JaNrkV9pg3BXP70PQBo3
   8y0bOFQyLC9BwCeJJSFpd60JhGami2PFHbT4i/soJLruoUlySnFw34pC2
   GKaVVKdg8lcQaZLtnhtZHFGGj2HJ2p2xf/P6Gop4ekle4/rG1Vd2LDpGL
   w==;
X-CSE-ConnectionGUID: FmThzyNpRiSBDuAGHnc5yQ==
X-CSE-MsgGUID: iFyyG/NNQPWhrj+t8s8d8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52182712"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52182712"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 11:28:13 -0800
X-CSE-ConnectionGUID: I3yiiJAiRh6BMNeDQiaZMw==
X-CSE-MsgGUID: yO8bzx7MSqO+nkaADoxAMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="115343992"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa010.fm.intel.com with ESMTP; 19 Feb 2025 10:43:55 -0800
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
Subject: [PATCH v3 00/15]  Prepare for new Intel Family numbers
Date: Wed, 19 Feb 2025 18:41:18 +0000
Message-ID: <20250219184133.816753-1-sohil.mehta@intel.com>
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
This series is an audit of all the arch/x86 Intel Family-model checks to get
ready for the upcoming Family 18 and 19 models. It also converts the last
reamaining Intel x86_model checks to VFM ones.

Patch 1-8 : Include Dave Hansen's Acked-by.
Patch 9-15: Almost ready to merge but don't have review tags yet.

---v3 changes---
* Reordered the patches and moved the Acked ones to the front since they are
  likely to get applied sooner.
* Patches 11 and 14 have a slightly different approach now. 
* Improved commit messages overall.
* Dropped the drivers/ fixes. Will post them separately.

---Previous versions---
Refer the v2 cover letter for more background.

v2: https://lore.kernel.org/lkml/20250211194407.2577252-1-sohil.mehta@intel.com/
RFC-v1: https://lore.kernel.org/lkml/20241220213711.1892696-1-sohil.mehta@intel.com/

Sohil Mehta (15):
  x86/apic: Fix 32-bit APIC initialization for extended Intel Families
  x86/cpu/intel: Fix the movsl alignment preference for extended
    Families
  x86/microcode: Update the Intel processor flag scan check
  x86/mtrr: Modify a x86_model check to an Intel VFM check
  x86/cpu/intel: Replace early Family 6 checks with VFM ones
  x86/cpu/intel: Replace Family 15 checks with VFM ones
  x86/cpu/intel: Replace Family 5 model checks with VFM ones
  x86/acpi/cstate: Improve Intel Family model checks
  x86/smpboot: Remove confusing quirk usage in INIT delay
  x86/smpboot: Fix INIT delay assignment for extended Intel Families
  x86/cpu/intel: Fix fast string initialization for extended Families
  x86/pat: Replace Intel x86_model checks with VFM ones
  x86/cpu/intel: Bound the non-architectural constant_tsc model checks
  perf/x86: Simplify Intel PMU initialization
  perf/x86/p4: Replace Pentium 4 model checks with VFM ones

 arch/x86/events/intel/core.c          | 16 ++++--
 arch/x86/events/intel/p4.c            |  7 +--
 arch/x86/events/intel/p6.c            | 26 ++--------
 arch/x86/include/asm/intel-family.h   | 21 +++++++-
 arch/x86/kernel/acpi/cstate.c         |  8 +--
 arch/x86/kernel/apic/apic.c           |  4 +-
 arch/x86/kernel/cpu/intel.c           | 74 +++++++++++++--------------
 arch/x86/kernel/cpu/microcode/intel.c |  2 +-
 arch/x86/kernel/cpu/mtrr/generic.c    |  4 +-
 arch/x86/kernel/smpboot.c             | 17 +++---
 arch/x86/mm/pat/memtype.c             |  6 +--
 11 files changed, 93 insertions(+), 92 deletions(-)

-- 
2.43.0


