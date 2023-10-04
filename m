Return-Path: <linux-acpi+bounces-429-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7317B8E25
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 22:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 28A9F281818
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 20:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EFD224EF
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 20:36:59 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78742137E
	for <linux-acpi@vger.kernel.org>; Wed,  4 Oct 2023 19:09:31 +0000 (UTC)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B14898;
	Wed,  4 Oct 2023 12:09:30 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-57c0775d4fcso28363eaf.0;
        Wed, 04 Oct 2023 12:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696446569; x=1697051369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIRRcUEkY2QwDUo2YxYjdPZlFGlVEIduNYlZzLi872Y=;
        b=aTt6MaNwRZ5Z9Chrk7xdu5VHwzcjJa6gRVUnOB51GGNGB+fCvDikkSzPG/SGb7iW0a
         bYvHAdd5/tTPRPBwGYae/aow+o/GblOvAD7/GZpsJW1Ow9C23HOMWTP4KZeGMyiQdBSj
         JyNL4+SOl8d2DP1iyLTupzNK1ik0jKGJJbEQL8aYJaDDZ1PIiSvDS4g6HTtQFi1JyvXo
         BZDCOc/mQHe2B4+KWpsSDJ1p3GMkbT/bsR7b3LKkrLEGbD5FbotEbpKlnHvENHWBGu9+
         r4XjUhlSLrdJe2hHgOjRFDxOTLfbrPq+ChfbQDDqBwXRT7i/SyZShcq4Zdes81g/r2Ac
         dRdA==
X-Gm-Message-State: AOJu0YxGC4wCP9VIUGpXXzDjGcWeWv8pN75Fc3m5EjjglEZwKcQxFoDf
	jr9Ad+aC21gYfSo8FY/z+eHUzk3o22lq4aCmWV4=
X-Google-Smtp-Source: AGHT+IEoiOp7mEVinpVKZsIBFCfod83bd7/eQFof7tFvi/KF10mIwMRAx6EP0sSZomQ/E9+6rGDV6xxCflMP4uLidoI=
X-Received: by 2002:a4a:d097:0:b0:57b:7e31:c12 with SMTP id
 i23-20020a4ad097000000b0057b7e310c12mr3211586oor.1.1696446569455; Wed, 04 Oct
 2023 12:09:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925144842.586829-1-michal.wilczynski@intel.com> <20230925144842.586829-2-michal.wilczynski@intel.com>
In-Reply-To: <20230925144842.586829-2-michal.wilczynski@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 4 Oct 2023 21:09:18 +0200
Message-ID: <CAJZ5v0jyjH48XZ6vytncodYhsS6ODYg2yaZBPfRWb_qm99FMuA@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] ACPI: bus: Make notify wrappers more generic
To: Michal Wilczynski <michal.wilczynski@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, rafael.j.wysocki@intel.com, 
	andriy.shevchenko@intel.com, lenb@kernel.org, dan.j.williams@intel.com, 
	vishal.l.verma@intel.com, ira.weiny@intel.com, rui.zhang@intel.com, 
	Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 25, 2023 at 6:31=E2=80=AFPM Michal Wilczynski
<michal.wilczynski@intel.com> wrote:
>
> acpi_dev_install_notify_handler() and acpi_dev_remove_notify_handler()
> are wrappers around ACPICA installers. They are meant to save some
> duplicated code from drivers. However as we're moving towards drivers
> operating on platform_device they become a bit inconvenient to use as
> inside the driver code we mostly want to use driver data of platform
> device instead of ACPI device.

That's fair enough, but ->

