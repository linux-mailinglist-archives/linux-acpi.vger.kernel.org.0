Return-Path: <linux-acpi+bounces-19545-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DA0CB4A49
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Dec 2025 04:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 23BCB30012C6
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Dec 2025 03:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A061422A4CC;
	Thu, 11 Dec 2025 03:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="KHHTfEa4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA29E13A88C;
	Thu, 11 Dec 2025 03:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765424663; cv=none; b=Zw8D5GyrsYih7qUH4vJ7k6LfRcF6Oye/y02GC8ig9hiBSUIMas+/dBlJaVcJlv1H0AUJGNKo2APlhLT3CQ+wlmchqTQXy4dNQyRHnhHz0K9LOAZh/O19qO+eXh/u8T3WMqy6TK0C91ghUaKlyVcOWcMBSebOBiMMSEwJNo/XPNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765424663; c=relaxed/simple;
	bh=Vn+8po3O60AnsxbI89zAz9P0AlWBmc0QKjxdgSCt76U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NzDOLL+yvx57aPlhBH2aHzWca2tqvHFq95I2C9Uq9Ox/wx4vzMoqQTsXkAlA9fhJyYy/w16XZQfED/0alwzzBW0wr5lzPrZnP5uD0XZlqOUnm0x9HtOJbK5YCJ+Lm039ycLXtnCTdj2hNZb3rcGuE9ZtZfo6owzsi/gSL8rTF3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=KHHTfEa4; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=74ewB5cduIA6X19k9ZUQ+8OExhYwha+qeGIwSlWnBtU=;
	b=KHHTfEa4NjNih0tCOyqNpIMOLF4RU1kuCGOdU8NMvMvjFESlsajvAI35iEku+ijwEkzdMiMeD
	x+uZQgP9Y+FtbldUwVuJeqggdxOUTLny1dwxXy7D/CwG2gNZEgPc2P16JD3mfwkQVPmGAQKDd2r
	Vf81+ooOCpwd2TJu9Z/+lOQ=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dRdgj2GCzz1T4JP;
	Thu, 11 Dec 2025 11:42:09 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id AA23C180BD3;
	Thu, 11 Dec 2025 11:44:12 +0800 (CST)
Received: from [10.67.121.62] (10.67.121.62) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 11 Dec
 2025 11:44:11 +0800
Message-ID: <5e37b804-f91e-4f90-b0de-2d837257765b@huawei.com>
Date: Thu, 11 Dec 2025 11:44:11 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: PCC: Fix race condition by removing static
 qualifier
To: Sudeep Holla <sudeep.holla@arm.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <lihuisong@huawei.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<linhongye@h-partners.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <wangzhi12@huawei.com>
References: <20251210132634.2050033-1-zhangpengjie2@huawei.com>
 <20251210-valiant-watchful-guillemot-2bb5be@sudeepholla>
From: "zhangpengjie (A)" <zhangpengjie2@huawei.com>
In-Reply-To: <20251210-valiant-watchful-guillemot-2bb5be@sudeepholla>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr200004.china.huawei.com (7.202.195.241)


On 12/10/2025 10:54 PM, Sudeep Holla wrote:
> On Wed, Dec 10, 2025 at 09:26:34PM +0800, Pengjie Zhang wrote:
>> The variable 'ret' in acpi_pcc_address_space_setup() is currently
>> declared with the 'static' storage specifier. This can lead to race
>> conditions in a multithreaded environment.
>>
>> Remove the 'static' qualifier to ensure 'ret' is allocated directly
>> on the stack as a local variable.
>>
Hi, I'm lucky that I didn't run into any problems because of this, I 
just found

this issue during code review.

> Ah, my mistake. I’m not sure how that slipped in other than a simple typo or
> copy/paste error. Thanks for catching it. Let me know if you spotted it
> because something broke or just from reading the code.
>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>
>> Fixes: a10b1c99e2dc ("ACPI: PCC: Setup PCC Opregion handler only if platform interrupt is available")
>> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
>> ---
>>   drivers/acpi/acpi_pcc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
>> index 97064e943768..e3f302b9dee5 100644
>> --- a/drivers/acpi/acpi_pcc.c
>> +++ b/drivers/acpi/acpi_pcc.c
>> @@ -52,7 +52,7 @@ acpi_pcc_address_space_setup(acpi_handle region_handle, u32 function,
>>   	struct pcc_data *data;
>>   	struct acpi_pcc_info *ctx = handler_context;
>>   	struct pcc_mbox_chan *pcc_chan;
>> -	static acpi_status ret;
>> +	acpi_status ret;
>>   
>>   	data = kzalloc(sizeof(*data), GFP_KERNEL);
>>   	if (!data)
>> -- 
>> 2.33.0
>>

