Return-Path: <linux-acpi+bounces-11318-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0381FA3C8CD
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 20:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8890E189D100
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 19:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AEE2397B0;
	Wed, 19 Feb 2025 19:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HUMWxafv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4574423957F;
	Wed, 19 Feb 2025 19:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739993402; cv=none; b=aBlnOK0kVeGgmxcf11riE2VM/e+q3s4O57MHv37iU7AyCHgDwkl1ZoEbBP9XxLLoq4NraAZrmpCKjlzg8Ma62OgR+SLznYtNNditU8Ab/0NS/pHaOFCAtQLLW5/vkB+aEIPVpHlhjVHlEj6EAgKkcaW+ZqLLU2Utybr+iRVPa/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739993402; c=relaxed/simple;
	bh=QLIMnNXCwjgKCC5aNgIRCQTRlUzz0+nUlS5cRZ36n7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eIk0gJ5tdJ8nVVonoLNXyudfTDXfuIrV4SE7RW+yndlB+ZLyai6jc8MMhz66t3yAkR+/ZX4kYQrWNgxV8eM5GlA7arQotlLJrAm9bzN9/agf6+UZXkVdQlL+G92HBygyRstGMCcGck+m3SZxJyDGIbZuD+jTI885uXB+5quUu2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HUMWxafv; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739993400; x=1771529400;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QLIMnNXCwjgKCC5aNgIRCQTRlUzz0+nUlS5cRZ36n7M=;
  b=HUMWxafvQUZ08vO46pAafrfGQeDYR/2mttDR881RDD001mDxetNnqwRQ
   ALGn4rt9JeNU/iEfzXzTd8lRmMUKKO75wnXaXMg61LYP4j5sG776pMoc9
   kz36Oa/M2foT8ZvJ/HlnxHYUFvZhvriZw89vyjv4JPpeKT5vRGqZd975N
   kZJTeDQeewUr/MqKdV6PdkPq4rCiP6spe9/zmNGQHdreNS+45bUHa6ZHw
   EIdilgKfH/ULEiner3qtF7aOAOdYsddMUC9bvm88+ixfkX9hkMr5B7RHo
   i3AGh4XFzTFqBwbVG1j509fSjVFKvqWl57VtkOjclnXcfJzf2Bav7RiBR
   g==;
X-CSE-ConnectionGUID: L5CK+tJwRWqrfRFhvJX/pg==
X-CSE-MsgGUID: Xk95ySiIScy67JUblkBj8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52183103"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52183103"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 11:29:58 -0800
X-CSE-ConnectionGUID: pCzsR04cRdaYRECqVCeYJw==
X-CSE-MsgGUID: nDUq0+YwTgG3+goNBDOSbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="115344084"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa010.fm.intel.com with ESMTP; 19 Feb 2025 10:50:35 -0800
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
Subject: [PATCH v3 15/15] perf/x86/p4: Replace Pentium 4 model checks with VFM ones
Date: Wed, 19 Feb 2025 18:41:33 +0000
Message-ID: <20250219184133.816753-16-sohil.mehta@intel.com>
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

Introduce names for some old pentium 4 models and replace x86_model
checks with VFM ones.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v3: No change.
v2: No change.
---
 arch/x86/events/intel/p4.c          | 7 ++++---
 arch/x86/include/asm/intel-family.h | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
index 844bc4fc4724..fb726c6fc6e7 100644
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -10,6 +10,7 @@
 #include <linux/perf_event.h>
 
 #include <asm/perf_event_p4.h>
+#include <asm/cpu_device_id.h>
 #include <asm/hardirq.h>
 #include <asm/apic.h>
 
@@ -732,9 +733,9 @@ static bool p4_event_match_cpu_model(unsigned int event_idx)
 {
 	/* INSTR_COMPLETED event only exist for model 3, 4, 6 (Prescott) */
 	if (event_idx == P4_EVENT_INSTR_COMPLETED) {
-		if (boot_cpu_data.x86_model != 3 &&
-			boot_cpu_data.x86_model != 4 &&
-			boot_cpu_data.x86_model != 6)
+		if (boot_cpu_data.x86_vfm != INTEL_P4_PRESCOTT &&
+		    boot_cpu_data.x86_vfm != INTEL_P4_PRESCOTT_2M &&
+		    boot_cpu_data.x86_vfm != INTEL_P4_CEDARMILL)
 			return false;
 	}
 
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 6621d796bb3d..89cb545d521b 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -193,6 +193,7 @@
 /* Family 15 - NetBurst */
 #define INTEL_P4_WILLAMETTE		IFM(15, 0x01) /* Also Xeon Foster */
 #define INTEL_P4_PRESCOTT		IFM(15, 0x03)
+#define INTEL_P4_PRESCOTT_2M		IFM(15, 0x04)
 #define INTEL_P4_CEDARMILL		IFM(15, 0x06) /* Also Xeon Dempsey */
 
 /* Family 19 */
-- 
2.43.0


