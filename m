Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B5E2FDA4A
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Jan 2021 20:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732317AbhATT6A (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Jan 2021 14:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732467AbhATT5s (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jan 2021 14:57:48 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130C9C061575
        for <linux-acpi@vger.kernel.org>; Wed, 20 Jan 2021 11:57:00 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a12so24226386wrv.8
        for <linux-acpi@vger.kernel.org>; Wed, 20 Jan 2021 11:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=7fY1YnH7ikXqfCJe0iJqTLLPitg8xUDuDcSMfe8CDtA=;
        b=TlPSYT0eseVURoiykW+wV1g+gps/yurpLaogN73c0dKwdGdVUfs1tet0AiQpxCwrTs
         At5Ul5ALgPQb43aD/qgzPXNB/AIEOZ796bCUrcoiLgNpaMeaMY+G43m3oiiJtnuz7bKP
         4nySnyYx1urLmL+g/DU4y6qGdpOCoLKVmelGMQn4y1n2ih00FwJsh8C3Uo4cH+4aDxwt
         s6ZFc2rUGug4DVlPzKqpuQNTxYpwftOH4px8JktdSvuID957wGoVM+oflLBGQocvcIom
         utFTZ1irHb+LVHKBwR68wJAxbHMIpQBKZM0eTBLImosqKQ5VkYtrqB/USXW8IS8i6Qk0
         pG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=7fY1YnH7ikXqfCJe0iJqTLLPitg8xUDuDcSMfe8CDtA=;
        b=lpcfqQxsfbgpJ6GJwqQaI+dEwiwfEeCffhO1ttpobLoTrQ6HagkDUOLl+O0qMSU313
         2BzzNnyedPG6bf/xmsrHQ7uW4MfCBIqrMrPd0JmkGRrmx/I3K0zNN0yf9xKbW3vredgI
         uC6XOAfBemvjI+YlrltOC3Q9tDEAOv/8AgjARKobaxEr/6Jyzth359SRGP+Sja/5Eeu0
         KgWkF9LK+Xsjh8zxRe0E1Vaj98LJaROLBtKeUNSxzk04SbSgMk0aINr0yoYxMfnbq4F+
         yVl7qKHl3J8llSgu2VJ886Fnv/fR8NeEejwYj4xY7Rkj/N2DFB8tm/wlK9LoSrFtBwHJ
         re+Q==
X-Gm-Message-State: AOAM530rI4SfMmT0K5Vq0FuHDYBUJlJwZbGS4eEN0MV0FSHyTnZwVHvQ
        tUSwBTHem9AD9boVPJdm39V1ipVqh/HxwlkVNyG63TH+7UM=
X-Google-Smtp-Source: ABdhPJzhdUBjaTobCYEHeYMg/LNSN4A/iHCIq43TFMDNRpUEv7qFcSw3G1DAFiiK2ZE4XknpD/SuICkYyohPN3ps6hI=
X-Received: by 2002:adf:c5d3:: with SMTP id v19mr10743419wrg.365.1611172618326;
 Wed, 20 Jan 2021 11:56:58 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Date:   Wed, 20 Jan 2021 20:56:46 +0100
Message-ID: <CA+GA0_sPC3rp5K4qwZm-u+W1C=+2Y2p-dbF4DMdHkKaTpeKKkg@mail.gmail.com>
Subject: Crash in acpi_ns_validate_handle triggered by soundwire on Linux 5.10
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hey,

Linux 5.10 fails to boot on my IceLake laptop, where 5.9 worked fine.
I'm not sure whether it's a bug in ACPI or Soundwire subsystem, so I'm
sending this to both
lists. The W taint flag is because of an unrelated nouveau failure (It
was busted on 5.9, and is
still on 5.10). Full kernel log down below.
It's from a distro kernel, but I can build my own kernel with patches if needed.

snd_hda_intel 0000:00:1f.3: DSP detected with PCI
class/subclass/prog-if info 0x040380
BUG: kernel NULL pointer dereference, address: 0000000000000050
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] SMP NOPTI
CPU: 6 PID: 472 Comm: systemd-udevd Tainted: G        W
5.10.0-1-amd64 #1 Debian 5.10.4-1
Hardware name: HP HP Pavilion Laptop 15-cs3xxx/86E2, BIOS F.05 01/01/2020
RIP: 0010:acpi_ns_validate_handle+0x1a/0x23
Code: 00 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f c3 0f 1f 44 00 00
48 8d 57 ff 48 89 f8 48 83 fa fd 76 08 48 8b 05 0c b8 67 01 c3 <80> 7f
08 0f 74 02 31 c0 c3 0f 1f 44 00 00 48 8b 3d f6 b7 67 01 e8
RSP: 0000:ffffc388807c7b20 EFLAGS: 00010213
RAX: 0000000000000048 RBX: ffffc388807c7b70 RCX: 0000000000000000
RDX: 0000000000000047 RSI: 0000000000000246 RDI: 0000000000000048
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffc0f5f4d1 R11: ffffffff8f0cb268 R12: 0000000000001001
R13: ffffffff8e33b160 R14: 0000000000000048 R15: 0000000000000000
FS:  00007f24548288c0(0000) GS:ffff9f781fb80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000050 CR3: 0000000106158004 CR4: 0000000000770ee0
PKRU: 55555554
Call Trace:
 acpi_get_data_full+0x4d/0x92
 acpi_bus_get_device+0x1f/0x40
 sdw_intel_acpi_scan+0x59/0x230 [soundwire_intel]
 ? strstr+0x22/0x60
 ? dmi_matches+0x76/0xe0
 snd_intel_dsp_driver_probe.cold+0xaf/0x163 [snd_intel_dspcfg]
 azx_probe+0x7a/0x970 [snd_hda_intel]
 local_pci_probe+0x42/0x80
 ? _cond_resched+0x16/0x40
 pci_device_probe+0xfd/0x1b0
 really_probe+0x205/0x460
 driver_probe_device+0xe1/0x150
 device_driver_attach+0xa1/0xb0
 __driver_attach+0x8a/0x150
 ? device_driver_attach+0xb0/0xb0
 ? device_driver_attach+0xb0/0xb0
 bus_for_each_dev+0x78/0xc0
 bus_add_driver+0x12b/0x1e0
 driver_register+0x8b/0xe0
 ? 0xffffffffc0f65000
 do_one_initcall+0x44/0x1d0
 ? do_init_module+0x23/0x250
 ? kmem_cache_alloc_trace+0xf5/0x200
 do_init_module+0x5c/0x250
 __do_sys_finit_module+0xb1/0x110
 do_syscall_64+0x33/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f2454ce19b9
Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d a7 54 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007fff0b66be58 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 0000557d20c7a8b0 RCX: 00007f2454ce19b9
RDX: 0000000000000000 RSI: 00007f2454e6ce2d RDI: 000000000000001c
RBP: 0000000000020000 R08: 0000000000000000 R09: 0000557d20c80d50
R10: 000000000000001c R11: 0000000000000246 R12: 00007f2454e6ce2d
R13: 0000000000000000 R14: 0000557d20ae9c00 R15: 0000557d20c7a8b0
Modules linked in: snd_hda_intel(+) snd_intel_dspcfg soundwire_intel
soundwire_generic_allocation kvm snd_soc_core snd_compress
pcc_cpufreq(-) irqbypass soundwire_cadence acpi_cpufreq(-) rapl
snd_hda_codec jitterentropy_rng uvcvideo intel_cstate cfg80211
snd_hda_core videobuf2_vmalloc videobuf2_memops videobuf2_v4l2
snd_hwdep videobuf2_common soundwire_bus intel_uncore videodev snd_pcm
drbg snd_timer iTCO_wdt snd ansi_cprng joydev binfmt_misc hp_wmi(+)
intel_pmc_bxt sparse_keymap mc pcspkr ecdh_generic serio_raw wmi_bmof
intel_wmi_thunderbolt iTCO_vendor_support ecc soundcore watchdog
rfkill libarc4 processor_thermal_device mei_me intel_rapl_common mei
intel_soc_dts_iosf int3403_thermal int340x_thermal_zone hp_accel
lis3lv02d hp_wireless int3400_thermal evdev acpi_thermal_rel
intel_pmc_core acpi_pad ac acpi_tad parport_pc ppdev lp parport fuse
configfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2
crc32c_generic dm_crypt dm_mod nouveau i915 crc32_pclmul crc32c_intel
 ghash_clmulni_intel nvme aesni_intel libaes crypto_simd mxm_wmi ttm
ahci nvme_core xhci_pci i2c_algo_bit libahci xhci_hcd drm_kms_helper
t10_pi crc_t10dif libata psmouse cryptd glue_helper cec usbcore r8169
drm crct10dif_generic scsi_mod realtek mdio_devres i2c_i801 libphy
i2c_smbus crct10dif_pclmul intel_lpss_pci crct10dif_common intel_lpss
usb_common idma64 battery video wmi button
CR2: 0000000000000050
---[ end trace cf1844e25a37ee58 ]---
RIP: 0010:acpi_ns_validate_handle+0x1a/0x23
Code: 00 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f c3 0f 1f 44 00 00
48 8d 57 ff 48 89 f8 48 83 fa fd 76 08 48 8b 05 0c b8 67 01 c3 <80> 7f
08 0f 74 02 31 c0 c3 0f 1f 44 00 00 48 8b 3d f6 b7 67 01 e8
RSP: 0000:ffffc388807c7b20 EFLAGS: 00010213
RAX: 0000000000000048 RBX: ffffc388807c7b70 RCX: 0000000000000000
RDX: 0000000000000047 RSI: 0000000000000246 RDI: 0000000000000048
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffc0f5f4d1 R11: ffffffff8f0cb268 R12: 0000000000001001
R13: ffffffff8e33b160 R14: 0000000000000048 R15: 0000000000000000
FS:  00007f24548288c0(0000) GS:ffff9f781fb80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000050 CR3: 0000000106158004 CR4: 0000000000770ee0
PKRU: 55555554


Full kernel log:
-----
microcode: microcode updated early to revision 0xa0, date = 2020-07-30
Linux version 5.10.0-1-amd64 (debian-kernel@lists.debian.org) (gcc-10
(Debian 10.2.1-3) 10.2.1 20201224, GNU ld (GNU Binutils for Debian)
2.35.1) #1 SMP Debian 5.10.4-1 (2020-12-31)
Command line: BOOT_IMAGE=/vmlinuz-5.10.0-1-amd64
root=/dev/mapper/debian--vg-root ro quiet
x86/split lock detection: warning about user-space split_locks
x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
x86/fpu: Enabled xstate features 0x2e7, context size is 2440 bytes,
using 'compacted' format.
BIOS-provided physical RAM map:
BIOS-e820: [mem 0x0000000000000000-0x000000000009f7ff] usable
BIOS-e820: [mem 0x000000000009f800-0x000000000009ffff] reserved
BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
BIOS-e820: [mem 0x0000000000100000-0x0000000023902fff] usable
BIOS-e820: [mem 0x0000000023903000-0x0000000023903fff] ACPI NVS
BIOS-e820: [mem 0x0000000023904000-0x0000000023959fff] usable
BIOS-e820: [mem 0x000000002395a000-0x000000002395afff] reserved
BIOS-e820: [mem 0x000000002395b000-0x0000000032a2efff] usable
BIOS-e820: [mem 0x0000000032a2f000-0x000000003518efff] reserved
BIOS-e820: [mem 0x000000003518f000-0x0000000035f7efff] ACPI NVS
BIOS-e820: [mem 0x0000000035f7f000-0x0000000035ffefff] ACPI data
BIOS-e820: [mem 0x0000000035fff000-0x0000000035ffffff] usable
BIOS-e820: [mem 0x0000000036000000-0x0000000039ffffff] reserved
BIOS-e820: [mem 0x000000003a200000-0x000000003a3fffff] reserved
BIOS-e820: [mem 0x000000003b000000-0x00000000cfffffff] reserved
BIOS-e820: [mem 0x00000000fc800000-0x00000000fe7fffff] reserved
BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
BIOS-e820: [mem 0x00000000fed10000-0x00000000fed17fff] reserved
BIOS-e820: [mem 0x00000000fed20000-0x00000000fed7ffff] reserved
BIOS-e820: [mem 0x00000000feda0000-0x00000000feda1fff] reserved
BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
BIOS-e820: [mem 0x00000000ff400000-0x00000000ffffffff] reserved
BIOS-e820: [mem 0x0000000100000000-0x00000008bfbfffff] usable
NX (Execute Disable) protection: active
SMBIOS 3.2 present.
DMI: HP HP Pavilion Laptop 15-cs3xxx/86E2, BIOS F.05 01/01/2020
tsc: Detected 1500.000 MHz processor
tsc: Detected 1497.600 MHz TSC
e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
e820: remove [mem 0x000a0000-0x000fffff] usable
last_pfn = 0x8bfc00 max_arch_pfn = 0x400000000
MTRR default type: write-back
MTRR fixed ranges enabled:
  00000-9FFFF write-back
  A0000-BFFFF uncachable
  C0000-FFFFF write-protect
MTRR variable ranges enabled:
  0 base 0080000000 mask 7F80000000 uncachable
  1 base 0040000000 mask 7FC0000000 uncachable
  2 base 003C000000 mask 7FFC000000 uncachable
  3 base 003B000000 mask 7FFF000000 uncachable
  4 base 2000000000 mask 6000000000 uncachable
  5 base 1000000000 mask 7000000000 uncachable
  6 base 4000000000 mask 4000000000 uncachable
  7 disabled
  8 disabled
  9 disabled
x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
last_pfn = 0x36000 max_arch_pfn = 0x400000000
found SMP MP-table at [mem 0x000fe1b0-0x000fe1bf]
Using GB pages for direct mapping
RAMDISK: [mem 0x2d18f000-0x31342fff]
ACPI: Early table checksum verification disabled
ACPI: RSDP 0x00000000000FE020 000024 (v02 HPQOEM)
ACPI: XSDT 0x0000000035FCF188 0000FC (v01 HPQOEM SLIC-MPC 00000002 HP
 01000013)
ACPI: FACP 0x0000000035FD4000 00010C (v05 HPQOEM SLIC-MPC 00000002 HP
 00040000)
ACPI: DSDT 0x0000000035F9C000 032D1B (v02 HPQOEM 86E2     00000002
ACPI 00040000)
ACPI: FACS 0x0000000035F19000 000040
ACPI: UEFI 0x0000000035F7E000 000236 (v01 HPQOEM 86E2     00000001 HP
 00040000)
ACPI: SSDT 0x0000000035FF9000 003DF8 (v02 HPQOEM 86E2     00001000
ACPI 00040000)
ACPI: SSDT 0x0000000035FF7000 001B60 (v02 HPQOEM 86E2     00003000
ACPI 00040000)
ACPI: SSDT 0x0000000035FF3000 003389 (v02 HPQOEM 86E2     00003000
ACPI 00040000)
ACPI: SSDT 0x0000000035FE7000 00B259 (v02 HPQOEM 86E2     00001000
ACPI 00040000)
ACPI: SSDT 0x0000000035FE6000 0001D2 (v01 HPQOEM 86E2     00001000
ACPI 00040000)
ACPI: SSDT 0x0000000035FDE000 007166 (v01 HPQOEM 86E2     00001000
ACPI 00040000)
ACPI: LPIT 0x0000000035FDC000 000094 (v01 HPQOEM 86E2     00000002 HP
 00040000)
ACPI: WSMT 0x0000000035FDB000 000028 (v01 HPQOEM 86E2     00000002 HP
 00040000)
ACPI: SSDT 0x0000000035FDA000 000B70 (v02 HPQOEM 86E2     00001000
ACPI 00040000)
ACPI: DBGP 0x0000000035FD9000 000034 (v01 HPQOEM SLIC-MPC 00000002 HP
 00040000)
ACPI: DBG2 0x0000000035FD8000 000054 (v00 HPQOEM 86E2     00000002 HP
 00040000)
ACPI: SSDT 0x0000000035FD7000 0007EA (v02 HPQOEM 86E2     00001000
ACPI 00040000)
ACPI: NHLT 0x0000000035FD6000 00002D (v00 HPQOEM 86E2     00000002 HP
 00040000)
ACPI: ECDT 0x0000000035FD5000 000069 (v01 HPQOEM 86E2     00000002 HP
 00040000)
ACPI: HPET 0x0000000035FD3000 000038 (v01 HPQOEM 86E2     00000002 HP
 00040000)
ACPI: APIC 0x0000000035FD2000 00012C (v03 HPQOEM 86E2     00000002 HP
 00040000)
ACPI: MCFG 0x0000000035FD1000 00003C (v01 HPQOEM 86E2     00000002 HP
 00040000)
ACPI: SSDT 0x0000000035FFD000 0000F5 (v01 HPQOEM 86E2     00000002
ACPI 00040000)
ACPI: DMAR 0x0000000035F9B000 0000A8 (v02 HPQOEM 86E2     00000002 HP
 00040000)
ACPI: SSDT 0x0000000035F97000 00333E (v01 HPQOEM 86E2     00001000
ACPI 00040000)
ACPI: SSDT 0x0000000035F96000 000987 (v02 HPQOEM 86E2     00001000
ACPI 00040000)
ACPI: SSDT 0x0000000035F95000 000164 (v01 HPQOEM 86E2     00001000
ACPI 00040000)
ACPI: SSDT 0x0000000035F94000 00005C (v02 HPQOEM 86E2     00001000
ACPI 00040000)
ACPI: SSDT 0x0000000035F93000 00005C (v02 HPQOEM 86E2     00001000
ACPI 00040000)
ACPI: FPDT 0x0000000035F92000 000044 (v01 HPQOEM SLIC-MPC 00000002 HP
 00040000)
ACPI: Local APIC address 0xfee00000
No NUMA configuration found
Faking a node at [mem 0x0000000000000000-0x00000008bfbfffff]
NODE_DATA(0) allocated [mem 0x8bfbd6000-0x8bfbfffff]
Zone ranges:
  DMA      [mem 0x0000000000001000-0x0000000000ffffff]
  DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
  Normal   [mem 0x0000000100000000-0x00000008bfbfffff]
  Device   empty
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000001000-0x000000000009efff]
  node   0: [mem 0x0000000000100000-0x0000000023902fff]
  node   0: [mem 0x0000000023904000-0x0000000023959fff]
  node   0: [mem 0x000000002395b000-0x0000000032a2efff]
  node   0: [mem 0x0000000035fff000-0x0000000035ffffff]
  node   0: [mem 0x0000000100000000-0x00000008bfbfffff]
