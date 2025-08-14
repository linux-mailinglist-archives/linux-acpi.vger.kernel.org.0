Return-Path: <linux-acpi+bounces-15670-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D33AB25D96
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 09:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B57715C1D6F
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 07:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BD826CE06;
	Thu, 14 Aug 2025 07:32:12 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3386926AABE;
	Thu, 14 Aug 2025 07:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156732; cv=none; b=qRDSpURu/und0twP29TlHwKkrMSRkvGmxSmPBtohis+Af4GEq7lEgYRt2H7LbXK48ymAXC5XhV8fflLpfR4R8qDI+HEmn8CGdCluvi6YvEgDZz5sWigsohK1s5URhSY4GSo6O5AeBwzBfhM/FyDoyuKPD756u+p/SDiR+hPdHuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156732; c=relaxed/simple;
	bh=aNB8RnFOdlm/LD47HYzXVx3mQUZ+WpdbIN7fgCe1BFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ospJnPA2Us0GzMQ+8IDgoPeUcdohm/h5vsyyyZFCO50HcjD1NVABipkFuFHsrJWP+GgMerbuu4hPCTMxbld4u2Lvsp30n7AEh6CtV24EF2jWvGRCuMOUI3aHcoO0xMcrbNS5w1wDf7MzG4xjyJS4OP92iE8JIfSpahukyJ3JxQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c49f289678e011f0b29709d653e92f7d-20250814
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:c69afa9d-4fb1-4cb6-ae03-e0a15a42b7b4,IP:10,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-20
X-CID-INFO: VERSION:1.1.45,REQID:c69afa9d-4fb1-4cb6-ae03-e0a15a42b7b4,IP:10,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-META: VersionHash:6493067,CLOUDID:5a8228b419ed3b3c0bb95fde1e630080,BulkI
	D:250814153204NL75FUNS,BulkQuantity:0,Recheck:0,SF:17|19|23|38|43|66|74|78
	|81|82|102,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: c49f289678e011f0b29709d653e92f7d-20250814
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(175.2.165.11)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 75132995; Thu, 14 Aug 2025 15:32:01 +0800
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
Subject: [PATCH v2 2/2] ACPI: processor: idle: Replace single idle driver with per-CPU model for better hybrid CPU support
Date: Thu, 14 Aug 2025 15:31:56 +0800
Message-Id: <20250814073156.1022939-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250814072934.1016694-1-tianyaxiong@kylinos.cn>
References: <20250814072934.1016694-1-tianyaxiong@kylinos.cn>
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
 drivers/acpi/processor_idle.c   | 66 +++++++++++++++++----------------
 include/acpi/processor.h        |  2 +-
 4 files changed, 39 insertions(+), 33 deletions(-)

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
index 2c2dc559e0f8..857dc56654d4 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -51,16 +51,17 @@ module_param(latency_factor, uint, 0644);
 
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
-		arch_cpu_rescan_dead_smt_siblings();
+	int cpu;
+	for_each_possible_cpu(cpu)
+		if (cpuidle_get_driver() == per_cpu_ptr(&acpi_idle_driver, cpu)) {
+			arch_cpu_rescan_dead_smt_siblings();
+			return;
+		}
 }
 
 static
@@ -738,12 +739,13 @@ static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
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
@@ -776,7 +778,7 @@ static int acpi_processor_setup_cstates(struct acpi_processor *pr)
 	int i, count;
 	struct acpi_processor_cx *cx;
 	struct cpuidle_state *state;
-	struct cpuidle_driver *drv = &acpi_idle_driver;
+	struct cpuidle_driver *drv = per_cpu_ptr(&acpi_idle_driver, pr->id);
 
 	if (max_cstate == 0)
 		max_cstate = 1;
@@ -1198,7 +1200,7 @@ static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
 	int i;
 	struct acpi_lpi_state *lpi;
 	struct cpuidle_state *state;
-	struct cpuidle_driver *drv = &acpi_idle_driver;
+	struct cpuidle_driver *drv = per_cpu_ptr(&acpi_idle_driver, pr->id);
 
 	if (!pr->flags.has_lpi)
 		return -EOPNOTSUPP;
@@ -1232,7 +1234,7 @@ static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
 static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
 {
 	int i;
-	struct cpuidle_driver *drv = &acpi_idle_driver;
+	struct cpuidle_driver *drv = per_cpu_ptr(&acpi_idle_driver, pr->id);
 
 	if (!pr->flags.power_setup_done || !pr->flags.power)
 		return -EINVAL;
@@ -1316,13 +1318,7 @@ int acpi_processor_power_state_has_changed(struct acpi_processor *pr)
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
@@ -1360,12 +1356,14 @@ int acpi_processor_power_state_has_changed(struct acpi_processor *pr)
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
@@ -1382,14 +1380,21 @@ int acpi_processor_power_init(struct acpi_processor *pr)
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
@@ -1403,11 +1408,10 @@ int acpi_processor_power_init(struct acpi_processor *pr)
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
@@ -1415,17 +1419,17 @@ int acpi_processor_power_init(struct acpi_processor *pr)
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


