Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92313246507
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Aug 2020 13:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgHQLAj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Aug 2020 07:00:39 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47540 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726802AbgHQLAY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 17 Aug 2020 07:00:24 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 24B4A599F9685D733EF6;
        Mon, 17 Aug 2020 19:00:21 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.226) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Mon, 17 Aug 2020 19:00:10 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <lorenzo.pieralisi@arm.com>, <guohanjun@huawei.com>,
        <sudeep.holla@arm.com>
CC:     <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] ACPI/IORT: Drop the unused @ops of iort_add_device_replay()
Date:   Mon, 17 Aug 2020 18:59:46 +0800
Message-ID: <20200817105946.1511-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.226]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Since commit d2e1a003af56 ("ACPI/IORT: Don't call iommu_ops->add_device
directly"), we use the IOMMU core API to replace a direct invoke of the
specified callback. The parameter @ops has therefore became unused. Let's
drop it.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 drivers/acpi/arm64/iort.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index ec782e4a0fe4..a0ece0e201b2 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -811,8 +811,7 @@ static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev)
 	return (fwspec && fwspec->ops) ? fwspec->ops : NULL;
 }
 
-static inline int iort_add_device_replay(const struct iommu_ops *ops,
-					 struct device *dev)
+static inline int iort_add_device_replay(struct device *dev)
 {
 	int err = 0;
 
@@ -1072,7 +1071,7 @@ const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
 	 */
 	if (!err) {
 		ops = iort_fwspec_iommu_ops(dev);
-		err = iort_add_device_replay(ops, dev);
+		err = iort_add_device_replay(dev);
 	}
 
 	/* Ignore all other errors apart from EPROBE_DEFER */
@@ -1089,8 +1088,7 @@ const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
 #else
 static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev)
 { return NULL; }
-static inline int iort_add_device_replay(const struct iommu_ops *ops,
-					 struct device *dev)
+static inline int iort_add_device_replay(struct device *dev)
 { return 0; }
 int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 { return 0; }
-- 
2.19.1

