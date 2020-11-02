Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9235C2A28F3
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Nov 2020 12:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgKBLXV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Nov 2020 06:23:21 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7400 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbgKBLXU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Nov 2020 06:23:20 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CPrBX2zbDz72HN;
        Mon,  2 Nov 2020 19:23:16 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 2 Nov 2020 19:23:08 +0800
From:   John Garry <john.garry@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH] ACPI: scan: Fix acpi_dma_configure_id() kerneldoc name
Date:   Mon, 2 Nov 2020 19:19:31 +0800
Message-ID: <1604315971-89149-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

For some reason building with W=1 doesn't pick up on this, but the
kerneldoc name for acpi_dma_configure_id() is not right, so fix it up.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index a896e5e87c93..bc6a79e33220 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1453,7 +1453,7 @@ int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
 }
 
 /**
- * acpi_dma_configure - Set-up DMA configuration for the device.
+ * acpi_dma_configure_id - Set-up DMA configuration for the device.
  * @dev: The pointer to the device
  * @attr: device dma attributes
  * @input_id: input device id const value pointer
-- 
2.26.2

