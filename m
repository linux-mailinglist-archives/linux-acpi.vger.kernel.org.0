Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338EB2A10FB
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Oct 2020 23:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgJ3Wj7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Oct 2020 18:39:59 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17035 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ3Wj7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Oct 2020 18:39:59 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9c96490001>; Fri, 30 Oct 2020 15:40:09 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 30 Oct
 2020 22:39:51 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 30 Oct 2020 22:39:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kStxR0D6wJdyO7KbKcXMJawp4zaYf20GUK7tG4C7hHtZbciYo/hTZ8YdNY8c7Bk+5KhjTIhV8TmSkMz4aNdMapDOC+JPMU/VJVhNXs44dvkP/E13XhK1CYxx8p67nMye0JBn6CVA3ICGwpr55HT4DbItcbHQpEBES/7K7jm+oZanL/DQXE/Mb6Gmj0WrnGfWTWcnX9HNhOFqb98DnZqdHb/U2Euskmc23ei/Ef4JEuJlM6MvvSGCtA/8NgjwCFmTi94knGytB5f5U5U7xVR3G2+cvrWXyP1lI8vycPEjrcEfevLJTVw8ahu1ttGxMikcwXE6WrLbzicdpKYlt2fvvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXPbnXgFa8vXK/1wqGd6x5CfPfH3yGHyh0jLTCXn+2E=;
 b=gV5x/F601d0Lgc6EljEOo6qZXPLlJPxpnFi4Prlctwi4+ohzr7WV2pMkJ2ykgGfmjY4WvHf3bJpOuNLQrT0DJpiG66vUKhAPInAZdjk5ZuZibaxXyIrx2SAYmuFPhYperkRr4ycPrqmXb9b1f/A343/Y3pzAxH8SlV1/yxVCESWvVcKJm7+jXCXbOrJPJo8Dp7sZZvWeJqs84yqzSTIwqien/5o744veut26OWqAr2znh8hFgccjU04NB8+f5J1rtorGYDAwj2a4/LAAm9dY1JJzMtStoBIPRaZJnF3L3f17ne9O0JtjNQS4M8dr2SI7X29bICrIm7ItnU6S3tqB+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BL0PR12MB2532.namprd12.prod.outlook.com (2603:10b6:207:4a::20)
 by MN2PR12MB3711.namprd12.prod.outlook.com (2603:10b6:208:161::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.24; Fri, 30 Oct
 2020 22:39:49 +0000
Received: from BL0PR12MB2532.namprd12.prod.outlook.com
 ([fe80::a078:c548:edac:b867]) by BL0PR12MB2532.namprd12.prod.outlook.com
 ([fe80::a078:c548:edac:b867%3]) with mapi id 15.20.3477.021; Fri, 30 Oct 2020
 22:39:49 +0000
From:   Vikram Sethi <vsethi@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Natu, Mahesh" <mahesh.natu@intel.com>,
        "Rudoff, Andy" <andy.rudoff@intel.com>,
        Jeff Smith <JSMITH@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Ard Biesheuvel <Ard.Biesheuvel@arm.com>
Subject: RE: Onlining CXL Type2 device coherent memory
Thread-Topic: Onlining CXL Type2 device coherent memory
Thread-Index: Adatfla1CkojzXe1QXKddAzhdTnQ8QBfh7EAAAPdARA=
Date:   Fri, 30 Oct 2020 22:39:49 +0000
Message-ID: <BL0PR12MB2532DDE990282976888108D2BD150@BL0PR12MB2532.namprd12.prod.outlook.com>
References: <BL0PR12MB25321C8689BAFDF8678E5C69BD170@BL0PR12MB2532.namprd12.prod.outlook.com>
 <CAPcyv4jWFf0=VoA2EiXPaQphA-5z9JFO8h0Agy0dO0w6nDyorw@mail.gmail.com>
In-Reply-To: <CAPcyv4jWFf0=VoA2EiXPaQphA-5z9JFO8h0Agy0dO0w6nDyorw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=vsethi@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-10-30T22:39:47.4129884Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=b179dbe3-74ea-4346-a6c9-dea842e16a8c;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [24.242.90.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e0ad736-c465-40e2-df5c-08d87d24b598
x-ms-traffictypediagnostic: MN2PR12MB3711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB37118DE7D5194578F3B5C351BD150@MN2PR12MB3711.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vedQoCSeIOZIlEp9tLuKfx97N3dPLHkQj23I/wCzLG4hC89LnVIy+CubH4MrEwldA1KRCh6zT5akwEpzi7Uv2XSBEYr7PUnT4LYc5XrhFAfQWhfxaT2OoBAM8duW8mUXgj126bhJahEFuKP6gJ6eByp1eMmjs6z4DY+U6wjIxi6aAVJEyRocR3dEsnTlSdeF/NyckLzFVTFmCPjL+QWsP6ihH2psXvro3EkaWs1wb+Dw9JBp6qZ50TeDpcSB7Nv8pRnr5/SpTsggqK+QhdhHokxHCJegqyH8vwMdHz+ZF1RZ2BOsLkSiyZXbPkdJxADxJlOVrsTZTkn0ABKb02L4XQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2532.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(53546011)(8936002)(64756008)(66476007)(66446008)(7696005)(316002)(478600001)(26005)(66556008)(55016002)(7416002)(9686003)(4326008)(66946007)(76116006)(52536014)(54906003)(186003)(33656002)(6506007)(83380400001)(6916009)(8676002)(2906002)(5660300002)(86362001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Dr3bMTrfJGbQl7Jh8w2eRfh8C/2x8d40BTUcxusM145uWYlC56lBEECnAMLYkstBC2LzxojZsiVVhB/K3oEAwc7maX5WZPR2elOPwcHRMdC2sJp7zKJDE/joCgLROlL+Wrm8xMoTmxmb2ktALDfdE7xTFRdoY9nfcfe/TlWa28RYGaVOAdUxHQBIp90NeX134J3NBOH5A/jzTSOOyBu01epM3WUdJVyYcoXiOnzgPrQhSY7ET8cmpczwdZCefIqsyoNzkZgT8aLCAHihWRIzKFc5NlQwCusvKD+d8etXyoVU5CBbVRp+Xpz8+Zn43jaPuWpFgtBHhTHi8nWYW2LHefXAlCRUHfqK8T6e+qn948iB60u+vgUYEDqY3ONwx5jYFFQ0aEsxHo0yiJ3QfsXyV/SsFgbwP2zRSqGgoNpI9p9JKnoB2nGjABkK3AjFzaLqdfI6wDjZWpwATpcWghVr/8+nz1tBtdd+Ide6mQilrEXr7r4wZkgAvBq8GN8aPEsagVhggNNPJ8KoJNzzrBR3fxQi3kHRlQYPkS+wHHOMxlJbzWpCWiHLHK6VbIdRu8jMmwT++ctJfsakJX2rmKohXe9tmM2/FBn8qLn44ZGrC8xhNB2S9ISh4Vzu0SmewK14KvnUagQANe8nGhXgguuVrg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2532.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0ad736-c465-40e2-df5c-08d87d24b598
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 22:39:49.0655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pn/1/3AS0StecZZonvxsv3Mm50eMqsEeY1FhNJQXT2bVUPsCXUacYP1Bd8hNEjfl92LynGNQVtY6pTtF3qkdSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3711
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604097609; bh=FXPbnXgFa8vXK/1wqGd6x5CfPfH3yGHyh0jLTCXn+2E=;
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
        b=GaZI431IaqNWyP2jg16gwIvq6aQQEQDVTTNa2NG1UFlZzqqXbRAKce4EtHFWlG22O
         MI8GjKrWCYMnstn9RDycYyY9kqTvU/00PUCP/Dd9sTKVzMPMuf83hwQSQu3ZIjgz0H
         v9xFYI8PjqwuS5wxlKMBo2yVZ8CHiPm9aQzJnj4n169hrU54hTYoyZdHsS1rjumFDW
         yXLWI7uWntTQbEXYZWNokSQf6Q9Awx/oRNfKurSDY/MnyjPdAwRcw3t/WmRS1odMkt
         VP1m+BrMGMkMcvmsPqptCXZjxe6ORwThSzRDrxXLuZiqYDVuXOlkSwixWfr15bNsSb
         F2cobxYEAg9xQ==
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGkgRGFuLCANCj4gRnJvbTogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+
DQo+IE9uIFdlZCwgT2N0IDI4LCAyMDIwIGF0IDQ6MDYgUE0gVmlrcmFtIFNldGhpIDx2c2V0aGlA
bnZpZGlhLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBIZWxsbywNCj4gPg0KPiA+IEkgd2FudGVkIHRv
IGtpY2sgb2ZmIGEgZGlzY3Vzc2lvbiBvbiBob3cgTGludXggb25saW5pbmcgb2YgQ1hMIFsxXSB0
eXBlIDIgZGV2aWNlDQo+ID4gQ29oZXJlbnQgbWVtb3J5IGFrYSBIb3N0IG1hbmFnZWQgZGV2aWNl
IG1lbW9yeSAoSERNKSB3aWxsIHdvcmsgZm9yIHR5cGUgMg0KPiBDWEwNCj4gPiBkZXZpY2VzIHdo
aWNoIGFyZSBhdmFpbGFibGUvcGx1Z2dlZCBpbiBhdCBib290LiBBIHR5cGUgMiBDWEwgZGV2aWNl
IGNhbiBiZQ0KPiBzaW1wbHkNCj4gPiB0aG91Z2h0IG9mIGFzIGFuIGFjY2VsZXJhdG9yIHdpdGgg
Y29oZXJlbnQgZGV2aWNlIG1lbW9yeSwgdGhhdCBhbHNvIGhhcyBhDQo+ID4gQ1hMLmNhY2hlIHRv
IGNhY2hlIHN5c3RlbSBtZW1vcnkuDQo+ID4NCj4gPiBPbmUgY291bGQgZW52aXNpb24gdGhhdCBC
SU9TL1VFRkkgY291bGQgZXhwb3NlIHRoZSBIRE0gaW4gRUZJIG1lbW9yeSBtYXANCj4gPiBhcyBj
b252ZW50aW9uYWwgbWVtb3J5IGFzIHdlbGwgYXMgaW4gQUNQSSBTUkFUL1NMSVQvSE1BVC4gSG93
ZXZlciwgYXQgbGVhc3QNCj4gPiBvbiBzb21lIGFyY2hpdGVjdHVyZXMgKGFybTY0KSBFRkkgY29u
dmVudGlvbmFsIG1lbW9yeSBhdmFpbGFibGUgYXQga2VybmVsIGJvb3QNCj4gPiBtZW1vcnkgY2Fu
bm90IGJlIG9mZmxpbmVkLCBzbyB0aGlzIG1heSBub3QgYmUgc3VpdGFibGUgb24gYWxsIGFyY2hp
dGVjdHVyZXMuDQo+IA0KPiBUaGF0IHNlZW1zIGFuIG9kZCByZXN0cmljdGlvbi4gQWRkIERhdmlk
LCBsaW51eC1tbSwgYW5kIGxpbnV4LWFjcGkgYXMNCj4gdGhleSBtaWdodCBiZSBpbnRlcmVzdGVk
IC8gaGF2ZSBjb21tZW50cyBvbiB0aGlzIHJlc3RyaWN0aW9uIGFzIHdlbGwuDQo+IA0KPiA+IEZ1
cnRoZXIsIHRoZSBkZXZpY2UgZHJpdmVyIGFzc29jaWF0ZWQgd2l0aCB0aGUgdHlwZSAyIGRldmlj
ZS9hY2NlbGVyYXRvciBtYXkNCj4gPiB3YW50IHRvIHNhdmUgb2ZmIGEgY2h1bmsgb2YgSERNIGZv
ciBkcml2ZXIgcHJpdmF0ZSB1c2UuDQo+ID4gU28gaXQgc2VlbXMgdGhlIG1vcmUgYXBwcm9wcmlh
dGUgbW9kZWwgbWF5IGJlIHNvbWV0aGluZyBsaWtlIGRldiBkYXggbW9kZWwNCj4gPiB3aGVyZSB0
aGUgZGV2aWNlIGRyaXZlciBwcm9iZS9vcGVuIGNhbGxzIGFkZF9tZW1vcnlfZHJpdmVyX21hbmFn
ZWQsIGFuZA0KPiA+IHRoZSBkcml2ZXIgY291bGQgY2hvb3NlIGhvdyBtdWNoIG9mIHRoZSBIRE0g
aXQgd2FudHMgdG8gcmVzZXJ2ZSBhbmQgaG93DQo+ID4gbXVjaCB0byBtYWtlIGdlbmVyYWxseSBh
dmFpbGFibGUgZm9yIGFwcGxpY2F0aW9uIG1tYXAvbWFsbG9jLg0KPiANCj4gU3VyZSwgaXQgY2Fu
IGFsd2F5cyBiZSBkcml2ZXIgbWFuYWdlZC4gVGhlIHRyaWNrIHdpbGwgYmUgZ2V0dGluZyB0aGUN
Cj4gcGxhdGZvcm0gZmlybXdhcmUgdG8gYWdyZWUgdG8gbm90IG1hcCBpdCBieSBkZWZhdWx0LCBi
dXQgSSBzdXNwZWN0DQo+IHlvdSdsbCBoYXZlIGEgaGFyZCB0aW1lIGNvbnZpbmNpbmcgcGxhdGZv
cm0tZmlybXdhcmUgdG8gdGFrZSB0aGF0DQo+IHN0YW5jZS4gVGhlIEJJT1MgZG9lcyBub3Qga25v
dywgYW5kIHNob3VsZCBub3QgY2FyZSB3aGF0IE9TIGlzIGJvb3RpbmcNCj4gd2hlbiBpdCBwcm9k
dWNlcyB0aGUgbWVtb3J5IG1hcC4gU28gSSB0aGluayBDWEwgbWVtb3J5IHVucGx1ZyBhZnRlcg0K
PiB0aGUgZmFjdCBpcyBtb3JlIHJlYWxpc3RpYyB0aGFuIHRyeWluZyB0byBnZXQgdGhlIEJJT1Mg
bm90IHRvIG1hcCBpdC4NCj4gU28sIHRvIG1lIGl0IGxvb2tzIGxpa2UgYXJtNjQgbmVlZHMgdG8g
cmVjb25zaWRlciBpdHMgdW5wbHVnIHN0YW5jZS4NCg0KQWdyZWUuIENjIEFuc2h1bWFuLCBXaWxs
LCBDYXRhbGluLCBBcmQsIGluIGNhc2UgSSBtaXNzZWQgc29tZXRoaW5nIGluDQpBbnNodW1hbidz
IHBhdGNoZXMgYWRkaW5nIGFybTY0IG1lbW9yeSByZW1vdmUsIG9yIGlmIGFueSBwbGFucyB0byBy
ZW1vdmUNCnRoZSBsaW1pdGF0aW9uLg0KIA0KPiA+IEFub3RoZXIgdGhpbmcgdG8gdGhpbmsgYWJv
dXQgaXMgd2hldGhlciB0aGUga2VybmVsIHJlbGllcyBvbiBVRUZJIGhhdmluZyBmdWxseQ0KPiA+
IGRlc2NyaWJlZCBOVU1BIHByb3hpbWl0eSBkb21haW5zIGFuZCBlbmQtZW5kIE5VTUEgZGlzdGFu
Y2VzIGZvciBIRE0sDQo+ID4gb3Igd2hldGhlciB0aGUga2VybmVsIHdpbGwgcHJvdmlkZSBzb21l
IGluZnJhc3RydWN0dXJlIHRvIG1ha2UgdXNlIG9mIHRoZQ0KPiA+IGRldmljZS1sb2NhbCBhZmZp
bml0eSBpbmZvcm1hdGlvbiBwcm92aWRlZCBieSB0aGUgZGV2aWNlIGluIHRoZSBDb2hlcmVudCBE
ZXZpY2UNCj4gPiBBdHRyaWJ1dGUgVGFibGUgKENEQVQpIHZpYSBhIG1haWxib3gsIGFuZCB1c2Ug
dGhhdCB0byBhZGQgYSBuZXcgTlVNQSBub2RlIElEDQo+ID4gZm9yIHRoZSBIRE0sIGFuZCB3aXRo
IHRoZSBOVU1BIGRpc3RhbmNlcyBjYWxjdWxhdGVkIGJ5IGFkZGluZyB0byB0aGUgTlVNQQ0KPiA+
IGRpc3RhbmNlIG9mIHRoZSBob3N0IGJyaWRnZS9Sb290IHBvcnQgd2l0aCB0aGUgZGV2aWNlIGxv
Y2FsIGRpc3RhbmNlLiBBdCBsZWFzdA0KPiA+IHRoYXQncyBob3cgSSB0aGluayBDREFUIGlzIHN1
cHBvc2VkIHRvIHdvcmsgd2hlbiBrZXJuZWwgZG9lc24ndCB3YW50IHRvIHJlbHkNCj4gPiBvbiBC
SU9TIHRhYmxlcy4NCj4gDQo+IFRoZSBrZXJuZWwgY2FuIHN1cHBsZW1lbnQgdGhlIE5VTUEgY29u
ZmlndXJhdGlvbiBmcm9tIENEQVQsIGJ1dCBub3QgaWYNCj4gdGhlIG1lbW9yeSBpcyBhbHJlYWR5
IGVudW1lcmF0ZWQgaW4gdGhlIEVGSSBNZW1vcnkgTWFwIGFuZCBBQ1BJDQo+IFNSQVQvSE1BVC4g
QXQgdGhhdCBwb2ludCBDREFUIGlzIGEgbm9wIGJlY2F1c2UgdGhlIEJJT1MgaGFzIHByZWNsdWRl
ZA0KPiB0aGUgT1MgZnJvbSBjb25zdW1pbmcgaXQuDQoNClRoYXQgbWFrZXMgc2Vuc2UuDQoNCj4g
PiBBIHNpbWlsYXIgcXVlc3Rpb24gb24gTlVNQSBub2RlIElEIGFuZCBkaXN0YW5jZXMgZm9yIEhE
TSBhcmlzZXMgZm9yIENYTA0KPiBob3RwbHVnLg0KPiA+IFdpbGwgdGhlIGtlcm5lbCByZWx5IG9u
IENEQVQsIGFuZCBjcmVhdGUgaXRzIG93biBOVU1BIG5vZGUgSUQgYW5kIHBhdGNoIHVwDQo+ID4g
ZGlzdGFuY2VzLCBvciB3aWxsIGl0IHJlbHkgb24gQklPUyBwcm92aWRpbmcgUFhNIGRvbWFpbiBy
ZXNlcnZlZCBhdCBib290IGluDQo+ID4gU1JBVCB0byBiZSB1c2VkIGxhdGVyIG9uIGhvdHBsdWc/
DQo+IA0KPiBJIGRvbid0IGV4cGVjdCB0aGUga2VybmVsIHRvIG1lcmdlIGFueSBDREFUIGRhdGEg
aW50byB0aGUgQUNQSSB0YWJsZXMuDQo+IEluc3RlYWQgdGhlIGtlcm5lbCB3aWxsIG9wdGlvbmFs
bHkgdXNlIENEQVQgYXMgYW4gYWx0ZXJuYXRpdmUgbWV0aG9kDQo+IHRvIGdlbmVyYXRlIExpbnV4
IE5VTUEgdG9wb2xvZ3kgaW5kZXBlbmRlbnQgb2YgQUNQSSBTUkFULiBUaGluayBvZiBpdA0KPiBs
aWtlIExpbnV4IHN1cHBvcnRpbmcgYm90aCBBQ1BJIGFuZCBPcGVuIEZpcm13YXJlIE5VTUEgZGVz
Y3JpcHRpb25zIGF0DQo+IHRoZSBzYW1lIHRpbWUuIENEQVQgaXMgaXRzIG93biBOVU1BIGRlc2Ny
aXB0aW9uIGRvbWFpbiB1bmxlc3MgQklPUyBoYXMNCj4gYmx1cnJlZCB0aGUgbGluZXMgYW5kIHBy
ZS1pbmNvcnBvcmF0ZWQgaXQgaW50byBTUkFUL0hNQVQuIFRoYXQgc2FpZCBJDQo+IHRoaW5rIHRo
ZSBDWEwgYXR0YWNoZWQgbWVtb3J5IG5vdCBkZXNjcmliZWQgYnkgRUZJIC8gQUNQSSBpcyBjdXJy
ZW50bHkNCj4gdGhlIE5VTEwgc2V0Lg0KDQpXaGF0IEkgbWVhbnQgYnkgcGF0Y2gvbWVyZ2Ugd2Fz
IGlmIG9uIGEgZHVhbCBzb2NrZXQgc3lzdGVtIHdpdGggZGlzdGFuY2UgNDANCmJldHdlZW4gdGhl
IHNvY2tldHMgKG5vdCBnZXR0aW5nIGludG8gSE1BVCB2cyBTTElUIGRlc2NyaXB0aW9uIG9mIGxh
dGVuY3kpLA0KaWYgeW91IGhvdHBsdWdnZWQgaW4gYSBDWEwgdHlwZTIvMyBkZXZpY2Ugd2hvc2Ug
Q0RBVCBzYXlzIGRldmljZSBsb2NhbCAnZGlzdGFuY2UnDQppcyA4MCwgdGhlbiB0aGUga2VybmVs
IGlzIHN0aWxsIG1lcmdpbmcgdGhhdCA4MCBpbiB3aXRoIHRoZSA0MCB0byB0aGUgcmVtb3RlIHNv
Y2tldA0KdG8gc2F5IDEyMCBmcm9tIHJlbW90ZSBzb2NrZXQgQ1BVIHRvIHRoaXMgc29ja2V0J3Mg
Q1hMIGRldmljZSBpLmUgd2hldGhlciB0aGUNCjQwIGNhbWUgZnJvbSBTTElUIG9yIEhNQVQsIGl0
IGlzIHN0aWxsIG1lcmdlZCBpbnRvIHRoZSBkYXRhIGtlcm5lbCBoYWQgb2J0YWluZWQNCmZyb20g
QUNQSS4gSSB0aGluayB5b3UncmUgc2F5aW5nIHRoZSBzYW1lIHRoaW5nIGluIGEgZGlmZmVyZW50
IHdheToNCnRoYXQgdGhlIGRldmljZSBsb2NhbCBwYXJ0IGlzIG5vdCBiZWluZyBtZXJnZWQgd2l0
aCBhbnl0aGluZyBBQ1BJIHByb3ZpZGVkIGZvciANCnRoZSBkZXZpY2UsIGV4YW1wbGUgX1NMSSBh
dCB0aW1lIG9mIGhvdHBsdWcgKHdoaWNoIEkgYWdyZWUgd2l0aCkuDQoNClZpa3JhbQ0K
