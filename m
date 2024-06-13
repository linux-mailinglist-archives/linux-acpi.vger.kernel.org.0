Return-Path: <linux-acpi+bounces-6385-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EB2907CAB
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 21:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BFB21F232C1
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 19:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E62E14D6F9;
	Thu, 13 Jun 2024 19:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B41kXFrk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7548814D6ED;
	Thu, 13 Jun 2024 19:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718307248; cv=none; b=qvtMmUZJKcwv/e1BDHRUqVxNwQIh0TI4mnleboKKXEmb68H1uoA7/MgLvqBp8bvv49/1NdzlsC/IOL3Po8nnTm0H0Sj/7kd9L9FjMtDDllx/MmXjYuEUwl8b0eQQpP2ll8mmF8lxXSNzaKeFsmKgJcYikfYkqOfrF+25p6Bm6xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718307248; c=relaxed/simple;
	bh=bbhYqO6arj3VX7+rFvR2uC0Q/DGG5UGkw2Zn5smw2UQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PAyETDcKcfQ1p53f9kc2GPmolnMDIJigLrhsPVxVrjGZHYQv+xu+hN9gO7GMDGJL4z0zuMrtomFfwXpxgvMB2QYWB5N1h17+HieKEqAfb3LOLWCo1tVCJP8HixrriW3Eyonyi23TL9OMlRCPo5YMJ+/upWDQ/d7W6Wgqw6QY6mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B41kXFrk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C8BC4AF5F;
	Thu, 13 Jun 2024 19:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718307248;
	bh=bbhYqO6arj3VX7+rFvR2uC0Q/DGG5UGkw2Zn5smw2UQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B41kXFrkKcs4UOo8evdjfW2C4ZW/UK3nX+H2W1bKE/9jnhsi9R8uzcuv9pzz6ywsb
	 6NhZCORscpyhVztgHvNjw3zpk55iVAc1L0EFo/y4foNJrvrcatI3hN81iUWnxfWWqM
	 dhIxGhrOj6STl5dzuYjwHEDitl/LBsXb/Svl43pRVS2JBt6HEIw/7xVClMj8T5rFT/
	 JHKdVb6kn36tDqT1mDPflFVMatAdDbR0NlcXUw7HaBP6pvGrVp4usRe/VJjjtZ9hzS
	 WUQh84AAlYl0fS8jZNieg+F3pi+hcb2rgKQGkpaD42bC3N5LrlMhdhJSl70coKt9Tz
	 2KHOrsydpjYmg==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d21c5b48f5so211526b6e.0;
        Thu, 13 Jun 2024 12:34:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVugk0YH1nqMjWV+m4nZ5RULE7ZhMRc3ACxi5TSllsT6EJpv7vdDEu+hQ+0+8+DA/osDIknL21ySlUIRk7++bxhF1mmoYZORiHkY5HyOOJWLLE8FmVfYjbPPKsCTC92E86x1i7OnZGgpgHulLQ2C7wOfQdNKuzFroD1f/oyJigqdxK9
X-Gm-Message-State: AOJu0YwxV52g8Oy+BRQTWYPWKsv3MOdlQhr23zOnjLP08M9Yb8HHHAwD
	+1zd/qldE+cfIYcsFvY1FNpZxNUDk0hkDmrN9CzwtaQwCNsigszq2zP4P7CJ+b1P/Fr8VrrTbE3
	1HmhxFURNbVLkurbDxISs45I1njQ=
X-Google-Smtp-Source: AGHT+IG0G9y36mr+Dlfv2THcm6PYAW/FOqGLOg/QX0txRvOhtSWL6wvDXmnU00jM0TAGeT4jIFVoyY40op2reHRrX9s=
X-Received: by 2002:a4a:e1da:0:b0:5ba:ead2:c742 with SMTP id
 006d021491bc7-5bdad9f0343mr742290eaf.0.1718307247027; Thu, 13 Jun 2024
 12:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610-cros_ec-charge-control-v3-0-135e37252094@weissschuh.net> <20240610-cros_ec-charge-control-v3-1-135e37252094@weissschuh.net>
In-Reply-To: <20240610-cros_ec-charge-control-v3-1-135e37252094@weissschuh.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Jun 2024 21:33:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iUjvrs+57_meCkK7fcokH0j8sTAG3xXai5av_n5OHJwA@mail.gmail.com>
Message-ID: <CAJZ5v0iUjvrs+57_meCkK7fcokH0j8sTAG3xXai5av_n5OHJwA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] ACPI: battery: add devm_battery_hook_register()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	Sebastian Reichel <sre@kernel.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>, 
	Dustin Howett <dustin@howett.net>, Stephen Horvath <s.horvath@outlook.com.au>, 
	Rajas Paranjpe <paranjperajas@gmail.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, Matt Hartley <matt.hartley@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 5:52=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> Add a utility function for device-managed registration of battery hooks.
> The function makes it easier to manage the lifecycle of a hook.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Please feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to this patch and route it along with the rest of the series as needed.

Thanks!

> ---
>  drivers/acpi/battery.c | 15 +++++++++++++++
>  include/acpi/battery.h |  2 ++
>  2 files changed, 17 insertions(+)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index b379401ff1c2..6ea979f76f84 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -756,6 +756,21 @@ void battery_hook_register(struct acpi_battery_hook =
*hook)
>  }
>  EXPORT_SYMBOL_GPL(battery_hook_register);
>
> +static void devm_battery_hook_unregister(void *data)
> +{
> +       struct acpi_battery_hook *hook =3D data;
> +
> +       battery_hook_unregister(hook);
> +}
> +
> +int devm_battery_hook_register(struct device *dev, struct acpi_battery_h=
ook *hook)
> +{
> +       battery_hook_register(hook);
> +
> +       return devm_add_action_or_reset(dev, devm_battery_hook_unregister=
, hook);
> +}
> +EXPORT_SYMBOL_GPL(devm_battery_hook_register);
> +
>  /*
>   * This function gets called right after the battery sysfs
>   * attributes have been added, so that the drivers that
> diff --git a/include/acpi/battery.h b/include/acpi/battery.h
> index 611a2561a014..c93f16dfb944 100644
> --- a/include/acpi/battery.h
> +++ b/include/acpi/battery.h
> @@ -2,6 +2,7 @@
>  #ifndef __ACPI_BATTERY_H
>  #define __ACPI_BATTERY_H
>
> +#include <linux/device.h>
>  #include <linux/power_supply.h>
>
>  #define ACPI_BATTERY_CLASS "battery"
> @@ -19,5 +20,6 @@ struct acpi_battery_hook {
>
>  void battery_hook_register(struct acpi_battery_hook *hook);
>  void battery_hook_unregister(struct acpi_battery_hook *hook);
> +int devm_battery_hook_register(struct device *dev, struct acpi_battery_h=
ook *hook);
>
>  #endif
>
> --
> 2.45.2
>
>

