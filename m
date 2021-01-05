Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D588B2EA6AA
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Jan 2021 09:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbhAEIgD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Jan 2021 03:36:03 -0500
Received: from mail-eopbgr690118.outbound.protection.outlook.com ([40.107.69.118]:15623
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726097AbhAEIgC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 5 Jan 2021 03:36:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzTuH37FXq+wwj+xUy1k4p2xOK708kGe3bTnNmd+fSAmRat+QwUCE0b6w7GLfqaIotse8n9hmlC8rxHWlnZoalMX9HOLsYiY8gfCaxOaVZpn4pPQ57gSPS6YgIgKfzoty0QN6JrANXt3hLB3fpOj8LQEXti8gwjeLS2dW63KMVk4aA9MKDr3JzlOlqMwa4P7EGj34MI4dhQOFSo1bhXDr87NHSzDxALb8GeB5OzbHM2MyEfljI0sOY8I+mIo1FbrfJDndE6yB/DHze2eA8PeRq+DjDXHQGwzuYBrATYMd12qtsovmPmfzLtB/JT3Uu+XH3hXfUjqkwZXsdPZHZszSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pi8HelUfabOYUuFrFgDZRafcgGTtgB/DLKyW0hL8/gg=;
 b=UwpSgKwY9C6kXSD8rV14KLxW8IRA/n8BefkBdcogTKajKj99PvjGL86k6T0W+dStNWY5z1bJdzacsjS83QSXcK3lWtORbA0Ukhcq6bJkDWQs0LTibNVagx5m/aJniV5O+iMxp8Dy3fq8jREBcDfAZsg0e+1576enwCRg+5WNGf5WR13SZkH1lVafgJaduXCENCqFuhoiIYrpIPAIOdClrl7r5TYKQIx/gVtYLfboSgLXbrFFYRyYI/c5Y9Mf05Mf0RYW88TxRjyf6hpRc1bqyTya+XZysWLcP7Cl4XB9BLlu6tI/FLT7ceZ0GMO+CwZnWlxebWHWyJaQonoEgafh7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fortanix.com; dmarc=pass action=none header.from=fortanix.com;
 dkim=pass header.d=fortanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fortanix.onmicrosoft.com; s=selector2-fortanix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pi8HelUfabOYUuFrFgDZRafcgGTtgB/DLKyW0hL8/gg=;
 b=iS7sbdvnFOdz/rhJmteUv3tWJ7ur2UiCwmfBusqjF8u1/7/iDX6f+j3m3ZXjTFw8G5MLfGKJ03qMynrMF7VQSxrvpnWVAkv6i+B6dEpFOc6t445qoKZiYlrMmoDpTQvesx/mROTLZhol5EPXLkflaFEAGiw771O2/alrYIVaen0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=fortanix.com;
Received: from BY5PR11MB4260.namprd11.prod.outlook.com (2603:10b6:a03:1ba::30)
 by BYAPR11MB2840.namprd11.prod.outlook.com (2603:10b6:a02:c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Tue, 5 Jan
 2021 08:31:35 +0000
Received: from BY5PR11MB4260.namprd11.prod.outlook.com
 ([fe80::84e0:4df6:7a70:eee5]) by BY5PR11MB4260.namprd11.prod.outlook.com
 ([fe80::84e0:4df6:7a70:eee5%6]) with mapi id 15.20.3721.024; Tue, 5 Jan 2021
 08:31:35 +0000
To:     linux-acpi@vger.kernel.org, devel@acpica.org,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
From:   Jethro Beekman <jethro@fortanix.com>
Subject: Fwd: [Bug 210449] New: acpi_device_add: buffer overflow in strcpy
Message-ID: <02b336ee-603e-d5e6-998c-aa94b9dce71b@fortanix.com>
Date:   Tue, 5 Jan 2021 09:31:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms020500060704040503000008"
X-Originating-IP: [213.127.127.169]
X-ClientProxiedBy: AM0PR10CA0085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::38) To BY5PR11MB4260.namprd11.prod.outlook.com
 (2603:10b6:a03:1ba::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.4.219] (213.127.127.169) by AM0PR10CA0085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20 via Frontend Transport; Tue, 5 Jan 2021 08:31:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cf77f94-23ad-4a07-ea32-08d8b154507a
X-MS-TrafficTypeDiagnostic: BYAPR11MB2840:
X-Microsoft-Antispam-PRVS: <BYAPR11MB284010F56F07A828E1C6336AAAD10@BYAPR11MB2840.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gFi3CdAXof79vAkNOtZhxOIVEraRV9f6Fn9qCOT7cNEgxgAPaWkwIHv1NhUNzt9vb0mCw+jmhs1fxC/7Gt4RjU2WpnQFPUf8RFKN2kEqbi4txHKWw3HLaEZ1VaPHwjHrIic8PbQtf/3mnnPF27DJKEEO+HJTMfneHKuxlndN0mwk4mWGuR56Jkb2gk1GSGDvwyf0lfnoXy7CI74tuC7xns9miJalZ/4Hm9R2lYfyDpb6/UIaJLcs4nw1b3C99nA5ltu0eysvaRL3N5StJZvIMr/tQLznTAGqjRI/a8OFJiLkyu64Urmu5dwIoDr7sYzWNmzBm0MH0CfbnlxlCkPNSEC7+AIpC5Wyw3B1d86Qh+E1TOE6zxyqRUhpL1qMpBjkXn9gp5+X1Qwh+QoYi92AWdICPQigHQ80O/9EY1M+lgp72a2pbz5PpkStGPcMpqYrVL34fFkC+QeuvDASYGxNKac0SchUX5aE54XyGaZ+mgGvQ7G+f2dYdRURnmDrg4gj7KYq/he01bLE+AcUHVVBGfOrgd6mdL6pOarsvpb1rDOnpAZ8cxbl4m7zvL4Ba7Ye
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4260.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(39840400004)(136003)(366004)(52116002)(8676002)(66476007)(66556008)(235185007)(8936002)(6666004)(31696002)(6486002)(966005)(83380400001)(478600001)(5660300002)(66946007)(186003)(45080400002)(16526019)(26005)(2906002)(33964004)(16576012)(2616005)(956004)(6916009)(316002)(36756003)(31686004)(30864003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Q1N1bEwxcXZmZHlheGhGVkNleDBQb3RmQ3ZmajNITi8vUWJGa0ZrUWRqMExW?=
 =?utf-8?B?QnpqcG1URkt3R2IzcnEzY1hOZ2pIN3dCeXF0emxXQ2tSR2ExVVordXpTR2Jx?=
 =?utf-8?B?d2E5OHVDdmEyREZPR2hKVFJZSWZLVWZPWktMaFU1QWpLTDZIUWlnMVJBS1F6?=
 =?utf-8?B?akRRVTJBTzRBeS9hMEVmRzRmUGMxS25VMzNnSUxYMmZxRFFwNEhyK3ZTVGtq?=
 =?utf-8?B?Y0psYlNPaHdsUDV0Y0hoT2lzL3lZWlluYlRLQm5iZTB3OERlVk9xd0VtRXlt?=
 =?utf-8?B?YUZMRktodW1OaytJQXgzcVhPWVU5K29LVzJ3T1JIbnY2djRIRHcxeUZoK1ZR?=
 =?utf-8?B?amc3U290cllFMDN3akE5QmNDR0lOMGlqWHFMSHMwL0tWbFdGNXZ3QUM4Ti9H?=
 =?utf-8?B?RWk5OUNrRGplNnZrT2tlVDRkdG9oaVh6c3lubVpIYlhHaDJZaU9MZDQxdmNW?=
 =?utf-8?B?WjJxY0Flc3Q3amo3amcrUEdHWG5CZUNObFo5eXQ4RlBMWHZrdlhVRnppRlNX?=
 =?utf-8?B?OHFUT2g5bnRQNWZ6dzNJS0tZLzVGbnlpUjFKTE5vZThJYkxiUGlwMDVGd2wr?=
 =?utf-8?B?amxCQmZ6T0Ftcjk4N3ZZTnZjUytxNnNTYWVqS2crckltOFNnZWVvRjc2WDZT?=
 =?utf-8?B?N2UzVWR1MVlzR2VKdVNjSzZZODA2UVhONlFJSUpGeWdERjVJTTR6QUhicGYv?=
 =?utf-8?B?TlgyV21KY3hMSHp3QmxELzFkVFM0NjlIZlEzaytvdjQ4WlpuU0NUWm1JK1Q3?=
 =?utf-8?B?Q1R0c0UxQmdpV2JpaVZOc0VrLzRQQlNwR2tpZ0RaRisxOWFCMGhWb3l0V0ly?=
 =?utf-8?B?Qzl4WGNqVEhweGUzSHIrV1RkbjBObVM5bXI2S3ZpVit1c0l5L3g0YVhnYkdD?=
 =?utf-8?B?YldpeSt4RlRMaFgxMnYwVzhPQUJIc1p4TlNpWUpVdXc3SUJraC9IY0JzRE5H?=
 =?utf-8?B?WTArTFRtdVA5dDhFUkh0blUyd0I3QWY4Q04wYmx4OFdUdXVkREVKRDdFSktl?=
 =?utf-8?B?aU5ycnJwTUlHWEM4RU9GbzlVakVtenBxN280MXFsWTdidThINXQ5REpOQ0lI?=
 =?utf-8?B?MEtUNDdFVHJZa2FRUkhRWUlwSXVTcHBCTHdJV21uZmhuZzJlU1NtUW1GSy9i?=
 =?utf-8?B?M0s1Qkl1aVp2VmVDc2lYN1NJOXZhOXF1SXQ0NUNiNHFjUmtuYnV1ODZQVDZD?=
 =?utf-8?B?RjZRVjNrWDZRVUFPTjQyTkNqZ01nM3grZ1YvcU82TkxYd2RoVDNhN2ZYbUNX?=
 =?utf-8?B?ZnBod1p0TkdEeExESjhzcFVXeDFMVWFrUXVTVTk4OFpQa3c4czU5Sk9PYjF6?=
 =?utf-8?Q?kAZTUGd3F17crNLKYy2CRw4b9B2LVH6Rtw?=
X-OriginatorOrg: fortanix.com
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4260.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2021 08:31:35.7327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: de7becae-4883-43e8-82c7-7dbdbb988ae6
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf77f94-23ad-4a07-ea32-08d8b154507a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /u1jVHCYHqTfRA0TlCK0KcQuesekCgfiVS5Birk+Oh3BOA9WQJOERUKKzGODTSoNBY2HQevxoUpYWFQ39QbMOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2840
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

--------------ms020500060704040503000008
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

This regression (boot failure) is now in 5.11.0-rc2

--=20
Jethro Beekman | Fortanix

-------- Forwarded Message --------
Subject: [Bug 210449] New: acpi_device_add: buffer overflow in strcpy
Date: Wed, 02 Dec 2020 02:16:38 -0800
From: bugzilla-daemon@bugzilla.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D210449


            Bug ID: 210449
           Summary: acpi_device_add: buffer overflow in strcpy
           Product: ACPI
           Version: 2.5
    Kernel Version: next-20201201
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Config-Other
          Assignee: acpi_config-ot...@kernel-bugs.osdl.org
          Reporter: ker...@jbeekman.nl
        Regression: No

[    0.000000] Linux version 5.10.0-rc6-next-20201201 (root@sgx-kernel-bu=
ild)
(gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609, GNU ld (GNU Binutil=
s for
Ubuntu) 2.26.1) #7 SMP Wed Dec 2 09:18:07 UTC 2020
[    0.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-5.10.0-rc6-next-2=
0201201
root=3DUUID=3D4ec1dc08-af51-4080-b927-561417afaa77 ro console=3Dtty1 cons=
ole=3DttyS0
earlyprintk=3DttyS0
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai =20
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating poi=
nt
registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds regis=
ters'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960=

bytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x00000000000c0000-0x00000000000fffff] res=
erved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003ed4bfff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x000000003ed4c000-0x000000003ed4cfff] ACP=
I data
[    0.000000] BIOS-e820: [mem 0x000000003ed4d000-0x000000003ee7afff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x000000003ee7b000-0x000000003ee99fff] ACP=
I data
[    0.000000] BIOS-e820: [mem 0x000000003ee9a000-0x000000003eef1fff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x000000003eef2000-0x000000003ef1afff] res=
erved
[    0.000000] BIOS-e820: [mem 0x000000003ef1b000-0x000000003ff9afff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x000000003ff9b000-0x000000003fff2fff] res=
erved
[    0.000000] BIOS-e820: [mem 0x000000003fff3000-0x000000003fffafff] ACP=
I data
[    0.000000] BIOS-e820: [mem 0x000000003fffb000-0x000000003fffefff] ACP=
I NVS
[    0.000000] BIOS-e820: [mem 0x000000003ffff000-0x000000003fffffff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000001bfffffff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x00000001c0200000-0x00000001c1bfffff] res=
erved
[    0.000000] BIOS-e820: [mem 0x00000001c1e00000-0x00000001c1ffffff] res=
erved
[    0.000000] printk: bootconsole [earlyser0] enabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.70 by Microsoft
[    0.000000] efi: ACPI=3D0x3fffa000 ACPI 2.0=3D0x3fffa014 SMBIOS=3D0x3f=
fd8000
SMBIOS 3.0=3D0x3ffd6000 MEMATTR=3D0x3f9e0218 RNG=3D0x3ffda818=20
[    0.000000] efi: seeding entropy pool
[    0.000000] SMBIOS 3.1.0 present.
[    0.000000] DMI: Microsoft Corporation Virtual Machine/Virtual Machine=
, BIOS
Hyper-V UEFI Release v4.1 06/17/2020
[    0.000000] Hypervisor detected: Microsoft Hyper-V
[    0.000000] Hyper-V: features 0x2e7f, hints 0x60c2c, misc 0xed7b2
[    0.000000] Hyper-V Host Build:18362-10.0-3-0.3186
[    0.000000] Hyper-V: LAPIC Timer Frequency: 0xc3500
[    0.000000] tsc: Marking TSC unstable due to running on Hyper-V
[    0.000000] Hyper-V: Using hypercall for remote TLB flush
[    0.000000] clocksource: hyperv_clocksource_tsc_page: mask:
0xffffffffffffffff max_cycles: 0x24e6a1710, max_idle_ns: 440795202120 ns
[    0.000002] tsc: Detected 3696.012 MHz processor
[    0.002124] last_pfn =3D 0x1c0000 max_arch_pfn =3D 0x400000000
[    0.004543] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- =
WT =20
Memory KASLR using RDRAND RDTSC...
[    0.008675] last_pfn =3D 0x40000 max_arch_pfn =3D 0x400000000
[    0.021667] check: Scanning 1 areas for low memory corruption
[    0.024119] Using GB pages for direct mapping
[    0.026644] Secure boot disabled
[    0.029161] RAMDISK: [mem 0x2c75c000-0x2f097fff]
[    0.033563] ACPI: Early table checksum verification disabled
[    0.037148] ACPI: RSDP 0x000000003FFFA014 000024 (v02 VRTUAL)
[    0.040591] ACPI: XSDT 0x000000003FFF90E8 00005C (v01 VRTUAL MICROSFT
00000001 MSFT 00000001)
[    0.044286] ACPI: FACP 0x000000003FFF8000 000114 (v06 VRTUAL MICROSFT
00000001 MSFT 00000001)
[    0.048784] ACPI: DSDT 0x000000003EE7B000 01E184 (v02 MSFTVM DSDT01 =20
00000001 MSFT 05000000)
[    0.052610] ACPI: FACS 0x000000003FFFE000 000040
[    0.054718] ACPI: OEM0 0x000000003FFF7000 000064 (v01 VRTUAL MICROSFT
00000001 MSFT 00000001)
[    0.058583] ACPI: WAET 0x000000003FFF6000 000028 (v01 VRTUAL MICROSFT
00000001 MSFT 00000001)
[    0.063415] ACPI: APIC 0x000000003FFF5000 000050 (v04 VRTUAL MICROSFT
00000001 MSFT 00000001)
[    0.067570] ACPI: SRAT 0x000000003FFF4000 0001D0 (v02 VRTUAL MICROSFT
00000001 MSFT 00000001)
[    0.073199] ACPI: BGRT 0x000000003FFF3000 000038 (v01 VRTUAL MICROSFT
00000001 MSFT 00000001)
[    0.079622] ACPI: FPDT 0x000000003ED4C000 000034 (v01 VRTUAL MICROSFT
00000001 MSFT 00000001)
[    0.085486] SRAT: PXM 0 -> APIC 0x00 -> Node 0
[    0.087926] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x3fffffff] hotpl=
ug
[    0.093171] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x1bfffffff] hot=
plug
[    0.096744] ACPI: SRAT: Node 0 PXM 0 [mem 0x1c0200000-0x1c1bfffff] hot=
plug
[    0.100390] ACPI: SRAT: Node 0 PXM 0 [mem 0x1c1e00000-0x1c1ffffff] hot=
plug
[    0.103377] ACPI: SRAT: Node 0 PXM 0 [mem 0x1c2000000-0xfdfffffff] hot=
plug
[    0.107195] ACPI: SRAT: Node 0 PXM 0 [mem 0x1000000000-0xffffffffff] h=
otplug
[    0.111687] ACPI: SRAT: Node 0 PXM 0 [mem 0x10000200000-0x1ffffffffff]=

