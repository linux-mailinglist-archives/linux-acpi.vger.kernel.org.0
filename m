Return-Path: <linux-acpi+bounces-10231-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CF09F9C33
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 22:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C9B16A28C
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 21:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24715225A3C;
	Fri, 20 Dec 2024 21:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Skci+Ity"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07BE22A807;
	Fri, 20 Dec 2024 21:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734730766; cv=none; b=SH+Hev3CCKUyOnsas6yxkFqPRb27mwg3K6kIfNFfoa/x7aqrksvGxERgVA/lNWTRqXBESQtu1RhW809l9YuqoxBvGhxUoTk6UGt96YrrGvKxHSTd2t5vJL5o7wnImY7I+MMNpbGnwdPk6ODiJDLqgi/wZv5yepNVgragF8ZgusI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734730766; c=relaxed/simple;
	bh=sdXp+h2ETwRXHxEyxIcdZXZlBP+plqq6x2FmUGbFHmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/2LNUabbKxIVwEY8rMQpGM5vp7BnZjgBTEczzfPFR5OFgVsx6hC/tFs0T6wd0Fx0OOZzJXOclofNV0ukUXpno9wdTds+oYEaPiYsqZKfdqM433a77xzFw/gd0zNWmtrnP0VF6RnskzgJnJmpiWkKEU91ykaGt1ccMSHNv+8Rq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Skci+Ity; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734730764; x=1766266764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sdXp+h2ETwRXHxEyxIcdZXZlBP+plqq6x2FmUGbFHmk=;
  b=Skci+Ityj10dV3dLb8ZdAIezjHZhQC1u7bx3MYASi7os5nmxpDaLEc0u
   p3ugPqOS9HU1zt0Rs0abxiM3FQrG0NBgaNR1EYa5dJ6Qozbre/OZXbSCL
   o6AOKdPyqxgnZBUA2Dmq4p0KAg5u8QneLlpmfw2UYtUPillejg613IY0K
   h01f1S9izaltOkG8/dSeLMcajWVzt340EKrISSJIOdRUcREqvGaPDw+d4
   8g2fvEy7HacOfbUCwfYVEr4Ew/iyp7lDeHN4miopQBWkRg7J7e6ohAlPv
   Oq+Di6Z3O8z4LuUm6wYcItsdags7wOamLutZaGz5X7IwAv+d3QlL1E3FG
   Q==;
X-CSE-ConnectionGUID: 2THhP3R7Q6KfBIC0FDBwPw==
X-CSE-MsgGUID: T+tPAE6oTZGchIojl8Vn6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="39070757"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="39070757"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 13:39:19 -0800
X-CSE-ConnectionGUID: jEjo24QQQdiyh7CqRDStfg==
X-CSE-MsgGUID: 5AqDAvbSRcqkKR211zb04A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103223863"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa005.fm.intel.com with ESMTP; 20 Dec 2024 13:39:18 -0800
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
Subject: [RFC PATCH 12/15] x86/acpi/cstate: Improve Intel family model checks
Date: Fri, 20 Dec 2024 21:37:07 +0000
Message-ID: <20241220213711.1892696-13-sohil.mehta@intel.com>
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

Update the Intel family checks to consistently use Family 15 instead of
Family 0xF. Also, get rid of one of last usages of x86_model by using
the new VFM checks.

Update the incorrect comment since the check has changed since the
initial commit ee1ca48fae7e ("ACPI: Disable ARB_DISABLE on platforms
where it is not needed").

commit 3e2ada5867b7 ("ACPI: fix Compaq Evo N800c (Pentium 4m) boot hang
regression") removed the P4s and commit 03a05ed11529 ("ACPI: Use the
ARB_DISABLE for the CPU which model id is less than 0x0f.") got rid of
CORE_YONAH.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/include/asm/intel-family.h | 3 +++
 arch/x86/kernel/acpi/cstate.c       | 8 ++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 76a184361930..73e458440fcb 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -179,6 +179,9 @@
 #define INTEL_XEON_PHI_KNL		IFM(6, 0x57) /* Knights Landing */
 #define INTEL_XEON_PHI_KNM		IFM(6, 0x85) /* Knights Mill */
 
+/* Notational marker denoting the last Family 6 model */
+#define INTEL_FAM6_LAST		        IFM(6, 0xFF)
+
 /* Family 5 */
 #define INTEL_FAM5_START		IFM(5, 0x00) /* Notational marker, also P5 A-step */
 #define INTEL_PENTIUM_75		IFM(5, 0x02) /* P54C - Need a better name */
diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index f3ffd0a3a012..6d87d1ebe89b 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 
 #include <acpi/processor.h>
+#include <asm/cpu_device_id.h>
 #include <asm/mwait.h>
 #include <asm/special_insns.h>
 
@@ -46,12 +47,11 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
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


