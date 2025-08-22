Return-Path: <linux-acpi+bounces-15984-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2802B322CB
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 21:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AFA51D636F0
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 19:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C442D0C75;
	Fri, 22 Aug 2025 19:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyn2+mIg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0048C29994B;
	Fri, 22 Aug 2025 19:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755890871; cv=none; b=O+3VM2WD35Pm1xSBn9Akc/OnCQ5QNw4aLGQfOjK5Sjhr83fSTC2G500l3vIglth8lTQVD2J8uZHOiguhXj9rOqRMjXP9QdxZBz+taRLNXhIx8IS95821CV+vajlBw+IZvF5UmqDOsFZ9zrKIaI+VQNLXzn0Wrj3PPKdrlBuZPng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755890871; c=relaxed/simple;
	bh=UrSFc4ceG2KOC9f1OqXNvzvbLgWDesJ+3YD6m1xObDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oet4GxtnDEPz33+yWeZTausQxsWhRPU5tiqdiZa40LnkvmtayQjPzZ2Ut9q177T3WZi6CdWjN7i/4ceNGVdunr/adcJeefdQ1yK6bT4ik0x/ACa/5PpgInudwvVIA69pRrIw16bgZhJRmqFWpYc4rEXtaRv7DiB3eoFNibZt688=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyn2+mIg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB43C4CEED;
	Fri, 22 Aug 2025 19:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755890870;
	bh=UrSFc4ceG2KOC9f1OqXNvzvbLgWDesJ+3YD6m1xObDA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hyn2+mIgBo8O7wkfPZAqZP0AC6dPtJFLg++z7ishNacZ2IUtLAJGLYlA39gbq/YCD
	 rdZFYzBDXikwOVfV186z7i5uAcea0aULJFBm9qbog5RLqA3IDCC2LjUNDNtOluj0t1
	 ioR43MDInW6RG/3huccUvuV7NFPV30qgXrsGKNweBivnqMbQ4Q4IdsLTImdi2uqPHv
	 V4yTMptbG815KymqMRD2E85sMzCn4uJNbDO10bDeX+9zUuFewUI4+v4WsaH2lEW8ux
	 lUGrtSy3sCOwOwYLsbu9XvaC3YtGok0JFk8lPROqyAPL/23N0fN+K5Gti3v6VmIXLF
	 IV6WkIRAYZB8w==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-61bc52fd7a4so1945553eaf.0;
        Fri, 22 Aug 2025 12:27:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXt9VYY63lYZeOUKB1cmft2nbRbf1+xOY7hQWkIfZsgzQ1JFsRV/57RrKr8C4+MhRhMap5+lxGXODZD@vger.kernel.org, AJvYcCXwGAwrTQ2iWK3r0erKSGp89FabxK2a0uQZqipoEtpvS/SixeKhzyHE+S6N0ZifEY2CiGm4hKqzZca3ab/V@vger.kernel.org
X-Gm-Message-State: AOJu0YyYSkd7Ed1Tp+fUcdfULmP5qYHQhQACkXHdezLImpp2V03GySDt
	/DhIBHacY7IBmOw0YvT0mVbVVHP8m6q4WXvcPooqY4wKFOEBSdus487NHvO4gjlKIXpNSkqLdKD
	qlvxlS/+BOo5gHL4d9ZE1Nxmm7368MBs=
X-Google-Smtp-Source: AGHT+IFwyQIR5WWfBTC+i7HkpeOSpK0phH5gxCkFaPo2TqBE2UYaYKYoFKiUQF3I1397M+baz0oJdPJhuoG/nqkczxo=
X-Received: by 2002:a05:6870:b507:b0:314:9689:a466 with SMTP id
 586e51a60fabf-314dd6e64d7mr2103441fac.22.1755890869635; Fri, 22 Aug 2025
 12:27:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728070612.1260859-1-lihuisong@huawei.com> <20250728070612.1260859-2-lihuisong@huawei.com>
In-Reply-To: <20250728070612.1260859-2-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 Aug 2025 21:27:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ir6ds5KGMQAUwb-hEdwhbuALHdYzDspT9z=W4md1rsOw@mail.gmail.com>
X-Gm-Features: Ac12FXxeNPnp9DZtU-EOTSVEq2I6VEFp-0bTRwQXvdmuJ7s9CENx8TIn4dVonGs
Message-ID: <CAJZ5v0ir6ds5KGMQAUwb-hEdwhbuALHdYzDspT9z=W4md1rsOw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ACPI: processor: idle: Fix memory leak when
 register cpuidle device failed
To: Huisong Li <lihuisong@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com, liuyonglong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 9:06=E2=80=AFAM Huisong Li <lihuisong@huawei.com> w=
rote:
>
> The cpuidle device's memory has been leaked when register cpuidle
> device failed in acpi_processor_power_init().
>
> Fixes: 3d339dcbb56d ("cpuidle / ACPI : move cpuidle_device field out of t=
he acpi_processor_power structure")
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/acpi/processor_idle.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index 2c2dc559e0f8..031738390f2d 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1405,6 +1405,8 @@ int acpi_processor_power_init(struct acpi_processor=
 *pr)
>                 if (retval) {
>                         if (acpi_processor_registered =3D=3D 0)
>                                 cpuidle_unregister_driver(&acpi_idle_driv=
er);
> +                       kfree(dev);
> +                       per_cpu(acpi_cpuidle_device, pr->id) =3D NULL;
>                         return retval;
>                 }
>                 acpi_processor_registered++;
> --

Applied as 6.18 material with minor adjustments, thanks!

