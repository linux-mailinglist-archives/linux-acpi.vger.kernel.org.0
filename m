Return-Path: <linux-acpi+bounces-425-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6907B8558
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 18:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4A69E2815C9
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 16:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306471C287
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 16:32:40 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BFF1C28E
	for <linux-acpi@vger.kernel.org>; Wed,  4 Oct 2023 16:30:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BACDC
	for <linux-acpi@vger.kernel.org>; Wed,  4 Oct 2023 09:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696437014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lI0tHuKQm3hza7SJ8Hfos0tclaGBNnEY+R8qHgZutNg=;
	b=QJf80yI2Nh/HQrBL8dVg4HwyXInm7V1CMnArk0pGIP7Rxhy9vRh+9cEfEBAjma3IWyHLlw
	s1ZCcAcjJcdc6kQ+OF7Ak9jdWBP7uDUWs7wpR6K54FaPHz4mShQpsdftzp74YplJIGB5cT
	VbxbOKMoSovLHx7zilC1Lt45ppF9E5I=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-BICqCN0rMs6TYyGpIxh1_Q-1; Wed, 04 Oct 2023 12:30:02 -0400
X-MC-Unique: BICqCN0rMs6TYyGpIxh1_Q-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9adad8f306fso2073866b.0
        for <linux-acpi@vger.kernel.org>; Wed, 04 Oct 2023 09:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696437001; x=1697041801;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lI0tHuKQm3hza7SJ8Hfos0tclaGBNnEY+R8qHgZutNg=;
        b=Ffuspry9zmih2JCmiX/QW1PZvGyfAKm+6bcG5sKAJjG8UZLTCRoafgPGQIk8V+Gmvn
         aMoVSH7Y+ec/h2LUJOb/rKjA6fa41GYyGttXSAHYYxKpz1mnReoNsbWghgw5bmE6PIw0
         ZIE1UvUhqCWgcQ9DblTW3lmgS0EUdHdZ30xxlpiLob9Ulgk1BIU1nPGt9mL/uLOJPAtE
         JluepPRzL1jx6LcoouQIXmorjlrz7RrUFmQ6m6yvh4Go/vFkDMnwmhsYD6b6BzCySzW1
         hjGABmxSXBlBqE90zzEjjxT3klwbkKZnBN/I+/34iaTUaLZRDn/zwB5gB3I9L6Zfnc/U
         v6bQ==
X-Gm-Message-State: AOJu0Yz8QhNIIDkcqD1MVYLPU6FRH/9NtcGrdI9w0oJ7nFYPEw+DanOk
	Gy3TNIjA7fNMFgQslD7jXXAa4oRl+MHBZNqYQ7Kj3QfECyAMarmHp9qnHqe6Jms0EEeeAUCqdh0
	gQxG/iJJh5mr8S6hkrBnZHg==
X-Received: by 2002:a17:906:7382:b0:9ae:284:c93d with SMTP id f2-20020a170906738200b009ae0284c93dmr2244826ejl.5.1696437001592;
        Wed, 04 Oct 2023 09:30:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElkl1GzNocfc8JqmyUzDxej18jix4NEB50qQW6aI4r9SQHJwYmjjgCrxLNlGo7Q0rxgU8BSw==
X-Received: by 2002:a17:906:7382:b0:9ae:284:c93d with SMTP id f2-20020a170906738200b009ae0284c93dmr2244800ejl.5.1696437001198;
        Wed, 04 Oct 2023 09:30:01 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id gr11-20020a170906e2cb00b0099ccee57ac2sm3063899ejb.194.2023.10.04.09.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 09:30:00 -0700 (PDT)
Message-ID: <29764d46-8d3d-9794-bbde-d7928a91cbb5@redhat.com>
Date: Wed, 4 Oct 2023 18:29:59 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/5] platform/x86: int3472: don't use
 gpiod_toggle_active_low()
Content-Language: en-US, nl
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Daniel Scally
 <djrscally@gmail.com>, Mark Gross <markgross@kernel.org>,
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20230926145943.42814-1-brgl@bgdev.pl>
 <e6817d30-b443-1a73-efae-84415604b19f@redhat.com>
 <CACMJSetWH=Z5ubHb33W0mYvpqkU7vv=nKNBSa9eLmAi94NyrgA@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CACMJSetWH=Z5ubHb33W0mYvpqkU7vv=nKNBSa9eLmAi94NyrgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Bart,

On 9/28/23 20:40, Bartosz Golaszewski wrote:
> On Thu, 28 Sept 2023 at 14:40, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi All,
>>
>> Here is a v2 of Bartosz' "don't use gpiod_toggle_active_low()" series.
>>
>> New in v2:
>> - Rework to deal with ACPI path vs gpiod_lookup.key differences:
>>   acpi_get_handle(path) -> acpi_fetch_acpi_dev(handle) -> acpi_dev_name(adev)
>>
>> Regards,
>>
>> Hans
>>
>>
>> Bartosz Golaszewski (2):
>>   platform/x86: int3472: Add new
>>     skl_int3472_gpiod_get_from_temp_lookup() helper
>>   gpio: acpi: remove acpi_get_and_request_gpiod()
>>
>> Hans de Goede (3):
>>   platform/x86: int3472: Add new skl_int3472_fill_gpiod_lookup() helper
>>   platform/x86: int3472: Stop using gpiod_toggle_active_low()
>>   platform/x86: int3472: Switch to devm_get_gpiod()
>>
>>  drivers/gpio/gpiolib-acpi.c                   |  28 -----
>>  .../x86/intel/int3472/clk_and_regulator.c     |  54 ++--------
>>  drivers/platform/x86/intel/int3472/common.h   |   7 +-
>>  drivers/platform/x86/intel/int3472/discrete.c | 101 ++++++++++++++----
>>  drivers/platform/x86/intel/int3472/led.c      |  24 +----
>>  include/linux/gpio/consumer.h                 |   8 --
>>  6 files changed, 93 insertions(+), 129 deletions(-)
>>
>> --
>> 2.41.0
>>
> 
> Thanks Hans, this looks good to me. I'd let it sit on the list for a
> week. After that, do you want to take patches 1-4 and provide me with
> another tag?

I have just send out a v3 to address Andy's remark about me
somehow resetting the authorship to me on 2 patches from Bartosz.

While working on this I noticed (and fixed) a bug in:

[RFT PATCH 1/4] platform/x86: int3472: provide a helper for getting GPIOs from lookups
https://lore.kernel.org/all/20230926145943.42814-2-brgl@bgdev.pl/

	struct gpiod_lookup_table *lookup __free(kfree) =
			kzalloc(struct_size(lookup, table, 1), GFP_KERNEL);

You are allocating an entry for the temp lookup, but the gpiolib
core expects lookup tables to be terminated with an entry lookup,
so this should alloc space for 2 entries:

	struct gpiod_lookup_table *lookup __free(kfree) =
			kzalloc(struct_size(lookup, table, 2), GFP_KERNEL);

Despite this already being fixed now I wanted to explicitly point
this out in case you have used the same construct elsewhere during
your recent gpiolib cleanup efforts ?

As for your request for a tag for the 4st 4 patches for you to merge
into gpiolib. I'll go and work work on that. I need to coordinate
this with Ilpo, with whom I now co-maintain pdx86 .

Regards,

Hans



