Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8493F2E9F
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Aug 2021 17:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240967AbhHTPNz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Aug 2021 11:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbhHTPNz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Aug 2021 11:13:55 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BBCC061575;
        Fri, 20 Aug 2021 08:13:17 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id o2so9475794pgr.9;
        Fri, 20 Aug 2021 08:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZLsQBmbYPy6TkjNymlou640ZLna2BWSi56DTvRZ7JDI=;
        b=MbzDdKH7+C0WQP7+AdNCxPK0vlRWRMmtPT+Em7Ps/ooufmAqDcZUY0sk3UawUAGAs+
         Mr/h1dZC7EsiDKDhFiut+9P/4ilY5Wg4lTX2RQTTwOHUZGDyM+Xg5Lms5mZzAtfBqxq3
         yigCNhLWKqU2GdPoc/pdePjfnfZrNZIpQRUe1/EPX+fJiGFTgg283/QA9kbb74bVkGbb
         g3FSBjD2UyVr7u+Qlv05oZorzfo+zdbUxs8DwetYbxkIaSaVnS9Z/u2OweB81wTOQ5KQ
         iTTl542GhLhDTucMFXIZMl3rxmQwGmEqs0/NAH+vPmgJ/+LS3qMyCcVBRPoxvnD4DWOJ
         UELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZLsQBmbYPy6TkjNymlou640ZLna2BWSi56DTvRZ7JDI=;
        b=Sb279YXuUNitXMFH9M1qGNUFJxlXjoO5j6DPRBxfdXUVq+IEQ4OB4oCd84YNulOjwx
         cFUesrqlXVBNQ3zRe1sswmiliEMwq/Qb1Hz2AdUtF8AcpnZ6fo8Vk7NsUfLQfxFNtbeT
         OpNM3sRQaeJx13LXRKn5rGQendrIyyMSEWkVbaGsbN5i1aDpvirxdV3nl/Geb6HVuc6C
         Z5sZi2f4tkvlG6+/DMupZQBnwt/6fGs1p+A/h6bELPn8SddQ/od+Oyb4rVUDntEeqKOe
         0lfxRZXg19LFop0Yr23KWk5n2/h/qfwZgpLlyfBxUQvVDs4TRi5oU8rUdK/gfEwMKnHT
         SQOA==
X-Gm-Message-State: AOAM5308FmHAlSkyWu9stVe9PaTzNeIs6/gBdX7o2LuWYS/g3Ip9Vhzn
        SUUM81x/h1JE0P+8EBSPGFcgZYLK6OJMqIw0uCLs/ZbB8XQ=
X-Google-Smtp-Source: ABdhPJxbmIqRf1r08fp79EQIOZACHUYpl9unVHIHWEk04df8kienN+545VPNB0DJ7XYasXxcs021C7JxIhNqC6jEEVE=
X-Received: by 2002:a65:63d6:: with SMTP id n22mr17071651pgv.74.1629472396869;
 Fri, 20 Aug 2021 08:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210414083022.25453-3-me@fabwu.ch> <20210712090326.7064-1-me@fabwu.ch>
 <20210820131207.GB3@paasikivi.fi.intel.com> <CAHp75Vf=1aKx=SN60rGpUpgvXEryq9w1R7NRi0nCG49jWWzefg@mail.gmail.com>
 <20210820150241.GC3@paasikivi.fi.intel.com>
In-Reply-To: <20210820150241.GC3@paasikivi.fi.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 20 Aug 2021 18:12:37 +0300
Message-ID: <CAHp75VdBLaiW=G+BaPHX7-wMoVHqQ1mfC5ijCUTyRckDz2EV6Q@mail.gmail.com>
Subject: Re: [PATCH v4] ipu3-cio2: Parse sensor orientation and rotation
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc:     =?UTF-8?Q?Fabian_W=C3=BCthrich?= <me@fabwu.ch>,
        linux-media@vger.kernel.org, Jacopo Mondi <jacopo@jmondi.org>,
        Dan Scally <djrscally@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 20, 2021 at 6:02 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
> On Fri, Aug 20, 2021 at 04:25:15PM +0300, Andy Shevchenko wrote:
> > On Fri, Aug 20, 2021 at 4:12 PM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > > On Mon, Jul 12, 2021 at 11:03:26AM +0200, Fabian W=C3=BCthrich wrote:
> > > > The sensor orientation is read from the _PLC ACPI buffer and conver=
ted to a v4l2
> > > > format.
> > > >
> > > > The sensor rotation is read from the SSDB ACPI buffer and converted=
 into
> > > > degrees.
> > > >
> > > > Signed-off-by: Fabian W=C3=BCthrich <me@fabwu.ch>
> > > > Reviewed-by: Daniel Scally <djrscally@gmail.com>
> > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > >
> > > It's in my tree now.
> >
> > Do you know what's going on with
> > https://lore.kernel.org/linux-media/20210726084055.54887-1-andriy.shevc=
henko@linux.intel.com/
> > ?
>
> I thought you'd be merging that through the other tree where the other
> patch was merged.

Ah, okay, let's ask Rafael if he can take this for v5.14 cycle.

Rafael, I can resubmit a new version with Sakari's ACK. Or you may
retrieve this by message ID from lore. What do you prefer?

> I can also take it through the media tree. I guess by now it'll be the ne=
xt
> version in any case.

--
With Best Regards,
Andy Shevchenko
