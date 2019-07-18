Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE126C3E4
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Jul 2019 02:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731985AbfGRAtr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Jul 2019 20:49:47 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41359 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727557AbfGRAtr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Jul 2019 20:49:47 -0400
Received: by mail-qk1-f193.google.com with SMTP id v22so19049882qkj.8
        for <linux-acpi@vger.kernel.org>; Wed, 17 Jul 2019 17:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7K9LFXNQszPVt9oolCuthJEpelngJlWY3awPIGBoIrc=;
        b=GZjJVzEiaTVbs3gP0mhVx/ascqRuKFftBg0qG8OjLCs9Uet45jCXXHASsA+I78EcEM
         hnXVwAzXuOMkmmeiVNSMXOz6qQ6PQrO13L850mZrPiDOmrEl4+tmsaJATgsPDLzvCuHX
         pKtA0WAL6PfYZ732t/8Hn7t/mcLhGq8mgFBmgAyj3C3f4w6pLEclhG2GZnZyY2pwiyIv
         PbfEpwmggZ6X+dlw2lyCk8k5yM+HeTs5ukcAG8TCaHwMNf5XhyNs1uxa8lhpwmCm/N4j
         arlVs+uOoN4ASTWBLtHsXFZOsmspHBc7JksnLpoBGrrHRb1mDJi7fsHLqiyUCUtZWwqy
         SVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7K9LFXNQszPVt9oolCuthJEpelngJlWY3awPIGBoIrc=;
        b=HzUagjnngZOFscIIBeYf/mMTEanV4hKk0U3I/qPIRZuE3HurgDA1fPfOIh0AXXtYjG
         1ieb9Qss+r1PQVvOJW7pl4c0SOgeyFhYfBmLeu32dGAIj0RPEiu2ErR052rEAIZHV9hJ
         C+INvav0XiP51TNx87h5YNQmQdseyDZ1JziROJSPZUkFoytn7ornHZrqwQXtQmtgKPpd
         dnKgx+fDNLzc0cNU61JflEIcP7VC4vJLEyxS2OlhHfl3vJqH6HoacX6bG9NwUVnjcJtz
         B3YjIcZrmyR0M2W8lf+dpJfPY/p1JlwNJ3aVwiPtYZYOpG4pvz/nuWyaw+zxWW0jA77k
         eK4g==
X-Gm-Message-State: APjAAAVyY/SyomSvyiEoagAoo0msbCjr1HIYpEhPp6MIHyn28CWxLYUl
        6UWDZH8nFUgcY8P9NScVLs/eXg==
X-Google-Smtp-Source: APXvYqyFZ9N+j7zVEUuW7E/oqpo5oR1MZH84slnFKyHkQq0UmXesigIoFoR8pMXjjDLELyRq2Ou6vA==
X-Received: by 2002:ae9:f101:: with SMTP id k1mr28781291qkg.337.1563410986046;
        Wed, 17 Jul 2019 17:49:46 -0700 (PDT)
Received: from qians-mbp.fios-router.home (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id v84sm11985703qkb.0.2019.07.17.17.49.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 17:49:45 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] acpica: fix -Wnull-pointer-arithmetic warnings
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <CAKwvOdmPX2DsUawcA0SzaFacjz==ACcfD8yDsbaS4eP4Es=Wzw@mail.gmail.com>
Date:   Wed, 17 Jul 2019 20:49:43 -0400
Cc:     rafael.j.wysocki@intel.com, robert.moore@intel.com,
        erik.schmauss@intel.com, jkim@freebsd.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <73A4565B-837B-4E13-8B72-63F69BF408E7@lca.pw>
References: <20190717033807.1207-1-cai@lca.pw>
 <CAKwvOdmPX2DsUawcA0SzaFacjz==ACcfD8yDsbaS4eP4Es=Wzw@mail.gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> On Jul 17, 2019, at 6:01 PM, Nick Desaulniers =
