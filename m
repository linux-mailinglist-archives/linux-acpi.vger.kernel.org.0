Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1160247E84
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Aug 2020 08:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgHRGgv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 Aug 2020 02:36:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35318 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726421AbgHRGgr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Aug 2020 02:36:47 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A265EA9449FAE5FEAB7D;
        Tue, 18 Aug 2020 14:36:43 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.226) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 18 Aug 2020 14:36:37 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <lorenzo.pieralisi@arm.com>, <guohanjun@huawei.com>,
        <sudeep.holla@arm.com>
CC:     <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v2 2/2] ACPI/IORT: Remove the unused inline functions
Date:   Tue, 18 Aug 2020 14:36:25 +0800
Message-ID: <20200818063625.980-3-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20200818063625.980-1-yuzenghui@huawei.com>
References: <20200818063625.980-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.226]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Since commit 8212688600ed ("ACPI/IORT: Fix build error when IOMMU_SUPPORT
is disabled"), iort_fwspec_iommu_ops() and iort_add_device_replay() are not
needed anymore when CONFIG_IOMMU_API is not selected. Let's remove them.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 drivers/acpi/arm64/iort.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index a0ece0e201b2..e670785a6201 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1086,10 +1086,6 @@ const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
 }
 
 #else
-static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev)
-{ return NULL; }
-static inline int iort_add_device_replay(struct device *dev)
-{ return 0; }
 int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 { return 0; }
 const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
-- 
2.19.1

