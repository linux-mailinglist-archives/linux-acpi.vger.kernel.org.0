Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9AA47C62A
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Dec 2021 19:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241120AbhLUSQd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 21 Dec 2021 13:16:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38413 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236864AbhLUSQd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 21 Dec 2021 13:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640110592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oZeVhFboZslEu9Zvr6cMkBDRbTmY4fOX3foXx2jkBng=;
        b=GEsNHl5EFwKNtMcA9mjvHSZVDKEB/penB+t0CtxJWNAk/2LwtB+1PeOR7J8XkSljEwhOiw
        Iju989bYh6YsUkL/mTGFsq3eVi9JB2/CQW4EzesK8KbByU981U2M5wf3SwphMLBRNQ4K25
        o2mWp2l+OdOYOsxb7YjPqXGATa3c5Ug=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-458acgUdMmqU3HtNs6UZ6g-1; Tue, 21 Dec 2021 13:16:31 -0500
X-MC-Unique: 458acgUdMmqU3HtNs6UZ6g-1
Received: by mail-ed1-f70.google.com with SMTP id z8-20020a056402274800b003f8580bfb99so5713872edd.11
        for <linux-acpi@vger.kernel.org>; Tue, 21 Dec 2021 10:16:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oZeVhFboZslEu9Zvr6cMkBDRbTmY4fOX3foXx2jkBng=;
        b=7lBK/IjXuZv9k4hrTz2ZsIlYfdvnM0FwbUr0hNw5pSxNGvGV8ga2m1w6SRL4XUeJpY
         2YMuxXF9H282uHrz0X6wbWxpdR9tbseLr5uvuJJ69BnarZmtMqZ9P6g4nbzrzuhIAQ2i
         mK67i6AXOnC+ZtaNAp6PW13rNMOqJvsrwgVByY38pJ70Jclxzc6A25wYv9EWuM9JmR4B
         /8fGTy18jtp7Q266cSIWTuMoaJa8Zv/UFLxGNS4A4RuUm/spLj3fyhjS1pQZ9HX98xXC
         GukLvk16jchEHclHmIjt28ONc2lW2PnHwwg19kJOzf0XPPptIPriO72tSWkIPhS1/xCk
         TRfw==
X-Gm-Message-State: AOAM532hx8Jg0TWZc8TRdkemspvKhlzipVYXWz+mh16mQIkWTIvPuTHm
        M9ILxOqTFZCRINtSe2GUOYExp3KcjT851MF9uK/oNN+9Nuvxul2FUUf6DtMJnf6toptPiH5/vX6
        Mo1EK9nVVTTQvEQYn5rXDQA==
X-Received: by 2002:a05:6402:2891:: with SMTP id eg17mr4529285edb.33.1640110590002;
        Tue, 21 Dec 2021 10:16:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy1A8/D2KSPClN8mkwmxMpBeMDz35yUrtABXglLtrO/tH+rl/3zBn9FK8lB8DeMNNQQA0SHdg==
X-Received: by 2002:a05:6402:2891:: with SMTP id eg17mr4529270edb.33.1640110589822;
        Tue, 21 Dec 2021 10:16:29 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id hd36sm778579ejc.96.2021.12.21.10.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 10:16:29 -0800 (PST)
Message-ID: <e387ed3f-8f8c-1fa9-e576-92bd3ab08671@redhat.com>
Date:   Tue, 21 Dec 2021 19:16:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 0/6] Support Spi in i2c-multi-instantiate driver
Content-Language: en-US
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Gross <markgross@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20211210154050.3713-1-sbinding@opensource.cirrus.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211210154050.3713-1-sbinding@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Stefan,

On 12/10/21 16:40, Stefan Binding wrote:
> Add support for SPI bus in the ic2-multi-instantiate driver as
> upcoming laptops will need to multi instantiate SPI devices from
> a single device node, which has multiple SpiSerialBus entries at
> the ACPI table.
> 
> With the new SPI support, i2c-multi-instantiate becomes
> bus-multi-instantiate and is moved to the ACPI folder.
> 
> The intention is to support the SPI bus by re-using the current
> I2C multi instantiate, instead of creating a new SPI multi
> instantiate, to make it possible for peripherals that can be
> controlled by I2C or SPI to have the same HID at the ACPI table.
> 
> The new driver (Bus multi instantiate, bmi) checks for the
> hard-coded bus type and returns -ENODEV in case of zero devices
> found for that bus. In the case of automatic bus detection, 
> the driver will give preference to I2C.
> 
> The expectation is for a device node in the ACPI table to have
> multiple I2cSerialBus only or multiple SpiSerialBus only, not
> a mix of both; and for the case where there are both entries in
> one device node, only the I2C ones would be probed.
> 
> This new bus multi instantiate will be used in CS35L41 HDA new
> driver, being upstreamed:
> https://lkml.org/lkml/2021/11/23/723

Patches 1-5 look good to me and are:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Rafael, you may also consider this as my ack for merging this
series through the ACPI subsys branches.

But I do have some remarks on patch 6 which should be
addressed first.

Regards,

Hans



> 
> Changes since V1:
>  - Added Cover Letter
>  - Split SPI patch into move, rename, reorganize and add
>    SPI support
>  - Hard coded BUS type for better decison making at bmi_probe
>  - Driver moved to acpi folder
>  - Change to use acpi_spi_find_controller_by_adev
>  - New shared function bmi_get_irq for I2C and SPI
> 
> 
> Lucas Tanure (3):
>   platform/x86: i2c-multi-instantiate: Move it to drivers/acpi folder
>   ACPI: i2c-multi-instantiate: Rename it for a generic bus driver name
>   ACPI: bus-multi-instantiate: Reorganize I2C functions
> 
> Stefan Binding (3):
>   spi: Export acpi_spi_find_controller_by_adev to be used externally
>   spi: Make spi_alloc_device and spi_add_device public again
>   ACPI: bus-multi-instantiate: Add SPI support
> 
>  MAINTAINERS                                  |   4 +-
>  drivers/acpi/Kconfig                         |  11 +
>  drivers/acpi/Makefile                        |   1 +
>  drivers/acpi/bus-multi-instantiate.c         | 500 +++++++++++++++++++
>  drivers/acpi/scan.c                          |  19 +-
>  drivers/platform/x86/Kconfig                 |  11 -
>  drivers/platform/x86/Makefile                |   1 -
>  drivers/platform/x86/i2c-multi-instantiate.c | 174 -------
>  drivers/spi/spi.c                            |   9 +-
>  include/linux/spi/spi.h                      |  22 +
>  10 files changed, 552 insertions(+), 200 deletions(-)
>  create mode 100644 drivers/acpi/bus-multi-instantiate.c
>  delete mode 100644 drivers/platform/x86/i2c-multi-instantiate.c
> 

