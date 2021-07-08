Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B938B3C18FB
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jul 2021 20:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhGHSL4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Jul 2021 14:11:56 -0400
Received: from foss.arm.com ([217.140.110.172]:36034 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230273AbhGHSLz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 8 Jul 2021 14:11:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFD631424;
        Thu,  8 Jul 2021 11:09:12 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C9D623F66F;
        Thu,  8 Jul 2021 11:09:11 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH 12/13] mailbox: pcc: Add support for PCCT extended PCC subspaces(type 3/4)
Date:   Thu,  8 Jul 2021 19:08:50 +0100
Message-Id: <20210708180851.2311192-13-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210708180851.2311192-1-sudeep.holla@arm.com>
References: <20210708180851.2311192-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

With all the plumbing in place to avoid accessing PCCT type and other
fields directly from the PCCT table all the time, let us now add the
support for extended PCC subspaces(type 3 and 4).

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 119 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 102 insertions(+), 17 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 99ad3429f174..22d1c7691887 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -89,12 +89,18 @@ struct pcc_chan_reg {
  * @db: PCC register bundle for the doorbell register
  * @plat_irq_ack: PCC register bundle for the platform interrupt acknowledge
  *	register
+ * @cmd_complete: PCC register bundle for the command complete check register
+ * @cmd_update: PCC register bundle for the command complete update register
+ * @error: PCC register bundle for the error status register
  * @db_irq: doorbell interrupt
  */
 struct pcc_chan_info {
 	struct pcc_mbox_chan chan;
 	struct pcc_chan_reg db;
 	struct pcc_chan_reg plat_irq_ack;
+	struct pcc_chan_reg cmd_complete;
+	struct pcc_chan_reg cmd_update;
+	struct pcc_chan_reg error;
 	int db_irq;
 };
 
@@ -228,9 +234,29 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 {
 	struct pcc_chan_info *pchan;
 	struct mbox_chan *chan = p;
+	u64 val;
+	int ret;
 
 	pchan = chan->con_priv;
 
+	ret = pcc_chan_reg_read(&pchan->cmd_complete, &val);
+	if (ret)
+		return IRQ_NONE;
+
+	val &= pchan->cmd_complete.status_mask;
+	if (!val)
+		return IRQ_NONE;
+
+	ret = pcc_chan_reg_read(&pchan->error, &val);
+	if (ret)
+		return IRQ_NONE;
+	val &= pchan->error.status_mask;
+	if (val) {
+		val &= ~pchan->error.status_mask;
+		pcc_chan_reg_write(&pchan->error, val);
+		return IRQ_NONE;
+	}
+
 	mbox_chan_received_data(chan, NULL);
 
 	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack))
@@ -335,8 +361,13 @@ EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
  */
 static int pcc_send_data(struct mbox_chan *chan, void *data)
 {
+	int ret;
 	struct pcc_chan_info *pchan = chan->con_priv;
 
+	ret = pcc_chan_reg_read_modify_write(&pchan->cmd_update);
+	if (ret)
+		return ret;
+
 	return pcc_chan_reg_read_modify_write(&pchan->db);
 }
 
@@ -429,6 +460,16 @@ static int pcc_parse_subspace_irq(struct pcc_chan_info *pchan,
 					pcct2_ss->ack_preserve_mask,
 					pcct2_ss->ack_write_mask, 0,
 					"PLAT IRQ ACK");
+
+	} else if (pcct_ss->header.type == ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE ||
+		   pcct_ss->header.type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE) {
+		struct acpi_pcct_ext_pcc_master *pcct_ext = (void *)pcct_ss;
+
+		ret = pcc_chan_reg_init(&pchan->plat_irq_ack,
+					&pcct_ext->platform_ack_register,
+					pcct_ext->ack_preserve_mask,
+					pcct_ext->ack_set_mask, 0,
+					"PLAT IRQ ACK");
 	}
 
 	return ret;
