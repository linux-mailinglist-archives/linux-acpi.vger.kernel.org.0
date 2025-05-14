Return-Path: <linux-acpi+bounces-13715-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DD9AB687E
	for <lists+linux-acpi@lfdr.de>; Wed, 14 May 2025 12:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C057E1BA0697
	for <lists+linux-acpi@lfdr.de>; Wed, 14 May 2025 10:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3B41FC7CB;
	Wed, 14 May 2025 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iVsAw0OE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BBB26FDB3
	for <linux-acpi@vger.kernel.org>; Wed, 14 May 2025 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747217707; cv=none; b=C26yYfLioJkPGsMv+WYHdpOOIw0gEwNUDabczQxL76sPLKaOPeCJm3VvgNLFHukfDrb2gd2/PFoYvSP/hqpVyUDgXbPDYxj12vkj9rfj8qBUhH3to+SMc7NzyHFcqSG7ofhQ5o58wBQbGtY3ASOnGqqdm+lexXz0dwZoDcgrqzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747217707; c=relaxed/simple;
	bh=wDmraekW7m0pgFwPRFE4S7PnYUyPMFc7PeEJ7Alaud0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PkUgdkxvnolsYBKQDVAYaPo2bUsOo35jbwh526X1sK9E4AvLwjemrzGZjrSf9CjE6sVo8naorz6aaR26SBpmL44BHf3lQ0UdnjrMoUV7nXdB39RNSy3cN5UWP7eg58xCA48pSn3VPJRYq6wg53KFa1qrQoeGxVFpsCvlFOSjvHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iVsAw0OE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747217703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8LKDxEPlK0zUrqmN4DZvo7SZOHbpNlPdUFt+T51TxI=;
	b=iVsAw0OE2vGJCyUNvW6ugcxjU7vSSbGD92RyjT5sMmupNXNUIMZ88541/tp/VEhQ7n1qUT
	oyWnl0avt8d9/CuW1efMdgdTscgETcK1B+EEX2UgC5ldbk+X3PFwvq/x10HC/J02w9tfJK
	dbjyRG8CUIEO5V+pbDti8SHEJ2epFCE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-nljHHoB4MLGhad5JC7_qvw-1; Wed, 14 May 2025 06:15:02 -0400
X-MC-Unique: nljHHoB4MLGhad5JC7_qvw-1
X-Mimecast-MFC-AGG-ID: nljHHoB4MLGhad5JC7_qvw_1747217701
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-acb61452b27so731105866b.2
        for <linux-acpi@vger.kernel.org>; Wed, 14 May 2025 03:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747217701; x=1747822501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K8LKDxEPlK0zUrqmN4DZvo7SZOHbpNlPdUFt+T51TxI=;
        b=uFJLWEL7c9a8maYBCLHOR/NBqRtluIu8L3xj0sN2JncncChkv2MePXzcUCOzZajqw7
         vj/zoyEc1l/6hDXMdxGizKUQxrIYnNpe7/4/o1LCHDAMuosiuXrWutYkopGLveeAuP+8
         4p1gjNWR2dCs+lncoDczMn+zD15JVJQhE9hxc7lgj3uP00jdrejIcUBbb0wTqvOHvQ7N
         0xG/PdyeAu0zBjvgXDuS2LyDnh/fcb2E4VDI69uWNro6qchFtDpBlt2yyrAm7VZm85Yz
         SuOsOQpHLNNcnVaClnk5a1eahsBsSg+wi9bq7n1+U6NPCfQkS749d7QYqeTZqc8nVHBc
         pjOw==
X-Forwarded-Encrypted: i=1; AJvYcCUmC5iV5yCT9Pz0g0/M3hiLLgomMefyGtqw4ARfB3Eolqill4BWMiroABEcSjCdAkj8d9qlOOokTtxT@vger.kernel.org
X-Gm-Message-State: AOJu0YzYdoP49MuaVDRu7gvqAriviSHHGURsKykc67VoXwnl0rXPxwP4
	W0Zc3LyJQ+p3NRiJj0BVp/g59y96PdO0U9EDUrj8u6BEeB27J2PqqFYO0gDOgl734lVFFUqZ7nH
	OUeNRjFu7xZDo19sXZOGm8pqHKTzJ8TGVvBjBjsMfiOm/EEKfF4Hu1+Q18u0=
X-Gm-Gg: ASbGncvWdjY2Twok6cIIvOd2kULHafTs97JJEenRf6OKb4w0TIo0r982lzp9NlFMdK6
	/nvRTRqHFI4V2fGLisLPi/gri44nVLJIWTmCihHeXLEqXtvDjJbrGXgA2xD4WQ68GkkTISYJZQF
	MzfEIbLUMuS1KDLCjZKdBkQKA6aJ8y0xBJn4O84yk+4JdIPWZAei3NqN/orJrdteID/kj1mAlsL
	NnqF5lqjwwrT1d8v4zHXSxNikrSh3sCZTuBFLB4XuWZQmApdCw1Uyah8JCprcJOhcghUXcPvLmE
	IhYGugKZVGeAfDbUEg==
X-Received: by 2002:a17:907:96ab:b0:ad2:293d:166e with SMTP id a640c23a62f3a-ad4f717a571mr262749966b.31.1747217700920;
        Wed, 14 May 2025 03:15:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL7kdzll3t4oQ25ZYCbLYS9k6oyFJfi2q4wOT/F3rxR/d4Hx5O00NDK2zGNm+A5NAW2+hs3g==
X-Received: by 2002:a17:907:96ab:b0:ad2:293d:166e with SMTP id a640c23a62f3a-ad4f717a571mr262748266b.31.1747217700550;
        Wed, 14 May 2025 03:15:00 -0700 (PDT)
Received: from [192.168.37.224] ([109.36.142.219])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21947acf8sm912226966b.85.2025.05.14.03.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 03:14:59 -0700 (PDT)
Message-ID: <adda844f-1dc7-4c4d-90f1-ddba1c99be65@redhat.com>
Date: Wed, 14 May 2025 12:14:57 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] gpiolib: acpi: Split quirks to its own file
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Mika Westerberg <westeri@kernel.org>
References: <20250513100514.2492545-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250513100514.2492545-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 13-May-25 12:00, Andy Shevchenko wrote:
> The GPIO ACPI helpers use a few quirks which consumes approximately 20%
> of the file. Besides that the necessary bits are sparse and being directly
> referred. Split them to a separate file. There is no functional change.
> 
> For the new file I used the Hans' authorship of Hans as he the author of
> all those bits (expect very tiny changes made by this series).
> 
> Hans, please check if it's okay and confirm, or suggest better alternative.

Thanks, the entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> Andy Shevchenko (4):
>   gpiolib: acpi: Switch to use enum in acpi_gpio_in_ignore_list()
>   gpiolib: acpi: Handle deferred list via new API
>   gpiolib: acpi: Add acpi_gpio_need_run_edge_events_on_boot() getter
>   gpiolib: acpi: Move quirks to a separate file
> 
>  drivers/gpio/Makefile                         |   1 +
>  .../{gpiolib-acpi.c => gpiolib-acpi-core.c}   | 344 +----------------
>  drivers/gpio/gpiolib-acpi-quirks.c            | 363 ++++++++++++++++++
>  drivers/gpio/gpiolib-acpi.h                   |  15 +
>  4 files changed, 392 insertions(+), 331 deletions(-)
>  rename drivers/gpio/{gpiolib-acpi.c => gpiolib-acpi-core.c} (79%)
>  create mode 100644 drivers/gpio/gpiolib-acpi-quirks.c
> 


