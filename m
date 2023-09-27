Return-Path: <linux-acpi+bounces-182-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A14277B01F4
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 12:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 53B7E2829CE
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 10:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBDA15AC2
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 10:33:56 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8070FF9DF
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 08:41:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D51FC0
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 01:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695804070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dRjpHatXMpLPR28RDuixweakSgTj14YOtfkxYl7i+lQ=;
	b=KQ5k5EkJCseJgInAWsZbFeMA7Ie7bwV3f/cXopU5YQXDI0DC1Acbrui7yXzyW9h1ci/y1S
	RGG73L90HZ74MUI/YEs93NYtyraz3Ry+UUfJb9hVyHMyPUoxZTwVxmeaT4SB2qvONpTLpS
	l0JhcI5qH8sBv6QszmV0kStMSLc+CP8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-r0B00xkANGao0wGG5Uv2Sg-1; Wed, 27 Sep 2023 04:41:09 -0400
X-MC-Unique: r0B00xkANGao0wGG5Uv2Sg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9ae42088b4bso885940766b.3
        for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 01:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695804068; x=1696408868;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dRjpHatXMpLPR28RDuixweakSgTj14YOtfkxYl7i+lQ=;
        b=lMDtGJXpEI2y2QhPrGxch/kroMx6J/LdPxMMZ3G53Hh7c8Yb0nRy2egbBRVPWSND+j
         hASeLuEjE7WLFa9OGtgfXSGpBq7M+CR8Jpe2zxL4FT8v1VeOvgc7yOzOG07ESusqH9pD
         xA7wKR5dlsO7X8ZN1du1Iql4l3rUVr6bLqm5OtvYz7J2N4rHOdxFAkXSIHFc06H+z2WE
         po9uwL23Uy25u1TgzOSS6hqR+rGaRwuDmHXs+kQdr6hMEQdVU8MZIb883ehEKkV60JDZ
         8C8QYaGJ/zU+RhTlgdJOnpbzMmeC+PC0F1anbjf/s+sqQ7k0FtT0wGdQOzTh9o1t0oza
         0jbA==
X-Gm-Message-State: AOJu0Yxd7o+FjvPOoPMGVLbODsIpkoLV5W/E9sL/7UvxWBggWn1DhjDm
	Qilbq7GbvS0PVWtK7+MTlHg7Ou0AaDqTMBW0hp0kmJ1Lttt7xQymWk7tuSNEyByiL0T29VeMnFL
	zMmv7rjm3nVDOzYMop5wSaQ==
X-Received: by 2002:a17:906:d6:b0:9ae:2f33:4ad0 with SMTP id 22-20020a17090600d600b009ae2f334ad0mr1286249eji.71.1695804067912;
        Wed, 27 Sep 2023 01:41:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGe2pqu6JcAU51HEq3OLEnrMnL9FsmxkzqYCWJwkknNkJZo4Yj9H1+Hni85bBZ+QOsKjJLXQ==
X-Received: by 2002:a17:906:d6:b0:9ae:2f33:4ad0 with SMTP id 22-20020a17090600d600b009ae2f334ad0mr1286224eji.71.1695804067504;
        Wed, 27 Sep 2023 01:41:07 -0700 (PDT)
Received: from [192.168.1.217] ([109.36.155.235])
        by smtp.gmail.com with ESMTPSA id vb5-20020a170907d04500b009b299529709sm2262486ejc.132.2023.09.27.01.41.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 01:41:07 -0700 (PDT)
Message-ID: <5e127422-1e09-816c-d956-d7afd7ed1c6d@redhat.com>
Date: Wed, 27 Sep 2023 10:41:04 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFT PATCH 0/4] platform/x86: int3472: don't use
 gpiod_toggle_active_low()
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Daniel Scally
 <djrscally@gmail.com>, Mark Gross <markgross@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230926145943.42814-1-brgl@bgdev.pl>
 <ffb5b1a8-a4fa-f794-afc8-52eed4420a5c@redhat.com>
In-Reply-To: <ffb5b1a8-a4fa-f794-afc8-52eed4420a5c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 9/27/23 10:38, Hans de Goede wrote:
> Hi Bartosz,
> 
> On 9/26/23 16:59, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
>> gpiod_toggle_active_low() is a badly designed API that should have never
>> been used elsewhere then in the MMC code. And even there we should find
>> a better solution.
>>
>> Replace the uses of it in the int3472 driver with the good old temporary
>> lookup table trick. This is not very pretty either but it's the lesser
>> evil.
> 
> I saw your previous proposal which added a new api to directly set
> the active_low flag, rather then toggle it.
> 
> I intended to reply to that thread to say that I liked that approach,
> but I don't remember if I actually did reply.
> 
> I wonder what made you abandon the new function to directly set
> the active-low flag on a gpio_desc?
> 
> For the int3472 code that would work pretty well and it would
> be much cleaner then the temp gpio-lookup approach.

I missed that 4/4 removes acpi_get_and_request_gpiod(),
so I guess that this is not just only about removing gpiod_toggle_active_low()
but also about removing gpiod_toggle_active_low() ?

Regards,

Hans



>>
>> Bartosz Golaszewski (4):
>>   platform/x86: int3472: provide a helper for getting GPIOs from lookups
>>   platform/x86: int3472: led: don't use gpiod_toggle_active_low()
>>   platform/x86: int3472: clk_and_regulator: use GPIO lookup tables
>>   gpio: acpi: remove acpi_get_and_request_gpiod()
>>
>>  drivers/gpio/gpiolib-acpi.c                   | 28 ------------------
>>  .../x86/intel/int3472/clk_and_regulator.c     | 22 ++++++--------
>>  drivers/platform/x86/intel/int3472/common.c   | 29 +++++++++++++++++++
>>  drivers/platform/x86/intel/int3472/common.h   |  9 ++++++
>>  drivers/platform/x86/intel/int3472/led.c      | 12 +++-----
>>  include/linux/gpio/consumer.h                 |  8 -----
>>  6 files changed, 51 insertions(+), 57 deletions(-)
>>


