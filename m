Return-Path: <linux-acpi+bounces-11309-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4043AA3C8A0
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 20:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15F09175F3B
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 19:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EC422DF9D;
	Wed, 19 Feb 2025 19:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U23Xch2w"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2F622D4E5;
	Wed, 19 Feb 2025 19:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739993357; cv=none; b=RwuMBehyFGicl2HQIdo7Q1VZqMVeeD09fPg1QtzDISM53w8L5PrjMq/91L5oYaJwogAyeoBVTQIe/H7WzdK/+v8njnpJQ7BiHViwq92j7VC7E7rXgXpBQU+W6OMb2Nv9wXUdDuIO5N+JGclxQhgKtI7+XSaWOVzLbSKkp6MTIg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739993357; c=relaxed/simple;
	bh=Q2SlEWad6JQXOW9tD/84aivFAQ6sDntehgRf/QmNpiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ET1ALWTgPDiWagAts2UUOkPXWYIWlIJHdcBRzVYGrYp8jK8yDT0vjSJQhyZGESUnf1s5/IPXQssVJ1IoNZ4jNHV2+r4bOCRe+9yIR90GRWYqRgnkGADmPtihUuVM3z9sMaJYI/DTjyzzwD9+GjNxwWqjznUjZfRaNtTRVD9EABg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U23Xch2w; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739993356; x=1771529356;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q2SlEWad6JQXOW9tD/84aivFAQ6sDntehgRf/QmNpiM=;
  b=U23Xch2wAh01ciRvnt4PoBzr4XB7PdgMjppWWZlWRycIbIIE/bloCi/o
   vC4GO0rz6PvLnroQij/zG+HQ5jPtkNEfi01/h30/NTqmO+g/eYetREvKe
   GeZazW5yUNXqJaunfYz4iLPgAksRhgYSzPImCkFjHawLWFwd8x4rvWcm0
   PQKzbCDhSBEQzbiywIalrRLGwBcMe9qMpbHjHhEBsKOxtSdSsE2Fkz0Kn
   m1d7EdUQXbB6xbvFqnOK0s8Q8XlApPZEd6P5z8ton/qHdylEHBrQOlwVY
   6U/wzL2Kjgko/5cApxkDK1hEkSYSFGKdBSZqz7DnzsqMlTQUDd1DU7WLC
   g==;
X-CSE-ConnectionGUID: 0ZkcgF3jT5e6tC44rIizJg==
X-CSE-MsgGUID: tKjfm11+TAaMsxoNYJLg6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52182890"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52182890"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 11:29:14 -0800
X-CSE-ConnectionGUID: sBJDlqX+TGKPgxk79ZCmxA==
X-CSE-MsgGUID: Ny3peUT9RSOCqQop5iEqyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="115344026"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa010.fm.intel.com with ESMTP; 19 Feb 2025 10:47:33 -0800
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
Subject: [PATCH v3 06/15] x86/cpu/intel: Replace Family 15 checks with VFM ones
Date: Wed, 19 Feb 2025 18:41:24 +0000
Message-ID: <20250219184133.816753-7-sohil.mehta@intel.com>
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

Introduce names for some old pentium 4 models and replace the x86_model
checks with VFM ones.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
---
v3: Picked up Dave's Ack.
v2: No change.
---
 arch/x86/include/asm/intel-family.h | 4 ++++
 arch/x86/kernel/cpu/intel.c         | 6 +++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index c1a081585fcb..f509061b8c7e 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -184,6 +184,10 @@
 /* Family 5 */
 #define INTEL_QUARK_X1000		IFM(5, 0x09) /* Quark X1000 SoC */
 
+/* Family 15 - NetBurst */
+#define INTEL_P4_WILLAMETTE		IFM(15, 0x01) /* Also Xeon Foster */
+#define INTEL_P4_PRESCOTT		IFM(15, 0x03)
+
 /* Family 19 */
 #define INTEL_PANTHERCOVE_X		IFM(19, 0x01) /* Diamond Rapids */
 
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 8e67d1ef4c73..30f3812ba62c 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -256,8 +256,8 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 #endif
 
 	/* CPUID workaround for 0F33/0F34 CPU */
-	if (c->x86 == 0xF && c->x86_model == 0x3
-	    && (c->x86_stepping == 0x3 || c->x86_stepping == 0x4))
+	if (c->x86_vfm == INTEL_P4_PRESCOTT &&
+	    (c->x86_stepping == 0x3 || c->x86_stepping == 0x4))
 		c->x86_phys_bits = 36;
 
 	/*
@@ -430,7 +430,7 @@ static void intel_workarounds(struct cpuinfo_x86 *c)
 	 * P4 Xeon erratum 037 workaround.
 	 * Hardware prefetcher may cause stale data to be loaded into the cache.
 	 */
-	if ((c->x86 == 15) && (c->x86_model == 1) && (c->x86_stepping == 1)) {
+	if (c->x86_vfm == INTEL_P4_WILLAMETTE && c->x86_stepping == 1) {
 		if (msr_set_bit(MSR_IA32_MISC_ENABLE,
 				MSR_IA32_MISC_ENABLE_PREFETCH_DISABLE_BIT) > 0) {
 			pr_info("CPU: C0 stepping P4 Xeon detected.\n");
-- 
2.43.0


