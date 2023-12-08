Return-Path: <linux-acpi+bounces-2220-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE958809C67
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 07:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AFE21C2074D
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 06:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBA5D51B
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 06:33:14 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D4891738;
	Thu,  7 Dec 2023 21:40:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4D5A11FB;
	Thu,  7 Dec 2023 21:40:52 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.41.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 413633F5A1;
	Thu,  7 Dec 2023 21:40:01 -0800 (PST)
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
	linux-stm32@st-md-mailman.stormreply.com,
	Leo Yan <leo.yan@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH V3 03/10] coresight: Add helpers registering/removing both AMBA and platform drivers
Date: Fri,  8 Dec 2023 11:09:32 +0530
Message-Id: <20231208053939.42901-4-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231208053939.42901-1-anshuman.khandual@arm.com>
References: <20231208053939.42901-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds two different helpers i.e coresight_init_driver()/remove_driver()
enabling coresight devices to register or remove AMBA and platform drivers.

Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: James Clark <james.clark@arm.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: coresight@lists.linaro.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in V3:

- New patch in the series

 drivers/hwtracing/coresight/coresight-core.c | 29 ++++++++++++++++++++
 include/linux/coresight.h                    |  7 +++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 9fabe00a40d6..ede9b0723f95 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1833,6 +1833,35 @@ static void __exit coresight_exit(void)
 module_init(coresight_init);
 module_exit(coresight_exit);
 
+int coresight_init_driver(const char *drv, struct amba_driver *amba_drv,
+			  struct platform_driver *pdev_drv)
+{
+	int ret;
+
+	ret = amba_driver_register(amba_drv);
+	if (ret) {
+		pr_err("%s: error registering AMBA driver\n", drv);
+		return ret;
+	}
+
+	ret = platform_driver_register(pdev_drv);
+	if (!ret)
+		return 0;
+
+	pr_err("%s: error registering platform driver\n", drv);
+	amba_driver_unregister(amba_drv);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(coresight_init_driver);
+
+void coresight_remove_driver(struct amba_driver *amba_drv,
+			     struct platform_driver *pdev_drv)
+{
+	amba_driver_unregister(amba_drv);
+	platform_driver_unregister(pdev_drv);
+}
+EXPORT_SYMBOL_GPL(coresight_remove_driver);
+
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
 MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index a269fffaf991..be7fe3793763 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -12,6 +12,8 @@
 #include <linux/io.h>
 #include <linux/perf_event.h>
 #include <linux/sched.h>
+#include <linux/amba/bus.h>
+#include <linux/platform_device.h>
 
 /* Peripheral id registers (0xFD0-0xFEC) */
 #define CORESIGHT_PERIPHIDR4	0xfd0
@@ -597,6 +599,11 @@ void coresight_relaxed_write64(struct coresight_device *csdev,
 			       u64 val, u32 offset);
 void coresight_write64(struct coresight_device *csdev, u64 val, u32 offset);
 
+int coresight_init_driver(const char *drv, struct amba_driver *amba_drv,
+			  struct platform_driver *pdev_drv);
+
+void coresight_remove_driver(struct amba_driver *amba_drv,
+			     struct platform_driver *pdev_drv);
 #else
 static inline struct coresight_device *
 coresight_register(struct coresight_desc *desc) { return NULL; }
-- 
2.25.1


