Return-Path: <linux-acpi+bounces-15717-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A63B2779D
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 06:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E190F5862E7
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 04:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83EF14A4CC;
	Fri, 15 Aug 2025 04:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="QJilNiSO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770EA13FEE
	for <linux-acpi@vger.kernel.org>; Fri, 15 Aug 2025 04:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755230875; cv=none; b=iCQdpKrn1eyMwsQCC0DShxa7T+v4hBWEB87ckQ7sKtOAyQeLjs06g4F/ehQyHU4zXqza9eKwKBoXATugat4ALT407RKpWDQGuOEFwu8NRSnlu1pbBY1o8aYYCFnTwZLu7tJ0a1j8lhxc64AGI1u3D1vpLN/WRJFatr3vwMnCO4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755230875; c=relaxed/simple;
	bh=RwSO4Q1T6ctIKjfszGR4iMk4KLc300sw36PpMImwZjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmM9xnAakc3B3gab7yDfFmf+YVh8XUmv3sQC3XsMLmjGCCccc8cw6cQNGfL05aV5NHxa7wi/uC02dXLVuGwWs5nhRiJ9VgSjpaWLpkNrKq6LsTWzeAx1Knya1iEEz1GwJV/7+EI65Ibsnt1+7cEPivQei0hScFK9mBhxWg7wbu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=QJilNiSO; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-333f9145edaso11353661fa.2
        for <linux-acpi@vger.kernel.org>; Thu, 14 Aug 2025 21:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755230871; x=1755835671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9e8pHPVBpJpnZzAbKWbiPECwlXFdrGDdyBGbrFe0a8=;
        b=QJilNiSOOkFYe7hEzuegJiMdRDQVFSdTd3D0qR+DarJsAGo0ai1PYHXmZc1XDfRL/3
         ujCMLYFBpUD4GZ+RoRkW5xzjekjl9gCEZcCQPPoD3M59gg2u4zGvxmh1o75lOj7oVzzl
         S7q4WpK/Goz+992V5zhnnBilBCzqP3dM0n6pC3yia4jHRMJ+ulfWUY7HVISwh2GOmtgT
         MAz95wZsf8NROaXOvn47uXM6KTJjMcsoxFt0G7mqgth3yvyYooYWiqWcuiO3vcAaD8ry
         Hv8jVD2D2Nj71NVZpjvjEhppauYVXFWyk+WDtTlUxOjUZiO1eoHCjDQOpAzoiYULWCYZ
         HDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755230871; x=1755835671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9e8pHPVBpJpnZzAbKWbiPECwlXFdrGDdyBGbrFe0a8=;
        b=ssjNl7pFOM77+CIyq0Q9cVKO4pGwb0nUt9KvLRPDkZ/vtNGQbGSRmGQ5HBulDBhdpP
         PEXTetmzcTlKJnG/86RKoNZg0KRIr0YISFyhJTKI/RRQxRYvbzwTvUwhsNV3eZdGimWr
         oDqusKBJTJNLTGA+4TiuxHqc9h05vXVEh5rUVzbGhYlKpMt4htysDuHpfTO0AW2gu5zk
         wXw0epeY7RffI2xZ+g+CDgy/7Dql/DFYc27rFLClQMClnlL5or56ys5HbHb2RgJG9BCe
         hhFLkVVmkbBiYSRjmWbeHHGlrH3v1qC8kTtDqfVxPyRdiKYW734I41o0/Ol+yOHQm2X0
         hlpw==
X-Forwarded-Encrypted: i=1; AJvYcCXa2IyG6eh90kdgCJo2zP08LW+VZgu11m82mqsgD0CfarIdt+43HMh6FSwr1z+t1UTMEh4VWn9lKDFF@vger.kernel.org
X-Gm-Message-State: AOJu0YyOkfoZs8Ibt2qnD17JnYBMt3/aILHmQ4M5yvk/i+AF5j8E8TLt
	5Qj+1V1cz2HxK43CCreGn6UlvTSN2OtuFfwz1Iu5hGKwi9qO4UorUX1YsfdC9Y2+ve7qK7WeRrF
	tb8BWEYca+gNYJaQahATokjaElQk2CAuXTn7YWeAEAQ==
