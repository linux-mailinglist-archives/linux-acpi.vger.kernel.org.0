Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41FF4601D7
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Nov 2021 23:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbhK0WEY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 27 Nov 2021 17:04:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31911 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231246AbhK0WCX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 27 Nov 2021 17:02:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638050347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WgRo6jqZlsiLzJ+meHTYqXdTnSiPMz+E9iN3Od+rC1o=;
        b=HxS5w6veOwUxD0VZJ56Is4EiNi4CwNWJjf9bJpo86S5yZKZEAxacvYAAQMF4zm6kF0NfnZ
        1i38Wem8UekP4/IiP9wPOunkWSiG4Zye/DFjvky2ulwZFjn8zqqh9k5bUHIn0W5b6MJW1D
        dJo+qGSAw+psiYGtTOWio/uM/tda8A4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-XeIb0IAwP0G5Cx6zuL9upQ-1; Sat, 27 Nov 2021 16:59:06 -0500
X-MC-Unique: XeIb0IAwP0G5Cx6zuL9upQ-1
Received: by mail-ed1-f72.google.com with SMTP id w18-20020a056402071200b003e61cbafdb4so10558640edx.4
        for <linux-acpi@vger.kernel.org>; Sat, 27 Nov 2021 13:59:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WgRo6jqZlsiLzJ+meHTYqXdTnSiPMz+E9iN3Od+rC1o=;
        b=vX9H4lHLChpGUJIoJdQXNJ3AV1l7S+cxax6+drBAsqu5xTAzWpmfSG0e0PQ2P9kPo0
         BZaOwHOarAwgpRea83/QnLDENN44vSYLUW+X5RhTxvVPWTp/4DGKJgzveXHYeLlEhhPn
         Yg0kPWm2DDcpPEKFBaO3Lb9VvEN5o7yY4/9CxyLaBnLa/kHsJVfj23Tjt3yE6CsdDl5N
         fBXu5KqLtBp1o79PU9dJBeLBDqkRDzp+9AYY6YIF4PPiiC8fxKojqc1Y2dFNjOZ9pOcg
         ZUTJZAOIRd5UYKSyasXTz9cBg4MuKiYDt0qDU1XLrS7rXKZ2x9bpyebVnSd0Mnymat5q
         anBQ==
X-Gm-Message-State: AOAM530TepYFVbdKDKpnvDsuspkkVx0SUS2DoiWiqv/qMCyDDT1h5YSY
        c3/6ZApXhWZqSuJa4CFm9zo8ZdJ3n/KUZhGpSQkV5SO4mG5UM2ZbU7ufNmKOmgrCqooPlpUC/9/
        9atf4PlKdQrZKL1qqL6EMFA==
X-Received: by 2002:a17:906:c147:: with SMTP id dp7mr49567805ejc.173.1638050345340;
        Sat, 27 Nov 2021 13:59:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxqgNPhk5O1VrC7hGr0Dc8+sn4dXks5plF//LIcddNtuWb9fZh21FJJMlX7I7d/v9ymFzTe3g==
X-Received: by 2002:a17:906:c147:: with SMTP id dp7mr49567791ejc.173.1638050345178;
        Sat, 27 Nov 2021 13:59:05 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id sg17sm5084176ejc.72.2021.11.27.13.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Nov 2021 13:59:04 -0800 (PST)
Message-ID: <ec8a5fcf-3e6d-e485-3426-6a0178f32855@redhat.com>
Date:   Sat, 27 Nov 2021 22:59:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 3/3] ACPI: PMIC: xpower: Fix _TMP ACPI errors
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
References: <20211126152109.230986-1-hdegoede@redhat.com>
 <20211126152109.230986-3-hdegoede@redhat.com>
 <YaEDy+5ffLeQRe1D@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YaEDy+5ffLeQRe1D@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 11/26/21 16:56, Andy Shevchenko wrote:
