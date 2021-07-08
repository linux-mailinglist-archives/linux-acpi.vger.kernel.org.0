Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DCA3C18F7
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jul 2021 20:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhGHSLy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Jul 2021 14:11:54 -0400
Received: from foss.arm.com ([217.140.110.172]:36040 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230334AbhGHSLw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 8 Jul 2021 14:11:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FA5A1477;
        Thu,  8 Jul 2021 11:09:10 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 98FC33F66F;
        Thu,  8 Jul 2021 11:09:09 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH 10/13] mailbox: pcc: Avoid accessing PCCT table in pcc_send_data and pcc_mbox_irq
Date:   Thu,  8 Jul 2021 19:08:48 +0100
Message-Id: <20210708180851.2311192-11-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210708180851.2311192-1-sudeep.holla@arm.com>
References: <20210708180851.2311192-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Now that the con_priv is availvale solely for PCC mailbox controller
driver, let us use the same to save the channel specific information
in it so that we can it whenever required instead of parsing the PCCT
table entries every time in both pcc_send_data and pcc_mbox_irq.

We can now use the newly introduces PCC register bundle to simplify both
saving of channel specific information and accessing them without repeated
checks for the subspace type.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 116 +++++++++++-------------------------------
 1 file changed, 30 insertions(+), 86 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 7d48e5c1ac52..237dba9cb445 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -86,15 +86,15 @@ struct pcc_chan_reg {
  * struct pcc_chan_info - PCC channel specific information
  *
  * @chan: PCC channel information with Shared Memory Region info
- * @db_vaddr: cached virtual address for doorbell register
- * @plat_irq_ack_vaddr: cached virtual address for platform interrupt
- *	acknowledge register
+ * @db: PCC register bundle for the doorbell register
+ * @plat_irq_ack: PCC register bundle for the platform interrupt acknowledge
+ *	register
  * @db_irq: doorbell interrupt
  */
 struct pcc_chan_info {
 	struct pcc_mbox_chan chan;
-	void __iomem *db_vaddr;
-	void __iomem *plat_irq_ack_vaddr;
+	struct pcc_chan_reg db;
+	struct pcc_chan_reg plat_irq_ack;
 	int db_irq;
 };
 
@@ -242,40 +242,15 @@ static int pcc_map_interrupt(u32 interrupt, u32 flags)
  */
 static irqreturn_t pcc_mbox_irq(int irq, void *p)
 {
-	struct acpi_generic_address *doorbell_ack;
-	struct acpi_pcct_hw_reduced *pcct_ss;
 	struct pcc_chan_info *pchan;
 	struct mbox_chan *chan = p;
-	u64 doorbell_ack_preserve;
-	u64 doorbell_ack_write;
-	u64 doorbell_ack_val;
-	int ret;
 
-	pcct_ss = chan->con_priv;
+	pchan = chan->con_priv;
 
 	mbox_chan_received_data(chan, NULL);
 
-	if (pcct_ss->header.type == ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2) {
-		struct acpi_pcct_hw_reduced_type2 *pcct2_ss = chan->con_priv;
-		u32 id = chan - pcc_mbox_channels;
-
-		pchan = chan_info + id;
-		doorbell_ack = &pcct2_ss->platform_ack_register;
-		doorbell_ack_preserve = pcct2_ss->ack_preserve_mask;
-		doorbell_ack_write = pcct2_ss->ack_write_mask;
-
-		ret = read_register(pchan->plat_irq_ack_vaddr,
-				    &doorbell_ack_val, doorbell_ack->bit_width);
-		if (ret)
-			return IRQ_NONE;
-
-		ret = write_register(pchan->plat_irq_ack_vaddr,
-				     (doorbell_ack_val & doorbell_ack_preserve)
-					| doorbell_ack_write,
-				     doorbell_ack->bit_width);
-		if (ret)
-			return IRQ_NONE;
-	}
+	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack))
+		return IRQ_NONE;
 
 	return IRQ_HANDLED;
 }
