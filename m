Return-Path: <linux-acpi+bounces-14949-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D70AF6044
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 19:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B9748799A
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 17:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F3A2F2C70;
	Wed,  2 Jul 2025 17:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOKSpZ3O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1792F5095;
	Wed,  2 Jul 2025 17:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751478185; cv=none; b=VmqdfYIkV2EtWHN4u2nUJ16QejoHTQZEqFdxOv8M/yRsN/qxUKZi/IGo2nIyFxkKzQ1SkfxBS8iTZwtbKW1ddXHpbm0EpN++WrBh7LjWoe1MYOaAk1MOYdHfR6GLguN8mJhKIUHY8K718gYqbmXctGAhRJeL6LI4kRODW05UXJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751478185; c=relaxed/simple;
	bh=xNYIt4k65OmORX5MazjpnJhAOzApzm5yJpTWGaszrSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nii9UT6IRTh92GBDutmaT4UK9dJg3FfwWfDMwojVGLmdQVF3cC2AVsiWLw14GaqnTu3UK6O7tNpvpbLW2DZhQEUBt98sMOemMyhI6kfqEuyLDM72x4/Y37POgyWU0n5lTgKFjgIoL0Woh8kDKHdtVHfuq8h8TORO7LdsrqcIrSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOKSpZ3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649DCC4CEEE;
	Wed,  2 Jul 2025 17:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751478185;
	bh=xNYIt4k65OmORX5MazjpnJhAOzApzm5yJpTWGaszrSE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EOKSpZ3O9oABL54flR1MFwT1f16U8EQ9I/SWGCKw7P4NUCzlQvr+h3rLxfOFZyhyG
	 mAHSE0mQEA53l5H6GYOpyjPCV5LpX1mQhKOAaY/RyJnFOZ1A9sXLO95i1gVvB3Ek5e
	 5UlIK3mrv8TatvkASfYQmXHocjY2Ae9JfUD3Fnve1DCSS192GZ1dmxkJFo0s1Da589
	 6YtdJqWoQQRkvTU4hHVK77+3fTPzVDSEmdm9AKvUjcwXQguvNnbkdRWeKucRKquyK9
	 0LVwZBMvaghSU5f1lKGS0ZpfSGL0i8VpkFPLsz/rh9Jl8ZCp7xOhDfDtRKQxhgDxYd
	 M5VpgsGWOv/jA==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-40a7322f081so1157341b6e.3;
        Wed, 02 Jul 2025 10:43:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUtDELatjLOVLBzKOBooOH2DMGe/cf+kMx+90TtGSL6y/eOpf8YUxloWhI8wWMQizkGu1dBP1XaG2ivXxR9@vger.kernel.org, AJvYcCXvkzuNCuVJ7++sHlNKVYaEJNrw+l5bo/Te8Rxs50UI611+Mq8cGJsSu+bg/6/UyPkBCN7Wox5l+Fve@vger.kernel.org
X-Gm-Message-State: AOJu0YyXnuWhIBaUOiOLPLlG/u5YlNbHSXDA8MYLS+ga3csljgbMk64P
	iale6iOzTbqh9PN/96rnvkk5qJf6eMEtb1S+xEu77fbADv9PPirrZLs6VN71E30EmEEtjkdYyzu
	OmbKhU7i63ZjRVoucHKDqzE+RCXm5iQg=
X-Google-Smtp-Source: AGHT+IEYCjBLhv2IUPANINTVTYjL55B/pUxgMmy1PvSz15J7I/HowCWNOeStKEhd+OQXqsaj1g68bg6L+mpPYvTLxXw=
X-Received: by 2002:a05:6808:2508:b0:40b:9361:cd69 with SMTP id
 5614622812f47-40bf1452004mr211860b6e.15.1751478184712; Wed, 02 Jul 2025
 10:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619061327.1674384-1-lihuisong@huawei.com>
In-Reply-To: <20250619061327.1674384-1-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Jul 2025 19:42:53 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gjkZ3a-BwgJxjUJbNwu5E_j9VUUHrR3M=a+KPTA-tZcA@mail.gmail.com>
X-Gm-Features: Ac12FXxDnQyb4BepgKbaRCENdhqrDbMrc_WtjqAhuPlAfuZGemsdzs68jKKr8ko
Message-ID: <CAJZ5v0gjkZ3a-BwgJxjUJbNwu5E_j9VUUHrR3M=a+KPTA-tZcA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor: idle: Fix resource rollback in acpi_processor_power_init
To: Huisong Li <lihuisong@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com, liuyonglong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 8:13=E2=80=AFAM Huisong Li <lihuisong@huawei.com> w=
rote:
>
> There are two resource rollback issues in acpi_processor_power_init:
> 1> Do not unregister acpi_idle_driver when do kzalloc failed.
> 2> Do not free cpuidle device memory when register cpuidle device failed.
>
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/acpi/processor_idle.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index 2c2dc559e0f8..3548ab9dac9e 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1392,8 +1392,10 @@ int acpi_processor_power_init(struct acpi_processo=
r *pr)
>                 }
>
>                 dev =3D kzalloc(sizeof(*dev), GFP_KERNEL);
> -               if (!dev)
> -                       return -ENOMEM;
> +               if (!dev) {
> +                       retval =3D -ENOMEM;
> +                       goto unregister_driver;

No, unregistering the driver here is pointless.

> +               }
>                 per_cpu(acpi_cpuidle_device, pr->id) =3D dev;
>
>                 acpi_processor_setup_cpuidle_dev(pr, dev);
> @@ -1402,14 +1404,22 @@ int acpi_processor_power_init(struct acpi_process=
or *pr)
>                  * must already be registered before registering device
>                  */
>                 retval =3D cpuidle_register_device(dev);
> -               if (retval) {
> -                       if (acpi_processor_registered =3D=3D 0)
> -                               cpuidle_unregister_driver(&acpi_idle_driv=
er);

Pretty much the same as here.

It would be good to clean up dev here though.

> -                       return retval;
> -               }
> +               if (retval)
> +                       goto free_cpuidle_device;
> +
>                 acpi_processor_registered++;
>         }
>         return 0;
> +
> +free_cpuidle_device:
> +       per_cpu(acpi_cpuidle_device, pr->id) =3D NULL;
> +       kfree(dev);
> +
> +unregister_driver:
> +       if (acpi_processor_registered =3D=3D 0)
> +               cpuidle_unregister_driver(&acpi_idle_driver);
> +
> +       return retval;
>  }
>
>  int acpi_processor_power_exit(struct acpi_processor *pr)
> --
> 2.33.0
>

