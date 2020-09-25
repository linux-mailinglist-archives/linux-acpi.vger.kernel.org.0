Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C76278CFA
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Sep 2020 17:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbgIYPlr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Sep 2020 11:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgIYPlr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Sep 2020 11:41:47 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E40C0613CE;
        Fri, 25 Sep 2020 08:41:47 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id t16so2946715edw.7;
        Fri, 25 Sep 2020 08:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F+5yHV+FxcRKrnedBNbOKTzuVXY9zUpRD9QVW+qIhF0=;
        b=JBxFXPiMiDiS5nKIg3qxtqvYTiI4ocb8cxha/z1a0K3tm1x0+7BaxxjVyoEWdlgYJF
         3ibIqkWkj6vkkl4xKZpFGB1Lx01wa5WVyJfhF+2YUXa5x9R1s8d4mVah0m3gprGEyxDT
         pvuLEfMttB513LeydPhgovFFXNND7Ep1WnTghVEoxqc10xc3j3skNYMaV9ENiWvTKbTJ
         eiSp0UTIWyS7tm+qaXdDOqLL2ymBbdbxsfPHcNwTL8gEbjfXuI4Skp8/G3vBF/bSbYJF
         CIHDneT3rzfYCGXRyPmCRFnS0vXsch5FwDmZiObGhdDSA6ZjmWb/qeDgLE+q0AMkrkw/
         leXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F+5yHV+FxcRKrnedBNbOKTzuVXY9zUpRD9QVW+qIhF0=;
        b=mtCnmPKmDKLclmiejAWG5c+QQgydKRZSMN92SA+dGTa5S6oYiXnJI95XOG/sDb7lJ5
         rAd2gn/hRQ5kYmmZzpm80k3GESvVJuodX/YlO6iVwnKR02pd7TGKqnVatyCrlyF4j5pC
         bgmZWVER3tykUnxFRyFh9NTbmrajxGOdhMFWXki2bL7wuyQyyjKkl08JqthPko/zD5K6
         /x43zhvE6JkE2g+R+KWU6MAZ8sAJR1D2t6wMnxM2rMXJfS18cQ9UbHd7hpcn8Dyl8wDz
         YQtLNFlrR9ZdAwpwTfIJ4/ILawKWr2XnqAppwrs04Bcm4V3GDqay9NZc57vme+3MD3M6
         GIfQ==
X-Gm-Message-State: AOAM531MCHR+O46e20sqRdyU+YnCIplWJNlAq4FQTIBYk3lY2D4bktRm
        2WspSmEAG575nP+uSK6R72QeoYdZ8vkasw==
X-Google-Smtp-Source: ABdhPJxMaDIA9K/WRwt+Hm7at0yFLJktmxHnHp9F6JDTRmWhsiFFaTxVr8f6lvaU0d8ubW82gxQ8Gw==
X-Received: by 2002:aa7:dc0e:: with SMTP id b14mr1989973edu.17.1601048505404;
        Fri, 25 Sep 2020 08:41:45 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a5af.dip0.t-ipconnect.de. [217.229.165.175])
        by smtp.gmail.com with ESMTPSA id y21sm2118250eju.46.2020.09.25.08.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 08:41:44 -0700 (PDT)
Subject: Re: [RFC PATCH 0/9] Add support for Microsoft Surface System
 Aggregator Module
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
        Platform Driver <platform-driver-x86@vger.kernel.org>
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
 <CAK8P3a3Qie_CP1dA-ERqyDv=EnaQQPnNbFYrGr3ySiY4mO0=Uw@mail.gmail.com>
 <CAHp75Vfp86h38Rd-VEgER7ASADdmz5ymAkuHvD0Q6WPDqZBqHw@mail.gmail.com>
 <95c2d02b-b8b1-59d9-1276-f2b1830fdac8@gmail.com>
 <CAHp75Vc6ohuT_Ga=p-n+gKaVhPWE2EEbkhx-EQO_vKEtgmswqA@mail.gmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <41fe48ea-5486-3d06-6fb8-0663e2c930b5@gmail.com>
Date:   Fri, 25 Sep 2020 17:41:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc6ohuT_Ga=p-n+gKaVhPWE2EEbkhx-EQO_vKEtgmswqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 9/25/20 4:58 PM, Andy Shevchenko wrote:
> On Thu, Sep 24, 2020 at 10:17 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>> On 9/24/20 10:30 AM, Andy Shevchenko wrote:
>>> On Wed, Sep 23, 2020 at 6:32 PM Arnd Bergmann <arnd@arndb.de> wrote:
>>>> On Wed, Sep 23, 2020 at 5:15 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
> 
> ...
> 
>>>> I think this should go to drivers/platform/x86 or drivers/platform/surface/
>>>> along with other laptop vendor specific code rather than drivers/misc/.
>>>
>>> +1 here. drivers/platform/surface is a good place to start.
>>> And you may begin with moving a few Surface drivers out of PDx86 to
>>> the new folder.
>>
>> Perfect, thanks! I'll draft up a patch series over the weekend.
>>
>> A couple questions regarding structure and maintenance:
>>
>>    - Should I CC the platform-driver-x86 list on future submissions to
>>      drivers/platform/surface? I.e. is this something you would want to
>>      review if it doesn't touch the drivers/platform/x86 directory?
> 
> Include PDx86 mailing list to the list of that. Current SURFACE*
> drivers have per driver record in MAINTAINERS IIRC. So, update them as
> well if needed.

Will do.

>>    - How would you want the layout to be, specifically regarding to the
>>      surface-aggregator stuff? My suggestion would be simply:
>>
>>      drivers/platform/surface/
> 
>>          surface_aggregator/
> 
> Don't repeat parts of the path, the aggregator is enough as a folder
> name, but the driver of course should be in its own namespace
> ('surface').

Okay.

>>              Kconfig
>>              Makefile
>>              core.c
>>              controller.c
>>              ... (all core stuff built into the surface_aggregator module)
>>          Kconfig
>>          Makefile
> 
>>          surface_aggregator_debugfs.c
> 
> (Not sure why it's not a part of aggregator folder)

I kind of thought of the aggregator folder to contain only files that
build the core module. surface_aggregator_debugfs is intended as
separate module, to be loaded when needed. So I'd consider it a client
driver to the aggregator in the same way that surface_acpi_notify is.

Let me know if you still want me to move this into the aggregator folder
though. Personally, I just feel that that might lead to a bit of
confusion, specifically the idea that it's built into the core when it's
not.

>>          surface_acpi_notify.c
>>          surface_*.c        (any other surface platform driver as well
>>                              as drivers dependent on surface_aggregator)
>>
>>    - Regarding future things like HID transport driver, battery/AC driver:
>>      Submit them to drivers/platform/surface or to their respective
>>      subsystem directories?
> 
> Respective subsystem _if_ it is a subsystem related driver and not
> kinda board file. Use common sense and existing examples.

Right, thank you!

Regards,
Max
