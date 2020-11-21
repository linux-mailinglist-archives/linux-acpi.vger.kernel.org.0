Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B162BBBBD
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Nov 2020 03:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgKUCAX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Nov 2020 21:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgKUCAX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Nov 2020 21:00:23 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8804FC061A48
        for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2020 18:00:21 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id x17so10339571ybr.8
        for <linux-acpi@vger.kernel.org>; Fri, 20 Nov 2020 18:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ycGf66kvaYrLmdh3G+aCiWw8LB61gZe9GTCWFcB4rE=;
        b=j9fW+Rch9vX4uBVv6QiV4xPZnWddbVzAZ+B6JwtYcvwqUbueVGWGawGEMfe7QmGLEz
         P9m+3AFUcdwjQNKoUpjkOhzsYIpYby5fdyYtvyo/TPHaFtsQnQBpm8b0Mn0esIUVxHW7
         ITNUKEgWSH1RJ4p3FEQQ1fchBY3xz2fyvREP3n6OHtrJ8ejt6Ya1c/VnI5Qjh/1kZ9L3
         vFvAmV1j67ieejnWkVQ/TsbVQ+DutIma5WmdvIe103aX4hAmqNdTp7U2Uo1+gTxHAOlt
         qhv8yh9EqbN3XMN0+G7boR/RaXq0xVPhhu/Nfe1ykAJL9W+fIM077v3XWkqjKzwPnSLE
         Fupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ycGf66kvaYrLmdh3G+aCiWw8LB61gZe9GTCWFcB4rE=;
        b=tq8n+InWV7LSF4E3CHCXgwIVUZTwBFzkT98jX6p8zt/+FYSpRoW7oafl/jjqi/O5xY
         /XzZzNgothgM1+UhD59itrHmsJOGm00pTVXjZcaI4h1HBxHqrrwkmPVBrCJ7/herqsfi
         SyrL4bwTKmPVjsEBQMXiJ9cL7QSuecB737ix3Tjh+kwVP8EFv9YS3Dyou3KUm+PIKVKX
         U0JmV5JCGIgQ2ZDEqnS1yRlA+zM7wPxsnJu1/q2vlUkn4lyOyuFNBs/n3GzRnWpeVULu
         qtz1vKNUlx+tMdp8S0+YbOuobHlTfrP5QGv8JqkaEKhLxYOBcxGzI2+C2xXOMwWY+NQ9
         +fBg==
X-Gm-Message-State: AOAM532PCvnkTk/eEmWkssx/CVDiyUM41TGOmTcHR8mdtkEsTKX+i9fl
        su2z7NB0x4z0Zk6LCn1aDiAz69MqXV46oqyFFiZDgg==
X-Google-Smtp-Source: ABdhPJzmti3j25/p9ucrFMH9zeXSUBLReU/TTBO4O7VjGDy1OKygDmnDqi1xN6WvnIkmq8twCFtNDIkwLGgOT0E/7J4=
X-Received: by 2002:a25:c483:: with SMTP id u125mr23453145ybf.310.1605924020602;
 Fri, 20 Nov 2020 18:00:20 -0800 (PST)
MIME-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com>
 <20201104232356.4038506-10-saravanak@google.com> <CAJZ5v0h31RrsrU4F1tjZKQ1O8BFWtkDJxkwyWoKBzm_kyknxVQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0h31RrsrU4F1tjZKQ1O8BFWtkDJxkwyWoKBzm_kyknxVQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 20 Nov 2020 17:59:44 -0800
Message-ID: <CAGETcx-DxkuCE2EuiBoevXobVb55M5WXa+d1syK2u-rUu6Z7Jw@mail.gmail.com>
Subject: Re: [PATCH v1 09/18] driver core: Allow only unprobed consumers for
 SYNC_STATE_ONLY device links
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
        "Cc: Android Kernel" <kernel-team@android.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 16, 2020 at 7:57 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Nov 5, 2020 at 12:24 AM Saravana Kannan <saravanak@google.com> wrote:
> >
> > SYNC_STATE_ONLY device links only affect the behavior of sync_state()
> > callbacks. Specifically, they prevent sync_state() only callbacks from
> > being called on a device if one or more of its consumers haven't probed.
> >
> > So, creating a SYNC_STATE_ONLY device link from an already probed
> > consumer is useless. So, don't allow creating such device links.
>
> I'm wondering why this needs to be part of the series?
>
> It looks like it could go in separately, couldn't it?

Right, I just wrote this as part of the series as I noticed this gap
in the error checking as I wrote this series. It can go in separately.

>
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/base/core.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 1a1d9a55645c..4a0907574646 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -646,6 +646,17 @@ struct device_link *device_link_add(struct device *consumer,
> >                 goto out;
> >         }
> >
> > +       /*
> > +        * SYNC_STATE_ONLY links are useless once a consumer device has probed.
> > +        * So, only create it if the consumer hasn't probed yet.
> > +        */
> > +       if (flags & DL_FLAG_SYNC_STATE_ONLY &&
> > +           consumer->links.status != DL_DEV_NO_DRIVER &&
> > +           consumer->links.status != DL_DEV_PROBING) {
> > +               link = NULL;
> > +               goto out;
> > +       }
>
> Returning NULL at this point may be confusing if there is a link
> between these devices already.

But the request is for a SYNC_STATE_ONLY link that can't be created
when this condition is met. I see it similar to the error check above.

I think returning the existing non-SYNC_STATE_ONLY link gives the
wrong impression that the link was created successfully. Also, if I
find the existing link and return it, then I need to refcount it
(conditional on STATELESS?) and
the caller who shouldn't be trying to create this link should now need
to keep track of this and release it too. I think it's cleaner and
simpler to just return NULL.


-Saravana
