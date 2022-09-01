Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691E15A8C26
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Sep 2022 06:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiIAEGg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Sep 2022 00:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIAEGf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Sep 2022 00:06:35 -0400
X-Greylist: delayed 12734 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 Aug 2022 21:06:33 PDT
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865ECEE4B7
        for <linux-acpi@vger.kernel.org>; Wed, 31 Aug 2022 21:06:33 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 26B642C05A0;
        Thu,  1 Sep 2022 04:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1662005190;
        bh=rhle4Wlt2XowReT6tVKgUtFQJBVf0dKstFF0q02FfTM=;
        h=From:To:Subject:Date:From;
        b=nACFBshWQFA1SCZf9z2asv1zoHWUqUrbN+c1L1NMSuVxTTJuh/z7fjV/lyt1uEzf6
         0lOUJMmknfizCcEhwsSEebGeYl+aN3XZDNpiXyV0PYzen+bTKEVxyt3P19aKUf0Y4R
         MONRDuFR8apGIHiUHTXo1g189B1u8GLOZx4U4/WSOSQcXZV2x9m32lOtzfb1k/UTAY
         DCHUWqFIoubRdD5xZIzAfXtjQkiEOX7GPVT15KJ2Ng+Tk44jxdq16t2pVdPw8ROl8U
         yEHzTqaQCGYx14wo23veGRvOcqn4op82w6OJW8ZRrgy6r0f8IcX7nLq1um7aR5cOBG
         3dNQ7Hm14NI8Q==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B63102fc50000>; Thu, 01 Sep 2022 16:06:29 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.38; Thu, 1 Sep 2022 16:06:29 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.040; Thu, 1 Sep 2022 16:06:29 +1200
From:   Joshua Scott <Joshua.Scott@alliedtelesis.co.nz>
To:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Unloading i2c mux overlay results in warning and stack trace
Thread-Topic: Unloading i2c mux overlay results in warning and stack trace
Thread-Index: AQHYvbg2S0S5+J72oEudFlyzQgl7vg==
Date:   Thu, 1 Sep 2022 04:06:29 +0000
Message-ID: <2baf7a4e370e4a7ea601a3c7d1be4662@svr-chch-ex1.atlnz.lc>
Accept-Language: en-NZ, en-US
Content-Language: en-NZ
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=eJVtc0h1 c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=8nJEP1OIZ-IA:10 a=xOM3xZuef0cA:10 a=Lm9K21Lct89MkaFcEKkA:9 a=wPNLvfGTeEIA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,=0A=
=0A=
I've been having a go at using a device-tree i2c-mux driver via the ACPI "P=
RP0001" compatibility layer.=0A=
I'm running Linux 5.15.62.=0A=
=0A=
I've written an SSDT overlay, and when I load it, everything seems to work =
fine.=0A=
The mux channels show up and are usable to access devices that are connecte=
d to the mux channels.=0A=
=0A=
When I remove the overlay however, the operation appears to succeed, but I =
get a warning and stack trace output from the kernel:=0A=
=0A=
[root@awplus overlays]# mkdir /sys/kernel/config/acpi/table/bay_1_mux=0A=
[root@awplus overlays]# cat mux_only.aml > /sys/kernel/config/acpi/table/ba=
y_1_mux/aml=0A=
=0A=
[root@awplus overlays]# ls /sys/bus/i2c/devices=0A=
i2c-0           i2c-12          i2c-4           i2c-8=0A=
i2c-1           i2c-13          i2c-5           i2c-9=0A=
i2c-10          i2c-2           i2c-6           i2c-PRP0001:00=0A=
i2c-11          i2c-3           i2c-7=0A=
=0A=
[root@awplus overlays]# rmdir /sys/kernel/config/acpi/table/bay_1_mux=0A=
[   92.682779] ------------[ cut here ]------------=0A=
[root@awplus ove[   92.687417] kernfs: can not remove 'physical_node', no d=
irectory=0A=
rlays]# [   92.694902] WARNING: CPU: 7 PID: 83 at fs/kernfs/dir.c:1542 kern=
fs_remove_by_name_ns+0x82/0x90=0A=
[   92.704086] Modules linked in: mvIntDrv(O) xt_nat xt_mark xt_addrtype xt=
_MASQUERADE xt_LOG pluggable(O) nf_log_syslog iptable_nat efivarfs diag tip=
c idprom_i2c(O) epi3_boardinfo_i2c(O) psuslot_epi3_register(O) psuslot_gpio=
_group(O) psuslot(O) gpiopins_boardinfo(O) SBx90xGEN3(O) idprom(O) epi3_boa=
rdinfo(O) boardinfo(O)=0A=
[   92.732146] CPU: 7 PID: 83 Comm: kworker/u128:1 Tainted: G           O  =
    5.15.63 #2=0A=
