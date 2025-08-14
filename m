Return-Path: <linux-acpi+bounces-15703-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBA4B26D1D
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 18:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0E0C1894D90
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 16:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DFD1FE444;
	Thu, 14 Aug 2025 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="Xpc/dRtV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C4B1E4BE
	for <linux-acpi@vger.kernel.org>; Thu, 14 Aug 2025 16:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755190626; cv=none; b=MdybPimjHn2sze7DZNRwFzGf8ZtKz/BPflpf5FqTkoqg/qqDBXnn+kwVdzztim8igOZeIMtynGUxT5mmOSzrNPxuN1IMjHITfWf75SBCcPLJIaQhhn+zRwY9mU91JhjCX8Nt1guAx0nMZYJfVEopv4g4j9fAhExqPe4RKNU0oxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755190626; c=relaxed/simple;
	bh=djF5DXh5MSKzsQqpJa+xdWVngEtyc9S4HvDyi2iilac=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZiYon1UjQAo5agWHGmqIj9J4JMNoT+xfUZyKvm3XacYm/RSmp1Rn+Dfc1ns1zNU5JIeZrzSU4BQAuytLiaHwoSgYP7O5cpt6tuswfeLRV3hmId//D15RPryj3BJE7lLs0ItQhuBW8mqnKYb5dC2TI4WJ9F6h9CengA+cf5XJqFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com; spf=pass smtp.mailfrom=jrtc27.com; dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b=Xpc/dRtV; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jrtc27.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b05a49cso7218735e9.1
        for <linux-acpi@vger.kernel.org>; Thu, 14 Aug 2025 09:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1755190622; x=1755795422; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nehsJsbxpmsuOIRfNqAphy85HakrhWnyrgyBK0Nsdg4=;
        b=Xpc/dRtV4SCnxQ3TVBq4XhZm6VDYPZZtZO9RpsqWpKbzgJwcx+gBZx/2WV2EKFVUJj
         frbmBKwDxeFEumECW4ZJYRfJjeH+YcoZpkD+YTBvdj7jP4PTnb8y/aAmFeA6aAB8yn6V
         A01UzpPsVAu97V4prRGaQ9CC/UHhiULtZPQi/FZeLc01bmSakLf7joOnoo+wIw8HIyCS
         5fGd5w5l1r2wIpiRrS9qJuPuhTKLKTEfA+pecOQtk5YYarYqqFYbGfNrO1bsbBaA2dXS
         zKH8nVgA3zJeKyHsEF7ZwvbK/6wYaeSwf+6stTgFAqU0fHuO6EzhQ7yrwN9ZXg0a+rjB
         R8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755190622; x=1755795422;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nehsJsbxpmsuOIRfNqAphy85HakrhWnyrgyBK0Nsdg4=;
        b=wXYe1UE8LX5FgKu9SsW2CvGPFUgiieiWyMahahbyI5j70TJkttIM978hi1/qlI2wt0
         DzhrZH6DHPirHCIYzqub0Y2s1xMrscTGDvNwqQoXHuXRdoM0xMsqZelFb2Hk0WD17+jp
         T7J8sDFO1v/z/8Lxw1ZMVs1O3bNcgFgPZIMRsVjDZVt1Y1dDSwh7St0WMwxfgRa//vDy
         emPw4m25cG9Gqa14p8cdmO+NfBygoGB1ZuxyUZ19wO5Ai3iBStEq6g3oxJdzrdYxHucb
         YQPranuqrFLbuxQuQDNe3TfBZyHzpGB2yA7tAABGo8HTOHuHPNxzhoLHbwOFzLfymwnU
         /fDw==
X-Forwarded-Encrypted: i=1; AJvYcCV6UssOOQGgK5ZyuKFEdHMlOFG2zVD7yUrGDwBR9WjVxgBMPpglV6bLMmn8k9ggH7qp4120+nWeDmc+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2d5/yi+ddHpkyyZ9AEl0Ha57q8LQ5SC9CBk6OyPTX0Xk2p9yF
	m4/2NrszrXld6jSKaKoHa4VhP7r+KqIALIJlWQZc2I/uWY8OPi8H7zKkGd41+oevKoo=
