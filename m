Return-Path: <linux-acpi+bounces-11035-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8E4A315A5
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 20:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A04E168D88
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 19:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B7A26389E;
	Tue, 11 Feb 2025 19:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E1Og/kLG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19887261588;
	Tue, 11 Feb 2025 19:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303193; cv=none; b=nHk3jfk5qsOhqsXqF9Qdu58XPXhW/UCtCCGTV5u3J3lqM5LFyQm9TsUoJWN44zb+PFSbjfMxNDFYGy5ipmLlqP7vM3p0jRdw3SA2XzK3Gml4ICDwdjy6T4Qcqfp1HBDJYetH8a8oH50WyVUDp+b5Duf0nMuMbWSJKwRUkXIQdIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303193; c=relaxed/simple;
	bh=nC7bhGMaf/cKm6gQcQiTLScmrM7KGmQ7WwLO4mYu2Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOlg0MkFFEEDkzIntstbOLoQsqX7LCI2MuAXnSoqHDRkI409HsMQqmpsS/uOCrAZbstYZuFcpC8KaQD0Eroh2PaEOiylVqx5yaEw1J+9xd9Mp9GyteHTqEdThbKL+uamowdZQ4R1qEkOmVm+UJ4+wQcGVVi41rTrVqLlKBDUFQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E1Og/kLG; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739303192; x=1770839192;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nC7bhGMaf/cKm6gQcQiTLScmrM7KGmQ7WwLO4mYu2Zk=;
  b=E1Og/kLGJWu/1xpLXjyB9Gc3NWltoHbXAHFkB+hMAKNZSDBSizxWLLAU
   SRb3nh7gXPfZQ2w6IVbWUCm6HmOPxo0md/fUiFbkjQmpi7NWM9+KeiROt
   fMYcP/W9mfloSmDCe4A/gVsVwzO+Y1gw89oeUa8Z/9jx0b2uTroMA13Ow
   rxmTXi8g2CxP8a7T0uTkrf+yXj7rDkPu0iG6gAnIppiOi9aJd6sSEzQMS
   CZB6VSCd+RPLdzuLuxucyAR89g5lmCYg/X9Ga7qW/HalazdXOP6ofyr4B
   8hZh2IQ5J91yHJgYZNbCXze/ty7YICuVk/QripOAKwZ926PGCJzKH7VcI
   Q==;
X-CSE-ConnectionGUID: t62t181eTP2nP46rSaONuQ==
X-CSE-MsgGUID: Rv7cvOWLTGOAok+66DHj2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39854820"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39854820"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 11:46:30 -0800
X-CSE-ConnectionGUID: ycPs8KnhRAmT/bNZJEyQ7g==
X-CSE-MsgGUID: cXiz9gCNQWKtAsEe8dKYEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="143519262"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa001.fm.intel.com with ESMTP; 11 Feb 2025 11:46:29 -0800
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
Subject: [PATCH v2 03/17] x86/apic: Fix 32-bit APIC initialization for extended Intel Families
Date: Tue, 11 Feb 2025 19:43:53 +0000
Message-ID: <20250211194407.2577252-4-sohil.mehta@intel.com>
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

APIC detection is currently limited to a few specific Families and will
not match the upcoming Families >=18.

Extend the check to include all Families 6 or greater. Also convert it
to a VFM check to make it simpler.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
---

v2: Update commit message to make it more precise

---
 arch/x86/kernel/apic/apic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index e893dc6f11c1..4d99bd65faf5 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2014,8 +2014,8 @@ static bool __init detect_init_APIC(void)
 	case X86_VENDOR_HYGON:
 		break;
 	case X86_VENDOR_INTEL:
-		if (boot_cpu_data.x86 == 6 || boot_cpu_data.x86 == 15 ||
-		    (boot_cpu_data.x86 == 5 && boot_cpu_has(X86_FEATURE_APIC)))
+		if ((boot_cpu_data.x86 == 5 && boot_cpu_has(X86_FEATURE_APIC)) ||
+		    boot_cpu_data.x86_vfm >= INTEL_PENTIUM_PRO)
 			break;
 		goto no_apic;
 	default:
-- 
2.43.0


