Return-Path: <linux-acpi+bounces-12080-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E84DA5BFA7
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 12:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E82F176888
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 11:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3800B24167A;
	Tue, 11 Mar 2025 11:47:49 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0B8214A9A;
	Tue, 11 Mar 2025 11:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741693669; cv=none; b=cZlKa97Jzd3fw9MpS2rqeJ/ICfpue/IJLbx+uUe9InOVd25KIgEcAqp8RXy6+zOk/LRjkDmGseoGDGaIiCNwpN6tFgeUdgJrv+U7fVkOceb2Djz6BMj0WVOfEgdx6QSaSf21zvSAktUm8wpJwKq4pQF/oQNLbrJb66FoUmwGr2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741693669; c=relaxed/simple;
	bh=UpZB7yJlAeTzAIz0+EV/14+4oqybesjZxPrmDa9Aluk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g9g92/7LlF2crOQUMLiN0RYlMSsoYkyr++mqpxwS7tl2eEohBW8PFC38T6retffyWbO95XTJGAFPXu69+3lkfMg2+QjEIc5UTc8bLpIT8NQCOVksGK4Oa6V1Ydiny1X6Ig88JYLka067WiGaRNu3A7yUKb1MOhRjBfOWa7uqCy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4ZBsTZ25Mnz27gBg;
	Tue, 11 Mar 2025 19:48:18 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C6951A016C;
	Tue, 11 Mar 2025 19:47:43 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Mar 2025 19:47:43 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 11 Mar
 2025 19:47:42 +0800
Message-ID: <34bdfee2-4780-f45b-7891-e845b13fdd2f@huawei.com>
Date: Tue, 11 Mar 2025 19:47:39 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 08/13] mailbox: pcc: Refactor and simplify
 check_and_ack()
To: Sudeep Holla <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Jassi Brar <jassisinghbrar@gmail.com>, Adam Young
	<admiyo@os.amperecomputing.com>, Robbie King <robbiek@xsightlabs.com>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
 <20250305-pcc_fixes_updates-v2-8-1b1822bc8746@arm.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20250305-pcc_fixes_updates-v2-8-1b1822bc8746@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/3/6 0:38, Sudeep Holla 写道:
> The existing check_and_ack() function had unnecessary complexity. The
> logic could be streamlined to improve code readability and maintainability.
>
> The command update register needs to be updated in order to acknowledge
> the platform notification through type 4 channel. So it can be done
> unconditionally. Currently it is complicated just to make use of
> pcc_send_data() which also executes the same updation.
>
> In order to simplify, let us just ring the doorbell directly from
> check_and_ack() instead of calling into pcc_send_data(). While at it,
> rename it into pcc_chan_check_and_ack() to maintain consistency in the
> driver.
LGTM except for some trivial,
Acked-by: Huisong Li <lihuisong@huawei.com>
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/mailbox/pcc.c | 37 +++++++++++++------------------------
>   1 file changed, 13 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index b3d133170aac7f8acfd1999564c69b7fe4f6d582..90d6f5e24df7e796f8c29705808eb6df2806c1f2 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -117,8 +117,6 @@ struct pcc_chan_info {
>   static struct pcc_chan_info *chan_info;
>   static int pcc_chan_count;
>   
> -static int pcc_send_data(struct mbox_chan *chan, void *data);
> -
>   /*
>    * PCC can be used with perf critical drivers such as CPPC
>    * So it makes sense to locally cache the virtual address and
> @@ -288,33 +286,24 @@ static int pcc_mbox_error_check_and_clear(struct pcc_chan_info *pchan)
>   	return 0;
>   }
>   
> -static void check_and_ack(struct pcc_chan_info *pchan, struct mbox_chan *chan)
> +static void pcc_chan_check_and_ack(struct pcc_chan_info *pchan)
How about use pcc_chan_ack?
>   {
> -	struct acpi_pcct_ext_pcc_shared_memory pcc_hdr;
> +	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_hdr;
>   
>   	if (pchan->type != ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
>   		return;
> -	/* If the memory region has not been mapped, we cannot
> -	 * determine if we need to send the message, but we still
> -	 * need to set the cmd_update flag before returning.
> -	 */
> -	if (pchan->chan.shmem == NULL) {
> -		pcc_chan_reg_read_modify_write(&pchan->cmd_update);
> -		return;
> -	}
> -	memcpy_fromio(&pcc_hdr, pchan->chan.shmem,
> -		      sizeof(struct acpi_pcct_ext_pcc_shared_memory));
> +
> +	pcc_chan_reg_read_modify_write(&pchan->cmd_update);
> +
> +	pcc_hdr = pchan->chan.shmem;

Should use the original code?

memcpy_fromio(&pcc_hdr, pchan->chan.shmem,
		      sizeof(struct acpi_pcct_ext_pcc_shared_memory));

> +
>   	/*
> -	 * The PCC slave subspace channel needs to set the command complete bit
> -	 * after processing message. If the PCC_ACK_FLAG is set, it should also
> -	 * ring the doorbell.
> -	 *
> -	 * The PCC master subspace channel clears chan_in_use to free channel.
> +	 * The PCC slave subspace channel needs to set the command
> +	 * complete bit after processing message. If the PCC_ACK_FLAG
> +	 * is set, it should also ring the doorbell.
>   	 */
> -	if (pcc_hdr.flags & PCC_CMD_COMPLETION_NOTIFY)
> -		pcc_send_data(chan, NULL);
> -	else
> -		pcc_chan_reg_read_modify_write(&pchan->cmd_update);
> +	if (ioread32(&pcc_hdr->flags) & PCC_CMD_COMPLETION_NOTIFY)
> +		pcc_chan_reg_read_modify_write(&pchan->db);
>   }
>   
>   /**
> @@ -352,7 +341,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   	pchan->chan_in_use = false;
>   	mbox_chan_received_data(chan, NULL);
>   
> -	check_and_ack(pchan, chan);
> +	pcc_chan_check_and_ack(pchan);
>   
>   	return IRQ_HANDLED;
>   }
>