X-Gm-Gg: ASbGncv0e6EMQOqBIyRnqA82FN8M+II55RkAfbTdl6vTt1F9BTgvZOYQxaan6l0Ae6R
	0NeXg0sMLocEL3Bvz3Lz49GBUNmMHhj0fsBy+i7oJsN2FmxJFzdo7vSXEXbOfacHNbZ7C9aC1qX
	R7dw+2IUTq/O2orw9MQYtgQZydVJunaJXJHIyl80djy53K6R0OIwPMS/P86u+kYIfZkLqDt/Zk3
	7qO0Axb
X-Google-Smtp-Source: AGHT+IHHhpvLwRQzTYqEsi0JA5Co1f+dJaEUkGOCKAbt2sHrX46XmG0yA6YeiQZ6UI8h4oZENwbeMXIQZ7Ym5pmUDQM=
X-Received: by 2002:a05:651c:2208:b0:32f:1c0f:fb73 with SMTP id
 38308e7fff4ca-334099bb9e9mr2387571fa.36.1755230871331; Thu, 14 Aug 2025
 21:07:51 -0700 (PDT)
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
 <CAK9=C2X+6vs=Xa7XnreRs4+e5OjeJA-XtwwUM4GHq7pT=Fs-5A@mail.gmail.com>
 <CAEEQ3wm9shktdzUeO5RczE-=qdDUS30TGASOFtnMEcuw7L7jZw@mail.gmail.com>
 <CAK9=C2UDVnpHs04VmzmjjmTYkE--dX2NtoWXGXoX=vVm=SF_5Q@mail.gmail.com> <4A3F784D-4844-48D8-AE84-B4D25BCB78B4@jrtc27.com>
In-Reply-To: <4A3F784D-4844-48D8-AE84-B4D25BCB78B4@jrtc27.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Fri, 15 Aug 2025 09:37:41 +0530
X-Gm-Features: Ac12FXysveFy5MvqM7-gcPY6uzwVpoOKdQwpt1C0H9OnoApa3rWZLFWDQwrcUnU
Message-ID: <CAK9=C2XXsMq_x80R+jH2LDEYYZnBWgXcBAUSbV0tQwEb2OX6yA@mail.gmail.com>
Subject: Re: [External] [PATCH] ACPI: RISC-V: CPPC: Add CSR_CYCLE for CPPC FFH
To: Jessica Clarke <jrtc27@jrtc27.com>
Cc: yunhui cui <cuiyunhui@bytedance.com>, aou@eecs.berkeley.edu, juwenlong@bytedance.com, 
	alex@ghiti.fr, rafael@kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	linux-riscv@lists.infradead.org, Rahul Pathak <rpathak@ventanamicro.com>, lenb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 10:27=E2=80=AFPM Jessica Clarke <jrtc27@jrtc27.com>=
 wrote:
>
> On 14 Aug 2025, at 14:37, Anup Patel <apatel@ventanamicro.com> wrote:
> >
> > On Thu, Aug 14, 2025 at 11:49=E2=80=AFAM yunhui cui <cuiyunhui@bytedanc=
e.com> wrote:
> >>
> >> Hi Anup,
> >>
> >> On Thu, Aug 14, 2025 at 1:48=E2=80=AFPM Anup Patel <apatel@ventanamicr=
o.com> wrote:
> >>>
> >>> On Thu, Aug 14, 2025 at 9:08=E2=80=AFAM yunhui cui <cuiyunhui@bytedan=
ce.com> wrote:
> >>>>
> >>>> Hi Anup,
> >>>>
> >>>> On Wed, Aug 13, 2025 at 7:12=E2=80=AFPM Anup Patel <apatel@ventanami=
cro.com> wrote:
> >>>>>
> >>>>> On Wed, Aug 13, 2025 at 12:14=E2=80=AFPM yunhui cui <cuiyunhui@byte=
dance.com> wrote:
> >>>>>>
> >>>>>> Hi Sunil,
> >>>>>>
> >>>>>> On Wed, Aug 13, 2025 at 1:28=E2=80=AFPM Sunil V L <sunilvl@ventana=
micro.com> wrote:
> >>>>>>>
> >>>>>>> Hi Yunhui,
> >>>>>>>
> >>>>>>> On Wed, Aug 13, 2025 at 11:23:39AM +0800, yunhui cui wrote:
> >>>>>>>> Hi Sunil,
> >>>>>>>>
> >>>>>>>> On Tue, Aug 12, 2025 at 10:06=E2=80=AFPM Sunil V L <sunilvl@vent=
anamicro.com> wrote:
> >>>>>>>>>
> >>>>>>> [...]
> >>>>>>>>>>>>
> >>>>>>>>>>>> The purpose of cppc_ffh_csr_read() is to calculate the actua=
l
> >>>>>>>>>>>> frequency of the CPU, which is delta_CSR_CYCLE/delta_CSR_XXX=
.
> >>>>>>>>>>>>
> >>>>>>>>>>>> CSR_XXX should be a reference clock and does not count durin=
g WFI
> >>>>>>>>>>>> (Wait For Interrupt).
> >>>>>>>>>>>>
> >>>>>>>>>>>> Similar solutions include: x86's aperf/mperf, and ARM64's AM=
U with
> >>>>>>>>>>>> registers SYS_AMEVCNTR0_CORE_EL0/SYS_AMEVCNTR0_CONST_EL0.
> >>>>>>>>>>>>
> >>>>>>>>>>>> However, we know that CSR_TIME in the current code does coun=
t during
> >>>>>>>>>>>> WFI. So, is this design unreasonable?
> >>>>>>>>>>>>
> >>>>>>>>>>>> Should we consider proposing an extension to support such a =
dedicated
> >>>>>>>>>>>> counter (a reference clock that does not count during WFI)? =
This way,
> >>>>>>>>>>>> the value can be obtained directly in S-mode without trappin=
g to
> >>>>>>>>>>>> M-mode, especially since reading this counter is very freque=
nt.
> >>>>>>>>>>>>
> >>>>>>>>>>> Hi Yunhui,
> >>>>>>>>>>>
> >>>>>>>>>>> Yes, but we anticipated that vendors might define their own c=
ustom CSRs.
> >>>>>>>>>>> So, we introduced FFH encoding to accommodate such cases.
> >>>>>>>>>>>
> >>>>>>>>>>> Thanks,
> >>>>>>>>>>> Sunil
> >>>>>>>>>>
> >>>>>>>>>> As mentioned earlier, it is best to directly read CSR_XXX (a r=
eference
> >>>>>>>>>> clock that does not count during WFI) and CSR_CYCLE in S-mode,=
 rather
