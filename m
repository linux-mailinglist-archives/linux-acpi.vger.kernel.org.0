Return-Path: <linux-acpi+bounces-15752-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3F8B28BE1
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Aug 2025 10:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C6027B1FFA
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Aug 2025 08:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FDD1E8342;
	Sat, 16 Aug 2025 08:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dZZRx9oF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F633770B
	for <linux-acpi@vger.kernel.org>; Sat, 16 Aug 2025 08:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755333022; cv=none; b=KHXktHrL11hwo4IEKPerB5B/I/d/lOme0LW658i/dhQF3o7p0Zu5TDKulRfKjBNmR0v6JbPLmX9LDWfCG1sZaRt/nN951GzUhPdrxVGTPRstSFLzl2ACfkVNOgivyWjxhHRDC6VLK072YBQNsrntla9rCc6VPpGUVtmB/xFtIJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755333022; c=relaxed/simple;
	bh=ybTasye67ll+G1+S+rEoBvfI5uGN+1c1DzSfrmamFI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UCfhBxGIekUDHF9KKqKgnQ9JK2unobKtjI/DuqeCUNezONP/ew9bmJKYDbe2H9HKxlWeV8sEU+dmLk+YuuBv7qe7JBmcM43EPNfuK9fMzAzk9CyU4QknxbeQNwQ55uGOWA3mYdZFlV7dqUIw/SIom4Dy7I5TmCFE7b8s3gagGz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=dZZRx9oF; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-333f8d1ecffso19859111fa.0
        for <linux-acpi@vger.kernel.org>; Sat, 16 Aug 2025 01:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755333018; x=1755937818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERxMgw2kpDYIcEN4b7OBl7/5abBT2Agrn9m7lX6uaGA=;
        b=dZZRx9oFXlzdHw09lv3qSRrtcDWJmdN9CmRJ6UxLmePejsOuOihchy1MfnvoS8ToVj
         OlxEsUQSIsHbWmXjv4HSlH9OXX4iR7e9CicLzdAv1AFNIud5chBI9KYWKT7iJnuk2D3T
         EUEj0i3Tj7rCJoKsbYA7/KDvhalFEB0fe9DIOoS+w5PNMIKjUyKpqx5NgSjOPza0ATvv
         RBQb0ZL/ioq+JKSxOnZflXqOAVVTGdhllsPdLGMfGfUvkeDTtbIWRzwoEaLHs0n8ShrQ
         xxmLt2X7D00HhcDxZZiJ8QBi6DF1sXv0oiuPw1dbnzF1yJVO2DBhYs28XnjvH4CdHeNy
         2W6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755333018; x=1755937818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERxMgw2kpDYIcEN4b7OBl7/5abBT2Agrn9m7lX6uaGA=;
        b=MZwPkwfUmAf/HOE9QLI51AOJ6yVghKcmERnpCUl0hotRmnoIinM5N+/1qAyuHlk1BU
         bcS91XMWJrSwp5UMxIWHsuqdH8JUZXOAQiVABIVqrbDF2yUsTxs7IlUlMthQKArbKL5O
         wjepKCxo+7jUtOQKWjNPw69DJg1Kyipm31SFSgQhphadnKxqdYkYk3wyWFF8n4UyWp9b
         mccCduimUknTRExnmpaDyufEB8uQbqtCOhJwafNzZGTYeXClPffNqeO3kDpTmoJQuHvO
         f5JjgzntS7rFcsrBq2ZWHJyzTDmeP/g2BHQlEPtEBVEq26FrTZpHqpwlbD6uzj39mEJl
         rSgA==
X-Forwarded-Encrypted: i=1; AJvYcCVw0IrqmfP45Bk+5zvZkRBDZKFp72qxTWk5PvxhdXd7xH7/O4Zj9jt2RryXqGS7txFWZ2XDdHDdFENu@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc8wwkb2HlKYQkBLr2tyeF+w+y+IeW6ctjuSAtvz5AaEXTC1Dt
	w4a9ipx2Dvw+lmXUlB/0GjPCv1O1Vf5QHpC8c+j5Zr7rjcqOeT6GveU+8IYFFeeKXK+lQDvGLOt
	YY9JbUVEZZvW7+SlLsUOlxx6ffzxxKWKC4UFoMuOdpQ==
