Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54EF40F94E
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Sep 2021 15:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245638AbhIQNgA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 17 Sep 2021 09:36:00 -0400
Received: from foss.arm.com ([217.140.110.172]:53344 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245265AbhIQNfn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Sep 2021 09:35:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B19F611D4;
        Fri, 17 Sep 2021 06:34:21 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CCDA83F719;
        Fri, 17 Sep 2021 06:34:20 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH v2 13/14] mailbox: pcc: Move bulk of PCCT parsing into pcc_mbox_probe
Date:   Fri, 17 Sep 2021 14:33:56 +0100
Message-Id: <20210917133357.1911092-14-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210917133357.1911092-1-sudeep.holla@arm.com>
References: <20210917133357.1911092-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Move the PCCT subspace parsing and allocation into pcc_mbox_probe so
that we can get rid of global PCC channel and mailbox controller data.
It also helps to make use of devm_* APIs for all the allocations.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 124 ++++++++++++++++++++++--------------------
 1 file changed, 66 insertions(+), 58 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index eb90c9eaaf9c..887a3704c12e 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -63,8 +63,6 @@
 
 #define MBOX_IRQ_NAME		"pcc-mbox"
 
-static struct mbox_chan *pcc_mbox_channels;
-
 /**
  * struct pcc_chan_reg - PCC register bundle
  *
@@ -106,7 +104,7 @@ struct pcc_chan_info {
 
 #define to_pcc_chan_info(c) container_of(c, struct pcc_chan_info, chan)
 static struct pcc_chan_info *chan_info;
-static struct mbox_controller pcc_mbox_ctrl = {};
+static int pcc_chan_count;
 
 /*
  * PCC can be used with perf critical drivers such as CPPC
@@ -281,11 +279,11 @@ struct pcc_mbox_chan *
 pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 {
 	struct pcc_chan_info *pchan;
-	struct device *dev = pcc_mbox_ctrl.dev;
 	struct mbox_chan *chan;
+	struct device *dev;
 	unsigned long flags;
 
-	if (subspace_id < 0 || subspace_id >= pcc_mbox_ctrl.num_chans)
+	if (subspace_id < 0 || subspace_id >= pcc_chan_count)
 		return ERR_PTR(-ENOENT);
 
 	pchan = chan_info + subspace_id;
@@ -294,6 +292,7 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 		dev_err(dev, "Channel not found for idx: %d\n", subspace_id);
 		return ERR_PTR(-EBUSY);
 	}
+	dev = chan->mbox->dev;
 
 	spin_lock_irqsave(&chan->lock, flags);
 	chan->msg_free = 0;
@@ -576,16 +575,12 @@ static void pcc_parse_subspace_shmem(struct pcc_chan_info *pchan,
  */
 static int __init acpi_pcc_probe(void)
 {
+	int count, i, rc = 0;
+	acpi_status status;
 	struct acpi_table_header *pcct_tbl;
-	struct acpi_subtable_header *pcct_entry;
-	struct acpi_table_pcct *acpi_pcct_tbl;
 	struct acpi_subtable_proc proc[ACPI_PCCT_TYPE_RESERVED];
-	int count, i, rc;
-	acpi_status status = AE_OK;
 
-	/* Search for PCCT */
 	status = acpi_get_table(ACPI_SIG_PCCT, 0, &pcct_tbl);
-
 	if (ACPI_FAILURE(status) || !pcct_tbl)
 		return -ENODEV;
 
@@ -607,21 +602,60 @@ static int __init acpi_pcc_probe(void)
 			pr_warn("Invalid PCCT: %d PCC subspaces\n", count);
 
 		rc = -EINVAL;
-		goto err_put_pcct;
+	} else {
+		pcc_chan_count = count;
 	}
 
-	pcc_mbox_channels = kcalloc(count, sizeof(struct mbox_chan),
-				    GFP_KERNEL);
+	acpi_put_table(pcct_tbl);
+
+	return rc;
+}
+
+/**
+ * pcc_mbox_probe - Called when we find a match for the
+ *	PCCT platform device. This is purely used to represent
+ *	the PCCT as a virtual device for registering with the
+ *	generic Mailbox framework.
+ *
+ * @pdev: Pointer to platform device returned when a match
+ *	is found.
+ *
+ *	Return: 0 for Success, else errno.
+ */
+static int pcc_mbox_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mbox_controller *pcc_mbox_ctrl;
+	struct mbox_chan *pcc_mbox_channels;
+	struct acpi_table_header *pcct_tbl;
+	struct acpi_subtable_header *pcct_entry;
+	struct acpi_table_pcct *acpi_pcct_tbl;
+	acpi_status status = AE_OK;
+	int i, rc, count = pcc_chan_count;
+
+	/* Search for PCCT */
+	status = acpi_get_table(ACPI_SIG_PCCT, 0, &pcct_tbl);
+
+	if (ACPI_FAILURE(status) || !pcct_tbl)
+		return -ENODEV;
+
+	pcc_mbox_channels = devm_kcalloc(dev, count, sizeof(*pcc_mbox_channels),
+					 GFP_KERNEL);
 	if (!pcc_mbox_channels) {
-		pr_err("Could not allocate space for PCC mbox channels\n");
 		rc = -ENOMEM;
-		goto err_put_pcct;
+		goto err;
 	}
 
