Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8081308CF6
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Jan 2021 20:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbhA2TCl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Jan 2021 14:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhA2TAx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Jan 2021 14:00:53 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C926C061573
        for <linux-acpi@vger.kernel.org>; Fri, 29 Jan 2021 11:00:11 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id m13so9877284wro.12
        for <linux-acpi@vger.kernel.org>; Fri, 29 Jan 2021 11:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OY53MZLJW1nal0fyfbPEVTGQ9r9eM2T3IQHvoQTTa+4=;
        b=PPgVdDP0Ui3+pJh3Nj0qzC+xErn6iP58i5ynucRBjcKnDYvOD/ZbYdpgs4SCMxnj0a
         PqsY1CNFJ6zEpyr8ysFsKF53VUWcLd6qUWwq4P9wsV3yNBCqNomVTq+pf8k8OSSRORFe
         3XhYcPx0jzwpyIdWSZ64uD3I07p1c/4qQqBXJzlv+C78P+oh33qR5cjjaEdR8WyzaMnr
         is4GnQHRv8pn9FuKFTvyjGi+BioEGVKGp9ln7bmr6Nus8k5xFp6M803/kMxCX3kdM2gS
         o+RUMz9oYvuezbr2O1HDsQcLqIfebHgXMXF0bTNctTuk1MrppLLNNGPQZRelQ+iGowGK
         1Ulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OY53MZLJW1nal0fyfbPEVTGQ9r9eM2T3IQHvoQTTa+4=;
        b=Fs14IxvGCn7wD4dh/87Zu/KfBiwGzxWsGFcjFJKfCQe6vyC4kZnea0+oXxEUStB3jZ
         7udVjG2mKUBXZR2k0KsYS/Ay9jRw6LJcn7bEG25uAB0ni1PyGdlP9VlnMjDPXwNRzgh9
         5jnRUhaJ5P9UjDVRw/GFYN84P1naVH5dxVhqOfAz8+RZ7igvSI8ZgPoe5LoJioCO0TMt
         cSvAnW8bjYc2x+Gxeqe4BY1HfZvH3Bj+BGFucDBXtLMxtztFW0lgrA4DcuOqJ1udOUH/
         WVX72ti6IGh4ffj1Su6aF004Vi9MVL22JjVM6864UumzkbYS4ziDqLZGzyoZSnRwWhZA
         FtiQ==
X-Gm-Message-State: AOAM530SPD0FyJ6KugVg8sRw+Iyc+a8qvXG3i+mfFwiDoHbmU6wc9UzW
        Xkv8AvqdDxFqrJbRFSFQ/hDQAzdQ4oKTVBn/nT4=
X-Google-Smtp-Source: ABdhPJzwqf44HalldbsYSO3hxibHWsE9m0LycUmwXDN7Al+E6H+CHeXL3/LAGoqDzaKZPdb0eL35+NfQLeDxzqW3cVo=
X-Received: by 2002:a5d:6045:: with SMTP id j5mr6041320wrt.365.1611946810067;
 Fri, 29 Jan 2021 11:00:10 -0800 (PST)
MIME-Version: 1.0
References: <CA+GA0_sPC3rp5K4qwZm-u+W1C=+2Y2p-dbF4DMdHkKaTpeKKkg@mail.gmail.com>
 <CAJZ5v0iapmc8ywuySwexwTagKr89Hj7TPXkAvd_HXMhdLoyyQQ@mail.gmail.com>
 <1f0f7273-597e-cdf0-87d1-908e56c13133@linux.intel.com> <CA+GA0_v3JUWS3G3=R4XuQ=OW91cpwiBP1Rp=uzYOF8c9TUJ46w@mail.gmail.com>
 <CA+GA0_sCdowanpZmg==c+xVqqNxG5whLGsKHaCfSmpERBhqMzA@mail.gmail.com>
 <1dc2639a-ecbc-c554-eaf6-930256dcda96@linux.intel.com> <CA+GA0_sZm2pqOfA3LsNQowb930QS_g5CiCCGthzsS=vAjB9Rjg@mail.gmail.com>
 <CAJZ5v0h+Kwn5u293QO+H2rfGx-ZMBr18tMCLB7jHKHWWRaovOw@mail.gmail.com>
 <CAJZ5v0h8abkdrdN97RHouzxynPBFXBoAuMSb7Zy56+-sTXkPKQ@mail.gmail.com> <CA+GA0_vYdxFj_SPWgdkufo04VaOuWqcNTSck6gvnMfN07ZdO_Q@mail.gmail.com>
