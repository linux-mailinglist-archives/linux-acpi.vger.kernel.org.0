Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9DB2DF24E
	for <lists+linux-acpi@lfdr.de>; Sun, 20 Dec 2020 00:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgLSXtf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 19 Dec 2020 18:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgLSXtf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Dec 2020 18:49:35 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6CEC061285;
        Sat, 19 Dec 2020 15:48:54 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id a6so6278162wmc.2;
        Sat, 19 Dec 2020 15:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rUMcAhttVrLv6lscALuFpWWw1W7PkfzIfUMJWnybu7M=;
        b=prL8wqkPzeWJWE3WeSxsJAf+Y4p8OAA5UDMfAkWynjJJvOPKx6XSyYhQ6OD7P+kAN9
         TYWeshGSBwDxqmNSUFKz+HIVhiE4v5fy/b4jtzrmjdll59hSUEGkXHprsBCfgy4YiwtQ
         8cJduIs+2sWaQCuXf1B0q7z5u0E2WLO0Nv9YbSn2exAdX4LxEyRRIYE+15vsw3CkVPrl
         0PHIJmdNGG4Yfx12ANaFzi3th2JN8iaD6T50hPfgGdD7pFlPvFO2BvxRQxrCz6V/Kj29
         4GXzlxq9R+E0xEaad6UWjXfdoC5LQAXLFxGvWjKzH8CHeZalPwW+hLRuPJwndijIMZjN
         CnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rUMcAhttVrLv6lscALuFpWWw1W7PkfzIfUMJWnybu7M=;
        b=Az6NMQSLtw5t6ODY9+mnpRZQ5E6omBvff0yHZhCT+z4rdTNX2Ans6C476fJB2JRsYb
         ryp08mV8fbsM/IU6MSOagfYxdzz0QKflnZm4iVR3l0bH3ay+a3lhNtko/kuoT/CrnvI8
         A67MIfHvL2fPbF+axPvtl/2+L13oATN8iuLvM6jdpG6WyfH0Qps09Wnt0bY0965ksrhP
         2an+FLgjWeFkvc3yc6B6n9gknRbG6uHEqTNyo/FE4znAmtd2U9G1mDOriHAuaVZfr5ev
         TNFBEMxEHLYYp/inHwilJGOwWgnpzNOjkazb9Og72n8Uy8Zjx8pUWaQ5mDOuDatRWVQO
         wXoA==
X-Gm-Message-State: AOAM533nWas/qTpMAWabnMXyQqUnScBZLO4bnW3pcGalRPuDfqmfIzhN
        UI4cMoLi9longS+G9f3Jo+Q=
X-Google-Smtp-Source: ABdhPJwyVsNbits/IGDogWPOmndvH7aAwODw3c9h8rqBssG5EUhFzGg2o55QmyOf1hoIdexB604R+A==
X-Received: by 2002:a1c:17:: with SMTP id 23mr9690986wma.35.1608421733579;
        Sat, 19 Dec 2020 15:48:53 -0800 (PST)
Received: from [192.168.1.211] ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id k6sm16776578wmf.25.2020.12.19.15.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Dec 2020 15:48:53 -0800 (PST)
Subject: Re: [PATCH v2 12/12] ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@acpica.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tian Shu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        kieran.bingham+renesas@ideasonboard.com,
        Linus Walleij <linus.walleij@linaro.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Tsuchiya Yuto <kitakar@gmail.com>, jorhand@linux.microsoft.com
References: <20201217234337.1983732-1-djrscally@gmail.com>
 <20201217234337.1983732-13-djrscally@gmail.com>
 <20201218211732.GE4077@smile.fi.intel.com>
 <e2b4c35f-5020-c332-d97a-8ba25be0e55e@gmail.com>
 <CAHp75VcebKas4j-vByodicHxRMrO4jkaJToSUW3iLJC2+vY_iA@mail.gmail.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <e86fc26d-8c2f-c8a6-fc2e-ec612fd5d158@gmail.com>
Date:   Sat, 19 Dec 2020 23:48:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcebKas4j-vByodicHxRMrO4jkaJToSUW3iLJC2+vY_iA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 19/12/2020 18:52, Andy Shevchenko wrote:
> On Sat, Dec 19, 2020 at 2:25 AM Daniel Scally <djrscally@gmail.com> wrote:
>> On 18/12/2020 21:17, Andy Shevchenko wrote:
>>> On Thu, Dec 17, 2020 at 11:43:37PM +0000, Daniel Scally wrote:
> 
> ...
> 
>>>> +    sensor->ep_properties[0] = PROPERTY_ENTRY_U32(sensor->prop_names.bus_type, 4);
>>>
>>> Does 4 has any meaning that can be described by #define ?
>>
>> It's V4L2_FWNODE_BUS_TYPE_CSI2_DPHY:
>>
>> https://elixir.bootlin.com/linux/latest/source/drivers/media/v4l2-core/v4l2-fwnode.c#L36
>>
>> That enum's not in an accessible header, but I can define it in this
>> module's header
> 
> Maybe you can do a preparatory patch to make it visible to v4l2
> drivers? (Like moving to one of v4l2 headers)

Sure ok, guess media/v4l2-fwnode.h makes the most sense.

> ...
> 
>>>> +                    if (bridge->n_sensors >= CIO2_NUM_PORTS) {
>>>> +                            dev_warn(&cio2->dev, "Exceeded available CIO2 ports\n");
>>>
>>>> +                            /* overflow i so outer loop ceases */
>>>> +                            i = ARRAY_SIZE(cio2_supported_sensors);
>>>> +                            break;
>>>
>>> Why not to create a new label below and assign ret here with probably comment
>>> why it's not an error?
>>
>> Sure, I can do that, but since it wouldn't need any cleanup I could also
>> just return 0 here as Laurent suggest (but with a comment explaining why
>> that's ok as you say) - do you have a preference?
> 
> While it's a good suggestion it will bring a bit of inconsistency into
> approach. Everywhere else in the function you are using the goto
> approach.
> So yes, I have a preference.

No problem

>>>> +                    }
> 
> ...
> 
>>>> +                    ret = cio2_bridge_read_acpi_buffer(adev, "SSDB",
>>>> +                                                       &sensor->ssdb,
>>>> +                                                       sizeof(sensor->ssdb));
>>>> +                    if (ret < 0)
>>>
>>> if (ret) (because positive case can be returned just by next conditional).
>>
>> cio2_bridge_read_acpi_buffer() returns the buffer length on success at
>> the moment, but I can change it to return 0 and have this be if (ret)
> 
> Please correct this somehow, because the next failure returns it
> instead of error...

Ah! Good spot - thank you. I will fix that yes.

>>>> +                            goto err_put_adev;
>>>> +
>>>> +                    if (sensor->ssdb.lanes > 4) {
>>>> +                            dev_err(&adev->dev,
>>>> +                                    "Number of lanes in SSDB is invalid\n");
> 
> ...I'm even thinking that you have to assign ret here to something meaningful.

Yeah I agree, I will do this too.

>>>> +                            goto err_put_adev;
>>>> +                    }
> 

