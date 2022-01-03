Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20244830AB
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Jan 2022 12:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbiACLmh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 Jan 2022 06:42:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32658 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233055AbiACLmg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Jan 2022 06:42:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641210155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gSNOI5ql8oXZVvuzD0ppCtwWNeddD2uNEOgMzwq7yWs=;
        b=cmdow/FWHRgbM6aSxs/xTctjtcIMiH4QlG036cY7wdoBRm6ldaHP0OiJawl8UnBYAfPjg8
        3QCKr8q83OcMsDq0Gtq9lUwnS1d4UI653YmVrg5G4b+E4dm6YYLafARmZTqxDDDxuCLK4B
        qWD+nQk1TC7MUQtw2DciR0i99U9buqA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-345-c3cmxtBNM7mYPCcrhZyP2w-1; Mon, 03 Jan 2022 06:42:34 -0500
X-MC-Unique: c3cmxtBNM7mYPCcrhZyP2w-1
Received: by mail-ed1-f72.google.com with SMTP id q15-20020a056402518f00b003f87abf9c37so22619532edd.15
        for <linux-acpi@vger.kernel.org>; Mon, 03 Jan 2022 03:42:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gSNOI5ql8oXZVvuzD0ppCtwWNeddD2uNEOgMzwq7yWs=;
        b=s3KvbekodvF9mc6Mnk4Vnv+QWfUcBMFK4vrm8tiLj6d1TFxSYdUAI5bXPZ6A81YxdD
         DY2cmQfEqFcsNYeu2n2m7tci89FZrG8oo8IOAQqxvYoquxvnMQjB1g4cDW3mK9e4W6cl
         SWqmV6LwoNKKo3NRuL8ERuu3G/WcQ2CzGa5xuSZhAFp6ma9dzq8JsajgpHFb1t1VcbZI
         r/kREfkq/GFByjoCrfECwVGvLjYPWt9dASoYV2k8o375+mLxGKwjFrU7q2RuUf+pr7A6
         3/OLoSIpqSfSJa3R2Azw3yzOl0QXQK9b9HZ7tmJ2/w+Cv8dXLx9xIAo5qnw+Mfsy7Tt5
         m0Ug==
X-Gm-Message-State: AOAM530h5fC1i/duEsjeUEmo/CkGrKdhIO9wKB5VPg4k0mpmXzmGWCKm
        U7AtRmxACrvBKFprUtzIkHzP/7fJX/9GPujEcNhZqS1FQvqQxA/R4/yPSEDT85M9JBssjKc72hE
        j8E42tJSRQQi7cx1E3F2m0A==
X-Received: by 2002:a17:906:9491:: with SMTP id t17mr34874595ejx.667.1641210153016;
        Mon, 03 Jan 2022 03:42:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyIi4yBcIp+Imi4nqsCAFS4wrZ7x5Z4CdDD0XwShkPowGrJPzk/hjb7Xh+egDpsRHbtUE5ZNA==
X-Received: by 2002:a17:906:9491:: with SMTP id t17mr34874574ejx.667.1641210152871;
        Mon, 03 Jan 2022 03:42:32 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id sc7sm10590939ejc.87.2022.01.03.03.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 03:42:32 -0800 (PST)
Message-ID: <464b14f9-3df8-5651-7268-80f9fe0df3d4@redhat.com>
Date:   Mon, 3 Jan 2022 12:42:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 00/12] ACPI / pdx86: Add support for x86 Android tablets
 with broken DSDTs
Content-Language: en-US
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-i2c@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-serial@vger.kernel.org
References: <20211229231431.437982-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211229231431.437982-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

On 12/30/21 00:14, Hans de Goede wrote:
> Hi All,
> 
> As a small(ish) hoppy project over the holidays I've been looking into
> getting some (somewhat older) x86 tablets which ship with Android as the
> only OS on their factory image working with the mainline kernel.
> 
> These typically have pretty broken DSDTs since the Android image kernel
> just has everything hardcoded.
> 
> This patch-series makes most things on 3 of these tablets work with the
> mainline kernel and lays the groundwork for adding support for similar
> tablets.
> 
> Since the ACPI tables on these devices clearly are buggy this series is
> written so as to add minimal changes to the ACPI core code, leaving all
> of the heavy lifting to the recently introduced (in linux-next)
> drivers/platform/x86/x86-android-tablets.c module, which when built as
> a module only autoloads on affected devices based on DMI matching.
> 
> And when this module is disabled the added acpi_quirk_skip_*_enumeration()
> helpers are replaced by inline stubs and even the minimally added core
> code will be optimized away.
> 
> The ACPI core changes are in patches 1-3 of this series. Since the
> i2c and serdev ACPI enumeration changes are very small and depend on
> patch 1, I believe it would be best for patches 1-3 to all be merged
> through Rafael's ACPI tree.

I've added patches 4-12 to my pdx86/review-hans (soon to be for-next)
branch now.

Regards,

Hans


> Hans de Goede (12):
>   ACPI / x86: Add acpi_quirk_skip_[i2c_client|serdev]_enumeration()
>     helpers
>   i2c: acpi: Do not instantiate I2C-clients on boards with known bogus
>     DSDT entries
>   serdev: Do not instantiate serdevs on boards with known bogus DSDT
>     entries
>   platform/x86: x86-android-tablets: Don't return -EPROBE_DEFER from a
>     non probe() function
>   platform/x86: x86-android-tablets: Add support for PMIC interrupts
>   platform/x86: x86-android-tablets: Add support for instantiating
>     platform-devs
>   platform/x86: x86-android-tablets: Add support for instantiating
>     serdevs
>   platform/x86: x86-android-tablets: Add support for registering GPIO
>     lookup tables
>   platform/x86: x86-android-tablets: Add support for preloading modules
>   platform/x86: x86-android-tablets: Add Asus TF103C data
>   platform/x86: x86-android-tablets: Add Asus MeMO Pad 7 ME176C data
>   platform/x86: x86-android-tablets: Add TM800A550L data
> 
>  drivers/acpi/x86/utils.c                   |  96 ++++
>  drivers/i2c/i2c-core-acpi.c                |  17 +
>  drivers/platform/x86/Kconfig               |   2 +-
>  drivers/platform/x86/x86-android-tablets.c | 562 ++++++++++++++++++++-
>  drivers/tty/serdev/core.c                  |  14 +
>  include/acpi/acpi_bus.h                    |  16 +
>  6 files changed, 698 insertions(+), 9 deletions(-)
> 

