Return-Path: <linux-acpi+bounces-11047-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA52EA315D3
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 20:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442471889C9D
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 19:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CBA26B2B3;
	Tue, 11 Feb 2025 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TRm2IQDR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B537267F68;
	Tue, 11 Feb 2025 19:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303203; cv=none; b=MarucLxo8Ya04jNOIDFneWcJ79FUQDT6Pz0bv+4Rw7WOK032Hpafkm/wq9jqKzvDeZJjJ0mqNnM3uCIz2QEloA0alpY5nwR4cFLkleWDWJpPmoqRkyxyD1Hm/KuJwu94k8F3ihZdM5LWvwLkxQX5Oy42Vk5t3XHpnbYUto/l180=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303203; c=relaxed/simple;
	bh=JbPiUOcdrtU+wv7vJSwpOT1w28hleA0/pq1R8WhFBmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQSPuq4z8ctdiwD4V3vk/p1c38lxBYhhmjYFtJaa5ou4IDKUhYRSDekOnE+5CQPs41sjXtDZ0zz6i2yXwtR/cK/17KVGk33d6hYyXm0NNv+P8Za/hvPw9aJsGJBTU5LcNnM31rHybw5U5GO+Ohvm8niZxbCT97Xeo3zJptpyU1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TRm2IQDR; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739303200; x=1770839200;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JbPiUOcdrtU+wv7vJSwpOT1w28hleA0/pq1R8WhFBmU=;
  b=TRm2IQDREwXKZxG+RhiX4aM6fiM9hLrW8dLpVFVMs8Ty9w+lot4MCwYv
   tUVDNCK0AFCzI04HxDKnAdsFwZQtAkIigeV2w4E8Q517E4msdLUihwx0p
   y49FBFAZfVyrJaXRKnGuf/9PV58cUOeg70a8jpFBGn1PrjI2O5KdAnNxN
   nIsU2Pucg0kKyoe/Cst3V1YZJwyyca5AZtJI4800TVtzkWYqki72mVKk8
   iTP3hYZgw24c/QG/dSnipjXdFiyi+5/XxWUsuWFKCJnFYjWAhba5Frazo
   4SD07fZYYDoXYH7PCxUC+vtIpP0U2xQ896goiFwbUwtR+TwgHZ9WfQXzy
   A==;
X-CSE-ConnectionGUID: p/xtbNB1QJ+0frbu5qaFag==
X-CSE-MsgGUID: eqkj+FYeRdGSxjT9h4mbaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39855001"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39855001"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 11:46:36 -0800
X-CSE-ConnectionGUID: QVD96zhsTxmX0tH2IPm5gw==
X-CSE-MsgGUID: Dy9TJI1TRBaTQTs4HdAZ+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="143519309"
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
Subject: [PATCH v2 14/17] x86/acpi/cstate: Improve Intel Family model checks
Date: Tue, 11 Feb 2025 19:44:04 +0000
Message-ID: <20250211194407.2577252-15-sohil.mehta@intel.com>
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

Update the Intel Family checks to consistently use Family 15 instead of
Family 0xF. Also, get rid of one of last usages of x86_model by using
the new VFM checks.

Update the incorrect comment since the check has changed[1][2] since the
initial commit ee1ca48fae7e ("ACPI: Disable ARB_DISABLE on platforms
where it is not needed").

[1]: commit 3e2ada5867b7 ("ACPI: fix Compaq Evo N800c (Pentium 4m) boot
hang regression") removed the P4 - Family 15.

[2]: commit 03a05ed11529 ("ACPI: Use the ARB_DISABLE for the CPU which
model id is less than 0x0f.") got rid of CORE_YONAH - Family 6, model E.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>

---

v2: Improve commit message.

---
 arch/x86/include/asm/intel-family.h | 3 +++
 arch/x86/kernel/acpi/cstate.c       | 8 ++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 300dac505d7f..fae52a15d9b9 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -187,6 +187,9 @@
 #define INTEL_XEON_PHI_KNL		IFM(6, 0x57) /* Knights Landing */
 #define INTEL_XEON_PHI_KNM		IFM(6, 0x85) /* Knights Mill */
 
+/* Notational marker denoting the last Family 6 model */
+#define INTEL_FAM6_LAST		        IFM(6, 0xFF)
+
 /* Family 15 - NetBurst */
 #define INTEL_P4_WILLAMETTE		IFM(15, 0x01) /* Also Xeon Foster */
 #define INTEL_P4_PRESCOTT		IFM(15, 0x03)
diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index 5854f0b8f0f1..444602a0a3dd 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 
 #include <acpi/processor.h>
+#include <asm/cpu_device_id.h>
 #include <asm/cpuid.h>
 #include <asm/mwait.h>
 #include <asm/special_insns.h>
@@ -47,12 +48,11 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
 	/*
 	 * On all recent Intel platforms, ARB_DISABLE is a nop.
 	 * So, set bm_control to zero to indicate that ARB_DISABLE
-	 * is not required while entering C3 type state on
-	 * P4, Core and beyond CPUs
+	 * is not required while entering C3 type state.
 	 */
 	if (c->x86_vendor == X86_VENDOR_INTEL &&
-	    (c->x86 > 0xf || (c->x86 == 6 && c->x86_model >= 0x0f)))
-			flags->bm_control = 0;
+	    (c->x86 > 15 || (c->x86_vfm >= INTEL_CORE2_MEROM && c->x86_vfm <= INTEL_FAM6_LAST)))
+		flags->bm_control = 0;
 
 	if (c->x86_vendor == X86_VENDOR_CENTAUR) {
 		if (c->x86 > 6 || (c->x86 == 6 && c->x86_model == 0x0f &&
-- 
2.43.0


