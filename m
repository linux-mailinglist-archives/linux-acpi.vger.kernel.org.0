Return-Path: <linux-acpi+bounces-6465-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E0290B9E0
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 20:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B25D0B255DF
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 18:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581EF195381;
	Mon, 17 Jun 2024 18:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5nSwNa0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAB2DDD7;
	Mon, 17 Jun 2024 18:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718649472; cv=none; b=SfpN2rxUQMYvpNrnJhXgjXSOyEK6jUkzCidTLWEyzVkkQUsuIlED7MbFIPSDDWCz5icaApDi+Rv3Gn4lWxhCxDmBRRwBQQ12ybVBUL91eZa4pXtC5cZPZTmNl3nJH6QS8q9ZkP7JGbaS5maW2akRmVM9v6KAYgfhiamyrXXxwkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718649472; c=relaxed/simple;
	bh=C/2KHZtEZmz+3QjoKtzyIX0VvSO9irLLt76KmyjTSq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7u2UUVjo2rEL4HBMrdFScSBr/RHm55ucZUfp4WUtW9/dIb1UuH+GtnA1LlMaDKlrFMwFzpvAAY0rXJ9ELAx3+vSTiX9utGuJbJ1CqAkxppqiB9OEK6iBtIrF1dnmWNopblVqAxBZKQK6zjjO6LAwY/zdjrVzpCfVkvx2jbryAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5nSwNa0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48F1C4AF48;
	Mon, 17 Jun 2024 18:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718649471;
	bh=C/2KHZtEZmz+3QjoKtzyIX0VvSO9irLLt76KmyjTSq8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G5nSwNa0zFLtmhvU1hihth5QK4jKexlaU5l9UKdrNuEAbYv9Ed18QJ8x5O3nwg/02
	 kNHY/zapnZ5mogMiV0kkePWacKuukHOVMYifC+0XZ3O6CfzsQeU1ozWnxgaWGl7h7O
	 ePOoBz/7DkHKScIG4zrVfLtlqAEDlhlk8Pdw2J2BN+n7/MFjhEJ+oI5QajNGHoGFjT
	 H1tuC0oS3OhPZABsHPi8nWuYOOohxI0+6+LDvoFWJE27zyT13qchR3QJu16SeU1xKc
	 Dyfnj1H91CKWYaWv5TjqL2RjTmA/WL7B2YeLCkzN3cX3TpqqW73PM/7Ps5OpywnuUS
	 +dCQ0DxMMBCdQ==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5bad112b623so126683eaf.3;
        Mon, 17 Jun 2024 11:37:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+L/MZwmfbEc3o1XzYrRzzTw02DK6xRmMUn3UOdNM3MxwavNqIqbdB8eBjMLT6urzH5f9QPPFv0B04DQZOiWnFEBWYFlapEPiqgvaIqJYq05YJlk1hi7vDSM2QkJ8/9DkWSqIpRQvGbA==
X-Gm-Message-State: AOJu0YzMuM7qh3l4RYwvm3W5eRXjxt9/DhHRPz9X+QpUyPWQ1Lg4PIOO
	HV7vpNVRrybifItF+7DvqWFUzJIaLb5aAtJy/mCscFInKY29m8hL0V/EsRAxWh4BexUUMGkycMm
	BoXgVwcko7lE+KBSlN2qeWi14E38=
X-Google-Smtp-Source: AGHT+IHanRmRsVJGp3XkEoFCPGSrkSlTy0kWAMt6c5ldTqMfF38xdLHNudMu7yymW1y/ppCm5VMo1/d+N0kGvpMp2Pg=
X-Received: by 2002:a4a:e1da:0:b0:5ba:ead2:c742 with SMTP id
 006d021491bc7-5bdad9f0343mr11205636eaf.0.1718649470885; Mon, 17 Jun 2024
 11:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613-acpi-sysfs-groups-v1-0-665e0deb052a@weissschuh.net> <20240613-acpi-sysfs-groups-v1-1-665e0deb052a@weissschuh.net>
In-Reply-To: <20240613-acpi-sysfs-groups-v1-1-665e0deb052a@weissschuh.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 17 Jun 2024 20:37:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iHB1X7WM6Lg_-vr3Kzwp65yqjvHG9CA_X8vqFBFV_F_A@mail.gmail.com>
Message-ID: <CAJZ5v0iHB1X7WM6Lg_-vr3Kzwp65yqjvHG9CA_X8vqFBFV_F_A@mail.gmail.com>
Subject: Re: [PATCH 1/5] ACPI: sysfs: convert utf-16 from _STR to utf-8 only once
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 10:15=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weiss=
schuh.net> wrote:
>
> The ACPI _STR method returns an UTF-16 string that is converted to utf-8
> before printing it in sysfs.
> Currently this conversion is performed every time the "description"
> sysfs attribute is read, which is not necessary.

Why is it a problem, though?

How many devices have _STR and how much of the time is it used?

Hint: On the system I'm sitting in front of, the answer is 0 and never.

So Is it really worth adding an _STR string pointer to every struct acpi_de=
vice?

