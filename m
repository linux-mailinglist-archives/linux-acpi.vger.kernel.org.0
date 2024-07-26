Return-Path: <linux-acpi+bounces-7074-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B56993D849
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jul 2024 20:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F08E1C21CB8
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jul 2024 18:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E4F38DEE;
	Fri, 26 Jul 2024 18:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpI/vBzo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DBA38385
	for <linux-acpi@vger.kernel.org>; Fri, 26 Jul 2024 18:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722018243; cv=none; b=XfklsVk5FQzRaexy2LMnTGEy91dGQ+GMV2tkDdPS4Mni/vGARYhVJaVP3toMS2zEVJutCKPwxAwsCaZGMuBvv8gow72tMIrhxwGPI4k8zJ8bYMFt/3gFzTKZ7SvpFxH/FjmxKHIWJuFBGj0GuIv+FLz0Jdt8lYF2f/BXRsw65fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722018243; c=relaxed/simple;
	bh=ws28o8ILsysCfd14HwiUJn5G1gWztMVRd+qEdPZqi68=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=k0IEFI3fJeTdA20Mrr2CvAwCa0k7hayy9wSuL3xYKgfk/EbWfTZH2nabI2alamRV2lgJuffNP4qA7jScH2QkROE+YKBnkdRLg2v/5AFsHfSmZ+ggpHhn6l7oImZpOBNAgvEigjg2yDdJnqkzSSqVXZ5HDZlkFy8LXDLwHWILDKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpI/vBzo; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fee6435a34so8295065ad.0
        for <linux-acpi@vger.kernel.org>; Fri, 26 Jul 2024 11:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722018242; x=1722623042; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THBvAPKKoZ+vsoz9t6UaOmfjXawep1fZfGgaZL/1yYE=;
        b=RpI/vBzokvOHd0lvZEeV0FCMqxRHIS42LYoLSrHuwe7T0TjBoHvQfBAMFQaslQc0s5
         gzPLjMk61vI3y+6MDXxQ29s1ZXGxRU1tYW9dn9p53YQF2Ynmv4LuPbRSaPtk2z6TA9M9
         cYgQA6GHSEi/2n/vuLe5Tq9PLTgixdJQNWz52wtVTyuxCHokxe7sDuajj9AbVvpu3lCk
         /V3SORfwNVQRoRsHDFQAbA4Bc6RlkCx8kqzl/oIo8oJfdnaX2Uw+Ue0vtSgaMMg7DUmT
         ELD/2cXqP2aXwfh6kKktix8zUeMSoDUkZ9oTHf+IszOnXHhEunVgWdAFtOax0Wka2v85
         BFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722018242; x=1722623042;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THBvAPKKoZ+vsoz9t6UaOmfjXawep1fZfGgaZL/1yYE=;
        b=P2TBjkH3xi/xtjFIEbKi4sKXjCcsX40rhrFOd5dKxVxi3930e7tLqIIUstHKXM/JQz
         OHxcmfc4667DhfqRJMo6XIz8z1vGFrkxQlwW3c4iqFm/qYxtpj3+WOrLHjVz/+STYkz1
         x6bBqhxJa9LceE8YqXMpsuDFdPaXuZn7KRiXy7zl84pMuOqCZNYKKEYeAWGeCFF2GnIK
         5mudhtDmz3LShCoiq3HJVdjISZucLmqYofIT4v1c+aGoAwUPJW1Qf74ZEBSay1QeYgiD
         xaRHDqoQQxhavIi40vINO2e+4HJBah12oofQpZMj4SYcYcf8KSxuuy2bFuyDCAK38Mxp
         S0Vw==
X-Forwarded-Encrypted: i=1; AJvYcCW/aYI9TLemt2t10D+zPHiph4vsnfpbK1nRYTGs1HBa7QxynJ6/0Db/Etb/Z+X8Cdme21uzP3HWUYcN2h2aNwVK+RM0K4niP7FMpQ==
X-Gm-Message-State: AOJu0Yw3vi+Oc1oXXd+VBAVGcROsYAJ5W/RVS3yRi/SQ7zRMcu3Ah/WA
	dDrYADQ3FRCgRI9cyQN7SXgXn2fL61dGNuS1hDopluYlX+dBbyEh
