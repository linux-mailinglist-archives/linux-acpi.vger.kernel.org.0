Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338943B76DD
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jun 2021 19:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbhF2RGP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Jun 2021 13:06:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46736 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232222AbhF2RGP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Jun 2021 13:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624986227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jCQRTyqyVi+Vp1ty27vzq1AjGmjrma8NUfWzxhJcTzE=;
        b=Dr6WEoFAE0DSQBLyzCk/5RPrMUVQhmlvN6sUEoKW1SyTWzY4TrmOflXUv9BdFdFHKtMtoC
        yj9gcHMohtjTqMg6TLRVytUuLtZgMBU419wmsMSHDF6xotu6aQdvwe9vvyTi7ZadF4RqOg
        JxbIlVZXon0SNSvQ79/HDjd/slVG5ug=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-6zaiaG9iMv6Kht4lkb5fhw-1; Tue, 29 Jun 2021 13:03:46 -0400
X-MC-Unique: 6zaiaG9iMv6Kht4lkb5fhw-1
Received: by mail-lj1-f199.google.com with SMTP id q6-20020a05651c0546b029016e41a5a837so8644928ljp.21
        for <linux-acpi@vger.kernel.org>; Tue, 29 Jun 2021 10:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jCQRTyqyVi+Vp1ty27vzq1AjGmjrma8NUfWzxhJcTzE=;
        b=LgEkGMyVRQxNDB7EJb+a2xBKnSqHby2dD+BLn/etzJv3O7RnkKZF47QayqkdEdL5xt
         ekgs7r4vS1XnVgbwPTaFO66qE8lGcR/Bv2vzjUrDSYI9BIkPKcOiJq+kx8mdGrMJkmsF
         XJKT60dM3jbd1U8Jr/OaS1w0/+UgFlQwAKHewSxSFyzT4QPq8PiOvUsXgY/tQsPMceLw
         d5ka+tdvS9Q9psvw0jyDuVoT8ifP8vyapZVkrccqqEWDClt00PZyU/g59A9TkGAEZ+Dr
         HDAVq/XLy+4Laf03GQnfSHDUguvUsf3vSiuDA5rxWP1SecKYUqE8MqtF73tpU/TsItSk
         Ww4A==
X-Gm-Message-State: AOAM5322+af19mpVwPs0O5eIdn4G0r03t1/SBwiM9/G2uPCr1R/TFkQh
        CBd4xOuRdEfIBSrGg6ZJlRtE5yqpIZk/H3z8IX+gA8Q55SHzuo51jPnctz4WCI5vNhW2cvlzkSm
        0dJfB07DHG37z7BldRVigbZcpwqMHlv6qHl4+HQ==
X-Received: by 2002:a2e:8596:: with SMTP id b22mr4673930lji.63.1624986223441;
        Tue, 29 Jun 2021 10:03:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQlrAa5jZbQThvuA5wXj9dVOXkkl0XOAeQ9xCnlXSm5u+JPnEbES+UurigQ6SOSsm9ysp1m3DZhormjkHLLzo=
X-Received: by 2002:a2e:8596:: with SMTP id b22mr4673873lji.63.1624986222770;
 Tue, 29 Jun 2021 10:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <cki.6A65B499FE.46BPQ6DJTC@redhat.com> <20210625083918.GA2736@willie-the-truck>
 <CA+tGwn=rP_hAMLLtoy_s90ZzBjfMggu7T2Qj8HyFfGh1BGUoRA@mail.gmail.com>
 <31ffe8fc-f5ee-2858-26c5-0fd8bdd68702@arm.com> <20210625110944.GB20835@arm.com>
 <48b23351-3dba-bec8-242f-3c918ae55708@arm.com> <8a28663f-6541-6ff4-3de0-b140e3f8a5b9@arm.com>
 <20210629144415.GA28457@lpieralisi> <14ca6f72-9b0f-ebd7-9cf8-a5d6190c8e5d@arm.com>
