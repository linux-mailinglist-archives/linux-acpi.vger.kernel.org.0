Return-Path: <linux-acpi+bounces-11307-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F5DA3C8A9
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 20:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EFA51891393
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 19:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E0522AE7E;
	Wed, 19 Feb 2025 19:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hHA9oF0D"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D480F1F3FC8;
	Wed, 19 Feb 2025 19:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739993342; cv=none; b=ZhomiBIOZBlqAGFfteXCPksrTctaSa1uIW+1YJ+zRiKvoJ0P0qjZNP2qFYxzdFDEh+ZHHiPvLtIdxdK6fcrxrjOavLKE6RwROKtinIGYB3IC+LfTLAp0kqmqZlP9xtJU23HtZ7+exhgIGTQ6dKNgbO9LZUM6fVIYhaazohOPssM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739993342; c=relaxed/simple;
	bh=R7JhdOBsOQPdSbgCruIjrXivbKrDKZdPOdsum6ZxC2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGhosPuAoVIpgFnK8RgGVilg1AFvLz2/i8D5Xi6IhPhgk5ID5+iMf3XLWuafA7eAp8k5VzqCtPz1s4bXLDO1T15FMyZZwcmUobpU3ff97VNTHJj7VfiGPFJwkKHtm9l1Kw9Fgjw27rdBHvT2ENlJoVcGpsFJiSL97U3eezioKPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hHA9oF0D; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739993341; x=1771529341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R7JhdOBsOQPdSbgCruIjrXivbKrDKZdPOdsum6ZxC2Q=;
  b=hHA9oF0Dr6Vwrrnfo0XbTp3KHonDqDYK1N6uK8Yn8J3P53S5VxCADmE8
   8UpTmvVMIUizzNsqjTmYoq6VVT0xtWvDD1Yw13MiC0Y63NMFlM7rlB96w
   l39sipNOfReN+3MpsMV4XhrCdVMeXN5io719TdmB167C9AhCBLibEvx4E
   TynuilULlQmojQw1iIj4m+oHmd7/AAOag4uofmO6xhZizoaYonlpLHkcy
   hqW8YXScHitjrSMHffiaCRUSYTf1FCwlP3nJpPn+x0wHaMxGJvOIvCMhw
   GmmMWkcXfHJTBptVEMOe20IC2egPna2fdpBo6etSeM3hYpM3AQtcUXRKC
   A==;
X-CSE-ConnectionGUID: 6kmL+/p/TtKdBM7ZKOfZIg==
X-CSE-MsgGUID: 0K0crY1wTxmyxEfjWyACzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52182847"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52182847"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 11:29:00 -0800
X-CSE-ConnectionGUID: qGiUzr7USGub5fNVbp3w0Q==
X-CSE-MsgGUID: ohGR5sAuTfKbayN2NNUa8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="115344018"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa010.fm.intel.com with ESMTP; 19 Feb 2025 10:46:25 -0800
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
Subject: [PATCH v3 04/15] x86/mtrr: Modify a x86_model check to an Intel VFM check
Date: Wed, 19 Feb 2025 18:41:22 +0000
Message-ID: <20250219184133.816753-5-sohil.mehta@intel.com>
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

Simplify one of the last few Intel x86_model checks in arch/x86 by
substituting it with a VFM one.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
---
v3: Picked up Dave's Ack.
v2: No change.
---
 arch/x86/kernel/cpu/mtrr/generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 2fdfda2b60e4..826b8cff33cf 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -12,6 +12,7 @@
 #include <asm/processor-flags.h>
 #include <asm/cacheinfo.h>
 #include <asm/cpufeature.h>
+#include <asm/cpu_device_id.h>
 #include <asm/hypervisor.h>
 #include <asm/mshyperv.h>
 #include <asm/tlbflush.h>
@@ -1025,8 +1026,7 @@ int generic_validate_add_page(unsigned long base, unsigned long size,
 	 * For Intel PPro stepping <= 7
 	 * must be 4 MiB aligned and not touch 0x70000000 -> 0x7003FFFF
 	 */
-	if (mtrr_if == &generic_mtrr_ops && boot_cpu_data.x86 == 6 &&
-	    boot_cpu_data.x86_model == 1 &&
+	if (mtrr_if == &generic_mtrr_ops && boot_cpu_data.x86_vfm == INTEL_PENTIUM_PRO &&
 	    boot_cpu_data.x86_stepping <= 7) {
 		if (base & ((1 << (22 - PAGE_SHIFT)) - 1)) {
 			pr_warn("mtrr: base(0x%lx000) is not 4 MiB aligned\n", base);
-- 
2.43.0


