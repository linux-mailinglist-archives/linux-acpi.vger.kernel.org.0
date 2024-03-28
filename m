Return-Path: <linux-acpi+bounces-4274-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3C98791F4
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Mar 2024 11:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE0B1B22F00
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Mar 2024 10:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389ED7AE58;
	Tue, 12 Mar 2024 10:24:27 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B1F7AE4E;
	Tue, 12 Mar 2024 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710239067; cv=none; b=kJdgvOG07esqIeceVoeRrioGGYG/sxCa/BoIpUuX2a3DD5IkBRpsDO+xjT5yvduKVIO+lbaAfmqPLP0CmHbGVjkVaBm5n36JYUQ3AOkD7ZLr9UijDxK/onlQp7XnfCLZfV929b8pfV0CmHdczDO5Xu6M7BiVd+iBpJGP9vYZi2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710239067; c=relaxed/simple;
	bh=eV/Jb9fXtBorXuZV2RdF9/eii9PO9J8+g+3rLJcoIk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b3SM8Kl4sWNVK3RQTzw2G99G1po65XgRzPH+Op/JCu45D1uW+A7Sr5kp7ByFkYEPsdZK1VKmdPNzSnmEfDWfVRlpHPsnJ48ii1hFnXHkN9XYswzBo9IzTNEQhGjndw0OlocbaOYGG/EOEdtEbM4M0EiJ2Zv31R/1D7FY/Niyy8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB5201007;
	Tue, 12 Mar 2024 03:25:01 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.52.80])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7D1E53F73F;
	Tue, 12 Mar 2024 03:24:20 -0700 (PDT)
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
Subject: [PATCH V6 10/11] coresight: stm: Move ACPI support from AMBA driver to platform driver
Date: Tue, 12 Mar 2024 15:53:17 +0530
Message-Id: <20240312102318.2285165-11-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240312102318.2285165-1-anshuman.khandual@arm.com>
References: <20240312102318.2285165-1-anshuman.khandual@arm.com>
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
clock if available. But first this renames and then refactors stm_probe()
and stm_remove(), making sure it can be used both for platform and AMBA
drivers. Also this moves pm_runtime_put() from stm_probe() to the callers.

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
Tested-by: Sudeep Holla <sudeep.holla@arm.com> # Boot and driver probe only
Acked-by: Sudeep Holla <sudeep.holla@arm.com> # For ACPI related changes
Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in V6:

- Added WARN_ON(!drvdata) check in stm_platform_remove()
- Added additional elements for acpi_device_id[]

 drivers/acpi/arm64/amba.c                   |   1 -
 drivers/hwtracing/coresight/coresight-stm.c | 104 ++++++++++++++++++--
 2 files changed, 94 insertions(+), 11 deletions(-)

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
index 5ae24c33c846..a0c744f0f13f 100644
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
@@ -115,6 +117,7 @@ DEFINE_CORESIGHT_DEVLIST(stm_devs, "stm");
  * struct stm_drvdata - specifics associated to an STM component
  * @base:		memory mapped base address for this component.
  * @atclk:		optional clock for the core parts of the STM.
+ * @pclk:		APB clock if present, otherwise NULL
  * @csdev:		component vitals needed by the framework.
  * @spinlock:		only one at a time pls.
  * @chs:		the channels accociated to this STM.
@@ -131,6 +134,7 @@ DEFINE_CORESIGHT_DEVLIST(stm_devs, "stm");
 struct stm_drvdata {
 	void __iomem		*base;
 	struct clk		*atclk;
+	struct clk		*pclk;
 	struct coresight_device	*csdev;
 	spinlock_t		spinlock;
 	struct channel_space	chs;
@@ -810,14 +814,12 @@ static char *stm_csdev_name(struct coresight_device *csdev)
 	return uci_data ? (char *)uci_data : "STM";
 }
 
-static int stm_probe(struct amba_device *adev, const struct amba_id *id)
+static int __stm_probe(struct device *dev, struct resource *res)
 {
 	int ret, trace_id;
 	void __iomem *base;
-	struct device *dev = &adev->dev;
 	struct coresight_platform_data *pdata = NULL;
 	struct stm_drvdata *drvdata;
-	struct resource *res = &adev->res;
 	struct resource ch_res;
 	struct coresight_desc desc = { 0 };
 
@@ -829,12 +831,16 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
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
@@ -882,7 +888,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 		ret = PTR_ERR(pdata);
 		goto stm_unregister;
 	}
-	adev->dev.platform_data = pdata;
+	dev->platform_data = pdata;
 
 	desc.type = CORESIGHT_DEV_TYPE_SOURCE;
 	desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE;
@@ -903,8 +909,6 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 	drvdata->traceid = (u8)trace_id;
 
-	pm_runtime_put(&adev->dev);
-
 	dev_info(&drvdata->csdev->dev, "%s initialized\n",
 		 stm_csdev_name(drvdata->csdev));
 	return 0;
@@ -917,9 +921,20 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 	return ret;
 }
 
-static void stm_remove(struct amba_device *adev)
+static int stm_probe(struct amba_device *adev, const struct amba_id *id)
+{
+	int ret;
+
+	ret = __stm_probe(&adev->dev, &adev->res);
+	if (!ret)
+		pm_runtime_put(&adev->dev);
+
+	return ret;
+}
+
+static void __stm_remove(struct device *dev)
 {
-	struct stm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
+	struct stm_drvdata *drvdata = dev_get_drvdata(dev);
 
 	coresight_trace_id_put_system_id(drvdata->traceid);
 	coresight_unregister(drvdata->csdev);
@@ -927,6 +942,11 @@ static void stm_remove(struct amba_device *adev)
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
@@ -935,6 +955,8 @@ static int stm_runtime_suspend(struct device *dev)
 	if (drvdata && !IS_ERR(drvdata->atclk))
 		clk_disable_unprepare(drvdata->atclk);
 
+	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
+		clk_disable_unprepare(drvdata->pclk);
 	return 0;
 }
 
@@ -945,6 +967,8 @@ static int stm_runtime_resume(struct device *dev)
 	if (drvdata && !IS_ERR(drvdata->atclk))
 		clk_prepare_enable(drvdata->atclk);
 
+	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
+		clk_prepare_enable(drvdata->pclk);
 	return 0;
 }
 #endif
@@ -973,7 +997,67 @@ static struct amba_driver stm_driver = {
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
+	ret = __stm_probe(&pdev->dev, res);
+	pm_runtime_put(&pdev->dev);
+	if (ret)
+		pm_runtime_disable(&pdev->dev);
+
+	return ret;
+}
+
+static int stm_platform_remove(struct platform_device *pdev)
+{
+	struct stm_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
+
+	if (WARN_ON(!drvdata))
+		return -ENODEV;
+
+	__stm_remove(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
+		clk_put(drvdata->pclk);
+	return 0;
+}
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id stm_acpi_ids[] = {
+	{"ARMHC502", 0, 0, 0}, /* ARM CoreSight STM */
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


