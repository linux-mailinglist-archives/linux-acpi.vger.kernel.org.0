Return-Path: <linux-acpi+bounces-15680-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B6BB267FF
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 15:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7421CC6966
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 13:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D421F0E29;
	Thu, 14 Aug 2025 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Y+OwjVvG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F673191F92
	for <linux-acpi@vger.kernel.org>; Thu, 14 Aug 2025 13:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178670; cv=none; b=lv2EsX7tfnEuOQz1oDHVGIn7RRIncpO7uEwnwxv+x2GRlve8DhgQTwDta9IHdB2m2IpnMg9/YZj0SAz0lEvuamoVje52L+8mnzJaNNdeNQpqDolSMs984UBe8gfRvLnCXZe0esfWbtPCZT1X9YH9H2hOlVu0juAfdmoeocAhmtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178670; c=relaxed/simple;
	bh=0FxAevH6cs/T7WF1SN5OuwK4YTjxe+sN9AjhztgFvmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YorNgSrzGjurAswaRf1RACOJuMRdyRmGhPUrsi6zkPJjr5ZsGA0sw0R6PlTVywuBLvDTHA1DUsQMzLZHJI8ESTBIodsgNRNbYfCs2SIjC3CiWcGdWvYmvNoPX/b+emxpQnE8Pzsu4UQRtlLoLqDaHsLR6A32WxPErdqomFfuTCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Y+OwjVvG; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-333f8f22292so7418701fa.1
        for <linux-acpi@vger.kernel.org>; Thu, 14 Aug 2025 06:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755178666; x=1755783466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gkWZh4lkQ0wCGGmXBdFqtaFQtMJ9nFJgisInk5aTPU=;
        b=Y+OwjVvGvM2vEW6fHYt690JiqDjRv0ONitf8s9CPtc0hq96lW7asKlwBMFK9rjTcMW
         Q0dxWB3A7Ubsbl48Aa6jP3Vcwjsa2t52QaO2dXKj2MkJ5ZykQ2tEZGF4pkGACYjGjNF2
         TpwsklFjA2Ey4C/4ukGvtE/mz7cnnpP9qxjs+jnT5sNysnAMer69ifkH0bWDYdWZwJw4
         KWPt/WKMf2MfFKYXrqIQ9AjOsv+DtXuWZBxMNA0JggpJp10smdJH2i/opiF+wsJ//ABz
         63FeY6c/3WyrXU3rCJOGm/xb0W3HQ+7TlqpGr9Pl2WEipDHNKvhNphGIffbD/RcxK1K9
         MS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178666; x=1755783466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6gkWZh4lkQ0wCGGmXBdFqtaFQtMJ9nFJgisInk5aTPU=;
        b=RSy5Nkp7chgrV0pFgC6OecaE98/+wH/3tPu6epvDZu/W8qT5BV/b0TAomOtw/PdQSR
         PI41SCwL5KU4eoW7QbQclFGyR0VZ8FaWG1bejZcPQUfq4SW8giwi8FiBNDdz/gUluslc
         E2hWCwZ6Sqz4i60nvEEZPnbwgjLbucvuLNZnsM1F41xR7lEhcclIrfyaeAehNufSSDBP
         Uf3abJ6C+WAnwilWXBV8UVNL2ewn+tYTdXIBdBcedOjf7W2noNYfo6Mc8JADBs2F6r27
         f8kIbKhkFNgj98WJqex7KPrI7BVi1EE7P6Jg95oDZBPJL/o6IHxPKVn+blTHLjroRF8D
         3Jtw==
X-Forwarded-Encrypted: i=1; AJvYcCWkV3U7Ulf4UKuD/63M6siFvOcCzjzgUUSl00xy3Q4dzrj2JpL9GcaZfkmHhIvp04E7Wo3lyozkl4hq@vger.kernel.org
X-Gm-Message-State: AOJu0Yz62qVxFDKi6WxOOIIZcE0tjRbzcdH8/hr4Onc7/GlHWpoVsCSD
	zV538g/htTwT2+053xMsph4a4jIBsEVDgAPVZ8hZJ+HaR6hHq24GUSBmypJwMSJo2B2DN5ZvlgE
	Y9tzB+wdKxVojF9nXX+4YfAlM6rhSjXtYTmSNeRHNlg==
