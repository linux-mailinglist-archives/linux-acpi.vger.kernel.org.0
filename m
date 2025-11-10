Return-Path: <linux-acpi+bounces-18730-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95997C47876
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 16:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843AB188AE73
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 15:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD9723D2B2;
	Mon, 10 Nov 2025 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipearl.com header.i=@sipearl.com header.b="sLznb25g"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtpout.sipearl.com (smtpout.sipearl.com [178.170.11.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77F7242D8B;
	Mon, 10 Nov 2025 15:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.170.11.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762788311; cv=none; b=mVEMJ1otGYmN3QbYPlQKP6gr6/x6+LMWcPpAQaLKCSDmx88mYb32Z99+S/mG3lyrBpERpr8T5HmpXqCu1Mg0RiNq602ChzhqdKZjB+9YUPZ6HcQSz52o0kWM/PkIwXTh7QVQDFtx9fXi4riDEocqwkap4wmfqXvSwR2Rc8UzRjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762788311; c=relaxed/simple;
	bh=6aDfq1O4bhca5RLhLmmdUwU0lECAmu17Hzx+ZbV7QJw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NQLt0+W8+ImcfTekDz6y2/ejbGDWt3LBaxdVhSgoNGWBLWR52ICA78J/msuDhjVBKe3qQCFcIIrzSmonWZD+n9DzmyLudxX+BWk+jI9Eyfb1XdDU8ulcayJqDlHijBa45tQGHKsGHGyCRvnk5i2ahKvrZA1JIZPrkZdYiGr2f7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipearl.com; spf=pass smtp.mailfrom=sipearl.com; dkim=pass (2048-bit key) header.d=sipearl.com header.i=@sipearl.com header.b=sLznb25g; arc=none smtp.client-ip=178.170.11.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipearl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipearl.com
Received: from smtpout.sipearl.com ([172.31.29.1])
	by smtpin.sipearl.com  with ESMTPS id 5AAF9et3032096-5AAF9et5032096
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 16:09:40 +0100
Received: from dc2pvlnosz001.pub.int.sipearl.com (172.31.65.18) by
 dc2pvwexcz001.sipearl.corp (172.31.29.1) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Mon, 10 Nov 2025 16:09:40 +0100
From: Andrea Tomassetti <andrea.tomassetti@sipearl.com>
To: <sudeep.holla@arm.com>, <jassisinghbrar@gmail.com>, <rafael@kernel.org>
CC: Andrea Tomassetti <andrea.tomassetti@sipearl.com>, <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<olivierdautricourt@gmail.com>, Thibault Cantori
	<thibault.cantori@sipearl.com>, Olivier Dautricourt
	<olivier.dautricourt@sipearl.com>
Subject: [PATCH] mailbox: pcc: support polling mode when there is no platform IRQ
Date: Mon, 10 Nov 2025 16:08:21 +0100
Message-ID: <20251110150825.3548819-1-andrea.tomassetti@sipearl.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dc2pvwexcz001.sipearl.corp (172.31.29.1) To
 dc2pvwexcz001.sipearl.corp (172.31.29.1)
X-FEAS-Client-IP: 172.31.29.1
X-FE-Policy-ID: 2:2:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=sipearl.com; s=sipearl2024; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:mime-version:content-type;
 bh=C7vAsdXnHh8Asw9/J2zJB9CUMoD7+9IQATCBZPO7A/Y=;
 b=sLznb25gh5CK3kMHxtpaXcml6fci1C+cbmGtraD46M/buQl/5fYBxPM2KfGuCyW4xiZIuJLkm9U4
	nUMefaYgOAJH2LvjgySd7I93ryQMz9T7ehNsL0Klif8Alle7BRr+g09pLflGe6dHuYa6BcltZ51V
	udRTF7GA9mdzwqzMo74P7FRBcmGj+OfLKgSFlnj8ASq3QIPEnDz3dvbCu+Z9VSuRNt5pW+76X2Qq
	0IFFxxUqO4A54qKjpxcdVxTvfYzLgV7fmsUpEOx4//Eb9SUarJ4jCW0grbN/GR8Pw/h4Pz79uFf5
	5Ll0l5C25fAgwzMt1r2hK5YJtjW4NofK4Go4iQ==

The goal is to allow clients to submit a message in both irq and polling
mode of the pcc mailbox. The ACPI specification does not require a
platform irq for pcc channels. Let's implement the case where it is not
available.

peek_data is mapped to pcc_mbox_error_check_and_clear, so that it
returns true if no error occurred while the platform processed last
message, and therefore clients can fetch response data provided by the
platform.

Tested-by: Thibault Cantori <thibault.cantori@sipearl.com>
Co-developed-by: Olivier Dautricourt <olivier.dautricourt@sipearl.com>
Signed-off-by: Olivier Dautricourt <olivier.dautricourt@sipearl.com>
Signed-off-by: Andrea Tomassetti <andrea.tomassetti@sipearl.com>
---
 drivers/acpi/acpi_pcc.c | 77 ++++++++++++++++++++++++++++-------------
 drivers/mailbox/pcc.c   | 12 ++++++-
 2 files changed, 63 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
index 97064e943768..ef5d7eae150b 100644
--- a/drivers/acpi/acpi_pcc.c
+++ b/drivers/acpi/acpi_pcc.c
@@ -51,7 +51,6 @@ acpi_pcc_address_space_setup(acpi_handle region_handle, u32 function,
 {
 	struct pcc_data *data;
 	struct acpi_pcc_info *ctx = handler_context;
-	struct pcc_mbox_chan *pcc_chan;
 	static acpi_status ret;

 	data = kzalloc(sizeof(*data), GFP_KERNEL);
@@ -59,7 +58,7 @@ acpi_pcc_address_space_setup(acpi_handle region_handle, u32 function,
 		return AE_NO_MEMORY;

 	data->cl.rx_callback = pcc_rx_callback;
-	data->cl.knows_txdone = true;
+	data->cl.knows_txdone = false;
 	data->ctx.length = ctx->length;
 	data->ctx.subspace_id = ctx->subspace_id;
 	data->ctx.internal_buffer = ctx->internal_buffer;
@@ -73,61 +72,89 @@ acpi_pcc_address_space_setup(acpi_handle region_handle, u32 function,
 		goto err_free_data;
 	}

-	pcc_chan = data->pcc_chan;
-	if (!pcc_chan->mchan->mbox->txdone_irq) {
-		pr_err("This channel-%d does not support interrupt.\n",
-		       ctx->subspace_id);
-		ret = AE_SUPPORT;
-		goto err_free_channel;
-	}
-
 	*region_context = data;
 	return AE_OK;

-err_free_channel:
-	pcc_mbox_free_channel(data->pcc_chan);
 err_free_data:
 	kfree(data);

 	return ret;
 }

+static acpi_status
+acpi_pcc_send_msg_polling(struct pcc_data *data)
+{
+	int ret;
+
+	ret = mbox_send_message(data->pcc_chan->mchan, data->pcc_chan->shmem);
+	if (ret == -ETIME) {
+		pr_err("PCC command executed timeout!\n");
+		return AE_TIME;
+	}
+
+	if (ret < 0)
+		return AE_ERROR;
+
+	if (!mbox_client_peek_data(data->pcc_chan->mchan))
+		return AE_ERROR;
+
+	return AE_OK;
+}
+
+static acpi_status
+acpi_pcc_send_msg_irq(struct pcc_data *data)
+{
+	int ret;
+
+	ret = mbox_send_message(data->pcc_chan->mchan, NULL);
+	if (ret < 0)
+		return AE_ERROR;
+
+	ret = wait_for_completion_timeout(&data->done,
+					  usecs_to_jiffies(data->cl.tx_tout * USEC_PER_MSEC));
+	if (ret == 0) {
+		pr_err("PCC command executed timeout!\n");
+		return AE_TIME;
+	}
+
+	mbox_chan_txdone(data->pcc_chan->mchan, ret);
+
+	return AE_OK;
+}
+
 static acpi_status
 acpi_pcc_address_space_handler(u32 function, acpi_physical_address addr,
 			       u32 bits, acpi_integer *value,
 			       void *handler_context, void *region_context)
 {
-	int ret;
+	acpi_status ret;
 	struct pcc_data *data = region_context;
 	u64 usecs_lat;
+	bool use_polling = data->pcc_chan->mchan->mbox->txdone_poll;

 	reinit_completion(&data->done);

 	/* Write to Shared Memory */
 	memcpy_toio(data->pcc_chan->shmem, (void *)value, data->ctx.length);

-	ret = mbox_send_message(data->pcc_chan->mchan, NULL);
-	if (ret < 0)
-		return AE_ERROR;
-
 	/*
 	 * pcc_chan->latency is just a Nominal value. In reality the remote
 	 * processor could be much slower to reply. So add an arbitrary
 	 * amount of wait on top of Nominal.
 	 */
 	usecs_lat = PCC_CMD_WAIT_RETRIES_NUM * data->pcc_chan->latency;
-	ret = wait_for_completion_timeout(&data->done,
-						usecs_to_jiffies(usecs_lat));
-	if (ret == 0) {
-		pr_err("PCC command executed timeout!\n");
-		return AE_TIME;
-	}

-	mbox_chan_txdone(data->pcc_chan->mchan, ret);
+	data->cl.tx_block = use_polling;
+	data->cl.tx_tout = usecs_lat / USEC_PER_MSEC;
+
+	if (use_polling)
+		ret = acpi_pcc_send_msg_polling(data);
+	else
+		ret = acpi_pcc_send_msg_irq(data);

 	memcpy_fromio(value, data->pcc_chan->shmem, data->ctx.length);

-	return AE_OK;
+	return ret;
 }

 void __init acpi_init_pcc(void)
diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 0a00719b2482..e4e744669f81 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -579,11 +579,17 @@ static void pcc_shutdown(struct mbox_chan *chan)
 		devm_free_irq(chan->mbox->dev, pchan->plat_irq, chan);
 }

+static bool pcc_peek_data(struct mbox_chan *chan)
+{
+	return pcc_mbox_error_check_and_clear(chan->con_priv) == 0;
+}
+
 static const struct mbox_chan_ops pcc_chan_ops = {
 	.send_data = pcc_send_data,
 	.startup = pcc_startup,
 	.shutdown = pcc_shutdown,
 	.last_tx_done = pcc_last_tx_done,
+	.peek_data = pcc_peek_data,
 };

 /**
@@ -877,8 +883,12 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 		(unsigned long) pcct_tbl + sizeof(struct acpi_table_pcct));

 	acpi_pcct_tbl = (struct acpi_table_pcct *) pcct_tbl;
-	if (acpi_pcct_tbl->flags & ACPI_PCCT_DOORBELL)
+	if (acpi_pcct_tbl->flags & ACPI_PCCT_DOORBELL) {
 		pcc_mbox_ctrl->txdone_irq = true;
+	} else {
+		pcc_mbox_ctrl->txdone_poll = true;
+		pcc_mbox_ctrl->txpoll_period = 1;
+	}

 	for (i = 0; i < count; i++) {
 		struct pcc_chan_info *pchan = chan_info + i;
--
2.25.0

