Return-Path: <linux-acpi+bounces-10249-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D7F9FA0DF
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Dec 2024 15:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A767169B46
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Dec 2024 14:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BCA1F37A1;
	Sat, 21 Dec 2024 14:10:59 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867212E64A;
	Sat, 21 Dec 2024 14:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734790259; cv=none; b=uDxeD3w/IXqzzD2icyxTAuQ3emsitVs2sHJ6Ae+L7eeEuenD/ulnQmVdJvPztn4WGdSYaZgkx8blbcS1+maHKu8ztgRirOeUWtCHPa9Adiqovhvb5qPoZs8X2XgAxXWwItYACHiTCD9LokMm/9jMJrKFuqNQM/9lvNwTywx/j6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734790259; c=relaxed/simple;
	bh=nGWeQg8S6y6shLHbmW3aMKeXpkYiYJxrmAinLDsKRyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WU1sFUVc8TS1ZZ5w/Aq1sE9ceRo3PzZoA7wR2S/0DVA01PtNs8ZS1Mg5qq/IPooUh96MLxf+j0gjAVrIAmOja/gSDALXEaadzVpipTJ6Vy3tDZayvliCnr2iwAphUkxmVgmdTGKCP48uKHqTUufWCNKDf1k3euGVAlFm3ZmORLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3eb9101419cso1522082b6e.0;
        Sat, 21 Dec 2024 06:10:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734790256; x=1735395056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GpBog1LJdntPo57cyHdGkHydPz04prdcJbkki5MzpWU=;
        b=TpWjqCsCmVQlHcmwTeicWaB1bGRUpy9Oi35DrzlHLfkoEF8h/+p4znIMe+MXbek/aJ
         A30tDToASNtw6unuXN/XZR1wOw/bPAmFq2TMg+IlKY3YSjSWK+mnkoaphPX1vnP9599N
         wUMerZlMbds7bHuKCSn7BzZdaajBvgnaTdDA3ulTNiqDEVTVUZVDZ4buJpQdzuHswjBk
         3I9HM/0btUiiDwijEV+vSEc/aeR1W3ATu3hZS/ayMImrKdusmRFlvAI2ry9XUXZ9iLAB
         r8Ztbtk6QuzB6xXKSFg60RsObz1vjD0KwIFPQlOMqsw3zu+V4DPqSdGkQcQKKcp3wudn
         PH/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8ZSN0l/FNIiORiuNvvy3KQRzYb9ZBpFCQeFHqSl2fSJ6Wr+OW/eTAJ2N96xr0K4aPOpNEuAfB8dRNq9ke@vger.kernel.org, AJvYcCUBlmTusJsjqlliT1kVkqQKqBa6s1nHP9iysYQtSGu6ToBqLbm2sReOy8LGF8+tzF99XtZ8B1JfLVA=@vger.kernel.org, AJvYcCUKo+hJqR4NBH9a9hpFTDgQLWXDgmlRq3vs04JblGMFdeUZMc1dUepyjJsqYZiddBzWdTx5urW3aClvsjak@vger.kernel.org, AJvYcCV14ShbOzS4bKriNt5asOm+ndEZvn6dQfp/sE0DfUW6lgEOzuDCNKE3XqN9WryzYAqZ7PYwI1WuNFYAZw==@vger.kernel.org, AJvYcCVQTr2t0sITj8Y/MBfZk89Q/HMqvl8WAd9KfN5J6phDx1vKAW3VwvRynualpf5YCHv7HHpTYuvUu6mV3Q==@vger.kernel.org, AJvYcCVYeQ8Efrz9JaLWmOuERvHmRHZaLcjFGQdOnz6EDS0QjXwRfGH1bB+emoacM2oR0sjhwyw5BPLI/KzDmA==@vger.kernel.org, AJvYcCVr1QJv7ra5wIBAD0BpJUXHWFuol5feRflZDgCrYGmTj5zB7tt2WGMoox0uqCB9DmXntbgxL2Vdx2r0@vger.kernel.org, AJvYcCW8rzViTQOEtl7tXuBcGpTllGifmP5AhHxAygpyeL9laxX/ofWd9M7MBgMcGAWOgaoFchoTaysm2Ig=@vger.kernel.org, AJvYcCWQJCMnCiq3rMTQCTfD4Met3n/Ky+1yH3U5S4m5EO+ctS6W+Yw2gzDgds/aZr5DNddv7oRULKOTsz5/+5E=@vger.kernel.org, AJvYcCWTcptxjWrekurmlfnHJoUA
 kOKmqqKndGU8LoVbD7WScKp+F4kiF5BXqrhIFsGpXg0KEE0AsAcp+R9UsOIy1I0=@vger.kernel.org, AJvYcCX9K+h4NnX5LMuWxMQWvwYQjMJhOTA3iCsdAXrc2/d8qYaoxzjMg6jVAoGWiJmc3LeAoNxXvJUgJaKSPQ==@vger.kernel.org, AJvYcCXWUY39GeoYz6s4VTnTTwkg4mgRuFQLW+fVQnWJfA2hJts4kRHZYK+0u0LUp8rCXJOOTxMn/fFUXusi@vger.kernel.org, AJvYcCXyHUl/pvPtdcg16hb+5sjjcIBcsYLI0bJ+FvENJBMcw8LhTfasiCep4NtlswPe+KqchfmK2tpZlJtnxw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3XjopM29SS5z3fiKI3gKgO4WfZ/Dr0yheM2nZ/25pCQi8TvY5
	s/H9k3NwMtnLgb6xAt4xs8FVFduau1cEm1Vxl+bEK4g86NRGHAQy829BODNZ
