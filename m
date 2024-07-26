Return-Path: <linux-acpi+bounces-7072-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BD893D71C
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jul 2024 18:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5761C23389
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jul 2024 16:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48F42E64A;
	Fri, 26 Jul 2024 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqukogRg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB9B179950
	for <linux-acpi@vger.kernel.org>; Fri, 26 Jul 2024 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722011962; cv=none; b=fCLAsvzWgrsb0/bXKLks3AhGwxEP/Gdx2x1RwzOJwsDUSUQk1AGO+f5WFDyVO7WhFBZz8XZjeYbaTPjuH8cbEDufSG4JJuoh1Z0IYMeWRDt1phTtadqmv9W8zn14WmhrVutTYkfJKxAC6IK3jjwzSDwQDbU5HWRaviPrGb9jwAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722011962; c=relaxed/simple;
	bh=dVoDmUT67wVrmvb2ZR7vUlD0DPDpMiqFIlAMKVKwYWo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dEKv5gZBMHNlpIAZYfeRJBdBEslGzV3Sejjo12MmySiNPrrvMeBN3e4DK247ZX1/jM7U4pdAjjz7iXSZ+/sJn7KjbcmAX/gSGDk7uCbxY8vTjP7hxUdZtX2wwqdhpX+eCChScnrt4VP7jGMLqdSQe8LUdUPIxEaHA64OSPnv21I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqukogRg; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3d9e13ef8edso754758b6e.2
        for <linux-acpi@vger.kernel.org>; Fri, 26 Jul 2024 09:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722011960; x=1722616760; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6IFr/uBFRmlohPZgze4KnKiKiNUVk+iL+TvkF/MXV4=;
        b=FqukogRgdRIIDjO/QjO9upoLq2BqmtpZZ9iFBONrt8fVEkjqmTBHmDMLN8Qqqxr7no
         qPzEibHbhuX4zxvV59jYpyNfjDfwNZIGWLbiHuVQhhc7b2WXVZ7VVNrHuZZ92swRjNly
         nT0LCpTKdjzP8dym/N/BNgZ0qtjf40Ra6agl4RwKOdmHiMoR/Zqkng3YHA2QPXrjH/4u
         LDbsRX+c3RCGDFZgQn231dcoUZ9fNYcpHdh5GAlYErHPlUXg+kfL0sVmY8PRGsbb/M5V
         2/Zd+hYGl+Je+moFystV7ZPtp1p6CsnJVvniLkvKNGHONBR+M/A8ZGf6+53VgFyvzNJ1
         LEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722011960; x=1722616760;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6IFr/uBFRmlohPZgze4KnKiKiNUVk+iL+TvkF/MXV4=;
        b=ru8wNNWcumnKAJcHaEUD8c1wpr5nJblLPPYRfp9yH1XV9GBm9GRBy4dv2cLqdGTJca
         lkNo8oOUYe2ZDNS/5L+xwe7jMnXOcujfLaIX+NYe/Hm+AnFt5tNX9gU0ua93J4HRaERT
         1wOk5sBYDJ9rRy4Ga6WLe/KlVmXcJKLO+s8k4c7Rs+uawMlAWFrPXMQU3EZUfvXBj0sL
         h5vnU2ri4k0X3Tr6gMEnxZGCJik0jJ0CHEnqdrI3xz5AqKiFis0td1R4vsOeNtN4RSMX
         CrWbuZB+PcbFxHSUYomF8uqiDYf5rlveNHukthplDti+lcl0Zt3mDFrhOKdzhDL/EkBc
         F4kA==
X-Gm-Message-State: AOJu0YxKvUomSC3vZLlgEZW+2JQdi1NgLHMyNeC9jDwXikHR4d/nd6d6
	fyV2avvoHMNGygtdqURsUqBSiMBPOQ7SdBmrZVpIgjd2wCmmIKZC
X-Google-Smtp-Source: AGHT+IGql7DSlnlCNI4PzWu2cUaeRUO5HNu83E/yXkFwTYIucinn8GjfMwqmu+CNcU5es9z81ilyjw==
X-Received: by 2002:a05:6808:1416:b0:3da:4c28:6697 with SMTP id 5614622812f47-3db23a2edbcmr320916b6e.38.1722011960065;
        Fri, 26 Jul 2024 09:39:20 -0700 (PDT)
