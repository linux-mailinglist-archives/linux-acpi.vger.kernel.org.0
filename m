Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F31131A29F
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Feb 2021 17:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhBLQZh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Feb 2021 11:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhBLQZZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Feb 2021 11:25:25 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB59C061756;
        Fri, 12 Feb 2021 08:24:44 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id s15so106477plr.9;
        Fri, 12 Feb 2021 08:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AyVdYp4XHpNQZCGZsh4I/si/qqoq8d7SNCRAzCX5430=;
        b=mAUeC2hEZ16mr8DoI+7evauEUBx8cjJvy7mwPfEFFprnn1Hm5uuAAvx2irH76Ulsqb
         91xdKn7n8nW2ma/Zu173h9fXffdB3CtBPI0gwkdKJk0Qv1g5+O25OGlJHJVCO8r7e0zd
         W4P4zcWIv3YaLiOLh24RsA/apkxpSyTJ6bhgaPEQcnG9egk1Jsrow6dziPUQv36ouF59
         Vdo1Pz7O1NUy7whdJbC6BCfB9dWfu4hpzX99M3uw7Sb0YByWsYbGXKv85Dmj3yAfrGa3
         PsrD8Mh1R02RCyJe73iXJq3U+DmgehE1qxy0uv0+qvDnzqCHGpBgtxF0BtGn9iazUbcc
         EGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AyVdYp4XHpNQZCGZsh4I/si/qqoq8d7SNCRAzCX5430=;
        b=YSSjzXpUz2QOT8jnD2wtcts50QDjrsTGDHtX7rUs6+arAG8pVbVuXJUtOIvw0V9Gh5
         zwIPn0ykNTFco2ZLFKs+KhmNdbss3TWDRRGgpBD/rl4pHqbYQs8Hg8R+L8QSHoH1ABjW
         FM99+CVpTIJNPYutxr75gKobk/koE0lZkNPdpV8PNX2GeUPIUAOLKHQZQonHutZjcg7o
         LColA2Pa74Nn80Q3Tq+uokq9xEOwVG3TYRN9c9CARCV7j/+JntAYnEABzIy1QotSxtKM
         5v2FEAp/UdPTEbBMsU0D2bzlcy5Zp2GIT69VEiwXqVc/2Q5gbvwEQAm1n1BFUrrIMm2l
         CVTg==
X-Gm-Message-State: AOAM531Ce9HR+rbljNtrAeNEXyipFBpqITVeRDCtATEyRUFAqP9+G+DD
        L8pU7OiltTKMMP5KAUp2pZ+BGnH5qWJM0GlTclQ=
X-Google-Smtp-Source: ABdhPJz0mqyw/DHAX7vfCsptEAXofYBiy5jaxju5oOgLtcZiVvSwS/XSGhlOmyJpvs/W2rwiEMtWZ05jVRbjnsHguAk=
X-Received: by 2002:a17:902:be14:b029:e1:bec9:f4a7 with SMTP id
 r20-20020a170902be14b02900e1bec9f4a7mr3490949pls.21.1613147084314; Fri, 12
 Feb 2021 08:24:44 -0800 (PST)
MIME-Version: 1.0
References: <20210212141121.62115-1-andriy.shevchenko@linux.intel.com>
 <20210212141121.62115-5-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0jot6w2AdTCmxn4Hw2zOzJk2JSrTaeH9cQR4or2N9HjCg@mail.gmail.com>
 <YCamNlCxK9nb8XrZ@smile.fi.intel.com> <CAJZ5v0i=YT_pqSC+WJoZYOvA0oM4nwJhnPuD46WjezQGPJGJXw@mail.gmail.com>
In-Reply-To: <CAJZ5v0i=YT_pqSC+WJoZYOvA0oM4nwJhnPuD46WjezQGPJGJXw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 12 Feb 2021 18:24:28 +0200
Message-ID: <CAHp75VcvVuZR-dyKZcPW2TwgT8RDT6z78kbdarv79YG_NY=C3Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] ACPI: property: Refactor acpi_data_prop_read_single()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 12, 2021 at 6:11 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Feb 12, 2021 at 5:01 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Feb 12, 2021 at 03:31:24PM +0100, Rafael J. Wysocki wrote:
> > > On Fri, Feb 12, 2021 at 3:14 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:

...

> > > > +       if (ret)
> > > > +               return ret;
> > >
> > > else if (!val)
> > >         ret = 1;
> >
> > But then it become a bug again :-)
>
> I'm not sure why?  The checks below will still happen and they may
> cause an error to be returned.

Oh, I misinterpreted ret = as plain return. Right. Seems okay.

-- 
With Best Regards,
Andy Shevchenko
