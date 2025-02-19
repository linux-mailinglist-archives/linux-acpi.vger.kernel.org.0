Return-Path: <linux-acpi+bounces-11313-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D703A3C8C0
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 20:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACB5F189BD44
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 19:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE42022D79C;
	Wed, 19 Feb 2025 19:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B2HWywCh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AEF22D4E7;
	Wed, 19 Feb 2025 19:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739993381; cv=none; b=OINdn5siiIVlY9rIphrFIJqga9pV+b6JBPF+GpTDYp/agNaN4LZHo9SZU+n+h+EzZDoo9ehZZb8+q2spS+w3bnEHoG/gFQfo1QVRMgrMhyve2euFkojZ1uquKKoorWCUVZC1wuWSwCH7SiTePhLSkpjVq5PA4FdX5Zt2rncqXPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739993381; c=relaxed/simple;
	bh=Z7V906WlulIENLuqD38aqu92AY/oFAIHejRUI6piyqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gx+3hXnjZpFjrwH+4eoGooAdaUb+FzMehX+azQ35+pH1poBmVNAFELXvJJscMtN7+AAOJGbRFOsYLM2ZDBLAC5T/rlX4V2+MSJ485J+42Woh8bP1wkJl6ARWeJAvhQgZ1q89MGuyJRwcf3u2ijyShRIgzVJE1P+Gd0vnDXZDW1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B2HWywCh; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739993380; x=1771529380;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z7V906WlulIENLuqD38aqu92AY/oFAIHejRUI6piyqI=;
  b=B2HWywChCnpgEmBKhmj0lNnyX8IAmPjjSNnlXxtV2vTi2WcDgngDuX2S
   5/aySlCnc0nXAZYVrhQbX9/0+L2ja8sYXVqOU5P6lFgqIvr04fZ/lOhqw
   WzxHfFxrHmHyAiqb7j96NSpFT1HvsnPCRcVGucigy2CcVKae04z3Ogy2o
   evrQ5PFNpD7iqZbrwWQzJRnlETJ2dMfxEjv3+193aF0Bw2uKk5Z36APh1
   s4VK9zCBhNnyHb0yP2cGPsWqMEHPK2Vx3uf0Uir/UZ+5ZdUreYHjeKY46
   OBQwhmOKsgh9mAZfGSS4XUG+XF/Kx4FxKjDrIUSzEPSf8RKU3XBP/v88u
   w==;
X-CSE-ConnectionGUID: jnkMXuDVQlCfZM+Uj3l70Q==
X-CSE-MsgGUID: 4a7reIGKSS6PDVhzLfL7xA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52182990"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52182990"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 11:29:39 -0800
X-CSE-ConnectionGUID: Chmk76SWRmmLrviLrkjnJA==
X-CSE-MsgGUID: EUrRt8CGTs2uznCUO0yqQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="115344046"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa010.fm.intel.com with ESMTP; 19 Feb 2025 10:49:07 -0800
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
Subject: [PATCH v3 10/15] x86/smpboot: Fix INIT delay assignment for extended Intel Families
Date: Wed, 19 Feb 2025 18:41:28 +0000
Message-ID: <20250219184133.816753-11-sohil.mehta@intel.com>
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

Some old crusty CPUs need an extra delay that slows down booting. See
the comment above 'init_udelay' for details. Newer CPUs don't need the
delay.

Right now, for Intel, Family 6 and only Family 6 skips the delay. That
leaves out both the Family 15 (Pentium 4s) and brand new Family 18/19
models.

The omission of Family 15 (Pentium 4s) seems like an oversight and 18/19
do not need the delay.

Skip the delay on all Intel processors Family 6 and beyond.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v3: Improve commit message
v2: Make the changelog more precise
---
 arch/x86/kernel/smpboot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index eb91ed0f2a06..57e7b6441384 100644
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
+	    (boot_cpu_data.x86_vendor == X86_VENDOR_AMD   && boot_cpu_data.x86 >= 0xF)) {
 		init_udelay = 0;
 		return;
 	}
-- 
2.43.0


