Return-Path: <linux-acpi+bounces-2057-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 222AD8003F3
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Dec 2023 07:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCDE72815B3
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Dec 2023 06:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EC71CA92
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Dec 2023 06:34:01 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id C11251BC2;
	Thu, 30 Nov 2023 22:21:27 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECA761042;
	Thu, 30 Nov 2023 22:22:13 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.41.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3BFAC3F73F;
	Thu, 30 Nov 2023 22:21:22 -0800 (PST)
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
Subject: [PATCH V2 4/7] coresight: tpiu: Move ACPI support from AMBA driver to platform driver
Date: Fri,  1 Dec 2023 11:50:50 +0530
Message-Id: <20231201062053.1268492-5-anshuman.khandual@arm.com>
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

Add support for the tpiu device in the platform driver, which can then be
used on ACPI based platforms. This change would now allow runtime power
management for ACPI based systems. The driver would try to enable the APB
clock if available.

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
 drivers/acpi/arm64/amba.c                    |  1 -
 drivers/hwtracing/coresight/coresight-tpiu.c | 87 ++++++++++++++++++--
 2 files changed, 79 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/arm64/amba.c b/drivers/acpi/arm64/amba.c
index 587061b0fd2f..6d24a8f7914b 100644
--- a/drivers/acpi/arm64/amba.c
+++ b/drivers/acpi/arm64/amba.c
@@ -25,7 +25,6 @@ static const struct acpi_device_id amba_id_list[] = {
 	{"ARMHC501", 0}, /* ARM CoreSight ETR */
 	{"ARMHC502", 0}, /* ARM CoreSight STM */
 	{"ARMHC503", 0}, /* ARM CoreSight Debug */
-	{"ARMHC979", 0}, /* ARM CoreSight TPIU */
 	{"ARMHC97C", 0}, /* ARM CoreSight SoC-400 TMC, SoC-600 ETF/ETB */
 	{"", 0},
 };
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 59eac93fd6bb..3ee7c5064389 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -5,6 +5,8 @@
  * Description: CoreSight Trace Port Interface Unit driver
  */
 
+#include <linux/platform_device.h>
+#include <linux/acpi.h>
 #include <linux/atomic.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -57,6 +59,7 @@ DEFINE_CORESIGHT_DEVLIST(tpiu_devs, "tpiu");
 struct tpiu_drvdata {
 	void __iomem		*base;
 	struct clk		*atclk;
+	struct clk		*pclk;
 	struct coresight_device	*csdev;
 };
 
@@ -114,14 +117,12 @@ static const struct coresight_ops tpiu_cs_ops = {
 	.sink_ops	= &tpiu_sink_ops,
 };
 
-static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
+static int __tpiu_probe(struct device *dev, struct resource *res)
 {
 	int ret;
 	void __iomem *base;
-	struct device *dev = &adev->dev;
 	struct coresight_platform_data *pdata = NULL;
 	struct tpiu_drvdata *drvdata;
-	struct resource *res = &adev->res;
 	struct coresight_desc desc = { 0 };
 
 	desc.name = coresight_alloc_device_name(&tpiu_devs, dev);
@@ -132,12 +133,16 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 	if (!drvdata)
 		return -ENOMEM;
 
-	drvdata->atclk = devm_clk_get(&adev->dev, "atclk"); /* optional */
+	drvdata->atclk = devm_clk_get(dev, "atclk"); /* optional */
 	if (!IS_ERR(drvdata->atclk)) {
 		ret = clk_prepare_enable(drvdata->atclk);
 		if (ret)
 			return ret;
 	}
+
+	drvdata->pclk = coresight_get_enable_apb_pclk(dev);
+	if (IS_ERR(drvdata->pclk))
+		return -ENODEV;
 	dev_set_drvdata(dev, drvdata);
 
 	/* Validity for the resource is already checked by the AMBA core */
@@ -164,20 +169,30 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 	drvdata->csdev = coresight_register(&desc);
 
 	if (!IS_ERR(drvdata->csdev)) {
-		pm_runtime_put(&adev->dev);
+		pm_runtime_put(dev);
 		return 0;
 	}
 
 	return PTR_ERR(drvdata->csdev);
 }
 
-static void tpiu_remove(struct amba_device *adev)
+static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 {
-	struct tpiu_drvdata *drvdata = dev_get_drvdata(&adev->dev);
+	return __tpiu_probe(&adev->dev, &adev->res);
+}
+
+static void __tpiu_remove(struct device *dev)
+{
+	struct tpiu_drvdata *drvdata = dev_get_drvdata(dev);
 
 	coresight_unregister(drvdata->csdev);
 }
 
+static void tpiu_remove(struct amba_device *adev)
+{
+	__tpiu_remove(&adev->dev);
+}
+
 #ifdef CONFIG_PM
 static int tpiu_runtime_suspend(struct device *dev)
 {
@@ -186,6 +201,8 @@ static int tpiu_runtime_suspend(struct device *dev)
 	if (drvdata && !IS_ERR(drvdata->atclk))
 		clk_disable_unprepare(drvdata->atclk);
 
+	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
+		clk_disable_unprepare(drvdata->pclk);
 	return 0;
 }
 
@@ -196,6 +213,8 @@ static int tpiu_runtime_resume(struct device *dev)
 	if (drvdata && !IS_ERR(drvdata->atclk))
 		clk_prepare_enable(drvdata->atclk);
 
+	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
+		clk_prepare_enable(drvdata->pclk);
 	return 0;
 }
 #endif
@@ -235,7 +254,59 @@ static struct amba_driver tpiu_driver = {
 	.id_table	= tpiu_ids,
 };
 
-module_amba_driver(tpiu_driver);
+static int tpiu_platform_probe(struct platform_device *pdev)
+{
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	int ret;
+
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	ret = __tpiu_probe(&pdev->dev, res);
+	if (ret) {
+		pm_runtime_put_noidle(&pdev->dev);
+		pm_runtime_disable(&pdev->dev);
+	}
+	return ret;
+}
+
+static int tpiu_platform_remove(struct platform_device *pdev)
+{
+	__tpiu_remove(&pdev->dev);
+	return 0;
+}
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id tpiu_acpi_ids[] = {
+	{"ARMHC979", 0}, /* ARM CoreSight TPIU */
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, tpiu_acpi_ids);
+#endif
+
+static struct platform_driver tpiu_platform_driver = {
+	.probe	= tpiu_platform_probe,
+	.remove	= tpiu_platform_remove,
+	.driver = {
+		.name			= "coresight-tpiu-platform",
+		.acpi_match_table	= ACPI_PTR(tpiu_acpi_ids),
+		.suppress_bind_attrs	= true,
+		.pm			= &tpiu_dev_pm_ops,
+	},
+};
+
+static int __init tpiu_init(void)
+{
+	return coresight_init_driver("tpiu", &tpiu_driver, &tpiu_platform_driver);
+}
+
+static void __exit tpiu_exit(void)
+{
+	coresight_remove_driver(&tpiu_driver, &tpiu_platform_driver);
+}
+module_init(tpiu_init);
+module_exit(tpiu_exit);
 
 MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
 MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
-- 
2.25.1


