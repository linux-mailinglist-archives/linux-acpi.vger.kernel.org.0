Return-Path: <linux-acpi+bounces-10233-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1269F9C3A
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 22:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13FF116AB0C
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 21:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE44F22CBF1;
	Fri, 20 Dec 2024 21:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SVB9Ms6+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5EB22B8D9;
	Fri, 20 Dec 2024 21:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734730767; cv=none; b=Tt5EsMo0/gn8qAGDqqfUihMd0QGHvoO44Ok6ohKVQ4pXV0KEpllhn9KsHcWbKnOFafmjiNyivZ/CMZEK4op1JUMH5Zte0FBsEk4iVSajx4y1Zke1l5Y/73Lz+jcgjb/6bJmnWZ5LpwIppj5gIvaXkemIarL2PO0F9rkd5tuDfJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734730767; c=relaxed/simple;
	bh=P7ru4qx+MPgk/Pvi5QoK/6DMjTyTZM1LsOislTZ21R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RCDEf5/cqWomf7iK9yPPjsMZtSb6LejC3t5KIC6TgOyplYy4+P3BzSBqmiQDu9XM9Nl7La2+OGriDJlVzveLw6z7+FKBcUkOy+jaKw8aUfEbJfljOzPiB8HdkMqgVPCP0DjecWjCyTf6IWZ6yWYJ+D1ZBXEtx7t+ICsZw5Uvag4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SVB9Ms6+; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734730766; x=1766266766;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P7ru4qx+MPgk/Pvi5QoK/6DMjTyTZM1LsOislTZ21R4=;
  b=SVB9Ms6+Bej9Svvy00zudQmAobfUDyczXmXBayot1ZgFOR03lkpMyyXC
   6YUmwlHFEaLySnc295IjpHftvXqajEA/JUK6ra5EPGDOOXb9V/E/jUUm3
   WAE/CFGw6bcdCv//bpG2iv+FluadQ0+qLe6OPPBb8lUcZFlgJKKige8EP
   JgeWbgW6YDs3PMiYgDV3GsWuqyHkXa74FtH9/eN32zqpf5xvARX/vM7WE
   obI8G5XXurjkxt4l2gdImGBGsH/pnei8cPUWp2HDKcNjihPksHOWboJRz
   SnVNQz7ziPmRiNKVSZ0W87W2eEWET+bUInEhAgKXiOHtq/na2z/ZtxLcK
   Q==;
X-CSE-ConnectionGUID: RhLX0b/IQeuLunz/Fl8icw==
X-CSE-MsgGUID: qKGr4nkyTtStz7m6M8XcGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="39070794"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="39070794"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 13:39:20 -0800
X-CSE-ConnectionGUID: Vyab51gZQfeIHUm1FYygxw==
X-CSE-MsgGUID: JmFcIO4bQDaV0caz/Pe/lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103223872"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa005.fm.intel.com with ESMTP; 20 Dec 2024 13:39:19 -0800
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
Subject: [RFC PATCH 15/15] perf/x86/p4: Replace Pentium 4 model checks with VFM ones
Date: Fri, 20 Dec 2024 21:37:10 +0000
Message-ID: <20241220213711.1892696-16-sohil.mehta@intel.com>
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

Introduce names for some old pentium 4 models and replace with VFM based
checks.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
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
index 73e458440fcb..77840c0b0df3 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -192,6 +192,7 @@
 #define INTEL_FAM15_START		IFM(15, 0x00) /* Notational marker */
 #define INTEL_P4_WILLAMETTE		IFM(15, 0x01) /* Also Xeon Foster */
 #define INTEL_P4_PRESCOTT		IFM(15, 0x03)
+#define INTEL_P4_PRESCOTT_2M		IFM(15, 0x04)
 #define INTEL_P4_CEDARMILL		IFM(15, 0x06) /* Also Xeon Dempsey */
 
 /* Family 19 */
-- 
2.43.0


