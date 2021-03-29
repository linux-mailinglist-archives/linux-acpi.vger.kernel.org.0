Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED92C34D2D5
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Mar 2021 16:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhC2Ov3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Mar 2021 10:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbhC2OvS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Mar 2021 10:51:18 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32213C061574;
        Mon, 29 Mar 2021 07:51:18 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id h3so9993949pfr.12;
        Mon, 29 Mar 2021 07:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TtgJoHcRy4HrILByQHP0XtLCLwWzY0ytiVDAosaALmI=;
        b=GvbmuyzUK0XcLFnuTgzgiWC6Xn2EmVvqH1CYzweg/SfjBgajDHZozowXa6RI+/LdO5
         DXNU9xH4UVeiFB3is0qki2yur/kKiwd9aZyujfqJH8DZqQhBKzd9li0zBimiiOWdAJTG
         apVIMo6uLD5d85yJ5wcJV5Tq6g8hydbu6lNkKl8ARWlRLRXmRgD1rNuKu2xJSA9zMyvj
         zZP52MygYOQo5BtHC7SelvNyVDbqJDaOBfCcGKoSIOhAlWPmnF+AoF/DQ2n4YAnh0TP1
         MAS9qjKE4/7BnDCi2m7Sl8fhILeWEbw+9t4OoLYdX3CkJK3a9EsUpb+V229VFtJD7W/R
         lfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TtgJoHcRy4HrILByQHP0XtLCLwWzY0ytiVDAosaALmI=;
        b=PJIp/SSmb2MpbGGeQBEVtmXcwjxc1YrExG4RVe9ryumyas6t9OH1WQAzY6PoJGkRsW
         SIAA4ylFNV+6SVhGrBiMHZwsYkLBDQS3lgKaImLAQ9HWaIhhymrxLv1kon0Bi3OTtVxO
         Zt0BlCySo8gRa9KLoRIq03Iy2RtnYa7ac7lFfs2OHySCNgBH5fEfVRW42cNcbsB8gBgn
         qGR8yrAitFzzkRdP9Sm20DyAbuwJ3HWGZ0/tjjWaZ13fmRZE/i/iCSaJazrnm7OfiHw3
         8NnRzUKbKC5mIEYHzLH3SQ4vjlyAu4pbQkiRL4xzndNsH7R3te00DaHiz9xwvoPDkeP4
         CsVg==
X-Gm-Message-State: AOAM531/137PXW9rEJbyewuNlQDTsznmC1aHHjEdQhOMvQGPwdFwyKn7
        xbjTq67OeAsdkD+OD9waEzD3tQ3ODMt5jP94oE4=
X-Google-Smtp-Source: ABdhPJwZCI4bilYL0u7DfEXdhw7ru/FjBc8O1UxeqAHmeF6XEhOWqOcZcOrYX4N4pMlcXqXhKmpJOxWCqu/NHpa2/+M=
X-Received: by 2002:a63:cb44:: with SMTP id m4mr1667281pgi.4.1617029477672;
 Mon, 29 Mar 2021 07:51:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210327222012.54103-1-andriy.shevchenko@linux.intel.com>
 <20210327222012.54103-3-andriy.shevchenko@linux.intel.com>
 <YGAmB2Nwph6pArXc@kroah.com> <CAHp75VfFzqpdR+6p9vQww-ujQcw3L-V_N7ezUTGhcRmvwvqMZg@mail.gmail.com>
 <YGB+YMh1MsQao3zS@kroah.com> <YGHPnkoB/wP6u6HC@smile.fi.intel.com> <YGHaTf+cpvAZ5geB@kroah.com>
In-Reply-To: <YGHaTf+cpvAZ5geB@kroah.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Mar 2021 17:51:01 +0300
Message-ID: <CAHp75VfEN4HAX=BUZNp+-kKD1B1WVU2oeG2SXyaw=EWVa-CAhA@mail.gmail.com>
Subject: Re: [PATCH v1 3/8] software node: Show properties and their values in sysfs
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 29, 2021 at 4:46 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, Mar 29, 2021 at 04:01:18PM +0300, Andy Shevchenko wrote:
> > On Sun, Mar 28, 2021 at 03:02:24PM +0200, Greg Kroah-Hartman wrote:
> > > On Sun, Mar 28, 2021 at 03:56:26PM +0300, Andy Shevchenko wrote:
> > > > On Sun, Mar 28, 2021 at 9:47 AM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > > On Sun, Mar 28, 2021 at 12:20:07AM +0200, Andy Shevchenko wrote:
> > > > > > It's very convenient to see what properties and their values
> > > > > > are currently being assigned in the registered software nodes.

...

> > > > > > +             for (i = 0; i < prop->length / sizeof(u8); i++)
> > > > > > +                     len += sysfs_emit_at(buf, len, "%u,", ((u8 *)pointer)[i]);
> > > > >
> > > > > No, sysfs is "one value per file", and that is not what you are showing
> > > > > here at all :(
> > > >
> > > > It is following: it's a "one value" for property in question,
> > > >
> > > > As we may read in [1]: "...so it is socially acceptable to express an
> > > > array of values of the same type."
> > > >
> > > > And here is exactly the case: *values of the same type*.
> > >
> > > So what is it going to look like exactly?
> >
> > Basically we have two approaches (already done in the kernel!) use space or
> > comma for a separator. So:
> >  - for boolean it will be an empty string (and it's one value always)
> >  - for integers it will be, for example, '0,1,2' (w/o single quotes)
> >    for property array with values 0, 1, and 2
> >  - for plain integers or arrays out of 1 element it will be plain integer
> >  - for strings it will be, for example, '"str1","str2"' (w/o single quotes)
> >    for array of string { "str1", "str2" }
> >  - for single string or array out of 1 element, it will be '"str"' (w/o single
> >    quotes)
> >
> > This should be a part of documentation.
>
> And I will complain then too, these "lists of values" are not for sysfs,
> sorry.

How can you recommend showing an array(s) of values of the same type?

> > > And what tool is going to be
> > > there to parse this mess?  Who is going to to use it?
> >
> > I guess something like hwinfo (needs a patch).
>
> If nothing needs this, then why are you adding these?

OK, I will prepare tools first, but I have no idea for the format. So,
how can I be sure that tools will accept the patch if there is no
kernel interface available? Seems like a stale case.

> > The idea behind that this is following what ACPI and DT provides to the users
> > via /sys/firmware/ (however, in binary format). I can re-do to provide a
> > binary, and it will effectively make software nodes in align with the rest.
>
> binary files in sysfs are only to be used as a "pass through" from
> hardware to userspace.  That does not seem relevant here.

This makes sense.

> sorry, please keep this out of sysfs for now.

OK. For now I will resubmit the rest with addressed comments.
Thanks!

-- 
With Best Regards,
Andy Shevchenko
