Return-Path: <linux-acpi+bounces-18472-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0EDC2D98F
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 19:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B46A24E3698
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 18:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6BA2BE7C2;
	Mon,  3 Nov 2025 18:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSibrf8L"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3D2285CA4
	for <linux-acpi@vger.kernel.org>; Mon,  3 Nov 2025 18:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762193368; cv=none; b=MWiJl+v/Ae0WIOUwgr3Yi/abvklb/I91OlHaC2WfJZAsFyC6BTTpndzcg8svKW84unkfop4keQUHlFDkG8xg4zAx3i0tSrXwCs47HdGZaJMjxVO7xn9BTVMAP8mogcs5FEbwITHmnI97uj9rdfu1u817ULf3RRgNsxeiS7nkGv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762193368; c=relaxed/simple;
	bh=GIVep2mwCobXrapQXMsC8otlq3Mdat5Ya3mMg5dI0ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQPab6dkpnJkKEqOhDUzzKUuw810Ohhzm53uZ1Aa/22c9893CUN7dgKtPvncUN9j1JvcQ3WByiUfZ4swLMbqO5g6NokAlSATjd+iMqkiOmqg7WmcaOqLWM5QQmyL36j6quOITA9d6Z2JxGff1x9ukwKSQyohjjw8hdJcOF2+FB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSibrf8L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6CFC113D0
	for <linux-acpi@vger.kernel.org>; Mon,  3 Nov 2025 18:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762193367;
	bh=GIVep2mwCobXrapQXMsC8otlq3Mdat5Ya3mMg5dI0ug=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fSibrf8LiIh1UPYNJaZIy/YygOjQ2940i93GlOxIP9gMl8eVhtmGgNTxtQjuo2U9N
	 pX17/Y0NjCqda7m2kiWFWWu/CyKzRpx6zn+qD0h1fsN51tkfwtOcGzm3MR+i5I7+8u
	 wYWEOFpN0Mmvc/6I8MCqNX4ze9lklqBL2Om1nl7+a6M8l3VQ8gGCKd2A+rXNCDtXN+
	 BwRrDOX8tlyOq3egRgkOPHXDH0/jeIF8/w5nVkiNM406wTDnk8ZhMR718++WQVPi98
	 +36nmIcOLz7CnBOTMVH61swRmj2jlzNBmMKyPZv2m4E9Yt4CU/GQdgFJJrJtEZE0p+
	 HP00cHU3TD6sQ==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-65366485678so2443899eaf.2
        for <linux-acpi@vger.kernel.org>; Mon, 03 Nov 2025 10:09:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+mJ5ankT8bgQ3+YJSmAB3OK8NbrYbBqQ+MBAIo6/70qo9DWMUIXT4qi79f5Tr2E8NPE/QvUIdAKrU@vger.kernel.org
X-Gm-Message-State: AOJu0YzstRfRRGL7hDixIa82RkXMADz2Q/clIQ7TvmutAT/mr4OqUWVQ
	zwioF/CH+yAULmBmrGGSq2SrR69nKZgjQ+rFJlqGh6aciYEhRXiMKfbsEOakRp5X6VOnbHu179N
	KVwINd3V+ey+N8Fusr8ItR86wehgwyiE=
X-Google-Smtp-Source: AGHT+IG7x2rRrcA6QrLQTa5xWb0daH70NTjyInTXmFaxht1gFxQwSaFvkKLb5ZMaa0lEvSdnh4SnPhH3Mz/5+lVl5m4=
X-Received: by 2002:a4a:e912:0:b0:654:fc59:2240 with SMTP id
 006d021491bc7-6568a3eedabmr6067377eaf.1.1762193366901; Mon, 03 Nov 2025
 10:09:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103084244.2654432-1-lihuisong@huawei.com> <20251103084244.2654432-5-lihuisong@huawei.com>
In-Reply-To: <20251103084244.2654432-5-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 3 Nov 2025 19:09:14 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0idhxfOa8_Zp4Z_j5Rqh4GW4JsBpGT_hT=v=NgcEZRb+g@mail.gmail.com>
X-Gm-Features: AWmQ_bmi96oszDfQBk54Oo-EquHWI8AVZM3ogwB9ykleX4g_GY4wX8ncFBRI9TM
Message-ID: <CAJZ5v0idhxfOa8_Zp4Z_j5Rqh4GW4JsBpGT_hT=v=NgcEZRb+g@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] ACPI: processor: idle: Disable ACPI idle if get
 power information failed in power notify
To: Huisong Li <lihuisong@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 9:42=E2=80=AFAM Huisong Li <lihuisong@huawei.com> wr=
ote:
>
> The old states may not be usable any more if get power information
> failed in power notify. The ACPI idle should be disabled entirely.

How does it actually disable anything?  It only changes the
acpi_processor_power_state_has_changed() return value AFAICS, but that
return value isn't checked.

> Fixes: f427e5f1cf75 ("ACPI / processor: Get power info before updating th=
e C-states")

So how does it fix anything?

> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/acpi/processor_idle.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index c73df5933691..4627b00257e6 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1317,6 +1317,7 @@ int acpi_processor_power_state_has_changed(struct a=
cpi_processor *pr)
>         int cpu;
>         struct acpi_processor *_pr;
>         struct cpuidle_device *dev;
> +       int ret =3D 0;
>
>         if (disabled_by_idle_boot_param())
>                 return 0;
> @@ -1345,8 +1346,18 @@ int acpi_processor_power_state_has_changed(struct =
acpi_processor *pr)
>                         cpuidle_disable_device(dev);
>                 }
>
> -               /* Populate Updated C-state information */
> -               acpi_processor_get_power_info(pr);
> +               /*
> +                * Populate Updated C-state information
> +                * The same idle state is used for all CPUs, cpuidle of a=
ll CPUs
> +                * should be disabled.
> +                */
> +               ret =3D acpi_processor_get_power_info(pr);
> +               if (ret) {
> +                       pr_err("Get processor-%u power information failed=
, disable cpuidle of all CPUs\n",
> +                              pr->id);

pr_info() at most, preferably pr_debug() or maybe pr_info_once().

> +                       goto release_lock;

"unlock" would be a better name.

> +               }
> +
>                 acpi_processor_setup_cpuidle_states(pr);
>
>                 /* Enable all cpuidle devices */
> @@ -1354,18 +1365,19 @@ int acpi_processor_power_state_has_changed(struct=
 acpi_processor *pr)
>                         _pr =3D per_cpu(processors, cpu);
>                         if (!_pr || !_pr->flags.power_setup_done)
>                                 continue;
> -                       acpi_processor_get_power_info(_pr);
> -                       if (_pr->flags.power) {
> +                       ret =3D acpi_processor_get_power_info(_pr);

This does not need to be called if _pr->flags.power is unset.  Why are
you changing this?

> +                       if (!ret && _pr->flags.power) {
>                                 dev =3D per_cpu(acpi_cpuidle_device, cpu)=
;
>                                 acpi_processor_setup_cpuidle_dev(_pr, dev=
);
>                                 cpuidle_enable_device(dev);
>                         }

If it succeeds for the next CPU, the return value will be still 0, won't it=
?

>                 }
> +release_lock:
>                 cpuidle_resume_and_unlock();
>                 cpus_read_unlock();
>         }
>
> -       return 0;
> +       return ret;
>  }
>
>  void acpi_processor_register_idle_driver(void)
> --

