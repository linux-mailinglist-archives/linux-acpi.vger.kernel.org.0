Return-Path: <linux-acpi+bounces-12073-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4716DA5BEC6
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 12:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80ECF7A722A
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 11:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DE0251790;
	Tue, 11 Mar 2025 11:20:03 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C86529A1;
	Tue, 11 Mar 2025 11:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741692003; cv=none; b=EThsmYmMsJCBQ+HJQaN3BSam8EsyVnXwVc61s9co2/6wcqzdj02vA4TEljVNytqQqhYvZmM7h0c+J0qUHOfQnOIPbbChjHs+hLcHm01pMsX+nrQiq6/UlkcD3nNQSzmXRzMWfmi+BIWftNdS+o1I/i+0576K6fbKibHDYQFDCgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741692003; c=relaxed/simple;
	bh=JOceSiTGaS54vSsatPEdT3xp5lbUodd1csD+RBL/RfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MoIRLZ42IIK7U5KI9ZApiGZMdbWmwcOe512U+GDtRfZBBZgaSOEEUcnx4q9/EoDU/kLwPBM5kD+iQKY0RK2bdObps+W0NHnMq/nptmh06vlgShJd9ljMPV0JBaC9/XNkj0E1D6yVG1Sm64QSLkthGGpPLUEqrl1on30lO+FnsUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZBrmR529mzvWpX;
	Tue, 11 Mar 2025 19:16:07 +0800 (CST)
Received: from dggemv703-chm.china.huawei.com (unknown [10.3.19.46])
	by mail.maildlp.com (Postfix) with ESMTPS id DACEC180080;
	Tue, 11 Mar 2025 19:19:57 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Mar 2025 19:19:57 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 11 Mar
 2025 19:19:57 +0800
Message-ID: <f4142049-932e-2572-b199-6ba303b6d406@huawei.com>
Date: Tue, 11 Mar 2025 19:19:56 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 03/13] mailbox: pcc: Drop unnecessary endianness
 conversion of pcc_hdr.flags
To: Sudeep Holla <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Jassi Brar <jassisinghbrar@gmail.com>, Adam Young
	<admiyo@os.amperecomputing.com>, Robbie King <robbiek@xsightlabs.com>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
 <20250305-pcc_fixes_updates-v2-3-1b1822bc8746@arm.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20250305-pcc_fixes_updates-v2-3-1b1822bc8746@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/3/6 0:38, Sudeep Holla 写道:
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
>
> The redundant conversion occurs in pcc_chan_check_and_ack() for the
> pcc_hdr.flags field. Drop this unnecessary endianness conversion of
> pcc_hdr.flags.
>
> Also drop the redundant PCC_ACK_FLAG_MASK definition and use the
> more appropriate and already defined PCC_CMD_COMPLETION_NOTIFY.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/mailbox/pcc.c | 2 +-
>   include/acpi/pcc.h    | 1 -
>   2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 4c582fa2b8bf4c9a9368dba8220f567555dba963..42dd405482e407cf90e66917a46fb8e350e0eeaf 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -292,7 +292,7 @@ static void check_and_ack(struct pcc_chan_info *pchan, struct mbox_chan *chan)
>   	 *
>   	 * The PCC master subspace channel clears chan_in_use to free channel.
>   	 */
> -	if (le32_to_cpup(&pcc_hdr.flags) & PCC_ACK_FLAG_MASK)
> +	if (pcc_hdr.flags & PCC_CMD_COMPLETION_NOTIFY)
>   		pcc_send_data(chan, NULL);
>   	else
>   		pcc_chan_reg_read_modify_write(&pchan->cmd_update);
> diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
> index 699c1a37b8e7846362bae35477eb5736be15d79e..d1e506f041c5a80857d4a025fa3c1803746ba4b9 100644
> --- a/include/acpi/pcc.h
> +++ b/include/acpi/pcc.h
> @@ -32,7 +32,6 @@ struct pcc_mbox_chan {
>   #define PCC_CMD_COMPLETION_NOTIFY	BIT(0)
>   
>   #define MAX_PCC_SUBSPACES	256
> -#define PCC_ACK_FLAG_MASK	0x1
>   
>   #ifdef CONFIG_PCC
>   extern struct pcc_mbox_chan *
Acked-by: Huisong Li <lihuisong@huawei.com>
>