In-Reply-To: <CA+GA0_vYdxFj_SPWgdkufo04VaOuWqcNTSck6gvnMfN07ZdO_Q@mail.gmail.com>
From:   =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Date:   Fri, 29 Jan 2021 19:59:52 +0100
Message-ID: <CA+GA0_vKyJZSQZ9bA6_BSDeGfRZ_nz86gj2aVHaOoy1h57CMzA@mail.gmail.com>
Subject: Re: Crash in acpi_ns_validate_handle triggered by soundwire on Linux 5.10
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

czw., 28 sty 2021 o 15:32 Marcin =C5=9Alusarz <marcin.slusarz@gmail.com> na=
pisa=C5=82(a):
>
> czw., 28 sty 2021 o 13:39 Rafael J. Wysocki <rafael@kernel.org> napisa=C5=
=82(a):
> > The only explanation for that I can think about (and which does not
> > involve supernatural intervention so to speak) is a stack corruption
> > occurring between these two calls in sdw_intel_acpi_cb().  IOW,
> > something scribbles on the handle in the meantime, but ATM I have no
> > idea what that can be.
>
> I tried KASAN but it didn't find anything and kernel actually booted
> successfully.

I investigated this and it looks like a compiler bug (or something nastier)=
,
but I can't find where exactly registers get corrupted because if I add pri=
ntks
the corruption seems on the printk side, but if I don't add them it seems
the value gets corrupted earlier.

Here's what I tried:

1) If I add printk(KERN_INFO "%s handle: %p\n", __func__, handle); to
acpi_ns_validate_handle before and after call to ACPI_GET_DESCRIPTOR_TYPE
I get this:

acpi_ns_validate_handle handle: 00000000433f39ec
BUG: kernel NULL pointer dereference, address: 0000000000000050
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] SMP NOPTI
CPU: 3 PID: 473 Comm: systemd-udevd Tainted: G        W   E     5.10.11+ #1=
3
Hardware name: HP HP Pavilion Laptop 15-cs3xxx/86E2, BIOS F.05 01/01/2020
RIP: 0010:acpi_ns_validate_handle+0x39/0x62
Code: 49 8d 44 24 ff 48 83 f8 fd 76 09 4c 8b 25 4a b4 89 01 eb 39 4c
89 e2 48 c7 c6 c0 a4 6c 8f 48 c7 c7 46 6d 94 8f e8 eb 87 31 00 <41> 80
7c 24 08 0f 75 18 4c 89 e2 48 c7 c6 c0 a4 6c 8f 48 c7 c7 46
RSP: 0018:ffff9f488060bb00 EFLAGS: 00010246
RAX: 0000000000000030 RBX: ffff9f488060bb68 RCX: ffff889d5fad8a08
RDX: 0000000000000000 RSI: 0000000000000027 RDI: ffff889d5fad8a00
RBP: 0000000000000048 R08: 0000000000000000 R09: ffff9f488060b928
R10: ffff9f488060b920 R11: ffffffff8fcdc3f8 R12: 0000000000000048
R13: 0000000000000000 R14: ffffffff8ed400f0 R15: 0000000000000000
FS:  00007f811fdbe8c0(0000) GS:ffff889d5fac0000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000050 CR3: 000000026877c001 CR4: 0000000000770ee0
PKRU: 55555554
Call Trace:
 acpi_get_data_full+0x81/0xdf
 acpi_bus_get_device+0x32/0xa0
 sdw_intel_acpi_scan.cold+0x23/0x21c [soundwire_intel]
 snd_intel_dsp_driver_probe.cold+0x187/0x1b2 [snd_intel_dspcfg]
 azx_probe+0x7a/0x970 [snd_hda_intel]
 local_pci_probe+0x42/0x80
 ? _cond_resched+0x16/0x40
 pci_device_probe+0xfd/0x1b0
 really_probe+0xf2/0x440
 driver_probe_device+0xe1/0x150
 device_driver_attach+0xa1/0xb0
 __driver_attach+0x8a/0x150
 ? device_driver_attach+0xb0/0xb0
 ? device_driver_attach+0xb0/0xb0
 bus_for_each_dev+0x78/0xc0
 bus_add_driver+0x12b/0x1e0
 driver_register+0x8b/0xe0
 ? 0xffffffffc128a000
 do_one_initcall+0x44/0x1d0
 ? do_init_module+0x23/0x260
 ? kmem_cache_alloc_trace+0xf5/0x200
 do_init_module+0x5c/0x260
