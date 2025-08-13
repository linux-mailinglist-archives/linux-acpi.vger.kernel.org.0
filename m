Return-Path: <linux-acpi+bounces-15626-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66666B23EF9
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Aug 2025 05:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840081A26464
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Aug 2025 03:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F18927056E;
	Wed, 13 Aug 2025 03:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="T503ZE5K"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0872690D9
	for <linux-acpi@vger.kernel.org>; Wed, 13 Aug 2025 03:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755055433; cv=none; b=O+IaPiRWkprYpSFo03rMOFdJFlQyrZyqPBF2t93i56P7G4DZIrx4ARqCDsna9FoIPthODowsoazJ97aLdeG/y/s22iLu1BQ79cwNalyW9ktwLeNuVbGIusS5/6EIiWlxGX4MrH32eD6+JNbTm+aPatenQafVe7iaoimIx35Y68Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755055433; c=relaxed/simple;
	bh=+b/rHlzlrnJFBTqdVOQ82H2x9LikxRlFuUDVTUewGjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfyC/AIqA/a0Vo9Pkxn70mFJs25c4FCGxQtWnENBNIBdUYnQhVIa46+rTGFrJ/Djpz2D1DBRVvjz6dXaRB402wx3rkC+eklJz/B5ogUX6zqq8ypoSaigBGUqbNGCNIUv5HEuZBshC0Z4B0kzTniwLI2cOdvzqBy6/SUwlnOJWRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=T503ZE5K; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-433f599d5b9so3962984b6e.2
        for <linux-acpi@vger.kernel.org>; Tue, 12 Aug 2025 20:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755055430; x=1755660230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2VCV0IcKQbeDysFZNp7fgDy2mqwBozQbq8Iq9HYJ1rc=;
        b=T503ZE5KB/l1AjE9a2PuXkGbPV2jSQgyCabxy2OSJoqkQWd5hsImByoZWXwgqH324l
         7/mQKHst1/AoHXe8JsPOYhJi/8qOe/cY77N6u9ZQcdKwt+sm0pMlZjNn0tZNzd6x3t2z
         Ao7Pcy1qjTvvOyiMVrKR5C3BI0VQgoLa0rZFeWiEFj4J1I5gOfbHH0R12C9Wy0xyrpeF
         Qufx87IpDbR+mzuwt2pBY9kvUVXYoz7mGfnZ8Mlnv+zTEJhawiEJspQwuyZbCdNXiWr/
         gvPUK40BR8d6wHrGbamf0+BNuvGP8UJFtMMV8NxiBhTubwCBcijKu5gav/Ht04tIJeCc
         efnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755055430; x=1755660230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2VCV0IcKQbeDysFZNp7fgDy2mqwBozQbq8Iq9HYJ1rc=;
        b=bKi+JMynv0CjX9/RHt49VoOYKs3I87oLxt0fv35TdYXyk31HFGQMjBDqgVUNomxXyM
         SQBSYT8lrxUJZ8W/3LiTrDsKTec1IJ22Lqo/JmnfhntmFJEb6S9yyc4uOnV5HkKgIIo1
         ijauli0VaDySI+LQUB2gdjOjGeZ7LjExQTeDjndYom7G69b5f6a2RhTJwMedLecn1RLu
         uGMDoI83Wo6Jyy0XJpnt9U7reVxfFP6GH1JYLpkHWVWoaUy79Zyh6eU59qckYBXO379V
         7q+IJQqPpLXsDBcEAi2jWItveiJJv0uiewStbyuO6Ez9Kj9tWkSJR0mLENSnR6ooTTga
         eUMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7lQFMHzytr8KCbOKusfYIXXSzm/Tj5c8CFEdZefZPV9fGxDhEWFezDao9w/9ywTqWaOBA54lx/BOj@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/YsJOU9JTPIavKdM1BvGtDg7XipjEzeQh66fiyez/w6MeE0r+
	QTb7ch1zzC145HympSvq0TM4gimvhsQi+qMivGePMwLK/NZl9p875jknPOQDKK4mk/LoFC2OuIm
	k+4cx8RUabGQJRiB3OVQRyVAhv2ZQDy0v4XbSHhlqPw==
X-Gm-Gg: ASbGncvEgK6mAsnjFZF8YuYpfI5C3IH/4XjzavAyZMkZNrSzxw0DsSzSdjRStcQbQcR
	EyEsZG35O/0VqX2lh+yEY7XMgC4T0C1HLnuLHh/F22F9Oj+88pvKBf/R8T5dh5edCTM6E+Ev8tX
	ThF7CWeqcAGaiIsE+PXhPbqQZvpKHi09rWsMJ/BtP8D3J/nDKwYILjVzIkihsE0bj70RbTZueLy
	elhXZbr3nmcsdgJF//OAOhB
X-Google-Smtp-Source: AGHT+IHToQLYwLq1/teWU7qsFi7+iFfC6eraS42g9mMDfypdyNKK18baY/bFJ+yAHRyJKFNY0FsEqDTEhE8C509h41k=
X-Received: by 2002:a05:6808:1889:b0:433:ef4c:6d85 with SMTP id
 5614622812f47-435d4142142mr973085b6e.14.1755055430087; Tue, 12 Aug 2025
 20:23:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515094301.40016-1-cuiyunhui@bytedance.com>
 <CAEEQ3w=XqoKmVu1kvc5XUbGbQJsHVkRx=T65tXvYEYo0HCTcnQ@mail.gmail.com>
 <aJs-aPH32OxpzR3G@sunil-laptop> <CAEEQ3wnHFPBPC0U59rDBJaZYxJ24uJzJ7NDQO0gfmVqoiQwNOw@mail.gmail.com>
 <aJtKZhvNX0p3obFw@sunil-laptop>
