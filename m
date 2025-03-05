Return-Path: <linux-acpi+bounces-11822-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 208A4A4F6D8
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 07:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E27116EE5C
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 06:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F9D1C701C;
	Wed,  5 Mar 2025 06:09:17 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F06170A13;
	Wed,  5 Mar 2025 06:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741154957; cv=none; b=gVUbFLjjHYn8c5LKLJc6YQmNNj6Qthovq6bZLdntEL0GaoxKU8yzz+zY2zgdGyn1a2l6do9Ocpe8yxlR2f54NNXsNJ0hou+NSKE1XnmNuyqdleUUlmWL+0o9sifho+4WCBZv7mQL1JS1qCwi5dIXaj3vIaer5Qmk7L7T0IjwwDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741154957; c=relaxed/simple;
	bh=oeNhIULAr61uRIVhjFIbhbeNn+d8Z47LbmVkmIFQM2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZpSwrMUSUPK2HCwKHhPmltubGhKMqDd6PXG2xtHHelpgKaUw8v0scTKbA69uOogs0lVQro2CJXeYIelT0Enc/eSIfPAJgWYrGsLmXMvct7LRnJRmBb04s+vn9sBzZAPjaJTsPiDD3z1nBlSUtNst9JUuZYVt2J9aYwHuNjQAayE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Z727H3GMDzwXQk;
	Wed,  5 Mar 2025 14:04:11 +0800 (CST)
Received: from dggemv711-chm.china.huawei.com (unknown [10.1.198.66])
	by mail.maildlp.com (Postfix) with ESMTPS id AB51C14037E;
	Wed,  5 Mar 2025 14:09:05 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Mar 2025 14:09:05 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 5 Mar
 2025 14:09:04 +0800
Message-ID: <91106bf6-9777-bde6-55f5-8fb7e7afd8ba@huawei.com>
Date: Wed, 5 Mar 2025 14:09:03 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 06/14] mailbox: pcc: Refactor error handling in irq
 handler into separate function
To: Sudeep Holla <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Jassi Brar <jassisinghbrar@gmail.com>, Adam Young
	<admiyo@os.amperecomputing.com>
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
 <20250303-pcc_fixes_updates-v1-6-3b44f3d134b1@arm.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20250303-pcc_fixes_updates-v1-6-3b44f3d134b1@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/3/3 18:51, Sudeep Holla 写道:
> The existing error handling logic in pcc_mbox_irq() is intermixed with the
> main flow of the function. The command complete check and the complete
> complete update/acknowledgment are nicely factored into separate functions.
>
> Moves error detection and clearing logic into a separate function called:
> pcc_mbox_error_check_and_clear() by extracting error-handling logic from
> pcc_mbox_irq().
>
> This ensures error checking and clearing are handled separately and it
> improves maintainability by keeping the IRQ handler focused on processing
> events.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/mailbox/pcc.c | 30 ++++++++++++++++++++----------
>   1 file changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index a0fdafc3ef71d20c73ff58ef065201e6dc911396..e693675ce1fbd8d01d0640b3053a5c1882bdbce7 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -269,6 +269,25 @@ static bool pcc_mbox_cmd_complete_check(struct pcc_chan_info *pchan)
>   	return !!val;
>   }
>   
> +static int pcc_mbox_error_check_and_clear(struct pcc_chan_info *pchan)
> +{
> +	u64 val;
> +	int ret;
> +
> +	ret = pcc_chan_reg_read(&pchan->error, &val);
> +	if (ret)
> +		return ret;
> +
> +	val &= pchan->error.status_mask;
> +	if (val) {
> +		val &= ~pchan->error.status_mask;
> +		pcc_chan_reg_write(&pchan->error, val);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
>   static void check_and_ack(struct pcc_chan_info *pchan, struct mbox_chan *chan)
>   {
>   	struct acpi_pcct_ext_pcc_shared_memory pcc_hdr;
> @@ -309,8 +328,6 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   {
>   	struct pcc_chan_info *pchan;
>   	struct mbox_chan *chan = p;
> -	u64 val;
> -	int ret;
>   
>   	pchan = chan->con_priv;
>   
> @@ -324,15 +341,8 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   	if (!pcc_mbox_cmd_complete_check(pchan))
>   		return IRQ_NONE;
>   
> -	ret = pcc_chan_reg_read(&pchan->error, &val);
> -	if (ret)
> +	if (!pcc_mbox_error_check_and_clear(pchan))
>   		return IRQ_NONE;

Here should be like below code, right? 0 on success.

if (pcc_mbox_error_check_and_clear(pchan))
  		return IRQ_NONE;

> -	val &= pchan->error.status_mask;
> -	if (val) {
> -		val &= ~pchan->error.status_mask;
> -		pcc_chan_reg_write(&pchan->error, val);
> -		return IRQ_NONE;
> -	}
>   
>   	/*
>   	 * Clear this flag immediately after updating interrupt ack register
>

