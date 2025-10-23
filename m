Return-Path: <linux-acpi+bounces-18142-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC3CC00894
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 12:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7968250207F
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 10:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE37306B01;
	Thu, 23 Oct 2025 10:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJoP3JF4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6D430CD89
	for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 10:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215724; cv=none; b=FXCcVBb+E2Sy63CMpayhLClhLopaWdHi+VgvJC1DPlIDDW415Yoh0E27nk7jOWmtI9BPr7ePI3RjEmYX4vp25llRh3KI1zP7mp+pVGWXvYBXySM4nb4z2m+Mm4hTvJfU9Hz9M7qJrbfo6eT1fSNFCWkPH6qZekCQpbiLPZkDuwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215724; c=relaxed/simple;
	bh=KxNv26c3ElS+fE9HW43tqm+IB24ijiFXrt9FnLLIpZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+O03I9T7Vz+BLIYEkNI6Qk1Cu0qk9eIvCC60pKrjFNb1K9tU7tyIkv2qTI76o3FqAC7Zxwl/Pp011FeIbnHeHhoFAKLMf+yfQkr606szymSr9XYbAHaw+/huKxG2wu4B/ox94H/Y93+7VrNnbSwzIaUYBccSExDy/r/mG6Zipw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJoP3JF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CB0C113D0
	for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 10:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761215724;
	bh=KxNv26c3ElS+fE9HW43tqm+IB24ijiFXrt9FnLLIpZA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SJoP3JF4h3Zf1+HQLbTn2og3tBT0AbixF0vFapA68f2cwwnJhwEHU66ygtNFbtJnr
	 IIOQDq/CxRiMM7gmt0iV6PfLD4mMlXBqRxAWn/WzHpKhEX/jL0+6pVMl5YuZ3Gx1bu
	 6+6rbAZ0bP8L0f53NJFwNZVrDq42uPRynu7KDiOmRpMN4k9pY1zX5eO6vpNT3V9Yj9
	 06fmvYWWMeH0UExFp9OppAgAqQvdRwogx92FBqhxJRNbUwSpZcX11J3bkHG+iRP3pc
	 H0/tEy7yB0hlRZs08d9Bv7d0bTTQR0XQwCQf5M3+L4hAq20D8uSxKm8Eq+yNa7mTFV
	 GDtnB7xT8AiDw==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c0e8367d4eso242663a34.1
        for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 03:35:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWx0chCKMYYw4pu9PXSb9fRgLbjIC4Q7CLiEIyFGOpC7B8PBSPUBi23TYLgGk6jmvwwTaYqPrITMiQy@vger.kernel.org
X-Gm-Message-State: AOJu0YwJzhq43Sv7VZzeuRAz4U15nB4+nBX5h9lY2qGysVh4MYNCbmxa
	jagBnmU/3NfkelSI+p4l3h3aTKhZJA/UF+yzw2vBxY+/u6m/QV/B6KK2eeHa+9PBwztR+ze4Ci9
	FuuNWgTtq2iPvq6PYBO6S6YCquWewp1E=
X-Google-Smtp-Source: AGHT+IGHGzbBhtCDjfjtiVBjF5gNR4L8YTOEGQA5cjswLcRfclq9EWvgPKLpoS+Zu+4iByCUL0E4qm2Om49lC0kIFfE=
X-Received: by 2002:a05:6808:319b:b0:43f:1a5f:281f with SMTP id
 5614622812f47-443a30d1eeemr9414038b6e.35.1761215722358; Thu, 23 Oct 2025
 03:35:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929093754.3998136-1-lihuisong@huawei.com>
 <20250929093754.3998136-6-lihuisong@huawei.com> <CAJZ5v0iLt7rnXBaTBv=-ztKro39h1hECQS_Ov9Cn1eBcfhXDaQ@mail.gmail.com>
 <92b1b431-9855-43fb-8bb3-801649064438@huawei.com>
