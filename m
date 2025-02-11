Return-Path: <linux-acpi+bounces-11039-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5B5A315B4
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 20:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 193E47A3E19
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 19:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1203265CA4;
	Tue, 11 Feb 2025 19:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hRT4O1pX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08592641DE;
	Tue, 11 Feb 2025 19:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303196; cv=none; b=PaRkkzpHZ6u9HuL7KIjR9M0bveXLN90OcJOjakhJYQOSr5aa5SrvX0/OYJl+aqQQYFZRzuT2g6ChZzXwjIsiVg7CM78XRIJNWMpuaKbJuV2fT7qr0xgXj8V8wTYgLifTAJvBTwQJFy6LHUWCSvpA/OMJZ8SsHcH0XM7WUDrpITA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303196; c=relaxed/simple;
	bh=V/i/5q4uvOA1nS0YV+9rcuMl+w8d2TLzCBnwG4lRfCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HdT3A8yquWDgVu7d6LlEfPcEN+yuJ36e8z+O0q1nU4TJK+Swfbxs2nkWoAUz+BldWkbV+VE7O/THKry8rr2sFWIBWL+5C283tsdsEfXENV0cuJU83U0zX9OZSk6IlwB+Cawc2ihIgq2DlHs5vLtbfxwyyJKmvEykcGph7g1ikQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hRT4O1pX; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739303195; x=1770839195;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V/i/5q4uvOA1nS0YV+9rcuMl+w8d2TLzCBnwG4lRfCs=;
  b=hRT4O1pXDVJFrPueQK8kpQF/NtruYYJMoTEPXjMyb551riePds+rCCM8
   gGORvxPlTsL8TcO57VTWqLHorylF9YWZk3lde1bQ6pAh4sHjUqetdCJI8
   7fOZpmg587fqoW7p118CwX6HZYivZQ0jli9sX8+WSQb1c+1h0kPgZ9OLi
   /2FvOLWPnfvbtXSDBx0/2fulqXN9NRlQGFdiuJ6/Og/RqGuOVe8ouZSAB
   aBedi5XoJOoocuQyWNZdpEHOy/zij/HsrGQJPF94ZlA8TgIgpYIkjnjt+
   s44rf8EbSX8MIxEcg/dGMFBqfN6rs8kbeW5CMHE7yPyYjBm4+A9EIdTqC
   A==;
X-CSE-ConnectionGUID: e0i8vvyPRLmwKLFuQaq/uw==
X-CSE-MsgGUID: vQv8eLGRSkOE0SCtt+n2Mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39854896"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39854896"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 11:46:33 -0800
X-CSE-ConnectionGUID: f0xe5dK8SN+qOP4K5rQcHQ==
X-CSE-MsgGUID: bN7z4DTaTReETxmkzcihnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="143519280"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa001.fm.intel.com with ESMTP; 11 Feb 2025 11:46:32 -0800
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
Subject: [PATCH v2 07/17] hwmon: Fix Intel Family-model checks to include extended Families
Date: Tue, 11 Feb 2025 19:43:57 +0000
Message-ID: <20250211194407.2577252-8-sohil.mehta@intel.com>
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

The current Intel Family-model checks in the coretemp driver seem to
implicitly assume Family 6. Extend the checks to include the extended
Family numbers 18 and 19 as well.

Also, add explicit checks for Family 6 in places where it is assumed
implicitly.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>

---

v2: No change. Pickup Ack from Guenter Roeck.

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


