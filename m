Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5609432F12C
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Mar 2021 18:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbhCER2q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Mar 2021 12:28:46 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:41641 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhCER2P (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Mar 2021 12:28:15 -0500
Received: by mail-oi1-f174.google.com with SMTP id y131so427879oia.8;
        Fri, 05 Mar 2021 09:28:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ftRwsenV0mfBhEpHD6J+4YldNWZr/T/WfB+IqdjDVZ0=;
        b=dDwsTMv+i/KkYfwYCFE+xfbo5olaL6KAlRqxqx6Vyw7vEby3x1MjiokZPE4F82J7vA
         IETb27PQCMKyL3LLHqg2G3LTMxQ6sf7E5gNND5Dj6tgyoN0yd4z9v+eJ8at7Bq/5z3ro
         FgV5zdFpZZvQFC7Ou+iretAE8ZtKq6T4Lt4U8g8MW8AIV7B+bUhdKWBkNWvzqD/mLLfj
         QuXMCznWSvwNEKTusciOru2akFUsNyHJj8/r5R+dxiWLNUI6YxNclA2HyLUW1GmBFSMj
         0i+3RozsiwqQ/mTcXm+K+A0y/3GW1xxyh3dRMKch+aUBA7+ShmI7trkOhZDJw5wxQ3ms
         hpQA==
X-Gm-Message-State: AOAM530m6NRwJ//dCl+6rzICQFpVmBji9JOyNZoa78vPxn0tlvh+EpbW
        BOgjRk2JL2cDM5s1EPVK3T8Nl+xgnx3wUfah/0o=
X-Google-Smtp-Source: ABdhPJyRCNl9wBRlc9FLTirldygNk6ebxUtOAwuC3niu/mw5EjJsxD/INLbWNAaEX7qcXMo2ZvAhzsETBtIwyopDahs=
X-Received: by 2002:aca:e189:: with SMTP id y131mr8068443oig.71.1614965294578;
 Fri, 05 Mar 2021 09:28:14 -0800 (PST)
MIME-Version: 1.0
References: <6041a2ff.18V+4AiVF2xWzVE+%lkp@intel.com> <YEIkhnfEMINzlZHH@smile.fi.intel.com>
 <CAJZ5v0idCJBQkDfN8GuUt3YqzBjcMZ4EACPogm=+LyihYRhwcA@mail.gmail.com> <YEI3EfE8N/isD9Uk@smile.fi.intel.com>
In-Reply-To: <YEI3EfE8N/isD9Uk@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Mar 2021 18:28:03 +0100
Message-ID: <CAJZ5v0gNNv1vRfdoFva4bwuDPoPAWNMFfPPT7LvPWnq2LTOvaQ@mail.gmail.com>
Subject: Re: [BUILD REGRESSION] LAST PATCH: gpiolib: Reuse device's fwnode to
 create IRQ domain
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Mar 5, 2021 at 2:50 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Mar 05, 2021 at 02:06:54PM +0100, Rafael J. Wysocki wrote:
> > On Fri, Mar 5, 2021 at 1:31 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, Mar 05, 2021 at 11:18:23AM +0800, kernel test robot wrote:
> > > > url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/gpiolib-switch-to-fwnode-in-the-core/20210304-230747
> > > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git e749df1bbd23f4472082210650514548d8a39e9b
> > > >
> > > > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > > > And when submitting patch, we suggest to use '--base' as documented in
> > > > https://git-scm.com/docs/git-format-patch]
> > > >
> > > >
> > > > Error/Warning in current branch:
> > > >
> > > > drivers/gpio/gpiolib.c:3672:24: warning: passing argument 1 of 'is_acpi_node' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
> > > > drivers/gpio/gpiolib.c:3675:24: warning: passing argument 1 of 'is_acpi_node' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
> > > > drivers/gpio/gpiolib.c:3686:24: error: passing 'const struct fwnode_handle *' to parameter of type 'struct fwnode_handle *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
> > > > drivers/gpio/gpiolib.c:3686:24: warning: passing argument 1 of 'is_acpi_node' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
> > >
> > > Yeah, yeah. The fix should be in Rafael's tree.
> > >
> > > Rafael, can you submit it as material for v5.12-rcX, please?
> >
> > What exactly do you want me to submit for 5.12-rc and why is it urgent?
>
> I'm talking about
> https://lore.kernel.org/linux-acpi/20210302133721.GG3@paasikivi.fi.intel.com/T/#u
>
> It's not urgent per se, but it rather makes life easier in case that my
> GPIO fwnode patch series will be routed thru the different tree (and
> I believe GPIO would like to have pull it as an immutable branch / tag).

OK, just sent a PR with that change, thanks!
