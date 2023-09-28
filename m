Return-Path: <linux-acpi+bounces-257-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 945F27B1F7F
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 16:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 414032827FC
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 14:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236DC1365
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Sep 2023 14:33:47 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144D32E638
	for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 12:40:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FDD19B
	for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 05:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695904809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hFRSmhC1yPSbB9D3RIWwpqfVPBnoWuA9Kbk89H68FA=;
	b=dPR3MpKXYU2jh/XHlITpGolXpvOp7nMNlFvC4Gbs5DkJ1MADet4vM+Svi80JCleiex2kqb
	t1bb5QswJ8C5NDJMj3+o/wWgvRbeOYI46D76g3yPc1FtZY2tYMIU/4/S2iyLE3+IODE67e
	lDrlbVX60402T2R6V5xe2GSfvx8UqCM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-6LrzBsTeMCGL7laS5Ur92g-1; Thu, 28 Sep 2023 08:40:07 -0400
X-MC-Unique: 6LrzBsTeMCGL7laS5Ur92g-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-99388334de6so1124098366b.0
        for <linux-acpi@vger.kernel.org>; Thu, 28 Sep 2023 05:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695904806; x=1696509606;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0hFRSmhC1yPSbB9D3RIWwpqfVPBnoWuA9Kbk89H68FA=;
        b=aZ1e8AjQVEW067wbLdCBi+bbbr6xrdKZA33CYo5QHW+WZn0ziAnuUO8gC0MJuSvbA7
         S60qIXUgciwKwnUxSRRfuUYMLCQArHR80errKzs/5o3iyn17Cz1vzo94NY8CSRxHrtd+
         btOCfUik1ikaK85vxUNuW4gzQIgZH5pCrEl9D5Q2Fyx+VITaqGvf5RyaW5GMHCRStUf9
         1R1ysp4SYC9dzcQWzD0r18oEF+q+hVG+rywpms6t+vhe/r2V4IAbkJfdSjb8oKJKwm2P
         zzta24EWJMxJD27PR573SgCt2mLtU4eWaKPAR44qnA68tkXADXJV9qDJ5c5p+Nnc5tKy
         ff4g==
X-Gm-Message-State: AOJu0YzAocdwwbHwXeZX7U3yu9eaH6z0x2oC5mWYjZDSP9wiI8AqIh4C
	y5AwMrY8WCsPhnYKez/orPvIdCgKOoOt8KCZ8CBARzzJ4ac2G6G8LE4fozsz9q8J2fLfHZBWsrV
	RH+ww3Ry/vLtbb47dPCkvJA==
X-Received: by 2002:a17:907:7712:b0:9ae:82b4:e309 with SMTP id kw18-20020a170907771200b009ae82b4e309mr1192196ejc.0.1695904806735;
        Thu, 28 Sep 2023 05:40:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7O5uFQTyzH0jhxnRyyPH5q1RHCxAi7qglSAjZirKqTUvUvzw5yk0NoQa8J3TDppGiJS+YHQ==
X-Received: by 2002:a17:907:7712:b0:9ae:82b4:e309 with SMTP id kw18-20020a170907771200b009ae82b4e309mr1192176ejc.0.1695904806392;
        Thu, 28 Sep 2023 05:40:06 -0700 (PDT)
Received: from [192.168.1.217] ([109.36.138.103])
        by smtp.gmail.com with ESMTPSA id e8-20020a170906374800b0099cf840527csm10843051ejc.153.2023.09.28.05.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 05:40:05 -0700 (PDT)
Message-ID: <e6817d30-b443-1a73-efae-84415604b19f@redhat.com>
Date: Thu, 28 Sep 2023 14:40:03 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
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
Subject: [PATCH v2 0/5] platform/x86: int3472: don't use
 gpiod_toggle_active_low()
In-Reply-To: <20230926145943.42814-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi All,

Here is a v2 of Bartosz' "don't use gpiod_toggle_active_low()" series.

New in v2:
- Rework to deal with ACPI path vs gpiod_lookup.key differences:
  acpi_get_handle(path) -> acpi_fetch_acpi_dev(handle) -> acpi_dev_name(adev)

Regards,

Hans


Bartosz Golaszewski (2):
  platform/x86: int3472: Add new
    skl_int3472_gpiod_get_from_temp_lookup() helper
  gpio: acpi: remove acpi_get_and_request_gpiod()

Hans de Goede (3):
  platform/x86: int3472: Add new skl_int3472_fill_gpiod_lookup() helper
  platform/x86: int3472: Stop using gpiod_toggle_active_low()
  platform/x86: int3472: Switch to devm_get_gpiod()

 drivers/gpio/gpiolib-acpi.c                   |  28 -----
 .../x86/intel/int3472/clk_and_regulator.c     |  54 ++--------
 drivers/platform/x86/intel/int3472/common.h   |   7 +-
 drivers/platform/x86/intel/int3472/discrete.c | 101 ++++++++++++++----
 drivers/platform/x86/intel/int3472/led.c      |  24 +----
 include/linux/gpio/consumer.h                 |   8 --
 6 files changed, 93 insertions(+), 129 deletions(-)

-- 
2.41.0


