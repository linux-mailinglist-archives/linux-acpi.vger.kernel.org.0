Return-Path: <linux-acpi+bounces-18101-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF6BBFCA67
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 16:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC15334B646
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 14:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659DD334C13;
	Wed, 22 Oct 2025 14:45:48 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4C434845C
	for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 14:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761144348; cv=none; b=gy3Y3oTlhSf1Uvs7cFcTtdJqelmQEvcJdeuiz5aDp0TzRqRAFMgdL/XmAy9K/j7Adub1ZTK+rvgKw0zxkF0uWoxEsRn8LnWwPAdNrk/EAOHMsT6+ShDN5iGMIog355G1RIr03J+JY/f06K2ZS9DxhQqPfGwCgzStiYUOXQN0muU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761144348; c=relaxed/simple;
	bh=tSw6rQZlMQn+CQgaVhZKZ/LPnP71EM4OXUrLskqgNhI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r8MqvP5VZj6Z9efVbExRsaDYB3++UDeB62VO4dY9QEH6tZ1Z8yzskP4/J+Ct6cYVTrMHsxoX7U1ICIrQEV+24crYEfH5OOn6K2wkcajypuhtka8uDldplqr5lJg7LZma5B6FYVmmxMAK4vuIpxRjNDMIVu+iTGy2rYzPWJbJx44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vBa5f-00088u-0v; Wed, 22 Oct 2025 16:45:27 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vBa5e-004uKx-0o;
	Wed, 22 Oct 2025 16:45:26 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vBa5e-00000000BDI-0hMt;
	Wed, 22 Oct 2025 16:45:26 +0200
Message-ID: <939b13c69ade5e574c33777bc4f7b368f83764ff.camel@pengutronix.de>
Subject: Re: [PATCH v2 9/9] reset: gpio: use software nodes to setup the
 GPIO lookup
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
Date: Wed, 22 Oct 2025 16:45:25 +0200
In-Reply-To: <20251022-reset-gpios-swnodes-v2-9-69088530291b@linaro.org>
References: <20251022-reset-gpios-swnodes-v2-0-69088530291b@linaro.org>
	 <20251022-reset-gpios-swnodes-v2-9-69088530291b@linaro.org>
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

On Mi, 2025-10-22 at 15:41 +0200, Bartosz Golaszewski wrote:
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
>  drivers/reset/core.c | 131 ++++++++++++++++++++++++++++++---------------=
------
>  1 file changed, 77 insertions(+), 54 deletions(-)
>=20
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index c9f13020ca3a7b9273488497a7d4240d0af762b0..20378de4b813ab79a103ea81c=
f2cbcd2b76c0ccf 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
[...]
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

Please move this ...

>  	struct gpio_device *gdev __free(gpio_device_put) =3D
>  		gpio_device_find_by_fwnode(of_fwnode_handle(args->np));
>  	if (!gdev)
>  		return -EPROBE_DEFER;
> =20
> +	parent =3D gpio_device_to_device(gdev);
> +

... and this after the lockdep_asset_held() below.


With that,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

