Return-Path: <linux-acpi+bounces-9538-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9E99C6B71
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 10:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3321F221BD
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 09:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BD51F80A4;
	Wed, 13 Nov 2024 09:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boqwB/5M"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B501F77BE;
	Wed, 13 Nov 2024 09:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731490020; cv=none; b=mL1z9HoRO+cck2eNWYNNK1eSw2CHUetrwfoir1tCNncGsFlcZCFivj9ovofUqwIFoU4thKuN+mxZBSpuf23aiwwukE7P4IkonJYEihYHDfKhXbyvftvoYtswJ/QxmNLNAjaJ7nqRdhQHnTY+9EpG3o/0RlgbJx9irIufGXK0dI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731490020; c=relaxed/simple;
	bh=KKddwOlKp3xB82QPe3QDVHAfVga4HLYFJb8YTpyiYm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+vzuUk4ly5ohffYndXa02u17+//fMnFtYomuPcfmoyvDz/xBuPkDVeIL1Om/I0rL+nq+YozRZ790nUsYQx0Oyv2Y/UjSGFDlTKdfhXbzf/eL+UnPzGUVxefiqnj6kRS5TbvEqLi4cbcjUiY7NDrB6HscQFWYwbUf3C/qpAG/g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boqwB/5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A41C4CECD;
	Wed, 13 Nov 2024 09:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731490020;
	bh=KKddwOlKp3xB82QPe3QDVHAfVga4HLYFJb8YTpyiYm8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=boqwB/5MI6sZEvQGDmwGvAla6H21vSLrIChGCXQhJuJZgD8hsNJo8DGfmmMCvctNA
	 upTCDFw10/t77+VQZGSrlrP3d89tHhhNGRULhwhRX1OTNthQRKKO0mJG0t/roCI7QU
	 YY8S2BBmOsdkYjAnOa7INMPn100k0rMpX21ZrL7yVutGl2aNW+W/PEbPj7AfN9U60P
	 vF51xwBnEXbIF5t3HhDT8OzbreluIQi0Q/ga3xwlNQ2T6waLcvo+AygLb4NDf6YnuA
	 RnVpx4zh5cCdaT/+wqIuhzVc2xfw4+5W8zkXcFn26YSK93t8Na12+h9S0+u0kljLHI
	 V1mIzqnFY/tMw==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5edfe8c17c4so3153525eaf.2;
        Wed, 13 Nov 2024 01:27:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVa1p/FJ7dTVWVmeCFQfIdE+Q2DRgwitoxI6Vpe+YK7b05vnF41rkyy9Qlf7tCa5EXLxPwgLgmLTLO6@vger.kernel.org, AJvYcCXplyJ16Ldkg5d3t5J2L6NdV2fcOjJ1mOXpWmfMPjaf46tabjJOfdxYQ5Xssf07DoPFugaB8Do10KiaKb6n@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7gMoXZ/B/iaQ4LXK489XTw3gDxb2Zym9XZyt9l6xEuycII876
	YD3YBvwGjeYyr4CVnGhACJlozGWnzuAwENXuYN95ciD/lnI6ZNB5vrcgie9Gnudqbfr9PeMby3f
	W54gbo9U21OIchDgqhcN2l8KxVtk=
X-Google-Smtp-Source: AGHT+IHrGo4hQ/QNB5Ws8/fcwzpMem5cjfOKQFCWczhgXACZdzYPewYcQJ/b5zkFP/phZlZVHSJ8Dr6TMhEqrLb8/3E=
X-Received: by 2002:a05:6820:2018:b0:5e7:caf5:ae03 with SMTP id
 006d021491bc7-5ee57ba7a91mr13944610eaf.2.1731490019714; Wed, 13 Nov 2024
 01:26:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113085634.7657-1-lihuisong@huawei.com>
In-Reply-To: <20241113085634.7657-1-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 Nov 2024 10:26:48 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jTMg=Wipt2VPU1DDnnO7Rh5pu0VYvUjHRW5Nada--O8A@mail.gmail.com>
Message-ID: <CAJZ5v0jTMg=Wipt2VPU1DDnnO7Rh5pu0VYvUjHRW5Nada--O8A@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: thermal: Support for linking devices associated
 with the thermal zone
To: Huisong Li <lihuisong@huawei.com>
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, rafael@kernel.org, 
	linux-kernel@vger.kernel.org, rui.zhang@intel.com, liuyonglong@huawei.com, 
	zhanjie9@hisilicon.com, zhenglifeng1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 10:07=E2=80=AFAM Huisong Li <lihuisong@huawei.com> =
wrote:
>
> There are many 'cdevX' files which link cooling devices under
> '/sys/class/thermal/thermal_zoneX/'. These devices contain active cooling
> devices and passive cooling devices. And user cann't directly know which
> devices temperature is represented by the thermal zone.
>
> However, ACPI spec provides a '_TZD' object which evaluates to a package
> of device names. Each name corresponds to a device in the ACPI namespace
> that is associated with the thermal zone. The temperature reported by the
> thermal zone is roughly correspondent to that of each of the devices.
>
> User can get all devices a thermal zone measured by the 'measures'
> directory under the thermal zone device.

Well, that's kind of clear, but what exactly is the use case?  Why
does the user need to know that?

> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
> v2: fix commitlog based on Rafael's comment.
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
>

