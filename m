Return-Path: <linux-acpi+bounces-11929-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B55BBA56AA1
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Mar 2025 15:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20846189B618
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Mar 2025 14:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C592621C165;
	Fri,  7 Mar 2025 14:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTWxX0n2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9701E21C16D;
	Fri,  7 Mar 2025 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741358358; cv=none; b=UG3zL2Nn2OeckpWHb85w8zWLaERtbbw5+SKBiBc3CXkhfTVqNwNfAUT/cwBcOom8lv8Q09gC9oQhbTm7axVbp2AEHkztuZV1q++P1JIkjoBWO5BUrWrO6hD+CMTWsd72TT9SQoXYg2PHST1OoVtKVmwvl7HrTLEoo8+xU+V+Y0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741358358; c=relaxed/simple;
	bh=fFmSvyAZuaaADM9zu6ZznJgoRZWd4cxcZLyG+vgwEsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RVL5PAI5sh3BAtGa5KQ1w8gPeHICX+BeJhdW4o/YiBbhC8jxtRsQAIjYzg6Fo7f4xf388uZi+WLy7g9Jsvf66vK3a8MqY0eM/6GcC1/EWaV2VPRyrALZ5AmdfRDOxCDpiiAmPNt6UK66KnI71+M+LOyy+LQJVBxO/bgxo81QQhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTWxX0n2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0501EC4CED1;
	Fri,  7 Mar 2025 14:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741358357;
	bh=fFmSvyAZuaaADM9zu6ZznJgoRZWd4cxcZLyG+vgwEsw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aTWxX0n2Zy2Nrp7qYJgJWgik6p61+eNrvVQNaezL/2NQ538lK1+ogBtMn65I2qskV
	 VHDx8nvcGMa+gLe/gf7DNZ3sbNFLcmGiBWObn+anRjtzqpfNkooL0TkqAKgwryMZm4
	 gQbmJKs4MJdHZ0hWie8xfZZOawsrm5/BkBB/vLBpXiomHK4aP66HuPxy8RQxyrTTuW
	 I34DGnIw9oHlBa1+Ua7gT6yP0v889tNgPdK5hfX7xCLRVyZIaa3iGgPVD4gTthcYZ6
	 u4mA9gK5PT7+KPab8JeyBnG/PvRhuammGafFcI4pHUXG5ZxdzMXZj3x+GXl+9b48yp
	 BXA/7X/32QAIA==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2b2b6019a74so1060855fac.0;
        Fri, 07 Mar 2025 06:39:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVesnhDA/cH8B3h1L44hZQj3Xu4C76uq43pGM2Cdj8ImR2OiETdOOJsd0hf5HqUWdLuAL8cQ1uqTVMT@vger.kernel.org, AJvYcCW/t3Gsj8jNLEiGb5MqTDjXpfCbAjo0pzAu/Qz3nIxM6funOiJRuPNehFD/ffeusnt0Lcz+YsC/BTBW/8Oi@vger.kernel.org, AJvYcCXWpfh3LhUw0/AJn6kuTPUD7COKquB9pY1fycKuRT/ArojC+G7ZxzR/GzJs/hC4YyTFMqpK2owVFhaEJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYvBNPfKbacIBIWm4gIYaIoZHmsueWFDVIWrOncKXtiKszH3aL
	LJcgNNMNKsTbBIyuBOet7JVptAdmTcR3jOSq7hlTys2bcPLv/3pnxvW1n6CgHrVFiGZ2FzwX/m9
	4J7b48qfsNLmpNkufeMPNfhYAeP4=
X-Google-Smtp-Source: AGHT+IHIPb/Xjy60xgUb8wH9pdRdsbl0zxj2R31ulx/Tzqn62Qr0VTwR5WyiUuItGs148LZBFEMswc7pIJruI8pEwMw=
X-Received: by 2002:a05:6870:9e8b:b0:2ba:11d5:ad64 with SMTP id
 586e51a60fabf-2c261159fd3mr2032713fac.23.1741358356369; Fri, 07 Mar 2025
 06:39:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305220146.3932955-1-superm1@kernel.org> <20250305220146.3932955-3-superm1@kernel.org>
