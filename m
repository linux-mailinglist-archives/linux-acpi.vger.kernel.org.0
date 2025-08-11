Return-Path: <linux-acpi+bounces-15583-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBA8B20040
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Aug 2025 09:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 067FF1760CC
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Aug 2025 07:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2A82D9792;
	Mon, 11 Aug 2025 07:27:37 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB94A2D879D;
	Mon, 11 Aug 2025 07:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754897257; cv=none; b=TW0AVdatX11Y0+xaxrj9cl7BSAu7hyC+sS/JFSFA/3viOZk4Lm27ED26xuJk1783dh4J0pdDCrt+F77q51jtORCq7sQNoy5n+DX5y12Sch49G9nN0taCnyWeAuO1O23Ckvr6495nHKzprD8B5SZGrsB/p5cM5s0GPFRyCw3ezac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754897257; c=relaxed/simple;
	bh=7In0APipBxYztvMciKOwywMsghjmq6Nbt71Lm7V7KOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sub2jO5SREOZ7Be5qtuEVlyfJZUfizPlq325da1jOa2uQEJyZL5dQsqrIaKCwidCSjPZAGsDjgKM2I7Md1h7rTFoPHI/QC2FGAj3k2d9p85I1mYEClTb3C60rPO4txxfS0yzRHRByFSdSu2VfMS+Zms/YaMKL4gxFOoEEQQ1N4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a281b462768411f0b29709d653e92f7d-20250811
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF
	CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:0d026300-57ae-43b8-b99b-ffdbed3ba909,IP:10,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-10
X-CID-INFO: VERSION:1.1.45,REQID:0d026300-57ae-43b8-b99b-ffdbed3ba909,IP:10,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-10
X-CID-META: VersionHash:6493067,CLOUDID:7e0d3e1ee74fae7613c1de3ccc5d5296,BulkI
	D:250811152729XBBZWQNU,BulkQuantity:0,Recheck:0,SF:19|23|38|43|66|72|74|78
	|81|82|102,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-UUID: a281b462768411f0b29709d653e92f7d-20250811
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(106.16.203.49)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 660309298; Mon, 11 Aug 2025 15:27:28 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	lenb@kernel.org,
	robert.moore@intel.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Yaxiong Tian <tianyaxiong@kylinos.cn>,
	Shaobo Huang <huangshaobo2075@phytium.com.cn>,
	Yinfeng Wang <wangyinfeng@phytium.com.cn>,
	Xu Wang <wangxu@phytium.com.cn>
Subject: [PATCH 2/2] ACPI: processor: idle: Replace single idle driver with per-CPU model for better hybrid CPU support
Date: Mon, 11 Aug 2025 15:27:23 +0800
Message-Id: <20250811072723.762608-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250811072349.753478-1-tianyaxiong@kylinos.cn>
References: <20250811072349.753478-1-tianyaxiong@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current implementations of hybrid architectures (e.g., ARM64 big.LITTLE
and Intel Alder Lake) feature CPU cores with different exit latencies.
Using a single driver to describe_LPI states for all core types is
therefore suboptimal. This is further supported by ACPI specification
8.4.4.1 which states: "In a processor hierarchy, each node has its
own _LPI low-power states specific to that node."

To address these limitations, we replace the monolithic idle driver
with a per-CPU model. This approach enables accurate idle state representation
for each core type

Tested-by: Shaobo Huang <huangshaobo2075@phytium.com.cn>
Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
Signed-off-by: Shaobo Huang <huangshaobo2075@phytium.com.cn>
Signed-off-by: Yinfeng Wang <wangyinfeng@phytium.com.cn>
Signed-off-by: Xu Wang<wangxu@phytium.com.cn>
---
 drivers/acpi/Kconfig            |  1 +
 drivers/acpi/processor_driver.c |  3 +-
 drivers/acpi/processor_idle.c   | 60 ++++++++++++++++-----------------
 include/acpi/processor.h        |  2 +-
 4 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ca00a5dbcf75..d92c0faca978 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -276,6 +276,7 @@ config ACPI_PROCESSOR_CSTATE
 config ACPI_PROCESSOR_IDLE
 	bool
 	select CPU_IDLE
