Return-Path: <linux-acpi+bounces-18283-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7700EC1518B
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Oct 2025 15:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 459314EB0C1
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Oct 2025 14:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E554335094;
	Tue, 28 Oct 2025 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6dnwsvU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5413328E5
	for <linux-acpi@vger.kernel.org>; Tue, 28 Oct 2025 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660652; cv=none; b=QrXISVtC+LKAgr1brgXlqygSjb1dhiTb4i5Jla5ZzNgK02ZKGkbLZZ76YdKoph77vqbepaXN+GnAU9GeoFAoLm4onO42BjrQZg0TtKzUfxXAaxAmuhL+nycUtWMyvTo0BGwh7N/X7p9RKjCHePgyh/jLyuUULwPU1pFt02RhqPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660652; c=relaxed/simple;
	bh=9MQdQxj70yjmNeGCIc6Di+FRAIbRgsLKF+QiN38fNXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ThzDZ7a2vBW90wZuVpWa15V7MYgDo2SabY8TOJNq2ML/5Q3ORRRqwXnW80VRNT37jnjUd3bwlmz0OXGswvkZC6AnJrPyFlNrl4Nk/Wc5Q5nawXUWO+fy5pZ5nwiAzs7o4K6ZUceYgw879kzhYC3dpuaGc9XTOc+fZkp2EAiHyOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6dnwsvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C964C116C6
	for <linux-acpi@vger.kernel.org>; Tue, 28 Oct 2025 14:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761660652;
	bh=9MQdQxj70yjmNeGCIc6Di+FRAIbRgsLKF+QiN38fNXY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G6dnwsvUgrYl1OrqkZ9wOHYFRXBUnREZvE3I4Q8DK7cBq1Rg4GC1O7T6hLgDpw0uB
	 LOeIcsJWCYs0+Ds6rJt+IA/ZYvko7PDG4uz6+BNtvuScjGYNU2WOvlu0dYpaPb1Z9E
	 jyNTQnXLrBqMWo/Pr6Q+ynv2d4OyfGAu08zuKhFTmvkmk4JoLjqnvLFKHqVeYlHWGT
	 B403m1RShc+XaN/zUuWTQFaZD4vHt8Y1H907S1PEHjuifUbVXTq+YNy2b3lD2UpCuh
	 kdYycVw0GLNngjDcjVuqHjAAqX6aE1wbx/9K43ceEhm6UDjebJHz49FdMuy7BzX5ci
	 hB27FC679dGAg==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-443ac891210so3258143b6e.1
        for <linux-acpi@vger.kernel.org>; Tue, 28 Oct 2025 07:10:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXoPB4vGQlQRs0Bq9hkkTS+26Tnpl+YeOxfJZx3Sf/lQg6/UtzEHDH5xG2JhVLWEsrfIvG2BCBH/Rhf@vger.kernel.org
X-Gm-Message-State: AOJu0YzusBKNxFXVmFZ4IqPnzrvYaAjyXb0YbeaYoCSyJs6FUwlZiZnk
	wEsDZBfZ8NJW3bPufX/jLf6MmCJq4T0MnL/q22V+sHCO82RVW0KMujPnufFFnfE3nRamCjc+nNo
	vxidd4iF7iK77iev2az6xnbPtfXDjLVc=
X-Google-Smtp-Source: AGHT+IE0knAQw6FfaushnbySWImrTzxFtRDabqyVZ1OX3SSkfmRS+Rz3Ee2OaBsxYv6Q+KSNzkK0/9j1cQNQK9cPfvg=
X-Received: by 2002:a05:6808:15a7:b0:441:8f74:f1f with SMTP id
 5614622812f47-44f6bb1e9c6mr1559391b6e.57.1761660651602; Tue, 28 Oct 2025
 07:10:51 -0700 (PDT)
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
 <37fb4e84-d404-449e-986a-e5ccb327bd78@huawei.com> <CAJZ5v0j9i1W3JmDQP+-tTqu1dnE1i1XeZUk5=JMKRN_e++iJ7w@mail.gmail.com>
 <8b1dc682-928a-4898-876c-ae6ccf59d328@huawei.com>
