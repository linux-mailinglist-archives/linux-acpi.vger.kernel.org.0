Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422CF316C04
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Feb 2021 18:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbhBJRDr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Feb 2021 12:03:47 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14568 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbhBJRDp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Feb 2021 12:03:45 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B602411c80001>; Wed, 10 Feb 2021 09:03:04 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Feb
 2021 17:03:03 +0000
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Feb
 2021 17:02:28 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.57) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 10 Feb 2021 17:02:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYAQVHaSU+s9ANk3MoScCU43WNQv+nZU3yz/p5RwIc+1IHZwBVRXYF+3IO64YAW4vZ4kpqEPIKM1vAqkfKTEN0Z4oMdXbC6Nz3XDEjUxEHmkle0J1wh4djbDrLizt5WSXMdQ7+Zs138emO4W2B2lcquDm+vd5ki83miXJGNKxfW3zJ9tX+qumz0iQHKmRFSaYoujB4ABWTNyDveasuA+qidwreaSggNuiAmVPHwzqUsELFbuFqXsOOFdBtqCAgzXBUcgqo721H8XYJhtWnwaDP94Ji9ryMxp7au4ZhNVZvLdvNA/pyeDys/zExJZQVqLiAF9hkQNTYbTtx4WSEYalA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E37qn+qMy+qVbVksx0bmpSipWTtEMxQKtPV7A6e7sDU=;
 b=ZT0l3bOyxUkWqkIBIR58mQ7yhGzXJE1HA8Xk833HrllYgc95W9+yvml1mb1NALo+DF7EOH3axrPtHrLCqXbCcOIm0m8gJY+JGkIv03A1nmyk3GOj+LFNWB7nLnuXKDFlTVKyYwAe8HjU6qrVAdd2an9MLSKXKmeAYcWTenC63lQryLDiOBy5THTyu+Gv08xgYBCoXOSPTTMfA3AjFFMkiHkPj5NcINEVx1wEEZHmoVNarTNBSVk+MBDDw1lQLHZac2b43nUYjIbWNULAM65agLPSJ4WhYNrdnIaVPvx7nwhkwKQ8mTdvWJmfeEYmBi9NESCHOCf5EkTEHfbAR5DYuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BL0PR12MB2532.namprd12.prod.outlook.com (2603:10b6:207:4a::20)
 by BL0PR12MB4737.namprd12.prod.outlook.com (2603:10b6:208:8d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Wed, 10 Feb
 2021 17:02:25 +0000
Received: from BL0PR12MB2532.namprd12.prod.outlook.com
 ([fe80::70f2:ec2c:f43b:927a]) by BL0PR12MB2532.namprd12.prod.outlook.com
 ([fe80::70f2:ec2c:f43b:927a%4]) with mapi id 15.20.3846.027; Wed, 10 Feb 2021
 17:02:25 +0000
From:   Vikram Sethi <vsethi@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC:     "Natu, Mahesh" <mahesh.natu@intel.com>,
        Chet R Douglas <chet.r.douglas@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Vishal L Verma" <vishal.l.verma@intel.com>
Subject: RE: [RFC] ACPI Code First ECR: Generic Target
Thread-Topic: [RFC] ACPI Code First ECR: Generic Target
Thread-Index: AQHW/2DyadUHSm+TsEGosbjlKg4aSapRnLVw
Date:   Wed, 10 Feb 2021 17:02:25 +0000
Message-ID: <BL0PR12MB2532C769A507F8AB5B40D2BEBD8D9@BL0PR12MB2532.namprd12.prod.outlook.com>
References: <CAPcyv4gmd_cygXK0PpGkXmJLC3_ctEpRvpi5P-QcuXusFX5oNQ@mail.gmail.com>
In-Reply-To: <CAPcyv4gmd_cygXK0PpGkXmJLC3_ctEpRvpi5P-QcuXusFX5oNQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=vsethi@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2021-02-10T17:02:23.5410193Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=e737b242-5b9e-410d-ab82-b76c3b9e5625;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [12.97.180.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b93ab76-fff6-47c8-0a5c-08d8cde5a3fe
x-ms-traffictypediagnostic: BL0PR12MB4737:
x-microsoft-antispam-prvs: <BL0PR12MB4737C394D88E80B1DB0E1A29BD8D9@BL0PR12MB4737.namprd12.prod.outlook.com>
x-header: ProcessedBy-CMR-outbound
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jar+zVN9UDMSarOuGZUXMWJnDA8l8diOsmtMkCMAnYNz/cQlW14w0AGS7KSgV9x2Av7uwiRfWKLGjPq4WlcgOdYhYkET8dig1xoPEhc/h0scmCQG9gbm4sXx57ob0kzAVFASMD9doy81Y/sgxDCTJshUpEjKR0Y2QpNG6O15Mj7c5/zIuFvcEetycmaYWAFLTfub7pjf798Rg4fJAmiX71lUhXGBr/by/cjSsoxAJrFEaFOyW5ZZGKj6wGv6/eFkOHPHXpFx7c2fBVKt4R0tDviT075tckJTc/GFXPDGg5lVIniqXiKztLU5Jx7dzGYOcSNjY6pfxjORvJQBX1hkrh5N5i5Su2tvzU8bspe6XHZv9Ba7Pfi2H/K8FKULs4KPF5iDrSp66j6fISkTFeBRCRASFXzr5t5nibibzCRDyXxdAQkpw4sarpykOzgaHkZROgGXsoTmZhyAs6b70r+P3NA5uA7NsaeVnygVwjK6vwylpHsrCsaIP6MQWda1yxX6Y8Z/nY1EQkc3dMvoDSyJlIJxdB5RWxnWZ+sJdirLS6g2CjtRpVS6pjdPmljdOARd5zj2CZSij8tXbxXiFh5VcvwEcpEmy88tOxvDd/0HfPcY+SKKzlKxYKmKMXEQZkMKx1NSDFM3KmhJX1oligg7/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2532.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(71200400001)(4326008)(8676002)(2906002)(66446008)(64756008)(66556008)(54906003)(66476007)(52536014)(6506007)(53546011)(33656002)(110136005)(76116006)(83380400001)(7696005)(478600001)(5660300002)(26005)(86362001)(8936002)(9686003)(66946007)(316002)(55016002)(186003)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cnA0NEtUUE9zK0ZxS1hyRmNmUTU4UE5ZQjhNNzF2TmFVdVY3QkI1QzdLWnVF?=
 =?utf-8?B?eWFHbldERkJzR3o4dkJlZEpzRVNNQnhpdGVKUjhTUW1aWlNmdzY4WC81TG1p?=
 =?utf-8?B?ek51SStaNkxIdjN0VVBxMjQ2YW80MUxrV1NyaFIvamRST0o3ckRzQXkyajJ1?=
 =?utf-8?B?c3ZKVFRvM2lzSVcrcUNyckJxbnA0Znp6MURHRFNJQmg4T21WUy84eDBxTkhr?=
 =?utf-8?B?dHplUWx0Q0hoS3JOK3AzZ0hGZzVIRHBHNmIvS0tzNU5wVUlkTDROUXNjTlNa?=
 =?utf-8?B?R0QvY2hCcTBjSkdFd29EdFQwNGZwQUV3R2JMQUR2c21MbW5JQWRhNG9uZkpP?=
 =?utf-8?B?aThyN0J6ek9OUGFCQSt3S3FSdWpMcWlTY05EdWcxanl1U2lVT01RdG9iblNB?=
 =?utf-8?B?Ykx4VjZoTE1WK3BGUFEzczJoelpyUytDaGZQTzdTQ1BPQjlmZk00aHBGejhE?=
 =?utf-8?B?OTZyU3FtRTBMdHZUQ1R6WTJGVGZYOWxLTFhMTkJaemxQZnpNVkk0bG9NM3VS?=
 =?utf-8?B?cEVsTS9PSTFaVTk1Rm1FcGUvd0VEWXZIc2FEKy9FUnZ6RjZKSDFXWk5jTDQw?=
 =?utf-8?B?NEJSUCt2WDJNZU04djZUTllKM01iTUE4cEFURGlCNGU0VnNTZVZHaERoMHBa?=
 =?utf-8?B?NkV0azdJY0M2ZXFVZmM2QWxnYUtHdWRBZzN3WFpTRm1aajBxd05JajIrbW5m?=
 =?utf-8?B?eVJMUTUzdWxBR0ttSW5jYXYwOFlqbm5PcTRTNVRCdWc5Vk1CY2VsQjkxNkVk?=
 =?utf-8?B?d3RxOVp2Wlh0MTdmTGtxV25waTdHalk3M25RSnBYVUQxK0VsL3pEWURNcXBx?=
 =?utf-8?B?VE02YTByeDVNYmFYeHhyUjVkbVo3L2Q4VlgxSWhhYzZoRnE0eVVrY1MxMW0x?=
 =?utf-8?B?Ui8vdVdRRlkzUzlWWjFzWUpyNkxuSis1NkxaRHI2WjZjeFlHSUwwTEU4UFJ5?=
 =?utf-8?B?NVZrdXRkamp2ZkN0blp3d2swbTRoTnZaVkdHNGdPbkxWeG5HdW5WbXhtWTdL?=
 =?utf-8?B?YTBPYm1ZSU4wQTVkR2NpbWswdUlUM0l6VUg5YndCNEFlWWhKN1h2QjM1alFj?=
 =?utf-8?B?czVJdzl1WmVUc0JIS0ZWdFZzOTNnemwzU1BEQVM3MDJ3a1ROZzZEbFZKRjU3?=
 =?utf-8?B?VTEyT0JQNnJCdXd5d3ArUjNETk5wQnZvOFVtclVkNlYycXdvbE0wNVZteTJO?=
 =?utf-8?B?UlFPV1oyNXFGTmVwR3JKNzErSkZ2NWJMNDZQRSthK3lVL1ozaHlZc1dRQzRV?=
 =?utf-8?B?YkJwUDd6YnU2bXp4YmY4ZzM4Rm1zSTE2bGh6UU5oTnhycUtqY2o5d3BvUlRh?=
 =?utf-8?B?bVNMZWJ1eG1CekhTRGlWbkwrT0xaSkpoY2pmSmtMM1d0N0xDb1JLMDZNcVNY?=
 =?utf-8?B?Q2d4QnUrQkZHVVN6Z05neng0d2FPWU9IWG5vMjdYSHExUnpnT2ZOMmVGc3hE?=
 =?utf-8?B?V0E0bVJNeUJSRlpiM2ZkYms5U1dWZDRvcDdxU2JvYUYwRVlmaSthZXQvZjYx?=
 =?utf-8?B?YW1jenI3TUNTaFRDWHdkcTE0b1FBOTlKbzY2Y1RpSVZOdXptSC9sblhGeERh?=
 =?utf-8?B?N3B4SnBDczNUZk9sT0orY29JU2VGM1FDYVlHaXBZS2toWGZnTlMzTWFhSjJE?=
 =?utf-8?B?c2hsTUMzSTBHMnFmOStQVHhGMTh2aFd2NkZib0RnSzZscEw2VC91UlZ1RGdF?=
 =?utf-8?B?ZEh5SU9reE54eFp5VWFmY21tckEyRDJabjVoemZ1RlNPN3hBVDBWd1BHNkMx?=
 =?utf-8?Q?eLWbRnX2CFFG7fNOXJ9wtouK8ylKMhsnR4Y8iuD?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2532.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b93ab76-fff6-47c8-0a5c-08d8cde5a3fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 17:02:25.3975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wcMqbpGYJT0AGPH44X+TfVNBXrcNNyu284U/Ze1o2b/1IspFI3a0tvIXE0LfAQwVDIknOxuGE/6ccjL/XCYKMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4737
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612976584; bh=E37qn+qMy+qVbVksx0bmpSipWTtEMxQKtPV7A6e7sDU=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
         In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:msip_labels:authentication-results:
         x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
         x-microsoft-antispam-prvs:x-header:x-ms-oob-tlc-oobclassifiers:
         x-ms-exchange-senderadcheck:x-microsoft-antispam:
         x-microsoft-antispam-message-info:x-forefront-antispam-report:
         x-ms-exchange-antispam-messagedata:x-ms-exchange-transport-forked:
         Content-Type:Content-Transfer-Encoding:MIME-Version:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=Xbo4gCr8UJ6RUBkSyPvMqaWsAGHAjD4fU1O+As2bF9J7uSER5YBZF58iyIU/vyL1s
         q9kljgbOHAiysY4gPOddvQlhW32NObXR0SC/kPPj9biGmOHoospPceFYQACVZJqcwh
         6dc/Sxkk+1mGPLlMt+8orOAHFhX5QLppy917pagdLOcB/1lsBltIhrAWLHidLx1GSE
         kMV8UJoXgZTILVy5yWvfE4FcwNbw75bPqSF+xApUU3hnbDZLRmzebzBv6kXsSxNE1x
         4coyZQ+bYKRWd8f2gRAE2GRgWs/b+0DB513sd9YWWpB5MMogZR43lb+4riZPhD5OnK
         GHNPrBf0iu0IA==
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGkgRGFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbiBXaWxs
aWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFy
eSA5LCAyMDIxIDk6NTUgUE0NCj4gVG86IGxpbnV4LWN4bEB2Z2VyLmtlcm5lbC5vcmc7IExpbnV4
IEFDUEkgPGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnPg0KPiBDYzogTmF0dSwgTWFoZXNoIDxt
YWhlc2gubmF0dUBpbnRlbC5jb20+OyBDaGV0IFIgRG91Z2xhcw0KPiA8Y2hldC5yLmRvdWdsYXNA
aW50ZWwuY29tPjsgQmVuIFdpZGF3c2t5IDxiZW4ud2lkYXdza3lAaW50ZWwuY29tPjsgVmlzaGFs
IEwNCj4gVmVybWEgPHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbT4NCj4gU3ViamVjdDogW1JGQ10g
QUNQSSBDb2RlIEZpcnN0IEVDUjogR2VuZXJpYyBUYXJnZXQNCj4gDQo+IEV4dGVybmFsIGVtYWls
OiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gV2hp
bGUgdGhlIHBsYXRmb3JtIEJJT1MgaXMgYWJsZSB0byBkZXNjcmliZSB0aGUgcGVyZm9ybWFuY2UN
Cj4gY2hhcmFjdGVyaXN0aWNzIG9mIENYTCBtZW1vcnkgdGhhdCBpcyBwcmVzZW50IGF0IGJvb3Qs
IGl0IGlzIHVuYWJsZSB0bw0KPiBzdGF0aWNhbGx5IGVudW1lcmF0ZSB0aGUgcGVyZm9ybWFuY2Ug
b2YgQ1hMIG1lbW9yeSBob3QgaW5zZXJ0ZWQNCj4gcG9zdC1ib290LiBUaGUgT1MgY2FuIGVudW1l
cmF0ZSBtb3N0IG9mIHRoZSBjaGFyYWN0ZXJpc3RpY3MgZnJvbSBsaW5rDQo+IHJlZ2lzdGVycyBh
bmQgQ0RBVCwgYnV0IHRoZSBwZXJmb3JtYW5jZSBmcm9tIHRoZSBDUFUgdG8gdGhlIGhvc3QNCj4g
YnJpZGdlLCBmb3IgZXhhbXBsZSwgaXMgbm90IGVudW1lcmF0ZWQgYnkgUENJRSBvciBDWEwuIElu
dHJvZHVjZSBhbg0KPiBBQ1BJIG1lY2hhbmlzbSBmb3IgdGhpcyBwdXJwb3NlLiBDcml0aWNhbGx5
IHRoaXMgaXMgYWNoaWV2ZWQgd2l0aCBhDQo+IHNtYWxsIHR3ZWFrIHRvIGhvdyB0aGUgZXhpc3Rp
bmcgR2VuZXJpYyBJbml0aWF0b3IgcHJveGltaXR5IGRvbWFpbiBpcw0KPiB1dGlsaXplZCBpbiB0
aGUgSE1BVC4NCj4gDQo+IC0tLQ0KPiANCj4gIyBUaXRsZTogSW50cm9kdWNlIGEgR2VuZXJpYyBU
YXJnZXQgZm9yIENYTA0KPiANCj4gIyBTdGF0dXM6IERyYWZ0DQo+IA0KPiAjIERvY3VtZW50OiBB
Q1BJIFNwZWNpZmljYXRpb24gNi40DQo+IA0KPiAjIExpY2Vuc2UNCj4gU1BEWC1MaWNlbnNlIElk
ZW50aWZpZXI6IENDLUJZLTQuMA0KPiANCj4gIyBTdWJtaXR0ZXI6DQo+ICogU3BvbnNvcjogRGFu
IFdpbGxpYW1zLCBJbnRlbA0KPiAqIENyZWF0b3JzL0NvbnRyaWJ1dG9yczoNCj4gICAgICogTWFo
ZXNoIE5hdHUsIEludGVsDQo+ICAgICAqIENoZXQgRG91Z2xhcywgSW50ZWwNCj4gICAgICogRGVl
cGFrIFNoaXZha3VtYXIsIEludGVsDQo+IA0KPiAjIFN1bW1hcnkgb2YgdGhlIENoYW5nZQ0KPiBJ
bnRyb2R1Y2UgYSAiR2VuZXJpYyBUYXJnZXQiIGNvbmNlcHQgdG8gdGhlIFNSQVQgdG8gZGVzY3Jp
YmUgdGhlIHJvb3QNCj4gcGVyZm9ybWFuY2UgcGFyYW1ldGVycyBpbiB0aGUgcGF0aCB0byBkeW5h
bWljYWxseSBkaXNjb3ZlcmVkIChvdXRzaWRlIG9mDQo+IEFDUEkgZW51bWVyYXRpb24pIENYTCBt
ZW1vcnkgdGFyZ2V0IGVuZHBvaW50cy4NCj4gDQo+ICMgQmVuZWZpdHMgb2YgdGhlIENoYW5nZQ0K
PiBDb25zaWRlciB0aGUgY2FzZSBvZiBhIHN5c3RlbSB3aXRoIGEgc2V0IG9mIENYTCBob3N0IGJy
aWRnZXMgKEFDUEkwMDE2KSwNCj4gYW5kIG5vIGRldmljZXMgYXR0YWNoZWQgYXQgaW5pdGlhbCBz
eXN0ZW0gcG93ZXItb24uIEluIHRoaXMgc2NlbmFyaW8NCj4gcGxhdGZvcm0gZmlybXdhcmUgaXMg
dW5hYmxlIHRvIHBlcmZvcm0gdGhlIGVuZC10by1lbmQgZW51bWVyYXRpb24NCj4gbmVjZXNzYXJ5
IHRvIHBvcHVsYXRlIFNSQVQgYW5kIEhNQVQgZm9yIHRoZSBlbmRwb2ludHMgdGhhdCBtYXkgYmUN
Cj4gaG90LWluc2VydGVkIGJlaGluZCB0aG9zZSBicmlkZ2VzIHBvc3QgcG93ZXItb24uIFRoZSBh
ZGRyZXNzLXJhbmdlIGlzDQo+IHVua25vd24gc28gU1JBVCBjYW4gbm90IGJlIHByZS1wb3B1bGF0
ZWQsIHRoZSBwZXJmb3JtYW5jZSBpcyB1bmtub3duIChubw0KPiBDREFUIG5vciBpbnRlcmxlYXZl
IGNvbmZpZ3VyYXRpb24pIHNvIEhNQVQgY2FuIG5vdCBiZSBwcmUtcG9wdWxhdGVkLg0KPiANCj4g
SG93ZXZlciwgd2hhdCBpcyBrbm93biB0byBwbGF0Zm9ybSBmaXJtd2FyZSB0aGF0IGdlbmVyYXRl
cyB0aGUgU1JBVCBhbmQNCj4gSE1BVCBpcyB0aGUgcGVyZm9ybWFuY2UgY2hhcmFjdGVyaXN0aWNz
IG9mIHRoZSBwYXRoIGJldHdlZW4gQ1BVIGFuZA0KPiBHZW5lcmljIEluaXRpYXRvcnMgdG8gdGhl
IENYTCBob3N0IGJyaWRnZSB0YXJnZXQuIFdpdGggZWl0aGVyDQo+IENQVS10by1HZW5lcmljLVRh
cmdldCwgb3IgR2VuZXJpYy1Jbml0aWF0b3ItdG8tR2VuZXJpYy1UYXJnZXQgZW50cmllcyBpbg0K
PiB0aGUgSE1BVCB0aGUgT1MgQ1hMIHN1YnN5c3RlbSBjYW4gZW51bWVyYXRlIHRoZSByZW1haW5p
bmcgZGV0YWlscyAoUENJRQ0KPiBsaW5rIHN0YXR1cywgZGV2aWNlIENEQVQsIGludGVybGVhdmUg
Y29uZmlndXJhdGlvbikgdG8gY2FsY3VsYXRlIHRoZQ0KPiBiYW5kd2lkdGggYW5kIGxhdGVuY3kg
b2YgYSBkeW5hbWljYWxseSBkaXNjb3ZlcmVkIENYTCBtZW1vcnkgdGFyZ2V0Lg0KPiANCldoYXQg
aWYgdGhlcmUgaXMgYSBDWEwgc3dpdGNoIHdpdGggYSBHZW5lcmljIEluaXRpYXRvciBhbmQgQ1hM
IHR5cGUgMyBtZW1vcnkNCndoaWNoIGNvdWxkIGJlIGhvdHBsdWdnZWQgaW4uIA0KSSBmb3JnZXQg
aWYgdGhlIEdJIHRvIHR5cGUgMyBtZW1vcnkgcGF0aCBpcyBPTkxZIHRocm91Z2ggdGhlIGhvc3Qg
YnJpZGdlIHRvZGF5IGluIDIuMCANCm9yIGFsc28gYWxsb3dlZCB0aHJvdWdoIHRoZSBzd2l0Y2gu
IEluIGZ1dHVyZSB3ZSB3b3VsZCB3YW50IGl0IGFsbG93ZWQgdGhyb3VnaA0KdGhlIHN3aXRjaCBm
b3Igc3VyZSwganVzdCBsaWtlIFBDSWUgcDJwLiANClNvIGhvdyB3b3VsZCB0aGUgc3dpdGNoIHJv
dXRlIGxhdGVuY3kvQlcgYmUgZGlzY292ZXJlZD8NCkFsc28sIGFuIGV4YW1wbGUgd2l0aCBudW1i
ZXJzIG9mIHdoYXQgd291bGQgYmUgaW4gSE1BVCBtYXkgaGVscCB1bmRlcnN0YW5kIHRoZSBjYXNl
DQp3aGVyZSBldmVyeXRoaW5nIGlzIG9ubHkgY29ubmVjdGVkIHZpYSBob3N0IGJyaWRnZSBhbHNv
LiANCg0KPiAjIEltcGFjdCBvZiB0aGUgQ2hhbmdlDQo+IFRoZSBleGlzdGluZyBHZW5lcmljIElu
aXRpYXRvciBBZmZpbml0eSBTdHJ1Y3R1cmUgKEFDUEkgNi40IFNlY3Rpb24NCj4gNS4yLjE2LjYp
IGFscmVhZHkgY29udGFpbnMgYWxsIHRoZSBmaWVsZHMgbmVjZXNzYXJ5IHRvIGVudW1lcmF0ZSBh
DQo+IGdlbmVyaWMgdGFyZ2V0IHByb3hpbWl0eSBkb21haW4uIEFsbCB0aGF0IGlzIG1pc3Npbmcg
aXMgdGhlDQo+IGludGVycHJldGF0aW9uIG9mIHRoYXQgcHJveGltaXR5IGRvbWFpbiBvcHRpb25h
bGx5IGFzIGEgdGFyZ2V0DQo+IGlkZW50aWZpZXIgaW4gdGhlIEhNQVQuDQo+IA0KPiBHaXZlbiB0
aGF0IHRoZSBPUyBzdGlsbCBuZWVkcyB0byBkeW5hbWljYWxseSBlbnVtZXJhdGUgYW5kIGluc3Rh
bnRpYXRlDQo+IHRoZSBtZW1vcnkgcmFuZ2VzIGJlaGluZCB0aGUgaG9zdCBicmlkZ2UuIFRoZSBh
c3N1bXB0aW9uIGlzIHRoYXQNCj4gb3BlcmF0aW5nIHN5c3RlbXMgdGhhdCBkbyBub3Qgc3VwcG9y
dCBuYXRpdmUgQ1hMIGVudW1lcmF0aW9uIHdpbGwgaWdub3JlDQo+IHRoaXMgZGF0YSBpbiB0aGUg
SE1BVCwgd2hpbGUgQ1hMIG5hdGl2ZSBlbnVtZXJhdGlvbiBhd2FyZSBlbnZpcm9ubWVudHMNCj4g
d2lsbCB1c2UgdGhpcyBmcmFnbWVudCBvZiB0aGUgcGVyZm9ybWFuY2UgcGF0aCB0byBjYWxjdWxh
dGUgdGhlDQo+IHBlcmZvcm1hbmNlIGNoYXJhY3RlcmlzdGljcy4NCj4gDQo+ICMgUmVmZXJlbmNl
cw0KPiAqIENvbXB1dGUgRXhwcmVzcyBMaW5rIFNwZWNpZmljYXRpb24gdjIuMCwNCj4gPGh0dHBz
Oi8vd3d3LmNvbXB1dGVleHByZXNzbGluay5vcmcvPg0KPiANCj4gIyBEZXRhaWxlZCBEZXNjcmlw
dGlvbiBvZiB0aGUgQ2hhbmdlDQo+IA0KPiAqIFJlcGxhY2UgIkdlbmVyaWMgSW5pdGlhdG9yIiB3
aXRoICJHZW5lcmljIEluaXRpYXRvciAvIFRhcmdldCIgaW4gYWxsDQo+IGxvY2F0aW9ucyBleGNl
cHQgd2hlcmUgYW4gImluaXRpYXRvciIgb3IgInRhcmdldCIgaXMgaW1wbGllZC4NCj4gU3BlY2lm
aWNhbGx5IDUuMi4yNy4zICJNZW1vcnkgUHJveGltaXR5IERvbWFpbiBBdHRyaWJ1dGVzIFN0cnVj
dHVyZSINCj4gbmVlZCBub3QgcmVwbGFjZSBvY2N1cnJlbmNlcyBvZiAiZ2VuZXJpYyBpbml0aWF0
b3IiIGluIGZpZWxkOiAiUHJveGltaXR5DQo+IERvbWFpbiBmb3IgQXR0YWNoZWQgSW5pdGlhdG9y
Ii4gQWRkaXRpb25hbGx5IGZpZWxkOiAiUHJveGltaXR5IERvbWFpbg0KPiBmb3IgdGhlIE1lbW9y
eSIgbXVzdCBiZSByZW5hbWVkIHRvICJQcm94aW1pdHkgRG9tYWluIGZvciB0aGUgTWVtb3J5IC8N
Cj4gR2VuZXJpYyBUYXJnZXQiIHdpdGggYSBuZXcgZGVzY3JpcHRpb24gIkludGVnZXIgdGhhdCBy
ZXByZXNlbnRzIHRoZQ0KPiBtZW1vcnkgLyBnZW5lcmljIHRhcmdldCBwcm94aW1pdHkgZG9tYWlu
IHRvIHdoaWNoIHRoaXMgbWVtb3J5IGJlbG9uZ3MuIg0KPiANCj4gKiBSZXZpc2UgIjUuMi4xNi42
IEdlbmVyaWMgSW5pdGlhdG9yIEFmZmluaXR5IFN0cnVjdHVyZSIgdG8gbWFrZSBpdA0KPiAgIGNv
bnNpc3RlbnQgd2l0aCBiZWluZyByZWZlcmVuY2VkIGFzIGVpdGhlciBhIHRhcmdldCBvciBpbml0
aWF0b3IuDQo+IA0KPiAgICAgICAgICogRGVzY3JpcHRpb246IChyZXBsYWNlIGFsbCB0ZXh0KQ0K
PiANCj4gICAgICAgICA+IFRoZSBHZW5lcmljIEluaXRpYXRvciAvIFRhcmdldCBBZmZpbml0eSBT
dHJ1Y3R1cmUgcHJvdmlkZXMgdGhlDQo+ICAgICAgICAgPiBhc3NvY2lhdGlvbiBiZXR3ZWVuIGEg
R2VuZXJpYyBJbml0aWF0b3IgYW5kIGEgTWVtb3J5IFByb3hpbWl0eQ0KPiAgICAgICAgID4gRG9t
YWluLCBvciBhbm90aGVyIEdlbmVyaWMgVGFyZ2V0IFByb3hpbWl0eSBEb21haW4uIFRoZQ0KPiAg
ICAgICAgID4gZGlzdGluY3Rpb24gYXMgdG8gd2hldGhlciB0aGlzIHN0cnVjdHVyZSByZXByZXNl
bnRzIGFuDQo+ICAgICAgICAgPiBJbml0aWF0b3IsIGEgVGFyZ2V0LCBvciBib3RoIGRlcGVuZHMg
b24gaG93IGl0IGlzIHJlZmVyZW5jZWQNCj4gICAgICAgICA+IGluIHRoZSBITUFULiBTZWUgU2Vj
dGlvbiA1LjIuMjcuMyBmb3IgZGV0YWlscy4NCj4gDQo+ICAgICAgICAgPiBTdXBwb3J0IG9mIEdl
bmVyaWMgSW5pdGlhdG9yIC8gVGFyZ2V0IEFmZmluaXR5IFN0cnVjdHVyZXMgYnkNCj4gICAgICAg
ICA+IE9TUE0gaXMgb3B0aW9uYWwsIGFuZCB0aGUgcGxhdGZvcm0gbWF5IHF1ZXJ5IHdoZXRoZXIg
dGhlIE9TDQo+ICAgICAgICAgPiBzdXBwb3J0cyBpdCB2aWEgdGhlIF9PU0MgbWV0aG9kLiBTZWUg
U2VjdGlvbiA2LjIuMTEuMi4NCj4gDQo+ICAgICAgICAgKiBBcmNoaXRlY3R1cmFsIHRyYW5zYWN0
aW9uczogKGFwcGVuZCBhZnRlciBjdXJyZW50IHRleHQpDQo+IA0KPiAgICAgICAgID4gSWYgdGhp
cyBwcm94aW1pdHkgZG9tYWluIGlzIHJlZmVyZW5jZWQgYXMgYSB0YXJnZXQgdGhlbiBpdA0KPiAg
ICAgICAgID4gc3VwcG9ydHMgYWxsIHRoZSB0cmFuc2FjdGlvbiB0eXBlcyBpbmZlcnJlZCBhYm92
ZS4NCj4gDQo+ICAgICAgICAgKiBPdGhlciB1cGRhdGVzIGFyZSBzaW1wbGUgSW5pdGlhdG9yID0+
IEluaXRpYXRvciAvIFRhcmdldA0KPiAgICAgICAgICAgcmVwbGFjZW1lbnRzLg0K
