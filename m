Return-Path: <linux-acpi+bounces-6016-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D54FB8D103F
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 00:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60BD81F21DFC
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 22:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5077815FA63;
	Mon, 27 May 2024 22:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="EJo0LY41"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A4017E908;
	Mon, 27 May 2024 22:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716849076; cv=none; b=iXxjlmaN76Jkoz9wvT6uPvRViuNHZyq5vVLFnpdMYLEUOOjk3tDHnS1xpRU0JpDMwX6Y++Y/qOl9YGjmw61tzbkG7jtF2lUyeBPSv0GOpzWBVHyhLFmYN1lf37wxE8ASe6fqbBK2QLH4egoGu9c6V8aw79WN86koJaNbYyLlV2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716849076; c=relaxed/simple;
	bh=4cA13FZ9TmOAvutjahbJ8v7gnLyVEbiI7r+Y2DyYYYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q5XQxq8VkCQ7c8Waw9PIFV/dNW4ZFBxn5xRKhbST+XkoHC5y4smCThoO44fmahdcZP72jzPcUtCewGjyntgKaDAJZDyvGvtp776TgDNCX1VPlotNu2a4W1/8X+rMQHp5+I59DxNVaBNc83chfOz2+XvMniKLpvLj7Y0JsVnZBbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=EJo0LY41; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716849043; x=1717453843; i=w_armin@gmx.de;
	bh=66TYJSn9JptMjs+p8Jc+Zw3QLUD8iSGd2JIT9o3TlIc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EJo0LY41898o+26Z1BP70zHRxV4sp0WAfsPdAe1RYEoY19+ioNHN+G7gBFMChyZ1
	 8b/ETfGxJeh/2jROlehR2vlZjKkFlup4muPks5M34uLDLizEp7vDcqNjYMEzhIYbT
	 HBCrWbSiI9DoFSBleYCYP9wOm6lPNMRCdWqM5PNqan20JLA5B2VhJnZ4hQAHMxLtk
	 Z6HLJybHl/FSXORtJlkM+BNNAiZ3XU8br6xOlo9Q+Xsxd6EhjecD3EGHuiHlrC8zO
	 8PHLZwcHr0zLnqnZkinBHDtJUnOYNfZJuwPu7MyMCbW1lJqpMLyipMYOGPAyoK4f0
	 SJkpPoPDGArhU0KS1g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M26r3-1sDdbm2VZZ-002WMb; Tue, 28
 May 2024 00:30:43 +0200
Message-ID: <92415bd8-4231-4c68-8034-e4f7a0ea5651@gmx.de>
Date: Tue, 28 May 2024 00:30:40 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] ACPI: fan: Add hwmon support
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: mlj@danelec.com, rafael.j.wysocki@intel.com, lenb@kernel.org,
 jdelvare@suse.com, andy.shevchenko@gmail.com, linux@roeck-us.net,
 linux@weissschuh.net, ilpo.jarvinen@linux.intel.com,
 linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20240510201242.3886-1-W_Armin@gmx.de>
 <CAJZ5v0gu=yvFeXH4uwHeAQZ8p1JyCs8uuiKzr6F+yNkD2E1ZAA@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAJZ5v0gu=yvFeXH4uwHeAQZ8p1JyCs8uuiKzr6F+yNkD2E1ZAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hj3rtn4ihhIVBSN/Pzecvvj2xd4xwuRfa+aBOhfYYOykb7kkt2s
 9T0mTzLIKD/ah/FGL/uGWM7zo23tZCEhXfH2M9snStt8ATxyAxJu/PoeYRpbwMR+m0f9Heg
 oD4EOPKEquER/f3W4Q54+l+ghkizu/G6KgtZaf2ASz10pvnw8Y4/Ui6EHFJ9wNz2vCLrgBS
 0rtmy5wqF/59l0juVjv2A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Cnb3Stt+/sk=;9pU19/U+URkSzIt0scNmrCv3Khd
 PU/4LTo7BVheKt6h1ZJ428Gd+1fqcHTGUl8BEnxuS6hwnT4iKawCGplw1nz00R5L2pr10FuEY
 lnsgRKZ3ubRXcYdb+HdjIZHAQEhBYfB6C6k4/YbI4eqREoYWNhABua5p0YMkTJSL07Q11ZK8v
 DhPQauV+t+xlH2h6oaJWlWVYdQus+NXGGzxHOG19xjC3YZN98Iy/hGs2gAWkv9STq6r52M+yc
 rHK0i/DhjG4g2gIxaYsIPzO7NKXTAuN+92uoU99OD5L3dwzqKA8z/rhQxmoG51CVtu5yHtjNY
 XAUJN/2D/fPQWpTLHc/pBjI5KqxLlIMkkEr2WD4AuaYolDRiqD645b72L5lcoxHOXyI3AZopg
 pP006fDRID3P+Az/OeJlZspJlGPkG8LGTNU34wCD2Xw2hm4GkCN26N2U0THDgtjK0XaGnfycv
 thgBMjJ36l56kS5z68QkmTW+PnVbW2Gnoeim/kXTzp827/DpnhVXdt1Eet6BJM4Q+GJm9Pxba
 V8Zcj48Hjlzh2yqTw45byItes/I7wHohVXlOGR59GXfP2DBu4RortczyHmdXL4XeIZGKuFNPG
 XydxYjteht9xT3sBhCm0YlLuBitBqtYrgrWs5poOX5qSKwk8I5YqdoKz6PEjHxclGiw6OhoBL
 /jW3lR4BqlNwkrlup0Mw7Hzbwhoi2M9ffSWgnso99nQT9JVAOds3T4xMS4LkKRtbzoyhCigIP
 xVjXqnukSH+VLLRh4BFclbbbJ/y+4bPxGPNQJv2vo+EtqPGkKTfrSrJuTe9ldmjHOoEJH2V3b
 GS8kWWurIKezuMCPeRyELMt1KDl80BDnBjqd/svlXs2gg=

