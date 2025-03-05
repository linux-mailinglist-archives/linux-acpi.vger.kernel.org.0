Return-Path: <linux-acpi+bounces-11825-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E07BA4F782
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 07:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39BE216E395
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 06:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4507A1E5B94;
	Wed,  5 Mar 2025 06:54:46 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4E61E5B77;
	Wed,  5 Mar 2025 06:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741157686; cv=none; b=qkvJLhyCn9MeshDbQsMxKumESWcRdtmADwrDgLg7/FcRRsvkDbheck5HP6VTd7yxtsPPwQ2Hok8swLyroHBVusGshQlvHPcsbj7mqy3MBSdj5ButR6FOoYtUgNoBSQkNHNAT7Qf5EKtAISSwR/eOPuGEfj9GHF+XM4TgsHX0ybo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741157686; c=relaxed/simple;
	bh=bKk4Z0qYRtr74xLH77aXapB/oR/kYt+BhxpRKIKVP2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b8J/pgabD5coPQBFsC7VYFE4nqjQhEaJXQdn7M52oC0dXbfDoCTkIuP6N8cEQbd9p5CdmErgQBMbBsKeE57TDjYuVqf5gnKktH0U/L1WxYI3wU2XDJY8xioEP49F+aRMrYlrvaC0oLcY3oGW0BdSBiDq5QkzWJKBPTOe0Dg2pgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Z73GB370xz17NZG;
	Wed,  5 Mar 2025 14:55:14 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id D6E5B14025A;
	Wed,  5 Mar 2025 14:54:40 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Mar 2025 14:54:40 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 5 Mar
 2025 14:54:40 +0800
Message-ID: <fc45c6c7-6828-d36e-3bb1-9f90fec01b45@huawei.com>
Date: Wed, 5 Mar 2025 14:54:39 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 08/14] mailbox: pcc: Always map the shared memory
 communication address
To: Sudeep Holla <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Jassi Brar <jassisinghbrar@gmail.com>, Adam Young
	<admiyo@os.amperecomputing.com>
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
 <20250303-pcc_fixes_updates-v1-8-3b44f3d134b1@arm.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20250303-pcc_fixes_updates-v1-8-3b44f3d134b1@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/3/3 18:51, Sudeep Holla 写道:
> Currently the shared memory communication address was mapped by the
> mailbox client drivers leading to all sorts of inconsistencies.
>
> It also has resulted in the inconsistent attributes used while mapping
> the shared memory regions.
>
> In order to remove/eliminate any issues, let us ensures the shared
> memory address is always mapped and unmapped when the PCC channels are
> requested and release.
>
> We need to map them as the ACPI PCCT associates these shared memory
> with each channel subspace and may need use the headers in those
> memory to manage the transport.
>
> Since there are no users of pcc_chan_ioremap() and also it is mapped
> by default, we can stop exporting it and make it static function.

If pcc_chan_ioremap is static function, I think we can delete this 
function which just has one line if put this to pcc_mbox_request_channel().

>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/mailbox/pcc.c | 10 +++++++---
>   include/acpi/pcc.h    |  5 -----
>   2 files changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index f230e512c29b79fc03e429145180ff049a250d2d..5f2e2b727d99f07c44e87e44c11ba0aefe3a2318 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -357,7 +357,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   	return IRQ_HANDLED;
>   }
>   
> -int pcc_mbox_ioremap(struct mbox_chan *chan)
> +static int pcc_mbox_ioremap(struct mbox_chan *chan)
>   {
>   	struct pcc_chan_info *pchan_info;
>   	struct pcc_mbox_chan *pcc_mbox_chan;
> @@ -374,7 +374,6 @@ int pcc_mbox_ioremap(struct mbox_chan *chan)
>   
>   	return 0;
>   }
> -EXPORT_SYMBOL_GPL(pcc_mbox_ioremap);
>   
>   /**
>    * pcc_mbox_request_channel - PCC clients call this function to
> @@ -409,7 +408,12 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
>   	if (rc)
>   		return ERR_PTR(rc);
>   
> -	return &pchan->chan;
> +	rc = pcc_mbox_ioremap(chan);
> +	if (!rc)
> +		return &pchan->chan;
> +
> +	mbox_free_channel(chan);
> +	return ERR_PTR(rc);
>   }
>   EXPORT_SYMBOL_GPL(pcc_mbox_request_channel);
>   
> diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
> index 699c1a37b8e7846362bae35477eb5736be15d79e..0462bb9da6513a241f3b652b8e203299a1d990c7 100644
> --- a/include/acpi/pcc.h
> +++ b/include/acpi/pcc.h
> @@ -38,7 +38,6 @@ struct pcc_mbox_chan {
>   extern struct pcc_mbox_chan *
>   pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id);
>   extern void pcc_mbox_free_channel(struct pcc_mbox_chan *chan);
> -extern int pcc_mbox_ioremap(struct mbox_chan *chan);
>   #else
>   static inline struct pcc_mbox_chan *
>   pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
> @@ -46,10 +45,6 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
>   	return ERR_PTR(-ENODEV);
>   }
>   static inline void pcc_mbox_free_channel(struct pcc_mbox_chan *chan) { }
> -static inline int pcc_mbox_ioremap(struct mbox_chan *chan)
> -{
> -	return 0;
> -};
>   #endif
>   
>   #endif /* _PCC_H */
>

