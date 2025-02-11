Return-Path: <linux-acpi+bounces-11045-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E54A315CB
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 20:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F901617FD
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 19:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4841B269CE4;
	Tue, 11 Feb 2025 19:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cs7id1Iz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F641EC00D;
	Tue, 11 Feb 2025 19:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303201; cv=none; b=Dx5n3SCIELZ6PVTEmYBm4sfS5Ik6o2sDK7C/Y1I1/m8Ho/PqkvxVlXHa0EZicDSaoHvHmU+7NQMzYZuPb7uxcbxA2OfOh3dvsQockkSWxL+TPTUP6EUwuMCBj7Ao6HCN4xs3voKIwmwc0b1+x1xyTh/YdlE9HwLSMFMXmkMhjTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303201; c=relaxed/simple;
	bh=jR8/FSmO4PdPthiRGBHj6+I0HazZNWgqbrxcQmNZY7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I488q00cT5MYaFEXVc1PE4+kKbAxjbN2ZcTd9wMiSQblRCOaAfzJUyQSBACl+HGxiZHTwTYfn+bv02qRbcPsdTBvEqwC9m/le90ep1UBtM1Xomq41lZzMa1BN/XnCKYqdGJkpTFhHUcYxZFcRizb5YgTp7bGIWp158YrAkWbx94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cs7id1Iz; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739303199; x=1770839199;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jR8/FSmO4PdPthiRGBHj6+I0HazZNWgqbrxcQmNZY7o=;
  b=Cs7id1IzCYCJtcVROPTp4qMrscOZaqLbFe7Zz9AkzJ41a4ASRuprKnsR
   dc4TiXQ4wW1UHiasQifuXhbkirqCw6qX2MSor8imMwnWqm17BW1QXjD0M
   wTw8769iI8Xfj9akOrP39a6Ng4lbXac+IIReOQ6ahov4BbH61KciFNvgb
   BDPvEQOFKJdl7gaM5OwDqNN5NcO3Q5KK1pM16TkIHupNze9LD35kALagO
   Xa8VAIGqAe6akSGlyHASVz2vIwuawvPV+Q+D1R2mXnnZLJz/qnxbp65co
   NBW8q2Swd5VlDP2KyUloM4KoS/bpd5AOlF7hyFTEtK0MbQTGBncsEeN4E
   Q==;
X-CSE-ConnectionGUID: V9BqJjDgRgKO1Co2RYIahA==
X-CSE-MsgGUID: pScgo95RRcWSfjYtq6YnHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39854987"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39854987"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 11:46:36 -0800
X-CSE-ConnectionGUID: hNhrIqQ8R52CoZwWxNRnrg==
X-CSE-MsgGUID: yYtJJHpVT6+Pl77WBy8gyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="143519306"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa001.fm.intel.com with ESMTP; 11 Feb 2025 11:46:35 -0800
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
Subject: [PATCH v2 13/17] x86/pat: Replace Intel x86_model checks with VFM ones
Date: Tue, 11 Feb 2025 19:44:03 +0000
Message-ID: <20250211194407.2577252-14-sohil.mehta@intel.com>
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

Introduce markers and names for some Family 6 and Family 15 models and
replace x86_model checks with VFM ones.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>

---

v2: Get rid of the INTEL_FAM15_START IFM(15, 0x00) define.

---
 arch/x86/include/asm/intel-family.h | 1 +
 arch/x86/mm/pat/memtype.c           | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 9e6a13f03f0e..300dac505d7f 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -190,6 +190,7 @@
 /* Family 15 - NetBurst */
 #define INTEL_P4_WILLAMETTE		IFM(15, 0x01) /* Also Xeon Foster */
 #define INTEL_P4_PRESCOTT		IFM(15, 0x03)
+#define INTEL_P4_CEDARMILL		IFM(15, 0x06) /* Also Xeon Dempsey */
 
 /* Family 19 */
 #define INTEL_PANTHERCOVE_X		IFM(19, 0x01) /* Diamond Rapids */
diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index feb8cc6a12bf..25a8ecbad3a2 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -43,6 +43,7 @@
 #include <linux/fs.h>
 #include <linux/rbtree.h>
 
+#include <asm/cpu_device_id.h>
 #include <asm/cacheflush.h>
 #include <asm/cacheinfo.h>
 #include <asm/processor.h>
@@ -290,9 +291,9 @@ void __init pat_bp_init(void)
 		return;
 	}
 
-	if ((c->x86_vendor == X86_VENDOR_INTEL) &&
-	    (((c->x86 == 0x6) && (c->x86_model <= 0xd)) ||
-	     ((c->x86 == 0xf) && (c->x86_model <= 0x6)))) {
+	if (c->x86_vendor == X86_VENDOR_INTEL &&
+	    ((c->x86_vfm >= INTEL_PENTIUM_PRO && c->x86_vfm <= INTEL_PENTIUM_M_DOTHAN) ||
+	    (c->x86_vfm >= INTEL_P4_WILLAMETTE && c->x86_vfm <= INTEL_P4_CEDARMILL))) {
 		/*
 		 * PAT support with the lower four entries. Intel Pentium 2,
 		 * 3, M, and 4 are affected by PAT errata, which makes the
-- 
2.43.0


