Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9236C9ABE
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Mar 2023 07:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjC0FHA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Mar 2023 01:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjC0FGg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Mar 2023 01:06:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9EFCF55A5;
        Sun, 26 Mar 2023 22:06:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70F784B3;
        Sun, 26 Mar 2023 22:07:12 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.42.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 01BD13FA27;
        Sun, 26 Mar 2023 22:06:12 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com
Cc:     scclevenger@os.amperecomputing.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 4/5] coresight: etm4x: Change etm4_platform_driver driver for MMIO devices
Date:   Mon, 27 Mar 2023 10:35:36 +0530
Message-Id: <20230327050537.30861-5-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230327050537.30861-1-anshuman.khandual@arm.com>
References: <20230327050537.30861-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add support for handling MMIO based devices via platform driver. We need to
make sure that :

1) The APB clock, if present is enabled at probe and via runtime_pm ops
2) Use the ETM4x architecture or CoreSight architecture registers to
   identify a device as CoreSight ETM4x, instead of relying a white list of
   "Peripheral IDs"

The driver doesn't get to handle the devices yet, until we wire the ACPI
changes to move the devices to be handled via platform driver than the
etm4_amba driver.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 .../coresight/coresight-etm4x-core.c          | 62 +++++++++++++++++--
 drivers/hwtracing/coresight/coresight-etm4x.h |  4 ++
 include/linux/coresight.h                     | 47 ++++++++++++++
 3 files changed, 109 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 3521838ab4fb..bef205023bbe 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -30,6 +30,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
+#include <linux/clk/clk-conf.h>
 
 #include <asm/barrier.h>
 #include <asm/sections.h>
@@ -1067,12 +1068,22 @@ static bool etm4_init_sysreg_access(struct etmv4_drvdata *drvdata,
 	return true;
 }
 
+static bool is_etm4x_devtype(void __iomem *base)
+{
+	u32 devtype = readl(base + TRCDEVTYPE);
+
+	return (devtype == ETM_DEVTYPE_ETMv4x_ARCH);
+}
+
 static bool etm4_init_iomem_access(struct etmv4_drvdata *drvdata,
 				   struct csdev_access *csa)
 {
 	u32 devarch = readl_relaxed(drvdata->base + TRCDEVARCH);
 	u32 idr1 = readl_relaxed(drvdata->base + TRCIDR1);
 
+	if (!is_coresight_device(drvdata->base) || !is_etm4x_devtype(drvdata->base))
+		return false;
+
 	/*
 	 * All ETMs must implement TRCDEVARCH to indicate that
 	 * the component is an ETMv4. To support any broken
@@ -2133,6 +2144,7 @@ static int etm4_probe_amba(struct amba_device *adev, const struct amba_id *id)
 
 static int etm4_probe_platform_dev(struct platform_device *pdev)
 {
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct etmv4_drvdata *drvdata;
 	int ret;
 
@@ -2140,7 +2152,18 @@ static int etm4_probe_platform_dev(struct platform_device *pdev)
 	if (!drvdata)
 		return -ENOMEM;
 
-	drvdata->base = NULL;
+	drvdata->pclk = coresight_get_enable_apb_pclk(&pdev->dev);
+	if (IS_ERR(drvdata->pclk))
+		return -ENODEV;
+
+	if (res) {
+		drvdata->base = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(drvdata->base)) {
+			clk_put(drvdata->pclk);
+			return PTR_ERR(drvdata->base);
+		}
+	}
+
 	dev_set_drvdata(&pdev->dev, drvdata);
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
@@ -2186,7 +2209,7 @@ static struct amba_cs_uci_id uci_id_etm4[] = {
 		/*  ETMv4 UCI data */
 		.devarch	= ETM_DEVARCH_ETMv4x_ARCH,
 		.devarch_mask	= ETM_DEVARCH_ID_MASK,
-		.devtype	= 0x00000013,
+		.devtype	= ETM_DEVTYPE_ETMv4x_ARCH,
 	}
 };
 
@@ -2244,6 +2267,10 @@ static int __exit etm4_remove_platform_dev(struct platform_device *pdev)
 
 	if (drvdata)
 		ret = etm4_remove_dev(drvdata);
+
+	if (drvdata->pclk)
+		clk_put(drvdata->pclk);
+
 	pm_runtime_disable(&pdev->dev);
 	return ret;
 }
@@ -2284,7 +2311,33 @@ static struct amba_driver etm4x_amba_driver = {
 	.id_table	= etm4_ids,
 };
 
