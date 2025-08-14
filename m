Return-Path: <linux-acpi+bounces-15663-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2664B25B3D
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 07:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71A4189782A
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 05:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F70227B95;
	Thu, 14 Aug 2025 05:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="U1+zTnoz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B0822541C
	for <linux-acpi@vger.kernel.org>; Thu, 14 Aug 2025 05:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755150508; cv=none; b=TlKGTMZQz+EVJqmksj9Cpmq920FR7d5T/WxTZCK4o6n71/kTNktu0Oag7Rfk1N3XoAItc3Z6YFhTVBz7KWOSk5PHcSCdnto8aupsy5ZQTtdSB2/2PK6T7Vx0gWd9y1VRQpn8u1jxmSTDzlSH2aNe2QrW8o73Soj/LyUdET/gq38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755150508; c=relaxed/simple;
	bh=EnO7gUYfftgvv/e+AlrK2p84IrrBv8aNOUY7tpolDek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lelxh/uiJ+JPu3rlf+yER6uNlbdJXevWuRGreRXKFOsLY31B41yuqSxlShNQgEzVASFwGVmFO+5FgbCZ4+vdbqUnaEyS89v8Cc2R6G2mPv0AOV5POkPh/TVcUcdkta1lfDQcltnBIiM23fnIsS2lJe4/mHgQmdHa9XpPT9/9mFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=U1+zTnoz; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-333f8d39e94so3915251fa.0
        for <linux-acpi@vger.kernel.org>; Wed, 13 Aug 2025 22:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755150504; x=1755755304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jq8gnnel9LZRFbimfyn0o9ie2eLRCQN7eTZ1xYFVwp0=;
        b=U1+zTnozYoHlKXs6ICo358tqnwoR0Wl6i70YcnQqjXYhjHp1gAMFHVVB/E2DVrmpj5
         IcNOvLcqn7NhNWV1V+nYdPNaXJ4M7Pv1Y4CywpszOE2sOxNP6Fo+tqNAeYz676rwWHJc
         R+kThcDOVxQ2hAF6WQ4XmMAYCM0vBP0tjtVtTQo/KAZKv7nopUzfRfSJgF45hoafhOIu
         EBakdgkoVBVSHxZwnsH14eZI72Yrp0A6+nH62YjHKTSsA5blXExtjXOfPm6+HwStcCqs
         6tNnyORmwLWfnI+wGe4IPd1bZrMMupKjYX3IJBuPLBlKLtpojuTF7rYSxW1bw4/xQ52A
         +Z8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755150504; x=1755755304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jq8gnnel9LZRFbimfyn0o9ie2eLRCQN7eTZ1xYFVwp0=;
        b=WchngPoICf5uBgfNr6c2IN4LGVcAobP0YLE8L5zuN4bxUbMUe0mmiWLEXp4OD2m43w
         KG15gbgh+BZSvlQm2S22WMRjeK0RfDjBDU4ePeJMJf0SE9Ex5+k/gpt8615/Pj9P+H4T
         qdTdyzHJJ3ueXM/I6yMrCDRdedZ3G0Piq1V6yt7KFXUs42brQkHCTpxDpTPbWcb+26Lt
         6kyB/EHWJdV9VvqaODLJMWEgJ6UP+TUr4zZc/3lNc1Lr6Tbkk9kSWB3m2XQGfUhdZx61
         M+vzkEvi8LNTKVuRG+YRP7cJ5ugqYJaf6yH0QTY/NFNVgOurtZa93EcUapBRwujsv7ch
         i9ew==
X-Forwarded-Encrypted: i=1; AJvYcCVu3SIDrvH1dmVikCSB/0PAOpbJMvqzOO1lFU5AjYAjJ1Cc3WiAzjlnbNyVo0RagfhU1DyUChA7Fmen@vger.kernel.org
X-Gm-Message-State: AOJu0YzmIMDtQtY7invmG0NKkRga4XDc3I3WgVgBI1ame+iRmRIUctg0
	JUjgoAegkZi4oKPzoCvByJ9n/UZneos1sbShaW2lY0gnj9CoOHfaZ+28DUasYhIdBTrJ5Rd61iv
	ejxidHyy+/um1bqRebjoP5fIo+ud6oFlbYMxs5IVSYg==
X-Gm-Gg: ASbGncvjBbn9TuMQMz+8K8d1ORDBpeSSNVSILOqJPbOrEMMb9zLflQR2R5UwhOUg+C/
	6h70CcokRbk2TcG9IP0ghMZR4MPRAoE0Ea9y/x1Ny0kpQ80iAOrAszAK9oMz/qXyQi85tNcasDh
	Ls6u+ZkAvyTdklKvst2OSnKjJZa5qAfqZWo/8Ca3dO2ofn2TeyOQeFSwMl3QZEQNjTvHJwdGKGj
	ebtqii+UDvKrwf0Fac=
