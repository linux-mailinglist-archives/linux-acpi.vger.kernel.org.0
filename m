Return-Path: <linux-acpi+bounces-16964-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BCCB5854E
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 21:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C06E6207500
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 19:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF1721771B;
	Mon, 15 Sep 2025 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAkFmryh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A654D1D618E
	for <linux-acpi@vger.kernel.org>; Mon, 15 Sep 2025 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757964835; cv=none; b=mbCDkIHzqiy3z0qLs9xNTzYIwLipE+fHPFH/3//42ABmsMAzANn2xAeDBwKg/XJpjhRMbkLbOpmOIelnQlac8kFHfAKSY86FBjL58iLHp856y4zb98bHeZgIA/vIY+3e8FyVzZrub7HsAS7dJ2kmlOP/2ql8b8w6ANMHidRw+Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757964835; c=relaxed/simple;
	bh=bHRNR6Si9KkH2i6HyBG3sLnqM7QaA4pwDc0GRfKNCBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3eMxDJgCkMw+SIFIdCp3+XJ/C7mf47L4TWk0xCY/jm5ug+97oQYIMgToclzhgKmrzxN8DR2BjqQqaUTfY7a/d7ZsG5vVkCNs3i8tCYN29DbzqrfHruYRH+/UMfnVzUGlkuZ/qOXpulpFhgNd5+/b1TvHMhpA3+dhMhP+PBpPi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAkFmryh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E65CC4CEFC
	for <linux-acpi@vger.kernel.org>; Mon, 15 Sep 2025 19:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757964835;
	bh=bHRNR6Si9KkH2i6HyBG3sLnqM7QaA4pwDc0GRfKNCBs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gAkFmryhDtGnEGfBS/Iojo7VsdNZNEiLHZhMqQBNHbcwU7C91PkAKOP/lcgrLlW9S
	 CnH1dDbTfdlUlZSfGCSu4pM8+1uoP4nRomGPa40WuhLSuWA6kGPEQ3j5aMtj8T53gW
	 iAmUe2Tr7nOU1D7GKKjPCC6MKuPNhINIsO0KFuRrjDPig0uZ4RQmNYHYEVsEoAbDzk
	 6jG1ICMj4PQ7QpHOiTMXhto8xwjMX78wrjAsf9g3Jz8SYpMsCa+MmEA6qcM9HttR3U
	 UiJo1tUhLc8oH7x5AAK2M5bep8tSofkWUITZlwbp5y4mrkU1NAUiRVb1/UhhF78ez9
	 Z9bnb3uXRjR1g==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-62189987b47so1879918eaf.1
        for <linux-acpi@vger.kernel.org>; Mon, 15 Sep 2025 12:33:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZ1fuN9pFw8rJoPqtKKj7rSW/qzcIHV+RdYR1c2NecXXGGKRGpad1S5UFe6pjXmH2duJEWE8djWLu/@vger.kernel.org
X-Gm-Message-State: AOJu0YxVy/klT8XPHbjhDsFwPRPNCHjpp4u0n6utNirTII6xHMkw3H6+
	n1mEuW5FHscUbFK4CCXxzmvQ0QT9mPM9FPUJXxCX+FsektUble9ETtNiQfUJ5UpD/157KvZSPTA
	QQVSlhe709httXxUQy5lrqwSgCdLtiSQ=
X-Google-Smtp-Source: AGHT+IFt0QX/DZNL+mFbjfONvR4fJq+mrWUIlKJnqaVa6n0S7fGi6dwDHjXutXDyNK9g28F/49/zVWZmAC6itATpams=
X-Received: by 2002:a05:6820:162a:b0:621:ce3b:b648 with SMTP id
 006d021491bc7-621ce3bbb6cmr4252352eaf.4.1757964834587; Mon, 15 Sep 2025
 12:33:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910044531.264043-1-jiaqiyan@google.com> <88893809-ed13-dbb9-2446-8fd680f57693@huawei.com>
