Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19673E46A1
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2019 11:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438278AbfJYJGq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Oct 2019 05:06:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48757 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438235AbfJYJGq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 25 Oct 2019 05:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571994404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7fTgOTMBeF31B4vmWB9JS07f2fjdYULIg77zQQzJWV0=;
        b=VhEzACbmxuW3p9OQevQ6POlh3XQWnHQf+8TGH5m7LNn8AAKaBcnwonXOq6yqEpyDks2F9t
        348fN/LYomSX4N9D1O7Lr1T5u5tEBezETYCZ+txfVxWV5nKUeUMwALG5yBxFVhGo9v+NrL
        oPt8DlFjYg2ubrdel4gwYxLPqDl5CYM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-NArUVoQbMaSNudR3rRElLA-1; Fri, 25 Oct 2019 05:06:43 -0400
Received: by mail-wr1-f72.google.com with SMTP id h4so693475wrx.15
        for <linux-acpi@vger.kernel.org>; Fri, 25 Oct 2019 02:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QAaGwMo3n+rr2aQNEdB20hiTv23JYLyYkwDVMy7rmpY=;
        b=rqHujtUXim7ugUKqAk8MY5LNp127wCcOyj6cSFqNoCZSwZOsBSu+ADoxOfP+FKgHad
         ORJp7P71XcP1rK0u2h0Fm/vC4aBLnH3Xdp893REVeMsAg+tPaGedXdHItTfDt35ylMgQ
         QN3aXqE4EwQzgRpR/7M0wFopZJn1b3oktFa0wrdN8W7eHeDKzb/aDNEvGu7OM0pSDAP+
         kxf+Ut+ou3doB1pLlsmaI6x024pbUva9F37Uf8osqAQzKDLj2/RGeDDMZcJG9oZKkKeQ
         XOfy+K6oRbvZd/7sZdNqkWzYJBHsBJm2lejfYMPwI9rPyYC8DjnuzlJajXh9/qiM8xXe
         36Qw==
X-Gm-Message-State: APjAAAUfPCah5gQ7oxGtbWe5Z0QYISrrMgccoCBgt6clUf3LcojZgCcf
        FmgoTdCVNKoH8xfnZJQ6hxkINY/4LJGRRoGphOY3zKPuaArVDc7xnXdzQEvLnwavzKVSSBUA/Xf
        sZqJDs1LCpESFHnBshuceaw==
X-Received: by 2002:a1c:49c2:: with SMTP id w185mr2409618wma.16.1571994401827;
        Fri, 25 Oct 2019 02:06:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyhMGKrNBdso6mcA1iGrIvyQtimRFR80K0kW8QMex0xxsM7pKZ+OjmD8wQ9Ylzt+nw5TTn+8Q==
X-Received: by 2002:a1c:49c2:: with SMTP id w185mr2409583wma.16.1571994401531;
        Fri, 25 Oct 2019 02:06:41 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id a9sm2654827wmf.14.2019.10.25.02.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 02:06:40 -0700 (PDT)
Subject: Re: [PATCH 3/4] ACPI / PMIC: Add Cherry Trail Crystal Cove PMIC
 OpRegion driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191024213827.144974-1-hdegoede@redhat.com>
 <20191024213827.144974-4-hdegoede@redhat.com>
 <20191025074518.GZ32742@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <230f4820-688f-4b04-ee62-771486fcfa63@redhat.com>
Date:   Fri, 25 Oct 2019 11:06:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025074518.GZ32742@smile.fi.intel.com>
Content-Language: en-US
X-MC-Unique: NArUVoQbMaSNudR3rRElLA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 25-10-2019 09:45, Andy Shevchenko wrote:
> On Thu, Oct 24, 2019 at 11:38:26PM +0200, Hans de Goede wrote:
>> We have no docs for the CHT Crystal Cove PMIC. The Asus Zenfone-2 kernel
>> code has 2 Crystal Cove regulator drivers, one calls the PMIC a "Crystal
>> Cove Plus" PMIC and talks about Cherry Trail, so presuambly that one
>> could be used to get register info for the regulators if we need to
>> implement regulator support in the future.
>>
>> For now the sole purpose of this driver is to make
>> intel_soc_pmic_exec_mipi_pmic_seq_element work on devices with a
>> CHT Crystal Cove PMIC.
>>
>> Specifically this fixes the following MIPI PMIC sequence related errors
>> on e.g. an Asus T100HA:
>>
>> [  178.211801] intel_soc_pmic_exec_mipi_pmic_seq_element: No PMIC regist=
ered
>> [  178.211897] [drm:intel_dsi_dcs_init_backlight_funcs [i915]] *ERROR* m=
ipi_exec_pmic failed, error: -6
>>
>=20
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> as long as name pattern uses "chtcc".

As I already replied to your other similar remark, I would really like to
stick with crc, crc to me means either crystal-cove or well a crc, cc trigg=
ers
different associations in my mind. Also other crystal-cove files also use c=
rc
in their filename. Or alternatively we could just write out crystalcove lik=
e the
gpio driver does: drivers/gpio/gpio-crystalcove.c

