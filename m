Return-Path: <linux-acpi+bounces-17624-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E534CBBE788
	for <lists+linux-acpi@lfdr.de>; Mon, 06 Oct 2025 17:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 800E73AA323
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Oct 2025 15:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996312D73B5;
	Mon,  6 Oct 2025 15:20:12 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AB92D6603
	for <linux-acpi@vger.kernel.org>; Mon,  6 Oct 2025 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759764012; cv=none; b=EpZOTnWbjP7pNql+9PRczRdk/b/9iX+DFk9DqBzFzgLsVNPUh6cljKKkCt9EYOvx63a00B3g0H8yWvLJXPOYNb3tlTTpuQDkOHv8c3A3YqdaIs7P8L8I8q3+z+ZExRwzcSgNXkjRKArJwcPcyA/gbyY4TvAdsA2X8IR432ZTciM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759764012; c=relaxed/simple;
	bh=nt6EudYMp3xYvVKECpHlYySFvcdOrLQvMt3e2mjhQj8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BlMrglaW/CAqyES4sFMeo7TJJ0gbAkvFro0NL8VzIYptxFV1cXtZbKyIoxmGyJoJZpA+zWW2NhNHvVBiSs8wta52hk261/XHPp3pwPMgThAC/snrV+gdPs/noQr2JSdCTeyHPKCDYjjiyuczhgRtXkzZzxUuDOU1ogdOwkHsqgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1v5n05-0008Ce-1r; Mon, 06 Oct 2025 17:19:45 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1v5n04-002Fjr-0B;
	Mon, 06 Oct 2025 17:19:44 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1v5n03-00000000C9V-44XM;
	Mon, 06 Oct 2025 17:19:43 +0200
Message-ID: <95bbec130437846d4b902ce4161ccf0f33c26c59.camel@pengutronix.de>
Subject: Re: [PATCH 7/9] reset: make the provider of reset-gpios the parent
 of the reset device
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
Date: Mon, 06 Oct 2025 17:19:43 +0200
In-Reply-To: <20251006-reset-gpios-swnodes-v1-7-6d3325b9af42@linaro.org>
References: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
	 <20251006-reset-gpios-swnodes-v1-7-6d3325b9af42@linaro.org>
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

Hi Bartosz,

On Mo, 2025-10-06 at 15:00 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> Auxiliary devices really do need a parent so ahead of converting the
> reset-gpios driver to registering on the auxiliary bus, make the GPIO
> device that provides the reset GPIO the parent of the reset-gpio device.
> To that end move the lookup of the GPIO device by fwnode to the
> beginning of __reset_add_reset_gpio_device() which has the added benefor

Typo: benefit.

> of bailing out earlier, before allocating resources for the virtual
> device, if the chip is not up yet.
>=20
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/reset/core.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index 5a696e2dbcc224a633e2b321da53b7bc699cb5f3..ad85ddc8dd9fcf8b512cb0916=
8586e0afca257f1 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -849,11 +849,11 @@ static void __reset_control_put_internal(struct res=
et_control *rstc)
>  	kref_put(&rstc->refcnt, __reset_control_release);
>  }
> =20
> -static int __reset_add_reset_gpio_lookup(int id, struct device_node *np,
> +static int __reset_add_reset_gpio_lookup(struct gpio_device *gdev, int i=
d,
> +					 struct device_node *np,
>  					 unsigned int gpio,
>  					 unsigned int of_flags)
>  {
> -	const struct fwnode_handle *fwnode =3D of_fwnode_handle(np);
>  	unsigned int lookup_flags;
>  	const char *label_tmp;
> =20
> @@ -868,10 +868,6 @@ static int __reset_add_reset_gpio_lookup(int id, str=
uct device_node *np,
>  		return -EINVAL;
>  	}
> =20
> -	struct gpio_device *gdev __free(gpio_device_put) =3D gpio_device_find_b=
y_fwnode(fwnode);
> -	if (!gdev)
> -		return -EPROBE_DEFER;
> -
>  	label_tmp =3D gpio_device_get_label(gdev);

This is the only remaining use of gdev in
__reset_add_reset_gpio_lookup().
It would make sense to move this as well and only pass the label.

Given that all this is removed in patch 9, this is not super important.

>  	if (!label_tmp)
>  		return -EINVAL;
> @@ -919,6 +915,11 @@ static int __reset_add_reset_gpio_device(const struc=
t of_phandle_args *args)
>  	if (args->args_count !=3D 2)
>  		return -ENOENT;
> =20
> +	struct gpio_device *gdev __free(gpio_device_put) =3D
> +		gpio_device_find_by_fwnode(of_fwnode_handle(args->np));

We are mixing cleanup helpers with gotos in this function, which the
documentation in cleanup.h explicitly advises against.

I know the current code is already guilty, but could you take this
opportunity to prepend a patch that splits the part under guard() into
a separate function?

I'd also move this block after the lockdep_assert_not_held() below.


regards
Philipp

