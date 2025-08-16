Return-Path: <linux-acpi+bounces-15753-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F0AB28BF8
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Aug 2025 10:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2F905C753E
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Aug 2025 08:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47813238159;
	Sat, 16 Aug 2025 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ho1YfLzU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAA61E1E1C
	for <linux-acpi@vger.kernel.org>; Sat, 16 Aug 2025 08:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755333759; cv=none; b=KOEzZP2SIg6qffAZBODYu9ahs5UzHCFvxCH9MGZ9LNBAPc/YqzJULi35nV5shZuIyi/RnnjprCLAM4E4iQTdf9644pfk0PX9wIJbhfz/z96O0Rh+gAZS/WBPmkadLF50p9S2fv43Z0UjwVjWGjoM1ur+O9Y2QdiXqRlbAeFJkv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755333759; c=relaxed/simple;
	bh=d65PHt7h3Ht/KQGMdAlcMhYKtNBnOObEyI6Fnc7QJ88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DMcwYOraAr6fwvnlz4RQq0mMjD8tRC8X/qq1BpGLdHtCnQJZy2WGuekr662ixXlTUtzDgJ0NRtkwoSkdMP2Gcs+D+m3wsXlnAUk/40LQ9Vn1LacSu79rKPrm56Wzns+Px0m2otP5QGnwsY/Ge+wmKJtKvgZm4qyvTC4dwH0/AfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ho1YfLzU; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55ce4d3b746so3145473e87.1
        for <linux-acpi@vger.kernel.org>; Sat, 16 Aug 2025 01:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755333755; x=1755938555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihYXXz9o9cjYPSNj67KJq15CtaTxUe12z8+pHHWdiko=;
        b=ho1YfLzU9QdI1G4WkTsf9u87sN62kzsAc826Aw8Ol0Ch6bdVRTHweJNx9WZhPFcuL6
         Kn/JvrVPzeKB81fKI+Q8+0ehMgiXTtTpCN7EW09bzRoW91VI/7Nvo6T2OKlluPeGHCUu
         GOCKg29ju8d8wGiKV4g/Uz/WUhxqceFs792ZKlsErD5vkweJaGS2vJTiQm3yPc+IJHSN
         LmPDF8vnn8y0G5bgSC7KNV1ol+pbUX/aWKM4WDyNYurDAnLfSXqmoQF3IaBktigkb5ja
         LAB4dOYhO3bWkYKbhOYWPhKdapPfSt8K2HlcpddLiw9gtw5SkrvstwV0idbPzIpUs7Ai
         WT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755333755; x=1755938555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihYXXz9o9cjYPSNj67KJq15CtaTxUe12z8+pHHWdiko=;
        b=GnrZJuT6aFOBf3OnVQHfAI+fRJ7r12oiWZ6zoez6lrVd176tMImSfGYOQef0GpvZw9
         vuSU4kV75CcV2Jq5NHMh1/T+0EG6dPVJO/vvVPVxq8zM3SHH0q0JsIdWYR8vmM1XVuk3
         Yt1sPTxIpRmZWw4FEFNg8RZnIiNW5H5T84Vi3CRIuWrNBKcXcUbFjeXIIRUJqjBNpkVQ
         1LgTzP7TlMtphHip6NE5JHy/o89QYtsJ8L67cYzhu/rw7ETkIJ+w38zqPqPnt/XuUaYI
         IjIZMvzlNipZg7Y497/u2zvRUxzj+iUWNJVS1UriyEkAn+EQJiLssr54vT8ujGapk/QR
         8RYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVngrQeRm56xwN3qgxgKEMT4A4juvCoqVfAtWfgClU90ts+rhTYtlcv/c2cLz1WzTT0fbEjrVn+m/wL@vger.kernel.org
