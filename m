Return-Path: <linux-acpi+bounces-18663-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F421C41263
	for <lists+linux-acpi@lfdr.de>; Fri, 07 Nov 2025 18:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C3364E74D7
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Nov 2025 17:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0429F331A6E;
	Fri,  7 Nov 2025 17:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgtM8UQ6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37F0207A22
	for <linux-acpi@vger.kernel.org>; Fri,  7 Nov 2025 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762537787; cv=none; b=JV8Nq8+vOqlllhkd8SFrqKk12pxdrICPMLLWM78jbNjtjoT23af0LC8lm/M5r/SkP+bX976GuM1lnTT+pMfZSg80Jwu03weB3ZQ6roCi4ypMjcAsDQvVURI1CuwqNAa1HewOvf53N1pdfdYzxL3Z+ZZRTVkr4j7+Hmj7sOSF5gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762537787; c=relaxed/simple;
	bh=4um+QvY1U7FK3/P4egf0S22SHqYdSsyehiBykKOwaPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HzrXon111O/5g2mD3aZa0UD3HVVPgqSIYFx1iRldysbjB0hfsjRjg6nRPwaWoNGvl/pBM40s0s/yut3qnLEQWCW45JDnXPzF1r1XIQU52zSSlEAjNy8U+X+W9bKi1entaGlRVLY4wSO2gTgkqncyqBryUlL1u8pgsEAIIYPlDwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgtM8UQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD09C2BCB1
	for <linux-acpi@vger.kernel.org>; Fri,  7 Nov 2025 17:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762537787;
	bh=4um+QvY1U7FK3/P4egf0S22SHqYdSsyehiBykKOwaPk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fgtM8UQ6tuFap96NbjxmTxVx26BWnBfMP4tHZas82IdikHK+TfO/d8pNNuG82YZaa
	 0A7p28XRiJnmtgvRCTG4W4Q/01RhvYdwV1gfAmpmKYj+Mw1aGEDPlX4S20YupaY0IB
	 NgZruAYHrajuMeqI4hx4eHxBCAZzzPk7hR0qjNSnU0IK5xzsQeRIEd+eqChFVxP7au
	 kz9RnTIvjIGCrRn71fLfm6OSueiUwP8TIsqflg9AZMwscLhI9MfWhYJb5AtFsDqsLO
	 My2cv5NVBVL956I4PtiFKQ/r6QAvjEscpep7zgvqaPQK9PTpnYHpFXfIS8mqxvnSJ9
	 GS6sKOxfbZ15g==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-656c665749dso203053eaf.0
        for <linux-acpi@vger.kernel.org>; Fri, 07 Nov 2025 09:49:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW6y9JCbQzDndE6V0rVfBerJP3dCakIgEILzUNMFTVDq7MqF1ZqDpM5fg7rjhTQUMtlM0eIW2+VX0CO@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh7PE/23mrKXciQKhs84riqPT8SWzJntI6CM4ZYNiDLUh97hBk
	F+UAuzTU9gMMrNTx0HpeHo8L1jAB4I++0G9S+LiFjSTXDLPSVtbFHLXpICdv8fTiE9A/1w/qHNR
	PviOxUS9/wfVzcRqxSUFWTp43Em4LAis=
X-Google-Smtp-Source: AGHT+IER87GrchrdaUz6axnPt/FyUNlukE+Gp8sAmwWRp2wquYizKIjc1M3C+vdg7NcaEPeF1EmIidtalAExy2+3dkg=
X-Received: by 2002:a05:6820:2188:b0:654:f20e:2d0c with SMTP id
 006d021491bc7-656d877e349mr196570eaf.1.1762537786571; Fri, 07 Nov 2025
 09:49:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105093647.3557248-1-lihuisong@huawei.com>
In-Reply-To: <20251105093647.3557248-1-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Nov 2025 18:49:35 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gs4xVKv65NW8A7XPgAqwoM6B-izAFrkySjmgeoNqDirg@mail.gmail.com>
X-Gm-Features: AWmQ_bldKVVUGi9avp8T4YJW3_2ZWJtKiIOiC9NPyBTLQPnjThz25EBo5eVHVE4
Message-ID: <CAJZ5v0gs4xVKv65NW8A7XPgAqwoM6B-izAFrkySjmgeoNqDirg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor: idle: Remove useless codes about the
 verification of cstate count
To: Huisong Li <lihuisong@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 10:36=E2=80=AFAM Huisong Li <lihuisong@huawei.com> w=
rote:
>
> The acpi_processor_setup_cstates and acpi_processor_setup_cpuidle_cx will
> be called after successfully obtaining the power information. These setup
> functions have their own main role, but also verify the validity of cstat=
e
> count.
>
> Actually, the acpi_processor_get_power_info_cst will return failure if th=
e
> cstate count is zero and acpi_processor_get_power_info will return failur=
e.
>
> So the verification of cstate count in these functions are useless.
>
> No intentional functional impact.
>
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/acpi/processor_idle.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index 341825e8ac63..22909fccf0b1 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -732,8 +732,8 @@ static int __cpuidle acpi_idle_enter_s2idle(struct cp=
uidle_device *dev,
>         return 0;
>  }
>
> -static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
> -                                          struct cpuidle_device *dev)
> +static void acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
> +                                           struct cpuidle_device *dev)
>  {
>         int i, count =3D ACPI_IDLE_STATE_START;
>         struct acpi_processor_cx *cx;
> @@ -753,14 +753,9 @@ static int acpi_processor_setup_cpuidle_cx(struct ac=
pi_processor *pr,
>                 if (count =3D=3D CPUIDLE_STATE_MAX)
>                         break;
>         }
> -
> -       if (!count)
> -               return -EINVAL;
> -
> -       return 0;
>  }
>
> -static int acpi_processor_setup_cstates(struct acpi_processor *pr)
> +static void acpi_processor_setup_cstates(struct acpi_processor *pr)
>  {
>         int i, count;
>         struct acpi_processor_cx *cx;
> @@ -822,11 +817,6 @@ static int acpi_processor_setup_cstates(struct acpi_=
processor *pr)
>         }
>
>         drv->state_count =3D count;
> -
> -       if (!count)
> -               return -EINVAL;
> -
> -       return 0;
>  }
>
>  static inline void acpi_processor_cstate_first_run_checks(void)
> @@ -1241,7 +1231,8 @@ static int acpi_processor_setup_cpuidle_states(stru=
ct acpi_processor *pr)
>         if (pr->flags.has_lpi)
>                 return acpi_processor_setup_lpi_states(pr);
>
> -       return acpi_processor_setup_cstates(pr);
> +       acpi_processor_setup_cstates(pr);
> +       return 0;
>  }
>
>  /**
> @@ -1261,7 +1252,8 @@ static int acpi_processor_setup_cpuidle_dev(struct =
acpi_processor *pr,
>         if (pr->flags.has_lpi)
>                 return acpi_processor_ffh_lpi_probe(pr->id);
>
> -       return acpi_processor_setup_cpuidle_cx(pr, dev);
> +       acpi_processor_setup_cpuidle_cx(pr, dev);
> +       return 0;
>  }
>
>  static int acpi_processor_get_power_info(struct acpi_processor *pr)
> --

Applied as 6.19 material with rewritten subject and changelog, thanks!