X-Gm-Gg: ASbGncsnAIrS5R33j4dPGZdEHinp3d57LOpmjPK+eZYpDPGXYt98dJY8WhdQ0+pZRuA
	MkIqls4FvN9Az+fm7IbUkXiujh0giA3FkAOU5/pidjUkxLL/Q/xzfWe9tT/7amfyPw8mQn4iMXE
	wkVX3AHFwqKjxG4cVBGIwZ4ZHniyAobgzkHLhFC5smJwH9wHn7OdBikKRluiu1eUrYCI+aKis9g
	0M292QGb447hCEi2DTnCuTWgD0a/y9vPsXNddqT6z/YrBFWYx6FZodH1bd8KwjulwjlS1yxuIuE
	OETAQNl3sCtBor/HPLNr8YzYu4EUmHM6f8DvC0f7Omz15p689BdZhYUMaW6AksE9dIpXFawHCPV
	iYn1Qcl8XwUcm63LjJIUofS9EeBpaDlufRwce+pykPMCpUtm+wQRmE63HkJYOhqh2cMQ=
X-Google-Smtp-Source: AGHT+IHKMn03UYm2I2J4TPmc1jy6+XybZkm8kaxxP3i30WStDU/ht3x7BfIAILNbbP0EfBkMTPEVjQ==
X-Received: by 2002:a05:600c:3509:b0:458:bd2a:496f with SMTP id 5b1f17b1804b1-45a1b646dc0mr29225375e9.21.1755190622048;
        Thu, 14 Aug 2025 09:57:02 -0700 (PDT)
