Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E697D2E6C89
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Dec 2020 00:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbgL1Xbl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Dec 2020 18:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729604AbgL1Xbk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Dec 2020 18:31:40 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CAEC0613D6;
        Mon, 28 Dec 2020 15:31:00 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c133so691667wme.4;
        Mon, 28 Dec 2020 15:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Rbm54XmbViPVWteCI0YRZVtATFNPo3mryVFGn+rPYY8=;
        b=FJb/J+fKQNhptQMF7RjyIpHxRczlo2IJpFroQfmNSrV6nrLDxMxzPj9vacnt+Zau4a
         htTiiJQsuB+wFKcphIb6FejRWc4XdQChpl6z2wF+EAhqQfLS08AJXCpqAxIKQQEiO8AR
         mA0j34K0uOQA4eyDJUR0H9HVrL9mNYA5v5aqrnvyddThTkiblMvzNIqASfx5oOq24GYV
         ZdW7+KeKyAh0/ssHd4vMFi+qLdg0Nr3PLJUZFhTpu5Yyz85PekOmvtfJ++O3KboDm9xp
         bvzn4LWyynFpcccOAFPmsrsraNmEpEDgcEIzhwWSn4h5fxfGEBKXOCZuQygbYe8R9mnM
         7ygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Rbm54XmbViPVWteCI0YRZVtATFNPo3mryVFGn+rPYY8=;
        b=aQ782764Qzs3pJUBA9FwTO+AHqpZ/H+Xu6i+DKB4tQbeMlnn7mjMHCzrbjUnq1fu+8
         xjhWYQ1WsyLyHuhtq/Jgzg64Ny2/PY37JY8mX/dbolEe6OoGXLBAsYf8dxq3Ekloc+bF
         rFSX6JilR9ugeXLnamMIkOGGqXvQrVWwYZEvhZeQERYQxPhUmR4JlG+hp+XFiIRPU7c1
         YCnH5yDHgpbdOZizYZDrKp6N5OJKxf7f6u9m7ONsg+Xbe+RFcsAMZvynW2erRMiRxhBq
         zV39VMsZxX/qwMir4EY0CfpHZdhPnSKWN8Pdej3HGKXSKKvilmj7PgfGaxNvSRsCdrGR
         OTNw==
X-Gm-Message-State: AOAM533B5gN/XJor4LAWD1kBvWUAevV4Djs18xHjtPbh034Ibt8XWgFy
        dHCr+XPjmOQRFuQB39VYHHQ=
X-Google-Smtp-Source: ABdhPJypYG54wTWAhSIwDzfD/aMq2IZjStR080fOAxRXLxI77o0FG29owuJ5LzcJ88BNzydu67Xe4w==
X-Received: by 2002:a7b:cd90:: with SMTP id y16mr955907wmj.115.1609198258919;
        Mon, 28 Dec 2020 15:30:58 -0800 (PST)
Received: from [192.168.1.211] ([2.31.224.116])
        by smtp.gmail.com with ESMTPSA id h16sm990254wmb.41.2020.12.28.15.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Dec 2020 15:30:58 -0800 (PST)
Subject: Re: [PATCH v3 14/14] ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
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
 <20201228225544.GH4077@smile.fi.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <1b6ffc66-d16e-8ab4-64c8-b92bfac557f0@gmail.com>
Date:   Mon, 28 Dec 2020 23:30:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201228225544.GH4077@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy

On 28/12/2020 22:55, Andy Shevchenko wrote:
> On Mon, Dec 28, 2020 at 10:37:38PM +0000, Daniel Scally wrote:
>> On 28/12/2020 17:05, Sakari Ailus wrote:
>>> On Thu, Dec 24, 2020 at 02:54:44PM +0200, Andy Shevchenko wrote:
> ...
>
>>>>> +#include <linux/property.h>
>>>>> +
>>>>> +#define CIO2_HID                               "INT343E"
>>>>> +#define CIO2_NUM_PORTS                         4
>>> This is already defined in ipu3-cio2.h. Could you include that instead?
>> Yes; but I'd need to also include media/v4l2-device.h and
>> media/videobuf2-dma-sg.h (they're included in ipu3-cio2-main.c at the
>> moment). It didn't seem worth it; but I can move those two includes from
>> the .c to the .h and then include ipu3-cio2.h in cio2-bridge.h
>>
>> Which do you prefer?
> Actually ipu3-cio2.h misses a lot of inclusions (like mutex.h which I
> immediately noticed when scrolled over data types). I think here should be a
> compromise variant, split out something like ipu3-cio2-defs.h which can be
> included in both ipu3-cio2.h and cio2-bridge.h.


And just including all the things that need to be in both files you mean?

>
> And cio2-bridge.h needs more inclusions like types.h.


Added this in there too

