Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD313FCF8A
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Sep 2021 00:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhHaWUL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 31 Aug 2021 18:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhHaWUK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Aug 2021 18:20:10 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564E9C061764
        for <linux-acpi@vger.kernel.org>; Tue, 31 Aug 2021 15:19:13 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id n126so1330408ybf.6
        for <linux-acpi@vger.kernel.org>; Tue, 31 Aug 2021 15:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ifV99n/y4cMpRleJnGxlR5krF8hXhCt0QnPJskXH/G0=;
        b=mXJaohfgLRAZziAeXw3DoxsqQIdvxruf11ejCdzwmE0bs3LkUlvm2Sna4RscCQnUR4
         AqbiUWI7waAxZ1hgjaqjxPYnn5+b4sFqkIae4BITOse4wTvFXrYi8i20hjCA+fO6qXvq
         Zuro6Lpn8jaAWVY+QDqfrfE9j+ewxqZ/DnQBgu7sXBmzy+5Qg93mtmXhS9lFoa55bGjO
         OZ3q+D7NvlTUP5Qr4uYIgAP1BFmClydC5ArXAQsF/XrcIGReU1f1etpuOT8pRsNmV5Fp
         U3x1q1IzX070pGvOHBz1IH6oA/pV5JcCIX557TQ732/KpzmGalXoOS0jCfOX/FjnCylV
         r2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ifV99n/y4cMpRleJnGxlR5krF8hXhCt0QnPJskXH/G0=;
        b=kb8eofMUb9kz/y/1/iaxWQhKsQTCj/QHj1h5xiWbSddBUjrY81lIT3SRxsPLNNquMo
         f8GCWsUT0OJc31H3mPPttQIJX6xXJSq3cBISEOVYwq7/qfzWXv87SckQoR4btEeBc5gY
         f6QzGdL6j819x7DnIzWPMkfZlmybTzN5KGFbwPsznLYXk6AEWffbd3FGlxlnLzZCNfEy
         Sbrqu3ygV0Mfm4x9ZSL0OkE+dBXKtsZzmfwi1HmLXU1CGvxKrVFflAQZvwMswA8XgLSr
         gXH8r8JgT5EF2GrFIDDkl7iC6foUsIyq7QH6Tv5fsMcCEiuwvUei7qpk27noy+Vl0sl0
         7gAw==
X-Gm-Message-State: AOAM531sJkInIncdqXD12Zh13Se5rCMw2bDkCQ8NNU7zuMxHOjt3l0r0
        0JxLGK4USOqLfyGABeI3ne61eBI7/gtopV4n5GBVEw==
X-Google-Smtp-Source: ABdhPJwW9LbiOWC7XzKXLV28krpS8gQQ6Glcr3p9SZV4SwiLgXqANwTnPYLfnyyap+XYJ5EC1woQrg3C6IAb9PbINrk=
X-Received: by 2002:a25:6746:: with SMTP id b67mr35157317ybc.96.1630448351690;
 Tue, 31 Aug 2021 15:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <YSg+dRPSX9/ph6tb@lunn.ch> <CAGETcx_r8LSxV5=GQ-1qPjh7qGbCqTsSoSkQfxAKL5q+znRoWg@mail.gmail.com>
 <YSjsQmx8l4MXNvP+@lunn.ch> <CAGETcx_vMNZbT-5vCAvvpQNMMHy-19oR-mSfrg6=eSO49vLScQ@mail.gmail.com>
 <YSlG4XRGrq5D1/WU@lunn.ch> <CAGETcx-ZvENq8tFZ9wb_BCPZabpZcqPrguY5rsg4fSNdOAB+Kw@mail.gmail.com>
 <YSpr/BOZj2PKoC8B@lunn.ch> <CAGETcx_mjY10WzaOvb=vuojbodK7pvY1srvKmimu4h6xWkeQuQ@mail.gmail.com>
 <YS4rw7NQcpRmkO/K@lunn.ch> <CAGETcx_QPh=ppHzBdM2_TYZz3o+O7Ab9-JSY52Yz1--iLnykxA@mail.gmail.com>
 <YS6nxLp5TYCK+mJP@lunn.ch>
In-Reply-To: <YS6nxLp5TYCK+mJP@lunn.ch>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 31 Aug 2021 15:18:35 -0700
Message-ID: <CAGETcx90dOkw+Yp5ZRNqQq2Ny_ToOKvGJNpvyRohaRQi=SQxhw@mail.gmail.com>
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

On Tue, Aug 31, 2021 at 3:06 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Aug 31, 2021 at 12:26:30PM -0700, Saravana Kannan wrote:
> > On Tue, Aug 31, 2021 at 6:16 AM Andrew Lunn <andrew@lunn.ch> wrote:
> > >
> > > > > I must admit, my main problem at the moment is -rc1 in two weeks
> > > > > time. It seems like a number of board with Ethernet switches will be
> > > > > broken, that worked before. phy-handle is not limited to switch
> > > > > drivers, it is also used for Ethernet drivers. So it could be, a
> > > > > number of Ethernet drivers are also going to be broken in -rc1?
> > > >
> > > > Again, in those cases, based on your FEC example, fw_devlink=on
> > > > actually improves things.
> > >
> > > Debatable. I did some testing. As expected some boards with Ethernet
> > > switches are now broken.
> >
> > To clarify myself, I'm saying the patch to parse "ethernet" [8] will
> > make things better with fw_devlink=on for FEC. Not sure if you tested
> > that patch or not.
>
> Yes and no. I was tested with the FEC, but because of fw_devlink=on,
> the switches don't probe correctly. So it is not possible to see if it
> helped or not, since its plain broken.
>
> > Not sure what was the tip of the tree with which you bisected.
>
> I manually tested linux-next, v5.14, v5.13 and v5.12 and then
> bisected:
>
> $ git bisect log
> git bisect start
> # good: [9f4ad9e425a1d3b6a34617b8ea226d56a119a717] Linux 5.12
> git bisect good 9f4ad9e425a1d3b6a34617b8ea226d56a119a717
> # bad: [62fb9874f5da54fdb243003b386128037319b219] Linux 5.13
>
> So well away from linux-next which contains the phy-handle parser.
>
> I will try to give the two patches a try today or tomorrow.

If the switches are broken without the phy-handle or ethernet change,
I'm not sure if the "BROKEN_PARENT" patch would help.

>
> > Thanks for testing it out. And worst case, we'll revert phy-handle
> > support.
>
> Which is not enough to fix these Ethernet switches.

Ok, if you can give more specifics on this, I'll look into it. I'd need:
1) The DTS file that you see the issue on.
2) The devices that don't probe when you have the issue (you can find
these in /sys/kernel/debug/devices_deferred)
3) And if possible boot logs with dev_dbg changed to dev_info in
device_link_add() and device_links_check_suppliers()

Thanks,
Saravana