> Make notify handlers installer wrappers more generic, while still
> saving some code that would be duplicated otherwise.
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> ---
>
> Notes:
>     So one solution could be to just replace acpi_device with
>     platform_device as an argument in those functions. However I don't
>     believe this is a correct solution, as it is very often the case that
>     drivers declare their own private structures which gets allocated dur=
ing
>     the .probe() callback, and become the heart of the driver. When drive=
rs
>     do that it makes much more sense to just pass the private structure
>     to the notify handler instead of forcing user to dance with the
>     platform_device or acpi_device.
>
>  drivers/acpi/ac.c         |  6 +++---
>  drivers/acpi/acpi_video.c |  6 +++---
>  drivers/acpi/battery.c    |  6 +++---
>  drivers/acpi/bus.c        | 14 ++++++--------
>  drivers/acpi/hed.c        |  6 +++---
>  drivers/acpi/nfit/core.c  |  6 +++---
>  drivers/acpi/thermal.c    |  6 +++---
>  include/acpi/acpi_bus.h   |  9 ++++-----
>  8 files changed, 28 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> index 225dc6818751..0b245f9f7ec8 100644
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -256,8 +256,8 @@ static int acpi_ac_add(struct acpi_device *device)
>         ac->battery_nb.notifier_call =3D acpi_ac_battery_notify;
>         register_acpi_notifier(&ac->battery_nb);
>
> -       result =3D acpi_dev_install_notify_handler(device, ACPI_ALL_NOTIF=
Y,
> -                                                acpi_ac_notify);
> +       result =3D acpi_dev_install_notify_handler(device->handle, ACPI_A=
LL_NOTIFY,
> +                                                acpi_ac_notify, device);
>         if (result)
>                 goto err_unregister;
>
> @@ -306,7 +306,7 @@ static void acpi_ac_remove(struct acpi_device *device=
)
>
>         ac =3D acpi_driver_data(device);
>
> -       acpi_dev_remove_notify_handler(device, ACPI_ALL_NOTIFY,
> +       acpi_dev_remove_notify_handler(device->handle, ACPI_ALL_NOTIFY,
>                                        acpi_ac_notify);
>         power_supply_unregister(ac->charger);
>         unregister_acpi_notifier(&ac->battery_nb);
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 948e31f7ce6e..025c17890127 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -2059,8 +2059,8 @@ static int acpi_video_bus_add(struct acpi_device *d=
evice)
>
>         acpi_video_bus_add_notify_handler(video);
>
> -       error =3D acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOT=
IFY,
> -                                               acpi_video_bus_notify);
> +       error =3D acpi_dev_install_notify_handler(device->handle, ACPI_DE=
VICE_NOTIFY,
> +                                               acpi_video_bus_notify, de=
vice);
>         if (error)
>                 goto err_remove;
>
> @@ -2092,7 +2092,7 @@ static void acpi_video_bus_remove(struct acpi_devic=
e *device)
>
>         video =3D acpi_driver_data(device);
>
> -       acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
> +       acpi_dev_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY=
,
>                                        acpi_video_bus_notify);
>
>         mutex_lock(&video_list_lock);
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 969bf81e8d54..45dae32a8646 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -1213,8 +1213,8 @@ static int acpi_battery_add(struct acpi_device *dev=
ice)
>
>         device_init_wakeup(&device->dev, 1);
>
> -       result =3D acpi_dev_install_notify_handler(device, ACPI_ALL_NOTIF=
Y,
> -                                                acpi_battery_notify);
> +       result =3D acpi_dev_install_notify_handler(device->handle, ACPI_A=
LL_NOTIFY,
> +                                                acpi_battery_notify, dev=
ice);
>         if (result)
>                 goto fail_pm;
>
> @@ -1241,7 +1241,7 @@ static void acpi_battery_remove(struct acpi_device =
*device)
>
>         battery =3D acpi_driver_data(device);
>
> -       acpi_dev_remove_notify_handler(device, ACPI_ALL_NOTIFY,
> +       acpi_dev_remove_notify_handler(device->handle, ACPI_ALL_NOTIFY,
>                                        acpi_battery_notify);
>
>         device_init_wakeup(&device->dev, 0);
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index f41dda2d3493..479fe888d629 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -554,14 +554,13 @@ static void acpi_device_remove_notify_handler(struc=
t acpi_device *device,
>         acpi_os_wait_events_complete();
>  }
>
> -int acpi_dev_install_notify_handler(struct acpi_device *adev,
> -                                   u32 handler_type,
> -                                   acpi_notify_handler handler)
> +int acpi_dev_install_notify_handler(acpi_handle handle, u32 handler_type=
,
> +                                   acpi_notify_handler handler, void *co=
ntext)
>  {
>         acpi_status status;
>
> -       status =3D acpi_install_notify_handler(adev->handle, handler_type=
,
> -                                            handler, adev);
> +       status =3D acpi_install_notify_handler(handle, handler_type,
> +                                            handler, context);

The wrapper now takes exactly the same arguments as the wrapped
function, so what exactly is the point of having it?  The return value
type?

>         if (ACPI_FAILURE(status))
>                 return -ENODEV;
>
> @@ -569,11 +568,10 @@ int acpi_dev_install_notify_handler(struct acpi_dev=
ice *adev,
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_install_notify_handler);
>
> -void acpi_dev_remove_notify_handler(struct acpi_device *adev,
> -                                   u32 handler_type,
> +void acpi_dev_remove_notify_handler(acpi_handle handle, u32 handler_type=
,
>                                     acpi_notify_handler handler)
>  {
> -       acpi_remove_notify_handler(adev->handle, handler_type, handler);
> +       acpi_remove_notify_handler(handle, handler_type, handler);
>         acpi_os_wait_events_complete();

Here at least there is the extra workqueues synchronization point.

That said, why exactly is it better to use acpi_handle instead of a
struct acpi_device pointer?

Realistically, in a platform driver you'll need the latter to obtain
the former anyway.

