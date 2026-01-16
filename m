Return-Path: <linux-acpi+bounces-20400-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E2ED31031
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jan 2026 13:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D661303E668
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jan 2026 12:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D823017C21C;
	Fri, 16 Jan 2026 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHWdDACb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D22273F9
	for <linux-acpi@vger.kernel.org>; Fri, 16 Jan 2026 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768566146; cv=none; b=ift1aRGsryDwZUuYd+u4QGvQkxXPLjdARa4AH5R8eVu9p6XX+q+dU3mROu3g2YWlhpDqPZfp2u6770W/8h/GhKTITpzTJvoA5x6LnFmQFjCdY+kXRFOQh/jFYJhro7BJUBTQY6PxknS6zHXn5uucYB2dqcLxuhDXgzmrUvKxM2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768566146; c=relaxed/simple;
	bh=IPMtitYygdzvGdrw8mv6obGrW61MH2SzucPtLD1KQp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=riEVgbzsvJGkz4KC1ZDD1YmcOQ95toBHdqYiY3eCPV/fexeAUaXF5K5z7ojja+vzMbzSQoyH3R2SDSqT0n5KAYNDaqYSYMDxKUzhmZbZfys4zPs4vnYefbRsTOSVyNaEKwxo0TbIIcL1CDn1GkjNNJvOIoptuXbGBEPOd+D9QDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHWdDACb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3F1C2BC86
	for <linux-acpi@vger.kernel.org>; Fri, 16 Jan 2026 12:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768566146;
	bh=IPMtitYygdzvGdrw8mv6obGrW61MH2SzucPtLD1KQp0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oHWdDACbT20q4oEzanMdpARJQ9GM6IvK60BY18yQ4O2O3ATmiBkJAZ2niOyLy6uq5
	 5BVOM07NM08iZ7WD+5YknANYT6R24xmWRnxXI8PacVLNVi0FVuW32U59uNdW6ow2NJ
	 fDF22Mqh0jvN8Il60CvPCNCIJa122Zzq4wjq0JJ0O2worza58l/fmBze3sIapD1oWH
	 2w/mbYCJQK+p5fOkJcq+xCiVQ5wQ4z3nwzz8qPT3YNwyvFAwG4sfHHnCvngM6mB2qG
	 l25XnybgFEM8hqRSMXknk9PjVqO+Jl2ubTw115RSWM/UT3tizHJcuO8y/QxcLzRkbw
	 x2Mwk7kVRMNuw==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4042cd2a336so1265868fac.0
        for <linux-acpi@vger.kernel.org>; Fri, 16 Jan 2026 04:22:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXqBzwR0R2G39YegT6xzCOXw8H/x9g09VvXbzRSL4L2Y3s4ewm8M6bG8OMioUwx0iGaueDOzZY2UVVW@vger.kernel.org
X-Gm-Message-State: AOJu0YzOIJwHKDJbAcfwK7y6jcIqu/7+avRQc7J9dhfmRFpalcbANbCw
	gaIKjHOZ00rOufLewhhM+tzyYD6INMVXXgUzrFQBg8nNTIeiFul6ffT5jGDgjpUx+HHNjpALRV5
	HPs24m/M4dMSaOocZzjTkEJmTI+WOQA0=
X-Received: by 2002:a05:6820:2002:b0:65d:1bf8:bb74 with SMTP id
 006d021491bc7-661179f713emr1310124eaf.61.1768566145440; Fri, 16 Jan 2026
 04:22:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125065210.3670266-1-lihuisong@huawei.com>
 <20251125065210.3670266-2-lihuisong@huawei.com> <CAJZ5v0j9Mp5AqQwpakVLWDmK10cjOOiKtetfCr2OSSukekdPhQ@mail.gmail.com>
 <2b1a456f-b9e3-4722-84ba-ba4fdd4b2ece@huawei.com> <CAJZ5v0hfwWCSOdyhqn_ZHGnHrbZ1YcXk8t5o8=cGXDbc1WfnEw@mail.gmail.com>
 <ededfb4c-4ade-45cc-ae09-5b6589dc339c@huawei.com>
