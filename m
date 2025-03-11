Return-Path: <linux-acpi+bounces-12076-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 158A3A5BED9
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 12:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D26416ECD9
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 11:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A4B25487F;
	Tue, 11 Mar 2025 11:23:29 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5881523816D;
	Tue, 11 Mar 2025 11:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741692208; cv=none; b=UzrIaQFPYlMvp4MBB1rv+Wr58GP3SeOP3DwcdIJwjUMXZcm3zYTOmwBLs4waCAWraZ4WSwgKqDLP74V369hWTQIHbsgp63Og8iaYDoMK3blwytGlt4WhGBYMC3Ns5P6fMtmef8NOcfjwiYBKVYbm5vgB96kBzd/tu9jvQe0Xd+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741692208; c=relaxed/simple;
	bh=gaEpZqmgr8C7OEl9qKSUSCWcDsIXL/k2RXNQZz2ohOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bw+rPaPTsWmZJ4yPizPqgr3kRkdykjPSbVDPMTN8WmGjBHoPTsw3gcbeUSE0v/Iogs+8/tWP4DYS6Jkvo6lqQ1gTcCEZKt/6/E2uLnP5zHHA5bEg8yHXCLICNLRSZKZ8LlL83Sqyb0vYdTgTxHtRt2zVfHSQ7l7QK5lZ05JhC+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4ZBrxN0L2Zz27gHM;
	Tue, 11 Mar 2025 19:23:52 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 416DC1A016C;
	Tue, 11 Mar 2025 19:23:17 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Mar 2025 19:23:17 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 11 Mar
 2025 19:23:16 +0800
Message-ID: <59bea7ac-ad43-0c0f-0796-6567962428a7@huawei.com>
Date: Tue, 11 Mar 2025 19:23:15 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 06/13] mailbox: pcc: Refactor error handling in irq
 handler into separate function
To: Sudeep Holla <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Jassi Brar <jassisinghbrar@gmail.com>, Adam Young
	<admiyo@os.amperecomputing.com>, Robbie King <robbiek@xsightlabs.com>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
 <20250305-pcc_fixes_updates-v2-6-1b1822bc8746@arm.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20250305-pcc_fixes_updates-v2-6-1b1822bc8746@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/3/6 0:38, Sudeep Holla 写道:
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
Acked-by: Huisong Li <lihuisong@huawei.com>
Tested-by: Huisong Li <lihuisong@huawei.com>
> ---
>   drivers/mailbox/pcc.c | 30 ++++++++++++++++++++----------
>   1 file changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index b1b8223b5da7002fc522523dbc82f6124215439a..41bd14851216e8c4f03052c81aaf938a5e5c5343 100644
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
> +	if (pcc_mbox_error_check_and_clear(pchan))
>   		return IRQ_NONE;
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

