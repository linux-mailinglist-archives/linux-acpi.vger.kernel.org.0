Return-Path: <linux-acpi+bounces-718-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41047CDBC8
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 14:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EBE0280A92
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 12:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449D334CD5
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 12:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EC317753
	for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 10:47:37 +0000 (UTC)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70C1B0;
	Wed, 18 Oct 2023 03:47:35 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-57bf04841ccso1372601eaf.0;
        Wed, 18 Oct 2023 03:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697626055; x=1698230855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owRD6lMJDku4XSPhJxJ1EXNoQcyNAZKK4phuEs/4T2s=;
        b=jTt3vTlQEz8nTrOe6JfxzBF4gWWW8QkTcLwycj1aUS6mcRtLlNpOyj4qagRQFU44h+
         5GdOdPHEGkFoKDTCVtRyB4Jla1IAvscDRkclEwH1E8FdaAjcKgjjoiYTcKMfF1zm9Fb5
         p09e3VXpZCrVabsQSkd2/YtE7mCLgFVOvrQkN46djJdHpkHAZGBDq+u4hBVFHInIR54Y
         IUQbT3GjZjs31uQ3Dtfw0ANHE3KVMhvyesL1rd/nZ/rVU+qeI40c6+UmRfekdfKDKnaM
         B1Tmfmb4ZLK6TZT8tL6amghhwUeISr67d0JGjnd658SufWe1/TBVPLXZNbV2pUvu6hIs
         AmpQ==
X-Gm-Message-State: AOJu0YzX9oE1EDxaGp8zUp6MsfvSo851gkLTUgNVrWG0WbTEFPzYyFR1
	rbhZnU/2L9fOitR5U7pIUInWPZB0IA4RDH6xkivAewkM
X-Google-Smtp-Source: AGHT+IFtEpXVsN5jFuSpPWCMC/bpVMsjvq2nuGZOajiQq84V25jdp6093L7xb6e9qui47a0H6GP7B5YHUOARljSWBo8=
X-Received: by 2002:a4a:4f15:0:b0:581:e7b8:dd77 with SMTP id
 c21-20020a4a4f15000000b00581e7b8dd77mr3401978oob.1.1697626054921; Wed, 18 Oct
 2023 03:47:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016170125.576159-1-michal.wilczynski@intel.com> <20231016170125.576159-2-michal.wilczynski@intel.com>
In-Reply-To: <20231016170125.576159-2-michal.wilczynski@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Oct 2023 12:47:24 +0200
Message-ID: <CAJZ5v0ib86pvMcXFS_TJ+_6JSdJHaWwY-WDGrtDozGvr3j0Pgw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] ACPI: acpi_pad: Replace acpi_driver with platform_driver
To: Michal Wilczynski <michal.wilczynski@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com, 
	lenb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 8:42=E2=80=AFPM Michal Wilczynski
