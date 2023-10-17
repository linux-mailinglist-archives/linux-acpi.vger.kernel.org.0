Return-Path: <linux-acpi+bounces-694-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE577CC5F6
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Oct 2023 16:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92A1E2818DD
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Oct 2023 14:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBE64446D
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Oct 2023 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3248E43A93
	for <linux-acpi@vger.kernel.org>; Tue, 17 Oct 2023 14:06:56 +0000 (UTC)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C932AF0;
	Tue, 17 Oct 2023 07:06:54 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-57b68555467so241503eaf.0;
        Tue, 17 Oct 2023 07:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697551614; x=1698156414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/q+wuZASo6Z0fTJ2g1A4X/m+vDSravRUT5sPcdQHlI=;
        b=t1v1rOg0NIxvVg99T6z+BTv8b+B1IYm2zqMjkiDN91Xh4vYrWIXqmuMSLxBmPFWkpU
         iBg5N6KOG0EK18QeR/z9h5nzq7HH4sdpNyeRTFuFqJIdgNXODbhsXH+349Tb+xMSSRse
         HRs3Y4JACGisPHvltmTzoyOW7D70eeEcSkyXlFXF0HOIrrIyJs+hoMK8rihOPq7mxhNp
         akkAO5sk67Xr39AO3VbbaW3XxFAFeqnmrf3yY/1Abf2bGIBGP0ZuP2McfW8HaUFQpeuV
         pXjetVkgM72KIR4EtZ3JBIDT4d3jVVJEjQm+6IIU/5GvlpB9J7vszEwBMXF9KRbLmPZm
         E7Lw==
X-Gm-Message-State: AOJu0YzhCcsvgsbC7aYd6PqL94x5OWhAq7gcNPeUuXVrT3G0c2vFndCw
	pzGcs2BhjROuZWVWp6BppNtQf1EgcYqBTYZxmTTC/mXMSMo=
X-Google-Smtp-Source: AGHT+IFd96eE/x88+yG5zSGJ+AiwCCf74V15p7hd79kQ8n5jO9c89RDSq0OCq/k/XaacLWnWy5bit6ABH63kQ0g4IT4=
X-Received: by 2002:a4a:d898:0:b0:581:84e9:a7ad with SMTP id
 b24-20020a4ad898000000b0058184e9a7admr2267424oov.1.1697551614004; Tue, 17 Oct
 2023 07:06:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231006173055.2938160-1-michal.wilczynski@intel.com> <20231006173055.2938160-6-michal.wilczynski@intel.com>
In-Reply-To: <20231006173055.2938160-6-michal.wilczynski@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 17 Oct 2023 16:06:43 +0200
Message-ID: <CAJZ5v0h=gcEcnnWiRdLVgZgEYFg3-U=odGFPS_6odFW2+4_=YQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] ACPI: NFIT: Replace acpi_driver with platform_driver
To: Michal Wilczynski <michal.wilczynski@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, rafael.j.wysocki@intel.com, 
	andriy.shevchenko@intel.com, lenb@kernel.org, dan.j.williams@intel.com, 
	vishal.l.verma@intel.com, ira.weiny@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 6, 2023 at 8:33=E2=80=AFPM Michal Wilczynski
