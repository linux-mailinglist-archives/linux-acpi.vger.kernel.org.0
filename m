Return-Path: <linux-acpi+bounces-19069-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BACAC6D909
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 10:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 1A8392D615
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 09:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32002333438;
	Wed, 19 Nov 2025 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipearl.com header.i=@sipearl.com header.b="A14RteS/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtpout.sipearl.com (smtpout.sipearl.com [178.170.11.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8D9332EC8;
	Wed, 19 Nov 2025 09:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.170.11.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763543027; cv=none; b=arDJjQ2zTqF+VsFEq2r+BfCwmAZxcp3il+b/RYtbcKwJS+7GG1wqjSalcgTuZpd2VinPUaN7vR8u51Y+yK6K/FbWJpi6z99flJ3C2X0Y5KIzq8WkPozpHljWEEJXUECSfP9XHS9aNu0XpA00iYWMTiUPyPGBGt0jNtLGFpZBb1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763543027; c=relaxed/simple;
	bh=A/nzHBnTALxUYji4M2ChVsHyYrSq/vEPPwnxPfJ6nh8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IXskrMCmV36h4E14kSd9OlJs/ezVbx/Fn/S92WGJUQkxm4p+2wM1D4cv8OivIsP1LJjE4UI0eibhW3zj3Figig3Aoc6rgshakQRNEiyXLq5uwr/fRq1P53ZlXONmFL5khTCnauZyDDvs4d/bC4/5/P9hR7Qr3b7Q+GncC4e0gA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipearl.com; spf=pass smtp.mailfrom=sipearl.com; dkim=pass (2048-bit key) header.d=sipearl.com header.i=@sipearl.com header.b=A14RteS/; arc=none smtp.client-ip=178.170.11.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipearl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipearl.com
Received: from smtpout.sipearl.com ([172.31.29.1])
	by smtpin.sipearl.com  with ESMTPS id 5AJ92vrG024678-5AJ92vrI024678
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 10:02:57 +0100
Received: from dc2pvlnosz001.pub.int.sipearl.com (172.31.65.18) by
 dc2pvwexcz001.sipearl.corp (172.31.29.1) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 19 Nov 2025 10:02:57 +0100
From: Andrea Tomassetti <andrea.tomassetti@sipearl.com>
To: <lkp@intel.com>
CC: <andrea.tomassetti@sipearl.com>, <jassisinghbrar@gmail.com>,
	<lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <oe-kbuild-all@lists.linux.dev>,
	<olivier.dautricourt@sipearl.com>, <olivierdautricourt@gmail.com>,
	<rafael@kernel.org>, <sudeep.holla@arm.com>, <thibault.cantori@sipearl.com>
Subject: [PATCH v2] mailbox: pcc: support polling mode when there is no platform IRQ
Date: Wed, 19 Nov 2025 10:01:18 +0100
Message-ID: <20251119090118.2445303-1-andrea.tomassetti@sipearl.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <202511120729.R3XQNSnx-lkp@intel.com>
References: <202511120729.R3XQNSnx-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dc2pvwexcz002.sipearl.corp (172.31.29.2) To
 dc2pvwexcz001.sipearl.corp (172.31.29.1)
X-FEAS-Client-IP: 172.31.29.1
X-FE-Policy-ID: 2:2:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=sipearl.com; s=sipearl2024; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=cQRvB0G2AMAcVVjKdC/G5kP1LGby/AHBtIZ3/QDRRRM=;
 b=A14RteS/eOEuAgyfs2jbMZvR0TNpt6yuDiF8C3B+43r07tX+r+S8xOAJz8G99F6Q0BQusKOVarPC
	k+4AuT6BwZwerrVT6kNkTjhcn96jLu6v65GwVXFWEFc61aAo3nu7ZWQwjpCYC90YKmaD7cX3oraH
	V/8E8zEaBcwQbRThgNpJEArCAG5KiDo3sDf0IzQxFycogqS0f/fXYaQMYNfWzpAu2+TmGxQfIcQ6
	XZbVm2TUI0QGC4cgg5WBAAo3mnWqC7jWNzWdbiY8RO9PCYC2SDlHKFA9wC5oM0b4INazXUA63i20
	RU+q46y6wXF04Rs9l8BwJfsJMlVTUlv5o9jIsA==

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
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202511120243.soxAFpqQ-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202511120558.Cln7LF6M-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202511120729.R3XQNSnx-lkp@intel.com/
---
v2: Fix issues reported by the kernel test robot
  - sparse: incorrect type in argument 2 (different address spaces)
  - acpi_pcc.c:(.text+0x69): undefined reference to `__udivdi3'

 drivers/acpi/acpi_pcc.c | 78 ++++++++++++++++++++++++++++-------------
 drivers/mailbox/pcc.c   | 12 ++++++-
 2 files changed, 64 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
index 97064e943768..37f94fa4c424 100644
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
@@ -73,61 +72,90 @@ acpi_pcc_address_space_setup(acpi_handle region_handle, u32 function,
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
+	ret = mbox_send_message(data->pcc_chan->mchan,
+				(__force void *)data->pcc_chan->shmem);
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
+	data->cl.tx_tout = div_u64(usecs_lat, USEC_PER_MSEC);
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

base-commit: 8b690556d8fe074b4f9835075050fba3fb180e93
-- 
2.51.2


