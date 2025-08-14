Return-Path: <linux-acpi+bounces-15666-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6757FB25BBD
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 08:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328891BC657E
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 06:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A34124061F;
	Thu, 14 Aug 2025 06:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eUG1z/Tr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CD7242D76
	for <linux-acpi@vger.kernel.org>; Thu, 14 Aug 2025 06:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755152400; cv=none; b=UurIr2sALoa45NG6nbzZNIDqaNSVLP19qT+cwuWJ+WBCLbzGJeCZhb5GlHrdX40bXxQRkoJ9FdqIzfEty+uzXA8NhHFKqMicJMBOyYWtJZnZS1Ps3y7CpBmDGxQwZIsUVIewTN7/EB6jBKHmACyhILDZyzr+ZaGiFSVLRRqHvJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755152400; c=relaxed/simple;
	bh=aH5aCG26MEvtZCrulLttDBq0GXZKtGlLmyaXUPBQMwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMZgU2wQfkz2oiRzJNn5CQWWS06swXBfy+iUg3IsK9VYhrvUW6GhoAgLs0NPnATlXLcx1dumD4Vowd1yPACXd7onaVcMIgkLxolk1vkVhrSlAcjaAbtvFOTepvkaGZlrXIxQEiv0zDoYEEaoLGx7+gRO+H/jsGD/DdpbhjIcJsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eUG1z/Tr; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-30ccec50c0aso469222fac.3
        for <linux-acpi@vger.kernel.org>; Wed, 13 Aug 2025 23:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755152397; x=1755757197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K37ZoIE953NbQpDgEOfmT9VHYZQ4PHUN5FAq5i39cDs=;
        b=eUG1z/Trsm06Q1xzor9Xs++UDnyjwtRIVDJKsDKHg8X/x8oWKeEM06jQnEuWxcqQj+
         kIcbPXMPF1UgmYvQPYjNAnN95zkBsqfQIhAQtW4uCILBmRsAiK1SWg+GzbtAx/6T+Rou
         R5p4CxYDH+L9AJRm9SbS0KTYVD41tSvcFQ95Kquk3fI8s7HwPeZoKZ40xgqEH9+HqKqa
         AXIp8pp43p4bWcNTQrRy5HyttOBZR5eqNPNqYslbWBehvgzgm9MSiCX3LgIy6a4BypNJ
         FKtCVw1JUxWJSIJFXsnZ89M6ykmQaFHw6LvOMdnQTAqZ4cQfhDo/UiyivIQcde2tkKvc
         fibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755152397; x=1755757197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K37ZoIE953NbQpDgEOfmT9VHYZQ4PHUN5FAq5i39cDs=;
        b=KADwVxmDZ2WVjmbqP9KCKU23g68qU8LLd0AlLSOtPlenXF0tPGgx1atSGRY9zOPCNN
         62OjFSS2OeUrzMsiy3P+iv1Xsggky2lV9C3b4Zv2cULEMfZluuqRZGav8Q15KqJmVaVR
         NyeR4HSsGdwhOlIFp0snAgrqVB1NEkTKClsT2qn8ZYCBLLRBm1U7nZ9YN1GsiSo50D+2
         V+IrRhBHURbY3Fl8pxYtBSHWeXthmKaOSqny0Vcou5stLIT/2WEpExK9zkh/z96JLa50
         9wCH+EINxvx+bqqD6SOEgjgjWAoacXVd/RY3l0oXFWOXNI7Z3n1BJm39xtKtvVgAmFy4
         65Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUZNSVuVRbmrXxcNwdKVpUNaQpAdUUq5GXF2o6ZHc7t+7rFvC+s+x/stiqhevSe44q7o7qHCzYiBOZD@vger.kernel.org
