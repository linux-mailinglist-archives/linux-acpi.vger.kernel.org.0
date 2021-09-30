Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6363641E037
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Sep 2021 19:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352724AbhI3RdZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 Sep 2021 13:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352720AbhI3RdZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Sep 2021 13:33:25 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CEFC06176C
        for <linux-acpi@vger.kernel.org>; Thu, 30 Sep 2021 10:31:42 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id v195so14527821ybb.0
        for <linux-acpi@vger.kernel.org>; Thu, 30 Sep 2021 10:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dbyWtskCAZy+xt/GX/rEgH8dPX77Pl0JHzECutvB7o8=;
        b=AOfO0Xhr5RbIHSrEG7VDe+G/eQDtr/9yws9yHRrlM4INTiD6bVk7zpxrJIj/11NLkI
         TIQ6kRv/FruFzkkLOHs/dUDB0vBP6Bz4CdY4KqkoPXWOu4ZpAnGAiNT1Q2DCWTYfCTdw
         +4idllKUY8B1pBmX1Bbps144pNNEeW76nSwzMwjmCoOCg5LvCJPEseLCwrCg44RzvFJN
         Z2Rk95vOiKlQv80e0EfbhzQpsAk9HoH8s3Ccy87CD95vUacfVMvqwtVyr31MIN65zPd2
         nHthyi2Xb0uLapKRmAdVvZbTMJ4GForrM0vxVj5y/e3kS+4k/mi6yeoq3W4tF4LQKMza
         Ne7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dbyWtskCAZy+xt/GX/rEgH8dPX77Pl0JHzECutvB7o8=;
        b=xFRo0JrzhNXKA4TcLFn6K1rxF8/zUhBvX+fRend1ugLeNqtPDA9VD0rpOLOl/XhWu3
         ckbvwbroTir3K8Ltafr1r2+5Mr5U1dFL9rvxC3st8udOPPalUPU5qWLpYOL3E2JQSRat
         zBy6sOB87LKFnzNLPEan8lHNlaUGDPUOel1Eju3flHmidGOAXILV3Eb22IO+Mqsz6NEF
         UyM3H6vrhuavU14kfXnPY48q3RUvlH04INHCRh05wSL9PkGWta74vqEft3NJIfapUgJz
         vXDpcpdGZBbleWHck5Oi4wmgIeP9Wfk3xF6cR+pdE2DjrWbFB+mN1sGju6mT/SNtuayW
         IXZg==
X-Gm-Message-State: AOAM533hwgVoQ1056EVU3onSotVxGBj+HqB6+jfJXsbWY77yfOt5vQrR
        aRXKYR5AC6SR/1nWA4Y8KyDVqaWoBM2UbIJpB4Qnqg==
X-Google-Smtp-Source: ABdhPJyV3/tD2PJOZ+6zaxIskMQ+tAjgdePucKrZFQgdWa6LnhBqYPlRwMYUesbtPLbMK6lEurqAoxRJi8dLI25P64Y=
X-Received: by 2002:a25:2b07:: with SMTP id r7mr496920ybr.296.1633023101172;
 Thu, 30 Sep 2021 10:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <YSpr/BOZj2PKoC8B@lunn.ch> <CAGETcx_mjY10WzaOvb=vuojbodK7pvY1srvKmimu4h6xWkeQuQ@mail.gmail.com>
 <YS4rw7NQcpRmkO/K@lunn.ch> <CAGETcx_QPh=ppHzBdM2_TYZz3o+O7Ab9-JSY52Yz1--iLnykxA@mail.gmail.com>
 <YS6nxLp5TYCK+mJP@lunn.ch> <CAGETcx90dOkw+Yp5ZRNqQq2Ny_ToOKvGJNpvyRohaRQi=SQxhw@mail.gmail.com>
 <YS608fdIhH4+qJsn@lunn.ch> <20210831231804.zozyenear45ljemd@skbuf>
 <CAGETcx8MXzFhhxom3u2MXw8XA-uUtm9XGEbYNobfr+Ptq5+fVQ@mail.gmail.com>
 <20210930134343.ztq3hgianm34dvqb@skbuf> <YVXDAQc6RMvDjjFu@lunn.ch>
In-Reply-To: <YVXDAQc6RMvDjjFu@lunn.ch>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 30 Sep 2021 10:31:05 -0700
Message-ID: <CAGETcx8emDg1rojU=_rrQJ3ezpx=wTukFdbBV-uXiu1EQ87=wQ@mail.gmail.com>
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

On Thu, Sep 30, 2021 at 7:00 AM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Andrew is testing with arch/arm/boot/dts/vf610-zii-dev-rev-b.dts.
> >
> > Graphically it looks like this:
>
> Nice ASCII art :-)

Thanks for the awesome diagram Vladimir!

>
> This shows the flow of Ethernet frames thought the switch
> cluster. What is missing, and causing fw_devlink problems is the MDIO
> bus master for the PHYs, and the interrupt control where PHY
> interrupts are stored, and the linking from the PHY to the interrupt
> controller. Physically all these parts are inside the Ethernet switch
> package. But Linux models them as separate blocks. This is because in
> the general case, they are all discrete blocks. You have a MAC chip,
> and a PHY chip, and the PHY interrupt output it connected to a SoC
> GPIO.
>
> >
> >  +-----------------------------+
> >  |          VF610 SoC          |
> >  |          +--------+         |
> >  |          |  fec1  |         |
> >  +----------+--------+---------+
> >                 | DSA master
> >                 |
> >                 | ethernet = <&fec1>;
> >  +--------+----------+---------------------------+
> >  |        |  port@6  |                           |
> >  |        +----------+                           |
> >  |        | CPU port |     dsa,member = <0 0>;   |
> >  |        +----------+      -> tree 0, switch 0  |
> >  |        |   cpu    |                           |
> >  |        +----------+                           |
> >  |                                               |
> >  |            switch0                            |
> >  |                                               |
> >  +-----------+-----------+-----------+-----------+
>
> Inside the block above, is the interrupt controller and the MDIO bus
> master.
>
>
> >  |   port@0  |   port@1  |   port@2  |   port@5  |
> >  +-----------+-----------+-----------+-----------+
> >  |switch0phy0|switch0phy1|switch0phy2|   no PHY  |
> >  +-----------+-----------+-----------+-----------+
>
> The control path for these PHYs is over the MDIO bus. They are probed
> via the control path bus. These PHYs also have an interrupt output,
> which is wired to the interrupt controller above.
>
>
> >  | user port | user port | user port | DSA port  |
> >  +-----------+-----------+-----------+-----------+
> >  |    lan0   |    lan1   |    lan2   |    dsa    |
> >  +-----------+-----------+-----------+-----------+
>

Thanks for the dts paths and the additional details Andrew.

I think this gives me enough info for now to make sure whatever I'm
coding isn't completely stupid. I'm trying to make the generic PHY
driver less greedy (taking it a bit further than what Vladimir was
attempting) and also delay the use of generic PHY driver as late as
possible (so that we give as much time as possible for the specific
driver to be registered/loaded before we give up and use generic PHY
driver). This would also need some changes to the DSA code and hence
these questions.

Btw, do we have non-DSA networking devices where fw_devlink=on
delaying PHY probes is causing an issue?

-Saravana
