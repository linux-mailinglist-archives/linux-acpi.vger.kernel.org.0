Return-Path: <linux-acpi+bounces-15831-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E11B2BFBF
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 13:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031CE1BC53F7
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 11:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4437B32BF25;
	Tue, 19 Aug 2025 11:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="nLMIKj0+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4C4326D66
	for <linux-acpi@vger.kernel.org>; Tue, 19 Aug 2025 11:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601281; cv=none; b=iG3yfaNLGbJRqWHFZoK2pxfsfowLRhz8lllylBaepXnMArGSjAyFlCRlfbkoN9fscO8TsIScPkipbnNmfEzbnOezS3/ey4DVaG0yLUbpW+lRF8F52HJgeqvPNlFUnqn3nKVhLGrGzV84+bRPXPom5QRC6dlWxCjTVlWd8dbfEuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601281; c=relaxed/simple;
	bh=rBoh3tTRWRVwm4WtZsNA9+gBHKDnPEyycJ/HGvoY0oA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQigBA9GhAKyfT9zojoIYWEADNPu1ZpKkHza6mR0BheLPo5UOmHJCL51dlYPP+FvHMMRWNsOqyU6p1YssTUMcC7NRH3RP2wEhk2qo/WYeY/p/6wDlkPDmGYgcF5RT+0lNv8R9VoX2ohzZNMkIGIg73oKt9hfNL7Gl5CwOGgb7oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=nLMIKj0+; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55ce5253a57so5321056e87.2
        for <linux-acpi@vger.kernel.org>; Tue, 19 Aug 2025 04:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755601276; x=1756206076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C80fm0GDc3jc75LWz0UrKrGBSlO4fahAHmLCSkDw+Sw=;
        b=nLMIKj0+t4UJ0ctZhdWnTZV6sZB3TRT4jDu7NfbqTiogeqeNNXlpcpcjIK1aK0M0Py
         7bilsbrW8cwEjqwg7ueh+GnChp+d7BKy0Un1ojRtLvaz9dAErWMuDU4VNpz3cj+SkdJg
         sIoAbDPdydsXCZcX7J6+rTBSbi5NkWbj5ve30rMefmj832lMwAnzq1vMPdLwWN1VWI0A
         P+iJwH7JSx07Njrt5XC9ZQLYnZnneSRJeUZb9XaxNe9titSFLUWxD8/lq++Dh9NT+hce
         UztzD1lRTsGejhJ46N8uruIDsvuHHosh89P1JjDvhSb+JeXQrg9mOHpgyz6c2UcaYrbN
         O/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755601276; x=1756206076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C80fm0GDc3jc75LWz0UrKrGBSlO4fahAHmLCSkDw+Sw=;
        b=CkFORvFi7V4XLgduXnQ3gYt+W3gXSQluPQ73Ifuhwc7LlPKLudbyDVm3esWlnq+fZT
         jrFdPlZLqLXC3dqsDL/FyGaQJj/2cKf3UQoEvF0tOsgV9pZFQUs/YwLz9Jn3gtvB1SwM
         gibgJLZ9TVhv99cXdDi4bN60k/KvyQ9S3/nsau+yL+0lcWCsgcoXANzjCntv5DJAxDm2
         t5KsdgJpwdRhjE7atr2VF+ZKFvh216LhSngFyB4HhHie+E4Afk9DF3s8rSwVBY/Eh9L1
         ckPd6yNXhMRW4hyZWx2TWgvkkLV738WCMA1lrlTncHhDKJQ0VaonpVlGjmyJfBudowa1
         mIZg==
X-Forwarded-Encrypted: i=1; AJvYcCXT/lIFZ2+vUlcyFQ6IL9C8s0OSdFWmJJNpeE655VPdoAr7Epu34qKln/4g34QRuMBgGzVLqXHIbFxr@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4QUDNy/fvj0XRcOjRjH9AfvMnp2ekwMUUabPlKY0uUhcy5G5T
	zA7ZXm/fs7iC5TcvgrhZlP5qWVs2gadXZId1U4QMdbMVnUfXnanMTabnZ/BH83OI7xzQZIEk43g
	vttiX4MbbSeFporaVgsCT0AxLap4+zgrCIaC+9FtJyA==
X-Gm-Gg: ASbGncuVJrxlrwGc+XbgjACpX6+dXgr9yEQhJvuHkM2j0hVQq9zlxRNZYXQXhkmVjPa
	6NOR4xNWFkw9RvjO7onBB+FqeBgF6SM0l0NpzhzDqCP9lpPFBGTXZ1yahp4XwgXKcmTViDHuBwn
	poe6M4xNeopBsTuV+cgcE0oZQnr1gvP7pdS7UPwGCCdqqoWrmf/QBEQDlB9dF1bjHukVpH7rRW5
	5NXT7e5
X-Google-Smtp-Source: AGHT+IHlIIdtCFdyCt7BneXnJGieYkzZry9p86M1MLWKm3IaZVgcEXSSysCiKPyBhgKLxKZbQYCB+SGi8IsuSWQ4UsE=
X-Received: by 2002:a2e:b8d3:0:b0:332:42a6:5ca2 with SMTP id
 38308e7fff4ca-335304fbb66mr5924491fa.10.1755601276145; Tue, 19 Aug 2025
 04:01:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818143600.894385-1-apatel@ventanamicro.com>
 <20250818143600.894385-3-apatel@ventanamicro.com> <aKPu2g1MOZBBzQbV@pie>
 <CAK9=C2XmDGOz9_euC4vtchOxr+8f+m+9zZYVewCc2s7GZhd4Pw@mail.gmail.com> <aKP553e1S5RCYNhU@pie>
