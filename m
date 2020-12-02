Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09CE82CC657
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Dec 2020 20:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbgLBTOb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Dec 2020 14:14:31 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:41423 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731022AbgLBTOa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2020 14:14:30 -0500
Received: by mail-ot1-f54.google.com with SMTP id j21so2674846otp.8;
        Wed, 02 Dec 2020 11:14:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CSgCPvyjSWwR5VuE/IAdVdzw2MyO2GOfuLQ4fVNgIpw=;
        b=Qy/flFGQTXNXYv7clv0+MVOjlr/4k7GCy7KjS2XfvvnalRA8MSvz92ppd2lAm32mwf
         WqrrZ+fH1rA8bzz6BKpKY3yueInIyvOlcqeWJ0M6fqO9KtMCZEEQoqBFhjua7VwuNkjd
         UvtQKYB8wiT0W+eotbax9vA/V1RuRDDfRsH4yHKTvSrWTtQt6YMMc/A1y4LUANb5Vzu0
         EbpDf1VZtxei+39Z7+HB2G3bSVdyhbODdwSOAZjilKsvIUMzdwJKk4k6H6JMLo2Mpiyc
         Ru9MNO5LGvnpdBlb5Q2v7vjGNRD1RjmVZf5YQ93S4b7EWYyrc7ar8HXmoiDnYGQRiKe2
         z3Dw==
X-Gm-Message-State: AOAM533HVNiW/aLI4PFpab+K3SqOavBy6MksMo0kZjUJVOABe7W4mlpe
        ZrM4tMnLX+iEo/PGyoddmnMPv1C2yCH+jTCGwp0=
X-Google-Smtp-Source: ABdhPJw/JQjLLLN6CbYH3DtwCCSLVoGBAx5DynWnnuCt7W2OWszKJ3VbCibWMQVmo1d6njsDOMahJuK4GKi6nf7r3Tg=
X-Received: by 2002:a9d:171a:: with SMTP id i26mr2967213ota.260.1606936429762;
 Wed, 02 Dec 2020 11:13:49 -0800 (PST)
MIME-Version: 1.0
References: <87blkbx1gt.fsf@gmx.net> <87imdp5r80.fsf@rub.de>
 <20200811132955.wbt55ns7bu5mxouq@linutronix.de> <CAJZ5v0h+n9VCz5=VixVbe_b=ZbTU3D=46stGhE9z7Y7yaUMJzw@mail.gmail.com>
 <20200811152551.dmfw46urecbmeklr@linutronix.de> <87ft8tayic.fsf@gmx.net>
 <20200811184902.2fm4eyprmpkfon2j@linutronix.de> <20201006214927.4nsqtfji4fdv3oed@linutronix.de>
 <3fc9074b-c153-8446-0289-1e4dfab395eb@intel.com> <20201026172057.h5toqoobiyhc4g3g@linutronix.de>
 <20201202180350.kwmgfzkom7v7bzjg@linutronix.de> <CAJZ5v0j86pX_a4bSLP=sobLoYhfQYV9dWL8HHf2941kXgND79g@mail.gmail.com>
In-Reply-To: <CAJZ5v0j86pX_a4bSLP=sobLoYhfQYV9dWL8HHf2941kXgND79g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 2 Dec 2020 20:13:38 +0100
Message-ID: <CAJZ5v0j7i86twMS+csYMaetUkvqjof4FD2GRNoZ_AN=SBF7F1w@mail.gmail.com>
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

On Wed, Dec 2, 2020 at 7:31 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Dec 2, 2020 at 7:03 PM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2020-10-26 18:20:59 [+0100], To Rafael J. Wysocki wrote:
> > > > > > > Done as Bug 208877.
> > > > > Rafael, do you have any suggestions?
> > > >
> > > > I've lost track of this sorry.
> > > >
> > > > I have ideas, let me get back to this next week.
> > >
> > > :)
> >
> > Rafael, any update? If you outline an idea or so then I may be able to
> > form a patch out of it. Otherwise I have no idea how to fix this - other
> > than telling the driver to not poll in smaller intervals than
> > 30secs.
>
> The idea, roughly speaking, is to limit the number of outstanding work
> items in the queue (basically, if there's a notification occurring
> before the previous one can be handled, there is no need to queue up
> another work item for it).

That's easier said than done, though, because of the way the work item
queue-up is hooked up into the ACPICA code.
