Return-Path: <linux-acpi+bounces-16974-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 437D9B586FD
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 23:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577801B251F0
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 21:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D76C2BD02A;
	Mon, 15 Sep 2025 21:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ylzSx3pS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5092BF3DB
	for <linux-acpi@vger.kernel.org>; Mon, 15 Sep 2025 21:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757973289; cv=none; b=p0LV/t+ZkPiqcoQzzxvZcYKCxErKV5WoCBTz7zVIxvWdmQEnkT/LixVss7j1vA0KTwTXxI94aAJXj9jhxwUKyGtz+ew5xtZkVDxLU/84RaM1ychm2saRew7VlCtAMOLJHqJ3IYgg1PbwCSRGt5TAfCHfXD49G6NY3WdSo+6o1sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757973289; c=relaxed/simple;
	bh=G3/k8zFJyvwTRkMJvmzdV4kSvaLSv1YaCkh9pjD9KnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=unnSilq5xCdfsFl7maqFyXtWCGXjtAs55z2aH+Gde7LI9qz2rgWcYSogLR+ELZqHxjm9GNMFiwgztmFyIbA/ktu8FRcMLqhvUBtMyfv5E6A4LEQWb1/lNeZAfmIJSQnq6QL06NFopJRGZ4q5Vp5tEv/Q2rmM1f8QC6dY3s4yNYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ylzSx3pS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45f2d21cbabso5445e9.1
        for <linux-acpi@vger.kernel.org>; Mon, 15 Sep 2025 14:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757973285; x=1758578085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHvvCOOuofVjO/68RHGLJQvjCcfErnPvJ89hOwciG5g=;
        b=ylzSx3pSYsn42eDBSnZLMqU5Y5E9g6sfITjN/8/xO/zKKp1Ss4/yLwMq2gOa7MQ8F6
         sbV2mYRJaOUztwlp+FW2rIlUMxwANxvwzkWoxQgwuu0K7/EB9WUCwZbTaHaLbchLV+Dn
         E5Vl/FjoAr8YKtEKJ73TBlEBNF64MV5X1nkOaQmDjGevvzxSg905896J5bBMOMRzWHvx
         dKG49BRcuciO1W7aWg1XI3gsmWq6DGeRhTa3+exuPusbFgWZCnxqbLJlPhiDraDPSxK6
         ZYH8T8DWL7rN+HB1yRDRiB2uk51bibojAeiVrlO9X4izTgCO+mrlTMPhsDwfdlel8fYc
         z/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757973285; x=1758578085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHvvCOOuofVjO/68RHGLJQvjCcfErnPvJ89hOwciG5g=;
        b=Dl0UtK7Gi7vZtCJDysseCN/+w9UxunLUHdy868TvarymU5nQU1lYcZ7CVqd8Cmht0R
         g4A9/mnykpW8B/FiNISOV/aZP8lkjF8WqNBnYsNsRPj+q9LE8iXrAp8yg3nfxUFuCpkz
         Egyj2DJS/3zzzOkr5ymxm57cDNttLxHWIGC9vUBBnJYtYPjVRp0H/Zutsz91FhHuTozC
         0yLMOn9p0BTCEiKh4rbRmW/zKLnMEXYNIsHVDmuRE3Ocsc+oEqmq4oKD5DOaqd7m/V+w
         F6v1GInwy3qygU2Q0faTPHVVG8ABYSRzkDQETp8VjdP0mkLGoBfMFSlRhHZoHF72duaA
         7Ofg==
X-Forwarded-Encrypted: i=1; AJvYcCXEJfeE7IpVIkB3dqJkwGUcUelV7v8dYt2BMOREw6DoKwdHqLoNoqd0e3xGitEkXDZmyN3aFeB0vdxY@vger.kernel.org
X-Gm-Message-State: AOJu0YxnBBd9Ye04rm3dMWpjp7I0U3BlikWLmsr6gJsQAGrr+4zA1E9r
	NeNCv2FRTrKhFF5FFEb4wZ4LA20qdqnjILP4RbkO9yZasdUofB3y/LiVLFo2oUwCpPOCg8D1gOV
	8HlVzO8PQGauKthykJjpTfdWUv/FLq1b6MLiVlnDMMCHEABi0EwQ8RHEJ
X-Gm-Gg: ASbGnctRfcTPQ6XNF+fPPQxxN1UUhjnvqqmDVgxyf9+uC9bghIx3hUF9UzUmKLbU1Np
	zIiOal5UuvdswR+6ZPTl+V+ayvULNzHmA2hJmBU2HazzPQaVLugS/YBX/DIPJiAPN/r11Sro74R
	8I6p2A2FHWjcQA7HQDBAG+qfzpBOr4lBk/1aukFeT9HC2omhi77GvTe6e9bfLuDeIFm6Gwgz3P5
	ZWDenqRudyp3fz6AYja+mpNgsa0YBzKjzF2Qy7DZ7PWaT1OoQ6ChF0=
