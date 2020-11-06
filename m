Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51F52A909D
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Nov 2020 08:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgKFHn4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Nov 2020 02:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgKFHnx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Nov 2020 02:43:53 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCE0C0613D3
        for <linux-acpi@vger.kernel.org>; Thu,  5 Nov 2020 23:43:51 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id f140so373025ybg.3
        for <linux-acpi@vger.kernel.org>; Thu, 05 Nov 2020 23:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N8D4dOtEO5MSbMPQgbZVh96Yr52JhSt0gBh/mkTHwTk=;
        b=WMh5UrBwhjwlDr/PIgBwYmiM0/NmKaeT7rK+uQ83kgyA8HFql6+lU/cH31BfmlPlPh
         vAbL5MfwyJuEQ1hqm8JklkkzDbV6iC9q1jf97OGpKBsJqWVY21tnFw9xZnNeyPTPkWl3
         J11pKXcY3tkvhHDUJf+4IVGnhUlZkFiq64rj2WJ4xwuK5UzL3lTeTG8+j6alyTvalh00
         5Q7pD6mWtl4cwuQMBlYiXMHjEpOmsJtrV3+9voocQUGuVF2yLH0T46duv0xHSFR8mozi
         FXgeYrrvZVMpO+bgL6mgGuyzHxUIqGZUqC7GiPlUGq+i8+IJzbwX+zy8o4LblLQnwuTF
         1t8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N8D4dOtEO5MSbMPQgbZVh96Yr52JhSt0gBh/mkTHwTk=;
        b=Pthy7/iwHidMW9FvJ0ieDbEBisnv07FhcFKzKlT9K7Ff92TnkbxHrVXJcYSJ8xa3nL
         2r8K10z9K7D1geb9cLY5L6dDMuLVA2WsWL/CPpTTv7rjjmb43xVZv39wP3Gu90cNKbwe
         SGOx+C3nm8CO/Cjt95VIj0ztTaTRwEPYfIR3QaIR87FTl+IlyAgl0vBK5u3kV69YoXZc
         Fccg3vD0Nv8e6z7hRU0O7PjyIJ7gFkn21HfSsJIoAuT9ZSJKynXs0yAI+O1CptPG4pkt
         xYyvFX/uv2ejR8bI5XsrBA4gJ107pxcCJquU4p7dDJ08mbaEyaumaa5gDEih6mbPORrz
         oCLQ==
X-Gm-Message-State: AOAM5304BEZnHAo+70jeKfxmYqo09nh5V9txxjtiCnhEYL6c6W2NY0Li
        /waJtKlaWtZMyubiBBF/nNKcKII4fwIOlPk6vcx4ww==
X-Google-Smtp-Source: ABdhPJwxCHB2el/67vNsvKOGjOS/pfNJW+HaA9YvqAeTMeFI9WzuFNdYNDMSK2TEnsRVbX087TjDwhXbRnbTYkvu9tU=
X-Received: by 2002:a25:9c02:: with SMTP id c2mr1045324ybo.228.1604648630629;
 Thu, 05 Nov 2020 23:43:50 -0800 (PST)
MIME-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com>
 <20201104232356.4038506-18-saravanak@google.com> <20201105094350.GG3439341@kroah.com>
 <CAGETcx--D_KCpvK3b9NAQbMgWxzYT6MGEav1h2M8V7f=wK5L6A@mail.gmail.com> <20201106072410.GC2614221@kroah.com>
In-Reply-To: <20201106072410.GC2614221@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 5 Nov 2020 23:43:14 -0800
Message-ID: <CAGETcx85S1MeZTPTs+0c+ZGVziaiU9WvSJSo8sM2xeo8MDPRgw@mail.gmail.com>
Subject: Re: [PATCH v1 17/18] driver core: Add helper functions to convert
 fwnode links to device links
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
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

On Thu, Nov 5, 2020 at 11:23 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Nov 05, 2020 at 03:32:05PM -0800, Saravana Kannan wrote:
> > On Thu, Nov 5, 2020 at 1:43 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Nov 04, 2020 at 03:23:54PM -0800, Saravana Kannan wrote:
> > > > Add helper functions __fw_devlink_link_to_consumers() and
> > > > __fw_devlink_link_to_suppliers() that convert fwnode links to device
> > > > links.
> > > >
> > > > __fw_devlink_link_to_consumers() is for creating:
> > > > - Device links between a newly added device and all its consumer devices
> > > >   that have been added to driver core.
> > > > - Proxy SYNC_STATE_ONLY device links between the newly added device and
> > > >   the parent devices of all its consumers that have not been added to
> > > >   driver core yet.
> > > >
> > > > __fw_devlink_link_to_suppliers() is for creating:
> > > > - Device links between a newly added device and all its supplier devices
> > > > - Proxy SYNC_STATE_ONLY device links between the newly added device and
> > > >   all the supplier devices of its child device nodes.
> > > >
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > >
> > > Did you just add build warnings with these static functions that no one
> > > calls?
> >
> > The next patch in this series uses it. I'm just splitting it up into a
> > separate patch so that it's digestible and I can provide more details
> > in the commit text.
>
> But you can not add build warnings, you know this :)

I know I can't break the build because that'll screw git bisect. But I
thought warning that's fixed later in the series might be okay if it
helps readability. I know now :)
>
> > Couple of options:
> > 1. Drop the static in this patch and add it back when it's used in patch 18/18.
> > 2. Drop the commit text and squash this with 18/18 if you think the
> > function documentation is clear enough and it won't make patch 18/18
> > too hard to review.
>
> It is hard to review new functions when you do not see them being used,
> otherwise you have to flip back and forth between patches, which is
> difficult.
>
> Add the functions, and use them, in the same patch.  Otherwise we have
> no idea _HOW_ you are using them, or even if you end up using them at
> all.

Sounds good. I'll squash them.

-Saravana
