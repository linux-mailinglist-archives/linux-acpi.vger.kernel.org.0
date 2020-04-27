Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D0B1BA804
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Apr 2020 17:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgD0Pbb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Apr 2020 11:31:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55831 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728157AbgD0Pbb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 27 Apr 2020 11:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588001489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TKFWcoJJEHH5/ibI5vdJgvFR606TzkLnlJit+oD4SIw=;
        b=Nqid3mtuCH8O28RxmQ6LLc+JTgTL5NXYAdL/LxoBk5VlDyVOs+IqiUgIzJ1O7eHHV4RZvR
        Dtl00kjzX30a5cAsQEKonuyRj5RmMVEPKmUM9BbQrneRGLRbktTM4V04xD7gMqueihQsn1
        YC+Pkxl6365tSi70IYhweQp3Y/7b8po=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-DYiQUBZ4PRO86w_NKVkfQw-1; Mon, 27 Apr 2020 11:31:27 -0400
X-MC-Unique: DYiQUBZ4PRO86w_NKVkfQw-1
Received: by mail-wm1-f72.google.com with SMTP id o26so23154wmh.1
        for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2020 08:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TKFWcoJJEHH5/ibI5vdJgvFR606TzkLnlJit+oD4SIw=;
        b=eyBTvAekloxaWpc+dUvaK4ddkeGReBK6/zhiwibR2BbXZTEQaza/A9ZEkPdl3h5JTd
         L50S9w5ftsR9O3p6HQZSpU5F2X71KkEK+wUOzRKHkHYGAZrx+jViginoMg9wk+h+N4iN
         19kqvLU6zgwusN2ZQWEF2Z1ePZtIWpP9N7Kph1Nk2hpJIrWBU2Bbb8L3RNOy9/fUERhd
         QJt7c/VoWnh9156Oz6AQS4u4Dkg5lgpbh7ZO+XOkL6EeddCnzTNB8GmzxfEGzBrbF2Sw
         z2B1T3QM+thk4HZ7GYx8gyB0aIdKbECVudqAUKc3OezSOooIthuGod3YH1Olff0x5KXZ
         eusw==
X-Gm-Message-State: AGi0PuZOoNYG10p+WeDYGr/qkJowWefVs58O6FegN5MBWgm0M8BUocHa
        jW5Eilg47ISlMsWq1C8MKLU6VFyRB2lyERMTFXLMiDDGwgvsAAgTN4lUXHg7NutHnptrsx0ZLjT
        ua6gMNoULKlrR6H/3BB0J8A==
X-Received: by 2002:adf:f74f:: with SMTP id z15mr27610544wrp.297.1588001485952;
        Mon, 27 Apr 2020 08:31:25 -0700 (PDT)
X-Google-Smtp-Source: APiQypK1z0uJnIkyqKhTGjclHeQYArQfsANi9lGv3gcyQLqpd9WZYBRVORDchAEbGQqBBjAFAxmDtQ==
X-Received: by 2002:adf:f74f:: with SMTP id z15mr27610523wrp.297.1588001485724;
        Mon, 27 Apr 2020 08:31:25 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id q184sm16239828wma.25.2020.04.27.08.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 08:31:24 -0700 (PDT)
Subject: Re: [PATCH 7/8] iio: light: cm32181: Add support for parsing CPM0 and
 CPM1 ACPI tables
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Kevin Tsai <ktsai@capellamicro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
References: <20200426110256.218186-1-hdegoede@redhat.com>
 <20200426110256.218186-7-hdegoede@redhat.com>
 <CAHp75Vdzu18gKaix2B5btEAz6YX7JZ3wJfeSR-MAV6nLeJUMzg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ade56f53-8ac5-1900-21fa-574f27e2a24a@redhat.com>