@@ -446,14 +487,48 @@ static int pcc_parse_subspace_db_reg(struct pcc_chan_info *pchan,
 {
 	int ret = 0;
 
-	struct acpi_pcct_subspace *pcct_ss;
-
-	pcct_ss = (struct acpi_pcct_subspace *)pcct_entry;
-
-	ret = pcc_chan_reg_init(&pchan->db,
-				&pcct_ss->doorbell_register,
-				pcct_ss->preserve_mask,
-				pcct_ss->write_mask, 0,	"Doorbell");
+	if (pcct_entry->type <= ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2) {
+		struct acpi_pcct_subspace *pcct_ss;
+
+		pcct_ss = (struct acpi_pcct_subspace *)pcct_entry;
+
+		ret = pcc_chan_reg_init(&pchan->db,
+					&pcct_ss->doorbell_register,
+					pcct_ss->preserve_mask,
+					pcct_ss->write_mask, 0,	"Doorbell");
+
+	} else {
+		struct acpi_pcct_ext_pcc_master *pcct_ext;
+
+		pcct_ext = (struct acpi_pcct_ext_pcc_master *)pcct_entry;
+
+		ret = pcc_chan_reg_init(&pchan->db,
+					&pcct_ext->doorbell_register,
+					pcct_ext->preserve_mask,
+					pcct_ext->write_mask, 0, "Doorbell");
+		if (ret)
+			return ret;
+
+		ret = pcc_chan_reg_init(&pchan->cmd_complete,
+					&pcct_ext->cmd_complete_register,
+					0, 0, pcct_ext->cmd_complete_mask,
+					"Command Complete Check");
+		if (ret)
+			return ret;
+
+		ret = pcc_chan_reg_init(&pchan->cmd_update,
+					&pcct_ext->cmd_update_register,
+					pcct_ext->cmd_update_preserve_mask,
+					pcct_ext->cmd_update_set_mask, 0,
+					"Command Complete Update");
+		if (ret)
+			return ret;
+
+		ret = pcc_chan_reg_init(&pchan->error,
+					&pcct_ext->error_status_register,
+					0, 0, pcct_ext->error_status_mask,
+					"Error Status");
+	}
 	return ret;
 }
 
@@ -467,15 +542,25 @@ static int pcc_parse_subspace_db_reg(struct pcc_chan_info *pchan,
 static void pcc_parse_subspace_shmem(struct pcc_chan_info *pchan,
 				     struct acpi_subtable_header *pcct_entry)
 {
-	struct acpi_pcct_subspace *pcct_ss;
-
-	pcct_ss = (struct acpi_pcct_subspace *)pcct_entry;
-
-	pchan->chan.shmem_base_addr = pcct_ss->base_address;
-	pchan->chan.shmem_size = pcct_ss->length;
-	pchan->chan.latency = pcct_ss->latency;
-	pchan->chan.max_access_rate = pcct_ss->max_access_rate;
-	pchan->chan.min_turnaround_time = pcct_ss->min_turnaround_time;
+	if (pcct_entry->type <= ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2) {
+		struct acpi_pcct_subspace *pcct_ss =
+			(struct acpi_pcct_subspace *)pcct_entry;
+
+		pchan->chan.shmem_base_addr = pcct_ss->base_address;
+		pchan->chan.shmem_size = pcct_ss->length;
+		pchan->chan.latency = pcct_ss->latency;
+		pchan->chan.max_access_rate = pcct_ss->max_access_rate;
+		pchan->chan.min_turnaround_time = pcct_ss->min_turnaround_time;
+	} else {
+		struct acpi_pcct_ext_pcc_master *pcct_ext =
+			(struct acpi_pcct_ext_pcc_master *)pcct_entry;
+
+		pchan->chan.shmem_base_addr = pcct_ext->base_address;
+		pchan->chan.shmem_size = pcct_ext->length;
+		pchan->chan.latency = pcct_ext->latency;
+		pchan->chan.max_access_rate = pcct_ext->max_access_rate;
+		pchan->chan.min_turnaround_time = pcct_ext->min_turnaround_time;
+	}
 }
 
 /**
-- 
2.25.1

