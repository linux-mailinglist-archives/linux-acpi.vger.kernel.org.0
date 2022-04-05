Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BE04F46D6
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Apr 2022 01:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241496AbiDEUp4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Apr 2022 16:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447557AbiDEPqr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Apr 2022 11:46:47 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ABFC4E24;
        Tue,  5 Apr 2022 07:22:04 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n35so8069579wms.5;
        Tue, 05 Apr 2022 07:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RWfziD1iE8jpxwMBFUUhmMTU0THg9AB/El7kcr/8qtk=;
        b=ffMhxHKve3Xfau+zWOeJA2bLzajuE66dfmgnxUk1ZyDguCAY2M5qml3GD91KTP2OW7
         23kz3N6lBAtVQGzunoCCcR33WhE7ytaChRIB8vaY4ZvH2NEP8EYCHmymotygN1Dsh9rQ
         heJqW3WTozMnNxqCiaMUWY1ZM/D5cCSq0NpBbp5eoMjmggFOKlBjF0dSkUjXReBPL2QX
         umnODX1upo7IYL34c4jmeKtgXAsHSWfLWEMxOYc/TdDARtZfAy/NpFtKjrU4JiFK/VZb
         DvsLVBy61HhunHfN7JzS8Ccoup3oS290noh+1DDkmqwaSOT8sxdc4xUbItViqNmRitnl
         Fpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RWfziD1iE8jpxwMBFUUhmMTU0THg9AB/El7kcr/8qtk=;
        b=ceGBLZeLSlcVJUCw9401tDVWqxCD1BY2NwuHiIw44HZduej7rk4KLh56EqA4EkpRgY
         7ZviS3Y5gj+CYLrCh+C0EY6TQCbd+UV5MRTStkRC2B6wzrvrcZlC/GwPr16Sc8WoxSsH
         cDI+Wm0QNio690xKw13UQpMSeNXeYacZev2BGs3qazIcEbedy9odr8UYfqAKWjWptW9E
         wdGRnuCweHtf44GTtCQZkzk7ur3joyC9LDJ0UCJeqSNSVsMMe4U+cDWdtewWfQt0mtEP
         clGZsmFJAoW8uwgctjZGTMhF7wWeK9TdmzDYFAQtt46P3nPaJ5m5IrAwyJLD6QuTDQ8J
         0aNA==
X-Gm-Message-State: AOAM531KUCe7GtFXEnS8sI9Idm7uM+mRyFZprWBgwP6iiXhDwJucbmBG
        +xLvZy1LaM+mauWZ9QPc/0U=
X-Google-Smtp-Source: ABdhPJzCu0G/jMu35urMh3AzZYiLEhWgmcJyFoD04BpeJxIaKbnExsIu81RtAgrUsWJ2kwjJxyrK0w==
X-Received: by 2002:a1c:f70a:0:b0:37c:533d:d296 with SMTP id v10-20020a1cf70a000000b0037c533dd296mr3237662wmh.147.1649168523281;
        Tue, 05 Apr 2022 07:22:03 -0700 (PDT)
Received: from [192.168.0.14] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id y15-20020a056000168f00b002057a9f9f5csm14991631wrd.31.2022.04.05.07.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 07:22:02 -0700 (PDT)
Message-ID: <6b8fe162-91ff-291d-ffe5-22f44930eb77@gmail.com>
Date:   Tue, 5 Apr 2022 15:22:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/5] ACPI: scan: Add acpi_dev_get_next_consumer_dev()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Robert Moore <robert.moore@intel.com>
References: <20220327161344.50477-1-djrscally@gmail.com>
 <20220327161344.50477-2-djrscally@gmail.com>
 <CAJZ5v0i2ciLHP-=8eQcZc0v0xCzhKHKpxLC=Kgv6W5E_5=HQJA@mail.gmail.com>
From:   Daniel Scally <djrscally@gmail.com>
In-Reply-To: <CAJZ5v0i2ciLHP-=8eQcZc0v0xCzhKHKpxLC=Kgv6W5E_5=HQJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello

