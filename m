Return-Path: <linux-acpi+bounces-185-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 671637B01F8
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 12:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 176C2282A9B
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 10:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DCA15ACA
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 10:34:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372E6290B
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 09:14:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D3EBF
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 02:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695806051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T/bCjD93zGx7k6DS0sd/nFhrwYQMV95Gpv7IoiMJVN0=;
	b=etuxdj4ICwxAGabm39B0Roqb6V2gWvmfGJxublkuWQ0tM9zwpx2y3xl6r2mzOkLORcJ5No
	G/O0w+GfEJUP6P1i3NVpYGZoxanNHQdKGnFEADGNz9zU9z8svyuzXhc4fAjW0Jqjy2+cIH
	on37CfhZgC9E8+kDGrpZYmhiY66XEO8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-ZGcpJCG_OBKlfY1Bu3kENA-1; Wed, 27 Sep 2023 05:14:09 -0400
X-MC-Unique: ZGcpJCG_OBKlfY1Bu3kENA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9ae12311183so910728866b.2
        for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 02:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695806048; x=1696410848;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/bCjD93zGx7k6DS0sd/nFhrwYQMV95Gpv7IoiMJVN0=;
        b=gjW3EN3bbEMkslhsw7lbx3Md35p+LoT8sBB6N/FaQDfWYk21A+T5bgbPU4/A0T1EJH
         gEwnBRmXw5pGxe3aj/c56NY9FwfrjiPNj0AW3bxhGGdM4RZLq87H8bm3eiiqgEGYKE7/
         xbbFM4WNQtU546NBMpo0KYjOc8Qc5htjcvnoQO+iEKClgXJWpIW9iIkatYk6VsTCj36G
         E03PpunRBskcVtWuisoHTvl7BWFLVl5UF4eAftp5k0/88lwRSZevpyk3E8mvVYFrpNM0
         PJuisGgaqQrhIUlG7/xFHvw/Xc33oOrojtRY/w3Oqb/qhIwVa4oeDxAsYcVlE2Ok7bOl
         PUhw==
X-Gm-Message-State: AOJu0Yy0aKdQ/+ROhWQ5owzkssix62VUjZ3xO63ZpHPESkbucCGNrFBm
	sxaG6KNimKiovFw3LpukUVastpuL5pyy5yZ04U0F+xrDF4N/IUKEImJ9AjycMI46o8EZzgRaW+n
	HbwsoSJcC/mJAjGoAmY/f4A==
X-Received: by 2002:a17:907:1ca1:b0:9a1:bd33:4389 with SMTP id nb33-20020a1709071ca100b009a1bd334389mr1744705ejc.74.1695806048726;
        Wed, 27 Sep 2023 02:14:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBja2h6H4iNhc0j95Q0ZZoVn1HywvIdObcsejBA4MbQ5G7O+fTuE/uCPp8hyYYFBBIWF65Tg==
X-Received: by 2002:a17:907:1ca1:b0:9a1:bd33:4389 with SMTP id nb33-20020a1709071ca100b009a1bd334389mr1744683ejc.74.1695806048395;
        Wed, 27 Sep 2023 02:14:08 -0700 (PDT)
Received: from [192.168.1.217] ([109.36.155.235])
        by smtp.gmail.com with ESMTPSA id e8-20020a170906374800b009920e9a3a73sm8972076ejc.115.2023.09.27.02.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 02:14:06 -0700 (PDT)
Message-ID: <adf04176-273d-e365-f765-f84c4e4f6a11@redhat.com>
Date: Wed, 27 Sep 2023 11:14:03 +0200
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
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Daniel Scally
 <djrscally@gmail.com>, Mark Gross <markgross@kernel.org>,
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230926145943.42814-1-brgl@bgdev.pl>
 <20230926145943.42814-3-brgl@bgdev.pl> <ZRL4PYeX21bwCPR0@smile.fi.intel.com>
 <CAMRc=Mf7P4sWdhgTV+jVD8HEVpxbSuGK8JjJb5Q9djCkKUeUcg@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAMRc=Mf7P4sWdhgTV+jVD8HEVpxbSuGK8JjJb5Q9djCkKUeUcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

HI,

On 9/27/23 09:02, Bartosz Golaszewski wrote:
> On Tue, Sep 26, 2023 at 5:27 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>>
>> On Tue, Sep 26, 2023 at 04:59:41PM +0200, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>> Instead of acpi_get_and_request_gpiod() + gpiod_toggle_active_low(), use
>>> temporary lookup tables with appropriate lookup flags.
>>
>> ...
>>
>>> +     int3472->pled.gpio = skl_int3472_gpiod_get_from_temp_lookup(
>>> +                             int3472->dev, path, agpio->pin_table[0],
>>> +                             "int3472,privacy-led", polarity,
>>> +                             GPIOD_OUT_LOW);
>>
>> Personally I found this style weird. I prefer to have longer line over
>> the split on the parentheses.
>>
> 
> I in turn prefer this one. Checkpatch doesn't complain either way so
> I'll leave it to the maintainers of this driver to decide.

I'm fine with keeping this as is, using longer lines does not seem to make
things better here.

Regards,

Hans