X-Gm-Gg: ASbGnctOokorhYWmsvdx59/XIZvJ+dFBJwchfksgiW5UC+l1h6eQBA/IsVX9niD7wJV
	weTOyxazSeBlooV3/pTydIYQfz7ybu5EZIXPHTjg2EDSqbZeUJ1cj1sa/Y5GTKKjgXO7r0nqw8R
	d+ZNE1pnYXmJNHolr7ucB6KZ4Qz1u1LOfuudZ6L0/P4dKkxZXKwG4iYwuY4t3X/2aTtoGToDUHv
	EndsTY=
X-Google-Smtp-Source: AGHT+IEST4Hz1W6gN8Tp0q2vE+c0oXk55HJWk6Wusd2HGHaqZsEJzSfdSxtmeot6CG5ZxyPg8a3TAz84PqZoJqjFmzo=
X-Received: by 2002:a2e:a00e:0:10b0:334:97:10c8 with SMTP id
 38308e7fff4ca-3340986afc2mr7761541fa.4.1755333018132; Sat, 16 Aug 2025
 01:30:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815161406.76370-1-apatel@ventanamicro.com>
 <20250815161406.76370-3-apatel@ventanamicro.com> <20250815-e69bdc695cf78e6ce07e580c@orel>
In-Reply-To: <20250815-e69bdc695cf78e6ce07e580c@orel>
From: Anup Patel <apatel@ventanamicro.com>
Date: Sat, 16 Aug 2025 14:00:07 +0530
X-Gm-Features: Ac12FXyKiNxNt01bHkxj5VizDPtJcwrdzgQ6aEx_XK-xKa-rmi7zdvozfKXtcOY
Message-ID: <CAK9=C2UA6EF=RQ0C9qK2CGEun3GGndq_G1UpTju23GNSfRaRbw@mail.gmail.com>
Subject: Re: [PATCH 2/2] RISC-V: Add common csr_read_num() and csr_write_num() functions
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>, Atish Patra <atish.patra@linux.dev>, 
	Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-acpi@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 16, 2025 at 1:32=E2=80=AFAM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Fri, Aug 15, 2025 at 09:44:06PM +0530, Anup Patel wrote:
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
>
> My preference would be for an interface with the return/err parameters th=
e
> other way around, i.e.
>
> int csr_read_num(unsigned long csr_num, unsigned long *val);
> int csr_write_num(unsigned long csr_num, unsigned long val);
>
> and then ensure all callers always check that the return value is zero
> before proceeding to use val or assume val was written.

I had considered this but the problem with this approach is that
individual switch cases in csr_read_num() become roughly 4
instructions because value read from CSR has to written to a
memory location.

The current approach results in just 2 instructions for each
switch-case. Additionally, the current prototypes of csr_read_num()
and csr_write_num() are closer to csr_read() and csr_write()
respectively.

