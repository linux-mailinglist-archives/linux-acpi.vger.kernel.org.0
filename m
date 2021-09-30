Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15FC41E267
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Sep 2021 21:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347411AbhI3TvE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 Sep 2021 15:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347300AbhI3TvA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Sep 2021 15:51:00 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E08C06176D
        for <linux-acpi@vger.kernel.org>; Thu, 30 Sep 2021 12:49:15 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id z5so15832086ybj.2
        for <linux-acpi@vger.kernel.org>; Thu, 30 Sep 2021 12:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qzu64fXHTiIcfDbo11y5nmqEplOgcWDPv9SREtrsAds=;
        b=Bb62IHSQDymweZCjp9xCrijJ4lA8x9M279DwXdVGqH/5uAqnookw/HiEaQlaS5zWqU
         9KGcmVWArgai7IWvkHgaVbOJP6ugo6RiOI7h5W4m66/auYzQMFZBfhqxotRbpU8kiRzS
         PZpSxywFF1bA4enUzOcab2PVSVcafmV3BKdv/+cJCvBaH6GBJzbxROInp0b6E7+hWhz9
         Ul0ZNkN01tBQkGdA9zJk9MLl8igAvDL+GZQi+qXIz5RzsiXi6c05uExo/xXTfJCOTaNW
         BP6luiLNrOScu1xZBasjy9zw4hyUtdM+E14rR5GhzRfXe7+i8ZwqAw15pTxYAg6uKmaP
         BawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qzu64fXHTiIcfDbo11y5nmqEplOgcWDPv9SREtrsAds=;
        b=O+/ht+ypztlNNUMOowqdhwj60vmeclZjUuZPkd/YqRlneWN/T2COF0SvbnhJ0gh21u
         RvL1IQcmkUi30dzYR8bgfZ4oYhkEnffEv06abrGPPGFR8wM6YPg7TLhCz46M3wdx+931
         TShvnBRRU6fk6KeIvA5Jz22ZlxXJjMyxuLHnVQFn28m9xzBfFrur4T+N55kkQIM/7fJ7
         8LbwtZK5SQ+p8kmyNsR3pERdiIg34KVw/XWNd8EmxcV3YdUABAFmfzXrZLfeB7Lm/k82
         EPGkrdp3D3ed5FKxLi84z6lKzGUBPg17Sy6dmpmVIc4GDESW6iZmy8eZCP1XLNOmPiEM
         jVCw==
X-Gm-Message-State: AOAM530dhxvIRSl2X/VJIzvmcMey5bTD0tqIs3N5HnYXzWfWYMg9qOZp
        1c09d1rOXTq/RP7TqRnj3WmkdVLHKOW40c871gGl+g==
X-Google-Smtp-Source: ABdhPJy+W7Tlus6n8v/jVtsLypB52CV1qGme2IbGkCZFgbZ1vtZMJQTdf96zuBomuacwcNbKiYAd8eQ34FMvbgF1v1g=
X-Received: by 2002:a25:db91:: with SMTP id g139mr1183581ybf.391.1633031354608;
 Thu, 30 Sep 2021 12:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <YS4rw7NQcpRmkO/K@lunn.ch> <CAGETcx_QPh=ppHzBdM2_TYZz3o+O7Ab9-JSY52Yz1--iLnykxA@mail.gmail.com>
 <YS6nxLp5TYCK+mJP@lunn.ch> <CAGETcx90dOkw+Yp5ZRNqQq2Ny_ToOKvGJNpvyRohaRQi=SQxhw@mail.gmail.com>
 <YS608fdIhH4+qJsn@lunn.ch> <20210831231804.zozyenear45ljemd@skbuf>
 <CAGETcx8MXzFhhxom3u2MXw8XA-uUtm9XGEbYNobfr+Ptq5+fVQ@mail.gmail.com>
 <20210930134343.ztq3hgianm34dvqb@skbuf> <YVXDAQc6RMvDjjFu@lunn.ch>
 <CAGETcx8emDg1rojU=_rrQJ3ezpx=wTukFdbBV-uXiu1EQ87=wQ@mail.gmail.com> <YVYSMMMkmHQn6n2+@lunn.ch>
In-Reply-To: <YVYSMMMkmHQn6n2+@lunn.ch>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 30 Sep 2021 12:48:38 -0700
Message-ID: <CAGETcx-L7zhfd72+aRmapb=nAbbFGR5NX0aFK-V9K1WT4ubohA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] driver core: fw_devlink: Add support for FWNODE_FLAG_BROKEN_PARENT
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>,
        Alvin Sipraga <ALSI@bang-olufsen.dk>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 30, 2021 at 12:38 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Btw, do we have non-DSA networking devices where fw_devlink=on
> > delaying PHY probes is causing an issue?
>
> I don't know if issues have been reported, but the realtek driver has
> had problems in the past when the generic driver is used. Take a look
> at r8169_mdio_register(), it does something similar to DSA.

Does it have the issue of having the PHY as its child too and then
depending on it to bind to a driver? I can't tell because I didn't
know how to find that info for a PCI device.

>
> What is going to make things interesting is that phy_attach_direct()
> is called in two different contexts. During the MAC drivers probe, it
> is O.K. to return EPROBE_DEFER, and let the MAC driver try again
> later, if we know there is a specific PHY driver for it. But when
> called during the MAC drivers open() op, -EPROBE_DEFER is not
> allowed. What to do then is an interesting question.

Yeah, basically before doing an open() it'll have to call an API to
say "just bind with whatever you got". Or something along those lines.
I already know how to get that to work. I'll send some RFC soonish (I
hope).

-Saravana