X-Gm-Gg: ASbGncvvK0lWuK5NTPsb6paYV1MSzykFXq87WtsmZ7NvQgAAMKFXwX5lkczzmGpQaJP
	sHqYjLlbH9KSfYl45EhHqmaCwH2erOnchkPJeN5/9MjR50bjxetOlid5N8Q0kSqxvoy0ReUPCln
	NL6hrgQxm/ZDGKrPYUfwJdNx4+rA9jaoDRgQKd3MWIqy09ZefN2f2OL38D2eMGNdeMygSSmTm9+
	2lqOyen
X-Google-Smtp-Source: AGHT+IE15HdL23EEgnVQUwk7dS+BBYy2x+fRcVFjV1ngmnRfL/Rdb2lqeLYmPN46saEVYJkIpvD5NIGQc857WdTGS6M=
X-Received: by 2002:a05:651c:e05:b0:332:5366:9a2c with SMTP id
 38308e7fff4ca-333fa71850dmr4562701fa.12.1755178666214; Thu, 14 Aug 2025
 06:37:46 -0700 (PDT)
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
 <CAK9=C2VOaAJZxCeM-5QPj5B-ie68LivJyQcM8KwKjdL9u00RJg@mail.gmail.com>
 <CAEEQ3wmDygvLn-EK_hCumOuCkPjKWfnmwiA+kz4p9N=thG0pXA@mail.gmail.com>
 <CAK9=C2X+6vs=Xa7XnreRs4+e5OjeJA-XtwwUM4GHq7pT=Fs-5A@mail.gmail.com> <CAEEQ3wm9shktdzUeO5RczE-=qdDUS30TGASOFtnMEcuw7L7jZw@mail.gmail.com>
In-Reply-To: <CAEEQ3wm9shktdzUeO5RczE-=qdDUS30TGASOFtnMEcuw7L7jZw@mail.gmail.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 14 Aug 2025 19:07:34 +0530
X-Gm-Features: Ac12FXwgf8QXNu4zyG32y8QFGt05IfZ10vCNN37oqbP2pVKVvFQqCIkqzt5QAo0
Message-ID: <CAK9=C2UDVnpHs04VmzmjjmTYkE--dX2NtoWXGXoX=vVm=SF_5Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] ACPI: RISC-V: CPPC: Add CSR_CYCLE for CPPC FFH
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>, rafael@kernel.org, lenb@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Rahul Pathak <rpathak@ventanamicro.com>, 
	juwenlong@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 11:49=E2=80=AFAM yunhui cui <cuiyunhui@bytedance.co=
m> wrote:
>
> Hi Anup,
>
> On Thu, Aug 14, 2025 at 1:48=E2=80=AFPM Anup Patel <apatel@ventanamicro.c=
om> wrote:
> >
> > On Thu, Aug 14, 2025 at 9:08=E2=80=AFAM yunhui cui <cuiyunhui@bytedance=
.com> wrote:
> > >
> > > Hi Anup,
> > >
> > > On Wed, Aug 13, 2025 at 7:12=E2=80=AFPM Anup Patel <apatel@ventanamic=
ro.com> wrote:
> > > >
> > > > On Wed, Aug 13, 2025 at 12:14=E2=80=AFPM yunhui cui <cuiyunhui@byte=
dance.com> wrote:
> > > > >
> > > > > Hi Sunil,
> > > > >
> > > > > On Wed, Aug 13, 2025 at 1:28=E2=80=AFPM Sunil V L <sunilvl@ventan=
amicro.com> wrote:
> > > > > >
> > > > > > Hi Yunhui,
> > > > > >
> > > > > > On Wed, Aug 13, 2025 at 11:23:39AM +0800, yunhui cui wrote:
> > > > > > > Hi Sunil,
> > > > > > >
> > > > > > > On Tue, Aug 12, 2025 at 10:06=E2=80=AFPM Sunil V L <sunilvl@v=
entanamicro.com> wrote:
> > > > > > > >
> > > > > > [...]
> > > > > > > > > > >
> > > > > > > > > > > The purpose of cppc_ffh_csr_read() is to calculate th=
e actual
> > > > > > > > > > > frequency of the CPU, which is delta_CSR_CYCLE/delta_=
CSR_XXX.
> > > > > > > > > > >
> > > > > > > > > > > CSR_XXX should be a reference clock and does not coun=
t during WFI
> > > > > > > > > > > (Wait For Interrupt).
> > > > > > > > > > >
> > > > > > > > > > > Similar solutions include: x86's aperf/mperf, and ARM=
64's AMU with
> > > > > > > > > > > registers SYS_AMEVCNTR0_CORE_EL0/SYS_AMEVCNTR0_CONST_=
EL0.
> > > > > > > > > > >
> > > > > > > > > > > However, we know that CSR_TIME in the current code do=
es count during
> > > > > > > > > > > WFI. So, is this design unreasonable?
> > > > > > > > > > >
> > > > > > > > > > > Should we consider proposing an extension to support =
such a dedicated
> > > > > > > > > > > counter (a reference clock that does not count during=
 WFI)? This way,