In-Reply-To: <8b1dc682-928a-4898-876c-ae6ccf59d328@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 28 Oct 2025 15:10:39 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hTkVzuKQu4WFOxtdfC-uXTBYkBr77UurXj_zfDbgV0vg@mail.gmail.com>
X-Gm-Features: AWmQ_blMwiClUZfXYAWhC0RqhmMfjUZfV9B0g6Ofzj4BSy4UXTWbOnLbxq5ntE4
Message-ID: <CAJZ5v0hTkVzuKQu4WFOxtdfC-uXTBYkBr77UurXj_zfDbgV0vg@mail.gmail.com>
Subject: Re: [PATCH v1 5/9] ACPI: processor: idle: Add the verification of
 processor FFH LPI state
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 1:45=E2=80=AFPM lihuisong (C) <lihuisong@huawei.com=
> wrote:
>
>
> =E5=9C=A8 2025/10/27 20:28, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > On Mon, Oct 27, 2025 at 2:43=E2=80=AFAM lihuisong (C) <lihuisong@huawei=
.com> wrote:
> >>
> >> =E5=9C=A8 2025/10/26 20:40, Rafael J. Wysocki =E5=86=99=E9=81=93:
> >>> On Fri, Oct 24, 2025 at 11:40=E2=80=AFAM lihuisong (C) <lihuisong@hua=
wei.com> wrote:
> >>>> =E5=9C=A8 2025/10/23 18:35, Rafael J. Wysocki =E5=86=99=E9=81=93:
> >>>>> On Thu, Oct 23, 2025 at 12:17=E2=80=AFPM lihuisong (C) <lihuisong@h=
uawei.com> wrote:
> >>>>>> =E5=9C=A8 2025/10/22 3:42, Rafael J. Wysocki =E5=86=99=E9=81=93:
> >>>>>>> On Mon, Sep 29, 2025 at 11:38=E2=80=AFAM Huisong Li <lihuisong@hu=
awei.com> wrote:
> >>>>>>>> Both ARM64 and RISCV architecture would validate Entry Method of=
 LPI
> >>>>>>>> state and SBI HSM or PSCI cpu suspend. Driver should return fail=
ure
> >>>>>>>> if FFH of LPI state are not ok.
> >>>>>>> First of all, I cannot parse this changelog, so I don't know the
> >>>>>>> motivation for the change.
> >>>>>> Sorry for your confusion.
> >>>>>>> Second, if _LPI is ever used on x86, the
> >>>>>>> acpi_processor_ffh_lpi_probe() in acpi_processor_get_power_info()=
 will
> >>>>>>> get in the way.
> >>>>>> AFAICS, it's also ok if X86 platform use LPI.
> >>>>> No, because it returns an error by default as it stands today.
> >>>>>
> >>>>>>> Why does the evaluation in acpi_processor_setup_cpuidle_dev() not=
 work?
> >>>>>> The acpi_processor_ffh_lpi_probe does verify the validity of LPI f=
or ARM
> >>>>>> and RISCV.
> >>>>>> But the caller of the acpi_processor_setup_cpuidle_dev()don't veri=
fy the
> >>>>>> return value.
> >>>>>> In addition, from the name of acpi_processor_setup_cpuidle_dev(), =
its
> >>>>>> main purpose is to setup cpudile device rather than to verify LPI.
> >>>>> That's fair enough.
> >>>>>
> >>>>> Also, the list of idle states belongs to the cpuidle driver, not to=
 a
> >>>>> cpuidle device.
> >>>>>
> >>>>>> So I move it to a more prominent position and redefine the
> >>>>>> acpi_processor_setup_cpuidle_dev to void in patch 9/9.
> >>>>>>>> Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low=
 Power Idle(LPI) states")
