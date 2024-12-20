Return-Path: <linux-acpi+bounces-10230-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9DD9F9C38
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 22:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55EDA1899A8B
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 21:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44DC22B8B3;
	Fri, 20 Dec 2024 21:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nJsfoUIi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D2D22A1E6;
	Fri, 20 Dec 2024 21:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734730765; cv=none; b=T/NghVusGwiuRPaRE9aF+m7VbqdUX0bJkrADq3FhsNK4I+doGt8zSG7xVAwRYSDumTaJ7zMyVE190nbog/SPXIcRqO8xHNMnoKhZ9TlGzTuJu90iWbfgoUy6aYQCKyrfu8jPiwjhtF9u9kRf3cHbPfzCdUOR0y7EpA5xDo0dSBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734730765; c=relaxed/simple;
	bh=nskDi7vWKmYmbEC/bVsVOpL6GgLNfPD5bwlSaoQJlAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANTJGjpxziJEpOPrQ0nGdw2QX71mxBqLzyjYahilsXkpb6sajrEIeGXOIU/MRray/m3UAY8i9k02pnvPboMUJOlDQQ3DNhremi+xDfCAGb/cE0g2gwZkDv9riFh+78VKZJ0V450UmD2QfWmXiX3EWH+d1a7lryCZOnr1OpgIq7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nJsfoUIi; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734730764; x=1766266764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nskDi7vWKmYmbEC/bVsVOpL6GgLNfPD5bwlSaoQJlAk=;
  b=nJsfoUIiP6fIgeeoj8ayj8PHDKinqSbKsCuz6avURX3Vi8dZFYiosDi6
   EHcAJjzhDaGP48nndD3fV0wWFlGpdb4jEKguqznmcyMMZj/THhtaDB2hS
   CngWQx6yteeu02hGJu+O5DqpJL2ZYN6H64BHRnL1Q2aaaCPNbEEP0YVYR
   m8qRIWDj2sG+ZRSWB1TZHYaTZBUa9TulxSkpM1mVOffftGHPSLgpbgsTl
   VvAB92ZhmjTMTgzcsJXG5FjC5VlcYbs1FeQt2MqfrdYl9AoOIPtZ/bdr2
   s6GBaZmdEjIBc1zY1p6/7kkJN8P0ff644hg9Wk2DopiN5JjlgsYolha5V
   g==;
X-CSE-ConnectionGUID: Bsr/BlzJSz+EdSUJfCYfFQ==
X-CSE-MsgGUID: FLnJxrlWSQek4keCOGDl1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="39070747"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="39070747"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 13:39:19 -0800
X-CSE-ConnectionGUID: Y+pEd0TdQgy9J/VxtRPOfA==
X-CSE-MsgGUID: aAIm8e3IShiCRH6xfhcFRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103223859"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa005.fm.intel.com with ESMTP; 20 Dec 2024 13:39:17 -0800
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
Subject: [RFC PATCH 11/15] x86/pat: Replace Intel model checks with VFM ones
Date: Fri, 20 Dec 2024 21:37:06 +0000
Message-ID: <20241220213711.1892696-12-sohil.mehta@intel.com>
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

Introduce markers and names for some family 6 and family 15  models and
replace with VFM based checks.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/include/asm/intel-family.h | 2 ++
 arch/x86/mm/pat/memtype.c           | 7 ++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 025d091be98e..76a184361930 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -186,8 +186,10 @@
 #define INTEL_QUARK_X1000		IFM(5, 0x09) /* Quark X1000 SoC */
 
 /* Family 15 */
+#define INTEL_FAM15_START		IFM(15, 0x00) /* Notational marker */
 #define INTEL_P4_WILLAMETTE		IFM(15, 0x01) /* Also Xeon Foster */
 #define INTEL_P4_PRESCOTT		IFM(15, 0x03)
+#define INTEL_P4_CEDARMILL		IFM(15, 0x06) /* Also Xeon Dempsey */
 
 /* Family 19 */
 #define INTEL_PANTHERCOVE_X		IFM(19, 0x01) /* Diamond Rapids */
diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index feb8cc6a12bf..e6d7dc608b77 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -43,6 +43,7 @@
 #include <linux/fs.h>
 #include <linux/rbtree.h>
 
+#include <asm/cpu_device_id.h>
 #include <asm/cacheflush.h>
 #include <asm/cacheinfo.h>
 #include <asm/processor.h>
@@ -290,9 +291,9 @@ void __init pat_bp_init(void)
 		return;
 	}
 
-	if ((c->x86_vendor == X86_VENDOR_INTEL) &&
-	    (((c->x86 == 0x6) && (c->x86_model <= 0xd)) ||
-	     ((c->x86 == 0xf) && (c->x86_model <= 0x6)))) {
+	if (c->x86_vendor == X86_VENDOR_INTEL &&
+	    ((c->x86_vfm >= INTEL_PENTIUM_PRO && c->x86_vfm <= INTEL_PENTIUM_M_DOTHAN) ||
+	    (c->x86_vfm > INTEL_FAM15_START && c->x86_vfm <= INTEL_P4_CEDARMILL))) {
 		/*
 		 * PAT support with the lower four entries. Intel Pentium 2,
 		 * 3, M, and 4 are affected by PAT errata, which makes the
-- 
2.43.0


