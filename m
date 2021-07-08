Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D843C18F5
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jul 2021 20:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhGHSLx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Jul 2021 14:11:53 -0400
Received: from foss.arm.com ([217.140.110.172]:36026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230191AbhGHSLu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 8 Jul 2021 14:11:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DB03D6E;
        Thu,  8 Jul 2021 11:09:08 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 66E6B3F66F;
        Thu,  8 Jul 2021 11:09:07 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH 08/13] mailbox: pcc: Rename doorbell ack to platform interrupt ack register
Date:   Thu,  8 Jul 2021 19:08:46 +0100
Message-Id: <20210708180851.2311192-9-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210708180851.2311192-1-sudeep.holla@arm.com>
References: <20210708180851.2311192-1-sudeep.holla@arm.com>
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
 drivers/mailbox/pcc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 49971e007e40..c4eecccac4b8 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -69,13 +69,14 @@ static struct mbox_chan *pcc_mbox_channels;
  *
  * @chan: PCC channel information with Shared Memory Region info
  * @db_vaddr: cached virtual address for doorbell register
- * @db_ack_vaddr: cached virtual address for doorbell ack register
+ * @plat_irq_ack_vaddr: cached virtual address for platform interrupt
+ *	acknowledge register
  * @db_irq: doorbell interrupt
  */
 struct pcc_chan_info {
 	struct pcc_mbox_chan chan;
 	void __iomem *db_vaddr;
-	void __iomem *db_ack_vaddr;
+	void __iomem *plat_irq_ack_vaddr;
 	int db_irq;
 };
 
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
@@ -406,10 +407,10 @@ static int pcc_parse_subspace_irq(struct pcc_chan_info *pchan,
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

