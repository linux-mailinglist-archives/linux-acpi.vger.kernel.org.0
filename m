Return-Path: <linux-acpi+bounces-275-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B89E7B2872
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 00:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E34402833F2
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 22:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD22B19458
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 22:31:11 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B269CA71
	for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 21:15:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE641A4
	for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 14:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695935711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=668WRSwzccSSZLdUmHKsncI+ABaAosHC/XXc6je1ZO4=;
	b=Q1InXibYE0BLxyvKRsIe5JHXuej5Juh6E+EC2xq2t/xNwZuwV+W+GKAmZ9QCnn8tXKlGJF
	KN+dYG7UCGGdrRlf+ifJYV43pc143/MkocHqxYTwuaGmKKyuxvc6ZTUEwDC+BVDUUtjuq0
	Fb3C6moNh640zQSro+bCKuhuZfOCpnY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-P6MME_Y5PUylBgqcXp54kg-1; Thu, 28 Sep 2023 17:15:09 -0400
X-MC-Unique: P6MME_Y5PUylBgqcXp54kg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4030ae94fedso121440345e9.1
        for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 14:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695935708; x=1696540508;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=668WRSwzccSSZLdUmHKsncI+ABaAosHC/XXc6je1ZO4=;
        b=FUHfU3slwwlapunklz88XtaLq0Rk384SjxP7Jxj+sJb0LMJS4elt8UAdCZbfY5acUW
         DYPdVNJ6f1Kr+wO/OvSOMhmkZGZq24VDs4EHUi2Qux1iRrrGWYZc9QsuiwmfRnKuVgXe
         hdC2WX1z/if25UXgrxqoGm0NBovmeU/RCZ8rVTMu51BuqyAnUVj0s9TtRShReqLQtgwN
         eVvC+eIiYJg+vWWocV7BlRu93dTqyN6PIhrWm1dOn5bBVFsiM5Rxp7q8hZKQJpaLq/jY
         2aaddwov5Vy9azzRssk1WfPIzfeVLAscCKU68jii0QDptLCb8NhmF4nRcFXW+9itTm2y
         mjIw==
X-Gm-Message-State: AOJu0YyhPz0a0RHCL6meztX7GtW3a19Wwz9e5oJDDbJXhrSw5g10yNwl
	lQqylQN/cSEFpgygPW2buXG/Ufa49SoWCkEPYf5pGnoC6ZQxg9F47xlIKdBSFcDnzdBkqk8NCIt
	th1C1JyGYpupDEd2bmyVqCA==
X-Received: by 2002:a05:600c:ad3:b0:402:e68f:888c with SMTP id c19-20020a05600c0ad300b00402e68f888cmr2307037wmr.7.1695935708549;
        Thu, 28 Sep 2023 14:15:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoLBoBW0RgQfcEdiTRVcDK8Jq1t72S30ZWZt45BMjO2TF/Kz5Taeo5wZ+kqpssbrMB8u+FAg==
X-Received: by 2002:a05:600c:ad3:b0:402:e68f:888c with SMTP id c19-20020a05600c0ad300b00402e68f888cmr2307027wmr.7.1695935708175;
        Thu, 28 Sep 2023 14:15:08 -0700 (PDT)
Received: from [10.10.158.202] ([213.144.205.82])
        by smtp.gmail.com with ESMTPSA id p8-20020a7bcc88000000b003fbe4cecc3bsm955wma.16.2023.09.28.14.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 14:15:07 -0700 (PDT)
Message-ID: <6f7530af-a160-620b-f3d4-a56dae1e0b46@redhat.com>
Date: Thu, 28 Sep 2023 23:15:06 +0200
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
Content-Language: en-US
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

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

That sounds like a good plan to me, will do.

Regards,

Hans


