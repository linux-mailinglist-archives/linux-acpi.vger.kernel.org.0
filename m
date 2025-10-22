Return-Path: <linux-acpi+bounces-18118-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E813BFDF2C
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 20:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EB204E25AB
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 18:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1D834EEF6;
	Wed, 22 Oct 2025 18:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+KlbbKb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AFF34D4EA
	for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 18:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761159541; cv=none; b=qKiBmnqgKnP2x3Z11ZXnovebA33Om0tfxQ63zSEaCekd+ziLqFheymC6cCMG2l5UuWgyrTeVqVz4spFZJYOfHZh/KCmvrSSvbpKB8m/WT2BqB+AIQo2FbI+qWUYXJphUkaYtgIKZ64XhczgK5xE5P0H+9yLyBcyUzCtFq1yxZzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761159541; c=relaxed/simple;
	bh=mlwslglfW4AmbMaPmUaoJHzXtLDw/OW10z4gunbfZxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gW3acjc9mXZ2eMhBYEPP0vq05sH0a2bll7rUAGJFSq5JTK4UFDVBHKiaOAanHC/ntQoPQxWN05GtoWifeiacVt9uYGKHjJPIW4spu3c4XFKZlENh5RHo4WdddtjRzV84fJeuVJo10dfrX6koRVwpJt3mhOej51aGnMCLmOLKOZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+KlbbKb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05F5C4CEF7
	for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 18:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761159540;
	bh=mlwslglfW4AmbMaPmUaoJHzXtLDw/OW10z4gunbfZxk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m+KlbbKbg+TVRUrI8Rg4IVBS8BBDieHkrgK4IYVotugzRLIalVionN9nECSOzOKh/
	 SuCdc4S8dxNGMyI5vnU7COp01KIbgH/HDTl5XpE1UGP6Q8uorE/9PV0RxhCuYvRgIR
	 uAy0PmKDphEFrK2B7i4OxeGgF18fK7pisZ/Av0AeBEZqWqOKvsn1xhi5OIP9Q3MKd2
	 hgdgbaksqNcQDkAi7lfPZTnnRlPQ9vqvve9SsDgpgx9h9oRAwcdtr0iMw9UA/1ZNbt
	 V2r4iie3W/TaPCJgkKfUBcKr+4owpzG0usCGZUiVjO+GxE744huWm+nDy25sLYEno8
	 Fh+9asyIXQBbQ==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7c28bf230feso1177051a34.0
        for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 11:59:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUKjuvXJT1LwARdE8xKrRHUsAUmUTyZNsbSkHG+9B8hII2CjC3GI56ROSVryyUtjSFCKye61bRD8sEJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyMrHRfX/NRD7GQa2UFLLhqVIAHnZk9YgTXb1blaNbermJBuvu9
	3vV1FobUX7qwYyWaLT8rP9vEtjo3nBXM9GIXaLFNLkoScWXe4VE22iklq4xnilKFNRgaQfeJc+/
	V5DyYdi1tgjNQtJE3QqqjagZnxj/zSqg=
X-Google-Smtp-Source: AGHT+IH6Jjo+IK81R/sTD0z/wJnoekcNqRBMKeJWqjdcL97733FKRJK/+yvWMd2u3QK97i8+mkKlE/vupbbju7xyqD4=
X-Received: by 2002:a05:6808:4f29:b0:43f:28bb:2f85 with SMTP id
 5614622812f47-44963d8028dmr2095232b6e.8.1761159540078; Wed, 22 Oct 2025
 11:59:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002113404.3117429-1-srosek@google.com> <20251002113404.3117429-6-srosek@google.com>
In-Reply-To: <20251002113404.3117429-6-srosek@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 22 Oct 2025 20:58:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hGKHJKMXPLKKGUntDok8SSm0=TGYqHFkCxXBxkygfK7w@mail.gmail.com>
X-Gm-Features: AS18NWD-inSgNr9w6XPyQUnP_62cM9xRIQR6r2OvWy2WykLMUtE5HsKh3HsYhsc
Message-ID: <CAJZ5v0hGKHJKMXPLKKGUntDok8SSm0=TGYqHFkCxXBxkygfK7w@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] ACPI: platform: Add macro for acpi platform driver
To: Slawomir Rosek <srosek@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Alex Hung <alexhung@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, 
	AceLan Kao <acelan.kao@canonical.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tomasz Nowicki <tnowicki@google.com>, 
	Stanislaw Kardach <skardach@google.com>, Michal Krawczyk <mikrawczyk@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 1:34=E2=80=AFPM Slawomir Rosek <srosek@google.com> w=
