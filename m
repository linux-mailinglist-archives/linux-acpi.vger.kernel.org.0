Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864402DFB40
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Dec 2020 11:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgLUKxg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Dec 2020 05:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgLUKxf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Dec 2020 05:53:35 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7142FC0613D6;
        Mon, 21 Dec 2020 02:52:55 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t16so10599064wra.3;
        Mon, 21 Dec 2020 02:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=UwwnMwR2kfUcWRxk8iTnFBRRH6uRfKSxOocUF3HIakM=;
        b=c0fXFtpGPZpKDXElftRtOWRuvSUR20VZQT52u9Z0QEqNgGXxMojaqvycQPlQiGjerM
         zVehpwzGRrMfJ5ofvCFCZIViVQ9EAaVgGxEad+7Bd7s8rJmDFitKPc4JT7zZ42A6wUVX
         DP4cqoc3PQ7s0x6DpZGC0JHKEKl+45etvo1zKaVYFshoO/iA/fWyDnIj6U/I5fvIv0TZ
         Q2M3UE+L83bx9Z0N6j8PKsgTWBFgEdAsWu6iD/6YRhHlfa9vnKuwXqide9HZxWAQkHG7
         IDAstFAqUp6Tdt/CkNQcVqKrkr2bf3PPctbu5VeAp/epyj0khTZgyYaGaszc/D/Y1aKF
         ufsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UwwnMwR2kfUcWRxk8iTnFBRRH6uRfKSxOocUF3HIakM=;
        b=QZs1nsdny8lBWh+C0wtwBc4TuWVUred1dbIlWoMpyCMH5up/3ikb5Xeurl2a/0B274
         tFPORM/OZNB/g6KXMneDPakdk+d5U6Q4h5f54XxHmuNMmIQfy8j3i81MfNv5tJcYVojx
         LLdJwVPP1m8x+jPDwQyowp6AD/aN0qZcnik5BQFpMn8ijTdXHBQdoLTYTWcOughcDO04
         DHm5DALm+4PcT+Ur7rZfkEQroBNCDVkYoXtq4k+/rqdYv6G3x4Otw9zUtUSj9G0KXozm
         HsSwDJpnl0RBOuLd0eQD8QROgJ3tIELd4PsyivlCrmCt2zcfcgdAPuZr9Q25DH1zlZGv
         GK/g==
X-Gm-Message-State: AOAM533d6xwUyM2nGjCb6ClN3AdRkwOM5+Wb9hAed+51/IeM7figfWl0
        G6AchxYiY1nv68VntLMKfxs=
X-Google-Smtp-Source: ABdhPJyDRD1hyEkZAhGiG6vgtYKzIOhhOFbhtoE0B0prFL8jZXxIwDDe6LhiOl1y+4R6z6DTsrtz8A==
X-Received: by 2002:a5d:4c49:: with SMTP id n9mr18203106wrt.30.1608547974186;
        Mon, 21 Dec 2020 02:52:54 -0800 (PST)
Received: from [192.168.1.211] ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id l5sm26600567wrv.44.2020.12.21.02.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 02:52:53 -0800 (PST)
Subject: Re: [PATCH v2 12/12] ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@acpica.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yong Zhi <yong.zhi@intel.com>,
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
 <e86fc26d-8c2f-c8a6-fc2e-ec612fd5d158@gmail.com>
 <20201221102147.GJ26370@paasikivi.fi.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <5ba6ada9-c8a6-fa66-b8d6-5769b7bcdfea@gmail.com>
Date:   Mon, 21 Dec 2020 10:52:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201221102147.GJ26370@paasikivi.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 21/12/2020 10:21, Sakari Ailus wrote:
> Hi Daniel, Andy,
>
> On Sat, Dec 19, 2020 at 11:48:51PM +0000, Daniel Scally wrote:
>> On 19/12/2020 18:52, Andy Shevchenko wrote:
>>> On Sat, Dec 19, 2020 at 2:25 AM Daniel Scally <djrscally@gmail.com> wrote:
>>>> On 18/12/2020 21:17, Andy Shevchenko wrote:
>>>>> On Thu, Dec 17, 2020 at 11:43:37PM +0000, Daniel Scally wrote:
>>> ...
>>>
>>>>>> +    sensor->ep_properties[0] = PROPERTY_ENTRY_U32(sensor->prop_names.bus_type, 4);
>>>>> Does 4 has any meaning that can be described by #define ?
>>>> It's V4L2_FWNODE_BUS_TYPE_CSI2_DPHY:
>>>>
>>>> https://elixir.bootlin.com/linux/latest/source/drivers/media/v4l2-core/v4l2-fwnode.c#L36
>>>>
>>>> That enum's not in an accessible header, but I can define it in this
>>>> module's header
>>> Maybe you can do a preparatory patch to make it visible to v4l2
>>> drivers? (Like moving to one of v4l2 headers)
>> Sure ok, guess media/v4l2-fwnode.h makes the most sense.
> Yes, please.
Done for the next version
>
>>> ...
>>>
>>>>>> +                    if (bridge->n_sensors >= CIO2_NUM_PORTS) {
>>>>>> +                            dev_warn(&cio2->dev, "Exceeded available CIO2 ports\n");
>>>>>> +                            /* overflow i so outer loop ceases */
>>>>>> +                            i = ARRAY_SIZE(cio2_supported_sensors);
>>>>>> +                            break;
>>>>> Why not to create a new label below and assign ret here with probably comment
>>>>> why it's not an error?
>>>> Sure, I can do that, but since it wouldn't need any cleanup I could also
>>>> just return 0 here as Laurent suggest (but with a comment explaining why
>>>> that's ok as you say) - do you have a preference?
>>> While it's a good suggestion it will bring a bit of inconsistency into
>>> approach. Everywhere else in the function you are using the goto
>>> approach.
>>> So yes, I have a preference.
>> No problem
> Laurent also commented on the return code.
>
> I might just handle this as an error. The earlier ports are fine, but
> there's also a problem with the data here. It'd be easier to spot that this
> way, and we can change this in the future if need be.


You mean just raise an error with dev_err()? Or fail the probe and
unwind the 4 sensors that were already connected successfully? I'm fine
with that if so - we have no in scope devices where that will be a
problem at the moment.

