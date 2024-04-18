Return-Path: <linux-acpi+bounces-5170-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F9F8AA2BD
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Apr 2024 21:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DC111F21597
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Apr 2024 19:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABC917BB04;
	Thu, 18 Apr 2024 19:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXcuOEGJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D3E6A00E;
	Thu, 18 Apr 2024 19:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713468584; cv=none; b=I8E+fdA83hDYIyVksUiMpKV5g25kYgVd1SaTz8MB2jLjDqM3jjwxKJsWouRmVCRWoJu3FnDLv9DixYiL3upiqfMU0lLA5pCWfgNMmm/hUGHyBJ04MDq8MHYQrFi8mh2CXcFMFlBWgnENziUBRmvxdxhW+H61LEm+DZa/17fVam4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713468584; c=relaxed/simple;
	bh=LrLBfpriSshLYGG7DcMlsnRlKK4um/syDnIFznUgYUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQsjKvHLjRITsiHfMI5qk+ftO4K0Z44vwgJKdCMr2PwqdtTaqa/jH8QarmOsrv8cbsQ22rfw2nW339ZoQhZrDN/bqWQwXR13NzkXmRxGleApdq0hFM0GHx2LxHvcgQsTE2CKXmWSQaL+JH6P40lNLbR/eXXlflJNOFGGwXAtEcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXcuOEGJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CC2C113CC;
	Thu, 18 Apr 2024 19:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713468583;
	bh=LrLBfpriSshLYGG7DcMlsnRlKK4um/syDnIFznUgYUY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fXcuOEGJ+RFeFeP0HS9IoeFJ29kucKfGxrW/exWti/yYoAU9RQVgJEzSJ5K05cShz
	 60/A0TbzfrQnVFosR89DP8p30n2EyWuhov/GWUAsO/XaPij46zBXzWfrB/GAfIObeO
	 8z8VfxrrHtQHRnaxwrWLbkNffCVZxpo5BSuTHDN10KfSYiweavL/90/A+hzjwL/Y5L
	 46QCPtPAQ82/AFSp7bLgJAZHpGLIA03fAqbHxjBys57zm8VzF7/K1Xr+AA6FjQ3e6y
	 o/xZSrYHD8Oq7hnSX+FEJVNQnnt9kIA0a5IjF/v8BMV0YCRfUN8/8ZLwKb/G/blh0K
	 rwQY8YAqYmdmg==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6eb50bbd8ceso157917a34.1;
        Thu, 18 Apr 2024 12:29:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWjhFdDP2MGSOPZZekCcnSxrQr5s5F0bKd2j1+IO7fA10ojQiZu/yVSSYnRHow8puTeytdNh6f8LRPxDh54lrswHj4fKgw/k5QaZdi3+nTz/CTZNJQb3gVDELzAAzjk9Jnd9V1OaTU=
X-Gm-Message-State: AOJu0YzcpSSfb7CZ54k4P0qTeg+Z3OlbZxvJDfIdv8U/yksnG1LRkq/V
	oQtPYfuw+vjSZQgHtfmZPh/a9tN9VGfA5wme4BVoNaxL0gmOPQk+oBTQ1NuFdDU/IsaO+IO4Stf
	32Vqkjk0YSnnumKuFhY8nl/acqNs=
X-Google-Smtp-Source: AGHT+IHH8Kfoy0dlrXRtnrKKmFUt5MrkkaRhY1U0slOzTwjhxVNzcSkvUuSfQBNPDkyygtXGuW9dLoLPAKixSKi3dK8=
X-Received: by 2002:a05:6820:2884:b0:5aa:241a:7f4b with SMTP id
 dn4-20020a056820288400b005aa241a7f4bmr197834oob.1.1713468583064; Thu, 18 Apr
 2024 12:29:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313030251.1049624-1-hamish.martin@alliedtelesis.co.nz>
In-Reply-To: <20240313030251.1049624-1-hamish.martin@alliedtelesis.co.nz>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 18 Apr 2024 21:29:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jChQdAUaYCPoiao1fhxt90A3auybEW72DRXEwCxE3=Pg@mail.gmail.com>
Message-ID: <CAJZ5v0jChQdAUaYCPoiao1fhxt90A3auybEW72DRXEwCxE3=Pg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: Move storage of acpi_gpio_chip
To: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Cc: mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, 
	linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 4:03=E2=80=AFAM Hamish Martin