X-Gm-Message-State: AOJu0YyaKOKcVt0sK0kVcpuzk0ZUSjnoPzM1jn0Y0NEp6NJQmoQ92v3m
	Kl8HixOf+PzrgchgxXaR3WCsXg0S+fIvTGbcBPykBHgkgGrveDWI0XPuQpvKSBDyOu7OMVMpvtJ
	xwFtz755pOk3KywBwk4WyL1EyF2NVBXkf6WhpPstvEw==
X-Gm-Gg: ASbGncte/sqk/r+pvIl30cpKrUaJRdxB5yfMlgPbSskrFvVZX4l+PwL1qrXejyfLcY5
	8jsW6cC8COmTwS8XwfWpL3gpz5qjVvfRQAnOJosWHwlPJovFpJ7jGgKGrDUj9Y+6uUs5u6+stfo
	nk8tjrGiFLitIejcu+1HUn0J3XneNiGoPEgjyny3Gk6LnYEhv6D/K6kmm7/T1N1lHkpWJonB2y+
	sYVExDXfo0YQV92vD83
X-Google-Smtp-Source: AGHT+IFF1KhFGVek9692RhQESMEbD6QEJ3AjQ87DDfwoloFOdRs2+IYdpxgdieq0emI6nzT2JrVcgi1yj/0KDyyBilU=
X-Received: by 2002:a05:6808:130b:b0:434:2d4:f1ad with SMTP id
 5614622812f47-435df7e35d2mr1015717b6e.19.1755152396808; Wed, 13 Aug 2025
 23:19:56 -0700 (PDT)
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
 <CAEEQ3wmDygvLn-EK_hCumOuCkPjKWfnmwiA+kz4p9N=thG0pXA@mail.gmail.com> <CAK9=C2X+6vs=Xa7XnreRs4+e5OjeJA-XtwwUM4GHq7pT=Fs-5A@mail.gmail.com>
In-Reply-To: <CAK9=C2X+6vs=Xa7XnreRs4+e5OjeJA-XtwwUM4GHq7pT=Fs-5A@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 14 Aug 2025 14:19:45 +0800
X-Gm-Features: Ac12FXxWcnW9AvzpB4Tg96jAcApHUxx-84Vd4X88-9DuHSc2Z0oR48FZbQwB7EQ
Message-ID: <CAEEQ3wm9shktdzUeO5RczE-=qdDUS30TGASOFtnMEcuw7L7jZw@mail.gmail.com>
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

On Thu, Aug 14, 2025 at 1:48=E2=80=AFPM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> On Thu, Aug 14, 2025 at 9:08=E2=80=AFAM yunhui cui <cuiyunhui@bytedance.c=
om> wrote:
> >
> > Hi Anup,
> >
> > On Wed, Aug 13, 2025 at 7:12=E2=80=AFPM Anup Patel <apatel@ventanamicro=
.com> wrote:
> > >
> > > On Wed, Aug 13, 2025 at 12:14=E2=80=AFPM yunhui cui <cuiyunhui@byteda=
nce.com> wrote:
> > > >
> > > > Hi Sunil,
> > > >
> > > > On Wed, Aug 13, 2025 at 1:28=E2=80=AFPM Sunil V L <sunilvl@ventanam=
icro.com> wrote:
> > > > >
> > > > > Hi Yunhui,
> > > > >
> > > > > On Wed, Aug 13, 2025 at 11:23:39AM +0800, yunhui cui wrote:
> > > > > > Hi Sunil,
> > > > > >
> > > > > > On Tue, Aug 12, 2025 at 10:06=E2=80=AFPM Sunil V L <sunilvl@ven=
tanamicro.com> wrote:
> > > > > > >
> > > > > [...]
> > > > > > > > > >
> > > > > > > > > > The purpose of cppc_ffh_csr_read() is to calculate the =
actual
> > > > > > > > > > frequency of the CPU, which is delta_CSR_CYCLE/delta_CS=
R_XXX.
> > > > > > > > > >
> > > > > > > > > > CSR_XXX should be a reference clock and does not count =
during WFI
> > > > > > > > > > (Wait For Interrupt).
> > > > > > > > > >
> > > > > > > > > > Similar solutions include: x86's aperf/mperf, and ARM64=
's AMU with
> > > > > > > > > > registers SYS_AMEVCNTR0_CORE_EL0/SYS_AMEVCNTR0_CONST_EL=
0.
> > > > > > > > > >
> > > > > > > > > > However, we know that CSR_TIME in the current code does=
 count during
