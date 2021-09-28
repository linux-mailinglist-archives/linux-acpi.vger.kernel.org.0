Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91EDD41A40E
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Sep 2021 02:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238255AbhI1AMR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Sep 2021 20:12:17 -0400
Received: from mail-mw2nam10on2069.outbound.protection.outlook.com ([40.107.94.69]:59744
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238253AbhI1AMR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 27 Sep 2021 20:12:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlDsczoc5YKd2R1nEwH1yLA1LXU2QetaAw37kysuNdD8yzYnQmzn7p6LkwEc7/LNrcJc2vgn0kTMiafG8x39rlH9cqUB9BxFFUQ3m6OlUaypkV2dMSWWnm8xFOBo3SmN68u+4JxwaDtT0vG0pe0Fh8uvn2x7dp5BIPE6Od9tnZoijV78/lwy5jdcsO0aNIIyAGmk658RfZ/m3ziBtPHd2lmXWk8/vIQpc/Fg6TIKZOlmTvwkCQAmXfl/XOKj8ErMxDd3mRMvE20N4y2pUwtBrRqUZQnsjgEtEVdCjySSQIn3cLX7J5coSyAuG+l9EMZv0LBc3NWD5Ol2jsMWEvqDrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fHJg4Lxweb6rP/uyqF5+24+iYcEEjCtgm4qJNo9gZZE=;
 b=EhBkWHISJpBTPP5TSVSzb2GA2nXszdD5Zy9EnNpl8dmd961E0oQUb8tuyhO3TSuhhGmahfju1PHxuuiJhxKk8zaDYDCf+CW7tVBgZawT72KhPewU3WM6AQdzlOQImeDn65mQtnsxR1ifWiusQ1byH2/8HZMv+EtZ0yk1LZhUB5BNNgd9nWnPlQ2atFlMfJE+lLMkrfOqqdh7b4BCMMKyK1v0BvYp4S/6wCyD5z0YqnbJtTykrqDye6U2e96RiTi3U1b/UBwuicBxkV1J+8vKziKCgUDWcSUV/frQisKEcXUGD9HPju/dQXNgL7j1dKah0hsXb6bIfFW6Udce67j9IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csun.edu; dmarc=pass action=none header.from=csun.edu;
 dkim=pass header.d=csun.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mycsunemail.onmicrosoft.com; s=selector1-mycsunemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHJg4Lxweb6rP/uyqF5+24+iYcEEjCtgm4qJNo9gZZE=;
 b=jqFfJ11XBwGuLy6U+HelGT4FEA7jp2vzgEEB9GQEBHz61kIqjkSJ4UFdrHcaVRF7C8qdm/GUqXQ8ozCJ91yhcAMKGVYXgSiQIlCz5Key+eBDTQbdVMO0WjiC/MAJasUKViWC5Ay+dVDCTzlRKtryF/eVzHjW4XD0och5+3G6RmF/yvPDH8+7ziuv8BZYJYvL6tEqBw/B00NFYsNFmAwSgfikU1HM0Mvmpo7kQp1o+q/W61nfESO0y+bL9A6XrYRg7mbhnoDHFmox83YVOZjEK+CpgWFc7xaU2dHhHWGchgmVulCUA+pFJbhtl2C44hJVEPaABx/wIUzx1NanS/xQBQ==
Received: from BYAPR07MB5816.namprd07.prod.outlook.com (2603:10b6:a03:13d::28)
 by BYAPR07MB5720.namprd07.prod.outlook.com (2603:10b6:a03:a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Tue, 28 Sep
 2021 00:10:35 +0000
Received: from BYAPR07MB5816.namprd07.prod.outlook.com
 ([fe80::3c31:c16d:bed1:9ce0]) by BYAPR07MB5816.namprd07.prod.outlook.com
 ([fe80::3c31:c16d:bed1:9ce0%6]) with mapi id 15.20.4544.021; Tue, 28 Sep 2021
 00:10:35 +0000
From:   "Wiegley, Jeffrey" <jeffw@csun.edu>
To:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Fix for BL460c G9 ACPI BIOS (V2.80) to see NX2 network interfaces?
Thread-Topic: Fix for BL460c G9 ACPI BIOS (V2.80) to see NX2 network
 interfaces?
Thread-Index: Adez/UAH9r9GZK5YSNGPpQbG75Twqg==
Date:   Tue, 28 Sep 2021 00:10:35 +0000
Message-ID: <BYAPR07MB58160361619C9E235947B743D3A89@BYAPR07MB5816.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=csun.edu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00e32c36-1efe-4b63-c9cc-08d9821464fd
x-ms-traffictypediagnostic: BYAPR07MB5720:
x-microsoft-antispam-prvs: <BYAPR07MB5720FF8F79CF85A20080FC19D3A89@BYAPR07MB5720.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sno1p2RIasA52p7s62eUT6ytafVKPDr44ficbCB4wKwmRf6kTsXcpIZH65LiHy5qrkNc+IAExg0eq58PlH2FcYJyXRwoJCEMbrGMX04MLIED+lPsb/2ctGTmrSv7llNrX57vjZ2X5oOkzEje5SjKffffG+kvaCHo0zqmzznFc4H3nudwlFSlJ9iNA3+01NMtdlXGN72YLiSZhu6pnyCQHMSCiElYIlX1DcLQHWlom97HV9WDiBGg0ywu2hTAdRsBYmFx5NhCOwcKTNYOfhp9wUyCAvZOV/uCcvpJ2v7MJqM6kDSDBHqh/4BCIEjQVGIVfki8W307To3rWwdun1bA2tZqqM1g44rOaRHqI1bA4UdWpI0FHQzceb39o/xZq01uqG1GA/6gG/lLJSMESFHOQnLdh5IpLRcgoYsioZvS036yBAqR5sxi1W7eNIhf9JKbV5fSpcrRJyI8yznBhXZH9kK9jecF2fjUkMTa8KBa1vpR8g50hXSOMF3b0wCtkL7olguE42IqJwCytAHzQIgqmwVAyclCGxtf+onWKfrqt6OIeupbOGFvZJLXZ91GynF+YR/HHE+62/tWRTXSLK0/w6bO85mZV3aw0MjZtKF89GBPFn1jdF26eEIBrPgveHkJQcE0eSkdPrWkMmV9JXdpvfBtslPCpdq9lMgMya0YMVvZ+Onr+Y+A/HzcAOOJz3PAs8yQ9UMy6qxqrTL5Vih/bQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5816.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(76116006)(66556008)(38070700005)(66476007)(9686003)(66446008)(64756008)(66946007)(86362001)(55016002)(316002)(186003)(52536014)(8676002)(508600001)(5660300002)(38100700002)(122000001)(33656002)(83380400001)(8936002)(71200400001)(6506007)(75432002)(7696005)(26005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CjHPzpOW6PRLsdqDWuKMGCZ1Yz7XsdVa6aRPwOKpL+SgBEgwmsUF/e8uK9EE?=
 =?us-ascii?Q?u2x1Akrprzi28f0xyfq0daz/KA7eDBT6dHuaBuzhbv3frnSR4YVyRkha5AwJ?=
 =?us-ascii?Q?kBt6/0bt3H5767dnmeie8OTUKYCKYu5j9jdw5M0WgU/qmmFky439O6fG12bq?=
 =?us-ascii?Q?W/vlvj/ul+xrDE+YWFzYdAZTrlt4VYXqGGf4lNJcCONqVMqGL0rNrZAoq0Vz?=
 =?us-ascii?Q?vkVmdOv+D9rHqLO9LUZT9QbuPwg/byTN18+kpI4FzRU9gnRv1Xe8bXJwHn4Q?=
 =?us-ascii?Q?CY6wh8GDfl4x6QeF+AqRuLMHngLupE5HKxs4d8gSHa4YIsjUuNkrauC1QH+4?=
 =?us-ascii?Q?MHO3G2CBIgbumFBhJo9djtRF50Ht7nI+ETp1mGW2p8i7I8WvwB/8SRq9yNok?=
 =?us-ascii?Q?7aC7VFFiefbi5js3S6+Too4woTpEyPPpufc9kCz9KQpc2udFZAgrlnEjgHPx?=
 =?us-ascii?Q?ZwHXN0TRXNY1rouHDQcmRdVsOayRq5CrmVOQ7W/PR3VJmFKeyWvtIMnKFeFM?=
 =?us-ascii?Q?jKEHTMFVtbwpUMu83ZMJ1bCFfCHWskXGu2afNzBgYkYwn2E2iBfGQ5fa8weM?=
 =?us-ascii?Q?Nknva71eG5ff+TsgEkT7ChPpLlLV8xRctYHieKhgwT8YFt2cpxS0s4P6pZnp?=
 =?us-ascii?Q?XPEbVY4Qm9a1SzRYbFk8ZSK9C/6XjuxFynqwr1KHnXFIMJxxcpuTd0e5Rfdz?=
 =?us-ascii?Q?8SjTN6HzBd4RpQY8OF+HmjaS/Aq++O+DlfCwlydWnwmlbwV6RbLeOiwmoOHe?=
 =?us-ascii?Q?Kf6K7mfmtF+3MjHqzjHonxKTpzoFEWUdeGo2km8wAhKh+AgriLdzSE++gAeB?=
 =?us-ascii?Q?0W/2aKEGbTKdPOULhqP/4Ox7M78VKeUhZz/cciNVTlqMZjRzugjuBpvVkGlr?=
 =?us-ascii?Q?8ThLso8GrrzshmISwy4XDrnbeX+TqQicXM57Mtia3xC+ir+45kT6K6vR0oIs?=
 =?us-ascii?Q?X6GShWVzEbA7sUzv35aEwcZdAt0orlozOwENgEoQTtLVhs8LhoMXSsrnPJ62?=
 =?us-ascii?Q?tMUDBxrD/JA48KX402vcQsf9phQTYfPEHMADbtKbQ5OfsL7t98OMYJjGMS5l?=
 =?us-ascii?Q?ThpGbja3SeuuRwVkJtrwdmN5Xl3KsnBbAngHjS9uG14l/l+ZZJHmKI73gJvd?=
 =?us-ascii?Q?d1ZB+pu6JiZ7qj5xHKrtHpmng0YUcYhHFyzxMRCHTvO31QSxtoW/fgapo3jb?=
 =?us-ascii?Q?BtGNdO8gvLF++W6ntWVYolD00gqwXSQ2DHp9Sj9A3g3HNXXxLP12G8DRiUcA?=
 =?us-ascii?Q?OR0RhTsXchSlYWzzEkzE8+L4FLq5tVgFYiIKQfCbeJW2rPuAvro56HgcMR2S?=
 =?us-ascii?Q?0bMip7jzwNRANpii5hmIRiA2?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: csun.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5816.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e32c36-1efe-4b63-c9cc-08d9821464fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2021 00:10:35.3197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ff15522-6096-47dc-89bf-389bbe13cd68
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0gcjIJJtuExeltDEVDRxd8wQwb9+z+ODoBGhvx5q6fWsnx+WWMAI1+9xH30fGMqr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5720
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

I have a couple of HP BL460c blade servers. I can't get Ubuntu 21.10 instal=
led on them
(as well as other versions) because the network interfaces from the QLogic =
BCM57840
devices don't show up.

During boot dmesg | grep bnx2x shows:
root@hp9b:~# dmesg | grep bnx2x
[    6.719454] bnx2x 0000:06:00.0: msix capability found
[    6.812918] bnx2x 0000:06:00.0: part number 0-0-0-0
[    7.123370] bnx2x: probe of 0000:06:00.0 failed with error -22    [<<<<<=
----- That has me worried most]
[    7.174829] bnx2x 0000:06:00.1: msix capability found
[    7.305138] bnx2x 0000:06:00.1: part number 0-0-0-0
[    7.539580] bnx2x: probe of 0000:06:00.1 failed with error -22

The only thing I've been able to discover is that if I add "acpi=3Doff" to =
the kernel parameters then I get
root@hp9b:~# dmesg | grep bnx2x
[    5.026485] bnx2x 0000:06:00.0: msix capability found
[    5.053567] bnx2x 0000:06:00.0: can't find IRQ for PCI INT A; please try=
 using pci=3Dbiosirq
[    5.053614] bnx2x 0000:06:00.0: part number 0-0-0-0
[    5.780072] bnx2x 0000:06:00.0: 63.008 Gb/s available PCIe bandwidth (8.=
0 GT/s PCIe x8 link)
[    5.822507] bnx2x 0000:06:00.1: msix capability found
[    5.824372] bnx2x 0000:06:00.1: can't find IRQ for PCI INT B; please try=
 using pci=3Dbiosirq
[    5.826283] bnx2x 0000:06:00.1: part number 0-0-0-0
[    6.395996] bnx2x 0000:06:00.1: 63.008 Gb/s available PCIe bandwidth (8.=
0 GT/s PCIe x8 link)
[    6.435953] bnx2x 0000:06:00.0 eno49: renamed from eth0
[    6.548078] bnx2x 0000:06:00.1 eno50: renamed from eth1
[   17.788962] bnx2x 0000:06:00.1 eno50: using MSI-X  IRQs: sp 36  fp[0] 38=
 ... fp[0] 38
[   18.427262] bnx2x 0000:06:00.1 eno50: NIC Link is Up, 10000 Mbps full du=
plex, Flow control: ON - receive & transmit
[   18.593587] bnx2x 0000:06:00.0 eno49: using MSI-X  IRQs: sp 33  fp[0] 35=
 ... fp[0] 35
[   19.195314] bnx2x 0000:06:00.0 eno49: NIC Link is Up, 10000 Mbps full du=
plex, Flow control: ON - receive & transmit

Except this is not really a solution because now... Only one of the 16 CPU =
cores is detected/enumerated.
So that kind of isn't acceptable for what is supposed to be a virtualizatio=
n server.

root@hp9b:~# lspci | grep -i ethernet
06:00.0 Ethernet controller: Broadcom Inc. and subsidiaries BCM57840 NetXtr=
eme II 10/20-Gigabit Ethernet (rev 11)
06:00.1 Ethernet controller: Broadcom Inc. and subsidiaries BCM57840 NetXtr=
eme II 10/20-Gigabit Ethernet (rev 11)

The BIOS for the BL460c is already updated to the 2021.05 SPP and is at v2.=
80. The networking device's firmware is
also up to date at v7.18.77 (from the same 2021.05 SPP).

Does anyone know how to get one of these things working correctly? Other th=
an somehow magically getting HP
to start producing non-buggy BOS firmware. Is this a known bug/problem or a=
 different kernel parameter I can
specify to get it working but not disable the enumeration of CPUs? Sorry if=
 linux-acpi is the wrong forum. I could see
it being a network driver problem too. But since disabling ACPI at least hi=
d the problem I figure ACPI is messed up.

Thanks,
Jeff
