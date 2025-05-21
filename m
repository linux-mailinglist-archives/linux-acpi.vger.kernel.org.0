Return-Path: <linux-acpi+bounces-13845-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206B0ABFDBB
	for <lists+linux-acpi@lfdr.de>; Wed, 21 May 2025 22:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61CB19E514A
	for <lists+linux-acpi@lfdr.de>; Wed, 21 May 2025 20:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF42E28A1C5;
	Wed, 21 May 2025 20:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0FpCaxK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961F6221713;
	Wed, 21 May 2025 20:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747858664; cv=none; b=L2lfRqHNo6Xj7WHWx1eMN0xf81Q84io8QYkq3OFyh+T4w17n0SUJ18mx84Xda6CO6HOi7sIRgZRskAPIgh9mOzjT7Z+qPKcyqIWNuJNWEouAlmd3rT4MofRd80HAKy3+QTiE4EjZ98NtMzFFUqVPv8xS62M7dPnMfy/ioRPdygE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747858664; c=relaxed/simple;
	bh=OcRrlj7xdaiC5clW99dAz86chXxQeFIdlShKpSfDJoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zn4hTwbE9PBmDh0FomrTMlf/JRyfShlBXdp5QFdcgylc9RMUYcpAZ56ikL4u+Se+FlkuZOAX8BqzoG0oSwsLS6urV8/2IUR5z5g82GnxfdtX5JFrqaElew14sIdTZEn69BeeeLpJ/TOYMw9N3WyzkUSeWd8mn3E/0Nz+H7Csq+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0FpCaxK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EC5C4CEE4;
	Wed, 21 May 2025 20:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747858664;
	bh=OcRrlj7xdaiC5clW99dAz86chXxQeFIdlShKpSfDJoU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f0FpCaxKfQZTRgXEWzIjCh/Ijb82lawhRKMczr3wkR93kyW8tin1ESpQ0nJ02jt0x
	 QWk6172yvTZ8Po57OBUMT2rIP8UXcnu0gEqmHvNa3Kz6OAHTNuDnZ/syNqAkFScNO4
	 noNWwUxLV0QoPXGBw2pRn42jcXI6reaOpG71me74DU0OpSVJerKLg9Ci/xYCLO0RoG
	 Ied4jf5r6LA+MjS4N9sL73zkboJjKf85ptFl/mPMlJV9OKXMFq+eUmF/+2Yq+0/PQ3
	 aGkn2CejABhgm0U0eXukwr9afPI37+bMGQtbIv4uYxqb27l3oTpm2WaSvKDYxD526F
	 i0I/DrztrXaHQ==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3fbaa18b810so2352900b6e.2;
        Wed, 21 May 2025 13:17:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1ZG5W9MhV6jo9CXDOwfrtnBnnyze8mpSSbN5Uj+3aSyUf0EoyqFARey313KXohcK8c2ne4Xz7SSfcriL+@vger.kernel.org, AJvYcCX/QjUj6Q6SaEGZPLLgdR6m4ut+TxkALvg5yMQ4MoY0wGinkvsMMAD3fDE0quJTDy136vUVUDL9q1Jc@vger.kernel.org
X-Gm-Message-State: AOJu0YyRR45YEnXQSGU9RGDXkQTvZ4ob89WAD7h3ziWR+Y3OMe5imOn1
	8IfrBFKn+gcMYoL/0BLWmYkAWlk+IUoUJjlXbfiLHPW+m7zLmQNCIZFb+cWl45Qj6Lgnz/JkdSN
	2KbKxwVuCz7socXa18MwyrS/l4YTOctE=
X-Google-Smtp-Source: AGHT+IEla/7OsBunWSBkZYFCsgl0DpTjBkEnFqnChnn85Xl5ZHXukeaimdJeqpTZUi6sozTY3Kg0ceoNvlrRQueeryk=
X-Received: by 2002:a05:6808:4447:b0:3f8:93c5:6d85 with SMTP id
 5614622812f47-404da760a09mr11955098b6e.16.1747858663283; Wed, 21 May 2025
 13:17:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250518185111.3560-1-W_Armin@gmx.de>
In-Reply-To: <20250518185111.3560-1-W_Armin@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 21 May 2025 22:17:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hNmMtR4V0tYqD1dV2BqAKJ2sCOyBadkVtG3sS3V90uvw@mail.gmail.com>
X-Gm-Features: AX0GCFsebpZ_dmCbnnO_Avxc4XYzYmOYwknKN0mNIyDBQyWOD5ECcbZax0_zh3U
Message-ID: <CAJZ5v0hNmMtR4V0tYqD1dV2BqAKJ2sCOyBadkVtG3sS3V90uvw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: platform_profile: Add support for non-ACPI platforms
To: Armin Wolf <W_Armin@gmx.de>
Cc: rafael@kernel.org, lenb@kernel.org, j@jannau.net, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 18, 2025 at 8:51=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Currently the platform profile subsystem assumes that all supported
> (i.e. ACPI-capable) platforms always run with ACPI being enabled.
> However some ARM64 notebooks do not support ACPI and are instead
> using devicetree for booting.
>
> Do not register the legacy sysfs interface on such devices as it
> depends on the acpi_kobj (/sys/firmware/acpi/) being present. Users
> are encouraged to use the new platform-profile class interface
> instead.

