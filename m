Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3EB3CBAEF
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jul 2021 19:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhGPRKs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Jul 2021 13:10:48 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:33680 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhGPRKs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jul 2021 13:10:48 -0400
Received: by mail-oi1-f170.google.com with SMTP id s23so11703177oij.0
        for <linux-acpi@vger.kernel.org>; Fri, 16 Jul 2021 10:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8AsjM0zHjsroVPxNVB9BrkBRP3AvB+V6XnB2ZxVS6Ks=;
        b=F0dNfMRbpM1a9Cqn9nw9A4inhA20yQolhCyQbvQad8fpTuF7Ik/5+9ZjP8NyQJwQIQ
         S8vMvSXGqzF4cTeFje5YNyDXSpRwGnt5CMDDrXqABfSa4SJPHKQToaUledtzVAglKBrI
         FiP3om4bPGjL17Zw1iqP3a+/aKqWzfaBmHPncksx2ZwtevAgy6IiLWf57kv6c0c+nxNG
         lgeUZ6E5QWq0UNy7gHG0YD6blvDBI5EKFBQrw7SCamjLgIVmnI6+J2xm72Wh7MrQlGSo
         FdqSiKVjW36vsXrjpQfCI06K7g7NKHRMdneLyrhwJo1bU1LbcMgoLqi7wLTI8GUNsWjd
         KF2w==
X-Gm-Message-State: AOAM530+vHyo4L39KlCP4y4AE5OLiazWlp5FOOnhtg9zhMZXbisE3c+v
        lLDDPSDLTr+Ia3qAFEiXHGIRiYChWnewBYMMwns=
X-Google-Smtp-Source: ABdhPJwwcVr4p1x45KVnLenIXVvN/5Em+GVKBqX7VS9/POg/eSO7kGZIA91P/F/tlqe/wv+YVC8l2+THUQ2+qQL+RwQ=
X-Received: by 2002:a05:6808:10d0:: with SMTP id s16mr8239534ois.69.1626455272569;
 Fri, 16 Jul 2021 10:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210706160923.20273-1-hdegoede@redhat.com>
In-Reply-To: <20210706160923.20273-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Jul 2021 19:07:41 +0200
Message-ID: <CAJZ5v0gbmdNPus1XURJSw9joqJfhsD=QNm0O_bPJyyf9XEzS0w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ACPI / PMIC: XPower: optimize I2C-bus accesses
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jul 6, 2021 at 6:09 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The I2C-bus to the XPower AXP288 is shared between the Linux kernel and
> the SoCs P-Unit. The P-Unit has a semaphore which the kernel must "lock"
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
> Add iosf_mbi_block_punit_i2c_access() calls around groups of register
> accesses, so that the P-Unit semaphore only needs to be taken once
> for each group of register accesses.
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Do not hold the P-Unit sempahore over the usleep_range() in
>  intel_xpower_pmic_get_raw_temp()
> ---
>  drivers/acpi/pmic/intel_pmic_xpower.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c b/drivers/acpi/pmic/intel_pmic_xpower.c
> index a091d5a8392c..5750c5e7d4c6 100644
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
> @@ -234,6 +236,11 @@ static int intel_xpower_pmic_get_raw_temp(struct regmap *regmap, int reg)
>                 return ret;
>
>         if (adc_ts_pin_ctrl & AXP288_ADC_TS_CURRENT_ON_OFF_MASK) {
> +               /*
> +                * AXP288_ADC_TS_PIN_CTRL reads are cached by the regmap, so
> +                * this does to a single I2C-transfer, and thus there is no
> +                * need to explicitly call iosf_mbi_block_punit_i2c_access().
> +                */
>                 ret = regmap_update_bits(regmap, AXP288_ADC_TS_PIN_CTRL,
>                                          AXP288_ADC_TS_CURRENT_ON_OFF_MASK,
>                                          AXP288_ADC_TS_CURRENT_ON_ONDEMAND);
> @@ -244,6 +251,10 @@ static int intel_xpower_pmic_get_raw_temp(struct regmap *regmap, int reg)
>                 usleep_range(6000, 10000);
>         }
>
> +       ret = iosf_mbi_block_punit_i2c_access();
> +       if (ret)
> +               return ret;
> +
>         ret = regmap_bulk_read(regmap, AXP288_GP_ADC_H, buf, 2);
>         if (ret == 0)
>                 ret = (buf[0] << 4) + ((buf[1] >> 4) & 0x0f);
> @@ -254,6 +265,8 @@ static int intel_xpower_pmic_get_raw_temp(struct regmap *regmap, int reg)
>                                    AXP288_ADC_TS_CURRENT_ON);
>         }
>
> +       iosf_mbi_unblock_punit_i2c_access();
> +
>         return ret;
>  }
>
> --

Applied along with the [2/2] as 5.15 material, thanks!