X-Gm-Message-State: AOJu0YxjyYqjAihLQqazbyCPFsmZET4mIDQJ7EhWnUvvlc7LRYfOTuZw
	kqhai5g40XRNcszYLnbO3nXKjUVIRepFBZp7CRAQ1spRCUtFbji7rKG0ph8exJMrf4GPDH/D40v
	MG0SEt/0o7z3E1v3HTJiGs7eRwQ1h434m11X1IpsVkw==
X-Gm-Gg: ASbGnctzx8FINodHyUXTFhZrrySTvPsI38ueWtuDRjzuwkx2OOIIP8rlr3kEeo2vMXr
	XA1vPXLjZzdepGSUYhAizs26tAVp83Prd1EBfuDl2y9p9Qh+BmYwZQOtfIO3SM6uYlc+0Nq6CT5
	FwcgzQH7fHgwDUYbDy2HV2FQunNE6Vy897YH/9klijRo+EFMOL9cOsidXFQNxIGU9v06BiOa8ii
	jov94E=
X-Google-Smtp-Source: AGHT+IHd93gFDsfSeH+6hKdXUyx7eyTlOzSh+cqWVIEalrd8dXAm7pt/QRaacvUrMvURzZJoFprZ5FpQX5OfW35bVyM=
X-Received: by 2002:a05:6512:3a2:b0:558:fad0:2518 with SMTP id
 2adb3069b0e04-55ce62e6b19mr1649919e87.27.1755333755198; Sat, 16 Aug 2025
 01:42:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815161406.76370-1-apatel@ventanamicro.com>
 <20250815161406.76370-3-apatel@ventanamicro.com> <89865f17-f405-445a-874d-9361fe247bfe@iscas.ac.cn>
In-Reply-To: <89865f17-f405-445a-874d-9361fe247bfe@iscas.ac.cn>
From: Anup Patel <apatel@ventanamicro.com>
Date: Sat, 16 Aug 2025 14:12:23 +0530
X-Gm-Features: Ac12FXyz8wuFa7cPjtTNVg42nY9wMyrUOE31nc7JPbMBqyFFW-8P3CDmu_S96ZE
Message-ID: <CAK9=C2VWSpREd0Hqg3TuLcVxG1=Ddfqn9ouNcowxHdCfJWgmJg@mail.gmail.com>
Subject: Re: [PATCH 2/2] RISC-V: Add common csr_read_num() and csr_write_num() functions
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Sunil V L <sunilvl@ventanamicro.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>, Atish Patra <atish.patra@linux.dev>, 
	Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-acpi@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 16, 2025 at 9:54=E2=80=AFAM Vivian Wang <wangruikang@iscas.ac.c=
