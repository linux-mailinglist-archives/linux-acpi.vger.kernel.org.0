Return-Path: <linux-acpi+bounces-17961-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA74BEF3AA
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 06:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600623AB565
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 04:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1A317C77;
	Mon, 20 Oct 2025 04:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="GbzV8td/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348598460;
	Mon, 20 Oct 2025 04:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760933752; cv=none; b=pAHLmNtIFcfvxsOMyKH9YXDNvZTwrhvNBHG/FdzwHLy7DRAqhuQKp68L3ogaQbShJUMOSlsi5dKxoxKYgBnPFQbhQ7fX9EtbzbSFV+WEivhAcitvyZGEktiDwxoYFJPe2NIWZkFpFLkr+9nP5+EpscO4uCfgeayt/0bv/3M4VDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760933752; c=relaxed/simple;
	bh=JtO8PeCa2PKlgR0i89nAa+GKUcEDAU/+N45DOg5MU/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cFO+EnFTrP84Yu9Q3ZJLT/TMFi5fWcm378dtuE6j/aw0/GZ06arypWgwkzNKDsn9f/NIzUe5Ne2MRmGphgRTBMcP4mRcPFwZbth/yToD4nbfg+zxiadQv6KiFK74CCgHuk09+8O7IhJi6+nkPKLMuKj/LIr6CmbWlKnZ7qGAylw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=GbzV8td/; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4bztEUw24D7GJwcXXrpnWAsggCfD+kMyHqNEIvLAwyI=;
	b=GbzV8td/lb81gfw2C64wmVNB3qfpNKyPqwdi8uCBsvm6F/Ua4jDhDqTTgFl3aCyFCsIYBgCAT
	+4rjNeDZnmgSPMKzD7R49u2xcvjl8N70gkatsBh1ZIdPGdJu8g9VTIClkS4su3tBsr1yILxmWNz
	QrV1gS7kUNCGzFNvUdpg6+M=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4cqhsx4KkJz1K97v;
	Mon, 20 Oct 2025 12:15:17 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 270FD1A016C;
	Mon, 20 Oct 2025 12:15:40 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Oct 2025 12:15:39 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 20 Oct
 2025 12:15:39 +0800
Message-ID: <ceb9f28b-c935-476b-bd67-a5a9da9989f6@huawei.com>
Date: Mon, 20 Oct 2025 12:15:38 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] mailbox: pcc: Initialize SHMEM before binding the
 channel with the client
To: Sudeep Holla <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Adam Young <admiyo@os.amperecomputing.com>, Robbie King
	<robbiek@xsightlabs.com>, Jassi Brar <jassisinghbrar@gmail.com>, "Cristian
 Marussi" <cristian.marussi@arm.com>
References: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
 <20251016-pcc_mb_updates-v1-5-0fba69616f69@arm.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20251016-pcc_mb_updates-v1-5-0fba69616f69@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/10/17 3:08, Sudeep Holla 写道:
> The PCC channel's shared memory region must be set up before the
> mailbox controller binds the channel with the client, as the binding
> process may trigger client operations like startup() that may rely on
> SHMEM being initialized.
>
> Reorder the setup sequence to ensure the shared memory is ready before
> binding. Initialize and map the PCC shared memory (SHMEM) prior to
> calling mbox_bind_client() so that clients never observe an uninitialized
> or NULL SHMEM during bind-time callbacks or early use in startup().
>
> This makes the PCC mailbox channel bring-up order consistent and
> eliminates a race between SHMEM setup and client binding.

I don't think this race exists. The above reason is enough.

This patch should be for patch 6/6, right?

>
> This will be needed in channel startup to clear/acknowledge any pending
> interrupts before enabling them.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: lihuisong@huawei.com
> ---
>   drivers/mailbox/pcc.c | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 33bd2d05704b..2829ec51b47f 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -378,18 +378,20 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)

>

