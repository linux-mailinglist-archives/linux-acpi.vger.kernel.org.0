Return-Path: <linux-acpi+bounces-19030-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD53C6ABD6
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 17:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D25E4F917B
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 16:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A298377E8C;
	Tue, 18 Nov 2025 16:45:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101B03002C6
	for <linux-acpi@vger.kernel.org>; Tue, 18 Nov 2025 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763484325; cv=none; b=bIA9c0jvrydNOGg5oIn9Nd+EWqHy6QTopmz4x4G42B1zU+zttmJ0AqYKq2/Grnv1O9dutM6PzPyjmtSYh6Vk22JQwmIbU0LWsdUvHAcaSM7e4pVkptPN+wd0mjT8IkASzKm1nalvYG9dldpGA10zVCI+MDEed9pmas3dDEtcVOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763484325; c=relaxed/simple;
	bh=oQ7BOxq8Kr3JX0HJ0KIsH0NxlWew6O3eCfg3IQQNyiY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VszzW6EAphV1crneVziNXjbQoNchO37f6KA+4wWRYmum98rfjV34qr1HqA/rl0XKLkc8P2FY78Qr8kyPI8WlFkfcjd+YuTQJ4yRUj/OGwzqcq3LjeXW6jSAWL0d3WXPLCZ8iXvlT+3EIFFttiy+DKApSIP59c1PeouwY+7Dk60Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vLOoO-00029M-R3; Tue, 18 Nov 2025 17:44:12 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vLOoN-0016yC-1u;
	Tue, 18 Nov 2025 17:44:11 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vLOoN-000000009ZX-26c4;
	Tue, 18 Nov 2025 17:44:11 +0100
Message-ID: <0d251a35a438ebf3e14c6762df7ece079ee1d164.camel@pengutronix.de>
Subject: Re: [PATCH v6 8/8] reset: gpio: use software nodes to setup the
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
Date: Tue, 18 Nov 2025 17:44:11 +0100
In-Reply-To: <20251106-reset-gpios-swnodes-v6-8-69aa852de9e4@linaro.org>
References: <20251106-reset-gpios-swnodes-v6-0-69aa852de9e4@linaro.org>
	 <20251106-reset-gpios-swnodes-v6-8-69aa852de9e4@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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