hotplug
[    0.115130] ACPI: SRAT: Node 0 PXM 0 [mem 0x20000200000-0x3ffffffffff]=

hotplug
[    0.118507] ACPI: SRAT: Node 0 PXM 0 [mem 0x40000200000-0x7ffffffffff]=

hotplug
[    0.121785] ACPI: SRAT: Node 0 PXM 0 [mem 0x80000200000-0xfffffffffff]=

hotplug
[    0.125707] NUMA: Node 0 [mem 0x00000000-0x3fffffff] + [mem
0x100000000-0x1bfffffff] -> [mem 0x00000000-0x1bfffffff]
[    0.131037] NODE_DATA(0) allocated [mem 0x1bffd5000-0x1bfffffff]
[    0.134643] Zone ranges:
[    0.136056]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.139374]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.142758]   Normal   [mem 0x0000000100000000-0x00000001bfffffff]
[    0.145575]   Device   empty
[    0.147316] Movable zone start for each node
[    0.149727] Early memory node ranges
[    0.151185]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.154043]   node   0: [mem 0x0000000000100000-0x000000003ed4bfff]
[    0.156924]   node   0: [mem 0x000000003ed4d000-0x000000003ee7afff]
[    0.159732]   node   0: [mem 0x000000003ee9a000-0x000000003eef1fff]
[    0.162220]   node   0: [mem 0x000000003ef1b000-0x000000003ff9afff]
[    0.165073]   node   0: [mem 0x000000003ffff000-0x000000003fffffff]
[    0.167650]   node   0: [mem 0x0000000100000000-0x00000001bfffffff]
[    0.170038] Zeroed struct page in unavailable ranges: 270 pages
[    0.170040] Initmem setup node 0 [mem 0x0000000000001000-0x00000001bff=
fffff]
[    0.185045] tboot: non-0 tboot_addr but it is not of type E820_TYPE_RE=
SERVED
[    0.190108] ACPI: PM-Timer IO Port: 0x408
[    0.191916] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
[    0.194264] IOAPIC[0]: apic_id 1, version 17, address 0xfec00000, GSI =
0-23
[    0.196894] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level=
)
[    0.199432] Using ACPI (MADT) for SMP configuration information
[    0.201790] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
[    0.203987] PM: hibernation: Registered nosave memory: [mem
0x00000000-0x00000fff]
[    0.207429] PM: hibernation: Registered nosave memory: [mem
0x000a0000-0x000bffff]
[    0.210706] PM: hibernation: Registered nosave memory: [mem
0x000c0000-0x000fffff]
[    0.218676] PM: hibernation: Registered nosave memory: [mem
0x3ed4c000-0x3ed4cfff]
[    0.222254] PM: hibernation: Registered nosave memory: [mem
0x3ee7b000-0x3ee99fff]
[    0.226091] PM: hibernation: Registered nosave memory: [mem
0x3eef2000-0x3ef1afff]
[    0.229853] PM: hibernation: Registered nosave memory: [mem
0x3ff9b000-0x3fff2fff]
[    0.232710] PM: hibernation: Registered nosave memory: [mem
0x3fff3000-0x3fffafff]
[    0.237183] PM: hibernation: Registered nosave memory: [mem
0x3fffb000-0x3fffefff]
[    0.240665] PM: hibernation: Registered nosave memory: [mem
0x40000000-0xffffffff]
[    0.243469] [mem 0x40000000-0xffffffff] available for PCI devices
[    0.246209] Booting paravirtualized kernel on Hyper-V
[    0.248579] clocksource: refined-jiffies: mask: 0xffffffff max_cycles:=