<ndesaulniers@google.com> wrote:
>=20
> On Tue, Jul 16, 2019 at 8:38 PM Qian Cai <cai@lca.pw> wrote:
>>=20
>> Clang generate quite a few of those warnings.
>>=20
>> drivers/acpi/scan.c:759:28: warning: arithmetic on a null pointer
>> treated as a cast from integer to pointer is a GNU extension
>> [-Wnull-pointer-arithmetic]
>>                status =3D acpi_get_handle(ACPI_ROOT_OBJECT,
>> obj->string.pointer,
>>                                         ^~~~~~~~~~~~~~~~
>> ./include/acpi/actypes.h:458:56: note: expanded from macro
>> 'ACPI_ROOT_OBJECT'
>> #define ACPI_ROOT_OBJECT                ((acpi_handle) =
ACPI_TO_POINTER
>> (ACPI_MAX_PTR))
>>                                                        =
^~~~~~~~~~~~~~~
>> ./include/acpi/actypes.h:509:41: note: expanded from macro
>> 'ACPI_TO_POINTER'
>> #define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void, (void *) =
0,
>> (acpi_size) (i))
>>                                         =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ./include/acpi/actypes.h:503:84: note: expanded from macro
>> 'ACPI_ADD_PTR'
>> #define ACPI_ADD_PTR(t, a, b)           ACPI_CAST_PTR (t,
>> (ACPI_CAST_PTR (u8, (a)) + (acpi_size)(b)))
>>                                         ^~~~~~~~~~~~~~~~~
>> ./include/acpi/actypes.h:501:66: note: expanded from macro
>> 'ACPI_CAST_PTR'
>> #define ACPI_CAST_PTR(t, p)             ((t *) (acpi_uintptr_t) (p))
>>                                                                  ^
>> This is because pointer arithmetic on a pointer not pointing to an =
array
>> is an undefined behavior. Fix it by doing an integer arithmetic
>> instead.
>=20
> Hi Qian, thanks for the patch.  How do I reproduce this issue,
> precisely?  I just tried:
> $ make CC=3Dclang -j71 drivers/acpi/scan.o
> on linux-next today and don't observe the warning.  My clang is ToT
> built sometime this week.  It looks like drivers/acpi/scan.o when
> CONFIG_ACPI=3Dy, which is set in the defconfig.  Is there another set =
of
> configs to enable to observe the warning?

# make W=3D1 -j 256

With the config,

https://raw.githubusercontent.com/cailca/linux-mm/master/arm64.config=20

>=20
> Also, the fix is curious.  Arithmetic on pointers to different
> "objects" (with one element passed the end) may lead to provence
> issues due to undefined behavior, but I would have expected some cases
> to uintptr_t, then arithmetic on that type, as the solution (which is
> what I suspect ACPI_CAST_PTR is doing).
>=20
> Further, you seem to have modified ACPI_ADD_PTR but not ACPI_SUB_PTR;
> I would have expected both to be afflicted together or not at all
> based on their existing implementations.

Yes, I thought about that, but ACPI_SUB_PTR does not seem used anywhere, =
so I thought maybe just start a new discussion to remove it all together =
later.


>=20
>>=20
>> Signed-off-by: Qian Cai <cai@lca.pw>
>> ---
>> include/acpi/actypes.h | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
>> index ad6892a24015..25b4a32da177 100644
>> --- a/include/acpi/actypes.h
>> +++ b/include/acpi/actypes.h
>> @@ -500,13 +500,13 @@ typedef u64 acpi_integer;
>>=20
>> #define ACPI_CAST_PTR(t, p)             ((t *) (acpi_uintptr_t) (p))
>> #define ACPI_CAST_INDIRECT_PTR(t, p)    ((t **) (acpi_uintptr_t) (p))
>> -#define ACPI_ADD_PTR(t, a, b)           ACPI_CAST_PTR (t, =
(ACPI_CAST_PTR (u8, (a)) + (acpi_size)(b)))
>> +#define ACPI_ADD_PTR(t, a, b)           ACPI_CAST_PTR (t, (a) + =
(acpi_size)(b))
>> #define ACPI_SUB_PTR(t, a, b)           ACPI_CAST_PTR (t, =
(ACPI_CAST_PTR (u8, (a)) - (acpi_size)(b)))
>> #define ACPI_PTR_DIFF(a, b)             ((acpi_size) (ACPI_CAST_PTR =
(u8, (a)) - ACPI_CAST_PTR (u8, (b))))
>>=20
>> /* Pointer/Integer type conversions */
>>=20
>> -#define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void, (void *) =
0, (acpi_size) (i))
>> +#define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void, 0, =
(acpi_size) (i))
>=20
> IIUC, these are adding `i` to NULL (or (void*)0)? X + 0 =3D=3D X ?
> --=20
> Thanks,
> ~Nick Desaulniers