In-Reply-To: <14ca6f72-9b0f-ebd7-9cf8-a5d6190c8e5d@arm.com>
From:   Veronika Kabatova <vkabatov@redhat.com>
Date:   Tue, 29 Jun 2021 19:03:06 +0200
Message-ID: <CA+tGwn=r=BZK08CHBUkk1m5NB-W7GqC9Cwj6Qj+_MbYzqdEjDg@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOKdjCBGQUlMOiBUZXN0IHJlcG9ydCBmb3Iga2VybmVsIDUuMTMuMC1yYzcgKGFybQ==?=
        =?UTF-8?B?LW5leHQsIDhhYjliMWE5KQ==?=
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        CKI Project <cki-project@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Memory Management <mm-qe@redhat.com>,
        skt-results-master@redhat.com, Jeff Bastian <jbastian@redhat.com>,
        Jan Stancek <jstancek@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        rjw@rjwysocki.net, lenb@kernel.org, guohanjun@huawei.com,
        sudeep.holla@arm.com, Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, lv.zheng@intel.com,
        tony.luck@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 29, 2021 at 5:15 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-06-29 15:44, Lorenzo Pieralisi wrote:
> > On Tue, Jun 29, 2021 at 12:48:14PM +0100, Robin Murphy wrote:
> >> [ +ACPI audience ]
> >>
> >> On 2021-06-25 12:15, Robin Murphy wrote:
> >>> On 2021-06-25 12:09, Catalin Marinas wrote:
> >>>> On Fri, Jun 25, 2021 at 12:02:52PM +0100, Robin Murphy wrote:
> >>>>> On 2021-06-25 10:52, Veronika Kabatova wrote:
> >>>>> [...]
> >>>>>>>>           =E2=9D=8C stress: stress-ng
> >>>>>>>
> >>>>>>> Oh no, this looks like another alignment fault in memcpy:
> >>>>>>>
> >>>>>>> [13330.651903] Unable to handle kernel paging request at
> >>>>>>> virtual address ffff8000534705ff
> >>>>>>> [13330.651914] Mem abort info:
> >>>>>>> [13330.651918]   ESR =3D 0x96000021
> >>>>>>> [13330.651922]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> >>>>>>> [13330.651928]   SET =3D 0, FnV =3D 0
> >>>>>>> [13330.651931]   EA =3D 0, S1PTW =3D 0
> >>>>>>> [13330.651933]   FSC =3D 0x21: alignment fault
> >>>>>>> [13330.651938] Data abort info:
> >>>>>>> [13330.651940]   ISV =3D 0, ISS =3D 0x00000021
> >>>>>>> [13330.651941]   CM =3D 0, WnR =3D 0
> >>>>>>> [13330.651943] swapper pgtable: 4k pages, 48-bit VAs,
> >>>>>>> pgdp=3D00000000f3e6b000
> >>>>>>> [13330.651945] [ffff8000534705ff] pgd=3D1000008ffcfff003,
> >>>>>>> p4d=3D1000008ffcfff003, pud=3D100000088e57d003,
> >>>>>>> pmd=3D10000008d0aeb003, pte=3D006800008021370f
> >>>>>>> [13330.651956] Internal error: Oops: 96000021 [#1] SMP
> >>>>>>> [13330.651961] Modules linked in: unix_diag binfmt_misc
> >>>>>>> fcrypt sm4_generic crc32_generic md4 michael_mic
> >>>>>>> nhpoly1305_neon nhpoly1305 poly1305_generic libpoly1305
> >>>>>>> poly1305_neon rmd160 sha3_generic sm3_generic
> >>>>>>> streebog_generic wp512 blowfish_generic blowfish_common
> >>>>>>> cast5_generic des_generic libdes chacha_generic
> >>>>>>> chacha_neon libchacha camellia_generic cast6_generic
> >>>>>>> cast_common serpent_generic twofish_generic
> >>>>>>> twofish_common dm_thin_pool dm_persistent_data
> >>>>>>> dm_bio_prison nvme nvme_core ipmi_watchdog ipmi_poweroff
> >>>>>>> loop tun af_key crypto_user scsi_transport_iscsi
> >>>>>>> xt_multiport ip_gre ip_tunnel gre overlay xt_CONNSECMARK
> >>>>>>> xt_SECMARK nft_counter xt_state xt_conntrack nft_compat
> >>>>>>> ah6 ah4 nft_objref nft_ct nf_conntrack nf_defrag_ipv6
> >>>>>>> nf_defrag_ipv4 nf_tables nfnetlink jfs sctp
> >>>>>>> ip6_udp_tunnel udp_tunnel dm_log_writes dm_flakey rfkill
> >>>>>>> mlx5_ib ib_uverbs ib_core sunrpc coresight_etm4x
> >>>>>>> i2c_smbus coresight_replicator coresight_tpiu
> >>>>>>> coresight_tmc joydev mlx5_core acpi_ipmi psample
> >>>>>>> ipmi_ssif mlxfw !
> >>>>>>>     ipmi_devintf
> >>>>>>> [13330.652076]  ipmi_msghandler coresight_funnel
> >>>>>>> thunderx2_pmu coresight vfat fat fuse zram ip_tables xfs
> >>>>>>> ast crct10dif_ce i2c_algo_bit ghash_ce drm_vram_helper
> >>>>>>> drm_kms_helper syscopyarea sysfillrect sysimgblt
> >>>>>>> fb_sys_fops cec drm_ttm_helper ttm drm gpio_xlp
> >>>>>>> i2c_xlp9xx uas usb_storage aes_neon_bs [last unloaded:
> >>>>>>> nvmet]
> >>>>>>> [13330.652123] CPU: 115 PID: 188446 Comm: stress-ng
> >>>>>>> Tainted: G           OEL    5.13.0-rc7 #1
> >>>>>>> [13330.652129] Hardware name: HPE Apollo 70
> >>>>>>> /C01_APACHE_MB         , BIOS L50_5.13_1.15 05/08/2020
> >>>>>>> [13330.652133] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO BTYPE=
=3D--)
> >>>>>>> [13330.652139] pc : __memcpy+0x168/0x250
> >>>>>>> [13330.652150] lr : memory_read_from_buffer+0x58/0x80
> >>>>>>> [13330.652161] sp : ffff800063ef3c20
> >>>>>>> [13330.652163] x29: ffff800063ef3c20 x28:
> >>>>>>> ffff0008b1380000 x27: 0000000000000000
> >>>>>>> [13330.652170] x26: 0000000000000000 x25:
> >>>>>>> 0000000000000000 x24: ffff00080a960fe0
> >>>>>>> [13330.652176] x23: ffff800063ef3d28 x22:
> >>>>>>> 000000000000063f x21: ffff800063ef3c88
> >>>>>>> [13330.652181] x20: 000000000000063f x19:
> >>>>>>> 000000000000063f x18: 0000000000000000
> >>>>>>> [13330.652186] x17: 0000000000000000 x16:
> >>>>>>> 0000000000000000 x15: 0000000000000000
> >>>>>>> [13330.652191] x14: 0000000000000000 x13:
> >>>>>>> 0000000000000000 x12: 0000000000000000
> >>>>>>> [13330.652196] x11: 0000000000000000 x10:
> >>>>>>> 0000000000000000 x9 : 0000000000000000
> >>>>>>> [13330.652200] x8 : 0000000000000000 x7 :
> >>>>>>> 0000000000000000 x6 : 0000000000000000
> >>>>>>> [13330.652206] x5 : ffff000d0fb0063f x4 :
> >>>>>>> ffff80005347063f x3 : ffff000d0fb005c0
> >>>>>>> [13330.652212] x2 : ffffffffffffffef x1 :
> >>>>>>> ffff800053470600 x0 : ffff000d0fb00000
> >>>>>>> [13330.652218] Call trace:
> >>>>>>> [13330.652221]  __memcpy+0x168/0x250
> >>>>>>> [13330.652225]  acpi_data_show+0x5c/0x8c
> >>>>>>> [13330.652232]  sysfs_kf_bin_read+0x78/0xa0
> >>>>>>> [13330.652238]  kernfs_file_read_iter+0x9c/0x1a4
> >>>>>>> [13330.652241]  kernfs_fop_read_iter+0x34/0x50
> >>>>>>> [13330.652244]  new_sync_read+0xdc/0x154
> >>>>>>> [13330.652253]  vfs_read+0x158/0x1e4
> >>>>>>> [13330.652260]  ksys_read+0x64/0xec
> >>>>>>> [13330.652266]  __arm64_sys_read+0x28/0x34
> >>>>>>> [13330.652273]  invoke_syscall+0x50/0x120
> >>>>>>> [13330.652280]  el0_svc_common.constprop.0+0x4c/0xd4
> >>>>>>> [13330.652284]  do_el0_svc+0x30/0x9c
> >>>>>>> [13330.652286]  el0_svc+0x2c/0x54
> >>>>>>> [13330.652294]  el0t_64_sync_handler+0x1a4/0x1b0
> >>>>>>> [13330.652296]  el0t_64_sync+0x19c/0x1a0
> >>>>>>> [13330.652303] Code: a984346c a9c4342c f1010042 54fffee8 (a97c3c8=
e)
> >>>>>>> [13330.652307] ---[ end trace 227d4380f57145d4 ]---
> >>>>>>>
> >>>>>>> So maybe this issue isn't limited to weird modules, after all...
> >>>>>>>
> >>>>>>
> >>>>>> It ran on the machine from the same set that we were able to repro=
duce
> >>>>>> it on previously. If you or anyone else have an idea on how
> >>>>>> to stabilize
> >>>>>> the reproducibility or have a debug patch we'll be happy to try it=
.
> >>>>>
> >>>>> Possibly it depends on the individual machines' firmware exactly ho=
w the
> >>>>> relevant bits of their ACPI tables are aligned in memory?
> >>>>>
> >>>>> I've started digging into that callstack - it may not be a
> >>>>> "weird module"
> >>>>> but it's definitely crusty ACPI code... a238317ce818 ("ACPI: Clean =
up
> >>>>> acpi_os_map/unmap_memory() to eliminate __iomem.") looks frankly a =
bit
> >>>>> questionable in its decision to blithely cast away __iomem, but the=
n the
> >>>>> rationale in aafc65c731fe ("ACPI: add arm64 to the platforms that u=
se
> >>>>> ioremap") seems particularly dubious on top of that (especially
> >>>>> given this
> >>>>> end result).
> >>>>>
> >>>>> At a wild guess, I'm wondering if this may be sufficient:
> >>>>>
> >>>>> ----->8-----
> >>>>> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> >>>>> index 327e1b4eb6b0..f5d26b102fbe 100644
> >>>>> --- a/drivers/acpi/osl.c
> >>>>> +++ b/drivers/acpi/osl.c
> >>>>> @@ -277,7 +277,7 @@ acpi_map_lookup_virt(void __iomem *virt,
> >>>>> acpi_size size)
> >>>>>           return NULL;
> >>>>>    }
> >>>>>
> >>>>> -#if defined(CONFIG_IA64) || defined(CONFIG_ARM64)
> >>>>> +#if defined(CONFIG_IA64)
> >>>>>    /* ioremap will take care of cache attributes */
> >>>>>    #define should_use_kmap(pfn)   0
> >>>>>    #else
> >>>>> -----8<-----
> >>>>
> >>>> I thought the same but shouldn't acpi_os_ioremap() map it with the r=
ight
> >>>> attributes? It uses the EFI maps to check what kind of memory this i=
s.
> >>>
> >>> Oh crikey, I missed that branch of the rabbit hole... I guess that mu=
st
> >>> mean that the tables being poked here are *not* covered by the EFI
> >>> memory map, so page_is_ram() is unlikely to help either :(
> >>
> >> After picking through the UEFI spec I think I've now got a clearer pic=
ture
> >> of what's happening, but I'm not sure where it goes from here...
> >>
> >> The spec implies that it *is* legitimate for runtime-loaded ACPI table=
s to
> >> lie outside the EFI memory map, and that case they must be assumed to =
be
> >> uncached, so the behaviour of acpi_os_ioremap() is correct.
> >
> > I'd agree with the reasoning, it would be good to pinpoint whether
> > that's what actually triggers the issue.
> >
> > I'd like to replicate it if possible (it is TX2 HW but firmware
> > config is likely to differ from the HW I have at hand), the
> > test command line that triggers the fault would be useful as
> > a starting point.
> >