[   92.740071] Hardware name: congatec AG conga-B7E3/conga-B7E3, BIOS 5.13 =
08/23/2021=0A=
[   92.747636] Workqueue: kacpi_hotplug acpi_device_del_work_fn=0A=
[   92.753301] RIP: 0010:kernfs_remove_by_name_ns+0x82/0x90=0A=
[   92.758629] Code: c0 5d 41 5c 41 5d e9 dd 21 b6 00 48 c7 c7 20 59 b6 bc =
e8 31 6d e1 ff b8 fe ff ff ff eb e3 48 c7 c7 28 9c 7d bc e8 f0 52 73 00 <0f=
> 0b b8 fe ff ff ff eb ce 0f 1f 44 00 00 41 57 41 56 41 55 41 54=0A=
[   92.777332] RSP: 0018:ffffae03c04e7b68 EFLAGS: 00010286=0A=
[   92.782571] RAX: 0000000000000000 RBX: ffff979c47324bd0 RCX: 00000000000=
00000=0A=
[   92.789704] RDX: ffff97a34e3e6490 RSI: ffff97a34e3db450 RDI: ffff97a34e3=
db450=0A=
[   92.796836] RBP: ffff979c4a909e40 R08: ffff97a36f2eaba8 R09: 00000000fff=
fbfff=0A=
[   92.803965] R10: ffff97a34e0a0000 R11: ffff97a34e0a0000 R12: ffffae03c04=
e7b88=0A=
[   92.811097] R13: ffff979c47320a88 R14: ffff979c47320d80 R15: ffffae03c04=
e7b88=0A=
[   92.818239] FS:  0000000000000000(0000) GS:ffff97a34e3c0000(0000) knlGS:=
0000000000000000=0A=
[   92.826321] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
[   92.832070] CR2: 00007faeda657010 CR3: 000000010788c000 CR4: 00000000003=
506e0=0A=
[   92.839216] Call Trace:=0A=
[   92.841688]  <TASK>=0A=
[   92.843822]  acpi_unbind_one+0xec/0x170=0A=
[   92.847672]  device_del+0x1a3/0x4b0=0A=
[   92.851189]  ? kernfs_name_hash+0xd/0x80=0A=
[   92.855129]  ? recalibrate_cpu_khz+0x10/0x10=0A=
[   92.859425]  ? ktime_get_mono_fast_ns+0x49/0x90=0A=
[   92.863972]  device_unregister+0x9/0x20=0A=
[   92.867823]  i2c_del_adapter.part.0+0x1bf/0x250=0A=
[   92.872383]  i2c_mux_del_adapters+0x81/0xc0=0A=
[   92.876576]  pca954x_remove+0x20/0x30=0A=
[   92.880269]  i2c_device_remove+0x1a/0x80=0A=
[   92.884206]  __device_release_driver+0x179/0x250=0A=
[   92.888848]  device_release_driver+0x1f/0x30=0A=
[   92.893126]  bus_remove_device+0xcd/0x110=0A=
[   92.897152]  device_del+0x18b/0x4b0=0A=
[   92.900666]  ? device_match_fwnode+0x20/0x20=0A=
[   92.904964]  device_unregister+0x9/0x20=0A=
[   92.908817]  i2c_acpi_notify+0x115/0x150=0A=
[   92.912771]  ? device_del+0x2e1/0x4b0=0A=
[   92.916446]  blocking_notifier_call_chain+0x58/0x80=0A=
[   92.921351]  acpi_device_del_work_fn+0x78/0xc0=0A=
[   92.925809]  process_one_work+0x1d8/0x370=0A=
[   92.929848]  worker_thread+0x48/0x3d0=0A=
[   92.933525]  ? rescuer_thread+0x380/0x380=0A=
[   92.937562]  kthread+0x122/0x140=0A=
[   92.940805]  ? set_kthread_struct+0x40/0x40=0A=
[   92.945017]  ret_from_fork+0x22/0x30=0A=
[   92.948610]  </TASK>=0A=
[   92.950828] ---[ end trace 76fd3a73e923dd51 ]---=0A=
=0A=
[root@awplus overlays]# ls /sys/bus/i2c/devices=0A=
i2c-0  i2c-1  i2c-2  i2c-3  i2c-4  i2c-5=0A=
=0A=
=0A=
I have included the source code for my SSDT overlay below.=0A=
Is there something that I am doing incorrectly?=0A=
Or, is there some missing support around removing ACPI overlays that use de=
vice-tree drivers?=0A=
=0A=
=0A=
Thank you for your time,=0A=
Joshua Scott=0A=
=0A=
=0A=
DefinitionBlock ("mux_only.aml", "SSDT", 1, "ATL", "TEST", 0x00000001)=0A=
{=0A=
    External (\_SB.I2CA, DeviceObj)=0A=
=0A=
    Scope (\_SB.I2CA)=0A=
    {=0A=
        // 8-Channel i2c mux=0A=
        Device (MUX0)=0A=
        {=0A=
            Name (_HID, "PRP0001")=0A=
            Name (_CRS, ResourceTemplate () {=0A=
                I2cSerialBusV2 (0x74, ControllerInitiated,=0A=
                                400000, AddressingMode7Bit,=0A=
                                "\\_SB.I2CA", 0x00,=0A=
                                ResourceConsumer, , Exclusive, )=0A=
            })=0A=
            Name (_DSD, Package () {=0A=
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"), // Device =
Properties UUID=0A=
                Package () {=0A=
                    Package () { "compatible", "nxp,pca9548" },=0A=
                    Package () { "i2c-mux-idle-disconnect", "" },=0A=
                }=0A=
            })=0A=
=0A=
            // Unused channels=0A=
            // Device (CH00) { Name (_ADR, 0) }=0A=
            // Device (CH01) { Name (_ADR, 1) }=0A=
            // Device (CH02) { Name (_ADR, 2) }=0A=
            // Device (CH03) { Name (_ADR, 3) }=0A=
            // Device (CH04) { Name (_ADR, 4) }=0A=
            // Device (CH05) { Name (_ADR, 5) }=0A=
            // Device (CH06) { Name (_ADR, 6) }=0A=
=0A=
            // Channel 7 contains GPIO expander.=0A=
            Device (CH07)=0A=
            {=0A=
                Name (_ADR, 7)=0A=
            }=0A=
        }=0A=
    }=0A=
}=
