Return-Path: <linux-acpi+bounces-11315-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFF0A3C8C8
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 20:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9133B2C6A
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 19:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362ED233141;
	Wed, 19 Feb 2025 19:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eq1K0SP0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB25230D2B;
	Wed, 19 Feb 2025 19:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739993392; cv=none; b=u/vrEjkjfPv/Dsv4qGVkY5o+SuSnT/hi89r6LGKEDkQEp9t3UzGXsXuFYA+P2zmr1CROAWlgA1PGWnqr6icARfFCAuZdDwPxBsnnFz4G0JqMvPZ+ioV5quuPpjEnO6la676MeitIGJqVWsN37NyNE0S7WKoddlXO3PagGDEgW2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739993392; c=relaxed/simple;
	bh=efC62GOuBd6EmcOJoj7xSMoKa7ryCi1TEhBuhf/fdJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TRs2Xg9VtYbRhAIp6bzmg695RG2SsqewJ7EZ8O9SXxRUC6wM7bQjwL9aOxEJW79wxB5g0JFnYQrEGSzMU0HQakUwXvqDFTbszSOED4Di00bRann4CfrkElJjffT/XRFWyBGyg9xMTyffAokhIhOjrCRMojk4kYgCrFd7YkdSLI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eq1K0SP0; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739993391; x=1771529391;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=efC62GOuBd6EmcOJoj7xSMoKa7ryCi1TEhBuhf/fdJg=;
  b=Eq1K0SP0Bo15nJG4EbdLHTR1NHAot4qV/t7AHCbuHxYA3Kqx+hgCe4vd
   AbKOtDDm5kP4Wlc4kFjD3qA82g9kxW0ypjua2U5QecSinbAHK5BkUsADz
   8YWVYXOHAb2UoTqK8RmgH8rvgfofwrudOyMxOZ7C1SUIfw+U63FsNDO+s
   vveeA1cY2Y9LkNSZD/NSwsJAc+BH9Q4DpXS1RYvtH3azyqI1r2Ya379um
   dR2TPDYTDiURk0QBJLa4oGRuH0kezXTbXG2kiSDm5tBSP2O1QQG4Nut4N
   nnuTjmRHvZH7wIoSyB+1WaPUPrfej+I/Z4fmk5F9jl+0XX3mn6Gm4hH+M
   A==;
X-CSE-ConnectionGUID: NJb/wG/uR4+UiccouLc5Ng==
X-CSE-MsgGUID: fzLxqrifQZuBC/IUH/i7Gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52183049"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52183049"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 11:29:50 -0800
X-CSE-ConnectionGUID: 8covmJoISUe/ensB1ZQhrw==
X-CSE-MsgGUID: bMfWny8oRGyG234eB2VWPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="115344062"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa010.fm.intel.com with ESMTP; 19 Feb 2025 10:49:57 -0800
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
Subject: [PATCH v3 12/15] x86/pat: Replace Intel x86_model checks with VFM ones
Date: Wed, 19 Feb 2025 18:41:30 +0000
Message-ID: <20250219184133.816753-13-sohil.mehta@intel.com>
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

Introduce markers and names for some Family 6 and Family 15 models and
replace x86_model checks with VFM ones.

Since the VFM checks are closed ended and only applicable to Intel, get
rid of the explicit Intel vendor check as well.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v3: Get rid of the Intel vendor check.
v2: Get rid of the INTEL_FAM15_START IFM(15, 0x00) define.
---
 arch/x86/include/asm/intel-family.h | 1 +
 arch/x86/mm/pat/memtype.c           | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index deb17c9c21e5..6621d796bb3d 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -193,6 +193,7 @@
 /* Family 15 - NetBurst */
 #define INTEL_P4_WILLAMETTE		IFM(15, 0x01) /* Also Xeon Foster */
 #define INTEL_P4_PRESCOTT		IFM(15, 0x03)
+#define INTEL_P4_CEDARMILL		IFM(15, 0x06) /* Also Xeon Dempsey */
 
 /* Family 19 */
 #define INTEL_PANTHERCOVE_X		IFM(19, 0x01) /* Diamond Rapids */
diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index feb8cc6a12bf..e40861c9cb90 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -43,6 +43,7 @@
 #include <linux/fs.h>
 #include <linux/rbtree.h>
 
+#include <asm/cpu_device_id.h>
 #include <asm/cacheflush.h>
 #include <asm/cacheinfo.h>
 #include <asm/processor.h>
@@ -290,9 +291,8 @@ void __init pat_bp_init(void)
 		return;
 	}
 
-	if ((c->x86_vendor == X86_VENDOR_INTEL) &&
-	    (((c->x86 == 0x6) && (c->x86_model <= 0xd)) ||
-	     ((c->x86 == 0xf) && (c->x86_model <= 0x6)))) {
+	if ((c->x86_vfm >= INTEL_PENTIUM_PRO   && c->x86_vfm <= INTEL_PENTIUM_M_DOTHAN) ||
+	    (c->x86_vfm >= INTEL_P4_WILLAMETTE && c->x86_vfm <= INTEL_P4_CEDARMILL)) {
 		/*
 		 * PAT support with the lower four entries. Intel Pentium 2,
 		 * 3, M, and 4 are affected by PAT errata, which makes the
-- 
2.43.0


