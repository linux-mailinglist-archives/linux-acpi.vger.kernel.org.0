Return-Path: <linux-acpi+bounces-10225-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 576B29F9C21
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 22:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5901892566
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 21:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE96222915C;
	Fri, 20 Dec 2024 21:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQr9/+Qv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E62228380;
	Fri, 20 Dec 2024 21:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734730761; cv=none; b=Fif3sh1W3K1NzNeJRfZV5SFnblzXl0h8kI6oid1R5EryAhWnX1eZScxwYNpCSsaF7kHCooVpGwar6bd1+Gv50etixaINg5Qs9EKCf3ajfr6xbhqTGIDMOp+aZlYnAHRzbQVi9qqugC4mGog+Xm9daaSUMqnmCKlmFx04kINu8/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734730761; c=relaxed/simple;
	bh=w5yxFrFjNk2rOvxvNr3CKSLfp4P0JFH0fW/f7AsjuWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBlw2vDz7iGgyzB+OIoJ27/az5Ul+Oj/AiPZzhvusLCXFBGscqlhVa9c1kGHGrX+iD/FZE6a7ODqHr50gFsb9F0J+Rk3fMRlhX27lRQwNUVH8CjYoIUu15m4AgouTnHJ4h0CqAr3afeSFjMAqpk14Vla014PnN6wgVeIkgxWquk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQr9/+Qv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734730760; x=1766266760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w5yxFrFjNk2rOvxvNr3CKSLfp4P0JFH0fW/f7AsjuWk=;
  b=OQr9/+Qvgw3JDdIS2lmdkQyNX0EaOz7Ua3Qo15KXMLhPK9lhDkXjeJeF
   JQ7AmvAV3wyGtB894wQtvCX1EJlrtJVBS9Rk23+y3242Wz7bKPtUzOYAX
   CvUfDVt6oRO7LE33jgwOpLCtIAkI3z6QU1hvyPns00jEJduVtJBkwS6s8
   QdSRc6/KtKHerUOiKp3jd+KMmPpGpc5VR+7y5E4JnsXpNA5mtXebCV5Tc
   RIgZG4Oim2t4Lx0DNP0WXxiz9eDFl4iD4NSZQ3SVbHudlWWyyamuBs/li
   Rp9VEYQABYZSzR1UmhnC/Lg6ollRQTuBQQXa7GsW6OPAhTdeXJ2uOGQCO
   A==;
X-CSE-ConnectionGUID: qIoCiHMbRZOPfqGS8BTPaw==
X-CSE-MsgGUID: B3Z3aUNkQOOaK2sfAhE44w==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="39070699"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="39070699"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 13:39:17 -0800
X-CSE-ConnectionGUID: +7AvRxIXRzK5RubY0g8fEQ==
X-CSE-MsgGUID: 5/NJpDxeTAWD4dS0s729CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103223847"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa005.fm.intel.com with ESMTP; 20 Dec 2024 13:39:16 -0800
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
Subject: [RFC PATCH 07/15] x86/mtrr: Modify a x86_model check to an Intel VFM check
Date: Fri, 20 Dec 2024 21:37:02 +0000
Message-ID: <20241220213711.1892696-8-sohil.mehta@intel.com>
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

Get rid of one of the last few Intel x86_model checks in arch/x86.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/kernel/cpu/mtrr/generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 7b29ebda024f..36f5dbd2f482 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -12,6 +12,7 @@
 #include <asm/processor-flags.h>
 #include <asm/cacheinfo.h>
 #include <asm/cpufeature.h>
+#include <asm/cpu_device_id.h>
 #include <asm/hypervisor.h>
 #include <asm/mshyperv.h>
 #include <asm/tlbflush.h>
@@ -1025,8 +1026,7 @@ int generic_validate_add_page(unsigned long base, unsigned long size,
 	 * For Intel PPro stepping <= 7
 	 * must be 4 MiB aligned and not touch 0x70000000 -> 0x7003FFFF
 	 */
-	if (mtrr_if == &generic_mtrr_ops && boot_cpu_data.x86 == 6 &&
-	    boot_cpu_data.x86_model == 1 &&
+	if (mtrr_if == &generic_mtrr_ops && boot_cpu_data.x86_vfm == INTEL_PENTIUM_PRO &&
 	    boot_cpu_data.x86_stepping <= 7) {
 		if (base & ((1 << (22 - PAGE_SHIFT)) - 1)) {
 			pr_warn("mtrr: base(0x%lx000) is not 4 MiB aligned\n", base);
-- 
2.43.0