X-Google-Smtp-Source: AGHT+IHIPspasYIEYYItlIVyGSxQu8fkWzwR8pfaH7cv/7C7zYCW1M75JsV//f8iDk+nBqj4XS/NmQ==
X-Received: by 2002:a17:902:db06:b0:1fd:6529:7447 with SMTP id d9443c01a7336-1ff0485b001mr5731535ad.29.1722018241381;
        Fri, 26 Jul 2024 11:24:01 -0700 (PDT)
Received: from smtpclient.apple (va133-130-115-230-f.a04e.g.tyo1.static.cnode.io. [2400:8500:1301:747:a133:130:115:230f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f1aa18sm36051745ad.190.2024.07.26.11.23.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2024 11:24:00 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] ACPI: rename acpi_arm_init to acpi_arch_init
From: Miao Wang <shankerwangmiao@gmail.com>
In-Reply-To: <ZqPjJy5YCuF02XNI@sunil-laptop>
Date: Sat, 27 Jul 2024 02:23:43 +0800
Cc: Sudeep Holla <sudeep.holla@arm.com>,
 linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1A59AB2E-58A6-4D9F-9976-DABFAA825EE0@gmail.com>
References: <446b96d0-4b61-11ef-9239-3f7ac1938848@innull.com>
 <ZqPJLtGZQfxrIxhf@bogus> <DCBB5DD3-C6FD-4CE6-8C21-C4E218BD666E@gmail.com>
 <ZqPjJy5YCuF02XNI@sunil-laptop>
To: Sunil V L <sunilvl@ventanamicro.com>
X-Mailer: Apple Mail (2.3774.600.62)


> 2024=E5=B9=B47=E6=9C=8827=E6=97=A5 01:55=EF=BC=8CSunil V L =
<sunilvl@ventanamicro.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Sat, Jul 27, 2024 at 12:39:03AM +0800, Miao Wang wrote:
>> Hi,
>>=20
>> Thanks for your quick reply.
>>=20
>>> 2024=E5=B9=B47=E6=9C=8827=E6=97=A5 00:05=EF=BC=8CSudeep Holla =
<sudeep.holla@arm.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> On Fri, Jul 26, 2024 at 11:03:01PM +0800, Miao Wang via B4 Relay =
wrote:
>>>> From: Miao Wang <shankerwangmiao@gmail.com>
>>>>=20
>>>> So that we avoid arch-specific code in general ACPI initialization =
flow.
>>>> Other architectures can also have chance to define their own
>>>> arch-specific acpi initialization process if necessary.
>>>>=20
>>>=20
>>> Nice, but I assume you are adding something similar to another =
arch(riscv
>>> or loongarch ?). It would be nice to have those changes as well =
together to
>>> make it easy to understand the intention much quicker.
>>=20
>> Yes, you are right about it. I'm trying to add some codes for =
loongarch,
>> after DSDT is loaded and namespace is created, before the devices are
>> enumerated, so I'll have chance to add a _DEP method to one of the =
device
>> using acpi_install_method to provide compatibility for some early =
loongarch
>> devices which are produced before the loongarch related ACPI standard =
is
>> finalized.
>>=20
> I have arch-specific initialization need for RISC-V as well. So, good =
to
> see this patch!.
>=20
>>>=20
>>>> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
>>>> ---
>>>> arch/arm64/include/asm/acpi.h | 2 ++
>>>> drivers/acpi/arm64/init.c     | 2 +-
>>>> drivers/acpi/bus.c            | 2 +-
>>>> include/linux/acpi.h          | 6 +++---
>>>> 4 files changed, 7 insertions(+), 5 deletions(-)
>>>>=20
>>>> diff --git a/arch/arm64/include/asm/acpi.h =
b/arch/arm64/include/asm/acpi.h
>>>> index a407f9cd549e..0d24e920e143 100644
>>>> --- a/arch/arm64/include/asm/acpi.h
>>>> +++ b/arch/arm64/include/asm/acpi.h
>>>> @@ -188,4 +188,6 @@ static inline void acpi_map_cpus_to_nodes(void) =
{ }
>>>>=20
>>>> #define ACPI_TABLE_UPGRADE_MAX_PHYS MEMBLOCK_ALLOC_ACCESSIBLE
>>>>=20
>>>> +#define ACPI_HAVE_ARCH_INIT
>>>> +
>>>=20
>>> There is nothing core arm66 arch specific in acpi_arm_init() and =
hence it
>>> is in drivers/acpi/arm64. I would like to avoid adding anything in =
arch/arm64
>>> if possible. Also I don't think we need to define this =
ACPI_HAVE_ARCH_INIT
>>>=20
>>>> #endif /*_ASM_ACPI_H*/
>>>> diff --git a/drivers/acpi/arm64/init.c b/drivers/acpi/arm64/init.c
>>>> index d0c8aed90fd1..7a47d8095a7d 100644
>>>> --- a/drivers/acpi/arm64/init.c
>>>> +++ b/drivers/acpi/arm64/init.c
>>>> @@ -2,7 +2,7 @@
>>>> #include <linux/acpi.h>
>>>> #include "init.h"
>>>>=20
>>>> -void __init acpi_arm_init(void)
>>>> +void __init acpi_arch_init(void)
>>>=20
>>> Keep the name acpi_arm_init as is.
>>>=20
>>>> {
>>>> if (IS_ENABLED(CONFIG_ACPI_AGDI))
>>>> acpi_agdi_init();
>>>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>>>> index 284bc2e03580..662f69e379ef 100644
>>>> --- a/drivers/acpi/bus.c
>>>> +++ b/drivers/acpi/bus.c
>>>> @@ -1458,7 +1458,7 @@ static int __init acpi_init(void)
>>>> acpi_viot_early_init();
>>>> acpi_hest_init();
>>>> acpi_ghes_init();
>>>> - acpi_arm_init();
>>>> + acpi_arch_init();
>>>=20
>>> Here we need acpi_arch_init() like you have changed.
>>>=20
>>>> acpi_scan_init();
>>>> acpi_ec_init();
>>>> acpi_debugfs_init();
>>>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>>>> index f0b95c76c707..3c3a83499c2d 100644
>>>> --- a/include/linux/acpi.h
>>>> +++ b/include/linux/acpi.h
>>>> @@ -1517,10 +1517,10 @@ static inline int =
find_acpi_cpu_topology_hetero_id(unsigned int cpu)
>>>> }
>>>> #endif
>>>>=20
>>>> -#ifdef CONFIG_ARM64
>>>> -void acpi_arm_init(void);
>>>> +#ifdef ACPI_HAVE_ARCH_INIT
>>>> +void acpi_arch_init(void);
>>>=20
>>> This is bit inconsistent. The Makefile is still conditional on
>>> CONFIG_ARM64 while here you move to ACPI_HAVE_ARCH_INIT.
>>> So while not just undefine and redefine acpi_arch_init to =
acpi_arm_init.
>>> Something like this must work ?
>>>=20
>>> #define acpi_arch_init() do { }while(0)
>>>=20
>>> #ifdef CONFIG_ARM64
>>> #undef acpi_arch_init
>>> #define acpi_arch_init() acpi_arm_init()
>>> #endif
>>=20
>> It will work. However I can see the pattern in other parts, where
>> the definition of a macro named HAVE_xxx is checked, and define an
>> inline static function with empty body if such macro is not defined
>> or define a function prototype with the same name otherwise, like
>> acpi_arch_set_root_pointer. I'm just trying to follow this pattern.
>>=20
> I was thinking to make it weak function similar to cpc_read_ffh().
> Wouldn't it be better than ifdefery?

I believe there would be performance loss for those arches with a stub
function definition if a weak function is used (correct me if wrong).
So the approach with a static inline stub is more common in the kernel
code.

Cheers,

Miao Wang