> Only perform the conversion once and cache the result.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>  drivers/acpi/device_sysfs.c | 63 ++++++++++++++++++++++++++++-----------=
------
>  include/acpi/acpi_bus.h     |  2 +-
>  2 files changed, 40 insertions(+), 25 deletions(-)

And it's more lines of code even.

>
> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> index 23373faa35ec..4bedbe8f57ed 100644
> --- a/drivers/acpi/device_sysfs.c
> +++ b/drivers/acpi/device_sysfs.c
> @@ -439,24 +439,11 @@ static ssize_t description_show(struct device *dev,
>                                 char *buf)
>  {
>         struct acpi_device *acpi_dev =3D to_acpi_device(dev);
> -       int result;
>
> -       if (acpi_dev->pnp.str_obj =3D=3D NULL)
> +       if (acpi_dev->pnp.str =3D=3D NULL)
>                 return 0;
>
> -       /*
> -        * The _STR object contains a Unicode identifier for a device.
> -        * We need to convert to utf-8 so it can be displayed.
> -        */
> -       result =3D utf16s_to_utf8s(
> -               (wchar_t *)acpi_dev->pnp.str_obj->buffer.pointer,
> -               acpi_dev->pnp.str_obj->buffer.length,
> -               UTF16_LITTLE_ENDIAN, buf,
> -               PAGE_SIZE - 1);
> -
> -       buf[result++] =3D '\n';
> -
> -       return result;
> +       return sysfs_emit("%s\n", acpi_dev->pnp.str);
>  }
>  static DEVICE_ATTR_RO(description);
>
> @@ -507,14 +494,46 @@ static ssize_t status_show(struct device *dev, stru=
ct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(status);
>
> +static const char *acpi_device_str(struct acpi_device *dev)
> +{
> +       struct acpi_buffer buffer =3D {ACPI_ALLOCATE_BUFFER, NULL};
> +       union acpi_object *str_obj;
> +       acpi_status status;
> +       const char *ret;
> +       char buf[512];
> +       int result;
> +
> +       if (!acpi_has_method(dev->handle, "_STR"))
> +               return NULL;
> +
> +       status =3D acpi_evaluate_object(dev->handle, "_STR",
> +                                     NULL, &buffer);
> +       if (ACPI_FAILURE(status))
> +               return NULL;
> +
> +       str_obj =3D buffer.pointer;
> +       /*
> +        * The _STR object contains a Unicode identifier for a device.
> +        * We need to convert to utf-8 so it can be displayed.
> +        */
> +       result =3D utf16s_to_utf8s((wchar_t *)str_obj->buffer.pointer,
> +                                str_obj->buffer.length,
> +                                UTF16_LITTLE_ENDIAN,
> +                                buf, sizeof(buf) - 1);
> +       buf[result++] =3D '\0';
> +
> +       ret =3D kstrdup(buf, GFP_KERNEL);
> +       kfree(buffer.pointer);
> +
> +       return ret;
> +}
> +
>  /**
>   * acpi_device_setup_files - Create sysfs attributes of an ACPI device.
>   * @dev: ACPI device object.
>   */
>  int acpi_device_setup_files(struct acpi_device *dev)
>  {
> -       struct acpi_buffer buffer =3D {ACPI_ALLOCATE_BUFFER, NULL};
> -       acpi_status status;
>         int result =3D 0;
>
>         /*
> @@ -539,12 +558,8 @@ int acpi_device_setup_files(struct acpi_device *dev)
>         /*
>          * If device has _STR, 'description' file is created
>          */
> -       if (acpi_has_method(dev->handle, "_STR")) {
> -               status =3D acpi_evaluate_object(dev->handle, "_STR",
> -                                       NULL, &buffer);
> -               if (ACPI_FAILURE(status))
> -                       buffer.pointer =3D NULL;
> -               dev->pnp.str_obj =3D buffer.pointer;
> +       dev->pnp.str =3D acpi_device_str(dev);
> +       if (dev->pnp.str) {
>                 result =3D device_create_file(&dev->dev, &dev_attr_descri=
ption);
>                 if (result)
>                         goto end;
> @@ -618,7 +633,7 @@ void acpi_device_remove_files(struct acpi_device *dev=
)
>          * If device has _STR, remove 'description' file
>          */
>         if (acpi_has_method(dev->handle, "_STR")) {
> -               kfree(dev->pnp.str_obj);
> +               kfree(dev->pnp.str);
>                 device_remove_file(&dev->dev, &dev_attr_description);
>         }
>         /*
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 1a4dfd7a1c4a..32e3105c9ece 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -254,7 +254,7 @@ struct acpi_device_pnp {
>         struct list_head ids;           /* _HID and _CIDs */
>         acpi_device_name device_name;   /* Driver-determined */
>         acpi_device_class device_class; /*        "          */
> -       union acpi_object *str_obj;     /* unicode string for _STR method=
 */
> +       const char *str;                /* _STR */
>  };
>
>  #define acpi_device_bid(d)     ((d)->pnp.bus_id)
>
> --
> 2.45.2
>
>

