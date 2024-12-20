Return-Path: <linux-acpi+bounces-10224-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5789F9C1D
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 22:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D945188F113
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 21:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA89229135;
	Fri, 20 Dec 2024 21:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TfJJVL0q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC23227B8B;
	Fri, 20 Dec 2024 21:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734730761; cv=none; b=SZR4Ad5hWPM/h5AwmFe02n2/radMp+J/iAoJhKAQw6WGMzDrXBAn40kCXj2VqjXT9EeErNmhP3jvOJ6AuFNM0mpyFuczftXEX2O05PYtjRUPqSUBPVxQmbnt1qXvGTKsV3gJW6kLGxz2fnGDImBdxelxED4nnr7p+sYGbX3bpu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734730761; c=relaxed/simple;
	bh=RigSsP0koHKo+ynGNOr65xWILzziWrY3/A9JCpL5ADo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSR5LaeTRouuNqJyGC02KpgFjpnKt8pAknBNW0kjBr7YLUGrL+DTt6H3KVK3UpD0e6KAPO5AXdOBSEt/d9mAT4eLB1Qd0455aUx8QKrsen1kfe8hZQthDQncodGpBY3J5qUTxRZ+m3TUpB0qq7pmoHrHRlALW0MxRdvLQlOlGB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TfJJVL0q; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734730760; x=1766266760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RigSsP0koHKo+ynGNOr65xWILzziWrY3/A9JCpL5ADo=;
  b=TfJJVL0q9EaOmessQtHeRqvcRoZxvjSClRJG4Amo1DjNz/02hbo6xOkB
   zxsjo54CgJJ/HTJd8EwZHenFxNiQYKYo8RrdnZ8qAIG+QQm6RPAogvKEs
   MLCC5n10t6izeXL4RFpVW9SRdkcrc7E8V9JMFIzrzh8dk8fSgK5aG8qr/
   YV46cvgMtVq6j3wN/wVLsWgC92qofyj4KuCyHXlEAZAYQ/N8thG8Fi1WP
   hVoKKh19XT8pIYSD0jBMl6YWse1tkXjp0hO0wGr/tkSIRO3ZYHmFmH0su
   vSFxXXMRarQIWEzt7jqMS2ovFmoCL8HLhKl63BX7UwHFwIdYsToqCn7Sl
   Q==;
X-CSE-ConnectionGUID: 2knWKvOmRL2WL/7iqfrQMA==
X-CSE-MsgGUID: Nn6B5KuSSzqpNkPBtX/k9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="39070675"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="39070675"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 13:39:17 -0800
X-CSE-ConnectionGUID: PBznrhb5Qh2lUv/z1yIlCA==
X-CSE-MsgGUID: gfYDJXLvQYeCdMHnJRJLng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103223841"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa005.fm.intel.com with ESMTP; 20 Dec 2024 13:39:15 -0800
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
Subject: [RFC PATCH 05/15] hwmon: Fix Intel family checks to include extended family numbers
Date: Fri, 20 Dec 2024 21:37:00 +0000
Message-ID: <20241220213711.1892696-6-sohil.mehta@intel.com>
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

The current Intel family-model checks in the coretemp driver seem to
implicitly assume family 6. Extend the checks to include the extended
family numbers beyond 15 as well.

Also, add explicit checks for family 6 in places where it is assumed
implicitly.

x86_model checks seem inconsistent and scattered throughout the driver.
Consolidating and converting them to VFM ones would be a useful addition
in future.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 drivers/hwmon/coretemp.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 1b9203b20d70..1aa67a2b5f18 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -185,6 +185,13 @@ static int adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
 			return tjmax_table[i].tjmax;
 	}
 
+	/*
+	 * Return without adjustment if the Family isn't 6.
+	 * The rest of the function assumes Family 6.
+	 */
+	if (c->x86 != 6)
+		return tjmax;
+
 	for (i = 0; i < ARRAY_SIZE(tjmax_model_table); i++) {
 		const struct tjmax_model *tm = &tjmax_model_table[i];
 		if (c->x86_model == tm->model &&
@@ -260,14 +267,17 @@ static int adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
 
 static bool cpu_has_tjmax(struct cpuinfo_x86 *c)
 {
+	u8 family = c->x86;
 	u8 model = c->x86_model;
 
-	return model > 0xe &&
-	       model != 0x1c &&
-	       model != 0x26 &&
-	       model != 0x27 &&
-	       model != 0x35 &&
-	       model != 0x36;
+	return family > 15 ||
+	       (family == 6 &&
+		model > 0xe &&
+		model != 0x1c &&
+		model != 0x26 &&
+		model != 0x27 &&
+		model != 0x35 &&
+		model != 0x36);
 }
 
 static int get_tjmax(struct temp_data *tdata, struct device *dev)
@@ -460,7 +470,7 @@ static int chk_ucode_version(unsigned int cpu)
 	 * Readings might stop update when processor visited too deep sleep,
 	 * fixed for stepping D0 (6EC).
 	 */
-	if (c->x86_model == 0xe && c->x86_stepping < 0xc && c->microcode < 0x39) {
+	if (c->x86 == 6 && c->x86_model == 0xe && c->x86_stepping < 0xc && c->microcode < 0x39) {
 		pr_err("Errata AE18 not fixed, update BIOS or microcode of the CPU!\n");
 		return -ENODEV;
 	}
@@ -580,7 +590,7 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
 	 * MSR_IA32_TEMPERATURE_TARGET register. Atoms don't have the register
 	 * at all.
 	 */
-	if (c->x86_model > 0xe && c->x86_model != 0x1c)
+	if (c->x86 > 15 || (c->x86 == 6 && c->x86_model > 0xe && c->x86_model != 0x1c))
 		if (get_ttarget(tdata, &pdev->dev) >= 0)
 			tdata->attr_size++;
 
-- 
2.43.0