On 05/04/2022 13:57, Rafael J. Wysocki wrote:
> On Sun, Mar 27, 2022 at 6:13 PM Daniel Scally <djrscally@gmail.com> wrote:
>> In commit b83e2b306736 ("ACPI: scan: Add function to fetch dependent
>> of ACPI device") we added a means of fetching the first device to
>> declare itself dependent on another ACPI device in the _DEP method.
>> One assumption in that patch was that there would only be a single
>> consuming device, but this has not held.
>>
>> Replace that function with a new function that fetches the next consumer
>> of a supplier device. Where no "previous" consumer is passed in, it
>> behaves identically to the original function.
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>> Signed-off-by: Daniel Scally <djrscally@gmail.com>
>> ---
>> Changes in v2:
>>
>>         - Removed acpi_dev_get_first_consumer_dev() entirely
>>
>>  drivers/acpi/scan.c                         | 37 +++++++++++++++------
>>  drivers/platform/x86/intel/int3472/common.c |  2 +-
>>  include/acpi/acpi_bus.h                     |  4 ++-
>>  3 files changed, 30 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> index 010ef0b28374..8797e4a33674 100644
>> --- a/drivers/acpi/scan.c
>> +++ b/drivers/acpi/scan.c
>> @@ -2215,9 +2215,21 @@ static void acpi_bus_attach(struct acpi_device *device, bool first_pass)
>>                 device->handler->hotplug.notify_online(device);
>>  }
>>
>> -static int acpi_dev_get_first_consumer_dev_cb(struct acpi_dep_data *dep, void *data)
>> +static int acpi_dev_get_next_consumer_dev_cb(struct acpi_dep_data *dep, void *data)
>>  {
>> -       struct acpi_device *adev;
>> +       struct acpi_device *adev = *(struct acpi_device **)data;
> I would prefer
>
> struct acpi_device **adev_p = data;
> struct acpi_device *adev = *adev_p;


This and the below are fine for me; I'll send a v3

>
>> +
>> +       /*
>> +        * If we're passed a 'previous' consumer device then we need to skip
>> +        * any consumers until we meet the previous one, and then NULL @data
>> +        * so the next one can be returned.
>> +        */
>> +       if (adev) {
>> +               if (dep->consumer == adev->handle)
>> +                       *(struct acpi_device **)data = NULL;
>                       *adev_p = NULL;
>
>> +
>> +               return 0;
>> +       }
>>
>>         adev = acpi_bus_get_acpi_device(dep->consumer);
>>         if (adev) {
>> @@ -2348,25 +2360,28 @@ bool acpi_dev_ready_for_enumeration(const struct acpi_device *device)
>>  EXPORT_SYMBOL_GPL(acpi_dev_ready_for_enumeration);
>>
>>  /**
>> - * acpi_dev_get_first_consumer_dev - Return ACPI device dependent on @supplier
>> + * acpi_dev_get_next_consumer_dev - Return the next adev dependent on @supplier
>>   * @supplier: Pointer to the dependee device
>> + * @start: Pointer to the current dependent device
>>   *
>> - * Returns the first &struct acpi_device which declares itself dependent on
>> + * Returns the next &struct acpi_device which declares itself dependent on
>>   * @supplier via the _DEP buffer, parsed from the acpi_dep_list.
>>   *
>> - * The caller is responsible for putting the reference to adev when it is no
>> - * longer needed.
>> + * If the returned adev is not passed as @start to this function, the caller is
>> + * responsible for putting the reference to adev when it is no longer needed.
>>   */
>> -struct acpi_device *acpi_dev_get_first_consumer_dev(struct acpi_device *supplier)
>> +struct acpi_device *acpi_dev_get_next_consumer_dev(struct acpi_device *supplier,
>> +                                                  struct acpi_device *start)
>>  {
>> -       struct acpi_device *adev = NULL;
>> +       struct acpi_device *adev = start;
>>
>>         acpi_walk_dep_device_list(supplier->handle,
>> -                                 acpi_dev_get_first_consumer_dev_cb, &adev);
>> +                                 acpi_dev_get_next_consumer_dev_cb, &adev);
>>
>> -       return adev;
>> +       acpi_dev_put(start);
>> +       return adev == start ? NULL : adev;
> And here
>
> if (adev == start)
>         return NULL;
>
> return adev;
>
>>  }
>> -EXPORT_SYMBOL_GPL(acpi_dev_get_first_consumer_dev);
>> +EXPORT_SYMBOL_GPL(acpi_dev_get_next_consumer_dev);
>>
>>  /**
>>   * acpi_bus_scan - Add ACPI device node objects in a given namespace scope.
>> diff --git a/drivers/platform/x86/intel/int3472/common.c b/drivers/platform/x86/intel/int3472/common.c
>> index 77cf058e4168..9db2bb0bbba4 100644
>> --- a/drivers/platform/x86/intel/int3472/common.c
>> +++ b/drivers/platform/x86/intel/int3472/common.c
>> @@ -62,7 +62,7 @@ int skl_int3472_get_sensor_adev_and_name(struct device *dev,
>>         struct acpi_device *sensor;
>>         int ret = 0;
>>
>> -       sensor = acpi_dev_get_first_consumer_dev(adev);
>> +       sensor = acpi_dev_get_next_consumer_dev(adev, NULL);
>>         if (!sensor) {
>>                 dev_err(dev, "INT3472 seems to have no dependents.\n");
>>                 return -ENODEV;
>> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
>> index 2f93ecf05dac..cdc726d251b6 100644
>> --- a/include/acpi/acpi_bus.h
>> +++ b/include/acpi/acpi_bus.h
>> @@ -696,7 +696,9 @@ bool acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, const ch
>>
>>  void acpi_dev_clear_dependencies(struct acpi_device *supplier);
>>  bool acpi_dev_ready_for_enumeration(const struct acpi_device *device);
>> -struct acpi_device *acpi_dev_get_first_consumer_dev(struct acpi_device *supplier);
>> +struct acpi_device *acpi_dev_get_next_consumer_dev(struct acpi_device *supplier,
>> +                                                  struct acpi_device *start);
>> +
>>  struct acpi_device *
>>  acpi_dev_get_next_match_dev(struct acpi_device *adev, const char *hid, const char *uid, s64 hrv);
>>  struct acpi_device *
>> --
>> 2.25.1
>>
