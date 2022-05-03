Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C9E518A08
	for <lists+linux-acpi@lfdr.de>; Tue,  3 May 2022 18:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239525AbiECQh6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 May 2022 12:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiECQh5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 3 May 2022 12:37:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4683CA78
        for <linux-acpi@vger.kernel.org>; Tue,  3 May 2022 09:34:24 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Kt57x2Dcyz67y8S;
        Wed,  4 May 2022 00:31:41 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 3 May 2022 18:34:22 +0200
Received: from A2006125610.china.huawei.com (10.202.227.178) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 3 May 2022 17:34:15 +0100
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>, <will@kernel.org>,
        <wanghuiqiang@huawei.com>, <guohanjun@huawei.com>,
        <steven.price@arm.com>, <Sami.Mujawar@arm.com>,
        <jon@solid-run.com>, <eric.auger@redhat.com>,
        <laurentiu.tudor@nxp.com>, <hch@infradead.org>
Subject: [PATCH v12 1/9] iommu: Introduce a callback to struct iommu_resv_region
Date:   Tue, 3 May 2022 17:33:22 +0100
Message-ID: <20220503163330.509-2-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20220503163330.509-1-shameerali.kolothum.thodi@huawei.com>
References: <20220503163330.509-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.227.178]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

A callback is introduced to struct iommu_resv_region to free memory
allocations associated with the reserved region. This will be useful
when we introduce support for IORT RMR based reserved regions.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Steven Price <steven.price@arm.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/iommu.c | 16 +++++++++++-----
 include/linux/iommu.h |  2 ++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f2c45b85b9fc..ffcfa684e80c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2597,16 +2597,22 @@ void iommu_put_resv_regions(struct device *dev, struct list_head *list)
  * @list: reserved region list for device
  *
  * IOMMU drivers can use this to implement their .put_resv_regions() callback
- * for simple reservations. Memory allocated for each reserved region will be
- * freed. If an IOMMU driver allocates additional resources per region, it is
- * going to have to implement a custom callback.
+ * for simple reservations. If a per region callback is provided that will be
+ * used to free all memory allocations associated with the reserved region or
+ * else just free up the memory for the regions. If an IOMMU driver allocates
+ * additional resources per region, it is going to have to implement a custom
+ * callback.
  */
 void generic_iommu_put_resv_regions(struct device *dev, struct list_head *list)
 {
 	struct iommu_resv_region *entry, *next;
 
-	list_for_each_entry_safe(entry, next, list, list)
-		kfree(entry);
+	list_for_each_entry_safe(entry, next, list, list) {
+		if (entry->free)
+			entry->free(dev, entry);
+		else
+			kfree(entry);
+	}
 }
 EXPORT_SYMBOL(generic_iommu_put_resv_regions);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 9208eca4b0d1..68bcfb3a06d7 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -134,6 +134,7 @@ enum iommu_resv_type {
  * @length: Length of the region in bytes
  * @prot: IOMMU Protection flags (READ/WRITE/...)
  * @type: Type of the reserved region
+ * @free: Callback to free associated memory allocations
  */
 struct iommu_resv_region {
 	struct list_head	list;
@@ -141,6 +142,7 @@ struct iommu_resv_region {
 	size_t			length;
 	int			prot;
 	enum iommu_resv_type	type;
+	void (*free)(struct device *dev, struct iommu_resv_region *region);
 };
 
 /**
-- 
2.17.1

