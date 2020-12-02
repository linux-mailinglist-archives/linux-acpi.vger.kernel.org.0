Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253782CC536
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Dec 2020 19:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389223AbgLBScP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Dec 2020 13:32:15 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:36258 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbgLBScO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2020 13:32:14 -0500
Received: by mail-ot1-f51.google.com with SMTP id y24so2565115otk.3;
        Wed, 02 Dec 2020 10:31:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B4i9VFRUD3xARLzYQEJLNB6JhqamFut8iCJ5lNpUlk4=;
        b=iYEerzja10ZQZBFr4aeAtdJwMq8T6CEiRCZQmgbpdOKYkmL7c9QT5ydgasOnWyRSUD
         TLm4xZ5pqJx6g3DAWBmBCGJaukgCYMRExm4gR93XN8T8xp3epZpwg2elGWJJBRpzGnHE
         7o7h47DLAhuh+USumGlFdOVYmio3mX8kgdJn6CC3Eyo3eibNsKZu2s5ghSj5u0RSHCEH
         CEAGHM72ELT6TejXuJLVEWK+R37n7YqaxEImurO0ORy3dOtLe8ZuobFKBjym+UcewL4S
         HJVRCtxC1VADpEoRdy4lMXKfCztdAq7QQ6sxW7aZyXvIAcL4WcFeGRkBRAwsYL+doo0Q
         xUjA==
X-Gm-Message-State: AOAM5304FLkz2YyJmxl0tBvrjOOxUYaWL/5WrWnsPBThMnNsJZgk2z4C
        hATrUPso/+mGPKGWftnLMQh7q3b+34s8IMJk4PE=
X-Google-Smtp-Source: ABdhPJxpvRp8VsnzKDL27mVBm4pcDuSz96iERvdj7q3h3vU8KuTGbZbDzV61PT2USI8W+btbuSQjQw8l/wqoA9qDaTM=
X-Received: by 2002:a9d:745a:: with SMTP id p26mr2455710otk.206.1606933893884;
 Wed, 02 Dec 2020 10:31:33 -0800 (PST)
MIME-Version: 1.0
References: <87blkbx1gt.fsf@gmx.net> <87imdp5r80.fsf@rub.de>
 <20200811132955.wbt55ns7bu5mxouq@linutronix.de> <CAJZ5v0h+n9VCz5=VixVbe_b=ZbTU3D=46stGhE9z7Y7yaUMJzw@mail.gmail.com>
 <20200811152551.dmfw46urecbmeklr@linutronix.de> <87ft8tayic.fsf@gmx.net>
 <20200811184902.2fm4eyprmpkfon2j@linutronix.de> <20201006214927.4nsqtfji4fdv3oed@linutronix.de>
 <3fc9074b-c153-8446-0289-1e4dfab395eb@intel.com> <20201026172057.h5toqoobiyhc4g3g@linutronix.de>
 <20201202180350.kwmgfzkom7v7bzjg@linutronix.de>
In-Reply-To: <20201202180350.kwmgfzkom7v7bzjg@linutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 2 Dec 2020 19:31:21 +0100
Message-ID: <CAJZ5v0j86pX_a4bSLP=sobLoYhfQYV9dWL8HHf2941kXgND79g@mail.gmail.com>
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Berman <stephen.berman@gmx.net>,
        Zhang Rui <rui.zhang@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Dec 2, 2020 at 7:03 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2020-10-26 18:20:59 [+0100], To Rafael J. Wysocki wrote:
> > > > > > Done as Bug 208877.
> > > > Rafael, do you have any suggestions?
> > >
> > > I've lost track of this sorry.
> > >
> > > I have ideas, let me get back to this next week.
> >
> > :)
>
> Rafael, any update? If you outline an idea or so then I may be able to
> form a patch out of it. Otherwise I have no idea how to fix this - other
> than telling the driver to not poll in smaller intervals than
> 30secs.

The idea, roughly speaking, is to limit the number of outstanding work
items in the queue (basically, if there's a notification occurring
before the previous one can be handled, there is no need to queue up
another work item for it).
