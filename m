Return-Path: <linux-acpi+bounces-15609-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E28BCB228CF
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Aug 2025 15:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604D13B962B
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Aug 2025 13:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F65280A51;
	Tue, 12 Aug 2025 13:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OagxA+Kd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D12C27FB26
	for <linux-acpi@vger.kernel.org>; Tue, 12 Aug 2025 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005545; cv=none; b=g9VqyTLCqjkrkuOVvcaSQu80aRNPXFRmv7bsGRINXIxkndU2P1U6XOVkqh0Mjahzsi4a/RdUUdzFb6p+5O8+QicwVXt47L1hrCEajrAFbt1F0vnqalJx+y40cObVynEAiZGjRM2vWYzYVyicyPKTLpWewQcYpLkaJaN9dA5P1Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005545; c=relaxed/simple;
	bh=97DZ8nBHALwhUra4p+uJuSqwJI3vH9u6tlHUwXfe+5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RbCzVSTtBjh30u/l5lpiem/li1nAIAPrE3v9yEjXRtBgKANXa6mXrzgAGgVz0YZytpPmKB48V5AK0MopIyS9uLQN2wUVceDjE6nI2CzTMaDvuEAX/oOLrQM2z9INOdpKCmDyuTg1+KKuP3IEDydhyEmNuoOOJAa1VtXbRJrwA4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OagxA+Kd; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-433fd4aeeb8so3468939b6e.0
        for <linux-acpi@vger.kernel.org>; Tue, 12 Aug 2025 06:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755005542; x=1755610342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKMJP6DIKNaNb9e/aM/CY6qYW/+/BiIO2tSY1DOCRC0=;
        b=OagxA+Kd1v/6rH6tdS8O3DVchj8koLoeEE1kTdE/LG6K4aQqxbVXEKaHvJF58cFOrO
         /tTjTlm1Z4ekgbJmujLVyIqFc6f7runN2pmDsGQOps5eJC6G+BBTpRbMf1wNoff9McmC
         OtzJF88xCfOcPQ6CG6A/8NmNFjfl4ynsWBxu2Hg0joOCP7tvrXj0CkRz35iJBMrHg4Hs
         71gPSPJjzMRXLas16iP9Y4Riyujw7sw5OBAOF+yymLPCR/3utSQgrSHxy5jTxZ5Z03Da
         B2TNL9vsjbEGmn+uHSu1sqD22rDpI4Kl3VzlyNbT1ZfdrPVM8beqnWe/CjYoXWQvERPA
         8shQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755005542; x=1755610342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKMJP6DIKNaNb9e/aM/CY6qYW/+/BiIO2tSY1DOCRC0=;
        b=BLorOZHuivB2zBC6IRnxBbevjfkg4lV+EsVp5b6Cq7UErauiP+ERlXDl8QcrniKlc+
         MTq7AU8zWgzGOhWS7ZtkAV8F4FwmmWnMDiuMGpotq5GwrzNzivemz2jeMLHavc65KAfd
         v4fGBTjuG7gvyTBr60ULCSrH1Rv9rCpi/P5lJCOlRvqZ5DTk7szYIkXuq9IVEMeGFVn7
         62s097UeiNYrGz+oUo4LbHQbp0nalnJgmmn1Q45qfchIUrVF/Z5y2m5t7xOYngh2IDkq
         LjdAcyvvx2MgI3wQpH9da3vTgLTP9HxcyUxOyV9aQAyOwUMoO1k82i0iHzZanvkihCCO
         xfzg==
X-Forwarded-Encrypted: i=1; AJvYcCXbufr9aV6343eGXOu6N8gXmwSrrqlebZCoWAutGyX4zNOStwOtHaXQbg4Ng+7jth8gSalRBAapvGVH@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ2Gs3jCXwiFwAGjUFd2iR8YrIs0ORgqoADOR/0CVoUzpOZkJ1
	EpqnePwB/D7fxObAuiKk+cZnoMpAZVzeffkT393tTzMqpGBPJkrgzBe/S1hbxx3dY8O/8p1PRdD
	9KlIgthA32+hRfy4TlRTAbte/+T9vCLJZ4/amq1qAgw==
X-Gm-Gg: ASbGncsfkZUUpF9+ub8vLCJ4nCCtavfLSQQb8yylmM/IS/l0GUQYsXrotMH1rW9tGOw
	gE0Klq0Y/UvSwFCGNMVEEHCLSvjHFoSW5Fz51RUdGNwFMEdVXFIyi6JsGysPk/dUnLz6G+Ptkqh
	7kgb3Rdg3FKd8v6dZ7T5bw+x7OVeBsTzQ8dIlAO68FdiFrJFkH7jWwRlG+YTlCRkHqpJryBovhR
	u3EJRnTbC8wVGa8IlTo
