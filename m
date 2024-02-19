Return-Path: <linux-acpi+bounces-3683-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E03185A0D0
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Feb 2024 11:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75D31F239EF
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Feb 2024 10:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC8625616;
	Mon, 19 Feb 2024 10:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aXryL0C9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CB022F13
	for <linux-acpi@vger.kernel.org>; Mon, 19 Feb 2024 10:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708337958; cv=none; b=r+N4F0+jKbpSLIGqS99OE4o995u1I9SvCv+M0pfaeezu8rWvFuM4UKlXGp+2vaCUys2tfBpn+9cQg6Ea691u1ZkB65sUKuKK/fiXCPcgVnA7FS3Bayth1nPh9qd5ejPLYmU5Ro65T/UUY8O+xQynGlN9jSibxWP9pfFmnr4yMmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708337958; c=relaxed/simple;
	bh=BR8qa4yclQoANiq0GFDN1gNFROp3E6LCeM0UJ+oH1+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lWBZX9SVDzqarH/ZmXU1YBbLztb160QbHiFZ4lDOnBoEUpApwBEUN7LN+aCgbpsNtqZAraFGX3YXkzhDti9u34iML99knbZbSZVExMW6wU/9qMqvnwSjP/mV9slNb0heeHVtboTrgke7ol0qWyz2OF+UX2IlO0YgFEzCVpRZO/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aXryL0C9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708337955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXB1UzSeUpl1IdbbooLhKWQe6HLHid6w7KNMlRFndfQ=;
	b=aXryL0C9sDtgMHoWuZMB0L1dy7j2Y/38VDBr9CF0u6IePYKo7+8MaOqbFSEZLh6L97Cend
	E+BWtPcS03+TQPBVXC45O+/W7qooKhmwrd74xhP4lkrxi3tDEXN7waMtofml3Y0nwu+Kxz
	AolqXwVgtlJEl+pAWo0cQl/1je9p1v4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-7uWqhHPmPAi1fKVSoLXjGA-1; Mon, 19 Feb 2024 05:19:13 -0500
X-MC-Unique: 7uWqhHPmPAi1fKVSoLXjGA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a3e426228acso28075066b.3
        for <linux-acpi@vger.kernel.org>; Mon, 19 Feb 2024 02:19:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708337952; x=1708942752;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UXB1UzSeUpl1IdbbooLhKWQe6HLHid6w7KNMlRFndfQ=;
        b=jIStjFbuELI1imIMNGZdbNm+0yYAvXHtZYzcReoCokkH53pUyY8h2+CncrMMRd7yJu
         71hHZO/NedaZsA9ry212Y/7tiY7Y8tsfWwUMOk7SmpqDrZNVdGxG+c/abbfT1xv9tvRL
         xZyv6BBopePPqukXjU68pk4ww+vgbuCrIxmgRzJ8TnOtGkhTHA9liU7GluatgHdStCBS
         sP2XFJnOBUiQJwJF8gMhIrvjinUBdjXm2+ipMDmXLA2PfKVWbkMg+WFTE/jAokGZpQ2N
         cFskJwiSv1P1M0ha+r0i/5yhuridmt5eZsPKhlIl/t2PlGD42FZlyZ06tsJU42RM6SF9
         yj9A==
X-Forwarded-Encrypted: i=1; AJvYcCWK0z7rz7sN+5SWydyp/TIiIaob2uioenPqiPcx47qr3+poXwtIiMU5c15RkOJpR9TfDDk/iOtxq8iMxaP2COiSH0YJLvPgz/AXJA==
X-Gm-Message-State: AOJu0Yyfg9HHYU1OPAJFNfUNyR4BjPKOUnFen0ifB649UerIa/q9ujwJ
	hPvB1g/a3dbd1wDfpQZaXcol2CN8OzYy9jTwDJpIbysekwtreXtEiFKz5vHdkI7Cx9h3QCE9Ys+
	XAVlNoKpIIb8yb0STmw80zh60I+SzJLYzXHcufxLA70VINI6L+vFa7lAz5VA=
