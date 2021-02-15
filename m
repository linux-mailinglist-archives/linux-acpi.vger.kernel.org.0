Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3811431BC3C
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Feb 2021 16:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhBOPYG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Feb 2021 10:24:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20048 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230106AbhBOPYC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 15 Feb 2021 10:24:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613402552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fJz8YgaK9JiINlO/a+xlVgWJntkGKx0HDC2HE+3srwg=;
        b=DYpj5ujPAglcb12jtsN8mIGBU5CvF8SO3hLSLpupgp2devT9rTS7r27SjivakX0QQcLePn
        Qqt+u3IN03jR+1kDMLlfksxtzUg40ebp64pcNt8MLi8flaEK5YNx8BEKTTf5wG9HEEvSty
        Mj2nS2a6HOibj5f27qjjvZhYU0K7EWc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-EU1IPDt_MgG0kGj0axTGiA-1; Mon, 15 Feb 2021 10:22:30 -0500
X-MC-Unique: EU1IPDt_MgG0kGj0axTGiA-1
Received: by mail-ed1-f71.google.com with SMTP id l23so5211580edt.23
        for <linux-acpi@vger.kernel.org>; Mon, 15 Feb 2021 07:22:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fJz8YgaK9JiINlO/a+xlVgWJntkGKx0HDC2HE+3srwg=;
        b=D4OErsJLXE3/Ww13dQbO4E9XjSOrWszfRuz+QuhTiHSCJJtipFVDz97IZsBsHGUrHu
         M3oLQj1dwuewo3KsWbMZWcc4V+BstYH1CRYKjead+/BDLNfVgQn3NuRE8TolL0AiB8KA
         Z4v4G+K8VRx6wSH8jmKeoB3uwvigAPb8lw7HR15unL6jmqJxFtjO3AOu3Yo1CBLDhQIX
         0QlUHwgLObn7a3Twsgn3uTyHu1XTQ2uaXXCHiRklopOEk4Ai0fBYOQYbvXPVizVwtEoy
         MrXqeA/U9nbUrM2kPjYAnpGqndCn4WB4hwErHtzAcLH163YVyB/QjzKbsvi4R+G3qNmf
         yHzA==
X-Gm-Message-State: AOAM533V9U72wgnWrftsLHYNNE5BU7/rZ4okf1UGeVYGyBAg/Xse6naH
        nR3zNACYkb0ZiPtJpUNIjgI+gJ8ycefLxpPNfK2aXEremNKhA/EGGhwanW3YqrECiwzzQsgOBx0
        PItBj4ED8HDIpXHvROJHO1Q==
X-Received: by 2002:a17:906:4050:: with SMTP id y16mr1830498ejj.203.1613402549492;
        Mon, 15 Feb 2021 07:22:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy+zjwVtuh7Fqdmsz92FGNGYl8ZNQsHVtJy7xb1/oGQop9MCGMwieZLXoXsr8wv3IpM9z9ZOQ==
X-Received: by 2002:a17:906:4050:: with SMTP id y16mr1830452ejj.203.1613402549050;
        Mon, 15 Feb 2021 07:22:29 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id op10sm1052452ejb.98.2021.02.15.07.22.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Feb 2021 07:22:28 -0800 (PST)
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
Message-ID: <510803ab-b5b8-ce2c-e956-5539874d00bf@redhat.com>
Date:   Mon, 15 Feb 2021 16:22:28 +0100
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

So I just realized one problem with this plan, patch 1/4 depends
on (modifies) Kconfig bits which are only in my tree / my 5.12 pull-req
(which I send out earlier today).

One option here would be for me pickup 1-3/4 and send a second
pull-req during the merge-window, with your ack as these are
touching files under drivers/acpi ?

Regards,

Hans

