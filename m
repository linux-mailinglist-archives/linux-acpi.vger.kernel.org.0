Return-Path: <linux-acpi+bounces-17958-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4427BEF36B
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 06:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8400C3E2180
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 04:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466C828641D;
	Mon, 20 Oct 2025 04:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="bkJCSfZP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128581DE4E0;
	Mon, 20 Oct 2025 04:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760932938; cv=none; b=pe4tvv8DV8XkeRcz/TNneeEdaqAoimvIAt9PisSE6SAM8fRdIzz8ljCO0n41FBnCS6bfIOBBan600Yu79YFH5aAvahUPr6J1mHWPvb5KS9qeXikbw/02ms5oNWPWr4maWVAzJse8sLSddbXb9OjYVhx8ZGcC2hmgY0HrONbH3iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760932938; c=relaxed/simple;
	bh=xiQEuhbS26lgi7tc0SiF/Pi3BxxNJ65xaFRgFXWdszQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s3yLURm5Atfrm+BKbrH8FLbloN9iyepsdQVwyg4oZzRQL4Ge6vcpZYFwKyxH1rInyXfO+CI6wEvroiGi6jO+0JkO+yPPeNOOgy4IWiAGiIK0VlsF/naXhANK5sKxi0QSs6MICaN9TgbB9mImosSmP4fyCELJp+c4tZXEYdL3zXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=bkJCSfZP; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=MzJdLmnOsL/VXj2QYXvU0BjpxQDu6/NiGIPBtSIXgsU=;
	b=bkJCSfZP0k4djR2U/n2o8tfNPNr0mprPz/tVdFxoqoK6S5lbzvJdWz+NlAOYWMyypZqLhgprk
	aQ6BjrvpnkK12G3x9Nr9jeALrEqNZzfwylGeL4JbHx63/tGst4HC6tVXVFE07a995TpdY9VbzJj
	sWYHg5vB6QcXklYLu/WnOic=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4cqhZF4jYlzRhR7;
	Mon, 20 Oct 2025 12:01:41 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 1EE4C1402ED;
	Mon, 20 Oct 2025 12:02:05 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Oct 2025 12:01:55 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 20 Oct
 2025 12:01:54 +0800
Message-ID: <6d4b85ce-de35-4a38-92ff-34b2caec66d0@huawei.com>
Date: Mon, 20 Oct 2025 12:01:54 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] mailbox: pcc: Wire up ->last_tx_done() for PCC
 channels
To: Sudeep Holla <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Adam Young <admiyo@os.amperecomputing.com>, Robbie King
	<robbiek@xsightlabs.com>, Jassi Brar <jassisinghbrar@gmail.com>, "Cristian
 Marussi" <cristian.marussi@arm.com>
References: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
 <20251016-pcc_mb_updates-v1-2-0fba69616f69@arm.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20251016-pcc_mb_updates-v1-2-0fba69616f69@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/10/17 3:08, Sudeep Holla 写道:
> Some PCC users poll for completion between transfers and benefit from
> the knowledge of previous Tx completion check through the mailbox
> framework's ->last_tx_done() op.
>
> Hook up the last_tx_done callback in the PCC mailbox driver so the mailbox
> framework can correctly query the completion status of the last transmitted
> message. This aligns PCC with other controllers that already implement such
> last_tx_done status query.
>
> No functional change unless callers use ->last_tx_done(). Normal Tx and
> IRQ paths are unchanged. This change just improves synchronization and
> avoids unnecessary timeouts for non-interrupt driven channels by ensuring
> correct completion detection for PCC channels that don’t rely on interrupts.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/mailbox/pcc.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index f6714c233f5a..2b690c268cf0 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -445,6 +445,13 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
>   	return ret;
>   }
>   
> +static bool pcc_last_tx_done(struct mbox_chan *chan)
> +{
> +	struct pcc_chan_info *pchan = chan->con_priv;
> +
The last_tx_done() is used on the condition that txdone_poll  is true 
and txdone_irq is false.
So how about add WARN_ON() for this in this API?
> +	return pcc_mbox_cmd_complete_check(pchan);
The pcc_mbox_cmd_complete_check() works on type 3/4.
I'm not sure if we need to add some comments or do some other something 
for this.
> +}
> +
>   /**
>    * pcc_startup - Called from Mailbox Controller code. Used here
>    *		to request the interrupt.
> @@ -490,6 +497,7 @@ static const struct mbox_chan_ops pcc_chan_ops = {
>   	.send_data = pcc_send_data,
>   	.startup = pcc_startup,
>   	.shutdown = pcc_shutdown,
> +	.last_tx_done = pcc_last_tx_done,
>   };
>   
>   /**
>