>
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
> > +     if (out_err)
> > +             *out_err =3D 0;
> > +
> > +     switch (csr_num) {
> > +     switchcase_csr_read_32(CSR_CYCLE);
> > +     switchcase_csr_read_32(CSR_CYCLEH);
> > +     switchcase_csr_read_256(CSR_CUSTOM0_U_RW_BASE);
> > +     switchcase_csr_read_64(CSR_CUSTOM1_U_RO_BASE);
> > +     switchcase_csr_read_64(CSR_CUSTOM2_S_RW_BASE);
> > +     switchcase_csr_read_64(CSR_CUSTOM3_S_RW_BASE);
> > +     switchcase_csr_read_64(CSR_CUSTOM4_S_RO_BASE);
> > +     switchcase_csr_read_64(CSR_CUSTOM5_HS_RW_BASE);
> > +     switchcase_csr_read_64(CSR_CUSTOM6_HS_RW_BASE);
> > +     switchcase_csr_read_64(CSR_CUSTOM7_HS_RO_BASE);
> > +#ifdef CONFIG_RISCV_M_MODE
> > +     switchcase_csr_read_64(CSR_CUSTOM8_M_RW_BASE);
> > +     switchcase_csr_read_64(CSR_CUSTOM9_M_RW_BASE);
> > +     switchcase_csr_read_64(CSR_CUSTOM10_M_RO_BASE);
> > +#endif
> > +     default:
> > +             if (out_err)
> > +                     *out_err =3D -EINVAL;
> > +             else
> > +                     pr_err("%s: csr 0x%lx not supported\n", __func__,=
 csr_num);
> > +             break;
> > +     }
> > +
> > +     return 0;
> > +#undef switchcase_csr_read_256
> > +#undef switchcase_csr_read_128
> > +#undef switchcase_csr_read_64
> > +#undef switchcase_csr_read_32
> > +#undef switchcase_csr_read_16
> > +#undef switchcase_csr_read_8
> > +#undef switchcase_csr_read_4
> > +#undef switchcase_csr_read_2
> > +#undef switchcase_csr_read
> > +}
> > +EXPORT_SYMBOL_GPL(csr_read_num);
> > +
> > +void csr_write_num(unsigned long csr_num, unsigned long val, int *out_=
err)
> > +{
> > +#define switchcase_csr_write(__csr_num, __val)                       \
> > +     case (__csr_num):                                       \
> > +             csr_write(__csr_num, __val);                    \
> > +             break
> > +#define switchcase_csr_write_2(__csr_num, __val)             \
> > +     switchcase_csr_write(__csr_num + 0, __val);             \
> > +     switchcase_csr_write(__csr_num + 1, __val)
> > +#define switchcase_csr_write_4(__csr_num, __val)             \
> > +     switchcase_csr_write_2(__csr_num + 0, __val);           \
> > +     switchcase_csr_write_2(__csr_num + 2, __val)
> > +#define switchcase_csr_write_8(__csr_num, __val)             \
> > +     switchcase_csr_write_4(__csr_num + 0, __val);           \
> > +     switchcase_csr_write_4(__csr_num + 4, __val)
> > +#define switchcase_csr_write_16(__csr_num, __val)            \
> > +     switchcase_csr_write_8(__csr_num + 0, __val);           \
> > +     switchcase_csr_write_8(__csr_num + 8, __val)
> > +#define switchcase_csr_write_32(__csr_num, __val)            \
> > +     switchcase_csr_write_16(__csr_num + 0, __val);          \
> > +     switchcase_csr_write_16(__csr_num + 16, __val)
> > +#define switchcase_csr_write_64(__csr_num, __val)            \
> > +     switchcase_csr_write_32(__csr_num + 0, __val);          \
> > +     switchcase_csr_write_32(__csr_num + 32, __val)
> > +#define switchcase_csr_write_128(__csr_num, __val)           \
> > +     switchcase_csr_write_64(__csr_num + 0, __val);          \
> > +     switchcase_csr_write_64(__csr_num + 64, __val)
> > +#define switchcase_csr_write_256(__csr_num, __val)           \
> > +     switchcase_csr_write_128(__csr_num + 0, __val);         \
> > +     switchcase_csr_write_128(__csr_num + 128, __val)
> > +
> > +     if (out_err)
> > +             *out_err =3D 0;
> > +
> > +     switch (csr_num) {
> > +     switchcase_csr_write_256(CSR_CUSTOM0_U_RW_BASE, val);
> > +     switchcase_csr_write_64(CSR_CUSTOM2_S_RW_BASE, val);
> > +     switchcase_csr_write_64(CSR_CUSTOM3_S_RW_BASE, val);
> > +     switchcase_csr_write_64(CSR_CUSTOM5_HS_RW_BASE, val);
> > +     switchcase_csr_write_64(CSR_CUSTOM6_HS_RW_BASE, val);
> > +#ifdef CONFIG_RISCV_M_MODE
> > +     switchcase_csr_write_64(CSR_CUSTOM8_M_RW_BASE, val);
> > +     switchcase_csr_write_64(CSR_CUSTOM9_M_RW_BASE, val);
> > +#endif
> > +     default:
> > +             if (out_err)
> > +                     *out_err =3D -EINVAL;
> > +             else
> > +                     pr_err("%s: csr 0x%lx not supported\n", __func__,=
 csr_num);
> > +             break;
> > +     }
> > +#undef switchcase_csr_write_256
> > +#undef switchcase_csr_write_128
> > +#undef switchcase_csr_write_64
> > +#undef switchcase_csr_write_32
> > +#undef switchcase_csr_write_16
> > +#undef switchcase_csr_write_8
> > +#undef switchcase_csr_write_4
> > +#undef switchcase_csr_write_2
> > +#undef switchcase_csr_write
> > +}
> > +EXPORT_SYMBOL_GPL(csr_write_num);
> > diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
> > index 42c1a9052470..fe491937ed25 100644
> > --- a/drivers/acpi/riscv/cppc.c
> > +++ b/drivers/acpi/riscv/cppc.c
> > @@ -65,24 +65,19 @@ static void sbi_cppc_write(void *write_data)
> >  static void cppc_ffh_csr_read(void *read_data)
> >  {
> >       struct sbi_cppc_data *data =3D (struct sbi_cppc_data *)read_data;
> > +     int err;
> >
> > -     switch (data->reg) {
> > -     /* Support only TIME CSR for now */
> > -     case CSR_TIME:
> > -             data->ret.value =3D csr_read(CSR_TIME);
> > -             data->ret.error =3D 0;
> > -             break;
> > -     default:
> > -             data->ret.error =3D -EINVAL;
> > -             break;
> > -     }
> > +     data->ret.value =3D csr_read_num(data->reg, &err);
> > +     data->ret.error =3D err;
> >  }
> >
> >  static void cppc_ffh_csr_write(void *write_data)
> >  {
> >       struct sbi_cppc_data *data =3D (struct sbi_cppc_data *)write_data=
;
> > +     int err;
> >
> > -     data->ret.error =3D -EINVAL;
> > +     csr_write_num(data->reg, data->val, &err);
> > +     data->ret.error =3D err;
> >  }
> >
> >  /*
> > diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> > index 7644147d50b4..aa053254448d 100644
> > --- a/drivers/perf/riscv_pmu.c
> > +++ b/drivers/perf/riscv_pmu.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/smp.h>
> >  #include <linux/sched_clock.h>
> >
> > +#include <asm/csr.h>
> >  #include <asm/sbi.h>
> >
> >  static bool riscv_perf_user_access(struct perf_event *event)
> > @@ -88,46 +89,6 @@ void arch_perf_update_userpage(struct perf_event *ev=
ent,
> >       userpg->cap_user_time_short =3D 1;
> >  }
> >
> > -static unsigned long csr_read_num(int csr_num)
> > -{
> > -#define switchcase_csr_read(__csr_num, __val)                {\
> > -     case __csr_num:                                 \
> > -             __val =3D csr_read(__csr_num);            \
> > -             break; }
> > -#define switchcase_csr_read_2(__csr_num, __val)              {\
> > -     switchcase_csr_read(__csr_num + 0, __val)        \
> > -     switchcase_csr_read(__csr_num + 1, __val)}
> > -#define switchcase_csr_read_4(__csr_num, __val)              {\
> > -     switchcase_csr_read_2(__csr_num + 0, __val)      \
> > -     switchcase_csr_read_2(__csr_num + 2, __val)}
> > -#define switchcase_csr_read_8(__csr_num, __val)              {\
> > -     switchcase_csr_read_4(__csr_num + 0, __val)      \
> > -     switchcase_csr_read_4(__csr_num + 4, __val)}
> > -#define switchcase_csr_read_16(__csr_num, __val)     {\
> > -     switchcase_csr_read_8(__csr_num + 0, __val)      \
> > -     switchcase_csr_read_8(__csr_num + 8, __val)}
> > -#define switchcase_csr_read_32(__csr_num, __val)     {\
> > -     switchcase_csr_read_16(__csr_num + 0, __val)     \
> > -     switchcase_csr_read_16(__csr_num + 16, __val)}
> > -
> > -     unsigned long ret =3D 0;
> > -
> > -     switch (csr_num) {
> > -     switchcase_csr_read_32(CSR_CYCLE, ret)
> > -     switchcase_csr_read_32(CSR_CYCLEH, ret)
> > -     default :
> > -             break;
> > -     }
> > -
> > -     return ret;
> > -#undef switchcase_csr_read_32
> > -#undef switchcase_csr_read_16
> > -#undef switchcase_csr_read_8
> > -#undef switchcase_csr_read_4
> > -#undef switchcase_csr_read_2
> > -#undef switchcase_csr_read
> > -}
> > -
> >  /*
> >   * Read the CSR of a corresponding counter.
> >   */
> > @@ -139,7 +100,7 @@ unsigned long riscv_pmu_ctr_read_csr(unsigned long =
csr)
> >               return -EINVAL;
> >       }
> >
> > -     return csr_read_num(csr);
> > +     return csr_read_num(csr, NULL);
> >  }
> >
> >  u64 riscv_pmu_ctr_get_width_mask(struct perf_event *event)
> > --
> > 2.43.0
> >
>
> Other than the suggestion to flip the interface,
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Regards,
Anup

