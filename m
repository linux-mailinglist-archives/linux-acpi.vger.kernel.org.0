Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6DC740F93D
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Sep 2021 15:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245057AbhIQNfg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 17 Sep 2021 09:35:36 -0400
Received: from foss.arm.com ([217.140.110.172]:53282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240676AbhIQNfd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Sep 2021 09:35:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BDD811B3;
        Fri, 17 Sep 2021 06:34:11 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 474D53F719;
        Fri, 17 Sep 2021 06:34:10 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH v2 04/14] mailbox: pcc: Consolidate subspace interrupt information parsing
Date:   Fri, 17 Sep 2021 14:33:47 +0100
Message-Id: <20210917133357.1911092-5-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210917133357.1911092-1-sudeep.holla@arm.com>
References: <20210917133357.1911092-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Extended PCC subspaces(Type 3 and 4) differ from generic(Type 0) and
HW-Reduced Communication(Type 1 and 2) subspace structures. However some
fields share same offsets and same type of structure can be use to extract
the fields. In order to simplify that, let us move all the IRQ related
information parsing into pcc_parse_subspace_irq and consolidate there.
It will be easier to extend it if required within the same.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 588d2207edf9..efde77d7038c 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -405,18 +405,26 @@ static int parse_pcc_subspace(union acpi_subtable_headers *header,
 
 /**
  * pcc_parse_subspace_irq - Parse the PCC IRQ and PCC ACK register
- *		There should be one entry per PCC client.
- * @id: PCC subspace index.
- * @pcct_ss: Pointer to the ACPI subtable header under the PCCT.
+ *
+ * @pchan: Pointer to the PCC channel info structure.
+ * @pcct_entry: Pointer to the ACPI subtable header.
  *
  * Return: 0 for Success, else errno.
  *
- * This gets called for each entry in the PCC table.
+ * There should be one entry per PCC channel. This gets called for each
+ * entry in the PCC table. This uses PCCY Type1 structure for all applicable
+ * types(Type 1-4) to fetch irq
  */
-static int pcc_parse_subspace_irq(int id, struct acpi_pcct_hw_reduced *pcct_ss)
+static int pcc_parse_subspace_irq(struct pcc_chan_info *pchan,
+				  struct acpi_subtable_header *pcct_entry)
 {
-	struct pcc_chan_info *pchan = chan_info + id;
+	struct acpi_pcct_hw_reduced *pcct_ss;
 
+	if (pcct_entry->type < ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE ||
+	    pcct_entry->type > ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
+		return 0;
+
+	pcct_ss = (struct acpi_pcct_hw_reduced *)pcct_entry;
 	pchan->db_irq = pcc_map_interrupt(pcct_ss->platform_interrupt,
 					  (u32)pcct_ss->flags);
 	if (pchan->db_irq <= 0) {
@@ -425,8 +433,7 @@ static int pcc_parse_subspace_irq(int id, struct acpi_pcct_hw_reduced *pcct_ss)
 		return -EINVAL;
 	}
 
-	if (pcct_ss->header.type
-		== ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2) {
+	if (pcct_ss->header.type == ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2) {
 		struct acpi_pcct_hw_reduced_type2 *pcct2_ss = (void *)pcct_ss;
 
 		pchan->db_ack_vaddr =
@@ -510,17 +517,10 @@ static int __init acpi_pcc_probe(void)
 		struct acpi_pcct_subspace *pcct_ss;
 		pcc_mbox_channels[i].con_priv = pcct_entry;
 
-		if (pcct_entry->type == ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE ||
-		    pcct_entry->type == ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2) {
-			struct acpi_pcct_hw_reduced *pcct_hrss;
-
-			pcct_hrss = (struct acpi_pcct_hw_reduced *) pcct_entry;
-
-			if (pcc_mbox_ctrl.txdone_irq) {
-				rc = pcc_parse_subspace_irq(i, pcct_hrss);
-				if (rc < 0)
-					goto err;
-			}
+		if (pcc_mbox_ctrl.txdone_irq) {
+			rc = pcc_parse_subspace_irq(pchan, pcct_entry);
+			if (rc < 0)
+				goto err;
 		}
 		pcct_ss = (struct acpi_pcct_subspace *) pcct_entry;
 
-- 
2.25.1

