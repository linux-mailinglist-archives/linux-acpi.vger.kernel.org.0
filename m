Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04522E9626
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 14:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbhADNij (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Jan 2021 08:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbhADNij (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jan 2021 08:38:39 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FFEC061794;
        Mon,  4 Jan 2021 05:37:59 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id x12so14539313plr.10;
        Mon, 04 Jan 2021 05:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K+CDCfA5PemkxKnAwCzf0wlF1tNUAK7fJ30n7xk8Eos=;
        b=uePTtjoOc2coYDV9deOOVYGQB1/AH7to+N/S8Auz8QnywvItZd80oilByCOCt5hAfX
         GDFLHWJJ31yNVUtaWWr/AgXo8eF7lHB3FC1fYYq+1+KDK94xFErDFEsD3osumFaDFgvY
         DBgouQfpvJx53TY8gEcbYSVQNuJYBi84xq6Pq24DGJwQajR42XUBllcL7WCegYVtCFQC
         krTYBh1U1Ci97Euk7MwAAr99JZvLyd20eDy/nIzaeAAdXth9Dp+k1mjmK+C153nlsJfM
         FVpyq0WPMMFlbrYWhyUz0yNnBJV3kwidCzC5kwBE0XhA5t73N7aW7W56OwgZFjBbGjAE
         4Rkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K+CDCfA5PemkxKnAwCzf0wlF1tNUAK7fJ30n7xk8Eos=;
        b=edvpOJUlZFs79MhZeeI8taAStxtCq4My4L0svW+cUY4F+Tu9CsbQOic4SQI8mFF3E/
         cNO2IKbdS97DfbibMa81S2dyZuwgdwBlFWJfM6IVbvjKwRfhhjdnJq+sna62aF1qxLy9
         4awZsuGqW1voDGJ0fLfqQIhbbAyh9qf1KngwhUn0n/bX4CiW5ZHSLHFiBhQodzYed9J/
         tj8s9A0X431Lzc8mbYsmxPwI3hyNy0MzLe8YDJoSnkaMF4d6UNY3ib4ao4UK0CAMsez7
         QA6zaJP8aH3TZ3ncHqhEZW67Vh6ewdQj703yH5c3hLReiFtkHcU5JoCwNlVjhNQhvJgW
         EtxQ==
X-Gm-Message-State: AOAM5329aP9iObJbE+X4WqJT9CxzFKEQNw585L4J9kUZ2qJ4a0/TTg3a
        ZeDjYur1vW7yQFwJsJsCWvH7cmm+++4p8TOQKuA=
X-Google-Smtp-Source: ABdhPJzgoMjcEAl2pjB/Fd0EbpHaPeU2biYFz0h4TI3h789ORYJfBqqtqhv5AkMXxAby+Zk+iI+bVoL9q6HazNOjsJw=
X-Received: by 2002:a17:90b:a17:: with SMTP id gg23mr30331114pjb.129.1609767478850;
 Mon, 04 Jan 2021 05:37:58 -0800 (PST)
MIME-Version: 1.0
References: <20210103231235.792999-1-djrscally@gmail.com> <20210103231235.792999-16-djrscally@gmail.com>
 <20210104120905.GR4077@smile.fi.intel.com> <2f64873d-0413-3614-34e2-139b4a4d9da6@gmail.com>
In-Reply-To: <2f64873d-0413-3614-34e2-139b4a4d9da6@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Jan 2021 15:38:47 +0200
Message-ID: <CAHp75VcU7DcRZD_eK+B1-CX7tVtsR5YLPdrA6oULk187xhApCw@mail.gmail.com>
Subject: Re: [PATCH v4 15/15] ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver
To:     Daniel Scally <djrscally@gmail.com>, Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@acpica.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Len Brown <lenb@kernel.org>, Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tian Shu Qiu <tian.shu.qiu@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 4, 2021 at 3:02 PM Daniel Scally <djrscally@gmail.com> wrote:
> On 04/01/2021 12:09, Andy Shevchenko wrote:
> > On Sun, Jan 03, 2021 at 11:12:35PM +0000, Daniel Scally wrote:

...

> >> +#define NODE_SENSOR(_HID, _PROPS)           \
> >> +    ((const struct software_node) {         \
> >> +            .name = _HID,                   \
> >> +            .properties = _PROPS,           \
> >> +    })
> >> +
> >> +#define NODE_PORT(_PORT, _SENSOR_NODE)              \
> >> +    ((const struct software_node) {         \
> >> +            .name = _PORT,                  \
> >> +            .parent = _SENSOR_NODE,         \
> >> +    })
> >> +
> >> +#define NODE_ENDPOINT(_EP, _PORT, _PROPS)   \
> >> +    ((const struct software_node) {         \
> >> +            .name = _EP,                    \
> >> +            .parent = _PORT,                \
> >> +            .properties = _PROPS,           \
> >> +    })
> > In all three I didn't get why you need outer parentheses. Without them it will
> > be well defined compound literal and should work as is.
> The code works fine, but checkpatch complains that macros with complex
> values should be enclosed in parentheses. I guess now that I'm more
> familiar with the code I'd call that a false-positive though, as nowhere
> else in the kernel that I've seen encloses them the same way.

I guess it is yet another false positive from checkpatch.
I would ignore its complaints.

-- 
With Best Regards,
Andy Shevchenko
