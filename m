Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDD5B4E897
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jun 2019 15:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfFUNJX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Jun 2019 09:09:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbfFUNJX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Jun 2019 09:09:23 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9E512083B;
        Fri, 21 Jun 2019 13:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561122562;
        bh=3kASRVGmx6gIzaNDW0UH4aywd2v9uOYZA1v/uiaj0SA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lhcfsi00wrk7qFLHqMnMCfo+ARkq04Z4tvXNxtTXrG80UljTus9evC3AoMzikE4ku
         XMnyA5gEUJINbjE/6/+NxNinZZVZoAkztMeV5lxkm8lTwQjG82PL03S/5VQNvTlQYZ
         ors3bjBvg+oFHl7Z4iY3nFtbo5SVGGXqkJx8BpqI=
Date:   Fri, 21 Jun 2019 08:09:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] PCI / ACPI: Use cached ACPI device state to get
 PCI device power state
Message-ID: <20190621130920.GB82584@google.com>
References: <20190618161858.77834-1-mika.westerberg@linux.intel.com>
 <20190618161858.77834-2-mika.westerberg@linux.intel.com>
 <20190619212801.GC143205@google.com>
 <20190620082730.GM2640@lahna.fi.intel.com>
 <20190620131649.GG143205@google.com>
 <20190620133710.GB2640@lahna.fi.intel.com>
 <20190620141541.GA257318@google.com>
 <CAJZ5v0hfCnyuAA7kC5-fXRo-Mf0jvGZQASV9T4iK8QxsqHMN_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hfCnyuAA7kC5-fXRo-Mf0jvGZQASV9T4iK8QxsqHMN_g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 21, 2019 at 12:32:22PM +0200, Rafael J. Wysocki wrote:
