Return-Path: <linux-acpi+bounces-11305-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3A5A3C89C
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 20:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB2E818970A4
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 19:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDCC22CBD2;
	Wed, 19 Feb 2025 19:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IK2AkLYe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8078322B5B6;
	Wed, 19 Feb 2025 19:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739993311; cv=none; b=Q7KpgylP8MFytPd73X3CGhiXhQYwcWb4oiEXEFaNIUvWEbxLJFTjyPcZFXwHHLmSQyswt91s4rRYnTi/cfloqiQJ012UWYKQfb5D+cwYjWtvWnw+kIz9A2jhhzErVr+TfHwzu7+JmaOy2IWFg9Y+tZXWFlYVWXNE0oS5NrgqaiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739993311; c=relaxed/simple;
	bh=sNuMaM1WZ6y1DAt6ky+6zKrfsOMdtVLR6Xl5JYbOSSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLRwYsHZO8av9q1uYB3AfoV1JIxVIB21kps48SinJYgGpu9u4n5HpyxguifEm18jv6QgoBZzsdCng6iXXSdGpOWerhtp2VfSoYn2Cww2bGFOzdqw0qx+7l4vDbrmO3shSdLKFT2KH9LfgW49qssVVBXiBN96YcPcWTTC+pEuek0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IK2AkLYe; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739993309; x=1771529309;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sNuMaM1WZ6y1DAt6ky+6zKrfsOMdtVLR6Xl5JYbOSSE=;
  b=IK2AkLYesTXOuaHToxqrO9xNxxaAAg08MTtICWwrNBGuasCZyFcaCR0M
   aPEiIAB/OOHtNGBWtZ3lrlBMG9VfgHZECcsbKSwmt7S19FcHJFzX4Db5P
   qq9hiC+0nw/FezAwgnqecdrBSoPce10QXYlNgaPP25GCs47kFF/B6fgDG
   eTJq+J/j+HRhXv440zSp0eAsiLvgneNVnLScoy8f/Fu+4AIpGxg99Pz7e
   TtqElCbiWZyxbpimXl45eeEVlfW6t0Hc/S0pa1+StO0FxZcjj9540AJeo
   W47kdaKiJQd0Y0+z/Fb+es6VMO6gqcy2+I9dz8vZhXcH+Js7ARO5wQL+O
   g==;
X-CSE-ConnectionGUID: ShcFywT2Sr2p7oh2DKHaAQ==
X-CSE-MsgGUID: mqPXt4/sQ+igOQ2GeVOsRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52182771"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52182771"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 11:28:29 -0800
X-CSE-ConnectionGUID: 4n9c7S+4QNm6oiP3O2Wc0g==
X-CSE-MsgGUID: WiUdiodkRUeRqlVaLTzqxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="115344005"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa010.fm.intel.com with ESMTP; 19 Feb 2025 10:45:36 -0800
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
Subject: [PATCH v3 02/15] x86/cpu/intel: Fix the movsl alignment preference for extended Families
Date: Wed, 19 Feb 2025 18:41:20 +0000
Message-ID: <20250219184133.816753-3-sohil.mehta@intel.com>
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

The alignment preference for 32-bit movsl based bulk memory move has
been 8-byte for a long time. However this preference is only set for
Family 6 and 15 processors.

Use the same preference for upcoming Family numbers 18 and 19. Also, use
a simpler VFM based check instead of switching based on Family numbers.
Refresh the comment to reflect the new check.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
---
v3: Picked up Dave's Ack. Improve commit message.
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


