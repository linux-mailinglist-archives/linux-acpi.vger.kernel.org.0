Return-Path: <linux-acpi+bounces-13883-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 468A6AC2AAD
	for <lists+linux-acpi@lfdr.de>; Fri, 23 May 2025 22:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591F73A01CC
	for <lists+linux-acpi@lfdr.de>; Fri, 23 May 2025 20:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0096C1993B9;
	Fri, 23 May 2025 20:01:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849F53AC1C;
	Fri, 23 May 2025 20:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748030484; cv=none; b=HUf6C2bCMnddNcOM5b/08kYWfsG6sKfwTGkjh8yZzbwItmCPmx2WDP4bC++A51n2x2TDWiJuycHtAUZBzlVdM7cIpGPX32pTAjWw1KOiwakELqVUuLjJsgbTIk4XcYiM1qCik//VM0uKTHiqkSxlpDbpF0FKz9DBvWmFj3tXshc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748030484; c=relaxed/simple;
	bh=34dqfWtBp6Yko0qKlSwbOVTBh+Tukl6NJLu9DPOn/CI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMcdAhPKU2vSDz+9dSIkQlR03AW6FP2Y4ONGVfJc41ytRIdCFGX4pwO8vy5pkcKykIBRNiVzPpWmPyd7osaObX9IX28SaH/ABPys53UWj/hS46czagNnp7FGQoaGctEecVxuvCP7UJ/QN1S2PexW0XUCkNRRYGf4Ioh6fhCHKYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id A969C43987;
	Fri, 23 May 2025 20:01:17 +0000 (UTC)
Message-ID: <f12632df-927e-4bdd-930e-5724e142af77@ghiti.fr>
Date: Fri, 23 May 2025 22:01:16 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: acpi: Fix platform profile driver on !acpi
 platforms
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Armin Wolf <W_Armin@gmx.de>, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Len Brown <lenb@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>, Arnd Bergmann <arnd@arndb.de>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20250522141410.31315-1-alexghiti@rivosinc.com>
 <91458376-dfc7-46fc-8523-aa176907d703@gmx.de>
 <83e02a52-86ad-45e5-ba87-6c17dc6f59b5@ghiti.fr>
 <CAJZ5v0iPVx0KXB5qQ46iQ7CKG6KJC1CnXogQ=e8or24vZuytrw@mail.gmail.com>
 <CAJZ5v0iwH3p_A=f0g7+EsPbP7KBJS_LbT9+_gXNLBbXqW8vMFg@mail.gmail.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CAJZ5v0iwH3p_A=f0g7+EsPbP7KBJS_LbT9+_gXNLBbXqW8vMFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeljeeiucdltddurdegfedvrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeduffeugedvtdegleeuhfeuteetueegfeefkefhheffvdduhfegvdehuddukeffgeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhinhhfrhgruggvrggurdhorhhgnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemvgeljedvmegutgdumeejvdduugemiedtsgdtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeeffeekvdemvghfledtmegvleejvdemuggtudemjedvudgumeeitdgstddphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemvgeljedvmegutgdumeejvdduugemiedtsgdtngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephggptehrmhhinhesghhmgidru
 ggvpdhrtghpthhtoheprghlvgigghhhihhtihesrhhivhhoshhinhgtrdgtohhmpdhrtghpthhtoheplhgvnhgssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtphhtthhopehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvg
X-GND-Sasl: alex@ghiti.fr

Hi Rafael,

On 5/23/25 16:46, Rafael J. Wysocki wrote:
> On Fri, May 23, 2025 at 12:50 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Fri, May 23, 2025 at 12:11 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>>> On 5/22/25 22:04, Armin Wolf wrote:
>>>> Am 22.05.25 um 16:13 schrieb Alexandre Ghiti:
>>>>
>>>>> The platform profile driver is loaded even on platforms that do not have
>>>>> acpi enabled. The initialization of the sysfs entries was recently moved
>>>>> from platform_profile_register() to the module init call, and those
>>>>> entries need acpi_kobj to be initialized which is not the case when acpi
>>>>> is disabled.
>>>>>
>>>>> This results in the following warning:
>>>>>
>>>>>    WARNING: CPU: 5 PID: 1 at fs/sysfs/group.c:131
>>>>> internal_create_group+0xa22/0xdd8
>>>>>    Modules linked in:
>>>>>    CPU: 5 UID: 0 PID: 1 Comm: swapper/0 Tainted: G W
>>>>> 6.15.0-rc7-dirty #6 PREEMPT
>>>>>    Tainted: [W]=WARN
>>>>>    Hardware name: riscv-virtio,qemu (DT)
>>>>>    epc : internal_create_group+0xa22/0xdd8
>>>>>     ra : internal_create_group+0xa22/0xdd8
>>>>>
>>>>>    Call Trace:
>>>>>
>>>>>    internal_create_group+0xa22/0xdd8
>>>>>    sysfs_create_group+0x22/0x2e
>>>>>    platform_profile_init+0x74/0xb2
>>>>>    do_one_initcall+0x198/0xa9e
>>>>>    kernel_init_freeable+0x6d8/0x780
>>>>>    kernel_init+0x28/0x24c
>>>>>    ret_from_fork+0xe/0x18
>>>>>
>>>>> Fix this by checking if acpi is enabled before trying to create sysfs
>>>>> entries.
>>>> I already submitted a patch for this problem (see
>>>> https://lore.kernel.org/linux-acpi/a6d92cdd-4dc3-4080-9ed9-5b1f02f247e0@gmx.de/T/)
>>>> that only disables the legacy sysfs interface while keeping the
>>>> class-based interface functional
>>>> as it does not depend on ACPI at all.
>>>
>>> Great, I understand if your patchset is not merged for rc1 but it would
>>> be nice to have it merged in 6.16 though to fix riscv syzkaller
>>> instance. Perhaps you could add the Fixes tag that Arnd mentioned too?
>> I actually prefer your patch to the Armin's one because there are
>> questions regarding the latter (see the most recent message from Arnd
>> in this thread).
> And so it has been applied as 6.16 material now, thanks!


Thank you very much!

Alex


>
>>>>> Fixes: 77be5cacb2c2 ("ACPI: platform_profile: Create class for ACPI
>>>>> platform profile")
>>>>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>>>>> ---
>>>>>    drivers/acpi/platform_profile.c | 3 +++
>>>>>    1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/drivers/acpi/platform_profile.c
>>>>> b/drivers/acpi/platform_profile.c
>>>>> index ffbfd32f4cf1..b43f4459a4f6 100644
>>>>> --- a/drivers/acpi/platform_profile.c
>>>>> +++ b/drivers/acpi/platform_profile.c
>>>>> @@ -688,6 +688,9 @@ static int __init platform_profile_init(void)
>>>>>    {
>>>>>        int err;
>>>>>    +    if (acpi_disabled)
>>>>> +        return -EOPNOTSUPP;
>>>>> +
>>>>>        err = class_register(&platform_profile_class);
>>>>>        if (err)
>>>>>            return err;
>>>> _______________________________________________
>>>> linux-riscv mailing list
>>>> linux-riscv@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