+	select CPU_IDLE_MULTIPLE_DRIVERS
 
 config ACPI_MCFG
 	bool
diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 65e779be64ff..22db9c904437 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -166,7 +166,8 @@ static int __acpi_processor_start(struct acpi_device *device)
 	if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
 		dev_dbg(&device->dev, "CPPC data invalid or not present\n");
 
-	if (!cpuidle_get_driver() || cpuidle_get_driver() == &acpi_idle_driver)
+	if (!cpuidle_get_cpu_driver_by_cpu(pr->id) || cpuidle_get_cpu_driver_by_cpu(pr->id)
+			== per_cpu_ptr(&acpi_idle_driver, pr->id))
 		acpi_processor_power_init(pr);
 
 	acpi_pss_perf_init(pr);
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 2c2dc559e0f8..4922110da0bf 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -51,15 +51,12 @@ module_param(latency_factor, uint, 0644);
 
 static DEFINE_PER_CPU(struct cpuidle_device *, acpi_cpuidle_device);
 
-struct cpuidle_driver acpi_idle_driver = {
-	.name =		"acpi_idle",
-	.owner =	THIS_MODULE,
-};
+DEFINE_PER_CPU(struct cpuidle_driver, acpi_idle_driver);
 
 #ifdef CONFIG_ACPI_PROCESSOR_CSTATE
 void acpi_idle_rescan_dead_smt_siblings(void)
 {
-	if (cpuidle_get_driver() == &acpi_idle_driver)
+	if (cpuidle_get_driver() == this_cpu_ptr(&acpi_idle_driver))
 		arch_cpu_rescan_dead_smt_siblings();
 }
 
@@ -738,12 +735,13 @@ static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
 	int i, count = ACPI_IDLE_STATE_START;
 	struct acpi_processor_cx *cx;
 	struct cpuidle_state *state;
