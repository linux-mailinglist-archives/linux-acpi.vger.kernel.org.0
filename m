Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2482EFD51
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Jan 2021 04:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbhAIDLC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Jan 2021 22:11:02 -0500
Received: from mail-dm6nam11on2113.outbound.protection.outlook.com ([40.107.223.113]:33822
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725836AbhAIDLC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 8 Jan 2021 22:11:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PefeCaoxe+H9GZcWshp7KTaAZo4lCTaUeNSTVNhklzS4G7Axr7W2oYZFF1hVzkdKF+qKlriTpPbQFp+epHHJIsOLLSsqVw6tM5bIF4CWCyhg4fnNWHq2EMol9Nt+XHV1rrwkjXNNi6ojWsjqTfF5icJpn4XAjofn74hWq6CC9uClMPGvygMSBw/juLmZTmCYGvq2kA8WlhPsqp2cAox2ka5BprwlqlyykXPOt11pYx6fzbOO06t7J6+zewNo60gFrixdr8KgcNuMWOBb6dFWnWGDNbMWitTSEuTGfertpU61XHLg1Q/qyRiCfKN8OE0JeuWTSFIKPbdImxqQMPtBsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mge6mZ5BxNGL708h6xa9Jr6ju2HWqmcs/mmrFlO+JxY=;
 b=PrB5gYfc73drt7WHcA++L1P5W/O+ZdecOar/mDwTeN97DfNjiSMZcZ8WmmNzvbHK0wgEm/TynScJx/EZa2T6bC+lil9unM1eJK+sgOdbpzUGLX2J8xQtPyPmKXJZOpNutwUi1M80RxkDBznG/awr+YPsAuusPTrJR6fUF3ndaDm+0kOJICLlW7qAJByeJcJIJ4R3r/lJFbfjTyRpSxsb0nSaXFCkuT/buEX1y6hRTP787Pu4VN8PlVxvVPyN9CT1ta/Srm2c37VkeAFIAVy3t+8FHbjlBQoUGwx6h6FSe5BhBSyy1+SoanKxZThWJy6TbJh8rX18ayn05H9nO3Yy4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mge6mZ5BxNGL708h6xa9Jr6ju2HWqmcs/mmrFlO+JxY=;
 b=WqIaGCVyqa8e5hpW/YrFb0uv7nFzoQt3g0DjlpxV0VSPspFoxvJCvLh+vwp9RwX9vridn22kKQ6ZbALrsxQZN6X94Q52M0rtTQ+1vzBFJS0qzzUjw91aChfrChpxsoyMMoqHAFSuUkjUZZcGpG9DrpuM8SDuvirscrRG+6zNtlc=
Received: from (2603:10b6:300:128::18) by
 MWHPR21MB0191.namprd21.prod.outlook.com (2603:10b6:300:79::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.0; Sat, 9 Jan 2021 03:10:05 +0000
Received: from MWHPR21MB0798.namprd21.prod.outlook.com
 ([fe80::74c5:1aa5:e46f:8cb4]) by MWHPR21MB0798.namprd21.prod.outlook.com
 ([fe80::74c5:1aa5:e46f:8cb4%14]) with mapi id 15.20.3763.007; Sat, 9 Jan 2021
 03:10:05 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>
Subject: RE: [PATCH v2] ACPI: scan: Fix a Hyper-V Linux VM panic caused by
 buffer overflow
Thread-Topic: [PATCH v2] ACPI: scan: Fix a Hyper-V Linux VM panic caused by
 buffer overflow
Thread-Index: AQHW5Y9DoP/1GXp3uE+7wQPdQBcnaKoenHFQ
Date:   Sat, 9 Jan 2021 03:10:05 +0000
Message-ID: <MWHPR21MB0798B23AD969666FCDAD5095BFAD9@MWHPR21MB0798.namprd21.prod.outlook.com>
References: <20210108072348.34091-1-decui@microsoft.com>
In-Reply-To: <20210108072348.34091-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1bf73e76-964f-4bbf-ac26-f157d6553093;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-09T03:01:52Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [73.140.237.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 821faf62-642c-465d-5657-08d8b44c103b
x-ms-traffictypediagnostic: MWHPR21MB0191:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB01911B0A7F7062D01E4F2614BFAD9@MWHPR21MB0191.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6xgW6MdGnlgraG21IFCW6vq4VKM8TRdZwL66TZlgebm2dxiHbd+/OKkOcJaiQYNmtmzmvgxCPGMWJvnhV7+Qi2havUJxYtLJrC1w3nWdeSZlhO9D94up1CQo+ok2zZId1wUxb9OTJH/9RGDBu+hUXYGkgIBgqbXfumm17mzO/XPNP5KDVNfRlhbKBjcagtCM6eN83ivtRKSgUPxDyU02aRXL6veCNiLi47cFV5jBsFsCBqTakcX9Mcl92JOsfcz7HXCZil97mx8xoemSEWO8RzjHo8jGRaksPjMrjwTXmLtjMxcEermn724SwyY2BVDlxoWA99WZrfmNYh8/mjQ6MoeeTJn5gPgrYT6r7+2CDEYZPCr1Q0qw3aYzl0OP8QBg0hgeVJbT5g+MGV8LCtGHtFB/SSdbb75DrsvBHQHIpWafNVNtxdnxru9g1asGWsdTpTU6cCjefJDQ+vJBiwgxAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB0798.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(7696005)(8676002)(33656002)(110136005)(4744005)(52536014)(76116006)(66476007)(66556008)(64756008)(66446008)(66946007)(54906003)(5660300002)(26005)(8936002)(478600001)(8990500004)(82950400001)(82960400001)(4326008)(316002)(86362001)(6506007)(186003)(9686003)(966005)(10290500003)(55016002)(2906002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5hpFBhYH3CL+5oqwPRmhZaOSoHFIBf2t7fhmNmYdK6vNSP6h/LBDql5njcIi?=
 =?us-ascii?Q?gwGMnAJuTSwpHABBuLaKAhgQMTisK7Fg/+PVSSebJMa0QdUeoiJ+xTlmnwgJ?=
 =?us-ascii?Q?ENMmv9sIC54T846K0TsM4dgcuf5ogfNWqTqAM9wgDQlJnWQMYQ3g3ligIKI4?=
 =?us-ascii?Q?qCMvkufABJvHJodX2mucrCSvyjoL+NsFbJIgzewqKveSIz/E63TF56Yf5eM4?=
 =?us-ascii?Q?jIrF92bQgVekPvTTo7UY7+8cT0tBbiaSoZpWBofh/iS0+h2SiNo+l4CZM+0l?=
 =?us-ascii?Q?goFj+FCA/ZpnacsRzMCLJb1/dW1uuGeZgmkN1PVu5kiWme86gTFlq+jGQivC?=
 =?us-ascii?Q?s/+Me5RQd9BIRocxGbWZ03nmRrJwpiyri4OQ0tMVBX5PRyLJA3qsVGH8aRcW?=
 =?us-ascii?Q?VrgWFjhYNASCjiOe8EWl7CEU167fX9+GiahuNrSeLeEBM2Q/QBavgfp8J0v/?=
 =?us-ascii?Q?zglAlUhwA5JU22eMBY2IzLKM8SKXOwnP4SosYeOsBjXRcUmYgiWSjbVqoH+D?=
 =?us-ascii?Q?zG25IYczGvEFRoVJjgslyL78IDBSfK2kk8df4C8VSw4yNHJYCspL3DGoYq8K?=
 =?us-ascii?Q?sqKIVsuyKShEH6AAYvAKPf73ld37m/7Vw2gEqxIGPMJfoInIh/+zKRfYB+IJ?=
 =?us-ascii?Q?YY+9FXuHKtqWtXoYCwfwqZtGKoKObMm0OKWtfzV9OMb0OERz/XOQqTowV7TV?=
 =?us-ascii?Q?KMmZGwniRovX6nDUHJ5iytePAD3SQOI3BzzmW90hi5mXcgUkAzgNyahWgE2X?=
 =?us-ascii?Q?e7/PhS/1Tdwawx6hxVixrqK2CL80J6qiy4jMJAg6pKlceg1qHMEkcEjJc/Vt?=
 =?us-ascii?Q?6Tdm6//dtf/BVt5P/+KAdVcfdYRh/ce67mSEvya6zkcAj+Nucx9Szog8VnTm?=
 =?us-ascii?Q?Rmu3EQ1bdN0mq3yUygd0l5/UUBzngdpBmfg1XAmKdjK12KLvC7hg2Yuy/Uhh?=
 =?us-ascii?Q?hOaAlL/9DNxiRKcJbKrtcQoklxpdlh8gMSICI80Ir8A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB0798.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 821faf62-642c-465d-5657-08d8b44c103b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2021 03:10:05.4504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OodfvEZgQa2rJDtt6XouMSsBAkx2Fsgip9VOnOk+jKSwI/YN1qpSFwj3XuyW1vlF9T3xmbBhraLVNvEbbKetCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0191
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> From: Dexuan Cui <decui@microsoft.com>
> Sent: Thursday, January 7, 2021 11:24 PM
> ...
> Linux VM on Hyper-V crashes with the latest mainline:
> ...
>=20
> Changes in v2:
>     strlcpy -> kstrdup_const. Thanks Rafael J. Wysocki!
>     Change commit log accordingly.

Hi Rafael, Len, and all,
Can you please take a look at the v2 patch?

The Linux mainline has been broken for several weeks when it
runs as a guest on Hyper-V, so we'd like this to be fixed ASAP,
as more people are being affected, e.g.
https://bugzilla.kernel.org/show_bug.cgi?id=3D210449

Thanks,
-- Dexuan