In-Reply-To: <ededfb4c-4ade-45cc-ae09-5b6589dc339c@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 16 Jan 2026 13:22:13 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gq=Cw49fEozs+9VT=UtgmzHgBCRgW38w956cEzb-1vow@mail.gmail.com>
X-Gm-Features: AZwV_QifclsryOKH9aO_g_lgJ6JPpOxYSlNUeNsBOLyxdUVf76pci6ALMqwY5Ck
Message-ID: <CAJZ5v0gq=Cw49fEozs+9VT=UtgmzHgBCRgW38w956cEzb-1vow@mail.gmail.com>
Subject: Re: [PATCH 1/3] ACPI: processor: idle: Relocate and verify acpi_processor_ffh_lpi_probe
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 7:38=E2=80=AFAM lihuisong (C) <lihuisong@huawei.com=
> wrote:
>
>
> On 1/15/2026 9:06 PM, Rafael J. Wysocki wrote:
> > On Thu, Jan 15, 2026 at 1:09=E2=80=AFPM lihuisong (C) <lihuisong@huawei=
.com> wrote:
> >> Hi Rafael,
> >>
> >> On 1/15/2026 1:27 AM, Rafael J. Wysocki wrote:
> >>> On Tue, Nov 25, 2025 at 7:52=E2=80=AFAM Huisong Li <lihuisong@huawei.=
com> wrote:
> >>>> The platform used LPI need check if the LPI support and the entry
> >>>> method is valid by the acpi_processor_ffh_lpi_probe(). But the retur=
n
> >>>> of acpi_processor_ffh_lpi_probe() in acpi_processor_setup_cpuidle_de=
v()
> >>>> isn't verified by any caller.
> >>>>
> >>>> What's more, acpi_processor_get_power_info() is a more logical place=
 for
> >>>> verifying the validity of FFH LPI than acpi_processor_setup_cpuidle_=
dev().
> >>>> So move acpi_processor_ffh_lpi_probe() from the latter to the former=
 and
> >>>> verify its return.
> >>>>
> >>>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> >>>> ---
> >>>>    drivers/acpi/processor_idle.c | 10 ++++++++--
> >>>>    1 file changed, 8 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_=
idle.c
> >>>> index 5f86297c8b23..cdf86874a87a 100644
> >>>> --- a/drivers/acpi/processor_idle.c
> >>>> +++ b/drivers/acpi/processor_idle.c
> >>>> @@ -1252,7 +1252,7 @@ static int acpi_processor_setup_cpuidle_dev(st=
ruct acpi_processor *pr,
> >>>>
> >>>>           dev->cpu =3D pr->id;
> >>>>           if (pr->flags.has_lpi)
> >>>> -               return acpi_processor_ffh_lpi_probe(pr->id);
> >>>> +               return 0;
> >>>>
> >>>>           acpi_processor_setup_cpuidle_cx(pr, dev);
> >>>>           return 0;
> >>>> @@ -1264,7 +1264,13 @@ static int acpi_processor_get_power_info(stru=
ct acpi_processor *pr)
> >>>>
> >>>>           ret =3D acpi_processor_get_lpi_info(pr);
> >>>>           if (ret)
> >>>> -               ret =3D acpi_processor_get_cstate_info(pr);
> >>>> +               return acpi_processor_get_cstate_info(pr);
> >>>> +
> >>>> +       if (pr->flags.has_lpi) {
> >>>> +               ret =3D acpi_processor_ffh_lpi_probe(pr->id);
> >>>> +               if (ret)
> >>>> +                       pr_err("Processor FFH LPI state is invalid.\=
n");
> >>>> +       }
> >>>>
> >>>>           return ret;
> >>>>    }
> >>>> --
> >>> Please reorder this behind the next patch in the series.
> >> Patch 2/3 depends on this patch.
> >> So I don't know how to reorder this patch.
> > I should have been more precise, sorry.
> >
> > Please first convert acpi_processor_setup_cpuidle_dev() to a void
> > function and then make the changes from this patch on top of that.
> The acpi_processor_ffh_lpi_probe may return an error.
> And acpi_processor_setup_cpuidle_dev can pass the error code to its
> caller(Although the caller ignored it currently).

If all of its callers ignore its return value, it can and arguably
should be a void function.

> It may be inapproprate to convert acpi_processor_setup_cpuidle_dev() to
> a void function directly if we doesn't move acpi_processor_ffh_lpi_probe
> out first.
> So I first relocate the position of acpi_processor_ffh_lpi_probe. Then
> changing it to a void function would be more logical.
>
> Or we need to drop the return value of acpi_processor_ffh_lpi_probe and
> convert acpi_processor_setup_cpuidle_dev to a void function, like:
> -->
>
> -static int acpi_processor_setup_cpuidle_dev(struct acpi_processor *pr,
> -                                           struct cpuidle_device *dev)
> +static void acpi_processor_setup_cpuidle_dev(struct acpi_processor *pr,
> +                                            struct cpuidle_device *dev)
>   {
>         if (!pr->flags.power_setup_done || !pr->flags.power || !dev)
> -               return -EINVAL;
> +               return;
>
>         dev->cpu =3D pr->id;
>         if (pr->flags.has_lpi) {
> -               return acpi_processor_ffh_lpi_probe();
> +               acpi_processor_ffh_lpi_probe();
> +               return;
>          }
>
>         acpi_processor_setup_cpuidle_cx(pr, dev);
> -       return 0;
>   }
>
> What do you think now?

Well, please see above.