Zeroed struct page in unavailable ranges: 23092 pages
Initmem setup node 0 [mem 0x0000000000001000-0x00000008bfbfffff]
On node 0 totalpages: 8332748
  DMA zone: 64 pages used for memmap
  DMA zone: 21 pages reserved
  DMA zone: 3998 pages, LIFO batch:0
  DMA32 zone: 3177 pages used for memmap
  DMA32 zone: 203310 pages, LIFO batch:63
  Normal zone: 126960 pages used for memmap
  Normal zone: 8125440 pages, LIFO batch:63
x86/hpet: Will disable the HPET for this platform because it's not reliable
Reserving Intel graphics memory at [mem 0x3c800000-0x403fffff]
ACPI: PM-Timer IO Port: 0x1808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0x8086a201 base: 0xfed00000
TSC deadline timer available
smpboot: Allowing 8 CPUs, 0 hotplug CPUs
PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000dffff]
PM: hibernation: Registered nosave memory: [mem 0x000e0000-0x000fffff]
PM: hibernation: Registered nosave memory: [mem 0x23903000-0x23903fff]
PM: hibernation: Registered nosave memory: [mem 0x2395a000-0x2395afff]
PM: hibernation: Registered nosave memory: [mem 0x32a2f000-0x3518efff]
PM: hibernation: Registered nosave memory: [mem 0x3518f000-0x35f7efff]
PM: hibernation: Registered nosave memory: [mem 0x35f7f000-0x35ffefff]
PM: hibernation: Registered nosave memory: [mem 0x36000000-0x39ffffff]
PM: hibernation: Registered nosave memory: [mem 0x3a000000-0x3a1fffff]
PM: hibernation: Registered nosave memory: [mem 0x3a200000-0x3a3fffff]
PM: hibernation: Registered nosave memory: [mem 0x3a400000-0x3affffff]
PM: hibernation: Registered nosave memory: [mem 0x3b000000-0xcfffffff]
PM: hibernation: Registered nosave memory: [mem 0xd0000000-0xfc7fffff]
PM: hibernation: Registered nosave memory: [mem 0xfc800000-0xfe7fffff]
PM: hibernation: Registered nosave memory: [mem 0xfe800000-0xfebfffff]
PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
PM: hibernation: Registered nosave memory: [mem 0xfed00000-0xfed00fff]
PM: hibernation: Registered nosave memory: [mem 0xfed01000-0xfed0ffff]
PM: hibernation: Registered nosave memory: [mem 0xfed10000-0xfed17fff]
PM: hibernation: Registered nosave memory: [mem 0xfed18000-0xfed1ffff]
PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xfed7ffff]
PM: hibernation: Registered nosave memory: [mem 0xfed80000-0xfed9ffff]
PM: hibernation: Registered nosave memory: [mem 0xfeda0000-0xfeda1fff]
PM: hibernation: Registered nosave memory: [mem 0xfeda2000-0xfedfffff]
PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xff3fffff]
PM: hibernation: Registered nosave memory: [mem 0xff400000-0xffffffff]
[mem 0xd0000000-0xfc7fffff] available for PCI devices
Booting paravirtualized kernel on bare hardware
clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 7645519600211568 ns
setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
percpu: Embedded 54 pages/cpu s183960 r8192 d29032 u262144
pcpu-alloc: s183960 r8192 d29032 u262144 alloc=1*2097152
pcpu-alloc: [0] 0 1 2 3 4 5 6 7
Built 1 zonelists, mobility grouping on.  Total pages: 8202526
Policy zone: Normal
Kernel command line: BOOT_IMAGE=/vmlinuz-5.10.0-1-amd64
root=/dev/mapper/debian--vg-root ro quiet
Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
mem auto-init: stack:off, heap alloc:on, heap free:off
Memory: 827144K/33330992K available (12295K kernel code, 2540K rwdata,
4060K rodata, 2380K init, 1692K bss, 735384K reserved, 0K
cma-reserved)
random: get_random_u64 called from __kmem_cache_create+0x2e/0x550 with
crng_init=0
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
ftrace: allocating 35988 entries in 141 pages
ftrace: allocated 141 pages with 4 groups
rcu: Hierarchical RCU implementation.
rcu: RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=8.
Rude variant of Tasks RCU enabled.
Tracing variant of Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
NR_IRQS: 524544, nr_irqs: 2048, preallocated irqs: 16
random: crng done (trusting CPU's manufacturer)
Console: colour VGA+ 80x25
printk: console [tty0] enabled
ACPI: Core revision 20200925
APIC: Switch to symmetric I/O mode setup
DMAR: Host address width 39
DMAR: DRHD base: 0x000000fed90000 flags: 0x0
DMAR: dmar0: reg_base_addr fed90000 ver 4:0 cap 1c0000c40660462 ecap 49e2ff0505e
DMAR: DRHD base: 0x000000fed91000 flags: 0x1
DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
DMAR: RMRR base: 0x00000035041000 end: 0x00000035060fff
DMAR: RMRR base: 0x0000003c000000 end: 0x000000403fffff
DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
DMAR-IR: HPET id 0 under DRHD base 0xfed91000
DMAR-IR: x2apic is disabled because BIOS sets x2apic opt out bit.
DMAR-IR: Use 'intremap=no_x2apic_optout' to override the BIOS setting.
DMAR-IR: Enabled IRQ remapping in xapic mode
x2apic: IRQ remapping doesn't support X2APIC mode
clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:
0x159647815e3, max_idle_ns: 440795269835 ns
Calibrating delay loop (skipped), value calculated using timer
frequency.. 2995.20 BogoMIPS (lpj=5990400)
pid_max: default: 32768 minimum: 301
LSM: Security Framework initializing
Yama: disabled by default; enable with sysctl kernel.yama.*
AppArmor: AppArmor initialized
TOMOYO Linux initialized
Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
x86/cpu: User Mode Instruction Prevention (UMIP) activated
mce: CPU0: Thermal monitoring enabled (TM1)
process: using mwait in idle threads
Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer
sanitization
Spectre V2 : Mitigation: Enhanced IBRS
Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
Speculative Store Bypass: Mitigation: Speculative Store Bypass
disabled via prctl and seccomp
Freeing SMP alternatives memory: 32K
smpboot: CPU0: Intel(R) Core(TM) i7-1065G7 CPU @ 1.30GHz (family: 0x6,
model: 0x7e, stepping: 0x5)
Performance Events: PEBS fmt4+-baseline,  AnyThread deprecated,
Icelake events, 32-deep LBR, full-width counters, Intel PMU driver.
... version:                5
... bit width:              48
... generic registers:      8
... value mask:             0000ffffffffffff
... max period:             00007fffffffffff
... fixed-purpose events:   4
... event mask:             0001000f000000ff
rcu: Hierarchical SRCU implementation.
NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
smp: Bringing up secondary CPUs ...
x86: Booting SMP configuration:
.... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
smp: Brought up 1 node, 8 CPUs
smpboot: Max logical packages: 1
smpboot: Total of 8 processors activated (23961.60 BogoMIPS)
node 0 deferred pages initialised in 32ms
devtmpfs: initialized
x86/mm: Memory block size: 128MB
PM: Registering ACPI NVS region [mem 0x23903000-0x23903fff] (4096 bytes)
PM: Registering ACPI NVS region [mem 0x3518f000-0x35f7efff] (14614528 bytes)
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
max_idle_ns: 7645041785100000 ns
futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
audit: initializing netlink subsys (disabled)
audit: type=2000 audit(1611164511.048:1): state=initialized
audit_enabled=0 res=1
thermal_sys: Registered thermal governor 'fair_share'
thermal_sys: Registered thermal governor 'bang_bang'
thermal_sys: Registered thermal governor 'step_wise'
thermal_sys: Registered thermal governor 'user_space'
cpuidle: using governor ladder
cpuidle: using governor menu
ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
ACPI: bus type PCI registered
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem
0xc0000000-0xcfffffff] (base 0xc0000000)
PCI: MMCONFIG at [mem 0xc0000000-0xcfffffff] reserved in E820
PCI: Using configuration type 1 for base access
ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: Added _OSI(Linux-Dell-Video)
ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
ACPI: 14 ACPI AML tables successfully acquired and loaded
ACPI: EC: EC started
ACPI: EC: interrupt blocked
ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
ACPI: EC: Boot ECDT EC used to handle transactions
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF9F733E5DC000 0000F4 (v02 PmRef  Cpu0Psd  00003000
INTL 20160422)
ACPI: \_SB_.PR00: _OSC native thermal LVT Acked
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF9F733E547C00 000386 (v02 PmRef  Cpu0Cst  00003001
INTL 20160422)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF9F70811CF800 000437 (v02 PmRef  Cpu0Ist  00003000
INTL 20160422)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF9F733E59F200 00012C (v02 PmRef  Cpu0Hwp  00003000
INTL 20160422)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF9F70811CE800 000724 (v02 PmRef  HwpLvt   00003000
INTL 20160422)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF9F70811CE000 0005FC (v02 PmRef  ApIst    00003000
INTL 20160422)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF9F733E543400 000317 (v02 PmRef  ApHwp    00003000
INTL 20160422)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF9F7080140000 000AB0 (v02 PmRef  ApPsd    00003000
INTL 20160422)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF9F733E540800 00030A (v02 PmRef  ApCst    00003000
INTL 20160422)
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
PCI: Using host bridge windows from ACPI; if necessary, use
"pci=nocrs" and report a bug
ACPI: Enabled 10 GPEs in block 00 to 7F
ACPI: Power Resource [PC01] (on)
ACPI: Power Resource [V0PR] (on)
ACPI: Power Resource [V1PR] (on)
ACPI: Power Resource [V2PR] (on)
ACPI: Power Resource [WRST] (on)
acpi ABCD0000:00: ACPI dock station (docks/bays count: 1)
ACPI: Power Resource [TBT0] (on)
ACPI: Power Resource [TBT1] (on)
ACPI BIOS Error (bug): Could not resolve symbol [\_SB.IPPF._STA.POS1],
AE_NOT_FOUND (20200925/psargs-330)
ACPI Error: Aborting method \_SB.IPPF._STA due to previous error
(AE_NOT_FOUND) (20200925/psparse-529)
ACPI: Power Resource [PIN] (off)
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM
Segments MSI HPX-Type3]
acpi PNP0A08:00: _OSC: platform does not support [AER]
acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME
PCIeCapability LTR]
acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: root bus resource [mem 0x40400000-0xbfffffff window]
pci_bus 0000:00: root bus resource [bus 00-fe]
pci 0000:00:00.0: [8086:8a12] type 00 class 0x060000
pci 0000:00:02.0: [8086:8a52] type 00 class 0x030000
pci 0000:00:02.0: reg 0x10: [mem 0x6b000000-0x6bffffff 64bit]
pci 0000:00:02.0: reg 0x18: [mem 0x70000000-0x7fffffff 64bit pref]
pci 0000:00:02.0: reg 0x20: [io  0x8000-0x803f]
pci 0000:00:02.0: DMAR: Skip IOMMU disabling for graphics
pci 0000:00:04.0: [8086:8a03] type 00 class 0x118000
pci 0000:00:04.0: reg 0x10: [mem 0x6c100000-0x6c10ffff 64bit]
pci 0000:00:14.0: [8086:34ed] type 00 class 0x0c0330
pci 0000:00:14.0: reg 0x10: [mem 0x6c110000-0x6c11ffff 64bit]
pci 0000:00:14.0: PME# supported from D3hot D3cold
pci 0000:00:14.2: [8086:34ef] type 00 class 0x050000
pci 0000:00:14.2: reg 0x10: [mem 0x6c124000-0x6c125fff 64bit]
pci 0000:00:14.2: reg 0x18: [mem 0x6c128000-0x6c128fff 64bit]
pci 0000:00:15.0: [8086:34e8] type 00 class 0x0c8000
pci 0000:00:15.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
pci 0000:00:15.1: [8086:34e9] type 00 class 0x0c8000
pci 0000:00:15.1: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
pci 0000:00:16.0: [8086:34e0] type 00 class 0x078000
pci 0000:00:16.0: reg 0x10: [mem 0x6c12b000-0x6c12bfff 64bit]
pci 0000:00:16.0: PME# supported from D3hot
pci 0000:00:17.0: [8086:282a] type 00 class 0x010400
pci 0000:00:17.0: reg 0x10: [mem 0x6c126000-0x6c127fff]
pci 0000:00:17.0: reg 0x14: [mem 0x6c131000-0x6c1310ff]
pci 0000:00:17.0: reg 0x18: [io  0x8080-0x8087]
pci 0000:00:17.0: reg 0x1c: [io  0x8088-0x808b]
pci 0000:00:17.0: reg 0x20: [io  0x8060-0x807f]
pci 0000:00:17.0: reg 0x24: [mem 0x6c130000-0x6c1307ff]
pci 0000:00:17.0: PME# supported from D3hot
pci 0000:00:1c.0: [8086:34b8] type 01 class 0x060400
pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.4: [8086:34bc] type 01 class 0x060400
pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.4: PTM enabled (root), 4ns granularity
pci 0000:00:1d.0: [8086:34b0] type 01 class 0x060400
pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1d.0: PTM enabled (root), 4ns granularity
pci 0000:00:1d.1: [8086:34b1] type 01 class 0x060400
pci 0000:00:1d.1: PME# supported from D0 D3hot D3cold
pci 0000:00:1d.1: PTM enabled (root), 4ns granularity
pci 0000:00:1d.4: [8086:34b4] type 01 class 0x060400
pci 0000:00:1d.4: PME# supported from D0 D3hot D3cold
pci 0000:00:1d.4: PTM enabled (root), 4ns granularity
pci 0000:00:1e.0: [8086:34a8] type 00 class 0x078000
pci 0000:00:1e.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
pci 0000:00:1e.2: [8086:34aa] type 00 class 0x0c8000
pci 0000:00:1e.2: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
pci 0000:00:1f.0: [8086:3482] type 00 class 0x060100
pci 0000:00:1f.3: [8086:34c8] type 00 class 0x040380
pci 0000:00:1f.3: reg 0x10: [mem 0x6c120000-0x6c123fff 64bit]
pci 0000:00:1f.3: reg 0x20: [mem 0x6c000000-0x6c0fffff 64bit]
pci 0000:00:1f.3: PME# supported from D3hot D3cold
pci 0000:00:1f.4: [8086:34a3] type 00 class 0x0c0500
pci 0000:00:1f.4: reg 0x10: [mem 0x6c12e000-0x6c12e0ff 64bit]
pci 0000:00:1f.4: reg 0x20: [io  0x8040-0x805f]
pci 0000:00:1f.5: [8086:34a4] type 00 class 0x0c8000
pci 0000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]
pci 0000:00:1c.0: PCI bridge to [bus 01-05]
pci 0000:00:1c.0:   bridge window [io  0x7000-0x7fff]
pci 0000:00:1c.0:   bridge window [mem 0x6a000000-0x6affffff]
pci 0000:00:1c.0:   bridge window [mem 0x62000000-0x62ffffff 64bit pref]
pci 0000:06:00.0: [10de:1d13] type 00 class 0x030200
pci 0000:06:00.0: reg 0x10: [mem 0x69000000-0x69ffffff]
pci 0000:06:00.0: reg 0x14: [mem 0x50000000-0x5fffffff 64bit pref]
pci 0000:06:00.0: reg 0x1c: [mem 0x60000000-0x61ffffff 64bit pref]
pci 0000:06:00.0: reg 0x24: [io  0x6000-0x607f]
pci 0000:06:00.0: reg 0x30: [mem 0xfff80000-0xffffffff pref]
pci 0000:06:00.0: Enabling HDA controller
pci 0000:00:1c.4: PCI bridge to [bus 06-0a]
pci 0000:00:1c.4:   bridge window [io  0x6000-0x6fff]
pci 0000:00:1c.4:   bridge window [mem 0x69000000-0x69ffffff]
pci 0000:00:1c.4:   bridge window [mem 0x50000000-0x61ffffff 64bit pref]
pci 0000:0b:00.0: [10ec:c822] type 00 class 0x028000
pci 0000:0b:00.0: reg 0x10: [io  0x5000-0x50ff]
pci 0000:0b:00.0: reg 0x18: [mem 0x68000000-0x6800ffff 64bit]
pci 0000:0b:00.0: supports D1 D2
pci 0000:0b:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:1d.0: PCI bridge to [bus 0b-0f]
pci 0000:00:1d.0:   bridge window [io  0x5000-0x5fff]
pci 0000:00:1d.0:   bridge window [mem 0x68000000-0x68ffffff]
pci 0000:00:1d.0:   bridge window [mem 0x63000000-0x63ffffff 64bit pref]
pci 0000:10:00.0: [10ec:8168] type 00 class 0x020000
pci 0000:10:00.0: reg 0x10: [io  0x4000-0x40ff]
pci 0000:10:00.0: reg 0x18: [mem 0x67004000-0x67004fff 64bit]
pci 0000:10:00.0: reg 0x20: [mem 0x67000000-0x67003fff 64bit]
pci 0000:10:00.0: supports D1 D2
pci 0000:10:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:1d.1: PCI bridge to [bus 10-14]
pci 0000:00:1d.1:   bridge window [io  0x4000-0x4fff]
pci 0000:00:1d.1:   bridge window [mem 0x67000000-0x67ffffff]
pci 0000:00:1d.1:   bridge window [mem 0x64000000-0x64ffffff 64bit pref]
pci 0000:15:00.0: [15b7:5003] type 00 class 0x010802
pci 0000:15:00.0: reg 0x10: [mem 0x66000000-0x66003fff 64bit]
pci 0000:00:1d.4: PCI bridge to [bus 15]
pci 0000:00:1d.4:   bridge window [io  0x3000-0x3fff]
pci 0000:00:1d.4:   bridge window [mem 0x66000000-0x66ffffff]
pci 0000:00:1d.4:   bridge window [mem 0x65000000-0x65ffffff 64bit pref]
ACPI BIOS Error (bug): Could not resolve symbol [\_SB.IPPF._STA.POS1],
AE_NOT_FOUND (20200925/psargs-330)
ACPI Error: Aborting method \_SB.IPPF._STA due to previous error
(AE_NOT_FOUND) (20200925/psparse-529)
ACPI: EC: interrupt unblocked
ACPI: EC: event unblocked
ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
ACPI: EC: GPE=0x6e
ACPI: \_SB_.PCI0.LPCB.EC0_: Boot ECDT EC initialization complete
ACPI: \_SB_.PCI0.LPCB.EC0_: EC: Used to handle transactions and events
iommu: Default domain type: Translated
pci 0000:00:02.0: vgaarb: setting as boot VGA device
pci 0000:00:02.0: vgaarb: VGA device added:
decodes=io+mem,owns=io+mem,locks=none
pci 0000:00:02.0: vgaarb: bridge control possible
vgaarb: loaded
EDAC MC: Ver: 3.0.0
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
NetLabel:  unlabeled traffic allowed by default
PCI: Using ACPI for IRQ routing
PCI: pci_cache_line_size set to 64 bytes
pci 0000:00:1f.5: can't claim BAR 0 [mem 0xfe010000-0xfe010fff]: no
compatible bridge window
e820: reserve RAM buffer [mem 0x0009f800-0x0009ffff]
e820: reserve RAM buffer [mem 0x23903000-0x23ffffff]
e820: reserve RAM buffer [mem 0x2395a000-0x23ffffff]
e820: reserve RAM buffer [mem 0x32a2f000-0x33ffffff]
e820: reserve RAM buffer [mem 0x36000000-0x37ffffff]
e820: reserve RAM buffer [mem 0x8bfc00000-0x8bfffffff]
clocksource: Switched to clocksource tsc-early
VFS: Disk quotas dquot_6.6.0
VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
AppArmor: AppArmor Filesystem Enabled
pnp: PnP ACPI init
system 00:00: [io  0x0680-0x069f] has been reserved
system 00:00: [io  0x164e-0x164f] has been reserved
system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
pnp 00:01: Plug and Play ACPI device, IDs HPQ8001 PNP0303 (active)
pnp 00:02: Plug and Play ACPI device, IDs ETD074c SYN1e00 SYN0002
PNP0f13 (active)
system 00:03: [mem 0xfed10000-0xfed17fff] has been reserved
system 00:03: [mem 0xfeda0000-0xfeda0fff] has been reserved
system 00:03: [mem 0xfeda1000-0xfeda1fff] has been reserved
system 00:03: [mem 0xc0000000-0xcfffffff] has been reserved
system 00:03: [mem 0xfed20000-0xfed7ffff] has been reserved
system 00:03: [mem 0xfed90000-0xfed93fff] could not be reserved
system 00:03: [mem 0xfee00000-0xfeefffff] could not be reserved
system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
system 00:04: [io  0x1800-0x18fe] has been reserved
system 00:04: [mem 0xfd000000-0xfd68ffff] has been reserved
system 00:04: [mem 0xfd6b0000-0xfd6cffff] has been reserved
system 00:04: [mem 0xfd6f0000-0xfdffffff] has been reserved
system 00:04: [mem 0xfe000000-0xfe01ffff] has been reserved
system 00:04: [mem 0xfe200000-0xfe7fffff] has been reserved
system 00:04: [mem 0xff000000-0xffffffff] could not be reserved
system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
system 00:05: [io  0x2000-0x20fe] has been reserved
system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
system 00:06: [mem 0xfe038000-0xfe038fff] has been reserved
system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
ACPI BIOS Error (bug): Could not resolve symbol [\_SB.IPPF._STA.POS1],
AE_NOT_FOUND (20200925/psargs-330)
ACPI Error: Aborting method \_SB.IPPF._STA due to previous error
(AE_NOT_FOUND) (20200925/psparse-529)
pnp: PnP ACPI: found 7 devices
clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff,
max_idle_ns: 2085701024 ns
NET: Registered protocol family 2
tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144
bytes, linear)
TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
TCP: Hash tables configured (established 262144 bind 65536)
UDP hash table entries: 16384 (order: 7, 524288 bytes, linear)
UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, linear)
NET: Registered protocol family 1
NET: Registered protocol family 44
pci 0000:06:00.0: can't claim BAR 6 [mem 0xfff80000-0xffffffff pref]:
no compatible bridge window
pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
pci 0000:00:15.0: BAR 0: failed to assign [mem size 0x00001000 64bit]
pci 0000:00:15.1: BAR 0: no space for [mem size 0x00001000 64bit]
pci 0000:00:15.1: BAR 0: failed to assign [mem size 0x00001000 64bit]
pci 0000:00:1e.0: BAR 0: no space for [mem size 0x00001000 64bit]
pci 0000:00:1e.0: BAR 0: failed to assign [mem size 0x00001000 64bit]
pci 0000:00:1e.2: BAR 0: no space for [mem size 0x00001000 64bit]
pci 0000:00:1e.2: BAR 0: failed to assign [mem size 0x00001000 64bit]
pci 0000:00:1f.5: BAR 0: no space for [mem size 0x00001000]
pci 0000:00:1f.5: BAR 0: trying firmware assignment [mem 0xfe010000-0xfe010fff]
pci 0000:00:1f.5: BAR 0: [mem 0xfe010000-0xfe010fff] conflicts with
Reserved [mem 0xfc800000-0xfe7fffff]
pci 0000:00:1f.5: BAR 0: failed to assign [mem size 0x00001000]
pci 0000:00:1c.0: PCI bridge to [bus 01-05]
pci 0000:00:1c.0:   bridge window [io  0x7000-0x7fff]
pci 0000:00:1c.0:   bridge window [mem 0x6a000000-0x6affffff]
pci 0000:00:1c.0:   bridge window [mem 0x62000000-0x62ffffff 64bit pref]
pci 0000:06:00.0: BAR 6: no space for [mem size 0x00080000 pref]
pci 0000:06:00.0: BAR 6: failed to assign [mem size 0x00080000 pref]
pci 0000:00:1c.4: PCI bridge to [bus 06-0a]
pci 0000:00:1c.4:   bridge window [io  0x6000-0x6fff]
pci 0000:00:1c.4:   bridge window [mem 0x69000000-0x69ffffff]
pci 0000:00:1c.4:   bridge window [mem 0x50000000-0x61ffffff 64bit pref]
pci 0000:00:1d.0: PCI bridge to [bus 0b-0f]
pci 0000:00:1d.0:   bridge window [io  0x5000-0x5fff]
pci 0000:00:1d.0:   bridge window [mem 0x68000000-0x68ffffff]
pci 0000:00:1d.0:   bridge window [mem 0x63000000-0x63ffffff 64bit pref]
pci 0000:00:1d.1: PCI bridge to [bus 10-14]
pci 0000:00:1d.1:   bridge window [io  0x4000-0x4fff]
pci 0000:00:1d.1:   bridge window [mem 0x67000000-0x67ffffff]
pci 0000:00:1d.1:   bridge window [mem 0x64000000-0x64ffffff 64bit pref]
pci 0000:00:1d.4: PCI bridge to [bus 15]
pci 0000:00:1d.4:   bridge window [io  0x3000-0x3fff]
pci 0000:00:1d.4:   bridge window [mem 0x66000000-0x66ffffff]
pci 0000:00:1d.4:   bridge window [mem 0x65000000-0x65ffffff 64bit pref]
pci_bus 0000:00: Some PCI device resources are unassigned, try booting
with pci=realloc
pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: resource 7 [mem 0x40400000-0xbfffffff window]
pci_bus 0000:01: resource 0 [io  0x7000-0x7fff]
pci_bus 0000:01: resource 1 [mem 0x6a000000-0x6affffff]
pci_bus 0000:01: resource 2 [mem 0x62000000-0x62ffffff 64bit pref]
pci_bus 0000:06: resource 0 [io  0x6000-0x6fff]
pci_bus 0000:06: resource 1 [mem 0x69000000-0x69ffffff]
pci_bus 0000:06: resource 2 [mem 0x50000000-0x61ffffff 64bit pref]
pci_bus 0000:0b: resource 0 [io  0x5000-0x5fff]
pci_bus 0000:0b: resource 1 [mem 0x68000000-0x68ffffff]
pci_bus 0000:0b: resource 2 [mem 0x63000000-0x63ffffff 64bit pref]
pci_bus 0000:10: resource 0 [io  0x4000-0x4fff]
pci_bus 0000:10: resource 1 [mem 0x67000000-0x67ffffff]
pci_bus 0000:10: resource 2 [mem 0x64000000-0x64ffffff 64bit pref]
pci_bus 0000:15: resource 0 [io  0x3000-0x3fff]
pci_bus 0000:15: resource 1 [mem 0x66000000-0x66ffffff]
pci_bus 0000:15: resource 2 [mem 0x65000000-0x65ffffff 64bit pref]
pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
PCI: CLS 64 bytes, default 64
Trying to unpack rootfs image as initramfs...
Freeing initrd memory: 67280K
DMAR: No ATSR found
DMAR: dmar0: Using Queued invalidation
DMAR: dmar1: Using Queued invalidation
pci 0000:00:00.0: Adding to iommu group 0
pci 0000:00:02.0: Adding to iommu group 1
pci 0000:00:04.0: Adding to iommu group 2
pci 0000:00:14.0: Adding to iommu group 3
pci 0000:00:14.2: Adding to iommu group 3
pci 0000:00:15.0: Adding to iommu group 4
pci 0000:00:15.1: Adding to iommu group 4
pci 0000:00:16.0: Adding to iommu group 5
pci 0000:00:17.0: Adding to iommu group 6
pci 0000:00:1c.0: Adding to iommu group 7
pci 0000:00:1c.4: Adding to iommu group 8
pci 0000:00:1d.0: Adding to iommu group 9
pci 0000:00:1d.1: Adding to iommu group 10
pci 0000:00:1d.4: Adding to iommu group 11
pci 0000:00:1e.0: Adding to iommu group 12
pci 0000:00:1e.2: Adding to iommu group 12
pci 0000:00:1f.0: Adding to iommu group 13
pci 0000:00:1f.3: Adding to iommu group 13
pci 0000:00:1f.4: Adding to iommu group 13
pci 0000:00:1f.5: Adding to iommu group 13
pci 0000:06:00.0: Adding to iommu group 14
pci 0000:0b:00.0: Adding to iommu group 15
pci 0000:10:00.0: Adding to iommu group 16
pci 0000:15:00.0: Adding to iommu group 17
DMAR: Intel(R) Virtualization Technology for Directed I/O
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
software IO TLB: mapped [mem 0x000000002918f000-0x000000002d18f000] (64MB)
clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x159647815e3,
max_idle_ns: 440795269835 ns
clocksource: Switched to clocksource tsc
platform rtc_cmos: registered platform RTC device (no PNP device found)
Initialise system trusted keyrings
Key type blacklist registered
workingset: timestamp_bits=36 max_order=23 bucket_order=0
zbud: loaded
integrity: Platform Keyring initialized
Key type asymmetric registered
Asymmetric key parser 'x509' registered
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
io scheduler mq-deadline registered
pcieport 0000:00:1c.0: PME: Signaling with IRQ 122
pcieport 0000:00:1c.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd-
PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
pcieport 0000:00:1c.4: PME: Signaling with IRQ 123
pcieport 0000:00:1d.0: PME: Signaling with IRQ 124
pcieport 0000:00:1d.1: PME: Signaling with IRQ 125
pcieport 0000:00:1d.4: PME: Signaling with IRQ 126
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
intel_idle: MWAIT substates: 0x11121020
Monitor-Mwait will be used to enter C-1 state
Monitor-Mwait will be used to enter C-2 state
Monitor-Mwait will be used to enter C-3 state
ACPI: \_SB_.PR00: Found 3 idle states
intel_idle: v0.5.1 model 0x7E
intel_idle: Local APIC timer is reliable in all C-states
[Firmware Bug]: Invalid critical threshold (0)
thermal LNXTHERM:00: registered as thermal_zone0
ACPI: Thermal Zone [TZ01] (58 C)
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
hpet_acpi_add: no address or irqs in _CRS
Linux agpgart interface v0.103
AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
AMD-Vi: AMD IOMMUv2 functionality not available on this system
i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mousedev: PS/2 mouse device common for all mice
rtc_cmos rtc_cmos: RTC can wake from S4
rtc_cmos rtc_cmos: registered as rtc0
rtc_cmos rtc_cmos: setting system clock to 2021-01-20T17:41:52 UTC (1611164512)
rtc_cmos rtc_cmos: alarms up to one month, y3k, 114 bytes nvram
intel_pstate: Intel P-state driver initializing
intel_pstate: HWP enabled
ledtrig-cpu: registered to indicate activity on CPUs
NET: Registered protocol family 10
Segment Routing with IPv6
mip6: Mobile IPv6
NET: Registered protocol family 17
mpls_gso: MPLS GSO support
microcode: sig=0x706e5, pf=0x80, revision=0xa0
microcode: Microcode Update Driver: v2.2.
IPI shorthand broadcast: enabled
sched_clock: Marking stable (1117818972, 8996860)->(1171767835, -44952003)
registered taskstats version 1
Loading compiled-in X.509 certificates
Loaded X.509 cert 'Debian Secure Boot CA:
6ccece7e4c6c0d1f6149f3dd27dfcc5cbb419ea1'
Loaded X.509 cert 'Debian Secure Boot Signer 2020: 00b55eb3b9'
zswap: loaded using pool lzo/zbud
Key type ._fscrypt registered
Key type .fscrypt registered
Key type fscrypt-provisioning registered
AppArmor: AppArmor sha1 policy hashing enabled
Freeing unused kernel image (initmem) memory: 2380K
input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input0
Write protecting the kernel read-only data: 18432k
Freeing unused kernel image (text/rodata gap) memory: 2040K
Freeing unused kernel image (rodata/data gap) memory: 36K
x86/mm: Checked W+X mappings: passed, no W+X pages found.
Run /init as init process
  with arguments:
    /init
  with environment:
    HOME=/
    TERM=linux
    BOOT_IMAGE=/vmlinuz-5.10.0-1-amd64
