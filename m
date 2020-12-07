Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0E32D196E
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Dec 2020 20:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgLGT0V (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Dec 2020 14:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLGT0V (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Dec 2020 14:26:21 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C099BC06179C
        for <linux-acpi@vger.kernel.org>; Mon,  7 Dec 2020 11:25:40 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id w127so2509924ybw.8
        for <linux-acpi@vger.kernel.org>; Mon, 07 Dec 2020 11:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dzi60D45rWQuaA2cHr5rB8Qrg2wnEyiFvWItg7Nmx+A=;
        b=v+WQqOx59N4nA+TR3LOO4M4W3N8UUxCd0mi3VCA8QhjuDwo4lIM2+KUjXY4FldkutS
         N3bExgP4Ogg8B3b0uktbNmwWg7AQmW0STl6R4EvJlNkfllvx3u4GnKCMfiMy6ZPF5DCT
         ZWIK6jyLgazQ3AjLbIkw1Slu7PeW/Ol5A0PDEi3EAgvI75uo5+oh4xkSm1s2hZbvnjFQ
         cKgVdvDiXo0sp5k0CAO4kTZ947dYA48KsKA/oO2ZGVPGIC3/sCveX07WRqK7ML6yxNrx
         AbvIxSQFUZJNZslcFFXo+40ytrrNOS21ihYbAMPkDbuMkp/Eoe9k8fsa3M/0rkagkaCn
         WkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dzi60D45rWQuaA2cHr5rB8Qrg2wnEyiFvWItg7Nmx+A=;
        b=bDtzv+b+BAkMdLMF7ZvY5SMnR93yi6+92X1X6PkjCF5AZEkIzq0zFjvQid+jl4Mjqa
         7Mub8O27MYuZAdoa+P6n8KeXmOXpW2g9Qtcw75YTnDOIgNWD2pXf3ka3+7akTIfVQz04
         h0CCQQezRM/evOJK5mpG3hkMZX2MPl5fsmBKCqpSv/2XeVq5J0LTeeHm374d+xVu0+oN
         WwUnckQ2ok01zbZSj5tdauFQP0zBYGJpLKAi53HY37NbYy8YwEQP9EVomKqstVBnD5Kh
         24AuOGi7QLl2Ml55rYCFdLZAwUt4s6x46EAC8wkv21SO5BA6HcSPRlTk5lBi0pfo1SWt
         N98g==
X-Gm-Message-State: AOAM530xjpyguwHubyGVNan64i9VotOi7WkzkJKndfy92tXn2/YRvYHf
        C70n0g+HKieXbYXeZRLg7oStUuzbHWa58GmC1ucOwA==
X-Google-Smtp-Source: ABdhPJzh94uQucZym0EJ/OhT0eAxJs+lEBfZI5tn0VwSrzUilb89QB7ghzACx8BH7y0+Q9uP9BQEqVPCQXCZ16NCfhM=
X-Received: by 2002:a25:1383:: with SMTP id 125mr22570950ybt.32.1607369139748;
 Mon, 07 Dec 2020 11:25:39 -0800 (PST)
MIME-Version: 1.0
References: <20201121020232.908850-1-saravanak@google.com> <20201121020232.908850-9-saravanak@google.com>
 <20201206074840.GB687065@unreal>
In-Reply-To: <20201206074840.GB687065@unreal>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 7 Dec 2020 11:25:03 -0800
Message-ID: <CAGETcx8296K_v1p2-KAW7ABQjB02P63sBzz2aZoRW3E3WHb4Dg@mail.gmail.com>
Subject: Re: [PATCH v2 08/17] driver core: Add fwnode link support
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Android Kernel Team <kernel-team@android.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Dec 5, 2020 at 11:48 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Fri, Nov 20, 2020 at 06:02:23PM -0800, Saravana Kannan wrote:
> > Add support for creating supplier-consumer links between fwnodes.  It is
> > intended for internal use the driver core and generic firmware support
> > code (eg. Device Tree, ACPI), so it is simple by design and the API
> > provided is limited.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/base/core.c    | 98 ++++++++++++++++++++++++++++++++++++++++++
> >  drivers/of/dynamic.c   |  1 +
> >  include/linux/fwnode.h | 14 ++++++
> >  3 files changed, 113 insertions(+)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 401fa7e3505c..e2b246a44d1a 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -50,6 +50,104 @@ static LIST_HEAD(wait_for_suppliers);
> >  static DEFINE_MUTEX(wfs_lock);
> >  static LIST_HEAD(deferred_sync);
> >  static unsigned int defer_sync_state_count = 1;
> > +static DEFINE_MUTEX(fwnode_link_lock);
> > +
> > +/**
> > + * fwnode_link_add - Create a link between two fwnode_handles.
> > + * @con: Consumer end of the link.
> > + * @sup: Supplier end of the link.
> > + *
> > + * Create a fwnode link between fwnode handles @con and @sup. The fwnode link
> > + * represents the detail that the firmware lists @sup fwnode as supplying a
> > + * resource to @con.
> > + *
> > + * The driver core will use the fwnode link to create a device link between the
> > + * two device objects corresponding to @con and @sup when they are created. The
> > + * driver core will automatically delete the fwnode link between @con and @sup
> > + * after doing that.
> > + *
> > + * Attempts to create duplicate links between the same pair of fwnode handles
> > + * are ignored and there is no reference counting.
>
> Sorry to ask, but why is that?
> Isn't this a programmer error?

No, not a programmer error.

One firmware node can point to the same supplier many times. For
example, the consumer can be using multiple clocks from the same
supplier clock controller. In the context of fw_devlink, there's no
reason to keep track of each clock dependency separately because we'll
be creating only one device link from fwnode link. So multiple fwnode
link attempts between the same two devices are just treated as one
instance of dependency. I hope that clarifies things.

-Saravana