In-Reply-To: <aJtKZhvNX0p3obFw@sunil-laptop>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 13 Aug 2025 11:23:39 +0800
X-Gm-Features: Ac12FXwhM6-MmscWbyq1ralTrqKIU7ifLVg5RHi-3fR206-epo7nHbTF62cmctI
Message-ID: <CAEEQ3wmomscuAzuiRyJu4ha8tiM=s1Y-ytQROPTWr1DScMNL3g@mail.gmail.com>
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

On Tue, Aug 12, 2025 at 10:06=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.co=
m> wrote:
>
> On Tue, Aug 12, 2025 at 09:32:10PM +0800, yunhui cui wrote:
> > Hi Sunil,
> >
> >
> > On Tue, Aug 12, 2025 at 9:15=E2=80=AFPM Sunil V L <sunilvl@ventanamicro=
.com> wrote:
> > >
> > > On Tue, Aug 12, 2025 at 07:25:44PM +0800, yunhui cui wrote:
> > > > Hi Sunil,
> > > >
> > > > On Thu, May 15, 2025 at 5:44=E2=80=AFPM Yunhui Cui <cuiyunhui@byted=
ance.com> wrote:
> > > > >
> > > > > Add the read of CSR_CYCLE to cppc_ffh_csr_read() to fix the
> > > > > warning message: "CPPC Cpufreq: cppc_scale_freq_wokrfn: failed
> > > > > to read perf counters".
> > > > >
> > > > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > > > ---
> > > > >  drivers/acpi/riscv/cppc.c | 5 ++++-
> > > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.=
c
> > > > > index 4cdff387deff6..c1acaeb18eac3 100644
> > > > > --- a/drivers/acpi/riscv/cppc.c
> > > > > +++ b/drivers/acpi/riscv/cppc.c
> > > > > @@ -69,11 +69,14 @@ static void cppc_ffh_csr_read(void *read_data=
)
> > > > >         struct sbi_cppc_data *data =3D (struct sbi_cppc_data *)re=
ad_data;
> > > > >
> > > > >         switch (data->reg) {
> > > > > -       /* Support only TIME CSR for now */
> > > > >         case CSR_TIME:
> > > > >                 data->ret.value =3D csr_read(CSR_TIME);
> > > > >                 data->ret.error =3D 0;
> > > > >                 break;
> > > > > +       case CSR_CYCLE:
> > > > > +               data->ret.value =3D csr_read(CSR_CYCLE);
> > > > > +               data->ret.error =3D 0;
> > > > > +               break;
> > > > >         default:
> > > > >                 data->ret.error =3D -EINVAL;
> > > > >                 break;
> > > > > --
> > > > > 2.39.2
> > > > >
> > > >
> > > > The purpose of cppc_ffh_csr_read() is to calculate the actual
> > > > frequency of the CPU, which is delta_CSR_CYCLE/delta_CSR_XXX.
> > > >
> > > > CSR_XXX should be a reference clock and does not count during WFI
> > > > (Wait For Interrupt).
> > > >
> > > > Similar solutions include: x86's aperf/mperf, and ARM64's AMU with
> > > > registers SYS_AMEVCNTR0_CORE_EL0/SYS_AMEVCNTR0_CONST_EL0.
> > > >
> > > > However, we know that CSR_TIME in the current code does count durin=
g
> > > > WFI. So, is this design unreasonable?
> > > >
> > > > Should we consider proposing an extension to support such a dedicat=
ed
> > > > counter (a reference clock that does not count during WFI)? This wa=
y,
> > > > the value can be obtained directly in S-mode without trapping to
> > > > M-mode, especially since reading this counter is very frequent.
> > > >
> > > Hi Yunhui,
> > >
> > > Yes, but we anticipated that vendors might define their own custom CS=
Rs.
> > > So, we introduced FFH encoding to accommodate such cases.
> > >
> > > Thanks,
> > > Sunil
> >
> > As mentioned earlier, it is best to directly read CSR_XXX (a reference
> > clock that does not count during WFI) and CSR_CYCLE in S-mode, rather
> > than trapping to SBI.
> >
> No. I meant direct CSR access itself not SBI. Please take a look at
> Table 6 of RISC-V FFH spec.
>
> > drivers/acpi/riscv/cppc.c is a generic driver that is not specific to
> > any vendor. Currently, the upstream code already uses CSR_TIME, and
> > the logic of CSR_TIME is incorrect.
> >
> CSR_TIME is just an example. It is upto the vendor how _CPC objects are
> encoded using FFH. The linux code doesn't mean one should use CSR_TIME
> always.

First, the example of CSR_TIME is incorrect. What is needed is a
CSR_XXX (a reference clock that does not count during WFI).

Second, you mentioned that each vendor can customize their own
implementations. But should all vendors' CSR_XXX/YYY/... be added to
drivers/acpi/riscv/cppc.c? Shouldn=E2=80=99t drivers/acpi/riscv/cppc.c fall
under the scope defined by the RISC-V architecture?

>
> > It would be best to promote a specification to support CSR_XXX, just
> > like what has been done for x86 and arm64. What do you think?
> >
> Wouldn't above work? For a standard extension, you may have to provide
> more data with actual HW.

This won=E2=80=99t work. May I ask how the current upstream code can calcul=
ate
the actual CPU frequency using CSR_TIME without trapping to SBI?
This is a theoretical logical issue. Why is data needed here?

Could you take a look at the "AMU events and event numbers" chapter in
the ARM64 manual?


>
> Thanks,
> Sunil

Thanks,
Yunhui

