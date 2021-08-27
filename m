Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091853FA132
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Aug 2021 23:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhH0Ve3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 27 Aug 2021 17:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbhH0Ve2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Aug 2021 17:34:28 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C3CC0613D9
        for <linux-acpi@vger.kernel.org>; Fri, 27 Aug 2021 14:33:39 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id x140so15169920ybe.0
        for <linux-acpi@vger.kernel.org>; Fri, 27 Aug 2021 14:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RZNyHeDVs2mzNxDgTuglWtbJQudBi+AgMRN4SZ0C/nY=;
        b=jVqEIc455Wtcw8ODTyXfnO/FQsEQDMK/It9z9OeJqHqx8p3YH0rnsTE3JppBBQ71ic
         hFAjlj8BEwrMpHu5dY26GEJrq9XNElRyt2SaSTsQQPeNiGInacBfUIwM47yAwiv52Cx6
         cb5GcXIKp71l+SHcuTn0XmplTlgeszW/UdUC5gCMt1xJKxkcd9fGDlAao5HTZ6N1Xrka
         x1jACeUhmZYPrTZV4Sdl2PwtBWU2wCwz958GvC5DQjFa8/08MAVUxdRtI1csFaIvGlK+
         lC13HteG3Oka7xoTpaaAHoKgIUm8l7vHSWN0P6G5nVDvLsPsESrPFwGNXA+XnpKiANxH
         gLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RZNyHeDVs2mzNxDgTuglWtbJQudBi+AgMRN4SZ0C/nY=;
        b=gra59yDsgDalBk5+1MgjQQT8rlayfyBR+rgZusgvJUTlPP1WrOsFj4WhGjdZr+9aW2
         9Okh+iPG5inKPTF6h9zBll8wXA3OzW8aMmFNAqMQNTxTx3f5UtaJ2vjvFad1BzazSBsg
         KQmd9IkD4ZZe6yGok9KtoA9bboGhwaRv2QKXLHxZqUIao+g26WsMjgfFNqryaT74itu+
         s5JVpnqxhzqfez/rZQrPjayA/gcmbZE31HA469J0JjhBlSuThMLBL8p5IqCX0NSP3yUS
         682WhxtuCc0fJsoUU5YVTt8Q11UYDrf7fCu4b8rMWSi1uzSGfvoEQADdtnS+ZpUuWdyS
         Q/mQ==
X-Gm-Message-State: AOAM532Yn+XHTjGEmOK9mOtVsAClXaIk8SqWvLOltYcLv8ZgB28AnZRj
        1WjHi9haHCgpw6JlIE1Je9+YwXgP5aTnRXzShVDNaA==
X-Google-Smtp-Source: ABdhPJz5+dNvgc2ixHXOwcDeo8jDfMW8Ql6QvMwMVQ6iLfDyfXrrjgP9Mg+KHQk+aYDhygWXhbGhxIhyAShRq9e5qmw=
X-Received: by 2002:a25:d2c8:: with SMTP id j191mr8213434ybg.412.1630100018502;
 Fri, 27 Aug 2021 14:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210826074526.825517-1-saravanak@google.com> <20210826074526.825517-2-saravanak@google.com>
 <YSeTdb6DbHbBYabN@lunn.ch> <CAGETcx-pSi60NtMM=59cve8kN9ff9fgepQ5R=uJ3Gynzh=0_BA@mail.gmail.com>
 <YSf/Mps9E77/6kZX@lunn.ch> <CAGETcx_h6moWbS7m4hPm6Ub3T0tWayUQkppjevkYyiA=8AmACw@mail.gmail.com>
 <YSg+dRPSX9/ph6tb@lunn.ch> <CAGETcx_r8LSxV5=GQ-1qPjh7qGbCqTsSoSkQfxAKL5q+znRoWg@mail.gmail.com>
 <YSjsQmx8l4MXNvP+@lunn.ch> <CAGETcx_vMNZbT-5vCAvvpQNMMHy-19oR-mSfrg6=eSO49vLScQ@mail.gmail.com>
 <YSlG4XRGrq5D1/WU@lunn.ch>
In-Reply-To: <YSlG4XRGrq5D1/WU@lunn.ch>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 27 Aug 2021 14:33:02 -0700
Message-ID: <CAGETcx-ZvENq8tFZ9wb_BCPZabpZcqPrguY5rsg4fSNdOAB+Kw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] driver core: fw_devlink: Add support for FWNODE_FLAG_BROKEN_PARENT
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>,
        Alvin Sipraga <ALSI@bang-olufsen.dk>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 27, 2021 at 1:11 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > I've not yet looked at plain Ethernet drivers. This pattern could also
> > > exist there. And i wonder about other complex structures, i2c bus
> > > multiplexors, you can have interrupt controllers as i2c devices,
> > > etc. So the general case could exist in other places.
> >
> > I haven't seen any generic issues like this reported so far. It's only
> > after adding phy-handle that we are hitting these issues with DSA
> > switches.
>
> Can you run your parser over the 2250 DTB blobs and see how many
> children have dependencies on a parent? That could give us an idea how
> many moles need whacking. And maybe, where in the tree they are
> hiding?

You are only responding to part of my email. As I said in my previous
email: "There are plenty of cases where it's better to delay the child
device's probe until the parent finishes. You even gave an example[7]
where it would help avoid unnecessary deferred probes." Can you please
give your thoughts on the rest of the points I made too?

-Saravana