0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.253386] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:1 nr_cpu_ids:1
nr_node_ids:1
[    0.256881] percpu: Embedded 55 pages/cpu s188416 r8192 d28672 u209715=
2
[    0.259605] Hyper-V: PV spinlocks enabled
[    0.261610] PV qspinlock hash table entries: 256 (order: 0, 4096 bytes=
,
linear)
[    0.265050] Built 1 zonelists, mobility grouping on.  Total pages: 103=
0580
[    0.269460] Policy zone: Normal
[    0.270834] Kernel command line:
BOOT_IMAGE=3D/boot/vmlinuz-5.10.0-rc6-next-20201201
root=3DUUID=3D4ec1dc08-af51-4080-b927-561417afaa77 ro console=3Dtty1 cons=
ole=3DttyS0
earlyprintk=3DttyS0
[    0.279471] Dentry cache hash table entries: 524288 (order: 10, 419430=
4
bytes, linear)
[    0.284434] Inode-cache hash table entries: 262144 (order: 9, 2097152 =
bytes,
linear)
[    0.288417] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.301143] Memory: 3966860K/4193224K available (14346K kernel code, 3=
311K
rwdata, 4592K rodata, 2244K init, 6596K bss, 226104K reserved, 0K cma-res=
erved)
[    0.309082] random: get_random_u64 called from
__kmem_cache_create+0x32/0x480 with crng_init=3D0
[    0.309152] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D1,=
 Nodes=3D1
