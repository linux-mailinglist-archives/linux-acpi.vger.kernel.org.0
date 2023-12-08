Return-Path: <linux-acpi+bounces-2219-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB7A809C66
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 07:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6C91C209AB
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 06:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF656ABB
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 06:33:09 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBA4C1721;
	Thu,  7 Dec 2023 21:40:01 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 756A011FB;
	Thu,  7 Dec 2023 21:40:47 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.41.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3CBD73F5A1;
	Thu,  7 Dec 2023 21:39:56 -0800 (PST)
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
Subject: [PATCH V3 02/10] coresight: tmc: Extract device properties from AMBA pid based table lookup
Date: Fri,  8 Dec 2023 11:09:31 +0530
Message-Id: <20231208053939.42901-3-anshuman.khandual@arm.com>
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

This extracts device properties from AMBA pid based table lookup. This also
defers tmc_etr_setup_caps() after the coresight device has been initialized
so that pid value can be read.

Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: James Clark <james.clark@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in V3:

- New patch in the series

 .../hwtracing/coresight/coresight-tmc-core.c  | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index c106d142e632..ad61d02f5f75 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -362,16 +362,24 @@ static inline bool tmc_etr_has_non_secure_access(struct tmc_drvdata *drvdata)
 	return (auth & TMC_AUTH_NSID_MASK) == 0x3;
 }
 
+#define TMC_AMBA_MASK 0xfffff
+
+static const struct amba_id tmc_ids[];
+
 /* Detect and initialise the capabilities of a TMC ETR */
-static int tmc_etr_setup_caps(struct device *parent, u32 devid, void *dev_caps)
+static int tmc_etr_setup_caps(struct device *parent, u32 devid)
 {
 	int rc;
-	u32 dma_mask = 0;
+	u32 tmc_pid, dma_mask = 0;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(parent);
+	void *dev_caps;
 
 	if (!tmc_etr_has_non_secure_access(drvdata))
 		return -EACCES;
 
+	tmc_pid = coresight_get_pid(&drvdata->csdev->access) & TMC_AMBA_MASK;
+	dev_caps = coresight_get_uci_data_from_amba(tmc_ids, tmc_pid);
+
 	/* Set the unadvertised capabilities */
 	tmc_etr_init_caps(drvdata, (u32)(unsigned long)dev_caps);
 
@@ -487,10 +495,6 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 		desc.type = CORESIGHT_DEV_TYPE_SINK;
 		desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM;
 		desc.ops = &tmc_etr_cs_ops;
-		ret = tmc_etr_setup_caps(dev, devid,
-					 coresight_get_uci_data(id));
-		if (ret)
-			goto out;
 		idr_init(&drvdata->idr);
 		mutex_init(&drvdata->idr_mutex);
 		dev_list = &etr_devs;
@@ -528,6 +532,9 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 		goto out;
 	}
 
+	if (drvdata->config_type == TMC_CONFIG_TYPE_ETR)
+		ret = tmc_etr_setup_caps(dev, devid);
+
 	drvdata->miscdev.name = desc.name;
 	drvdata->miscdev.minor = MISC_DYNAMIC_MINOR;
 	drvdata->miscdev.fops = &tmc_fops;
-- 
2.25.1