<michal.wilczynski@intel.com> wrote:
>
> NFIT driver uses struct acpi_driver incorrectly to register itself.
> This is wrong as the instances of the ACPI devices are not meant
> to be literal devices, they're supposed to describe ACPI entry of a
> particular device.
>
> Use platform_driver instead of acpi_driver. In relevant places call
> platform devices instances pdev to make a distinction with ACPI
> devices instances.
>
> NFIT driver uses devm_*() family of functions extensively. This change
> has no impact on correct functioning of the whole devm_*() family of
> functions, since the lifecycle of the device stays the same. It is still
> being created during the enumeration, and destroyed on platform device
> removal.
>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> ---
>  drivers/acpi/nfit/core.c | 34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 942b84d94078..fb0bc16fa186 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -15,6 +15,7 @@
>  #include <linux/sort.h>
>  #include <linux/io.h>
>  #include <linux/nd.h>
> +#include <linux/platform_device.h>
>  #include <asm/cacheflush.h>
>  #include <acpi/nfit.h>
>  #include "intel.h"
> @@ -98,7 +99,7 @@ static struct acpi_device *to_acpi_dev(struct acpi_nfit=
_desc *acpi_desc)
>                         || strcmp(nd_desc->provider_name, "ACPI.NFIT") !=
=3D 0)
>                 return NULL;
>
> -       return to_acpi_device(acpi_desc->dev);
> +       return ACPI_COMPANION(acpi_desc->dev);
>  }
>
>  static int xlat_bus_status(void *buf, unsigned int cmd, u32 status)
> @@ -3284,11 +3285,11 @@ static void acpi_nfit_put_table(void *table)
>
>  static void acpi_nfit_notify(acpi_handle handle, u32 event, void *data)
>  {
> -       struct acpi_device *adev =3D data;
> +       struct device *dev =3D data;
>
> -       device_lock(&adev->dev);
> -       __acpi_nfit_notify(&adev->dev, handle, event);
> -       device_unlock(&adev->dev);
> +       device_lock(dev);
> +       __acpi_nfit_notify(dev, handle, event);
> +       device_unlock(dev);

Careful here.

The ACPI device locking is changed to platform device locking without
a word of explanation in the changelog.

Do you actually know what the role of the locking around
__acpi_nfit_notify() is and whether or not it can be replaced with
platform device locking safely?

>  }
>
>  static void acpi_nfit_remove_notify_handler(void *data)
> @@ -3329,11 +3330,12 @@ void acpi_nfit_shutdown(void *data)
>  }
>  EXPORT_SYMBOL_GPL(acpi_nfit_shutdown);
>
> -static int acpi_nfit_add(struct acpi_device *adev)
> +static int acpi_nfit_probe(struct platform_device *pdev)
>  {
>         struct acpi_buffer buf =3D { ACPI_ALLOCATE_BUFFER, NULL };
>         struct acpi_nfit_desc *acpi_desc;
> -       struct device *dev =3D &adev->dev;
> +       struct device *dev =3D &pdev->dev;
> +       struct acpi_device *adev =3D ACPI_COMPANION(dev);
>         struct acpi_table_header *tbl;
>         acpi_status status =3D AE_OK;
>         acpi_size sz;
> @@ -3360,7 +3362,7 @@ static int acpi_nfit_add(struct acpi_device *adev)
>         acpi_desc =3D devm_kzalloc(dev, sizeof(*acpi_desc), GFP_KERNEL);
>         if (!acpi_desc)
>                 return -ENOMEM;
> -       acpi_nfit_desc_init(acpi_desc, &adev->dev);
> +       acpi_nfit_desc_init(acpi_desc, dev);

You seem to think that replacing adev->dev with pdev->dev everywhere
in this driver will work,

Have you verified that in any way?  If so, then how?

>
>         /* Save the acpi header for exporting the revision via sysfs */
>         acpi_desc->acpi_header =3D *tbl;
> @@ -3391,7 +3393,7 @@ static int acpi_nfit_add(struct acpi_device *adev)
>                 return rc;
>
>         rc =3D acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
> -                                            acpi_nfit_notify, adev);
> +                                            acpi_nfit_notify, dev);
>         if (rc)
>                 return rc;
>
> @@ -3475,11 +3477,11 @@ static const struct acpi_device_id acpi_nfit_ids[=
] =3D {
>  };
>  MODULE_DEVICE_TABLE(acpi, acpi_nfit_ids);
>
> -static struct acpi_driver acpi_nfit_driver =3D {
> -       .name =3D KBUILD_MODNAME,
> -       .ids =3D acpi_nfit_ids,
> -       .ops =3D {
> -               .add =3D acpi_nfit_add,
> +static struct platform_driver acpi_nfit_driver =3D {
> +       .probe =3D acpi_nfit_probe,
> +       .driver =3D {
> +               .name =3D KBUILD_MODNAME,
> +               .acpi_match_table =3D acpi_nfit_ids,
>         },
>  };
>
> @@ -3517,7 +3519,7 @@ static __init int nfit_init(void)
>                 return -ENOMEM;
>
>         nfit_mce_register();
> -       ret =3D acpi_bus_register_driver(&acpi_nfit_driver);
> +       ret =3D platform_driver_register(&acpi_nfit_driver);
>         if (ret) {
>                 nfit_mce_unregister();
>                 destroy_workqueue(nfit_wq);
> @@ -3530,7 +3532,7 @@ static __init int nfit_init(void)
>  static __exit void nfit_exit(void)
>  {
>         nfit_mce_unregister();
> -       acpi_bus_unregister_driver(&acpi_nfit_driver);
> +       platform_driver_unregister(&acpi_nfit_driver);
>         destroy_workqueue(nfit_wq);
>         WARN_ON(!list_empty(&acpi_descs));
>  }
> --

