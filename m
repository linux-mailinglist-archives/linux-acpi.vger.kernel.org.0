Return-Path: <linux-acpi+bounces-198-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1E07B06EC
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 6E971282616
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 14:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563F8347D1
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 14:33:21 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8C2C8E2
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 13:17:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACACA121
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 06:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695820672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3bwPqaSphrGy3IZbd7qFF8174I53rtWlv8Z5kNQYDxg=;
	b=L7praLbjmQvT8n9v+DFCj2wPK81DpoU5PQ9rOHpr8eivmCgkrxtSHneuZFvC0qjYp3Fq86
	hU/0m7bqS7FD9N1XkhbtwjgAhFuA1EiYQ+8EJ0iSvwiTG/rZNlIglsOwHu5krVMs8tbU9V
	v1K0Q8PEPZJOKs9ewsNK0MS42io1wSE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-XzQX-fV3O_mIblYGhtPyhA-1; Wed, 27 Sep 2023 09:17:51 -0400
X-MC-Unique: XzQX-fV3O_mIblYGhtPyhA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9a681c3470fso923998366b.1
        for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 06:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695820670; x=1696425470;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3bwPqaSphrGy3IZbd7qFF8174I53rtWlv8Z5kNQYDxg=;
        b=IUdqqGqFO44R3JX4VF6eMkPtGVl8wyVZNd+TDKY7lbLhs7+ttZaSOevAtfP063syHS
         i+v4IewMMkET3i+1vJ4fzr43N5KxNbC4VCP0ZWRNbzWySSM7RtLefkYy8MT0HALkZVDH
         BidPmFW26iOAZnOXTEiTprARsLRbP2LkiZUv7TmLxeqElvvkYABO1zbsR7W/0CoTnw/z
         o1qZL0HyYsjOX5FAPqUqsH7w3L7S6Pyt5x6fVbCROrofxd+2b/ra7ImL9RltR6LDG14h
         umbscsFtwHPX/DjHg1A48myxZuPRfdahOgB2/dcKJFTFZMgx4EgzFGSg9nZg+gmZ88La
         cJFg==
X-Gm-Message-State: AOJu0Yw+QTm8B4gPIAGSWNxoVcdNjpFG6008QVF5MnOKlQOIk/xqjPUU
	Ntb66P0NqZGyzDpkDfHTCD8SSYC0CbmYRctg2lL62lfaEO2eiFX5mY5kxYrEyHZQR3G2Syjwx2L
	2lsepBvCiGbXgUhZvPXAMOA==
X-Received: by 2002:a17:907:780b:b0:9ae:6355:afe9 with SMTP id la11-20020a170907780b00b009ae6355afe9mr1834013ejc.52.1695820670356;
        Wed, 27 Sep 2023 06:17:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcFMBgnkkkfPmnZduR/RzERo1iFJANN51tYfOFZOeu6D+NKkAerFz89yTzT+NcrTqRmW4q9w==
X-Received: by 2002:a17:907:780b:b0:9ae:6355:afe9 with SMTP id la11-20020a170907780b00b009ae6355afe9mr1833987ejc.52.1695820669960;
        Wed, 27 Sep 2023 06:17:49 -0700 (PDT)
Received: from [192.168.1.217] ([109.36.155.235])
        by smtp.gmail.com with ESMTPSA id vw7-20020a170907058700b009b27d4153cfsm2583163ejb.176.2023.09.27.06.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 06:17:49 -0700 (PDT)
Message-ID: <681ddbf9-baeb-9876-8615-5ec8a4b6c368@redhat.com>
Date: Wed, 27 Sep 2023 15:17:45 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFT PATCH 2/4] platform/x86: int3472: led: don't use
 gpiod_toggle_active_low()
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Daniel Scally
 <djrscally@gmail.com>, Mark Gross <markgross@kernel.org>,
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230926145943.42814-1-brgl@bgdev.pl>
 <20230926145943.42814-3-brgl@bgdev.pl>
 <2b5db794-c00f-e9f5-c0c9-4c5fb4df0802@redhat.com>
 <CAMRc=MeSK-ZReyt4556Dik4GwgtitD-NBgVE0swe=4i+5gBLwA@mail.gmail.com>
 <3f8760f8-ae8c-c0b0-19d7-76fbbf5d25de@redhat.com>
In-Reply-To: <3f8760f8-ae8c-c0b0-19d7-76fbbf5d25de@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Again,

