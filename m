Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE6E781ECE
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2019 16:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbfHEOQ0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Aug 2019 10:16:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:28887 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbfHEOQ0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Aug 2019 10:16:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 07:16:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="192429773"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 05 Aug 2019 07:16:23 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 05 Aug 2019 17:16:21 +0300
Date:   Mon, 5 Aug 2019 17:16:21 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 7/8] thunderbolt: Add support for Intel Ice Lake
Message-ID: <20190805141621.GT2640@lahna.fi.intel.com>
References: <20190705095800.43534-1-mika.westerberg@linux.intel.com>
 <20190705095800.43534-8-mika.westerberg@linux.intel.com>
 <20190804182510.m7tlftyc73sp6bjs@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190804182510.m7tlftyc73sp6bjs@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Aug 04, 2019 at 08:25:10PM +0200, Lukas Wunner wrote:
> On Fri, Jul 05, 2019 at 12:57:59PM +0300, Mika Westerberg wrote:
> > @@ -891,16 +1020,23 @@ static int nhi_resume_noirq(struct device *dev)
> >  {
> >  	struct pci_dev *pdev = to_pci_dev(dev);
> >  	struct tb *tb = pci_get_drvdata(pdev);
> > +	int ret;
> > +
> > +	ret = nhi_power_up(tb->nhi);
> 
> Some general thoughts:
> 
> You're enabling Force Power during the resume_noirq phase of the NHI.
> 
> If TBT devices were already connected before system sleep, the PCI core
> walks down the hierarchy during resume_noirq, puts each device into D0 and
> restores config space.  For this to work, the NHI must have set up tunnels
> to attached devices.  But it can hardly do that until Force Power is
> enabled.  Yet I cannot see any provision here which causes the hotplug
> bridges to wait for the NHI to finish its resume_noirq phase.
> 
> Don't you need that?

For the FW CM we don't because there is some magic ASL as part of the
ACPI power resources (shared between root ports and NHI) that causes the
firmware to establish tunnels as part of _ON() method.

> On Macs we have quirk_apple_wait_for_thunderbolt() to resolve this issue.
> 
> And a commit has been rotting on my development branch for years
> which replaces quirk_apple_wait_for_thunderbolt() with device links:
> 
> https://github.com/l1k/linux/commit/8cbb1d589660
> 
> 
> Also, you recently posted a patch stating that on Ice Lake, the NHI and
> hotplug bridges share an ACPI Power Resource:
> 
> https://patchwork.kernel.org/patch/11015233/
> 
> How does that relate to the Force Power and Go2Sx dance implemented in
> the present patch?  Does the ACPI Power Resource toggle the same Force
> Power and Go2Sx registers as this patch here?  Or is that an additional
> power management mechanism?

It is an additional mechanism (but I think it also touches force power
at some point). Force power here is not the same as with the discrete
chips. AFAIK it pretty much only loads and starts the firmware whereas
in discrete it actually controls power to the chip.

> If Force Power is off on the NHI, are the hotplug bridges' config and
> mmio spaces accessible?

Yes, they are all accessible.

> All of this should be documented in code comments or at least the
> commit message.

Will do.

> There's a quirk for Macs with Cactus Ridge to perform a Go2Sx dance
> during the suspend_noirq phase, quirk_apple_poweroff_thunderbolt().
> Can this be reimplemented using the infrastructure you're adding
> in this patch?

It might be possible to implement ->force_power for Cactus Ridge and do
the ACPI magic there instead. I'll try and see what it looks like.

> On Macs with Thunderbolt 1 and 2, there are ACPI methods to toggle
> Force Power in the NHI's namespace.  However disabling Force Power
> not only cuts power to the NHI but also to the integrated PCIe switch.
> For this reason, I've implemented power management on these Macs using
> a struct dev_pm_domain which is assigned to the upstream bridge of
> the integrated PCIe switch.  That way, power isn't cut until the
> Thunderbolt controller's top-most device in the hierarchy is runtime
> suspended:
> 
> https://github.com/l1k/linux/commit/4db7f0b1f5c9
> 
> I'm wondering if it would make sense to similarly assign a dev_pm_domain
> to the NHI on Ice Lake.

Using PM domain here does not feel right to me. The force power thing
here is not really about power (but I'm calling it that because that's
the what we use internally) so I think it should be part of normal
driver flows.

> One thing that bothers me a bit with the present patch is that nhi.c
> is cluttered up with code specific to Ice Lake.  That doesn't seem
> sustainable going forward as I expect we'll have to add plenty of
> other quirks once USB4 chipsets become available.  Ideally the file
> should contain only (or mostly) generic code and quirks should be
> contained in separate files which need not be compiled in on
> unrelated arches.

I originally intented to have ICL support in icm.c but I realized that
the same steps are most likely needed on Apple systems as well (I don't
have any so can't tell if that's really the case) and since these flows
are for the NHI I figured that's the correct place for it.

I agree with you that moving chip specific things to separate files
makes sense (such as icl.c and so on) in the long run to keep the driver
maintainable.

> That's why in the above-linked commit to add
> Apple-specific power management, I put all the code in a pm_apple.c
> and nhi.c only calls tb_pm_apple_init() / _fini(), which become
> empty inline stubs if CONFIG_ACPI or CONFIG_PM isn't enabled.
> 
> 
> > --- a/drivers/thunderbolt/nhi.c
> > +++ b/drivers/thunderbolt/nhi.c
> > @@ -38,6 +40,60 @@
> >  #define MSIX_MAX_VECS		16
> >  
> >  #define NHI_MAILBOX_TIMEOUT	500 /* ms */
> > +#define LC_MAILBOX_TIMEOUT	500 /* ms */
> > +
> > +enum lc_mailbox_cmd {
> > +	LC_GO2SX = 0x02,
> > +	LC_GO2SX_NO_WAKE = 0x03,
> > +	LC_PREPARE_FOR_RESET = 0x21,
> > +};
> 
> Shouldn't these live together with the other LC macros in tb_regs.h?

I've used tb_regs.h to keep registers and definitions that belong to
Thunderbolt fabric. The other LC macros are there because they are used
to access LC over TBT.

Here we access it through NHI and only use it in nhi.c.

No strong feelings moving it to tb_regs.h if you still think that's
more suitable.

> > +	ret = device_for_each_child(&tb->root_switch->dev, NULL,
> > +				    nhi_device_connected);
> > +	if (!ret) {
> > +		lc_mailbox_cmd(tb->nhi, LC_PREPARE_FOR_RESET);
> > +		ret = lc_mailbox_cmd_complete(tb->nhi,
> > +					      LC_MAILBOX_TIMEOUT);
> > +		if (ret)
> > +			return ret;
> > +
> > +		return nhi_power_down(tb->nhi);
> > +	}
> > +
> > +	return 0;
> > +}
> 
> Why not:
> 
> 	if (ret)
> 		return 0;
> 
> and that way reduce the indentation of the code in your if-block by 1 tab?

Indeed. Will do.
