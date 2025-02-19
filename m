Return-Path: <linux-acpi+bounces-11311-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E302A3C8AD
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 20:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA3D176EEB
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 19:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A191322FADE;
	Wed, 19 Feb 2025 19:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YvuWhvCW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C934B22B597;
	Wed, 19 Feb 2025 19:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739993368; cv=none; b=ETO4drEgH77X2n+eBDprvbEKYmDiYUqa4ivzD/kEJapkbewnTu+SH/N02ikpNjsbXCikHbPhusr9aPQaUhyhGyUD/TsfGTXUTY1Nyo2O14gRSGN9ehJgjAWnbZK0r/OKUBy0aU5Ka5i0QC01OwKTJaE1ZUU4Gmc5UfL/PuiYfLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739993368; c=relaxed/simple;
	bh=P9o4bCSPBdpQHPEjmhfPo03t9UDYKs2YD45Ob4HtAOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTy7/JBYvQ2+zvNLnZrAe201Jz4B698QkXR+UJ7cfIpp/RClGlZ1vgV3WWEK6J8RSSSWOv13f/Am334kS47VzO0DElVTe76peppgcPAso4YcTk48a3Ei+A2xo5g0/9uq28KgQtClJvJ5QkL6KaSZ6B5EXmMuRZmm89anyhsZh1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YvuWhvCW; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739993367; x=1771529367;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P9o4bCSPBdpQHPEjmhfPo03t9UDYKs2YD45Ob4HtAOg=;
  b=YvuWhvCWclOWwOlK3NW0LT0sGX8qppccfvwZlZ/gODcuJGWv50DOXZrA
   SbKLuQXijLC+H31ilUf+D0+fgKepg1b/oYRZMP8WcEg6vSv6i1yISPynF
   oHNTGihYjb5LV+QWVaJBlrFkCW21Q8k7elgBN6XT5XircKVyl7SbVA7mL
   6qgknzptWhCQ1Xw84rmQKNkGCLxjb7Q5OUuqpkk48mf+PFndlKl2FZgSZ
   q1kMYAtCsDGpIjX7DX2mZLK941KxtSAajLcn1a2MqQG1099WrcgQgb2WF
   rG1yd10mwFlCekGKSxvCxD9AIlkAHOqleneAFXkzVqg+6WO6MsPH92ULu
   A==;
X-CSE-ConnectionGUID: Q7rnl/aNTV+UQlwILNpxiw==
X-CSE-MsgGUID: U3qkYLezTXSSWx5d/dQ8Dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52182949"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52182949"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 11:29:25 -0800
X-CSE-ConnectionGUID: vucltjVdRAamGbVSuvwdpw==
X-CSE-MsgGUID: 4zd8VEqOTGam3WTujjw2cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="115344040"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa010.fm.intel.com with ESMTP; 19 Feb 2025 10:48:10 -0800
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
Subject: [PATCH v3 08/15] x86/acpi/cstate: Improve Intel Family model checks
Date: Wed, 19 Feb 2025 18:41:26 +0000
Message-ID: <20250219184133.816753-9-sohil.mehta@intel.com>
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
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
---
v3: Pick up Dave's Ack.
v2: Improve commit message.
---
 arch/x86/include/asm/intel-family.h | 3 +++
 arch/x86/kernel/acpi/cstate.c       | 8 ++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 9e6a13f03f0e..deb17c9c21e5 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -187,6 +187,9 @@
 #define INTEL_XEON_PHI_KNL		IFM(6, 0x57) /* Knights Landing */
 #define INTEL_XEON_PHI_KNM		IFM(6, 0x85) /* Knights Mill */
 
+/* Notational marker denoting the last Family 6 model */
+#define INTEL_FAM6_LAST			IFM(6, 0xFF)
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


