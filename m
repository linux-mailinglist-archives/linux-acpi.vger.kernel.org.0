Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F086765A9B
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Jul 2023 19:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjG0RlH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Jul 2023 13:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjG0RlG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Jul 2023 13:41:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5E819A1;
        Thu, 27 Jul 2023 10:41:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 550E361F05;
        Thu, 27 Jul 2023 17:41:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E66CC433C8;
        Thu, 27 Jul 2023 17:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690479664;
        bh=sV0KNtt9fE1XUeUe/XyptVCWCQE2T1DYtSUkvu0/uQU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ondc/h+uRtAb3vSjtI9OfaFusUo1AEMl/lad0+0r0QabAkdTx82Su7M/1SqBtnUd9
         s9YDdOZRZfwkmnI+1KtH22smACKUWz89aWVk5vlsD7jVO43mIeMnz4eHowqeKWFqdk
         GNW9C3P/fAf1zTbFW323WYurlTP0AEQa5h37iqsszvBXKN4DHJ9ax/vZ7WjDAH5U7i
         MwoUjgFtWIOARzvvCYm6rg0vxCD7zXixWk/4i9oiyUW1GZf+AzSsehHJIizwHApcmb
         s347weqxZxhTMjndpp/Ntwbu+KjjVl2uAGp71y89KtWJNzUPbv98MaTRpg9ffX8Qz8
         LwL+SAWCqJnMQ==
Date:   Thu, 27 Jul 2023 12:41:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Igor Mammedov <imammedo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, terraluna977@gmail.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org, mst@redhat.com,
        rafael@kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: acpiphp:: use
 pci_assign_unassigned_bridge_resources() only if bus->self not NULL
Message-ID: <20230727174102.GA689794@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726123518.2361181-2-imammedo@redhat.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thank you to both you and Woody for chasing this down!

On Wed, Jul 26, 2023 at 02:35:18PM +0200, Igor Mammedov wrote:
> Commit [1] switched acpiphp hotplug to use
>    pci_assign_unassigned_bridge_resources()
> which depends on bridge being available, however in some cases
> when acpiphp is in use, enable_slot() can get a slot without
> bridge associated.
>   1. legitimate case of hotplug on root bus
>       (likely not exiting on real hw, but widely used in virt world)
>   2. broken firmware, that sends 'Bus check' events to non
>      existing root ports (Dell Inspiron 7352/0W6WV0), which somehow
>      endup at acpiphp:enable_slot(..., bridge = 0) and with bus
>      without bridge assigned to it.

Do we have evidence about the details of this non-existent root port?
If we do, I think it would be interesting to include a URL to them in
case there's some hole in the way we handle Bus Check events.

> Issue is easy to reproduce with QEMU's 'pc' machine provides
> PCI hotplug on hostbridge slots. to reproduce boot kernel at
> commit [1] in VM started with followin CLI and hotplug a device:

You mention CLI; did you mean to include a qemu command line here?
Maybe it's the same thing mentioned in the 40613da52b13 commit log?
I tried briefly to reproduce this using the 40613da52b13 command line
but haven't quite got it going yet.  I think it would be very useful
to either include it here again or point to the 40613da52b13 commit
log.

> once guest OS is fully booted at qemu prompt:
> 
> (qemu) device_add e1000
> 
> it will cause NULL pointer dereference at
> 
>     void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
>     {
>         struct pci_bus *parent = bridge->subordinate;
> 
> [  612.277651] BUG: kernel NULL pointer dereference, address: 0000000000000018
> [...]
> [  612.277798]  ? pci_assign_unassigned_bridge_resources+0x1f/0x260
> [  612.277804]  ? pcibios_allocate_dev_resources+0x3c/0x2a0
> [  612.277809]  enable_slot+0x21f/0x3e0
> [  612.277816]  acpiphp_hotplug_notify+0x13d/0x260
> [  612.277822]  ? __pfx_acpiphp_hotplug_notify+0x10/0x10
> [  612.277827]  acpi_device_hotplug+0xbc/0x540
> [  612.277834]  acpi_hotplug_work_fn+0x15/0x20
> [  612.277839]  process_one_work+0x1f7/0x370
> [  612.277845]  worker_thread+0x45/0x3b0
> [  612.277850]  ? __pfx_worker_thread+0x10/0x10
> [  612.277854]  kthread+0xdc/0x110
> [  612.277860]  ? __pfx_kthread+0x10/0x10
> [  612.277866]  ret_from_fork+0x28/0x40
> [  612.277871]  ? __pfx_kthread+0x10/0x10
> [  612.277876]  ret_from_fork_asm+0x1b/0x30
> 
> The issue was discovered on Dell Inspiron 7352/0W6WV0 laptop with
> following sequence:
>    1. suspend to RAM
>    2. wake up with the same backtrace being observed:
>    3. 2nd suspend to RAM attempt makes laptop freeze
> 
> Fix it by using __pci_bus_assign_resources() instead of
> pci_assign_unassigned_bridge_resources()as we used to do
> but only in case when bus doesn't have a bridge associated
> with it.
> 
> That let us keep hotplug on root bus working like it used to be
> but at the same time keeps resource reassignment usable on
> root ports (and other 1st level bridges) that was fixed by [1].
> 
> 1)
> Fixes: 40613da52b13 ("PCI: acpiphp: Reassign resources on bridge if necessary")
> Link: https://lore.kernel.org/r/11fc981c-af49-ce64-6b43-3e282728bd1a@gmail.com
> Reported-by: Woody Suwalski <terraluna977@gmail.com>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index 328d1e416014..3bc4e1f3efee 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -498,6 +498,7 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
>  				acpiphp_native_scan_bridge(dev);
>  		}
>  	} else {
> +		LIST_HEAD(add_list);
>  		int max, pass;
>  
>  		acpiphp_rescan_slot(slot);
> @@ -511,10 +512,15 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
>  				if (pass && dev->subordinate) {
>  					check_hotplug_bridge(slot, dev);
>  					pcibios_resource_survey_bus(dev->subordinate);
> +					if (!bus->self)
> +						__pci_bus_size_bridges(dev->subordinate, &add_list);
>  				}
>  			}
>  		}
> -		pci_assign_unassigned_bridge_resources(bus->self);
> +		if (bus->self)
> +			pci_assign_unassigned_bridge_resources(bus->self);
> +		else
> +			__pci_bus_assign_resources(bus, &add_list, NULL);
>  	}
>  
>  	acpiphp_sanitize_bus(bus);
> -- 
> 2.39.3
> 