<hamish.martin@alliedtelesis.co.nz> wrote:
>
> A memory leak occurs in a scenario where an ACPI SSDT overlay is removed
> and that is the trigger for the removal of the acpi_gpio_chip.
> This occurs because we use the ACPI_HANDLE of the chip->parent as a
> convenient location to tie the 'struct acpi_gpio_chip' to, using
> acpi_attach_data().
> This is fine in the usual case of removal of the 'struct acpi_gpio_chip'
> via a call to acpi_gpiochip_remove() because usually the ACPI data is
> still valid.
> But in the case of an SSDT overlay removal, the ACPI data has been
> marked as invalid before the removal code is triggered (see the setting
> of the acpi_device handle to INVALID_ACPI_HANDLE in
> acpi_scan_drop_device())

This is not entirely accurate.

The ACPI handle of the struct acpi_device going away is replaced with
INVALID_ACPI_HANDLE because by the time acpi_device_del_work_fn()
runs, the namespace object identified by this handle may have been
deleted already.

Moreover, all of the data items attached to that object are deleted by
the very acpi_ns_delete_node() call that has invoked
acpi_scan_drop_device().

So acpi_scan_drop_device() must invalidate the ACPI handle in the
struct acpi_device, because going forward it is not associated with a
valid namespace object and all of the data items attached to it via
acpi_attach_data() have been deleted.

> This means that by the time we execute
> acpi_gpiochip_remove(), the handles are invalid and we are unable to
> retrieve the 'struct acpi_gpio_chip' using acpi_get_data().

Indeed, that information has gone away already.

However, acpi_gpio_chip_dh() is called when that happens, so in
principle you can know when it is happening.

> Unable to get our data, we hit the failure case and see the following war=
ning
> logged:   Failed to retrieve ACPI GPIO chip
> This means we also fail to kfree() the struct at the end of
> acpi_gpiochip_remove().
>
> The fix is to no longer tie the acpi_gpio_chip data to the ACPI data,
> but instead hang it directly from the 'struct gpio_chip' with a new
> field. This decouples the lifecycle of the acpi_gpio_chip from the ACPI
> data, and ties it to the gpio_chip. This seems a much better place since
> they share a common lifecycle.

I can agree with this.

> The general concept of attaching data to the ACPI objects may also need
> revisiting in light of the issue this patch addresses. For instance
> i2c_acpi_remove_space_handler() is vulnerable to a similar leak due to
> using acpi_bus_get_private_data(), which just wraps acpi_attach_data().
> This may need a more widespread change than is addressed in this patch.

acpi_bus_attach_private_data() is only used in 2 places beyond this,
so I'm not worried too much.

But yes, generally speaking, if the ACPI namespace object you attach
data to can vanish from under you as a result of an overlay removal,
you better not attach data to it or use a meaningful data removal
handler.

