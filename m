Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E98344880
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Mar 2021 16:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhCVPDC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Mar 2021 11:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhCVPCt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Mar 2021 11:02:49 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE3EC061574;
        Mon, 22 Mar 2021 08:02:49 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c204so11113682pfc.4;
        Mon, 22 Mar 2021 08:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gevBJGtuhfbcYhKJ9JR81B9fz9ohjjKDV5B4FvK7CJ4=;
        b=mLX/Ev+jbyaa2D0U8NpOi89oc8T/SNEr9n0az6f6tsV7CGP2NDNQEL66wLtajWGbTJ
         35RnbrNwrxAwyIThGp9vz+i3IQD8jPthfUJO1oBHZBs4t3lx2v666iiVhbuN3QG+2r5X
         8MXYK06e/+X1/tGhflAqo6u0fjU6BJKIxhZz8QCV1xJj2D8pF2xzwHw0RM6fEVScRYVU
         DAkZS7jGkoOf+cHjBvZt5h6wR2/p5QZRP67EDIaEihdxy1rTMCW3nOPOqo+lkGgMsICM
         D+9US0mS1nEDNRFED2NV5qaXIGalo9MmeCdjNCmrItCSigGDtM3oXEXlla+DI6bafxUL
         +iBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gevBJGtuhfbcYhKJ9JR81B9fz9ohjjKDV5B4FvK7CJ4=;
        b=GmErk3hFjZ1W3QkiwXF8iS+OTVVlC5UlTiLirdPV8ACFEU6HRqayvQZMmSLGoQLBXa
         heOgNKO7GAyQDDrNU3UhB/0hP0sXP3F2mpJU8vn/D4HGHb410yzmXGmAROKtA2HbqKSb
         27h495YBdGOE+KgibMuCZWcu9SN3ZKyP5DawL53sgZFMAcNFtbbJXHWcTbcLZCl+UcZZ
         f0t8TSObRMlxFOXGhdMg8dLjpmNdyRUfqcmLRa+DxaraYjOX6xRNJppnwFaRPaw8++Sl
         NhAKf1yPVw20bOP2nYmPd3Tuq+MQqKmU8JJXHg4lx5Wze0T0F/kjhTzYv2SgnS2sx1yw
         1Saw==
X-Gm-Message-State: AOAM531wND6eGQmvS7qLRcvKw7RQjP24Aw4XKl5iR7ec0PTSpa8I9y8r
        FjrYAbvl5yUSvuX2onvGhd32gB+FfKqRN+dLJqI=
X-Google-Smtp-Source: ABdhPJz3Rhyw6UesM6IMn2STqQuI0esZDTE13C/dJ1f1Tt/1J+jY3/29L9dLOxZ3n1aTuiiDdf+p2oj3yY6GGn4y/rU=
X-Received: by 2002:a63:ce15:: with SMTP id y21mr77083pgf.4.1616425369102;
 Mon, 22 Mar 2021 08:02:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210319192109.40041-1-andriy.shevchenko@linux.intel.com> <CAJZ5v0gcqKiXKzEj6u7vq_1Y9pYBdSGA6yT3q6JPVgW4djSiaQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gcqKiXKzEj6u7vq_1Y9pYBdSGA6yT3q6JPVgW4djSiaQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 22 Mar 2021 17:02:33 +0200
Message-ID: <CAHp75VeVhHhkzPVdGRa9inLJtW0QF=dDp3jB-U1xvKWRY_pbyw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] ACPI: scan: Use unique number for instance_no
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 22, 2021 at 4:57 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Mar 19, 2021 at 8:21 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > The decrementation of acpi_device_bus_id->instance_no
> > in acpi_device_del() is incorrect, because it may cause
> > a duplicate instance number to be allocated next time
> > a device with the same acpi_device_bus_id is added.
> >
> > Replace above mentioned approach by using IDA framework.

...

> > +       result = ida_simple_get(&acpi_device_bus_id->instance_ida, 0, 255, GFP_KERNEL);
>
> This is ida_alloc_range(ida, start, (end) - 1, gfp), so I think it
> should be 256 above, instead of 255.

Ah, good catch!


> While at it, though, there can be more than 256 CPU devices easily on
> contemporary systems, so I would use a greater number here.  Maybe
> 4096 and define a symbol for it?

I was thinking about it, but there is a problem with the device name,
since it will break a lot of code,
And taking into account that currently we don't change the behaviour
it is good enough per se as a fix.

That said, we may extend by an additional patch with a logic like this:

res = ida_get(4096)
if (res < 0)
  return res;
if (res >= 256)
 use %04x
else
 use %02x

Would it make sense to you?


-- 
With Best Regards,
Andy Shevchenko