X-Gm-Gg: ASbGncvEJV2phJivv+o9cKVa3uv3hjuTHoUfRvGE8LeTL/aJyGrmGxNpzcbHIi1tOHc
	Y/WOrgCZZPg2cKfHw78C9EU1PtZv0hPvnE3hk60gK6JYN3v6WEaTkA1VduSYL76k0N4gHqBZIyc
	MSIplGxp/ExGjY/q05AKkNh4EXSeyXR9z5LMntZFeSD3b+fWYCNwpSNnFV0yny6tnDbscI2mzDY
	MJ4wEjp12ALONgK61NrBU+qgDqNvdRJwVemiAoAcAUdb5DzXBcWo7kZL9NA0ts4E5rh0WwY7IN9
	eY3r7xaSyDcFQceKVbyCS8o=
X-Google-Smtp-Source: AGHT+IH318VFJbILSf0sP1FE+WYJEi2wjNgqOClVq+hkCsZd7dK/+ayurqjnTjV9+mscjiAoUQP/0w==
X-Received: by 2002:a05:6808:3a0d:b0:3ea:64cc:4954 with SMTP id 5614622812f47-3ed890b8703mr4298465b6e.35.1734790256222;
        Sat, 21 Dec 2024 06:10:56 -0800 (PST)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ece2704181sm1294420b6e.54.2024.12.21.06.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Dec 2024 06:10:55 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3eb7f3b1342so1200263b6e.1;
        Sat, 21 Dec 2024 06:10:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU5qjHC5OBeYp+fsU0OpwvBxiF8LJfAk0lpSSUsYAafpvA0T4jbtje9lVOviXu9Byx2wdSwbWky+X9xw5U=@vger.kernel.org,
 AJvYcCUAAGPX59ZfNvS16TjaiWtvAiE6M4FvRY6I7muA1i84i9BfENEgTm0CVyUQKmSedsifjBVZ5z4Q8nYxkA==@vger.kernel.org,
 AJvYcCUt8dhDHAOyzYgbuQo3CW4GnaDRlaLYQmu+vyva8ngINpYsg65wGnqlrNa4n4WRJbzjMD6ZhJBj61WKMQ==@vger.kernel.org,
 AJvYcCVK4lc15WqbGR9I1sOeLS1EfwTbOlvdDss78J2CUV4RAOF5s/CIj715yz2Ycl0dsRcIoQdPhmtfsINl@vger.kernel.org,
 AJvYcCVhk83g33hLQoaYdKuSQcAqT7DxCHQpxVF+L7bNFmns1K3Iwm+BWJiZQcIhHYa4nHkS2MfyGHkTjyzwLmkjY4U=@vger.kernel.org,
 AJvYcCW9K7C/JV0mbdHwZew7jwdlq0wr+2Ec4hil0cOUQzC2GgYS9auSYMMJjZ9DAIxq2DeLDRdVmioDXXdNR/FF@vger.kernel.org,
 AJvYcCWAT09k1OyRwzr+h4z+/VDVf+6LMYXGHloAQ02vdGbEIn/JgltizZ/L32m57B0g+OMGX5BbsW52PK4LBU78@vger.kernel.org,
 AJvYcCWLC7QGeElx3vXhxiOH5eUqzJ4mTk0md6HBC0lJY5phbzz4jHuZTWJPfmBAmgBZFAaV6yobf3ybtQs=@vger.kernel.org,
 AJvYcCWLSRCinRGZVH2gwEeKhVH132l7KBglAz0o0ZCXIjEzrVF4MeYzHq6JXwidhETOUthgKUrqmx/3U3DejQ==@vger.kernel.org,
 AJvYcCWgnIdgb0r3xvJvUQD2ACtDy8ZU4bbo4tScQyxxSanyuTo5OnM2SP7o6okoUGvduodBYsey6wF9udw=@vger.kernel.org,
 AJvYcCWk0q+dZBYwtXS4zPSOM/tpZbKgb3CeYvoQg890rGZkpusUi7yFyqGaVkEHKqtJT8PKzFH/AupTW1kNjA==@vger.kernel.org,
 AJvYcCWsVsySwKoxSiCZ7/hlAMfQ7Sr6pdToHkPEA4VtjBYQsbpAfYsdD5ic4pSIj1tmJ+gavwmyGtgWWjlS@vger.kernel.org,
 AJvYcCXFzo40MdKRZ0nH+B7H2KeC4Cw5gBcG8E+pJGPBNWLWTRg/GLVaMGYQTpEWNqbQ0lbWVdJ7NW+umeQ3jQ==@vger.kernel.org
