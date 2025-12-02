Return-Path: <linux-acpi+bounces-19379-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FE5C9B0A5
	for <lists+linux-acpi@lfdr.de>; Tue, 02 Dec 2025 11:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACD053A4DAC
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Dec 2025 10:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B47B30F7E8;
	Tue,  2 Dec 2025 10:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipearl.com header.i=@sipearl.com header.b="kT/E+JDV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtpout.sipearl.com (smtpout.sipearl.com [178.170.11.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C94430E0D9;
	Tue,  2 Dec 2025 10:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.170.11.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764670403; cv=none; b=JeIux7ymZHKmTGs/o21NAnVjPUZHUhMXFty6KrAaKyZSq2M2OZVJYKX1o+4T1LH0qsKHQfbnRIShdP87jujPkTgsBKruEwE7aBWro0k1LxJSaSuuK98NyDsOmFiLsVn/cZKPmtmVNFzamFABWSKbaiWi52jOkopx+EODp3tA3iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764670403; c=relaxed/simple;
	bh=hXsBii3RQCZ+BzXwujYwWbydWY6iYnfjFp/Qf6k8+ZQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hHNa4/bHl3mSrJrhqPgpbXYxoa89OlnDoD+EHA6NdYhd5P07zrHJzVtpTSi6slz1Q8mYMM43VQm7hs4DSeW1Q1YzD4AjvZawlVp6qBGOQOGIXfcajkrXygejLZYyEp/p0jTFpsd/vCbYcIu9vLMRsvLu8GIsuxNYUVFJDGdkOOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipearl.com; spf=pass smtp.mailfrom=sipearl.com; dkim=pass (2048-bit key) header.d=sipearl.com header.i=@sipearl.com header.b=kT/E+JDV; arc=none smtp.client-ip=178.170.11.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipearl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipearl.com
Received: from smtpout.sipearl.com ([172.31.29.1])
	by smtpin.sipearl.com  with ESMTPS id 5B2AChom007506-5B2AChoo007506
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Dec 2025 11:12:43 +0100
Received: from dc2pvlnosz001.pub.int.sipearl.com (172.31.65.18) by
 dc2pvwexcz001.sipearl.corp (172.31.29.1) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Tue, 2 Dec 2025 11:12:43 +0100
From: Andrea Tomassetti <andrea.tomassetti@sipearl.com>
To: <sudeep.holla@arm.com>
CC: <andrea.tomassetti@sipearl.com>, <jassisinghbrar@gmail.com>,
	<lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lkp@intel.com>,
	<oe-kbuild-all@lists.linux.dev>, <olivier.dautricourt@sipearl.com>,
	<olivierdautricourt@gmail.com>, <rafael@kernel.org>,
	<thibault.cantori@sipearl.com>
Subject: [PATCH v3 1/2] mailbox: pcc: support polling mode when there is no platform IRQ
Date: Tue, 2 Dec 2025 11:12:14 +0100
Message-ID: <20251202101215.2240024-1-andrea.tomassetti@sipearl.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251127-lovely-real-wrasse-b1fbcd@sudeepholla>
References: <20251127-lovely-real-wrasse-b1fbcd@sudeepholla>
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
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=0jGh9SdSuD6apSeJEArVdo1S/NrSWq+ag67s8Lww+qs=;
 b=kT/E+JDVLbHouY5TKtl6w03/5xnS4iQvnxDjz6HpkISuujyL7zF7xPxHng6KFZE/JGN5VWt/MOlW
	DzU9wz1TveWRsyH7grex7ZMSs/YUtEZSkGXtB/dkCLZeIbpMSir0AGIFgg8R16qMMfRxf9DqiOBa
	FrNEBEYU/qMCYYw6vD7j+jlVJCAQYNtRD4xS29FlR6yhx3FiYMNwYXr/08b/6E2LjV+zoqxZyWst
	8fxJEFGezSNQS2G/77nRhlyWW7umJc141k1Gx2MkGpoSv2GC324WXW1Haxbf/vDouGsf70W7v5We
	bKKfC/wDOtJx5shutvPu8gaHZypKUIsgGu1+8A==

The goal is to allow clients to submit a message in both irq and polling
mode of the pcc mailbox. The ACPI specification does not require a
platform irq for pcc channels. Let's implement the case where it is not
available.

Tested-by: Thibault Cantori <thibault.cantori@sipearl.com>
Co-developed-by: Olivier Dautricourt <olivier.dautricourt@sipearl.com>
Signed-off-by: Olivier Dautricourt <olivier.dautricourt@sipearl.com>
Signed-off-by: Andrea Tomassetti <andrea.tomassetti@sipearl.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202511120243.soxAFpqQ-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202511120558.Cln7LF6M-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202511120729.R3XQNSnx-lkp@intel.com/
---
v3: Thank you very much for the feedback Sudeep! Here there are the changes
    implemented in this latest version:
  - separate the changes to the PCC OpRegion handler and the PCC mailbox
    driver into individual patches
  - rebased the changes on top of the ongoing cleanup work

v2: Fix issues reported by the kernel test robot
  - sparse: incorrect type in argument 2 (different address spaces)
  - acpi_pcc.c:(.text+0x69): undefined reference to `__udivdi3'

 drivers/acpi/acpi_pcc.c | 78 ++++++++++++++++++++++++++++-------------
 1 file changed, 53 insertions(+), 25 deletions(-)

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
-- 
2.51.2


