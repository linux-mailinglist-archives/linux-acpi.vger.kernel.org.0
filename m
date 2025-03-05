Return-Path: <linux-acpi+bounces-11820-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFF8A4F5DD
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 05:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 789263A4CCC
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 04:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4AF19ADBA;
	Wed,  5 Mar 2025 04:02:20 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87B519AD93;
	Wed,  5 Mar 2025 04:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741147340; cv=none; b=pyx9aDe/YuZP8sPpPZ5cLp3kHQhG5rRMWaa5ervSNlD3YWbai3+IsJ6BnTNxRLXdQZIIHFanCtJB3IHeI6BgewgxWBt+XaHYARD0dmR1ua7VOfgy1oWgYtxwB0F6KUz4AJD3EXBSN7MItVx+maTeGKXCK/hPKiLN191JcyZD1Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741147340; c=relaxed/simple;
	bh=4QSPvye2m6JGTxee35imGkvl12PlADPECYxuczPCgBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MvPTi41egQHwHtv82ETbK8Zvhveks7cYObOooVxsDVH0uZR+5imZWAofI+pgFLAdol0IBXqDsD4QBKRUlpI2FuxMwoMy6gZL2OqUQ3fOqaUQ4T2SNa240qxAS+NxEAwJkToTh3TIhZMvvKwuMnktvEcaPS40MwGc0mP8QeaKL5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Z6zLz0Rq3z21mx6;
	Wed,  5 Mar 2025 11:59:07 +0800 (CST)
Received: from dggemv704-chm.china.huawei.com (unknown [10.3.19.47])
	by mail.maildlp.com (Postfix) with ESMTPS id A30D51A0188;
	Wed,  5 Mar 2025 12:02:14 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Mar 2025 12:02:14 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 5 Mar
 2025 12:02:13 +0800
Message-ID: <5093286f-1db6-bab2-920d-71fe274ad251@huawei.com>
Date: Wed, 5 Mar 2025 12:02:13 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 03/14] mailbox: pcc: Drop unnecessary endianness
 conversion of pcc_hdr.flags
To: Sudeep Holla <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Jassi Brar <jassisinghbrar@gmail.com>, Adam Young
	<admiyo@os.amperecomputing.com>
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
 <20250303-pcc_fixes_updates-v1-3-3b44f3d134b1@arm.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20250303-pcc_fixes_updates-v1-3-3b44f3d134b1@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/3/3 18:51, Sudeep Holla 写道:
> The Sparse static checker flags a type mismatch warning related to
> endianness conversion:
>
>    |  warning: incorrect type in argument 1 (different base types)
>    |     expected restricted __le32 const [usertype] *p
>    |     got unsigned int *
>
> This is because an explicit endianness conversion (le32_to_cpu()) was
> applied unnecessarily to a pcc_hdr.flags field that is already in
> little-endian format.
>
> The PCC driver is only enabled on little-endian kernels due to its
> dependency on ACPI and EFI, making the explicit conversion unnecessary.
How to confirm ACPI works only on little-endian?
>
> The redundant conversion occurs in pcc_chan_check_and_ack() for the
> pcc_hdr.flags field. Drop this unnecessary endianness conversion of
> pcc_hdr.flags.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/mailbox/pcc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 4c582fa2b8bf4c9a9368dba8220f567555dba963..c87a5b7fa6eaf7bcabe0d55f844961c499376938 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -292,7 +292,7 @@ static void check_and_ack(struct pcc_chan_info *pchan, struct mbox_chan *chan)
>   	 *
>   	 * The PCC master subspace channel clears chan_in_use to free channel.
>   	 */
> -	if (le32_to_cpup(&pcc_hdr.flags) & PCC_ACK_FLAG_MASK)
> +	if (pcc_hdr.flags & PCC_ACK_FLAG_MASK)
It's recommanded to delete PCC_ACK_FLAG_MASK and use 
PCC_CMD_COMPLETION_NOTIFY.
They are from the same place, namely, 'Initiator Responder 
Communications Channel Flags'.
>   		pcc_send_data(chan, NULL);
>   	else
>   		pcc_chan_reg_read_modify_write(&pchan->cmd_update);
>

