Return-Path: <linux-acpi+bounces-12075-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2BCA5BED1
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 12:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E5C1751E4
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 11:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880DC2528FD;
	Tue, 11 Mar 2025 11:21:42 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6693252913;
	Tue, 11 Mar 2025 11:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741692102; cv=none; b=pVxVAjUprSRVKSZWOiqJqmyA7fNaCH7a14V8mAtQIfbJBzhxhFTdEm4pnUAnIKbPxn05oSBUzUiG8uLAlCkcEvJvKrFC2zHeb6c8p0pP3GmmPLz+0XJzrvwb9btpDWbebaXPplIri8hiN1GbN7w5Wi62W3ZEWafjfyYVHPMknS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741692102; c=relaxed/simple;
	bh=tO9+vFf9dJmvAOiMPYF/nYCN3QITcFpTODxWhhf2Ols=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QZkQONy/F1s2jevjdssoWw8Y+lYa1raSwLBdnZLQyRRX2bqGQP31yITBaKUqHGFvFh8i3WTv1o8E4NeIN2EVD9NMxiRka6qd9H5s3zAkPo0WWcY6J0BkgV413YygIQCNHRCGT60rpsfSE2FI0HfkhO72fHHFFmCU23LuHzNa0lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZBrpM3y6mzvWqV;
	Tue, 11 Mar 2025 19:17:47 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id B331D1401F2;
	Tue, 11 Mar 2025 19:21:37 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Mar 2025 19:21:37 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 11 Mar
 2025 19:21:36 +0800
Message-ID: <4ecf2dd3-dd88-aeb8-c1c3-0322c17438ab@huawei.com>
Date: Tue, 11 Mar 2025 19:21:36 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 05/13] mailbox: pcc: Use acpi_os_ioremap() instead of
 ioremap()
To: Sudeep Holla <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Jassi Brar <jassisinghbrar@gmail.com>, Adam Young
	<admiyo@os.amperecomputing.com>, Robbie King <robbiek@xsightlabs.com>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
 <20250305-pcc_fixes_updates-v2-5-1b1822bc8746@arm.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20250305-pcc_fixes_updates-v2-5-1b1822bc8746@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/3/6 0:38, Sudeep Holla 写道:
> The Platform Communication Channel (PCC) mailbox driver currently uses
> ioremap() to map channel shared memory regions. However it is preferred
> to use acpi_os_ioremap(), which is mapping function specific to EFI/ACPI
> defined memory regions. It ensures that the correct memory attributes
> are applied when mapping ACPI-provided regions.
>
> While at it, also add checks for handling any errors with the mapping.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/mailbox/pcc.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 5a9ae67f5c50a3e43d30aa368c31c80b81db01f7..b1b8223b5da7002fc522523dbc82f6124215439a 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -418,8 +418,12 @@ int pcc_mbox_ioremap(struct mbox_chan *chan)
>   		return -1;
>   	pchan_info = chan->con_priv;
>   	pcc_mbox_chan = &pchan_info->chan;
> -	pcc_mbox_chan->shmem = ioremap(pcc_mbox_chan->shmem_base_addr,
> -				       pcc_mbox_chan->shmem_size);
> +
> +	pcc_mbox_chan->shmem = acpi_os_ioremap(pcc_mbox_chan->shmem_base_addr,
> +					       pcc_mbox_chan->shmem_size);
> +	if (!pcc_mbox_chan->shmem)
> +		return -ENXIO;
> +
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(pcc_mbox_ioremap);
LGTM,
Acked-by: Huisong Li <lihuisong@huawei.com>
Tested-by: Huisong Li <lihuisong@huawei.com>