Generic FE-GE Realtek PHY r8169-1000:00: attached PHY driver [Generic
FE-GE Realtek PHY] (mii_bus:phy_addr=3Dr8169-1000:00, irq=3DIGNORE)
 __do_sys_finit_module+0xb1/0x110
 do_syscall_64+0x33/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

$ gdb vmlinux
(...)
(gdb) disassemble acpi_ns_validate_handle
Dump of assembler code for function acpi_ns_validate_handle:
   0xffffffff815781cd <+0>:     call   0xffffffff81062c40 <__fentry__>
   0xffffffff815781d2 <+5>:     push   %r12
   0xffffffff815781d4 <+7>:     mov    %rdi,%r12
   0xffffffff815781d7 <+10>:    call   0xffffffff81584a44
<acpi_ut_track_stack_ptr>
   0xffffffff815781dc <+15>:    lea    -0x1(%r12),%rax
   0xffffffff815781e1 <+20>:    cmp    $0xfffffffffffffffd,%rax
   0xffffffff815781e5 <+24>:    jbe    0xffffffff815781f0
<acpi_ns_validate_handle+35>
   0xffffffff815781e7 <+26>:    mov    0x189b44a(%rip),%r12        #
0xffffffff82e13638 <acpi_gbl_root_node>
   0xffffffff815781ee <+33>:    jmp    0xffffffff81578229
<acpi_ns_validate_handle+92>
   0xffffffff815781f0 <+35>:    mov    %r12,%rdx
   0xffffffff815781f3 <+38>:    mov    $0xffffffff81eca4c0,%rsi
   0xffffffff815781fa <+45>:    mov    $0xffffffff82146d46,%rdi
   0xffffffff81578201 <+52>:    call   0xffffffff818909f1 <printk>
   0xffffffff81578206 <+57>:    cmpb   $0xf,0x8(%r12)
   0xffffffff8157820c <+63>:    jne    0xffffffff81578226
<acpi_ns_validate_handle+89>
   0xffffffff8157820e <+65>:    mov    %r12,%rdx
   0xffffffff81578211 <+68>:    mov    $0xffffffff81eca4c0,%rsi
   0xffffffff81578218 <+75>:    mov    $0xffffffff82146d46,%rdi
   0xffffffff8157821f <+82>:    call   0xffffffff818909f1 <printk>
   0xffffffff81578224 <+87>:    jmp    0xffffffff81578229
<acpi_ns_validate_handle+92>
   0xffffffff81578226 <+89>:    xor    %r12d,%r12d
   0xffffffff81578229 <+92>:    mov    %r12,%rax
   0xffffffff8157822c <+95>:    pop    %r12
   0xffffffff8157822e <+97>:    ret
End of assembler dump.
(...)
(gdb) print (char *)0xffffffff82146d46
$2 =3D 0xffffffff82146d46 "\001\066%s handle: %p\n"
(gdb) print (char *)0xffffffff81eca4c0
$3 =3D 0xffffffff81eca4c0 <__func__.3> "acpi_ns_validate_handle"

The crash is on cmpb   $0xf,0x8(%r12).
%r12 is 0x48, so 0x48 + 0x8 =3D=3D 0x50 and that's the address we are crash=
ing on.
However, how can %r12 become 0x48 when few instructions above
we called printk and the value we see in the kernel log is different?
This probably means that printk is corrupting it... (or it's a CPU
bug, yeah right,
but with my luck for such issues who knows ;)
I don't dare to debug printk.

2) Without printks I get this:

