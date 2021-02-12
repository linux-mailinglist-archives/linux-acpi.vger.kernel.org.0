Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F3831A25B
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Feb 2021 17:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhBLQI3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Feb 2021 11:08:29 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:42600 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhBLQI2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Feb 2021 11:08:28 -0500
Received: by mail-ot1-f45.google.com with SMTP id q4so8831150otm.9;
        Fri, 12 Feb 2021 08:08:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+G8XBVjXwm5XDZ421FxNMfiS7Gmj2H4sQBSVF81T++Y=;
        b=H1DwysWb2BPsydIKU4uoyAb1CEBpX8sfW0DMuUBpUaSC/A2pXWeZlMTOeotqfFXXwn
         JJoAQjM/35/ExFWXUj7l6fdiGS1KFQDBFeif5BfMDTSiiYuvO6bRYS/7ameXTKhhiQoY
         YV/1ZA/RWYe2/pKFOwGH+pwIm0ClluwRWVz8CtG0YgB53ZTJ3TWkM8oOkHJZCI9kfu6Z
         3KhCb34w+ei+FBlIWPVm4jFm9jncr/vatl9W2ODw9oamI7YH6SE2O5u3Q2j5A37z+GlJ
         KiFPzt00RQQVUql3ivOwdmBr3G20XhReTyf1nuPwGMen63tYUdCVGAv3incmeFflwrBO
         q63A==
X-Gm-Message-State: AOAM532WUtFOjULboB5kQgAwcj/NjyQUQJeUFQOnhifjkEt4SBWtLOpi
        2glwoVPaFkHzdkANq3zg+oRZlDVZvEigrHIRrlA=
X-Google-Smtp-Source: ABdhPJzl69TzQu1ArbwzpEWW1bdjXmMFmeXfxG7zifnFieYvjZjoYn8ppavsmvSJT1UNpoKBRA3YjmRoNSbUrqfWcEI=
X-Received: by 2002:a05:6830:1481:: with SMTP id s1mr2567673otq.206.1613146066028;
 Fri, 12 Feb 2021 08:07:46 -0800 (PST)
MIME-Version: 1.0
References: <20210212141121.62115-1-andriy.shevchenko@linux.intel.com>
 <20210212141121.62115-5-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0jot6w2AdTCmxn4Hw2zOzJk2JSrTaeH9cQR4or2N9HjCg@mail.gmail.com> <YCamNlCxK9nb8XrZ@smile.fi.intel.com>
In-Reply-To: <YCamNlCxK9nb8XrZ@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 12 Feb 2021 17:07:34 +0100
Message-ID: <CAJZ5v0i=YT_pqSC+WJoZYOvA0oM4nwJhnPuD46WjezQGPJGJXw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] ACPI: property: Refactor acpi_data_prop_read_single()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 12, 2021 at 5:01 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Feb 12, 2021 at 03:31:24PM +0100, Rafael J. Wysocki wrote:
> > On Fri, Feb 12, 2021 at 3:14 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
>
> > > Refactor acpi_data_prop_read_single() for less LOCs and better maintenance.
>
> Thanks for review, my answers below.
>
> ...
>
> > > +       if (ret)
> > > +               return ret;
> >
> > else if (!val)
> >         ret = 1;
>
> But then it become a bug again :-)

I'm not sure why?  The checks below will still happen and they may
cause an error to be returned.

> ...
>
> > And this is just not looking good to me, sorry.
>
> Yeah, I think this patch is not needed right now. At least it seems no gain
> from it.

OK
