Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335412D1AA8
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Dec 2020 21:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgLGUiB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Dec 2020 15:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgLGUiB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Dec 2020 15:38:01 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53F6C061794
        for <linux-acpi@vger.kernel.org>; Mon,  7 Dec 2020 12:37:20 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id r127so14064370yba.10
        for <linux-acpi@vger.kernel.org>; Mon, 07 Dec 2020 12:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vKsYEQO+hXoC+O9fuIS3DOCrttBDvhwXSXCIpw/9d8w=;
        b=Eu3YUZ+efcTSPiMjldpqNT8TmByKdSe/auRkmzbcXUYTE9qktC3CcbXxyvz44SanH1
         0eGhoxAUqRvGek4HcRUVUMnibJnk9EH7MPI4yJG+fU6MsMlD33UrKBZ4+tFxQ5hkKEM8
         +kzCEl4nlVK81rnB73uBY/z6lg2jpLuxIAvzF6gskk/AovHFKE+1uEGNxbQ495q7b5qn
         KfnC/cf6OyXu1MPtHNBG+Su3rKPcnqIaJeiZ79v4c5J66B1H5Nx+MMRxLAwhmazt5aUU
         voP89YpE/HWtLPWZ0D4q45WpURi1h8mtDfrnGNO41lNnCax/2dWhShADQC5qYnR3BbfA
         r3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vKsYEQO+hXoC+O9fuIS3DOCrttBDvhwXSXCIpw/9d8w=;
        b=XZdPfNpKSjCkre+Uq/t22coDBzKQHmDzdNl8C/NXXgMVOdNp80q9UCTWf8l4/x8zDf
         l2wI5AzMmNz5O/gXE8KQwZ357WyS0bMFgkhyt1QBAUGa27M75y0ZD7POqplJVjb8j7OH
         kK1xJHNCS32Mj3R+BNPXkysIYHOayoj67Jg0gAbsGMkqwO2UM1JOKvjxAJxz6THPjwPi
         r2dkmy50HVqY+dUZ0HBoTC8ufzFZr5vfJgfjkuvh2eMLjtj1zqj0KvcCL4Pp343bMceF
         +esuT/mJnt8HnEbKKfZABrlgh5EYOBA6Tjakj3z7BtlKPUvn6bcUlo1yXeXcJE/s1m5o
         DL6A==
X-Gm-Message-State: AOAM531Jt7mWTSGimz+zCOxRGsOIKa3ihb3r3MPFlBtwrRe5iYu0BaZF
        TbwSYrB+Zey+D7MGcC/SOmxI6nEShJbCb9WhetVpUw==
X-Google-Smtp-Source: ABdhPJyJLUT7BtS2KbRGhO5/i+SqLWUVWG+N3s91L0Aio7l+Ry1j4uRMoKYqXkaJbXx0oor/SXMSyVMMmpneEAH4JXA=
X-Received: by 2002:a25:8401:: with SMTP id u1mr26690361ybk.96.1607373439718;
 Mon, 07 Dec 2020 12:37:19 -0800 (PST)
MIME-Version: 1.0
References: <20201121020232.908850-1-saravanak@google.com> <20201121020232.908850-8-saravanak@google.com>
 <20201206072621.GA687065@unreal> <CAGETcx9L0f5HPgunTf_WRsr9yeaYK1Ku5ESzeb0A1pkn3Yy2aw@mail.gmail.com>
 <20201207195357.GF693271@unreal>
In-Reply-To: <20201207195357.GF693271@unreal>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 7 Dec 2020 12:36:43 -0800
Message-ID: <CAGETcx-Y6qdyt7xGfoGg=z9B7VE30AZjodMZzy9hQrDAEd8uYw@mail.gmail.com>
Subject: Re: [PATCH v2 07/17] driver core: Add fwnode_init()
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

On Mon, Dec 7, 2020 at 11:54 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, Dec 07, 2020 at 11:25:15AM -0800, Saravana Kannan wrote:
> > On Sat, Dec 5, 2020 at 11:26 PM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Fri, Nov 20, 2020 at 06:02:22PM -0800, Saravana Kannan wrote:
> > > > There are multiple locations in the kernel where a struct fwnode_handle
> > > > is initialized. Add fwnode_init() so that we have one way of
> > > > initializing a fwnode_handle.
> > > >
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > ---
> > > >  drivers/acpi/property.c         | 2 +-
> > > >  drivers/acpi/scan.c             | 2 +-
> > > >  drivers/base/swnode.c           | 2 +-
> > > >  drivers/firmware/efi/efi-init.c | 8 ++++----
> > > >  include/linux/fwnode.h          | 6 ++++++
> > > >  include/linux/of.h              | 2 +-
> > > >  kernel/irq/irqdomain.c          | 2 +-
> > > >  7 files changed, 15 insertions(+), 9 deletions(-)
> > >
> > > In this series, I didn't find any extension of fwnode_init() to be it more
> > > than simple assignment. This change looks to me like unnecessary churn and
> > > obfuscation rather than improvement.
> > >
> > > "...ops = &...;" is pretty standard in the kernel to initialize ops
> > > structures.
> >
> > Subsequent patches make fwnode_init() do more stuff.
>
> But not in this series, right?

In this series. The very next patch - Patch 8/17 :)

-Saravana
