Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBFFE3758B
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2019 15:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfFFNoY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Jun 2019 09:44:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:19713 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727082AbfFFNoY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 6 Jun 2019 09:44:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2019 06:44:23 -0700
X-ExtLoop1: 1
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 06 Jun 2019 06:44:20 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 06 Jun 2019 16:44:19 +0300
Date:   Thu, 6 Jun 2019 16:44:19 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/3] PCI / ACPI: Handle sibling devices sharing power
 resources
Message-ID: <20190606134419.GL2781@lahna.fi.intel.com>
References: <20190605145820.37169-1-mika.westerberg@linux.intel.com>
 <20190605145820.37169-4-mika.westerberg@linux.intel.com>
 <CAJZ5v0iGu8f6H68082RGDmDCQsmQZNTULLwnb5JzpKA7m1QvVA@mail.gmail.com>
 <20190606112640.GA2781@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606112640.GA2781@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 06, 2019 at 02:26:40PM +0300, Mika Westerberg wrote:
> On Thu, Jun 06, 2019 at 10:54:40AM +0200, Rafael J. Wysocki wrote:
> > On Wed, Jun 5, 2019 at 4:58 PM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > >
> > > Intel Ice Lake has an interated Thunderbolt controller which means that
> > 
> > integrated
> 
> Right :)
> 
> > > the PCIe topology is extended directly from the two root ports (RP0 and
> > > RP1). Power management is handled by ACPI power resources that are
> > > shared between the root ports, Thunderbolt controller (NHI) and xHCI
> > > controller.
> > >
> > > The topology with the power resources (marked with []) looks like:
> > >
> > >   Host bridge
> > >       |
> > >       +- RP0 ---\
> > >       +- RP1 ---|--+--> [TBT]
> > >       +- NHI --/   |
> > >       |            |
> > >       |            v
> > >       +- xHCI --> [D3C]
> > >
> > > Here TBT and D3C are the shared ACPI power resources. ACPI _PR3() method
> > > returns either TBT or D3C or both.
> > >
> > > Say we runtime suspend first the root ports RP0 and RP1, then NHI. Now
> > > since the TBT power resource is still on when the root ports are runtime
> > > suspended their dev->current_state is set to D3hot. When NHI is runtime
> > > suspended TBT is finally turned off but state of the root ports remain
> > > to be D3hot.
> > 
> > It looks like this problem will affect all ACPI devices using power
> > resources and _PR3 in general, so fixing it just for PCI is not
> > sufficient IMO.
> 
> Fair enough.
> 
> > An alternative approach may be to set the state of a device that
> > dropped its references to power resources listed in _PR3 to D3cold
> > even though those power resources may be physically "on" at that time.
> > Everything else (including this patch AFAICS) will be racy this way or
> > another.
> 
> OK, thanks for the comment. I'll try to look into this approach then.

One additional question.

How about the other direction when shared power resource(s) gets turned
on? We would need to wake up all the sharing devices so that their state
gets restored back from D0uninitialized.