On Do, 2025-11-06 at 15:32 +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> GPIO machine lookup is a nice mechanism for associating GPIOs with
> consumers if we don't know what kind of device the GPIO provider is or
> when it will become available. However in the case of the reset-gpio, we
> are already holding a reference to the device and so can reference its
> firmware node. Let's setup a software node that references the relevant
> GPIO and attach it to the auxiliary device we're creating.
>=20
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/reset/core.c | 126 +++++++++++++++++++++++++++++----------------=
------
>  1 file changed, 73 insertions(+), 53 deletions(-)
>=20
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index cefeff10f6c82f5aef269a6d3a58d9d204ed6b7e..8262879e3f0d9ce67683c6baa=
00d9eea9e3c3ca3 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -14,6 +14,7 @@
>  #include <linux/export.h>
>  #include <linux/gpio/driver.h>
>  #include <linux/gpio/machine.h>
> +#include <linux/gpio/property.h>
>  #include <linux/idr.h>
>  #include <linux/kernel.h>
>  #include <linux/kref.h>
> @@ -77,10 +78,12 @@ struct reset_control_array {
>  /**
>   * struct reset_gpio_lookup - lookup key for ad-hoc created reset-gpio d=
evices
>   * @of_args: phandle to the reset controller with all the args like GPIO=
 number
> + * @swnode: Software node containing the reference to the GPIO provider
>   * @list: list entry for the reset_gpio_lookup_list
>   */
>  struct reset_gpio_lookup {
>  	struct of_phandle_args of_args;
> +	struct fwnode_handle *swnode;
>  	struct list_head list;
>  };
> =20
> @@ -822,52 +825,45 @@ static void __reset_control_put_internal(struct res=
et_control *rstc)
>  	kref_put(&rstc->refcnt, __reset_control_release);
>  }
> =20
> -static int __reset_add_reset_gpio_lookup(struct gpio_device *gdev, int i=
d,
> -					 struct device_node *np,
> -					 unsigned int gpio,
> -					 unsigned int of_flags)
> +static void reset_gpio_aux_device_release(struct device *dev)
>  {
> -	unsigned int lookup_flags;
> -	const char *label_tmp;
> +	struct auxiliary_device *adev =3D to_auxiliary_dev(dev);
> =20
> -	/*
> -	 * Later we map GPIO flags between OF and Linux, however not all
> -	 * constants from include/dt-bindings/gpio/gpio.h and
> -	 * include/linux/gpio/machine.h match each other.
> -	 */
> -	if (of_flags > GPIO_ACTIVE_LOW) {
> -		pr_err("reset-gpio code does not support GPIO flags %u for GPIO %u\n",
> -		       of_flags, gpio);
> -		return -EINVAL;
> +	kfree(adev);
> +}
> +
> +static int reset_add_gpio_aux_device(struct device *parent,
> +				     struct fwnode_handle *swnode,
> +				     int id, void *pdata)
> +{
> +	struct auxiliary_device *adev;
> +	int ret;
> +
> +	adev =3D kzalloc(sizeof(*adev), GFP_KERNEL);
> +	if (!adev)
> +		return -ENOMEM;
> +
> +	adev->id =3D id;
> +	adev->name =3D "gpio";
> +	adev->dev.parent =3D parent;
> +	adev->dev.platform_data =3D pdata;
> +	adev->dev.release =3D reset_gpio_aux_device_release;
> +	device_set_node(&adev->dev, swnode);
> +
> +	ret =3D auxiliary_device_init(adev);
> +	if (ret) {
> +		kfree(adev);
> +		return ret;
>  	}
> =20
> -	label_tmp =3D gpio_device_get_label(gdev);
> -	if (!label_tmp)
> -		return -EINVAL;
> +	ret =3D __auxiliary_device_add(adev, "reset");
> +	if (ret) {
> +		auxiliary_device_uninit(adev);
> +		kfree(adev);
> +		return ret;
> +	}
> =20
> -	char *label __free(kfree) =3D kstrdup(label_tmp, GFP_KERNEL);
> -	if (!label)
> -		return -ENOMEM;
> -
> -	/* Size: one lookup entry plus sentinel */
> -	struct gpiod_lookup_table *lookup __free(kfree) =3D kzalloc(struct_size=
(lookup, table, 2),
> -								  GFP_KERNEL);
> -	if (!lookup)
> -		return -ENOMEM;
> -
> -	lookup->dev_id =3D kasprintf(GFP_KERNEL, "reset.gpio.%d", id);
> -	if (!lookup->dev_id)
> -		return -ENOMEM;
> -
> -	lookup_flags =3D GPIO_PERSISTENT;
> -	lookup_flags |=3D of_flags & GPIO_ACTIVE_LOW;
> -	lookup->table[0] =3D GPIO_LOOKUP(no_free_ptr(label), gpio, "reset",
> -				       lookup_flags);
> -
> -	/* Not freed on success, because it is persisent subsystem data. */
> -	gpiod_add_lookup_table(no_free_ptr(lookup));
> -
> -	return 0;
> +	return ret;
>  }
> =20
>  /*
> @@ -875,8 +871,10 @@ static int __reset_add_reset_gpio_lookup(struct gpio=
_device *gdev, int id,
>   */
>  static int __reset_add_reset_gpio_device(const struct of_phandle_args *a=
rgs)
>  {
> +	struct property_entry properties[2] =3D { };
> +	unsigned int offset, of_flags, lflags;
>  	struct reset_gpio_lookup *rgpio_dev;
> -	struct auxiliary_device *adev;
> +	struct device *parent;
>  	int id, ret;
> =20
>  	/*
> @@ -895,6 +893,23 @@ static int __reset_add_reset_gpio_device(const struc=
t of_phandle_args *args)
>  	 */
>  	lockdep_assert_not_held(&reset_list_mutex);
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
> @@ -909,6 +924,10 @@ static int __reset_add_reset_gpio_device(const struc=
t of_phandle_args *args)
>  		}
>  	}
> =20
> +	lflags =3D GPIO_PERSISTENT | (of_flags & GPIO_ACTIVE_LOW);
> +	parent =3D gpio_device_to_device(gdev);
> +	properties[0] =3D PROPERTY_ENTRY_GPIO("reset-gpios", parent->fwnode, of=
fset, lflags);
> +
>  	id =3D ida_alloc(&reset_gpio_ida, GFP_KERNEL);
>  	if (id < 0)
>  		return id;
> @@ -920,11 +939,6 @@ static int __reset_add_reset_gpio_device(const struc=
t of_phandle_args *args)
>  		goto err_ida_free;
>  	}
> =20
> -	ret =3D __reset_add_reset_gpio_lookup(gdev, id, args->np, args->args[0]=
,
> -					    args->args[1]);
> -	if (ret < 0)
> -		goto err_kfree;
> -
>  	rgpio_dev->of_args =3D *args;
>  	/*
>  	 * We keep the device_node reference, but of_args.np is put at the end
> @@ -932,19 +946,25 @@ static int __reset_add_reset_gpio_device(const stru=
ct of_phandle_args *args)
>  	 * Hold reference as long as rgpio_dev memory is valid.
>  	 */
>  	of_node_get(rgpio_dev->of_args.np);
> -	adev =3D auxiliary_device_create(gpio_device_to_device(gdev), "reset",
> -				       "gpio", &rgpio_dev->of_args, id);
> -	ret =3D PTR_ERR_OR_ZERO(adev);
> +
> +	rgpio_dev->swnode =3D fwnode_create_software_node(properties, NULL);
> +	ret =3D PTR_ERR(rgpio_dev->swnode);

I'll apply this with the following patch squashed in:

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 3edf04ae8a95..8a7b112a9a77 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -945,7 +945,7 @@ static int __reset_add_reset_gpio_device(const struct o=
f_phandle_args *args)
        of_node_get(rgpio_dev->of_args.np);
=20
        rgpio_dev->swnode =3D fwnode_create_software_node(properties, NULL)=
;
-       ret =3D PTR_ERR(rgpio_dev->swnode);
+       ret =3D PTR_ERR_OR_ZERO(rgpio_dev->swnode);
        if (ret)
                goto err_put_of_node;
=20

regards
Philipp

