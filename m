Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055693BA36C
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jul 2021 18:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhGBRBU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Jul 2021 13:01:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42188 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229455AbhGBRBU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jul 2021 13:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625245127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=82NixBlufxqK7KigK+GsItwK7tsvhsWy1567biZlwT4=;
        b=VPHc5rc/CDvVxrOPnjfZflMH51MWPj1z3KZ/JJ3bqVh+Ts0WNvlW7smBqrXwWZkGle/lbb
        EWpL8sjsHcuzolpjeYpEbpOcg5J1vP+kQwcRU5TNtkeeU1Sezu078nu7NiJCV//syY94eg
        ewqYZlTRrKoscDYVqxnnhQC+N3LpvTc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-4aX-STcTOlO1gnIVujjo-g-1; Fri, 02 Jul 2021 12:58:46 -0400
X-MC-Unique: 4aX-STcTOlO1gnIVujjo-g-1
Received: by mail-ej1-f72.google.com with SMTP id h14-20020a1709070b0eb02904d7c421e00bso610989ejl.2
        for <linux-acpi@vger.kernel.org>; Fri, 02 Jul 2021 09:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=82NixBlufxqK7KigK+GsItwK7tsvhsWy1567biZlwT4=;
        b=BgL/y2GorFqi50R/uoZUjxnaXYDTpKoyqDGQbvDPweY+TLE/Cxn3LESEfm6aeYmtC6
         fzIRmA4JWDbR6kWGZWlVsCM27lYXE0LdlgPSZSFbCdCyHw7oWII+IVL4tHmwZFdVu8V0
         A3rPIwSfuPv3sxDnLWKNF42D2y9FC0fFePthzKtbNx0w9m459U6akwJ3FFyW+flH7Rot
         AwKMowHDMCmjNB7aBbzi+3qu33j23pqWTLHMRsOs7pfx04NYpoM+r2aEObIeStL3osOU
         oHJrX8QnAPTcaBHMJEQ5MYcFb1lIGNuKU8utVRpUgzJ2CBskoyEhKIMOtAWqEk6qxIzH
         PYGg==
X-Gm-Message-State: AOAM531g3DZzTJL923M0RyGf9pRDQKGeGLV3ypzo/szTUZhEBhyusXxC
        t3UpdsGilAf+YLgNWOIGMEKeNu7+mDLcBPwaHVj1qsNZjXYj3xorFSQ7o7oXPCec0nLZwHW6FAV
        OGGQ4+3SKcfGdiOOhS/WUqdS/Q8CizyIwcfzU4l2YR6BGOHcgGRZ3NcI9QgC8iGEi6to/Y7kPHA
        ==
X-Received: by 2002:a17:906:5408:: with SMTP id q8mr720711ejo.2.1625245124876;
        Fri, 02 Jul 2021 09:58:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLD6vKKW0KDHnF5t6+MHwNTF9gpnbDZ+KEInsfosFqLlSWazzU64U/ris2EWo/ZTVXExKUqQ==
X-Received: by 2002:a17:906:5408:: with SMTP id q8mr720690ejo.2.1625245124623;
        Fri, 02 Jul 2021 09:58:44 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id v24sm1550966eds.39.2021.07.02.09.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 09:58:44 -0700 (PDT)
Subject: Re: [PATCH 1/2] ACPI / PMIC: XPower: optimize I2C-bus accesses
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <20210702165052.81750-1-hdegoede@redhat.com>
 <CAHp75VfWN1wt4bA4hVefOGiHA44-h3qEMt_A0=96k2Wq4=_WVg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0e8c71a2-6b64-fec2-c307-a8a530bdead7@redhat.com>
