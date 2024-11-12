Return-Path: <linux-acpi+bounces-9510-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3BF9C62A2
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2024 21:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4DCF28512C
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2024 20:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0AB2194B7;
	Tue, 12 Nov 2024 20:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvzncJFj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91377200C93;
	Tue, 12 Nov 2024 20:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731443606; cv=none; b=SguhCkMTsUD0q59Nnp1wDf9Z0zPjHEd8gapz5m+wJiK+Yn1HNU2obTyPqZNNj1kMm9+LcsOK7ZmJrnDE+0e3fizOqUdR73Mr7KbDr2s5sTH8AVvev1cA0Xf4bRDZa8fhTTOc3iPAi+N2mcRi/gzvZnObBtnaMVQZmeofXf/DsDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731443606; c=relaxed/simple;
	bh=ePVpHpl1XNSYhQVsww4M327Po9d1ORxMToGVEKwK1a4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ju0fACA2WY2YNndVTnKJc1RfJbzmnnV3BzFpFOThoSht5ZcidyV7R4rHDHRfygbg/6Thowl9oBKjgGjNtvp5AKRp87CJa/tX/FZvqtYXDm6epiXZ1wrYqMwBLNGzjqje+U7moJwBSs3Ya9zvcKHovK+m7VlOjPCI/8eUNFEvQsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvzncJFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B85C4AF0C;
	Tue, 12 Nov 2024 20:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731443606;
	bh=ePVpHpl1XNSYhQVsww4M327Po9d1ORxMToGVEKwK1a4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KvzncJFjz8nhRVcUR/qPeygrYF9xLMzcsfpkJCUJw7pCkqXLvR5ed/MFDIWKCQ3kj
	 EQ0OqLx0KOker2UaDYQWuGkMV+UMywxpuMRo27kjI9gvIqsIraW5+q8LFpVVXffJqC
	 Qo1muqxvWJGLO0AKomt7jMa/YzBXKwa/AVdZW+6Gg4f0EhnRhzZnnQ3vS0GJPrjCtn
	 WpndPx9GGPaOhRwn1eUp+SaQr0mK3nnsgYfPhlWjH0EpuQgMSmvAnDgYtg0Wzc1SfZ
	 VSH4RJD/b7ZtZfpxVfvikYaeQus/0VxfLffUEzWSpEeFY7M37qeEmRuAm7hVPL0+s1
	 Z1jAIG1isYajw==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-295cee3a962so741461fac.3;
        Tue, 12 Nov 2024 12:33:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVuZLlWQNhfnVJjeyEOJoXNcsmXuNmn4UDSpIDRUhJqPZxaffIx8sTTwfw+RAux5SS9Nu0R6Xgd03G5D8fI@vger.kernel.org, AJvYcCX9kZIsZH+D1SPyxmB7/GXw/wFL0vSL+krLNqnuV9TW0+ojHw53/p53mAmaHdt/xGhhAjAndXBIk7mc@vger.kernel.org
X-Gm-Message-State: AOJu0YwIzLHrBYmU5vfy+J7HZyuOjJYASznvTOB9B/78U2rvYmAATFSm
	rtxK3fbt90ejP4PpCiliGdBvgwRACSuWa1sgTnYaQCJYK/SdE+hqGeNHLBkykywrVLcDSx9ZpDn
	btBZRq/Xwgaf5nIle573XuV5NpqE=
X-Google-Smtp-Source: AGHT+IEvad7GNsHvNH4EgnJGxG5bZY0hg2LcCYHaoHTDGRrbifm5ciEPrlFMuSpoUuxLH9SQTE9jMoDJtN+ffWM83zA=
X-Received: by 2002:a05:6870:5e53:b0:277:e6f6:b383 with SMTP id
 586e51a60fabf-295600ee2c1mr17788771fac.24.1731443605460; Tue, 12 Nov 2024
 12:33:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112020327.17781-1-lihuisong@huawei.com>
In-Reply-To: <20241112020327.17781-1-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Nov 2024 21:33:14 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gH2rEj1ARkg7thOs7FcP3wP_Vr4P+tVvmy2pnYn1jDWA@mail.gmail.com>
Message-ID: <CAJZ5v0gH2rEj1ARkg7thOs7FcP3wP_Vr4P+tVvmy2pnYn1jDWA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: thermal: Support for linking devices associated
 with the thermal zone
To: Huisong Li <lihuisong@huawei.com>
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, rafael@kernel.org, 
	linux-kernel@vger.kernel.org, rui.zhang@intel.com, liuyonglong@huawei.com, 
	zhanjie9@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 3:14=E2=80=AFAM Huisong Li <lihuisong@huawei.com> w=
rote:
>
> As ACPI spec said, '_TZD' evaluates to a package of device names.
> Each name corresponds to a device in the ACPI namespace that is
> associated with the thermal zone. The temperature reported by the
> thermal zone is roughly correspondent to that of each of the devices.
>
> Signed-off-by: Huisong Li <lihuisong@huawei.com>

You need to say in the changelog why exposing this information is
needed and how it is going to be used by its consumers.

Thanks!

