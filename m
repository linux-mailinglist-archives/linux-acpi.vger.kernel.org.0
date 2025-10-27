Return-Path: <linux-acpi+bounces-18242-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81751C0D8A9
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Oct 2025 13:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8094E1899EFE
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Oct 2025 12:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F6F30F95C;
	Mon, 27 Oct 2025 12:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZUOBFur"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8A130E837
	for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2025 12:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568129; cv=none; b=t3JyNra313/Lh9+VZbtKQ+mdBEeYZxN8tNIQ14A0KUi+QT07oSmYPe1h+axQu/XIiNzpnm8WCq1x1nQ+H9WNzZoCTLk5QD8GfZpmeS46HtZp3UxTex3fHW2nIY+94pZV6LAtDCe2sx6h67pO2HCTtBMnkqP3r4js12IP0EyWyv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568129; c=relaxed/simple;
	bh=gnzJV9tUqdqsLt2sygNxDFtUZ2/mTmyfYHonfLhYNK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XtaJMfekvDaYXs+MwCE9zx12JC7QEYFHDP4IZryGkJ/1wQjDpBovtptMVZ1wrpYbJNgC125AxAMgsnaU9mHTEWEESs3NUmo7JI5Mz31fc80swADOk+gBw+btl0F6pOwzhQUf6YftkY+Zf2Q17I1SkE8vOHHThm8uJ5V1kkZkibk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZUOBFur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A73C116B1
	for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2025 12:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761568129;
	bh=gnzJV9tUqdqsLt2sygNxDFtUZ2/mTmyfYHonfLhYNK4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jZUOBFur7yuj5/qzpiHvWpRdRcexW9JEEDZVUI4AivB/17HbMlAUG+a35N8kOpmif
	 2sGuG+mUbmM7AOQ3CWIdgzXFWIar340ie8xZrrho3h7a9z64JV+LYM4Ll08BolqGrp
	 6ywsNfafactg1ZXOHWVKhII15SFJwasb/P8R4dl7W4eKSugWixDp+flB00thJo/gGd
	 x1UAtE4/ia7VFifUEX1oMQuF8hGngcZ+UizfcK5wllE9D7f8+pBvPuyusZ/jVnXETS
	 MKFOjTX2WHJizMynktAdE8XATLv5iTYR8sYmF+bbi4dI9iGg2nASrLzA6a0raO///d
	 NokvdBygaGPWQ==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-654ed784e42so1227519eaf.0
        for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2025 05:28:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0uUNG5zafKmoNlDbmY0LTIpbspvAHCOWpph0wF6VMY0VJB6kRHJCQirUSHE6SjU1rJvTpYYLvP2Vh@vger.kernel.org
X-Gm-Message-State: AOJu0YyCBI6/CjZ/B8yRf6qASaZA/mDUG5oZaeAcvo+TEMVpdM8EmXlj
	dBRJ39yolO6wwTpeSsTmqNCrT1VPhbnqv8bIr3uk5m3rsKxXgkBE3D5tgmRxJ4N9yDZ8dOh6SPu
	Hd0201K6wZtjGIUbDXtynHCIAVn5JJDs=
X-Google-Smtp-Source: AGHT+IFnXbWgzm/xMMOANECiJWZcaZbyfE4DVv9CdW58D7GC0tUBQ2PZqPaA5FnSibwxE4AgHdEdR/+l9lHrRXohx8s=
X-Received: by 2002:a05:6871:1cf:b0:3c8:f1d8:223 with SMTP id
 586e51a60fabf-3c98cfa52b3mr16290708fac.22.1761568128358; Mon, 27 Oct 2025
 05:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929093754.3998136-1-lihuisong@huawei.com>
 <20250929093754.3998136-6-lihuisong@huawei.com> <CAJZ5v0iLt7rnXBaTBv=-ztKro39h1hECQS_Ov9Cn1eBcfhXDaQ@mail.gmail.com>
 <92b1b431-9855-43fb-8bb3-801649064438@huawei.com> <CAJZ5v0g0PgicTEAb3gAeF2D3ZqONNt+6odt2SfGE7XtY3zoPyg@mail.gmail.com>
 <ab814879-37d6-49dc-8a38-6b94cabf9327@huawei.com> <CAJZ5v0hHO_vuQ71sQ2=vmjEMNr3jYh6Wx_nk55gQVdGgWFDHKQ@mail.gmail.com>
 <37fb4e84-d404-449e-986a-e5ccb327bd78@huawei.com>
