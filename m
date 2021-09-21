Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD9A41333F
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Sep 2021 14:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhIUMPg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 21 Sep 2021 08:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbhIUMPf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Sep 2021 08:15:35 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E4BC061574;
        Tue, 21 Sep 2021 05:14:07 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id v24so73536048eda.3;
        Tue, 21 Sep 2021 05:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EA2T5sDryf1wshg82J637OYfNBLeVAzy/N9k8uhkKT8=;
        b=qZ6jLDrl1r/sGyHAotEko+QsWepOgK3neypqxen2BDwFbOyCNiD9DZZReBipSyZTKT
         /HOeM4NPjWDsmGxDjphfovxqkD/d14Z7fM+h2ZA/8T9HeZcsKLW6BHJ1cqyN0SX73Zn7
         jHZW693e1ONmRgl0WCnh6kEkwGUsWBmuKyKpy1SNr448N2wyrL2B9ZgLmepokfWtP4e2
         3Knmk7jAIgBey5wfCM75OofTo/Swa2MkfVNn+H5gAoL0c9xK2oPPln0bwTBZJYbmgt2c
         lDOs8hOio67hYgybSBI7mgZUVMtHvBltLbBvqs5PZaFOE0rDdVke74vywzEOJrYtYdYS
         0m+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EA2T5sDryf1wshg82J637OYfNBLeVAzy/N9k8uhkKT8=;
        b=8JRFM0PWMae4z+5qZ3xwMqhMFxYAtFDHfrMqktlAUDpG9lrxzLBanYO+LYGxb/Kt+V
         q9LQJaM2HVyUBKZOLQppB7Lxg8A82p+9vdxDByi5cI/5xxh9lWy0hxSnVIRCtVhMGnvG
         9OViNeMODVjc4ETnSILQ+wk8CSPOnKI4leKWxjab2rWYNneTThf8Dt1EKu6lKBzY1zQz
         KdQph8dMPZztXm1JR20OrRNCVyJTwqKxnDn+UCiRtvXOWYnZXIqgvMmX3OYx+Rm6mtJw
         ircg6dfz/x6HYmxg0mPGu6mNH7YVtPAzvb6sEniCMEzo1Drvle/deayKbejIvdk26ACm
         l2WA==
X-Gm-Message-State: AOAM5312WFcCbrcaOZN7JgZRKakXCrozZFEVzUJavAreL6W8ihcZB/X9
        4/bdlNBr524oeJYsTurnbIsuQJa2sODKdNpAB1A=
X-Google-Smtp-Source: ABdhPJzYckj7Qew5qhg3H25MAZrv1yE2lUHXGxCKD0KdGmz+WWCcporJRB70briSvnRZrWy+dQE8/VzVKcELZ0f7iLg=
X-Received: by 2002:a50:e188:: with SMTP id k8mr14443733edl.119.1632226442003;
 Tue, 21 Sep 2021 05:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210816104119.75019-1-hdegoede@redhat.com> <YRpWxnZvM2kzjcX/@smile.fi.intel.com>
 <e7c1b41a-4d11-21f4-0add-9b6dd00a8da6@redhat.com> <16df7a43-919b-5ad7-7ca7-025c669ba32f@redhat.com>
In-Reply-To: <16df7a43-919b-5ad7-7ca7-025c669ba32f@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Sep 2021 15:13:23 +0300
Message-ID: <CAHp75VfhCswzUQA0veYE0OmqOitbnqYo5EnmycV2j69+0n+unw@mail.gmail.com>
Subject: Re: [PATCH regression fix v2] gpiolib: acpi: Make set-debounce-timeout
 failures non fatal
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 20, 2021 at 7:47 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 8/16/21 2:28 PM, Hans de Goede wrote:
> > On 8/16/21 2:15 PM, Andy Shevchenko wrote:
> >> On Mon, Aug 16, 2021 at 12:41:19PM +0200, Hans de Goede wrote:

...

> >> Yes, I also think that we need to choose upper debounce instead of rejecting
> >> the settings. And yes, I agree that for now it's not suitable as a fix.
> >>
> >> That said,
> >> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > Thank you.
> >
> > FYI, I've prepared a patch to choose the upper debounce time for
> > pintctrl-baytrail . I'll test it when I'm back home tonight and
> > then submit it upstream.
>
> Ugh, I just noticed that this is still not upstream (not in v5.15-rc2), while this is
> a regression fix!

I think it was late for Bart to pick this up.

> Can we please get this merged and send to Linus ASAP ?

I'm on vacations now, but if Mika or Bart or Linus can handle this, my
tag is there :)

-- 
With Best Regards,
Andy Shevchenko
