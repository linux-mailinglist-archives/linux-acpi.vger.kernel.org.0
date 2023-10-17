Return-Path: <linux-acpi+bounces-693-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BD67CC5F5
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Oct 2023 16:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6BF281994
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Oct 2023 14:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F7743AB5
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Oct 2023 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C02436AD
	for <linux-acpi@vger.kernel.org>; Tue, 17 Oct 2023 13:47:25 +0000 (UTC)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA605F0;
	Tue, 17 Oct 2023 06:47:23 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-57be74614c0so240214eaf.1;
        Tue, 17 Oct 2023 06:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697550443; x=1698155243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TEEvUysii4uahaQ0m8FHMZlpWtYsFuaPhm1RtmqNb/I=;
        b=njPsdmpGfWXGcarrFKmjf4vgT3o3T0+e/JFVCU+MzlV5A0encZ8pj1/FM+T1oc0IGz
         pezzX/0YWIP8mNmOQnavRFhv5JCRaASaM8E4QRHqvJjnxb633+4+EkJ4Dnu+hwFJlJ+a
         jFGvWsFOOWPA+RfaoZGluCLWzL1oop++4vH+bHZRgMdA3eZx40kURYfEnFSra/oXr70B
         sYfddeqQq1RXxfFqziDTcjUpQlsOW07pxoe3+AFuRWw+nGKHiVBGyzf/XNAZNpQckCpe
         dDtgQm6N8RMmzDRJlH5nEtogV1G6sFw98ZkBQZkLiV8bsaTggx4fqIGH3cbhw60mHMrJ
         b2BQ==
X-Gm-Message-State: AOJu0YwmZiQYXoYrx3udlzL0NXYgteBsbLOJvj+iBHtdly/AULW3VMZ6
	gQCK4sHEkEnS3gLQNa06lRPPHFleKQ9H2fhAiiM=
X-Google-Smtp-Source: AGHT+IHvC9t7RwmoWiCH+fc45p2WvfI4yDWp6+zzWG0l3byPuExgnl0gPyDSD5VjVF615t/FRF8ap94jk1WhzAYvt00=
X-Received: by 2002:a4a:d898:0:b0:581:84e9:a7ad with SMTP id
 b24-20020a4ad898000000b0058184e9a7admr2203536oov.1.1697550443146; Tue, 17 Oct
 2023 06:47:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231011083334.3987477-1-michal.wilczynski@intel.com> <20231011083334.3987477-5-michal.wilczynski@intel.com>
In-Reply-To: <20231011083334.3987477-5-michal.wilczynski@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 17 Oct 2023 15:47:12 +0200
Message-ID: <CAJZ5v0gD-wjDVO_YRZRjn99y-UOTg5i4=2iVNzLgOfYF4bqJvA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] ACPI: AC: Rename ACPI device from device to adev
To: Michal Wilczynski <michal.wilczynski@intel.com>
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org, dan.j.williams@intel.com, 
	vishal.l.verma@intel.com, lenb@kernel.org, dave.jiang@intel.com, 
	ira.weiny@intel.com, rui.zhang@intel.com, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 10:34=E2=80=AFAM Michal Wilczynski