> On Fri, Nov 26, 2021 at 04:21:09PM +0100, Hans de Goede wrote:
>> On some devices with a X-Powers AXP288 PMIC the LPAT tables in the ACPI
>> node for the AXP288 PMIC for some reason only describe a small temperature
>> range, e.g. 27° - 37° Celcius (assuming the entries are in millidegrees).
>>
>> When the tablet is idle in a room at 21° degrees this is causing values
>> outside the LPAT table to be read, causing e.g. the following 2 errors
>> to get spammed to the logs every 4 seconds! :
>>
>> [ 7512.791316] ACPI Error: AE_ERROR, Returned by Handler for [UserDefinedRegion] (20210930/evregion-281)
>> [ 7512.791611] ACPI Error: Aborting method \_SB.SXP1._TMP due to previous error (AE_ERROR) (20210930/psparse-529)
>>
>> Fix this by clamping the raw value to the LPAT table range before
>> passing it to acpi_lpat_raw_to_temp().
>>
>> Note clamping has been chosen rather then extrapolating because it is
>> unknown how other parts of the ACPI tables will respond to temperature
>> values outside of the LPAT range.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> One nit-pick below.
> 
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/acpi/pmic/intel_pmic_xpower.c | 23 ++++++++++++++++++++++-
>>  1 file changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c b/drivers/acpi/pmic/intel_pmic_xpower.c
>> index e844bc1f3df5..61bbe4c24d87 100644
>> --- a/drivers/acpi/pmic/intel_pmic_xpower.c
>> +++ b/drivers/acpi/pmic/intel_pmic_xpower.c
>> @@ -293,12 +293,33 @@ static int intel_xpower_exec_mipi_pmic_seq_element(struct regmap *regmap,
>>  	return ret;
>>  }
>>  
>> +static int intel_xpower_lpat_raw_to_temp(struct acpi_lpat_conversion_table *lpat_table,
>> +					 int raw)
>> +{
>> +	struct acpi_lpat first = lpat_table->lpat[0];
>> +	struct acpi_lpat last = lpat_table->lpat[lpat_table->lpat_count - 1];
>> +
>> +	/*
>> +	 * Some LPAT tables in the ACPI Device for the AXP288 PMIC for some
>> +	 * reason only describe a small temperature range, e.g. 27° - 37°
>> +	 * Celcius. Resulting in errors when the tablet is idle in a cool room.
>> +	 *
>> +	 * To avoid these errors clamp the raw value to be inside the LPAT.
>> +	 */
> 
>> +	if (first.raw < last.raw)
> 
> Wondering what that would mean if this condition is false.

That the tables is in descending raw value order, rather then
in ascending one. Which quite a few LPAT tables actually are.

The existing acpi_lpat_raw_to_temp() has been carefully written
to be able to handle both cases too.

> 
>> +		raw = clamp(raw, first.raw, last.raw);
>> +	else
>> +		raw = clamp(raw, last.raw, first.raw);
> 
> clamp_value() slightly better due to type checking.

Quoting from include/linux/minmax.h :

 * This macro does strict typechecking of @lo/@hi to make sure they are of the
 * same type as @val.  See the unnecessary pointer comparisons.
 */
#define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)

So we already get strict type-checking from plain clamp()

Regards,

Hans



> 
>> +
>> +	return acpi_lpat_raw_to_temp(lpat_table, raw);
>> +}
>> +
>>  static const struct intel_pmic_opregion_data intel_xpower_pmic_opregion_data = {
>>  	.get_power = intel_xpower_pmic_get_power,
>>  	.update_power = intel_xpower_pmic_update_power,
>>  	.get_raw_temp = intel_xpower_pmic_get_raw_temp,
>>  	.exec_mipi_pmic_seq_element = intel_xpower_exec_mipi_pmic_seq_element,
>> -	.lpat_raw_to_temp = acpi_lpat_raw_to_temp,
>> +	.lpat_raw_to_temp = intel_xpower_lpat_raw_to_temp,
>>  	.power_table = power_table,
>>  	.power_table_count = ARRAY_SIZE(power_table),
>>  	.thermal_table = thermal_table,
>> -- 
>> 2.33.1
>>
> 

