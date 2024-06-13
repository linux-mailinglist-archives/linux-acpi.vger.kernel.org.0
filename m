Return-Path: <linux-acpi+bounces-6379-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C86B2907C09
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 21:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8C141C24B7A
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 19:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E211D137905;
	Thu, 13 Jun 2024 19:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cP2izgT3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71B9F9F8;
	Thu, 13 Jun 2024 19:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718305665; cv=none; b=fY8tPkxC0Jdw0hFLmygmHpYB3cONjXX42cuJPI57IX9y2YJPgkCGrHDLe1qdNKkDwB60GcYNT1Cc8ENi6fL/7XeWtPNfPs0aJYp3ujsxFJXeXDJVxo0AzAC0DmcwMZUtU6XIX80WQVkvPTVy85z8xaiyBF2fea52vQGBHyIB9HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718305665; c=relaxed/simple;
	bh=rBIdEYd5jFu0+smwdlfbR/AfIbyZXKk7Vhu6cLGSxZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/J8PYNZnwQ9BaGSkCpgQQRBlvgmhov8KMiHMe1N6M3fj7Ue5bFy9xhN9F/lJDtOE157neWp+k0O4y4S/HfhTQ8kul2GGhqg/KHgf77IUvAmeOexrtOy0++i7F4MefHnKuuEYwopIxAPD5GfclUmuI4AE+22CpWpzmJz+GktEjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cP2izgT3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1BAC32786;
	Thu, 13 Jun 2024 19:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718305665;
	bh=rBIdEYd5jFu0+smwdlfbR/AfIbyZXKk7Vhu6cLGSxZk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cP2izgT35cGD+7lFMocFlkB/VSyZC8KX3kPDZLWLH3aWldwNIfgPDoMmYvdP1pmrH
	 PcHFQEUbPAKyC0V2PYUyUEOcPTsOKFYGDyeD8yLBgezUeKThmmJSubnzw7BW7PMMDU
	 Yestw4SGflGTMTixqwLiqXQo6EPSUIDo2kehVkazTKQDYjBcYfP1d0sbIYairUEBeh
	 IfNZQOMXjrtCpk1PVtC8Kg9NofkAb7PgjKUeyCScn6kdkGFwWe77UsOtmUhJv0qr76
	 7ytSVQqQWQfE22Yyj+8C5lZxCTfLeQUWdPBvcFLqMRt64pV9xMSevNEXbMfrDHX6Wr
	 LPzcw0tWGhCtA==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5bb10cfe7daso93935eaf.2;
        Thu, 13 Jun 2024 12:07:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW53A8YknTAwDjRoR19kmFJTF6vEGut+ovX2AKaSrHhfU9nRjY8WlBcvAegr5OMILgOsLK2k6vFwF65R782@vger.kernel.org, AJvYcCXe5fz7eVDEClN5J0T7kcMpAg657k1A8BapJWgVNkuKXbBojothjMx78sk1Qe/k6oaHHQlZ1PDn7RZf6Q==@vger.kernel.org, AJvYcCXwBK2L08NttabDf3PdHF29qaw98Wf9OARnh2iwYkIcrrOEXz/gy2Qjm1q9tC4yubXy88iCyzwdLV5IpdY7R78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu1KjWDdnGsz/znwdy6FBineXqJakSFj+1Len3TxJdEEyx/nzs
	4+1lQvU/frTyHKe+T9I0MhXhzxWdNxpYoZxE50T/ZKOIUrEFlokB3SvTunE4PEcPpBbmsd8c3j2
	0VIDwKrUSGf9WK/kXa6wkAsL77ww=
X-Google-Smtp-Source: AGHT+IGL1poXQ3NOZsQ6DH+8PEMCE1TZqGMdLOTA1ZPa7viW8qftegdQDE3IjM3d4DlSW0uwE7fIglsLzbnco2ThpJs=
X-Received: by 2002:a4a:de45:0:b0:5ba:ca86:a025 with SMTP id
 006d021491bc7-5bdad9f3f2dmr636316eaf.0.1718305664456; Thu, 13 Jun 2024
 12:07:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603-md-drivers-acpi-misc-v1-1-fd7f7de1ce19@quicinc.com>
In-Reply-To: <20240603-md-drivers-acpi-misc-v1-1-fd7f7de1ce19@quicinc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Jun 2024 21:07:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jCtky__pmmZoxpa6WCGVDLukmmDR01nUsSHaT6z3d4vw@mail.gmail.com>
Message-ID: <CAJZ5v0jCtky__pmmZoxpa6WCGVDLukmmDR01nUsSHaT6z3d4vw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: add missing MODULE_DESCRIPTION() macros
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 4:29=E2=80=AFPM Jeff Johnson <quic_jjohnson@quicinc.=
com> wrote:
>
> make allmodconfig && make W=3D1 C=3D1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/acpi/acpi_tad.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/acpi/platform_p=
rofile.o
>
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/acpi/acpi_tad.c         | 1 +
>  drivers/acpi/platform_profile.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
> index 1d670dbe4d1d..b831cb8e53dc 100644
> --- a/drivers/acpi/acpi_tad.c
> +++ b/drivers/acpi/acpi_tad.c
> @@ -27,6 +27,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/suspend.h>
>
> +MODULE_DESCRIPTION("ACPI Time and Alarm (TAD) Device Driver");
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Rafael J. Wysocki");
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_prof=
ile.c
> index 4a9704730224..d2f7fd7743a1 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -217,4 +217,5 @@ int platform_profile_remove(void)
>  EXPORT_SYMBOL_GPL(platform_profile_remove);
>
>  MODULE_AUTHOR("Mark Pearson <markpearson@lenovo.com>");
> +MODULE_DESCRIPTION("ACPI platform profile sysfs interface");
>  MODULE_LICENSE("GPL");
>
> ---

Applied as 6.11 material, thanks!

