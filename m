Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E7E31BBB4
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Feb 2021 15:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhBOO7K (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Feb 2021 09:59:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33520 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230376AbhBOO6L (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 15 Feb 2021 09:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613401004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C7/6SkhZj68izBGsG8/2xbdZJ41s18nIem3iu9qGMRY=;
        b=ehjL7hdcqWzK6pSew7N3rtTQym3lfC2SFx+P2tKhLoYEVlu+0t1BmPFTFHG3x8wZfDWCbe
        dGDsb1s+InQ49UIjEKvlWQR4ariRXKfRYgJ09ya5lhNjgngNBxrfAES2ifJFggmMmgVmKu
        XPa+TfjJv52gUDmi8VK0XYCY2VkEQ1U=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-JWfYU_MpMXiAKuDWpVMibg-1; Mon, 15 Feb 2021 09:56:42 -0500
X-MC-Unique: JWfYU_MpMXiAKuDWpVMibg-1
Received: by mail-ed1-f69.google.com with SMTP id m16so5149507edd.21
        for <linux-acpi@vger.kernel.org>; Mon, 15 Feb 2021 06:56:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C7/6SkhZj68izBGsG8/2xbdZJ41s18nIem3iu9qGMRY=;
        b=egiEP8ELSiOgTtDYmdYbpmqCNmO4GGIZENLauLZ3iHZKxMDSc9cJdxpSZmiv1vjnCh
         w4M0VdYujm+JdK+5AkJr0TwbhIYYWNGGH7sl2GG2mWtaYnBgMAc8bwWvwiRGVygLH4Zh
         Jx3fLW433xcTcNb7ZhV6AvraJ+2ImwG4+DR64RCxFPpyX7gyG9CwxrN5EVpTfl9KKlK0
         srOG7tqik7ZDJVubNYLMSxay9yiymZ6jijThw25SEZZoXnPHzsNFMAKZsGeWjb510nT2
         xeLba6tpPFtDf6vPVlc2T9W5C15Yc9NPxeGhP5DjQpr1XaomXElkdRbS+V+ckPYbiD2y
         VNXA==
X-Gm-Message-State: AOAM533OwHByieTCYNTyBXAHakEA+pN5bql0Rl1kdYqCpxA/4aHZmgzT
        QOdMKFMyHYY7kNGNovAmyQkZm3PpzZnC0m/YCuO/gMSooy5Fkgz6wM4MKfbOFml0CWk7QCSbI91
        /9Uf1ITp5MIfgLNXGRJtreg==
X-Received: by 2002:a05:6402:4391:: with SMTP id o17mr15955788edc.196.1613401001443;
        Mon, 15 Feb 2021 06:56:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx38aACQ1U8wXIdboC62So4saijuy0+ev58xJuDHDrRQG8u+e9kOHHOzX4gXPbl+KjSoRIXng==
X-Received: by 2002:a05:6402:4391:: with SMTP id o17mr15955778edc.196.1613401001326;
        Mon, 15 Feb 2021 06:56:41 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id o26sm2174323edr.16.2021.02.15.06.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Feb 2021 06:56:40 -0800 (PST)
Subject: Re: [PATCH v2 0/4] platform/surface: Add platform profile driver for
 Surface devices
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mark Gross <mgross@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Mark Pearson <markpearson@lenovo.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210211201703.658240-1-luzmaximilian@gmail.com>
 <898aa498-8256-d59f-9e72-0e1199b3a62a@redhat.com>
 <CAJZ5v0jGUgHsNaqLarf=YLwjtOe-mQB48LkOQLi7FcZyW1Qchg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1d4b3de2-6b05-ef17-2489-db8fb2dfd371@redhat.com>
Date:   Mon, 15 Feb 2021 15:56:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jGUgHsNaqLarf=YLwjtOe-mQB48LkOQLi7FcZyW1Qchg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 2/15/21 3:54 PM, Rafael J. Wysocki wrote:
> On Mon, Feb 15, 2021 at 3:36 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 2/11/21 9:16 PM, Maximilian Luz wrote:
>>> This series adds a driver to provide platform profile support on 5th-
>>> and later generation Microsoft Surface devices with a Surface System
>>> Aggregator Module. On those devices, the platform profile can be used to
>>> influence cooling behavior and power consumption.
>>>
>>> To achieve this, a new platform profile is introduced: the
>>> 'balanced-performance' profile.
>>>
>>> In addition, a couple of fix-ups are performed:
>>> - Hide CONFIG_ACPI_PLATFORM_PROFILE and change drivers so that it is
>>>   selected instead of depended on.
>>> - Fix some references to documentation in a comment.
>>>
>>> Note: This series (or more specifically "platform/surface: Add platform
>>> profile driver") depends on the "platform/surface: Add Surface
>>> Aggregator device registry" series.
>>>
>>> Changes in v2:
>>>  - Introduce new 'balanced-performance' platform profile and change
>>>    profile mapping in driver.
>>>  - Perform some fix-ups for the ACPI platform profile implementation:
>>>    - Fix some references to documentation in a comment.
>>>    - Hide CONFIG_ACPI_PLATFORM_PROFILE
>>
>> Thanks, the entire series looks good to me, so for the series:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>
>> Rafael, can you (once 5.12-rc1 is out) pick 1-3/4 and then provide a
>> stable branch for me to merge?
> 
> Since [1-3/4] appear to be uncontroversial, so IMO it would be better
> to merge them during the merge window, so they are present in
> 5.12-rc1.
> 
> The extra stable branch wouldn't be necessary in that case.

That works for me, thanks.

Regards,

Hans



