Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FDB277906
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Sep 2020 21:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgIXTR0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Sep 2020 15:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgIXTR0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Sep 2020 15:17:26 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D1EC0613CE;
        Thu, 24 Sep 2020 12:17:25 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p9so308466ejf.6;
        Thu, 24 Sep 2020 12:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h1VoA7OKiH+cdit4mm4O2zd0Tw6zM3Q4V6K1zdq9FWE=;
        b=CPfOOWs9sDvMAKby1idWrCOP94Wyr+ZMxegjP9019mHptZ1gGqwxihutuHjfoMsuWu
         d/g8DjzsuHvSaU2JLwKD9PW5qk6iR5B20duSy3I/sYFK5fV5k6INIqZbstC31auUO3uP
         Q9p9SaNYOXcZVqOFLnyYAKNldtneJa9Bg8Bt41B37GSDOoWyndfZRPpBxstO3cY5LajU
         0jsbMpsz8bSyM3rIkIw/+KRJsPB9J70BXDl+xWhju4N3KtAcyOYU3GlhztDKSMtGP/s+
         yoxxClmg/MJpviOFAeFsEIf4Do/u3zuvTBAu5alIPzQD+G0SBeKsdROEs9Rsil8saU4l
         iSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h1VoA7OKiH+cdit4mm4O2zd0Tw6zM3Q4V6K1zdq9FWE=;
        b=cK9Z3Hq+wXoZozB1VQ1JN5AZ0mExxfCfko4HH3l2EnDlZsZka4S6QJv73bRCc5h+zN
         KbRNfCGMNcY0V529KBE9w4Vu1Rl1aXg6UHZJ+27JTO9qPSvk7pRmX3kOHc1sB1al8Q88
         ZvazaPks5mCbGWRAOfy0OgtcgWBw6r4CbffVKoCYfzNXD37CqtMdO0POklJovEtDXKJN
         5xe71GEN5fxSr4M09q9LVAncgSMLm8WHQ2b51v/emsgbzrAD+Gl2LY93LxfOxHsWoN4E
         ix41p43jk7gSvAngSdpVECVfNeWh+p2mvogHYAyRuQqyEipuDFunqpHct/F90Ym4Yumo
         TYIw==
X-Gm-Message-State: AOAM5337xELiBGgv+WDQDl26vHX4WfQmlv964yJM//C1QFbut8Ywbj9Q
        3MeJ2snXME/043c4/qpBkUEC4tYCRMSXWw==
X-Google-Smtp-Source: ABdhPJwrBKBnTVa5b20K8m+aWXTOHq2v5qNn3QFPotN7Ymaw7mYIIboiThbnKAsqnhDA59dy/kqcAQ==
X-Received: by 2002:a17:906:d7ab:: with SMTP id pk11mr138078ejb.472.1600975043995;
        Thu, 24 Sep 2020 12:17:23 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a9d2.dip0.t-ipconnect.de. [217.229.169.210])
        by smtp.gmail.com with ESMTPSA id z17sm68129edi.90.2020.09.24.12.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 12:17:23 -0700 (PDT)
Subject: Re: [RFC PATCH 0/9] Add support for Microsoft Surface System
 Aggregator Module
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
 <CAK8P3a3Qie_CP1dA-ERqyDv=EnaQQPnNbFYrGr3ySiY4mO0=Uw@mail.gmail.com>
 <CAHp75Vfp86h38Rd-VEgER7ASADdmz5ymAkuHvD0Q6WPDqZBqHw@mail.gmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <95c2d02b-b8b1-59d9-1276-f2b1830fdac8@gmail.com>
Date:   Thu, 24 Sep 2020 21:17:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vfp86h38Rd-VEgER7ASADdmz5ymAkuHvD0Q6WPDqZBqHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 9/24/20 10:30 AM, Andy Shevchenko wrote:
> On Wed, Sep 23, 2020 at 6:32 PM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Wed, Sep 23, 2020 at 5:15 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>>>
>>> Hello,
>>>
>>> The Surface System Aggregator Module (we'll refer to it as Surface
>>> Aggregator or SAM below) is an embedded controller (EC) found on various
>>> Microsoft Surface devices. Specifically, all 4th and later generation
>>> Surface devices, i.e. Surface Pro 4, Surface Book 1 and later, with the
>>> exception of the Surface Go series and the Surface Duo. Notably, it
>>> seems like this EC can also be found on the ARM-based Surface Pro X [1].
>>
>> I think this should go to drivers/platform/x86 or drivers/platform/surface/
>> along with other laptop vendor specific code rather than drivers/misc/.
> 
> +1 here. drivers/platform/surface is a good place to start.
> And you may begin with moving a few Surface drivers out of PDx86 to
> the new folder.

Perfect, thanks! I'll draft up a patch series over the weekend.

A couple questions regarding structure and maintenance:

  - Should I CC the platform-driver-x86 list on future submissions to
    drivers/platform/surface? I.e. is this something you would want to
    review if it doesn't touch the drivers/platform/x86 directory?

  - How would you want the layout to be, specifically regarding to the
    surface-aggregator stuff? My suggestion would be simply:

    drivers/platform/surface/
        surface_aggregator/
            Kconfig
            Makefile
            core.c
            controller.c
            ... (all core stuff built into the surface_aggregator module)
        Kconfig
        Makefile
        surface_aggregator_debugfs.c
        surface_acpi_notify.c
        surface_*.c        (any other surface platform driver as well
                            as drivers dependent on surface_aggregator)

  - Regarding future things like HID transport driver, battery/AC driver:
    Submit them to drivers/platform/surface or to their respective
    subsystem directories?

Thanks,
Max