X-Google-Smtp-Source: AGHT+IHhCtG5+TOkXctTQmejLJ1+lFtgzdiZI9hAQlzmYcHcQiwcJ94XXudSRNfjECSqpfteb/+HqsXWxJPNnvya25I=
X-Received: by 2002:a2e:a36e:0:b0:32a:869e:4c13 with SMTP id
 38308e7fff4ca-333fa72e974mr2692591fa.14.1755150503808; Wed, 13 Aug 2025
 22:48:23 -0700 (PDT)
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
 <aJwiXKWXik8BmpL8@sunil-laptop> <CAEEQ3wky3LXK=ge1wBkHD0ZWtwUF-aBn44EK0Uxa+_2DB1Giqw@mail.gmail.com>
 <CAK9=C2VOaAJZxCeM-5QPj5B-ie68LivJyQcM8KwKjdL9u00RJg@mail.gmail.com> <CAEEQ3wmDygvLn-EK_hCumOuCkPjKWfnmwiA+kz4p9N=thG0pXA@mail.gmail.com>
In-Reply-To: <CAEEQ3wmDygvLn-EK_hCumOuCkPjKWfnmwiA+kz4p9N=thG0pXA@mail.gmail.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 14 Aug 2025 11:18:10 +0530
X-Gm-Features: Ac12FXyrfbViQgrEQhqP_2MvMXsDZ6jc2RCF3VF-aE5KR9wmZtzeUd1ieaEQCLY
Message-ID: <CAK9=C2X+6vs=Xa7XnreRs4+e5OjeJA-XtwwUM4GHq7pT=Fs-5A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] ACPI: RISC-V: CPPC: Add CSR_CYCLE for CPPC FFH
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>, rafael@kernel.org, lenb@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Rahul Pathak <rpathak@ventanamicro.com>, 
	juwenlong@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 9:08=E2=80=AFAM yunhui cui <cuiyunhui@bytedance.com=
> wrote:
>
> Hi Anup,
>
> On Wed, Aug 13, 2025 at 7:12=E2=80=AFPM Anup Patel <apatel@ventanamicro.c=
om> wrote:
> >
> > On Wed, Aug 13, 2025 at 12:14=E2=80=AFPM yunhui cui <cuiyunhui@bytedanc=
e.com> wrote:
> > >
> > > Hi Sunil,
> > >
> > > On Wed, Aug 13, 2025 at 1:28=E2=80=AFPM Sunil V L <sunilvl@ventanamic=
ro.com> wrote:
> > > >
> > > > Hi Yunhui,
> > > >
> > > > On Wed, Aug 13, 2025 at 11:23:39AM +0800, yunhui cui wrote:
> > > > > Hi Sunil,
> > > > >
> > > > > On Tue, Aug 12, 2025 at 10:06=E2=80=AFPM Sunil V L <sunilvl@venta=
namicro.com> wrote:
> > > > > >
> > > > [...]
> > > > > > > > >
> > > > > > > > > The purpose of cppc_ffh_csr_read() is to calculate the ac=
tual
> > > > > > > > > frequency of the CPU, which is delta_CSR_CYCLE/delta_CSR_=
XXX.
> > > > > > > > >
> > > > > > > > > CSR_XXX should be a reference clock and does not count du=
ring WFI
> > > > > > > > > (Wait For Interrupt).
> > > > > > > > >
> > > > > > > > > Similar solutions include: x86's aperf/mperf, and ARM64's=
 AMU with
> > > > > > > > > registers SYS_AMEVCNTR0_CORE_EL0/SYS_AMEVCNTR0_CONST_EL0.
> > > > > > > > >
> > > > > > > > > However, we know that CSR_TIME in the current code does c=
ount during
> > > > > > > > > WFI. So, is this design unreasonable?
> > > > > > > > >
> > > > > > > > > Should we consider proposing an extension to support such=
 a dedicated
> > > > > > > > > counter (a reference clock that does not count during WFI=
)? This way,
> > > > > > > > > the value can be obtained directly in S-mode without trap=
ping to
> > > > > > > > > M-mode, especially since reading this counter is very fre=
quent.
> > > > > > > > >
> > > > > > > > Hi Yunhui,
> > > > > > > >
> > > > > > > > Yes, but we anticipated that vendors might define their own=
 custom CSRs.
