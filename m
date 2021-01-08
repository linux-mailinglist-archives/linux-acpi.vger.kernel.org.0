Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FF22EEDB3
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Jan 2021 08:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbhAHHHm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Jan 2021 02:07:42 -0500
Received: from mail-bn8nam12on2115.outbound.protection.outlook.com ([40.107.237.115]:25185
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726312AbhAHHHl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 8 Jan 2021 02:07:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NR69rZnhdKfiObeKcL0BAoPWMFvPN2oKmYjdGD/Y6Fp1en4+jdqbZCxlJt9zepG3ixoO5UIuX1nedDV2Pjmr1IIbFOc2MJQRLKYWGM0L48EKowfUU+DvFsxmWkDSRbpfbDSnaqfhtiiISbGl+4gDeIiL5Deh5SpFR33rAdWNS3eBgeMRchI+j1K8QGRVUw7pdeIC2EKvooc+nm+vcCOb7co4v5w7SlL4mYFtzUK5x+CeCsNlpa10y8Z7ZZCDuktWqGygFLHgLD59tFB4Rd4Po9uAzw50+RUnO8dOqgD76NNjYN2D41Lnl62vK4vIdEMrsNOIYdYLG7pByM3BBTlrgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/NCrnfYA6UqaqOgaQ3G9ASvs2M1VJ8AfBfD7BcYY3A=;
 b=TQ9i3cterWbzXJWV0GVYSwueNgHLljUbDn/mNmmxXgR4d/r1R0Q7qCjBEuDKLZo3T/SvH9CqsH8ubBuROHO0y3ueNGMF8+S/uLRGHwsZEUJWQC330fnScoASQOLU6nf/tzHtuKCDzzCQ5ryzSDmM7jylB6iNgUvgFC/Vv+vJ2Ed/E3lbLRHVcbzwVyFztm7qscPYfiuhsjyFjwIFHYfdw08FkdmlvSfoiJ+1npdjdSyFxAxzHdu7DkEIpyuNZRvpRAXKHC+yabz+m6BjvkGtpb7Sj0i/bIJ3Dny22nvJRnPaMFo53m80Q2f6wjEXIp4zU3CVKPKwKz13OC+IPEOTDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/NCrnfYA6UqaqOgaQ3G9ASvs2M1VJ8AfBfD7BcYY3A=;
 b=P3XaWxv2UJGaHSF0g0kNRXcw+4lKJ8R3eRbJlrPjQtmeS1TFzD0hxhTSVHYlVvTNkhJxUT5csEBuegh5RTf+Mdg3JKKXbsDvKG6BkTAWCBli9zvNRek9sHc2Ejd3U6XSjkRnV5uXQPxEVAatIyi8ure0tKvbvDnkwNV2YVTAyA0=
Received: from (2603:10b6:300:128::18) by
 MW2PR2101MB1050.namprd21.prod.outlook.com (2603:10b6:302:a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.0; Fri, 8 Jan
 2021 07:06:53 +0000
Received: from MWHPR21MB0798.namprd21.prod.outlook.com
 ([fe80::74c5:1aa5:e46f:8cb4]) by MWHPR21MB0798.namprd21.prod.outlook.com
 ([fe80::74c5:1aa5:e46f:8cb4%14]) with mapi id 15.20.3763.005; Fri, 8 Jan 2021
 07:06:53 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Michael Kelley <mikelley@microsoft.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH] ACPI: scan: Fix a Hyper-V Linux VM panic caused by buffer
 overflow
Thread-Topic: [PATCH] ACPI: scan: Fix a Hyper-V Linux VM panic caused by
 buffer overflow
Thread-Index: AQHW2GokQzlfi5P1IkaRrU4aFB3YlqoZpozAgAKf7QCAASCqQA==
Date:   Fri, 8 Jan 2021 07:06:53 +0000
Message-ID: <MWHPR21MB0798BBF5D452BBD9052350C1BFAE9@MWHPR21MB0798.namprd21.prod.outlook.com>
References: <20201218040826.57203-1-decui@microsoft.com>
 <MW2PR2101MB1052E61BEB80F14896EEFA79D7DF9@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <MW2PR2101MB181943C255A86A11E5402E50BFD19@MW2PR2101MB1819.namprd21.prod.outlook.com>
 <CAJZ5v0gXW0oEmduxZEc0BZWxfQd=+jh_r88OZAHmwCW=GFNBGg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gXW0oEmduxZEc0BZWxfQd=+jh_r88OZAHmwCW=GFNBGg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=380a94cf-4900-4c47-b864-3dc546c8459a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-08T07:00:44Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [73.140.237.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f421cae5-6c95-4da8-db7b-08d8b3a3fa43
x-ms-traffictypediagnostic: MW2PR2101MB1050:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB10501FCD274D1AA724BAAEDFBFAE9@MW2PR2101MB1050.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VbUWXoFEne7vxjzZ/QoFowkXt/RZszZ8jMoN5+XocNzwSPRiF3UneXz9QPNa023d7utCTqB1+ZcPO6ErstRznuZ9qHsjG3hBwaZjL/++5OQJ4TLbMDg79STq2FNp/iY1Mzmly+bGjFPdDbARxr+SW2b+VvohAbLza+42qkrupB5L06M8+ZkLGWG9FfLfYQ5oykZBzG79FeqwsmpKjOiA8kq/2L6wNjcgi0K7KcTtDvauIfCRgFB/K86XVljrZOfDw+omAfvQJ8DLcrM/kYRrVKRHdsaaIEouJ15epeoH1UqXzlObpQiXENAn0Jhdow/e5aEpAs1/Z6s6XYVHCesWaQdLF7UyFlAndD2FNAInpPH+sWEaTHaOP7gAYihmrNvqzD4JlJMqh+iw3yjbxZvecg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB0798.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(8676002)(66476007)(66556008)(76116006)(33656002)(66446008)(64756008)(478600001)(10290500003)(66946007)(71200400001)(2906002)(8990500004)(82960400001)(55016002)(26005)(5660300002)(8936002)(83380400001)(7696005)(107886003)(9686003)(86362001)(316002)(6506007)(82950400001)(4744005)(54906003)(4326008)(52536014)(6916009)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?4HJ9z9/MrmC73KptpGIc77aNeHPDvaPKsmVlcD25bKc289aaxCM30NnHIotm?=
 =?us-ascii?Q?qeRysIe8nCcPGJ4S8doMsH3+o8Md78Dfcukn3U7EkTRrG5GC4+f+pOOmbOGR?=
 =?us-ascii?Q?EEH4j3p3ms+cwUWz+rDUKzkwQvcUn39z7mztsS7CtwcPOtBpxtspiEc09VI0?=
 =?us-ascii?Q?tjqvE/XhTjwNcg1ZnJJUmosfTn+jHHWumV7uYh6NVz0JEZ8IZGAS7bYPAQa8?=
 =?us-ascii?Q?PYmpLSTotnVYEzcsSvVFz62VSfsML5onWwLHYmP8DcQBqwRGah8TD4kOXdja?=
 =?us-ascii?Q?lL9ba3jvdGeAwNCkHTHx+n+N5sMTL+1Eqf/Ajvg1zywYhhSgkXEBGRk+jkCu?=
 =?us-ascii?Q?r1s/r+E3sJZt4/tNhUrznplriZ447OxQ68DQ1bs3BXnY/ypg59f/xQAw0+FA?=
 =?us-ascii?Q?5OCg/+u6jAXyi9XCy5VfI9oLHIpbdUOKol9P3keTKqBtV+26I43YoqimXjE1?=
 =?us-ascii?Q?a9NvvTmddmhPYheFm+kf0UMuxGUQuu+GXzGLzacA4X/N6OhDesCWB+Vd9v4b?=
 =?us-ascii?Q?RysvVZSqGT160h+ji391eZHwg9zPNrfMBSBAHHP79AfBuCb3yUgG9QDn84Jw?=
 =?us-ascii?Q?SPuAbQJ9gh/lSkjpDXgQ5yr+21d8roSWFuG2uJQSVfiykaQelrdX4b/DoZpR?=
 =?us-ascii?Q?NF0AWIy9Gn2mfyzIY84Z1dUQulGuTftGdkt2ifOV+0qm2KfIhjzDe/7rJzlp?=
 =?us-ascii?Q?qEspbUT2NPivJV0iLkSNU7gOt9dIQuEHm1Nf5AfkoxcS8irCLVEt2kuOQ822?=
 =?us-ascii?Q?V1M5WWuJcroDkG9+DGbuUzPCVdvNezg9RvhAnaB7djKzqGoM4uXu3nnXMMDC?=
 =?us-ascii?Q?tL44gkOelbPVwS5cGuNLxy4FHQhi9B5p3e5VyWoKfPl7y6IqM0lMZbSolFct?=
 =?us-ascii?Q?M0BO5/2FDc/aO++eeaxoyvpIwsBegDKhCBZE2CMPfTs6+JolS1SZKM2kjYvH?=
 =?us-ascii?Q?ltuRWzKpZE36G7/IFEB+sX/JKI7kw2xLTV+eFiapaqI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB0798.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f421cae5-6c95-4da8-db7b-08d8b3a3fa43
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2021 07:06:53.1398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sSjOFIrC08HgqLiBiI3Pu72KtaDlB2UT9SnhXKy2sstrtSdxi2wM0quGcezs69Cp463b1tE3fYocc1GYNHQK4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1050
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> From: Rafael J. Wysocki <rafael@kernel.org>
> Sent: Thursday, January 7, 2021 5:48 AM
> > > > Linux VM on Hyper-V crashes with the latest mainline:
> > > > ...
> The root cause is a VM issue AFAICS, though.

Yes.
=20
> It doesn't look like the right fix to me, though.
>=20
> The problem appears to be that the string coming from _HID is too long
> (which is a spec violation).=20

Yes. We have requested Hyper-V team to fix the buggy BIOS/firmware,
but we have to cope with the existing buggy Hyper-V hosts, at least
before the Hyper-V fix is deployed to the hosts, and some old versions
of the hosts may not get updated. :-(

> The patch truncates it to match the
> length of the target buffer, but that is not particularly useful.
>=20
> It would be better to use something like kstrdup_const() to initialize
> acpi_device_bus_id->bus_id IMV.

Makes sense. I'll submit v2 shortly.

Thanks,
-- Dexuan
