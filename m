Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF33262437B
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Nov 2022 14:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiKJNpL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Nov 2022 08:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiKJNpK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Nov 2022 08:45:10 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A4AD3FBA7
        for <linux-acpi@vger.kernel.org>; Thu, 10 Nov 2022 05:45:10 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F265023A;
        Thu, 10 Nov 2022 05:45:15 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E2D803F703;
        Thu, 10 Nov 2022 05:45:08 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2 1/2] ACPI: Implement a generic FFH Opregion handler
Date:   Thu, 10 Nov 2022 13:45:04 +0000
Message-Id: <20221110134505.1375955-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221110134505.1375955-1-sudeep.holla@arm.com>
References: <20221110134505.1375955-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This registers the FFH OpRegion handler before ACPI tables are
loaded. The platform support for the same is checked via Platform-Wide
OSPM Capabilities(OSC) before registering the OpRegion handler.

It relies on the special context data passed to offset and the length.
However the interpretation of the values is platform/architecture
specific. This generic handler just passed all the information to
the platform/architecture specific callback. It also implements the
default callbacks which return as not supported.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/Kconfig    | 10 ++++++++
 drivers/acpi/Makefile   |  1 +
 drivers/acpi/acpi_ffh.c | 55 +++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/bus.c      |  6 +++++
 include/linux/acpi.h    |  7 ++++++
 5 files changed, 79 insertions(+)
 create mode 100644 drivers/acpi/acpi_ffh.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 473241b5193f..06508674a30b 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -564,6 +564,16 @@ config ACPI_PCC
 	  Enable this feature if you want to set up and install the PCC Address
 	  Space handler to handle PCC OpRegion in the firmware.
 
+config ACPI_FFH
+	bool "ACPI FFH Address Space"
+	default n
+	help
+	  The FFH(Fixed Function Hardware) Address Space also referred as FFH
+	  Operation Region allows to define platform specific opregion.
+
+	  Enable this feature if you want to set up and install the FFH Address
+	  Space handler to handle FFH OpRegion in the firmware.
+
 source "drivers/acpi/pmic/Kconfig"
 
 config ACPI_VIOT
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 0002eecbf870..feb36c0b9446 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -68,6 +68,7 @@ acpi-$(CONFIG_ACPI_GENERIC_GSI) += irq.o
 acpi-$(CONFIG_ACPI_WATCHDOG)	+= acpi_watchdog.o
 acpi-$(CONFIG_ACPI_PRMT)	+= prmt.o
 acpi-$(CONFIG_ACPI_PCC)		+= acpi_pcc.o
+acpi-$(CONFIG_ACPI_FFH)		+= acpi_ffh.o
 
 # Address translation
 acpi-$(CONFIG_ACPI_ADXL)	+= acpi_adxl.o
diff --git a/drivers/acpi/acpi_ffh.c b/drivers/acpi/acpi_ffh.c
new file mode 100644
index 000000000000..19aff808bbb8
--- /dev/null
+++ b/drivers/acpi/acpi_ffh.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Author: Sudeep Holla <sudeep.holla@arm.com>
+ * Copyright 2022 Arm Limited
+ */
+#include <linux/kernel.h>
+#include <linux/acpi.h>
+#include <linux/completion.h>
+#include <linux/idr.h>
+#include <linux/io.h>
+
+#include <linux/arm-smccc.h>
+
+static struct acpi_ffh_info ffh_ctx;
+
+int __weak acpi_ffh_address_space_arch_setup(void *handler_ctxt,
+					     void **region_ctxt)
+{
+	return -EOPNOTSUPP;
+}
+
+int __weak acpi_ffh_address_space_arch_handler(acpi_integer *value,
+					       void *region_context)
+{
+	return -EOPNOTSUPP;
+}
+
+static acpi_status
+acpi_ffh_address_space_setup(acpi_handle region_handle, u32 function,
+			     void *handler_context,  void **region_context)
+{
+	return acpi_ffh_address_space_arch_setup(handler_context,
+						 region_context);
+}
+
+static acpi_status
+acpi_ffh_address_space_handler(u32 function, acpi_physical_address addr,
+			       u32 bits, acpi_integer *value,
+			       void *handler_context, void *region_context)
+{
+	return acpi_ffh_address_space_arch_handler(value, region_context);
+}
+
+void __init acpi_init_ffh(void)
+{
+	acpi_status status;
+
+	status = acpi_install_address_space_handler(ACPI_ROOT_OBJECT,
+						    ACPI_ADR_SPACE_FIXED_HARDWARE,
+						    &acpi_ffh_address_space_handler,
+						    &acpi_ffh_address_space_setup,
+						    &ffh_ctx);
+	if (ACPI_FAILURE(status))
+		pr_alert("OperationRegion handler could not be installed\n");
+}
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index d466c8195314..245fb0828e47 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -300,6 +300,8 @@ EXPORT_SYMBOL_GPL(osc_sb_native_usb4_support_confirmed);
 
 bool osc_sb_cppc2_support_acked;
 
+bool osc_sb_ffh_opregion_support_confirmed;
+
 static u8 sb_uuid_str[] = "0811B06E-4A27-44F9-8D60-3CBBC22E7B48";
 static void acpi_bus_osc_negotiate_platform_control(void)
 {
@@ -383,6 +385,8 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_NATIVE_USB4_SUPPORT;
 		osc_cpc_flexible_adr_space_confirmed =
 			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_CPC_FLEXIBLE_ADR_SPACE;
+		osc_sb_ffh_opregion_support_confirmed =
+			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_FFH_OPR_SUPPORT;
 	}
 
 	kfree(context.ret.pointer);
@@ -1408,6 +1412,8 @@ static int __init acpi_init(void)
 		disable_acpi();
 		return result;
 	}
+	if (osc_sb_ffh_opregion_support_confirmed)
+		acpi_init_ffh();
 
 	pci_mmcfg_late_init();
 	acpi_iort_init();
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 3015235d65e3..c026c1129cba 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -586,6 +586,7 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
 #define OSC_SB_CPC_FLEXIBLE_ADR_SPACE		0x00004000
 #define OSC_SB_NATIVE_USB4_SUPPORT		0x00040000
 #define OSC_SB_PRM_SUPPORT			0x00200000
+#define OSC_SB_FFH_OPR_SUPPORT			0x00400000
 
 extern bool osc_sb_apei_support_acked;
 extern bool osc_pc_lpi_support_confirmed;
@@ -1488,6 +1489,12 @@ void acpi_init_pcc(void);
 static inline void acpi_init_pcc(void) { }
 #endif
 
+#ifdef CONFIG_ACPI_FFH
+void acpi_init_ffh(void);
+#else
+static inline void acpi_init_ffh(void) { }
+#endif
+
 #ifdef CONFIG_ACPI
 extern void acpi_device_notify(struct device *dev);
 extern void acpi_device_notify_remove(struct device *dev);
-- 
2.38.1