> On Thu, Jun 20, 2019 at 4:15 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Jun 20, 2019 at 04:37:10PM +0300, Mika Westerberg wrote:
> > > On Thu, Jun 20, 2019 at 08:16:49AM -0500, Bjorn Helgaas wrote:
> > > > On Thu, Jun 20, 2019 at 11:27:30AM +0300, Mika Westerberg wrote:
> > > > > On Wed, Jun 19, 2019 at 04:28:01PM -0500, Bjorn Helgaas wrote:
> > > > > > On Tue, Jun 18, 2019 at 07:18:56PM +0300, Mika Westerberg wrote:
> > > > > > > Intel Ice Lake has an integrated Thunderbolt controller which
> > > > > > > means that the PCIe topology is extended directly from the two
> > > > > > > root ports (RP0 and RP1).
> > > > > >
> > > > > > A PCIe topology is always extended directly from root ports,
> > > > > > regardless of whether a Thunderbolt controller is integrated, so I
> > > > > > guess I'm missing the point you're making.  It doesn't sound like
> > > > > > this is anything specific to Thunderbolt?
> > > > >
> > > > > The point I'm trying to make here is to explain why this is problem
> > > > > now and not with the previous discrete controllers. With the
> > > > > previous there was only a single ACPI power resource for the root
> > > > > port and the Thunderbolt host router was connected to that root
> > > > > port. PCIe hierarchy was extended through downstream ports (not root
> > > > > ports) of that controller (which includes PCIe switch).
> > > >
> > > > Sounds like you're using "PCIe topology extension" to mean
> > > > specifically something below a Thunderbolt controller, excluding a
> > > > subtree below a root port.  I don't think the PCI core is aware of
> > > > that distinction.
> > >
> > > Right it is not.
> > >
> > > > > Now the thing is part of the SoC so power management is different
> > > > > and causes problems in Linux.
> > > >
> > > > The SoC is a physical packaging issue that really doesn't enter into
> > > > the specs directly.  I'm trying to get at the logical topology
> > > > questions in terms of the PCIe and ACPI specs.
> > > >
> > > > I assume we could dream up a non-Thunderbolt topology that would show
> > > > the same problem?
> > >
> > > Yes.
> > >
> > > > > > > Power management is handled by ACPI power resources that are
> > > > > > > shared between the root ports, Thunderbolt controller (NHI) and xHCI
> > > > > > > controller.
> > > > > > >
> > > > > > > The topology with the power resources (marked with []) looks like:
> > > > > > >
> > > > > > >   Host bridge
> > > > > > >     |
> > > > > > >     +- RP0 ---\
> > > > > > >     +- RP1 ---|--+--> [TBT]
> > > > > > >     +- NHI --/   |
> > > > > > >     |            |
> > > > > > >     |            v
> > > > > > >     +- xHCI --> [D3C]
> > > > > > >
> > > > > > > Here TBT and D3C are the shared ACPI power resources. ACPI
> > > > > > > _PR3() method returns either TBT or D3C or both.
> > > >
> > > > I'm not very familiar with _PR3.  I guess this is under an ACPI object
> > > > representing a PCI device, e.g., \_SB.PCI0.RP0._PR3?
> > >
> > > Correct.
> > >
> > > > > > > Say we runtime suspend first the root ports RP0 and RP1, then
> > > > > > > NHI. Now since the TBT power resource is still on when the root
> > > > > > > ports are runtime suspended their dev->current_state is set to
> > > > > > > D3hot. When NHI is runtime suspended TBT is finally turned off
> > > > > > > but state of the root ports remain to be D3hot.
> > > >
> > > > So in this example we might have:
> > > >
> > > >   _SB.PCI0.RP0._PR3: TBT
> > > >   _SB.PCI0.RP1._PR3: TBT
> > > >   _SB.PCI0.NHI._PR3: TBT
> > >
> > > and also D3C.
> > >
> > > > And when Linux figures out that everything depending on TBT is in
> > > > D3hot, it evaluates TBT._OFF, which puts them all in D3cold?  And part
> > > > of the problem is that they're now in D3cold (where config access
> > > > doesn't work) but Linux still thinks they're in D3hot (where config
> > > > access would work)?
> > >
> > > Exactly.
> > >
> > > > I feel like I'm missing something because I don't know how D3C is
> > > > involved, since you didn't mention suspending xHCI.
> > >
> > > That's another power resource so we will also have D3C turned off when
> > > xHCI gets suspended but I did not want to complicate things too much in
> > > the changelog.
> >
> > If D3C isn't essential to seeing this problem, you could just omit it
> > altogether.  I think stripping out anything that's not essential will
> > make it easier to think about the underlying issues.
> >
> > > > And I can't mentally match up the patch with the D3hot/D3cold state
> > > > change (if indeed that's the problem).  If we were updating the path
> > > > that evaluates _OFF so it changed the power state of all dependent
> > > > devices, *that* would make a lot of sense to me because it sounds like
> > > > that's where the physical change happens that makes things out of
> > > > sync.
> > >
> > > I did that in the first version [1] but Rafael pointed out that it is
> > > racy one way or another [2].
> > >
> > > [1] https://www.spinics.net/lists/linux-pci/msg83583.html
> > > [2] https://www.spinics.net/lists/linux-pci/msg83600.html
> >
> > Yeah, interesting.  It was definitely a much larger patch.  I don't
> > know enough to comment on the races.
> 
> Say two power resources are listed by _PR3 for one device (because why
> not?) and you want to change the device's state to D3cold only if the
> two power resources are both "off".  Then, you need some locking (or
> equivalent) to synchronize two power resources with each other, so
> that you can change the devices state when the last of them goes _OFF.
> Currently, there is no such synchronization between power resources
> other then the "system_level" value which may not be reliable enough
> for this type of use.
> 
> Or you can say that the device is in D3cold if at least one of the
> power resources is _OFF, but IMO that may not really be consistent
> with the view that the "logical" power state of the device should
> reflect the physical reality accurately.
> 
> > I would wonder whether there's a way to get rid of the caches that become stale,
> 
> I guess what you mean is that the "cached" (or rather "logical" or
> "expected") power state value may become different from what is
> returned by acpi_device_get_power() for the device.
> 
> The problem here is that acpi_device_get_power() really only should be
> used for two purposes: (1) To initialize adev->power.state, or to
> update it via acpi_device_update_power(), and (2) by the
> "real_power_state" sysfs attribute (of ACPI device objects).  The
> adev->power.state value should be used anywhere else, in principle, so
> the Mika's patch is correct.
> 
> [Note that adev->power.state cannot be updated after calling
> acpi_device_get_power() to the value returned by it without updating
> the reference counters of the power resources that are "on" *exactly*
> because of the problem at hand here.]
> 
> > but that's just an idle thought, not a suggestion.
> 
> After the initialization of the ACPI subsystem, the authoritative
> source of the ACPI device power state information is
> adev->power.state.  The ACPI subsystem is expected to update this
> value as needed going forward (including system-wide transitions like
> resume from S3).

Thanks, this is all very helpful!  Do you by any chance add
lore.kernel.org links to commit logs when applying patches?  This is a
case where I think the discussion could be useful in the future.

Link: https://lore.kernel.org/r/20190618161858.77834-2-mika.westerberg@linux.intel.com
