Return-Path: <linux-acpi+bounces-15661-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A21B259E8
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 05:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F44A6880AA
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 03:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECD517A2EC;
	Thu, 14 Aug 2025 03:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YP5XH4CS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348F7157493
	for <linux-acpi@vger.kernel.org>; Thu, 14 Aug 2025 03:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755142694; cv=none; b=Xx1Lg2Qw5/dhfInulEUt0UlnMow5bQQ+sptfA8IOY2JpA0klaUzMTmD3Uy/5gG9Xkqi2MU5FSDAcYYU4nSeNKWbn5U3fDAlCCIr+76aNdbRJ/6XE+bLgcp32+xKtxA94SEB4LTPKmweJELCq9Ag08JFyIUf81qZc6giR9C9/07I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755142694; c=relaxed/simple;
	bh=uOHw+GnFS8frKp1UKJKEw+bBulS8fbGkEDbwotcBUL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIi7teLu585wmDo6lqXjbbyL2PX3ydLv3RPahEGPbp5+Ict47johBC//LOhhO4rIWZoBC38jE3lsH6paksLchd8ApbobwkZGQsCXLg2iYP4kZxFTXwmWl33Dck5C/iFKgdDwD5xdrtxLGzlvOjym/pSfnMlwE/+P/wUrQpn8/RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YP5XH4CS; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-435e2b89f9dso1411b6e.1
        for <linux-acpi@vger.kernel.org>; Wed, 13 Aug 2025 20:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755142691; x=1755747491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUu6oSbO6D+uUoB3TSxixh5CZbC6ogSp8+KOXMU+i3c=;
        b=YP5XH4CST1XRLTAuGuZ2TgnuZrKxT3nz9kVREVsq4u4ylm0JdsDK0UVq4GkNZ5FZSL
         Wu1fGL60+GiKENR1wjnknvnDFIFd46sA+vVO6cGcVbIRhSS5zRIaKv3cZG6H8qXxk1np
         kWCdUZYKIRrlENY+TIMB1p7eRXiRzA5Sx/7tJ+0w/PyW8HvLJ2CTlLdcHp4Gy4E0U5PE
         OjeXw2XhGt4DqB9GbTQAL7HKjRr27f0kagHMkjqoUhq+PFOw/NikoYfzOOI//Iq50jUr
         ckZk24ONXLPso8xq0VYEF5wauvP0wSJ4N5L/rjQbGqlf/Xm4fsOOfAzDcP+UC+AweRmZ
         inwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755142691; x=1755747491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUu6oSbO6D+uUoB3TSxixh5CZbC6ogSp8+KOXMU+i3c=;
        b=iMb2gbhS7+uUtF3c7+0ud+2YpEsFT8sJfjcfHW4YsH3+dg86JDa7NoRlk/FsZBkmLz
         8ZUdWyUQZBBVlOVrtQleibnflLn7PIXJWH96jqaIgChwqWH/StdNSb+sbR4pqsrrBfVD
         VeR4M61d+PfNspnepzSnZgrvPE7GPNi6gdtq4+vdnBipRdfjvDccz/Dh0+YaiypEFPD9
         eJK1Iuw1YDEgdGZYCIKIbl/+/1LNkCzCZPdtnkHLQzWVdk98HGroGN8RiHZQrOx/5XAz
         +9lR/UTlFximCKJwjnbL65LPDhqFwyr9DEbIfn0YdsbZSFtKRKVamhxa8SpREmg08Ivw
         jAMg==
X-Forwarded-Encrypted: i=1; AJvYcCV1ihBSVyzWVENmzw9DarUv0NbVWzUKlzmlEFxmxkVmNB71TzXRRLMdJdwMqEz+q323baf1k2epdPfO@vger.kernel.org
X-Gm-Message-State: AOJu0YyiGvfbGcFAH6sJEGmHGOeaTrmL+NXt7JjFRAWs9xDjYoMKMoe3
	TCrcaYSsLIYl6jf6DUeRGaM2AUNQs6z/2dm5FJIwY0Y06r5Vf9CxqdYn+71aijhB6FPr8AKvlz0
	AHuSkRA6/mkK52GwAUo0HoZjAWScpMizSoHk5hunL/A==