X-Received: by 2002:a17:906:1cc2:b0:a3e:4d4c:d120 with SMTP id i2-20020a1709061cc200b00a3e4d4cd120mr4116101ejh.12.1708337952112;
        Mon, 19 Feb 2024 02:19:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjWs09vUPrzjRiDJgVLiFoiPpjFhTeIvNNa/4brNIb9b/Y6nosVbDR+JVow9XUClmnHdaMjw==
X-Received: by 2002:a17:906:1cc2:b0:a3e:4d4c:d120 with SMTP id i2-20020a1709061cc200b00a3e4d4cd120mr4116089ejh.12.1708337951795;
        Mon, 19 Feb 2024 02:19:11 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id ty6-20020a170907c70600b00a3e0c07449bsm2691072ejc.104.2024.02.19.02.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 02:19:11 -0800 (PST)
Message-ID: <adcf7eb9-4f7a-457d-95ad-89ffaac48c83@redhat.com>
Date: Mon, 19 Feb 2024 11:19:10 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] ACPI: x86: Move acpi_quirk_skip_serdev_enumeration()
 out of CONFIG_X86_ANDROID_TABLETS
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, linux-acpi@vger.kernel.org
References: <20240218151533.5720-1-hdegoede@redhat.com>
 <20240218151533.5720-2-hdegoede@redhat.com>
 <CAHp75VeSHZ3xMr7uD1H+hQgd0RAqE5uSw8M=b46q_Y7NEAGQuA@mail.gmail.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VeSHZ3xMr7uD1H+hQgd0RAqE5uSw8M=b46q_Y7NEAGQuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 2/18/24 19:39, Andy Shevchenko wrote:
> On Sun, Feb 18, 2024 at 5:15 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Some recent(ish) Dell AIO devices have a backlight controller board
>> connected to an UART.
>>
>> This UART has a DELL0501 HID with CID set to PNP0501 so that the UART is
>> still handled by 8250_pnp.c. Unfortunately there is no separate ACPI device
>> with an UartSerialBusV2() resource to model the backlight-controller.
>>
>> The next patch in this series will use acpi_quirk_skip_serdev_enumeration()
>> to still create a serdev for this for a backlight driver to bind to
>> instead of creating a /dev/ttyS0.
>>
>> This new acpi_quirk_skip_serdev_enumeration() use is not limited to Android
>> X86 tablets, so move it out of the ifdef CONFIG_X86_ANDROID_TABLETS block.
> 
> ...
> 
>> +#else
>> +static int acpi_dmi_skip_serdev_enumeration(struct device *controller_parent, bool *skip)
>> +{
>> +       return 0;
>> +}
>>  #endif
> 
> ...
> 
>>  static inline int
>>  acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *skip)
>>  {
>>         *skip = false;
>>         return 0;
>>  }
>> +#endif
> 
> Now you have basically two identical blocks in two files. I believe
> you may reorganize the code to have only one of these.

One is #if IS_ENABLED(CONFIG_X86_ANDROID_TABLETS) the other is
#ifdef CONFIG_X86

Also one is for a private helper, the other is for a public function.

The whole idea of this patch is actually to have both, with the
upcoming DELL0501 handling we want acpi_quirk_skip_serdev_enumeration()
to be defined (and not just an inline stub in the .h) independent
of IS_ENABLED(CONFIG_X86_ANDROID_TABLETS), the first #if block
provides a dummy for the x86-android specific bits for
the now always defined acpi_quirk_skip_serdev_enumeration() to call
when CONFIG_X86_ANDROID_TABLETS is not set.

The second #if is because acpi_quirk_skip_serdev_enumeration() still
is only defined on X86 platforms and on non x86 platforms we need
a stub for it in the public .h file.

Regards,

Hans