input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input2
ACPI: Lid Switch [LID0]
input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input3
ACPI: Power Button [PWRB]
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input4
wmi_bus wmi_bus-PNP0C14:01: WQ data block query control method not found
wmi_bus wmi_bus-PNP0C14:01: WQ data block query control method not found
wmi_bus wmi_bus-PNP0C14:01: WQ data block query control method not found
wmi_bus wmi_bus-PNP0C14:01: WQ data block query control method not found
acpi PNP0C14:04: duplicate WMI GUID
05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on
PNP0C14:03)
acpi PNP0C14:05: duplicate WMI GUID
05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on
PNP0C14:03)
wmi_bus wmi_bus-PNP0C14:05: WQBJ data block query control method not found
wmi_bus wmi_bus-PNP0C14:05: WQBK data block query control method not found
i801_smbus 0000:00:1f.4: SPD Write Disable is set
i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
i2c i2c-0: 2/2 memory slots populated (from DMI)
i2c i2c-0: Successfully instantiated SPD at 0x50
SCSI subsystem initialized
r8169 0000:10:00.0: can't disable ASPM; OS doesn't have ASPM control
ACPI: bus type USB registered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
libata version 3.00 loaded.
ACPI: Power Button [PWRF]
xhci_hcd 0000:00:14.0: xHCI Host Controller
xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
ahci 0000:00:17.0: version 3.0
xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci version 0x110 quirks
0x0000000000009810
xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
ahci 0000:00:17.0: AHCI 0001.0301 32 slots 2 ports 6 Gbps 0x1 impl RAID mode
ahci 0000:00:17.0: flags: 64bit ncq sntf pm clo only pio slum part
deso sadm sds apst
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.10
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: xHCI Host Controller
usb usb1: Manufacturer: Linux 5.10.0-1-amd64 xhci-hcd
usb usb1: SerialNumber: 0000:00:14.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 12 ports detected
xhci_hcd 0000:00:14.0: xHCI Host Controller
xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperSpeed
usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.10
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: xHCI Host Controller
usb usb2: Manufacturer: Linux 5.10.0-1-amd64 xhci-hcd
usb usb2: SerialNumber: 0000:00:14.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 6 ports detected
cryptd: max_cpu_qlen set to 1000
scsi host0: ahci
AVX2 version of gcm_enc/dec engaged.
AES CTR mode by8 optimization enabled
nvme nvme0: pci function 0000:15:00.0
scsi host1: ahci
ata1: SATA max UDMA/133 abar m2048@0x6c130000 port 0x6c130100 irq 128
ata2: DUMMY
libphy: r8169: probed
r8169 0000:10:00.0 eth0: RTL8168h/8111h, 38:22:e2:1c:ff:ff, XID 541, IRQ 129
r8169 0000:10:00.0 eth0: jumbo features [frames: 9194 bytes, tx
checksumming: ko]
r8169 0000:10:00.0 eno1: renamed from eth0
nvme nvme0: 8/0/0 default/read/poll queues
 nvme0n1: p1 p2 < p5 >