-static const struct of_device_id etm4_sysreg_match[] = {
+#ifdef CONFIG_PM
+static int etm4_runtime_suspend(struct device *dev)
+{
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev);
+
+	if (!IS_ERR(drvdata->pclk))
+		clk_disable_unprepare(drvdata->pclk);
+
+	return 0;
+}
+
+static int etm4_runtime_resume(struct device *dev)
+{
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev);
+
+	if (!IS_ERR(drvdata->pclk))
+		clk_prepare_enable(drvdata->pclk);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops etm4_dev_pm_ops = {
+	SET_RUNTIME_PM_OPS(etm4_runtime_suspend, etm4_runtime_resume, NULL)
+};
+
+static const struct of_device_id etm4_match[] = {
 	{ .compatible	= "arm,coresight-etm4x-sysreg" },
 	{ .compatible	= "arm,embedded-trace-extension" },
 	{}
@@ -2295,8 +2348,9 @@ static struct platform_driver etm4_platform_driver = {
 	.remove		= etm4_remove_platform_dev,
 	.driver			= {
 		.name			= "coresight-etm4x",
-		.of_match_table		= etm4_sysreg_match,
+		.of_match_table		= etm4_match,
 		.suppress_bind_attrs	= true,
+		.pm			= &etm4_dev_pm_ops,
 	},
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 434f4e95ee17..78dfe7949548 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -701,6 +701,8 @@
 #define ETM_DEVARCH_ETE_ARCH						\
 	(ETM_DEVARCH_ARCHITECT_ARM | ETM_DEVARCH_ARCHID_ETE | ETM_DEVARCH_PRESENT)
 
+#define ETM_DEVTYPE_ETMv4x_ARCH		0x00000013
+
 #define TRCSTATR_IDLE_BIT		0
 #define TRCSTATR_PMSTABLE_BIT		1
 #define ETM_DEFAULT_ADDR_COMP		0
@@ -952,6 +954,7 @@ struct etmv4_save_state {
 
 /**
  * struct etm4_drvdata - specifics associated to an ETM component
+ * @pclk        APB clock for this component
  * @base:       Memory mapped base address for this component.
  * @csdev:      Component vitals needed by the framework.
  * @spinlock:   Only one at a time pls.
@@ -1017,6 +1020,7 @@ struct etmv4_save_state {
  * @arch_features: Bitmap of arch features of etmv4 devices.
  */
 struct etmv4_drvdata {
+	struct clk			*pclk;
 	void __iomem			*base;
 	struct coresight_device		*csdev;
 	spinlock_t			spinlock;
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index f85b041ea475..be60a8b84c49 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -6,6 +6,8 @@
 #ifndef _LINUX_CORESIGHT_H
 #define _LINUX_CORESIGHT_H
 
+#include <linux/amba/bus.h>
+#include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/perf_event.h>
@@ -370,6 +372,51 @@ static inline u32 csdev_access_relaxed_read32(struct csdev_access *csa,
 	return csa->read(offset, true, false);
 }
 
+#define CORESIGHT_CIDRn(i)	(0xFF0 + ((i) * 4))
+
+static inline u32 coresight_get_cid(void __iomem *base)
+{
+	u32 i, cid = 0;
+
+	for (i = 0; i < 4; i++)
+		cid |= readl(base + CORESIGHT_CIDRn(i)) << (i * 8);
+
+	return cid;
+}
+
+static inline bool is_coresight_device(void __iomem *base)
+{
+	u32 cid = coresight_get_cid(base);
+
+	return cid == CORESIGHT_CID;
+}
+
+/*
+ * Attempt to find and enable "APB clock" for the given device
+ *
+ * Returns:
+ *
+ * clk   - Clock is found and enabled
+ * NULL  - clock is not found
+ * ERROR - Clock is found but failed to enable
+ */
+static inline struct clk *coresight_get_enable_apb_pclk(struct device *dev)
+{
+	struct clk *pclk;
+	int ret;
+
+	pclk = clk_get(dev, "apb_pclk");
+	if (IS_ERR(pclk))
+		return NULL;
+
+	ret = clk_prepare_enable(pclk);
+	if (ret) {
+		clk_put(pclk);
+		return ERR_PTR(ret);
+	}
+	return pclk;
+}
+
 #define CORESIGHT_PIDRn(i)	(0xFE0 + ((i) * 4))
 
 static inline u32 coresight_get_pid(struct csdev_access *csa)
-- 
2.25.1

