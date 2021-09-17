Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7713E40F947
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Sep 2021 15:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244997AbhIQNfu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 17 Sep 2021 09:35:50 -0400
Received: from foss.arm.com ([217.140.110.172]:53314 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245138AbhIQNfj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Sep 2021 09:35:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 396DE11B3;
        Fri, 17 Sep 2021 06:34:16 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 54CF43F719;
        Fri, 17 Sep 2021 06:34:15 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH v2 08/14] mailbox: pcc: Rename doorbell ack to platform interrupt ack register
Date:   Fri, 17 Sep 2021 14:33:51 +0100
Message-Id: <20210917133357.1911092-9-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210917133357.1911092-1-sudeep.holla@arm.com>
References: <20210917133357.1911092-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The specification refers this register and associated bitmask as platform
interrupt acknowledge register. Let us rename it so that it is easier to
map and understand.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 453a58fda3a4..ae4b7a4b3531 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -69,14 +69,15 @@ static struct mbox_chan *pcc_mbox_channels;
  *
  * @chan: PCC channel information with Shared Memory Region info
  * @db_vaddr: cached virtual address for doorbell register
- * @db_ack_vaddr: cached virtual address for doorbell ack register
- * @db_irq: doorbell interrupt
+ * @plat_irq_ack_vaddr: cached virtual address for platform interrupt
+ *	acknowledge register
+ * @plat_irq: platform interrupt
  */
 struct pcc_chan_info {
 	struct pcc_mbox_chan chan;
 	void __iomem *db_vaddr;
-	void __iomem *db_ack_vaddr;
-	int db_irq;
+	void __iomem *plat_irq_ack_vaddr;
+	int plat_irq;
 };
 
 #define to_pcc_chan_info(c) container_of(c, struct pcc_chan_info, chan)
@@ -198,12 +199,12 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 		doorbell_ack_preserve = pcct2_ss->ack_preserve_mask;
 		doorbell_ack_write = pcct2_ss->ack_write_mask;
 
-		ret = read_register(pchan->db_ack_vaddr,
+		ret = read_register(pchan->plat_irq_ack_vaddr,
 				    &doorbell_ack_val, doorbell_ack->bit_width);
 		if (ret)
 			return IRQ_NONE;
 
-		ret = write_register(pchan->db_ack_vaddr,
+		ret = write_register(pchan->plat_irq_ack_vaddr,
 				     (doorbell_ack_val & doorbell_ack_preserve)
 					| doorbell_ack_write,
 				     doorbell_ack->bit_width);
@@ -256,14 +257,14 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 
 	spin_unlock_irqrestore(&chan->lock, flags);
 
-	if (pchan->db_irq > 0) {
+	if (pchan->plat_irq > 0) {
 		int rc;
 
-		rc = devm_request_irq(dev, pchan->db_irq, pcc_mbox_irq, 0,
+		rc = devm_request_irq(dev, pchan->plat_irq, pcc_mbox_irq, 0,
 				      MBOX_IRQ_NAME, chan);
 		if (unlikely(rc)) {
 			dev_err(dev, "failed to register PCC interrupt %d\n",
-				pchan->db_irq);
+				pchan->plat_irq);
 			pcc_mbox_free_channel(&pchan->chan);
 			return ERR_PTR(rc);
 		}
@@ -288,8 +289,8 @@ void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
 	if (!chan || !chan->cl)
 		return;
 
-	if (pchan_info->db_irq > 0)
-		devm_free_irq(chan->mbox->dev, pchan_info->db_irq, chan);
+	if (pchan_info->plat_irq > 0)
+		devm_free_irq(chan->mbox->dev, pchan_info->plat_irq, chan);
 
 	spin_lock_irqsave(&chan->lock, flags);
 	chan->cl = NULL;
@@ -400,9 +401,9 @@ static int pcc_parse_subspace_irq(struct pcc_chan_info *pchan,
 		return 0;
 
 	pcct_ss = (struct acpi_pcct_hw_reduced *)pcct_entry;
-	pchan->db_irq = pcc_map_interrupt(pcct_ss->platform_interrupt,
-					  (u32)pcct_ss->flags);
-	if (pchan->db_irq <= 0) {
+	pchan->plat_irq = pcc_map_interrupt(pcct_ss->platform_interrupt,
+					    (u32)pcct_ss->flags);
+	if (pchan->plat_irq <= 0) {
 		pr_err("PCC GSI %d not registered\n",
 		       pcct_ss->platform_interrupt);
 		return -EINVAL;
@@ -411,10 +412,10 @@ static int pcc_parse_subspace_irq(struct pcc_chan_info *pchan,
 	if (pcct_ss->header.type == ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2) {
 		struct acpi_pcct_hw_reduced_type2 *pcct2_ss = (void *)pcct_ss;
 
-		pchan->db_ack_vaddr =
+		pchan->plat_irq_ack_vaddr =
 			acpi_os_ioremap(pcct2_ss->platform_ack_register.address,
 					pcct2_ss->platform_ack_register.bit_width / 8);
-		if (!pchan->db_ack_vaddr) {
+		if (!pchan->plat_irq_ack_vaddr) {
 			pr_err("Failed to ioremap PCC ACK register\n");
 			return -ENOMEM;
 		}
-- 
2.25.1