battery: ACPI: Battery Slot [BAT0] (battery present)
i915 0000:00:02.0: [drm] VT-d active for gfx access
i915 0000:00:02.0: vgaarb: deactivate vga console
Console: switching to colour dummy device 80x25
ACPI Warning: \_SB.PCI0.GFX0._DSM: Argument #4 type mismatch - Found
[Buffer], ACPI requires [Package] (20200925/nsarguments-61)
ACPI Warning: \_SB.PCI0.RP05.PXSX._DSM: Argument #4 type mismatch -
Found [Buffer], ACPI requires [Package] (20200925/nsarguments-61)
pci 0000:06:00.0: optimus capabilities: enabled, status dynamic power,
VGA switcheroo: detected Optimus DSM method \_SB_.PCI0.RP05.PXSX handle
nouveau: detected PR support, will not use DSM
nouveau 0000:06:00.0: enabling device (0006 -> 0007)
i915 0000:00:02.0: vgaarb: changed VGA decodes:
olddecodes=io+mem,decodes=io+mem:owns=io+mem
nouveau 0000:06:00.0: NVIDIA GP108 (138000a1)
i915 0000:00:02.0: firmware: direct-loading firmware i915/icl_dmc_ver1_09.bin
i915 0000:00:02.0: [drm] Finished loading DMC firmware
i915/icl_dmc_ver1_09.bin (v1.9)
nouveau 0000:06:00.0: bios: version 86.08.40.00.2e
nouveau 0000:06:00.0: firmware: direct-loading firmware
nvidia/gp108/nvdec/scrubber.bin
nouveau 0000:06:00.0: firmware: direct-loading firmware nvidia/gp108/acr/bl.bin
nouveau 0000:06:00.0: firmware: direct-loading firmware
nvidia/gp108/acr/ucode_load.bin
nouveau 0000:06:00.0: firmware: direct-loading firmware
nvidia/gp108/acr/unload_bl.bin
nouveau 0000:06:00.0: firmware: direct-loading firmware
nvidia/gp108/acr/ucode_unload.bin
nouveau 0000:06:00.0: pmu: firmware unavailable
nouveau 0000:06:00.0: firmware: direct-loading firmware
nvidia/gp108/gr/fecs_bl.bin
nouveau 0000:06:00.0: firmware: direct-loading firmware
nvidia/gp108/gr/fecs_inst.bin
nouveau 0000:06:00.0: firmware: direct-loading firmware
nvidia/gp108/gr/fecs_data.bin
nouveau 0000:06:00.0: firmware: direct-loading firmware
nvidia/gp108/gr/fecs_sig.bin
nouveau 0000:06:00.0: firmware: direct-loading firmware
nvidia/gp108/gr/gpccs_bl.bin
nouveau 0000:06:00.0: firmware: direct-loading firmware
nvidia/gp108/gr/gpccs_inst.bin
nouveau 0000:06:00.0: firmware: direct-loading firmware
nvidia/gp108/gr/gpccs_data.bin
nouveau 0000:06:00.0: firmware: direct-loading firmware
nvidia/gp108/gr/gpccs_sig.bin
nouveau 0000:06:00.0: firmware: direct-loading firmware
nvidia/gp108/gr/sw_nonctx.bin
nouveau 0000:06:00.0: firmware: direct-loading firmware
nvidia/gp108/gr/sw_ctx.bin
nouveau 0000:06:00.0: firmware: direct-loading firmware
nvidia/gp108/gr/sw_bundle_init.bin
nouveau 0000:06:00.0: firmware: direct-loading firmware
nvidia/gp108/gr/sw_method_init.bin
nouveau 0000:06:00.0: firmware: direct-loading firmware
nvidia/gp108/sec2/sig.bin
nouveau 0000:06:00.0: firmware: direct-loading firmware
nvidia/gp108/sec2/image.bin
nouveau 0000:06:00.0: firmware: direct-loading firmware
nvidia/gp108/sec2/desc.bin
nouveau 0000:06:00.0: fb: 2048 MiB GDDR5
ata1: SATA link down (SStatus 4 SControl 300)
usb 1-3: new high-speed USB device number 2 using xhci_hcd
psmouse serio1: elantech: assuming hardware version 4 (with firmware
version 0x4d5f02)
psmouse serio1: elantech: Synaptics capabilities query result 0x10, 0x1a, 0x0d.
usb 1-3: New USB device found, idVendor=04ca, idProduct=707f, bcdDevice= 0.03
usb 1-3: New USB device strings: Mfr=3, Product=1, SerialNumber=2
usb 1-3: Product: HP Wide Vision HD Camera
usb 1-3: Manufacturer: DHKQA019ID97Y5
usb 1-3: SerialNumber: 200901010001
psmouse serio1: elantech: Elan sample query result 04, 4d, 86
input: ETPS/2 Elantech Touchpad as /devices/platform/i8042/serio1/input/input5
usb 1-10: new full-speed USB device number 3 using xhci_hcd
usb 1-10: New USB device found, idVendor=0bda, idProduct=b00c, bcdDevice= 0.00
usb 1-10: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-10: Product: Bluetooth Radio
usb 1-10: Manufacturer: Realtek
usb 1-10: SerialNumber: 00e04c000001
------------[ cut here ]------------
nouveau 0000:06:00.0: timeout
WARNING: CPU: 5 PID: 169 at
drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c:107
nvkm_pmu_reset+0x148/0x160 [nouveau]
Modules linked in: nouveau(+) i915(+) crc32_pclmul crc32c_intel
ghash_clmulni_intel nvme aesni_intel libaes crypto_simd mxm_wmi ttm
ahci nvme_core xhci_pci i2c_algo_bit libahci xhci_hcd drm_kms_helper
t10_pi crc_t10dif libata psmouse cryptd glue_helper cec usbcore r8169
drm crct10dif_generic scsi_mod realtek mdio_devres i2c_i801 libphy
i2c_smbus crct10dif_pclmul intel_lpss_pci crct10dif_common intel_lpss
usb_common idma64 battery video wmi button
CPU: 5 PID: 169 Comm: systemd-udevd Not tainted 5.10.0-1-amd64 #1
Debian 5.10.4-1
Hardware name: HP HP Pavilion Laptop 15-cs3xxx/86E2, BIOS F.05 01/01/2020
RIP: 0010:nvkm_pmu_reset+0x148/0x160 [nouveau]
Code: 04 24 48 8b 40 10 48 8b 78 10 4c 8b 67 50 4d 85 e4 74 1e e8 9a
de 78 cd 4c 89 e2 48 c7 c7 a1 d1 d8 c0 48 89 c6 e8 38 6a 9e cd <0f> 0b
e9 50 ff ff ff 4c 8b 27 eb dd 4c 8b 27 eb a5 e8 52 dd a1 cd
RSP: 0018:ffffc388804278e0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff9f70b993e800 RCX: ffffffff8f0b3228
RDX: c0000000ffffefff RSI: 00000000ffffefff RDI: 0000000000000247
RBP: ffff9f70a20cee00 R08: 0000000000000000 R09: ffffc38880427700
R10: ffffc388804276f8 R11: ffffffff8f0cb268 R12: ffff9f708129cb50
R13: 0000000058779b71 R14: 0000000053aa5380 R15: ffff9f70b9961e00
FS:  00007f6b768b38c0(0000) GS:ffff9f781fb40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb13a7ba6f4 CR3: 00000003be160004 CR4: 0000000000770ee0
PKRU: 55555554
Call Trace:
 nvkm_pmu_init+0x16/0x40 [nouveau]
 nvkm_subdev_init+0x92/0xd0 [nouveau]
 ? ktime_get+0x38/0xa0
 nvkm_device_init+0x10b/0x190 [nouveau]
 nvkm_udevice_init+0x41/0x60 [nouveau]
 nvkm_object_init+0x3e/0x100 [nouveau]
 nvkm_ioctl_new+0x169/0x200 [nouveau]
 ? nvkm_client_notify+0x30/0x30 [nouveau]
 ? nvkm_udevice_rd08+0x20/0x20 [nouveau]
 nvkm_ioctl+0xde/0x180 [nouveau]
 nvif_object_ctor+0x11e/0x1c0 [nouveau]
 nvif_device_ctor+0x1f/0x60 [nouveau]
 nouveau_cli_init+0x197/0x450 [nouveau]
 ? kmem_cache_alloc_trace+0xf5/0x200
 nouveau_drm_device_init+0x74/0x760 [nouveau]
 ? pci_bus_read_config_word+0x49/0x70
 nouveau_drm_probe+0x12f/0x1f0 [nouveau]
 local_pci_probe+0x42/0x80
 ? _cond_resched+0x16/0x40
 pci_device_probe+0xfd/0x1b0
 really_probe+0x205/0x460
 driver_probe_device+0xe1/0x150
 device_driver_attach+0xa1/0xb0
 __driver_attach+0x8a/0x150
 ? device_driver_attach+0xb0/0xb0
 ? device_driver_attach+0xb0/0xb0
 bus_for_each_dev+0x78/0xc0
 bus_add_driver+0x12b/0x1e0
 driver_register+0x8b/0xe0
 ? 0xffffffffc0769000
 do_one_initcall+0x44/0x1d0
 ? do_init_module+0x23/0x250
 ? kmem_cache_alloc_trace+0xf5/0x200
 do_init_module+0x5c/0x250
 __do_sys_finit_module+0xb1/0x110
 do_syscall_64+0x33/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f6b76d6c9b9
Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d a7 54 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007ffdee6f4268 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 000055dfe3ed3ef0 RCX: 00007f6b76d6c9b9
RDX: 0000000000000000 RSI: 00007f6b76ef7e2d RDI: 000000000000000f
RBP: 0000000000020000 R08: 0000000000000000 R09: 000055dfe3ed41a0
R10: 000000000000000f R11: 0000000000000246 R12: 00007f6b76ef7e2d
R13: 0000000000000000 R14: 000055dfe3eb9340 R15: 000055dfe3ed3ef0
---[ end trace cf1844e25a37ee57 ]---
[drm] Initialized i915 1.6.0 20200917 for 0000:00:02.0 on minor 0
[TTM] Zone  kernel: Available graphics memory: 16333688 KiB
[TTM] Zone   dma32: Available graphics memory: 2097152 KiB
[TTM] Initializing pool allocator
[TTM] Initializing DMA pool allocator
nouveau 0000:06:00.0: DRM: VRAM: 2048 MiB
nouveau 0000:06:00.0: DRM: GART: 536870912 MiB
nouveau 0000:06:00.0: DRM: BIT table 'A' not found
nouveau 0000:06:00.0: DRM: BIT table 'L' not found
nouveau 0000:06:00.0: DRM: Pointer to TMDS table not found
nouveau 0000:06:00.0: DRM: DCB version 4.1
nouveau 0000:06:00.0: DRM: MM: using COPY for buffer copies
[drm] Initialized nouveau 1.3.1 20120801 for 0000:06:00.0 on minor 1
ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input6
[Firmware Bug]: ACPI(PXSX) defines _DOD but not _DOS
ACPI: Video Device [PXSX] (multi-head: yes  rom: yes  post: no)
input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:44/LNXVIDEO:01/input/input7
vga_switcheroo: enabled
fbcon: i915drmfb (fb0) is primary device
Console: switching to colour frame buffer device 240x67
i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
device-mapper: uevent: version 1.0.3
device-mapper: ioctl: 4.43.0-ioctl (2020-10-01) initialised: dm-devel@redhat.com
PM: Image not found (code -22)
EXT4-fs (dm-1): mounted filesystem with ordered data mode. Opts: (null)
Not activating Mandatory Access Control as /sbin/tomoyo-init does not exist.
EXT4-fs (dm-1): re-mounted. Opts: errors=remount-ro
fuse: init (API version 7.32)
lp: driver loaded but no devices found
ppdev: user-space parallel port driver
intel_pmc_core INT33A1:00:  initialized
ACPI: AC Adapter [ADP1] (on-line)
input: HP Wireless hotkeys as /devices/virtual/input/input8
hp_accel: laptop model unknown, using default axes configuration
lis3lv02d: 8 bits 3DC sensor found
mei_me 0000:00:16.0: enabling device (0000 -> 0002)
input: ST LIS3LV02DL Accelerometer as /devices/platform/lis3lv02d/input/input9
intel_rapl_common: Found RAPL domain package
proc_thermal 0000:00:04.0: Creating sysfs group for PROC_THERMAL_PCI
EXT4-fs (nvme0n1p1): mounting ext2 file system using the ext4 subsystem
EXT4-fs (nvme0n1p1): mounted filesystem without journal. Opts: (null)
ext2 filesystem being mounted at /boot supports timestamps until 2038
(0x7fffffff)
iTCO_vendor_support: vendor-support=0
input: PC Speaker as /devices/platform/pcspkr/input/input10
mc: Linux media interface: v0.10
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
iTCO_wdt: Found a Intel PCH TCO device (Version=6, TCOBASE=0x0400)
iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
alg: No test for fips(ansi_cprng) (fips_ansi_cprng)
videodev: Linux video capture interface: v2.00
audit: type=1400 audit(1611164581.415:2): apparmor="STATUS"
operation="profile_load" profile="unconfined" name="/usr/sbin/haveged"
pid=563 comm="apparmor_parser"
audit: type=1400 audit(1611164581.415:3): apparmor="STATUS"
operation="profile_load" profile="unconfined" name="nvidia_modprobe"
pid=569 comm="apparmor_parser"
audit: type=1400 audit(1611164581.415:4): apparmor="STATUS"
operation="profile_load" profile="unconfined"
name="nvidia_modprobe//kmod" pid=569 comm="apparmor_parser"
audit: type=1400 audit(1611164581.415:5): apparmor="STATUS"
operation="profile_load" profile="unconfined" name="mysqld_akonadi"
pid=567 comm="apparmor_parser"
audit: type=1400 audit(1611164581.415:6): apparmor="STATUS"
operation="profile_load" profile="unconfined" name="mariadbd_akonadi"
pid=562 comm="apparmor_parser"
audit: type=1400 audit(1611164581.415:7): apparmor="STATUS"
operation="profile_load" profile="unconfined"
name="/usr/sbin/cups-browsed" pid=564 comm="apparmor_parser"
audit: type=1400 audit(1611164581.415:8): apparmor="STATUS"
operation="profile_load" profile="unconfined"
name="/usr/bin/akonadiserver" pid=565 comm="apparmor_parser"
audit: type=1400 audit(1611164581.415:9): apparmor="STATUS"
operation="profile_load" profile="unconfined"
name="postgresql_akonadi" pid=568 comm="apparmor_parser"
audit: type=1400 audit(1611164581.419:10): apparmor="STATUS"
operation="profile_load" profile="unconfined"
name="libreoffice-senddoc" pid=572 comm="apparmor_parser"
audit: type=1400 audit(1611164581.419:11): apparmor="STATUS"
operation="profile_load" profile="unconfined"
name="libreoffice-xpdfimport" pid=578 comm="apparmor_parser"
uvcvideo: Found UVC 1.00 device HP Wide Vision HD Camera (04ca:707f)
input: HP Wide Vision HD Camera: HP Wi as
/devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/input/input12
usbcore: registered new interface driver uvcvideo
USB Video Class driver (1.1.1)
cfg80211: Loading compiled-in X.509 certificates for regulatory database
cfg80211: Loaded X.509 cert 'benh@debian.org:
577e021cb980e0e820821ba7b54b4961b8b4fadf'
cfg80211: Loaded X.509 cert 'romain.perier@gmail.com:
3abbc6ec146e09d1b6016ab9d6cf71dd233f0328'
cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
platform regulatory.0: firmware: direct-loading firmware regulatory.db
platform regulatory.0: firmware: direct-loading firmware regulatory.db.p7s
RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
RAPL PMU: hw unit of domain package 2^-14 Joules
RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
Adding 1003516k swap on /dev/mapper/debian--vg-swap_1.  Priority:-2
extents:1 across:1003516k SSFS
snd_hda_intel 0000:00:1f.3: DSP detected with PCI
class/subclass/prog-if info 0x040380
BUG: kernel NULL pointer dereference, address: 0000000000000050
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] SMP NOPTI
CPU: 6 PID: 472 Comm: systemd-udevd Tainted: G        W
5.10.0-1-amd64 #1 Debian 5.10.4-1
Hardware name: HP HP Pavilion Laptop 15-cs3xxx/86E2, BIOS F.05 01/01/2020
RIP: 0010:acpi_ns_validate_handle+0x1a/0x23
Code: 00 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f c3 0f 1f 44 00 00
48 8d 57 ff 48 89 f8 48 83 fa fd 76 08 48 8b 05 0c b8 67 01 c3 <80> 7f
08 0f 74 02 31 c0 c3 0f 1f 44 00 00 48 8b 3d f6 b7 67 01 e8
RSP: 0000:ffffc388807c7b20 EFLAGS: 00010213
RAX: 0000000000000048 RBX: ffffc388807c7b70 RCX: 0000000000000000
RDX: 0000000000000047 RSI: 0000000000000246 RDI: 0000000000000048
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffc0f5f4d1 R11: ffffffff8f0cb268 R12: 0000000000001001
R13: ffffffff8e33b160 R14: 0000000000000048 R15: 0000000000000000
FS:  00007f24548288c0(0000) GS:ffff9f781fb80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000050 CR3: 0000000106158004 CR4: 0000000000770ee0
PKRU: 55555554
Call Trace:
 acpi_get_data_full+0x4d/0x92
 acpi_bus_get_device+0x1f/0x40
 sdw_intel_acpi_scan+0x59/0x230 [soundwire_intel]
 ? strstr+0x22/0x60
 ? dmi_matches+0x76/0xe0
 snd_intel_dsp_driver_probe.cold+0xaf/0x163 [snd_intel_dspcfg]
 azx_probe+0x7a/0x970 [snd_hda_intel]
 local_pci_probe+0x42/0x80
 ? _cond_resched+0x16/0x40
 pci_device_probe+0xfd/0x1b0
 really_probe+0x205/0x460
 driver_probe_device+0xe1/0x150
 device_driver_attach+0xa1/0xb0
 __driver_attach+0x8a/0x150
 ? device_driver_attach+0xb0/0xb0
 ? device_driver_attach+0xb0/0xb0
 bus_for_each_dev+0x78/0xc0
 bus_add_driver+0x12b/0x1e0
 driver_register+0x8b/0xe0
 ? 0xffffffffc0f65000
 do_one_initcall+0x44/0x1d0
 ? do_init_module+0x23/0x250
 ? kmem_cache_alloc_trace+0xf5/0x200
 do_init_module+0x5c/0x250
 __do_sys_finit_module+0xb1/0x110
 do_syscall_64+0x33/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f2454ce19b9
Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d a7 54 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007fff0b66be58 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 0000557d20c7a8b0 RCX: 00007f2454ce19b9
RDX: 0000000000000000 RSI: 00007f2454e6ce2d RDI: 000000000000001c
RBP: 0000000000020000 R08: 0000000000000000 R09: 0000557d20c80d50
R10: 000000000000001c R11: 0000000000000246 R12: 00007f2454e6ce2d
R13: 0000000000000000 R14: 0000557d20ae9c00 R15: 0000557d20c7a8b0
Modules linked in: snd_hda_intel(+) snd_intel_dspcfg soundwire_intel
soundwire_generic_allocation kvm snd_soc_core snd_compress
pcc_cpufreq(-) irqbypass soundwire_cadence acpi_cpufreq(-) rapl
snd_hda_codec jitterentropy_rng uvcvideo intel_cstate cfg80211
snd_hda_core videobuf2_vmalloc videobuf2_memops videobuf2_v4l2
snd_hwdep videobuf2_common soundwire_bus intel_uncore videodev snd_pcm
drbg snd_timer iTCO_wdt snd ansi_cprng joydev binfmt_misc hp_wmi(+)
intel_pmc_bxt sparse_keymap mc pcspkr ecdh_generic serio_raw wmi_bmof
intel_wmi_thunderbolt iTCO_vendor_support ecc soundcore watchdog
rfkill libarc4 processor_thermal_device mei_me intel_rapl_common mei
intel_soc_dts_iosf int3403_thermal int340x_thermal_zone hp_accel
lis3lv02d hp_wireless int3400_thermal evdev acpi_thermal_rel
intel_pmc_core acpi_pad ac acpi_tad parport_pc ppdev lp parport fuse
configfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2
crc32c_generic dm_crypt dm_mod nouveau i915 crc32_pclmul crc32c_intel
 ghash_clmulni_intel nvme aesni_intel libaes crypto_simd mxm_wmi ttm