[    0.317745] Kernel/User page tables isolation: enabled
[    0.320049] ftrace: allocating 43490 entries in 170 pages
[    0.331826] ftrace: allocated 170 pages with 4 groups
[    0.334815] rcu: Hierarchical RCU implementation.
[    0.337496] rcu:     RCU restricting CPUs from NR_CPUS=3D8192 to nr_cp=
u_ids=3D1.
[    0.340690]  Rude variant of Tasks RCU enabled.
[    0.344589]  Tracing variant of Tasks RCU enabled.
[    0.346827] rcu: RCU calculated value of scheduler-enlistment delay is=
 25
jiffies.
[    0.350645] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_i=
ds=3D1
[    0.355693] Using NULL legacy PIC
[    0.357032] NR_IRQS: 524544, nr_irqs: 256, preallocated irqs: 0
[    0.360578] Console: colour dummy device 80x25
[    0.363119] printk: console [tty1] enabled
[    0.365569] printk: console [ttyS0] enabled
[    0.365569] printk: console [ttyS0] enabled
[    0.370589] printk: bootconsole [earlyser0] disabled
[    0.370589] printk: bootconsole [earlyser0] disabled
[    0.375252] ACPI: Core revision 20200925
[    0.377028] Failed to register legacy timer interrupt
[    0.379501] APIC: Switch to symmetric I/O mode setup
[    0.381791] Hyper-V: Using IPI hypercalls
[    0.383640] Hyper-V: Using enlightened APIC (xapic mode)
[    0.383703] Calibrating delay loop (skipped), value calculated using t=
imer
frequency.. 7392.02 BogoMIPS (lpj=3D14784048)
[    0.391706] pid_max: default: 32768 minimum: 301
[    0.394396] LSM: Security Framework initializing
[    0.395713] Yama: becoming mindful.
[    0.397565] AppArmor: AppArmor initialized
[    0.399501] TOMOYO Linux initialized
[    0.399738] Mount-cache hash table entries: 8192 (order: 4, 65536 byte=
s,
linear)
[    0.403711] Mountpoint-cache hash table entries: 8192 (order: 4, 65536=

bytes, linear)
Poking KASLR using RDRAND RDTSC...
[    0.409605] Last level iTLB entries: 4KB 128, 2MB 8, 4MB 8
[    0.411705] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.414453] Spectre V1 : Mitigation: usercopy/swapgs barriers and __us=
er
pointer sanitization
[    0.415713] Spectre V2 : Mitigation: Full generic retpoline
[    0.418480] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling R=
SB on
context switch
[    0.419703] Speculative Store Bypass: Vulnerable
[    0.422516] TAA: Mitigation: Clear CPU buffers
[    0.423703] SRBDS: Unknown: Dependent on hypervisor status
[    0.426287] MDS: Mitigation: Clear CPU buffers
[    0.430804] Freeing SMP alternatives memory: 40K
[    0.432315] smpboot: CPU0: Intel(R) Xeon(R) E-2288G CPU @ 3.70GHz (fam=
ily:
0x6, model: 0x9e, stepping: 0xd)
[    0.435816] Performance Events: unsupported p6 CPU model 158 no PMU dr=
iver,
software events only.
[    0.439749] rcu: Hierarchical SRCU implementation.
[    0.442301] NMI watchdog: Perf NMI watchdog permanently disabled
[    0.443739] smp: Bringing up secondary CPUs ...
[    0.445615] smp: Brought up 1 node, 1 CPU
[    0.447704] smpboot: Max logical packages: 1
[    0.450605] smpboot: Total of 1 processors activated (7392.02 BogoMIPS=
)
[    0.451888] devtmpfs: initialized
[    0.453639] x86/mm: Memory block size: 128MB
[    0.455919] PM: Registering ACPI NVS region [mem 0x3fffb000-0x3fffefff=
]
(16384 bytes)
[    0.459758] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffff=
fff,
max_idle_ns: 7645041785100000 ns
[    0.463754] futex hash table entries: 256 (order: 2, 16384 bytes, line=
ar)
[    0.466884] pinctrl core: initialized pinctrl subsystem
[    0.468011] PM: RTC time: 10:07:38, date: 2020-12-02
[    0.471018] NET: Registered protocol family 16
[    0.471763] DMA: preallocated 512 KiB GFP_KERNEL pool for atomic alloc=
ations
[    0.474696] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA pool for atom=
ic
allocations
[    0.475711] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA32 pool for at=
omic
allocations
[    0.479694] audit: initializing netlink subsys (disabled)
[    0.479811] thermal_sys: Registered thermal governor 'fair_share'
[    0.479811] thermal_sys: Registered thermal governor 'bang_bang'
[    0.483709] audit: type=3D2000 audit(1606903658.096:1): state=3Dinitia=
lized
audit_enabled=3D0 res=3D1
[    0.487710] thermal_sys: Registered thermal governor 'step_wise'
[    0.487711] thermal_sys: Registered thermal governor 'user_space'
[    0.491673] cpuidle: using governor ladder
[    0.494158] cpuidle: using governor menu
[    0.495746] ACPI: bus type PCI registered
[    0.498396] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.500483] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pag=
es
[    0.503708] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pag=
es
[    0.507955] ACPI: Added _OSI(Module Device)
[    0.510343] ACPI: Added _OSI(Processor Device)
[    0.511707] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.513985] ACPI: Added _OSI(Processor Aggregator Device)
[    0.515744] ACPI: Added _OSI(Linux-Dell-Video)
[    0.517079] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.519735] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.526442] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.528121] ACPI: Interpreter enabled
[    0.529015] ACPI: (supports S0 S5)
[    0.529916] ACPI: Using IOAPIC for interrupt routing
[    0.531111] PCI: Using host bridge windows from ACPI; if necessary, us=
e
"pci=3Dnocrs" and report a bug
[    0.531760] ACPI: Enabled 1 GPEs in block 00 to 0F
[    0.533991] detected buffer overflow in strcpy
[    0.535598] ------------[ cut here ]------------
[    0.535704] kernel BUG at lib/string.c:1149!
[    0.536784] invalid opcode: 0000 [#1] SMP PTI
[    0.539286] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
5.10.0-rc6-next-20201201 #7
[    0.539700] Hardware name: Microsoft Corporation Virtual Machine/Virtu=
al
Machine, BIOS Hyper-V UEFI Release v4.1 06/17/2020
[    0.539700] RIP: 0010:fortify_panic+0x13/0x15
[    0.539700] Code: 00 41 c7 47 34 00 00 00 00 5b 4c 89 f8 41 5c 41 5d 4=
1 5e
41 5f 5d c3 55 48 89 fe 48 c7 c7 70 6e 76 a6 48 89 e5 e8 19 db ff ff <0f>=
 0b 55
48 89 e5 53 89 f3 48 89 de e8 46 bb ac ff 48 39 c3 0f 94
[    0.539700] RSP: 0000:ffffc09280043b38 EFLAGS: 00010282
[    0.539700] RAX: 0000000000000022 RBX: ffff9be00037f200 RCX:
c0000000ffffdfff
[    0.539700] RDX: 0000000000000000 RSI: 00000000ffffdfff RDI:
ffffffffa70058ac
[    0.539700] RBP: ffffc09280043b38 R08: 0000000000000003 R09:
0000000000000001
[    0.539700] R10: ffffc09280043b10 R11: ffffc09280043900 R12:
ffff9be0002d4420
[    0.539700] R13: ffff9be00037f200 R14: ffffffffa6c437c8 R15:
ffff9be00089b800
[    0.539700] FS:  0000000000000000(0000) GS:ffff9be0bbc00000(0000)
knlGS:0000000000000000
[    0.539700] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.539700] CR2: 0000000000000000 CR3: 000000019040a001 CR4:
00000000003706f0
[    0.539700] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[    0.539700] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[    0.539700] Call Trace:
[    0.539700]  acpi_device_add+0x403/0x410
[    0.539700]  ? acpi_free_pnp_ids+0x60/0x60
[    0.539700]  acpi_add_single_object+0x27c/0x670
[    0.539700]  ? up+0x32/0x50
[    0.539700]  ? acpi_os_signal_semaphore+0x33/0x40
[    0.539700]  acpi_bus_check_add+0xc0/0x240
[    0.539700]  ? up+0x32/0x50
[    0.539700]  acpi_ns_walk_namespace+0xe4/0x196
[    0.539700]  ? acpi_add_single_object+0x670/0x670
[    0.539700]  ? acpi_add_single_object+0x670/0x670
[    0.539700]  acpi_walk_namespace+0x9c/0xd0
[    0.539700]  acpi_bus_scan+0x7f/0x90
[    0.539700]  acpi_scan_init+0x121/0x26f
[    0.539700]  acpi_init+0x2d9/0x339
[    0.539700]  ? acpi_sleep_proc_init+0x2a/0x2a
[    0.539700]  do_one_initcall+0x51/0x200
[    0.539700]  kernel_init_freeable+0x1ef/0x244
[    0.539700]  ? rest_init+0xe0/0xe0
[    0.539700]  kernel_init+0xe/0x110
[    0.539700]  ret_from_fork+0x22/0x30
[    0.539700] Modules linked in:
[    0.539707] ---[ end trace ad7eca24a28de399 ]---
[    0.541613] RIP: 0010:fortify_panic+0x13/0x15
[    0.543671] Code: 00 41 c7 47 34 00 00 00 00 5b 4c 89 f8 41 5c 41 5d 4=
1 5e
41 5f 5d c3 55 48 89 fe 48 c7 c7 70 6e 76 a6 48 89 e5 e8 19 db ff ff <0f>=
 0b 55