Am 27.05.24 um 19:29 schrieb Rafael J. Wysocki:

> On Fri, May 10, 2024 at 10:13=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wro=
te:
>> Currently, the driver does only support a custom sysfs
>> interface to allow userspace to read the fan speed.
>> Add support for the standard hwmon interface so users
>> can read the fan speed with standard tools like "sensors".
>>
>> Reviewed-by: Andy Shevchenko <andy@kernel.org>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>> Tested witha custom ACPI SSDT, available here:
>> https://github.com/Wer-Wolf/acpi-fan-ssdt
>>
>> Changes since v7:
>> - add Reviewed-by tag
>> - spelling fixes
>> - add missing types.h include
>>
>> Changes since v6:
>> - add "hwmon" to the names of functions and variables
>> related to hwmon
>> - replace -ENODATA with -EIO/-ENODEV
>>
>> Changes since v5:
>> - fix coding style issues
>> - replace double break with return
>> - add missing includes
>>
>> Changes since v4:
>> - fix spelling issues
>> - check power values for overflow condition too
>>
>> Changes since v3:
>> - drop fault attrs
>> - rework initialization
>>
>> Changes since v2:
>> - add support for fanX_target and power attrs
>>
>> Changes since v1:
>> - fix undefined reference error
>> - fix fan speed validation
>> - coding style fixes
>> - clarify that the changes are compile-tested only
>> - add hwmon maintainers to cc list
>> ---
>>   drivers/acpi/Makefile    |   1 +
>>   drivers/acpi/fan.h       |   9 +++
>>   drivers/acpi/fan_core.c  |   4 +
>>   drivers/acpi/fan_hwmon.c | 170 ++++++++++++++++++++++++++++++++++++++=
+
>>   4 files changed, 184 insertions(+)
>>   create mode 100644 drivers/acpi/fan_hwmon.c
>>
>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>> index 39ea5cfa8326..61ca4afe83dc 100644
>> --- a/drivers/acpi/Makefile
>> +++ b/drivers/acpi/Makefile
>> @@ -77,6 +77,7 @@ obj-$(CONFIG_ACPI_TINY_POWER_BUTTON)  +=3D tiny-power=
-button.o
>>   obj-$(CONFIG_ACPI_FAN)         +=3D fan.o
>>   fan-objs                       :=3D fan_core.o
>>   fan-objs                       +=3D fan_attr.o
>> +fan-$(CONFIG_HWMON)            +=3D fan_hwmon.o
>>
>>   obj-$(CONFIG_ACPI_VIDEO)       +=3D video.o
>>   obj-$(CONFIG_ACPI_TAD)         +=3D acpi_tad.o
>> diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
>> index f89d19c922dc..db25a3898af7 100644
>> --- a/drivers/acpi/fan.h
>> +++ b/drivers/acpi/fan.h
>> @@ -10,6 +10,8 @@
>>   #ifndef _ACPI_FAN_H_
>>   #define _ACPI_FAN_H_
>>
>> +#include <linux/kconfig.h>
>> +
>>   #define ACPI_FAN_DEVICE_IDS    \
>>          {"INT3404", }, /* Fan */ \
>>          {"INTC1044", }, /* Fan for Tiger Lake generation */ \
>> @@ -57,4 +59,11 @@ struct acpi_fan {
>>   int acpi_fan_get_fst(struct acpi_device *device, struct acpi_fan_fst =
*fst);
>>   int acpi_fan_create_attributes(struct acpi_device *device);
>>   void acpi_fan_delete_attributes(struct acpi_device *device);
>> +
>> +#if IS_REACHABLE(CONFIG_HWMON)
>> +int devm_acpi_fan_create_hwmon(struct acpi_device *device);
>> +#else
>> +static inline int devm_acpi_fan_create_hwmon(struct acpi_device *devic=
e) { return 0; };
>> +#endif
>> +
>>   #endif
>> diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
>> index ff72e4ef8738..7cea4495f19b 100644
>> --- a/drivers/acpi/fan_core.c
>> +++ b/drivers/acpi/fan_core.c
>> @@ -336,6 +336,10 @@ static int acpi_fan_probe(struct platform_device *=
pdev)
>>                  if (result)
>>                          return result;
>>
>> +               result =3D devm_acpi_fan_create_hwmon(device);
>> +               if (result)
>> +                       return result;
>> +
>>                  result =3D acpi_fan_create_attributes(device);
>>                  if (result)
>>                          return result;
>> diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
>> new file mode 100644
>> index 000000000000..bd0d31a398fa
>> --- /dev/null
>> +++ b/drivers/acpi/fan_hwmon.c
>> @@ -0,0 +1,170 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * hwmon interface for the ACPI Fan driver.
>> + *
>> + * Copyright (C) 2024 Armin Wolf <W_Armin@gmx.de>
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/limits.h>
>> +#include <linux/types.h>
>> +#include <linux/units.h>
>> +
>> +#include "fan.h"
>> +
>> +/* Returned when the ACPI fan does not support speed reporting */
>> +#define FAN_SPEED_UNAVAILABLE  U32_MAX
>> +#define FAN_POWER_UNAVAILABLE  U32_MAX
>> +
>> +static struct acpi_fan_fps *acpi_fan_get_current_fps(struct acpi_fan *=
fan, u64 control)
>> +{
>> +       unsigned int i;
>> +
>> +       for (i =3D 0; i < fan->fps_count; i++) {
>> +               if (fan->fps[i].control =3D=3D control)
>> +                       return &fan->fps[i];
>> +       }
>> +
>> +       return NULL;
>> +}
>> +
>> +static umode_t acpi_fan_hwmon_is_visible(const void *drvdata, enum hwm=
on_sensor_types type,
>> +                                        u32 attr, int channel)
>> +{
>> +       const struct acpi_fan *fan =3D drvdata;
>> +       unsigned int i;
> AFAICS, the code below can be rewritten as follows:
>
> if (fan->fif.fine_grain_ctrl)
>           return 0;

Hi,

this would break hwmon_fan_input.

Thanks,
Armin Wolf

>
> switch (type) {
> case hwmon_fan:
>          if (attr =3D=3D hwmon_fan_input || attr =3D=3D hwmon_fan_target=
)
>                 return 0444;
>
>          return 0;
>
> case hwmon_power:
>          if (attr =3D=3D hwmon_power_input) {
>                 for (i =3D 0; i < fan->fps_count; i++) {
>                         if (fan->fps[i].power !=3D FAN_POWER_UNAVAILABLE=
)
>                                 return 0444;
>                 }
>          }
>
>          fallthrough;
> default:
>         return 0;
> }
>
> without changing functionality, which is both less duplication and
> fewer lines of code.
>
>> +
>> +       switch (type) {
>> +       case hwmon_fan:
>> +               switch (attr) {
>> +               case hwmon_fan_input:
>> +                       return 0444;
>> +               case hwmon_fan_target:
>> +                       /*
>> +                        * When in fine grain control mode, not every f=
an control value
>> +                        * has an associated fan performance state.
>> +                        */
>> +                       if (fan->fif.fine_grain_ctrl)
>> +                               return 0;
>> +
>> +                       return 0444;
>> +               default:
>> +                       return 0;
>> +               }
>> +       case hwmon_power:
>> +               switch (attr) {
>> +               case hwmon_power_input:
>> +                       /*
>> +                        * When in fine grain control mode, not every f=
an control value
>> +                        * has an associated fan performance state.
>> +                        */
>> +                       if (fan->fif.fine_grain_ctrl)
>> +                               return 0;
>> +
>> +                       /*
>> +                        * When all fan performance states contain no v=
alid power data,
>> +                        * when the associated attribute should not be =
created.
>> +                        */
>> +                       for (i =3D 0; i < fan->fps_count; i++) {
>> +                               if (fan->fps[i].power !=3D FAN_POWER_UN=
AVAILABLE)
>> +                                       return 0444;
>> +                       }
>> +
>> +                       return 0;
>> +               default:
>> +                       return 0;
>> +               }
>> +       default:
>> +               return 0;
>> +       }
>> +}
>> +
>> +static int acpi_fan_hwmon_read(struct device *dev, enum hwmon_sensor_t=
ypes type, u32 attr,
>> +                              int channel, long *val)
>> +{
>> +       struct acpi_device *adev =3D to_acpi_device(dev->parent);
>> +       struct acpi_fan *fan =3D dev_get_drvdata(dev);
>> +       struct acpi_fan_fps *fps;
>> +       struct acpi_fan_fst fst;
>> +       int ret;
>> +
>> +       ret =3D acpi_fan_get_fst(adev, &fst);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       switch (type) {
>> +       case hwmon_fan:
>> +               switch (attr) {
>> +               case hwmon_fan_input:
>> +                       if (fst.speed =3D=3D FAN_SPEED_UNAVAILABLE)
>> +                               return -ENODEV;
>> +
>> +                       if (fst.speed > LONG_MAX)
>> +                               return -EOVERFLOW;
>> +
>> +                       *val =3D fst.speed;
>> +                       return 0;
>> +               case hwmon_fan_target:
>> +                       fps =3D acpi_fan_get_current_fps(fan, fst.contr=
ol);
>> +                       if (!fps)
>> +                               return -EIO;
>> +
>> +                       if (fps->speed > LONG_MAX)
>> +                               return -EOVERFLOW;
>> +
>> +                       *val =3D fps->speed;
>> +                       return 0;
>> +               default:
>> +                       return -EOPNOTSUPP;
>> +               }
>> +       case hwmon_power:
>> +               switch (attr) {
>> +               case hwmon_power_input:
>> +                       fps =3D acpi_fan_get_current_fps(fan, fst.contr=
ol);
>> +                       if (!fps)
>> +                               return -EIO;
>> +
>> +                       if (fps->power =3D=3D FAN_POWER_UNAVAILABLE)
>> +                               return -ENODEV;
>> +
>> +                       if (fps->power > LONG_MAX / MICROWATT_PER_MILLI=
WATT)
>> +                               return -EOVERFLOW;
>> +
>> +                       *val =3D fps->power * MICROWATT_PER_MILLIWATT;
>> +                       return 0;
>> +               default:
>> +                       return -EOPNOTSUPP;
>> +               }
>> +       default:
>> +               return -EOPNOTSUPP;
>> +       }
>> +}
>> +
>> +static const struct hwmon_ops acpi_fan_hwmon_ops =3D {
>> +       .is_visible =3D acpi_fan_hwmon_is_visible,
>> +       .read =3D acpi_fan_hwmon_read,
>> +};
>> +
>> +static const struct hwmon_channel_info * const acpi_fan_hwmon_info[] =
=3D {
>> +       HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT | HWMON_F_TARGET),
>> +       HWMON_CHANNEL_INFO(power, HWMON_P_INPUT),
>> +       NULL
>> +};
>> +
>> +static const struct hwmon_chip_info acpi_fan_hwmon_chip_info =3D {
>> +       .ops =3D &acpi_fan_hwmon_ops,
>> +       .info =3D acpi_fan_hwmon_info,
>> +};
>> +
>> +int devm_acpi_fan_create_hwmon(struct acpi_device *device)
>> +{
>> +       struct acpi_fan *fan =3D acpi_driver_data(device);
>> +       struct device *hdev;
>> +
>> +       hdev =3D devm_hwmon_device_register_with_info(&device->dev, "ac=
pi_fan", fan,
>> +                                                   &acpi_fan_hwmon_chi=
p_info, NULL);
>> +       return PTR_ERR_OR_ZERO(hdev);
>> +}
>> --
>> 2.39.2
>>
>>

