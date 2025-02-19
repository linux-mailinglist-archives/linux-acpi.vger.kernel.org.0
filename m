Return-Path: <linux-acpi+bounces-11312-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72819A3C8BE
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 20:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E93FE3B7CB1
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 19:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8C022CBC7;
	Wed, 19 Feb 2025 19:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HMsV6fUa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19D822CBED;
	Wed, 19 Feb 2025 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739993374; cv=none; b=dpDPSq9QYl/PS+YnjC7kBY+ZJ7iUOS+s9PLyEK92fz/TG0f65GnTYd4Ofnx3eADIbl3NBObMwSdf/SQDq1k3hnM94+fyfssx/p/ACGL4P1BDC6+CZ0z12Dkf/S5jemmgj99Mt0pUIupKhMd2HebUQiro+2k5GRFsHk1Os0k/3Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739993374; c=relaxed/simple;
	bh=EWNICb2X23DLSk1/aKpia5v1KXOTOnjWC0RL/WJh/o4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6Ji7wKHHoYxu0B14iSGCEqkdZkLbTbBNLoR5W2dGiVaDy88dB/yQvCgde/fHLoVuMrs0UdoqVfxvDVpX7TaUtp1J4EJDBV9C3d4a44ph6W6Ax8MT1XqlCY+odyMtwVsxYV7Fo58GB6+tNse/YneQEYhAABY4rcfuCKq8UgE0y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HMsV6fUa; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739993373; x=1771529373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EWNICb2X23DLSk1/aKpia5v1KXOTOnjWC0RL/WJh/o4=;
  b=HMsV6fUaZNpZdpkgEgf5knrkLMtn5Z9Rj5EMoZoWycxboMEqkuwvIili
   ShEt4jPylSezlhE8mqf3AGSPv8ZY1Eec00C6M87vY5UfYn1Ff+Xi/YRB5
   aqHGUXfp9QO4W7vKbVm/NUIRE7ugdxyz8XeLf/HJUr6E6qzrG67Hb8AVs
   0fEKaxwZT5yFHO8sXlbN+40kRp9OBqC/O8sO7tVqZxlEGico1BqUKjK0l
   T2IDUFhvdjJbZHzkLkvlgLlprTmbgzrgDjmcjIOwHRt43gtgkDhdovwgg
   /S5SdX63pludhTSRTvCsiAiBmzGPARP0AZ61khhT+Kr5UQ8I7eOinSeus
   Q==;
X-CSE-ConnectionGUID: Lt3bEISBRmCl65PdWPQhVg==
X-CSE-MsgGUID: bJshtZv6Sw6LuPUQKwyCuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52182966"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52182966"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 11:29:30 -0800
X-CSE-ConnectionGUID: 9sXsdfyqQMeJqq6ImAulxQ==
X-CSE-MsgGUID: lcyiGrYiTPmTIU3ZJYh27w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="115344042"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa010.fm.intel.com with ESMTP; 19 Feb 2025 10:48:34 -0800
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
Subject: [PATCH v3 09/15] x86/smpboot: Remove confusing quirk usage in INIT delay
Date: Wed, 19 Feb 2025 18:41:27 +0000
Message-ID: <20250219184133.816753-10-sohil.mehta@intel.com>
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

Very old multiprocessor systems required a 10 msec delay between
asserting and de-asserting INIT but modern processors do not require
this delay.

Over time the usage of the "quirk" wording while setting the INIT delay
has become misleading. The code comments suggest that modern processors
need to be quirked, which clears the default init_udelay of 10 msec,
while legacy processors don't need the quirk and continue to use the
default init_udelay.

With a lot more modern processors, the wording should be inverted if at
all needed. Instead, simplify the comments and the code by getting rid
of "quirk" usage altogether and clarifying the following:

Old legacy processors -> Set the "legacy" 10 msec delay
Modern processors     -> Do not set any delay

No functional change.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v3: Improve commit message
v2: New patch
---
 arch/x86/kernel/smpboot.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index c10850ae6f09..eb91ed0f2a06 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -654,10 +654,9 @@ static void impress_friends(void)
  * But that slows boot and resume on modern processors, which include
  * many cores and don't require that delay.
  *
- * Cmdline "init_cpu_udelay=" is available to over-ride this delay.
- * Modern processor families are quirked to remove the delay entirely.
+ * Cmdline "cpu_init_udelay=" is available to override this delay.
  */
-#define UDELAY_10MS_DEFAULT 10000
+#define UDELAY_10MS_LEGACY 10000
 
 static unsigned int init_udelay = UINT_MAX;
 
@@ -669,7 +668,7 @@ static int __init cpu_init_udelay(char *str)
 }
 early_param("cpu_init_udelay", cpu_init_udelay);
 
-static void __init smp_quirk_init_udelay(void)
+static void __init smp_set_init_udelay(void)
 {
 	/* if cmdline changed it from default, leave it alone */
 	if (init_udelay != UINT_MAX)
@@ -683,7 +682,7 @@ static void __init smp_quirk_init_udelay(void)
 		return;
 	}
 	/* else, use legacy delay */
-	init_udelay = UDELAY_10MS_DEFAULT;
+	init_udelay = UDELAY_10MS_LEGACY;
 }
 
 /*
@@ -1094,7 +1093,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 
 	uv_system_init();
 
-	smp_quirk_init_udelay();
+	smp_set_init_udelay();
 
 	speculative_store_bypass_ht_init();
 
-- 
2.43.0