Regards,

Hans



>=20
>=20
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/acpi/Kconfig                  |  7 +++++
>>   drivers/acpi/Makefile                 |  1 +
>>   drivers/acpi/pmic/intel_pmic_chtcrc.c | 44 +++++++++++++++++++++++++++
>>   3 files changed, 52 insertions(+)
>>   create mode 100644 drivers/acpi/pmic/intel_pmic_chtcrc.c
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index 089f7f8e1be7..0f23d8b22c42 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -520,6 +520,13 @@ config BYTCRC_PMIC_OPREGION
>>   =09  This config adds ACPI operation region support for the Bay Trail
>>   =09  version of the Crystal Cove PMIC.
>>  =20
>> +config CHTCRC_PMIC_OPREGION
>> +=09bool "ACPI operation region support for Cherry Trail Crystal Cove PM=
IC"
>> +=09depends on INTEL_SOC_PMIC
>> +=09help
>> +=09  This config adds ACPI operation region support for the Cherry Trai=
l
>> +=09  version of the Crystal Cove PMIC.
>> +
>>   config XPOWER_PMIC_OPREGION
>>   =09bool "ACPI operation region support for XPower AXP288 PMIC"
>>   =09depends on MFD_AXP20X_I2C && IOSF_MBI=3Dy
>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>> index ee59b1db69a1..68853f23e901 100644
>> --- a/drivers/acpi/Makefile
>> +++ b/drivers/acpi/Makefile
>> @@ -110,6 +110,7 @@ obj-$(CONFIG_ACPI_EXTLOG)=09+=3D acpi_extlog.o
>>  =20
>>   obj-$(CONFIG_PMIC_OPREGION)=09+=3D pmic/intel_pmic.o
>>   obj-$(CONFIG_BYTCRC_PMIC_OPREGION) +=3D pmic/intel_pmic_bytcrc.o
>> +obj-$(CONFIG_CHTCRC_PMIC_OPREGION) +=3D pmic/intel_pmic_chtcrc.o
>>   obj-$(CONFIG_XPOWER_PMIC_OPREGION) +=3D pmic/intel_pmic_xpower.o
>>   obj-$(CONFIG_BXT_WC_PMIC_OPREGION) +=3D pmic/intel_pmic_bxtwc.o
>>   obj-$(CONFIG_CHT_WC_PMIC_OPREGION) +=3D pmic/intel_pmic_chtwc.o
>> diff --git a/drivers/acpi/pmic/intel_pmic_chtcrc.c b/drivers/acpi/pmic/i=
ntel_pmic_chtcrc.c
>> new file mode 100644
>> index 000000000000..ebf8d3187df1
>> --- /dev/null
>> +++ b/drivers/acpi/pmic/intel_pmic_chtcrc.c
>> @@ -0,0 +1,44 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Intel Cherry Trail Crystal Cove PMIC operation region driver
>> + *
>> + * Copyright (C) 2019 Hans de Goede <hdegoede@redhat.com>
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/init.h>
>> +#include <linux/mfd/intel_soc_pmic.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include "intel_pmic.h"
>> +
>> +/*
>> + * We have no docs for the CHT Crystal Cove PMIC. The Asus Zenfone-2 ke=
rnel
>> + * code has 2 Crystal Cove regulator drivers, one calls the PMIC a "Cry=
stal
>> + * Cove Plus" PMIC and talks about Cherry Trail, so presuambly that one
>> + * could be used to get register info for the regulators if we need to
>> + * implement regulator support in the future.
>> + *
>> + * For now the sole purpose of this driver is to make
>> + * intel_soc_pmic_exec_mipi_pmic_seq_element work on devices with a
>> + * CHT Crystal Cove PMIC.
>> + */
>> +static struct intel_pmic_opregion_data intel_chtcrc_pmic_opregion_data =
=3D {
>> +=09.pmic_i2c_address =3D 0x6e,
>> +};
>> +
>> +static int intel_chtcrc_pmic_opregion_probe(struct platform_device *pde=
v)
>> +{
>> +=09struct intel_soc_pmic *pmic =3D dev_get_drvdata(pdev->dev.parent);
>> +=09return intel_pmic_install_opregion_handler(&pdev->dev,
>> +=09=09=09ACPI_HANDLE(pdev->dev.parent), pmic->regmap,
>> +=09=09=09&intel_chtcrc_pmic_opregion_data);
>> +}
>> +
>> +static struct platform_driver intel_chtcrc_pmic_opregion_driver =3D {
>> +=09.probe =3D intel_chtcrc_pmic_opregion_probe,
>> +=09.driver =3D {
>> +=09=09.name =3D "cht_crystal_cove_pmic",
>> +=09},
>> +};
>> +builtin_platform_driver(intel_chtcrc_pmic_opregion_driver);
>> --=20
>> 2.23.0
>>
>=20

