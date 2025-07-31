Return-Path: <linux-acpi+bounces-15452-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B290AB176CE
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Jul 2025 21:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC051AA2C27
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Jul 2025 19:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3F324DCF9;
	Thu, 31 Jul 2025 19:51:58 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150B315533F
	for <linux-acpi@vger.kernel.org>; Thu, 31 Jul 2025 19:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753991518; cv=none; b=J/9aO0ukTjHUjrAwkTrNAmkm74//88U2fiDX1oMKA9yUzlao6nQ8hiJMBAnQR3HCxREregfy58OXESJ1AV1QWkDhVKbNscUpdYgWbYjGPqFTu8QeEzHxblBoYR2+0DmhIRzcL9JqR+Lxdz8kPqxSG3tCD5He/24b+GfTEd8J/PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753991518; c=relaxed/simple;
	bh=Z+a3RHDb5JzP6HJuLHT2EmwoRymDq46NvLJnpXVl4jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gJDf0gPXlKleDJwnQB9Xj+bg42b1GlMSivSLwKeNuSyubdvvfTXUjcj/rGeiBBplHlZljD15VA0FF2CmbKPin1ag7DrHOV6gwA/Qrs67zuKeGq//6b2KiJ5yoDFTuqcjYk8DBk7yDUYd6cyuYIEE6KZFlt1BirBKWLKEY15DHBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5DC53441BF;
	Thu, 31 Jul 2025 19:51:50 +0000 (UTC)
Message-ID: <8b933393-e9cf-4192-9e69-ef5c2a699c5b@ghiti.fr>
Date: Thu, 31 Jul 2025 21:51:48 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ACPI: support BGRT table on RISC-V
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, kernel@vger.kernel.org,
 Yunhui Cui <cuiyunhui@bytedance.com>, linux-acpi@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-riscv@lists.infradead.org,
 Len Brown <lenb@kernel.org>
References: <20250729131535.522205-1-heinrich.schuchardt@canonical.com>
 <20250729131535.522205-3-heinrich.schuchardt@canonical.com>
 <84a22949-88e7-4a6c-b14e-e8448724b034@ghiti.fr>
 <CAJZ5v0hvaw=m8zPDJn0vPvw5RBxUsRzyvjHPiganPkxHGCisRw@mail.gmail.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CAJZ5v0hvaw=m8zPDJn0vPvw5RBxUsRzyvjHPiganPkxHGCisRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddujedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeeuffefvdelteelteejhfejhedujeetteevtddvvddthfeiteffledvffeggfeiieenucffohhmrghinhepihhnfhhrrgguvggrugdrohhrghenucfkphepvddttddumeekiedumeeffeekvdemvghfledtmeeftdehfeemjegrtdgvmeeifhhfgeemiedvsggvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeeffeekvdemvghfledtmeeftdehfeemjegrtdgvmeeifhhfgeemiedvsggvpdhhvghloheplgfkrfggieemvddttddumeekiedumeeffeekvdemvghfledtmeeftdehfeemjegrtdgvmeeifhhfgeemiedvsggvngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopedufedprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgvihhnrhhitghhrdhstghhuhgthhgrrhguthestggrnhhonhhitggrlhdrt
 ghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtoheprhihrghnrdhrohgsvghrthhssegrrhhmrdgtohhmpdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphhtthhopehkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: alex@ghiti.fr

On 7/31/25 20:17, Rafael J. Wysocki wrote:
> On Thu, Jul 31, 2025 at 3:13 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>> Hi Heinrich,
>>
>> On 7/29/25 15:15, Heinrich Schuchardt wrote:
>>> The BGRT table is used to display a vendor logo in the boot process.
>>> There is no good reason why RISC-V should not support it.
>>>
>>> Remove the architecture constraint.
>>>
>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>> ---
>>>    drivers/acpi/Kconfig | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>>> index 7bc40c2735ac0..2b83c91bb1a78 100644
>>> --- a/drivers/acpi/Kconfig
>>> +++ b/drivers/acpi/Kconfig
>>> @@ -460,7 +460,7 @@ config ACPI_HED
>>>
>>>    config ACPI_BGRT
>>>        bool "Boottime Graphics Resource Table support"
>>> -     depends on EFI && (X86 || ARM64 || LOONGARCH)
>>> +     depends on EFI
>>>        help
>>>          This driver adds support for exposing the ACPI Boottime Graphics
>>>          Resource Table, which allows the operating system to obtain
>>
>> @Rafael: If you ack this patch, I can merge that for 6.17 as I haven't
>> sent my PR yet, just let me know!
> There you go:
>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>


Great, thanks!


>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

