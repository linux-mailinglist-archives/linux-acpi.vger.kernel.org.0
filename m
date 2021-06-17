Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E766B3AB219
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jun 2021 13:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhFQLQ2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Jun 2021 07:16:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55311 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231501AbhFQLQ0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Jun 2021 07:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623928458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UShfFP0yGU8xaRFO0Sd23m6zKnfLcJDtjSbsNFViaSE=;
        b=b6eGQmWmjVWh1uBUnmLDI67bUD/uHf4J+LTuFs1ySHmyHD2zleyB9IErsltBenDsFXiIdH
        SFNmomn5+Ga3Wdfl0lVNdJjfJR54ZP12kUnaZydt4B744JCHaiA986HQLfJfyVysw/5zxi
        6yU49bu3SHpufRCep4vO+OchtAAFZeY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-iqBjSx7_P9aX-2owikZS4A-1; Thu, 17 Jun 2021 07:14:16 -0400
X-MC-Unique: iqBjSx7_P9aX-2owikZS4A-1
Received: by mail-ej1-f69.google.com with SMTP id f1-20020a1709064941b02903f6b5ef17bfso2010904ejt.20
        for <linux-acpi@vger.kernel.org>; Thu, 17 Jun 2021 04:14:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UShfFP0yGU8xaRFO0Sd23m6zKnfLcJDtjSbsNFViaSE=;
        b=qlH7bLvvNnwm3IvMBqEqol2nLHOjepi8hanIYhk+j9gQjpkXOPl/t5Mv8yJ0zCR7k7
         5kxwP6VsHWjWs6hwaq7NDorzkYzVVZD+dINAI87GgpGAEiAbUBbEXYzwtVcZB2U4CmoX
         nubRRMz7cKZiBL9QEjzWtXtyMtXE72bUl++x28CqT2qOzYC/fB5eTbVDm/vHBwayVO8v
         M5jj4gyyvcHBzLjxl8NtXHkSycC2YkQyi9/O9pin3L5zmcMsASsi1eFiSKrFywjRfD+f
         tfoftjqDkWJu11qSVOBOGR2hC4kcIWl24YaIewDTF5NXKzLKZ1/PyauVwINGyE58BHW6
         tZAA==
X-Gm-Message-State: AOAM530KcySTge3/z0ZE5hkFGN0YG4iLuZo+YNQS5SVvqh8KwSDczB0K
        JhtrJ/KfPmt642Gp7U+C6gg4xDyK+uJ5uq7rsR30RTiwY0LjyMwU1d63RGCKc6A9OuZxL0koPl+
        0EAjyycfyf1sta1Jey6M6VQ==
X-Received: by 2002:a05:6402:518a:: with SMTP id q10mr5854961edd.198.1623928455783;
        Thu, 17 Jun 2021 04:14:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIW5ArmRxaDEzKHF3ObIivFWgmTxdnHyFD1/J1dazYNKKybZCVI/wY7eL/o+yNC93TJ0levw==
X-Received: by 2002:a05:6402:518a:: with SMTP id q10mr5854931edd.198.1623928455570;
        Thu, 17 Jun 2021 04:14:15 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id m11sm607521ejl.102.2021.06.17.04.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 04:14:14 -0700 (PDT)
Subject: Re: [PATCH v5 6/6] mfd: tps68470: Remove tps68470 MFD driver
To:     Daniel Scally <djrscally@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, devel@acpica.org
Cc:     Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Wolfram Sang <wsa@kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20210603224007.120560-1-djrscally@gmail.com>
 <20210603224007.120560-7-djrscally@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4083819a-eabf-fb2d-2ce8-5f6a409c69a0@redhat.com>