In-Reply-To: <88893809-ed13-dbb9-2446-8fd680f57693@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Sep 2025 21:33:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g_f3Ut_8nf1NM5nJb3OSS83ccS65sT=DZOu0LWuCWZ1Q@mail.gmail.com>
X-Gm-Features: AS18NWAtIax3pu9gkklTbd3hply-pFX4azyM_X7JPxc8ebVAI3tNa1WrLEgQp_4
Message-ID: <CAJZ5v0g_f3Ut_8nf1NM5nJb3OSS83ccS65sT=DZOu0LWuCWZ1Q@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: APEI: EINJ: Allow more types of addresses except MMIO
To: Hanjun Guo <guohanjun@huawei.com>, Jiaqi Yan <jiaqiyan@google.com>
Cc: tony.luck@intel.com, rafael@kernel.org, dan.j.williams@intel.com, 
	bp@alien8.de, mchehab@kernel.org, xueshuai@linux.alibaba.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 4:57=E2=80=AFPM Hanjun Guo <guohanjun@huawei.com> w=
rote:
>
> On 2025/9/10 12:45, Jiaqi Yan wrote:
> > EINJ driver today only allows injection request to go through for two
> > kinds of IORESOURCE_MEM: IORES_DESC_PERSISTENT_MEMORY and
> > IORES_DESC_SOFT_RESERVED. This check prevents user of EINJ to test
> > memory corrupted in many interesting areas:
> >
> > - Legacy persistent memory
> > - Memory claimed to be used by ACPI tables or NV storage
> > - Kernel crash memory and others
> >
> > There is need to test how kernel behaves when something consumes memory
> > errors in these memory regions. For example, if certain ACPI table is
> > corrupted, does kernel crash gracefully to prevent "silent data
> > corruption". For another example, legacy persistent memory, when manage=
d
> > by Device DAX, does support recovering from Machine Check Exception
> > raised by memory failure, hence worth to be tested.
> >
> > However, attempt to inject memory error via EINJ to legacy persistent
> > memory or ACPI owned memory fails with -EINVAL.
> >
> > Allow EINJ to inject at address except it is MMIO. Leave it to the BIOS
> > or firmware to decide what is a legitimate injection target.
> >
> > In addition to the test done in [1], on a machine having the following
> > iomem resources:
> >
> >      ...
> >      01000000-08ffffff : Crash kernel
> >      768f0098-768f00a7 : APEI EINJ
> >      ...
> >    768f4000-77323fff : ACPI Non-volatile Storage
> >    77324000-777fefff : ACPI Tables
> >    777ff000-777fffff : System RAM
> >    77800000-7fffffff : Reserved
> >    80000000-8fffffff : PCI MMCONFIG 0000 [bus 00-ff]
> >    90040000-957fffff : PCI Bus 0000:00
> >    ...
> >    300000000-3ffffffff : Persistent Memory (legacy)
> >    ...
> >
> > I commented __einj_error_inject during the test and just tested when
> > injecting a memory error at each start address shown above:
> > - 0x80000000 and 0x90040000 both failed with EINVAL
> > - request passed through for all other addresses
> >
> > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > ---
> >
> > Changelog
> >
> > v2 [2] -> v3:
> > - Remove unnecessary IORES_DESC_CXL per comment from Hanjun [3].
> > - Minor update to code comment.
> >
> > v1 [1] -> v2:
> > - In addition to allow IORES_DESC_PERSISTENT_MEMORY_LEGACY, open the
> >    door wider and only exclude MMIO per suggestion from Tony [4].
> > - Rebased to commit 11e7861d680c ("Merge tag 'for-linus' of git://git.k=
ernel.org/pub/scm/virt/kvm/kvm").
> >
> > [1] https://lore.kernel.org/linux-acpi/20250825223348.3780279-1-jiaqiya=
n@google.com
> > [2] https://lore.kernel.org/linux-acpi/20250830030226.918555-1-jiaqiyan=
@google.com
> > [3] https://lore.kernel.org/linux-acpi/bc8ad4b8-c000-0298-efd1-4a332c4c=
7820@huawei.com
> > [4] https://lore.kernel.org/linux-acpi/SJ1PR11MB60835824926BEE57F094DE6=
FFC39A@SJ1PR11MB6083.namprd11.prod.outlook.com
> >
> > drivers/acpi/apei/einj-core.c | 51 ++++++++++++++++++++++++++++-------
> >   1 file changed, 42 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-cor=
e.c
> > index 2561b045acc7b..3c87953dbd197 100644
> > --- a/drivers/acpi/apei/einj-core.c
> > +++ b/drivers/acpi/apei/einj-core.c
> > @@ -656,6 +656,43 @@ static int __einj_error_inject(u32 type, u32 flags=
, u64 param1, u64 param2,
> >       return rc;
> >   }
> >
> > +/* Allow almost all types of address except MMIO. */
> > +static bool is_allowed_range(u64 base_addr, u64 size)
> > +{
> > +     int i;
> > +     /*
> > +      * MMIO region is usually claimed with IORESOURCE_MEM + IORES_DES=
C_NONE.
> > +      * However, IORES_DESC_NONE is treated like a wildcard when we ch=
eck if
> > +      * region intersects with known resource. So do an allow list che=
ck for
> > +      * IORES_DESCs that definitely or most likely not MMIO.
> > +      */
> > +     int non_mmio_desc[] =3D {
> > +             IORES_DESC_CRASH_KERNEL,
> > +             IORES_DESC_ACPI_TABLES,
> > +             IORES_DESC_ACPI_NV_STORAGE,
> > +             IORES_DESC_PERSISTENT_MEMORY,
> > +             IORES_DESC_PERSISTENT_MEMORY_LEGACY,
> > +             /* Treat IORES_DESC_DEVICE_PRIVATE_MEMORY as MMIO. */
> > +             IORES_DESC_RESERVED,
> > +             IORES_DESC_SOFT_RESERVED,
> > +     };
> > +
> > +     if (region_intersects(base_addr, size, IORESOURCE_SYSTEM_RAM, IOR=
ES_DESC_NONE)
> > +                           =3D=3D REGION_INTERSECTS)
> > +             return true;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(non_mmio_desc); ++i) {
> > +             if (region_intersects(base_addr, size, IORESOURCE_MEM, no=
n_mmio_desc[i])
> > +                                   =3D=3D REGION_INTERSECTS)
> > +                     return true;
> > +     }
> > +
> > +     if (arch_is_platform_page(base_addr))
> > +             return true;
> > +
> > +     return false;
> > +}
> > +
> >   /* Inject the specified hardware error */
> >   int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u6=
4 param3,
> >                     u64 param4)
> > @@ -702,19 +739,15 @@ int einj_error_inject(u32 type, u32 flags, u64 pa=
ram1, u64 param2, u64 param3,
> >        * Disallow crazy address masks that give BIOS leeway to pick
> >        * injection address almost anywhere. Insist on page or
> >        * better granularity and that target address is normal RAM or
> > -      * NVDIMM.
> > +      * as long as is not MMIO.
>
> Thanks for updating this as well.
>
> >        */
> >       base_addr =3D param1 & param2;
> >       size =3D ~param2 + 1;
> >
> > -     if (((param2 & PAGE_MASK) !=3D PAGE_MASK) ||
> > -         ((region_intersects(base_addr, size, IORESOURCE_SYSTEM_RAM, I=
ORES_DESC_NONE)
> > -                             !=3D REGION_INTERSECTS) &&
> > -          (region_intersects(base_addr, size, IORESOURCE_MEM, IORES_DE=
SC_PERSISTENT_MEMORY)
> > -                             !=3D REGION_INTERSECTS) &&
> > -          (region_intersects(base_addr, size, IORESOURCE_MEM, IORES_DE=
SC_SOFT_RESERVED)
> > -                             !=3D REGION_INTERSECTS) &&
> > -          !arch_is_platform_page(base_addr)))
> > +     if ((param2 & PAGE_MASK) !=3D PAGE_MASK)
> > +             return -EINVAL;
> > +
> > +     if (!is_allowed_range(base_addr, size))
> >               return -EINVAL;
> >
> >       if (is_zero_pfn(base_addr >> PAGE_SHIFT))
>
> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Applied as 6.18 material, thanks!

