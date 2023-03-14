Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509306B8E61
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Mar 2023 10:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjCNJQF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Mar 2023 05:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjCNJQC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Mar 2023 05:16:02 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 094452A149;
        Tue, 14 Mar 2023 02:16:01 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id B7DD92056DC4;
        Tue, 14 Mar 2023 02:15:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B7DD92056DC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1678785358;
        bh=eAs9zn3uehRowNeXy5qxENpgerVFEdWYFUI3GKR3j34=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=daQlHQ8r0eFQf5oLLcPjiatcc4/LArmQETXVa8dQmWmZTSajyjj9yp3DatQ5RnoFe
         JxkcWO8Y4ZR9Nbq1xRz8fcBw45XDmxlzNjqurwVczHhZnOV/XsvqzMe5L7s/kO2VbJ
         sHu+H0bfz5JvLpGBYM7R3tVo9C9LkDHv9PjzH5hA=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        lenb@kernel.org, rafael@kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v8 5/5] Driver: VMBus: Add Devicetree support
Date:   Tue, 14 Mar 2023 02:15:50 -0700
Message-Id: <1678785350-20400-6-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1678785350-20400-1-git-send-email-ssengar@linux.microsoft.com>
References: <1678785350-20400-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Update the driver to support Devicetree boot as well along with ACPI.
At present the Devicetree parsing only provides the mmio region info
and is not the exact copy of ACPI parsing. This is sufficient to cater
all the current Devicetree usecases for VMBus.

Currently Devicetree is supported only for x86 systems.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
[V8]
- Remove the auto select of CONFIG_OF
- Remove the dependency on !ACPI for OF_EARLY_FLATTREE
- Used acpi_disabled instead of #ifdef and hence added a dummy function
  for vmbus_acpi_add
- GFP_ATOMIC -> GFP_KERNEL
- used range.flags instead of hard coding flags
- used __maybe_unused for acpi device id, removed #ifdef

 drivers/hv/Kconfig     |  5 ++--
 drivers/hv/vmbus_drv.c | 64 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 0747a8f1fcee..47132b30b7ee 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -4,11 +4,12 @@ menu "Microsoft Hyper-V guest support"
 
 config HYPERV
 	tristate "Microsoft Hyper-V client drivers"
-	depends on ACPI && ((X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
-		|| (ARM64 && !CPU_BIG_ENDIAN))
+	depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
+		|| (ACPI && ARM64 && !CPU_BIG_ENDIAN)
 	select PARAVIRT
 	select X86_HV_CALLBACK_VECTOR if X86
 	select VMAP_PFN
+	select OF_EARLY_FLATTREE if OF
 	help
 	  Select this option to run Linux as a Hyper-V client operating
 	  system.
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 3ad2fa2b92e7..15097e1f3f2b 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -20,6 +20,7 @@
 #include <linux/completion.h>
 #include <linux/hyperv.h>
 #include <linux/kernel_stat.h>
+#include <linux/of_address.h>
 #include <linux/clockchips.h>
 #include <linux/cpu.h>
 #include <linux/sched/isolation.h>
@@ -2143,7 +2144,7 @@ void vmbus_device_unregister(struct hv_device *device_obj)
 	device_unregister(&device_obj->device);
 }
 
-
+#ifdef CONFIG_ACPI
 /*
  * VMBUS is an acpi enumerated device. Get the information we
  * need from DSDT.
@@ -2253,6 +2254,7 @@ static acpi_status vmbus_walk_resources(struct acpi_resource *res, void *ctx)
 
 	return AE_OK;
 }
+#endif
 
 static void vmbus_mmio_remove(void)
 {
@@ -2273,7 +2275,7 @@ static void vmbus_mmio_remove(void)
 	}
 }
 
-static void vmbus_reserve_fb(void)
+static void __maybe_unused vmbus_reserve_fb(void)
 {
 	resource_size_t start = 0, size;
 	struct pci_dev *pdev;
@@ -2433,6 +2435,7 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size)
 }
 EXPORT_SYMBOL_GPL(vmbus_free_mmio);
 
+#ifdef CONFIG_ACPI
 static int vmbus_acpi_add(struct platform_device *pdev)
 {
 	acpi_status result;
@@ -2485,10 +2488,52 @@ static int vmbus_acpi_add(struct platform_device *pdev)
 		vmbus_mmio_remove();
 	return ret_val;
 }
+#else
+static int vmbus_acpi_add(struct platform_device *pdev)
+{
+	return 0;
+}
+#endif
+
+static int vmbus_device_add(struct platform_device *pdev)
+{
+	struct resource **cur_res = &hyperv_mmio;
+	struct of_range range;
+	struct of_range_parser parser;
+	struct device_node *np = pdev->dev.of_node;
+	int ret;
+
+	hv_dev = &pdev->dev;
+
+	ret = of_range_parser_init(&parser, np);
+	if (ret)
+		return ret;
+
+	for_each_of_range(&parser, &range) {
+		struct resource *res;
+
+		res = kzalloc(sizeof(*res), GFP_KERNEL);
+		if (!res)
+			return -ENOMEM;
+
+		res->name = "hyperv mmio";
+		res->flags = range.flags;
+		res->start = range.cpu_addr;
+		res->end = range.cpu_addr + range.size;
+
+		*cur_res = res;
+		cur_res = &res->sibling;
+	}
+
+	return ret;
+}
 
 static int vmbus_platform_driver_probe(struct platform_device *pdev)
 {
-	return vmbus_acpi_add(pdev);
+	if (!acpi_disabled)
+		return vmbus_acpi_add(pdev);
+	else
+		return vmbus_device_add(pdev);
 }
 
 static int vmbus_platform_driver_remove(struct platform_device *pdev)
@@ -2634,7 +2679,17 @@ static int vmbus_bus_resume(struct device *dev)
 #define vmbus_bus_resume NULL
 #endif /* CONFIG_PM_SLEEP */
 
-static const struct acpi_device_id vmbus_acpi_device_ids[] = {
+static const __maybe_unused struct of_device_id vmbus_of_match[] = {
+	{
+		.compatible = "microsoft,vmbus",
+	},
+	{
+		/* sentinel */
+	},
+};
+MODULE_DEVICE_TABLE(of, vmbus_of_match);
+
+static const __maybe_unused struct acpi_device_id vmbus_acpi_device_ids[] = {
 	{"VMBUS", 0},
 	{"VMBus", 0},
 	{"", 0},
@@ -2668,6 +2723,7 @@ static struct platform_driver vmbus_platform_driver = {
 	.driver = {
 		.name = "vmbus",
 		.acpi_match_table = ACPI_PTR(vmbus_acpi_device_ids),
+		.of_match_table = of_match_ptr(vmbus_of_match),
 		.pm = &vmbus_bus_pm,
 		.probe_type = PROBE_FORCE_SYNCHRONOUS,
 	}
-- 
2.34.1

