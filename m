Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A5D413B13
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Sep 2021 22:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbhIUUJO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 21 Sep 2021 16:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhIUUJN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Sep 2021 16:09:13 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF12CC061575
        for <linux-acpi@vger.kernel.org>; Tue, 21 Sep 2021 13:07:44 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id c7so1666796qka.2
        for <linux-acpi@vger.kernel.org>; Tue, 21 Sep 2021 13:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a7H6cT4mga6MKA/FBc1vFkMxBKchnSYc7FysSEACUIw=;
        b=oO5gtDS9BY3BSstkJ+QPf/LV2JA8+SMU9apCIHCpWaaHBK4sK9k6NAjTmStfTzCYIh
         tt5bVN0Ma/yc+3/wWZVtdTNGljvUMfEHO0WoiM8JORORa3iLBBhdcEK/9EGCafdjQKig
         7Qa7QFhyM0l3WXGzCGNFgJSBZsVQggKQIBp4FzV7o9i4IMqXszTEM+ObIgxb9F9du+6Z
         hfsOB5t6fckzqI2icwRndg0wA2CillJM1YqDcn6ph8w+fCKoL9bS1ajVxhPwFVtk0LT/
         1Xxa8X2nuY9L69Wkhf8yi1RC8/ANYWfjT9UsNXqUYeEpGidjV9vNlucI/nF4d4ipqHJn
         Tv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a7H6cT4mga6MKA/FBc1vFkMxBKchnSYc7FysSEACUIw=;
        b=eU8DbE9B42nq+VcYUxeq2wfKq9qBthVPXT40ndsXx4u25fIOWnR8X2/L72zfozkasU
         f6ICBwuCS0CW2LV3v/6gh18lQo+etsP9gBVNUjBo7R2AA3W02lH2E8/pnwGDe0Fm4iWd
         nZb8aWa8kTxTWb25V9cZuHKt2u8wgUy64VCVNr2tGN772iQnRKyLT1cCJbwdSeOhisK+
         w+/2sVAjBZXBECf21JA/CyQBc0BNp4nB9AoPkJSR/rshqDhcx7sdxgEnNLqnDXTI62Lf
         682HAfJ5omiTVShg+QzLJtHAau49d+tPk1BK/CSsv/FsHT5VHarzeyXj8UuVR84o3wC+
         U/pA==
X-Gm-Message-State: AOAM53051u15o6nDsalvX+m/P03BwB4U6gV++EFmSx47nSdlP8pDpZpt
        j4eBG87Lb/x+oOopoiUSEB+FWYamcgx8ukLWN+rXtw==
X-Google-Smtp-Source: ABdhPJy9sNWQpdC4UGhnYJap6j/FXL1c2YwO59wStPm6nzmkO6twNV+NIee+jWrz1uIESPFs1cj6U4d5PwFvh5XrCtI=
X-Received: by 2002:a25:e750:: with SMTP id e77mr12175923ybh.23.1632254863554;
 Tue, 21 Sep 2021 13:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210915170940.617415-1-saravanak@google.com> <20210915170940.617415-3-saravanak@google.com>
 <CAJZ5v0h11ts69FJh7LDzhsDs=BT2MrN8Le8dHi73k9dRKsG_4g@mail.gmail.com>
 <YUaPcgc03r/Dw0yk@lunn.ch> <YUoFFXtWFAhLvIoH@kroah.com> <CAJZ5v0jjvf6eeEKMtRJ-XP1QbOmjEWG=DmODbMhAFuemNn4rZg@mail.gmail.com>
 <YUocuMM4/VKzNMXq@lunn.ch> <CAJZ5v0iU3SGqrw909GLtuLwAxdyOy=pe2avxpDW+f4dP4ArhaQ@mail.gmail.com>
 <YUo3kD9jgx6eNadX@lunn.ch>
In-Reply-To: <YUo3kD9jgx6eNadX@lunn.ch>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 21 Sep 2021 13:07:07 -0700
Message-ID: <CAGETcx9hTFhY4+fHd71zYUsWW223GfUWBp8xxFCb2SNR6YUQ4Q@mail.gmail.com>
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

Sorry I've been busy with LPC and some other stuff and could respond earlier.

On Tue, Sep 21, 2021 at 12:50 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > It works at a device level, so it doesn't know about resources.  The
> > only information it has is of the "this device may depend on that
> > other device" type and it uses that information to figure out a usable
> > probe ordering for drivers.
>
> And that simplification is the problem. A phandle does not point to a
> device, it points to a resource of a device. It should really be doing
> what the driver would do, follow the phandle to the resource and see
> if it exists yet. If it does not exist then yes it can defer the
> probe. If the resource does exist, allow the driver to probe.
>
> > Also if the probe has already started, it may still return
> > -EPROBE_DEFER at any time in theory
>
> Sure it can, and does. And any driver which is not broken will
> unregister its resources on the error path. And that causes users of
> the resources to release them. It all nicely unravels, and then tries
> again later. This all works, it is what these drivers do.

One of the points of fw_devlink=on is to avoid the pointless deferred
probes that'd happen in this situation. So saying "let this happen"
when fw_devlink=on kinda beats the point of it. See further below.

>
> > However, making children wait for their parents to complete probing is
> > generally artificial, especially in the cases when the children are
> > registered by the parent's driver.  So waiting should be an exception
> > in these cases, not a rule.

Rafael,

There are cases where the children try to probe too quickly (before
the parent has had time to set up all the resources it's setting up)
and the child defers the probe. Even Andrew had an example of that
with some ethernet driver where the deferred probe is attempted
multiple times wasting time and then it eventually succeeds.

Considering there's no guarantee that a device_add() will result in
the device being bound immediately, why shouldn't we make the child
device wait until the parent has completely probed and we know all the
resources from the parent are guaranteed to be available? Why can't we
treat drivers that assume a device will get bound as soon as it's
added as the exception (because we don't guarantee that anyway)?

Also, this assumption that the child will be bound successfully upon
addition forces the parent/child drivers to play initcall chicken --
the child's driver has to be registered before the parent's driver. We
should be getting away from those by fixing the parent driver that's
making these assumptions (I'll be glad to help with that). We need to
be moving towards reducing pointless deferred probes and initcall
ordering requirements instead of saying "this bad assumption used to
work, so allow me to continue doing that".

-Saravana

> So are you suggesting that fw_devlink core needs to change, recognise
> the dependency on a parent, and allow the probe? Works for me. Gets us
> back to before fw_devlink.
