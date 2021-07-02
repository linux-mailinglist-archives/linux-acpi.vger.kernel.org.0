Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0466D3BA364
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jul 2021 18:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhGBQ5i (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Jul 2021 12:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhGBQ5h (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jul 2021 12:57:37 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75DDC061762
        for <linux-acpi@vger.kernel.org>; Fri,  2 Jul 2021 09:55:05 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id f20so1533082pfa.1
        for <linux-acpi@vger.kernel.org>; Fri, 02 Jul 2021 09:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IhfIB41B0pb5T84jhbuhAWo3M3hfB4nmcUtFAyIplM8=;
        b=avO1FLC92a9FeSdagjV/UlKfGWQzb/+CCziVxDmr3t++65UmKiuywrxRDqlKl9VFMK
         HZ8ZMulLz4Q0OWaffx8jtHpL1rEGqsdMHCdWlOLFl4mcjqD7xjkVkQ+XEA7L6QIl86pn
         KB9fIZpu+/9YeZc2JtbuXYQJlCP7gP6d2ntidwjYmWnp5Xdwd2HwWLu/XFAKOXcKXLFl
         F9xwOAGEMH5XgSL9rR3c1lAPNzwD26pIKbOLAX+a2G+cqY42vcJMbLrkiQmfpz9xI90s
         hPj7/PKzvSD4Sja0unXp0zMYO4Jzqa3nzZsxORWnacioSJKJx/1PVHqiG3z0ogAjTu0i
         MOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IhfIB41B0pb5T84jhbuhAWo3M3hfB4nmcUtFAyIplM8=;
        b=TJaEoiahCzSpP4+B3k9uqu0iSNvrF1QZAn5KIONIbtrcUr3ktUeTJALet/h7Om4RaS
         j0R4g3oieCljQ62cZ6+61xJnNpJjbx6a3kUdQ09YWApmLTrasqP3l8/qfG8DsDAlAext
         5vPRLHrY7TrPV0etIxpFnnx7NdkARSa6wOXv8FekXbyatu12+lFwEUVIs5VTQoiHqRCI
         jFHePTGssSYB/OSNO+O+dHcrn/N7IyE/nTOnwwEt34fdqHpR2XLMqfc5/XCHfzzDZqoY
         wgronY4sH0uLD1xbYBa0AGQ6qxwEhWyIvjbIk0v4MX9W+ME8YqGW/TpFlcl6Kzxajij7
         6YQg==
X-Gm-Message-State: AOAM532DothfH1pB4755UZfW3TwMyAPgDyosM8qz0QqogttI1MScXg6G
        +AS6y3GsSJJQuz80HvnPswZnFTzaNyNp5KkWIOk=
X-Google-Smtp-Source: ABdhPJxoK8mEAanDVT3eUU4G2YWxD1IDnF7MNLSF+NRLz/fyjGpdcT+YXc0vdxrqj0J9kNMRJSPM2MGMhOubUJTVKw8=
X-Received: by 2002:a63:d014:: with SMTP id z20mr891402pgf.203.1625244905069;
 Fri, 02 Jul 2021 09:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210702165052.81750-1-hdegoede@redhat.com>
In-Reply-To: <20210702165052.81750-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Jul 2021 19:54:27 +0300
Message-ID: <CAHp75VfWN1wt4bA4hVefOGiHA44-h3qEMt_A0=96k2Wq4=_WVg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI / PMIC: XPower: optimize I2C-bus accesses
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 2, 2021 at 7:50 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The I2C-bus to the XPower AXP288 is shared between the Linux kernel and
> the SoCs PUNIT. The PUNIT has a semaphore which the kernel must "lock"
> before it may use the bus and while the kernel holds the semaphore the CPU
> and GPU power-states must not be changed otherwise the system will freeze.
>
> This is a complex process, which is quite expensive. This is all done by
> iosf_mbi_block_punit_i2c_access(). To ensure that no unguarded I2C-bus
> accesses happen, iosf_mbi_block_punit_i2c_access() gets called by the
> I2C-bus-driver for every I2C transfer. Because this is so expensive it
> is allowed to call iosf_mbi_block_punit_i2c_access() in a nested
> fashion, so that higher-level code which does multiple I2C-transfers can
> call it once for a group of transfers, turning the calls done by the
> I2C-bus-driver into no-ops.
>
> Move / add iosf_mbi_block_punit_i2c_access() calls in / to the XPower
> OpRegion code so that the PUNIT semaphore only needs to be taken once
> for each OpRegion access.

We usually spell "P-Unit" instead of "PUNIT".
Otherwise it looks good to me, thanks!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/pmic/intel_pmic_xpower.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c b/drivers/acpi/pmic/intel_pmic_xpower.c
> index a091d5a8392c..644a495a4f13 100644
> --- a/drivers/acpi/pmic/intel_pmic_xpower.c
> +++ b/drivers/acpi/pmic/intel_pmic_xpower.c
> @@ -178,15 +178,17 @@ static int intel_xpower_pmic_update_power(struct regmap *regmap, int reg,
>  {
>         int data, ret;
>
> -       /* GPIO1 LDO regulator needs special handling */
> -       if (reg == XPOWER_GPI1_CTRL)
> -               return regmap_update_bits(regmap, reg, GPI1_LDO_MASK,
> -                                         on ? GPI1_LDO_ON : GPI1_LDO_OFF);
> -
>         ret = iosf_mbi_block_punit_i2c_access();
>         if (ret)
>                 return ret;
>
> +       /* GPIO1 LDO regulator needs special handling */
> +       if (reg == XPOWER_GPI1_CTRL) {
> +               ret = regmap_update_bits(regmap, reg, GPI1_LDO_MASK,
> +                                        on ? GPI1_LDO_ON : GPI1_LDO_OFF);
> +               goto out;
> +       }
> +
>         if (regmap_read(regmap, reg, &data)) {
>                 ret = -EIO;
>                 goto out;
> @@ -218,6 +220,10 @@ static int intel_xpower_pmic_get_raw_temp(struct regmap *regmap, int reg)
>         int ret, adc_ts_pin_ctrl;
>         u8 buf[2];
>
> +       ret = iosf_mbi_block_punit_i2c_access();
> +       if (ret)
> +               return ret;
> +
>         /*
>          * The current-source used for the battery temp-sensor (TS) is shared
>          * with the GPADC. For proper fuel-gauge and charger operation the TS
> @@ -231,14 +237,14 @@ static int intel_xpower_pmic_get_raw_temp(struct regmap *regmap, int reg)
>          */
>         ret = regmap_read(regmap, AXP288_ADC_TS_PIN_CTRL, &adc_ts_pin_ctrl);
>         if (ret)
> -               return ret;
> +               goto out;
>
>         if (adc_ts_pin_ctrl & AXP288_ADC_TS_CURRENT_ON_OFF_MASK) {
>                 ret = regmap_update_bits(regmap, AXP288_ADC_TS_PIN_CTRL,
>                                          AXP288_ADC_TS_CURRENT_ON_OFF_MASK,
>                                          AXP288_ADC_TS_CURRENT_ON_ONDEMAND);
>                 if (ret)
> -                       return ret;
> +                       goto out;
>
>                 /* Wait a bit after switching the current-source */
>                 usleep_range(6000, 10000);
> @@ -254,6 +260,9 @@ static int intel_xpower_pmic_get_raw_temp(struct regmap *regmap, int reg)
>                                    AXP288_ADC_TS_CURRENT_ON);
>         }
>
> +out:
> +       iosf_mbi_unblock_punit_i2c_access();
> +
>         return ret;
>  }
>
> --
> 2.31.1
>


-- 
With Best Regards,
Andy Shevchenko
