Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7F481E727
	for <lists+linux-acpi@lfdr.de>; Wed, 15 May 2019 05:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfEODd6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 May 2019 23:33:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59604 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726201AbfEODd5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 14 May 2019 23:33:57 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CBFBD7F6CF26B9D058A2;
        Wed, 15 May 2019 11:33:55 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Wed, 15 May 2019 11:33:46 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <guohanjun@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH RESEND] ACPI/IORT: Fix build error when IOMMU_SUPPORT disabled
Date:   Wed, 15 May 2019 11:42:53 +0800
Message-ID: <20190515034253.79348-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190515033406.79020-1-wangkefeng.wang@huawei.com>
References: <20190515033406.79020-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

drivers/acpi/arm64/iort.c: In function iort_iommu_configure:
drivers/acpi/arm64/iort.c:1079:21: error: struct iommu_fwspec has no member named flags
    dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
                     ^~
drivers/acpi/arm64/iort.c:1079:32: error: IOMMU_FWSPEC_PCI_RC_ATS
undeclared (first use in this function)
    dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
                                ^~~~~~~~~~~~~~~~~~~~~~~
drivers/acpi/arm64/iort.c:1079:32: note: each undeclared identifier is reported only once for each function it appears in

If IOMMU_SUPPORT not enabled, struct iommu_fwspec without members and
IOMMU_FWSPEC_PCI_RC_ATS not defined, add new iommu_fwspec_set_ats_flags()
to set IOMMU_FWSPEC_PCI_RC_ATS flags to solve build error.

Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 5702ee24182f ("ACPI/IORT: Check ATS capability in root complex nodes")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/acpi/arm64/iort.c | 2 +-
 include/linux/iommu.h     | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 9058cb084b91..4ccf0dd99852 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1076,7 +1076,7 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 					     iort_pci_iommu_init, &info);
 
 		if (!err && iort_pci_rc_supports_ats(node))
-			dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
+			iommu_fwspec_set_ats_flags(dev);
 	} else {
 		int i = 0;
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a815cf6f6f47..0a84556c0eb6 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -479,6 +479,11 @@ static inline void dev_iommu_fwspec_set(struct device *dev,
 	dev->iommu_fwspec = fwspec;
 }
 
+static inline void iommu_fwspec_set_ats_flags(struct device *dev)
+{
+	dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
+}
+
 int iommu_probe_device(struct device *dev);
 void iommu_release_device(struct device *dev);
 
@@ -770,6 +775,10 @@ static inline void iommu_fwspec_free(struct device *dev)
 {
 }
 
+static inline void iommu_fwspec_set_ats_flags(struct device *dev)
+{
+}
+
 static inline int iommu_fwspec_add_ids(struct device *dev, u32 *ids,
 				       int num_ids)
 {
-- 
2.20.1