Received: from smtpclient.apple (v133-130-115-230.a046.g.tyo1.static.cnode.io. [133.130.115.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8116afsm2914860b3a.116.2024.07.26.09.39.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2024 09:39:19 -0700 (PDT)
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
In-Reply-To: <ZqPJLtGZQfxrIxhf@bogus>
Date: Sat, 27 Jul 2024 00:39:03 +0800
Cc: linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DCBB5DD3-C6FD-4CE6-8C21-C4E218BD666E@gmail.com>
References: <446b96d0-4b61-11ef-9239-3f7ac1938848@innull.com>
 <ZqPJLtGZQfxrIxhf@bogus>
To: Sudeep Holla <sudeep.holla@arm.com>
X-Mailer: Apple Mail (2.3774.600.62)

Hi,

Thanks for your quick reply.

> 2024=E5=B9=B47=E6=9C=8827=E6=97=A5 00:05=EF=BC=8CSudeep Holla =
<sudeep.holla@arm.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri, Jul 26, 2024 at 11:03:01PM +0800, Miao Wang via B4 Relay =
wrote:
>> From: Miao Wang <shankerwangmiao@gmail.com>
>>=20
>> So that we avoid arch-specific code in general ACPI initialization =
flow.
>> Other architectures can also have chance to define their own
>> arch-specific acpi initialization process if necessary.
>>=20
>=20
> Nice, but I assume you are adding something similar to another =
arch(riscv
> or loongarch ?). It would be nice to have those changes as well =
together to
> make it easy to understand the intention much quicker.

Yes, you are right about it. I'm trying to add some codes for loongarch,
after DSDT is loaded and namespace is created, before the devices are
enumerated, so I'll have chance to add a _DEP method to one of the =
device
using acpi_install_method to provide compatibility for some early =
loongarch
devices which are produced before the loongarch related ACPI standard is
finalized.

>=20
>> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
>> ---
>> arch/arm64/include/asm/acpi.h | 2 ++
>> drivers/acpi/arm64/init.c     | 2 +-
>> drivers/acpi/bus.c            | 2 +-
>> include/linux/acpi.h          | 6 +++---
>> 4 files changed, 7 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/arch/arm64/include/asm/acpi.h =
b/arch/arm64/include/asm/acpi.h
>> index a407f9cd549e..0d24e920e143 100644
>> --- a/arch/arm64/include/asm/acpi.h
>> +++ b/arch/arm64/include/asm/acpi.h
>> @@ -188,4 +188,6 @@ static inline void acpi_map_cpus_to_nodes(void) { =
}
>>=20
>> #define ACPI_TABLE_UPGRADE_MAX_PHYS MEMBLOCK_ALLOC_ACCESSIBLE
>>=20
>> +#define ACPI_HAVE_ARCH_INIT
>> +
>=20
> There is nothing core arm66 arch specific in acpi_arm_init() and hence =
it
> is in drivers/acpi/arm64. I would like to avoid adding anything in =
arch/arm64
> if possible. Also I don't think we need to define this =
ACPI_HAVE_ARCH_INIT
>=20
>> #endif /*_ASM_ACPI_H*/
>> diff --git a/drivers/acpi/arm64/init.c b/drivers/acpi/arm64/init.c
>> index d0c8aed90fd1..7a47d8095a7d 100644
>> --- a/drivers/acpi/arm64/init.c
>> +++ b/drivers/acpi/arm64/init.c
>> @@ -2,7 +2,7 @@
>> #include <linux/acpi.h>
>> #include "init.h"
>>=20
>> -void __init acpi_arm_init(void)
>> +void __init acpi_arch_init(void)
>=20
> Keep the name acpi_arm_init as is.
>=20
>> {
>> if (IS_ENABLED(CONFIG_ACPI_AGDI))
>> acpi_agdi_init();
>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index 284bc2e03580..662f69e379ef 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -1458,7 +1458,7 @@ static int __init acpi_init(void)
>> acpi_viot_early_init();
>> acpi_hest_init();
>> acpi_ghes_init();
>> - acpi_arm_init();
>> + acpi_arch_init();
>=20
> Here we need acpi_arch_init() like you have changed.
>=20
>> acpi_scan_init();
>> acpi_ec_init();
>> acpi_debugfs_init();
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index f0b95c76c707..3c3a83499c2d 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -1517,10 +1517,10 @@ static inline int =
find_acpi_cpu_topology_hetero_id(unsigned int cpu)
>> }
>> #endif
>>=20
>> -#ifdef CONFIG_ARM64
>> -void acpi_arm_init(void);
>> +#ifdef ACPI_HAVE_ARCH_INIT
>> +void acpi_arch_init(void);
>=20
> This is bit inconsistent. The Makefile is still conditional on
> CONFIG_ARM64 while here you move to ACPI_HAVE_ARCH_INIT.
> So while not just undefine and redefine acpi_arch_init to =
acpi_arm_init.
> Something like this must work ?
>=20
> #define acpi_arch_init() do { }while(0)
>=20
> #ifdef CONFIG_ARM64
> #undef acpi_arch_init
> #define acpi_arch_init() acpi_arm_init()
> #endif

It will work. However I can see the pattern in other parts, where
the definition of a macro named HAVE_xxx is checked, and define an
inline static function with empty body if such macro is not defined
or define a function prototype with the same name otherwise, like
acpi_arch_set_root_pointer. I'm just trying to follow this pattern.

> --
> Regards,
> Sudeep


