Return-Path: <linux-acpi+bounces-11036-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8E2A315AB
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 20:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 159167A00E2
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 19:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4F72641D8;
	Tue, 11 Feb 2025 19:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VOHlEdJy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A48D262D0D;
	Tue, 11 Feb 2025 19:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303194; cv=none; b=S5+PokEmt0h+/7jdeMRHhjviqJierlCu+T2sx/ih76G9lTDLzAepGX9Ef2PZbgH1Ej7ZYmdhOQxwcUjmIr5ytA2AuU8UQqMr3uX8R+W9ETH05Iz/ASLoC4Zjss9jXwUyt7BnKzI3xpcwXFyJiPy2GKMx7ECx2fjjRMQ2777uHLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303194; c=relaxed/simple;
	bh=ePwF89ZyGeQ88u1VMJmUdubzH3tE/n8QmTHiT5e0Tw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPae8zKGxTnU0ReMkiB+RbLxtwU4dEThZ3KHzU42GByhMCTj0woWQN8YZGIU1apKa1ZjUzryPb2ibbGGKy9Bc6SjL/eRO2acJNphkovzQ8ghrDMNN7IxWAT9lBcDfGbH6UGeWgjnHTIcqadQdceVydm+GeVIYDEEeX53MxYkK1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VOHlEdJy; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739303193; x=1770839193;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ePwF89ZyGeQ88u1VMJmUdubzH3tE/n8QmTHiT5e0Tw8=;
  b=VOHlEdJyxWtZzWf9syCerBYhTxGvm7IHEiup1j3jq35KlngC8EsIS490
   omS/M6IyC8AeBoXlBaRdfWcgJQVh+ZtXH2/Zm8m4AjwLKtfAMCoRrM9Lz
   rHLt7+b0x6Quupxw7l4eHNsdIFd/t5sPrfpa6Apcv9qzVKJkKGG2vBVFV
   7A6jtR+XCfrr+f/tbLeBNNcadFFjBwITv9zVWX+5bkDRLZQS6WuRdiHIX
   sFoSnhU299gS3Mt22JtSfd5/dWMhLx17OrFCO1Ga1r3gGRbPCygOvwAGG
   nVKDB4UpJ75+p+QLvNPAbTNXKvYpdheH3hQFtRoNhDNTg/JdpqriRGLTa
   g==;
X-CSE-ConnectionGUID: m6JpGQMOQa+6P7Kx6qWB2w==
X-CSE-MsgGUID: ljaZSWbdQKay9TB9eSUTOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39854839"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39854839"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 11:46:31 -0800
X-CSE-ConnectionGUID: YyreT7gCTA+apRxuwOe1IQ==
X-CSE-MsgGUID: JrlHJLAtSaCQhcBTGPb/NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="143519266"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa001.fm.intel.com with ESMTP; 11 Feb 2025 11:46:30 -0800
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
Subject: [PATCH v2 04/17] x86/cpu/intel: Fix the movsl alignment preference for extended Families
Date: Tue, 11 Feb 2025 19:43:54 +0000
Message-ID: <20250211194407.2577252-5-sohil.mehta@intel.com>
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

The alignment preference for 32-bit movsl based bulk memory move has
been 8-byte for a long time. However this preference is only set for
Family 6 and 15 processors.

Extend the preference to upcoming Family numbers 18 and 19 to maintain
legacy behavior. Also, use a VFM based check instead of switching based
on Family numbers. Refresh the comment to reflect the new check.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>

---

v2: Split the patch into two parts. Update commit message.

---
 arch/x86/kernel/cpu/intel.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 3dce22f00dc3..e5f34a90963e 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -449,23 +449,16 @@ static void intel_workarounds(struct cpuinfo_x86 *c)
 	    (c->x86_stepping < 0x6 || c->x86_stepping == 0xb))
 		set_cpu_bug(c, X86_BUG_11AP);
 
-
 #ifdef CONFIG_X86_INTEL_USERCOPY
 	/*
-	 * Set up the preferred alignment for movsl bulk memory moves
+	 * movsl bulk memory moves can be slow when source and dest are not
+	 * both 8-byte aligned. PII/PIII only like movsl with 8-byte alignment.
+	 *
+	 * Set the preferred alignment for Pentium Pro and newer processors, as
+	 * it has only been tested on these.
 	 */
-	switch (c->x86) {
-	case 4:		/* 486: untested */
-		break;
-	case 5:		/* Old Pentia: untested */
-		break;
-	case 6:		/* PII/PIII only like movsl with 8-byte alignment */
+	if (c->x86_vfm >= INTEL_PENTIUM_PRO)
 		movsl_mask.mask = 7;
-		break;
-	case 15:	/* P4 is OK down to 8-byte alignment */
-		movsl_mask.mask = 7;
-		break;
-	}
 #endif
 
 	intel_smp_check(c);
-- 
2.43.0


