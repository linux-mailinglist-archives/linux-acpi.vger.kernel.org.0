Return-Path: <linux-acpi+bounces-181-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C268C7B01F3
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 12:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 78956282962
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 10:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F73415ADD
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 10:33:51 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D4BEAF2
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 08:38:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AD59F
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 01:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695803892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oFBFk293L3WpA/SF5GLh0iya0M5nZqt8LWn5s306O2o=;
	b=EKHdtYPRureqJduIGY9ufxO3zyAB2acAklipUj65F+JpDLs/Gvq12lAtWeYv19QvMh5W/X
	931oV5o2mNU3MZ3C9CtrlNWOZ9NxBTtwVz3vdXAyFhPVDiE6o3OWSg3kjBJ7Ft4W7ueOR2
	76yZPOX9DXSSRteGaZ0GgBD9wcykUDw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-QezWJnLmP3OfRgJCVZ2WJA-1; Wed, 27 Sep 2023 04:38:11 -0400
X-MC-Unique: QezWJnLmP3OfRgJCVZ2WJA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-530cfb598c5so8098206a12.1
        for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 01:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695803890; x=1696408690;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oFBFk293L3WpA/SF5GLh0iya0M5nZqt8LWn5s306O2o=;
        b=iSxSSxC1oFXmFXleXe+658KQ9FBV6oQB9/wSLQ+iakKsYY3NCHlwW73mhQ8JMPspRB
         6yqQOH4Pbf+OEMYOuLyio4PGdez84ZRsdjBc4ndgqk8K96Ux9nhh6XOHxlbzc7UbsLPb
         jExkM4T3Bnk6o3LVm3ndq4qh7uA3/ecUJDXKG5FIPIROLfcB0X7cTDd3JstoEqHBAuk/
         2jDzzo1pTP8DL7cN8hZUT31qK+59IDZ4ouQBKWEOLKX1nG/t59yFSdspyahYGfBfy215
         kB1Zi9FAQ5yZ+kKGRMmUStzghfIJ5l3n5FzuV0YgZ2u741eqgb0kyOd3EJ10H0O/THpK
         eJog==
X-Gm-Message-State: AOJu0YwxnggpL/25R+7fRirqvl6KrYMpEOV0fYGWqH8t31sJFg/D9ge6
	VekRu7wndqxJXvvKDELxiZ6ZVlP3Q+kUYtCxhYSoT/LQgz9C9ygOLW1lxty4QEPwrWYJvHpOcKE
	9OlMPL3fso5AXzFe5FWhGKQ==
X-Received: by 2002:a05:6402:6da:b0:530:9fbc:8df5 with SMTP id n26-20020a05640206da00b005309fbc8df5mr1352489edy.9.1695803889951;
        Wed, 27 Sep 2023 01:38:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaAq1i5bLDH0/vOkJlIJOevgIvVaw73om6syxk8ocMxZ0l92s3G7QXYUlLWnJSKN24ep4wYA==
X-Received: by 2002:a05:6402:6da:b0:530:9fbc:8df5 with SMTP id n26-20020a05640206da00b005309fbc8df5mr1352472edy.9.1695803889612;
        Wed, 27 Sep 2023 01:38:09 -0700 (PDT)
Received: from [192.168.1.217] ([109.36.155.235])
        by smtp.gmail.com with ESMTPSA id x62-20020a50bac4000000b0053443c8fd90sm2645885ede.24.2023.09.27.01.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 01:38:08 -0700 (PDT)
Message-ID: <ffb5b1a8-a4fa-f794-afc8-52eed4420a5c@redhat.com>
Date: Wed, 27 Sep 2023 10:38:05 +0200
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
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Daniel Scally
 <djrscally@gmail.com>, Mark Gross <markgross@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230926145943.42814-1-brgl@bgdev.pl>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230926145943.42814-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Bartosz,

On 9/26/23 16:59, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> gpiod_toggle_active_low() is a badly designed API that should have never
> been used elsewhere then in the MMC code. And even there we should find
> a better solution.
> 
> Replace the uses of it in the int3472 driver with the good old temporary
> lookup table trick. This is not very pretty either but it's the lesser
> evil.

I saw your previous proposal which added a new api to directly set
the active_low flag, rather then toggle it.

I intended to reply to that thread to say that I liked that approach,
but I don't remember if I actually did reply.

I wonder what made you abandon the new function to directly set
the active-low flag on a gpio_desc?

For the int3472 code that would work pretty well and it would
be much cleaner then the temp gpio-lookup approach.

Regards,

Hans



> 
> Bartosz Golaszewski (4):
>   platform/x86: int3472: provide a helper for getting GPIOs from lookups
>   platform/x86: int3472: led: don't use gpiod_toggle_active_low()
>   platform/x86: int3472: clk_and_regulator: use GPIO lookup tables
>   gpio: acpi: remove acpi_get_and_request_gpiod()
> 
>  drivers/gpio/gpiolib-acpi.c                   | 28 ------------------
>  .../x86/intel/int3472/clk_and_regulator.c     | 22 ++++++--------
>  drivers/platform/x86/intel/int3472/common.c   | 29 +++++++++++++++++++
>  drivers/platform/x86/intel/int3472/common.h   |  9 ++++++
>  drivers/platform/x86/intel/int3472/led.c      | 12 +++-----
>  include/linux/gpio/consumer.h                 |  8 -----
>  6 files changed, 51 insertions(+), 57 deletions(-)
> 