> >>>>>>>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> >>>>>>>> ---
> >>>>>>>>      drivers/acpi/processor_idle.c | 10 ++++++++--
> >>>>>>>>      1 file changed, 8 insertions(+), 2 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/proces=
sor_idle.c
> >>>>>>>> index 5684925338b3..b0d6b51ee363 100644
> >>>>>>>> --- a/drivers/acpi/processor_idle.c
> >>>>>>>> +++ b/drivers/acpi/processor_idle.c
> >>>>>>>> @@ -1264,7 +1264,7 @@ static int acpi_processor_setup_cpuidle_de=
v(struct acpi_processor *pr,
> >>>>>>>>
> >>>>>>>>             dev->cpu =3D pr->id;
> >>>>>>>>             if (pr->flags.has_lpi)
> >>>>>>>> -               return acpi_processor_ffh_lpi_probe(pr->id);
> >>>>>>>> +               return 0;
> >>>>>>>>
> >>>>>>>>             return acpi_processor_setup_cpuidle_cx(pr, dev);
> >>>>>>>>      }
> >>>>>>>> @@ -1275,7 +1275,13 @@ static int acpi_processor_get_power_info(=
struct acpi_processor *pr)
> >>>>>>>>
> >>>>>>>>             ret =3D acpi_processor_get_lpi_info(pr);
> >>>>>>>>             if (ret)
> >>>>> So I think it would be better to check it here, that is
> >>>>>
> >>>>> if (!ret) {
> >>>>>           ret =3D acpi_processor_ffh_lpi_probe(pr->id));
> >>>>>           if (!ret)
> >>>>>                   return 0;
> >>>>>
> >>>>>           pr_info("CPU%d: FFH LPI state is invalid\n", pr->id);
> >>>>>           pr->flags.has_lpi =3D 0;
> >>>>> }
> >>>>>
> >>>>> return acpi_processor_get_cstate_info(pr);
> >>>>>
> >>>>> And the default acpi_processor_ffh_lpi_probe() needs to be changed =
to return 0.
> >>>> Sorry, I don't understand why pr->flags.has_lpi is true if
> >>>> acpi_processor_ffh_lpi_probe() return failure.
> >>> It is set by acpi_processor_get_lpi_info() on success and
> >>> acpi_processor_ffh_lpi_probe() does not update it.
> >> The acpi_processor_get_lpi_info() will return failure on X86 platform
> >> because this function first call acpi_processor_ffh_lpi_probe().
> >> And acpi_processor_ffh_lpi_probe return EOPNOTSUPP because X86 platfor=
m
> >> doesn't implement it.
> >> So I think pr->flags.has_lpi is false on X86 plaform.
> > On x86 it is 0, but what if acpi_processor_ffh_lpi_probe() fails on arm=
64, say?
> Arm64 supports the acpi_processor_ffh_lpi_probe().
> So pr->flags.has_lpi is 1 on success.
> >>>> In addition, X86 platform doesn't define acpi_processor_ffh_lpi_prob=
e().
> >>>> this function will return EOPNOTSUPP.
> >>> Which is exactly why it is a problem.  x86 has no reason to implement
> >>> it because FFH always works there.
> >> Sorry, I still don't understand why X86 has no reason to implement it.
> >> I simply think that X86 doesn't need it.
> >> AFAICS, the platform doesn't need to get LPI info if this platform
> >> doesn't implement acpi_processor_ffh_lpi_probe().
>
> > Well, that's what is implemented in the current code, but it will need
> > to be changed if x86 is ever added and I'd rather avoid cleanups
> > making it harder to change.
>
> What you mean is that X86 use LPI?

In the future, x86 may want to use _LPI, that's all.

> If X86 also define acpi_processor_ffh_lpi_probe and use LPI, this patch
> is also good to it.

Well, fair enough.

