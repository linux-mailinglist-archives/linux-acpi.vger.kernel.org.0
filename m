Return-Path: <linux-acpi+bounces-12924-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B320A82E6D
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 20:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D272E3BEAA5
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 18:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C25327700C;
	Wed,  9 Apr 2025 18:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeUMfn95"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68EB7D07D;
	Wed,  9 Apr 2025 18:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744222726; cv=none; b=uQi9Gsdsa+OW37A/Izf8nD8a37iAYnbSIuKDq9Eqk7vGxD30oC0MnyfqYJ83rD3Ydyb1eGMIZZARZZ/p0Gir4RM0+gbu2vmvwYTUTVwXAeP2YtJFz7r2Xi8mU5AdUjZx0plITh2MKTA/f1yy09UplfNpy6vasB4jtjobyS4Yfl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744222726; c=relaxed/simple;
	bh=kS45Som1nQBGihKb4m+Yz52zHGLbvveA2auK4XolUsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IItVid5oaXd14uXRqRIf8CU155OG3eQ9nwP4dGZP6Os+fm5mFcuiozVFhE8elCgFC4ANT8uj1Pe5o8pxGmdkR0uh/HkozMPnP7sjsagZKRoZT8OpqNIOPhTdiP6xWKI5WQdStc66WOsUSZmvZoq8W8Cu8hLyRFxT0qIgtsytd0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeUMfn95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0AEC4CEEB;
	Wed,  9 Apr 2025 18:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744222726;
	bh=kS45Som1nQBGihKb4m+Yz52zHGLbvveA2auK4XolUsU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eeUMfn95uaG5C5IilivfI9p5eeu/mIMvSUGWwDmQcHPWG63MxghGIq5PHcgkwjygM
	 Lfo61l/2ibYR9MBksYYE/acHRfgcsIDc5Eb8UXjoYle/uQ6Fl3nwGAg5OcOHnVcVL8
	 t04Zq0KbTf2tZGDz8ggfoDjRQB5WLbC2P/ISOIrx1OrZtDglvnpbKR1bv/ExybTpRT
	 k9yPCzWUZoGCoAlezxMf2NCfdSRbyStQDGTQYj+lP++GQb2qtC+TMGsIwKUwYbnFSo
	 7vglvOf4x1c4NsJbNXvnwjZpxurG/6Zq/YLekMDBcib24dSqPojUOXWrJ0/5w2ZvCw
	 AhpOCmdm/Hxzg==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2c818343646so4180725fac.3;
        Wed, 09 Apr 2025 11:18:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFIdzFVkqeNn40GUEzhYhkU6IQcmlZb4sb+auvWODp6RAbiKzcNaH1/HZ44369QBV38Dc8DoGZes3L@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo7vifWXxh89agkeUvzxhMyjQ1RWAhLMfTp1dHm/MP91Nkckhc
	TafO8fwTAKx8iVMD+RR44SBnYB5SBYBJZmUiJE4vuXz6zQ98SHbsUnDFmZizBTBo7JiIsCSm6fw
	XT41ReeJIKgx1uNMvbpiUU8o9HQ4=
X-Google-Smtp-Source: AGHT+IHwp9tbK9hLs3eNIFuS7kjTKxjOsLtIE74r9zz5HtuDMjoP8TpEVRI+vifRRrUsUFJTigpgXMCy68JE9Il4B04=
X-Received: by 2002:a05:6870:b9c8:b0:2a7:d345:c0bb with SMTP id
 586e51a60fabf-2d08df8338fmr2268080fac.27.1744222725516; Wed, 09 Apr 2025
 11:18:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318-plat2faux_dev-v2-0-e6cc73f78478@arm.com> <20250318-plat2faux_dev-v2-7-e6cc73f78478@arm.com>