@@ -376,42 +351,9 @@ EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
  */
 static int pcc_send_data(struct mbox_chan *chan, void *data)
 {
-	struct acpi_pcct_hw_reduced *pcct_ss = chan->con_priv;
-	struct acpi_generic_address *doorbell;
-	struct pcc_chan_info *pchan;
-	u64 doorbell_preserve;
-	u64 doorbell_val;
-	u64 doorbell_write;
-	u32 id = chan - pcc_mbox_channels;
-	int ret = 0;
-
-	if (id >= pcc_mbox_ctrl.num_chans) {
-		pr_debug("pcc_send_data: Invalid mbox_chan passed\n");
-		return -ENOENT;
-	}
+	struct pcc_chan_info *pchan = chan->con_priv;
 
-	pchan = chan_info + id;
-	doorbell = &pcct_ss->doorbell_register;
-	doorbell_preserve = pcct_ss->preserve_mask;
-	doorbell_write = pcct_ss->write_mask;
-
-	/* Sync notification from OS to Platform. */
-	if (pchan->db_vaddr) {
-		ret = read_register(pchan->db_vaddr, &doorbell_val,
-				    doorbell->bit_width);
-		if (ret)
-			return ret;
-		ret = write_register(pchan->db_vaddr,
-				     (doorbell_val & doorbell_preserve)
-				      | doorbell_write, doorbell->bit_width);
-	} else {
-		ret = acpi_read(&doorbell_val, doorbell);
-		if (ret)
-			return ret;
-		ret = acpi_write((doorbell_val & doorbell_preserve) | doorbell_write,
-			doorbell);
-	}
-	return ret;
+	return pcc_chan_reg_read_modify_write(&pchan->db);
 }
 
 static const struct mbox_chan_ops pcc_chan_ops = {
@@ -479,6 +421,7 @@ pcc_chan_reg_init(struct pcc_chan_reg *reg, struct acpi_generic_address *gas,
 static int pcc_parse_subspace_irq(struct pcc_chan_info *pchan,
 				  struct acpi_subtable_header *pcct_entry)
 {
+	int ret = 0;
 	struct acpi_pcct_hw_reduced *pcct_ss;
 
 	if (pcct_entry->type < ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE ||
@@ -497,16 +440,14 @@ static int pcc_parse_subspace_irq(struct pcc_chan_info *pchan,
 	if (pcct_ss->header.type == ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2) {
 		struct acpi_pcct_hw_reduced_type2 *pcct2_ss = (void *)pcct_ss;
 
-		pchan->plat_irq_ack_vaddr =
-			acpi_os_ioremap(pcct2_ss->platform_ack_register.address,
-					pcct2_ss->platform_ack_register.bit_width / 8);
-		if (!pchan->plat_irq_ack_vaddr) {
-			pr_err("Failed to ioremap PCC ACK register\n");
-			return -ENOMEM;
-		}
+		ret = pcc_chan_reg_init(&pchan->plat_irq_ack,
+					&pcct2_ss->platform_ack_register,
+					pcct2_ss->ack_preserve_mask,
+					pcct2_ss->ack_write_mask, 0,
+					"PLAT IRQ ACK");
 	}
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -516,19 +457,20 @@ static int pcc_parse_subspace_irq(struct pcc_chan_info *pchan,
  * @pcct_entry: Pointer to the ACPI subtable header.
  *
  */
-static void pcc_parse_subspace_db_reg(struct pcc_chan_info *pchan,
-				      struct acpi_subtable_header *pcct_entry)
+static int pcc_parse_subspace_db_reg(struct pcc_chan_info *pchan,
+				     struct acpi_subtable_header *pcct_entry)
 {
+	int ret = 0;
+
 	struct acpi_pcct_subspace *pcct_ss;
-	struct acpi_generic_address *db_reg;
 
 	pcct_ss = (struct acpi_pcct_subspace *)pcct_entry;
 
-	/* If doorbell is in system memory cache the virt address */
-	db_reg = &pcct_ss->doorbell_register;
-	if (db_reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
-		pchan->db_vaddr = acpi_os_ioremap(db_reg->address,
-						  db_reg->bit_width / 8);
+	ret = pcc_chan_reg_init(&pchan->db,
+				&pcct_ss->doorbell_register,
+				pcct_ss->preserve_mask,
+				pcct_ss->write_mask, 0,	"Doorbell");
+	return ret;
 }
 
 /**
@@ -617,8 +559,8 @@ static int __init acpi_pcc_probe(void)
 
 	for (i = 0; i < count; i++) {
 		struct pcc_chan_info *pchan = chan_info + i;
-		pcc_mbox_channels[i].con_priv = pcct_entry;
 
+		pcc_mbox_channels[i].con_priv = pchan;
 		pchan->chan.mchan = &pcc_mbox_channels[i];
 
 		if (pcc_mbox_ctrl.txdone_irq) {
@@ -626,7 +568,9 @@ static int __init acpi_pcc_probe(void)
 			if (rc < 0)
 				goto err;
 		}
-		pcc_parse_subspace_db_reg(pchan, pcct_entry);
+		rc = pcc_parse_subspace_db_reg(pchan, pcct_entry);
+		if (rc < 0)
+			goto err;
 
 		pcc_parse_subspace_shmem(pchan, pcct_entry);
 
-- 
2.25.1