> > > > > > > > > > WFI. So, is this design unreasonable?
> > > > > > > > > >
> > > > > > > > > > Should we consider proposing an extension to support su=
ch a dedicated
> > > > > > > > > > counter (a reference clock that does not count during W=
FI)? This way,
> > > > > > > > > > the value can be obtained directly in S-mode without tr=
apping to
> > > > > > > > > > M-mode, especially since reading this counter is very f=
requent.
> > > > > > > > > >
> > > > > > > > > Hi Yunhui,
> > > > > > > > >
> > > > > > > > > Yes, but we anticipated that vendors might define their o=
wn custom CSRs.
> > > > > > > > > So, we introduced FFH encoding to accommodate such cases.
> > > > > > > > >
> > > > > > > > > Thanks,
> > > > > > > > > Sunil
> > > > > > > >
> > > > > > > > As mentioned earlier, it is best to directly read CSR_XXX (=
a reference
> > > > > > > > clock that does not count during WFI) and CSR_CYCLE in S-mo=
de, rather
> > > > > > > > than trapping to SBI.
> > > > > > > >
> > > > > > > No. I meant direct CSR access itself not SBI. Please take a l=
ook at
> > > > > > > Table 6 of RISC-V FFH spec.
> > > > > > >
> > > > > > > > drivers/acpi/riscv/cppc.c is a generic driver that is not s=
pecific to
> > > > > > > > any vendor. Currently, the upstream code already uses CSR_T=
IME, and
> > > > > > > > the logic of CSR_TIME is incorrect.
> > > > > > > >
> > > > > ACPI spec for "Reference Performance Register" says,
> > > > >
> > > > > "The Reference Performance Counter Register counts at a fixed rat=
e any
> > > > > time the processor is active. It is not affected by changes to De=
sired
> > > > > Performance, processor throttling, etc."
> > > > >
> > > > > > > CSR_TIME is just an example. It is upto the vendor how _CPC o=
bjects are
> > > > > > > encoded using FFH. The linux code doesn't mean one should use=
 CSR_TIME
> > > > > > > always.
> > > > > >
> > > > > > First, the example of CSR_TIME is incorrect. What is needed is =
a
> > > > > > CSR_XXX (a reference clock that does not count during WFI).
> > > > > >
> > > > > > Second, you mentioned that each vendor can customize their own
> > > > > > implementations. But should all vendors' CSR_XXX/YYY/... be add=
ed to
> > > > > > drivers/acpi/riscv/cppc.c? Shouldn=E2=80=99t drivers/acpi/riscv=
/cppc.c fall
> > > > > > under the scope defined by the RISC-V architecture?
> > > > > >
> > > > > No. One can implement similar to csr_read_num() in opensbi. We di=
dn't
> > > > > add it since there was no HW implementing such thing. What I am
> > > > > saying is we have FFH encoding to support such case.
> > > > >
> > > > > > >
> > > > > > > > It would be best to promote a specification to support CSR_=
XXX, just
> > > > > > > > like what has been done for x86 and arm64. What do you thin=
k?
> > > > > > > >
> > > > > > > Wouldn't above work? For a standard extension, you may have t=
o provide
> > > > > > > more data with actual HW.
> > > > > >
> > > > > > This won=E2=80=99t work. May I ask how the current upstream cod=
e can calculate
> > > > > > the actual CPU frequency using CSR_TIME without trapping to SBI=
?
> > > > > > This is a theoretical logical issue. Why is data needed here?
> > > > > >
> > > > > As I mentioned above, one can implement a generic CSR read withou=
t
> > > > > trapping to SBI.
> > > > >
> > > > > > Could you take a look at the "AMU events and event numbers" cha=
pter in
> > > > > > the ARM64 manual?
> > > > > >
> > > > > As-per ACPI spec reference performance counter is not affected by=
 CPU
