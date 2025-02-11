Return-Path: <linux-acpi+bounces-11041-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3B2A315BC
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 20:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D34F7A15A0
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 19:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC71267B80;
	Tue, 11 Feb 2025 19:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PUDboT10"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD07D264F90;
	Tue, 11 Feb 2025 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303198; cv=none; b=TYRbyvXchQjSEmndoTcjaZ53otW7OaR/irnL0VOKx1YBq0rWZrDax3+Cp2f7SCRlBrXdWV84Lh3T5viK26cs4oO16RFHJfJDFD4lMZiKV6EW8CXzRIDMdIwIfB+CSxwJ7Z9dSIYiheSZDJfgXzMuwsnj53NJwyWRyR+jrH6KtfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303198; c=relaxed/simple;
	bh=HUM3PYfPx4VfQRm4ZEm9gV4rFyyvrsXWK8SDOIE+/jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TdskGFJMvmVrqvT4dSZz3V23FBCJPKSr/jOVY1myZeyRSs3fr9VtOT9ZjbW4P0fS8E3CvpeNikPYh7902Bs8Bq6K1MWVdc+5q2o9Ub/tO8QGQ0JT5ydO34OoBDTJlSrljYkcFwyXEQbQsCJzL7HH//0sLzy1tlch5NojQkZ+hUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PUDboT10; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739303196; x=1770839196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HUM3PYfPx4VfQRm4ZEm9gV4rFyyvrsXWK8SDOIE+/jE=;
  b=PUDboT10Nn2zg2wOjGOdoYFq9I71jY+LLapBdHLQh6/IzS0nnQnk5gCF
   qw17rfKeZq7PArxwpEFY5bQ9rCXZLDp6x34MrFwZPvXFviZbvSP7KCNsM
   T+g5r4xVCOXJvGasmUEmnTqJn6GdBfi0nWmR589lfCFAwocs6qS41qcEz
   i2L/zbAiIPm/E27WOHTBBphrJrpTTcIi/ivIF1/4pkJWzoW8MVseFube9
   J4ajJHmjsjwRWUY6yfQ6XuAsCnMFuyOMgsKJ6Gmx2cLbhzyj79pGN+pyK
   KLpFomkvu7FTTFDVWFFbNfRuRTdlKpqpB9HYJA+aijZaQdGgm7yfA9jlX
   w==;
X-CSE-ConnectionGUID: 2MqQ6GwZT/uQIJsg+8XRQg==
X-CSE-MsgGUID: N3Etv/zMQzaYgiPHgOda3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39854929"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39854929"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 11:46:34 -0800
X-CSE-ConnectionGUID: nHwncgvrS9OxBg7CTp/gpg==
X-CSE-MsgGUID: D3Os13sARbGptEQ6KLJwCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="143519287"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa001.fm.intel.com with ESMTP; 11 Feb 2025 11:46:33 -0800
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
Subject: [PATCH v2 09/17] x86/mtrr: Modify a x86_model check to an Intel VFM check
Date: Tue, 11 Feb 2025 19:43:59 +0000
Message-ID: <20250211194407.2577252-10-sohil.mehta@intel.com>
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

Simplify one of the last few Intel x86_model checks in arch/x86 by
substituting it with a VFM one.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>

---

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


