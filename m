Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2405E413D15
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Sep 2021 23:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbhIUV4y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 21 Sep 2021 17:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbhIUV4y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Sep 2021 17:56:54 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E0DC061575
        for <linux-acpi@vger.kernel.org>; Tue, 21 Sep 2021 14:55:24 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id 73so2534542qki.4
        for <linux-acpi@vger.kernel.org>; Tue, 21 Sep 2021 14:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3QuvBAGlkAnIUdz8/4QcTPLHogNGT+8cLD8sfAqgRaI=;
        b=V/0T0H3IJ6X8dlNuc6qpX89jWAM5yewNgjQ1UjzHLcUvnJGkVi+ok8TBzHinfDg+6C
         nx1cofDHKBZxRHZtMAjzH3yfdPwyRtV8XutB4hK4yC8NJ+GsY7BBjXDFS6WHy6n355aA
         nBteNwfVRtTCtGi3zBW3rSYs7bqxF0lcb8d5RXlPydJXYWv4ai3u8MSu95kL4qSOLOKF
         /RkgsNsh3LohKkXZTAfM5YQDZLFIZhs2fEEsStDYzFdZpAsqTXNRVSzCK+BAFkZoKGo2
         oD/D7ClMe8v8sKnTyE728GSpaQ7ZkAcfyRD04f8/fhX3dj3yB0GFAdZU+/aoFnoa3bxS
         rZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3QuvBAGlkAnIUdz8/4QcTPLHogNGT+8cLD8sfAqgRaI=;
        b=FLqXNcQ+GY45cGprFaK1/QrRJtysXE7zasPs4uPvtgO79syOt8T6mGpweigwPcUf9V
         89Jo/C8jZR0fFC9VaaScZFSIzuimFUeK2J1os7psu6WF3vOz4bPxaRMQWOe4FoRASEGk
         SP7/2tweU8NKFGGg58nfdpUZBNTOLCHRU1bpkzoQ3p3d0NENuuTd3p2nxoeMjStQOcja
         jTmG6m0UEMhNBQgV5k7WiU4JRLbjXYFjONWemSHF96VBjvrstWhtvaaq6gSu93ggSnBh
         tR7PTVJ3fVExIKcl1uhLpLll85rYz6m1w7ZXL/u0rKqpOqpBQ4zoKfe8E2rGYNuadUhJ
         ekKw==
X-Gm-Message-State: AOAM530sfO++rTI7gyUS1A5On+NVjQddF8UmojtxQ+yru6a9Afgzz36i
        jLya/VwpQnzW/dqzVhu7K1217frJg2FrUTVCTe2Jig==
X-Google-Smtp-Source: ABdhPJwz9vBg4o7xVrIBJamIjkbjr8iOf/eD5UB2SSYihAir8Cuj20gAsEPMZGoiMDbFBm4ogQZaaHC34VNOiDocbeM=
X-Received: by 2002:a25:e750:: with SMTP id e77mr12672722ybh.23.1632261323912;
 Tue, 21 Sep 2021 14:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210915170940.617415-1-saravanak@google.com> <20210915170940.617415-3-saravanak@google.com>
 <CAJZ5v0h11ts69FJh7LDzhsDs=BT2MrN8Le8dHi73k9dRKsG_4g@mail.gmail.com>
 <YUaPcgc03r/Dw0yk@lunn.ch> <YUoFFXtWFAhLvIoH@kroah.com> <CAJZ5v0jjvf6eeEKMtRJ-XP1QbOmjEWG=DmODbMhAFuemNn4rZg@mail.gmail.com>
 <YUocuMM4/VKzNMXq@lunn.ch> <CAJZ5v0iU3SGqrw909GLtuLwAxdyOy=pe2avxpDW+f4dP4ArhaQ@mail.gmail.com>
 <YUo3kD9jgx6eNadX@lunn.ch> <CAGETcx9hTFhY4+fHd71zYUsWW223GfUWBp8xxFCb2SNR6YUQ4Q@mail.gmail.com>
 <YUpIgTqyrDRXMUyC@lunn.ch>
In-Reply-To: <YUpIgTqyrDRXMUyC@lunn.ch>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 21 Sep 2021 14:54:47 -0700
Message-ID: <CAGETcx_50KQuj0L+MCcf2Se8kpFfZwJBKP0juh_T7w+ZCs2p+g@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] driver core: fw_devlink: Add support for FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 21, 2021 at 2:03 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > There are cases where the children try to probe too quickly (before
> > the parent has had time to set up all the resources it's setting up)
> > and the child defers the probe. Even Andrew had an example of that
> > with some ethernet driver where the deferred probe is attempted
> > multiple times wasting time and then it eventually succeeds.
>
> And i prefer an occasional EPROBE_DEFER over a broken Ethernet switch,
> which is the current state. I'm happy to see optimisations, but not at
> the expense of breaking working stuff.

Right, but in that case, the long term solution should be to make
changes so we don't expect the child to be bound as soon as it's
added. Not disable the optimization. Agree?

>
> > Also, this assumption that the child will be bound successfully upon
> > addition forces the parent/child drivers to play initcall chicken
>
> We have never had any initcall chicken problems. The switch drivers
> all are standard mdio_module_driver, module_platform_driver,
> module_i2c_driver, module_pci_driver. Nothing special here. Things
> load in whatever order they load, and it all works out, maybe with an
> EPROBE_DEFER cycle. Which is good, we get our error paths tested, and
> sometimes find bugs that way.

My comment was a general comment about parent drives that expect the
child drivers to be bound on addition -- not specific to DSA.

But even in the DSA case, not playing initcall chicken means if you
change the order of driver registration, things should still work.
However, as it stands, if you register the switch driver before the
PHY drivers are registered, you are going to force bind the PHYs to
the generic driver.

-Saravana
