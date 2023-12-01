Return-Path: <linux-acpi+bounces-2059-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D54748003F5
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Dec 2023 07:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B88D1C20AAB
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Dec 2023 06:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7131CA91
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Dec 2023 06:34:11 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id A23481BE5;
	Thu, 30 Nov 2023 22:21:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FC6D1042;
	Thu, 30 Nov 2023 22:22:23 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.41.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A593C3F73F;
	Thu, 30 Nov 2023 22:21:32 -0800 (PST)
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
Subject: [PATCH V2 6/7] coresight: stm: Move ACPI support from AMBA driver to platform driver
Date: Fri,  1 Dec 2023 11:50:52 +0530
Message-Id: <20231201062053.1268492-7-anshuman.khandual@arm.com>
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

Add support for the stm devices in the platform driver, which can then be
used on ACPI based platforms. This change would now allow runtime power
management for ACPI based systems. The driver would try to enable the APB
clock if available.

Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: James Clark <james.clark@arm.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: coresight@lists.linaro.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/acpi/arm64/amba.c                   |  1 -
 drivers/hwtracing/coresight/coresight-stm.c | 91 ++++++++++++++++++---
 2 files changed, 81 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/arm64/amba.c b/drivers/acpi/arm64/amba.c
index d3c1defa7bc8..bec0976541da 100644
--- a/drivers/acpi/arm64/amba.c
+++ b/drivers/acpi/arm64/amba.c
@@ -22,7 +22,6 @@
 static const struct acpi_device_id amba_id_list[] = {
 	{"ARMH0061", 0}, /* PL061 GPIO Device */
 	{"ARMH0330", 0}, /* ARM DMA Controller DMA-330 */
-	{"ARMHC502", 0}, /* ARM CoreSight STM */
 	{"ARMHC503", 0}, /* ARM CoreSight Debug */
 	{"", 0},
 };
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index a1c27c901ad1..564aa5f1eb8a 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -29,6 +29,8 @@
 #include <linux/perf_event.h>
 #include <linux/pm_runtime.h>
 #include <linux/stm.h>
+#include <linux/platform_device.h>
+#include <linux/acpi.h>
 
 #include "coresight-priv.h"
 #include "coresight-trace-id.h"
@@ -132,6 +134,7 @@ DEFINE_CORESIGHT_DEVLIST(stm_devs, "stm");
 struct stm_drvdata {
 	void __iomem		*base;
 	struct clk		*atclk;
+	struct clk		*pclk;
 	struct coresight_device	*csdev;
 	spinlock_t		spinlock;
 	struct channel_space	chs;
@@ -804,14 +807,12 @@ static void stm_init_generic_data(struct stm_drvdata *drvdata,
 	drvdata->stm.set_options = stm_generic_set_options;
 }
 
-static int stm_probe(struct amba_device *adev, const struct amba_id *id)
+static int __stm_probe(struct device *dev, struct resource *res, void *dev_caps)
 {
 	int ret, trace_id;
 	void __iomem *base;
-	struct device *dev = &adev->dev;
 	struct coresight_platform_data *pdata = NULL;
 	struct stm_drvdata *drvdata;
-	struct resource *res = &adev->res;
 	struct resource ch_res;
 	struct coresight_desc desc = { 0 };
 
@@ -823,12 +824,16 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
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
 
 	base = devm_ioremap_resource(dev, res);
@@ -876,7 +881,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 		ret = PTR_ERR(pdata);
 		goto stm_unregister;
 	}
-	adev->dev.platform_data = pdata;
+	dev->platform_data = pdata;
 
 	desc.type = CORESIGHT_DEV_TYPE_SOURCE;
 	desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE;
@@ -897,10 +902,10 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 	drvdata->traceid = (u8)trace_id;
 
-	pm_runtime_put(&adev->dev);
+	pm_runtime_put(dev);
 
 	dev_info(&drvdata->csdev->dev, "%s initialized\n",
-		 (char *)coresight_get_uci_data(id));
+		 (char *)dev_caps);
 	return 0;
 
 cs_unregister:
@@ -911,9 +916,14 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 	return ret;
 }
 
-static void stm_remove(struct amba_device *adev)
+static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 {
-	struct stm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
+	return __stm_probe(&adev->dev, &adev->res, coresight_get_uci_data(id));
+}
+
+static void __stm_remove(struct device *dev)
+{
+	struct stm_drvdata *drvdata = dev_get_drvdata(dev);
 
 	coresight_trace_id_put_system_id(drvdata->traceid);
 	coresight_unregister(drvdata->csdev);
@@ -921,6 +931,11 @@ static void stm_remove(struct amba_device *adev)
 	stm_unregister_device(&drvdata->stm);
 }
 
+static void stm_remove(struct amba_device *adev)
+{
+	__stm_remove(&adev->dev);
+}
+
 #ifdef CONFIG_PM
 static int stm_runtime_suspend(struct device *dev)
 {
@@ -929,6 +944,8 @@ static int stm_runtime_suspend(struct device *dev)
 	if (drvdata && !IS_ERR(drvdata->atclk))
 		clk_disable_unprepare(drvdata->atclk);
 
+	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
+		clk_disable_unprepare(drvdata->pclk);
 	return 0;
 }
 
@@ -939,6 +956,8 @@ static int stm_runtime_resume(struct device *dev)
 	if (drvdata && !IS_ERR(drvdata->atclk))
 		clk_prepare_enable(drvdata->atclk);
 
+	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
+		clk_prepare_enable(drvdata->pclk);
 	return 0;
 }
 #endif
@@ -967,7 +986,59 @@ static struct amba_driver stm_driver = {
 	.id_table	= stm_ids,
 };
 
-module_amba_driver(stm_driver);
+static int stm_platform_probe(struct platform_device *pdev)
+{
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	int ret = 0;
+
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	ret = __stm_probe(&pdev->dev, res, NULL);
+	if (ret) {
+		pm_runtime_put_noidle(&pdev->dev);
+		pm_runtime_disable(&pdev->dev);
+	}
+	return ret;
+}
+
+static int stm_platform_remove(struct platform_device *pdev)
+{
+	__stm_remove(&pdev->dev);
+	return 0;
+}
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id stm_acpi_ids[] = {
+	{"ARMHC502", 0}, /* ARM CoreSight STM */
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, stm_acpi_ids);
+#endif
+
+static struct platform_driver stm_platform_driver = {
+	.probe	= stm_platform_probe,
+	.remove	= stm_platform_remove,
+	.driver	= {
+		.name			= "coresight-stm-platform",
+		.acpi_match_table	= ACPI_PTR(stm_acpi_ids),
+		.suppress_bind_attrs	= true,
+		.pm			= &stm_dev_pm_ops,
+	},
+};
+
+static int __init stm_init(void)
+{
+	return coresight_init_driver("stm", &stm_driver, &stm_platform_driver);
+}
+
+static void __exit stm_exit(void)
+{
+	coresight_remove_driver(&stm_driver, &stm_platform_driver);
+}
+module_init(stm_init);
+module_exit(stm_exit);
 
 MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
 MODULE_DESCRIPTION("Arm CoreSight System Trace Macrocell driver");
-- 
2.25.1


