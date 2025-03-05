Return-Path: <linux-acpi+bounces-11824-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE927A4F775
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 07:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E301890462
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 06:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3F51E9917;
	Wed,  5 Mar 2025 06:48:21 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896B11E0DB3;
	Wed,  5 Mar 2025 06:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741157301; cv=none; b=OtBWJiUWVj3OYMrx54jSwVM2co8GEMq+h/NAjW3mZ6FUB7CWzFYWkV6tBe8rScjL9g5G6bsKHAYHcL7HR/Z5Fmw0UhZTGS7Enxd1GPK/QaC8dvE0CuHBqMeAYgqraaKywf0mO+M6NVDlIQCJZFnxLWEhH6sHktbLg5DhMP646QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741157301; c=relaxed/simple;
	bh=vUMkbdgNDewqNNntuY+ZVtniT88cSX2GO7xcfQ2QhwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nQ8IFVmJYeVODIrMPa6HFArgDDoYg5YI+/VE1nmsouW3wZ9fLRMEfHSio0cPP8QWaysoTzjRHBS9qCA8cTkCtNmqmd4eSta4+1Jke9O+6pB/hy0L7am/KHV2noPY3xVUDJawtADJXHPiH5bQffMD3wY/pH/6N0F589iW9YisdaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Z73252f4CzCs6y;
	Wed,  5 Mar 2025 14:44:45 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 114901800C9;
	Wed,  5 Mar 2025 14:48:15 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Mar 2025 14:48:14 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 5 Mar
 2025 14:48:14 +0800
Message-ID: <5738e05f-fa1c-0aa7-78f3-3d38f9f0ae3c@huawei.com>
Date: Wed, 5 Mar 2025 14:48:13 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 07/14] mailbox: pcc: Move pcc_mbox_ioremap() before
 pcc_mbox_request_channel()
To: Sudeep Holla <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Jassi Brar <jassisinghbrar@gmail.com>, Adam Young
	<admiyo@os.amperecomputing.com>
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
 <20250303-pcc_fixes_updates-v1-7-3b44f3d134b1@arm.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20250303-pcc_fixes_updates-v1-7-3b44f3d134b1@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/3/3 18:51, Sudeep Holla 写道:
> In order to add support of mapping the generic communication shared
> memory region in the PCC mailbox driver when the PCC channel is requested,
> we need to move pcc_mbox_ioremap() before pcc_mbox_request_channel().
This patch is supposed to merge into patch 8/14 because it depend on 
this moving.
>
> No functional change.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/mailbox/pcc.c | 38 +++++++++++++++++++-------------------
>   1 file changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index e693675ce1fbd8d01d0640b3053a5c1882bdbce7..f230e512c29b79fc03e429145180ff049a250d2d 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -357,6 +357,25 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   	return IRQ_HANDLED;
>   }
>   
> +int pcc_mbox_ioremap(struct mbox_chan *chan)
> +{
> +	struct pcc_chan_info *pchan_info;
> +	struct pcc_mbox_chan *pcc_mbox_chan;
> +
> +	if (!chan || !chan->cl)
> +		return -1;
> +	pchan_info = chan->con_priv;
> +	pcc_mbox_chan = &pchan_info->chan;
> +
> +	pcc_mbox_chan->shmem = acpi_os_ioremap(pcc_mbox_chan->shmem_base_addr,
> +					       pcc_mbox_chan->shmem_size);
> +	if (!pcc_mbox_chan->shmem)
> +		return -ENXIO;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pcc_mbox_ioremap);
> +
>   /**
>    * pcc_mbox_request_channel - PCC clients call this function to
>    *		request a pointer to their PCC subspace, from which they
> @@ -419,25 +438,6 @@ void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
>   }
>   EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
>   
> -int pcc_mbox_ioremap(struct mbox_chan *chan)
> -{
> -	struct pcc_chan_info *pchan_info;
> -	struct pcc_mbox_chan *pcc_mbox_chan;
> -
> -	if (!chan || !chan->cl)
> -		return -1;
> -	pchan_info = chan->con_priv;
> -	pcc_mbox_chan = &pchan_info->chan;
> -
> -	pcc_mbox_chan->shmem = acpi_os_ioremap(pcc_mbox_chan->shmem_base_addr,
> -					       pcc_mbox_chan->shmem_size);
> -	if (!pcc_mbox_chan->shmem)
> -		return -ENXIO;
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(pcc_mbox_ioremap);
> -
>   /**
>    * pcc_send_data - Called from Mailbox Controller code. Used
>    *		here only to ring the channel doorbell. The PCC client
>

