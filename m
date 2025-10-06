Return-Path: <linux-acpi+bounces-17628-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04868BBE8EB
	for <lists+linux-acpi@lfdr.de>; Mon, 06 Oct 2025 17:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A1DC4EFA97
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Oct 2025 15:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701A12D0625;
	Mon,  6 Oct 2025 15:55:26 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D942D2488
	for <linux-acpi@vger.kernel.org>; Mon,  6 Oct 2025 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759766126; cv=none; b=ts/VCJJPcKeys8h+mEfw+VgTYhAxQHDnOjRU3nK0R1o62wNVwfDWnCw+tebh/ur1uSpPoZMyyKvcX7mpG1wF/UWwq2FjIrizaHhcj8gCh87iCpm0jEwSU5hQaNkhFm7GgB4m8nmDd5rgUacGhqTpn+SqHpq1PtvSRD6TY3sqjXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759766126; c=relaxed/simple;
	bh=y6HUfXDXIGn7AC+u25PWmRV83hvC0ZHZo1HMmuPyFHE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hIkgF4CsarFYeRkoKLQIr+9GHZ4k36ILRrILFRlI00Z4KipbNbN8iyLA2RuVfcpmpaDiuZcJP8cDDlz71rfF9VmxympJFnlZeCJtB0cpSsxUgodcYm2z320u9ZqnoVm4r7eF1jkQ6Y4LKzuPFOukt1IYYbKqgqGRFEGzxCUVjjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1v5nYI-0004ze-Ch; Mon, 06 Oct 2025 17:55:06 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1v5nYH-002FtQ-1w;
	Mon, 06 Oct 2025 17:55:05 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1v5nYH-00000000Cha-2AUn;
	Mon, 06 Oct 2025 17:55:05 +0200
Message-ID: <e6a120d4ada6d032f69812f14a7e794ac1796a85.camel@pengutronix.de>
Subject: Re: [PATCH 9/9] reset: gpio: use software nodes to setup the GPIO
 lookup
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij	
 <linus.walleij@linaro.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,  Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus	
 <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki"	 <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Krzysztof Kozlowski	 <krzk@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>
Date: Mon, 06 Oct 2025 17:55:05 +0200
In-Reply-To: <20251006-reset-gpios-swnodes-v1-9-6d3325b9af42@linaro.org>
References: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
	 <20251006-reset-gpios-swnodes-v1-9-6d3325b9af42@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-acpi@vger.kernel.org

On Mo, 2025-10-06 at 15:00 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> GPIO machine lookup is a nice mechanism for associating GPIOs with
> consumers if we don't know what kind of device the GPIO provider is or
> when it will become available. However in the case of the reset-gpio, we
> are already holding a reference to the device and so can reference its
> firmware node. Let's setup a software node that references the relevant
> GPIO and attach it to the auxiliary device we're creating.
>=20
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/reset/core.c | 132 ++++++++++++++++++++++++++++++---------------=
------
>  1 file changed, 78 insertions(+), 54 deletions(-)
>=20
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index c9f13020ca3a7b9273488497a7d4240d0af762b0..b3e6ba7a9c3d756d2e30dc20e=
dda9c02b624aefd 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
[...]
> @@ -849,52 +852,45 @@ static void __reset_control_put_internal(struct res=
et_control *rstc)
>  	kref_put(&rstc->refcnt, __reset_control_release);
>  }
> =20
> -static int __reset_add_reset_gpio_lookup(struct gpio_device *gdev, int i=
d,
> -					 struct device_node *np,
> -					 unsigned int gpio,
> -					 unsigned int of_flags)
> +static void reset_aux_device_release(struct device *dev)

static void reset_gpio_aux_device_release(struct device *dev)

[...]
> @@ -903,8 +899,10 @@ static int __reset_add_reset_gpio_lookup(struct gpio=
_device *gdev, int id,
>  static int __reset_add_reset_gpio_device(const struct of_phandle_args *a=
rgs)
>  {
>  	struct reset_gpio_lookup *rgpio_dev;
> -	struct auxiliary_device *adev;
> -	int id, ret;
> +	struct property_entry properties[2];

It would be nice if this could be initialized instead of the memset() +
assignment below. Maybe splitting the function will make this more
convenient.

> +	unsigned int offset, of_flags;
> +	struct device *parent;
> +	int id, ret, lflags;

Should this be unsigned int, or enum gpio_lookup_flags?

> =20
>  	/*
>  	 * Currently only #gpio-cells=3D2 is supported with the meaning of:
> @@ -915,11 +913,30 @@ static int __reset_add_reset_gpio_device(const stru=
ct of_phandle_args *args)
>  	if (args->args_count !=3D 2)
>  		return -ENOENT;
> =20
> +	offset =3D args->args[0];
> +	of_flags =3D args->args[1];
> +
> +	/*
> +	 * Later we map GPIO flags between OF and Linux, however not all
> +	 * constants from include/dt-bindings/gpio/gpio.h and
> +	 * include/linux/gpio/machine.h match each other.
> +	 *
> +	 * FIXME: Find a better way of translating OF flags to GPIO lookup
> +	 * flags.
> +	 */
> +	if (of_flags > GPIO_ACTIVE_LOW) {
> +		pr_err("reset-gpio code does not support GPIO flags %u for GPIO %u\n",
> +		       of_flags, offset);
> +		return -EINVAL;
> +	}
> +
>  	struct gpio_device *gdev __free(gpio_device_put) =3D
>  		gpio_device_find_by_fwnode(of_fwnode_handle(args->np));
>  	if (!gdev)
>  		return -EPROBE_DEFER;
> =20
> +	parent =3D gpio_device_to_device(gdev);
> +
>  	/*
>  	 * Registering reset-gpio device might cause immediate
>  	 * bind, resulting in its probe() registering new reset controller thus
> @@ -936,6 +953,13 @@ static int __reset_add_reset_gpio_device(const struc=
t of_phandle_args *args)
>  		}
>  	}
> =20
> +	lflags =3D GPIO_PERSISTENT | (of_flags & GPIO_ACTIVE_LOW);

Could we get an of_flags_to_gpio_lookup_flags() kind of helper for
this?

> +
> +	memset(properties, 0, sizeof(properties));
> +	properties[0] =3D PROPERTY_ENTRY_GPIO_FWNODE("reset-gpios",
> +						   parent->fwnode,
> +						   offset, lflags);
> +
>  	id =3D ida_alloc(&reset_gpio_ida, GFP_KERNEL);
>  	if (id < 0)
>  		return id;

regards
Philipp

