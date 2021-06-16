Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1F23AA2F8
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 20:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhFPSPw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 14:15:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38597 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230055AbhFPSPv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Jun 2021 14:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623867225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/2ZgS+GCY+zeGtNmbikEY7JDq0qDESkYvLCgyzZHxds=;
        b=Ie/QqAhfQKdRiVsaNonoQbbTkl6wz1xiF2w9hke8l8a3RhuujGKIwz8jnWRF+D8BAri0Eh
        YgbrbHFR7Gks5MJzfS3qzoBW8yeSLYF+MjM6opIVVHw+ZNeft8UOWFwRtGddaeTwdvqT2w
        dLnl6EuqB567rfHvzUoc4PJoe1QVhdY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-bOJB94yDMZ-kaVRpeg75lQ-1; Wed, 16 Jun 2021 14:13:37 -0400
X-MC-Unique: bOJB94yDMZ-kaVRpeg75lQ-1
Received: by mail-ed1-f69.google.com with SMTP id dd28-20020a056402313cb029038fc9850034so144426edb.7
        for <linux-acpi@vger.kernel.org>; Wed, 16 Jun 2021 11:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/2ZgS+GCY+zeGtNmbikEY7JDq0qDESkYvLCgyzZHxds=;
        b=WNSdfZa98N1iaFleVJ+lcgvZP6Tjyi/YQv0V6FInhbGmX9dqLX1VvMn4YwLBTB/QNH
         p+OvuTzal4j/o7mbsrayckFxl9Bkk65Cy42KRUKSspjAf5qa1PIA5DATwrvTJY4/4KcG
         /C2Lnn98YAAnJPkf50xn3H/NyYm3K1mjn400pXgSje67MEUuwjFMPye0jLMf2bijVtHL
         48a+Q+xAvNPJgOBTafulFGUw0Qhhtsmo4KcuS7ngGim8xTNgWkA/1r/LyCU6+hpsn/qd
         5FCnL+obY15Q80ANg/IhfTjxYpxaNDcHs01gMLL5dD0e2Y8IdsOs4PQnmEq6CCkblP1o
         b1kg==
X-Gm-Message-State: AOAM531PBiCNOZrmei8CEJ00OO8EZVJ09Drd4cEGIi4FEhpOZhszS2XP
        00Fp+oJ3aIjG5FNLiw5YH8xYw7O2NaYqOTw01i2U75v9McoCG0O2gP7XED7xIEaog3ki/SQZqXo
        wjnS2+WX41DZyfXZMtMaKPg==
X-Received: by 2002:a05:6402:781:: with SMTP id d1mr1297297edy.32.1623867216487;
        Wed, 16 Jun 2021 11:13:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9vMHLTBq5mDNxgautgv3pvtkh5NJQutUbOxh1CWqXkx9hBbr+BTgHCyzxPgjYIs3J1MTEVA==
X-Received: by 2002:a05:6402:781:: with SMTP id d1mr1297274edy.32.1623867216371;
        Wed, 16 Jun 2021 11:13:36 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id l26sm2498581edt.40.2021.06.16.11.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 11:13:36 -0700 (PDT)
Subject: Re: [PATCH v5 5/6] platform/x86: Add intel_skl_int3472 driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Wolfram Sang <wsa@kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        kieran.bingham@ideasonboard.com
References: <20210603224007.120560-1-djrscally@gmail.com>
 <20210603224007.120560-6-djrscally@gmail.com>
 <ea322abe-fa78-bbc3-b4c5-b372a4f28235@redhat.com>
 <CAHp75VccZbv8+u-jO8wYSsyQrw+Bd_zeDa==aiTvkh=fteuT3w@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0991caf2-1b7b-c8b5-8558-03b8f0dbb604@redhat.com>
Date:   Wed, 16 Jun 2021 20:13:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VccZbv8+u-jO8wYSsyQrw+Bd_zeDa==aiTvkh=fteuT3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/16/21 8:08 PM, Andy Shevchenko wrote:
> On Wed, Jun 16, 2021 at 8:58 PM Hans de Goede <hdegoede@redhat.com> wrote:
>> On 6/4/21 12:40 AM, Daniel Scally wrote:
>>> ACPI devices with _HID INT3472 are currently matched to the tps68470
>>> driver, however this does not cover all situations in which that _HID
>>> occurs. We've encountered three possibilities:
>>>
>>> 1. On Chrome OS devices, an ACPI device with _HID INT3472 (representing
>>> a physical TPS68470 device) that requires a GPIO and OpRegion driver
>>> 2. On devices designed for Windows, an ACPI device with _HID INT3472
>>> (again representing a physical TPS68470 device) which requires GPIO,
>>> Clock and Regulator drivers.
>>> 3. On other devices designed for Windows, an ACPI device with _HID
>>> INT3472 which does **not** represent a physical TPS68470, and is instead
>>> used as a dummy device to group some system GPIO lines which are meant
>>> to be consumed by the sensor that is dependent on this entry.
>>>
>>> This commit adds a new module, registering a platform driver to deal
>>> with the 3rd scenario plus an i2c driver to deal with #1 and #2, by
>>> querying the CLDB buffer found against INT3472 entries to determine
>>> which is most appropriate.
>>>
>>> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>> Signed-off-by: Daniel Scally <djrscally@gmail.com>
>>
>> Thank you for your patch, I've applied this patch to my review-hans
>> branch:
>> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
>>
>> I've fixed up the missing static marking of skl_int3472_tps68470_calc_type()
>> spotted by lkp@intel.com while applying the patch to my tree.
> 
> Are you going to apply patch 6 as well?
> IIRC it's acked by Lee.

Ah you are right, it is Acked, but I'm not sure if that ack was for
Lee being ok with it being merged through the pdx86 tree. I'll coordinate
this with Lee off list.

Regards,

Hans

