Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C29B2E88AB
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Jan 2021 22:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbhABVYQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 2 Jan 2021 16:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbhABVYP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 2 Jan 2021 16:24:15 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18183C061573;
        Sat,  2 Jan 2021 13:23:35 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id c5so27108186wrp.6;
        Sat, 02 Jan 2021 13:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6ghFTfIjxEctDxptPNvtSJH4UOPjMWmlT+kIsBap1jw=;
        b=pSZvvzezr1d8rXA0x5oYG7501vDkYBOcmRlDDOqbgcZR7FMQQjJKmoAo9TExDMpeaF
         BZ1x4WIXOeQV2F0TiJrs8N0CD1QQBs0RofJmaa9fSZpu8CAfYEPQmg8bVRt5x40dpBIz
         EevQ2h3MWvAmpuZuBrsVHRaWMk7AdscxPZSfyMSVZBR7JEmpYJiAfs9y0d9v3Ttky7gA
         465o1BRB6Nr1Ofx0PC/NXoPJltq3b3pgkjRTuTSK02U0wIV3TvcVqQMlOmtAG+pfP0PS
         dU9FhY8y8qOTi9Ln+YMdgF6t/TDNaUQCy5Hk05mLrqQKtIJii5burr+15LOVzps6A+5J
         cPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6ghFTfIjxEctDxptPNvtSJH4UOPjMWmlT+kIsBap1jw=;
        b=fjNCf22AAZ7PglBljVRd5aOFmuktgAtw0ohy3y5u8H/Wjc9Gj10vuV8zpFdDRNLtjx
         QOBaRsnEaJsMLYhVgPaIlq/ZmuntRldE6PYyakAsUMuSTb1j5EuQ3MXKI1Ago/NadIpt
         uNthJjeYwceHpv7RPGaj2AK49RCA5NayaS9ZfX7iqEob1aYTP6k1VzSOh8tz7R5oUuZ4
         0uJkT+x5/bLbfFUTUWUSvzNmLKc9RS1SjKQGFbfEQLv6N3RywOEqNrcBtIEGn3Sj/ITL
         DOo0zPTXvO4uvT+hhfV8trKOqnIPTdUNQs2he51x5Y8j2foxqHsfNSYzAOn0dXRNtq03
         ASCQ==
X-Gm-Message-State: AOAM5311XKfs3a3/xlDqfYQlnoR3H8iNDtRZ4ZPW5xomdSPJsaHs/1iv
        aVMRB4bI8QXD0zUX89aSOyM=
X-Google-Smtp-Source: ABdhPJzfSvV8/SEMVa7AzTOpKW/ysf0hDNuKeGBVNyAymeQZ+kD+ilHVRlPjrsXEP/S2OiCXBAzyVg==
X-Received: by 2002:adf:fd0c:: with SMTP id e12mr73510737wrr.61.1609622613430;
        Sat, 02 Jan 2021 13:23:33 -0800 (PST)
Received: from [192.168.1.211] ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id s13sm65498900wra.53.2021.01.02.13.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Jan 2021 13:23:32 -0800 (PST)
Subject: Re: [PATCH v3 14/14] ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
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
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        kieran.bingham+renesas@ideasonboard.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        niklas.soderlund+renesas@ragnatech.se,
        Steve Longerbeam <slongerbeam@gmail.com>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jordan Hand <jorhand@linux.microsoft.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20201224010907.263125-1-djrscally@gmail.com>
 <20201224010907.263125-15-djrscally@gmail.com>
 <CAHp75VeXN6PnV7Mzz6UMpD+m-yjPi6XK0kx1=+-M5mci=Vb=YQ@mail.gmail.com>
 <20201228170521.GZ26370@paasikivi.fi.intel.com>
 <2d37df3d-f04c-6679-6e27-6c7f82e9b158@gmail.com>
 <20210102170731.GD11878@paasikivi.fi.intel.com>
 <f0d6751d-b395-49f4-2411-0ed13e4dabc0@gmail.com>
 <20210102172414.GF11878@paasikivi.fi.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <8b999653-0cbc-b85e-6f95-729ecd66f622@gmail.com>
Date:   Sat, 2 Jan 2021 21:23:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210102172414.GF11878@paasikivi.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Sakari

On 02/01/2021 17:24, Sakari Ailus wrote:
> On Sat, Jan 02, 2021 at 05:12:47PM +0000, Daniel Scally wrote:
>> Hi Sakari
>>
>> On 02/01/2021 17:07, Sakari Ailus wrote:
>>> Hi Daniel,
>>>
>>> On Mon, Dec 28, 2020 at 10:37:38PM +0000, Daniel Scally wrote:
>>>>>>> +#define CIO2_NUM_PORTS                         4
>>>>> This is already defined in ipu3-cio2.h. Could you include that instead?
>>>> Yes; but I'd need to also include media/v4l2-device.h and
>>>> media/videobuf2-dma-sg.h (they're included in ipu3-cio2-main.c at the
>>>> moment). It didn't seem worth it; but I can move those two includes from
>>>> the .c to the .h and then include ipu3-cio2.h in cio2-bridge.h
>>>>
>>>> Which do you prefer?
>>> Seems you got answers already... :-) splitting the header in two seems good
>>> to me. But IMO it doesn't have to be a part of this set.
>>>
>> Yeah I've been hesitating over this; if we chose not to do it in this
>> set though, how would you want me to deal with the double definition of
>> CIO2_NUM_PORTS
> The patch is here:
>
> <URL:https://patchwork.linuxtv.org/project/linux-media/patch/20201230204405.62892-1-andriy.shevchenko@linux.intel.com/>
>
> I guess Andy forgot to cc you.
>
Ah - thanks, I'd not read back through the list yet. I'll look at this
tonight then.
