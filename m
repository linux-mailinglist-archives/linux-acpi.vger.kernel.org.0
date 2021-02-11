Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B52E318492
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Feb 2021 06:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhBKFVd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 11 Feb 2021 00:21:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:44540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229499AbhBKFVc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 11 Feb 2021 00:21:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29C7A64DE9;
        Thu, 11 Feb 2021 05:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613020851;
        bh=KdBGNzag/01kzofZT39hds+qMD7l9yoSaUDih1opjlI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fzYYioOelzFLe5ASclX6eHJGN7WoFZhlaJMK+ymsazIW579bo+vqgJ9uUx0QF44tO
         qAM7+YrvJuiJ+qeZUBkqEKOH7zHarvQfuqFH7t3JbQII6cuCh9WLkCWGqrs2pbWALo
         dIiTiCvSKaZRhbN0wwTNBD81DxAI4ylbXl4ZyQTtyl3bi685SXX8m3klblmA3MU8+j
         1XAoVrOuFJ88Y1LuZL5MmPFjj5oVK61grGSxS2ijFmsOmb3Z5ZKqtiIx9VdWQgogdp
         1CVhVYA8ReU1EfsDqAx8dJ5yJiGAhNqBYa3jNPlhxm4r0GIQvP6Lqoljo4W8MB6NAO
         IRginZBttRRcg==
Date:   Thu, 11 Feb 2021 10:50:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Marcin =?utf-8?Q?=C5=9Alusarz?= <marcin.slusarz@gmail.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        marcin.slusarz@intel.com, Takashi Iwai <tiwai@suse.de>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 1/2] soundwire: intel: fix possible crash when no device
 is detected
Message-ID: <20210211052047.GH2774@vkoul-mobl.Dlink>
References: <a3f01a5d-d7a5-8280-4091-b2486b01a782@linux.intel.com>
 <20210208120104.204761-1-marcin.slusarz@gmail.com>
 <CAJZ5v0gftDzua87J0To87=Huer2q=_z=0Bj2q++OQAYNtPe86w@mail.gmail.com>
 <e6d3f589-fa9b-baee-8dba-6a7c09e50b83@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6d3f589-fa9b-baee-8dba-6a7c09e50b83@linux.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 10-02-21, 17:15, Pierre-Louis Bossart wrote:
> 
> 
> On 2/8/21 6:37 AM, Rafael J. Wysocki wrote:
> > On Mon, Feb 8, 2021 at 1:01 PM Marcin Ślusarz <marcin.slusarz@gmail.com> wrote:
> > > 
> > > From: Marcin Ślusarz <marcin.slusarz@intel.com>
> > > 
> > > acpi_walk_namespace can return success without executing our
> > > callback which initializes info->handle.
> > > If the random value in this structure is a valid address (which
> > > is on the stack, so it's quite possible), then nothing bad will
> > > happen, because:
> > > sdw_intel_scan_controller
> > >   -> acpi_bus_get_device
> > >   -> acpi_get_device_data
> > >   -> acpi_get_data_full
> > >   -> acpi_ns_validate_handle
> > > will reject this handle.
> > > 
> > > However, if the value from the stack doesn't point to a valid
> > > address, we get this:
> > > 
> > > BUG: kernel NULL pointer dereference, address: 0000000000000050
> > > PGD 0 P4D 0
> > > Oops: 0000 [#1] SMP NOPTI
> > > CPU: 6 PID: 472 Comm: systemd-udevd Tainted: G        W         5.10.0-1-amd64 #1 Debian 5.10.4-1
> > > Hardware name: HP HP Pavilion Laptop 15-cs3xxx/86E2, BIOS F.05 01/01/2020
> > > RIP: 0010:acpi_ns_validate_handle+0x1a/0x23
> > > Code: 00 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f c3 0f 1f 44 00 00 48 8d 57 ff 48 89 f8 48 83 fa fd 76 08 48 8b 05 0c b8 67 01 c3 <80> 7f 08 0f 74 02 31 c0 c3 0f 1f 44 00 00 48 8b 3d f6 b7 67 01 e8
> > > RSP: 0000:ffffc388807c7b20 EFLAGS: 00010213
> > > RAX: 0000000000000048 RBX: ffffc388807c7b70 RCX: 0000000000000000
> > > RDX: 0000000000000047 RSI: 0000000000000246 RDI: 0000000000000048
> > > RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> > > R10: ffffffffc0f5f4d1 R11: ffffffff8f0cb268 R12: 0000000000001001
> > > R13: ffffffff8e33b160 R14: 0000000000000048 R15: 0000000000000000
> > > FS:  00007f24548288c0(0000) GS:ffff9f781fb80000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 0000000000000050 CR3: 0000000106158004 CR4: 0000000000770ee0
> > > PKRU: 55555554
> > > Call Trace:
> > >   acpi_get_data_full+0x4d/0x92
> > >   acpi_bus_get_device+0x1f/0x40
> > >   sdw_intel_acpi_scan+0x59/0x230 [soundwire_intel]
> > >   ? strstr+0x22/0x60
> > >   ? dmi_matches+0x76/0xe0
> > >   snd_intel_dsp_driver_probe.cold+0xaf/0x163 [snd_intel_dspcfg]
> > >   azx_probe+0x7a/0x970 [snd_hda_intel]
> > >   local_pci_probe+0x42/0x80
> > >   ? _cond_resched+0x16/0x40
> > >   pci_device_probe+0xfd/0x1b0
> > >   really_probe+0x205/0x460
> > >   driver_probe_device+0xe1/0x150
> > >   device_driver_attach+0xa1/0xb0
> > >   __driver_attach+0x8a/0x150
> > >   ? device_driver_attach+0xb0/0xb0
> > >   ? device_driver_attach+0xb0/0xb0
> > >   bus_for_each_dev+0x78/0xc0
> > >   bus_add_driver+0x12b/0x1e0
> > >   driver_register+0x8b/0xe0
> > >   ? 0xffffffffc0f65000
> > >   do_one_initcall+0x44/0x1d0
> > >   ? do_init_module+0x23/0x250
> > >   ? kmem_cache_alloc_trace+0xf5/0x200
> > >   do_init_module+0x5c/0x250
> > >   __do_sys_finit_module+0xb1/0x110
> > >   do_syscall_64+0x33/0x80
> > >   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > 
> > > CC: stable@vger.kernel.org
> > > Signed-off-by: Marcin Ślusarz <marcin.slusarz@intel.com>
> > > Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > 
> > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Adding Vinod, Takashi, Mark and Jaroslav in CC: to make sure this patch does
> not fall between the cracks.
> 
> This issue may impact all HDaudio platforms and this patch needs to reach
> Linus' tree and 5.10-stable. Thanks!

Applied, thanks.. I will send it up so that it is part of rc1 and gets
added to stable too

-- 
~Vinod
