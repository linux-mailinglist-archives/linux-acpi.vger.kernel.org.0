Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FE42E8817
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Jan 2021 18:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbhABRNc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 2 Jan 2021 12:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbhABRNb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 2 Jan 2021 12:13:31 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D237C061573;
        Sat,  2 Jan 2021 09:12:51 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id 91so26745453wrj.7;
        Sat, 02 Jan 2021 09:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=y5jH9d3mdO81XtDuxyfUPY1UFIU5znarbecHqlhGczQ=;
        b=mjZVp6hZbYMv9W1gx7ozhlf+SugBbLntN7v80midD1IWeVRxOjuFqO4M+nuO6n8hTp
         6XDG8vmtC7a5rfJ2aUOZAM5u96eB3ic3pSj4N+w6gOkmg23exWKgK4kTyOD6GEQ3fHzu
         Gn7OonVsZP72LNGnwEm81H117ulbYc7lhRqFeQFb5F//VgDmhipbIsWaROMFqN7RleiF
         4W1J5bigkMI/NQi0eKvb6YqhpoptEE+8+HY+TK1RIamIOR3dqYOtAnGm1WWqCEyD+K47
         TAcBlXuY52EE1tsYi6HNo9sdomtyid9idr4gP5bwuczYBpXGPGaXWDFt71mz7zfoi+yk
         QYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=y5jH9d3mdO81XtDuxyfUPY1UFIU5znarbecHqlhGczQ=;
        b=ev+NObkvMWBuUV70uIJMFZh32k4CdjgDlUG8Q06jcGV405LE4PlzbhUDUwmhkBCB00
         +H7jSKhRiy/PoPLxaCzzXJz5p5IzZN1MRs7nnIa3+uWIoeMi0SYA/3nMsbY3i9Nu6OTk
         vOnYEQigLuv+/iPF4jsGcflna9EGx/ghLjH3SDtojSj9Obs0cLbUMdy6T4oBpxRBOkRJ
         QM6miP5keONBI6G2YbxOtguxkH3bjA3dQMnfDJORJVrCfgF7jHyoolBrkkBu9Mo1fsHo
         JJbST9tI0bkTN9Tdl2xoKMpTg7sBE6WXkr5DnMg321+pUluyCLZJBvWbPhndczhss5vG
         zh0g==
X-Gm-Message-State: AOAM531TqxV1Lat7eEEsKf2t5ihCCGTpbfZohNK/vac0utcntlIuABl4
        CEqZ1uiUy2CI3mPH1dGIpYA=
X-Google-Smtp-Source: ABdhPJy9rROhgUUjUnk6hAJOgUyxMKwRrQCjmHodD3/8bZVpmDxS6GvBtIu64TWtc81hVo/ggfC1+Q==
X-Received: by 2002:adf:e98b:: with SMTP id h11mr72049927wrm.21.1609607569935;
        Sat, 02 Jan 2021 09:12:49 -0800 (PST)
Received: from [192.168.1.211] ([2.29.208.120])
        by smtp.gmail.com with ESMTPSA id z22sm23163411wml.1.2021.01.02.09.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Jan 2021 09:12:49 -0800 (PST)
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
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <f0d6751d-b395-49f4-2411-0ed13e4dabc0@gmail.com>
Date:   Sat, 2 Jan 2021 17:12:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210102170731.GD11878@paasikivi.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Sakari

On 02/01/2021 17:07, Sakari Ailus wrote:
> Hi Daniel,
>
> On Mon, Dec 28, 2020 at 10:37:38PM +0000, Daniel Scally wrote:
>>>>> +#define CIO2_NUM_PORTS                         4
>>> This is already defined in ipu3-cio2.h. Could you include that instead?
>> Yes; but I'd need to also include media/v4l2-device.h and
>> media/videobuf2-dma-sg.h (they're included in ipu3-cio2-main.c at the
>> moment). It didn't seem worth it; but I can move those two includes from
>> the .c to the .h and then include ipu3-cio2.h in cio2-bridge.h
>>
>> Which do you prefer?
> Seems you got answers already... :-) splitting the header in two seems good
> to me. But IMO it doesn't have to be a part of this set.
>
Yeah I've been hesitating over this; if we chose not to do it in this
set though, how would you want me to deal with the double definition of
CIO2_NUM_PORTS
