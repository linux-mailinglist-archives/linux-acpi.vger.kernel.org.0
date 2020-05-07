Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096641C8CE3
	for <lists+linux-acpi@lfdr.de>; Thu,  7 May 2020 15:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgEGNrV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 May 2020 09:47:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3900 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726470AbgEGNrU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 May 2020 09:47:20 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1F1899D09F94E6F0C063;
        Thu,  7 May 2020 21:47:18 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 21:47:11 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Sudeep Holla" <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH] ACPI: IORT: Add extra message "applying workaround" for off-by-1 issue
Date:   Thu, 7 May 2020 21:41:08 +0800
Message-ID: <1588858868-18039-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

As we already applied a workaround for the off-by-1 issue,
it's good to add extra message "applying workaround" to
make people less uneasy to see such message in the boot log.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---

Based on top of for-next/acpi branch of ARM64 repo

 drivers/acpi/arm64/iort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index b011d25..f3d492a 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -328,7 +328,7 @@ static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
 		 * Otherwise, things are *really* broken, and we just disregard
 		 * duplicate matches entirely to retain compatibility.
 		 */
-		pr_err(FW_BUG "[map %p] conflicting mapping for input ID 0x%x\n",
+		pr_err(FW_BUG "[map %p] conflicting mapping for input ID 0x%x, applying workaround\n",
 		       map, rid_in);
 		if (rid_in != map->input_base)
 			return -ENXIO;
-- 
1.7.12.4

