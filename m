Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA343C18EA
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jul 2021 20:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhGHSLp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Jul 2021 14:11:45 -0400
Received: from foss.arm.com ([217.140.110.172]:35982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230191AbhGHSLo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 8 Jul 2021 14:11:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 276BE1424;
        Thu,  8 Jul 2021 11:09:02 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3EB103F66F;
        Thu,  8 Jul 2021 11:09:01 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH 03/13] mailbox: pcc: Refactor all PCC channel information into a structure
Date:   Thu,  8 Jul 2021 19:08:41 +0100
Message-Id: <20210708180851.2311192-4-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210708180851.2311192-1-sudeep.holla@arm.com>
References: <20210708180851.2311192-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Currently all the PCC channel specific information are stored/maintained
in global individual arrays for each of those information. It is not
scalable and not clean if we have to stash more channel specific
information. Couple of reasons to stash more information are to extend
the support to Type 3/4 PCCT subspace and also to avoid accessing the
PCCT table entries themselves each time we need the information.

This patch moves all those PCC channel specific information into a
separate structure pcc_chan_info.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 106 +++++++++++++++++++++---------------------
 1 file changed, 53 insertions(+), 53 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 23391e224a68..c5f481a615b0 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -64,12 +64,20 @@
 
 static struct mbox_chan *pcc_mbox_channels;
 