> >>>>>>>>>> than trapping to SBI.
> >>>>>>>>>>
> >>>>>>>>> No. I meant direct CSR access itself not SBI. Please take a loo=
k at
> >>>>>>>>> Table 6 of RISC-V FFH spec.
> >>>>>>>>>
> >>>>>>>>>> drivers/acpi/riscv/cppc.c is a generic driver that is not spec=
ific to
> >>>>>>>>>> any vendor. Currently, the upstream code already uses CSR_TIME=
, and
> >>>>>>>>>> the logic of CSR_TIME is incorrect.
> >>>>>>>>>>
> >>>>>>> ACPI spec for "Reference Performance Register" says,
> >>>>>>>
> >>>>>>> "The Reference Performance Counter Register counts at a fixed rat=
e any
> >>>>>>> time the processor is active. It is not affected by changes to De=
sired
> >>>>>>> Performance, processor throttling, etc."
> >>>>>>>
> >>>>>>>>> CSR_TIME is just an example. It is upto the vendor how _CPC obj=
ects are
> >>>>>>>>> encoded using FFH. The linux code doesn't mean one should use C=
SR_TIME
> >>>>>>>>> always.
> >>>>>>>>
> >>>>>>>> First, the example of CSR_TIME is incorrect. What is needed is a
> >>>>>>>> CSR_XXX (a reference clock that does not count during WFI).
> >>>>>>>>
> >>>>>>>> Second, you mentioned that each vendor can customize their own
> >>>>>>>> implementations. But should all vendors' CSR_XXX/YYY/... be adde=
d to
> >>>>>>>> drivers/acpi/riscv/cppc.c? Shouldn=E2=80=99t drivers/acpi/riscv/=
cppc.c fall
> >>>>>>>> under the scope defined by the RISC-V architecture?
> >>>>>>>>
> >>>>>>> No. One can implement similar to csr_read_num() in opensbi. We di=
dn't
> >>>>>>> add it since there was no HW implementing such thing. What I am
> >>>>>>> saying is we have FFH encoding to support such case.
> >>>>>>>
> >>>>>>>>>
> >>>>>>>>>> It would be best to promote a specification to support CSR_XXX=
, just
> >>>>>>>>>> like what has been done for x86 and arm64. What do you think?
> >>>>>>>>>>
> >>>>>>>>> Wouldn't above work? For a standard extension, you may have to =
provide
> >>>>>>>>> more data with actual HW.
> >>>>>>>>
> >>>>>>>> This won=E2=80=99t work. May I ask how the current upstream code=
 can calculate
> >>>>>>>> the actual CPU frequency using CSR_TIME without trapping to SBI?
> >>>>>>>> This is a theoretical logical issue. Why is data needed here?
> >>>>>>>>
> >>>>>>> As I mentioned above, one can implement a generic CSR read withou=
t
> >>>>>>> trapping to SBI.
> >>>>>>>
> >>>>>>>> Could you take a look at the "AMU events and event numbers" chap=
ter in
> >>>>>>>> the ARM64 manual?
> >>>>>>>>
> >>>>>>> As-per ACPI spec reference performance counter is not affected by=
 CPU
> >>>>>>> state. The RISC-V FFH encoding is sufficiently generic to support=
 this
