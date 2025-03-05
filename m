Return-Path: <linux-acpi+bounces-11819-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE087A4F58D
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 04:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8FDC1890F6E
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 03:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4A21624D9;
	Wed,  5 Mar 2025 03:45:48 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3731624FC;
	Wed,  5 Mar 2025 03:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741146348; cv=none; b=ob0uAgX5/G7PIRsZtcOhtEBC/YyYayWT6BNl4ss0kyS7LPePZNTQFrXLktcISzkB0Gh7AjnB5F9soJW6OsV2NPPnbSPjqaLMQx/oDP4uaRHu6esyKc0iMrrxG8vRa7ab9AQxZDGKLnRZsv7rLUIFStto5x7QlS1VG4oXW/lop9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741146348; c=relaxed/simple;
	bh=0yTzmYzJnjOSQukZ5c5JyGiOIX7TMKbcvpqAZR22Dy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NqHzgvzx669hox17c6vPlkNw9eLZp4oQsBnla/jujYiUa6wWWKYDwrmHhN0KqIHSUjxQI3IAkcnNCZr+aRSYrECb5DuxJ2c9gyhxOmHLIHtoI5jap+sZv5BZ/37xJZuOqw7cPy8BW8n7TdbuYTUDDji+A5IxXVEuPRIiLXDCowE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Z6z4222wSz17NWt;
	Wed,  5 Mar 2025 11:46:10 +0800 (CST)
Received: from dggemv704-chm.china.huawei.com (unknown [10.3.19.47])
	by mail.maildlp.com (Postfix) with ESMTPS id B8F5B1A0188;
	Wed,  5 Mar 2025 11:45:36 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Mar 2025 11:45:36 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 5 Mar
 2025 11:45:35 +0800
Message-ID: <397910e0-38eb-553a-2bd2-c338d8c3a49c@huawei.com>
Date: Wed, 5 Mar 2025 11:45:35 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 02/14] mailbox: pcc: Always clear the platform ack
 interrupt first
To: Sudeep Holla <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Jassi Brar <jassisinghbrar@gmail.com>, Adam Young
	<admiyo@os.amperecomputing.com>, Robbie King <robbiek@xsightlabs.com>
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
 <20250303-pcc_fixes_updates-v1-2-3b44f3d134b1@arm.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20250303-pcc_fixes_updates-v1-2-3b44f3d134b1@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/3/3 18:51, Sudeep Holla 写道:
> The PCC mailbox interrupt handler (pcc_mbox_irq()) currently checks
> for command completion flags and any error status before clearing the
> interrupt.
>
> The below sequence highlights an issue in the handling of PCC mailbox
> interrupts, specifically when dealing with doorbell notifications and
> acknowledgment between the OSPM and the platform where type3 and type4
> channels are sharing the interrupt.
>
>          Platform Firmware              OSPM/Linux PCC driver
> ------------------------------------------------------------------------
>                                       build message in shmem
>                                       ring type3 channel doorbell
> receives the doorbell interrupt
>    process the message from OSPM
>    build response for the message
> ring the platform ack interrupt to OSPM
> 				--->
> build notification in type4 channel
>                                       start processing in pcc_mbox_irq()
>                                        enter pcc handler for type4 chan
>                                           command complete cleared
> 			        	 read the notification
>                                  <---     clear platform ack irq
>    		* no effect from above as platform ack irq *
> 		* not yet triggered on this channel *
> ring the platform ack irq on type4 channel
> 				--->
>                                        leave pcc handler for type4 chan
>                                        enter pcc handler for type3 chan
>                                           command complete set
> 					 read the response
>                                  <---     clear platform ack irq
>                                        leave pcc handler for type3 chan
>                                       leave pcc_mbox_irq() handler
>                                       start processing in pcc_mbox_irq()
>                                        enter pcc handler for type4 chan
>                                        leave pcc handler for type4 chan
>                                        enter pcc handler for type3 chan
>                                        leave pcc handler for type3 chan
>                                       leave pcc_mbox_irq() handler
This is not easy to understand to me.
The issue as below described is already very clear to me.
So suggest remove above flow graph.
> The key issue occurs when OSPM tries to acknowledge platform ack
> interrupt for a notification which is ready to be read and processed
> but the interrupt itself is not yet triggered by the platform.
>
> This ineffective acknowledgment leads to an issue later in time where
> the interrupt remains pending as we exit the interrupt handler without
> clearing the platform ack interrupt as there is no pending response or
> notification. The interrupt acknowledgment order is incorrect.
Has this issue been confired? It's more better if has the log.😁
But it seems a valid issue.
>
> To resolve this issue, the platform acknowledgment interrupt should
> always be cleared before processing the interrupt for any notifications
> or response.
AFAIC，always clearing the platform ack interrupt first which is also the 
communication flow as ACPI spec described.
I am not sure if it is ok when triggering interrupt and clearing 
interrupt occur concurrently.
But this scenario is always possible. I think It doesn't matter with 
this patch. It's just my confusion.
>
> Reported-by: Robbie King <robbiek@xsightlabs.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Lgtm,
Reviewed-by: Huisong Li <lihuisong@huawei.com>
> ---
>   drivers/mailbox/pcc.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index f2e4087281c70eeb5b9b33371596613a371dff4f..4c582fa2b8bf4c9a9368dba8220f567555dba963 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -313,6 +313,10 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   	int ret;
>   
>   	pchan = chan->con_priv;
> +
> +	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack))
> +		return IRQ_NONE;
> +
>   	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE &&
>   	    !pchan->chan_in_use)
>   		return IRQ_NONE;
> @@ -330,9 +334,6 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   		return IRQ_NONE;
>   	}
>   
> -	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack))
> -		return IRQ_NONE;
> -
>   	/*
>   	 * Clear this flag immediately after updating interrupt ack register
>   	 * to avoid possible race in updatation of the flag from
>

