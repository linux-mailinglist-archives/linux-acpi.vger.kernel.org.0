Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13F7D94C25
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2019 19:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfHSR5g (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Aug 2019 13:57:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:23229 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbfHSR5g (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Aug 2019 13:57:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 10:57:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,405,1559545200"; 
   d="scan'208";a="195585399"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 19 Aug 2019 10:57:31 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 19 Aug 2019 20:57:30 +0300
Date:   Mon, 19 Aug 2019 20:57:30 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario.Limonciello@dell.com
Cc:     linux-kernel@vger.kernel.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com, rjw@rjwysocki.net,
        lenb@kernel.org, lukas@wunner.de, anthony.wong@canonical.com,
        rajmohan.mani@intel.com, raanan.avargil@intel.com,
        David.Laight@aculab.com, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 0/8] thunderbolt: Intel Ice Lake support
Message-ID: <20190819175730.GX19908@lahna.fi.intel.com>
References: <20190819112223.15359-1-mika.westerberg@linux.intel.com>
 <5486107424db48f2a06ed4c8a81f75b0@AUSX13MPC101.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5486107424db48f2a06ed4c8a81f75b0@AUSX13MPC101.AMER.DELL.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 19, 2019 at 04:29:35PM +0000, Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Sent: Monday, August 19, 2019 6:22 AM
> > To: linux-kernel@vger.kernel.org
> > Cc: Andreas Noever; Michael Jamet; Yehezkel Bernat; Rafael J. Wysocki; Len
> > Brown; Lukas Wunner; Limonciello, Mario; Anthony Wong; Rajmohan Mani;
> > Raanan Avargil; David Laight; Mika Westerberg; linux-acpi@vger.kernel.org
> > Subject: [PATCH v3 0/8] thunderbolt: Intel Ice Lake support
> > 
> > 
> > [EXTERNAL EMAIL]
> > 
> > Hi all,
> > 
> > This is third iteration of the patch series adding support for the Intel
> > Ice Lake integrated Thunderbolt controller. The biggest difference from the
> > previous discrete controllers is that the Ice Lake Thunderbolt controller
> > is now integrated as part of the SoC. The firmware messages pretty much
> > follow Titan Ridge but there are some differences as well (such as the new
> > RTD3 veto notification). Also Ice Lake does not implement security levels
> > so DMA protection is handled by IOMMU.
> > 
> > The previous versions of the series can be found here:
> > 
> >   v2: https://lwn.net/Articles/795979/
> >   v1: https://lwn.net/Articles/793066/
> > 
> > Changes from v2:
> > 
> >   * Moved ICL specific NHI ops into a separate file (nhi_ops.c)
> > 
> >   * Postpone rescan thread during resume when if get device connected
> >     notification from the firmware. This fixes an issue that happened
> >     occasionally when resuming with full chain of devices. The driver
> >     started to remove last devices in the chain even if they are still
> >     connected.
> > 
> >   * Move call to nhi->ops->init() before CM specific probe happens.
> > 
> >   * Added ack from Rafael
> > 
> > Changes from v1:
> > 
> >   * Check !x86_apple_machine for Titan Ridge also.
> > 
> >   * Drop ioread32() when updating prod/cons because hardware ignores writes
> >     to the read-only parts of the register this allows us to save one read.
> > 
> >   * Remove Light Ridge specific handling in eeprom.c as it is not necessary
> >     after patch 4/8.
> > 
> >   * Moved RTD3 veto handling into separate functions to avoid code
> >     duplication.
> > 
> >   * Reworked struct nhi_ops so that it provides hooks such as
> >     runtime_suspend and so on. The NHI implementation then can use those
> >     hooks to implement whatever additional logic is needed. This should
> >     allow us to move those bits into a separate files in future if needed.
> > 
> >     I also looked whether we could replace
> >     quirk_apple_poweroff_thunderbolt() using struct nhi_ops as well but it
> >     turns out to be unsuitable. The reason is that the ACPI magic sequence
> >     needs to be done after PCI core has moved the device into D3. The NHI
> >     driver does not have easy means to do so.
> > 
> >   * Clarified comment in icl_nhi_suspend()
> > 
> >   * Added clarification comment to icl_nhi_force_power()
> > 
> >   * Use "Thunderbolt" instead of "TBT" in new GUID entries
> > 
> >   * Added reviewed tag from Yehezkel
> > 
> > Mika Westerberg (8):
> >   thunderbolt: Correct path indices for PCIe tunnel
> >   thunderbolt: Move NVM upgrade support flag to struct icm
> >   thunderbolt: Use 32-bit writes when writing ring producer/consumer
> >   thunderbolt: Do not fail adding switch if some port is not implemented
> >   thunderbolt: Hide switch attributes that are not set
> >   thunderbolt: Expose active parts of NVM even if upgrade is not supported
> >   thunderbolt: Add support for Intel Ice Lake
> >   ACPI / property: Add two new Thunderbolt property GUIDs to the list
> > 
> >  drivers/acpi/property.c        |   6 +
> >  drivers/thunderbolt/Makefile   |   2 +-
> >  drivers/thunderbolt/ctl.c      |  23 +++-
> >  drivers/thunderbolt/eeprom.c   |   4 -
> >  drivers/thunderbolt/icm.c      | 194 ++++++++++++++++++++++++++++++---
> >  drivers/thunderbolt/nhi.c      | 134 +++++++++++++++++++++--
> >  drivers/thunderbolt/nhi.h      |  22 ++++
> >  drivers/thunderbolt/nhi_ops.c  | 179 ++++++++++++++++++++++++++++++
> >  drivers/thunderbolt/nhi_regs.h |  37 +++++++
> >  drivers/thunderbolt/switch.c   |  52 +++++++--
> >  drivers/thunderbolt/tb_msgs.h  |  16 ++-
> >  drivers/thunderbolt/tunnel.c   |   4 +-
> >  include/linux/thunderbolt.h    |   2 +
> >  13 files changed, 622 insertions(+), 53 deletions(-)
> >  create mode 100644 drivers/thunderbolt/nhi_ops.c
> > 
> > --
> > 2.23.0.rc1
> 
> I've tested this on a pre-production ICL platform.  This was on top of 5.3-rc5, both of
> your patches from -next and this series.
> 
> I've run into a problem when using
> a WD19TB that after unplugging it will cause the following to spew in dmesg:
> 
> [ 2198.017003] ============================================
> [ 2198.017005] WARNING: possible recursive locking detected
> [ 2198.017008] 5.3.0-rc5+ #75 Not tainted
> [ 2198.017009] --------------------------------------------
> [ 2198.017012] irq/122-pciehp/121 is trying to acquire lock:
> [ 2198.017015] 00000000801d4de8 (&ctrl->reset_lock){.+.+}, at: pciehp_check_presence+0x1b/0x80
> [ 2198.017026] 
>                but task is already holding lock:
> [ 2198.017028] 000000000899e2eb (&ctrl->reset_lock){.+.+}, at: pciehp_ist+0xaf/0x1c0
> [ 2198.017033] 
>                other info that might help us debug this:
> [ 2198.017035]  Possible unsafe locking scenario:
> 
> [ 2198.017037]        CPU0
> [ 2198.017038]        ----
> [ 2198.017041]   lock(&ctrl->reset_lock);
> [ 2198.017044]   lock(&ctrl->reset_lock);
> [ 2198.017046] 
>                 *** DEADLOCK ***
> 
> [ 2198.017048]  May be due to missing lock nesting notation
> 
> [ 2198.017051] 3 locks held by irq/122-pciehp/121:
> [ 2198.017052]  #0: 000000000899e2eb (&ctrl->reset_lock){.+.+}, at: pciehp_ist+0xaf/0x1c0
> [ 2198.017057]  #1: 0000000069e1fd47 (pci_rescan_remove_lock){+.+.}, at: pciehp_unconfigure_device+0x41/0x130
> [ 2198.017064]  #2: 0000000046a5bfbf (&dev->mutex){....}, at: device_release_driver_internal+0x1c/0x1a0
> [ 2198.017071] 
>                stack backtrace:
> [ 2198.017075] CPU: 3 PID: 121 Comm: irq/122-pciehp Not tainted 5.3.0-rc5+ #75
> [ 2198.017077] Hardware name: Dell Inc. XPS 13 7300/, BIOS 0.1.16 08/06/2019
> [ 2198.017079] Call Trace:
> [ 2198.017089]  dump_stack+0x5e/0x8b
> [ 2198.017096]  __lock_acquire+0x12fe/0x1520
> [ 2198.017102]  lock_acquire+0x9d/0x1a0
> [ 2198.017105]  ? pciehp_check_presence+0x1b/0x80
> [ 2198.017113]  ? pci_restore_standard_config+0x40/0x40
> [ 2198.017118]  down_read+0x3b/0x160
> [ 2198.017121]  ? pciehp_check_presence+0x1b/0x80
> [ 2198.017123]  pciehp_check_presence+0x1b/0x80
> [ 2198.017128]  ? quirk_disable_msi.part.29+0x31/0x31
> [ 2198.017131]  pciehp_resume+0x27/0x30
> [ 2198.017136]  device_for_each_child+0x47/0x90
> [ 2198.017140]  ? pci_restore_standard_config+0x40/0x40
> [ 2198.017145]  pcie_port_device_runtime_resume+0x30/0x50
> [ 2198.017150]  pci_pm_runtime_resume+0x6e/0xc0
> [ 2198.017156]  __rpm_callback+0xb0/0x110
> [ 2198.017161]  ? pci_restore_standard_config+0x40/0x40
> [ 2198.017165]  rpm_callback+0x1f/0x70
> [ 2198.017169]  ? pci_restore_standard_config+0x40/0x40
> [ 2198.017173]  rpm_resume+0x4fe/0x690
> [ 2198.017179]  ? irq_forced_thread_fn+0x70/0x70
> [ 2198.017183]  __pm_runtime_resume+0x47/0x80
> [ 2198.017187]  device_release_driver_internal+0x7c/0x1a0
> [ 2198.017191]  pci_stop_bus_device+0x5d/0x80
> [ 2198.017195]  pci_stop_bus_device+0x2b/0x80
> [ 2198.017198]  pci_stop_and_remove_bus_device+0xe/0x20
> [ 2198.017202]  pciehp_unconfigure_device+0x7c/0x130
> [ 2198.017206]  pciehp_disable_slot+0x69/0x120
> [ 2198.017211]  pciehp_handle_presence_or_link_change+0x7d/0x4b0
> [ 2198.017215]  pciehp_ist+0x12a/0x1c0
> [ 2198.017219]  irq_thread_fn+0x1b/0x60
> [ 2198.017222]  irq_thread+0x15b/0x1c0
> [ 2198.017226]  ? lockdep_hardirqs_on+0x115/0x180
> [ 2198.017229]  ? wake_threads_waitq+0x30/0x30
> [ 2198.017233]  ? irq_thread_dtor+0x90/0x90
> [ 2198.017237]  kthread+0x101/0x140
> [ 2198.017241]  ? kthread_cancel_delayed_work_sync+0x10/0x10
> [ 2198.017245]  ret_from_fork+0x24/0x30
> [ 2198.017897] xhci_hcd 0000:03:00.0: remove, state 1
> [ 2198.017917] usb usb6: USB disconnect, device number 1
> [ 2198.017925] usb 6-2: USB disconnect, device number 2
> [ 2198.017932] usb 6-2.3: USB disconnect, device number 3
> [ 2198.017939] usb 6-2.3.1: USB disconnect, device number 5
> [ 2198.019565] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> [ 2198.019671] sd 0:0:0:0: [sda] Synchronize Cache(10) failed: Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK
> [ 2198.057200] xhci_hcd 0000:03:00.0: xHCI host controller not responding, assume dead
> [ 2198.057227] r8152 6-2.4:1.0 enxd8d090034dcb: Stop submitting intr, status -108
> [ 2198.057574] usb 6-2.4: USB disconnect, device number 4
> [ 2198.074541] xhci_hcd 0000:03:00.0: USB bus 6 deregistered
> [ 2198.074558] xhci_hcd 0000:03:00.0: remove, state 1
> [ 2198.074564] usb usb5: USB disconnect, device number 1
> [ 2198.074566] usb 5-2: USB disconnect, device number 2
> [ 2198.074569] usb 5-2.3: USB disconnect, device number 3
> [ 2198.074571] usb 5-2.3.4: USB disconnect, device number 5
> [ 2198.077367] usb 5-2.3.5: USB disconnect, device number 6
> [ 2198.078488] usb 5-2.5: USB disconnect, device number 4
> [ 2198.080340] xhci_hcd 0000:03:00.0: Host halt failed, -19
> [ 2198.080344] xhci_hcd 0000:03:00.0: Host not accessible, reset failed.
> [ 2198.080770] xhci_hcd 0000:03:00.0: USB bus 5 deregistered
> [ 2198.081153] pci 0000:03:00.0: Removing from iommu group 3
> [ 2198.081180] pci_bus 0000:03: busn_res: [bus 03] is released
> [ 2198.081287] pci 0000:02:02.0: Removing from iommu group 3
> [ 2198.081396] pci_bus 0000:04: busn_res: [bus 04-2d] is released
> [ 2198.081509] pci 0000:02:04.0: Removing from iommu group 3
> [ 2198.082273] pci_bus 0000:02: busn_res: [bus 02-2d] is released
> [ 2198.085759] pci 0000:01:00.0: Removing from iommu group 3
> [ 2198.630098] thunderbolt 0-1: device disconnected
> 
> Additionally I've found after this I can't get the dock to work by hotplugging again
> until I reboot the system.

Can you try if the following patch helps?

https://lore.kernel.org/patchwork/patch/1113961/