<michal.wilczynski@intel.com> wrote:
>
> The acpi_pad driver uses struct acpi_driver to register itself while it
> would be more logically consistent to use struct platform_driver for this
> purpose, because the corresponding platform device is present and the
> role of struct acpi_device is to amend the other bus types. ACPI devices
> are not meant to be used as proper representation of hardware entities,
> but to collect information on those hardware entities provided by the
> platform firmware.
>
> Use struct platform_driver for registering the acpi_pad driver.
>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> ---
>  drivers/acpi/acpi_pad.c | 41 ++++++++++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
> index 7a453c5ff303..36e1049833a3 100644
> --- a/drivers/acpi/acpi_pad.c
> +++ b/drivers/acpi/acpi_pad.c
> @@ -18,6 +18,7 @@
>  #include <linux/slab.h>
>  #include <linux/acpi.h>
>  #include <linux/perf_event.h>
> +#include <linux/platform_device.h>
>  #include <asm/mwait.h>
>  #include <xen/xen.h>
>
> @@ -413,16 +414,16 @@ static void acpi_pad_handle_notify(acpi_handle hand=
le)
>         mutex_unlock(&isolated_cpus_lock);
>  }
>
> -static void acpi_pad_notify(acpi_handle handle, u32 event,
> -       void *data)
> +static void acpi_pad_notify(acpi_handle handle, u32 event, void *data)
>  {
> -       struct acpi_device *device =3D data;
> +       struct device *dev =3D data;
> +       struct acpi_device *device =3D ACPI_COMPANION(dev);
>
>         switch (event) {
>         case ACPI_PROCESSOR_AGGREGATOR_NOTIFY:
>                 acpi_pad_handle_notify(handle);
>                 acpi_bus_generate_netlink_event(device->pnp.device_class,
> -                       dev_name(&device->dev), event, 0);
> +                                               dev_name(dev), event, 0);

This is the same mistake as in the analogous AC driver patch, as it
changes the binary interface between the kernel and user space.

Please leave it as is for now (at least in this patch).

>                 break;
>         default:
>                 pr_warn("Unsupported event [0x%x]\n", event);
> @@ -430,8 +431,10 @@ static void acpi_pad_notify(acpi_handle handle, u32 =
event,
>         }
>  }
>
> -static int acpi_pad_add(struct acpi_device *device)
> +static int acpi_pad_probe(struct platform_device *pdev)
>  {
> +       struct acpi_device *device =3D ACPI_COMPANION(&pdev->dev);
> +       struct device *dev =3D &pdev->dev;
>         acpi_status status;
>
>         strcpy(acpi_device_name(device), ACPI_PROCESSOR_AGGREGATOR_DEVICE=
_NAME);
> @@ -441,7 +444,9 @@ static int acpi_pad_add(struct acpi_device *device)
>                 return -ENODEV;
>
>         status =3D acpi_install_notify_handler(device->handle,
> -               ACPI_DEVICE_NOTIFY, acpi_pad_notify, device);
> +                                            ACPI_DEVICE_NOTIFY,
> +                                            acpi_pad_notify,
> +                                            dev);

Passing the struct acpi_device pointer as the last argument here is
fine, no need to change that.

>         if (ACPI_FAILURE(status)) {
>                 acpi_pad_remove_sysfs(device);
>                 return -ENODEV;
> @@ -450,14 +455,17 @@ static int acpi_pad_add(struct acpi_device *device)
>         return 0;
>  }
>
> -static void acpi_pad_remove(struct acpi_device *device)
> +static void acpi_pad_remove(struct platform_device *pdev)
>  {
> +       struct acpi_device *device =3D ACPI_COMPANION(&pdev->dev);
> +
>         mutex_lock(&isolated_cpus_lock);
>         acpi_pad_idle_cpus(0);
>         mutex_unlock(&isolated_cpus_lock);
>
>         acpi_remove_notify_handler(device->handle,
> -               ACPI_DEVICE_NOTIFY, acpi_pad_notify);
> +                                  ACPI_DEVICE_NOTIFY,
> +                                  acpi_pad_notify);

The white space cleanup can be done in a separate patch (here and in
the other places).

>         acpi_pad_remove_sysfs(device);
>  }
>
> @@ -467,13 +475,12 @@ static const struct acpi_device_id pad_device_ids[]=
 =3D {
>  };
>  MODULE_DEVICE_TABLE(acpi, pad_device_ids);
>
> -static struct acpi_driver acpi_pad_driver =3D {
> -       .name =3D "processor_aggregator",
> -       .class =3D ACPI_PROCESSOR_AGGREGATOR_CLASS,
> -       .ids =3D pad_device_ids,
> -       .ops =3D {
> -               .add =3D acpi_pad_add,
> -               .remove =3D acpi_pad_remove,
> +static struct platform_driver acpi_pad_driver =3D {
> +       .probe =3D acpi_pad_probe,
> +       .remove_new =3D acpi_pad_remove,
> +       .driver =3D {
> +               .name =3D "processor_aggregator",
> +               .acpi_match_table =3D pad_device_ids,
>         },
>  };
>
> @@ -487,12 +494,12 @@ static int __init acpi_pad_init(void)
>         if (power_saving_mwait_eax =3D=3D 0)
>                 return -EINVAL;
>
> -       return acpi_bus_register_driver(&acpi_pad_driver);
> +       return platform_driver_register(&acpi_pad_driver);
>  }
>
>  static void __exit acpi_pad_exit(void)
>  {
> -       acpi_bus_unregister_driver(&acpi_pad_driver);
> +       platform_driver_unregister(&acpi_pad_driver);
>  }
>
>  module_init(acpi_pad_init);
> --