Date:   Fri, 2 Jul 2021 18:58:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfWN1wt4bA4hVefOGiHA44-h3qEMt_A0=96k2Wq4=_WVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 7/2/21 6:54 PM, Andy Shevchenko wrote:
> On Fri, Jul 2, 2021 at 7:50 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> The I2C-bus to the XPower AXP288 is shared between the Linux kernel and
>> the SoCs PUNIT. The PUNIT has a semaphore which the kernel must "lock"
>> before it may use the bus and while the kernel holds the semaphore the CPU
>> and GPU power-states must not be changed otherwise the system will freeze.
>>
>> This is a complex process, which is quite expensive. This is all done by
>> iosf_mbi_block_punit_i2c_access(). To ensure that no unguarded I2C-bus
>> accesses happen, iosf_mbi_block_punit_i2c_access() gets called by the
>> I2C-bus-driver for every I2C transfer. Because this is so expensive it
>> is allowed to call iosf_mbi_block_punit_i2c_access() in a nested
>> fashion, so that higher-level code which does multiple I2C-transfers can
>> call it once for a group of transfers, turning the calls done by the
>> I2C-bus-driver into no-ops.
>>
>> Move / add iosf_mbi_block_punit_i2c_access() calls in / to the XPower
>> OpRegion code so that the PUNIT semaphore only needs to be taken once
>> for each OpRegion access.
> 
> We usually spell "P-Unit" instead of "PUNIT".
> Otherwise it looks good to me, thanks!
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thank you for the review.

Is your Reviewed-by for just this patch, or for the series ?

Regards,

Hans



> 
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/acpi/pmic/intel_pmic_xpower.c | 23 ++++++++++++++++-------
>>  1 file changed, 16 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c b/drivers/acpi/pmic/intel_pmic_xpower.c
>> index a091d5a8392c..644a495a4f13 100644
>> --- a/drivers/acpi/pmic/intel_pmic_xpower.c
>> +++ b/drivers/acpi/pmic/intel_pmic_xpower.c
>> @@ -178,15 +178,17 @@ static int intel_xpower_pmic_update_power(struct regmap *regmap, int reg,
>>  {
>>         int data, ret;
>>
>> -       /* GPIO1 LDO regulator needs special handling */
>> -       if (reg == XPOWER_GPI1_CTRL)
>> -               return regmap_update_bits(regmap, reg, GPI1_LDO_MASK,
>> -                                         on ? GPI1_LDO_ON : GPI1_LDO_OFF);
>> -
>>         ret = iosf_mbi_block_punit_i2c_access();
>>         if (ret)
>>                 return ret;
>>
>> +       /* GPIO1 LDO regulator needs special handling */
>> +       if (reg == XPOWER_GPI1_CTRL) {
>> +               ret = regmap_update_bits(regmap, reg, GPI1_LDO_MASK,
>> +                                        on ? GPI1_LDO_ON : GPI1_LDO_OFF);
>> +               goto out;
>> +       }
>> +
>>         if (regmap_read(regmap, reg, &data)) {
>>                 ret = -EIO;
>>                 goto out;
>> @@ -218,6 +220,10 @@ static int intel_xpower_pmic_get_raw_temp(struct regmap *regmap, int reg)
>>         int ret, adc_ts_pin_ctrl;
>>         u8 buf[2];
>>
>> +       ret = iosf_mbi_block_punit_i2c_access();
>> +       if (ret)
>> +               return ret;
>> +
>>         /*
>>          * The current-source used for the battery temp-sensor (TS) is shared
>>          * with the GPADC. For proper fuel-gauge and charger operation the TS
>> @@ -231,14 +237,14 @@ static int intel_xpower_pmic_get_raw_temp(struct regmap *regmap, int reg)
>>          */
>>         ret = regmap_read(regmap, AXP288_ADC_TS_PIN_CTRL, &adc_ts_pin_ctrl);
>>         if (ret)
>> -               return ret;
>> +               goto out;
>>
>>         if (adc_ts_pin_ctrl & AXP288_ADC_TS_CURRENT_ON_OFF_MASK) {
>>                 ret = regmap_update_bits(regmap, AXP288_ADC_TS_PIN_CTRL,
>>                                          AXP288_ADC_TS_CURRENT_ON_OFF_MASK,
>>                                          AXP288_ADC_TS_CURRENT_ON_ONDEMAND);
>>                 if (ret)
>> -                       return ret;
>> +                       goto out;
>>
>>                 /* Wait a bit after switching the current-source */
>>                 usleep_range(6000, 10000);
>> @@ -254,6 +260,9 @@ static int intel_xpower_pmic_get_raw_temp(struct regmap *regmap, int reg)
>>                                    AXP288_ADC_TS_CURRENT_ON);
>>         }
>>
>> +out:
>> +       iosf_mbi_unblock_punit_i2c_access();
>> +
>>         return ret;
>>  }
>>
>> --
>> 2.31.1
>>
> 
> 

