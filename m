Return-Path: <linux-acpi+bounces-15716-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE964B27654
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 04:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 589F63AFCF6
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 02:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4E017B425;
	Fri, 15 Aug 2025 02:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="csICdsra"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4AC17A318
	for <linux-acpi@vger.kernel.org>; Fri, 15 Aug 2025 02:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755226030; cv=none; b=Amb09WQfrUPa4WPg2cmJVAQZAsNNaLv00xDtHakLEgxBUNBMYE+u4C09PfWce/P9wLr04cg5dLhB5xKQ4ZoNTOvPTgzqCiygJxvAlipMCqPT8tq2ppIEVgxdWqA8Msp/Xr2ewIvQ/Sbn4l4ME/Q2zfsAPq8MIHFaVvvVSpROWwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755226030; c=relaxed/simple;
	bh=FgEGBlwB3ciJlGICTiEIBmOCk6trtHsuEUI/77KBQ5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbXGNvkfTAM+dBqJHfZN8cAN/nVmRdhW87whzSjAWqtXsadEL9860HaX/btbFiRp1PMwSSK7Cww4sKbvXeIZ36W5gRVEGso/xQzIKQzwLm8ir1ojqRsU7chQR8ykbgiJvzWilCrVMhbK/k5odnhBhPZ4vOANpzmJRn9bOE6AIM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=csICdsra; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-435de7aebb7so1028951b6e.2
        for <linux-acpi@vger.kernel.org>; Thu, 14 Aug 2025 19:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755226027; x=1755830827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i22p/aw9mrQuKl9gbWNZhMqSoSRUivedkHT3ITohh0M=;
        b=csICdsraVeI4hxkgS905p6H4zsiAIl6ycoQbLDziD6CMfJKLa9U9LV9A4Jekz2VcGT
         gazQt5lfwUZbFGyxR5pV4pAcGksOlkZwBGxsF8A4rFwsVLCvYKW44svAXiRyJJ77NVNL
         zyLYmziABQtkXiENIHXIFhBtLvzPK1w+xocnlwZ9AXdJnsLtjXpZ46imY1YbwWCTKhvK
         jClQ7yZHpQgNfE0rbQrvKPW2fS+tNh6zq8KPun4VJtm/vaVorw3HNB8ac6uCuLT0lQPl
         Z01LvqM8Xws68CRFn0LdzM85ZcSlj3UKA0gLfrZjcjnkiWgppDwckmbGmI0VIx34oXwn
         9ieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755226027; x=1755830827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i22p/aw9mrQuKl9gbWNZhMqSoSRUivedkHT3ITohh0M=;
        b=oeiw+RCnfDy8feTl+IIaNTkH6LuY1RjyK1srkaVWbMvT6W8V1nxfZQoSjb/y8gZF3n
         EtkYCI118i06JHVPSWjuqIaEPsrXjp9AIgQkNa5AWLlBFv2Aue9JJk0CelerED3sAYCJ
         oEI7Lrwjt2XU0J/xSa3OViL8WP/N3IwuHepAEpX0u279NZfQ/FuFLqnpxcxnNrNECNOG
         pA8pwBi7xMJXv6skwMqcKK4k1RvPOkByBEDCMDAE2ObL2jgxLxKtsP1pry96gWs4pvCM
         DbDzw8qjSAgVgwjEe6LJVk2RG5r23QvPYXvx+uKylaRXO+gelLWRgna/ocfwjMJCu4uJ
         NqQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmfsY+jZ+bXD1yXC6p9UDMHzCrU0Y8Y3LKrHYfDu7ID/bkeWAI3IIC/yIoJv4Jq7V+j2HjBJT+DToq@vger.kernel.org
X-Gm-Message-State: AOJu0YxIk5p15OnQ7N0Fa+f/Ff9PX53qJ7AnrpPoKiW5Vn6ba1Ahgujm
	rY+EKz0sPUIvEd+efn94BROM7dxRjLRgAymv3BnldJbmQxeBIgdJv/m/EUYzeWhwvdikN71Ma8n
	8UYv+Xyr3TvKZof1dQBNXe5vXGRrYsJ0DWiufZH8aTw==
X-Gm-Gg: ASbGncvYVj6Y0nZ9ZL8GKjk4MXV8LSYApqjcNyIHmFI6M+PiZVTQS+paZnCAHGZXejt
	mtfMXGqJqSxU2dyhTrKiu5hhOCelAlhYLpc0zcweymKhaHHhyoxsJOsWKNYX9xNtDk/bYLSFd+E
	cp42F212mXXbuy/P97iKNJT+i2is1H35AARSzdDWxFoLpO1rVtDlZI8VWWxH2JJzktulTK1JXPc
	v4/EZBiAt1DWmA6RNBf9HPk
X-Google-Smtp-Source: AGHT+IFQ5d8tJ25Ui1eA5Dvb0jLpOC9919b2NPrp4OSov+1adrsc3N2mQy1gf8rgbrxNJwHxWsgq/SBoimc4pYFKYbQ=
X-Received: by 2002:a05:6808:23d0:b0:433:f8ac:2eca with SMTP id
 5614622812f47-435ec4fb0aamr192856b6e.27.1755226027030; Thu, 14 Aug 2025
 19:47:07 -0700 (PDT)
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
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 15 Aug 2025 10:46:55 +0800
X-Gm-Features: Ac12FXwPrR70zso9xdRXBCPyrDokgjQt3elf-TdGrHXD-NoX5_YBF4DYT8WvjwM
Message-ID: <CAEEQ3wm5M9WgraQsVkoESTZ4bHYvV23yqOMvVZ3XV8zhE4Bs3w@mail.gmail.com>
Subject: Re: [External] [PATCH] ACPI: RISC-V: CPPC: Add CSR_CYCLE for CPPC FFH
To: Jessica Clarke <jrtc27@jrtc27.com>
Cc: Anup Patel <apatel@ventanamicro.com>, aou@eecs.berkeley.edu, juwenlong@bytedance.com, 
	alex@ghiti.fr, rafael@kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	linux-riscv@lists.infradead.org, Rahul Pathak <rpathak@ventanamicro.com>, lenb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jessica,

On Fri, Aug 15, 2025 at 12:57=E2=80=AFAM Jessica Clarke <jrtc27@jrtc27.com>=
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

Agreed. Because the second operand of the csrr instruction must be a
constant, a switch-case conversion is therefore necessary.

>
> Jessica
>

Thanks,
Yunhui