> > > > > > > > > > > the value can be obtained directly in S-mode without =
trapping to
> > > > > > > > > > > M-mode, especially since reading this counter is very=
 frequent.
> > > > > > > > > > >
> > > > > > > > > > Hi Yunhui,
> > > > > > > > > >
> > > > > > > > > > Yes, but we anticipated that vendors might define their=
 own custom CSRs.
> > > > > > > > > > So, we introduced FFH encoding to accommodate such case=
s.
> > > > > > > > > >
> > > > > > > > > > Thanks,
> > > > > > > > > > Sunil
> > > > > > > > >
> > > > > > > > > As mentioned earlier, it is best to directly read CSR_XXX=
 (a reference
> > > > > > > > > clock that does not count during WFI) and CSR_CYCLE in S-=
mode, rather
> > > > > > > > > than trapping to SBI.
> > > > > > > > >
> > > > > > > > No. I meant direct CSR access itself not SBI. Please take a=
 look at
> > > > > > > > Table 6 of RISC-V FFH spec.
> > > > > > > >
> > > > > > > > > drivers/acpi/riscv/cppc.c is a generic driver that is not=
 specific to
> > > > > > > > > any vendor. Currently, the upstream code already uses CSR=
_TIME, and
> > > > > > > > > the logic of CSR_TIME is incorrect.
> > > > > > > > >
> > > > > > ACPI spec for "Reference Performance Register" says,
> > > > > >
> > > > > > "The Reference Performance Counter Register counts at a fixed r=
ate any
> > > > > > time the processor is active. It is not affected by changes to =
Desired
> > > > > > Performance, processor throttling, etc."
> > > > > >
> > > > > > > > CSR_TIME is just an example. It is upto the vendor how _CPC=
 objects are
> > > > > > > > encoded using FFH. The linux code doesn't mean one should u=
se CSR_TIME
> > > > > > > > always.
> > > > > > >
> > > > > > > First, the example of CSR_TIME is incorrect. What is needed i=
s a
> > > > > > > CSR_XXX (a reference clock that does not count during WFI).
> > > > > > >
> > > > > > > Second, you mentioned that each vendor can customize their ow=
n
> > > > > > > implementations. But should all vendors' CSR_XXX/YYY/... be a=
dded to
> > > > > > > drivers/acpi/riscv/cppc.c? Shouldn=E2=80=99t drivers/acpi/ris=
cv/cppc.c fall
> > > > > > > under the scope defined by the RISC-V architecture?
> > > > > > >
> > > > > > No. One can implement similar to csr_read_num() in opensbi. We =
didn't
> > > > > > add it since there was no HW implementing such thing. What I am
> > > > > > saying is we have FFH encoding to support such case.
> > > > > >
> > > > > > > >
> > > > > > > > > It would be best to promote a specification to support CS=
R_XXX, just
> > > > > > > > > like what has been done for x86 and arm64. What do you th=
ink?
> > > > > > > > >
> > > > > > > > Wouldn't above work? For a standard extension, you may have=
 to provide
> > > > > > > > more data with actual HW.
> > > > > > >
> > > > > > > This won=E2=80=99t work. May I ask how the current upstream c=
ode can calculate
> > > > > > > the actual CPU frequency using CSR_TIME without trapping to S=
BI?
> > > > > > > This is a theoretical logical issue. Why is data needed here?
> > > > > > >
> > > > > > As I mentioned above, one can implement a generic CSR read with=
out
> > > > > > trapping to SBI.
> > > > > >
> > > > > > > Could you take a look at the "AMU events and event numbers" c=
hapter in
> > > > > > > the ARM64 manual?
> > > > > > >
> > > > > > As-per ACPI spec reference performance counter is not affected =
by CPU
> > > > > > state. The RISC-V FFH encoding is sufficiently generic to suppo=
rt this
> > > > > > requirement, even if the standard CSR_TIME cannot be used. In s=
uch
> > > > > > cases, an alternative CSR can be encodeded, accessed via an OS-=
level
> > > > > > abstraction such as csr_read_num().
> > > > >
> > > > > So what you're saying is that we should submit a patch like this,=
 right?
