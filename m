Return-Path: <linux-acpi+bounces-9329-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2BB9BD6E5
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 21:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151741F22E22
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 20:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AAD21219C;
	Tue,  5 Nov 2024 20:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIl2kRgh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBCD1EBFF1;
	Tue,  5 Nov 2024 20:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730838182; cv=none; b=udrvTFTNb4RscY2gWQyoCC+ectAn/fTB9tK5dw16NWoZLFJWFrplD6BglX/k+Re5yrRYFu7YTc6cjdszWdDO4OaZrjNmmK8/G1VUeYaG3wEUOFn9yCe2iQMXajmj7+AzLMqEhob75T3G/BhzVU/wzeCaezy6f4r5mLVpwuHmNU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730838182; c=relaxed/simple;
	bh=p0cxWwuAOVwjVA5NZqCtccTI2j1kA74DVH7qGX9vENg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KWug4SmSxGJTl/C6jgikOQ1ix2Yo22ifhxAmJMUf6V7AExJk53OuKuCPMBAhqHjiO+3/JloZBlJfagrAiqDU9WFzr5HvyuLD7xIfWBtmGvACN6hacD+zloO6PvcKBhiqzAEeVMd2pWb+0agFL354npeT+lPDhYv9TGTeSbsngPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIl2kRgh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A31C4CED4;
	Tue,  5 Nov 2024 20:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730838181;
	bh=p0cxWwuAOVwjVA5NZqCtccTI2j1kA74DVH7qGX9vENg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XIl2kRghLvJyPBIO+ZtmCgvY0tS5KDyld93lbccjI1hYJq11rKaog0H0ZKEFwZUaW
	 4VDMX+JcgEWkG6ACC2Vhhp6uxKrDhLhU8zbKjmjF/lUenUHqY2pJ77+Gp4/vV3baV3
	 ztz/1KSpDjPWYncda0/Zjq5o7uv3wdCKPSYKrA7Ix2r/oXYkDXiCsShIFdL9NjHe0N
	 303FrFtZvFnTQmLqrCEw7TGtXgBIg6pI7AdFp2OAtIhkFfytPcv126Guuj3bTxfIqn
	 pMZHt+ukS8EfmUEFof0GoGKDb3t5iI4IRdl9FUXi7hs2p6vATSDDirBo8CulCR4cFf
	 Vkh5UpHVqP3fA==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-71811c7eb8dso2685412a34.0;
        Tue, 05 Nov 2024 12:23:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVF2LQeX7keb4MZDMUtVb/EcVZmMYEMqXl1aAkApVke3LAf5M295V6XB3HmLE9XjnBrelrb/jPvLKDS@vger.kernel.org, AJvYcCVoNUHHWyKLIBoGeDJFh7a48n4c28tzLBIt3t1EzbbLVJZeXrxmkhECcndingh0HNnyItJj3HL7RWRdnXFp@vger.kernel.org
X-Gm-Message-State: AOJu0YwT4JRznRhGtT7MOKFkGS8vJhhoC2JJtIBDABkP33TaDXDGoI3p
	T+YpJrQjBR2qR/EUAkaN+XrkdG/jwsnE05vNoumoT/x5jRPA6zBs1dzR757A3f52Ojr7+Pk/Z6Y
	b5RVnv1L+vYdCEUHkDFaOh+OkfVk=
X-Google-Smtp-Source: AGHT+IFhXTr3CHxNkH5BCESn9YSc4gAXiLF1J5loVpxDmi6Jh0KlCCa4aL3A2x1Zw+6Ze3LbWdNR0WFdOFKilHBBeJI=
X-Received: by 2002:a05:6830:6618:b0:710:ec4a:b394 with SMTP id
 46e09a7af769-719ca25ea6amr15803674a34.29.1730838180984; Tue, 05 Nov 2024
 12:23:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027083007.11199-1-qasim.majeed20@gmail.com>
In-Reply-To: <20241027083007.11199-1-qasim.majeed20@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 5 Nov 2024 21:22:50 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jrxW+MxES3CgiFG4ttJWtV85=j3CpyeeJqveDvNj=6fw@mail.gmail.com>
Message-ID: <CAJZ5v0jrxW+MxES3CgiFG4ttJWtV85=j3CpyeeJqveDvNj=6fw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: thermal: Use strscpy instead of strcpy.
To: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 27, 2024 at 9:30=E2=80=AFAM Muhammad Qasim Abdul Majeed
<qasim.majeed20@gmail.com> wrote:
>
> Replace strcpy() with strscpy() in the ACPI thermal driver.
>
> strcpy() has been deprecated because it is generally unsafe.
> Eliminating it from the kernel source.
>
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
>
> Hi Rafael,
>
> Any update on the patches?
>
> Best Regards,
> Qasim
>
> ---
>  drivers/acpi/thermal.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index a0cfc857fb55..0c69d04fbac9 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -842,9 +842,9 @@ static int acpi_thermal_add(struct acpi_device *devic=
e)
>                 return -ENOMEM;
>
>         tz->device =3D device;
> -       strcpy(tz->name, device->pnp.bus_id);
> -       strcpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME);
> -       strcpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
> +       strscpy(tz->name, device->pnp.bus_id);
> +       strscpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME);
> +       strscpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
>         device->driver_data =3D tz;
>
>         acpi_thermal_aml_dependency_fix(tz);
> --

Applied (with edits in the changelog) as 6.13 material, thanks!