The failure is always triggered during stress testing, see source at

https://gitlab.com/cki-project/kernel-tests/-/tree/main/stress/stress-ng

The runtest file is specific to run in our lab, but all it does is running
subsets of the upstream test (see the "*.stressors" files). Upstream
test version is V0.12.05 and the version wasn't changed since long
before we started hitting the problem. The failures were observed on
both Fedora 33 and 34 releases, I don't think the distro choice matters
but mentioning it just in case.

It doesn't reproduce 100%, anytime we tried to reproduce it on purpose
we couldn't trigger the issue. As if it knew we're watching...

> > Furthermore, is this a v5.13-rc* regression ? If so it would be
> > good to bisect it - I can't recollect arm64 changes that could
> > have introduced this regression in the last cycle but I may have
> > missed something.
>
> The actual change which has brought this to light is the update to
> arm64's memcpy() routine for 5.13 - the new version is more aggressive
> at making unaligned loads from the source buffer, so now triggers
> alignment faults more readily when (wrongly) used on iomem mappings in
> places that were getting away with it by chance under the previous
> implementation (see also [1], for example).
>

We dug into the history of runs, the first record we have is from the
mainline commit eb6bbacc46720b8b from April 28. The previously tested
commit fafe1e39ed213221c0bce doesn't hit any problems when running
stress-ng. Unfortunately we don't have logs from that first failed run
anymore as they are only saved for 6 weeks, the first logs we still have
are from May 11 from mainline commit c90b1834703f13b3a:

