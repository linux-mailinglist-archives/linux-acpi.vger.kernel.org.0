Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE0941E28F
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Sep 2021 22:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347442AbhI3UQ6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 Sep 2021 16:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346230AbhI3UQ6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Sep 2021 16:16:58 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0516AC06176D
        for <linux-acpi@vger.kernel.org>; Thu, 30 Sep 2021 13:15:15 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id s64so12881391yba.11
        for <linux-acpi@vger.kernel.org>; Thu, 30 Sep 2021 13:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Me7vW3q+q6rLanOt9S2VuLazMhOi6957p7rnr+uLOIk=;
        b=R2FWQW45NNofSeNJjPfUjNyFFGod2AQS1fmBgJZAaTIHwyU6++wv5vI9m/2JPTk8rX
         WugZ1flWTFEs6XzqN2uc0P9GJhlwnkMJi7s1WBXdivpSy2fMM/O+5pPhuHqBVXAPJYFl
         loP65unlQa3cHJwxa30sHAZSocSa7V3A2W1azPmBVwsIyYnFpWOoKZ5yPA5lvIAY7F4D
         zCfHC1tvrXhOYtLb8oeHcNk0yi5McHmEsrfMmA/omIIeXH3BjGTZpsNhuIBWsS+o383z
         gRayEQmmxLWZktUXQsvBfi4jicmQIVD8Nwjrx3KQHpZfz9ItFqgTCFCXT53dhpq8j1dW
         oCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Me7vW3q+q6rLanOt9S2VuLazMhOi6957p7rnr+uLOIk=;
        b=sgFVLGjHx6NLILi6NGcLfg8Ju8fAwoSFxbrWHio+4Ho8S+Jhhs1QnPnm9KdBjpGeVs
         uZxRPOT/qo7FB0J9MCRgN1PslBY3Mt5Aoo4AkNyLMbwButQnMGfBxlxcXQp1vGxX/QMS
         7uMnfOm7t/A6UmiAo3PzfGNIh5sE3R596lHun1zSBRIrVIPz747zLQ/9lo9z5KnAQHHO
         uTlvEPz1JfKIM1IEn87RdbFmmBTAZB2TLFO9d9pzg6hFGViARdL/sqkNzpF3Tn1xzMjA
         sNqr7aIOufXqwoXUfVqK6OGNcKcL9DFuRrWr1645RfZ0oNtCDAGnzKTzwOdQoase4ppB
         k3gw==
X-Gm-Message-State: AOAM533dwfOjZlmlo3WrvJ5LhKl4tAq/dnuyyBl2vzHnDp/Q60Pzf2iz
        ryI/Pfl8xgtY5Ik5ubgXYVXWHjFz1iVHJyiGUDcPaQ==
X-Google-Smtp-Source: ABdhPJyz2NYXeBQwRc9kkgNI9ar1T2WvDJpjlb3i7GnpyBRAvqGnbL4ZtbOFN5XbF1suUYAXztX67XYEMBOQNXZt/yU=
X-Received: by 2002:a25:db91:: with SMTP id g139mr1313912ybf.391.1633032913793;
 Thu, 30 Sep 2021 13:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <YS4rw7NQcpRmkO/K@lunn.ch> <CAGETcx_QPh=ppHzBdM2_TYZz3o+O7Ab9-JSY52Yz1--iLnykxA@mail.gmail.com>
 <YS6nxLp5TYCK+mJP@lunn.ch> <CAGETcx90dOkw+Yp5ZRNqQq2Ny_ToOKvGJNpvyRohaRQi=SQxhw@mail.gmail.com>
 <YS608fdIhH4+qJsn@lunn.ch> <20210831231804.zozyenear45ljemd@skbuf>
 <CAGETcx8MXzFhhxom3u2MXw8XA-uUtm9XGEbYNobfr+Ptq5+fVQ@mail.gmail.com>
 <20210930134343.ztq3hgianm34dvqb@skbuf> <YVXDAQc6RMvDjjFu@lunn.ch>
 <CAGETcx8emDg1rojU=_rrQJ3ezpx=wTukFdbBV-uXiu1EQ87=wQ@mail.gmail.com>
 <YVYSMMMkmHQn6n2+@lunn.ch> <CAGETcx-L7zhfd72+aRmapb=nAbbFGR5NX0aFK-V9K1WT4ubohA@mail.gmail.com>
 <cb193c3d-e75d-3b1e-f3f4-0dcd1e982407@gmail.com>
In-Reply-To: <cb193c3d-e75d-3b1e-f3f4-0dcd1e982407@gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 30 Sep 2021 13:14:37 -0700
Message-ID: <CAGETcx_G3haECnv-FS4L16PCmpfbCB3hhqHssT2E8d1fw5D3zw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] driver core: fw_devlink: Add support for FWNODE_FLAG_BROKEN_PARENT
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>,
        Alvin Sipraga <ALSI@bang-olufsen.dk>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 30, 2021 at 1:06 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 9/30/21 12:48 PM, Saravana Kannan wrote:
> > On Thu, Sep 30, 2021 at 12:38 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >>
> >>> Btw, do we have non-DSA networking devices where fw_devlink=on
> >>> delaying PHY probes is causing an issue?
> >>
> >> I don't know if issues have been reported, but the realtek driver has
> >> had problems in the past when the generic driver is used. Take a look
> >> at r8169_mdio_register(), it does something similar to DSA.
> >
> > Does it have the issue of having the PHY as its child too and then
> > depending on it to bind to a driver? I can't tell because I didn't
> > know how to find that info for a PCI device.
>
> Yes, r8169 includes a MDIO bus controller, and the PHY is internal to
> the Ethernet MAC. These are AFAIR the relevant changes to this discussion:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=16983507742cbcaa5592af530872a82e82fb9c51
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=11287b693d03830010356339e4ceddf47dee34fa
>
>
> >
> >>
> >> What is going to make things interesting is that phy_attach_direct()
> >> is called in two different contexts. During the MAC drivers probe, it
> >> is O.K. to return EPROBE_DEFER, and let the MAC driver try again
> >> later, if we know there is a specific PHY driver for it. But when
> >> called during the MAC drivers open() op, -EPROBE_DEFER is not
> >> allowed. What to do then is an interesting question.
> >
> > Yeah, basically before doing an open() it'll have to call an API to
> > say "just bind with whatever you got". Or something along those lines.
> > I already know how to get that to work. I'll send some RFC soonish (I
> > hope).
>
> I don't think this is going to scale, we have dozens and dozens of
> drivers that connect to the PHY during ndo_open().

Whichever code calls ->ndo_open() can't that mark all the PHYs that'll
be used as "needs to be ready now"? In any case, if we can have an API
that allows a less greedy Generic PHY binding, we could slowly
transition drivers over or at least move them over as they hit issues
with Gen PHY. Anyway, I'll think discussing it over code would be
easier. I'll also have more context as I try to make changes. So,
let's continue this on my future RFC.

-Saravana

> It is not realistic
> to audit them all, just like the opposite case where the drivers do
> probe MDIO/PHY during their .probe() call is not realistic either.
> --
> Florian
