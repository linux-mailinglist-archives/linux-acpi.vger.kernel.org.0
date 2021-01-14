Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9852F6D97
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Jan 2021 22:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbhANV4u (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Jan 2021 16:56:50 -0500
Received: from mga02.intel.com ([134.134.136.20]:31410 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729536AbhANV4t (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Jan 2021 16:56:49 -0500
IronPort-SDR: 7WJnf/vTeo4XJ2BvwtdYBIswV0bcoC4j2a9ruv3h2JNx8/Tyqnruw30k3JidqWlLC+vZmwp2rW
 r6w2jKjVybkg==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="165536108"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="165536108"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 13:55:03 -0800
IronPort-SDR: o16aF2jsRFDqAvWWtpCp2BSpzDjAlyShyT4lFA+IfgjDvGWm9R+Hr9h+EYYh0VPO1wK3WfGxtJ
 /NxG2DDAIs1Q==
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="382419372"
Received: from dvarelam-mobl1.amr.corp.intel.com (HELO [10.212.182.202]) ([10.212.182.202])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 13:55:01 -0800
To:     ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: ACPI scan regression -> Boot fail on Cherrytrail w/ 5.11-rc3
Message-ID: <792c89fd-88f2-b243-50df-21f3be1cc20c@linux.intel.com>
Date:   Thu, 14 Jan 2021 15:55:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,
My primary test device for SOF on Cherrytrail no longer boots with 
v5.11-rc3 and the sof-dev branch, nothing happens after the 'loading 
initial ramdisk'. It's a 'Zotac' headless device derived from the 
Cherrytrail FFD design, so likely there are other devices hit by this 
problem.

A long bisect points to the commit 71da201f38dfb ('ACPI: scan: Defer 
enumeration of devices with _DEP lists').

Reverting the two commits below solves the boot issue.

I have absolutely no idea what these two patches do, but they sure have 
a large impact. Please let me know what sort of information or tests 
might help root-cause this problem.

FWIW I uploaded the alsa-info here:
http://alsa-project.org/db/?f=963685fa2c775b98b60835da3e61d9dd60056841

Thanks for your help
-Pierre

git revert 0de7fb7c8687048299305529d17f6a1e98ae658c
git revert 71da201f38dfb0c3a3d33bbe3168ea9112299dde

71da201f38dfb0c3a3d33bbe3168ea9112299dde is the first bad commit
commit 71da201f38dfb0c3a3d33bbe3168ea9112299dde
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Mon Dec 14 21:27:27 2020 +0100

     ACPI: scan: Defer enumeration of devices with _DEP lists

     In some cases ACPI control methods used during device enumeration
     (such as _HID or _STA) may rely on Operation Region handlers
     supplied by the drivers of other devices [1]:

      An example of this is the Acer Switch 10E SW3-016 model. The _HID
      method of the ACPI node for the UART attached Bluetooth, reads
      GPIOs to detect the installed wifi chip and update the _HID for the
      Bluetooth's ACPI node accordingly. The current ACPI scan code calls
      _HID before the GPIO controller's OpRegions are available, leading
      to the wrong _HID being used and Bluetooth not working.

     In principle, in those cases there should be a _DEP control method
     under the device object with OpRegion enumeration dependencies, so
     deferring the enumeration of devices with _DEP returning a non-empty
     list of suppliers of OpRegions depended on by the given device
     (modulo some known exceptions that don't really supply any OpRegions
     and are listed by _DEP for other reasons irrelevant for Linux) should
     at least address the first-order dependencies by allowing the OpRegion
     suppliers to be enumerated before their consumers.

     Implement the above idea by modifying acpi_bus_scan() to enumerate
     devices in the given scope of the ACPI namespace in two passes,
     where the first pass covers the devices without "significant" lists
     of dependencies coming from _DEP only and the second pass covers
     all of the devices that were not enumerated in the first pass.

     Take _DEP into account only for device objects with _HID, mostly in
     order to avoid deferring the creation of ACPI device objects that
     represent PCI devices and must be present during the enumeration
     of the PCI bus (which takes place during the processing of the ACPI
     device object that represents the host bridge), so that they can
     be properly associated with the corresponding PCI devices.

     Link: 
https://lore.kernel.org/linux-acpi/20201121203040.146252-1-hdegoede@redhat.com/ 
# [1]
     Reported-by: Hans de Goede <hdegoede@redhat.com>
     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
     Reviewed-by: Hans de Goede <hdegoede@redhat.com>
     Tested-by: Hans de Goede <hdegoede@redhat.com>
     Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

  drivers/acpi/scan.c | 103 
+++++++++++++++++++++++++++++++++++++++-------------
  1 file changed, 78 insertions(+), 25 deletions(-)

git bisect start
# bad: [7c53f6b671f4aba70ff15e1b05148b10d58c2837] Linux 5.11-rc3
git bisect bad 7c53f6b671f4aba70ff15e1b05148b10d58c2837
# good: [2c85ebc57b3e1817b6ce1a6b703928e113a90442] Linux 5.10
git bisect good 2c85ebc57b3e1817b6ce1a6b703928e113a90442
# good: [3db1a3fa98808aa90f95ec3e0fa2fc7abf28f5c9] Merge tag 
'staging-5.11-rc1' of 
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
git bisect good 3db1a3fa98808aa90f95ec3e0fa2fc7abf28f5c9
# good: [9805529ec544ea7a82d891d5239a8ebd3dbb2a3e] Merge tag 
'arm-soc-dt-5.11' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect good 9805529ec544ea7a82d891d5239a8ebd3dbb2a3e
# good: [f4a2f7866faaf89ea1595b136e01fcb336b46aab] Merge tag 'rtc-5.11' 
of git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux
git bisect good f4a2f7866faaf89ea1595b136e01fcb336b46aab
# bad: [ef2c8b81b88868f042579b9dd021cc9edbc2d0c6] Merge tag 
'drm-next-2020-12-24' of git://anongit.freedesktop.org/drm/drm
git bisect bad ef2c8b81b88868f042579b9dd021cc9edbc2d0c6
# good: [8653b778e454a7708847aeafe689bce07aeeb94e] Merge tag 
'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
git bisect good 8653b778e454a7708847aeafe689bce07aeeb94e
# good: [4960821a4d80781fd3e63cd71fb1b38c2dadb915] Merge tag 
'pm-5.11-rc1-2' of 
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect good 4960821a4d80781fd3e63cd71fb1b38c2dadb915
# good: [418eddef050d5f6393c303a94e3173847ab85466] vdpa: Use simpler 
version of ida allocation
git bisect good 418eddef050d5f6393c303a94e3173847ab85466
# bad: [58cf05f597b03a8212d9ecf2c79ee046d3ee8ad9] Merge tag 
'sound-fix-5.11-rc1' of 
git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect bad 58cf05f597b03a8212d9ecf2c79ee046d3ee8ad9
# bad: [6755f4563144e38f375f43dbb01926fd4ce08620] Merge tag 
'linux-watchdog-5.11-rc1' of git://www.linux-watchdog.org/linux-watchdog
git bisect bad 6755f4563144e38f375f43dbb01926fd4ce08620
# good: [6f733cb2e7db38f8141b14740bcde577844a03b7] watchdog: Fix 
potential dereferencing of null pointer
git bisect good 6f733cb2e7db38f8141b14740bcde577844a03b7
# bad: [538fcf57aaee6ad78a05f52b69a99baa22b33418] Merge branches 
'acpi-scan', 'acpi-pnp' and 'acpi-sleep'
git bisect bad 538fcf57aaee6ad78a05f52b69a99baa22b33418
# bad: [9272e97ae9e9b95e0805c690404a0df9fb03055f] ACPI: scan: Add Intel 
Baytrail Mailbox Device to acpi_ignore_dep_ids
git bisect bad 9272e97ae9e9b95e0805c690404a0df9fb03055f
# bad: [71da201f38dfb0c3a3d33bbe3168ea9112299dde] ACPI: scan: Defer 
enumeration of devices with _DEP lists
git bisect bad 71da201f38dfb0c3a3d33bbe3168ea9112299dde
# good: [6fc250887cbe14a350d472516f2e0118240c5d68] ACPI: scan: Evaluate 
_DEP before adding the device
git bisect good 6fc250887cbe14a350d472516f2e0118240c5d68
# first bad commit: [71da201f38dfb0c3a3d33bbe3168ea9112299dde] ACPI: 
scan: Defer enumeration of devices with _DEP lists
