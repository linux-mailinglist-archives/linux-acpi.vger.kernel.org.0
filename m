Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE0280C02
	for <lists+linux-acpi@lfdr.de>; Sun,  4 Aug 2019 20:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfHDScf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 4 Aug 2019 14:32:35 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:36959 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfHDScf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Aug 2019 14:32:35 -0400
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Aug 2019 14:32:33 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 9A43A100D9411;
        Sun,  4 Aug 2019 20:25:10 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 4C6EE1213E; Sun,  4 Aug 2019 20:25:10 +0200 (CEST)
Date:   Sun, 4 Aug 2019 20:25:10 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 7/8] thunderbolt: Add support for Intel Ice Lake
Message-ID: <20190804182510.m7tlftyc73sp6bjs@wunner.de>
References: <20190705095800.43534-1-mika.westerberg@linux.intel.com>
 <20190705095800.43534-8-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705095800.43534-8-mika.westerberg@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 05, 2019 at 12:57:59PM +0300, Mika Westerberg wrote:
> @@ -891,16 +1020,23 @@ static int nhi_resume_noirq(struct device *dev)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  	struct tb *tb = pci_get_drvdata(pdev);
> +	int ret;
> +
> +	ret = nhi_power_up(tb->nhi);

Some general thoughts:

You're enabling Force Power during the resume_noirq phase of the NHI.

If TBT devices were already connected before system sleep, the PCI core
walks down the hierarchy during resume_noirq, puts each device into D0 and
restores config space.  For this to work, the NHI must have set up tunnels
to attached devices.  But it can hardly do that until Force Power is
enabled.  Yet I cannot see any provision here which causes the hotplug
bridges to wait for the NHI to finish its resume_noirq phase.

Don't you need that?

On Macs we have quirk_apple_wait_for_thunderbolt() to resolve this issue.

And a commit has been rotting on my development branch for years
which replaces quirk_apple_wait_for_thunderbolt() with device links:

https://github.com/l1k/linux/commit/8cbb1d589660


Also, you recently posted a patch stating that on Ice Lake, the NHI and
hotplug bridges share an ACPI Power Resource:

https://patchwork.kernel.org/patch/11015233/

How does that relate to the Force Power and Go2Sx dance implemented in
the present patch?  Does the ACPI Power Resource toggle the same Force
Power and Go2Sx registers as this patch here?  Or is that an additional
power management mechanism?  If Force Power is off on the NHI, are the
hotplug bridges' config and mmio spaces accessible?  All of this should
be documented in code comments or at least the commit message.


There's a quirk for Macs with Cactus Ridge to perform a Go2Sx dance
during the suspend_noirq phase, quirk_apple_poweroff_thunderbolt().
Can this be reimplemented using the infrastructure you're adding
in this patch?


On Macs with Thunderbolt 1 and 2, there are ACPI methods to toggle
Force Power in the NHI's namespace.  However disabling Force Power
not only cuts power to the NHI but also to the integrated PCIe switch.
For this reason, I've implemented power management on these Macs using
a struct dev_pm_domain which is assigned to the upstream bridge of
the integrated PCIe switch.  That way, power isn't cut until the
Thunderbolt controller's top-most device in the hierarchy is runtime
suspended:

https://github.com/l1k/linux/commit/4db7f0b1f5c9

I'm wondering if it would make sense to similarly assign a dev_pm_domain
to the NHI on Ice Lake.


One thing that bothers me a bit with the present patch is that nhi.c
is cluttered up with code specific to Ice Lake.  That doesn't seem
sustainable going forward as I expect we'll have to add plenty of
other quirks once USB4 chipsets become available.  Ideally the file
should contain only (or mostly) generic code and quirks should be
contained in separate files which need not be compiled in on
unrelated arches.  That's why in the above-linked commit to add
Apple-specific power management, I put all the code in a pm_apple.c
and nhi.c only calls tb_pm_apple_init() / _fini(), which become
empty inline stubs if CONFIG_ACPI or CONFIG_PM isn't enabled.


> --- a/drivers/thunderbolt/nhi.c
> +++ b/drivers/thunderbolt/nhi.c
> @@ -38,6 +40,60 @@
>  #define MSIX_MAX_VECS		16
>  
>  #define NHI_MAILBOX_TIMEOUT	500 /* ms */
> +#define LC_MAILBOX_TIMEOUT	500 /* ms */
> +
> +enum lc_mailbox_cmd {
> +	LC_GO2SX = 0x02,
> +	LC_GO2SX_NO_WAKE = 0x03,
> +	LC_PREPARE_FOR_RESET = 0x21,
> +};

Shouldn't these live together with the other LC macros in tb_regs.h?


> +	ret = device_for_each_child(&tb->root_switch->dev, NULL,
> +				    nhi_device_connected);
> +	if (!ret) {
> +		lc_mailbox_cmd(tb->nhi, LC_PREPARE_FOR_RESET);
> +		ret = lc_mailbox_cmd_complete(tb->nhi,
> +					      LC_MAILBOX_TIMEOUT);
> +		if (ret)
> +			return ret;
> +
> +		return nhi_power_down(tb->nhi);
> +	}
> +
> +	return 0;
> +}

Why not:

	if (ret)
		return 0;

and that way reduce the indentation of the code in your if-block by 1 tab?

Thanks,

Lukas
