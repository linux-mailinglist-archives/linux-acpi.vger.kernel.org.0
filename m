Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695F74601D3
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Nov 2021 22:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhK0WCV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 27 Nov 2021 17:02:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34559 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235478AbhK0WAV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 27 Nov 2021 17:00:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638050225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fmx4+9i5eP7k6jV/KCzbjstaUyd4NraUgkonqWzI5jQ=;
        b=VZJZANZwGkSlgt7BS4BdjZAHVp0kug5NUk67Ai0XtzfrBsZt6L/2WHXD364YMNnEMupzHj
        rw2TXpRYZmWbawmyENKZoVvj2nS2Aa7mgKvx9vGudTTSSpbtcek9StOyHS0JDU1DqK6rDW
        3gIL1N5SIU+rSEDYcEB8fp1Wqn/DjT4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-195-TXKLcg8EOZOH3O3xY6OyEw-1; Sat, 27 Nov 2021 16:57:04 -0500
X-MC-Unique: TXKLcg8EOZOH3O3xY6OyEw-1
Received: by mail-ed1-f70.google.com with SMTP id eg20-20020a056402289400b003eb56fcf6easo10489035edb.20
        for <linux-acpi@vger.kernel.org>; Sat, 27 Nov 2021 13:57:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Fmx4+9i5eP7k6jV/KCzbjstaUyd4NraUgkonqWzI5jQ=;
        b=PBVdw+3zWSWND3rpRKM6P3sR/I16L6f8fDoK+lgx7M66LxjiZ7+rh9i5KGGCu/11OQ
         S7Z/9++o6UpiuQ1hRlfzVjn4s/lf0muwmKKOP5tz9jXONMFI5ZYG9hgL7M7SdOZ+vk2p
         fztT3oPnm+fs8gtHBEiufeBkOvQ0l9B4gRMHotAFICHZSLr5nw+xbltdl4IuvYJ+OWq+
         8c56LaCBrj9Kmgbr1m/quxEgaDGCK4dlmg1raRY6PhGenlwlBg29A4nXPzrDAxdRWtNd
         RnIpq9pHrEHLg35EJqIoE02Nw+7IZKrqOFaisSgMepTD8ssqG1oe6LS5PkRRudhxi5kg
         1Vbg==
X-Gm-Message-State: AOAM533ceGIr2q2228Fc+nbHEKbGsb/cIzH8TiFHapauOvv6z5zXVQVo
        NT7v5J4Ii9BGgpIbgqcSYX7zqw4ipjMnr0xSbfz82YR84vOcGwrMvvTP7oDFJXB106z3ygf2XmE
        MNb+BzVISRby7pA5ewrJkvQ==
X-Received: by 2002:a17:907:7f1a:: with SMTP id qf26mr47914558ejc.543.1638050223576;
        Sat, 27 Nov 2021 13:57:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzn/4mT2QwwXNNZd/zyItR1PlwUBO33FL3qRaXzY5dvAmOT9/mGkj4iDrN/OXH4Iwwl/Pcw7w==
X-Received: by 2002:a17:907:7f1a:: with SMTP id qf26mr47914541ejc.543.1638050223380;
        Sat, 27 Nov 2021 13:57:03 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id nb4sm5208917ejc.21.2021.11.27.13.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Nov 2021 13:57:03 -0800 (PST)
Message-ID: <761aa221-690d-73fe-d58d-d769b83cff89@redhat.com>
Date:   Sat, 27 Nov 2021 22:57:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 2/3] ACPI: PMIC: allow drivers to provide a custom
 lpat_raw_to_temp() function
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
References: <20211126152109.230986-1-hdegoede@redhat.com>
 <20211126152109.230986-2-hdegoede@redhat.com>
 <YaEBcuFw+W8LNtMW@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YaEBcuFw+W8LNtMW@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 11/26/21 16:46, Andy Shevchenko wrote:
