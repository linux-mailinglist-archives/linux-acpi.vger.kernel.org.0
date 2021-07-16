Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C04F3CB477
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jul 2021 10:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237069AbhGPIhx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Jul 2021 04:37:53 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3418 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237805AbhGPIhw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jul 2021 04:37:52 -0400
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GR41P26f5z6D8nl;
        Fri, 16 Jul 2021 16:20:25 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 10:34:56 +0200
Received: from A2006125610.china.huawei.com (10.47.80.222) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 09:34:49 +0100
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>,
        <wanghuiqiang@huawei.com>, <guohanjun@huawei.com>,
        <steven.price@arm.com>, <Sami.Mujawar@arm.com>,
        <jon@solid-run.com>, <eric.auger@redhat.com>,
        <yangyicong@huawei.com>
Subject: [PATCH v6 1/9] iommu: Introduce a union to struct iommu_resv_region
Date:   Fri, 16 Jul 2021 09:34:34 +0100
Message-ID: <20210716083442.1708-2-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210716083442.1708-1-shameerali.kolothum.thodi@huawei.com>
References: <20210716083442.1708-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.80.222]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

A union is introduced to struct iommu_resv_region to hold
any firmware specific data. This is in preparation to add
support for IORT RMR reserve regions and the union now holds
the RMR specific information.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 include/linux/iommu.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 32d448050bf7..bd0e4641c569 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -114,6 +114,13 @@ enum iommu_resv_type {
 	IOMMU_RESV_SW_MSI,
 };
 
+struct iommu_iort_rmr_data {
+#define IOMMU_RMR_REMAP_PERMITTED	(1 << 0)
+	u32 flags;
+	u32 sid;	/* Stream Id associated with RMR entry */
+	void *smmu;	/* Associated IORT SMMU node pointer */
+};
+
 /**
  * struct iommu_resv_region - descriptor for a reserved memory region
  * @list: Linked list pointers
@@ -121,6 +128,7 @@ enum iommu_resv_type {
  * @length: Length of the region in bytes
  * @prot: IOMMU Protection flags (READ/WRITE/...)
  * @type: Type of the reserved region
+ * @rmr: ACPI IORT RMR specific data
  */
 struct iommu_resv_region {
 	struct list_head	list;
@@ -128,6 +136,9 @@ struct iommu_resv_region {
 	size_t			length;
 	int			prot;
 	enum iommu_resv_type	type;
+	union {
+		struct iommu_iort_rmr_data rmr;
+	} fw_data;
 };
 
 /**
-- 
2.17.1

