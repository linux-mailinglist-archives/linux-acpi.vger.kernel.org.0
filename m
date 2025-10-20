Return-Path: <linux-acpi+bounces-17960-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0305DBEF383
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 06:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E4918987C8
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 04:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7412BCF68;
	Mon, 20 Oct 2025 04:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="Uq+m6Ruj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC6E8F5B;
	Mon, 20 Oct 2025 04:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760933316; cv=none; b=sO0poSOziYKW/J/uHocViC45/PhirvJc6RDzdpz0kz6o6SlYf74ReHYZ86Sv7qd72Q8l8vIH5Ao48zxcEYM8N0BfQv+x835LS6rTrpfDh5aazGroVkqsp8aco/GW0AGNPzzIZqQARFAOm20n8dZGk1gi/TGvZNlxXZHiNvmX6UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760933316; c=relaxed/simple;
	bh=Xs789rIC2x1LyfFCF/lWHeg73oO1t+9X0l+uqBHBem0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oFbwFSGGhlltKnVEH352EmZmmfG1CTgrMG0NXRa7djr57TpIHTWjiFtcgj7sLld+d6nXLYT3K3Q5mNswWTHZwz5cU8gvOG95ltcQvCF5lklA1TSGIagCCoM2kqktkh6jOLdJxn+ZJWJnKoliC1Gz2lLlDWt+399pC6hVHfErPtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=Uq+m6Ruj; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vogSXQAY5L+d+4yqK1YD4lFEDswlXWh6n2/fPYiXaHc=;
	b=Uq+m6RujRZINecpmG/RFEnm71tx29HPn3oqyaA5YECxIQ2f/ub//4auE1WZWcYV7xxQrh41lW
	0TKOQ8wqYq3dEMTpaHC5SjR9vw/gI862S59IBvnhNWNPSWbfoTk1SBOoerHUDbrfrdMXixWNLop
	5kP9LyPyXGzUKKaCm+ye640=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4cqhhg4LHPzcZyT;
	Mon, 20 Oct 2025 12:07:15 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id A9CD6180B4A;
	Mon, 20 Oct 2025 12:08:22 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Oct 2025 12:08:22 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 20 Oct
 2025 12:08:21 +0800
Message-ID: <7c351acf-aa0e-4e2e-89de-f296b3abd956@huawei.com>
Date: Mon, 20 Oct 2025 12:08:21 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] mailbox: pcc: Mark Tx as complete in PCC IRQ handler
To: Sudeep Holla <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Adam Young <admiyo@os.amperecomputing.com>, Robbie King
	<robbiek@xsightlabs.com>, Jassi Brar <jassisinghbrar@gmail.com>, "Cristian
 Marussi" <cristian.marussi@arm.com>
References: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
 <20251016-pcc_mb_updates-v1-4-0fba69616f69@arm.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20251016-pcc_mb_updates-v1-4-0fba69616f69@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/10/17 3:08, Sudeep Holla 写道:
> The PCC IRQ handler clears channel-in-use and notifies clients with
> mbox_chan_received_data(), but it does not explicitly mark the
> transmit as complete. In IRQ completion mode this could leave Tx complete
> waiters hanging or lead to generic timeouts in the mailbox core.
>
> Invoke mbox_chan_txdone() in the IRQ path once the platform has
> acknowledged the transfer so the core can wake any waiters and update
> state accordingly.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/mailbox/pcc.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 327e022973db..33bd2d05704b 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -341,6 +341,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   	 */
>   	pchan->chan_in_use = false;
>   	mbox_chan_received_data(chan, NULL);
> +	mbox_chan_txdone(chan, 0);
Normally, this interface is called by mbox client.
So, IMO, this added code is not ok for mbox client.
AFAIS, this code should be for type4, right?
If so, the mbox client of type 4 channel has  responsibility to call 
this interface.
>   
>   	pcc_chan_acknowledge(pchan);
>   
>