> On Fri, Nov 26, 2021 at 04:21:08PM +0100, Hans de Goede wrote:
>> The LPAT tables used in the DSDT for some PMICs require special handling,
>> allow the PMIC OpRegion drivers to provide an alternative implementation
>> by adding a lpat_raw_to_temp function pointer to struct pmic_table;
>> and initialize this to the default acpi_lpat_raw_to_temp function
> 
> acpi_lpat_raw_to_temp()
> 
>> for all PMICs.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> (see one nit-pick below)
> 
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/acpi/pmic/intel_pmic.c          | 2 +-
>>  drivers/acpi/pmic/intel_pmic.h          | 4 ++++
>>  drivers/acpi/pmic/intel_pmic_bxtwc.c    | 1 +
>>  drivers/acpi/pmic/intel_pmic_bytcrc.c   | 1 +
>>  drivers/acpi/pmic/intel_pmic_chtcrc.c   | 1 +
>>  drivers/acpi/pmic/intel_pmic_chtdc_ti.c | 1 +
>>  drivers/acpi/pmic/intel_pmic_chtwc.c    | 1 +
>>  drivers/acpi/pmic/intel_pmic_xpower.c   | 1 +
>>  8 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/pmic/intel_pmic.c b/drivers/acpi/pmic/intel_pmic.c
>> index 98bbfd99c709..f20dbda1a831 100644
>> --- a/drivers/acpi/pmic/intel_pmic.c
>> +++ b/drivers/acpi/pmic/intel_pmic.c
>> @@ -95,7 +95,7 @@ static int pmic_read_temp(struct intel_pmic_opregion *opregion,
>>  		return 0;
>>  	}
>>  
>> -	temp = acpi_lpat_raw_to_temp(opregion->lpat_table, raw_temp);
>> +	temp = opregion->data->lpat_raw_to_temp(opregion->lpat_table, raw_temp);
>>  	if (temp < 0)
>>  		return temp;
>>  
>> diff --git a/drivers/acpi/pmic/intel_pmic.h b/drivers/acpi/pmic/intel_pmic.h
>> index 467a39966dc8..d956b03a6ca0 100644
>> --- a/drivers/acpi/pmic/intel_pmic.h
>> +++ b/drivers/acpi/pmic/intel_pmic.h
>> @@ -2,6 +2,8 @@
>>  #ifndef __INTEL_PMIC_H
>>  #define __INTEL_PMIC_H
>>  
>> +#include <acpi/acpi_lpat.h>
>> +
>>  struct pmic_table {
>>  	int address;	/* operation region address */
>>  	int reg;	/* corresponding thermal register */
>> @@ -17,6 +19,8 @@ struct intel_pmic_opregion_data {
>>  	int (*update_policy)(struct regmap *r, int reg, int bit, int enable);
>>  	int (*exec_mipi_pmic_seq_element)(struct regmap *r, u16 i2c_address,
>>  					  u32 reg_address, u32 value, u32 mask);
> 
>> +	int (*lpat_raw_to_temp)(struct acpi_lpat_conversion_table *lpat_table,
>> +				int raw);
> 
> Can be on one line.

I tried to stay within (or at least close too) 80 lines here as that is
still the recommended limit. The new 100 is more of a checkpatch only
change, not a change in the codingstyle docs.

With that said I'm fine with changing this. Rafael, feel free to
change this while merging. Or let me know if you want a v2.

Regards,

Hans


> 
>>  	struct pmic_table *power_table;
>>  	int power_table_count;
>>  	struct pmic_table *thermal_table;
>> diff --git a/drivers/acpi/pmic/intel_pmic_bxtwc.c b/drivers/acpi/pmic/intel_pmic_bxtwc.c
>> index 6620ce0833f6..e247615189fa 100644
>> --- a/drivers/acpi/pmic/intel_pmic_bxtwc.c
>> +++ b/drivers/acpi/pmic/intel_pmic_bxtwc.c
>> @@ -376,6 +376,7 @@ static const struct intel_pmic_opregion_data intel_bxtwc_pmic_opregion_data = {
>>  	.update_aux     = intel_bxtwc_pmic_update_aux,
>>  	.get_policy     = intel_bxtwc_pmic_get_policy,
>>  	.update_policy  = intel_bxtwc_pmic_update_policy,
>> +	.lpat_raw_to_temp = acpi_lpat_raw_to_temp,
>>  	.power_table      = power_table,
>>  	.power_table_count = ARRAY_SIZE(power_table),
>>  	.thermal_table     = thermal_table,
>> diff --git a/drivers/acpi/pmic/intel_pmic_bytcrc.c b/drivers/acpi/pmic/intel_pmic_bytcrc.c
>> index 8a1d895ed689..9ea79f210965 100644
>> --- a/drivers/acpi/pmic/intel_pmic_bytcrc.c
>> +++ b/drivers/acpi/pmic/intel_pmic_bytcrc.c
>> @@ -278,6 +278,7 @@ static const struct intel_pmic_opregion_data intel_crc_pmic_opregion_data = {
>>  	.update_aux	= intel_crc_pmic_update_aux,
>>  	.get_policy	= intel_crc_pmic_get_policy,
>>  	.update_policy	= intel_crc_pmic_update_policy,
>> +	.lpat_raw_to_temp = acpi_lpat_raw_to_temp,
>>  	.power_table	= power_table,
>>  	.power_table_count= ARRAY_SIZE(power_table),
>>  	.thermal_table	= thermal_table,
>> diff --git a/drivers/acpi/pmic/intel_pmic_chtcrc.c b/drivers/acpi/pmic/intel_pmic_chtcrc.c
>> index d8266d22cd8e..f9301c6f098e 100644
>> --- a/drivers/acpi/pmic/intel_pmic_chtcrc.c
>> +++ b/drivers/acpi/pmic/intel_pmic_chtcrc.c
>> @@ -24,6 +24,7 @@
>>   * CHT Crystal Cove PMIC.
>>   */
>>  static const struct intel_pmic_opregion_data intel_chtcrc_pmic_opregion_data = {
>> +	.lpat_raw_to_temp = acpi_lpat_raw_to_temp,
>>  	.pmic_i2c_address = 0x6e,
>>  };
>>  
>> diff --git a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
>> index cb444ddec5a0..418eec523025 100644
>> --- a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
>> +++ b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
>> @@ -98,6 +98,7 @@ static const struct intel_pmic_opregion_data chtdc_ti_pmic_opregion_data = {
>>  	.get_power = chtdc_ti_pmic_get_power,
>>  	.update_power = chtdc_ti_pmic_update_power,
>>  	.get_raw_temp = chtdc_ti_pmic_get_raw_temp,
>> +	.lpat_raw_to_temp = acpi_lpat_raw_to_temp,
>>  	.power_table = chtdc_ti_power_table,
>>  	.power_table_count = ARRAY_SIZE(chtdc_ti_power_table),
>>  	.thermal_table = chtdc_ti_thermal_table,
>> diff --git a/drivers/acpi/pmic/intel_pmic_chtwc.c b/drivers/acpi/pmic/intel_pmic_chtwc.c
>> index 59385a9a05e5..f2c42f4c79ca 100644
>> --- a/drivers/acpi/pmic/intel_pmic_chtwc.c
>> +++ b/drivers/acpi/pmic/intel_pmic_chtwc.c
>> @@ -257,6 +257,7 @@ static const struct intel_pmic_opregion_data intel_cht_wc_pmic_opregion_data = {
>>  	.get_power		= intel_cht_wc_pmic_get_power,
>>  	.update_power		= intel_cht_wc_pmic_update_power,
>>  	.exec_mipi_pmic_seq_element = intel_cht_wc_exec_mipi_pmic_seq_element,
>> +	.lpat_raw_to_temp	= acpi_lpat_raw_to_temp,
>>  	.power_table		= power_table,
>>  	.power_table_count	= ARRAY_SIZE(power_table),
>>  };
>> diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c b/drivers/acpi/pmic/intel_pmic_xpower.c
>> index b5f4d81c621f..e844bc1f3df5 100644
>> --- a/drivers/acpi/pmic/intel_pmic_xpower.c
>> +++ b/drivers/acpi/pmic/intel_pmic_xpower.c
>> @@ -298,6 +298,7 @@ static const struct intel_pmic_opregion_data intel_xpower_pmic_opregion_data = {
>>  	.update_power = intel_xpower_pmic_update_power,
>>  	.get_raw_temp = intel_xpower_pmic_get_raw_temp,
>>  	.exec_mipi_pmic_seq_element = intel_xpower_exec_mipi_pmic_seq_element,
>> +	.lpat_raw_to_temp = acpi_lpat_raw_to_temp,
>>  	.power_table = power_table,
>>  	.power_table_count = ARRAY_SIZE(power_table),
>>  	.thermal_table = thermal_table,
>> -- 
>> 2.33.1
>>
> 