> > > > > > > > So, we introduced FFH encoding to accommodate such cases.
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > > Sunil
> > > > > > >
> > > > > > > As mentioned earlier, it is best to directly read CSR_XXX (a =
reference
> > > > > > > clock that does not count during WFI) and CSR_CYCLE in S-mode=
, rather
> > > > > > > than trapping to SBI.
> > > > > > >
> > > > > > No. I meant direct CSR access itself not SBI. Please take a loo=
k at
> > > > > > Table 6 of RISC-V FFH spec.
> > > > > >
> > > > > > > drivers/acpi/riscv/cppc.c is a generic driver that is not spe=
cific to
> > > > > > > any vendor. Currently, the upstream code already uses CSR_TIM=
E, and
> > > > > > > the logic of CSR_TIME is incorrect.
> > > > > > >
> > > > ACPI spec for "Reference Performance Register" says,
> > > >
> > > > "The Reference Performance Counter Register counts at a fixed rate =
any
> > > > time the processor is active. It is not affected by changes to Desi=
red
> > > > Performance, processor throttling, etc."
> > > >
> > > > > > CSR_TIME is just an example. It is upto the vendor how _CPC obj=
ects are
> > > > > > encoded using FFH. The linux code doesn't mean one should use C=
SR_TIME
> > > > > > always.
> > > > >
> > > > > First, the example of CSR_TIME is incorrect. What is needed is a
> > > > > CSR_XXX (a reference clock that does not count during WFI).
> > > > >
> > > > > Second, you mentioned that each vendor can customize their own
> > > > > implementations. But should all vendors' CSR_XXX/YYY/... be added=
 to
> > > > > drivers/acpi/riscv/cppc.c? Shouldn=E2=80=99t drivers/acpi/riscv/c=
ppc.c fall
> > > > > under the scope defined by the RISC-V architecture?
> > > > >
> > > > No. One can implement similar to csr_read_num() in opensbi. We didn=
't
> > > > add it since there was no HW implementing such thing. What I am
> > > > saying is we have FFH encoding to support such case.
> > > >
> > > > > >
> > > > > > > It would be best to promote a specification to support CSR_XX=
X, just
> > > > > > > like what has been done for x86 and arm64. What do you think?
> > > > > > >
> > > > > > Wouldn't above work? For a standard extension, you may have to =
provide
> > > > > > more data with actual HW.
> > > > >
> > > > > This won=E2=80=99t work. May I ask how the current upstream code =
can calculate
> > > > > the actual CPU frequency using CSR_TIME without trapping to SBI?
> > > > > This is a theoretical logical issue. Why is data needed here?
> > > > >
> > > > As I mentioned above, one can implement a generic CSR read without
> > > > trapping to SBI.
> > > >
> > > > > Could you take a look at the "AMU events and event numbers" chapt=
er in
> > > > > the ARM64 manual?
> > > > >
> > > > As-per ACPI spec reference performance counter is not affected by C=
PU
> > > > state. The RISC-V FFH encoding is sufficiently generic to support t=
his
> > > > requirement, even if the standard CSR_TIME cannot be used. In such
> > > > cases, an alternative CSR can be encodeded, accessed via an OS-leve=
l
> > > > abstraction such as csr_read_num().
> > >
> > > So what you're saying is that we should submit a patch like this, rig=
ht?
> > >
> > > diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
> > > index 440cf9fb91aab..953c259d46c69 100644
> > > --- a/drivers/acpi/riscv/cppc.c
> > > +++ b/drivers/acpi/riscv/cppc.c
> > > @@ -66,16 +66,8 @@ static void cppc_ffh_csr_read(void *read_data)
> > >  {
> > >         struct sbi_cppc_data *data =3D (struct sbi_cppc_data *)read_d=
ata;
> > >
> > > -       switch (data->reg) {
> > > -       /* Support only TIME CSR for now */
> > > -       case CSR_TIME:
> > > -               data->ret.value =3D csr_read(CSR_TIME);
> > > -               data->ret.error =3D 0;
> > > -               break;
> > > -       default:
> > > -               data->ret.error =3D -EINVAL;
> > > -               break;
> > > -       }
> > > +       data->ret.value =3D csr_read_num(data->reg);
> > > +       data->ret.error =3D 0;
> > >  }
> > >
> > > If that's the case, the robustness of the code cannot be guaranteed,
> > > because the range of CSRs from different vendors is unknown.
> >
> > ACPI FFH is allows mapping to any CSR.
>
> Yes, FFH can map any CSR, and this is not the point of contention.
>
> If that's the case, the CSR_TIME used in the current kernel code is
> inappropriate. Some vendors may design a counter that does not count
> during WFI, making CSR_TIME irrelevant. Even if counting continues
> during WFI, are you planning to have one counter operate in S-mode
> while the other traps to M-mode?
>
> In that case, the code would need to be modified as proposed above. Do
> you agree?

I disagree.

Like Sunil already explained, if an implementation has reference counter
which does not count during WFI state then for such implementation the
delivered performance counter should also not increment during WFI
to maintain the relative delta of increments. This means if an implementati=
on
uses TIME CSR as reference counter then for such implementation
the delivered performance counter should increment accordingly. Ultimately,
what matters is OS being able to correctly compute the performance level
using reference and delivered performance counters.

>
> Without a specification defining these two counters, the above code
> would lack robustness.

Can you elaborate the "robustness" part ?
Do you have data to back your claims ?

Regards,
Anup