-/* Array of cached virtual address for doorbell registers */
-static void __iomem **pcc_doorbell_vaddr;
-/* Array of cached virtual address for doorbell ack registers */
-static void __iomem **pcc_doorbell_ack_vaddr;
-/* Array of doorbell interrupts */
-static int *pcc_doorbell_irq;
+/**
+ * struct pcc_chan_info - PCC channel specific information
+ *
+ * @db_vaddr: cached virtual address for doorbell register
+ * @db_ack_vaddr: cached virtual address for doorbell ack register
+ * @db_irq: doorbell interrupt
+ */
+struct pcc_chan_info {
+	void __iomem *db_vaddr;
+	void __iomem *db_ack_vaddr;
+	int db_irq;
+};
+
+static struct pcc_chan_info *chan_info;
 
 static struct mbox_controller pcc_mbox_ctrl = {};
 /**
@@ -183,6 +191,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 {
 	struct acpi_generic_address *doorbell_ack;
 	struct acpi_pcct_hw_reduced *pcct_ss;
+	struct pcc_chan_info *pchan;
 	struct mbox_chan *chan = p;
 	u64 doorbell_ack_preserve;
 	u64 doorbell_ack_write;
@@ -197,17 +206,17 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 		struct acpi_pcct_hw_reduced_type2 *pcct2_ss = chan->con_priv;
 		u32 id = chan - pcc_mbox_channels;
 
+		pchan = chan_info + id;
 		doorbell_ack = &pcct2_ss->platform_ack_register;
 		doorbell_ack_preserve = pcct2_ss->ack_preserve_mask;
 		doorbell_ack_write = pcct2_ss->ack_write_mask;
 
-		ret = read_register(pcc_doorbell_ack_vaddr[id],
-				    &doorbell_ack_val,
-				    doorbell_ack->bit_width);
+		ret = read_register(pchan->db_ack_vaddr,
+				    &doorbell_ack_val, doorbell_ack->bit_width);
 		if (ret)
 			return IRQ_NONE;
 
-		ret = write_register(pcc_doorbell_ack_vaddr[id],
+		ret = write_register(pchan->db_ack_vaddr,
 				     (doorbell_ack_val & doorbell_ack_preserve)
 					| doorbell_ack_write,
 				     doorbell_ack->bit_width);
@@ -232,8 +241,9 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
  *		ERR_PTR.
  */
 struct mbox_chan *pcc_mbox_request_channel(struct mbox_client *cl,
-		int subspace_id)
+					   int subspace_id)
 {
+	struct pcc_chan_info *pchan = chan_info + subspace_id;
 	struct device *dev = pcc_mbox_ctrl.dev;
 	struct mbox_chan *chan;
 	unsigned long flags;
@@ -264,14 +274,14 @@ struct mbox_chan *pcc_mbox_request_channel(struct mbox_client *cl,
 
 	spin_unlock_irqrestore(&chan->lock, flags);
 
-	if (pcc_doorbell_irq[subspace_id] > 0) {
+	if (pchan->db_irq > 0) {
 		int rc;
 
-		rc = devm_request_irq(dev, pcc_doorbell_irq[subspace_id],
-				      pcc_mbox_irq, 0, MBOX_IRQ_NAME, chan);
+		rc = devm_request_irq(dev, pchan->db_irq, pcc_mbox_irq, 0,
+				      MBOX_IRQ_NAME, chan);
 		if (unlikely(rc)) {
 			dev_err(dev, "failed to register PCC interrupt %d\n",
-				pcc_doorbell_irq[subspace_id]);
+				pchan->db_irq);
 			pcc_mbox_free_channel(chan);
 			chan = ERR_PTR(rc);
 		}
@@ -290,6 +300,7 @@ EXPORT_SYMBOL_GPL(pcc_mbox_request_channel);
 void pcc_mbox_free_channel(struct mbox_chan *chan)
 {
 	u32 id = chan - pcc_mbox_channels;
+	struct pcc_chan_info *pchan;
 	unsigned long flags;
 
 	if (!chan || !chan->cl)
@@ -300,8 +311,9 @@ void pcc_mbox_free_channel(struct mbox_chan *chan)
 		return;
 	}
 
-	if (pcc_doorbell_irq[id] > 0)
-		devm_free_irq(chan->mbox->dev, pcc_doorbell_irq[id], chan);
+	pchan = chan_info + id;
+	if (pchan->db_irq > 0)
+		devm_free_irq(chan->mbox->dev, pchan->db_irq, chan);
 
 	spin_lock_irqsave(&chan->lock, flags);
 	chan->cl = NULL;
@@ -329,6 +341,7 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
 {
 	struct acpi_pcct_hw_reduced *pcct_ss = chan->con_priv;
 	struct acpi_generic_address *doorbell;
+	struct pcc_chan_info *pchan;
 	u64 doorbell_preserve;
 	u64 doorbell_val;
 	u64 doorbell_write;
@@ -340,19 +353,20 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
 		return -ENOENT;
 	}
 
+	pchan = chan_info + id;
 	doorbell = &pcct_ss->doorbell_register;
 	doorbell_preserve = pcct_ss->preserve_mask;
 	doorbell_write = pcct_ss->write_mask;
 
 	/* Sync notification from OS to Platform. */
-	if (pcc_doorbell_vaddr[id]) {
-		ret = read_register(pcc_doorbell_vaddr[id], &doorbell_val,
-			doorbell->bit_width);
+	if (pchan->db_vaddr) {
+		ret = read_register(pchan->db_vaddr, &doorbell_val,
+				    doorbell->bit_width);
 		if (ret)
 			return ret;
-		ret = write_register(pcc_doorbell_vaddr[id],
-			(doorbell_val & doorbell_preserve) | doorbell_write,
-			doorbell->bit_width);
+		ret = write_register(pchan->db_vaddr,
+				     (doorbell_val & doorbell_preserve)
+				      | doorbell_write, doorbell->bit_width);
 	} else {
 		ret = acpi_read(&doorbell_val, doorbell);
 		if (ret)
@@ -398,12 +412,13 @@ static int parse_pcc_subspace(union acpi_subtable_headers *header,
  *
  * This gets called for each entry in the PCC table.
  */
-static int pcc_parse_subspace_irq(int id,
-				  struct acpi_pcct_hw_reduced *pcct_ss)
+static int pcc_parse_subspace_irq(int id, struct acpi_pcct_hw_reduced *pcct_ss)
 {
-	pcc_doorbell_irq[id] = pcc_map_interrupt(pcct_ss->platform_interrupt,
-						 (u32)pcct_ss->flags);
-	if (pcc_doorbell_irq[id] <= 0) {
+	struct pcc_chan_info *pchan = chan_info + id;
+
+	pchan->db_irq = pcc_map_interrupt(pcct_ss->platform_interrupt,
+					  (u32)pcct_ss->flags);
+	if (pchan->db_irq <= 0) {
 		pr_err("PCC GSI %d not registered\n",
 		       pcct_ss->platform_interrupt);
 		return -EINVAL;
@@ -413,10 +428,10 @@ static int pcc_parse_subspace_irq(int id,
 		== ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2) {
 		struct acpi_pcct_hw_reduced_type2 *pcct2_ss = (void *)pcct_ss;
 
-		pcc_doorbell_ack_vaddr[id] = acpi_os_ioremap(
-				pcct2_ss->platform_ack_register.address,
-				pcct2_ss->platform_ack_register.bit_width / 8);
-		if (!pcc_doorbell_ack_vaddr[id]) {
+		pchan->db_ack_vaddr =
+			acpi_os_ioremap(pcct2_ss->platform_ack_register.address,
+					pcct2_ss->platform_ack_register.bit_width / 8);
+		if (!pchan->db_ack_vaddr) {
 			pr_err("Failed to ioremap PCC ACK register\n");
 			return -ENOMEM;
 		}
@@ -474,24 +489,12 @@ static int __init acpi_pcc_probe(void)
 		goto err_put_pcct;
 	}
 
-	pcc_doorbell_vaddr = kcalloc(count, sizeof(void *), GFP_KERNEL);
-	if (!pcc_doorbell_vaddr) {
+	chan_info = kcalloc(count, sizeof(*chan_info), GFP_KERNEL);
+	if (!chan_info) {
 		rc = -ENOMEM;
 		goto err_free_mbox;
 	}
 
-	pcc_doorbell_ack_vaddr = kcalloc(count, sizeof(void *), GFP_KERNEL);
-	if (!pcc_doorbell_ack_vaddr) {
-		rc = -ENOMEM;
-		goto err_free_db_vaddr;
-	}
-
-	pcc_doorbell_irq = kcalloc(count, sizeof(int), GFP_KERNEL);
-	if (!pcc_doorbell_irq) {
-		rc = -ENOMEM;
-		goto err_free_db_ack_vaddr;
-	}
-
 	/* Point to the first PCC subspace entry */
 	pcct_entry = (struct acpi_subtable_header *) (
 		(unsigned long) pcct_tbl + sizeof(struct acpi_table_pcct));
@@ -501,6 +504,7 @@ static int __init acpi_pcc_probe(void)
 		pcc_mbox_ctrl.txdone_irq = true;
 
 	for (i = 0; i < count; i++) {
+		struct pcc_chan_info *pchan = chan_info + i;
 		struct acpi_generic_address *db_reg;
 		struct acpi_pcct_subspace *pcct_ss;
 		pcc_mbox_channels[i].con_priv = pcct_entry;
@@ -522,8 +526,8 @@ static int __init acpi_pcc_probe(void)
 		/* If doorbell is in system memory cache the virt address */
 		db_reg = &pcct_ss->doorbell_register;
 		if (db_reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
-			pcc_doorbell_vaddr[i] = acpi_os_ioremap(db_reg->address,
-							db_reg->bit_width/8);
+			pchan->db_vaddr = acpi_os_ioremap(db_reg->address,
+							  db_reg->bit_width / 8);
 		pcct_entry = (struct acpi_subtable_header *)
 			((unsigned long) pcct_entry + pcct_entry->length);
 	}
@@ -535,11 +539,7 @@ static int __init acpi_pcc_probe(void)
 	return 0;
 
 err:
-	kfree(pcc_doorbell_irq);
-err_free_db_ack_vaddr:
-	kfree(pcc_doorbell_ack_vaddr);
-err_free_db_vaddr:
-	kfree(pcc_doorbell_vaddr);
+	kfree(chan_info);
 err_free_mbox:
 	kfree(pcc_mbox_channels);
 err_put_pcct:
-- 
2.25.1

