Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0982A3401
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Nov 2020 20:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgKBTZi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Nov 2020 14:25:38 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:62456 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbgKBTZi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Nov 2020 14:25:38 -0500
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa05d300000>; Tue, 03 Nov 2020 03:25:36 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 2 Nov
 2020 19:25:27 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.56) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 2 Nov 2020 19:25:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYb+Mcgd+H0H8kF6DSEm7LocUkpQnPKYFuGLsIYBHVnCDv2a/gju6tkG9cVRKnn8O/POZxMm46VjPDMGbUZbJn6ai6jkdARSqnN32k18rp3XX36hylBj7vXR2olvVt2lTXvONY7v0Jqbs7WVaXXmcp7yA9o0i5isusVYS3/OrEDCbN/c+rF6pytH+8beJ8e4gw4d69M3QaoHb1VHxKVrgS7vrjQQ5eAVGvDswRThtET13x+x7eJhExAwHRbYkBNqE/F26aIPHFZ/AStxZS2/FhGz6DhY9dQYSeQVGc+K12iqDfCIXlrPXQFcoNvzs4+RdGLYiZXgdy6s5KTXP3F6lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAQcHIGeTzmLBJTO3235qfLpapxUY6mIm/zegf0INeA=;
 b=O08oHVpgrSJT60P4vyOFd6zn9QD4LbVxL9s5y+Vy7H4jVyGld8ghb90WPqykVhALLM96DRC6Dt9t0ZSSobuah4H2MOBrBvjk9SWpfYtHaWf9mXBGQ96xuqIx1VoYOUTNDJL4ownM9+KP/KUcakIzipA589m4mFLA1XKhAr3+Q8CyZ1I7t13h4G1wTYfSOYahOLXIlsjXzc4nQ14s8PGHiQZwS5nmpGIdPA0fwP5AYtnqHRak3CThXmLrTPiPGqb1cfmjqtRRU2cY/+xEDIS5RumT2IpvOq63kQtIiTnNmS6w7LCxD8i6X8KR2UNRUOOyJNNee2BADUYLedNb3q1RQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BL0PR12MB2532.namprd12.prod.outlook.com (2603:10b6:207:4a::20)
 by MN2PR12MB3710.namprd12.prod.outlook.com (2603:10b6:208:16d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Mon, 2 Nov
 2020 19:25:23 +0000
Received: from BL0PR12MB2532.namprd12.prod.outlook.com
 ([fe80::a078:c548:edac:b867]) by BL0PR12MB2532.namprd12.prod.outlook.com
 ([fe80::a078:c548:edac:b867%3]) with mapi id 15.20.3477.021; Mon, 2 Nov 2020
 19:25:23 +0000
From:   Vikram Sethi <vsethi@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
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
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: RE: Onlining CXL Type2 device coherent memory
Thread-Topic: Onlining CXL Type2 device coherent memory
Thread-Index: Adatfla1CkojzXe1QXKddAzhdTnQ8QBfh7EAABzIVAAADZ5sgABV57uAAAzdYlAAA/vCAAAAVwYAAAKdA4A=
Date:   Mon, 2 Nov 2020 19:25:23 +0000
Message-ID: <BL0PR12MB2532F7D105A1DC2E41B13DF2BD100@BL0PR12MB2532.namprd12.prod.outlook.com>
References: <BL0PR12MB25321C8689BAFDF8678E5C69BD170@BL0PR12MB2532.namprd12.prod.outlook.com>
 <CAPcyv4jWFf0=VoA2EiXPaQphA-5z9JFO8h0Agy0dO0w6nDyorw@mail.gmail.com>
 <451b2571-c3e8-97d8-bfd0-f8054a1b75c5@redhat.com>
 <CAPcyv4jX1tedjuU-vCSKgvhQeNFukyq9d0ddmsk7jAjWMX+iBQ@mail.gmail.com>
 <958912b2-1436-378f-43d7-cbc5c8955ffd@redhat.com>
 <BL0PR12MB2532D78BF9E62E141AED5EADBD100@BL0PR12MB2532.namprd12.prod.outlook.com>
 <2f9fa312-e080-d995-eb82-1ac9e6128a33@redhat.com>
 <CAPcyv4jvndnm986vjQLHOw=q0+rN8JDuJd4z-Bv3Wz06Wz4gug@mail.gmail.com>
In-Reply-To: <CAPcyv4jvndnm986vjQLHOw=q0+rN8JDuJd4z-Bv3Wz06Wz4gug@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=vsethi@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-11-02T19:25:21.0762532Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=9206d0d0-43e1-4eed-a7c0-fbe473171634;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [24.242.90.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d9b0469-4c7e-4f9f-64f2-08d87f650b85
x-ms-traffictypediagnostic: MN2PR12MB3710:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3710B0F78EA130C364770A91BD100@MN2PR12MB3710.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9THr5VY5iEqRwzH8WyMBLRCmANRcd/ymmDyq87jRJ5Mr2OnBwpc1SMTvWFA+PzWn4/qklvEBIiYZiWp8P2mx9U5XOz17gTFGBPljTvUSzAHaNyKAjHZTC5gOukPNvE5we9jDjPZ+/5lSAUOYTiWcPy8//DSsBBHi6UyinpyCXcE8r65gB4sH7OlWYowL5FUBUfyj5bIO+3EhpVfKXRNTTrFkOdttw64i//fr++D1BRIguV2dtHFxcScketmOgKRHk5YmnXeZ/mdgWvp9L8uRMm5QrMexzjIIoUrDk1jY/7y0mDHX44/p0fiazzneGg2U0rtwCMtZcTtPMsf4/MHf6fmkD9opc9sQLDZAjd5nqD9yqApjd2HPFo5+5Rg4EjcLPut2T3r1s6QoQmFvwsnujA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2532.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(186003)(8936002)(2906002)(6506007)(71200400001)(76116006)(66446008)(52536014)(8676002)(26005)(86362001)(66556008)(64756008)(5660300002)(66946007)(53546011)(66476007)(478600001)(966005)(7696005)(55016002)(4326008)(83380400001)(9686003)(316002)(7416002)(33656002)(110136005)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: vmfFXt1WimpTpZHWWFRpCpbWrwPcWAwEaDOZsMaAoJJ5dQRSfamA6xx29w7dgRoswRLylUy0C84y30nzR9TcrYbTqgkNondc9aUgjdrBm9ZdiIK9jzh2eDjS6gyCv03D54iXLvXboPuj1c6x4OOQuoaZLdrNqoShA7wV4wiyXrPGgtx0/dDYJRwWs0j/l7Bw6me9CYaFl3/CeCnwsvnLv6xMY89sElL0rF/M6x4DAtkAcc96sxBV6S+FXEHPuXNe9JT3601HHCR5CBfL0GQPJTtfyf3wJfnAZmwgmNdOvBr7yfX8lRrv+yRj6PaXfyu/x3ozezWy69Jh5YY1gePv54FEKRIy9H5wdzSWYa0O6e9jZyOVfiKoQ2YoEf6IezbHkZmMs7pR6dSSfDS2/KzjyONH79HhlnOK5rHRZuwbkSR4/hAV/Q1nypHQCLoXhjfasb6BIyRGKCmC/GW75JrsGJq6L9UagG4IUTFag6K4NywOv/tzQw2w5BoTnMMEdirZTHhL1O2tXCjOJ6RtkWB/E5Q47/OO/zls37oCDrwPIk9bB6yVU/I0Vo5qRmD8DW29w/0nuPz4f1qdoI/ed6zX65Wra1iafdW/CBvglSIjgHgnu8+MmyozubW8IrYhwRnVewVxCybjP0KveucEjznPmw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2532.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d9b0469-4c7e-4f9f-64f2-08d87f650b85
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 19:25:23.3831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ncn/VjTS/TviNsR+kJrxpOZMhA/wj+07byOfb4MgIdjGY91l5oga6N4/sOR0JQg/nI4IH3LP0N1MEHC7o99sfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3710
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604345136; bh=EAQcHIGeTzmLBJTO3235qfLpapxUY6mIm/zegf0INeA=;
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
        b=SeXE2QIhqUvc9XGddoWPJVXkS99G2gmVhkKIVFIgwnUvh3MnFlX8fKMJGuVhx7nay
         0Dzu+jc7b3r0nGgrvaJK9mkKwOpZ48zx1/G0C1mUsHLPYIWMYqOGBsddMcYbudSoyR
         /2+JwNm2lq+qXzpvJfiCzk/57KS7GG3tkkior+CIQy6G2eilFR81EiI3Yb7f9hx5tA
         fxmKcR89p7A/e7UTUJA697kDkZcMU0A9gb991rIoKxIj0k01zGVG1gcehFnHsp3OuO
         z4aZa7nu69DNnzdV0PTPVD/wPX8/mDQPUjF3vKRBSK5BsaD3q2wDJ15b9gJLkzdnJ8
         TnstlzWeexO0Q==
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gRnJvbTogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+IE9u
IE1vbiwgTm92IDIsIDIwMjAgYXQgOTo1MyBBTSBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVk
aGF0LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiAwMi4xMS4yMCAxNzoxNywgVmlrcmFtIFNldGhp
IHdyb3RlOg0KPiA+ID4gSGkgRGF2aWQsDQo+ID4gPj4gRnJvbTogRGF2aWQgSGlsZGVuYnJhbmQg
PGRhdmlkQHJlZGhhdC5jb20+DQo+ID4gPj4gT24gMzEuMTAuMjAgMTc6NTEsIERhbiBXaWxsaWFt
cyB3cm90ZToNCj4gPiA+Pj4gT24gU2F0LCBPY3QgMzEsIDIwMjAgYXQgMzoyMSBBTSBEYXZpZCBI
aWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4gd3JvdGU6DQo+ID4gPj4+Pg0KPiA+ID4+
Pj4gT24gMzAuMTAuMjAgMjE6MzcsIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gPiA+Pj4+PiBPbiBX
ZWQsIE9jdCAyOCwgMjAyMCBhdCA0OjA2IFBNIFZpa3JhbSBTZXRoaSA8dnNldGhpQG52aWRpYS5j
b20+DQo+IHdyb3RlOg0KPiA+ID4+Pj4+Pg0KPiA+ID4+Pj4+PiBIZWxsbywNCj4gPiA+Pj4+Pj4N
Cj4gPiA+Pj4+Pj4gSSB3YW50ZWQgdG8ga2ljayBvZmYgYSBkaXNjdXNzaW9uIG9uIGhvdyBMaW51
eCBvbmxpbmluZyBvZiBDWEwgWzFdIHR5cGUgMg0KPiA+ID4+IGRldmljZQ0KPiA+ID4+Pj4+PiBD
b2hlcmVudCBtZW1vcnkgYWthIEhvc3QgbWFuYWdlZCBkZXZpY2UgbWVtb3J5IChIRE0pIHdpbGwg
d29yaw0KPiBmb3INCj4gPiA+PiB0eXBlIDIgQ1hMDQo+ID4gPj4+Pj4+IGRldmljZXMgd2hpY2gg
YXJlIGF2YWlsYWJsZS9wbHVnZ2VkIGluIGF0IGJvb3QuIEEgdHlwZSAyIENYTCBkZXZpY2UgY2Fu
DQo+IGJlDQo+ID4gPj4gc2ltcGx5DQo+ID4gPj4+Pj4+IHRob3VnaHQgb2YgYXMgYW4gYWNjZWxl
cmF0b3Igd2l0aCBjb2hlcmVudCBkZXZpY2UgbWVtb3J5LCB0aGF0IGFsc28gaGFzDQo+IGENCj4g
PiA+Pj4+Pj4gQ1hMLmNhY2hlIHRvIGNhY2hlIHN5c3RlbSBtZW1vcnkuDQo+ID4gPj4+Pj4+DQo+
ID4gPj4+Pj4+IE9uZSBjb3VsZCBlbnZpc2lvbiB0aGF0IEJJT1MvVUVGSSBjb3VsZCBleHBvc2Ug
dGhlIEhETSBpbiBFRkkgbWVtb3J5DQo+IG1hcA0KPiA+ID4+Pj4+PiBhcyBjb252ZW50aW9uYWwg
bWVtb3J5IGFzIHdlbGwgYXMgaW4gQUNQSSBTUkFUL1NMSVQvSE1BVC4gSG93ZXZlciwNCj4gYXQN
Cj4gPiA+PiBsZWFzdA0KPiA+ID4+Pj4+PiBvbiBzb21lIGFyY2hpdGVjdHVyZXMgKGFybTY0KSBF
RkkgY29udmVudGlvbmFsIG1lbW9yeSBhdmFpbGFibGUgYXQNCj4ga2VybmVsDQo+ID4gPj4gYm9v
dA0KPiA+ID4+Pj4+PiBtZW1vcnkgY2Fubm90IGJlIG9mZmxpbmVkLCBzbyB0aGlzIG1heSBub3Qg
YmUgc3VpdGFibGUgb24gYWxsDQo+IGFyY2hpdGVjdHVyZXMuDQo+ID4gPj4+Pj4NCj4gPiA+Pj4+
PiBUaGF0IHNlZW1zIGFuIG9kZCByZXN0cmljdGlvbi4gQWRkIERhdmlkLCBsaW51eC1tbSwgYW5k
IGxpbnV4LWFjcGkgYXMNCj4gPiA+Pj4+PiB0aGV5IG1pZ2h0IGJlIGludGVyZXN0ZWQgLyBoYXZl
IGNvbW1lbnRzIG9uIHRoaXMgcmVzdHJpY3Rpb24gYXMgd2VsbC4NCj4gPiA+Pj4+Pg0KPiA+ID4+
Pj4NCj4gPiA+Pj4+IEkgYW0gbWlzc2luZyBzb21lIGltcG9ydGFudCBkZXRhaWxzLg0KPiA+ID4+
Pj4NCj4gPiA+Pj4+IGEpIFdoYXQgaGFwcGVucyBhZnRlciBvZmZsaW5pbmc/IFdpbGwgdGhlIG1l
bW9yeSBiZQ0KPiByZW1vdmVfbWVtb3J5KCknZWQ/DQo+ID4gPj4+PiBXaWxsIHRoZSBkZXZpY2Ug
Z2V0IHBoeXNpY2FsbHkgdW5wbHVnZ2VkPw0KPiA+ID4+Pj4NCj4gPiA+IE5vdCBhbHdheXMgSU1P
LiBJZiB0aGUgZGV2aWNlIHdhcyBnZXR0aW5nIHJlc2V0LCB0aGUgSERNIG1lbW9yeSBpcyBnb2lu
ZyB0bw0KPiBiZQ0KPiA+ID4gdW5hdmFpbGFibGUgd2hpbGUgZGV2aWNlIGlzIHJlc2V0LiBPZmZs
aW5pbmcgdGhlIG1lbW9yeSBhcm91bmQgdGhlIHJlc2V0IHdvdWxkDQo+ID4NCj4gPiBPdWNoLCB0
aGF0IHNwZWFrcyBJTUhPIGNvbXBsZXRlbHkgYWdhaW5zdCBleHBvc2luZyBpdCBhcyBTeXN0ZW0g
UkFNIGFzDQo+ID4gZGVmYXVsdC4NCj4gPg0KSSBzaG91bGQgaGF2ZSBjbGFyaWZpZWQgbWVtb3J5
IGJlY29tZXMgdW5hdmFpbGFibGUgb24gYSBuZXcgIkNYTCBSZXNldCIgaW4gQ1hMIDIuMC4NCkZM
UiBkb2VzIG5vdCBtYWtlIGRldmljZSBtZW1vcnkgdW5hdmFpbGFibGUsIGJ1dCB0aGVyZSBjb3Vs
ZCBiZSBkZXZpY2VzIHRoYXQNCkltcGxlbWVudCBDWEwgcmVzZXQgYnV0IG5vdCBGTFIsIGFzIEZM
UiBpcyBvcHRpb25hbC4NCg0KPiA+ID4gYmUgc3VmZmljaWVudCwgYnV0IGRlcGVuZGluZyBpZiBk
cml2ZXIgaGFkIGRvbmUgdGhlIGFkZF9tZW1vcnkgaW4gcHJvYmUsDQo+ID4gPiBpdCBwZXJoYXBz
IHdvdWxkIGJlIG9uZXJvdXMgdG8gaGF2ZSB0byByZW1vdmVfbWVtb3J5IGFzIHdlbGwgYmVmb3Jl
IHJlc2V0LA0KPiA+ID4gYW5kIHRoZW4gYWRkIGl0IGJhY2sgYWZ0ZXIgcmVzZXQuIEkgcmVhbGl6
ZSB5b3XigJlyZSBzYXlpbmcgc3VjaCBhIHByb2NlZHVyZQ0KPiA+ID4gd291bGQgYmUgYWJ1c2lu
ZyBob3RwbHVnIGZyYW1ld29yaywgYW5kIHdlIGNvdWxkIHBlcmhhcHMgcmVxdWlyZSB0aGF0DQo+
IG1lbW9yeQ0KPiA+ID4gYmUgcmVtb3ZlZCBwcmlvciB0byByZXNldCwgYnV0IG5vdCBjbGVhciB0
byBtZSB0aGF0IGl0ICptdXN0KiBiZSByZW1vdmVkIGZvcg0KPiA+ID4gY29ycmVjdG5lc3MuDQo+
ID4gPg0KPiA+ID4gQW5vdGhlciB1c2VjYXNlIG9mIG9mZmxpbmluZyB3aXRob3V0IHJlbW92aW5n
IEhETSBjb3VsZCBiZSBhcm91bmQNCj4gPiA+IFZpcnR1YWxpemF0aW9uL3Bhc3NpbmcgZW50aXJl
IGRldmljZSB3aXRoIGl0cyBtZW1vcnkgdG8gYSBWTS4gSWYgZGV2aWNlIHdhcw0KPiA+ID4gYmVp
bmcgdXNlZCBpbiB0aGUgaG9zdCBrZXJuZWwsIGFuZCBpcyB0aGVuIHVuYm91bmQsIGFuZCBib3Vu
ZCB0byB2ZmlvLXBjaQ0KPiA+ID4gKHZmaW8tY3hsPyksIHdvdWxkIHdlIGV4cGVjdCB2ZmlvLXBj
aSB0byBhZGRfbWVtb3J5X2RyaXZlcl9tYW5hZ2VkPw0KPiA+DQo+ID4gQXQgbGVhc3QgZm9yIHBh
c3NpbmcgdGhyb3VnaCBtZW1vcnkgdG8gVk1zICh2aWEgS1ZNKSwgeW91IGRvbid0IGFjdHVhbGx5
DQo+ID4gbmVlZCBzdHJ1Y3QgcGFnZXMgLyBtZW1vcnkgZXhwb3NlZCB0byB0aGUgYnVkZHkgdmlh
DQo+ID4gYWRkX21lbW9yeV9kcml2ZXJfbWFuYWdlZCgpLiBBY3R1YWxseSwgZG9pbmcgdGhhdCBz
b3VuZHMgbGlrZSB0aGUgd3JvbmcNCj4gPiBhcHByb2FjaC4NCj4gPg0KPiA+IEUuZy4sIHlvdSB3
b3VsZCAiYWxsb2NhdGUiIHRoZSBtZW1vcnkgdmlhIGRldmRheC9kYXhfaG1hdCBhbmQgZGlyZWN0
bHkNCj4gPiBtYXAgdGhlIHJlc3VsdGluZyBkZXZpY2UgaW50byBndWVzdCBhZGRyZXNzIHNwYWNl
LiBBdCBsZWFzdCB0aGF0J3Mgd2hhdA0KPiA+IHNvbWUgcGVvcGxlIGFyZSBkb2luZyB3aXRoDQoN
CkhvdyBkb2VzIG1lbW9yeV9mYWlsdXJlIGZvcndhcmRpbmcgdG8gZ3Vlc3Qgd29yayBpbiB0aGF0
IGNhc2U/DQpJSVVDIGl0IGRvZXNuJ3Qgd2l0aG91dCBhIHN0cnVjdCBwYWdlIGluIHRoZSBob3N0
LiANCkZvciBub3JtYWwgbWVtb3J5LCB3aGVuIFZNIGNvbnN1bWVzIHBvaXNvbiwgaG9zdCBrZXJu
ZWwgc2lnbmFscw0KVXNlcnNwYWNlIHdpdGggU0lHQlVTIGFuZCBzaS1jb2RlIHRoYXQgc2F5cyBB
Y3Rpb24gUmVxdWlyZWQsIHdoaWNoIA0KUUVNVSBpbmplY3RzIHRvIHRoZSBndWVzdC4NCklCTSBo
YWQgZG9uZSBzb21ldGhpbmcgbGlrZSB5b3Ugc3VnZ2VzdCB3aXRoIGNvaGVyZW50IEdQVSBtZW1v
cnkgYW5kIElJVUMNCm1lbW9yeV9mYWlsdXJlIGZvcndhcmRpbmcgdG8gZ3Vlc3QgVk0gZG9lcyBu
b3Qgd29yayB0aGVyZS4NCg0Ka2VybmVsIGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE4LzEyLzIw
LzEwMyANClFFTVU6IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTA4MzE0NTUv
DQpJIHdvdWxkIHRoaW5rIHdlICpkbyB3YW50KiBtZW1vcnkgZXJyb3JzIHRvIGJlIHNlbnQgdG8g
YSBWTS4gDQo+IA0KPiAuLi5hbmQgSm9hbyBpcyB3b3JraW5nIHRvIHNlZSBpZiB0aGUgaG9zdCBr
ZXJuZWwgY2FuIHNraXAgYWxsb2NhdGluZw0KPiAnc3RydWN0IHBhZ2UnIG9yIGRvIGl0IG9uIGRl
bWFuZCBpZiB0aGUgZ3Vlc3QgZXZlciByZXF1ZXN0cyBob3N0DQo+IGtlcm5lbCBzZXJ2aWNlcyBv
biBpdHMgbWVtb3J5LiBUeXBpY2FsbHkgaXQgZG9lcyBub3Qgc28gaG9zdCAnc3RydWN0DQo+IHBh
Z2UnIHNwYWNlIGZvciBkZXZkYXggbWVtb3J5IHJhbmdlcyBnb2VzIHdhc3RlZC4NCklzIG1lbW9y
eV9mYWlsdXJlIGZvcndhcmRlZCB0byBhbmQgaGFuZGxlZCBieSBndWVzdD8NCg==
