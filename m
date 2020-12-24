Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8772D2E2791
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Dec 2020 15:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgLXONS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Dec 2020 09:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgLXONR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2020 09:13:17 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1FCC061794;
        Thu, 24 Dec 2020 06:12:37 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id b5so1239158pjl.0;
        Thu, 24 Dec 2020 06:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SyPbtlk9TvZ8wXRc8WjmzSpmQJoyLh7+BtUnWFRUKOY=;
        b=Vv2Jg/rS+lyAVr9MqO3QquOplXTJE9iaeVSbUISyBQrx29Nk1tkF6q5D3r+WDG8vjg
         9FxmYx405/I97A8UVartQUnPETdQwiTCKYvIh24PLTWfcaFLGssnDt6tumHRLal0hskY
         myzItrP2leShibgY5N7Ebte7LM+rOf8YmclPEVSqgcyLurAqn2aINtFSbrrWqphjKSya
         WYStg7PkOmpP1clUIgvTPjXeQ0Yt61Ib82ihwMiA8PcGqHnsZbIczK1Edwni6qzKjG0W
         Say17Xh1AysuN/55mVAHC4XMuq0Z4EYGT6hxGbiBZuxzc6PuJLJ2tufoPs4HlCgyU/2e
         Avgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SyPbtlk9TvZ8wXRc8WjmzSpmQJoyLh7+BtUnWFRUKOY=;
        b=KO5LwyaFjpUOqhuk0DkZ3GRh6gnuh8rycIvQHwWOHyDTkB9EYdVch1YzKiPNDRQNIF
         pM47jd0IO1VPii/XC0D2mZNStSJjot9YV/1HabjhpWXSRzcDM3KCDa/SYv3VHAP6fTTA
         GUCASbl255gB7LYz/eAquAE2bedI4s+i6HCP2D5bhnfveHzoHkYYIvLfHAmg70YX1wuL
         fjc5C3NBsqWqJeEyCXWS6h4MC3sM5YNAp0edmV/B9aK4/Ye//ib9+eSBankF+4HcQst0
         3imlLCphttReoo1/HeyL6znlFph3Sao/f1U2sdB6Afrsow96saH+x3EE9BcE0Zk8EOSe
         rJGw==
X-Gm-Message-State: AOAM533xAHw38HI9MrjZXk6GF98f+g3b/orNqGyN8Fn+j2idTg/+gxDg
        M9vdS48Ug1/ZvsPLZ5u2zx/W/Ss6EE2dPhOx0Vc=
X-Google-Smtp-Source: ABdhPJx4kU2kgiBhzVnrEN4w5jn8fz4Uh0jF+A7nHQah1fR613EyonYvxy52LCufMdVu+K4/MKNj9N0tSoQEuzzOI1Q=
X-Received: by 2002:a17:90a:c592:: with SMTP id l18mr4636764pjt.228.1608819157024;
 Thu, 24 Dec 2020 06:12:37 -0800 (PST)
MIME-Version: 1.0
References: <20201224010907.263125-1-djrscally@gmail.com> <20201224010907.263125-6-djrscally@gmail.com>
 <CAHp75VdF5NdjrSxcOafh7KNNDteYEUDk9otA0HKX-iks7G0D4g@mail.gmail.com> <de478ef0-0b4d-df1d-2651-9cc35bf2f45b@gmail.com>
In-Reply-To: <de478ef0-0b4d-df1d-2651-9cc35bf2f45b@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 24 Dec 2020 16:12:20 +0200
Message-ID: <CAHp75VdWuowLenNPQRNc+QXeyuvwKqh_bjw=1WvmFrzoygXFRw@mail.gmail.com>
Subject: Re: [PATCH v3 05/14] software_node: unregister software_nodes in
 reverse order
To:     Daniel Scally <djrscally@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Linus Walleij <linus.walleij@linaro.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 24, 2020 at 4:00 PM Daniel Scally <djrscally@gmail.com> wrote:
> On 24/12/2020 12:13, Andy Shevchenko wrote:
> > On Thu, Dec 24, 2020 at 3:12 AM Daniel Scally <djrscally@gmail.com> wrote:

...

> >> + * Unregister multiple software nodes at once. The array will be unwound in
> >> + * reverse order (i.e. last entry first) and thus if any member of the array
> >> + * has its .parent member set then they should appear later in the array such
> >> + * that they are unregistered first.
> >
> > I'm, as being not a native speaker, a bit confused by this comment.
> > The idea is that children are unregistered first. Can you try to make
> > it more clear maybe?
>
> Sure, how about:
>
> The array will be unwound in reverse order (i.e. last entry first). If
> any member of the array is a child of another member then the child must

children ?

> appear later in the array than their parent, so that they are
> unregistered first.

I think with the above change it will be better, yes.

-- 
With Best Regards,
Andy Shevchenko