X-Google-Smtp-Source: AGHT+IF75Opbei0pOtMtFSYOAxsp8zj+N82lGQSRfSLagQ6UXFksL0Qth/N+YhLBTfQy9h6H44nrbm/bU7sjHpb/61c=
X-Received: by 2002:a05:6808:4f2b:b0:435:73d6:a3c5 with SMTP id
 5614622812f47-435c91d0663mr2191038b6e.28.1755005542352; Tue, 12 Aug 2025
 06:32:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515094301.40016-1-cuiyunhui@bytedance.com>
 <CAEEQ3w=XqoKmVu1kvc5XUbGbQJsHVkRx=T65tXvYEYo0HCTcnQ@mail.gmail.com> <aJs-aPH32OxpzR3G@sunil-laptop>
In-Reply-To: <aJs-aPH32OxpzR3G@sunil-laptop>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 12 Aug 2025 21:32:10 +0800
X-Gm-Features: Ac12FXzZDx2qdp0GWoD-x1Xk1VxI9-W9Mj81VMSYnU8MQ8i6GLOZDnFvumFdIFA
Message-ID: <CAEEQ3wnHFPBPC0U59rDBJaZYxJ24uJzJ7NDQO0gfmVqoiQwNOw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] ACPI: RISC-V: CPPC: Add CSR_CYCLE for CPPC FFH
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: rafael@kernel.org, lenb@kernel.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>, 
	Rahul Pathak <rpathak@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sunil,


On Tue, Aug 12, 2025 at 9:15=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> On Tue, Aug 12, 2025 at 07:25:44PM +0800, yunhui cui wrote:
> > Hi Sunil,
> >
> > On Thu, May 15, 2025 at 5:44=E2=80=AFPM Yunhui Cui <cuiyunhui@bytedance=
.com> wrote:
> > >
> > > Add the read of CSR_CYCLE to cppc_ffh_csr_read() to fix the
> > > warning message: "CPPC Cpufreq: cppc_scale_freq_wokrfn: failed
> > > to read perf counters".
> > >
> > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > ---
> > >  drivers/acpi/riscv/cppc.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
> > > index 4cdff387deff6..c1acaeb18eac3 100644
> > > --- a/drivers/acpi/riscv/cppc.c
> > > +++ b/drivers/acpi/riscv/cppc.c
> > > @@ -69,11 +69,14 @@ static void cppc_ffh_csr_read(void *read_data)
> > >         struct sbi_cppc_data *data =3D (struct sbi_cppc_data *)read_d=
ata;
> > >
> > >         switch (data->reg) {
> > > -       /* Support only TIME CSR for now */
> > >         case CSR_TIME:
> > >                 data->ret.value =3D csr_read(CSR_TIME);
> > >                 data->ret.error =3D 0;
> > >                 break;
> > > +       case CSR_CYCLE:
> > > +               data->ret.value =3D csr_read(CSR_CYCLE);
> > > +               data->ret.error =3D 0;
> > > +               break;
> > >         default:
> > >                 data->ret.error =3D -EINVAL;
> > >                 break;
> > > --
> > > 2.39.2
> > >
> >
> > The purpose of cppc_ffh_csr_read() is to calculate the actual
> > frequency of the CPU, which is delta_CSR_CYCLE/delta_CSR_XXX.
> >
> > CSR_XXX should be a reference clock and does not count during WFI
> > (Wait For Interrupt).
> >
> > Similar solutions include: x86's aperf/mperf, and ARM64's AMU with
> > registers SYS_AMEVCNTR0_CORE_EL0/SYS_AMEVCNTR0_CONST_EL0.
> >
> > However, we know that CSR_TIME in the current code does count during
> > WFI. So, is this design unreasonable?
> >
> > Should we consider proposing an extension to support such a dedicated
> > counter (a reference clock that does not count during WFI)? This way,
> > the value can be obtained directly in S-mode without trapping to
> > M-mode, especially since reading this counter is very frequent.
> >
> Hi Yunhui,
>
> Yes, but we anticipated that vendors might define their own custom CSRs.
> So, we introduced FFH encoding to accommodate such cases.
>
> Thanks,
> Sunil

As mentioned earlier, it is best to directly read CSR_XXX (a reference
clock that does not count during WFI) and CSR_CYCLE in S-mode, rather
than trapping to SBI.

drivers/acpi/riscv/cppc.c is a generic driver that is not specific to
any vendor. Currently, the upstream code already uses CSR_TIME, and
the logic of CSR_TIME is incorrect.

It would be best to promote a specification to support CSR_XXX, just
like what has been done for x86 and arm64. What do you think?

Thanks,
Yunhui

