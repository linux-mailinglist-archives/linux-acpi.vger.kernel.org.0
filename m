Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAD92E96ED
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 15:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbhADOMd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Jan 2021 09:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbhADOMd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jan 2021 09:12:33 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A94C061793;
        Mon,  4 Jan 2021 06:11:53 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id lb18so10140222pjb.5;
        Mon, 04 Jan 2021 06:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EUUxZnLp9iwqwD5hGCnTbWs9va3dDEmsYPYTCboDkgM=;
        b=X8aqmXMB5tiHFzrniLVTktDAFx9GPxoKYC/VERRRccElLhRt5O3imXB3TuJseco+VB
         6+IOagth86OcC79TdClqwAmmMuGeNj8/ODoiV94dlOOheowFAPPguDf7eM3Kbnum/qEd
         FsLcu6pedYoofU9BK0ErFQgL7AnvPpDreqrzLCid0zT+0YFgRYRYI9qnR1OnXWeDDU4a
         rq5h0PmyevPSwS38mhjy5/qei5hp8DMW5F2siQQNiPt3X99wAGlAxe2yHINXJaY2XdaX
         s+y0Jw8fJJQZHc6T7MgeJ+CNNyPReKkcZT+mgQAUtqpGNd/l9vI1rRpwptE9A7xhZEq1
         nm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EUUxZnLp9iwqwD5hGCnTbWs9va3dDEmsYPYTCboDkgM=;
        b=UXFKLdMEf+im46prrMZvTz65vHcH5h47NmAfEqRh47I/KWWkJLMM+vnbRaeI+9MebV
         hDTc8sk5rizAS8ffvvnJy77M8Ud2kggDfc86GKAVIQS5AqMedwyMXZff47UU66Kkhg5b
         yx7dgp6/YtVyw7w4qtOKpWxk3d5xsIQU9zuC2OeR5z+gMBkqKIwPj0MHm+Wl7EN5/SgL
         FYmXpfHMS7TQ/T6zyzgLgwqAaRCAW8wVInmhyhHhmCgfq0j19UuLY2sETkx/Dahig+pT
         WLF4YagqaJcg2dH4HAQ/xEYPZBlgQtwtmJadZw26Nc1V7mE8XVkziBwzK/63TY6lOIoS
         D+LA==
X-Gm-Message-State: AOAM5328TQVYq8KU7oy9MA58UEqezHNpxLVum8kci0M3i6w/PIZW5PjB
        7DbF8M3/njjEkDqL1PDtZJhq2eY5aJSxqPj+yzxXGTO+m40=
X-Google-Smtp-Source: ABdhPJz6ehqJDINMSa6fja9yTp967LimGY8Equ3PqbXvrPklGwWlCUj94mtpfF0BG/sS7aRFOYJzqN3YqyiM9CLOAFA=
X-Received: by 2002:a17:90b:a17:: with SMTP id gg23mr30462729pjb.129.1609769512562;
 Mon, 04 Jan 2021 06:11:52 -0800 (PST)
MIME-Version: 1.0
References: <20210103231235.792999-1-djrscally@gmail.com> <20210103231235.792999-16-djrscally@gmail.com>
 <3d881e2b-747f-dcd7-a0cf-e7309419914b@ideasonboard.com> <9026519f-1f33-9df0-de18-0881069f7aaa@gmail.com>
In-Reply-To: <9026519f-1f33-9df0-de18-0881069f7aaa@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Jan 2021 16:12:41 +0200
Message-ID: <CAHp75Vf6Z_qhw54jUu5tt85XxjZncaQFCNpYx=tqGTS9LsVPOg@mail.gmail.com>
Subject: Re: [PATCH v4 15/15] ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver
To:     Daniel Scally <djrscally@gmail.com>
Cc:     kieran.bingham+renesas@ideasonboard.com,
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
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
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

On Mon, Jan 4, 2021 at 3:55 PM Daniel Scally <djrscally@gmail.com> wrote:
> On 04/01/2021 13:35, Kieran Bingham wrote:

...

> +static const struct cio2_sensor_config cio2_supported_sensors[] = {
> +       /* Sensor OVTI5693 */
> +       CIO2_SENSOR_CONFIG("INT33BE", 0),
> +       /* Sensor OVTI2680 */
> +       CIO2_SENSOR_CONFIG("OVTI2680", 0),
>
> As an inline comment won't fit for the sensors that we know link-frequencies for. That sound ok?

At least to me it looks okay.

It seems for v5 we need Rafael's blessing on a few patches (driver
properties / swnode / ACPI) and we are fine.

-- 
With Best Regards,
Andy Shevchenko