-	chan_info = kcalloc(count, sizeof(*chan_info), GFP_KERNEL);
+	chan_info = devm_kcalloc(dev, count, sizeof(*chan_info), GFP_KERNEL);
 	if (!chan_info) {
 		rc = -ENOMEM;
-		goto err_free_mbox;
+		goto err;
+	}
+
+	pcc_mbox_ctrl = devm_kmalloc(dev, sizeof(*pcc_mbox_ctrl), GFP_KERNEL);
+	if (!pcc_mbox_ctrl) {
+		rc = -ENOMEM;
+		goto err;
 	}
 
 	/* Point to the first PCC subspace entry */
@@ -630,7 +664,7 @@ static int __init acpi_pcc_probe(void)
 
 	acpi_pcct_tbl = (struct acpi_table_pcct *) pcct_tbl;
 	if (acpi_pcct_tbl->flags & ACPI_PCCT_DOORBELL)
-		pcc_mbox_ctrl.txdone_irq = true;
+		pcc_mbox_ctrl->txdone_irq = true;
 
 	for (i = 0; i < count; i++) {
 		struct pcc_chan_info *pchan = chan_info + i;
@@ -639,13 +673,13 @@ static int __init acpi_pcc_probe(void)
 		pchan->chan.mchan = &pcc_mbox_channels[i];
 
 		if (pcct_entry->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE &&
-		    !pcc_mbox_ctrl.txdone_irq) {
+		    !pcc_mbox_ctrl->txdone_irq) {
 			pr_err("Plaform Interrupt flag must be set to 1");
 			rc = -EINVAL;
 			goto err;
 		}
 
-		if (pcc_mbox_ctrl.txdone_irq) {
+		if (pcc_mbox_ctrl->txdone_irq) {
 			rc = pcc_parse_subspace_irq(pchan, pcct_entry);
 			if (rc < 0)
 				goto err;
@@ -660,51 +694,25 @@ static int __init acpi_pcc_probe(void)
 			((unsigned long) pcct_entry + pcct_entry->length);
 	}
 
-	pcc_mbox_ctrl.num_chans = count;
+	pcc_mbox_ctrl->num_chans = count;
 
-	pr_info("Detected %d PCC Subspaces\n", pcc_mbox_ctrl.num_chans);
+	pr_info("Detected %d PCC Subspaces\n", pcc_mbox_ctrl->num_chans);
 
-	return 0;
+	pcc_mbox_ctrl->chans = pcc_mbox_channels;
+	pcc_mbox_ctrl->ops = &pcc_chan_ops;
+	pcc_mbox_ctrl->dev = dev;
 
+	pr_info("Registering PCC driver as Mailbox controller\n");
+	rc = mbox_controller_register(pcc_mbox_ctrl);
+	if (rc)
+		pr_err("Err registering PCC as Mailbox controller: %d\n", rc);
+	else
+		return 0;
 err:
-	kfree(chan_info);
-err_free_mbox:
-	kfree(pcc_mbox_channels);
-err_put_pcct:
 	acpi_put_table(pcct_tbl);
 	return rc;
 }
 
-/**
- * pcc_mbox_probe - Called when we find a match for the
- *	PCCT platform device. This is purely used to represent
- *	the PCCT as a virtual device for registering with the
- *	generic Mailbox framework.
- *
- * @pdev: Pointer to platform device returned when a match
- *	is found.
- *
- *	Return: 0 for Success, else errno.
- */
-static int pcc_mbox_probe(struct platform_device *pdev)
-{
-	int ret = 0;
-
-	pcc_mbox_ctrl.chans = pcc_mbox_channels;
-	pcc_mbox_ctrl.ops = &pcc_chan_ops;
-	pcc_mbox_ctrl.dev = &pdev->dev;
-
-	pr_info("Registering PCC driver as Mailbox controller\n");
-	ret = mbox_controller_register(&pcc_mbox_ctrl);
-
-	if (ret) {
-		pr_err("Err registering PCC as Mailbox controller: %d\n", ret);
-		ret = -ENODEV;
-	}
-
-	return ret;
-}
-
 static struct platform_driver pcc_mbox_driver = {
 	.probe = pcc_mbox_probe,
 	.driver = {
-- 
2.25.1