X-Received: by 2002:a05:6102:cc8:b0:4af:ef85:dae4 with SMTP id
 ada2fe7eead31-4b2cc313a2cmr7064126137.5.1734789822327; Sat, 21 Dec 2024
 06:03:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241221104304.2655909-1-guoweikang.kernel@gmail.com>
In-Reply-To: <20241221104304.2655909-1-guoweikang.kernel@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 21 Dec 2024 15:03:30 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXbB-ksxZ9+YRz86wazPGSM09ZFX7JZoyH--=UDndS=TQ@mail.gmail.com>
Message-ID: <CAMuHMdXbB-ksxZ9+YRz86wazPGSM09ZFX7JZoyH--=UDndS=TQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/memblock: Add memblock_alloc_or_panic interface
To: Guo Weikang <guoweikang.kernel@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Sam Creasey <sammy@sammy.net>, 
	Huacai Chen <chenhuacai@kernel.org>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Oreoluwa Babatunde <quic_obabatun@quicinc.com>, 
	rafael.j.wysocki@intel.com, Palmer Dabbelt <palmer@rivosinc.com>, 
	Hanjun Guo <guohanjun@huawei.com>, Easwar Hariharan <eahariha@linux.microsoft.com>, 
	Johannes Berg <johannes.berg@intel.com>, Ingo Molnar <mingo@kernel.org>, 
	Dave Hansen <dave.hansen@intel.com>, Christian Brauner <brauner@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Richard Henderson <richard.henderson@linaro.org>, 
	Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	WANG Xuerui <kernel@xen0n.name>, Michael Ellerman <mpe@ellerman.id.au>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	Helge Deller <deller@gmx.de>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Geoff Levand <geoff@infradead.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Andreas Larsson <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, kasan-dev@googlegroups.com, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guo,

On Sat, Dec 21, 2024 at 11:43=E2=80=AFAM Guo Weikang
<guoweikang.kernel@gmail.com> wrote:
> Before SLUB initialization, various subsystems used memblock_alloc to
> allocate memory. In most cases, when memory allocation fails, an immediat=
e
> panic is required. To simplify this behavior and reduce repetitive checks=
,
> introduce `memblock_alloc_or_panic`. This function ensures that memory
> allocation failures result in a panic automatically, improving code
> readability and consistency across subsystems that require this behavior.
>
> Signed-off-by: Guo Weikang <guoweikang.kernel@gmail.com>

Thanks for your patch!

> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -417,6 +417,20 @@ static __always_inline void *memblock_alloc(phys_add=
r_t size, phys_addr_t align)
>                                       MEMBLOCK_ALLOC_ACCESSIBLE, NUMA_NO_=
NODE);
>  }
>
> +static __always_inline void *__memblock_alloc_or_panic(phys_addr_t size,
> +                                                      phys_addr_t align,
> +                                                      const char *func)
> +{
> +       void *addr =3D memblock_alloc(size, align);
> +
> +       if (unlikely(!addr))
> +               panic("%s: Failed to allocate %llu bytes\n", func, size);
> +       return addr;
> +}

Please make this out-of-line, and move it to mm/memblock.c, so we have
just a single copy in the final binary.

> +
> +#define memblock_alloc_or_panic(size, align)    \
> +        __memblock_alloc_or_panic(size, align, __func__)
> +
>  static inline void *memblock_alloc_raw(phys_addr_t size,
>                                                phys_addr_t align)
>  {
> diff --git a/init/main.c b/init/main.c

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

