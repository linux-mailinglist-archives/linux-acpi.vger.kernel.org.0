Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A56028DDBE
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Oct 2020 11:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgJNJf6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Oct 2020 05:35:58 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2978 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725960AbgJNJf5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Oct 2020 05:35:57 -0400
Received: from lhreml715-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 96EED2E1D1A2E0660CA8;
        Wed, 14 Oct 2020 10:35:55 +0100 (IST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.85.245) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Wed, 14 Oct 2020 10:35:55 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <lorenzo.pieralisi@arm.com>,
        <guohanjun@huawei.com>, <sudeep.holla@arm.com>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH 1/1] ACPI/IORT: Fix doc warnings in iort.c
Date:   Wed, 14 Oct 2020 10:31:39 +0100
Message-ID: <20201014093139.1580-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.85.245]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml715-chm.china.huawei.com (10.201.108.66)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fix following warnings caused by mismatch between
function parameters and function comments.

drivers/acpi/arm64/iort.c:55: warning: Function parameter or member 'iort_node' not described in 'iort_set_fwnode'
drivers/acpi/arm64/iort.c:55: warning: Excess function parameter 'node' description in 'iort_set_fwnode'
drivers/acpi/arm64/iort.c:682: warning: Function parameter or member 'id' not described in 'iort_get_device_domain'
drivers/acpi/arm64/iort.c:682: warning: Function parameter or member 'bus_token' not described in 'iort_get_device_domain'
drivers/acpi/arm64/iort.c:682: warning: Excess function parameter 'req_id' description in 'iort_get_device_domain'
drivers/acpi/arm64/iort.c:1142: warning: Function parameter or member 'dma_size' not described in 'iort_dma_setup'
drivers/acpi/arm64/iort.c:1142: warning: Excess function parameter 'size' description in 'iort_dma_setup'
drivers/acpi/arm64/iort.c:1534: warning: Function parameter or member 'ops' not described in 'iort_add_platform_device'

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/acpi/arm64/iort.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 9929ff50c0c0..770d84071a32 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -44,7 +44,7 @@ static DEFINE_SPINLOCK(iort_fwnode_lock);
  * iort_set_fwnode() - Create iort_fwnode and use it to register
  *		       iommu data in the iort_fwnode_list
  *
- * @node: IORT table node associated with the IOMMU
+ * @iort_node: IORT table node associated with the IOMMU
  * @fwnode: fwnode associated with the IORT node
  *
  * Returns: 0 on success
@@ -673,7 +673,8 @@ static int iort_dev_find_its_id(struct device *dev, u32 id,
 /**
  * iort_get_device_domain() - Find MSI domain related to a device
  * @dev: The device.
- * @req_id: Requester ID for the device.
+ * @id: Requester ID for the device.
+ * @bus_token: irq domain bus token.
  *
  * Returns: the MSI domain for this device, NULL otherwise
  */
@@ -1136,7 +1137,7 @@ static int rc_dma_get_range(struct device *dev, u64 *size)
  *
  * @dev: device to configure
  * @dma_addr: device DMA address result pointer
- * @size: DMA range size result pointer
+ * @dma_size: DMA range size result pointer
  */
 void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
 {
@@ -1526,6 +1527,7 @@ static __init const struct iort_dev_config *iort_get_dev_cfg(
 /**
  * iort_add_platform_device() - Allocate a platform device for IORT node
  * @node: Pointer to device ACPI IORT node
+ * @ops: Pointer to IORT device config struct
  *
  * Returns: 0 on success, <0 failure
  */
-- 
2.17.1


