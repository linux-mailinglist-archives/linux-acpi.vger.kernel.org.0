Return-Path: <linux-acpi+bounces-2218-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4871E809C65
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 07:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FDF51C20C17
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 06:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB5610941
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 06:33:04 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB8BE171C;
	Thu,  7 Dec 2023 21:39:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F10F139F;
	Thu,  7 Dec 2023 21:40:42 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.41.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5D4503F5A1;
	Thu,  7 Dec 2023 21:39:52 -0800 (PST)
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
Subject: [PATCH V3 01/10] coresight: stm: Extract device name from AMBA pid based table lookup
Date: Fri,  8 Dec 2023 11:09:30 +0530
Message-Id: <20231208053939.42901-2-anshuman.khandual@arm.com>
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

Instead of using AMBA private data field, extract the device name from AMBA
pid based table lookup using new coresight_get_uci_data_from_amba() helper.

Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: James Clark <james.clark@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in V3:

- New patch in the series

 drivers/hwtracing/coresight/coresight-priv.h | 10 ++++++++++
 drivers/hwtracing/coresight/coresight-stm.c  | 14 +++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 767076e07970..68cbb036cec8 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -221,6 +221,16 @@ static inline void *coresight_get_uci_data(const struct amba_id *id)
 	return uci_id->data;
 }
 
+static inline void *coresight_get_uci_data_from_amba(const struct amba_id *table, u32 pid)
+{
+	while (table->mask) {
+		if ((table->id & table->mask) == pid)
+			return coresight_get_uci_data(table);
+		table++;
+	};
+	return NULL;
+}
+
 void coresight_release_platform_data(struct coresight_device *csdev,
 				     struct device *dev,
 				     struct coresight_platform_data *pdata);
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index a1c27c901ad1..9cdca4f86cab 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -804,6 +804,18 @@ static void stm_init_generic_data(struct stm_drvdata *drvdata,
 	drvdata->stm.set_options = stm_generic_set_options;
 }
 
+#define STM_AMBA_MASK 0xfffff
+
+static const struct amba_id stm_ids[];
+
+static char *stm_csdev_name(struct coresight_device *csdev)
+{
+	u32 stm_pid = coresight_get_pid(&csdev->access) & STM_AMBA_MASK;
+	void *uci_data = coresight_get_uci_data_from_amba(stm_ids, stm_pid);
+
+	return uci_data ? (char *)uci_data : "STM";
+}
+
 static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	int ret, trace_id;
@@ -900,7 +912,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 	pm_runtime_put(&adev->dev);
 
 	dev_info(&drvdata->csdev->dev, "%s initialized\n",
-		 (char *)coresight_get_uci_data(id));
+		 stm_csdev_name(drvdata->csdev));
 	return 0;
 
 cs_unregister:
-- 
2.25.1


