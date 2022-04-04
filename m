Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88B04F1512
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Apr 2022 14:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344509AbiDDMpB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Apr 2022 08:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbiDDMpA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Apr 2022 08:45:00 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DF12F3A5
        for <linux-acpi@vger.kernel.org>; Mon,  4 Apr 2022 05:43:04 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KX9PC1Cqvz67bZ4;
        Mon,  4 Apr 2022 20:41:03 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 14:43:02 +0200
Received: from A2006125610.china.huawei.com (10.47.93.34) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 13:42:54 +0100
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>, <will@kernel.org>,
        <wanghuiqiang@huawei.com>, <guohanjun@huawei.com>,
        <steven.price@arm.com>, <Sami.Mujawar@arm.com>,
        <jon@solid-run.com>, <eric.auger@redhat.com>,
        <laurentiu.tudor@nxp.com>, <yangyicong@huawei.com>
Subject: [PATCH v9 01/11] ACPI/IORT: Add temporary RMR node flag definitions
Date:   Mon, 4 Apr 2022 13:41:59 +0100
Message-ID: <20220404124209.1086-2-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
References: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.93.34]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

IORT rev E.d introduces more details into the RMR node Flags
field. Add temporary definitions to describe and access these
Flags field until ACPICA header is updated to support E.d.

This patch can be reverted once the include/acpi/actbl2.h has
all the relevant definitions.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
Please find the ACPICA E.d related changes pull request here,
https://github.com/acpica/acpica/pull/765

This is now merged to acpica:master.

---
 drivers/acpi/arm64/iort.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index f2f8f05662de..fd06cf43ba31 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -25,6 +25,30 @@
 #define IORT_IOMMU_TYPE		((1 << ACPI_IORT_NODE_SMMU) |	\
 				(1 << ACPI_IORT_NODE_SMMU_V3))
 
+/*
+ * The following RMR related definitions are temporary and
+ * can be removed once ACPICA headers support IORT rev E.d
+ */
+#ifndef ACPI_IORT_RMR_REMAP_PERMITTED
+#define ACPI_IORT_RMR_REMAP_PERMITTED	(1)
+#endif
+
+#ifndef ACPI_IORT_RMR_ACCESS_PRIVILEGE
+#define ACPI_IORT_RMR_ACCESS_PRIVILEGE	(1 << 1)
+#endif
+
+#ifndef ACPI_IORT_RMR_ACCESS_ATTRIBUTES
+#define ACPI_IORT_RMR_ACCESS_ATTRIBUTES(flags)	(((flags) >> 2) & 0xFF)
+#endif
+
+#ifndef ACPI_IORT_RMR_ATTR_DEVICE_GRE
+#define ACPI_IORT_RMR_ATTR_DEVICE_GRE	0x03
+#endif
+
+#ifndef ACPI_IORT_RMR_ATTR_NORMAL_IWB_OWB
+#define ACPI_IORT_RMR_ATTR_NORMAL_IWB_OWB	0x05
+#endif
+
 struct iort_its_msi_chip {
 	struct list_head	list;
 	struct fwnode_handle	*fw_node;
-- 
2.25.1