In-Reply-To: <20250318-plat2faux_dev-v2-7-e6cc73f78478@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Apr 2025 20:18:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jV1iHiq_2oNWDja0deQy0JDVp9-R=qi3GeivbY7rSo1A@mail.gmail.com>
X-Gm-Features: ATxdqUHnURzSuZwT-yGfrawR5yDEbBioLJxgm86RUcNIp0FKm8SxQW5lCfDECm4
Message-ID: <CAJZ5v0jV1iHiq_2oNWDja0deQy0JDVp9-R=qi3GeivbY7rSo1A@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] ACPI: APEI: EINJ: Transition to the faux device interface
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 6:02=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> The APEI error injection driver does not require the creation of a
> platform device. Originally, this approach was chosen for simplicity
> when the driver was first implemented.
>
> With the introduction of the lightweight faux device interface, we now
> have a more appropriate alternative. Migrate the driver to utilize the
> faux bus, given that the platform device it previously created was not
> a real one anyway. This will simplify the code, reducing its footprint
> while maintaining functionality.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

This causes 0-day to complain when applied on top of 6.15-rc1:

https://lore.kernel.org/linux-acpi/202504100128.AjbVDQgK-lkp@intel.com/

> ---
>  drivers/acpi/apei/einj-core.c | 51 +++++--------------------------------=
------
>  1 file changed, 6 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.=
c
> index 04731a5b01faaba534bad853d0acc4c8a873a53b..5fddd01074bafab2f7b23fd7e=
f9f863c0856637b 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -21,7 +21,7 @@
>  #include <linux/nmi.h>
>  #include <linux/delay.h>
>  #include <linux/mm.h>
> -#include <linux/platform_device.h>
> +#include <linux/device/faux.h>
>  #include <linux/unaligned.h>
>
>  #include "apei-internal.h"
> @@ -749,7 +749,7 @@ static int einj_check_table(struct acpi_table_einj *e=
inj_tab)
>         return 0;
>  }
>
> -static int __init einj_probe(struct platform_device *pdev)
> +static int __init einj_probe(struct faux_device *fdev)
>  {
>         int rc;
>         acpi_status status;
> @@ -838,6 +838,8 @@ static int __init einj_probe(struct platform_device *=
pdev)
>
>         pr_info("Error INJection is initialized.\n");
>
> +       einj_initialized =3D true;
> +
>         return 0;
>
>  err_release:
> @@ -851,7 +853,7 @@ static int __init einj_probe(struct platform_device *=
pdev)
>         return rc;
>  }
>
> -static void __exit einj_remove(struct platform_device *pdev)
> +static void __exit einj_remove(struct faux_device *fdev)
>  {
>         struct apei_exec_context ctx;
>
> @@ -872,48 +874,7 @@ static void __exit einj_remove(struct platform_devic=
e *pdev)
>         acpi_put_table((struct acpi_table_header *)einj_tab);
>  }
>
> -static struct platform_device *einj_dev;
> -/*
> - * einj_remove() lives in .exit.text. For drivers registered via
> - * platform_driver_probe() this is ok because they cannot get unbound at
> - * runtime. So mark the driver struct with __refdata to prevent modpost
> - * triggering a section mismatch warning.
> - */
> -static struct platform_driver einj_driver __refdata =3D {
> -       .remove =3D __exit_p(einj_remove),
> -       .driver =3D {
> -               .name =3D "acpi-einj",
> -       },
> -};
> -
> -static int __init einj_init(void)
> -{
> -       struct platform_device_info einj_dev_info =3D {
> -               .name =3D "acpi-einj",
> -               .id =3D -1,
> -       };
> -       int rc;
> -
> -       einj_dev =3D platform_device_register_full(&einj_dev_info);
> -       if (IS_ERR(einj_dev))
> -               return PTR_ERR(einj_dev);
> -
> -       rc =3D platform_driver_probe(&einj_driver, einj_probe);
> -       einj_initialized =3D rc =3D=3D 0;
> -
> -       return 0;
> -}
> -
> -static void __exit einj_exit(void)
> -{
> -       if (einj_initialized)
> -               platform_driver_unregister(&einj_driver);
> -
> -       platform_device_unregister(einj_dev);
> -}
> -
> -module_init(einj_init);
> -module_exit(einj_exit);
> +module_faux_driver(acpi_einj, einj_probe, __exit_p(einj_remove), true);
>
>  MODULE_AUTHOR("Huang Ying");
>  MODULE_DESCRIPTION("APEI Error INJection support");
>
> --
> 2.34.1
>
>

