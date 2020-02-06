Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE0E15487D
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Feb 2020 16:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgBFPuO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Feb 2020 10:50:14 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39122 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbgBFPuN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Feb 2020 10:50:13 -0500
Received: by mail-oi1-f195.google.com with SMTP id z2so5032695oih.6;
        Thu, 06 Feb 2020 07:50:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dme5ZXIhoB7s1X55C4a4cs6GUqj0sOSW+0dvpNuwF5s=;
        b=Pbaec5apToXTPqzVwlnlJiOdcJYEZVv+xiGOs+TCCP1FduJiFEk6ZudYxWoS34f1fV
         z3pTyse/aPa8kWkuw/Vbp6v7BTceT3uzMVKcmmTK3JFnTIHj+IcGO2YEyGOXYWqL9u9b
         u7Wf1VGkhZWX2I+pFKX3SCpho1P9H461kfK5CtarO8moS+uC/RGE/0ef0O0I/amjJdM1
         Pr6AnvV2i3lv5n1ebt5o2XFvCT56MYblW9ghAtLRG9+IfhJigr8HVlBZ6UiQXxqLxJzH
         pftAQI9VGI180x8Ha3v9qmDLJWtxREYRwz0RkCcy8nb8pxQAqAtzK4ChtZRDvmGpiSzW
         hYlQ==
X-Gm-Message-State: APjAAAVlmZdY71Y9QfXXROr7tsuta+o/1ttwKKPIYs2wovJmiKCdZtvt
        B1xCLYB34bAuOZvoSTrLQAwVpDZG64bI64eU/5Q=
X-Google-Smtp-Source: APXvYqxCCk+BimuGWm5AIS6e1odagbKEyeB1EmFE2QrrC0fWxaPfH77Gqt/APbhXUMPtN9PYi6nXcaM3P2+gVL6PvZs=
X-Received: by 2002:a54:488d:: with SMTP id r13mr7072453oic.115.1581004212270;
 Thu, 06 Feb 2020 07:50:12 -0800 (PST)
MIME-Version: 1.0
References: <1580915129.23547.3.camel@suse.de> <20200205152435.GE2667@lahna.fi.intel.com>
 <20200205163048.GD25403@roeck-us.net> <20200205163831.GG2667@lahna.fi.intel.com>
 <20200206154532.359086d6@endymion> <20200206145602.GQ2667@lahna.fi.intel.com>
In-Reply-To: <20200206145602.GQ2667@lahna.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 6 Feb 2020 16:50:00 +0100
Message-ID: <CAJZ5v0i5+DaFM22jW=dS66JHK5=ydvMf4dBuJTMvGoNSZLOL3Q@mail.gmail.com>
Subject: Re: Forcing non-ACPI watchdog driver
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Jean Delvare <jdelvare@suse.de>,
        Guenter Roeck <linux@roeck-us.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, Tom Abraham <tabraham@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Feb 6, 2020 at 3:56 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Thu, Feb 06, 2020 at 03:45:32PM +0100, Jean Delvare wrote:
> > Hi Mika,
> >
> > On Wed, 5 Feb 2020 18:38:31 +0200, Mika Westerberg wrote:
> > > On Wed, Feb 05, 2020 at 08:30:48AM -0800, Guenter Roeck wrote:
> > > > On Wed, Feb 05, 2020 at 05:24:35PM +0200, Mika Westerberg wrote:
> > > > > You should be able to revert to iTCO_wdt by simply disabling
> > > > > CONFIG_WDAT_WDT from .config. Then acpi_has_watchdog() returns false
> > > > > which means that iTCO_wdt is used instead.
> > > >
> > > > That may not be possible in a generic distribution.
> > >
> > > Right, they would need to build their own kernel. Currently there is no
> > > way to do that without changing .config.
> >
> > OK, that's pretty much what I was compl^Wworried about ;-) Would you
> > consider applying something like the following patch?
>
> Yes, I think the patch makes sense.
>
> Rafael, I guess you will take this since it is touching ACPI?

Yes, I will.

> > From: Jean Delvare <jdelvare@suse.de>
> > Subject: ACPI / watchdog: Allow disabling WDAT at boot
> >
> > In case the WDAT interface is broken, give the user the option to
> > ignore it to let a native driver bind to the watchdog device instead.
> >
> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks!