X-Gm-Gg: ASbGncsF8KsX446Tphin3gHZXSY1cCC7qTR7iLS6guoyQsGS3RU54EqEd/TuuT5LSM9
	i29Fxkd35n+Xy5de9FhP4LXk2ALO6d/GO/5faEZaYz32MHpp3vqwx+J8kE2GnhByB5bjt9AO7/h
	thTbMM1snaLaUH3HVGPvIkLNz5IXLVnRI7ikvQW0J2NzCaLBTyeIqy7WyGhBhJhIEHydA89GP//
	BiwIBRn/1Nek0M9QIFp
X-Google-Smtp-Source: AGHT+IFjHWcdv5oE5C1YN1jOSYALZcdBu+X0+1pQuzNgk6FzmgT8QU+Oy6pHz6bk7kpTc2WG6bJwuRY/duk1idFQEI8=
X-Received: by 2002:a05:6808:4f25:b0:415:9306:2e3b with SMTP id
 5614622812f47-435df7c755dmr904332b6e.23.1755142690957; Wed, 13 Aug 2025
 20:38:10 -0700 (PDT)
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
In-Reply-To: <CAK9=C2VOaAJZxCeM-5QPj5B-ie68LivJyQcM8KwKjdL9u00RJg@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 14 Aug 2025 11:37:58 +0800
X-Gm-Features: Ac12FXxW1tpavd5e7r8AJU48FLd8aGJQvqCB0NLX9F_9NFjMnhVNy3qquQBWkqQ
Message-ID: <CAEEQ3wmDygvLn-EK_hCumOuCkPjKWfnmwiA+kz4p9N=thG0pXA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] ACPI: RISC-V: CPPC: Add CSR_CYCLE for CPPC FFH
To: Anup Patel <apatel@ventanamicro.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>, rafael@kernel.org, lenb@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Rahul Pathak <rpathak@ventanamicro.com>, 
	juwenlong@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Anup,

On Wed, Aug 13, 2025 at 7:12=E2=80=AFPM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> On Wed, Aug 13, 2025 at 12:14=E2=80=AFPM yunhui cui <cuiyunhui@bytedance.=
com> wrote:
> >
> > Hi Sunil,
> >
> > On Wed, Aug 13, 2025 at 1:28=E2=80=AFPM Sunil V L <sunilvl@ventanamicro=
.com> wrote:
> > >
> > > Hi Yunhui,
> > >
> > > On Wed, Aug 13, 2025 at 11:23:39AM +0800, yunhui cui wrote:
> > > > Hi Sunil,
> > > >
> > > > On Tue, Aug 12, 2025 at 10:06=E2=80=AFPM Sunil V L <sunilvl@ventana=
micro.com> wrote:
> > > > >
> > > [...]
> > > > > > > >
> > > > > > > > The purpose of cppc_ffh_csr_read() is to calculate the actu=
al
> > > > > > > > frequency of the CPU, which is delta_CSR_CYCLE/delta_CSR_XX=
X.
> > > > > > > >
> > > > > > > > CSR_XXX should be a reference clock and does not count duri=
ng WFI
> > > > > > > > (Wait For Interrupt).
> > > > > > > >
> > > > > > > > Similar solutions include: x86's aperf/mperf, and ARM64's A=
MU with
> > > > > > > > registers SYS_AMEVCNTR0_CORE_EL0/SYS_AMEVCNTR0_CONST_EL0.
> > > > > > > >
> > > > > > > > However, we know that CSR_TIME in the current code does cou=
nt during
> > > > > > > > WFI. So, is this design unreasonable?
> > > > > > > >
> > > > > > > > Should we consider proposing an extension to support such a=
 dedicated
> > > > > > > > counter (a reference clock that does not count during WFI)?=
 This way,
> > > > > > > > the value can be obtained directly in S-mode without trappi=
ng to
> > > > > > > > M-mode, especially since reading this counter is very frequ=
ent.
> > > > > > > >
> > > > > > > Hi Yunhui,
> > > > > > >
> > > > > > > Yes, but we anticipated that vendors might define their own c=
ustom CSRs.
> > > > > > > So, we introduced FFH encoding to accommodate such cases.
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Sunil
> > > > > >
> > > > > > As mentioned earlier, it is best to directly read CSR_XXX (a re=
ference
> > > > > > clock that does not count during WFI) and CSR_CYCLE in S-mode, =
rather
> > > > > > than trapping to SBI.
> > > > > >
> > > > > No. I meant direct CSR access itself not SBI. Please take a look =
at
> > > > > Table 6 of RISC-V FFH spec.
> > > > >
> > > > > > drivers/acpi/riscv/cppc.c is a generic driver that is not speci=
fic to
> > > > > > any vendor. Currently, the upstream code already uses CSR_TIME,=
 and
