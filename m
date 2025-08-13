Return-Path: <linux-acpi+bounces-15628-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E87B241C6
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Aug 2025 08:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05C5D4E47E9
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Aug 2025 06:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0532D3EEA;
	Wed, 13 Aug 2025 06:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PbP84mgz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F05029DB88
	for <linux-acpi@vger.kernel.org>; Wed, 13 Aug 2025 06:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755067452; cv=none; b=IxCVum+8lRPE5btoFspL5zoBBuNcm2orPSsjlLhpghW9M1cm4BxQAuwnccjalqcGlgnPLWVVzSUJoa2OIzNRgwT+U+eAktTfhFVlBPBz5cor3zRjUHJUpQC+v2oP3Hnyxe04XxR84bVtAkSJkzDmAxf8KJQUBI+sKSIxyxcVFYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755067452; c=relaxed/simple;
	bh=Ntbu4TME5th/Z7sHM0FyWRCc2KPoc/Bn/1D8r1hHyTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=amH1qBsb25Oo/5QqH3s2Wlj/wGOIFQIk8XxlvjADodaw6qQZIX2f/q3KSNpgBXS9q0fZfWQpkiH29vAFxZefxDcOAuVynVEnh9Dz47rxAeNU7gg3Lvtk9MSkk7D4LBUZZTaBo0RN4lymgzDum1Ky6q5l6BluZFeI6EJwpr9rLhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PbP84mgz; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-741b1657dd8so3193663a34.2
        for <linux-acpi@vger.kernel.org>; Tue, 12 Aug 2025 23:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755067449; x=1755672249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kN4SWWkhP+H9aW8tQSuXufONqI8/WS93SoimYt/qVpo=;
        b=PbP84mgzhPB7Uc+xt5PaKIQfmfLe3TdIo9089ZTK+rKUEU/sxQ0eyEvo67mHsiea8O
         92ooMsmQ4xRDD+sbgGaEzTWABJB5PSpZZe+adHEb8R0Bvi9VoaTjvw/gecSyQxwem+4W
         Ty5Y4qVJT+q2mXKsFFX7SLpvXX1nrQ4bUPZ0MvK34u5TDo7YlNoJKousB7OfPJBDgAnz
         N3ltHpkCl3u7YGFYSYMS9MdZ8jBDEVntz4BKIzIxGSUVrfYwPioAIYoSsGP6+dMsegwl
         52kHN+J1jXLdhSEiktT9HiXi5WZv3APuDSz3jU/5Znw+HhSeecQ9f+sF0wZVQcxApVIK
         v9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755067449; x=1755672249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kN4SWWkhP+H9aW8tQSuXufONqI8/WS93SoimYt/qVpo=;
        b=N4Fh0ZTobXHhzBA5qfRvMI1d3FjYzOV+U74jLklYzEl8bSbb3VptiWS55dpV69uVov
         92hIiYgNkN/jqIWgPf8BdqRJp/XI0gXddOXyuQ3rZJrufySPQN8ZPLRsIs4EogiI4xrb
         GvhXB8ugisIWr/IhPEQKBVms3BzZc3mf2Hup/XDCjZAy7VV9YMTDodqIocPytxtqVZLQ
         V8i7dSMGhf00zHjYa9Iyff+8WZdZUzjIJnNCS3Xn/DuYVqNfGx4zZ8L/unhLUbjOljbr
         guw/oiNGGob53D7GLvqQO3G6lSaIyVXGXeYBTgDVWuXCGYUraSrqjLwIlmZBa2T1E8DL
         VSDw==
X-Forwarded-Encrypted: i=1; AJvYcCVRM+EoE7YQQroif98KFMMo+QLRX7rcxnIWg8rPhpxpVyiyxqLjRnMcvLCbL7PCpZtxfRBliuN7/13a@vger.kernel.org
X-Gm-Message-State: AOJu0YxcqKffVpyT4uD1yFKIvvZeDiNZxjlRe8DxABxnoJjbfVZ1Jb+A
	RZ6qakuzI1gpKU1lcMvS00oCKTxMSS//ZtRYNMb8B1S+4ixnzKwFhey1FmD9iMvvCgZDgSeNSkA
	nVCxwdVEeUY7r1a6jt8tKdEhplkKm6t/iyWweslQ2cw==
