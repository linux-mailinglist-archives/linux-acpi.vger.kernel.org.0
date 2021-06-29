Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB8B3B7498
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jun 2021 16:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbhF2Oqy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Jun 2021 10:46:54 -0400
Received: from foss.arm.com ([217.140.110.172]:52714 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234552AbhF2Oqw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Jun 2021 10:46:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB7F5106F;
        Tue, 29 Jun 2021 07:44:22 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DA563F718;
        Tue, 29 Jun 2021 07:44:20 -0700 (PDT)
Date:   Tue, 29 Jun 2021 15:44:15 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Will Deacon <will@kernel.org>,
        CKI Project <cki-project@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Memory Management <mm-qe@redhat.com>,
        skt-results-master@redhat.com, Jeff Bastian <jbastian@redhat.com>,
        Jan Stancek <jstancek@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        rjw@rjwysocki.net, lenb@kernel.org, guohanjun@huawei.com,
        sudeep.holla@arm.com, ardb@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>, lv.zheng@intel.com,
        tony.luck@intel.com
Subject: Re: =?utf-8?B?4p2MIEZBSUw=?= =?utf-8?Q?=3A?= Test report for kernel
 5.13.0-rc7 (arm-next, 8ab9b1a9)
Message-ID: <20210629144415.GA28457@lpieralisi>
References: <cki.6A65B499FE.46BPQ6DJTC@redhat.com>
 <20210625083918.GA2736@willie-the-truck>
 <CA+tGwn=rP_hAMLLtoy_s90ZzBjfMggu7T2Qj8HyFfGh1BGUoRA@mail.gmail.com>
 <31ffe8fc-f5ee-2858-26c5-0fd8bdd68702@arm.com>
 <20210625110944.GB20835@arm.com>
 <48b23351-3dba-bec8-242f-3c918ae55708@arm.com>
 <8a28663f-6541-6ff4-3de0-b140e3f8a5b9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a28663f-6541-6ff4-3de0-b140e3f8a5b9@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 29, 2021 at 12:48:14PM +0100, Robin Murphy wrote:
> [ +ACPI audience ]
> 
> On 2021-06-25 12:15, Robin Murphy wrote:
> > On 2021-06-25 12:09, Catalin Marinas wrote:
> > > On Fri, Jun 25, 2021 at 12:02:52PM +0100, Robin Murphy wrote:
> > > > On 2021-06-25 10:52, Veronika Kabatova wrote:
> > > > [...]
> > > > > > >          ❌ stress: stress-ng
> > > > > > 
> > > > > > Oh no, this looks like another alignment fault in memcpy:
> > > > > > 
> > > > > > [13330.651903] Unable to handle kernel paging request at
> > > > > > virtual address ffff8000534705ff
> > > > > > [13330.651914] Mem abort info:
> > > > > > [13330.651918]   ESR = 0x96000021
> > > > > > [13330.651922]   EC = 0x25: DABT (current EL), IL = 32 bits
> > > > > > [13330.651928]   SET = 0, FnV = 0
> > > > > > [13330.651931]   EA = 0, S1PTW = 0
> > > > > > [13330.651933]   FSC = 0x21: alignment fault
> > > > > > [13330.651938] Data abort info:
> > > > > > [13330.651940]   ISV = 0, ISS = 0x00000021
> > > > > > [13330.651941]   CM = 0, WnR = 0
> > > > > > [13330.651943] swapper pgtable: 4k pages, 48-bit VAs,
> > > > > > pgdp=00000000f3e6b000
> > > > > > [13330.651945] [ffff8000534705ff] pgd=1000008ffcfff003,
> > > > > > p4d=1000008ffcfff003, pud=100000088e57d003,
> > > > > > pmd=10000008d0aeb003, pte=006800008021370f
> > > > > > [13330.651956] Internal error: Oops: 96000021 [#1] SMP
> > > > > > [13330.651961] Modules linked in: unix_diag binfmt_misc
> > > > > > fcrypt sm4_generic crc32_generic md4 michael_mic
> > > > > > nhpoly1305_neon nhpoly1305 poly1305_generic libpoly1305
> > > > > > poly1305_neon rmd160 sha3_generic sm3_generic
> > > > > > streebog_generic wp512 blowfish_generic blowfish_common
> > > > > > cast5_generic des_generic libdes chacha_generic
> > > > > > chacha_neon libchacha camellia_generic cast6_generic
> > > > > > cast_common serpent_generic twofish_generic
> > > > > > twofish_common dm_thin_pool dm_persistent_data
> > > > > > dm_bio_prison nvme nvme_core ipmi_watchdog ipmi_poweroff
> > > > > > loop tun af_key crypto_user scsi_transport_iscsi
> > > > > > xt_multiport ip_gre ip_tunnel gre overlay xt_CONNSECMARK
> > > > > > xt_SECMARK nft_counter xt_state xt_conntrack nft_compat
> > > > > > ah6 ah4 nft_objref nft_ct nf_conntrack nf_defrag_ipv6
> > > > > > nf_defrag_ipv4 nf_tables nfnetlink jfs sctp
> > > > > > ip6_udp_tunnel udp_tunnel dm_log_writes dm_flakey rfkill
> > > > > > mlx5_ib ib_uverbs ib_core sunrpc coresight_etm4x
> > > > > > i2c_smbus coresight_replicator coresight_tpiu
> > > > > > coresight_tmc joydev mlx5_core acpi_ipmi psample
> > > > > > ipmi_ssif mlxfw !
> > > > > >    ipmi_devintf
> > > > > > [13330.652076]  ipmi_msghandler coresight_funnel
> > > > > > thunderx2_pmu coresight vfat fat fuse zram ip_tables xfs
> > > > > > ast crct10dif_ce i2c_algo_bit ghash_ce drm_vram_helper
> > > > > > drm_kms_helper syscopyarea sysfillrect sysimgblt
> > > > > > fb_sys_fops cec drm_ttm_helper ttm drm gpio_xlp
> > > > > > i2c_xlp9xx uas usb_storage aes_neon_bs [last unloaded:
> > > > > > nvmet]
> > > > > > [13330.652123] CPU: 115 PID: 188446 Comm: stress-ng
> > > > > > Tainted: G           OEL    5.13.0-rc7 #1
> > > > > > [13330.652129] Hardware name: HPE Apollo 70
> > > > > > /C01_APACHE_MB         , BIOS L50_5.13_1.15 05/08/2020
> > > > > > [13330.652133] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO BTYPE=--)
> > > > > > [13330.652139] pc : __memcpy+0x168/0x250
> > > > > > [13330.652150] lr : memory_read_from_buffer+0x58/0x80
> > > > > > [13330.652161] sp : ffff800063ef3c20
> > > > > > [13330.652163] x29: ffff800063ef3c20 x28:
> > > > > > ffff0008b1380000 x27: 0000000000000000
> > > > > > [13330.652170] x26: 0000000000000000 x25:
> > > > > > 0000000000000000 x24: ffff00080a960fe0
> > > > > > [13330.652176] x23: ffff800063ef3d28 x22:
> > > > > > 000000000000063f x21: ffff800063ef3c88
> > > > > > [13330.652181] x20: 000000000000063f x19:
> > > > > > 000000000000063f x18: 0000000000000000
> > > > > > [13330.652186] x17: 0000000000000000 x16:
> > > > > > 0000000000000000 x15: 0000000000000000
> > > > > > [13330.652191] x14: 0000000000000000 x13:
> > > > > > 0000000000000000 x12: 0000000000000000
> > > > > > [13330.652196] x11: 0000000000000000 x10:
> > > > > > 0000000000000000 x9 : 0000000000000000
> > > > > > [13330.652200] x8 : 0000000000000000 x7 :
> > > > > > 0000000000000000 x6 : 0000000000000000
> > > > > > [13330.652206] x5 : ffff000d0fb0063f x4 :
> > > > > > ffff80005347063f x3 : ffff000d0fb005c0
> > > > > > [13330.652212] x2 : ffffffffffffffef x1 :
> > > > > > ffff800053470600 x0 : ffff000d0fb00000
> > > > > > [13330.652218] Call trace:
> > > > > > [13330.652221]  __memcpy+0x168/0x250
> > > > > > [13330.652225]  acpi_data_show+0x5c/0x8c
> > > > > > [13330.652232]  sysfs_kf_bin_read+0x78/0xa0
> > > > > > [13330.652238]  kernfs_file_read_iter+0x9c/0x1a4
> > > > > > [13330.652241]  kernfs_fop_read_iter+0x34/0x50
> > > > > > [13330.652244]  new_sync_read+0xdc/0x154
> > > > > > [13330.652253]  vfs_read+0x158/0x1e4
> > > > > > [13330.652260]  ksys_read+0x64/0xec
> > > > > > [13330.652266]  __arm64_sys_read+0x28/0x34
> > > > > > [13330.652273]  invoke_syscall+0x50/0x120
> > > > > > [13330.652280]  el0_svc_common.constprop.0+0x4c/0xd4
> > > > > > [13330.652284]  do_el0_svc+0x30/0x9c
> > > > > > [13330.652286]  el0_svc+0x2c/0x54
> > > > > > [13330.652294]  el0t_64_sync_handler+0x1a4/0x1b0
> > > > > > [13330.652296]  el0t_64_sync+0x19c/0x1a0
> > > > > > [13330.652303] Code: a984346c a9c4342c f1010042 54fffee8 (a97c3c8e)
> > > > > > [13330.652307] ---[ end trace 227d4380f57145d4 ]---
> > > > > > 
> > > > > > So maybe this issue isn't limited to weird modules, after all...
> > > > > > 
> > > > > 
> > > > > It ran on the machine from the same set that we were able to reproduce
> > > > > it on previously. If you or anyone else have an idea on how
> > > > > to stabilize
> > > > > the reproducibility or have a debug patch we'll be happy to try it.
> > > > 
> > > > Possibly it depends on the individual machines' firmware exactly how the
> > > > relevant bits of their ACPI tables are aligned in memory?
> > > > 
> > > > I've started digging into that callstack - it may not be a
> > > > "weird module"
> > > > but it's definitely crusty ACPI code... a238317ce818 ("ACPI: Clean up
> > > > acpi_os_map/unmap_memory() to eliminate __iomem.") looks frankly a bit
> > > > questionable in its decision to blithely cast away __iomem, but then the
> > > > rationale in aafc65c731fe ("ACPI: add arm64 to the platforms that use
> > > > ioremap") seems particularly dubious on top of that (especially
> > > > given this
> > > > end result).
> > > > 
> > > > At a wild guess, I'm wondering if this may be sufficient:
> > > > 
> > > > ----->8-----
> > > > diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> > > > index 327e1b4eb6b0..f5d26b102fbe 100644
> > > > --- a/drivers/acpi/osl.c
> > > > +++ b/drivers/acpi/osl.c
> > > > @@ -277,7 +277,7 @@ acpi_map_lookup_virt(void __iomem *virt,
> > > > acpi_size size)
> > > >          return NULL;
> > > >   }
> > > > 
> > > > -#if defined(CONFIG_IA64) || defined(CONFIG_ARM64)
> > > > +#if defined(CONFIG_IA64)
> > > >   /* ioremap will take care of cache attributes */
> > > >   #define should_use_kmap(pfn)   0
> > > >   #else
> > > > -----8<-----
> > > 
> > > I thought the same but shouldn't acpi_os_ioremap() map it with the right
> > > attributes? It uses the EFI maps to check what kind of memory this is.
> > 
> > Oh crikey, I missed that branch of the rabbit hole... I guess that must
> > mean that the tables being poked here are *not* covered by the EFI
> > memory map, so page_is_ram() is unlikely to help either :(
> 
> After picking through the UEFI spec I think I've now got a clearer picture
> of what's happening, but I'm not sure where it goes from here...
> 
> The spec implies that it *is* legitimate for runtime-loaded ACPI tables to
> lie outside the EFI memory map, and that case they must be assumed to be
> uncached, so the behaviour of acpi_os_ioremap() is correct.

I'd agree with the reasoning, it would be good to pinpoint whether
that's what actually triggers the issue.

I'd like to replicate it if possible (it is TX2 HW but firmware
config is likely to differ from the HW I have at hand), the
test command line that triggers the fault would be useful as
a starting point.

Furthermore, is this a v5.13-rc* regression ? If so it would be
good to bisect it - I can't recollect arm64 changes that could
have introduced this regression in the last cycle but I may have
missed something.

> Given the definition of uncached for arm64 memory types though, that
> means that callers of acpi_os_map_memory() still have to be prepared
> to get an __iomem pointer back even if they know they're mapping a
> table rather than some random bit of MMIO for an AML method.
> 
> Therefore in this case it seems the blame lies partway between
> acpi_os_map_memory() for casting away __iomem and acpi_data_show() for
> letting an arbitrary offset lead to an arbitrarily-aligned memcpy(), but I
> don't know what the best way to fix it is. Either way I've satisfied myself
> that it's not an issue with the arm64 code itself - I do wonder whether this
> might also be a problem on IA-64 given ACPI_MISALIGNMENT_NOT_SUPPORTED, and
> I guess RISC-V may have alignment concerns as well.

Yes agreed but see above, this code has been there for aeons if it
is a v5.13-rc* regression it must be something else that actually
triggered it (test/FW config).

Thanks for looking into this.

Lorenzo