BUG: kernel NULL pointer dereference, address: 0000000000000050
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] SMP NOPTI
CPU: 0 PID: 500 Comm: systemd-udevd Tainted: G        W   E     5.10.11+ #1=
4
Hardware name: HP HP Pavilion Laptop 15-cs3xxx/86E2, BIOS F.05 01/01/2020
RIP: 0010:acpi_ns_validate_handle+0x23/0x34
Code: 41 5d 41 5e 41 5f c3 0f 1f 44 00 00 41 54 49 89 fc e8 8d c7 00
00 49 8d 44 24 ff 48 83 f8 fd 76 09 4c 8b 25 4a b4 89 01 eb 0b <41> 80
7c 24 08 0f 74 03 45 31 e4 4c 89 e0 41 5c c3 0f 1f 44 00 00
RSP: 0018:ffffbfc0c08dfb08 EFLAGS: 00010213
RAX: 0000000000000047 RBX: ffffbfc0c08dfb70 RCX: 0000000000000000
RDX: ffffffffc11204b1 RSI: 0000000000000246 RDI: 0000000000000048
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffc11204b1 R11: 0000000000000001 R12: 0000000000000048
R13: ffffffffa37400f0 R14: 0000000000000048 R15: 0000000000000000
FS:  00007fbfdfd478c0(0000) GS:ffff9cd01fa00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000050 CR3: 00000001401de003 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 acpi_get_data_full+0x4d/0x92
 acpi_bus_get_device+0x32/0xa0
 sdw_intel_acpi_scan+0x59/0x230 [soundwire_intel]
 ? strstr+0x22/0x60
 snd_intel_dsp_driver_probe.cold+0xaf/0x163 [snd_intel_dspcfg]
 azx_probe+0x7a/0x970 [snd_hda_intel]
 local_pci_probe+0x42/0x80
 ? _cond_resched+0x16/0x40
 pci_device_probe+0xfd/0x1b0
 really_probe+0xf2/0x440
 driver_probe_device+0xe1/0x150
 device_driver_attach+0xa1/0xb0
 __driver_attach+0x8a/0x150
 ? device_driver_attach+0xb0/0xb0
 ? device_driver_attach+0xb0/0xb0
 bus_for_each_dev+0x78/0xc0
 bus_add_driver+0x12b/0x1e0
 driver_register+0x8b/0xe0
 ? 0xffffffffc1112000
 do_one_initcall+0x44/0x1d0
 ? do_init_module+0x23/0x260
 ? kmem_cache_alloc_trace+0xf5/0x200
 do_init_module+0x5c/0x260
 __do_sys_finit_module+0xb1/0x110
 do_syscall_64+0x33/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

$ gdb vmlinux
(...)
(gdb) disassemble acpi_ns_validate_handle
Dump of assembler code for function acpi_ns_validate_handle:
   0xffffffff815781cd <+0>:     call   0xffffffff81062c40 <__fentry__>
   0xffffffff815781d2 <+5>:     push   %r12
   0xffffffff815781d4 <+7>:     mov    %rdi,%r12
   0xffffffff815781d7 <+10>:    call   0xffffffff81584969
<acpi_ut_track_stack_ptr>
   0xffffffff815781dc <+15>:    lea    -0x1(%r12),%rax
   0xffffffff815781e1 <+20>:    cmp    $0xfffffffffffffffd,%rax
   0xffffffff815781e5 <+24>:    jbe    0xffffffff815781f0
<acpi_ns_validate_handle+35>
   0xffffffff815781e7 <+26>:    mov    0x189b44a(%rip),%r12        #
0xffffffff82e13638 <acpi_gbl_root_node>
   0xffffffff815781ee <+33>:    jmp    0xffffffff815781fb
<acpi_ns_validate_handle+46>
   0xffffffff815781f0 <+35>:    cmpb   $0xf,0x8(%r12)
   0xffffffff815781f6 <+41>:    je     0xffffffff815781fb
<acpi_ns_validate_handle+46>
   0xffffffff815781f8 <+43>:    xor    %r12d,%r12d
   0xffffffff815781fb <+46>:    mov    %r12,%rax
   0xffffffff815781fe <+49>:    pop    %r12
   0xffffffff81578200 <+51>:    ret
End of assembler dump.

Again, we crash on cmpb   $0xf,0x8(%r12).
%r12 =3D=3D 0x48, so again we crash on address 0x50.
Why is %r12 =3D=3D 0x48? It was either corrupted by acpi_ut_track_stack_ptr
or before we even entered this function.
It's weird that the value is exactly the same when corruption
has a different origin...

3) Without printks and with ACPI_DEBUG=3Dn

