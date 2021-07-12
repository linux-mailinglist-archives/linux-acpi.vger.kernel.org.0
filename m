Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1FCE3C62A4
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jul 2021 20:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhGLSdG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Jul 2021 14:33:06 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:37736 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbhGLSdG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Jul 2021 14:33:06 -0400
Received: by mail-oi1-f169.google.com with SMTP id h9so25615139oih.4;
        Mon, 12 Jul 2021 11:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N4vzjKJtxHZvVFF3s8sjdimr+qBj5D1oqAlfvgwV2lg=;
        b=b+65iMvs7ir2SzORXXkTLKv4t3qbhL2PES4Flh7V54MsyeSmjUOIknOmugnLV0Gzxg
         LFvYMdLsqPQm7FtG0wAiB1AczRTU6XCuIG/IW9wyHv3cevRb5Cp3CuEIXnssslX1Dhpk
         T7oc+7ESgz1A5mgvjtRYK5phD917M6VMRiBBEBtv6bl8+2t0oX4ytXyp1cIm+86gJJrG
         AjSN4A4Vf2sbdvcGg+Kvoh3iKpoPb5Vq1VL4UeH/MZ03vWzndFjzS8K46wpz4PLWAwUo
         UlVmHWfxOx8yD6i/ULIzBepYP1SEuIruOKFtZuOI4NgIheL2bq1l+LCiAqRPD2SKDAvU
         eY7A==
X-Gm-Message-State: AOAM533frXaqDIUaBSkGbZrc0e9Q9EbbngdZsaQyE6HzNCAbpHkkQT2x
        LAYWf51/iSbNXlwfYW8bhwB9iZp1OVed3TPyIEo=
X-Google-Smtp-Source: ABdhPJzW6BBe5Qog04PD4bUYTSSTk8kgB65cZpDKjMTgNlWUvfhT7KqN9EQO+0MSHuVGeMuupG5D89/fCF2qEHjrLuM=
X-Received: by 2002:a05:6808:15a6:: with SMTP id t38mr11835566oiw.157.1626114617078;
 Mon, 12 Jul 2021 11:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <2780027.e9J7NaK4W3@kreacher> <5627033.MhkbZ0Pkbq@kreacher> <YOyD/4kdvd77PzLy@kroah.com>
In-Reply-To: <YOyD/4kdvd77PzLy@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Jul 2021 20:30:06 +0200
Message-ID: <CAJZ5v0gJP1ywCwEgdGdx2A4ZPaSKc3utmXeO_geiGfA85axZOw@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] software nodes: Split software_node_notify()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 12, 2021 at 8:03 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 12, 2021 at 07:27:12PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Split software_node_notify_remove) out of software_node_notify()
> > and make device_platform_notify() call the latter on device addition
> > and the former on device removal.
> >
> > While at it, put the headers of the above functions into base.h,
> > because they don't need to be present in a global header file.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/base/base.h      |    3 ++
> >  drivers/base/core.c      |    9 +++---
> >  drivers/base/swnode.c    |   61 ++++++++++++++++++++++++-----------------------
> >  include/linux/property.h |    2 -
> >  4 files changed, 39 insertions(+), 36 deletions(-)
> >
> > Index: linux-pm/drivers/base/swnode.c
> > ===================================================================
> > --- linux-pm.orig/drivers/base/swnode.c
> > +++ linux-pm/drivers/base/swnode.c
> > @@ -11,6 +11,8 @@
> >  #include <linux/property.h>
> >  #include <linux/slab.h>
> >
> > +#include "base.h"
> > +
> >  struct swnode {
> >       struct kobject kobj;
> >       struct fwnode_handle fwnode;
> > @@ -1053,7 +1055,7 @@ int device_add_software_node(struct devi
> >        * balance.
> >        */
> >       if (device_is_registered(dev))
> > -             software_node_notify(dev, KOBJ_ADD);
> > +             software_node_notify(dev);
>
> Should this now be called "software_node_notify_add()" to match up with:
>
> >       if (device_is_registered(dev))
> > -             software_node_notify(dev, KOBJ_REMOVE);
> > +             software_node_notify_remove(dev);
>
> The other being called "_remove"?
>
> Makes it more obvious to me :)

The naming convention used here follows platform_notify() and
platform_notify_remove(), and the analogous function names in ACPI for
that matter.

I thought that adding _add in just one case would be sort of odd, but
of course I can do that, so please let me know what you want me to do.

Cheers!
