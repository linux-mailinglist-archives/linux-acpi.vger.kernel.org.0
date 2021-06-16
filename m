Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB623A9DD5
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 16:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbhFPOnR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 10:43:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31693 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234094AbhFPOnO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Jun 2021 10:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623854467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/KmdDtuxC4DPMkm/dYQuBivCzYIDXejkNuC0LvGZbxU=;
        b=ME9thh6XopN48mSGZTRB2LSxICpbI2wHMjcZnF69kKj/UW2XLgRGUptsCmpp9ix84q0pjC
        VvmqxEj7X8A00pTRR5QxZI+kX0se+IeiwUpzKsexW2C6CeUf8ISMmWieaqA6623oUyzoXe
        9e558Q7lOTQkSENwSH2DewFBhhngIak=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-Z0uRRdeYOz2PvSaV2lOFhA-1; Wed, 16 Jun 2021 10:41:04 -0400
X-MC-Unique: Z0uRRdeYOz2PvSaV2lOFhA-1
Received: by mail-ed1-f71.google.com with SMTP id x12-20020a05640226ccb0290393aaa6e811so1152644edd.19
        for <linux-acpi@vger.kernel.org>; Wed, 16 Jun 2021 07:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/KmdDtuxC4DPMkm/dYQuBivCzYIDXejkNuC0LvGZbxU=;
        b=GoZxW9Ijl+KmJqq1H+ODdaQlVHlATGDvorjMhhdaFGgDxUsrolmcnSovMu91iIo3kR
         X/SLk/NcL96UDaaOC1IAS4Xd+4PwhO3EBPOnGRS15pYACDJSuhZVsT8v2eEmqFGPfC1n
         nfp8g7HfFLgc7aFdUrQu2x0ftqIu1ft5I5LrYdh44sjhK4t6kXGMgPBOAxWkOR+Jf2Y4
         iKN+5hf4pzoszVdF7TufrqeovIAtkBSgvTwG/gExgM7TdvFo4MjdGettrySaq/FjyO5N
         iW2gB9a4gjkha5Dwgjx4cpyhrKCGodSkXfnTO6jxou+JaKBI4llq0H5UOCmd0o+y5GDj
         RcZA==
X-Gm-Message-State: AOAM532dIDkNkHf2TP6xMbf9GX4rbkSwdHIWJxwcCT8slVcUDJ/LOZWo
        fj8T8SF2Sn0TcN/5ITZI7omtvLyJGss1egpo0waCY+MBZWE3ENksY+WxFvAU84g5c4QmCato0kZ
        WELyb38ZRFWBgAVgwIuELVg==
X-Received: by 2002:a05:6402:520b:: with SMTP id s11mr4598054edd.111.1623854463231;
        Wed, 16 Jun 2021 07:41:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyczHmLu6t+yCUzUAbMlYbY+WyHHr7hOEQVqmOEk9e7Vkgp3nCAYDNB5ni47dvk6qm1OkL03A==
X-Received: by 2002:a05:6402:520b:: with SMTP id s11mr4598044edd.111.1623854463136;
        Wed, 16 Jun 2021 07:41:03 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id j22sm1817090ejt.11.2021.06.16.07.41.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 07:41:02 -0700 (PDT)
Subject: Re: [GIT PULL] intel-gpio for 5.14-1
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux GPIO <linux-gpio@vger.kernel.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Scally <djrscally@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <YL43SrZ8N8H+ZHE9@black.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <66fee594-8e13-5200-f8d9-c71caeb863a7@redhat.com>
Date:   Wed, 16 Jun 2021 16:41:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YL43SrZ8N8H+ZHE9@black.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/7/21 5:12 PM, Andy Shevchenko wrote:
> Hi Linux GPIO and TWIMC maintainers,
> 
> This is GPIO material for v5.14 cycle. It contains some stuff that other
> subsystems may take due to dependencies. Consider this tag immutable.
> 
> Thanks,
> 
> With Best Regards,
> Andy Shevchenko

Thank you, I've merged this into the review-hans branch of
platform-drivers-x86 now, because this is a dependency for:
https://patchwork.kernel.org/project/platform-driver-x86/patch/20210603224007.120560-6-djrscally@gmail.com/

After I've run some tests I will push the review-hans branch
to the for-next branch.

Regards,

Hans





> 
> The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:
> 
>   Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)
> 
> are available in the Git repository at:
> 
>   git@gitolite.kernel.org:pub/scm/linux/kernel/git/andy/linux-gpio-intel.git tags/intel-gpio-v5.14-1
> 
> for you to fetch changes up to 043d7f09bf614809c10c4acbf0695ef731958300:
> 
>   gpiolib: acpi: Add acpi_gpio_get_io_resource() (2021-06-04 16:24:19 +0300)
> 
> ----------------------------------------------------------------
> intel-gpio for v5.14-1
> 
> * Export two functions from GPIO ACPI for wider use
> * Clean up Whiskey Cove and Crystal Cove GPIO drivers
> 
> The following is an automated git shortlog grouped by driver:
> 
> crystalcove:
>  -  remove platform_set_drvdata() + cleanup probe
> 
> gpiolib:
>  -  acpi: Add acpi_gpio_get_io_resource()
>  -  acpi: Introduce acpi_get_and_request_gpiod() helper
> 
> wcove:
>  -  Split error handling for CTRL and IRQ registers
>  -  Unify style of to_reg() with to_ireg()
>  -  Use IRQ hardware number getter instead of direct access
> 
> ----------------------------------------------------------------
> Alexandru Ardelean (1):
>       gpio: crystalcove: remove platform_set_drvdata() + cleanup probe
> 
> Andy Shevchenko (3):
>       gpio: wcove: Use IRQ hardware number getter instead of direct access
>       gpio: wcove: Unify style of to_reg() with to_ireg()
>       gpio: wcove: Split error handling for CTRL and IRQ registers
> 
> Daniel Scally (2):
>       gpiolib: acpi: Introduce acpi_get_and_request_gpiod() helper
>       gpiolib: acpi: Add acpi_gpio_get_io_resource()
> 
>  drivers/gpio/gpio-crystalcove.c | 10 +-------
>  drivers/gpio/gpio-wcove.c       | 39 +++++++++++++++----------------
>  drivers/gpio/gpiolib-acpi.c     | 51 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h            |  7 ++++++
>  include/linux/gpio/consumer.h   |  2 ++
>  5 files changed, 80 insertions(+), 29 deletions(-)
> 