BUG: kernel NULL pointer dereference, address: 0000000000000050
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] SMP NOPTI
CPU: 7 PID: 473 Comm: systemd-udevd Tainted: G        W   E     5.10.11+ #1=
5
Hardware name: HP HP Pavilion Laptop 15-cs3xxx/86E2, BIOS F.05 01/01/2020
RIP: 0010:acpi_ns_validate_handle+0x1a/0x23
Code: 00 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f c3 0f 1f 44 00 00
48 8d 57 ff 48 89 f8 48 83 fa fd 76 08 48 8b 05 8c 28 6a 01 c3 <80> 7f
08 0f 74 02 31 c0 c3 0f 1f 44 00 00 48 8b 3d 76 28 6a 01 e8
RSP: 0018:ffffa96ac0847b20 EFLAGS: 00010213
RAX: 0000000000000048 RBX: ffffa96ac0847b70 RCX: 0000000000000000
RDX: 0000000000000047 RSI: 0000000000000246 RDI: 0000000000000048
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffc10ee4b1 R11: ffffffffa14e3268 R12: 0000000000001001
R13: ffffffffa073f150 R14: 0000000000000048 R15: 0000000000000000
FS:  00007f5a27c588c0(0000) GS:ffff91555fbc0000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000050 CR3: 000000010ab64004 CR4: 0000000000770ee0
PKRU: 55555554
Call Trace:
 acpi_get_data_full+0x4d/0x92
 acpi_bus_get_device+0x26/0x50
 sdw_intel_acpi_scan+0x59/0x230 [soundwire_intel]
 ? strstr+0x22/0x60
 snd_intel_dsp_driver_probe.cold+0xaf/0x163 [snd_intel_dspcfg]
 azx_probe+0x7a/0x970 [snd_hda_intel]
 local_pci_probe+0x42/0x80
 ? _cond_resched+0x16/0x40
 pci_device_probe+0xfd/0x1b0
 really_probe+0xf2/0x440
 driver_probe_device+0xe1/0x150
 device_driver_attach+0xa1/0xb0
 __driver_attach+0x8a/0x150
 ? device_driver_attach+0xb0/0xb0
 ? device_driver_attach+0xb0/0xb0
 bus_for_each_dev+0x78/0xc0
 bus_add_driver+0x12b/0x1e0
 driver_register+0x8b/0xe0
 ? 0xffffffffc1217000
 do_one_initcall+0x44/0x1d0
 ? do_init_module+0x23/0x260
 ? kmem_cache_alloc_trace+0xf5/0x200
 do_init_module+0x5c/0x260
 __do_sys_finit_module+0xb1/0x110
 do_syscall_64+0x33/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

$ gdb vmlinux
(...)
(gdb) disassemble acpi_ns_validate_handle
Dump of assembler code for function acpi_ns_validate_handle:
   0xffffffff8156518b <+0>:     call   0xffffffff81062c40 <__fentry__>
   0xffffffff81565190 <+5>:     lea    -0x1(%rdi),%rdx
   0xffffffff81565194 <+9>:     mov    %rdi,%rax
   0xffffffff81565197 <+12>:    cmp    $0xfffffffffffffffd,%rdx
   0xffffffff8156519b <+16>:    jbe    0xffffffff815651a5
<acpi_ns_validate_handle+26>
   0xffffffff8156519d <+18>:    mov    0x16a288c(%rip),%rax        #
0xffffffff82c07a30 <acpi_gbl_root_node>
   0xffffffff815651a4 <+25>:    ret
   0xffffffff815651a5 <+26>:    cmpb   $0xf,0x8(%rdi)
   0xffffffff815651a9 <+30>:    je     0xffffffff815651ad
<acpi_ns_validate_handle+34>
   0xffffffff815651ab <+32>:    xor    %eax,%eax
   0xffffffff815651ad <+34>:    ret
End of assembler dump.

Again, we crash on cmpb   $0xf,0x8(%rdi).
%rdi =3D=3D 0x48, it can only come from outside.

All logs (+result of some gdb commands I didn't include here) can be found =
here:
https://people.freedesktop.org/~mslusarz/tmp/
I'm using gcc 10.2.1 from Debian testing.

I hope I didn't make a fatal mistake in my analysis...^W^W^W^W^W^W^W^W^W^W^=
W^W
I hope I made a mistake in my analysis and the bug can be explained easily =
;)

Marcin