ahci nvme_core xhci_pci i2c_algo_bit libahci xhci_hcd drm_kms_helper
t10_pi crc_t10dif libata psmouse cryptd glue_helper cec usbcore r8169
drm crct10dif_generic scsi_mod realtek mdio_devres i2c_i801 libphy
i2c_smbus crct10dif_pclmul intel_lpss_pci crct10dif_common intel_lpss
usb_common idma64 battery video wmi button
CR2: 0000000000000050
---[ end trace cf1844e25a37ee58 ]---
RIP: 0010:acpi_ns_validate_handle+0x1a/0x23
Code: 00 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f c3 0f 1f 44 00 00
48 8d 57 ff 48 89 f8 48 83 fa fd 76 08 48 8b 05 0c b8 67 01 c3 <80> 7f
08 0f 74 02 31 c0 c3 0f 1f 44 00 00 48 8b 3d f6 b7 67 01 e8
RSP: 0000:ffffc388807c7b20 EFLAGS: 00010213
RAX: 0000000000000048 RBX: ffffc388807c7b70 RCX: 0000000000000000
RDX: 0000000000000047 RSI: 0000000000000246 RDI: 0000000000000048
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffc0f5f4d1 R11: ffffffff8f0cb268 R12: 0000000000001001
R13: ffffffff8e33b160 R14: 0000000000000048 R15: 0000000000000000
FS:  00007f24548288c0(0000) GS:ffff9f781fb80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000050 CR3: 0000000106158004 CR4: 0000000000770ee0
PKRU: 55555554
Bluetooth: Core ver 2.22
intel_rapl_common: Found RAPL domain package
intel_rapl_common: Found RAPL domain core
intel_rapl_common: Found RAPL domain uncore
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO socket layer initialized
rtw_8822ce 0000:0b:00.0: firmware: direct-loading firmware
rtw88/rtw8822c_wow_fw.bin
rtw_8822ce 0000:0b:00.0: Firmware version 9.9.4, H2C version 15
rtw_8822ce 0000:0b:00.0: firmware: direct-loading firmware rtw88/rtw8822c_fw.bin
rtw_8822ce 0000:0b:00.0: Firmware version 9.9.4, H2C version 15
r8169 0000:10:00.0: firmware: direct-loading firmware rtl_nic/rtl8168h-2.fw
Generic FE-GE Realtek PHY r8169-1000:00: attached PHY driver [Generic
FE-GE Realtek PHY] (mii_bus:phy_addr=r8169-1000:00, irq=IGNORE)
usbcore: registered new interface driver btusb
Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=000c lmp_ver=0a
lmp_subver=8822
Bluetooth: hci0: RTL: rom_version status=0 version=3
Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cu_fw.bin
bluetooth hci0: firmware: direct-loading firmware rtl_bt/rtl8822cu_fw.bin
Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cu_config.bin
bluetooth hci0: firmware: failed to load rtl_bt/rtl8822cu_config.bin (-2)
firmware_class: See https://wiki.debian.org/Firmware for information
about missing firmware
bluetooth hci0: Direct firmware load for rtl_bt/rtl8822cu_config.bin
failed with error -2
Bluetooth: hci0: RTL: cfg_sz -2, total sz 34332
Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Bluetooth: BNEP filters: protocol multicast
Bluetooth: BNEP socket layer initialized
r8169 0000:10:00.0 eno1: Link is Down
Bluetooth: hci0: RTL: fw version 0x099a281a
sysrq: Keyboard mode set to system default
sysrq: Emergency Sync
Emergency Sync complete
sysrq: Emergency Remount R/O
