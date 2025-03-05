Return-Path: <linux-acpi+bounces-11826-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DE6A4F7BA
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 08:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C133C16EFF7
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 07:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E67A1EDA31;
	Wed,  5 Mar 2025 07:15:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AD91EA7C3;
	Wed,  5 Mar 2025 07:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741158900; cv=none; b=RIV7zzGfwXLqKKDjgYCt1mWxCbUWGTIDD5ThSytD3PRC3NtEn/PdrBx0afKLd2g/BKTgYMShQb0F4Qm7xiEuXfGrvUTIA2SJfk7kOCaOEg41IKJVIle/n3LHpS5B9GPwT7DjLruDEgkRIbAT8vD1Wxwm7c7ZZJVvP7SRWed4f2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741158900; c=relaxed/simple;
	bh=OfQ1/h18gvYdGOQWsuGdpj6T21nI2Ua4bbZBb1UiOqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c9JLyJd1VN9sz6wzVBhsiWa52gmqB6gE01tK1/HoXi7wfl/+PNGb3VjRnq6w3x8rzZbkZwcQ1ki99ZkI3m3MAEEFiKPoyFyeVFL1Uf2K//BIGewMITNp4WUh5Oh+PNtIf0kfgQCk4h/3Otd1ahkq8586jt+PaB5/ScaFGgg1Vmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Z73fx6zzDz1R69V;
	Wed,  5 Mar 2025 15:13:13 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 023361400D3;
	Wed,  5 Mar 2025 15:14:52 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Mar 2025 15:14:51 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 5 Mar
 2025 15:14:51 +0800
Message-ID: <1e7560ab-2545-843a-e42a-2d37f6b7ef93@huawei.com>
Date: Wed, 5 Mar 2025 15:14:50 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 10/14] soc: hisilicon: kunpeng_hccs: Simplify PCC shared
 memory region handling
To: Sudeep Holla <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Jassi Brar <jassisinghbrar@gmail.com>, Adam Young
	<admiyo@os.amperecomputing.com>
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
 <20250303-pcc_fixes_updates-v1-10-3b44f3d134b1@arm.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20250303-pcc_fixes_updates-v1-10-3b44f3d134b1@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/3/3 18:51, Sudeep Holla 写道:
> The PCC driver now handles mapping and unmapping of shared memory
> areas as part of pcc_mbox_{request,free}_channel(). Without these before,
> this Kunpeng HCCS driver did handling of those mappings like several
> other PCC mailbox client drivers.
>
> There were redundant operations, leading to unnecessary code. Maintaining
> the consistency across these driver was harder due to scattered handling
> of shmem.
>
> Just use the mapped shmem and remove all redundant operations from this
> driver.
>
> Cc: Huisong Li <lihuisong@huawei.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
With belows to change,
Reviewed-by: Huisong Li <lihuisong@huawei.com>
> ---
>   drivers/soc/hisilicon/kunpeng_hccs.c | 38 ++++++++++++------------------------
>   drivers/soc/hisilicon/kunpeng_hccs.h |  2 --
>   2 files changed, 13 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
> index 8aa8dec14911cdcdc2a2d11606bf6159144e9489..3b57189cd778f507afaa89bf47f0fa834043c244 100644
> --- a/drivers/soc/hisilicon/kunpeng_hccs.c
> +++ b/drivers/soc/hisilicon/kunpeng_hccs.c
> @@ -167,10 +167,6 @@ static void hccs_pcc_rx_callback(struct mbox_client *cl, void *mssg)
>   
>   static void hccs_unregister_pcc_channel(struct hccs_dev *hdev)
>   {
> -	struct hccs_mbox_client_info *cl_info = &hdev->cl_info;
> -
> -	if (cl_info->pcc_comm_addr)
> -		iounmap(cl_info->pcc_comm_addr);
>   	pcc_mbox_free_channel(hdev->cl_info.pcc_chan);
>   }
>   
> @@ -179,6 +175,7 @@ static int hccs_register_pcc_channel(struct hccs_dev *hdev)
>   	struct hccs_mbox_client_info *cl_info = &hdev->cl_info;
>   	struct mbox_client *cl = &cl_info->client;
>   	struct pcc_mbox_chan *pcc_chan;
> +	struct mbox_chan *mbox_chan;
>   	struct device *dev = hdev->dev;
>   	int rc;
>   
> @@ -196,7 +193,7 @@ static int hccs_register_pcc_channel(struct hccs_dev *hdev)
>   		goto out;
>   	}
>   	cl_info->pcc_chan = pcc_chan;
> -	cl_info->mbox_chan = pcc_chan->mchan;
> +	mbox_chan = pcc_chan->mchan;
>   
>   	/*
>   	 * pcc_chan->latency is just a nominal value. In reality the remote
> @@ -206,34 +203,24 @@ static int hccs_register_pcc_channel(struct hccs_dev *hdev)
>   	cl_info->deadline_us =
>   			HCCS_PCC_CMD_WAIT_RETRIES_NUM * pcc_chan->latency;
>   	if (!hdev->verspec_data->has_txdone_irq &&
> -	    cl_info->mbox_chan->mbox->txdone_irq) {
> +	    mbox_chan->mbox->txdone_irq) {
>   		dev_err(dev, "PCC IRQ in PCCT is enabled.\n");
>   		rc = -EINVAL;
>   		goto err_mbx_channel_free;
>   	} else if (hdev->verspec_data->has_txdone_irq &&
> -		   !cl_info->mbox_chan->mbox->txdone_irq) {
> +		   !mbox_chan->mbox->txdone_irq) {
>   		dev_err(dev, "PCC IRQ in PCCT isn't supported.\n");
>   		rc = -EINVAL;
>   		goto err_mbx_channel_free;
>   	}
>   
> -	if (!pcc_chan->shmem_base_addr ||
> -	    pcc_chan->shmem_size != HCCS_PCC_SHARE_MEM_BYTES) {
> +	if (pcc_chan->shmem_size != HCCS_PCC_SHARE_MEM_BYTES) {
>   		dev_err(dev, "The base address or size (%llu) of PCC communication region is invalid.\n",
>   			pcc_chan->shmem_size);

Now the check of shared base address is not here. The log about this 
address no need to be printed.

Can you help me fix it like:

dev_err(dev, "The base size (%llu) of PCC communication region must be %d Byte.\n",
  			pcc_chan->shmem_size, HCCS_PCC_SHARE_MEM_BYTES
);

>   		rc = -EINVAL;
>   		goto err_mbx_channel_free;
>   	}
>   


