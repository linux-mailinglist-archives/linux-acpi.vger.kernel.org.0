Return-Path: <linux-acpi+bounces-13855-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D726AC20AB
	for <lists+linux-acpi@lfdr.de>; Fri, 23 May 2025 12:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1C0F189C2AA
	for <lists+linux-acpi@lfdr.de>; Fri, 23 May 2025 10:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A2A227EA8;
	Fri, 23 May 2025 10:11:48 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34B822759C;
	Fri, 23 May 2025 10:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747995108; cv=none; b=bDch+fBTWVd8/fVr1V++2Xfi+CSCiJiJQCdPSgwySuQgYQ1zsHl5Wr8ySjGwTiBPGQ6rRBwX1Ul32B+JO/TkJxrPiAKE6ihJ0/VzwzhIdVXZy5OVWZSaxUjaStCE6/90aIr0HqsNN8hC1zk4FJbZVk7iCLokAMfDdHORzvEn5ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747995108; c=relaxed/simple;
	bh=LKDan4cRsFY8Z0xYaTip9q2QYSWjgajaVDt3pXOPDZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=skZEGNsjHI3ZeSSFVt5Hury7uB3Mm2tw0CeBWeOzYuL0cFAxiEY4SKqMNPtDHP1o1COa1CXZaxRgJShygvXUZ90RisqBjqKPtkwJemvJGEqh9Co5d5hOOpfApSob2zJkemm6JXHk9WIf0d1C4QASm0o9Y52ATucDvBZunbz0MGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8D03D439F0;
	Fri, 23 May 2025 10:11:42 +0000 (UTC)
Message-ID: <83e02a52-86ad-45e5-ba87-6c17dc6f59b5@ghiti.fr>
Date: Fri, 23 May 2025 12:11:42 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: acpi: Fix platform profile driver on !acpi
 platforms
To: Armin Wolf <W_Armin@gmx.de>, Alexandre Ghiti <alexghiti@rivosinc.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>, Arnd Bergmann <arnd@arndb.de>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20250522141410.31315-1-alexghiti@rivosinc.com>
 <91458376-dfc7-46fc-8523-aa176907d703@gmx.de>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <91458376-dfc7-46fc-8523-aa176907d703@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdekheekucdltddurdegfedvrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhepheevhfevteehhefhueekiedtheeuvdfgieetteetudffgeegieegieeitdevgeelnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpihhnfhhrrgguvggrugdrohhrghenucfkphepvddttddumeekiedumeeffeekvdemvghfledtmegvleejvdemuggtudemjedvudgumeeitdgstdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemvgeljedvmegutgdumeejvdduugemiedtsgdtpdhhvghloheplgfkrfggieemvddttddumeekiedumeeffeekvdemvghfledtmegvleejvdemuggtudemjedvudgumeeitdgstdgnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepuddupdhrtghpthhtohephggptehrmhhinhesghhmgidruggvpdhrtghpthhtoheprghlvgigghhhihhtihesrhhivhhoshhin
 hgtrdgtohhmpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvghnsgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhlphhordhjrghrvhhinhgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehmrghrihhordhlihhmohhntghivghllhhosegrmhgurdgtohhmpdhrtghpthhtohepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggv
X-GND-Sasl: alex@ghiti.fr

On 5/22/25 22:04, Armin Wolf wrote:
> Am 22.05.25 um 16:13 schrieb Alexandre Ghiti:
>
>> The platform profile driver is loaded even on platforms that do not have
>> acpi enabled. The initialization of the sysfs entries was recently moved
>> from platform_profile_register() to the module init call, and those
>> entries need acpi_kobj to be initialized which is not the case when acpi
>> is disabled.
>>
>> This results in the following warning:
>>
>>   WARNING: CPU: 5 PID: 1 at fs/sysfs/group.c:131 
>> internal_create_group+0xa22/0xdd8
>>   Modules linked in:
>>   CPU: 5 UID: 0 PID: 1 Comm: swapper/0 Tainted: G W           
>> 6.15.0-rc7-dirty #6 PREEMPT
>>   Tainted: [W]=WARN
>>   Hardware name: riscv-virtio,qemu (DT)
>>   epc : internal_create_group+0xa22/0xdd8
>>    ra : internal_create_group+0xa22/0xdd8
>>
>>   Call Trace:
>>
>>   internal_create_group+0xa22/0xdd8
>>   sysfs_create_group+0x22/0x2e
>>   platform_profile_init+0x74/0xb2
>>   do_one_initcall+0x198/0xa9e
>>   kernel_init_freeable+0x6d8/0x780
>>   kernel_init+0x28/0x24c
>>   ret_from_fork+0xe/0x18
>>
>> Fix this by checking if acpi is enabled before trying to create sysfs
>> entries.
>
> I already submitted a patch for this problem (see 
> https://lore.kernel.org/linux-acpi/a6d92cdd-4dc3-4080-9ed9-5b1f02f247e0@gmx.de/T/)
> that only disables the legacy sysfs interface while keeping the 
> class-based interface functional
> as it does not depend on ACPI at all.


Great, I understand if your patchset is not merged for rc1 but it would 
be nice to have it merged in 6.16 though to fix riscv syzkaller 
instance. Perhaps you could add the Fixes tag that Arnd mentioned too?

Thanks,

Alex


>
> Thank,
> Armin Wolf
>
>> Fixes: 77be5cacb2c2 ("ACPI: platform_profile: Create class for ACPI 
>> platform profile")
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> ---
>>   drivers/acpi/platform_profile.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/acpi/platform_profile.c 
>> b/drivers/acpi/platform_profile.c
>> index ffbfd32f4cf1..b43f4459a4f6 100644
>> --- a/drivers/acpi/platform_profile.c
>> +++ b/drivers/acpi/platform_profile.c
>> @@ -688,6 +688,9 @@ static int __init platform_profile_init(void)
>>   {
>>       int err;
>>   +    if (acpi_disabled)
>> +        return -EOPNOTSUPP;
>> +
>>       err = class_register(&platform_profile_class);
>>       if (err)
>>           return err;
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