On 9/27/23 15:08, Hans de Goede wrote:
> Hi Bart,
> 
> On 9/27/23 12:44, Bartosz Golaszewski wrote:
>> On Wed, Sep 27, 2023 at 11:40 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> Hi,
>>>
>>> On 9/26/23 16:59, Bartosz Golaszewski wrote:
>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>
>>>> Instead of acpi_get_and_request_gpiod() + gpiod_toggle_active_low(), use
>>>> temporary lookup tables with appropriate lookup flags.
>>>>
>>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>> ---
>>>>  drivers/platform/x86/intel/int3472/led.c | 12 ++++--------
>>>>  1 file changed, 4 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/platform/x86/intel/int3472/led.c b/drivers/platform/x86/intel/int3472/led.c
>>>> index bca1ce7d0d0c..62e0cd5207a7 100644
>>>> --- a/drivers/platform/x86/intel/int3472/led.c
>>>> +++ b/drivers/platform/x86/intel/int3472/led.c
>>>> @@ -25,18 +25,14 @@ int skl_int3472_register_pled(struct int3472_discrete_device *int3472,
>>>>       if (int3472->pled.classdev.dev)
>>>>               return -EBUSY;
>>>>
>>>> -     int3472->pled.gpio = acpi_get_and_request_gpiod(path, agpio->pin_table[0],
>>>> -                                                          "int3472,privacy-led");
>>>> +     int3472->pled.gpio = skl_int3472_gpiod_get_from_temp_lookup(
>>>> +                             int3472->dev, path, agpio->pin_table[0],
>>>> +                             "int3472,privacy-led", polarity,
>>>> +                             GPIOD_OUT_LOW);
>>>
>>> Yeah so this is not going to work, path here is an ACPI device path, e.g.
>>> on my laptop (which actually uses the INT3472 glue code) the path-s of
>>> the 2 GPIO controllers are: `\_SB_.GPI0` resp `\_SB_.PC00.XHCI.RHUB.HS08.VGPO`
>>>
>>> Where as skl_int3472_gpiod_get_from_temp_lookup() stores the passed in path
>>> in  gpiod_lookup_table.table[0].key, which is the dev_name() of the GPIO
>>> controller's parent dev which are `INTC1055:00` resp. `INTC1096:00` .
>>>
>>> So we are going to need to add some code to INT3472 to go from path to
>>> a correct value for gpiod_lookup_table.table[0].key which means partly
>>> reproducing most of acpi_get_gpiod:
>>>
>>>         struct gpio_chip *chip;
>>>         acpi_handle handle;
>>>         acpi_status status;
>>>
>>>         status = acpi_get_handle(NULL, path, &handle);
>>>         if (ACPI_FAILURE(status))
>>>                 return ERR_PTR(-ENODEV);
>>>
>>>         chip = gpiochip_find(handle, acpi_gpiochip_find);
>>>         if (!chip)
>>>                 return ERR_PTR(-EPROBE_DEFER);
>>>
>>> And then get the key from the chip. Which means using gpiochip_find
>>> in the int3472 code now, which does not sound like an improvement.
>>>
>>> I think that was is needed instead is adding an active_low flag
>>> to acpi_get_and_request_gpiod() and then have that directly
>>> set the active-low flag on the returned desc.
>>>
>>
>> Ultimately I'd like everyone to use gpiod_get() for getting
>> descriptors but for now I get it's enough. Are you find with this
>> being done in a single patch across GPIO and this driver?
> 
> Yes doing this in a single patch is fine.
> 
> Also I'm fine with merging such a patch through the gpio tree .

So thinking about this more I realized that the int3472 code already
generates GPIO lookups for the sensor device for some
(powerdown, reset) GPIOs, it only needs the gpio_desc for
the case where the GPIO is turned into a regulator, clock or led.

Since the int3472 code is already generating lookups it already
has a way to go from path to a lookup "key":

        status = acpi_get_handle(NULL, path, &handle);
        if (ACPI_FAILURE(status))
                return -EINVAL;

        adev = acpi_fetch_acpi_dev(handle);
        if (!adev)
                return -ENODEV;

        table_entry->key = acpi_dev_name(adev);

So we can get the key without needing to call gpio_find_chip()

So I do believe that the temp lookup approach should actually
work. I'm currently traveling, so no promises but I should
be able to rework your series in something which actually
works and which will:

1. Stop using gpiod_toggle_active_low()
2. Allow dropping acpi_get_and_request_gpiod()

So no need for a patch to add an active-low parameter to
acpi_get_and_request_gpiod(), sorry about the noise.

Regards,

Hans




>>>>       if (IS_ERR(int3472->pled.gpio))
>>>>               return dev_err_probe(int3472->dev, PTR_ERR(int3472->pled.gpio),
>>>>                                    "getting privacy LED GPIO\n");
>>>>
>>>> -     if (polarity == GPIO_ACTIVE_LOW)
>>>> -             gpiod_toggle_active_low(int3472->pled.gpio);
>>>> -
>>>> -     /* Ensure the pin is in output mode and non-active state */
>>>> -     gpiod_direction_output(int3472->pled.gpio, 0);
>>>> -
>>>>       /* Generate the name, replacing the ':' in the ACPI devname with '_' */
>>>>       snprintf(int3472->pled.name, sizeof(int3472->pled.name),
>>>>                "%s::privacy_led", acpi_dev_name(int3472->sensor));
>>>
>>


