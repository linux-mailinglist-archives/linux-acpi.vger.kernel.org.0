Return-Path: <linux-acpi+bounces-18058-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83512BF8493
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 21:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472EA19C368B
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 19:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD4926F2AB;
	Tue, 21 Oct 2025 19:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frBFQiUZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B90D21FF35
	for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 19:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761075763; cv=none; b=A9S5ks96Z04bis+39YndwwlI2WdTkcOEGT93BLdbq578YCse8rNcyxDzrCBD8+Epaqv3TlnSk55H6X6rmRrPHeoajkkLSPSCKM+nfWJhyzoxU/nryBJB8gVIaccKRfCv1dAMHj7tmJ460CeahyQkoh6YiSw/fps4TXGjUfmVtck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761075763; c=relaxed/simple;
	bh=S1jyD/WBZntauXdBXy1HgYF7lZZ27heHxJXbaqCcUe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e0uecgKAMpEt8TzWJznnvRBuWmd4NJvd1tFOcNvTNOCw/22EQRhEz9PMTlo0stUiEqPmHlIDdQIeVTjRCNQBJZCcd+odaY6vtAIkj5EmlDn2+dSTEndApzILPnbj/IMFbyMNhFnT4PwnkbWsIsbqgjWlaiW1X8XcinfiZGZekuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frBFQiUZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EAC1C113D0
	for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 19:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761075763;
	bh=S1jyD/WBZntauXdBXy1HgYF7lZZ27heHxJXbaqCcUe4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=frBFQiUZWO4C/NQ550H8WVRHcfC5wdraqI1e6OrJHdlywsOK5mxpZvr0ws+ECIgQ2
	 /c957msMTHI8agWo/5MqOGxAYGFxGD0p1wEhONuvMln/NQ3LiFicOgj7+Ws3DMGUWS
	 N1/hk1jXqpzvv5K0VHGhTY6fQlGfwi95iEMTn6/1uxScQKiy4LsJIlAWKshbfZq3Eq
	 y+VPIhxfPpG4K43j8TtAJpG7cNJwSl3kddunbK3WZn80TSBY71zzW5FUPPaddOuyym
	 q+3RvNgs5SeYrFe4/RMBjb0GLG2IDYGuIUHrh1l1S6jVxf2qJgL5qARFUJsC27rU34
	 RXNg1Hwu93Dpw==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4439f1cb764so3070740b6e.3
        for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 12:42:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWBeQ8S9I+JqGzu0ePyGpso0uIorivyFO+Jz2N0BaBRuyzeUWWGpFt4mecdOXq7IJtsucl2T1g9IQ2m@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4OUI/RIIsIMoQwwq2ultO7/1MBNaUGAGeaqoAHqTCAFB+LeSS
	o3A1GpUiGcvH5zPPJaA363h13unYfz36PveUwDKX/pcIXXHQslSRjjt1RrheDrqwJkdX6u0htgX
	gR0/L+sg1zyhQLQaUpsOT5BrJ3zG8RII=
X-Google-Smtp-Source: AGHT+IHozIIKPYpq1SpFZpCeNm2HB6U4jf9vpelRNteF6YFFmlNvUOuJR+fbO/rzL6Wvkjd8jI7rjc24upq8kuSJZgs=
X-Received: by 2002:a05:6808:6901:b0:443:9f95:44f6 with SMTP id
 5614622812f47-443a31c09f5mr8745627b6e.64.1761075762600; Tue, 21 Oct 2025
 12:42:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929093754.3998136-1-lihuisong@huawei.com> <20250929093754.3998136-6-lihuisong@huawei.com>
In-Reply-To: <20250929093754.3998136-6-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 21 Oct 2025 21:42:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iLt7rnXBaTBv=-ztKro39h1hECQS_Ov9Cn1eBcfhXDaQ@mail.gmail.com>
X-Gm-Features: AS18NWB_LKKMQPtnBLFUN9NQtvUlaQPOoxPTkb-m4-HoW2qNikB7XtcOZ14hqhQ
Message-ID: <CAJZ5v0iLt7rnXBaTBv=-ztKro39h1hECQS_Ov9Cn1eBcfhXDaQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/9] ACPI: processor: idle: Add the verification of
 processor FFH LPI state
To: Huisong Li <lihuisong@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 11:38=E2=80=AFAM Huisong Li <lihuisong@huawei.com> =
wrote:
>
> Both ARM64 and RISCV architecture would validate Entry Method of LPI
> state and SBI HSM or PSCI cpu suspend. Driver should return failure
> if FFH of LPI state are not ok.

First of all, I cannot parse this changelog, so I don't know the
motivation for the change.

Second, if _LPI is ever used on x86, the
acpi_processor_ffh_lpi_probe() in acpi_processor_get_power_info() will
get in the way.

Why does the evaluation in acpi_processor_setup_cpuidle_dev() not work?

> Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low Power Id=
le(LPI) states")
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/acpi/processor_idle.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index 5684925338b3..b0d6b51ee363 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1264,7 +1264,7 @@ static int acpi_processor_setup_cpuidle_dev(struct =
acpi_processor *pr,
>
>         dev->cpu =3D pr->id;
>         if (pr->flags.has_lpi)
> -               return acpi_processor_ffh_lpi_probe(pr->id);
> +               return 0;
>
>         return acpi_processor_setup_cpuidle_cx(pr, dev);
>  }
> @@ -1275,7 +1275,13 @@ static int acpi_processor_get_power_info(struct ac=
pi_processor *pr)
>
>         ret =3D acpi_processor_get_lpi_info(pr);
>         if (ret)
> -               ret =3D acpi_processor_get_cstate_info(pr);
> +               return acpi_processor_get_cstate_info(pr);
> +
> +       if (pr->flags.has_lpi) {
> +               ret =3D acpi_processor_ffh_lpi_probe(pr->id);
> +               if (ret)
> +                       pr_err("Processor FFH LPI state is invalid.\n");
> +       }
>
>         return ret;
>  }
> --
> 2.33.0
>