48 89 e5 53 89 f3 48 89 de e8 46 bb ac ff 48 39 c3 0f 94
[    0.543709] RSP: 0000:ffffc09280043b38 EFLAGS: 00010282
[    0.546283] RAX: 0000000000000022 RBX: ffff9be00037f200 RCX:
c0000000ffffdfff
[    0.547705] RDX: 0000000000000000 RSI: 00000000ffffdfff RDI:
ffffffffa70058ac
[    0.550900] RBP: ffffc09280043b38 R08: 0000000000000003 R09:
0000000000000001
[    0.551704] R10: ffffc09280043b10 R11: ffffc09280043900 R12:
ffff9be0002d4420
[    0.554852] R13: ffff9be00037f200 R14: ffffffffa6c437c8 R15:
ffff9be00089b800
[    0.555704] FS:  0000000000000000(0000) GS:ffff9be0bbc00000(0000)
knlGS:0000000000000000
[    0.559304] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.559704] CR2: 0000000000000000 CR3: 000000019040a001 CR4:
00000000003706f0
[    0.563106] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[    0.563704] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[    0.567006] Kernel panic - not syncing: Attempted to kill init!
exitcode=3D0x0000000b
[    0.567700] ---[ end Kernel panic - not syncing: Attempted to kill ini=
t!
exitcode=3D0x0000000b ]---


