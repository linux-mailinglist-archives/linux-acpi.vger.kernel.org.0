Return-Path: <linux-acpi+bounces-5949-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 126AC8CC796
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 22:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911791F21DBD
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 20:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DA57BB01;
	Wed, 22 May 2024 20:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="RvJlX+PP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FD5F4E7;
	Wed, 22 May 2024 20:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716408184; cv=none; b=sugVmp0EuDejXKpXsDN74La9/kR5H4UD4rlyuhi210f/FK7wzzYICQePRSzeEep1idmOWIa5q5qtglqRKiyC71ESUD0hmjGw1dpijsMGUYGh862Ch6DI19xgKm19OEU+Jy1gRaIENkWY9haoLHaaq2XfcUS97tjQnTgUutUo1PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716408184; c=relaxed/simple;
	bh=jNKlytWPZ3+WmG+/GqQYphCPwvIgOyC5WTdjKPOhe+I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MbhaiDOytdwE+XnAY8OlehU8fy8syh+va4B8nVOIJ2L3XnX/j7Wf+5D9yO/GW6fXhmBCx2F+z8cRa7fENIronCBcuh6LrcIviaaNKr8tAiPH57jymOXXkNQF7QvESCpU2etG8K50shR4eDbMdhfT/AXrK9/KstDq607CWzgOAeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=RvJlX+PP; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716408151; x=1717012951; i=w_armin@gmx.de;
	bh=EbSXLEhfNyBHfkLFgmwPIj65TlIj7Ja/Zl7ricA2EOU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RvJlX+PP2cvaX6Lyl0WH3JOmQwxIcvzZeB8MRJgeBWia6TYwisBqTrEXBFJrlxzz
	 MfTnTEVKTBbTEMiKoipSHpnTHyqaRVlLJR5fEGhoqX76sY7+9Y7vcGZWxBL0wRqUM
	 r9QCsG9yuMBTUGfOTh5u1IPI+WfSDkYPw4QerbHx3LxNEE9FHItYcN+ybtG12idIC
	 gY5mhBXYQW3Owrm9YX+feqVdEJjpmDz7krvuhE6+H0thzWvLBSA2yfGI2RuCbmTgZ
	 3kuTghs9p6UKmm+jdz7gB8QCQrbwD0oH/PzNwwrzuTZqLa/ROkfT1fgfaJPXvVqmW
	 k5AdB2gCedrlfp5Hsg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6Udt-1sCM4V3AfR-005Y0M; Wed, 22
 May 2024 22:02:30 +0200
Message-ID: <9d3f6b81-c53f-4ccf-9cb7-d997ba8957c7@gmx.de>
Date: Wed, 22 May 2024 22:02:26 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] ACPI: fan: Add hwmon support
From: Armin Wolf <W_Armin@gmx.de>
To: mlj@danelec.com, rafael.j.wysocki@intel.com, lenb@kernel.org
Cc: jdelvare@suse.com, andy.shevchenko@gmail.com, linux@roeck-us.net,
 linux@weissschuh.net, ilpo.jarvinen@linux.intel.com,
 linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20240510201242.3886-1-W_Armin@gmx.de>
Content-Language: en-US
In-Reply-To: <20240510201242.3886-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ZTun4CDbetuEEMYOOx42fe9A7CGEQ7l3Q91puhIFMKGtYi5aTJB
 EsfocdUIssccvIRbqhWimLezF4fBzLZaNPlk1+QZf5IHFB/cwCi5JtMWJho8vGyqVRi8vaI
 T6u9Y4zjAxHktXzHBw3p1HFeMSrC3fa9U2sc2qod/Rss88e8GlajZsAu5RVDdqvjVZqa16o
 rokH91drPAZfKcHHaIE7w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4yMaB1c4pl0=;+Wz8Sw8MDKD2IlnpD5+gfU6yap9
 T5kTzZ07WH+rlsL7571wxEGzI4VxTOcp/ahPI/XrS/Pirb/T7ptDVWdSqDyIDKR4GNnvd9vEH
 UVA/v9SyLJLgOm+EYCySMLCPYwsvhHAg6Dfy0huY6OhkMDXcTAU82OinMGZKAyKj5/FFDiL2l
 nKJMEfl5yniWJa3nxW8kOWJG9uESDm6lT6n04LfWiPO3c9etKPuTu8NEGUR1n/Onuj5dldYz2
 TCHDgU18xIRoYes67XQzA0jRpUCPBa4vR9FabexP9D2icxQJVhmJhadSBaI9EComH740Zv3AL
 Ono3BO0TQBihw0TcHQpX99wUuNcrYYuRk+bf1YrtViVDNMSlBcG6TPZcnE8+fmZsJqbUevaOz
 IoNnTfOEi1/owf41j/xA4nqEfxdpGgNdZTbk7iqU83czlfiWi5AMXrvOh+2q2GkppCjXw7NHk
 he8o8HY3/9k/+Uj2AE/VCueCQ2Rj5I8lS5XFWaO2BxIpz3p54ixae3cuksINW7K+00hcl3q1A
 zXtVF120Hb+xWtsmSeEEXz7oFbwBg3Htngx2rf5z/WJZlD/AQERKyu3mrjplpVk63FLw8pd9u
 RNIVFiav2EvTVElCeHi9FfN2Ic+gjduyNMzsBLXGQlRG7Z40YWQPGGwziXLHnvNLMI8NOu7rW
 pB/8UG/WzidII756zWMYn/FKf9o7XQuqOvEe8ym6Zz8BbMijOJ8pqdVm3GmwzKBulVUYknCay
 c5D72byeN/bz/UOxBnKHLgHPO7kDNrFegMEEfkUBQzWqGMmLtJl+22j/9FugX2JrpaGPnr7qS
 FHDS+J7g+UXPMk4gLB+QsRAaa6+pZOgK+rKRgxFuVV5mM=