> Signed-off-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
> ---
>  drivers/gpio/gpiolib-acpi.c | 57 ++++++++-----------------------------
>  include/linux/gpio/driver.h |  4 +++
>  2 files changed, 16 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index cd3e9657cc36..14d29902391f 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -180,11 +180,6 @@ static irqreturn_t acpi_gpio_irq_handler_evt(int irq=
, void *data)
>         return IRQ_HANDLED;
>  }
>
> -static void acpi_gpio_chip_dh(acpi_handle handle, void *data)
> -{
> -       /* The address of this function is used as a key. */
> -}
> -
>  bool acpi_gpio_get_irq_resource(struct acpi_resource *ares,
>                                 struct acpi_resource_gpio **agpio)
>  {
> @@ -500,18 +495,17 @@ void acpi_gpiochip_request_interrupts(struct gpio_c=
hip *chip)
>  {
>         struct acpi_gpio_chip *acpi_gpio;
>         acpi_handle handle;
> -       acpi_status status;
>         bool defer;
>
>         if (!chip->parent || !chip->to_irq)
>                 return;
>
> -       handle =3D ACPI_HANDLE(chip->parent);
> -       if (!handle)
> +       acpi_gpio =3D chip->acpi_gpio;
> +       if (!acpi_gpio)
>                 return;
>
> -       status =3D acpi_get_data(handle, acpi_gpio_chip_dh, (void **)&acp=
i_gpio);
> -       if (ACPI_FAILURE(status))
> +       handle =3D ACPI_HANDLE(chip->parent);
> +       if (!handle)
>                 return;
>
>         if (acpi_quirk_skip_gpio_event_handlers())
> @@ -545,18 +539,12 @@ void acpi_gpiochip_free_interrupts(struct gpio_chip=
 *chip)
>  {
>         struct acpi_gpio_chip *acpi_gpio;
>         struct acpi_gpio_event *event, *ep;
> -       acpi_handle handle;
> -       acpi_status status;
>
>         if (!chip->parent || !chip->to_irq)
>                 return;
>
> -       handle =3D ACPI_HANDLE(chip->parent);
> -       if (!handle)
> -               return;
> -
> -       status =3D acpi_get_data(handle, acpi_gpio_chip_dh, (void **)&acp=
i_gpio);
> -       if (ACPI_FAILURE(status))
> +       acpi_gpio =3D chip->acpi_gpio;
> +       if (!acpi_gpio)
>                 return;
>
>         mutex_lock(&acpi_gpio_deferred_req_irqs_lock);
> @@ -1218,15 +1206,10 @@ static void acpi_gpiochip_free_regions(struct acp=
i_gpio_chip *achip)
>         struct gpio_chip *chip =3D achip->chip;
>         acpi_handle handle =3D ACPI_HANDLE(chip->parent);
>         struct acpi_gpio_connection *conn, *tmp;
> -       acpi_status status;
>
> -       status =3D acpi_remove_address_space_handler(handle, ACPI_ADR_SPA=
CE_GPIO,
> -                                                  acpi_gpio_adr_space_ha=
ndler);
> -       if (ACPI_FAILURE(status)) {
> -               dev_err(chip->parent,
> -                       "Failed to remove GPIO OpRegion handler\n");
> -               return;
> -       }
> +       /* Ignore the return status as the handle is likely no longer val=
id. */
> +       acpi_remove_address_space_handler(handle, ACPI_ADR_SPACE_GPIO,
> +                                         acpi_gpio_adr_space_handler);
>
>         list_for_each_entry_safe_reverse(conn, tmp, &achip->conns, node) =
{
>                 gpiochip_free_own_desc(conn->desc);
> @@ -1310,7 +1293,6 @@ void acpi_gpiochip_add(struct gpio_chip *chip)
>  {
>         struct acpi_gpio_chip *acpi_gpio;
>         struct acpi_device *adev;
> -       acpi_status status;
>
>         if (!chip || !chip->parent)
>                 return;
> @@ -1327,16 +1309,10 @@ void acpi_gpiochip_add(struct gpio_chip *chip)
>         }
>
>         acpi_gpio->chip =3D chip;
> +       chip->acpi_gpio =3D acpi_gpio;
>         INIT_LIST_HEAD(&acpi_gpio->events);
>         INIT_LIST_HEAD(&acpi_gpio->deferred_req_irqs_list_entry);
>
> -       status =3D acpi_attach_data(adev->handle, acpi_gpio_chip_dh, acpi=
_gpio);
> -       if (ACPI_FAILURE(status)) {
> -               dev_err(chip->parent, "Failed to attach ACPI GPIO chip\n"=
);
> -               kfree(acpi_gpio);
> -               return;
> -       }
> -
>         acpi_gpiochip_request_regions(acpi_gpio);
>         acpi_gpiochip_scan_gpios(acpi_gpio);
>         acpi_dev_clear_dependencies(adev);
> @@ -1345,25 +1321,16 @@ void acpi_gpiochip_add(struct gpio_chip *chip)
>  void acpi_gpiochip_remove(struct gpio_chip *chip)
>  {
>         struct acpi_gpio_chip *acpi_gpio;
> -       acpi_handle handle;
> -       acpi_status status;
>
>         if (!chip || !chip->parent)
>                 return;
>
> -       handle =3D ACPI_HANDLE(chip->parent);
> -       if (!handle)
> +       acpi_gpio =3D chip->acpi_gpio;
> +       if (!acpi_gpio)
>                 return;
>
> -       status =3D acpi_get_data(handle, acpi_gpio_chip_dh, (void **)&acp=
i_gpio);
> -       if (ACPI_FAILURE(status)) {
> -               dev_warn(chip->parent, "Failed to retrieve ACPI GPIO chip=
\n");
> -               return;
> -       }
> -
>         acpi_gpiochip_free_regions(acpi_gpio);
>
> -       acpi_detach_data(handle, acpi_gpio_chip_dh);
>         kfree(acpi_gpio);
>  }
>
> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
> index 7f75c9a51874..698b92b1764c 100644
> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -529,6 +529,10 @@ struct gpio_chip {
>         int (*of_xlate)(struct gpio_chip *gc,
>                         const struct of_phandle_args *gpiospec, u32 *flag=
s);
>  #endif /* CONFIG_OF_GPIO */
> +
> +#ifdef CONFIG_GPIO_ACPI
> +       struct acpi_gpio_chip *acpi_gpio;
> +#endif /* CONFIG_GPIO_ACPI */
>  };
>
>  char *gpiochip_dup_line_label(struct gpio_chip *gc, unsigned int offset)=
;
> --
> 2.43.2
>
>

