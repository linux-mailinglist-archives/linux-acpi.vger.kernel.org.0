Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6901C35FE
	for <lists+linux-acpi@lfdr.de>; Mon,  4 May 2020 11:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgEDJqg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 May 2020 05:46:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45384 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728349AbgEDJqg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 May 2020 05:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588585594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=scFFt0BtLPxeOsN+SbAlNTW9udoDL7YI1oVFgdqCTZQ=;
        b=CLqy5JAiiaVJiSAFKO2F8rloFEvEH0aMr03JmsEQ3i1m7buNzZPB5CzVP0Xuegz4YVdDju
        Ckwgh8bjuOzZSpGLnLmV6bTeiyzGKsMRy5wsmEDdHulRZQt9alFIw1jtBP0SeZL3urJI1V
        pElxW1i4f9tMZntCClcgoCemygNXCUc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-Gryu1wwgPpOzRflDl3lCXQ-1; Mon, 04 May 2020 05:46:33 -0400
X-MC-Unique: Gryu1wwgPpOzRflDl3lCXQ-1
Received: by mail-wm1-f72.google.com with SMTP id f81so3220410wmf.2
        for <linux-acpi@vger.kernel.org>; Mon, 04 May 2020 02:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=scFFt0BtLPxeOsN+SbAlNTW9udoDL7YI1oVFgdqCTZQ=;
        b=DnL4uuhoReWhtHAHvX3dwxWd/qiJBGv634vyUHsj5WhYDk47MkHk4Kf8MeEH6E79aw
         XJa+fP1jZbnOI5/410eZr3jr0yN+CpVu6RPD5xt9C15TqoFM/UreR5y2bbubARgo9jfR
         iY9QL378VukMBZKE5vYjZPSSsEeMjVnAWSQ0LdiLe0F5+YJljaMLs2LIa4Z0JbzJq57p
         ZoI3wRATdueI8QR1wSA9nhqauIt5gKi25IZSTeeCFIHGH5dhxIloVGzu2R1fxV1kYA/L
         b6fGDSZfqL2gcbje7zGbTFJ+VvXoygIg1k4vlnhFU0W262ZyUuj/mMsoPHc/xbZj+jzb
         B3bw==
X-Gm-Message-State: AGi0PubISZPiXctETnkM3B3+M4dR1L5MKnBON/ZuNDGWSUxHQYcehBkz
        OOmHV+vQQwgQ3HoPvM6qcppjNLzs5uPjHmh8cj8OEoM08NKpPVM3tMKxT/lAETTjE/Owme1ffgN
        IprJHyRvoYREr5q80umeEZw==
X-Received: by 2002:a5d:4e0a:: with SMTP id p10mr10850200wrt.215.1588585592347;
        Mon, 04 May 2020 02:46:32 -0700 (PDT)
X-Google-Smtp-Source: APiQypL0l4tMFMDt9Hx6InMV/UDMk+rNzIMkzBVD6Xl95GsMPzXuuyBsYRdcehNHJEPa9EQux5wbsg==
X-Received: by 2002:a5d:4e0a:: with SMTP id p10mr10850189wrt.215.1588585592165;
        Mon, 04 May 2020 02:46:32 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id z18sm17330878wrw.41.2020.05.04.02.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 02:46:31 -0700 (PDT)
Subject: Re: [PATCH v3 01/11] iio: light: cm32181: Switch to new style
 i2c-driver probe function
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <20200428172923.567806-1-hdegoede@redhat.com>
 <20200503115456.11a16411@archlinux>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4f6df1df-8c82-c14f-8862-c020d67d3df3@redhat.com>
Date:   Mon, 4 May 2020 11:46:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200503115456.11a16411@archlinux>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 5/3/20 12:54 PM, Jonathan Cameron wrote:
> On Tue, 28 Apr 2020 19:29:13 +0200
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Switch to the new style i2c-driver probe_new probe function and drop the
>> unnecessary i2c_device_id table (we do not have any old style board files
>> using this).
>>
>> This is a preparation patch for adding ACPI binding support.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v3:
>> - This is a new patch in v3 of this patch-set
>> ---
>>   drivers/iio/light/cm32181.c | 15 +++------------
>>   1 file changed, 3 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
>> index 5f4fb5674fa0..cc57190a24cb 100644
>> --- a/drivers/iio/light/cm32181.c
>> +++ b/drivers/iio/light/cm32181.c
>> @@ -294,8 +294,7 @@ static const struct iio_info cm32181_info = {
>>   	.attrs			= &cm32181_attribute_group,
>>   };
>>   
>> -static int cm32181_probe(struct i2c_client *client,
>> -			const struct i2c_device_id *id)
>> +static int cm32181_probe(struct i2c_client *client)
>>   {
>>   	struct cm32181_chip *cm32181;
>>   	struct iio_dev *indio_dev;
>> @@ -316,7 +315,7 @@ static int cm32181_probe(struct i2c_client *client,
>>   	indio_dev->channels = cm32181_channels;
>>   	indio_dev->num_channels = ARRAY_SIZE(cm32181_channels);
>>   	indio_dev->info = &cm32181_info;
>> -	indio_dev->name = id->name;
>> +	indio_dev->name = dev_name(&client->dev);
> 
> ABI breakage.  The name needs to be unaffected by this patch and I'm
> fairly sure it just gained the vendor prefix.
> 
> So to drop that table, you need to provide the 'clean' part number
> somewhere else.  Seeing as driver currently only supports one number,
> you could just provide it directly here. However, as you are
> going to add support for another part number later, you'll need
> to do something more clever when you introduce that.

Ok, I will fix this for the next version.

> I'll make this suggestion in that patch, but I think you should add
> a chip_info structure for each of the supported chips rather than using
> a switch to put a number of different elements in place.  The name
> would then go in there.

Ok, I will add a chip_info structure for the next version (version 4).

Regards,

Hans