> > > > > > the logic of CSR_TIME is incorrect.
> > > > > >
> > > ACPI spec for "Reference Performance Register" says,
> > >
> > > "The Reference Performance Counter Register counts at a fixed rate an=
y
> > > time the processor is active. It is not affected by changes to Desire=
d
> > > Performance, processor throttling, etc."
> > >
> > > > > CSR_TIME is just an example. It is upto the vendor how _CPC objec=
ts are
> > > > > encoded using FFH. The linux code doesn't mean one should use CSR=
_TIME
> > > > > always.
> > > >
> > > > First, the example of CSR_TIME is incorrect. What is needed is a
> > > > CSR_XXX (a reference clock that does not count during WFI).
> > > >
> > > > Second, you mentioned that each vendor can customize their own
> > > > implementations. But should all vendors' CSR_XXX/YYY/... be added t=
o
> > > > drivers/acpi/riscv/cppc.c? Shouldn=E2=80=99t drivers/acpi/riscv/cpp=
c.c fall
> > > > under the scope defined by the RISC-V architecture?
> > > >
> > > No. One can implement similar to csr_read_num() in opensbi. We didn't
> > > add it since there was no HW implementing such thing. What I am
> > > saying is we have FFH encoding to support such case.
> > >
> > > > >
> > > > > > It would be best to promote a specification to support CSR_XXX,=
 just
> > > > > > like what has been done for x86 and arm64. What do you think?
> > > > > >
> > > > > Wouldn't above work? For a standard extension, you may have to pr=
ovide
> > > > > more data with actual HW.
> > > >
> > > > This won=E2=80=99t work. May I ask how the current upstream code ca=
n calculate
> > > > the actual CPU frequency using CSR_TIME without trapping to SBI?
> > > > This is a theoretical logical issue. Why is data needed here?
> > > >
> > > As I mentioned above, one can implement a generic CSR read without
> > > trapping to SBI.
> > >
> > > > Could you take a look at the "AMU events and event numbers" chapter=
 in
> > > > the ARM64 manual?
> > > >
> > > As-per ACPI spec reference performance counter is not affected by CPU
> > > state. The RISC-V FFH encoding is sufficiently generic to support thi=
s
> > > requirement, even if the standard CSR_TIME cannot be used. In such
> > > cases, an alternative CSR can be encodeded, accessed via an OS-level
> > > abstraction such as csr_read_num().
> >
> > So what you're saying is that we should submit a patch like this, right=
?
> >
> > diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
> > index 440cf9fb91aab..953c259d46c69 100644
> > --- a/drivers/acpi/riscv/cppc.c
> > +++ b/drivers/acpi/riscv/cppc.c
> > @@ -66,16 +66,8 @@ static void cppc_ffh_csr_read(void *read_data)
> >  {
> >         struct sbi_cppc_data *data =3D (struct sbi_cppc_data *)read_dat=
a;
> >
> > -       switch (data->reg) {
> > -       /* Support only TIME CSR for now */
> > -       case CSR_TIME:
> > -               data->ret.value =3D csr_read(CSR_TIME);
> > -               data->ret.error =3D 0;
> > -               break;
> > -       default:
> > -               data->ret.error =3D -EINVAL;
> > -               break;
> > -       }
> > +       data->ret.value =3D csr_read_num(data->reg);
> > +       data->ret.error =3D 0;
> >  }
> >
> > If that's the case, the robustness of the code cannot be guaranteed,
> > because the range of CSRs from different vendors is unknown.
>
> ACPI FFH is allows mapping to any CSR.

Yes, FFH can map any CSR, and this is not the point of contention.

If that's the case, the CSR_TIME used in the current kernel code is
inappropriate. Some vendors may design a counter that does not count
during WFI, making CSR_TIME irrelevant. Even if counting continues
during WFI, are you planning to have one counter operate in S-mode
while the other traps to M-mode?

In that case, the code would need to be modified as proposed above. Do
you agree?

Without a specification defining these two counters, the above code
would lack robustness.

>
> >
> > Since each vendor will define their own CSRs, why not formalize them
> > into a specification?
>
> The _CPC objects in the ACPI table point to platform specific mechanisms
> of accessing CPPC CSR so it can point to a vendor specific CSR.
>
> Regards,
> Anup

Thanks,
Yunhui

