Return-Path: <linux-acpi+bounces-10220-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5D99F9C0C
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 22:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA712188B1C6
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 21:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9090322655E;
	Fri, 20 Dec 2024 21:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QnIaGu5V"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0128157A48;
	Fri, 20 Dec 2024 21:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734730758; cv=none; b=J4HYl/OwVd5IxRiaP3LUfziJDj1ePd/8jOsC7/W3O5a2GG7jOU7bTXHX/G0Wl+a6Qvp/MEOCQXubepIzharDoWdiayu4YoYnM6TeZnGBFn7wJLUbt+76J294z1beh8zc23HzeG1ub5PrUH8eaMxttz0173nXJoTaSBNsfpo+XEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734730758; c=relaxed/simple;
	bh=WGLszqkcK4qS7XxdeQwaV9JLA+JQQF8TjunUmB8Arzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfNJ+kJrq3fEwsbRDoSeuqxLap2tZIl4w76u3vbKvP6tWNvzckuMf++8EYicwsQjk6xZMQLl5QY7F1D5uNc4lOGywlL78qHONvQDbBcFbJrFjA9ACnbkyBoKDF8qL9aEJfbvbKEbvJDLV39bGlMxkWHyvBdWQTBKMYjM+JTc2og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QnIaGu5V; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734730757; x=1766266757;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WGLszqkcK4qS7XxdeQwaV9JLA+JQQF8TjunUmB8Arzk=;
  b=QnIaGu5VrJHl8Fr7spuz2bIMVgllyN6qvLPazvhzVkid/X0+7Ymmgnao
   vMSH22z7yDbp3YZWEBnbndWQbpd8LKvyHtHDIn2NwtRJdLjSnx4Qhp3GJ
   ynsLzhrFv+2O3wyjA4PoejSYQKtff0NfCXovdu0+d/pba1ATbBAdfdUVS
   NdOKnfAFduU3HJR1xeOPaTcPZtfKDZX/XeCwtVml8oSfZ5I1FJMhCNy69
   gk9Sga+5ZjIl1sMZXzLILRk6XlsM4b9a1PpO5VEFqWRGDs50RyEcowGHk
   78/QoAi+iOMETOiUJEC+aMIHxJyuSEswP8WiLMZXF/yUNIA/DGX4cnoMZ
   A==;
X-CSE-ConnectionGUID: QYQxpPyrT+CHS+mVIbks2Q==
X-CSE-MsgGUID: WRoyM0OfTg+EJA3GhdPK4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="39070617"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="39070617"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 13:39:15 -0800
X-CSE-ConnectionGUID: /tMvC+22Rb+rT6uaVbKJBQ==
X-CSE-MsgGUID: vrXDA1jARrSxFxpmx5mnvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103223826"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa005.fm.intel.com with ESMTP; 20 Dec 2024 13:39:14 -0800
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
Subject: [RFC PATCH 01/15] x86/apic: Fix 32-bit APIC initialization for extended Intel families
Date: Fri, 20 Dec 2024 21:36:56 +0000
Message-ID: <20241220213711.1892696-2-sohil.mehta@intel.com>
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

detect_init_APIC() limits the APIC detection to families 6 and 15.
Extend the check to family numbers beyond 15. Also, convert it to a VFM
check to make it simpler.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/kernel/apic/apic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index c5fb28e6451a..13dac8f78213 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2014,8 +2014,8 @@ static bool __init detect_init_APIC(void)
 	case X86_VENDOR_HYGON:
 		break;
 	case X86_VENDOR_INTEL:
-		if (boot_cpu_data.x86 == 6 || boot_cpu_data.x86 == 15 ||
-		    (boot_cpu_data.x86 == 5 && boot_cpu_has(X86_FEATURE_APIC)))
+		if ((boot_cpu_data.x86 == 5 && boot_cpu_has(X86_FEATURE_APIC)) ||
+		    boot_cpu_data.x86_vfm >= INTEL_PENTIUM_PRO)
 			break;
 		goto no_apic;
 	default:
-- 
2.43.0


