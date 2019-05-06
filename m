Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8371448B
	for <lists+linux-acpi@lfdr.de>; Mon,  6 May 2019 08:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbfEFGpk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 May 2019 02:45:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:14674 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfEFGpk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 May 2019 02:45:40 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 May 2019 23:45:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,437,1549958400"; 
   d="scan'208";a="171109728"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 05 May 2019 23:45:34 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 06 May 2019 09:45:34 +0300
Date:   Mon, 6 May 2019 09:45:34 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Furquan Shaikh <furquan@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Schmauss, Erik" <erik.schmauss@intel.com>, mh@mike.franken.de,
        Lukas Wunner <lukas@wunner.de>, Takashi Iwai <tiwai@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>, ckellner@redhat.com,
        Jiri Slaby <jslaby@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Robert Moore <robert.moore@intel.com>
Subject: Re: [REGRESSION 5.0.8] Dell thunderbolt dock broken (xhci_hcd and
 thunderbolt)
Message-ID: <20190506064534.GG2895@lahna.fi.intel.com>
References: <s5hsgu0ihyg.wl-tiwai@suse.de>
 <EksOpJxc6GB@mike.franken.de>
 <20190430090021.GF26516@lahna.fi.intel.com>
 <CAJZ5v0j_fYqtMv07C-V_9fCJ6=1ec3GjvT2M7PXVNSbZpoM67Q@mail.gmail.com>
 <20190502114839.GC24696@kroah.com>
 <CAEGmHFFGpUmK1VitkUxqXL29dBrKwbceT0pEOeR_7+_4+eLzvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEGmHFFGpUmK1VitkUxqXL29dBrKwbceT0pEOeR_7+_4+eLzvA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, May 03, 2019 at 04:35:02PM -0700, Furquan Shaikh wrote:
> Thanks for reporting the issue and apologize for the breakage. When I
> pushed the patch, my understanding was that the device drivers do not
> depend on stale GPE events to take any action.
> 
> I am curious to understand the behavior for the thunderbolt device
> since I do not have one to test with. The failure seems to be a result
> of either having a edge-triggered interrupt or a pulse interrupt which
> indicates some kind of ready condition to the kernel driver. All the
> runtime GPEs seem to be initialized as part of acpi_init before ACPI
> bus is scanned. So, is this some special kind of requirement for
> thunderbolt that requires GPE enabled before the device can actually
> be probed. And so the GPEs going active before being enabled are then
> used as a way to call into ACPI Method to enable something which is
> essential for probing of device?

IIRC the idea is that when you boot with a TBT device connected (this is
only for the BIOS assisted/ACPI enumeration mode) the Thunderbolt host
router (the device with PCIe switch + xHCI + NHI) is configured in two
phases. The basic configuration is done in the ASL code that then waits
for a synchronization event (signal) from the SMI hotplug handler that
allows it to continue. The GPE which can be either edge or level is then
used to call the SMI hotplug handler to initialize the host router and
its resources properly.

If this is not done the PCI stack finds the host router half-configured
causing the failure.

> The other question I have is given that handling of GPE events that
> were active before being enabled is required at least for some set of
> devices (e.g. thunderbolt), what is a good way to solve the original
> problem that was being addressed by the patch being reverted i.e.
> stale events resulting in spurious wakes on wakeup GPEs. One way I can
> think of is clearing the status of GPEs when they are setup for
> wake(acpi_setup_gpe_for_wake). What do you think?

Sounds good to me.