<michal.wilczynski@intel.com> wrote:
>
> Since transformation from ACPI driver to platform driver there are two
> devices on which the driver operates - ACPI device and platform device.
> For the sake of reader this calls for the distinction in their naming,
> to avoid confusion. Rename device to adev, as corresponding
> platform device is called pdev.
>
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> ---
>  drivers/acpi/ac.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> index 1dd4919be7ac..2618a7ccc11c 100644
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -121,11 +121,11 @@ static void acpi_ac_notify(acpi_handle handle, u32 =
event, void *data)
>  {
>         struct device *dev =3D data;
>         struct acpi_ac *ac =3D dev_get_drvdata(dev);
> -       struct acpi_device *device =3D ACPI_COMPANION(dev);
> +       struct acpi_device *adev =3D ACPI_COMPANION(dev);
>
>         switch (event) {
>         default:
> -               acpi_handle_debug(device->handle, "Unsupported event [0x%=
x]\n",
> +               acpi_handle_debug(adev->handle, "Unsupported event [0x%x]=
\n",
>                                   event);
>                 fallthrough;
>         case ACPI_AC_NOTIFY_STATUS:
> @@ -142,11 +142,11 @@ static void acpi_ac_notify(acpi_handle handle, u32 =
event, void *data)
>                         msleep(ac_sleep_before_get_state_ms);
>
>                 acpi_ac_get_state(ac);
> -               acpi_bus_generate_netlink_event(device->pnp.device_class,
> +               acpi_bus_generate_netlink_event(adev->pnp.device_class,
>                                                 dev_name(dev),
>                                                 event,
>                                                 ac->state);
> -               acpi_notifier_call_chain(device, event, ac->state);
> +               acpi_notifier_call_chain(adev, event, ac->state);
>                 kobject_uevent(&ac->charger->dev.kobj, KOBJ_CHANGE);
>         }
>  }
> @@ -205,7 +205,7 @@ static const struct dmi_system_id ac_dmi_table[]  __i=
nitconst =3D {
>
>  static int acpi_ac_probe(struct platform_device *pdev)
>  {
> -       struct acpi_device *device =3D ACPI_COMPANION(&pdev->dev);
> +       struct acpi_device *adev =3D ACPI_COMPANION(&pdev->dev);
>         struct power_supply_config psy_cfg =3D {};
>         struct acpi_ac *ac;
>         int result;
> @@ -214,9 +214,9 @@ static int acpi_ac_probe(struct platform_device *pdev=
)
>         if (!ac)
>                 return -ENOMEM;
>
> -       ac->device =3D device;
> -       strcpy(acpi_device_name(device), ACPI_AC_DEVICE_NAME);
> -       strcpy(acpi_device_class(device), ACPI_AC_CLASS);
> +       ac->device =3D adev;
> +       strcpy(acpi_device_name(adev), ACPI_AC_DEVICE_NAME);
> +       strcpy(acpi_device_class(adev), ACPI_AC_CLASS);
>
>         platform_set_drvdata(pdev, ac);
>
> @@ -226,7 +226,7 @@ static int acpi_ac_probe(struct platform_device *pdev=
)
>
>         psy_cfg.drv_data =3D ac;
>
> -       ac->charger_desc.name =3D acpi_device_bid(device);
> +       ac->charger_desc.name =3D acpi_device_bid(adev);
>         ac->charger_desc.type =3D POWER_SUPPLY_TYPE_MAINS;
>         ac->charger_desc.properties =3D ac_props;
>         ac->charger_desc.num_properties =3D ARRAY_SIZE(ac_props);
> @@ -238,13 +238,13 @@ static int acpi_ac_probe(struct platform_device *pd=
ev)
>                 goto err_release_ac;
>         }
>
> -       pr_info("%s [%s] (%s-line)\n", acpi_device_name(device),
> -               acpi_device_bid(device), str_on_off(ac->state));
> +       pr_info("%s [%s] (%s-line)\n", acpi_device_name(adev),
> +               acpi_device_bid(adev), str_on_off(ac->state));
>
>         ac->battery_nb.notifier_call =3D acpi_ac_battery_notify;
>         register_acpi_notifier(&ac->battery_nb);
>
> -       result =3D acpi_dev_install_notify_handler(device, ACPI_ALL_NOTIF=
Y,
> +       result =3D acpi_dev_install_notify_handler(adev, ACPI_ALL_NOTIFY,
>                                                  acpi_ac_notify, &pdev->d=
ev);
>         if (result)
>                 goto err_unregister;
> --

Rebased on top of current linux-next and applied as 6.7 material, thanks!