In-Reply-To: <aKP553e1S5RCYNhU@pie>
From: Anup Patel <apatel@ventanamicro.com>
Date: Tue, 19 Aug 2025 16:31:03 +0530
X-Gm-Features: Ac12FXyzoEVZIICp9ybAr45jkWILs6mVWIyXA9urG_cQME-dgkISLwPNd_y4zjA
Message-ID: <CAK9=C2Xt2RYm90wFBiYg+8Wpui1e3h8U72OkG5J5u2UFS=AfWg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] RISC-V: Add common csr_read_num() and
 csr_write_num() functions
To: Yao Zi <ziyao@disroot.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Alexandre Ghiti <alex@ghiti.fr>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atish.patra@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org, 
	Andrew Jones <ajones@ventanamicro.com>, Will Deacon <will@kernel.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 9:43=E2=80=AFAM Yao Zi <ziyao@disroot.org> wrote:
>
> On Tue, Aug 19, 2025 at 09:00:03AM +0530, Anup Patel wrote:
> > On Tue, Aug 19, 2025 at 8:56=E2=80=AFAM Yao Zi <ziyao@disroot.org> wrot=
e:
> > >
> > > On Mon, Aug 18, 2025 at 08:06:00PM +0530, Anup Patel wrote:
> > > > In RISC-V, there is no CSR read/write instruction which takes CSR
> > > > number via register so add common csr_read_num() and csr_write_num(=
)
> > > > functions which allow accessing certain CSRs by passing CSR number
> > > > as parameter. These common functions will be first used by the
> > > > ACPI CPPC driver and RISC-V PMU driver.
> > > >
> > > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > > Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> > > > ---
> > > >  arch/riscv/include/asm/csr.h |   3 +
> > > >  arch/riscv/kernel/Makefile   |   1 +
> > > >  arch/riscv/kernel/csr.c      | 165 +++++++++++++++++++++++++++++++=
++++
> > > >  drivers/acpi/riscv/cppc.c    |  17 ++--
> > > >  drivers/perf/riscv_pmu.c     |  54 ++----------
> > > >  5 files changed, 184 insertions(+), 56 deletions(-)
> > > >  create mode 100644 arch/riscv/kernel/csr.c
> > > >
> > > > diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/=
csr.h
> > > > index 6fed42e37705..1540626b3540 100644
> > > > --- a/arch/riscv/include/asm/csr.h
> > > > +++ b/arch/riscv/include/asm/csr.h
> > > > @@ -575,6 +575,9 @@
> > > >                             : "memory");                      \
> > > >  })
> > > >
> > > > +extern unsigned long csr_read_num(unsigned long csr_num, int *out_=
err);
> > > > +extern void csr_write_num(unsigned long csr_num, unsigned long val=
, int *out_err);
> > >
> > > I think it's more consistent to directly return the error code, and f=
or
> > > csr_read_num, we could pass out the read value by a pointer. e.g.
> > >
> > >         int csr_read_num(unsigned long csr_num, unsigned long *val);
> > >         int csr_write_num(unsigned long csr_num, unsigned long val);
> > >
> > > This allows the caller to eliminate a variable for temporarily storin=
g
> > > the error code if they use it just after the invokation, and fits the
> > > common convention of Linux better.
> >
> > Drew had similar comments so see my response in the previous
> > patch revision. (Refer, https://www.spinics.net/lists/kernel/msg5808113=
.html)
>
> Thanks for the reference.
>
> > I had considered this but the problem with this approach is that
> > individual switch cases in csr_read_num() become roughly 4
> > instructions because value read from CSR has to written to a memory
> > location.
>
> You could return a structure smaller than or equal to 2 * XLEN from
> csr_read_num(), according to the ABI it could be passed in a0 and a1 and
> thus should require no memory operation.
>
> Let's assume we have
>
>         struct __csr_read_ret {
>                 long error;
>                 unsigned long value;
>         };
>
>         struct __csr_read_ret __csr_read_num(unsigned long csr_num);
>
> Then a wrapper like
>
>         /* piece of untested code */
>         static inline int csr_read_num(unsigned long csr_num,
>                                        unsigned long *val)
>         {
>                 struct __csr_read_ret ret =3D __csr_read_num(csr_num);
>                 *val =3D ret.value;
>                 return ret.error;
>         }
>
> could provide an interface that I've talked about earlier, and it
> follows the kernel's convention.

Like I mentioned previously, the current implementation tries to
minimize instructions for each switch case and avoid unnecessary
memory load/store. Your alternate suggestion is no better in this
respect.

>
> > The current approach results in just 2 instructions for each
> > switch-case. Additionally, the current prototypes of csr_read_num()
> > and csr_write_num() are closer to csr_read() and csr_write()
> > respectively.
>
> But csr_read() and csr_write() never directly raise errors that is
> expected to be handled by the caller. I don't think it's a fair
> comparison.

csr_read_num() and csr_write_num() are different because
these functions take CSR number as parameter so caller can
pass an unsupported value to these functions which needs to
be reported back as an error.

Regards,
Anup

