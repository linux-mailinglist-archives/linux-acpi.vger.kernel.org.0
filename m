Return-Path: <linux-acpi+bounces-10222-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C8A9F9C12
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 22:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1147A16DCE1
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 21:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17011228377;
	Fri, 20 Dec 2024 21:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="che1XCwC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96220225A57;
	Fri, 20 Dec 2024 21:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734730760; cv=none; b=fNHSX2DJi1tuxaKMSCSmlAWUCelTxGFUfGvd8K/ujRSHpqnfZqcdZzXMfx3f1KBEu7rcMcop4PU83s1VK8WY0Gb4CZCxrDmz+1x7OP1Ls/ULy/GLt8S9XqerKon2SiJh7iJhZq1OsO6O6kvQEnOZ/NT0WSqMKqGyaKY9zWsbap8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734730760; c=relaxed/simple;
	bh=zlu3Ip1J4PfGkdJP4zJ6MYrEEsH5WCqwL0qdutLDhUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EbjJ8RjoSEv3Eb8rbgnV1FSnYnjs2z2x7QCpu4jker/UM1DeTuQ6C7WTwUk5pI+9lxIa5pD10uoSo9iZ7NpZCtEGa2KvL8a7Dr/jPWZSpPhxcCHNHx2b7xTGemOC2EujUEsWH36t2GZYVwCqe5biCpvCl726+Bv8KaPGwPy92iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=che1XCwC; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734730758; x=1766266758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zlu3Ip1J4PfGkdJP4zJ6MYrEEsH5WCqwL0qdutLDhUo=;
  b=che1XCwC6MvyYphi+H1F0Y70UYHsdqgrcNr9UT/AdprCduXQadH0r0jo
   b0pCeiGCNP6p/TOlYmOXF9J3W2GnmMry5OIeV6mtrQ7nAsd6ZnEMB0+JF
   SweoObGh9JUJQaNmTi5RsKn/wNLcsrSyi+p/4btpHuLqwV/kDR7ybMz73
   HRcu1pD0JL5guLMEE3aS6+zbKaSJC/1SlcVv3wxb4Vhjr/m+4J/qPPcuD
   0TImydIdO74P5szgB5V2h+nGBRJVY5C1rcAS+QX7dMnQCtd80L2Xwtt7Y
   uHb2cn5/FGu2ikmxzA0u2x9Ok2iwZIrU80kLVafEBuEHqnvzgIEZwtU7C
   w==;
X-CSE-ConnectionGUID: /EX6ApY2RmW09pwsHqbFXA==
X-CSE-MsgGUID: Gv4umYfqRKynrJmp0PP9bw==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="39070641"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="39070641"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 13:39:16 -0800
X-CSE-ConnectionGUID: dovdIZ7DRoqSmQdYZHY7vw==
X-CSE-MsgGUID: w44AezdmQPOCd8GqUYY73w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103223835"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa005.fm.intel.com with ESMTP; 20 Dec 2024 13:39:15 -0800
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
Subject: [RFC PATCH 03/15] x86/cpu/intel: Fix init_intel() checks for extended family numbers
Date: Fri, 20 Dec 2024 21:36:58 +0000
Message-ID: <20241220213711.1892696-4-sohil.mehta@intel.com>
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

X86_FEATURE_REP_GOOD is only set for family 6 processors.  Extend the
check to family numbers beyond 15.

It is uncertain whether the Pentium 4s (family 15) should set the
feature flag as well. Commit 185f3b9da24c ("x86: make intel.c have
64-bit support code") that originally set X86_FEATURE_REP_GOOD also set
the x86_cache_alignment preference for family 15 processors. The
omission of the family 15 seems intentional.

Also, the 32-bit user copy alignment preference is only set for family 6
and 15 processors. Extend the preference to family numbers beyond 15.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/kernel/cpu/intel.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 8ded9f859a3a..f44b2e618fb3 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -449,23 +449,16 @@ static void intel_workarounds(struct cpuinfo_x86 *c)
 	    (c->x86_stepping < 0x6 || c->x86_stepping == 0xb))
 		set_cpu_bug(c, X86_BUG_11AP);
 
-
 #ifdef CONFIG_X86_INTEL_USERCOPY
 	/*
 	 * Set up the preferred alignment for movsl bulk memory moves
+	 * Family 4 - 486: untested
+	 * Family 5 - Pentium: untested
+	 * Family 6 - PII/PIII only like movsl with 8-byte alignment
+	 * Family 15 - P4 is OK down to 8-byte alignment
 	 */
-	switch (c->x86) {
-	case 4:		/* 486: untested */
-		break;
-	case 5:		/* Old Pentia: untested */
-		break;
-	case 6:		/* PII/PIII only like movsl with 8-byte alignment */
-		movsl_mask.mask = 7;
-		break;
-	case 15:	/* P4 is OK down to 8-byte alignment */
+	if (c->x86_vfm >= INTEL_PENTIUM_PRO)
 		movsl_mask.mask = 7;
-		break;
-	}
 #endif
 
 	intel_smp_check(c);
@@ -563,7 +556,7 @@ static void init_intel(struct cpuinfo_x86 *c)
 #ifdef CONFIG_X86_64
 	if (c->x86 == 15)
 		c->x86_cache_alignment = c->x86_clflush_size * 2;
-	if (c->x86 == 6)
+	if (c->x86 == 6 || c->x86 > 15)
 		set_cpu_cap(c, X86_FEATURE_REP_GOOD);
 #else
 	/*
-- 
2.43.0


