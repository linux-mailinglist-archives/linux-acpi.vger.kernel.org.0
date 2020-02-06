Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92DD81548B6
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Feb 2020 17:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgBFQA4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Feb 2020 11:00:56 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44553 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbgBFQAz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Feb 2020 11:00:55 -0500
Received: by mail-oi1-f195.google.com with SMTP id d62so5036332oia.11;
        Thu, 06 Feb 2020 08:00:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fvJvICwK37du5Oq8Y4LCX9ZQZ4eVrqYZ+IjIFXfjt3s=;
        b=g4OlMWSQx25P0vADh/e/BtnEtPxEgF7DBXCq0vVCFshFJNBnvdGaWpOzOIZ10BZiM9
         hDyISJPmZXW7ulaLnL6XzPG1DhEr1RzHnzAyuZ7jZSVNLoikUQfOECF8AD7GLZaDLg8g
         JVKP64jJ0f6OnuopHvKcDPey2JgIJcz+DvoCchgWogroWW18Yq7kY74tWtPOAbzKOibg
         u3QX7k5wmn/VVd5n8S8sOPTM55vPvUTGuIxg+gZ9wcMDVkAMlxHfS5MnMzHV2OndGxTi
         m9Eh0FEHS9kTeBPjNpj1I1jAe+J+wb5KOIV+CXNFLEvUnIL+xmydM2f1laa3GBxtQWKe
         KpYg==
X-Gm-Message-State: APjAAAUW2yUBMLo0kIBZ22wt0cZm5d9Eds5yhiq2XiVZEX6KhWPSsKVu
        3qX2ckRYSnSHDoZMnhi1ePk8E0/3AOry59SC3JCtxA==
X-Google-Smtp-Source: APXvYqwicWYBwqggNoQsEMhbLgLOSWn+xf3kazbMGG8QE5UEvQpwP4fQID2Jm0BOmtksKyBkiTR/XQB2eA0StsSu0DE=
X-Received: by 2002:a05:6808:8e1:: with SMTP id d1mr7371015oic.68.1581004854930;
 Thu, 06 Feb 2020 08:00:54 -0800 (PST)
MIME-Version: 1.0
References: <1580915129.23547.3.camel@suse.de> <20200205152435.GE2667@lahna.fi.intel.com>
 <20200205163048.GD25403@roeck-us.net> <20200205163831.GG2667@lahna.fi.intel.com>
 <20200206154532.359086d6@endymion> <20200206145602.GQ2667@lahna.fi.intel.com> <CAJZ5v0i5+DaFM22jW=dS66JHK5=ydvMf4dBuJTMvGoNSZLOL3Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0i5+DaFM22jW=dS66JHK5=ydvMf4dBuJTMvGoNSZLOL3Q@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 6 Feb 2020 17:00:43 +0100
Message-ID: <CAJZ5v0hOyVNt0up7kErOnFSeCu0yu=MhJp-Yqo4+M49W0bgZbw@mail.gmail.com>
Subject: Re: Forcing non-ACPI watchdog driver
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean Delvare <jdelvare@suse.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
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

On Thu, Feb 6, 2020 at 4:50 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Feb 6, 2020 at 3:56 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > On Thu, Feb 06, 2020 at 03:45:32PM +0100, Jean Delvare wrote:
> > > Hi Mika,
> > >
> > > On Wed, 5 Feb 2020 18:38:31 +0200, Mika Westerberg wrote:
> > > > On Wed, Feb 05, 2020 at 08:30:48AM -0800, Guenter Roeck wrote:
> > > > > On Wed, Feb 05, 2020 at 05:24:35PM +0200, Mika Westerberg wrote:
> > > > > > You should be able to revert to iTCO_wdt by simply disabling
> > > > > > CONFIG_WDAT_WDT from .config. Then acpi_has_watchdog() returns false
> > > > > > which means that iTCO_wdt is used instead.
> > > > >
> > > > > That may not be possible in a generic distribution.
> > > >
> > > > Right, they would need to build their own kernel. Currently there is no
> > > > way to do that without changing .config.
> > >
> > > OK, that's pretty much what I was compl^Wworried about ;-) Would you
> > > consider applying something like the following patch?
> >
> > Yes, I think the patch makes sense.
> >
> > Rafael, I guess you will take this since it is touching ACPI?
>
> Yes, I will.

So queued up now (with very minor changes in the subject and
changelog), but I will rebase it on top of -rc1 when it is out.
