Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935BF2A2F84
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Nov 2020 17:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgKBQSC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Nov 2020 11:18:02 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15341 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbgKBQSB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Nov 2020 11:18:01 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa0313c0005>; Mon, 02 Nov 2020 08:18:04 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 2 Nov
 2020 16:17:54 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 2 Nov 2020 16:17:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hE4aNWhwpm2Xlpz+pUA7DTwjFBvVo0SUU+XBD+av9PTLnvTQyPQSwX1x166oa4kviBA2gjgsaf4RjZyhWk2DGQupDw77EsS6hjmKqsG1fOXUFeKr9ZMyfsBq96r0ylLipaGFGtKwAVEkimkCrjWYMAvebvajTxgTH+AbLoWGxxFzWn/c7IUEYug2RE/skn/4LWDnE9SGGo4wtu2GtR1FjJZeu5C15Wj7/69Dng0Hpl551Fh/f43t/YIivgSP2w2+Zr36s4DpPZnLizxp/ssLprIGdEgqc/+mNr5Z2+Rm9wEekqF2Pn4dcehfUplPva85SFPKgAqRvhHVcrZ5JoWrRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hor9sJaxDjaL1lHUWw/9pZAZAb5NlEYMwOWq4HAaVDA=;
 b=cOjD7v+Zp1w0kBSh91GDPxQvdXLNgFrmd5cNQnE9IlsbxK57pah7DyeZN34Vt1Icrk79gmVBWNxAPf3NQyjcFU2gf5JR9v/c5Ic1+PP3xD3ls10QzI8p7j8rNNFwKyrICraGWvfeUyAFN+i84MMoy8HVHerHs30nSc7xQfS1Ea4hw1wyfm4m9KOHp9pZXJ4hhVpfmXb1k7G5Nr7OV/Vbcypx2ihZ8KCeFk5Azu/2lhBt5AhHH/iJqzL/xBfg4aLv5P4ZKn69vgGXr2uZ56lh3ZbXu4SBBKocdkhu/GNtnz+u74tUugjC8cH+nCUGdVPRTBdfdTwuRyJOJKnJD5pX1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BL0PR12MB2532.namprd12.prod.outlook.com (2603:10b6:207:4a::20)
 by MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Mon, 2 Nov
 2020 16:17:53 +0000
Received: from BL0PR12MB2532.namprd12.prod.outlook.com
 ([fe80::a078:c548:edac:b867]) by BL0PR12MB2532.namprd12.prod.outlook.com
 ([fe80::a078:c548:edac:b867%3]) with mapi id 15.20.3477.021; Mon, 2 Nov 2020
 16:17:53 +0000
From:   Vikram Sethi <vsethi@nvidia.com>
To:     David Hildenbrand <david@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Natu, Mahesh" <mahesh.natu@intel.com>,
        "Rudoff, Andy" <andy.rudoff@intel.com>,
        Jeff Smith <JSMITH@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: RE: Onlining CXL Type2 device coherent memory
Thread-Topic: Onlining CXL Type2 device coherent memory
Thread-Index: Adatfla1CkojzXe1QXKddAzhdTnQ8QBfh7EAABzIVAAADZ5sgABV57uAAAzdYlA=
Date:   Mon, 2 Nov 2020 16:17:52 +0000
Message-ID: <BL0PR12MB2532D78BF9E62E141AED5EADBD100@BL0PR12MB2532.namprd12.prod.outlook.com>
References: <BL0PR12MB25321C8689BAFDF8678E5C69BD170@BL0PR12MB2532.namprd12.prod.outlook.com>
 <CAPcyv4jWFf0=VoA2EiXPaQphA-5z9JFO8h0Agy0dO0w6nDyorw@mail.gmail.com>
 <451b2571-c3e8-97d8-bfd0-f8054a1b75c5@redhat.com>
 <CAPcyv4jX1tedjuU-vCSKgvhQeNFukyq9d0ddmsk7jAjWMX+iBQ@mail.gmail.com>
 <958912b2-1436-378f-43d7-cbc5c8955ffd@redhat.com>
