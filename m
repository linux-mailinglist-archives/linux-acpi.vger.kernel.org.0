Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD6C67B176
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jan 2023 12:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbjAYLf2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Jan 2023 06:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbjAYLfK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Jan 2023 06:35:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD841E1D8
        for <linux-acpi@vger.kernel.org>; Wed, 25 Jan 2023 03:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674646452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CWPRMhsc9mlY87PxAt6QyVroCBqiyrD/VMgZkk1LZQI=;
        b=CegFo+cJgMANCkXsodxrGDTOvk3B0Hc2mGoiuuavAplxK/uaNHd+sKpZKPDYEbvvfC5lOc
        hDTbet/sRxs1F+QgFbYZIw8u1az0ivpPqKu+H9XLWP9mpTSmTVsZb93kY0ELfNsQ9+NX5H
        jiZeo2Bl4FafKUwmdt5TYPJGQqP7Kck=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-439-PNYBUh9DMT2iK5ocFSO0xw-1; Wed, 25 Jan 2023 06:34:11 -0500
X-MC-Unique: PNYBUh9DMT2iK5ocFSO0xw-1
Received: by mail-ed1-f71.google.com with SMTP id b15-20020a056402350f00b0049e42713e2bso12625391edd.0
        for <linux-acpi@vger.kernel.org>; Wed, 25 Jan 2023 03:34:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CWPRMhsc9mlY87PxAt6QyVroCBqiyrD/VMgZkk1LZQI=;
        b=Gr6zr+uMJ5OLo3Ccf7RjrxpvUawBhCAdt7ONF0yC0KrjFGGuP6tSiYSli4RE4mB31r
         muV3DsuANF67o9C/iCazRdoN7uRe+ZW+kDS2kUGA3AgJJAYvk5CFMrY6hBaqoatWaFiJ
         1O1KQls+GszZP7hlt2aUs2+UZVD2PffVtYeGSHcZFOtj9Y+HwMj9UR2dk2gAd/cyDxgB
         plfqX2ouQ0MjNa2J+zrb+AWKv31Q8p+8Jzr7jgNJLXqi7cDxaLykuUpsrUHHmHN9MS30
         r7HAlTZFOgE/cQqwx4Er68gBvEfzP7ptH28g2lLwZxjBnbzAml+mOObEKcfVS0dYwlC7
         17Rw==
X-Gm-Message-State: AFqh2krKOsAfv23nr61s8fqA8VDteuluE9rdZ3GDY4K1qH78sPt9X5MA
        VSaAdcViysqEvzntQKVpYEiYsUanhzr1MbOLiGPHau64L/JPzZkiOGp+kGNPJk6O5DAvPat/ELI
        27S4JrfxbrjPvih3JWuVM7g==
X-Received: by 2002:a17:906:2612:b0:83f:384f:ea23 with SMTP id h18-20020a170906261200b0083f384fea23mr32919703ejc.57.1674646450238;
        Wed, 25 Jan 2023 03:34:10 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtyYx57jQJdieUbdTUBwBxUl4XDLfq0JYotshu4MM+gfTUH1Ta94yQH+hqhS7cVATVoHCuK2g==
X-Received: by 2002:a17:906:2612:b0:83f:384f:ea23 with SMTP id h18-20020a170906261200b0083f384fea23mr32919687ejc.57.1674646450049;
        Wed, 25 Jan 2023 03:34:10 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id n22-20020a1709065e1600b00877de2def77sm2225888eju.31.2023.01.25.03.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 03:34:09 -0800 (PST)
Message-ID: <6282e9b2-190a-29c8-551b-a63a9a8d611a@redhat.com>
Date:   Wed, 25 Jan 2023 12:34:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] ACPI: PMIC: Add comments with DSDT power opregion field
 names
Content-Language: en-US, nl
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
References: <20230125110718.18194-1-hdegoede@redhat.com>
 <CAHp75VdBzHuo3Ft-f7wPcYF69yJC6_3vnAqxwgxCaKYn556_hQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VdBzHuo3Ft-f7wPcYF69yJC6_3vnAqxwgxCaKYn556_hQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/25/23 12:17, Andy Shevchenko wrote:
> On Wed, Jan 25, 2023 at 1:07 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> The DSDTs of CHT devices using the Dollar Cove TI PMIC, all use
>> LDO1 - LDO14 names for the DSDT power opregion field names.
>>
>> Add comments with these fields to make it easier to see which PMIC
>> registers are being set by ACPI code using these.
>>
>> Note that LDO4 is missing and the mapped registers jump from 0x43
>> to 0x45 to match. This matches with how the fields are declared
>> in the DSDT where LDO3 is skipped to. Note there is no hole in
> 
> LDO4?

Oops, yes LDO4 is not there, my bad. I'll send a v2 fixing the commit
message.

> 
> too
> 
>> the field addresses, LDO3 is simply just not defined on either side.
> 
> LDO4?
> 
> With commit message clarification (whatever is considered correct)
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thank you.

Regards,

Hans


> 
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/acpi/pmic/intel_pmic_chtdc_ti.c | 26 ++++++++++++-------------
>>  1 file changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
>> index 418eec523025..c84ef3d15181 100644
>> --- a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
>> +++ b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
>> @@ -20,19 +20,19 @@
>>  #define CHTDC_TI_GPADC         0x5a
>>
>>  static struct pmic_table chtdc_ti_power_table[] = {
>> -       { .address = 0x00, .reg = 0x41 },
>> -       { .address = 0x04, .reg = 0x42 },
>> -       { .address = 0x08, .reg = 0x43 },
>> -       { .address = 0x0c, .reg = 0x45 },
>> -       { .address = 0x10, .reg = 0x46 },
>> -       { .address = 0x14, .reg = 0x47 },
>> -       { .address = 0x18, .reg = 0x48 },
>> -       { .address = 0x1c, .reg = 0x49 },
>> -       { .address = 0x20, .reg = 0x4a },
>> -       { .address = 0x24, .reg = 0x4b },
>> -       { .address = 0x28, .reg = 0x4c },
>> -       { .address = 0x2c, .reg = 0x4d },
>> -       { .address = 0x30, .reg = 0x4e },
>> +       { .address = 0x00, .reg = 0x41 }, /* LDO1 */
>> +       { .address = 0x04, .reg = 0x42 }, /* LDO2 */
>> +       { .address = 0x08, .reg = 0x43 }, /* LDO3 */
>> +       { .address = 0x0c, .reg = 0x45 }, /* LDO5 */
>> +       { .address = 0x10, .reg = 0x46 }, /* LDO6 */
>> +       { .address = 0x14, .reg = 0x47 }, /* LDO7 */
>> +       { .address = 0x18, .reg = 0x48 }, /* LDO8 */
>> +       { .address = 0x1c, .reg = 0x49 }, /* LDO9 */
>> +       { .address = 0x20, .reg = 0x4a }, /* LD10 */
>> +       { .address = 0x24, .reg = 0x4b }, /* LD11 */
>> +       { .address = 0x28, .reg = 0x4c }, /* LD12 */
>> +       { .address = 0x2c, .reg = 0x4d }, /* LD13 */
>> +       { .address = 0x30, .reg = 0x4e }, /* LD14 */
>>  };
>>
>>  static struct pmic_table chtdc_ti_thermal_table[] = {
>> --
>> 2.39.0
>>
> 
> 