X-Google-Smtp-Source: AGHT+IGgF8erkndeXtDHUhr2zcrIUM8ResXlh7Bz4HomPF7yCVlDTJkQURdkJEh09salFbWDGoRHkWMVVF8B7dR8AWU=
X-Received: by 2002:a05:600c:1d89:b0:45f:2e6d:ca01 with SMTP id
 5b1f17b1804b1-45f320b652dmr526125e9.4.1757973285340; Mon, 15 Sep 2025
 14:54:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910044531.264043-1-jiaqiyan@google.com> <88893809-ed13-dbb9-2446-8fd680f57693@huawei.com>
 <CAJZ5v0g_f3Ut_8nf1NM5nJb3OSS83ccS65sT=DZOu0LWuCWZ1Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0g_f3Ut_8nf1NM5nJb3OSS83ccS65sT=DZOu0LWuCWZ1Q@mail.gmail.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Mon, 15 Sep 2025 14:54:33 -0700
X-Gm-Features: AS18NWCdNBEuqmPpmxPwl50_DW0k8xUy7qHt0rAzSKB6QaxQrlurGRR4GNa8Zcw
Message-ID: <CACw3F52BxoT8KsnMPnuSti2cOWWV=V=WPRZ4Z3biZ-X=6HMCww@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: APEI: EINJ: Allow more types of addresses except MMIO
To: "Rafael J. Wysocki" <rafael@kernel.org>, Hanjun Guo <guohanjun@huawei.com>
Cc: tony.luck@intel.com, dan.j.williams@intel.com, bp@alien8.de, 
	mchehab@kernel.org, xueshuai@linux.alibaba.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 12:33=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Wed, Sep 10, 2025 at 4:57=E2=80=AFPM Hanjun Guo <guohanjun@huawei.com>=
 wrote:
