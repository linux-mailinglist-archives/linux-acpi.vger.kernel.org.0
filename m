Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523953FC578
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Aug 2021 12:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240751AbhHaKMd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 31 Aug 2021 06:12:33 -0400
Received: from out0.migadu.com ([94.23.1.103]:29358 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240855AbhHaKMd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 31 Aug 2021 06:12:33 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1630404695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vd98rQ/D/y8gDXSGwi8PNYRO/AKCDQfSLiZxPtvthSA=;
        b=eRt5zGMAC7wsEstgsaK7U+fOuU7TbBAaFdW7Mrp1IjtBjZiJjYzzVowUTIPilSnghPHf7f
        8ZsA7yo74WlkZay/6NV2pm/6LvnK815LmK3+r95/+IGyGz/F5gl5IWMr8GdvQNFPJuerFV
        E9w2f911kDnScc2umkmlFklX2apV0mM=
Date:   Tue, 31 Aug 2021 10:11:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Jackie Liu" <liu.yun@linux.dev>
Message-ID: <fc62139f5128ee8d0de0bc39030ca80f@linux.dev>
Subject: Re: [PATCH] acpi/arm64: fix next_platform_timer() section
 mismatch error
To:     lorenzo.pieralisi@arm.com
Cc:     linux-acpi@vger.kernel.org, liuyun01@kylinos.cn,
        "Hanjun Guo" <guohanjun@huawei.com>
In-Reply-To: <7f29a149-e005-f13f-2cc4-a9eb737107e1@huawei.com>
References: <7f29a149-e005-f13f-2cc4-a9eb737107e1@huawei.com>
 <20210823092526.2407526-1-liu.yun@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: liu.yun@linux.dev
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Friendly ping...=0A=0A=0A=0AAugust 23, 2021 9:33 PM, "Hanjun Guo" <guohan=
jun@huawei.com> =E5=86=99=E5=88=B0:=0A=0A> On 2021/8/23 17:25, Jackie Liu=
 wrote:=0A> =0A>> From: Jackie Liu <liuyun01@kylinos.cn>=0A>> Fix modpost=
 Section mismatch error in next_platform_timer().=0A>> [...]=0A>> WARNING=
: modpost: vmlinux.o(.text.unlikely+0x26e60): Section mismatch in referen=
ce from the=0A>> function next_platform_timer() to the variable .init.dat=
a:acpi_gtdt_desc=0A>> The function next_platform_timer() references=0A>> =
the variable __initdata acpi_gtdt_desc.=0A>> This is often because next_p=
latform_timer lacks a __initdata=0A>> annotation or the annotation of acp=
i_gtdt_desc is wrong.=0A>> WARNING: modpost: vmlinux.o(.text.unlikely+0x2=
6e64): Section mismatch in reference from the=0A>> function next_platform=
_timer() to the variable .init.data:acpi_gtdt_desc=0A>> The function next=
_platform_timer() references=0A>> the variable __initdata acpi_gtdt_desc.=
=0A>> This is often because next_platform_timer lacks a __initdata=0A>> a=
nnotation or the annotation of acpi_gtdt_desc is wrong.=0A>> ERROR: modpo=
st: Section mismatches detected.=0A>> Set CONFIG_SECTION_MISMATCH_WARN_ON=
LY=3Dy to allow them.=0A>> make[1]: *** [scripts/Makefile.modpost:59: vml=
inux.symvers] Error 1=0A>> make[1]: *** Deleting file 'vmlinux.symvers'=
=0A>> make: *** [Makefile:1176: vmlinux] Error 2=0A>> [...]=0A>> Fixes: a=
712c3ed9b8a ("acpi/arm64: Add memory-mapped timer support in GTDT driver"=
)=0A>> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>=0A>> ---=0A>> driv=
ers/acpi/arm64/gtdt.c | 2 +-=0A>> 1 file changed, 1 insertion(+), 1 delet=
ion(-)=0A>> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/g=
tdt.c=0A>> index 0a0a982f9c28..c0e77c1c8e09 100644=0A>> --- a/drivers/acp=
i/arm64/gtdt.c=0A>> +++ b/drivers/acpi/arm64/gtdt.c=0A>> @@ -36,7 +36,7 @=
@ struct acpi_gtdt_descriptor {=0A>>> static struct acpi_gtdt_descriptor =
acpi_gtdt_desc __initdata;=0A>>> -static inline void *next_platform_timer=
(void *platform_timer)=0A>> +static inline __init void *next_platform_tim=
er(void *platform_timer)=0A>> {=0A>> struct acpi_gtdt_header *gh =3D plat=
form_timer;=0A> =0A> Looks good to me,=0A> =0A> Acked-by: Hanjun Guo <guo=
hanjun@huawei.com>=0A> =0A> Thanks=0A> Hanjun
