Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A017A0333
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Sep 2023 14:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbjINMBO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Sep 2023 08:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbjINMBN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Sep 2023 08:01:13 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B591BE8;
        Thu, 14 Sep 2023 05:01:09 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RmbRQ2w1DzMlLL;
        Thu, 14 Sep 2023 19:57:38 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 14 Sep 2023 20:01:06 +0800
From:   Huisong Li <lihuisong@huawei.com>
To:     <rafael@kernel.org>, <rafael.j.wysocki@intel.com>,
        <sudeep.holla@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH] mailbox: pcc: export the PCC subspace type
Date:   Thu, 14 Sep 2023 19:57:53 +0800
Message-ID: <20230914115753.9064-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

As stated in APCI spec, the size of the subspace shared memory region may
be different for different types. So it is useful for driver to fill PCC
communication space. But the driver used this PCC channel doesn't know what
is the subspace type of the channel.

So export the PCC subspace type by requesting PCC channel.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/mailbox/pcc.c | 10 ++++------
 include/acpi/pcc.h    |  1 +
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 94885e411085..9742cc7837bd 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -91,7 +91,6 @@ struct pcc_chan_reg {
  * @cmd_update: PCC register bundle for the command complete update register
  * @error: PCC register bundle for the error status register
  * @plat_irq: platform interrupt
- * @type: PCC subspace type
  * @plat_irq_flags: platform interrupt flags
  * @chan_in_use: this flag is used just to check if the interrupt needs
  *		handling when it is shared. Since only one transfer can occur
@@ -108,7 +107,6 @@ struct pcc_chan_info {
 	struct pcc_chan_reg cmd_update;
 	struct pcc_chan_reg error;
 	int plat_irq;
-	u8 type;
 	unsigned int plat_irq_flags;
 	bool chan_in_use;
 };
@@ -263,7 +261,7 @@ static bool pcc_mbox_cmd_complete_check(struct pcc_chan_info *pchan)
 	 * bit 0 indicates that Platform is sending a notification and OSPM
 	 * needs to respond this interrupt to process this command.
 	 */
-	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
+	if (pchan->chan.type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
 		return !val;
 
 	return !!val;
@@ -284,7 +282,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	int ret;
 
 	pchan = chan->con_priv;
-	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE &&
+	if (pchan->chan.type == ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE &&
 	    !pchan->chan_in_use)
 		return IRQ_NONE;
 
@@ -312,7 +310,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	 *
 	 * The PCC master subspace channel clears chan_in_use to free channel.
 	 */
-	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
+	if (pchan->chan.type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
 		pcc_send_data(chan, NULL);
 	pchan->chan_in_use = false;
 
@@ -766,7 +764,7 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 
 		pcc_parse_subspace_shmem(pchan, pcct_entry);
 
-		pchan->type = pcct_entry->type;
+		pchan->chan.type = pcct_entry->type;
 		pcct_entry = (struct acpi_subtable_header *)
 			((unsigned long) pcct_entry + pcct_entry->length);
 	}
diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
index 73e806fe7ce7..eddf9f5dfba3 100644
--- a/include/acpi/pcc.h
+++ b/include/acpi/pcc.h
@@ -16,6 +16,7 @@ struct pcc_mbox_chan {
 	u32 latency;
 	u32 max_access_rate;
 	u16 min_turnaround_time;
+	u8 type;
 };
 
 #define MAX_PCC_SUBSPACES	256
-- 
2.33.0