Date:   Mon, 27 Apr 2020 17:31:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vdzu18gKaix2B5btEAz6YX7JZ3wJfeSR-MAV6nLeJUMzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 4/26/20 7:50 PM, Andy Shevchenko wrote:
> On Sun, Apr 26, 2020 at 2:03 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> On ACPI based systems the CPLM3218 ACPI device node describing the
>> CM3218[1] sensor typically will have some extra tables with register
>> init values for initializing the sensor and calibration info.
>>
>> This is based on a newer version of cm32181.c, with a copyright of:
>>
>>   * Copyright (C) 2014 Capella Microsystems Inc.
>>   * Author: Kevin Tsai <ktsai@capellamicro.com>
>>   *
>>   * This program is free software; you can redistribute it and/or modify it
>>   * under the terms of the GNU General Public License version 2, as published
>>   * by the Free Software Foundation.
>>
>> Which is floating around on the net in various places, but the changes
>> from this newer version never made it upstream.
>>
>> This was tested on the following models: Acer Switch 10 SW5-012 (CM32181)
>> Asus T100TA (CM3218), Asus T100CHI (CM3218) and HP X2 10-n000nd (CM32181).
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/iio/light/cm32181.c | 98 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 98 insertions(+)
>>
>> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
>> index e5674d4a8143..878fc13632d8 100644
>> --- a/drivers/iio/light/cm32181.c
>> +++ b/drivers/iio/light/cm32181.c
>> @@ -4,6 +4,7 @@
>>    * Author: Kevin Tsai <ktsai@capellamicro.com>
>>    */
>>
>> +#include <linux/acpi.h>
>>   #include <linux/delay.h>
>>   #include <linux/err.h>
>>   #include <linux/i2c.h>
>> @@ -53,6 +54,15 @@
>>
>>   #define SMBUS_ALERT_RESPONSE_ADDRESS   0x0c
>>
>> +/* CPM0 Index 0: device-id (3218 or 32181), 1: Unknown, 2: init_regs_bitmap */
>> +#define CPM0_REGS_BITMAP               2
>> +#define CPM0_HEADER_SIZE               3
>> +
>> +/* CPM1 Index 0: lux_per_bit, 1: calibscale, 2: resolution (100000) */
>> +#define CPM1_LUX_PER_BIT               0
>> +#define CPM1_CALIBSCALE                        1
>> +#define CPM1_SIZE                      3
>> +
>>   /* CM3218 Family */
>>   static const int cm3218_als_it_bits[] = { 0, 1, 2, 3 };
>>   static const int cm3218_als_it_values[] = { 100000, 200000, 400000, 800000 };
>> @@ -76,6 +86,56 @@ struct cm32181_chip {
>>          const int *als_it_values;
>>   };
>>
>> +static int cm32181_read_als_it(struct cm32181_chip *cm32181, int *val2);
>> +
>> +#ifdef CONFIG_ACPI
>> +/**
>> + * cm32181_acpi_get_cpm() - Get CPM object from ACPI
>> + * @client     pointer of struct i2c_client.
>> + * @obj_name   pointer of ACPI object name.
>> + * @count      maximum size of return array.
>> + * @vals       pointer of array for return elements.
>> + *
>> + * Convert ACPI CPM table to array.
>> + *
>> + * Return: -ENODEV for fail.  Otherwise is number of elements.
>> + */
>> +static int cm32181_acpi_get_cpm(struct i2c_client *client, char *obj_name,
>> +                               u64 *values, int count)
>> +{
>> +       struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>> +       union acpi_object *cpm, *elem;
>> +       acpi_handle handle;
>> +       acpi_status status;
>> +       int i;
>> +
>> +       handle = ACPI_HANDLE(&client->dev);
>> +       if (!handle)
>> +               return -ENODEV;
>> +
>> +       status = acpi_evaluate_object(handle, obj_name, NULL, &buffer);
>> +       if (ACPI_FAILURE(status)) {
>> +               dev_err(&client->dev, "object %s not found\n", obj_name);
>> +               return -ENODEV;
>> +       }
>> +
>> +       cpm = buffer.pointer;
>> +       if (cpm->package.count > count)
>> +               dev_warn(&client->dev, "%s table contains %d values, only using first %d values\n",
>> +                        obj_name, cpm->package.count, count);
>> +
>> +       count = min_t(int, cpm->package.count, count);
>> +       for (i = 0; i < count; i++) {
>> +               elem = &(cpm->package.elements[i]);
>> +               values[i] = elem->integer.value;
>> +       }
>> +
>> +       kfree(buffer.pointer);
>> +
>> +       return count;
>> +}
>> +#endif /* CONFIG_ACPI */
>> +
>>   /**
>>    * cm32181_reg_init() - Initialize CM32181 registers
>>    * @cm32181:   pointer of struct cm32181.
>> @@ -121,6 +181,44 @@ static int cm32181_reg_init(struct cm32181_chip *cm32181)
>>          cm32181->lux_per_bit = CM32181_LUX_PER_BIT;
>>          cm32181->lux_per_bit_base_it = CM32181_LUX_PER_BIT_BASE_IT;
>>
>> +#ifdef CONFIG_ACPI
>> +       if (ACPI_HANDLE(&client->dev)) {
>> +               u64 values[CPM0_HEADER_SIZE + CM32181_CONF_REG_NUM];
>> +               int count;
>> +
>> +               count = cm32181_acpi_get_cpm(client, "CPM0",
>> +                                            values, ARRAY_SIZE(values));
>> +               if (count <= CPM0_HEADER_SIZE)
>> +                       goto cpm_parsing_done;
>> +
>> +               count -= CPM0_HEADER_SIZE;
>> +
>> +               cm32181->init_regs_bitmap = values[CPM0_REGS_BITMAP];
>> +               cm32181->init_regs_bitmap &= GENMASK(count - 1, 0);
>> +               for (i = 0; i < count; i++) {
>> +                       if (cm32181->init_regs_bitmap & BIT(i))
>> +                               cm32181->conf_regs[i] =
>> +                                       values[CPM0_HEADER_SIZE + i];
>> +               }
>> +
>> +               count = cm32181_acpi_get_cpm(client, "CPM1",
>> +                                            values, ARRAY_SIZE(values));
>> +               if (count != CPM1_SIZE)
>> +                       goto cpm_parsing_done;
>> +
>> +               cm32181->lux_per_bit = values[CPM1_LUX_PER_BIT];
>> +
>> +               /* Check for uncalibrated devices */
>> +               if (values[CPM1_CALIBSCALE] == CM32181_CALIBSCALE_DEFAULT)
>> +                       goto cpm_parsing_done;
>> +
>> +               cm32181->calibscale  = values[CPM1_CALIBSCALE];
>> +               /* CPM1 lux_per_bit is for the current it value */
>> +               cm32181_read_als_it(cm32181, &cm32181->lux_per_bit_base_it);
>> +       }
>> +cpm_parsing_done:
> 
> Perhaps factor out to a helper, will
> a) allow to get rid of a label;
> b) drop indentation level.

Thank you for the reviews.

Factoring this into a helper is a good idea, that will also allow
getting rid of 1 of the CONFIG_ACPI #ifdef-s.

I also agree with your comments on the other patches.

I'll prepare and test a v2 with these changes and then submit
it with your Reviewed-by added.

Regards,

Hans

