Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355EA470679
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Dec 2021 17:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244278AbhLJQ6R (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Dec 2021 11:58:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33725 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244271AbhLJQ6Q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 10 Dec 2021 11:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639155280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V020FD6A+TFMeJ1aq3+n6+89eSkCOw7jD3ULGiZQ8B8=;
        b=W6PxLFwvYcJik4IjNLwe7mIhP86ymuVhAtMr5TOpAZiwo2MGoC+rzAbuE/wPjFaqmaLl9N
        L/LT0Q+dQkQx0jQInx+yqNxmdXNJ9AGk8O7X7tC8TSnlV3rbNOj+4GwvyW1ZTvem3AWEBz
        22sUdbVYcRxU1ndiz0qpG7DcEgA4FAs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-202-WzONH23NPoiroWo7OYRQ9w-1; Fri, 10 Dec 2021 11:54:37 -0500
X-MC-Unique: WzONH23NPoiroWo7OYRQ9w-1
Received: by mail-wm1-f70.google.com with SMTP id j193-20020a1c23ca000000b003306ae8bfb7so5181084wmj.7
        for <linux-acpi@vger.kernel.org>; Fri, 10 Dec 2021 08:54:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=V020FD6A+TFMeJ1aq3+n6+89eSkCOw7jD3ULGiZQ8B8=;
        b=oXjgO6q3WbDIOxL3alhCXlb4ry1y//1kRbNvTI/N65ZOBVwkvax/qH3ijVZv6e4gJI
         +Dj281nzC3XP49OVDMgDphXhAZQHQYelIHHbh1nFci4dTkjQE8izgkp6Xgmd+szHfp4P
         r2kC1TCezJAjzUvKZqOoaTxuB0h2uiY6lfRmX6gPxjj5Bu48bdFv9rAXUcQwr040OJRO
         sgWrOwV3owd+BgseM6ALI/HsxUvDlHwA0MN/b61yYkmhk8vFv2kBs2HsSV8192E3yOFT
         dvMBblpG5/yuP+7qWU/qBtl1Wr8PoQXVE6fLj+0V2eCCHmkPabbdXhlP0Lkb6Ue5/+7q
         65Fg==
X-Gm-Message-State: AOAM5317glrcsZjZtOMk/dvA/HBK0CMPTesxnBJJ5BBWa2poumK/09iE
        ah6fRSfW4O+hhZK53SmRZgVxl0AiaCsfat5KhgE4z4Wkdeg9EaRLI71ILkIFYU/lpGfc3CLl3op
        YtJEV46HP6hNJPDz+MGSR7w==
X-Received: by 2002:a05:600c:4e8f:: with SMTP id f15mr18370142wmq.76.1639155276386;
        Fri, 10 Dec 2021 08:54:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZuDU12I7ul5MprxalyWosHBaLLt+aIvUY7YHF9Ttkwa1eD+sivVwGWLbJCuxP5mQnHhGpfQ==
X-Received: by 2002:a05:600c:4e8f:: with SMTP id f15mr18370113wmq.76.1639155276155;
        Fri, 10 Dec 2021 08:54:36 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id t16sm2922983wrn.49.2021.12.10.08.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 08:54:35 -0800 (PST)
Message-ID: <8160a1c8-544d-6d95-4f80-224c7a9a9d40@redhat.com>
Date:   Fri, 10 Dec 2021 17:54:34 +0100
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

Unfortunately you never really answered my questions about v1
of this series:

https://lore.kernel.org/platform-driver-x86/a1f546c2-5c63-573a-c032-603c792f3f7c@redhat.com/

So looking at the linked CS35L41 HDA series there is a single
ACPI device node with a HID of CLSA0100 which describes
two CS35L41 amplifiers connected over I2C ?

I assume you are doing this work because there are also designs
where there is a similar CLSA0100 ACPI device which also describes
two CS35L41 amplifiers but then connected over SPI ?

It would really help if you can:

1. Answer my questions from v1
2. Provide a concrete example of a device where these changes will
be necessary to make things work, preferably with a link to an
actual ACPI DSDT of that device.

Until you can better clarify why this is necessary, this series
gets a nack from me. The i2c-mult-instantiate code is a hack to
deal with some rather sub-optimal choices made in DSDTs used on
devices shipped with Windows and unless absolutely necessary
I would rather not see this get expanded to SPI.

Regards,

Hans

