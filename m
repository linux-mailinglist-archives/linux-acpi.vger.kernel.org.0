Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DF21AC94D
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Apr 2020 17:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403757AbgDPPV3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 Apr 2020 11:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2408935AbgDPPVX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 16 Apr 2020 11:21:23 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F5BC061A0C;
        Thu, 16 Apr 2020 08:21:23 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r4so1791133pgg.4;
        Thu, 16 Apr 2020 08:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PqhlYvcZrmCM70l8lqNpCrbISzWwKQ5w1U1k6I8jKZA=;
        b=hKnRbOBsCft+ZCJ3dOvl2hctclPsJj4Mm+JVYqlNJxl8IHZr4V0qPXZZM+ivEpKEr3
         SiN+TJT7MwvBlrUZGKKnHLyuM09g2LTZ5sFEPYO2Bre9v1C57e3OEQzt+kQMlPAAU7bL
         jT0KyN96EsaQH2rinKl69nFDw/sZWH5DDkU/O4cF2UmDzXP9sncAFR8MLi/sIqWHacV1
         58Fu08H460YfxgFvw+eku5Xt1o1O02wzOt2uvW4l497UWGzwVRSjjjN32yjTL4x8Hb6/
         yTs+chUep9thohSNFC3EA5qoHgYo1fuIHABHIVuWXuQQUGEAO5L/w7IuMCsfcBrVTRll
         V8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PqhlYvcZrmCM70l8lqNpCrbISzWwKQ5w1U1k6I8jKZA=;
        b=Hzj7qJu9xBwq6KI+wckzFF1oSuRKCOwKOlT3ldv9A+dLzE4mdM08YNYwcRAB4/XhP8
         M3J2QmOGr2McDKNmWL5wo1Swx1ddTu2K45hMyBqlGRGOXq5mKuHaLzZf7hd580BThJSZ
         cRUx1q3o4tlmmv6bQCbMKXABtW1zROXuXCz3WppJp7nrj/2ikvJ+0dwi3XBHtIjiIrRB
         O6rM0X/w5SrkTPK5QycWmroJUM0yftqrP0fL5KGbpRShJbJFZvzWJS1qWMe8nwnDjfqv
         AHUQjFa1ur1BJ+Hqf5lDOxcA+CWhhyY6qA8c5/Ry+dk1/gXtB4nH54oPfdj+nYIm0wjS
         31Cw==
X-Gm-Message-State: AGi0PuZi1v5vaJuVNC+l5Xn46p3yWQkit2uxylndkxp5uneXSYDNnBHx
        4hkIeG3KZHN0uNhXFiAyOucYisPH+mh/aB86HJ8=
X-Google-Smtp-Source: APiQypL4QpTvQB0/qCwH/MWZ7VIatjMX02cplXwC/TTrnIKMzbV6jUInWZ+z6zydE0IKy2JVTEJ6y3JIo/biM4hFQT4=
X-Received: by 2002:a63:5511:: with SMTP id j17mr15897581pgb.4.1587050482349;
 Thu, 16 Apr 2020 08:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200408160905.12101-1-andriy.shevchenko@linux.intel.com>
 <20200416141730.GE185537@smile.fi.intel.com> <CAJZ5v0ihzD4knW=pKFmcsW0Q9c5rfyJMFh2ChiePe5SWO6G_TQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0ihzD4knW=pKFmcsW0Q9c5rfyJMFh2ChiePe5SWO6G_TQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 16 Apr 2020 18:21:15 +0300
Message-ID: <CAHp75Vf6MT1AFacUkRUP3760nv=3V5kzF2AHWJG64tr5yZ2=dg@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] platform/x86: intel_cht_int33fe: clean up series
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Apr 16, 2020 at 6:05 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Apr 16, 2020 at 4:17 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Wed, Apr 08, 2020 at 07:09:00PM +0300, Andy Shevchenko wrote:
> > > When I started looking into the intel_cht_int33fe driver for an example of use
> > > software node API, I have noticed that it's hard to get and code a bit messy.
> > > Here is a clean up, main part of which is to introduce node groups and API to
> > > register and unregister them. This and some pre-existing APIs can be used in
> > > the driver.
> > >
> > > So, because of cross-subsystem nature of this series, I may recommend to create
> > > myself the immutable branch which can be pulled to Rafael's and Greg's trees
> > > respectively. I'm also open for other proposals how to proceed.
> >
> > Greg, Rafael,
> > any suggestion how to proceed with this series?
> >
> > (It has been reviewed and tested).
>
> You can merge them through platform/x86 as far as I'm concerned, or
> please let me know if you want me to pick them up.

Works for me, but I would like to ask for formal Ack tag.
Thanks!

-- 
With Best Regards,
Andy Shevchenko