> >
> > On 2025/9/10 12:45, Jiaqi Yan wrote:
> > > EINJ driver today only allows injection request to go through for two
> > > kinds of IORESOURCE_MEM: IORES_DESC_PERSISTENT_MEMORY and
> > > IORES_DESC_SOFT_RESERVED. This check prevents user of EINJ to test
> > > memory corrupted in many interesting areas:
> > >
> > > - Legacy persistent memory
> > > - Memory claimed to be used by ACPI tables or NV storage
> > > - Kernel crash memory and others
> > >
> > > There is need to test how kernel behaves when something consumes memo=
ry
> > > errors in these memory regions. For example, if certain ACPI table is
> > > corrupted, does kernel crash gracefully to prevent "silent data
> > > corruption". For another example, legacy persistent memory, when mana=
ged
> > > by Device DAX, does support recovering from Machine Check Exception
> > > raised by memory failure, hence worth to be tested.
> > >
> > > However, attempt to inject memory error via EINJ to legacy persistent
> > > memory or ACPI owned memory fails with -EINVAL.
> > >
> > > Allow EINJ to inject at address except it is MMIO. Leave it to the BI=
OS
> > > or firmware to decide what is a legitimate injection target.
> > >
> > > In addition to the test done in [1], on a machine having the followin=
g
> > > iomem resources:
> > >
> > >      ...
> > >      01000000-08ffffff : Crash kernel
> > >      768f0098-768f00a7 : APEI EINJ
> > >      ...
> > >    768f4000-77323fff : ACPI Non-volatile Storage
> > >    77324000-777fefff : ACPI Tables
> > >    777ff000-777fffff : System RAM
> > >    77800000-7fffffff : Reserved
> > >    80000000-8fffffff : PCI MMCONFIG 0000 [bus 00-ff]
> > >    90040000-957fffff : PCI Bus 0000:00
> > >    ...
> > >    300000000-3ffffffff : Persistent Memory (legacy)
> > >    ...
> > >
> > > I commented __einj_error_inject during the test and just tested when
> > > injecting a memory error at each start address shown above:
> > > - 0x80000000 and 0x90040000 both failed with EINVAL
> > > - request passed through for all other addresses
> > >
> > > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > > ---
> > >
> > > Changelog
> > >
> > > v2 [2] -> v3:
> > > - Remove unnecessary IORES_DESC_CXL per comment from Hanjun [3].
> > > - Minor update to code comment.
> > >
> > > v1 [1] -> v2:
> > > - In addition to allow IORES_DESC_PERSISTENT_MEMORY_LEGACY, open the
> > >    door wider and only exclude MMIO per suggestion from Tony [4].
> > > - Rebased to commit 11e7861d680c ("Merge tag 'for-linus' of git://git=
.kernel.org/pub/scm/virt/kvm/kvm").
> > >
> > > [1] https://lore.kernel.org/linux-acpi/20250825223348.3780279-1-jiaqi=
yan@google.com
> > > [2] https://lore.kernel.org/linux-acpi/20250830030226.918555-1-jiaqiy=
an@google.com
> > > [3] https://lore.kernel.org/linux-acpi/bc8ad4b8-c000-0298-efd1-4a332c=
4c7820@huawei.com
> > > [4] https://lore.kernel.org/linux-acpi/SJ1PR11MB60835824926BEE57F094D=
E6FFC39A@SJ1PR11MB6083.namprd11.prod.outlook.com
> > >
> > > drivers/acpi/apei/einj-core.c | 51 ++++++++++++++++++++++++++++------=
-
> > >   1 file changed, 42 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-c=
ore.c
> > > index 2561b045acc7b..3c87953dbd197 100644
> > > --- a/drivers/acpi/apei/einj-core.c
> > > +++ b/drivers/acpi/apei/einj-core.c
> > > @@ -656,6 +656,43 @@ static int __einj_error_inject(u32 type, u32 fla=
gs, u64 param1, u64 param2,
> > >       return rc;
> > >   }
> > >
> > > +/* Allow almost all types of address except MMIO. */
> > > +static bool is_allowed_range(u64 base_addr, u64 size)
> > > +{
> > > +     int i;
> > > +     /*
> > > +      * MMIO region is usually claimed with IORESOURCE_MEM + IORES_D=
ESC_NONE.
> > > +      * However, IORES_DESC_NONE is treated like a wildcard when we =
check if
> > > +      * region intersects with known resource. So do an allow list c=
heck for
> > > +      * IORES_DESCs that definitely or most likely not MMIO.
> > > +      */
> > > +     int non_mmio_desc[] =3D {
> > > +             IORES_DESC_CRASH_KERNEL,
> > > +             IORES_DESC_ACPI_TABLES,
> > > +             IORES_DESC_ACPI_NV_STORAGE,
> > > +             IORES_DESC_PERSISTENT_MEMORY,
> > > +             IORES_DESC_PERSISTENT_MEMORY_LEGACY,
> > > +             /* Treat IORES_DESC_DEVICE_PRIVATE_MEMORY as MMIO. */
> > > +             IORES_DESC_RESERVED,
> > > +             IORES_DESC_SOFT_RESERVED,
> > > +     };
> > > +
> > > +     if (region_intersects(base_addr, size, IORESOURCE_SYSTEM_RAM, I=
ORES_DESC_NONE)
> > > +                           =3D=3D REGION_INTERSECTS)
> > > +             return true;
> > > +
> > > +     for (i =3D 0; i < ARRAY_SIZE(non_mmio_desc); ++i) {
> > > +             if (region_intersects(base_addr, size, IORESOURCE_MEM, =
non_mmio_desc[i])
> > > +                                   =3D=3D REGION_INTERSECTS)
> > > +                     return true;
> > > +     }
> > > +
> > > +     if (arch_is_platform_page(base_addr))
> > > +             return true;
> > > +
> > > +     return false;
> > > +}
> > > +
> > >   /* Inject the specified hardware error */
> > >   int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, =
u64 param3,
> > >                     u64 param4)
> > > @@ -702,19 +739,15 @@ int einj_error_inject(u32 type, u32 flags, u64 =
param1, u64 param2, u64 param3,
> > >        * Disallow crazy address masks that give BIOS leeway to pick
> > >        * injection address almost anywhere. Insist on page or
> > >        * better granularity and that target address is normal RAM or
> > > -      * NVDIMM.
> > > +      * as long as is not MMIO.
> >
> > Thanks for updating this as well.
> >
> > >        */
> > >       base_addr =3D param1 & param2;
> > >       size =3D ~param2 + 1;
> > >
> > > -     if (((param2 & PAGE_MASK) !=3D PAGE_MASK) ||
> > > -         ((region_intersects(base_addr, size, IORESOURCE_SYSTEM_RAM,=
 IORES_DESC_NONE)
> > > -                             !=3D REGION_INTERSECTS) &&
> > > -          (region_intersects(base_addr, size, IORESOURCE_MEM, IORES_=
DESC_PERSISTENT_MEMORY)
> > > -                             !=3D REGION_INTERSECTS) &&
> > > -          (region_intersects(base_addr, size, IORESOURCE_MEM, IORES_=
DESC_SOFT_RESERVED)
> > > -                             !=3D REGION_INTERSECTS) &&
> > > -          !arch_is_platform_page(base_addr)))
> > > +     if ((param2 & PAGE_MASK) !=3D PAGE_MASK)
> > > +             return -EINVAL;
> > > +
> > > +     if (!is_allowed_range(base_addr, size))
> > >               return -EINVAL;
> > >
> > >       if (is_zero_pfn(base_addr >> PAGE_SHIFT))
> >
> > Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
>
> Applied as 6.18 material, thanks!

Thank you both, Hanjun and Rafael!