In-Reply-To: <37fb4e84-d404-449e-986a-e5ccb327bd78@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 27 Oct 2025 13:28:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j9i1W3JmDQP+-tTqu1dnE1i1XeZUk5=JMKRN_e++iJ7w@mail.gmail.com>
X-Gm-Features: AWmQ_bm4t1og8AlJXsYfxUgjKD_89uPjUI-o_4y9fP3PCfFpRtDb4TTIs2ope4k
Message-ID: <CAJZ5v0j9i1W3JmDQP+-tTqu1dnE1i1XeZUk5=JMKRN_e++iJ7w@mail.gmail.com>
Subject: Re: [PATCH v1 5/9] ACPI: processor: idle: Add the verification of
 processor FFH LPI state
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 2:43=E2=80=AFAM lihuisong (C) <lihuisong@huawei.com=
> wrote:
>
>
> =E5=9C=A8 2025/10/26 20:40, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > On Fri, Oct 24, 2025 at 11:40=E2=80=AFAM lihuisong (C) <lihuisong@huawe=
i.com> wrote:
> >>
> >> =E5=9C=A8 2025/10/23 18:35, Rafael J. Wysocki =E5=86=99=E9=81=93:
> >>> On Thu, Oct 23, 2025 at 12:17=E2=80=AFPM lihuisong (C) <lihuisong@hua=
wei.com> wrote:
> >>>> =E5=9C=A8 2025/10/22 3:42, Rafael J. Wysocki =E5=86=99=E9=81=93:
> >>>>> On Mon, Sep 29, 2025 at 11:38=E2=80=AFAM Huisong Li <lihuisong@huaw=
ei.com> wrote:
> >>>>>> Both ARM64 and RISCV architecture would validate Entry Method of L=
PI
> >>>>>> state and SBI HSM or PSCI cpu suspend. Driver should return failur=
e
> >>>>>> if FFH of LPI state are not ok.
> >>>>> First of all, I cannot parse this changelog, so I don't know the
> >>>>> motivation for the change.
> >>>> Sorry for your confusion.
> >>>>> Second, if _LPI is ever used on x86, the
> >>>>> acpi_processor_ffh_lpi_probe() in acpi_processor_get_power_info() w=
ill
> >>>>> get in the way.
> >>>> AFAICS, it's also ok if X86 platform use LPI.
> >>> No, because it returns an error by default as it stands today.
> >>>
> >>>>> Why does the evaluation in acpi_processor_setup_cpuidle_dev() not w=
ork?
> >>>> The acpi_processor_ffh_lpi_probe does verify the validity of LPI for=
 ARM
> >>>> and RISCV.
> >>>> But the caller of the acpi_processor_setup_cpuidle_dev()don't verify=
 the
> >>>> return value.
> >>>> In addition, from the name of acpi_processor_setup_cpuidle_dev(), it=
s
> >>>> main purpose is to setup cpudile device rather than to verify LPI.
> >>> That's fair enough.
> >>>
> >>> Also, the list of idle states belongs to the cpuidle driver, not to a
> >>> cpuidle device.
> >>>
> >>>> So I move it to a more prominent position and redefine the
> >>>> acpi_processor_setup_cpuidle_dev to void in patch 9/9.
> >>>>>> Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low P=
ower Idle(LPI) states")
> >>>>>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> >>>>>> ---
> >>>>>>     drivers/acpi/processor_idle.c | 10 ++++++++--
> >>>>>>     1 file changed, 8 insertions(+), 2 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processo=
r_idle.c
> >>>>>> index 5684925338b3..b0d6b51ee363 100644
> >>>>>> --- a/drivers/acpi/processor_idle.c
> >>>>>> +++ b/drivers/acpi/processor_idle.c
> >>>>>> @@ -1264,7 +1264,7 @@ static int acpi_processor_setup_cpuidle_dev(=
struct acpi_processor *pr,
> >>>>>>
> >>>>>>            dev->cpu =3D pr->id;
> >>>>>>            if (pr->flags.has_lpi)
> >>>>>> -               return acpi_processor_ffh_lpi_probe(pr->id);
> >>>>>> +               return 0;
> >>>>>>
> >>>>>>            return acpi_processor_setup_cpuidle_cx(pr, dev);
> >>>>>>     }
> >>>>>> @@ -1275,7 +1275,13 @@ static int acpi_processor_get_power_info(st=
ruct acpi_processor *pr)
> >>>>>>
> >>>>>>            ret =3D acpi_processor_get_lpi_info(pr);
> >>>>>>            if (ret)
> >>> So I think it would be better to check it here, that is
> >>>
> >>> if (!ret) {
> >>>          ret =3D acpi_processor_ffh_lpi_probe(pr->id));
> >>>          if (!ret)
> >>>                  return 0;
> >>>
> >>>          pr_info("CPU%d: FFH LPI state is invalid\n", pr->id);
> >>>          pr->flags.has_lpi =3D 0;
> >>> }
> >>>
> >>> return acpi_processor_get_cstate_info(pr);
> >>>
> >>> And the default acpi_processor_ffh_lpi_probe() needs to be changed to=
 return 0.
> >> Sorry, I don't understand why pr->flags.has_lpi is true if
> >> acpi_processor_ffh_lpi_probe() return failure.
> > It is set by acpi_processor_get_lpi_info() on success and
> > acpi_processor_ffh_lpi_probe() does not update it.
> The acpi_processor_get_lpi_info() will return failure on X86 platform
> because this function first call acpi_processor_ffh_lpi_probe().
> And acpi_processor_ffh_lpi_probe return EOPNOTSUPP because X86 platform
> doesn't implement it.
> So I think pr->flags.has_lpi is false on X86 plaform.

On x86 it is 0, but what if acpi_processor_ffh_lpi_probe() fails on arm64, =
say?

> >
> >> In addition, X86 platform doesn't define acpi_processor_ffh_lpi_probe(=
).
> >> this function will return EOPNOTSUPP.
> > Which is exactly why it is a problem.  x86 has no reason to implement
> > it because FFH always works there.
> Sorry, I still don't understand why X86 has no reason to implement it.
> I simply think that X86 doesn't need it.
> AFAICS, the platform doesn't need to get LPI info if this platform
> doesn't implement acpi_processor_ffh_lpi_probe().

Well, that's what is implemented in the current code, but it will need
to be changed if x86 is ever added and I'd rather avoid cleanups
making it harder to change.

