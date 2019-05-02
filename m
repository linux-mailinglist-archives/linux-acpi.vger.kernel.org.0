Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23AF71186A
	for <lists+linux-acpi@lfdr.de>; Thu,  2 May 2019 13:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfEBLsn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 May 2019 07:48:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfEBLsm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 2 May 2019 07:48:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22F972081C;
        Thu,  2 May 2019 11:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556797721;
        bh=NxECKS4hO+fvuuCrWF9YKIVWO4SJGdSkM8vdKG2zimY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ds5BuqKmOB7afrbcN0Xt+UHtJ8ipUSsJUzAyDjWk1qH1nzsBNaeQIfRIwDfKi1m2K
         BTNO7v+q/sQLq5BPkz4ktdAm71+ks5/iTh6GtHvxLKz5bSrAnqFFSP+A1gLPEROOdz
         rUh42R8UgAsbD26YA8QbjexKESx/pQc0k30YZH5s=
Date:   Thu, 2 May 2019 13:48:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>, mh@mike.franken.de,
        Lukas Wunner <lukas@wunner.de>, Takashi Iwai <tiwai@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>, ckellner@redhat.com,
        Jiri Slaby <jslaby@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Furquan Shaikh <furquan@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Robert Moore <robert.moore@intel.com>
Subject: Re: [REGRESSION 5.0.8] Dell thunderbolt dock broken (xhci_hcd and
 thunderbolt)
Message-ID: <20190502114839.GC24696@kroah.com>
References: <s5hsgu0ihyg.wl-tiwai@suse.de>
 <EksOpJxc6GB@mike.franken.de>
 <20190430090021.GF26516@lahna.fi.intel.com>
 <CAJZ5v0j_fYqtMv07C-V_9fCJ6=1ec3GjvT2M7PXVNSbZpoM67Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j_fYqtMv07C-V_9fCJ6=1ec3GjvT2M7PXVNSbZpoM67Q@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Apr 30, 2019 at 11:37:48AM +0200, Rafael J. Wysocki wrote:
> On Tue, Apr 30, 2019 at 11:00 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > +Rafael, Furquan and linux-acpi
> >
> > (The original thread is here https://lore.kernel.org/lkml/s5hy33siofw.wl-tiwai@suse.de/T/#u)
> >
> > On Tue, Apr 30, 2019 at 10:39:00AM +0200, Michael Hirmke wrote:
> > > Hi Takashi,
> > >
> > > [...]
> > > >>> I also have XPS 9370 but not that particular dock. I will check tomorrow
> > > >>> if I can reproduce it as well.
> > > >>
> > > >> There aren't too many changes between 5.0.7 and 5.0.8 that touch
> > > >> PCI/ACPI. This is just a shot in the dark but could you try to revert:
> > > >>
> > > >>   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.gi
> > > >>   t/commit/?h=linux-5.0.y&id=da6a87fb0ad43ae811519d2e0aa325c7f792b13a
> > > >>
> > > >> and see if it makes any difference?
> > >
> > > >OK, I'm building a test kernel package with the revert in OBS
> > > >home:tiwai:bsc1133486 repo.  A new kernel will be
> > > >kernel-default-5.0.10-*g8edeab8:
> > > >  http://download.opensuse.org/repositories/home:/tiwai:/bsc1133486/standard/
> > >
> > > >Michael, once when the new kernel is ready, please give it a try.
> > >
> > > as far as I can see, state is back to normal with this kernel.
> > > No more error messages or crashing modules and all devices seem to work
> > > as expected.
> > > Only thing is, that the external devices connected to the Thunderbolt
> > > dock are coming up a little bit slower than with 5.0.7 - but this is
> > > nothing, I'd worry about.
> >
> > Thanks for testing.
> >
> > Rafael, it seems that commit c8b1917c8987 ("ACPICA: Clear status of GPEs
> > before enabling them") causes problem with Thunderbolt controllers if
> > you boot with device (dock) connected.
> >
> > I think the reason is the same that got fixed in v4.14 with commit
> > ecc1165b8b74 ("ACPICA: Dispatch active GPEs at init time") which the
> > above commit essentially undoes if I understand it correctly.
> 
> OK, I'll queue up a revert of that one then, thanks!
> 
> Erik, I think that commit c8b1917c8987 has been picked up by the
> upstream ACPICA already.  If I'm not mistaken, it needs to be reverted
> from there as well.

I've queued the revert up in the stable trees as it has hit Linus's tree
now, and will push out a new round of stable kernels soon.

thanks,

greg k-h
