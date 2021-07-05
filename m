Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C8C3BC27E
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Jul 2021 20:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhGEST1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Jul 2021 14:19:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26947 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229725AbhGEST1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jul 2021 14:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625509009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=69T2B546Vc7E1rcw+5P0F6nxugrJ3HbELpUQjs+VD0s=;
        b=hlxk8Y114c3pI17JkkvcD0YV96M31rwBsVjlwGEnmyMtWb201s5nfbOz45HjVSjxJooOKS
        zpyyvRNkiEuoz87hyvTfoFx1m3fGzfaSNEgP7ChUPgx7+7dQWFK51t5yCl0/P++P9PSRJf
        Zji9hB5oEog4g5enOCidZZDrHn97lGY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-wetSUVGDPYicsSi9KKLXGQ-1; Mon, 05 Jul 2021 14:16:48 -0400
X-MC-Unique: wetSUVGDPYicsSi9KKLXGQ-1
Received: by mail-ed1-f69.google.com with SMTP id d17-20020a05640208d1b0290399de3a0eecso1314371edz.0
        for <linux-acpi@vger.kernel.org>; Mon, 05 Jul 2021 11:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=69T2B546Vc7E1rcw+5P0F6nxugrJ3HbELpUQjs+VD0s=;
        b=Hvsnlgbsukkk/Le1pFi4BmBbTsDkS22TDhom/MOTeqzrWN1IcZ7bTzy47swxXSssII
         yctbwTdkNfn2Yd4x5e4TtToJNxfOxe+1vYuuI5G+dI6BSmfQEMbdE2UxZ5l5jiVWxtb3
         elk6wM6O/BT/OKH/1pQzgjC1VOioaz0WYczx8RFi95opc62ymG99jegusajiONuBF3Dr
         Ol++A/ope6tpZJQOc3RLCaANNYQB3y4QcVOZfqVffAtbPkUyuYeL51l8w/ddiljdwMG4
         3zFE3bjOaQ3c3ActebKQyNaP94DR1lSJVInWskMJewLcRlITql42vQhGkp4gVd4E/IY0
         CXlw==
X-Gm-Message-State: AOAM532aIKJ6dEJ1E3noYnqLFD4Qjwz76haK6XeHUh5/JEiHwstT6McA
        hDVTtYyx5Im+IXqN8tLYlQ1eoHhqZ2UfZWx1QJjA79APVD0reTXV+cb6acLjCG8lzAOnfKGoAgi
        e57ouXYHQVv+jWBvCqzGLM+sqaZE/sQsjCYb36JvqmBTr0EE5t1RUTYGMpplnEm03UQ9KvJlVZA
        ==
X-Received: by 2002:a05:6402:1001:: with SMTP id c1mr17780612edu.26.1625509006993;
        Mon, 05 Jul 2021 11:16:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyV8zUFVaQLdNenXFuPkeCWYMMaXWI5xBFsHSYlFNXHgJRwj1GjagjDulu30c4CKY6fyqj+Rg==
X-Received: by 2002:a05:6402:1001:: with SMTP id c1mr17780601edu.26.1625509006813;
        Mon, 05 Jul 2021 11:16:46 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id z10sm5694407edc.28.2021.07.05.11.16.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jul 2021 11:16:46 -0700 (PDT)
Subject: Re: [PATCH 1/2] ACPI / PMIC: XPower: optimize I2C-bus accesses
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
References: <20210702165052.81750-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f680621f-36f2-e0b4-c44b-6a21f008efb6@redhat.com>
Date:   Mon, 5 Jul 2021 20:16:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210702165052.81750-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 7/2/21 6:50 PM, Hans de Goede wrote:
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
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

I just noticed that one of the blocks has a usleep_range(6000, 10000)
in there which means that we now hold the P-Unit semaphore over the
sleep, which is not good.

Self nack. I'll send out an updated series fixing this.

Regards,

Hans




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
>  	int data, ret;
>  
> -	/* GPIO1 LDO regulator needs special handling */
> -	if (reg == XPOWER_GPI1_CTRL)
> -		return regmap_update_bits(regmap, reg, GPI1_LDO_MASK,
> -					  on ? GPI1_LDO_ON : GPI1_LDO_OFF);
> -
>  	ret = iosf_mbi_block_punit_i2c_access();
>  	if (ret)
>  		return ret;
>  
> +	/* GPIO1 LDO regulator needs special handling */
> +	if (reg == XPOWER_GPI1_CTRL) {
> +		ret = regmap_update_bits(regmap, reg, GPI1_LDO_MASK,
> +					 on ? GPI1_LDO_ON : GPI1_LDO_OFF);
> +		goto out;
> +	}
> +
>  	if (regmap_read(regmap, reg, &data)) {
>  		ret = -EIO;
>  		goto out;
> @@ -218,6 +220,10 @@ static int intel_xpower_pmic_get_raw_temp(struct regmap *regmap, int reg)
>  	int ret, adc_ts_pin_ctrl;
>  	u8 buf[2];
>  
> +	ret = iosf_mbi_block_punit_i2c_access();
> +	if (ret)
> +		return ret;
> +
>  	/*
>  	 * The current-source used for the battery temp-sensor (TS) is shared
>  	 * with the GPADC. For proper fuel-gauge and charger operation the TS
> @@ -231,14 +237,14 @@ static int intel_xpower_pmic_get_raw_temp(struct regmap *regmap, int reg)
>  	 */
>  	ret = regmap_read(regmap, AXP288_ADC_TS_PIN_CTRL, &adc_ts_pin_ctrl);
>  	if (ret)
> -		return ret;
> +		goto out;
>  
>  	if (adc_ts_pin_ctrl & AXP288_ADC_TS_CURRENT_ON_OFF_MASK) {
>  		ret = regmap_update_bits(regmap, AXP288_ADC_TS_PIN_CTRL,
>  					 AXP288_ADC_TS_CURRENT_ON_OFF_MASK,
>  					 AXP288_ADC_TS_CURRENT_ON_ONDEMAND);
>  		if (ret)
> -			return ret;
> +			goto out;
>  
>  		/* Wait a bit after switching the current-source */
>  		usleep_range(6000, 10000);
> @@ -254,6 +260,9 @@ static int intel_xpower_pmic_get_raw_temp(struct regmap *regmap, int reg)
>  				   AXP288_ADC_TS_CURRENT_ON);
>  	}
>  
> +out:
> +	iosf_mbi_unblock_punit_i2c_access();
> +
>  	return ret;
>  }
>  
> 