Date:   Thu, 17 Jun 2021 13:14:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210603224007.120560-7-djrscally@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/4/21 12:40 AM, Daniel Scally wrote:
> This driver only covered one scenario in which ACPI devices with _HID
> INT3472 are found, and its functionality has been taken over by the
> intel-skl-int3472 module, so remove it.
> 
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Daniel Scally <djrscally@gmail.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
> Changes since v4:
> 	- None
> 
>  drivers/acpi/pmic/Kconfig |  2 +-
>  drivers/gpio/Kconfig      |  2 +-
>  drivers/mfd/Kconfig       | 18 --------
>  drivers/mfd/Makefile      |  1 -
>  drivers/mfd/tps68470.c    | 97 ---------------------------------------
>  5 files changed, 2 insertions(+), 118 deletions(-)
>  delete mode 100644 drivers/mfd/tps68470.c
> 
> diff --git a/drivers/acpi/pmic/Kconfig b/drivers/acpi/pmic/Kconfig
> index 56bbcb2ce61b..f84b8f6038dc 100644
> --- a/drivers/acpi/pmic/Kconfig
> +++ b/drivers/acpi/pmic/Kconfig
> @@ -52,7 +52,7 @@ endif	# PMIC_OPREGION
>  
>  config TPS68470_PMIC_OPREGION
>  	bool "ACPI operation region support for TPS68470 PMIC"
> -	depends on MFD_TPS68470
> +	depends on INTEL_SKL_INT3472
>  	help
>  	  This config adds ACPI operation region support for TI TPS68470 PMIC.
>  	  TPS68470 device is an advanced power management unit that powers
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 1dd0ec6727fd..10228abeee56 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1367,7 +1367,7 @@ config GPIO_TPS65912
>  
>  config GPIO_TPS68470
>  	bool "TPS68470 GPIO"
> -	depends on MFD_TPS68470
> +	depends on INTEL_SKL_INT3472
>  	help
>  	  Select this option to enable GPIO driver for the TPS68470
>  	  chip family.
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 5c7f2b100191..99c4e1a80ae0 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1499,24 +1499,6 @@ config MFD_TPS65217
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called tps65217.
>  
> -config MFD_TPS68470
> -	bool "TI TPS68470 Power Management / LED chips"
> -	depends on ACPI && PCI && I2C=y
> -	depends on I2C_DESIGNWARE_PLATFORM=y
> -	select MFD_CORE
> -	select REGMAP_I2C
> -	help
> -	  If you say yes here you get support for the TPS68470 series of
> -	  Power Management / LED chips.
> -
> -	  These include voltage regulators, LEDs and other features
> -	  that are often used in portable devices.
> -
> -	  This option is a bool as it provides an ACPI operation
> -	  region, which must be available before any of the devices
> -	  using this are probed. This option also configures the
> -	  designware-i2c driver to be built-in, for the same reason.
> -
>  config MFD_TI_LP873X
>  	tristate "TI LP873X Power Management IC"
>  	depends on I2C
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 4f6d2b8a5f76..8b322d89a0c5 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -105,7 +105,6 @@ obj-$(CONFIG_MFD_TPS65910)	+= tps65910.o
>  obj-$(CONFIG_MFD_TPS65912)	+= tps65912-core.o
>  obj-$(CONFIG_MFD_TPS65912_I2C)	+= tps65912-i2c.o
>  obj-$(CONFIG_MFD_TPS65912_SPI)  += tps65912-spi.o
> -obj-$(CONFIG_MFD_TPS68470)	+= tps68470.o
>  obj-$(CONFIG_MFD_TPS80031)	+= tps80031.o
>  obj-$(CONFIG_MENELAUS)		+= menelaus.o
>  
> diff --git a/drivers/mfd/tps68470.c b/drivers/mfd/tps68470.c
> deleted file mode 100644
> index 4a4df4ffd18c..000000000000
> --- a/drivers/mfd/tps68470.c
> +++ /dev/null
> @@ -1,97 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * TPS68470 chip Parent driver
> - *
> - * Copyright (C) 2017 Intel Corporation
> - *
> - * Authors:
> - *	Rajmohan Mani <rajmohan.mani@intel.com>
> - *	Tianshu Qiu <tian.shu.qiu@intel.com>
> - *	Jian Xu Zheng <jian.xu.zheng@intel.com>
> - *	Yuning Pu <yuning.pu@intel.com>
> - */
> -
> -#include <linux/acpi.h>
> -#include <linux/delay.h>
> -#include <linux/i2c.h>
> -#include <linux/init.h>
> -#include <linux/mfd/core.h>
> -#include <linux/mfd/tps68470.h>
> -#include <linux/regmap.h>
> -
> -static const struct mfd_cell tps68470s[] = {
> -	{ .name = "tps68470-gpio" },
> -	{ .name = "tps68470_pmic_opregion" },
> -};
> -
> -static const struct regmap_config tps68470_regmap_config = {
> -	.reg_bits = 8,
> -	.val_bits = 8,
> -	.max_register = TPS68470_REG_MAX,
> -};
> -
> -static int tps68470_chip_init(struct device *dev, struct regmap *regmap)
> -{
> -	unsigned int version;
> -	int ret;
> -
> -	/* Force software reset */
> -	ret = regmap_write(regmap, TPS68470_REG_RESET, TPS68470_REG_RESET_MASK);
> -	if (ret)
> -		return ret;
> -
> -	ret = regmap_read(regmap, TPS68470_REG_REVID, &version);
> -	if (ret) {
> -		dev_err(dev, "Failed to read revision register: %d\n", ret);
> -		return ret;
> -	}
> -
> -	dev_info(dev, "TPS68470 REVID: 0x%x\n", version);
> -
> -	return 0;
> -}
> -
> -static int tps68470_probe(struct i2c_client *client)
> -{
> -	struct device *dev = &client->dev;
> -	struct regmap *regmap;
> -	int ret;
> -
> -	regmap = devm_regmap_init_i2c(client, &tps68470_regmap_config);
> -	if (IS_ERR(regmap)) {
> -		dev_err(dev, "devm_regmap_init_i2c Error %ld\n",
> -			PTR_ERR(regmap));
> -		return PTR_ERR(regmap);
> -	}
> -
> -	i2c_set_clientdata(client, regmap);
> -
> -	ret = tps68470_chip_init(dev, regmap);
> -	if (ret < 0) {
> -		dev_err(dev, "TPS68470 Init Error %d\n", ret);
> -		return ret;
> -	}
> -
> -	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, tps68470s,
> -			      ARRAY_SIZE(tps68470s), NULL, 0, NULL);
> -	if (ret < 0) {
> -		dev_err(dev, "devm_mfd_add_devices failed: %d\n", ret);
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -static const struct acpi_device_id tps68470_acpi_ids[] = {
> -	{"INT3472"},
> -	{},
> -};
> -
> -static struct i2c_driver tps68470_driver = {
> -	.driver = {
> -		   .name = "tps68470",
> -		   .acpi_match_table = tps68470_acpi_ids,
> -	},
> -	.probe_new = tps68470_probe,
> -};
> -builtin_i2c_driver(tps68470_driver);
> 