n> wrote:
>
>
> On 8/16/25 00:14, Anup Patel wrote:
> > In RISC-V, there is no CSR read/write instruction which takes CSR
> > number via register so add common csr_read_num() and csr_write_num()
> > functions which allow accessing certain CSRs by passing CSR number
> > as parameter. These common functions will be first used by the
> > ACPI CPPC driver and RISC-V PMU driver.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  arch/riscv/include/asm/csr.h |   3 +
> >  arch/riscv/kernel/Makefile   |   1 +
> >  arch/riscv/kernel/csr.c      | 177 +++++++++++++++++++++++++++++++++++
> >  drivers/acpi/riscv/cppc.c    |  17 ++--
> >  drivers/perf/riscv_pmu.c     |  43 +--------
> >  5 files changed, 189 insertions(+), 52 deletions(-)
> >  create mode 100644 arch/riscv/kernel/csr.c
> >
> > diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.=
h
> > index 6fed42e37705..1540626b3540 100644
> > --- a/arch/riscv/include/asm/csr.h
> > +++ b/arch/riscv/include/asm/csr.h
> > @@ -575,6 +575,9 @@
> >                             : "memory");                      \
> >  })
> >
> > +extern unsigned long csr_read_num(unsigned long csr_num, int *out_err)=
;
> > +extern void csr_write_num(unsigned long csr_num, unsigned long val, in=
t *out_err);
> > +
> >  #endif /* __ASSEMBLY__ */
> >
> >  #endif /* _ASM_RISCV_CSR_H */
> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index c7b542573407..0a75e20bde18 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
> > @@ -50,6 +50,7 @@ obj-y       +=3D soc.o
> >  obj-$(CONFIG_RISCV_ALTERNATIVE) +=3D alternative.o
> >  obj-y        +=3D cpu.o
> >  obj-y        +=3D cpufeature.o
> > +obj-y        +=3D csr.o
> >  obj-y        +=3D entry.o
> >  obj-y        +=3D irq.o
> >  obj-y        +=3D process.o
> > diff --git a/arch/riscv/kernel/csr.c b/arch/riscv/kernel/csr.c
> > new file mode 100644
> > index 000000000000..f7de45bb597c
> > --- /dev/null
> > +++ b/arch/riscv/kernel/csr.c
> > @@ -0,0 +1,177 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2025 Ventana Micro Systems Inc.
> > + */
> > +
> > +#define pr_fmt(fmt) "riscv: " fmt
> > +#include <linux/err.h>
> > +#include <linux/export.h>
> > +#include <linux/printk.h>
> > +#include <linux/types.h>
> > +#include <asm/csr.h>
> > +
> > +#define CSR_CUSTOM0_U_RW_BASE                0x800
> > +#define CSR_CUSTOM0_U_RW_COUNT               0x100
> > +
> > +#define CSR_CUSTOM1_U_RO_BASE                0xCC0
> > +#define CSR_CUSTOM1_U_RO_COUNT               0x040
> > +
> > +#define CSR_CUSTOM2_S_RW_BASE                0x5C0
> > +#define CSR_CUSTOM2_S_RW_COUNT               0x040
> > +
> > +#define CSR_CUSTOM3_S_RW_BASE                0x9C0
> > +#define CSR_CUSTOM3_S_RW_COUNT               0x040
> > +
> > +#define CSR_CUSTOM4_S_RO_BASE                0xDC0
> > +#define CSR_CUSTOM4_S_RO_COUNT               0x040
> > +
> > +#define CSR_CUSTOM5_HS_RW_BASE               0x6C0
> > +#define CSR_CUSTOM5_HS_RW_COUNT              0x040
> > +
> > +#define CSR_CUSTOM6_HS_RW_BASE               0xAC0
> > +#define CSR_CUSTOM6_HS_RW_COUNT              0x040
> > +
> > +#define CSR_CUSTOM7_HS_RO_BASE               0xEC0
> > +#define CSR_CUSTOM7_HS_RO_COUNT              0x040
> > +
> > +#define CSR_CUSTOM8_M_RW_BASE                0x7C0
> > +#define CSR_CUSTOM8_M_RW_COUNT               0x040
> > +
> > +#define CSR_CUSTOM9_M_RW_BASE                0xBC0
> > +#define CSR_CUSTOM9_M_RW_COUNT               0x040
> > +
> > +#define CSR_CUSTOM10_M_RO_BASE               0xFC0
> > +#define CSR_CUSTOM10_M_RO_COUNT              0x040
> > +
> > +unsigned long csr_read_num(unsigned long csr_num, int *out_err)
> > +{
> > +#define switchcase_csr_read(__csr_num)                               \
> > +     case (__csr_num):                                       \
> > +             return csr_read(__csr_num)
> > +#define switchcase_csr_read_2(__csr_num)                     \
> > +     switchcase_csr_read(__csr_num + 0);                     \
> > +     switchcase_csr_read(__csr_num + 1)
> > +#define switchcase_csr_read_4(__csr_num)                     \
> > +     switchcase_csr_read_2(__csr_num + 0);                   \
> > +     switchcase_csr_read_2(__csr_num + 2)
> > +#define switchcase_csr_read_8(__csr_num)                     \
> > +     switchcase_csr_read_4(__csr_num + 0);                   \
> > +     switchcase_csr_read_4(__csr_num + 4)
> > +#define switchcase_csr_read_16(__csr_num)                    \
> > +     switchcase_csr_read_8(__csr_num + 0);                   \
> > +     switchcase_csr_read_8(__csr_num + 8)
> > +#define switchcase_csr_read_32(__csr_num)                    \
> > +     switchcase_csr_read_16(__csr_num + 0);                  \
> > +     switchcase_csr_read_16(__csr_num + 16)
> > +#define switchcase_csr_read_64(__csr_num)                    \
> > +     switchcase_csr_read_32(__csr_num + 0);                  \
> > +     switchcase_csr_read_32(__csr_num + 32)
> > +#define switchcase_csr_read_128(__csr_num)                   \
> > +     switchcase_csr_read_64(__csr_num + 0);                  \
> > +     switchcase_csr_read_64(__csr_num + 64)
> > +#define switchcase_csr_read_256(__csr_num)                   \
> > +     switchcase_csr_read_128(__csr_num + 0);                 \
> > +     switchcase_csr_read_128(__csr_num + 128)
> > +
>
> That's... a bit horrendous.
>
> Since we know that each inner case is quite simple, can we just do our
> own jump table for that? Each case can be one csrr/csrw and one jal
> (possibly pad to 8 bytes), and we can just jump to
> label + (csr_num - range_start) * 8. See bottom of this message for an
> untested prototype.
>
> Vivian "dramforever" Wang
>
> UNTESTED prototype:
>
> #define CSR_CYCLE 0xc00
> #define CSR_CYCLEH 0xc80
>
> /* Force expand argument if macro */
> #define str(_x) #_x
>
> unsigned long csr_read_num(long csr_num)
> {
>         unsigned long res, tmp;
>
>         /*
>          * Generate a jump table for each range. Each (inner) case is 8 b=
ytes of
>          * code, a csrr instruction and a jump, possibly padded, so we ju=
st jump
>          * to label_1f + (csr_num - _start) * 8
>          */
> #define csr_read_case_range(_start, _size)                               =
       \
>         case (_start) ... ((_start) + (_size) - 1):                      =
       \
>                 asm volatile (                                           =
       \
>                                 "       lla %[tmp], 1f\n"                =
       \
>                                 "       add %[tmp], %[tmp], %[offset]\n" =
       \
>                                 "       jr %[tmp]\n"                     =
       \
>                                 "1:\n"                                   =
       \
>                                 "       .rept (" str(_size) ")\n"        =
       \
>                                 "       csrr %[res], (" str(_start) " + \=
\+)\n" \
>                                 "       j 2f\n"                          =
       \
>                                 "       .balign 4\n"                     =
       \
>                                 "       .endr\n"                         =
       \
>                                 "2:\n"                                   =
       \
>                                 : [tmp] "=3D&r"(tmp), [res] "=3Dr"(res)  =
           \
>                                 : [offset] "r"((csr_num - _start) * 8)   =
       \
>                                 : );                                     =
       \
>                 break;                                                   =
       \
>
>
>         switch (csr_num) {
>         csr_read_case_range(CSR_CYCLE, 4)
>         csr_read_case_range(CSR_CYCLEH, 4)
>
>         /* ... other cases */
>
>         default:
>                 /* Error handling */
>         }
>
> #undef csr_read_case_range
>
>         return res;
> }

Clearly you have trust issues with compiler switch-case optimizations
and your proposed solution looks horrendous to me.

Your proposed solution is effectively a nested switch case where
there is a higher-level jump-table generated by the compiler which
selects a range case and within each range case you have a hand
assembled jump table. If you analyse the effective number of
instructions involved in accessing an CSR then it will be much
more than the current approach.

The current approach relies on a compiler optimized jump table
where each switch-case is just two instructions (12 bytes) for
both csr_read_num() and csr_write_num().

Regards,
Anup

