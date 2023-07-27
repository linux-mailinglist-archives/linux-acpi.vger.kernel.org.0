Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615B876551D
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Jul 2023 15:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjG0Nd6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Jul 2023 09:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjG0Nd6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Jul 2023 09:33:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C72CD2D5B
        for <linux-acpi@vger.kernel.org>; Thu, 27 Jul 2023 06:33:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DF5AD75;
        Thu, 27 Jul 2023 06:34:34 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 161C53F6C4;
        Thu, 27 Jul 2023 06:33:49 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Steve Clevenger <scclevenger@os.amperecomputing.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH] ACPI: Move AMBA bus scan handling into arm64 specific directory
Date:   Thu, 27 Jul 2023 14:33:47 +0100
Message-ID: <20230727133347.648102-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Commit fcea0ccf4fd7 ("ACPI: bus: Consolidate all arm specific
initialisation into acpi_arm_init()") moved all of the ARM-specific
initialization into acpi_arm_init(). However, acpi_amba.c being outside
of drivers/acpi/arm64 got ignored and hence acpi_amba_init() was not
moved into acpi_arm_init().

Move the AMBA platform bus support into arm64 specific folder and make
acpi_amba_init() part of acpi_arm_init().

Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/Makefile                      | 1 -
 drivers/acpi/arm64/Makefile                | 1 +
 drivers/acpi/{acpi_amba.c => arm64/amba.c} | 2 +-
 drivers/acpi/arm64/init.c                  | 2 ++
 drivers/acpi/arm64/init.h                  | 1 +
 drivers/acpi/internal.h                    | 5 -----
 drivers/acpi/scan.c                        | 1 -
 7 files changed, 5 insertions(+), 8 deletions(-)
 rename drivers/acpi/{acpi_amba.c => arm64/amba.c} (99%)

Hi Rafael and others,

While I was trying to just add drivers/acpi/acpi_amba.c under ACPI for
ARM64 entry in the MAINTAINERS, I realised it could be moved as part of
acpi_arm_init() which got completely missed last time. So I took that path
instead of add the file in the entry explicitly.

This may have to wait until the coresight changes land or if those changes
can be applied as git understands the file movement this can be applied.

Regards,
Sudeep

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 3fc5a0d54f6e..eaa09bf52f17 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -50,7 +50,6 @@ acpi-$(CONFIG_PCI)		+= acpi_lpss.o
 acpi-y				+= acpi_apd.o
 acpi-y				+= acpi_platform.o
 acpi-y				+= acpi_pnp.o
-acpi-$(CONFIG_ARM_AMBA)	+= acpi_amba.o
 acpi-y				+= power.o
 acpi-y				+= event.o
 acpi-y				+= evged.o
diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
index f81fe24894b2..143debc1ba4a 100644
--- a/drivers/acpi/arm64/Makefile
+++ b/drivers/acpi/arm64/Makefile
@@ -3,4 +3,5 @@ obj-$(CONFIG_ACPI_AGDI) 	+= agdi.o
 obj-$(CONFIG_ACPI_IORT) 	+= iort.o
 obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
 obj-$(CONFIG_ACPI_APMT) 	+= apmt.o
+obj-$(CONFIG_ARM_AMBA)		+= amba.o
 obj-y				+= dma.o init.o
diff --git a/drivers/acpi/acpi_amba.c b/drivers/acpi/arm64/amba.c
similarity index 99%
rename from drivers/acpi/acpi_amba.c
rename to drivers/acpi/arm64/amba.c
index f5b443ab01c2..b2a7631d7ac7 100644
--- a/drivers/acpi/acpi_amba.c
+++ b/drivers/acpi/arm64/amba.c
@@ -17,7 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 
-#include "internal.h"
+#include "init.h"
 
 static const struct acpi_device_id amba_id_list[] = {
 	{"ARMH0061", 0}, /* PL061 GPIO Device */
diff --git a/drivers/acpi/arm64/init.c b/drivers/acpi/arm64/init.c
index d3ce53dda122..d0c8aed90fd1 100644
--- a/drivers/acpi/arm64/init.c
+++ b/drivers/acpi/arm64/init.c
@@ -10,4 +10,6 @@ void __init acpi_arm_init(void)
 		acpi_apmt_init();
 	if (IS_ENABLED(CONFIG_ACPI_IORT))
 		acpi_iort_init();
+	if (IS_ENABLED(CONFIG_ARM_AMBA))
+		acpi_amba_init();
 }
diff --git a/drivers/acpi/arm64/init.h b/drivers/acpi/arm64/init.h
index a1715a2a34e9..dcc277977194 100644
--- a/drivers/acpi/arm64/init.h
+++ b/drivers/acpi/arm64/init.h
@@ -4,3 +4,4 @@
 void __init acpi_agdi_init(void);
 void __init acpi_apmt_init(void);
 void __init acpi_iort_init(void);
+void __init acpi_amba_init(void);
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index f4148dc50b9c..21ec31b78216 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -28,11 +28,6 @@ void acpi_processor_init(void);
 void acpi_platform_init(void);
 void acpi_pnp_init(void);
 void acpi_int340x_thermal_init(void);
-#ifdef CONFIG_ARM_AMBA
-void acpi_amba_init(void);
-#else
-static inline void acpi_amba_init(void) {}
-#endif
 int acpi_sysfs_init(void);
 void acpi_gpe_apply_masked_gpes(void);
 void acpi_container_init(void);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 5b145f1aaa1b..902763430d56 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2615,7 +2615,6 @@ void __init acpi_scan_init(void)
 	acpi_watchdog_init();
 	acpi_pnp_init();
 	acpi_int340x_thermal_init();
-	acpi_amba_init();
 	acpi_init_lpit();
 
 	acpi_scan_add_handler(&generic_device_handler);
-- 
2.41.0