Received: from smtpclient.apple (global-184-7.n-1.net.cam.ac.uk. [131.111.184.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1b789d68sm19043135e9.1.2025.08.14.09.57.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Aug 2025 09:57:01 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [External] [PATCH] ACPI: RISC-V: CPPC: Add CSR_CYCLE for CPPC FFH
From: Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <CAK9=C2UDVnpHs04VmzmjjmTYkE--dX2NtoWXGXoX=vVm=SF_5Q@mail.gmail.com>
Date: Thu, 14 Aug 2025 17:56:50 +0100
Cc: yunhui cui <cuiyunhui@bytedance.com>,
 aou@eecs.berkeley.edu,
 juwenlong@bytedance.com,
 alex@ghiti.fr,
 rafael@kernel.org,
 linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org,
 palmer@dabbelt.com,
 paul.walmsley@sifive.com,
 linux-riscv@lists.infradead.org,
 Rahul Pathak <rpathak@ventanamicro.com>,
 lenb@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4A3F784D-4844-48D8-AE84-B4D25BCB78B4@jrtc27.com>
References: <20250515094301.40016-1-cuiyunhui@bytedance.com>
 <CAEEQ3w=XqoKmVu1kvc5XUbGbQJsHVkRx=T65tXvYEYo0HCTcnQ@mail.gmail.com>
 <aJs-aPH32OxpzR3G@sunil-laptop>
 <CAEEQ3wnHFPBPC0U59rDBJaZYxJ24uJzJ7NDQO0gfmVqoiQwNOw@mail.gmail.com>
 <aJtKZhvNX0p3obFw@sunil-laptop>
 <CAEEQ3wmomscuAzuiRyJu4ha8tiM=s1Y-ytQROPTWr1DScMNL3g@mail.gmail.com>
 <aJwiXKWXik8BmpL8@sunil-laptop>
 <CAEEQ3wky3LXK=ge1wBkHD0ZWtwUF-aBn44EK0Uxa+_2DB1Giqw@mail.gmail.com>
 <CAK9=C2VOaAJZxCeM-5QPj5B-ie68LivJyQcM8KwKjdL9u00RJg@mail.gmail.com>
 <CAEEQ3wmDygvLn-EK_hCumOuCkPjKWfnmwiA+kz4p9N=thG0pXA@mail.gmail.com>
 <CAK9=C2X+6vs=Xa7XnreRs4+e5OjeJA-XtwwUM4GHq7pT=Fs-5A@mail.gmail.com>
 <CAEEQ3wm9shktdzUeO5RczE-=qdDUS30TGASOFtnMEcuw7L7jZw@mail.gmail.com>
 <CAK9=C2UDVnpHs04VmzmjjmTYkE--dX2NtoWXGXoX=vVm=SF_5Q@mail.gmail.com>
To: Anup Patel <apatel@ventanamicro.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

On 14 Aug 2025, at 14:37, Anup Patel <apatel@ventanamicro.com> wrote:
>=20
> On Thu, Aug 14, 2025 at 11:49=E2=80=AFAM yunhui cui =
<cuiyunhui@bytedance.com> wrote:
>>=20
>> Hi Anup,
>>=20
>> On Thu, Aug 14, 2025 at 1:48=E2=80=AFPM Anup Patel =
<apatel@ventanamicro.com> wrote:
>>>=20
>>> On Thu, Aug 14, 2025 at 9:08=E2=80=AFAM yunhui cui =
<cuiyunhui@bytedance.com> wrote:
>>>>=20
>>>> Hi Anup,
>>>>=20
>>>> On Wed, Aug 13, 2025 at 7:12=E2=80=AFPM Anup Patel =
<apatel@ventanamicro.com> wrote:
>>>>>=20
>>>>> On Wed, Aug 13, 2025 at 12:14=E2=80=AFPM yunhui cui =
<cuiyunhui@bytedance.com> wrote:
>>>>>>=20
>>>>>> Hi Sunil,
>>>>>>=20
>>>>>> On Wed, Aug 13, 2025 at 1:28=E2=80=AFPM Sunil V L =
<sunilvl@ventanamicro.com> wrote:
>>>>>>>=20
>>>>>>> Hi Yunhui,
>>>>>>>=20
>>>>>>> On Wed, Aug 13, 2025 at 11:23:39AM +0800, yunhui cui wrote:
>>>>>>>> Hi Sunil,
>>>>>>>>=20
>>>>>>>> On Tue, Aug 12, 2025 at 10:06=E2=80=AFPM Sunil V L =
<sunilvl@ventanamicro.com> wrote:
>>>>>>>>>=20
>>>>>>> [...]
>>>>>>>>>>>>=20
>>>>>>>>>>>> The purpose of cppc_ffh_csr_read() is to calculate the =
actual
>>>>>>>>>>>> frequency of the CPU, which is =
delta_CSR_CYCLE/delta_CSR_XXX.
>>>>>>>>>>>>=20
>>>>>>>>>>>> CSR_XXX should be a reference clock and does not count =
during WFI
>>>>>>>>>>>> (Wait For Interrupt).
>>>>>>>>>>>>=20
>>>>>>>>>>>> Similar solutions include: x86's aperf/mperf, and ARM64's =
AMU with
>>>>>>>>>>>> registers SYS_AMEVCNTR0_CORE_EL0/SYS_AMEVCNTR0_CONST_EL0.
>>>>>>>>>>>>=20
>>>>>>>>>>>> However, we know that CSR_TIME in the current code does =
count during
>>>>>>>>>>>> WFI. So, is this design unreasonable?
>>>>>>>>>>>>=20
>>>>>>>>>>>> Should we consider proposing an extension to support such a =
dedicated
>>>>>>>>>>>> counter (a reference clock that does not count during WFI)? =
This way,
>>>>>>>>>>>> the value can be obtained directly in S-mode without =
trapping to
>>>>>>>>>>>> M-mode, especially since reading this counter is very =
frequent.
>>>>>>>>>>>>=20
>>>>>>>>>>> Hi Yunhui,
>>>>>>>>>>>=20
>>>>>>>>>>> Yes, but we anticipated that vendors might define their own =
custom CSRs.
>>>>>>>>>>> So, we introduced FFH encoding to accommodate such cases.
>>>>>>>>>>>=20
>>>>>>>>>>> Thanks,
>>>>>>>>>>> Sunil
>>>>>>>>>>=20
>>>>>>>>>> As mentioned earlier, it is best to directly read CSR_XXX (a =
reference
>>>>>>>>>> clock that does not count during WFI) and CSR_CYCLE in =
S-mode, rather
>>>>>>>>>> than trapping to SBI.
>>>>>>>>>>=20
>>>>>>>>> No. I meant direct CSR access itself not SBI. Please take a =
look at
>>>>>>>>> Table 6 of RISC-V FFH spec.
>>>>>>>>>=20
>>>>>>>>>> drivers/acpi/riscv/cppc.c is a generic driver that is not =
specific to
>>>>>>>>>> any vendor. Currently, the upstream code already uses =
CSR_TIME, and
>>>>>>>>>> the logic of CSR_TIME is incorrect.
>>>>>>>>>>=20
>>>>>>> ACPI spec for "Reference Performance Register" says,
>>>>>>>=20
>>>>>>> "The Reference Performance Counter Register counts at a fixed =
rate any
>>>>>>> time the processor is active. It is not affected by changes to =
Desired
>>>>>>> Performance, processor throttling, etc."
>>>>>>>=20
>>>>>>>>> CSR_TIME is just an example. It is upto the vendor how _CPC =
objects are
>>>>>>>>> encoded using FFH. The linux code doesn't mean one should use =
CSR_TIME
>>>>>>>>> always.
>>>>>>>>=20
>>>>>>>> First, the example of CSR_TIME is incorrect. What is needed is =
a
>>>>>>>> CSR_XXX (a reference clock that does not count during WFI).
>>>>>>>>=20
>>>>>>>> Second, you mentioned that each vendor can customize their own
>>>>>>>> implementations. But should all vendors' CSR_XXX/YYY/... be =
added to
>>>>>>>> drivers/acpi/riscv/cppc.c? Shouldn=E2=80=99t =
drivers/acpi/riscv/cppc.c fall
>>>>>>>> under the scope defined by the RISC-V architecture?
>>>>>>>>=20
>>>>>>> No. One can implement similar to csr_read_num() in opensbi. We =
didn't
>>>>>>> add it since there was no HW implementing such thing. What I am
>>>>>>> saying is we have FFH encoding to support such case.
>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>>> It would be best to promote a specification to support =
CSR_XXX, just
>>>>>>>>>> like what has been done for x86 and arm64. What do you think?
>>>>>>>>>>=20
>>>>>>>>> Wouldn't above work? For a standard extension, you may have to =
provide
>>>>>>>>> more data with actual HW.
>>>>>>>>=20
>>>>>>>> This won=E2=80=99t work. May I ask how the current upstream =
code can calculate
>>>>>>>> the actual CPU frequency using CSR_TIME without trapping to =
SBI?
>>>>>>>> This is a theoretical logical issue. Why is data needed here?
>>>>>>>>=20
>>>>>>> As I mentioned above, one can implement a generic CSR read =
without
>>>>>>> trapping to SBI.
>>>>>>>=20
>>>>>>>> Could you take a look at the "AMU events and event numbers" =
chapter in
>>>>>>>> the ARM64 manual?
>>>>>>>>=20
>>>>>>> As-per ACPI spec reference performance counter is not affected =
by CPU
>>>>>>> state. The RISC-V FFH encoding is sufficiently generic to =
support this
>>>>>>> requirement, even if the standard CSR_TIME cannot be used. In =
such
>>>>>>> cases, an alternative CSR can be encodeded, accessed via an =
OS-level
>>>>>>> abstraction such as csr_read_num().
>>>>>>=20
>>>>>> So what you're saying is that we should submit a patch like this, =
right?
>>>>>>=20
>>>>>> diff --git a/drivers/acpi/riscv/cppc.c =
b/drivers/acpi/riscv/cppc.c
>>>>>> index 440cf9fb91aab..953c259d46c69 100644
>>>>>> --- a/drivers/acpi/riscv/cppc.c
>>>>>> +++ b/drivers/acpi/riscv/cppc.c
>>>>>> @@ -66,16 +66,8 @@ static void cppc_ffh_csr_read(void *read_data)
>>>>>> {
>>>>>>        struct sbi_cppc_data *data =3D (struct sbi_cppc_data =
*)read_data;
>>>>>>=20
>>>>>> -       switch (data->reg) {
>>>>>> -       /* Support only TIME CSR for now */
>>>>>> -       case CSR_TIME:
>>>>>> -               data->ret.value =3D csr_read(CSR_TIME);
>>>>>> -               data->ret.error =3D 0;
>>>>>> -               break;
>>>>>> -       default:
>>>>>> -               data->ret.error =3D -EINVAL;
>>>>>> -               break;
>>>>>> -       }
>>>>>> +       data->ret.value =3D csr_read_num(data->reg);
>>>>>> +       data->ret.error =3D 0;
>>>>>> }
>>>>>>=20
>>>>>> If that's the case, the robustness of the code cannot be =
guaranteed,
>>>>>> because the range of CSRs from different vendors is unknown.
>>>>>=20
>>>>> ACPI FFH is allows mapping to any CSR.
>>>>=20
>>>> Yes, FFH can map any CSR, and this is not the point of contention.
>>>>=20
>>>> If that's the case, the CSR_TIME used in the current kernel code is
>>>> inappropriate. Some vendors may design a counter that does not =
count
>>>> during WFI, making CSR_TIME irrelevant. Even if counting continues
>>>> during WFI, are you planning to have one counter operate in S-mode
>>>> while the other traps to M-mode?
>>>>=20
>>>> In that case, the code would need to be modified as proposed above. =
Do
>>>> you agree?
>>>=20
>>> I disagree.
>>>=20
>>> Like Sunil already explained, if an implementation has reference =
counter
>>> which does not count during WFI state then for such implementation =
the
>>> delivered performance counter should also not increment during WFI
>>> to maintain the relative delta of increments. This means if an =
implementation
>>> uses TIME CSR as reference counter then for such implementation
>>> the delivered performance counter should increment accordingly. =
Ultimately,
>>> what matters is OS being able to correctly compute the performance =
level
>>> using reference and delivered performance counters.
>>=20
>>=20
>> For calculating the actual CPU frequency, both implementations are
>> acceptable where either both counters continue counting during WFI or
>> both stop counting.
>> In the current code, how do you read the other counter?
>> Shouldn't it be modified like this to support it? This way, all
>> counters can be read directly in S-mode without trapping to M-mode:
>> +       data->ret.value =3D csr_read_num(data->reg);
>> +       data->ret.error =3D 0;
>=20
> Yes, the current switch-case needs to replaced by common
> csr_read_num() and csr_write_num() implemented in arch/riscv/
>=20
> The RISC-V CSR space is limited so with it is straightforward
> to implement csr_read_num() and csr_write_num() using
> macros where each CSR access will turn-out to be roughly
> 3-4 instructions.

12 bits, or 4096 CSRs. Are you saying you want to have a jump table
that dispatches to one of 4096 entry points?

Maybe you can cut that down a bit for S-mode based on the encoding
convention, but that only eliminates 1/4, so you=E2=80=99re still =
looking at
3072 entry points, perhaps also minus the few that are allocated and
clearly not sensible things to use for this, like stval.

But I think that=E2=80=99s not a reasonable approach to take, and if =
there is
no CSR in the current RISC-V spec that fits the needs of ACPI then one
needs to be defined so that we don=E2=80=99t need every vendor to invent =
their
own. If there is a CSR already then that should be the only one that=E2=80=
=99s
allowed to be used here. If you look at arm64, it hard-codes which
counter to use for each of the two calls it supports. That=E2=80=99s a =
much
better world to be in.

Jessica