> >>>>>>> requirement, even if the standard CSR_TIME cannot be used. In suc=
h
> >>>>>>> cases, an alternative CSR can be encodeded, accessed via an OS-le=
vel
> >>>>>>> abstraction such as csr_read_num().
> >>>>>>
> >>>>>> So what you're saying is that we should submit a patch like this, =
right?
> >>>>>>
> >>>>>> diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
> >>>>>> index 440cf9fb91aab..953c259d46c69 100644
> >>>>>> --- a/drivers/acpi/riscv/cppc.c
> >>>>>> +++ b/drivers/acpi/riscv/cppc.c
> >>>>>> @@ -66,16 +66,8 @@ static void cppc_ffh_csr_read(void *read_data)
> >>>>>> {
> >>>>>>        struct sbi_cppc_data *data =3D (struct sbi_cppc_data *)read=
_data;
> >>>>>>
> >>>>>> -       switch (data->reg) {
> >>>>>> -       /* Support only TIME CSR for now */
> >>>>>> -       case CSR_TIME:
> >>>>>> -               data->ret.value =3D csr_read(CSR_TIME);
> >>>>>> -               data->ret.error =3D 0;
> >>>>>> -               break;
> >>>>>> -       default:
> >>>>>> -               data->ret.error =3D -EINVAL;
> >>>>>> -               break;
> >>>>>> -       }
> >>>>>> +       data->ret.value =3D csr_read_num(data->reg);
> >>>>>> +       data->ret.error =3D 0;
> >>>>>> }
> >>>>>>
> >>>>>> If that's the case, the robustness of the code cannot be guarantee=
d,
> >>>>>> because the range of CSRs from different vendors is unknown.
> >>>>>
> >>>>> ACPI FFH is allows mapping to any CSR.
> >>>>
> >>>> Yes, FFH can map any CSR, and this is not the point of contention.
> >>>>
> >>>> If that's the case, the CSR_TIME used in the current kernel code is
> >>>> inappropriate. Some vendors may design a counter that does not count
> >>>> during WFI, making CSR_TIME irrelevant. Even if counting continues
> >>>> during WFI, are you planning to have one counter operate in S-mode
> >>>> while the other traps to M-mode?
> >>>>
> >>>> In that case, the code would need to be modified as proposed above. =
Do
> >>>> you agree?
> >>>
> >>> I disagree.
> >>>
> >>> Like Sunil already explained, if an implementation has reference coun=
ter
> >>> which does not count during WFI state then for such implementation th=
e
> >>> delivered performance counter should also not increment during WFI
> >>> to maintain the relative delta of increments. This means if an implem=
entation
> >>> uses TIME CSR as reference counter then for such implementation
> >>> the delivered performance counter should increment accordingly. Ultim=
ately,
> >>> what matters is OS being able to correctly compute the performance le=
vel
> >>> using reference and delivered performance counters.
> >>
> >>
> >> For calculating the actual CPU frequency, both implementations are
> >> acceptable where either both counters continue counting during WFI or
> >> both stop counting.
> >> In the current code, how do you read the other counter?
> >> Shouldn't it be modified like this to support it? This way, all
> >> counters can be read directly in S-mode without trapping to M-mode:
> >> +       data->ret.value =3D csr_read_num(data->reg);
> >> +       data->ret.error =3D 0;
> >
> > Yes, the current switch-case needs to replaced by common
> > csr_read_num() and csr_write_num() implemented in arch/riscv/
> >
> > The RISC-V CSR space is limited so with it is straightforward
> > to implement csr_read_num() and csr_write_num() using
> > macros where each CSR access will turn-out to be roughly
> > 3-4 instructions.
>
> 12 bits, or 4096 CSRs. Are you saying you want to have a jump table
> that dispatches to one of 4096 entry points?
>
> Maybe you can cut that down a bit for S-mode based on the encoding
> convention, but that only eliminates 1/4, so you=E2=80=99re still looking=
 at
> 3072 entry points, perhaps also minus the few that are allocated and
> clearly not sensible things to use for this, like stval.

Yes, we don't need a switch case for all possible 4096 CSRs in
csr_read_num() and csr_write_num(). For S-mode, it will mostly
contain HPM counters and custom CSRs.

I am already working on a patch along these lines which will be
posted in the next few days.

>
> But I think that=E2=80=99s not a reasonable approach to take, and if ther=
e is
> no CSR in the current RISC-V spec that fits the needs of ACPI then one
> needs to be defined so that we don=E2=80=99t need every vendor to invent =
their
> own. If there is a CSR already then that should be the only one that=E2=
=80=99s
> allowed to be used here. If you look at arm64, it hard-codes which
> counter to use for each of the two calls it supports. That=E2=80=99s a mu=
ch
> better world to be in.
>

Like mentioned in this thread, the time CSR can be used as
reference perf counter and for delivered perf counter, we have
multiple options: 1) RPMI CPPC fast channel, 2) SBI CPPC call,
and 3) custom CSR. In fact, the QEMU PoC which we had posted
previously already has RPMI CPPC fast channel for delivered
perf counter which we access from OpenSBI.

If a platform vendor wants to implement a reference perf counter
and delivered perf counter differently then they can always have
custom CSRs.

Regards,
Anup