https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawa=
rehouse-public/2021/05/11/301024644/build_aarch64_redhat:1253670447/tests/9=
969720_aarch64_2_console.log


Veronika

> Thanks,
> Robin.
>
> [1]
> https://lore.kernel.org/linux-arm-kernel/20210608153344.3813661-1-narmstr=
ong@baylibre.com/
>
> >> Given the definition of uncached for arm64 memory types though, that
> >> means that callers of acpi_os_map_memory() still have to be prepared
> >> to get an __iomem pointer back even if they know they're mapping a
> >> table rather than some random bit of MMIO for an AML method.
> >>
> >> Therefore in this case it seems the blame lies partway between
> >> acpi_os_map_memory() for casting away __iomem and acpi_data_show() for
> >> letting an arbitrary offset lead to an arbitrarily-aligned memcpy(), b=
ut I
> >> don't know what the best way to fix it is. Either way I've satisfied m=
yself
> >> that it's not an issue with the arm64 code itself - I do wonder whethe=
r this
> >> might also be a problem on IA-64 given ACPI_MISALIGNMENT_NOT_SUPPORTED=
, and
> >> I guess RISC-V may have alignment concerns as well.
> >
> > Yes agreed but see above, this code has been there for aeons if it
> > is a v5.13-rc* regression it must be something else that actually
> > triggered it (test/FW config).
> >
> > Thanks for looking into this.
> >
> > Lorenzo
> >
>