X-Gm-Gg: ASbGncsxVGfcZPVaxYmlcUHANwPKXYtd79qRHCGfgjmiF1+xk+IjnQq+JIT82C8R8oy
	XfTQlfD4byMhZvLXBnR/UliqS+i9THezoyL2lKqSIVn4NeTeII3U7eCqf9c3DHwIV7TmExDw8fK
	DP9leBmmIUpHWal/T3reDjJEk9dwI95A7yDXdoLO/haAwbR0d7YMznFvotddnuyFgzwsq38WFwt
	pUoR+A7ZBcs7OY1ADKP/PNl
X-Google-Smtp-Source: AGHT+IE1kH655r3yAN3e42gjKNXI3YeADBZSD3EwRPhXTz20ecAS64Pguy13srIYgyLsWKp0VZhzjHp56BATXuR+FCg=
X-Received: by 2002:a05:6808:1818:b0:434:3f2:4d05 with SMTP id
 5614622812f47-435d4211298mr1290082b6e.20.1755067449027; Tue, 12 Aug 2025
 23:44:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515094301.40016-1-cuiyunhui@bytedance.com>
 <CAEEQ3w=XqoKmVu1kvc5XUbGbQJsHVkRx=T65tXvYEYo0HCTcnQ@mail.gmail.com>
 <aJs-aPH32OxpzR3G@sunil-laptop> <CAEEQ3wnHFPBPC0U59rDBJaZYxJ24uJzJ7NDQO0gfmVqoiQwNOw@mail.gmail.com>
 <aJtKZhvNX0p3obFw@sunil-laptop> <CAEEQ3wmomscuAzuiRyJu4ha8tiM=s1Y-ytQROPTWr1DScMNL3g@mail.gmail.com>
 <aJwiXKWXik8BmpL8@sunil-laptop>
In-Reply-To: <aJwiXKWXik8BmpL8@sunil-laptop>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 13 Aug 2025 14:43:58 +0800
X-Gm-Features: Ac12FXyGVnizD6EyhuBpve20mgaqlAC7Lqkjh6Jm18br-KgPX42SL0ncGyqGwNM
Message-ID: <CAEEQ3wky3LXK=ge1wBkHD0ZWtwUF-aBn44EK0Uxa+_2DB1Giqw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] ACPI: RISC-V: CPPC: Add CSR_CYCLE for CPPC FFH
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: rafael@kernel.org, lenb@kernel.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>, 
	Rahul Pathak <rpathak@ventanamicro.com>, juwenlong@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sunil,

