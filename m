Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9497DDA76A
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2019 10:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389585AbfJQI3U (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Oct 2019 04:29:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42638 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388560AbfJQI3U (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Oct 2019 04:29:20 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C2CF3893A16271D7D653;
        Thu, 17 Oct 2019 16:29:18 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Thu, 17 Oct 2019 16:29:11 +0800
From:   Tian Tao <tiantao6@huawei.com>
To:     <jonathan.cameron@huawei.com>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH] ACPI: fix the warning assignment of 0/1 to bool variable
Date:   Thu, 17 Oct 2019 16:26:33 +0800
Message-ID: <1571300793-41282-1-git-send-email-tiantao6@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It fixes the warning as follows reported by coccicheck:
drivers/acpi/cppc_acpi.c:908:4-45: WARNING: Assignment of 0/1
to bool variable.

Signed-off-by: Tian Tao <tiantao6@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 3b25259..3afbd1e 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -905,7 +905,7 @@ void acpi_cppc_processor_exit(struct acpi_processor *pr)
 			pcc_data[pcc_ss_id]->refcount--;
 			if (!pcc_data[pcc_ss_id]->refcount) {
 				pcc_mbox_free_channel(pcc_data[pcc_ss_id]->pcc_channel);
-				pcc_data[pcc_ss_id]->pcc_channel_acquired = 0;
+				pcc_data[pcc_ss_id]->pcc_channel_acquired = false;
 				kfree(pcc_data[pcc_ss_id]);
 			}
 		}
-- 
2.7.4

