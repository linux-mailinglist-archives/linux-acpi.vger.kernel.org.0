Return-Path: <linux-acpi+bounces-11049-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 089BBA315E2
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 20:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9E73A9614
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 19:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0556426D5B8;
	Tue, 11 Feb 2025 19:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eLHt9ppD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A17026B2AC;
	Tue, 11 Feb 2025 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303204; cv=none; b=EDyAsPt1KLBrKVEv8GPFWL/3KX4AAIKV2oCUMvjMxKno908eJIoBWs7Jh4ATsKDHEnCqGDmEw6NFl6IDWG8JqA7mvdd2zwnQfuNB0VCQdS5lMrjrI6Q6dfotc7Q/OYYVk/4whlbRpiPW9PQNrZtJb2mCyUbtqnJfkB9JEqI637M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303204; c=relaxed/simple;
	bh=DQwsDRYYrr2LZYYckCXDgcjmwkOtY0NcULIdRKXH9mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3B0RmixylSIA5UZo0AVam5mx6qSO9+D1Es6gnMgXCDaW4LSW7gelNaw3l73KV2UgUo079QLm6JAKNlLu2IH7eIGnDKnjC0FNTtxsyoBgEzfGS/noyQEd8PRbwWOJZYOIBnNF4wUq0i5nneBcbwulLCYxAIcbF5LSbVJekRBki0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eLHt9ppD; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739303203; x=1770839203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DQwsDRYYrr2LZYYckCXDgcjmwkOtY0NcULIdRKXH9mQ=;
  b=eLHt9ppDWIofwTI/lHNugJzmHlhzWnXXjFVW7Emr4KzKWLTY87ozG7PO
   7uHGwXVA4YLTeCLTukmM0uUYa4YB1C7wTkISO8rJvVnauOb7jfOjJFyG7
   rveOoMp3uaVUFqJy9kyoKnlfAbelLkwjhqj3pBmMHxtnJh8NsFkyRmVVS
   Lq2IfPbudK1IMXrGP9nyOA+781z3aqYF2e1BlZKzgWs1xfs8bjid+BF+6
   +NOvmB8QfDTSVIs9hzzRqUg6+oUp4knXytgCP6A4DVM6LCesvl2Swcgm9
   1PqIMBXFL3o2LxumxMLvVcJndji0k4h6TGq6sQLYm7zgm1b1npTbkI24/
   A==;
X-CSE-ConnectionGUID: VHL467KWRL+KuSqf3oMG2g==
X-CSE-MsgGUID: lUn8LA1fSpK+XJwmhAMtcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39855043"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39855043"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 11:46:37 -0800
X-CSE-ConnectionGUID: NhdnOQf9TjKVdH141SRtvg==
X-CSE-MsgGUID: tzy2/R7sSESU1esiHFRL0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="143519318"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa001.fm.intel.com with ESMTP; 11 Feb 2025 11:46:37 -0800
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
Subject: [PATCH v2 17/17] perf/x86/p4: Replace Pentium 4 model checks with VFM ones
Date: Tue, 11 Feb 2025 19:44:07 +0000
Message-ID: <20250211194407.2577252-18-sohil.mehta@intel.com>
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

Introduce names for some old pentium 4 models and replace x86_model
checks with VFM ones.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>

---

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
index fae52a15d9b9..af2979850d62 100644
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