> > > > > state. The RISC-V FFH encoding is sufficiently generic to support=
 this
> > > > > requirement, even if the standard CSR_TIME cannot be used. In suc=
h
> > > > > cases, an alternative CSR can be encodeded, accessed via an OS-le=
vel
> > > > > abstraction such as csr_read_num().
> > > >
> > > > So what you're saying is that we should submit a patch like this, r=
ight?
> > > >
> > > > diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
> > > > index 440cf9fb91aab..953c259d46c69 100644
> > > > --- a/drivers/acpi/riscv/cppc.c
> > > > +++ b/drivers/acpi/riscv/cppc.c
> > > > @@ -66,16 +66,8 @@ static void cppc_ffh_csr_read(void *read_data)
> > > >  {
> > > >         struct sbi_cppc_data *data =3D (struct sbi_cppc_data *)read=
_data;
> > > >
> > > > -       switch (data->reg) {
> > > > -       /* Support only TIME CSR for now */
> > > > -       case CSR_TIME:
> > > > -               data->ret.value =3D csr_read(CSR_TIME);
> > > > -               data->ret.error =3D 0;
> > > > -               break;
> > > > -       default:
> > > > -               data->ret.error =3D -EINVAL;
> > > > -               break;
> > > > -       }
> > > > +       data->ret.value =3D csr_read_num(data->reg);
> > > > +       data->ret.error =3D 0;
> > > >  }
> > > >
> > > > If that's the case, the robustness of the code cannot be guaranteed=
,
> > > > because the range of CSRs from different vendors is unknown.
> > >
> > > ACPI FFH is allows mapping to any CSR.
> >
> > Yes, FFH can map any CSR, and this is not the point of contention.
> >
> > If that's the case, the CSR_TIME used in the current kernel code is
> > inappropriate. Some vendors may design a counter that does not count
> > during WFI, making CSR_TIME irrelevant. Even if counting continues
> > during WFI, are you planning to have one counter operate in S-mode
> > while the other traps to M-mode?
> >
> > In that case, the code would need to be modified as proposed above. Do
> > you agree?
>
> I disagree.
>
> Like Sunil already explained, if an implementation has reference counter
> which does not count during WFI state then for such implementation the
> delivered performance counter should also not increment during WFI
> to maintain the relative delta of increments. This means if an implementa=
tion
> uses TIME CSR as reference counter then for such implementation
> the delivered performance counter should increment accordingly. Ultimatel=
y,
> what matters is OS being able to correctly compute the performance level
> using reference and delivered performance counters.


For calculating the actual CPU frequency, both implementations are
acceptable where either both counters continue counting during WFI or
both stop counting.
In the current code, how do you read the other counter?
Shouldn't it be modified like this to support it? This way, all
counters can be read directly in S-mode without trapping to M-mode:
+       data->ret.value =3D csr_read_num(data->reg);
+       data->ret.error =3D 0;


>
> >
> > Without a specification defining these two counters, the above code
> > would lack robustness.
>
> Can you elaborate the "robustness" part ?
> Do you have data to back your claims ?

Because there is no specification defining address access rules for
data->reg across different vendors' implementations, you cannot write
a validation logic like this:
if (data->reg < CSR_CYCLE || data->reg > CSR_HPMCOUNTER31H) {
    ...
    return -EINVAL;
}
Reading data->reg directly lacks robustness, because data->reg may
potentially hold an invalid value.


>
> Regards,
> Anup

Thanks,
Yunhui