rote:
>
> Introduce module_acpi_platform_driver() macro to simplify dynamic
> enumeration of ACPI device objects on the platform bus by loadable
> modules. Move common code from the intel-hid and intel-vbtn drivers
> to the ACPI platform core.

I think that this goes the other way around: common code is moved from
intel-hid and intel-vbtn to acpi_platform and the new macro is
introduced as a way for the drivers to invoke that code.

> Signed-off-by: Slawomir Rosek <srosek@google.com>

Overall, it looks like this patch does not depend on the [1-4/6] in this se=
ries.

> ---
>  drivers/acpi/acpi_platform.c      | 27 +++++++++++++++++++++++++
>  drivers/platform/x86/intel/hid.c  | 33 +++----------------------------
>  drivers/platform/x86/intel/vbtn.c | 30 +---------------------------
>  include/linux/platform_device.h   | 17 ++++++++++++++++
>  4 files changed, 48 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> index 48d15dd785f6..adf32ffa6be6 100644
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -190,6 +190,33 @@ struct platform_device *acpi_create_platform_device(=
struct acpi_device *adev,
>  }
>  EXPORT_SYMBOL_GPL(acpi_create_platform_device);
>
> +static acpi_status
> +__acpi_platform_driver_register_cb(acpi_handle handle, u32 lvl,
> +                               void *context, void **rv)
> +{
> +       const struct acpi_device_id *ids =3D context;
> +       struct acpi_device *dev =3D acpi_fetch_acpi_dev(handle);
> +
> +       if (dev && acpi_match_device_ids(dev, ids) =3D=3D 0)
> +               if (!IS_ERR_OR_NULL(acpi_create_platform_device(dev, NULL=
))) {
> +                       dev_info(&dev->dev,
> +                                "created platform device\n");
> +               }
> +
> +       return AE_OK;
> +}
> +
> +int __acpi_platform_driver_register(struct platform_driver *drv,
> +                               struct module *owner)
> +{
> +       acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT, ACPI_UINT=
32_MAX,
> +                           __acpi_platform_driver_register_cb, NULL,
> +                           (void *)drv->driver.acpi_match_table, NULL);

Why is this needed here?