> ---
>  drivers/acpi/thermal.c | 114 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 113 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 78db38c7076e..398195a5d42f 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -119,6 +119,9 @@ struct acpi_thermal {
>         struct work_struct thermal_check_work;
>         struct mutex thermal_check_lock;
>         refcount_t thermal_check_count;
> +       int num_domain_devices;
> +       struct acpi_device **domain_devices;
> +       struct kobject *holders_dir;
>  };
>
>  /* ---------------------------------------------------------------------=
-----
> @@ -589,6 +592,103 @@ static const struct thermal_zone_device_ops acpi_th=
ermal_zone_ops =3D {
>         .critical =3D acpi_thermal_zone_device_critical,
>  };
>
> +static void acpi_thermal_remove_domain_devices(struct acpi_thermal *tz)
> +{
> +       int i;
> +
> +       if (!tz->num_domain_devices)
> +               return;
> +
> +       for (i =3D 0; i < tz->num_domain_devices; i++) {
> +               struct acpi_device *obj =3D tz->domain_devices[i];
> +
> +               if (!obj)
> +                       continue;
> +
> +               sysfs_remove_link(tz->holders_dir,
> +                                 kobject_name(&obj->dev.kobj));
> +               acpi_dev_put(obj);
> +       }
> +
> +       kfree(tz->domain_devices);
> +       kobject_put(tz->holders_dir);
> +       tz->num_domain_devices =3D 0;
> +}
> +
> +static int acpi_thermal_read_domain_devices(struct acpi_thermal *tz)
> +{
> +       struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +       union acpi_object *pss;
> +       acpi_status status;
> +       int ret =3D 0;
> +       int i;
> +
> +       status =3D acpi_evaluate_object(tz->device->handle, "_TZD", NULL,
> +                                     &buffer);
> +       if (ACPI_FAILURE(status)) {
> +               acpi_evaluation_failure_warn(tz->device->handle, "_TZD",
> +                                            status);
> +               return -ENODEV;
> +       }
> +
> +       pss =3D buffer.pointer;
> +       if (!pss ||
> +           pss->type !=3D ACPI_TYPE_PACKAGE) {
> +               dev_err(&tz->device->dev, "Thermal zone invalid _TZD data=
\n");
> +               ret =3D -EFAULT;
> +               goto end;
> +       }
> +
> +       if (!pss->package.count)
> +               goto end;
> +
> +       tz->domain_devices =3D kcalloc(pss->package.count,
> +                                    sizeof(struct acpi_device *), GFP_KE=
RNEL);
> +       if (!tz->domain_devices) {
> +               ret =3D -ENOMEM;
> +               goto end;
> +       }
> +
> +       tz->holders_dir =3D kobject_create_and_add("measures",
> +                                                &tz->device->dev.kobj);
> +       if (!tz->holders_dir) {
> +               ret =3D -ENOMEM;
> +               goto exit_free;
> +       }
> +
> +       tz->num_domain_devices =3D pss->package.count;
> +       for (i =3D 0; i < pss->package.count; i++) {
> +               struct acpi_device *obj;
> +               union acpi_object *element =3D &pss->package.elements[i];
> +
> +               /* Refuse non-references */
> +               if (element->type !=3D ACPI_TYPE_LOCAL_REFERENCE)
> +                       continue;
> +
> +               /* Create a symlink to domain objects */
> +               obj =3D acpi_get_acpi_dev(element->reference.handle);
> +               tz->domain_devices[i] =3D obj;
> +               if (!obj)
> +                       continue;
> +
> +               ret =3D sysfs_create_link(tz->holders_dir, &obj->dev.kobj=
,
> +                                       kobject_name(&obj->dev.kobj));
> +               if (ret) {
> +                       acpi_dev_put(obj);
> +                       tz->domain_devices[i] =3D NULL;
> +               }
> +       }
> +
> +       ret =3D 0;
> +       goto end;
> +
> +exit_free:
> +       kfree(tz->domain_devices);
> +end:
> +       kfree(buffer.pointer);
> +       return ret;
> +}
> +
>  static int acpi_thermal_zone_sysfs_add(struct acpi_thermal *tz)
>  {
>         struct device *tzdev =3D thermal_zone_device(tz->thermal_zone);
> @@ -602,8 +702,19 @@ static int acpi_thermal_zone_sysfs_add(struct acpi_t=
hermal *tz)
>         ret =3D sysfs_create_link(&tzdev->kobj,
>                                    &tz->device->dev.kobj, "device");
>         if (ret)
> -               sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
> +               goto remove_thermal_zone;
>
> +       /* _TZD method is optional. */
> +       ret =3D acpi_thermal_read_domain_devices(tz);
> +       if (ret !=3D -ENODEV)
> +               goto remove_device;
> +
> +       return 0;
> +
> +remove_device:
> +       sysfs_remove_link(&tz->device->dev.kobj, "device");
> +remove_thermal_zone:
> +       sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
>         return ret;
>  }
>
> @@ -611,6 +722,7 @@ static void acpi_thermal_zone_sysfs_remove(struct acp=
i_thermal *tz)
>  {
>         struct device *tzdev =3D thermal_zone_device(tz->thermal_zone);
>
> +       acpi_thermal_remove_domain_devices(tz);
>         sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
>         sysfs_remove_link(&tzdev->kobj, "device");
>  }
> --
> 2.22.0
>