In-Reply-To: <92b1b431-9855-43fb-8bb3-801649064438@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Oct 2025 12:35:11 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g0PgicTEAb3gAeF2D3ZqONNt+6odt2SfGE7XtY3zoPyg@mail.gmail.com>
X-Gm-Features: AS18NWB9TrOOkLiktj8zwiGhxZR49Uy8Pwi4OIpXMDvXmZV6Dsr-BuGckXICdEI
Message-ID: <CAJZ5v0g0PgicTEAb3gAeF2D3ZqONNt+6odt2SfGE7XtY3zoPyg@mail.gmail.com>
Subject: Re: [PATCH v1 5/9] ACPI: processor: idle: Add the verification of
 processor FFH LPI state
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 12:17=E2=80=AFPM lihuisong (C) <lihuisong@huawei.co=
m> wrote:
>
>
> =E5=9C=A8 2025/10/22 3:42, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > On Mon, Sep 29, 2025 at 11:38=E2=80=AFAM Huisong Li <lihuisong@huawei.c=
om> wrote:
> >> Both ARM64 and RISCV architecture would validate Entry Method of LPI
> >> state and SBI HSM or PSCI cpu suspend. Driver should return failure
> >> if FFH of LPI state are not ok.
> > First of all, I cannot parse this changelog, so I don't know the
> > motivation for the change.
> Sorry for your confusion.
> > Second, if _LPI is ever used on x86, the
> > acpi_processor_ffh_lpi_probe() in acpi_processor_get_power_info() will
> > get in the way.
> AFAICS, it's also ok if X86 platform use LPI.

No, because it returns an error by default as it stands today.

> >
> > Why does the evaluation in acpi_processor_setup_cpuidle_dev() not work?
> The acpi_processor_ffh_lpi_probe does verify the validity of LPI for ARM
> and RISCV.
> But the caller of the acpi_processor_setup_cpuidle_dev()don't verify the
> return value.
> In addition, from the name of acpi_processor_setup_cpuidle_dev(), its
> main purpose is to setup cpudile device rather than to verify LPI.

That's fair enough.

Also, the list of idle states belongs to the cpuidle driver, not to a
cpuidle device.

> So I move it to a more prominent position and redefine the
> acpi_processor_setup_cpuidle_dev to void in patch 9/9.
> >
> >> Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low Power=
 Idle(LPI) states")
> >> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> >> ---
> >>   drivers/acpi/processor_idle.c | 10 ++++++++--
> >>   1 file changed, 8 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_id=
le.c
> >> index 5684925338b3..b0d6b51ee363 100644
> >> --- a/drivers/acpi/processor_idle.c
> >> +++ b/drivers/acpi/processor_idle.c
> >> @@ -1264,7 +1264,7 @@ static int acpi_processor_setup_cpuidle_dev(stru=
ct acpi_processor *pr,
> >>
> >>          dev->cpu =3D pr->id;
> >>          if (pr->flags.has_lpi)
> >> -               return acpi_processor_ffh_lpi_probe(pr->id);
> >> +               return 0;
> >>
> >>          return acpi_processor_setup_cpuidle_cx(pr, dev);
> >>   }
> >> @@ -1275,7 +1275,13 @@ static int acpi_processor_get_power_info(struct=
 acpi_processor *pr)
> >>
> >>          ret =3D acpi_processor_get_lpi_info(pr);
> >>          if (ret)

So I think it would be better to check it here, that is

if (!ret) {
       ret =3D acpi_processor_ffh_lpi_probe(pr->id));
       if (!ret)
               return 0;

       pr_info("CPU%d: FFH LPI state is invalid\n", pr->id);
       pr->flags.has_lpi =3D 0;
}

return acpi_processor_get_cstate_info(pr);

And the default acpi_processor_ffh_lpi_probe() needs to be changed to retur=
n 0.

> >> -               ret =3D acpi_processor_get_cstate_info(pr);
> >> +               return acpi_processor_get_cstate_info(pr);
> >> +
> >> +       if (pr->flags.has_lpi) {
> >> +               ret =3D acpi_processor_ffh_lpi_probe(pr->id);
> >> +               if (ret)
> >> +                       pr_err("Processor FFH LPI state is invalid.\n"=
);
> >> +       }
> >>
> >>          return ret;
> >>   }
> >> --