+	struct cpuidle_driver *drv = per_cpu_ptr(&acpi_idle_driver, pr->id);
 
 	if (max_cstate == 0)
 		max_cstate = 1;
 
 	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER && i <= max_cstate; i++) {
-		state = &acpi_idle_driver.states[count];
+		state = &drv->states[count];
 		cx = &pr->power.states[i];
 
 		if (!cx->valid)
@@ -776,7 +774,7 @@ static int acpi_processor_setup_cstates(struct acpi_processor *pr)
 	int i, count;
 	struct acpi_processor_cx *cx;
 	struct cpuidle_state *state;
-	struct cpuidle_driver *drv = &acpi_idle_driver;
+	struct cpuidle_driver *drv = per_cpu_ptr(&acpi_idle_driver, pr->id);
 
 	if (max_cstate == 0)
 		max_cstate = 1;
@@ -1198,7 +1196,7 @@ static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
 	int i;
 	struct acpi_lpi_state *lpi;
 	struct cpuidle_state *state;
-	struct cpuidle_driver *drv = &acpi_idle_driver;
+	struct cpuidle_driver *drv = per_cpu_ptr(&acpi_idle_driver, pr->id);
 
 	if (!pr->flags.has_lpi)
 		return -EOPNOTSUPP;
@@ -1232,7 +1230,7 @@ static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
 static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
 {
 	int i;
-	struct cpuidle_driver *drv = &acpi_idle_driver;
+	struct cpuidle_driver *drv = per_cpu_ptr(&acpi_idle_driver, pr->id);
 
 	if (!pr->flags.power_setup_done || !pr->flags.power)
 		return -EINVAL;
@@ -1316,13 +1314,7 @@ int acpi_processor_power_state_has_changed(struct acpi_processor *pr)
 	if (!pr->flags.power_setup_done)
 		return -ENODEV;
 
-	/*
-	 * FIXME:  Design the ACPI notification to make it once per
-	 * system instead of once per-cpu.  This condition is a hack
-	 * to make the code that updates C-States be called once.
-	 */
-
-	if (pr->id == 0 && cpuidle_get_driver() == &acpi_idle_driver) {
+	if (cpuidle_get_cpu_driver_by_cpu(pr->id) == per_cpu_ptr(&acpi_idle_driver, pr->id)) {
 
 		/* Protect against cpu-hotplug */
 		cpus_read_lock();
@@ -1360,12 +1352,14 @@ int acpi_processor_power_state_has_changed(struct acpi_processor *pr)
 	return 0;
 }
 
-static int acpi_processor_registered;
 
 int acpi_processor_power_init(struct acpi_processor *pr)
 {
 	int retval;
+	struct cpumask *cpumask;
 	struct cpuidle_device *dev;
+	struct cpuidle_driver *drv = per_cpu_ptr(&acpi_idle_driver, pr->id);
+
 
 	if (disabled_by_idle_boot_param())
 		return 0;
@@ -1382,14 +1376,21 @@ int acpi_processor_power_init(struct acpi_processor *pr)
 	 */
 	if (pr->flags.power) {
 		/* Register acpi_idle_driver if not already registered */
-		if (!acpi_processor_registered) {
-			acpi_processor_setup_cpuidle_states(pr);
-			retval = cpuidle_register_driver(&acpi_idle_driver);
-			if (retval)
-				return retval;
-			pr_debug("%s registered with cpuidle\n",
-				 acpi_idle_driver.name);
+		acpi_processor_setup_cpuidle_states(pr);
+
+		drv->name = "acpi_idle";
+		drv->owner = THIS_MODULE;
+		cpumask = kzalloc(cpumask_size(), GFP_KERNEL);
+		cpumask_set_cpu(pr->id, cpumask);
+		drv->cpumask = cpumask;
+
+		retval = cpuidle_register_driver(drv);
+		if (retval) {
+			kfree(cpumask);
+			return retval;
 		}
+		pr_debug("cpu %d:%s registered with cpuidle\n", pr->id,
+			 drv->name);
 
 		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 		if (!dev)
@@ -1403,11 +1404,10 @@ int acpi_processor_power_init(struct acpi_processor *pr)
 		 */
 		retval = cpuidle_register_device(dev);
 		if (retval) {
-			if (acpi_processor_registered == 0)
-				cpuidle_unregister_driver(&acpi_idle_driver);
+			cpuidle_unregister_driver(drv);
+			kfree(cpumask);
 			return retval;
 		}
-		acpi_processor_registered++;
 	}
 	return 0;
 }
@@ -1415,17 +1415,17 @@ int acpi_processor_power_init(struct acpi_processor *pr)
 int acpi_processor_power_exit(struct acpi_processor *pr)
 {
 	struct cpuidle_device *dev = per_cpu(acpi_cpuidle_device, pr->id);
+	struct cpuidle_driver *drv = per_cpu_ptr(&acpi_idle_driver, pr->id);
 
 	if (disabled_by_idle_boot_param())
 		return 0;
 
 	if (pr->flags.power) {
 		cpuidle_unregister_device(dev);
-		acpi_processor_registered--;
-		if (acpi_processor_registered == 0)
-			cpuidle_unregister_driver(&acpi_idle_driver);
+		cpuidle_unregister_driver(drv);
 
 		kfree(dev);
+		kfree(drv->cpumask);
 	}
 
 	pr->flags.power_setup_done = 0;
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index d0eccbd920e5..36940c6b96cc 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -417,7 +417,7 @@ static inline void acpi_processor_throttling_init(void) {}
 #endif	/* CONFIG_ACPI_CPU_FREQ_PSS */
 
 /* in processor_idle.c */
-extern struct cpuidle_driver acpi_idle_driver;
+DECLARE_PER_CPU(struct cpuidle_driver, acpi_idle_driver);
 #ifdef CONFIG_ACPI_PROCESSOR_IDLE
 int acpi_processor_power_init(struct acpi_processor *pr);
 int acpi_processor_power_exit(struct acpi_processor *pr);
-- 
2.25.1


