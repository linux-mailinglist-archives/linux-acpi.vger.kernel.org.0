Return-Path: <linux-acpi+bounces-19939-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2517CCF0CBC
	for <lists+linux-acpi@lfdr.de>; Sun, 04 Jan 2026 10:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF8C83009AB6
	for <lists+linux-acpi@lfdr.de>; Sun,  4 Jan 2026 09:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EB622CBD9;
	Sun,  4 Jan 2026 09:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="QZ85hFWi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDF718BC3B;
	Sun,  4 Jan 2026 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767520663; cv=none; b=HVr4ITSSrcaxWkXfRhvD6bxByFiQSiPKwnsbt/ZU52dQT0bAF4glwNd6XmEUx/NydMSp+Ufpdv/xEwT2a1sVf6wNQ7FDylJ2uF5Llb1IxGR/CwUVpwEkcdJkwNx7SViEFHDsqlst7sqT2K3aKAJdr5IluOcq/r9wxRph2fOrxjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767520663; c=relaxed/simple;
	bh=aZZX63cZ1NGGKmSLQH5v1AK/l1Jj4FL2p6IK3ik99gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uQONdmqQbeKyBjokkDj7uamMkI3dlq2LwKhj+36zfma95eD9BrRRVmkY6p/pnxjSf0aoOoEK5NH2ipfW9aPpTiVILmKZR6DjyocxYHUt5XjK3vPnErRXnx0FwZsiCDjTq92QOm+qTAuS1XSDMvHmbvz3kJHBCRJWiOI8186NqzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=QZ85hFWi; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=skgc0cfLoaid7wuVwKK3Ta1wurBdAZ2XIUELxPuuxiQ=;
	b=QZ85hFWicTB+dZNFHAYsSBoFe2vEsnwu+8Ph89UNQq3OMyYsThCgBl1xpQhVjCOEtbZoSUX/+
	spVb1/nXaXRUc8FdQiQ/d0nx3wI3cmJgBRbK4Jh05hbkqV8d46Hj65YG2ZoxvhH6B4HIU9vqdmi
	lpkAzmki7Jb9LyXwVX0aTks=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dkXpF4mlFznTZK;
	Sun,  4 Jan 2026 17:54:29 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id AA1FE4056C;
	Sun,  4 Jan 2026 17:57:35 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 4 Jan 2026 17:57:35 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Sun, 4 Jan
 2026 17:57:34 +0800
Message-ID: <2fdf9111-3cdd-44ec-959a-1dc2054dfc84@huawei.com>
Date: Sun, 4 Jan 2026 17:57:34 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/6] ACPI: processor: Recovery some reverted patches
To: Borislav Petkov <bp@alien8.de>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <AmandeepKaur.Longia@amd.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<prime.zeng@hisilicon.com>
References: <20251223100914.2407069-1-lihuisong@huawei.com>
 <20251224020532.GAaUtKbE7vA4ian0LU@renoirsky.local>
 <20260102101801.GAaVebWWUMQyFs_vHI@fat_crate.local>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260102101801.GAaVebWWUMQyFs_vHI@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2026/1/2 18:18, Borislav Petkov 写道:
> On Wed, Dec 24, 2025 at 03:05:32AM +0100, Borislav Petkov wrote:
>> On Tue, Dec 23, 2025 at 06:09:08PM +0800, Huisong Li wrote:
>>> Huisong Li (4):
>>>    ACPI: processor: idle: Optimize ACPI idle driver registration
>>>    ACPI: processor: Remove unused empty stubs of some functions
>>>    ACPI: processor: idle: Rearrange declarations in header file
>>>    ACPI: processor: Do not expose global variable acpi_idle_driver
>>>
>>> Rafael J. Wysocki (2):
>>>    ACPI: processor: Update cpuidle driver check in
>>>      __acpi_processor_start()
>>>    ACPI: processor: idle: Redefine two functions as void
>>>
>>>   drivers/acpi/processor_driver.c |  13 +++-
>>>   drivers/acpi/processor_idle.c   | 116 +++++++++++++++++++-------------
>>>   include/acpi/processor.h        |  34 ++--------
>>>   3 files changed, 86 insertions(+), 77 deletions(-)
>> I'll run them on the affected machine once I get to it.
> Looks good.
>
> Tested-by: Borislav Petkov (AMD) <bp@alien8.de>
>
Apologize for the crash issue on your platform.
Thank you very much for your test, Borisla.

/Huisong
>