So how does it work in this case?

> Reviewed-by: Janne Grunau <j@jannau.net>
> Tested-by: Janne Grunau <j@jannau.net>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/acpi/platform_profile.c | 68 ++++++++++++++++++++++++++-------
>  1 file changed, 55 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_prof=
ile.c
> index ffbfd32f4cf1..c5a5da7d03f1 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -190,6 +190,20 @@ static ssize_t profile_show(struct device *dev,
>         return sysfs_emit(buf, "%s\n", profile_names[profile]);
>  }
>
> +/**
> + * profile_notify_legacy - Notify the legacy sysfs interface
> + *
> + * This wrapper takes care of only notifying the legacy sysfs interface
> + * if it was registered during module initialization.
> + */
> +static void profile_notify_legacy(void)
> +{
> +       if (!acpi_kobj)
> +               return;
> +
> +       sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +}
> +
>  /**
>   * profile_store - Set the profile for a class device
>   * @dev: The device
> @@ -215,7 +229,7 @@ static ssize_t profile_store(struct device *dev,
>                         return ret;
>         }
>
> -       sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +       profile_notify_legacy();
>
>         return count;
>  }
> @@ -435,7 +449,7 @@ static ssize_t platform_profile_store(struct kobject =
*kobj,
>                         return ret;
>         }
>
> -       sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +       profile_notify_legacy();
>
>         return count;
>  }
> @@ -472,6 +486,22 @@ static const struct attribute_group platform_profile=
_group =3D {
>         .is_visible =3D profile_class_is_visible,
>  };
>
> +/**
> + * profile_update_legacy - Update the legacy sysfs interface
> + *
> + * This wrapper takes care of only updating the legacy sysfs interface
> + * if it was registered during module initialization.
> + *
> + * Return: 0 on success or error code on failure.
> + */
> +static int profile_update_legacy(void)
> +{
> +       if (!acpi_kobj)
> +               return 0;
> +
> +       return sysfs_update_group(acpi_kobj, &platform_profile_group);
> +}
> +
>  /**
>   * platform_profile_notify - Notify class device and legacy sysfs interf=
ace
>   * @dev: The class device
> @@ -481,7 +511,7 @@ void platform_profile_notify(struct device *dev)
>         scoped_cond_guard(mutex_intr, return, &profile_lock) {
>                 _notify_class_profile(dev, NULL);
>         }
> -       sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +       profile_notify_legacy();
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_notify);
>
> @@ -529,7 +559,7 @@ int platform_profile_cycle(void)
>                         return err;
>         }
>
> -       sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +       profile_notify_legacy();
>
>         return 0;
>  }
> @@ -603,9 +633,9 @@ struct device *platform_profile_register(struct devic=
e *dev, const char *name,
>                 goto cleanup_ida;
>         }
>
> -       sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +       profile_notify_legacy();
>
> -       err =3D sysfs_update_group(acpi_kobj, &platform_profile_group);
> +       err =3D profile_update_legacy();
>         if (err)
>                 goto cleanup_cur;
>
> @@ -639,8 +669,8 @@ void platform_profile_remove(struct device *dev)
>         ida_free(&platform_profile_ida, pprof->minor);
>         device_unregister(&pprof->dev);
>
> -       sysfs_notify(acpi_kobj, NULL, "platform_profile");
> -       sysfs_update_group(acpi_kobj, &platform_profile_group);
> +       profile_notify_legacy();
> +       profile_update_legacy();
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_remove);
>
> @@ -692,16 +722,28 @@ static int __init platform_profile_init(void)
>         if (err)
>                 return err;
>
> -       err =3D sysfs_create_group(acpi_kobj, &platform_profile_group);
> -       if (err)
> -               class_unregister(&platform_profile_class);
> +       /*
> +        * The ACPI kobject can be missing if ACPI was disabled during bo=
oting.
> +        * We thus skip the initialization of the legacy sysfs interface =
in such
> +        * cases to allow the platform profile class to work on ARM64 not=
ebooks
> +        * without ACPI support.
> +        */
> +       if (acpi_kobj) {
> +               err =3D sysfs_create_group(acpi_kobj, &platform_profile_g=
roup);
> +               if (err < 0) {
> +                       class_unregister(&platform_profile_class);
> +                       return err;
> +               }
> +       }
>
> -       return err;
> +       return 0;
>  }
>
>  static void __exit platform_profile_exit(void)
>  {
> -       sysfs_remove_group(acpi_kobj, &platform_profile_group);
> +       if (acpi_kobj)
> +               sysfs_remove_group(acpi_kobj, &platform_profile_group);
> +
>         class_unregister(&platform_profile_class);
>  }
>  module_init(platform_profile_init);
> --
> 2.39.5
>
>

