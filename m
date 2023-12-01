Return-Path: <linux-acpi+bounces-2054-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8405D8003EE
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Dec 2023 07:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48E432817E8
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Dec 2023 06:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6EC14276
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Dec 2023 06:33:47 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15D4E1703;
	Thu, 30 Nov 2023 22:21:13 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62BE51042;
	Thu, 30 Nov 2023 22:21:59 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.41.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9FD1D3F73F;
	Thu, 30 Nov 2023 22:21:08 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	suzuki.poulose@arm.com
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH V2 1/7] coresight: replicator: Move ACPI support from AMBA driver to platform driver
Date: Fri,  1 Dec 2023 11:50:47 +0530
Message-Id: <20231201062053.1268492-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231201062053.1268492-1-anshuman.khandual@arm.com>
References: <20231201062053.1268492-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the dynamic replicator device in the platform driver, which
can then be used on ACPI based platforms. This change would now allow
runtime power management for repliacator devices on ACPI based systems.

The driver would try to enable the APB clock if available. Also, rename the
code to reflect the fact that it now handles both static and dynamic
replicators.

Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: James Clark <james.clark@arm.com>
Cc: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: coresight@lists.linaro.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/acpi/arm64/amba.c                     |  1 -
 .../coresight/coresight-replicator.c          | 44 ++++++++++++-------
 2 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/arm64/amba.c b/drivers/acpi/arm64/amba.c
index 171b5c2c7edd..270f4e3819a2 100644
--- a/drivers/acpi/arm64/amba.c
+++ b/drivers/acpi/arm64/amba.c
@@ -27,7 +27,6 @@ static const struct acpi_device_id amba_id_list[] = {
 	{"ARMHC503", 0}, /* ARM CoreSight Debug */
 	{"ARMHC979", 0}, /* ARM CoreSight TPIU */
 	{"ARMHC97C", 0}, /* ARM CoreSight SoC-400 TMC, SoC-600 ETF/ETB */
-	{"ARMHC98D", 0}, /* ARM CoreSight Dynamic Replicator */
 	{"ARMHC9CA", 0}, /* ARM CoreSight CATU */
 	{"ARMHC9FF", 0}, /* ARM CoreSight Dynamic Funnel */
 	{"", 0},
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index b6be73034996..64de0bee02ec 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -38,6 +38,7 @@ DEFINE_CORESIGHT_DEVLIST(replicator_devs, "replicator");
 struct replicator_drvdata {
 	void __iomem		*base;
 	struct clk		*atclk;
+	struct clk		*pclk;
 	struct coresight_device	*csdev;
 	spinlock_t		spinlock;
 	bool			check_idfilter_val;
@@ -243,6 +244,10 @@ static int replicator_probe(struct device *dev, struct resource *res)
 			return ret;
 	}
 
+	drvdata->pclk = coresight_get_enable_apb_pclk(dev);
+	if (IS_ERR(drvdata->pclk))
+		return -ENODEV;
+
 	/*
 	 * Map the device base for dynamic-replicator, which has been
 	 * validated by AMBA core
@@ -301,16 +306,16 @@ static int replicator_remove(struct device *dev)
 	return 0;
 }
 
-static int static_replicator_probe(struct platform_device *pdev)
+static int replicator_platform_probe(struct platform_device *pdev)
 {
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	int ret;
 
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	/* Static replicators do not have programming base */
-	ret = replicator_probe(&pdev->dev, NULL);
+	ret = replicator_probe(&pdev->dev, res);
 
 	if (ret) {
 		pm_runtime_put_noidle(&pdev->dev);
@@ -320,7 +325,7 @@ static int static_replicator_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int static_replicator_remove(struct platform_device *pdev)
+static int replicator_platform_remove(struct platform_device *pdev)
 {
 	replicator_remove(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
@@ -335,6 +340,8 @@ static int replicator_runtime_suspend(struct device *dev)
 	if (drvdata && !IS_ERR(drvdata->atclk))
 		clk_disable_unprepare(drvdata->atclk);
 
+	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
+		clk_disable_unprepare(drvdata->pclk);
 	return 0;
 }
 
@@ -345,6 +352,8 @@ static int replicator_runtime_resume(struct device *dev)
 	if (drvdata && !IS_ERR(drvdata->atclk))
 		clk_prepare_enable(drvdata->atclk);
 
+	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
+		clk_prepare_enable(drvdata->pclk);
 	return 0;
 }
 #endif
@@ -354,31 +363,32 @@ static const struct dev_pm_ops replicator_dev_pm_ops = {
 			   replicator_runtime_resume, NULL)
 };
 
-static const struct of_device_id static_replicator_match[] = {
+static const struct of_device_id replicator_match[] = {
 	{.compatible = "arm,coresight-replicator"},
 	{.compatible = "arm,coresight-static-replicator"},
 	{}
 };
 
-MODULE_DEVICE_TABLE(of, static_replicator_match);
+MODULE_DEVICE_TABLE(of, replicator_match);
 
 #ifdef CONFIG_ACPI
-static const struct acpi_device_id static_replicator_acpi_ids[] = {
+static const struct acpi_device_id replicator_acpi_ids[] = {
 	{"ARMHC985", 0}, /* ARM CoreSight Static Replicator */
+	{"ARMHC98D", 0}, /* ARM CoreSight Dynamic Replicator */
 	{}
 };
 
-MODULE_DEVICE_TABLE(acpi, static_replicator_acpi_ids);
+MODULE_DEVICE_TABLE(acpi, replicator_acpi_ids);
 #endif
 
-static struct platform_driver static_replicator_driver = {
-	.probe          = static_replicator_probe,
-	.remove         = static_replicator_remove,
+static struct platform_driver replicator_driver = {
+	.probe          = replicator_platform_probe,
+	.remove         = replicator_platform_remove,
 	.driver         = {
-		.name   = "coresight-static-replicator",
+		.name   = "coresight-replicator",
 		/* THIS_MODULE is taken care of by platform_driver_register() */
-		.of_match_table = of_match_ptr(static_replicator_match),
-		.acpi_match_table = ACPI_PTR(static_replicator_acpi_ids),
+		.of_match_table = of_match_ptr(replicator_match),
+		.acpi_match_table = ACPI_PTR(replicator_acpi_ids),
 		.pm	= &replicator_dev_pm_ops,
 		.suppress_bind_attrs = true,
 	},
@@ -419,7 +429,7 @@ static int __init replicator_init(void)
 {
 	int ret;
 
-	ret = platform_driver_register(&static_replicator_driver);
+	ret = platform_driver_register(&replicator_driver);
 	if (ret) {
 		pr_info("Error registering platform driver\n");
 		return ret;
@@ -428,7 +438,7 @@ static int __init replicator_init(void)
 	ret = amba_driver_register(&dynamic_replicator_driver);
 	if (ret) {
 		pr_info("Error registering amba driver\n");
-		platform_driver_unregister(&static_replicator_driver);
+		platform_driver_unregister(&replicator_driver);
 	}
 
 	return ret;
@@ -436,7 +446,7 @@ static int __init replicator_init(void)
 
 static void __exit replicator_exit(void)
 {
-	platform_driver_unregister(&static_replicator_driver);
+	platform_driver_unregister(&replicator_driver);
 	amba_driver_unregister(&dynamic_replicator_driver);
 }
 
-- 
2.25.1