--------------ms020500060704040503000008
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
JTNkQWN0YWxpcyUyMFMucC5BLiUyZjAzMzU4NTIwOTY3LGMlM2RJVD9jZXJ0aWZpY2F0ZVJl
dm9jYXRpb25MaXN0O2JpbmFyeTA9oDugOYY3aHR0cDovL2NybDA1LmFjdGFsaXMuaXQvUmVw
b3NpdG9yeS9BVVRILVJPT1QvZ2V0TGFzdENSTDAdBgNVHQ4EFgQUvpepqoS/gL8QU30JMvnh
LjIbz3cwDgYDVR0PAQH/BAQDAgEGMA0GCSqGSIb3DQEBCwUAA4ICAQAmm+cbWQ10sxID6edV
94SAhc1CwzthHFfHpuYS30gisWUfWpgp43Dg1XzG2in3VGV7XrzCCGZh4JM/XQWp+4oxmyV4
2Qjz9vc8GRksgo6X2nYObPYZzQjda9wxsCB38i4G3H33w8lf9sFvl0xm4ZXZ2s2bF/PdqvrK
0ZgvF51+MoIPnli/wJBw3p72xbk5Sb1MneSO3tZ293WFzDmz7tuGU0PfytYUkG7O6annGqbU
1I6CA6QVKUqeFLPodSODAFqJ3pimKD0vX9MuuSa0QinH7CkiPtZMD0mpwwzIsnSs3qOOl60t
IZQOTc0I6lCe1LLhrz7Q75J6nNL9N5zVwZ1I3o2Lb8Dt7BA13VFuZvZIzapUGV83R7pmSVaj
1Bik1nJ/R393e6mwppsT140KDVLh4Oenywmp2VpBDuEj9RgICAO0sibv8n379LbO7ARa0kw9
y9pggFzN2PAX25b7w0n9m78kpv3z3vW65rs6wl7E8VEHNfv8+cnb81dxN3C51KElz+l31zch
FTurD5HFEpyEhzO/fMS5AkweRJIzwozxNs7OL/S/SVTpJLJL1ukZ1lnHHX0d3xCzRy/5HqfK
3uiG22LPB5+RjNDobPAjAz2BKMfkF/+v0pzn8mqqkopQaJzEAbLbMpgQYHRCjvrUxxwjJyUF
b2Z+40UNtMF4MTK7zTGCA/MwggPvAgEBMIGWMIGBMQswCQYDVQQGEwJJVDEQMA4GA1UECAwH
QmVyZ2FtbzEZMBcGA1UEBwwQUG9udGUgU2FuIFBpZXRybzEXMBUGA1UECgwOQWN0YWxpcyBT
LnAuQS4xLDAqBgNVBAMMI0FjdGFsaXMgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczAhBu
kmvE8GLB9+EYd88699DiMA0GCWCGSAFlAwQCAQUAoIICLTAYBgkqhkiG9w0BCQMxCwYJKoZI
hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMTAxMDUwODMxMzBaMC8GCSqGSIb3DQEJBDEiBCAq
wD+zI331TopUv5PiGjGfLoblDJowx2iBxdQ34mytvzBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCG
SAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqG
SIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGnBgkrBgEEAYI3EAQxgZkwgZYw
gYExCzAJBgNVBAYTAklUMRAwDgYDVQQIDAdCZXJnYW1vMRkwFwYDVQQHDBBQb250ZSBTYW4g
UGlldHJvMRcwFQYDVQQKDA5BY3RhbGlzIFMucC5BLjEsMCoGA1UEAwwjQWN0YWxpcyBDbGll
bnQgQXV0aGVudGljYXRpb24gQ0EgRzMCEG6Sa8TwYsH34Rh3zzr30OIwgakGCyqGSIb3DQEJ
EAILMYGZoIGWMIGBMQswCQYDVQQGEwJJVDEQMA4GA1UECAwHQmVyZ2FtbzEZMBcGA1UEBwwQ
UG9udGUgU2FuIFBpZXRybzEXMBUGA1UECgwOQWN0YWxpcyBTLnAuQS4xLDAqBgNVBAMMI0Fj
dGFsaXMgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczAhBukmvE8GLB9+EYd88699DiMA0G
CSqGSIb3DQEBAQUABIIBAMP2Eli17DKjmH4CufKHSVL4Fhmc7gynPp6i/uXKZ4FMD9qwWUqB
650lgYFLKbjOApRvc2X4yLK/Vy8cqIFxg1sZSZILTKQCnE6Iw8pLImbROi9aqOhupKZ8/vG+
wfXqH9yi6Br4TD4YjsXLAtWl/iP/SOKowkJ1DThRpnmKEVjAe/Ni9+R2Hha6s8L1X1CeCf+N
r3+A87HP/97tjaRzzcCz9Ln8/0SaFnX8WfbdG0IxcWmDE1RCENO8XbDojB3ibxqJC7DfUXOU
LLK6zsS38NRLACtbCP9y9C22ylQZaTmRccR5g+cgf92QIyIYie5rXwDSAuzoTgphS7TVjk6B
taAAAAAAAAA=

--------------ms020500060704040503000008--
