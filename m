Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82D8010304E
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2019 00:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfKSXg3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Nov 2019 18:36:29 -0500
Received: from mx.aristanetworks.com ([162.210.129.12]:49027 "EHLO
        smtp.aristanetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfKSXg3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Nov 2019 18:36:29 -0500
X-Greylist: delayed 341 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Nov 2019 18:36:29 EST
Received: from us180.sjc.aristanetworks.com (us180.sjc.aristanetworks.com [172.25.230.4])
        by smtp.aristanetworks.com (Postfix) with ESMTP id 7335B40186F;
        Tue, 19 Nov 2019 15:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1574206247;
        bh=7hTxUZAHCeTYICBD3dCxn3lCMI94VzJ7Cmd8ewom4xE=;
        h=Date:To:Subject:From:From;
        b=hmWMzUemrhYukBBsgZFXHLBVrJYPeOxvVL2Ex0qXLeeta1eAXdC4RzwOPWwYvbDrG
         BlXjVBYRdDH6G5wgeLEPqSF3E0wUI7f31vF1Ihd/swPzseEBvkXeznpvjbRYS57mfs
         sC+U/L6i1RKb/asEykxkxg5jm5lGzQCzXEjsjYxkOwaJzHsTKADuSoMSO8ieX/iWVV
         T8xU1ti8spnpVT3xbgPvwh2N7BWUD3Jqo8m0+vSzbAGDgMAWcY4Rtl64Qe7FFRHlj4
         EgSvl3MZacfi3e3nPFycsSnMf3LOr6WRQlq3Gmy06BHxvE2RLh9V3PRNDa9kM/rlNC
         SlZWeD3b/mbtw==
Received: by us180.sjc.aristanetworks.com (Postfix, from userid 10189)
        id 5447495C0DE7; Tue, 19 Nov 2019 15:30:47 -0800 (PST)
Date:   Tue, 19 Nov 2019 15:30:47 -0800
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        fruggeri@arista.com
Subject: Kernel panic when reading /sys/firmware/acpi/tables/data/BERT
User-Agent: Heirloom mailx 12.5 7/5/10
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20191119233047.5447495C0DE7@us180.sjc.aristanetworks.com>
From:   fruggeri@arista.com (Francesco Ruggeri)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

If I run

for ((i=0; i<10; i++))
	do for ((j=0; j<1000000; j++))
		do cat /sys/firmware/acpi/tables/data/BERT >/dev/null
	done &
done

I see this panic in 5.3.11. I see a similar panic in 4.19.84.

Is this a know issue?

Thanks,

Francesco Ruggeri

[   96.496605] x86/PAT: cat:14315 freeing invalid memtype [mem 0x7e212000-0x7e212fff]
[   96.496606] ------------[ cut here ]------------
[   96.496609] kernel BUG at arch/x86/mm/ioremap.c:457!
[   96.513923] invalid opcode: 0000 [#1] SMP
[   96.517978] CPU: 21 PID: 14316 Comm: cat Kdump: loaded Not tainted 5.3.11-14308225.AroraKernelnext.fc18.x86_64 #1
[   96.528284] Hardware name: Supermicro X9DRT/X9DRT, BIOS 3.0 06/28/2013
[   96.534872] RIP: 0010:iounmap+0xa1/0xb0
[   96.538766] Code: f6 44 24 18 40 48 8d b0 00 f0 ff ff 48 0f 45 f0 48 01 fe e8 78 3b 00 00 48 89 df e8 cd 34 14 00 49 39 c4 75 05 48 85 c0 75 02 <0f> 0b 4c 89 e7 e8 ac 3d 16 00 5b 41 5c 5d c3 66 66 66 66 90 55 48
[   96.557594] RSP: 0018:ffffc9000cd87d80 EFLAGS: 00010286
[   96.562867] RAX: 0000000000000000 RBX: ffffc9000cd91000 RCX: 0000000000000001
[   96.570053] RDX: ba7841fee6198e00 RSI: 0000000000000001 RDI: ffffc9000cd91000
[   96.577251] RBP: ffffc9000cd87d90 R08: 0000000000000001 R09: ffffffff81052572
[   96.584433] R10: ffffc9000cd87d28 R11: 0000000000000000 R12: ffff88a038a034c0
[   96.591627] R13: ffff88903b902000 R14: ffffc9000cd87ee8 R15: ffff88903b8eeda0
[   96.598812] FS:  00007f7cb3d01700(0000) GS:ffff88903fb40000(0000) knlGS:0000000000000000
[   96.606951] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   96.612969] CR2: 00007f5df9b4f030 CR3: 0000001033f50004 CR4: 00000000000606e0
[   96.620375] Call Trace:
[   96.623095]  acpi_os_map_cleanup.part.14+0x31/0x3e
[   96.628158]  acpi_os_unmap_iomem+0xc9/0xcf
[   96.632509]  acpi_os_unmap_memory+0xe/0x10
[   96.636886]  acpi_data_show+0x66/0x73
[   96.640814]  sysfs_kf_bin_read+0x69/0x6c
[   96.645000]  kernfs_fop_read+0xe1/0x152
[   96.649094]  __vfs_read+0x18/0x2f
[   96.652665]  vfs_read+0xa4/0xdc
[   96.656064]  ksys_read+0x6a/0xb6
[   96.659553]  __x64_sys_read+0x1a/0x1c
[   96.663483]  do_syscall_64+0x4c/0x5b
[   96.667330]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   96.672637] RIP: 0033:0x7f7cb3812020
[   96.676482] Code: b6 fe ff ff 48 8d 3d 1f e6 09 00 48 83 ec 08 e8 f6 97 02 00 66 0f 1f 44 00 00 83 3d 7d f7 2d 00 00 75 10 b8 00 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 7e d2 01 00 48 89 04 24
[   96.695955] RSP: 002b:00007ffcdd7852c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[   96.703985] RAX: ffffffffffffffda RBX: 0000000000010000 RCX: 00007f7cb3812020
[   96.711372] RDX: 0000000000010000 RSI: 000000000246c000 RDI: 0000000000000003
[   96.718766] RBP: 0000000000010000 R08: 0000000000000000 R09: 000000000246b030
[   96.726176] R10: 00007ffcdd784d28 R11: 0000000000000246 R12: 000000000246c000
[   96.733565] R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000010000
[   96.740958] Modules linked in: xt_MASQUERADE nf_conntrack_netlink iptable_filter xt_addrtype xt_conntrack br_netfilter bridge stp llc macvlan sg coretemp iTCO_wdt iTCO_vendor_support ip6table_filter ip6_tables x86_pkg_temp_thermal bonding ghash_clmulni_intel kvm_intel aesni_intel kvm igb irqbypass aes_x86_64 fuse hwmon glue_helper crypto_simd i2c_i801 i2c_algo_bit xt_multiport ioatdma cryptd lpc_ich joydev mfd_core i2c_core pcspkr dca iptable_nat ipmi_si ip_tables ipmi_msghandler nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 x_tables loop tun 8021q raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 isci ehci_pci libsas crc32c_intel ehci_hcd scsi_transport_sas wmi autofs4