In-Reply-To: <20250305220146.3932955-3-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Mar 2025 15:39:04 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gYRZ-wqStz7B96-HhkeedKBwNRXTOaA=bD1Q1uUy69TQ@mail.gmail.com>
X-Gm-Features: AQ5f1JpAUIjPtX9iBGcsSPf1RkGFON1HvGvxnN_LJPj3sH2gAisy6Q4TCQzk_O4
Message-ID: <CAJZ5v0gYRZ-wqStz7B96-HhkeedKBwNRXTOaA=bD1Q1uUy69TQ@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND 2/2] pinctrl: amd: Add an LPS0 check() callback
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, 
	"open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	linux-acpi@vger.kernel.org, Basavaraj Natikar <Basavaraj.Natikar@amd.com>, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 11:01=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> During suspend the pinctrl_amd driver disables the interrupts for
> any GPIOs that are not marked as wake sources.
>
> This however does not prevent them from changing the wake status
> bit during suspend, it just stops the system from waking.
>
> If the system wakes from hardware sleep for another reason (such
> as plugging in the AC adapter) this wake bits might be active.
>
> This could potentially cause problems with going back to hardware
> sleep.  Add an extra debugging message when PM debugging is enabled
> to help identify if this is happening.
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3929
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v3:
>  * Add tag
> ---
>  drivers/pinctrl/pinctrl-amd.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.=
c
> index 1d7fdcdec4c85..fdda8d1c4f344 100644
> --- a/drivers/pinctrl/pinctrl-amd.c
> +++ b/drivers/pinctrl/pinctrl-amd.c
> @@ -37,6 +37,8 @@
>  #include "pinctrl-utils.h"
>  #include "pinctrl-amd.h"
>
> +static struct amd_gpio *pinctrl_dev;
> +
>  static int amd_gpio_get_direction(struct gpio_chip *gc, unsigned offset)
>  {
>         unsigned long flags;
> @@ -909,6 +911,29 @@ static bool amd_gpio_should_save(struct amd_gpio *gp=
io_dev, unsigned int pin)
>         return false;
>  }
>
> +static void amd_gpio_check_pending(void)
> +{
> +       struct amd_gpio *gpio_dev =3D pinctrl_dev;
> +       struct pinctrl_desc *desc =3D gpio_dev->pctrl->desc;
> +       int i;
> +
> +       if (!pm_debug_messages_on)
> +               return;
> +
> +       for (i =3D 0; i < desc->npins; i++) {
> +               int pin =3D desc->pins[i].number;
> +               u32 tmp;
> +
> +               tmp =3D readl(gpio_dev->base + pin * 4);
> +               if (tmp & PIN_IRQ_PENDING)
> +                       pm_pr_dbg("%s: GPIO %d is active: 0x%x.\n", __fun=
c__, pin, tmp);
> +       }
> +}
> +
> +static struct acpi_s2idle_dev_ops pinctrl_amd_s2idle_dev_ops =3D {
> +       .check =3D amd_gpio_check_pending,
> +};
> +
>  static int amd_gpio_suspend_hibernate_common(struct device *dev, bool is=
_suspend)
>  {
>         struct amd_gpio *gpio_dev =3D dev_get_drvdata(dev);
> @@ -942,6 +967,7 @@ static int amd_gpio_suspend_hibernate_common(struct d=
evice *dev, bool is_suspend
>
>  static int amd_gpio_suspend(struct device *dev)
>  {
> +       pinctrl_dev =3D dev_get_drvdata(dev);
>         return amd_gpio_suspend_hibernate_common(dev, true);
>  }
>
> @@ -1181,6 +1207,7 @@ static int amd_gpio_probe(struct platform_device *p=
dev)
>
>         platform_set_drvdata(pdev, gpio_dev);
>         acpi_register_wakeup_handler(gpio_dev->irq, amd_gpio_check_wake, =
gpio_dev);
> +       acpi_register_lps0_dev(&pinctrl_amd_s2idle_dev_ops);
>
>         dev_dbg(&pdev->dev, "amd gpio driver loaded\n");
>         return ret;
> @@ -1199,6 +1226,7 @@ static void amd_gpio_remove(struct platform_device =
*pdev)
>
>         gpiochip_remove(&gpio_dev->gc);
>         acpi_unregister_wakeup_handler(amd_gpio_check_wake, gpio_dev);
> +       acpi_unregister_lps0_dev(&pinctrl_amd_s2idle_dev_ops);
>  }
>
>  #ifdef CONFIG_ACPI
> --

Applied as 6.15 material, thanks!

