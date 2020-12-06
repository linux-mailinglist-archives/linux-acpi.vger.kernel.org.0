Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9A22D0550
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Dec 2020 14:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgLFNoo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 6 Dec 2020 08:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgLFNon (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Dec 2020 08:44:43 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF66C0613D0;
        Sun,  6 Dec 2020 05:43:57 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id b9so5269405ejy.0;
        Sun, 06 Dec 2020 05:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VWJj8XSsi7Sw4xHAcPfuTamGh9q6QQBhc7e1qaVJ+k4=;
        b=pZkwpEsg21dhYiAGtDbCCaRwajOaUwQ0h1PtfqOKNlI9V/vBseeyH/TNqaWJdX0gLB
         mGc38Nu47/NtHxYHSVErHYCnUG70c6yc7DLGyVtDG1BuBlb6/O5YlnMVeLqYEIThU3tJ
         A4HFhujdvgYJ/+XP7f4J6ARDclvwjtEz+nfDTDSnqkg9Sy3v0xORHCoxb7l7zRowydXE
         E7AvX4xV+b2d7c6ue9ZgH/CyezF+kMv0RmqvOZNkxenHfkf5twG6ZHRZhL8rDjIHxmim
         qotszAFcAtiYI7wTxQXBKZ0YnXV8VFqENw+YPQiFdtETfTVdGlwPtRnRwToDlznowIYT
         G1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VWJj8XSsi7Sw4xHAcPfuTamGh9q6QQBhc7e1qaVJ+k4=;
        b=RMUl2porYFB1z6+NQjcAtRKzOBI/o17QVg2zMOzy7cK/ufnR/O2fhzbRTDpWFCsydx
         0yL4qOaP5AAklI80AH/YFQTrZeP9n4EntTy/8aBIy0aKSCV2i5RwKPp9I+TvrLQBzLmi
         GUZifHQoIUrgqv5ewxkR1o+GqXHsZE9HWbo2W0JvzUfUOiSryRD2XxPH9gy/SgwhEuM7
         u3i1NbI/h6ryf2lAKI8CovJ/4TNixdhmo6OTbDv05Y43j0qsyoEkivYuHahiFVachAgC
         SA1YXbNsx3DzL2k2skqLMX3O+hYeN1mmu9QP25tfCOFVgK/JlnAy4C8d/tEBKuTN97jz
         mkZQ==
X-Gm-Message-State: AOAM531rTfKjuckQsUuhvPIYw2gogN9FTsx059/xJ6aaIqd6sN+W1DQg
        fxI/EH6hVjfzxLShfG+2XbQRVlr+Lok=
X-Google-Smtp-Source: ABdhPJyXk2ybgpnATvSwLw8NdiS6UX9TB7aFXbDKLfjznWzyfHRb///DQRXPJJ2fgKY7Io9hc01yJQ==
X-Received: by 2002:a17:907:9705:: with SMTP id jg5mr8503692ejc.448.1607262235792;
        Sun, 06 Dec 2020 05:43:55 -0800 (PST)
Received: from [192.168.2.202] (pd9e5a241.dip0.t-ipconnect.de. [217.229.162.65])
        by smtp.gmail.com with ESMTPSA id j10sm8678812edj.97.2020.12.06.05.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Dec 2020 05:43:55 -0800 (PST)
Subject: Re: [PATCH v2 0/9] Add support for Microsoft Surface System
 Aggregator Module
To:     Leon Romanovsky <leon@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20201203212640.663931-1-luzmaximilian@gmail.com>
 <20201206070705.GA686270@unreal>
 <052ecf4d-9e08-2c08-8a06-c30ba2b28d82@redhat.com>
 <20201206085631.GE210929@unreal>
 <f76b329a-b6f5-486d-b06a-452ec4c51979@redhat.com>
 <20201206103339.GB693271@unreal>
 <f2511463-3bb8-a640-7863-b206db136109@redhat.com>
 <20201206114153.GD693271@unreal>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <040a5b5f-f268-79ea-c32c-95f229a34b4a@gmail.com>
Date:   Sun, 6 Dec 2020 14:43:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201206114153.GD693271@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 12/6/20 12:41 PM, Leon Romanovsky wrote:
> On Sun, Dec 06, 2020 at 11:41:46AM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 12/6/20 11:33 AM, Leon Romanovsky wrote:
>>> On Sun, Dec 06, 2020 at 11:04:06AM +0100, Hans de Goede wrote:
>>
>> <snip>
>>
>>>> But there is a difference between being careful and just nacking
>>>> it because no new UAPI may be added at all (also see GKH's response).
>>>
>>> I saw, the author misunderstood the Greg's comments.
>>
>> Quoting from patch 8/9:
>>
>> "
>> +==============================
>> +User-Space EC Interface (cdev)
>> +==============================
>> +
>> +The ``surface_aggregator_cdev`` module provides a misc-device for the SSAM
>> +controller to allow for a (more or less) direct connection from user-space to
>> +the SAM EC. It is intended to be used for development and debugging, and
>> +therefore should not be used or relied upon in any other way. Note that this
>> +module is not loaded automatically, but instead must be loaded manually.
>> "
>>
>> If I'm not mistaken that seems to be pretty much what Greg asked for.
> 
> Right, unless you forget the end of his request.
>   "
>    The "joy" of creating a user api is that no matter how much you tell
>    people "do not depend on this", they will, so no matter the file being
>    in debugfs, or a misc device, you might be stuck with it for forever,
>    sorry.
>   "

Which to me reads as "if you want a user-space interface for development and
debugging, you'll have to make it a stable interface, regardless where it is
implemented". Rather making a point for a well though-out stable interface.
Specifically with regards to

    "
     >  - So you suggest I go with a misc device instead of putting this into
     >    debugfs?

     Yes.
    "

Unless of course I'm misunderstanding things entirely. Greg, please feel free
to yell at me if I've got this wrong.

> So I still think that exposing user api for a development and debug of device
> that has no future is wrong thing to do.

Unless you know something that I don't, MS is rumored to come out with a new
Surface Pro 8 and Surface Laptop 4 early next year, which I fully expect to
also have this EC built in. And if they once again decided to move some
functionality normally provided via ACPI or other means to the EC for some
reason, we'll likely need that interface again.

Yes, it has no future outside of Surface devices, but so has every other
platform driver with respect to their specific platform. What are your
alternatives to exposing a user API? If we want to be able to easily test
and attempt to provide support for Surface devices, there has to be some
interaction with user-space.

With respect to stability of the interface and future changes, I believe
that IOCTLs are the way to go. If that's in debugfs or, as was the
result from the previous discussion about this, via a misc-device...
I'll be happy to implement whatever a consensus yields, as long as it
can be used for its intended purpose: aid development with regards to
the EC found on Surface devices.

Regards,
Max