Am 10.05.24 um 22:12 schrieb Armin Wolf:

> Currently, the driver does only support a custom sysfs
> interface to allow userspace to read the fan speed.
> Add support for the standard hwmon interface so users
> can read the fan speed with standard tools like "sensors".
>
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Hi,

what is the current status of this?

Thanks,
Armin Wolf

> ---
> Tested witha custom ACPI SSDT, available here:
> https://github.com/Wer-Wolf/acpi-fan-ssdt
>
> Changes since v7:
> - add Reviewed-by tag
> - spelling fixes
> - add missing types.h include
>
> Changes since v6:
> - add "hwmon" to the names of functions and variables
> related to hwmon
> - replace -ENODATA with -EIO/-ENODEV
>
> Changes since v5:
> - fix coding style issues
> - replace double break with return
> - add missing includes
>
> Changes since v4:
> - fix spelling issues
> - check power values for overflow condition too
>
> Changes since v3:
> - drop fault attrs
> - rework initialization
>
> Changes since v2:
> - add support for fanX_target and power attrs
>
> Changes since v1:
> - fix undefined reference error
> - fix fan speed validation
> - coding style fixes
> - clarify that the changes are compile-tested only
> - add hwmon maintainers to cc list
> ---
>   drivers/acpi/Makefile    |   1 +
>   drivers/acpi/fan.h       |   9 +++
>   drivers/acpi/fan_core.c  |   4 +
>   drivers/acpi/fan_hwmon.c | 170 +++++++++++++++++++++++++++++++++++++++
>   4 files changed, 184 insertions(+)
>   create mode 100644 drivers/acpi/fan_hwmon.c
>
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 39ea5cfa8326..61ca4afe83dc 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -77,6 +77,7 @@ obj-$(CONFIG_ACPI_TINY_POWER_BUTTON)	+= tiny-power-button.o
>   obj-$(CONFIG_ACPI_FAN)		+= fan.o
>   fan-objs			:= fan_core.o
>   fan-objs			+= fan_attr.o
> +fan-$(CONFIG_HWMON)		+= fan_hwmon.o
>
>   obj-$(CONFIG_ACPI_VIDEO)	+= video.o
>   obj-$(CONFIG_ACPI_TAD)		+= acpi_tad.o
> diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
> index f89d19c922dc..db25a3898af7 100644
> --- a/drivers/acpi/fan.h
> +++ b/drivers/acpi/fan.h
> @@ -10,6 +10,8 @@
>   #ifndef _ACPI_FAN_H_
>   #define _ACPI_FAN_H_
>
> +#include <linux/kconfig.h>
> +
>   #define ACPI_FAN_DEVICE_IDS	\
>   	{"INT3404", }, /* Fan */ \
>   	{"INTC1044", }, /* Fan for Tiger Lake generation */ \
> @@ -57,4 +59,11 @@ struct acpi_fan {
>   int acpi_fan_get_fst(struct acpi_device *device, struct acpi_fan_fst *fst);
>   int acpi_fan_create_attributes(struct acpi_device *device);
>   void acpi_fan_delete_attributes(struct acpi_device *device);
> +
> +#if IS_REACHABLE(CONFIG_HWMON)
> +int devm_acpi_fan_create_hwmon(struct acpi_device *device);
> +#else
> +static inline int devm_acpi_fan_create_hwmon(struct acpi_device *device) { return 0; };
> +#endif
> +
>   #endif
> diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
> index ff72e4ef8738..7cea4495f19b 100644
> --- a/drivers/acpi/fan_core.c
> +++ b/drivers/acpi/fan_core.c
> @@ -336,6 +336,10 @@ static int acpi_fan_probe(struct platform_device *pdev)
>   		if (result)
>   			return result;
>
> +		result = devm_acpi_fan_create_hwmon(device);
> +		if (result)
> +			return result;
> +
>   		result = acpi_fan_create_attributes(device);
>   		if (result)
>   			return result;
> diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
> new file mode 100644
> index 000000000000..bd0d31a398fa
> --- /dev/null
> +++ b/drivers/acpi/fan_hwmon.c
> @@ -0,0 +1,170 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * hwmon interface for the ACPI Fan driver.
> + *
> + * Copyright (C) 2024 Armin Wolf <W_Armin@gmx.de>
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/hwmon.h>
> +#include <linux/limits.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +
> +#include "fan.h"
> +
> +/* Returned when the ACPI fan does not support speed reporting */
> +#define FAN_SPEED_UNAVAILABLE	U32_MAX
> +#define FAN_POWER_UNAVAILABLE	U32_MAX
> +
> +static struct acpi_fan_fps *acpi_fan_get_current_fps(struct acpi_fan *fan, u64 control)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < fan->fps_count; i++) {
> +		if (fan->fps[i].control == control)
> +			return &fan->fps[i];
> +	}
> +
> +	return NULL;
> +}
> +
> +static umode_t acpi_fan_hwmon_is_visible(const void *drvdata, enum hwmon_sensor_types type,
> +					 u32 attr, int channel)
> +{
> +	const struct acpi_fan *fan = drvdata;
> +	unsigned int i;
> +
> +	switch (type) {
> +	case hwmon_fan:
> +		switch (attr) {
> +		case hwmon_fan_input:
> +			return 0444;
> +		case hwmon_fan_target:
> +			/*
> +			 * When in fine grain control mode, not every fan control value
> +			 * has an associated fan performance state.
> +			 */
> +			if (fan->fif.fine_grain_ctrl)
> +				return 0;
> +
> +			return 0444;
> +		default:
> +			return 0;
> +		}
> +	case hwmon_power:
> +		switch (attr) {
> +		case hwmon_power_input:
> +			/*
> +			 * When in fine grain control mode, not every fan control value
> +			 * has an associated fan performance state.
> +			 */
> +			if (fan->fif.fine_grain_ctrl)
> +				return 0;
> +
> +			/*
> +			 * When all fan performance states contain no valid power data,
> +			 * when the associated attribute should not be created.
> +			 */
> +			for (i = 0; i < fan->fps_count; i++) {
> +				if (fan->fps[i].power != FAN_POWER_UNAVAILABLE)
> +					return 0444;
> +			}
> +
> +			return 0;
> +		default:
> +			return 0;
> +		}
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int acpi_fan_hwmon_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> +			       int channel, long *val)
> +{
> +	struct acpi_device *adev = to_acpi_device(dev->parent);
> +	struct acpi_fan *fan = dev_get_drvdata(dev);
> +	struct acpi_fan_fps *fps;
> +	struct acpi_fan_fst fst;
> +	int ret;
> +
> +	ret = acpi_fan_get_fst(adev, &fst);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (type) {
> +	case hwmon_fan:
> +		switch (attr) {
> +		case hwmon_fan_input:
> +			if (fst.speed == FAN_SPEED_UNAVAILABLE)
> +				return -ENODEV;
> +
> +			if (fst.speed > LONG_MAX)
> +				return -EOVERFLOW;
> +
> +			*val = fst.speed;
> +			return 0;
> +		case hwmon_fan_target:
> +			fps = acpi_fan_get_current_fps(fan, fst.control);
> +			if (!fps)
> +				return -EIO;
> +
> +			if (fps->speed > LONG_MAX)
> +				return -EOVERFLOW;
> +
> +			*val = fps->speed;
> +			return 0;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	case hwmon_power:
> +		switch (attr) {
> +		case hwmon_power_input:
> +			fps = acpi_fan_get_current_fps(fan, fst.control);
> +			if (!fps)
> +				return -EIO;
> +
> +			if (fps->power == FAN_POWER_UNAVAILABLE)
> +				return -ENODEV;
> +
> +			if (fps->power > LONG_MAX / MICROWATT_PER_MILLIWATT)
> +				return -EOVERFLOW;
> +
> +			*val = fps->power * MICROWATT_PER_MILLIWATT;
> +			return 0;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static const struct hwmon_ops acpi_fan_hwmon_ops = {
> +	.is_visible = acpi_fan_hwmon_is_visible,
> +	.read = acpi_fan_hwmon_read,
> +};
> +
> +static const struct hwmon_channel_info * const acpi_fan_hwmon_info[] = {
> +	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT | HWMON_F_TARGET),
> +	HWMON_CHANNEL_INFO(power, HWMON_P_INPUT),
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info acpi_fan_hwmon_chip_info = {
> +	.ops = &acpi_fan_hwmon_ops,
> +	.info = acpi_fan_hwmon_info,
> +};
> +
> +int devm_acpi_fan_create_hwmon(struct acpi_device *device)
> +{
> +	struct acpi_fan *fan = acpi_driver_data(device);
> +	struct device *hdev;
> +
> +	hdev = devm_hwmon_device_register_with_info(&device->dev, "acpi_fan", fan,
> +						    &acpi_fan_hwmon_chip_info, NULL);
> +	return PTR_ERR_OR_ZERO(hdev);
> +}
> --
> 2.39.2
>
>

