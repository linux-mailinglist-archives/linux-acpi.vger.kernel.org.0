Return-Path: <linux-acpi+bounces-11034-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48844A315A1
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 20:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC6781675B8
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 19:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C74B262D36;
	Tue, 11 Feb 2025 19:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Te5r9zT5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D5A1E5B7F;
	Tue, 11 Feb 2025 19:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303193; cv=none; b=FcgmzW/1J737AWZoEk0PsbQeLG4ha09hLFf37OkkbPxdWzGPWrq+ecC2MaCffSA6VmdSbvASnbnbHM9lPdQQoTgTgwDqfy3WbogxqxPqIUQXKr6mTqLjmuVLBVsRzmZKP/sZYinqnAbR6AgaYkN2fkJO78oWyxThbI7mZI4eqbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303193; c=relaxed/simple;
	bh=mdpfH17o5dkDM3WpmrEspA/mb9FHGuKgj/Hbbefju8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+Ntm5IIGnOHp21eeMbTMI0ArR66TtSzo0IaGHynvvQhRbj/NMflWIPUU/ge5+sEW8kEwnpiSWRRC0RABI6TCa5Jb/qmTwUN1ekucJxxQ3WYhwldLzU4SY1vuD2uTxXofrgYH2Oksb8CXk//DKyghSn9xuOYdHj9jMlKaU2LLBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Te5r9zT5; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739303192; x=1770839192;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mdpfH17o5dkDM3WpmrEspA/mb9FHGuKgj/Hbbefju8Y=;
  b=Te5r9zT5Bt7pSjYMzzYbWkcpGFiRxQiz7NPqqqDg3NMBgiNmzEb/BHtm
   aqPiTUaQF/1imp+jGBEv+J6ytVYSKO5IJzmdcnfF7Pucb+GGIxZr461mL
   TilMK7TNT1HysImtrPakIXvIAdYAovpvbF/KTV92pUndARHsTy9pKfBEt
   QvvourrwWPFv6zX9sA9TOR0m1ArRlZMbfDkYt3EUeeZlx9MElRaiTp8oS
   VGbpNzZky8eH5kpG/oT0ehHU82+pq0hgcppIXNZLp4MSOo7Win0x7xJKK
   uNEqvzoZgH9xJVtaonjpmkhgbPNEhgaU9JTUNSE9Cfbp031sqkt6sKddi
   w==;
X-CSE-ConnectionGUID: GeyYWcLuSx6NptSe085pAQ==
X-CSE-MsgGUID: qcI1d0HnTCCmNsDd4JYP8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39854802"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39854802"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 11:46:29 -0800
X-CSE-ConnectionGUID: z1UQie1tT/uhlJlaQkVHDg==
X-CSE-MsgGUID: VYDIrfl/QTqUmE5+1I+tsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="143519258"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa001.fm.intel.com with ESMTP; 11 Feb 2025 11:46:29 -0800
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
Subject: [PATCH v2 02/17] x86/smpboot: Fix INIT delay optimization for extended Intel Families
Date: Tue, 11 Feb 2025 19:43:52 +0000
Message-ID: <20250211194407.2577252-3-sohil.mehta@intel.com>
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

Currently only Family 6 is considered as modern and avoids the 10 msec
INIT delay. The optimization doesn't extend to the upcoming Family 18/19
models.

Also, the omission of Family 15 (Pentium 4s) seems like an oversight and
should probably be included in the modern check as well.

Choose a simpler check and extend the optimization to all Intel
processors Family 6 and beyond.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>

---

v2: Make the changelog more precise

---
 arch/x86/kernel/smpboot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index eb91ed0f2a06..871c61df4edb 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -675,9 +675,9 @@ static void __init smp_set_init_udelay(void)
 		return;
 
 	/* if modern processor, use no delay */
-	if (((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) && (boot_cpu_data.x86 == 6)) ||
-	    ((boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) && (boot_cpu_data.x86 >= 0x18)) ||
-	    ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) && (boot_cpu_data.x86 >= 0xF))) {
+	if ((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL && boot_cpu_data.x86_vfm >= INTEL_PENTIUM_PRO) ||
+	    (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON && boot_cpu_data.x86 >= 0x18) ||
+	    (boot_cpu_data.x86_vendor == X86_VENDOR_AMD && boot_cpu_data.x86 >= 0xF)) {
 		init_udelay = 0;
 		return;
 	}
-- 
2.43.0


