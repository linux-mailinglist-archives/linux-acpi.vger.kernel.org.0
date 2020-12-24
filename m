Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DADE2E270F
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Dec 2020 14:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgLXNEQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Dec 2020 08:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbgLXNEP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2020 08:04:15 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F74C061794;
        Thu, 24 Dec 2020 05:03:35 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id t6so1286401plq.1;
        Thu, 24 Dec 2020 05:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nf+OEToUyzUSgpyKbUm/RZLj11+XPWI/mRkR/bcpjVo=;
        b=Z5Iy/gBp8Ct2o3+1AM0s8Qa53xfZtLHRkd8IXVRnZBYBmtN4cWhjWHBZPpSbLGkreA
         /ZWRo7u/GbkoL+5mwALiXb6gHjnmuMKVfKbbLOhfQah76L7oNoptg/ey16sbeCWUbJIb
         9t1WsG4qZSaZu56Xtl2JrDbkucHz1PlDi7zi1ALmfeJ2VdIbOhtc96Ca7ne7GFYMl9fB
         3i3REG8sSAVcdbdqj7N3YDULgfMFa+er3kKY+6xbKOd+HaKlFeVTBrVpQlDid6FgsmWG
         cqfQ2ftaUEE8geAa6puJ/OzFdwXiJKZf10uOus8oTvT2Hth3sFj/ZFE6pGzcK1K9mhcd
         QZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nf+OEToUyzUSgpyKbUm/RZLj11+XPWI/mRkR/bcpjVo=;
        b=Cnrkv472B1ng6A3Hvn0315saG9r71zJPn/JB5hJGOVbZFDw7WBt38LS5ent3mWSmQV
         6iUwF6Ns2wlgfhQb5fOWK7QX11MF7Jnnk6erh/+0EkSR8U5MUq+wy26ukI0PTkTvXHaS
         gE/KfCdaSjABHwHDAK3GzcfwIB4fRUpKAmyUyMzd2C5hAB7gwaO2jE14jCxGp7rA8ShI
         MqEi9BrBL4j7wFUsoqlYFUlcGfKilxzcF5vjWpTzPCB9WxuYwdwqxgFnLFsdGF+uBkLE
         cKwp3zIpEZaJhC7cFp1OpN9FWoARjBW3yKbG5/hmiljmMd2qLnVq6FDrokl/JPWDksbq
         kW3Q==
X-Gm-Message-State: AOAM533PxKpA5I5YC64j4GDV+nm75pUNcEoAS/T45ReEokdU/tyUKXfl
        d1eM5WmELC5lAuyiF7k/Qw81odoiUfhTeXBGgCA=
X-Google-Smtp-Source: ABdhPJx5pBslTFPiLxoZaSAOkeL0cxRUKvfR/rfmO3tgSDj1sZBpEnT+V5ZccptPEN/tQTIfkoBtoTq5w3ZlBGHwl3U=
X-Received: by 2002:a17:90a:c592:: with SMTP id l18mr4371312pjt.228.1608815015034;
 Thu, 24 Dec 2020 05:03:35 -0800 (PST)
MIME-Version: 1.0
References: <20201224010907.263125-1-djrscally@gmail.com> <20201224010907.263125-8-djrscally@gmail.com>
 <CAHp75Vft7gg1AcKCEU+E74eB_ZMouHFd-8uZ7pcVj5CoJzZpvQ@mail.gmail.com> <X+SPsks5itN9OFqB@pendragon.ideasonboard.com>
In-Reply-To: <X+SPsks5itN9OFqB@pendragon.ideasonboard.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 24 Dec 2020 15:03:18 +0200
Message-ID: <CAHp75Ve6YHm-tdqFPvOhfJiT=uRK_dpKY3mnhQd6Mg3KkSuKqA@mail.gmail.com>
Subject: Re: [PATCH v3 07/14] software_node: Add support for fwnode_graph*()
 family of functions
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
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
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 24, 2020 at 2:55 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Thu, Dec 24, 2020 at 02:24:12PM +0200, Andy Shevchenko wrote:
> > On Thu, Dec 24, 2020 at 3:14 AM Daniel Scally wrote:

...

> > > +               if (!strncmp(to_swnode(port)->node->name, "port@",
> >
> > You may use here corresponding _FMT macro.
> >
> > > +                            FWNODE_GRAPH_PORT_NAME_PREFIX_LEN))
> > > +                       return port;

...

> > > +       /* Ports have naming style "port@n", we need to select the n */
> >
> > > +       ret = kstrtou32(swnode->parent->node->name + FWNODE_GRAPH_PORT_NAME_PREFIX_LEN,
> >
> > Maybe a temporary variable?
> >
> >   unsigned int prefix_len = FWNODE_GRAPH_PORT_NAME_PREFIX_LEN;
> >   ...
> >   ret = kstrtou32(swnode->parent->node->name + prefix_len,
>
> Honestly I'm wondering if those macros don't hinder readability. I'd
> rather write
>
>         + strlen("port@")

Works for me, since the compiler optimizes this away to be a plain constant.

> and let the compiler optimize this to a compile-time constant.
>
> > > +                       10, &endpoint->port);
> > > +       if (ret)
> > > +               return ret;


-- 
With Best Regards,
Andy Shevchenko