In-Reply-To: <958912b2-1436-378f-43d7-cbc5c8955ffd@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=vsethi@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-11-02T16:17:51.0513908Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=2bf78d6f-47a8-485e-aa2a-a19c8eef6a3e;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [24.242.90.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8c487bd-5643-407d-9e9a-08d87f4ad9c0
x-ms-traffictypediagnostic: MN2PR12MB4078:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB40783D13BB26CEA5144A519EBD100@MN2PR12MB4078.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u0NMjTUVQ9RkfuGaN9IlEkRgL3Jyzz6E3sXfXyPc/uvgtnbj16/uZygAWbRssn4hgDFU62+u5eB78XfifF2/XX/tXdshon0IBYwUQy7iJPnoANbfETctR2zdBIjdBoObcYOT1o9szUcmwdBO6fXM+tCAAZlQ+W0S4r3sypdISU3bEL3W2biKMv1E1q9D8f/HAzdVHYj2NcSYefHEmsdgH1XiMkbjf1ltFIrBjpu45wN5lX9u1rGjSPslvUwjWj8SxKgBwUOsXD14HD/drFsKXv68/PZ3pGRnpK9EHRoegheUBpLWtdSacNNdeqK/zv/XO42CXh0PtvXgRlqaDHPZtNi7VezhuGjJDeGJ8uvx9OJA5DpvV1/9uC+qXoFGx6AszuRxELJlwqpK9OBWVBmSBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2532.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(7416002)(4326008)(55016002)(5660300002)(54906003)(66946007)(66446008)(64756008)(66556008)(66476007)(478600001)(2906002)(71200400001)(83380400001)(110136005)(316002)(8676002)(76116006)(7696005)(6506007)(53546011)(186003)(8936002)(107886003)(9686003)(52536014)(26005)(33656002)(966005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: s/NAGht2AhEhe3RlpeSgC1TQqXcALF1iNY6B4uiQz6jC6bEGnBsEvgw6+zBXdBoc5uO3GHWZIqCOENA6k8xXxTe2zRpfy4zoQIwmZxwK0Zd8B0cUWRc4VrSGCt6VqTRjUiCPIs620kCnm1QOwO6fZGcjXOgbcUTQ8N90QAp3sgCXRcqWLfpMfbH9DpH7HdLwfRbAbVM9rJ/WIHkjWnQybi6bLJaFJi7PYZnhD4FpcDEkOa/hlMrvlQeSq9acI9/aXo4lag9nab0BlHLHaMtVwqGkPGUHj6l1BfvN3oHp8qgSwsEragd1lb55jKVDNkZ780Sd7MFH3CzLBfs0FI5VW2KQyGs455sQE5NH0r/3QyRVhQfIC/4Dg6dx9zhnNTgtYNjoYmZZxM2pkW+5Q/BFkmBln2DOIVtTAOmGaZEaVa0GNVk6171h9vVV4P8xzIa0ankrsNC4rapYbWWx3szmGs4d+DpRQ3c9ozhiOWzBI8wb9jfOjCUpDM1FFRDGiLYy5M3t4/CbnaZzeuuBWuA1lvcbIX8pCjTdmkrAHIq6KngvULLGo5+2Da2VJ9xwy4itjaUC7teDKDYMvbpzebNR+3QnQThWEpTx2gQKEy3Gb/xuuJrpF+ZEWGcPLmL/BGrHaxKRuOt7lUWXSN3pBSZ8Pg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2532.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c487bd-5643-407d-9e9a-08d87f4ad9c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 16:17:52.9772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eqeEOIKIIzarbESHOPYt31ptb9HT6vkyCeRid8CRlfF6h8BnEYt12J6DpPYL1ygtitihppnKcMcxl0sZqdrsMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4078
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604333884; bh=hor9sJaxDjaL1lHUWw/9pZAZAb5NlEYMwOWq4HAaVDA=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
         In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:msip_labels:authentication-results:
         x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
         x-ms-exchange-transport-forked:x-microsoft-antispam-prvs:
         x-ms-oob-tlc-oobclassifiers:x-ms-exchange-senderadcheck:
         x-microsoft-antispam:x-microsoft-antispam-message-info:
         x-forefront-antispam-report:x-ms-exchange-antispam-messagedata:
         Content-Type:Content-Transfer-Encoding:MIME-Version:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=Ltf9wUVJkGq8qrZC2BQemXI674vC7rz/JwNNfYNkRMrmlBJJFuDNZX7Gn0Xvnobo9
         TfJzWsZyd680hoEe4wcf44dzzrhibvVQIN8KfwShDaIvDGJwp85TjR/YjpBz9j/KJW
         BLQxvFWMMnygCRCLfrtBjioLazWF8zkNI7YkoYqs69pCBrQYS5xcuEAXFUpuPIY6Mv
         IiYoIxp63/wK+JlZMcahWI7zqgiCiofrDQaLgk1gLJokPwbF/b+wigdSw0FrG4u3y/
         P6Q9MHujI9vu2A7lLust42VkKGm1TzA1jWvnQEdOd0U+iJOArqh9LNCHYo9t6AyKma
         SqLjlZXG6OVhw==
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGkgRGF2aWQsDQo+IEZyb206IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPg0K
PiBPbiAzMS4xMC4yMCAxNzo1MSwgRGFuIFdpbGxpYW1zIHdyb3RlOg0KPiA+IE9uIFNhdCwgT2N0
IDMxLCAyMDIwIGF0IDM6MjEgQU0gRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+
IHdyb3RlOg0KPiA+Pg0KPiA+PiBPbiAzMC4xMC4yMCAyMTozNywgRGFuIFdpbGxpYW1zIHdyb3Rl
Og0KPiA+Pj4gT24gV2VkLCBPY3QgMjgsIDIwMjAgYXQgNDowNiBQTSBWaWtyYW0gU2V0aGkgPHZz
ZXRoaUBudmlkaWEuY29tPiB3cm90ZToNCj4gPj4+Pg0KPiA+Pj4+IEhlbGxvLA0KPiA+Pj4+DQo+
ID4+Pj4gSSB3YW50ZWQgdG8ga2ljayBvZmYgYSBkaXNjdXNzaW9uIG9uIGhvdyBMaW51eCBvbmxp
bmluZyBvZiBDWEwgWzFdIHR5cGUgMg0KPiBkZXZpY2UNCj4gPj4+PiBDb2hlcmVudCBtZW1vcnkg
YWthIEhvc3QgbWFuYWdlZCBkZXZpY2UgbWVtb3J5IChIRE0pIHdpbGwgd29yayBmb3INCj4gdHlw
ZSAyIENYTA0KPiA+Pj4+IGRldmljZXMgd2hpY2ggYXJlIGF2YWlsYWJsZS9wbHVnZ2VkIGluIGF0
IGJvb3QuIEEgdHlwZSAyIENYTCBkZXZpY2UgY2FuIGJlDQo+IHNpbXBseQ0KPiA+Pj4+IHRob3Vn
aHQgb2YgYXMgYW4gYWNjZWxlcmF0b3Igd2l0aCBjb2hlcmVudCBkZXZpY2UgbWVtb3J5LCB0aGF0
IGFsc28gaGFzIGENCj4gPj4+PiBDWEwuY2FjaGUgdG8gY2FjaGUgc3lzdGVtIG1lbW9yeS4NCj4g
Pj4+Pg0KPiA+Pj4+IE9uZSBjb3VsZCBlbnZpc2lvbiB0aGF0IEJJT1MvVUVGSSBjb3VsZCBleHBv
c2UgdGhlIEhETSBpbiBFRkkgbWVtb3J5IG1hcA0KPiA+Pj4+IGFzIGNvbnZlbnRpb25hbCBtZW1v
cnkgYXMgd2VsbCBhcyBpbiBBQ1BJIFNSQVQvU0xJVC9ITUFULiBIb3dldmVyLCBhdA0KPiBsZWFz
dA0KPiA+Pj4+IG9uIHNvbWUgYXJjaGl0ZWN0dXJlcyAoYXJtNjQpIEVGSSBjb252ZW50aW9uYWwg
bWVtb3J5IGF2YWlsYWJsZSBhdCBrZXJuZWwNCj4gYm9vdA0KPiA+Pj4+IG1lbW9yeSBjYW5ub3Qg
YmUgb2ZmbGluZWQsIHNvIHRoaXMgbWF5IG5vdCBiZSBzdWl0YWJsZSBvbiBhbGwgYXJjaGl0ZWN0
dXJlcy4NCj4gPj4+DQo+ID4+PiBUaGF0IHNlZW1zIGFuIG9kZCByZXN0cmljdGlvbi4gQWRkIERh
dmlkLCBsaW51eC1tbSwgYW5kIGxpbnV4LWFjcGkgYXMNCj4gPj4+IHRoZXkgbWlnaHQgYmUgaW50
ZXJlc3RlZCAvIGhhdmUgY29tbWVudHMgb24gdGhpcyByZXN0cmljdGlvbiBhcyB3ZWxsLg0KPiA+
Pj4NCj4gPj4NCj4gPj4gSSBhbSBtaXNzaW5nIHNvbWUgaW1wb3J0YW50IGRldGFpbHMuDQo+ID4+
DQo+ID4+IGEpIFdoYXQgaGFwcGVucyBhZnRlciBvZmZsaW5pbmc/IFdpbGwgdGhlIG1lbW9yeSBi
ZSByZW1vdmVfbWVtb3J5KCknZWQ/DQo+ID4+IFdpbGwgdGhlIGRldmljZSBnZXQgcGh5c2ljYWxs
eSB1bnBsdWdnZWQ/DQo+ID4+DQpOb3QgYWx3YXlzIElNTy4gSWYgdGhlIGRldmljZSB3YXMgZ2V0
dGluZyByZXNldCwgdGhlIEhETSBtZW1vcnkgaXMgZ29pbmcgdG8gYmUNCnVuYXZhaWxhYmxlIHdo
aWxlIGRldmljZSBpcyByZXNldC4gT2ZmbGluaW5nIHRoZSBtZW1vcnkgYXJvdW5kIHRoZSByZXNl
dCB3b3VsZA0KYmUgc3VmZmljaWVudCwgYnV0IGRlcGVuZGluZyBpZiBkcml2ZXIgaGFkIGRvbmUg
dGhlIGFkZF9tZW1vcnkgaW4gcHJvYmUsIA0KaXQgcGVyaGFwcyB3b3VsZCBiZSBvbmVyb3VzIHRv
IGhhdmUgdG8gcmVtb3ZlX21lbW9yeSBhcyB3ZWxsIGJlZm9yZSByZXNldCwgDQphbmQgdGhlbiBh
ZGQgaXQgYmFjayBhZnRlciByZXNldC4gSSByZWFsaXplIHlvdeKAmXJlIHNheWluZyBzdWNoIGEg
cHJvY2VkdXJlDQp3b3VsZCBiZSBhYnVzaW5nIGhvdHBsdWcgZnJhbWV3b3JrLCBhbmQgd2UgY291
bGQgcGVyaGFwcyByZXF1aXJlIHRoYXQgbWVtb3J5DQpiZSByZW1vdmVkIHByaW9yIHRvIHJlc2V0
LCBidXQgbm90IGNsZWFyIHRvIG1lIHRoYXQgaXQgKm11c3QqIGJlIHJlbW92ZWQgZm9yIA0KY29y
cmVjdG5lc3MuIA0KDQpBbm90aGVyIHVzZWNhc2Ugb2Ygb2ZmbGluaW5nIHdpdGhvdXQgcmVtb3Zp
bmcgSERNIGNvdWxkIGJlIGFyb3VuZCANClZpcnR1YWxpemF0aW9uL3Bhc3NpbmcgZW50aXJlIGRl
dmljZSB3aXRoIGl0cyBtZW1vcnkgdG8gYSBWTS4gSWYgZGV2aWNlIHdhcw0KYmVpbmcgdXNlZCBp
biB0aGUgaG9zdCBrZXJuZWwsIGFuZCBpcyB0aGVuIHVuYm91bmQsIGFuZCBib3VuZCB0byB2Zmlv
LXBjaQ0KKHZmaW8tY3hsPyksIHdvdWxkIHdlIGV4cGVjdCB2ZmlvLXBjaSB0byBhZGRfbWVtb3J5
X2RyaXZlcl9tYW5hZ2VkPw0KSU1PIHRoZSBjb2hlcmVudCBkZXZpY2UgbWVtb3J5IHNob3VsZCBi
ZSBvbmxpbmVkIGluIHRoZSBob3N0LCBmb3IgZXhhbXBsZSwgdG8gDQpoYW5kbGUgbWVtb3J5X2Zh
aWx1cmUgZmxvd3MgYW5kIHBhc3Npbmcgb24gdG8gdXNlcnNwYWNlL3RoZSBWTSB3aGVuIHBvaXNv
biBpcyANCmNvbnN1bWVkIGJ5IHRoZSBWTSBvbiBsb2FkIHRvICJiYWQiIEhETS4gSSByZWFsaXpl
IGl0ICpjb3VsZCogYmUgZG9uZSB3aXRoIA0KdmZpbyBhZGRpbmcrb25saW5pbmcgdGhlIG1lbW9y
eSB0byBob3N0IGtlcm5lbCwgYW5kIHBlcmhhcHMgbWFrZXMgc2Vuc2UgaWYgDQp0aGUgZGV2aWNl
IGhhZCBuZXZlciBiZWVuIHVzZWQgaW4gdGhlIGhvc3Qga2VybmVsL2JvdW5kIHRvIGl0cyAibmF0
aXZlIiANCmRldmljZSBkcml2ZXIgdG8gYmVnaW4gd2l0aC4gQWxleD8NCg0KPiA+PiBiKSBXaGF0
J3MgdGhlIGdlbmVyYWwgcHVycG9zZSBvZiB0aGUgbWVtb3J5IGFuZCBpdHMgaW50ZW5kZWQgdXNh
Z2Ugd2hlbg0KPiA+PiAqbm90KiBleHBvc2VkIGFzIHN5c3RlbSBSQU0/IFdoYXQncyB0aGUgbWFp
biBwb2ludCBvZiB0cmVhdGluZyBpdCBsaWtlDQo+ID4+IG9yZGluYXJ5IHN5c3RlbSBSQU0gYXMg
ZGVmYXVsdD8NCj4gPj4NCj4gPj4gQWxzbywgY2FuIHlvdSBiZSBzdXJlIHRoYXQgeW91IGNhbiBv
ZmZsaW5lIHRoYXQgbWVtb3J5PyBJZiBpdCdzDQo+ID4+IFpPTkVfTk9STUFMIChhcyB1c3VhbGx5
IGFsbCBzeXN0ZW0gUkFNIGluIHRoZSBpbml0aWFsIG1hcCksIHRoZXJlIGFyZSBubw0KPiA+PiBz
dWNoIGd1YXJhbnRlZXMsIGVzcGVjaWFsbHkgb25jZSB0aGUgc3lzdGVtIHJhbiBmb3IgbG9uZyBl
bm91Z2gsIGJ1dA0KPiA+PiBhbHNvIGluIG90aGVyIGNhc2VzIChlLmcuLCBzaHVmZmxpbmcpLCBv
ciBpZiBhbGxvY2F0aW9uIHBvbGljaWVzIGNoYW5nZQ0KPiA+PiBpbiB0aGUgZnV0dXJlLg0KPiA+
Pg0KPiA+PiBTbyBJICpndWVzcyogeW91IHdvdWxkIGFscmVhZHkgaGF2ZSB0byB1c2Uga2VybmVs
IGNtZGxpbmUgaGFja3MgbGlrZQ0KPiA+PiAibW92YWJsZWNvcmUiIHRvIG1ha2UgaXQgd29yay4g
SW4gdGhhdCBjYXNlLCB5b3UgY2FuIGRpcmVjdGx5IHNwZWNpZnkNCj4gPj4gd2hhdCB5b3UgKmFj
dHVhbGx5KiB3YW50ICh3aGljaCBJIGFtIG5vdCBzdXJlIHlldCBJIGNvbXBsZXRlbHkNCj4gPj4g
dW5kZXJzdG9vZCkgLSBlLmcuLCBzb21ldGhpbmcgbGlrZSAibWVtbWFwPTE2RyExNkciIC4uLiBv
ciBzb21ldGhpbmcNCj4gPj4gc2ltaWxhci4NCj4gPj4NCj4gPj4gSSBjb25zaWRlciBvZmZsaW5p
bmcrcmVtb3ZpbmcgKmJvb3QqIG1lbW9yeSB0byBub3QgcGh5c2ljYWxseSB1bnBsdWcgaXQNCj4g
Pj4gKGUuZy4sIGEgRElNTSBnZXR0aW5nIHVucGx1Z2dlZCkgYWJ1c2luZyB0aGUgbWVtb3J5IGhv
dHVucGx1Zw0KPiA+PiBpbmZyYXN0cnVjdHVyZS4gSXQncyBhIGRpZmZlcmVudCB0aGluZyB3aGVu
IG1hbnVhbGx5IGFkZGluZyBtZW1vcnkgbGlrZQ0KPiA+PiBkYXhfa21lbSBkb2VzIHZpYSBhZGRf
bWVtb3J5X2RyaXZlcl9tYW5hZ2VkKCkuDQo+ID4+DQo+ID4+DQo+ID4+IE5vdywgYmFjayB0byB5
b3VyIG9yaWdpbmFsIHF1ZXN0aW9uOiBhcm02NCBkb2VzIG5vdCBzdXBwb3J0IHBoeXNpY2FsbHkN
Cj4gPj4gdW5wbHVnZ2luZyBESU1NcyB0aGF0IHdlcmUgcGFydCBvZiB0aGUgaW5pdGlhbCBtYXAu
IElmIHlvdSdkIHJlYm9vdA0KPiA+PiBhZnRlciB1bnBsdWdnaW5nIGEgRElNTSwgeW91ciBzeXN0
ZW0gd291bGQgY3Jhc2guIFdlIGFjaGlldmUgdGhhdCBieQ0KPiA+PiBkaXNhbGxvd2luZyB0byBv
ZmZsaW5lIGJvb3QgbWVtb3J5IC0gd2UgY291bGQgYWxzbyB0cnkgdG8gaGFuZGxlIGl0IGluDQo+
ID4+IEFDUEkgY29kZS4gQnV0IGFnYWluLCBtb3N0IHVzZXMgb2Ygb2ZmbGluaW5nK3JlbW92aW5n
IGJvb3QgbWVtb3J5IGFyZQ0KPiA+PiBhYnVzaW5nIHRoZSBtZW1vcnkgaG90dW5wbHVnIGluZnJh
c3RydWN0dXJlIGFuZCBzaG91bGQgcmF0aGVyIGJlIHNvbHZlZA0KPiA+PiBjbGVhbmx5IHZpYSBh
IGRpZmZlcmVudCBtZWNoYW5pc20gKGZpcm13YXJlLCBrZXJuZWwgY21kbGluZSwgLi4uKS4NCj4g
Pj4NCj4gPj4gSnVzdCByZWNlbnRseSBkaXNjdXNzZWQgaW4NCj4gPj4NCj4gPj4NCj4gaHR0cHM6
Ly9sa21sLmtlcm5lbC5vcmcvci9kZTgzODhkZjJmYmM1YTZhMzNhYWI5NTgzMWJhN2RiNEBjb2Rl
YXVyb3JhLm9yZw0KPiA+Pg0KPiA+Pj4+IEZ1cnRoZXIsIHRoZSBkZXZpY2UgZHJpdmVyIGFzc29j
aWF0ZWQgd2l0aCB0aGUgdHlwZSAyIGRldmljZS9hY2NlbGVyYXRvciBtYXkNCj4gPj4+PiB3YW50
IHRvIHNhdmUgb2ZmIGEgY2h1bmsgb2YgSERNIGZvciBkcml2ZXIgcHJpdmF0ZSB1c2UuDQo+ID4+
Pj4gU28gaXQgc2VlbXMgdGhlIG1vcmUgYXBwcm9wcmlhdGUgbW9kZWwgbWF5IGJlIHNvbWV0aGlu
ZyBsaWtlIGRldiBkYXgNCj4gbW9kZWwNCj4gPj4+PiB3aGVyZSB0aGUgZGV2aWNlIGRyaXZlciBw
cm9iZS9vcGVuIGNhbGxzIGFkZF9tZW1vcnlfZHJpdmVyX21hbmFnZWQsDQo+IGFuZA0KPiA+Pj4+
IHRoZSBkcml2ZXIgY291bGQgY2hvb3NlIGhvdyBtdWNoIG9mIHRoZSBIRE0gaXQgd2FudHMgdG8g
cmVzZXJ2ZSBhbmQgaG93DQo+ID4+Pj4gbXVjaCB0byBtYWtlIGdlbmVyYWxseSBhdmFpbGFibGUg
Zm9yIGFwcGxpY2F0aW9uIG1tYXAvbWFsbG9jLg0KPiA+Pj4NCj4gPj4+IFN1cmUsIGl0IGNhbiBh
bHdheXMgYmUgZHJpdmVyIG1hbmFnZWQuIFRoZSB0cmljayB3aWxsIGJlIGdldHRpbmcgdGhlDQo+
ID4+PiBwbGF0Zm9ybSBmaXJtd2FyZSB0byBhZ3JlZSB0byBub3QgbWFwIGl0IGJ5IGRlZmF1bHQs
IGJ1dCBJIHN1c3BlY3QNCj4gPj4+IHlvdSdsbCBoYXZlIGEgaGFyZCB0aW1lIGNvbnZpbmNpbmcg
cGxhdGZvcm0tZmlybXdhcmUgdG8gdGFrZSB0aGF0DQo+ID4+PiBzdGFuY2UuIFRoZSBCSU9TIGRv
ZXMgbm90IGtub3csIGFuZCBzaG91bGQgbm90IGNhcmUgd2hhdCBPUyBpcyBib290aW5nDQo+ID4+
PiB3aGVuIGl0IHByb2R1Y2VzIHRoZSBtZW1vcnkgbWFwLiBTbyBJIHRoaW5rIENYTCBtZW1vcnkg
dW5wbHVnIGFmdGVyDQo+ID4+PiB0aGUgZmFjdCBpcyBtb3JlIHJlYWxpc3RpYyB0aGFuIHRyeWlu
ZyB0byBnZXQgdGhlIEJJT1Mgbm90IHRvIG1hcCBpdC4NCj4gPj4+IFNvLCB0byBtZSBpdCBsb29r
cyBsaWtlIGFybTY0IG5lZWRzIHRvIHJlY29uc2lkZXIgaXRzIHVucGx1ZyBzdGFuY2UuDQo+ID4+
DQo+ID4+IE15IHBlcnNvbmFsIG9waW5pb24gaXMsIGlmIG1lbW9yeSBpc24ndCBqdXN0ICJvcmRp
bmFyeSBzeXN0ZW0gUkFNIiwgdGhlbg0KPiA+PiBsZXQgdGhlIHN5c3RlbSBrbm93IGVhcmx5IHRo
YXQgbWVtb3J5IGlzIHNwZWNpYWwgKGFzIHdlIGRvIHdpdGgNCj4gPj4gc29mdC1yZXNlcnZlZCku
DQo+ID4+DQo+ID4+IElkZWFsbHksIHlvdSBjb3VsZCBjb25maWd1cmUgdGhlIGZpcm13YXJlIChl
LmcuLCB2aWEgQklPUyBzZXR1cCkgb24gd2hhdA0KPiA+PiB0byBkbywgdGhhdCdzIHRoZSBjbGVh
bmVzdCBzb2x1dGlvbiwgYnV0IEkgY2FuIHVuZGVyc3RhbmQgdGhhdCdzIHJhdGhlcg0KPiA+PiBo
YXJkIHRvIGFjaGlldmUuDQo+ID4NCj4gPiBZZXMsIG15IGhvcGUsIHdoaWNoIGlzIGFib3V0IHRo
ZSBtb3N0IGluZmx1ZW5jZSBJIGNhbiBoYXZlIG9uDQo+ID4gcGxhdGZvcm0tZmlybXdhcmUgaW1w
bGVtZW50YXRpb25zLCBpcyB0aGF0IGl0IG1hcmtzIENYTCBhdHRhY2hlZA0KPiA+IG1lbW9yeSBh
cyBzb2Z0LXJlc2VydmVkIGJ5IGRlZmF1bHQgYW5kIGFsbG93IE9TIHBvbGljeSBkZWNpZGUgd2hl
cmUgaXQNCj4gPiBnb2VzLiBCYXJyaW5nIHRoYXQsIGZvciB0aGUgY29uZmlndXJhdGlvbiB0aGF0
IFZpa3JhbSBtZW50aW9uZWQsIHRoZQ0KPiA+IG9ubHkgb3RoZXIgd2F5IHRvIGdldCB0aGlzIGRp
ZmZlcmVudGlhdGVkIC8gbm90LW9yZGluYXJ5IHN5c3RlbS1yYW0NCj4gPiBiYWNrIHRvIGJlaW5n
IGRyaXZlciBtYW5hZ2VkIHdvdWxkIGJlIHRvIHVucGx1ZyBpdC4gVGhlIHNvZnQtcmVzZXJ2ZWQN
Cj4gPiBwYXRoIGlzIGNsZWFuZXIuDQo+IA0KPiBJZiB3ZSBhbHJlYWR5IG5lZWQga2VybmVsIGNt
ZGxpbmUgcGFyYW1ldGVycyAobW92YWJsZWNvcmUpLCB3ZSBjYW4NCj4gaGFuZGxlIHRoaXMgZGlm
ZmVyZW50bHkgdmlhIHRoZSBjbWRsaW5lLiBUaGF0IHNldHMgZXhwZWN0YXRpb25zIGZvcg0KPiBw
ZW9wbGUgaW1wbGVtZW50aW5nIHRoZSBmaXJtd2FyZSAtIHdlIHNob3VsZG4ndCBtYWtlIHRoZWly
IGxpZmUgdG9vIGVhc3kNCj4gd2l0aCBzdWNoIGRlY2lzaW9ucy4NCj4gDQo+IFRoZSBwYXJhZ3Jh
cGggc3RhcnRlZCB3aXRoDQo+IA0KPiAiT25lIGNvdWxkIGVudmlzaW9uIHRoYXQgQklPUy9VRUZJ
IGNvdWxkIGV4cG9zZSB0aGUgSERNIGluIEVGSSBtZW1vcnkNCj4gbWFwIC4uLiIgTGV0J3Mgbm90
IGVudmlzaW9uIGl0LCBidXQgaW5zdGVhZCBzdWdnZXN0IHBlb3BsZSB0byBub3QgZG8gaXQgOykN
Cj4gDQoNClNvdW5kcyBnb29kIHRvIG1lISBNYWhlc2gsIGxldOKAmXMgbGluZSB0aGlzIHRvcGlj
IHVwIGZvciBkaXNjdXNzaW9uIGluIGEgQ1hMDQpVRUZJL0FDUEkgc3VidGVhbSBtZWV0aW5nLCBh
bmQgZmluZCBhIHdheSB0byBhZGQgRUNSIGltcGxlbWVudGF0aW9uIG5vdGUNCnRvIHRoZSBzcGVj
IHRoYXQgVUVGSS9CSU9TIE5PVCBleHBvc2UgSERNIGluIEVGSSBtZW1vcnkgbWFwLg0KDQpUaGFu
a3MsDQpWaWtyYW0NCg==