> +
> +       return __platform_driver_register(drv, owner);
> +}
> +EXPORT_SYMBOL_GPL(__acpi_platform_driver_register);
> +
>  void __init acpi_platform_init(void)
>  {
>         acpi_reconfig_notifier_register(&acpi_platform_notifier);
> diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/inte=
l/hid.c
> index f25a427cccda..37f990686446 100644
> --- a/drivers/platform/x86/intel/hid.c
> +++ b/drivers/platform/x86/intel/hid.c
> @@ -775,34 +775,7 @@ static struct platform_driver intel_hid_pl_driver =
=3D {
>   *
>   * As a workaround until the ACPI core figures out how to handle
>   * this corner case, manually ask the ACPI platform device code to
> - * claim the ACPI node.
> + * claim the ACPI node by using module_acpi_platform_driver()
> + * instead of the regular module_platform_driver().
>   */
> -static acpi_status __init
> -check_acpi_dev(acpi_handle handle, u32 lvl, void *context, void **rv)
> -{
> -       const struct acpi_device_id *ids =3D context;
> -       struct acpi_device *dev =3D acpi_fetch_acpi_dev(handle);
> -
> -       if (dev && acpi_match_device_ids(dev, ids) =3D=3D 0)
> -               if (!IS_ERR_OR_NULL(acpi_create_platform_device(dev, NULL=
)))
> -                       dev_info(&dev->dev,
> -                                "intel-hid: created platform device\n");
> -
> -       return AE_OK;
> -}
> -
> -static int __init intel_hid_init(void)
> -{
> -       acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
> -                           ACPI_UINT32_MAX, check_acpi_dev, NULL,
> -                           (void *)intel_hid_ids, NULL);

This actually isn't right and should not be perpetuated.

Platform devices are created for ACPI device objects with ACPI device
IDs by acpi_default_enumeration(), so it should not be necessary to do
that from a driver.

> -
> -       return platform_driver_register(&intel_hid_pl_driver);
> -}
> -module_init(intel_hid_init);
> -
> -static void __exit intel_hid_exit(void)
> -{
> -       platform_driver_unregister(&intel_hid_pl_driver);
> -}
> -module_exit(intel_hid_exit);
> +module_acpi_platform_driver(intel_hid_pl_driver);
> diff --git a/drivers/platform/x86/intel/vbtn.c b/drivers/platform/x86/int=
el/vbtn.c
> index 232cd12e3c9f..42932479de35 100644
> --- a/drivers/platform/x86/intel/vbtn.c
> +++ b/drivers/platform/x86/intel/vbtn.c
> @@ -390,32 +390,4 @@ static struct platform_driver intel_vbtn_pl_driver =
=3D {
>         .remove =3D intel_vbtn_remove,
>  };
>
> -static acpi_status __init
> -check_acpi_dev(acpi_handle handle, u32 lvl, void *context, void **rv)
> -{
> -       const struct acpi_device_id *ids =3D context;
> -       struct acpi_device *dev =3D acpi_fetch_acpi_dev(handle);
> -
> -       if (dev && acpi_match_device_ids(dev, ids) =3D=3D 0)
> -               if (!IS_ERR_OR_NULL(acpi_create_platform_device(dev, NULL=
)))
> -                       dev_info(&dev->dev,
> -                                "intel-vbtn: created platform device\n")=
;
> -
> -       return AE_OK;
> -}
> -
> -static int __init intel_vbtn_init(void)
> -{
> -       acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
> -                           ACPI_UINT32_MAX, check_acpi_dev, NULL,
> -                           (void *)intel_vbtn_ids, NULL);

Same thing here.

> -
> -       return platform_driver_register(&intel_vbtn_pl_driver);
> -}
> -module_init(intel_vbtn_init);
> -
> -static void __exit intel_vbtn_exit(void)
> -{
> -       platform_driver_unregister(&intel_vbtn_pl_driver);
> -}
> -module_exit(intel_vbtn_exit);
> +module_acpi_platform_driver(intel_vbtn_pl_driver);
> diff --git a/include/linux/platform_device.h b/include/linux/platform_dev=
ice.h
> index 074754c23d33..3b70b054d8a5 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -264,6 +264,14 @@ extern int __platform_driver_register(struct platfor=
m_driver *,
>                                         struct module *);
>  extern void platform_driver_unregister(struct platform_driver *);
>
> +/*
> + * use a macro to avoid include chaining to get THIS_MODULE
> + */
> +#define acpi_platform_driver_register(drv) \
> +       __acpi_platform_driver_register(drv, THIS_MODULE)
> +extern int __acpi_platform_driver_register(struct platform_driver *,
> +                                       struct module *);

If "extern" is not necessary above, please remove it.

> +
>  /* non-hotpluggable platform devices may use this so that probe() and
>   * its support may live in __init sections, conserving runtime memory.
>   */
> @@ -292,6 +300,15 @@ static inline void platform_set_drvdata(struct platf=
orm_device *pdev,
>         module_driver(__platform_driver, platform_driver_register, \
>                         platform_driver_unregister)
>
> +/* module_acpi_platform_driver() - Helper macro for drivers that don't d=
o
> + * anything special in module init/exit.  This eliminates a lot of
> + * boilerplate.  Each module may only use this macro once, and
> + * calling it replaces module_init() and module_exit()
> + */
> +#define module_acpi_platform_driver(__platform_driver) \
> +       module_driver(__platform_driver, acpi_platform_driver_register, \
> +                       platform_driver_unregister)
> +
>  /* builtin_platform_driver() - Helper macro for builtin drivers that
>   * don't do anything special in driver init.  This eliminates some
>   * boilerplate.  Each driver may only use this macro once, and
> --

