Return-Path: <linux-acpi+bounces-10226-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA509F9C24
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 22:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC0E188EF28
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 21:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3573222968C;
	Fri, 20 Dec 2024 21:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WZp59ZRD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588A42288D0;
	Fri, 20 Dec 2024 21:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734730762; cv=none; b=YutwSDm6h1xfvmsBjostNyFC28TNMNhTFX9Dw7UjAKK7293UrWGZf2ruUyokaeJMPE/sH5RxxZN9HOh8bv9zT3R9k48IEspzEHZezVpc1oppqVkDRPbVpgEIWaq7/yKrZA6itv+vrMNQNYxy81c9ClcqmqlzdZ9niy3VCsSjowo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734730762; c=relaxed/simple;
	bh=mBOSa7vDktow9RtpDWMVAM+JsLjZGeJOv/UXCTAQnh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WLmbFoZ6Q4K2XLtBNK+mB4hOqklSEnW75YyCd2cxJib8o1XhlCHVTgI9I8vyabHPKEbkftiUZlGNFon9W94gZk+NnVzJcZIn0A/M9l49XGsRMVLWsC51oEx+ikVvOp3BcdTz5KBeLmt+0R4adt29MlI0Uzz3eao5cV9pi8SgCTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WZp59ZRD; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734730761; x=1766266761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mBOSa7vDktow9RtpDWMVAM+JsLjZGeJOv/UXCTAQnh8=;
  b=WZp59ZRDAWTQyYhBYGemsPH/QSR74X/I7377lHiR945Sl7Ct4PJTNWdn
   OpDDjkrAc9GjbZNyXTrGIAPYxHYTP4xrSVpOfxKxsGXzqycrCXQKIrDWK
   Tk3dPO+ZwuDkzBGp3gyxHA+O74g0pJVtFheP3SfnfzZ7c05d5CngSuaV8
   U4SKwT7GH4lDCAO8pK72ozdBNsgXe3R730DnOYfM3B2M1A5679IE1pAJ/
   923Fwhzl/+o/YOCeipdwAFzOdzXHL5kwCV47wBBHrxyxdr//uz9SEopXE
   fEQ4vttuTWVWyLlDwVpFm82OVYt7YAWeVLOEoCTIC48UIOj5PTv/nz69W
   Q==;
X-CSE-ConnectionGUID: DPJAckaOSB6GAB8iZROAQQ==
X-CSE-MsgGUID: 85V2fY6/Tby6ErtMU8GSqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="39070678"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="39070678"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 13:39:17 -0800
X-CSE-ConnectionGUID: j7vMtVUiQe+fZBGZnTTYqQ==
X-CSE-MsgGUID: oYZyDvjSRK2xHeqVxAOFuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103223844"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa005.fm.intel.com with ESMTP; 20 Dec 2024 13:39:16 -0800
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
Subject: [RFC PATCH 06/15] x86/microcode: Update the Intel processor flag scan check
Date: Fri, 20 Dec 2024 21:37:01 +0000
Message-ID: <20241220213711.1892696-7-sohil.mehta@intel.com>
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

The check whether to read IA32_PLATFORM_ID MSR is misleading. It doesn't
seem to consider family while comparing the model number. This works
because init_intel_microcode() bails out if the processor family is less
than 6. It is better to update the current check to specifically include
family 6.

Ideally, a VFM check would make it more readable. But, there isn't a
macro to derive VFM from sig.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/kernel/cpu/microcode/intel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index f3d534807d91..734819a12d5f 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -74,7 +74,8 @@ void intel_collect_cpu_info(struct cpu_signature *sig)
 	sig->pf = 0;
 	sig->rev = intel_get_microcode_revision();
 
-	if (x86_model(sig->sig) >= 5 || x86_family(sig->sig) > 6) {
+	/* TODO: Simplify this using a VFM check? */
+	if ((x86_family(sig->sig) == 6 && x86_model(sig->sig) >= 5) || x86_family(sig->sig) > 6) {
 		unsigned int val[2];
 
 		/* get processor flags from MSR 0x17 */
-- 
2.43.0