On Wed, Aug 13, 2025 at 1:28=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> Hi Yunhui,
>
> On Wed, Aug 13, 2025 at 11:23:39AM +0800, yunhui cui wrote:
> > Hi Sunil,
> >
> > On Tue, Aug 12, 2025 at 10:06=E2=80=AFPM Sunil V L <sunilvl@ventanamicr=
o.com> wrote:
> > >
> [...]
> > > > > >
> > > > > > The purpose of cppc_ffh_csr_read() is to calculate the actual
> > > > > > frequency of the CPU, which is delta_CSR_CYCLE/delta_CSR_XXX.
> > > > > >
> > > > > > CSR_XXX should be a reference clock and does not count during W=
FI
> > > > > > (Wait For Interrupt).
> > > > > >
> > > > > > Similar solutions include: x86's aperf/mperf, and ARM64's AMU w=
ith
> > > > > > registers SYS_AMEVCNTR0_CORE_EL0/SYS_AMEVCNTR0_CONST_EL0.
> > > > > >
> > > > > > However, we know that CSR_TIME in the current code does count d=
uring
> > > > > > WFI. So, is this design unreasonable?
> > > > > >
> > > > > > Should we consider proposing an extension to support such a ded=
icated
> > > > > > counter (a reference clock that does not count during WFI)? Thi=
s way,
> > > > > > the value can be obtained directly in S-mode without trapping t=
o
> > > > > > M-mode, especially since reading this counter is very frequent.
> > > > > >
> > > > > Hi Yunhui,
> > > > >
> > > > > Yes, but we anticipated that vendors might define their own custo=
m CSRs.
> > > > > So, we introduced FFH encoding to accommodate such cases.
> > > > >
> > > > > Thanks,
> > > > > Sunil
> > > >
> > > > As mentioned earlier, it is best to directly read CSR_XXX (a refere=
nce
> > > > clock that does not count during WFI) and CSR_CYCLE in S-mode, rath=
er
> > > > than trapping to SBI.
> > > >
> > > No. I meant direct CSR access itself not SBI. Please take a look at
> > > Table 6 of RISC-V FFH spec.
> > >
> > > > drivers/acpi/riscv/cppc.c is a generic driver that is not specific =
to
> > > > any vendor. Currently, the upstream code already uses CSR_TIME, and
> > > > the logic of CSR_TIME is incorrect.
> > > >
> ACPI spec for "Reference Performance Register" says,
>
> "The Reference Performance Counter Register counts at a fixed rate any
> time the processor is active. It is not affected by changes to Desired
> Performance, processor throttling, etc."
>
> > > CSR_TIME is just an example. It is upto the vendor how _CPC objects a=
re
> > > encoded using FFH. The linux code doesn't mean one should use CSR_TIM=
E
> > > always.
> >
> > First, the example of CSR_TIME is incorrect. What is needed is a
> > CSR_XXX (a reference clock that does not count during WFI).
> >
> > Second, you mentioned that each vendor can customize their own
> > implementations. But should all vendors' CSR_XXX/YYY/... be added to
> > drivers/acpi/riscv/cppc.c? Shouldn=E2=80=99t drivers/acpi/riscv/cppc.c =
fall
> > under the scope defined by the RISC-V architecture?
> >
> No. One can implement similar to csr_read_num() in opensbi. We didn't
> add it since there was no HW implementing such thing. What I am
> saying is we have FFH encoding to support such case.
>
> > >
> > > > It would be best to promote a specification to support CSR_XXX, jus=
t
> > > > like what has been done for x86 and arm64. What do you think?
> > > >
> > > Wouldn't above work? For a standard extension, you may have to provid=
e
> > > more data with actual HW.
> >
> > This won=E2=80=99t work. May I ask how the current upstream code can ca=
lculate
> > the actual CPU frequency using CSR_TIME without trapping to SBI?
> > This is a theoretical logical issue. Why is data needed here?
> >
> As I mentioned above, one can implement a generic CSR read without
> trapping to SBI.
>
> > Could you take a look at the "AMU events and event numbers" chapter in
> > the ARM64 manual?
> >
> As-per ACPI spec reference performance counter is not affected by CPU
> state. The RISC-V FFH encoding is sufficiently generic to support this
> requirement, even if the standard CSR_TIME cannot be used. In such
> cases, an alternative CSR can be encodeded, accessed via an OS-level
> abstraction such as csr_read_num().

So what you're saying is that we should submit a patch like this, right?

diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
index 440cf9fb91aab..953c259d46c69 100644
--- a/drivers/acpi/riscv/cppc.c
+++ b/drivers/acpi/riscv/cppc.c
@@ -66,16 +66,8 @@ static void cppc_ffh_csr_read(void *read_data)
 {
        struct sbi_cppc_data *data =3D (struct sbi_cppc_data *)read_data;

-       switch (data->reg) {
-       /* Support only TIME CSR for now */
-       case CSR_TIME:
-               data->ret.value =3D csr_read(CSR_TIME);
-               data->ret.error =3D 0;
-               break;
-       default:
-               data->ret.error =3D -EINVAL;
-               break;
-       }
+       data->ret.value =3D csr_read_num(data->reg);
+       data->ret.error =3D 0;
 }

If that's the case, the robustness of the code cannot be guaranteed,
because the range of CSRs from different vendors is unknown.

Since each vendor will define their own CSRs, why not formalize them
into a specification?

>
> Thanks,
> Sunil

Thanks,
Yunhui