> > > > >
> > > > > diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.=
c
> > > > > index 440cf9fb91aab..953c259d46c69 100644
> > > > > --- a/drivers/acpi/riscv/cppc.c
> > > > > +++ b/drivers/acpi/riscv/cppc.c
> > > > > @@ -66,16 +66,8 @@ static void cppc_ffh_csr_read(void *read_data)
> > > > >  {
> > > > >         struct sbi_cppc_data *data =3D (struct sbi_cppc_data *)re=
ad_data;
> > > > >
> > > > > -       switch (data->reg) {
> > > > > -       /* Support only TIME CSR for now */
> > > > > -       case CSR_TIME:
> > > > > -               data->ret.value =3D csr_read(CSR_TIME);
> > > > > -               data->ret.error =3D 0;
> > > > > -               break;
> > > > > -       default:
> > > > > -               data->ret.error =3D -EINVAL;
> > > > > -               break;
> > > > > -       }
> > > > > +       data->ret.value =3D csr_read_num(data->reg);
> > > > > +       data->ret.error =3D 0;
> > > > >  }
> > > > >
> > > > > If that's the case, the robustness of the code cannot be guarante=
ed,
> > > > > because the range of CSRs from different vendors is unknown.
> > > >
> > > > ACPI FFH is allows mapping to any CSR.
> > >
> > > Yes, FFH can map any CSR, and this is not the point of contention.
> > >
> > > If that's the case, the CSR_TIME used in the current kernel code is
> > > inappropriate. Some vendors may design a counter that does not count
> > > during WFI, making CSR_TIME irrelevant. Even if counting continues
> > > during WFI, are you planning to have one counter operate in S-mode
> > > while the other traps to M-mode?
> > >
> > > In that case, the code would need to be modified as proposed above. D=
o
> > > you agree?
> >
> > I disagree.
> >
> > Like Sunil already explained, if an implementation has reference counte=
r
> > which does not count during WFI state then for such implementation the
> > delivered performance counter should also not increment during WFI
> > to maintain the relative delta of increments. This means if an implemen=
tation
> > uses TIME CSR as reference counter then for such implementation
> > the delivered performance counter should increment accordingly. Ultimat=
ely,
> > what matters is OS being able to correctly compute the performance leve=
l
> > using reference and delivered performance counters.
>
>
> For calculating the actual CPU frequency, both implementations are
> acceptable where either both counters continue counting during WFI or
> both stop counting.
> In the current code, how do you read the other counter?
> Shouldn't it be modified like this to support it? This way, all
> counters can be read directly in S-mode without trapping to M-mode:
> +       data->ret.value =3D csr_read_num(data->reg);
> +       data->ret.error =3D 0;

Yes, the current switch-case needs to replaced by common
csr_read_num() and csr_write_num() implemented in arch/riscv/

The RISC-V CSR space is limited so with it is straightforward
to implement csr_read_num() and csr_write_num() using
macros where each CSR access will turn-out to be roughly
3-4 instructions.

>
>
> >
> > >
> > > Without a specification defining these two counters, the above code
> > > would lack robustness.
> >
> > Can you elaborate the "robustness" part ?
> > Do you have data to back your claims ?
>
> Because there is no specification defining address access rules for
> data->reg across different vendors' implementations, you cannot write
> a validation logic like this:
> if (data->reg < CSR_CYCLE || data->reg > CSR_HPMCOUNTER31H) {
>     ...
>     return -EINVAL;
> }
> Reading data->reg directly lacks robustness, because data->reg may
> potentially hold an invalid value.
>

I don't think there is any specification gap here. Platforms can either use
SBI CPPC extension or time CSR or other implementation specific CSRs.
All this is abstracted away by RISC-V ACPI FFH.

If data->reg points to invalid / unimplemented CSR then csr_read_num()
and csr_write_num() will cause an illegal instruction trap which is expecte=
d
behaviour for a buggy ACPI table.

Regards,
Anup

