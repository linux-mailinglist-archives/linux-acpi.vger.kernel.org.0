Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D870C20D18
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2019 18:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfEPQe2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 May 2019 12:34:28 -0400
Received: from mail-eopbgr770118.outbound.protection.outlook.com ([40.107.77.118]:45543
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726342AbfEPQe1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 16 May 2019 12:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uwy.onmicrosoft.com;
 s=selector1-uwy-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcwnDHlTtpWNtv7Xnb76RryX60mnSSYsTQklO5mlDWE=;
 b=p6TRE0sZJcu1f3l/ueCVDeapOsiVImMjcAm4MocrW5pTBwB3FKsYrPA1yLyaZoQbjHQE+i4bZcpIThNATk4UD9TUHPg6Q5B672BGtz9yiaKB62psc/fhq8VuhyIctPrrTYrCslHaYg8egfRWZRjLyT9HnQdGF9sBqhbriFkEfYk=
Received: from DM6PR05MB5259.namprd05.prod.outlook.com (20.177.223.223) by
 DM6PR05MB5500.namprd05.prod.outlook.com (20.176.122.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.13; Thu, 16 May 2019 16:34:25 +0000
Received: from DM6PR05MB5259.namprd05.prod.outlook.com
 ([fe80::ec12:ed89:3597:ef2f]) by DM6PR05MB5259.namprd05.prod.outlook.com
 ([fe80::ec12:ed89:3597:ef2f%5]) with mapi id 15.20.1922.002; Thu, 16 May 2019
 16:34:24 +0000
From:   "Robert R. Howell" <RHowell@uwyo.edu>
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI / LPSS: Don't skip late system PM ops for hibernate
 on BYT/CHT
Thread-Topic: [PATCH] ACPI / LPSS: Don't skip late system PM ops for hibernate
 on BYT/CHT
Thread-Index: AQHU6eBClqunF/byekqefGejWfaC+aYqIfOAgAcThICAAL18AIAFeNOAgAp38wCAAktGAIAFVH4AgADH4wCAAL1BAIACLkCAgAe6cICADXkegIAASjYAgACcTYCABaqjgIAFO8IA
Date:   Thu, 16 May 2019 16:34:24 +0000
Message-ID: <7cadac12-5909-1112-169c-a7917ac95bd6@uwyo.edu>
References: <20190403054352.30120-1-kai.heng.feng@canonical.com>
 <eb1462c9-ebef-7bd6-c263-3f4f2e8ba63d@redhat.com>
 <b6cd67d7-a4de-0fab-4512-25d732190d17@uwyo.edu>
 <feb1808d-542c-83c2-5c70-9228473bb8d0@redhat.com>
 <0a770539-dfe9-2eb6-a90a-82f065a23a3f@uwyo.edu>
 <f6db39bc-b8d1-fda8-ad37-a8b050ef0027@redhat.com>
 <37aee883-1253-adad-82b4-4a578cc72825@uwyo.edu>
 <CAJZ5v0j9U20cFbRx6QKeQv6wyDg6nL71L0U_Rec5+W1JoD8-=w@mail.gmail.com>
 <144b56d4-54e6-bccd-4652-22303bcd9168@uwyo.edu>
 <CAJZ5v0jJEovXXiqs-tzPC7FsGjGL+qxfXCxbTrQZqAxSCv1oyQ@mail.gmail.com>
 <beab21cb-9f89-b934-e0a4-2fd85c69f4e6@uwyo.edu>
 <4fb5fc2e-e5af-6732-0228-8c73beed1afb@redhat.com>
 <c3dadc9d-bf3b-c992-f256-94a25fea570a@uwyo.edu>
 <1bb008bd-ae0d-d351-ef0c-303e23b0eca5@redhat.com>
 <cc1dacb5-ef0f-61c4-6187-99ee1da55d92@uwyo.edu>
 <8e5b82ce-4120-4d81-fd8c-26a16cfe3381@redhat.com>
In-Reply-To: <8e5b82ce-4120-4d81-fd8c-26a16cfe3381@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-originating-ip: [12.203.174.10]
x-clientproxiedby: BYAPR05CA0095.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::36) To DM6PR05MB5259.namprd05.prod.outlook.com
 (2603:10b6:5:7f::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RHowell@uwyo.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c031cc50-1a65-48ce-bd02-08d6da1c5b55
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:DM6PR05MB5500;
x-ms-traffictypediagnostic: DM6PR05MB5500:
x-microsoft-antispam-prvs: <DM6PR05MB55004B6641FE04D6727655A9D30A0@DM6PR05MB5500.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(136003)(346002)(396003)(51444003)(189003)(199004)(316002)(476003)(11346002)(2616005)(75432002)(6246003)(786003)(73956011)(81166006)(305945005)(68736007)(8676002)(81156014)(229853002)(66066001)(71200400001)(65806001)(53936002)(6512007)(80792005)(66946007)(66476007)(66446008)(66556008)(186003)(5660300002)(25786009)(31696002)(446003)(7736002)(26005)(64756008)(36756003)(7520500002)(71190400001)(65956001)(8936002)(86362001)(110136005)(31686004)(486006)(6116002)(3846002)(6486002)(14444005)(99286004)(52116002)(72206003)(256004)(4326008)(478600001)(54906003)(58126008)(65826007)(88552002)(14454004)(102836004)(53546011)(6436002)(2906002)(6506007)(64126003)(76176011)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR05MB5500;H:DM6PR05MB5259.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: uwyo.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tBLu5cM7IHhi9gxittFNWg7MfYie7N+o3WQ91LxmgmG267/injFaX93yqkvBhAFnc1w/MVebHz3QNkJnlQWOoUStmZBY4BYFQohr1SQzYsibzBY6m4oEiYcm6lo51Ncevpa4v94pjvu1YrnskJbB+y/lwIW69+w4Q1tRN8t2V1RVpY3McaD47n/BzGUcylWfq7rCtaUGhQ4Pbz6qpE9IWGrrkDS+OiorlHV2yFHECqwzTHQkd0+Z56nWOhAv5LkA+xfC6J4YxCXFODS4tT1R+6IFY8Uie3y78oFmYWTkEasDXvYIKhSLBqsoL8VzKL5GCIvLOzKEQjYKWyzcY3GhpIBqMf3o8UhzxAAbvilNfS6w7uFYRReSo40zBxA/xZsW8FigKF0yNjJoA2i1nMqFds3U6n1hdOqDH0Dhk3ppGUY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66A5BF6976067040B6D755A1B36E203A@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: uwyo.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: c031cc50-1a65-48ce-bd02-08d6da1c5b55
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 16:34:24.8287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f9cdd7ad-825d-4601-8e9c-a325e02d52da
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB5500
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGkgSGFucw0KDQpPbiA1LzEzLzE5IDI6NDEgQU0sIEhhbnMgZGUgR29lZGUgd3JvdGU6DQoNCj4g
DQo+IEhpIFJvYmVydCwNCj4gDQo+IE9uIDA5LTA1LTE5IDIwOjA5LCBSb2JlcnQgUi4gSG93ZWxs
IHdyb3RlOg0KPj4gSGkgSGFucw0KPj4NCj4+IE9uIDUvOS8xOSAyOjUwIEFNLCBIYW5zIGRlIEdv
ZWRlIHdyb3RlOg0KPj4NCj4+Pg0KPj4+IEhpLA0KPj4+DQo+Pj4gT24gMDktMDUtMTkgMDY6MjQs
IFJvYmVydCBSLiBIb3dlbGwgd3JvdGU6DQo+Pj4+IE9uIDQvMzAvMTkgODozOSBBTSwgSGFucyBk
ZSBHb2VkZSB3cm90ZToNCj4+Pj4+DQo+Pg0KPj4+Pj4NCj4+Pj4+IEkndmUganVzdCB0cmllZCB0
byByZXByb2R1Y2UgdGhlICJFcnJvciBpMmNfZHdfeGZlciBjYWxsIHdoaWxlIHN1c3BlbmRlZCIg
ZXJyb3INCj4+Pj4+IG9uIHN1c3BlbmQvcmVzdW1lIG9uIG15IG93biBUMTAwVEEgYW5kIEkgY291
bGQgbm90IHJlcHJvZHVjZSB0aGlzLg0KPj4+Pj4NCj4+Pj4+IENhbiB5b3UgdHJ5IHdpdGhvdXQg
dGhlIEJUIGtleWJvYXJkIHBhaXJlZCBhbmQgd2FraW5nIHVwIGZyb20gc3VzcGVuZCB1c2luZyB0
aGUNCj4+Pj4+IHRhYmxldCBwYXJ0J3MgcG93ZXItYnV0dG9uID8NCj4+Pj4+DQo+Pj4+PiBBbHNv
IGRvIHlvdSBzdGlsbCBoYXZlIHRoZSBzY3JpcHRzIHRvIHJtbW9kIHNvbWUgbW9kdWxlcyBiZWZv
cmUgc3VzcGVuZCA/DQo+Pj4+Pg0KPj4+Pg0KPj4+PiBUaGUgVDEwMFRBIGtleWJvYXJkIGlzIGFj
dHVhbGx5IGEgaGFyZHdpcmVkIGNvbm5lY3Rpb24gcmF0aGVyIHRoYW4gQmx1ZXRvb3RoIGJ1dCBJ
DQo+Pj4+IGRpZCBwaHlzaWNhbGx5IGRpc2Nvbm5lY3QgdGhlIGtleWJvYXJkLCBhbmQgYWxzbyB1
bnBhaXJlZCBhbGwgdGhlIGFjdHVhbCBCbHVldG9vdGgNCj4+Pj4gZGV2aWNlcyAoc3VjaCBhcyB0
aGUgbW91c2UpIGFuZCB0aGVuIHBvd2VyZWQgZG93biB0aGUgVDEwMFRBIGJsdWV0b290aCBhZGFw
dGVyLg0KPj4+PiBXaGVuIEkgc3VzcGVuZCwgdGhlbiByZXN1bWUgdXNpbmcgdGhlIHRhYmxldCBw
b3dlciBidXR0b24sIEkgc3RpbGwgZ2V0IHRoZQ0KPj4+PiBpMmNfZHdfeGZlcmVycm9yIGVycm9y
IGR1cmluZyB0aGUgcmVzdW1lLsKgIEJ1dCB3aGF0ZXZlciBjYXVzZXMgdGhpcyBlcnJvciBpc24n
dCBmYXRhbCwNCj4+Pj4gaW4gdGhlIHNlbnNlIHRoYXQgYWZ0ZXIgcmVzdW1lIHRoZSBzb3VuZCBh
bmQgb3RoZXIgaTJjIGZ1bmN0aW9ucyBkbyBzdGlsbCB3b3JrIE9LLg0KPj4+Pg0KPj4+PiBXaGls
ZSBJIGFsd2F5cyBnZXQgdGhpcyBpMmNfZHdfeGZlciBlcnJvciBvbiByZXN1bWUgZnJvbSBzdXNw
ZW5kIG9yIGhpYmVybmF0aW9uIG9uIHRoZSBUMTAwVEEsDQo+Pj4+IEkgYWxzbyBoYXZlIGEgVDEw
MFRBTSBhbmQgY3VyaW91c2x5LCBpdCBORVZFUiBzaG93cyB0aGF0IGVycm9yIC0tIGFsdGhvdWdo
IGFsbCB0aGUNCj4+Pj4gb3RoZXIgc3VzcGVuZCBhbmQgaGliZXJuYXRlIGJlaGF2aW9yIHNlZW1z
IHNpbWlsYXIuwqAgSSdtIG5vdCBzdXJlIGlmIHRoZSBmb2xsb3dpbmcgY291bGQNCj4+Pj4gYmUg
dGhlIGRpZmZlcmVuY2UsIGJ1dCB0aGUgVDEwMFRBIHVzZXMgYW4gaTJjIGNvbm5lY3RlZCBBVE1M
MTAwMCB0b3VjaHNjcmVlbiBjb250cm9sbGVyDQo+Pj4+IHdoaWxlIHRoZSBUMTAwVEFNIHVzZXMg
YW4gaTJjIGNvbm5lY3RlZCBTSVMwODE3IHRvdWNoc2NyZWVuIGNvbnRyb2xsZXIuwqAgT3RoZXIg
dGhhbiB0aGF0DQo+Pj4+IHRoZSBoYXJkd2FyZSBzZWVtcyBhbG1vc3QgaWRlbnRpY2FsLg0KPj4+
DQo+Pj4gSSd2ZSBiZWVuIHRlc3Rpbmcgb24gYW4gYWN0dWFsIFQxMDBUQSwgd2l0aCB0aGUgQVRN
TDEwMDAgdG91Y2hzY3JlZW4gY29udHJvbGxlci4NCj4+Pg0KPj4+IE1heWJlIGl0IGlzIGEgZGlm
ZmVyZW5jZSBpbiBCSU9TIHZlcnNpb24sIG15IFQxMDBUQSBpcyBydW5uaW5nIHRoZSBsYXRlc3Qg
QklPUywgd2hhdA0KPj4+IGlzIHRoZSBvdXRwdXQgb2Y6DQo+Pj4NCj4+PiBjYXQgL3N5cy9jbGFz
cy9kbWkvaWQvYmlvc192ZXJzaW9uIC9zeXMvY2xhc3MvZG1pL2lkL2Jpb3NfZGF0ZQ0KPj4+DQo+
PiBPbiB0aGUgVDEwMFRBIHdoaWNoIHNob3dzIHRoZSBpMmNfZHdfeGZlciBlcnJvciB0aGUgYWJv
dmUgY2F0IHJlcG9ydHM6DQo+PiBUMTAwVEEuMzA3DQo+PiAwNS8wOS8yMDE0DQo+Pg0KPj4gd2hp
bGUgdGhlIFQxMDBUQSB3aGljaCBkb2VzIE5PVCBzaG93IHRoZSBpMmNfZHdfeGZlciBlcnJvciBy
ZXBvcnRzOg0KPj4gVDEwMFRBTS4yMDUNCj4+IDA3LzI1LzIwMTQNCj4+Pg0KPj4+IEFsc28gZG8g
eW91IHBlcmhhcHMgaGF2ZSBhIG1pY3Jvc2QgY2FyZCBpbnNlcnRlZD/CoCAoSSdtIHRyeWluZyB0
byBmaWd1cmUgb3V0IHRoZQ0KPj4+IGRpZmZlcmVudCBiZXR3ZWVuIG91ciBzZXR1cHMgc28gdGhh
dCBJIGNhbiBob3BlZnVsbHkgcmVwcm9kdWNlIHRoZSBpc3N1ZSBteXNlbGYpLg0KPj4+DQo+PiBJ
IGRvIGhhdmUgYSBtaWNyb3NkIGNhcmQgaW5zZXJ0ZWQgaW4gYm90aCB0aGUgVDEwMFRBIGFuZCB0
aGUgVDEwMFRBTS4NCj4gDQo+IEFoLCBvayBJIGFscmVhZHkgc3VzcGVjdGVkIHRoYXQgYW5kIEkg
dGhpbmsgdGhhdCBpcyB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVuIG91cg0KPiAyIHNldHVwcy4gSSB3
aWxsIHRyeSB0byByZXByb2R1Y2UgdGhlIHN1c3BlbmQvcmVzdW1lIHByb2JsZW0gYWdhaW4gd2l0
aCBhIG1pY3Jvc2QNCj4gY2FyZCBpbnNlcnRlZCBhbmQgbW91bnRlZC4NCj4gDQo+Pj4+IFJlZ2Fy
ZGluZyBzY3JpcHRzLCB3aGlsZSBJIGRvIHN0aWxsIG5lZWQgYSBzeXN0ZW1kIGhpYmVybmF0ZSBz
Y3JpcHQgd2hpY2ggcmVtb3ZlcyB0aGUNCj4+Pj4gYnJjbWZtYWMgYW5kIHRoZSBoY2lfdWFydCAo
Ymx1ZXRvb3RoIHJlbGF0ZWQpIGRyaXZlcnMsIEkndmUgZm91bmQgdGhhdCBJIG5vIGxvbmdlciBu
ZWVkDQo+Pj4+IGFueSBzY3JpcHQgZm9yIHN1c3BlbmQuDQo+Pj4NCj4+PiBPaywgc28geW91IGFy
ZSBub3QgZG9pbmcgYW55IHJtbW9kLXMgb24gc3VzcGVuZCwgcmlnaHQ/DQo+Pj4NCj4+IENvcnJl
Y3QgLS0gSSBhbSBOT1QgdXNpbmcgYSBzY3JpcHQgYW5kIGFtIG5vdCBkb2luZyBhbnkgZXhwbGlj
aXQgcm1tb2QncyBvbiBzdXNwZW5kLCBqdXN0IG9uIGhpYmVybmF0ZS4NCj4+PiBSZWdhcmRzLA0K
Pj4+DQo+Pj4gSGFucw0KPj4NCj4+IEFsbCBteSBwcmV2aW91cyB0ZXN0cyB3ZXJlIGRvbmUgdXNp
bmcgYSA1LjEuMC1yYzUsIDUuMS4wLXJjMywgb3IgZWFybGllciBrZXJuZWwuDQo+PiBCdXQgSSBq
dXN0IGNvbXBpbGVkIHRoZSByZWxlYXNlZCA1LjEuMCBrZXJuZWwgYW5kIHRoZSBiZWhhdmlvciBo
YXMgY2hhbmdlZCBmb3IgdGhlIFQxMDBUQSwNCj4+IHJlc3VsdGluZyBpbiBhIGRpZmZlcmVudCBp
MmMgZXJyb3IgYW5kIGEgY2FsbCB0cmFjZS7CoCAoSSBzdGlsbCBjb250aW51ZSB0byBOT1Qgc2Vl
IGFueQ0KPj4gc3VzcGVuZC9yZXN1bWUgZXJyb3JzIG9uIHRoZSBUMTAwVEFNLikNCj4gDQo+IFRo
aXMgaXMgZXhwZWN0ZWQgd2UgY2hhbmdlZCAvIGltcHJvdmVkIHRoZSBjb2RlIGdlbmVyYXRpbmcg
dGhlOg0KPiAiaTJjX2Rlc2lnbndhcmUgODA4NjBGNDE6MDA6IFRyYW5zZmVyIHdoaWxlIHN1c3Bl
bmRlZCINCj4gDQo+IFdhcm5pbmcgdG8gaW5jbHVkZSBhIHRyYWNlLCBzbyB0aGF0IHdlIGtub3cg
d2hpY2ggY29kZSBpbml0aWF0ZWQgdGhlIHRyYW5zZmVyLA0KPiB3aGljaCwgYXMgbW9yZSBvciBs
ZXNzIGV4cGVjdGVkLCBpcyB0aGUgQUNQSSBzdWJzeXN0ZW0sIGxpa2Ugc29tZSBwb3dlcl9vbiAo
X1BTMCkNCj4gb3Igb2ZmIChfUFMzKSBtZXRob2QuDQo+IA0KPj4gTm90ZSB0aGF0IGZvciBhbGwg
dGhlIHRlc3RzIGRlc2NyaWJlZCBpbiB0aGlzIG1lc3NhZ2UgSSdtIGFwcGx5aW5nIHlvdXIgcGF0
Y2gNCj4+IHJlZ2FyZGluZyAucG93ZXJvZmZfbm9pcnEgYW5kIC5yZXN0b3JlX25vaXJxLCBhbmQg
SSdtIGFwcGx5aW5nIG15IG93biBwYXRjaCByZW1vdmluZyB0aGUNCj4+IERQTV9GTEFHX1NNQVJU
X1NVU1BFTkQgZmxhZy7CoCBJIGhhdmVuJ3QgeWV0IHRyaWVkIHRvIGV4cGxvcmUgdmFyeWluZyB0
aG9zZSBwYXRjaGVzDQo+PiBmb3IgdGhlIDUuMS4wIHJlbGVhc2UgYXMgSSBkaWQgZm9yIHRoZSBl
YXJsaWVyIHJjJ3MsIGFzIGRlc2NyaWJlZCBpbiBwcmV2aW91cyBtZXNzYWdlcy4NCj4gDQo+IEht
bSwgZm9yIGZ1dHVyZSB0ZXN0aW5nIHBsZWFzZSBsZWF2ZSBvdXQgdGhlIHBhdGNoIHJlbW92aW5n
IHRoZSBEUE1fRkxBR19TTUFSVF9TVVNQRU5EDQo+IGZsYWcuIFVzdWFsbHkgd2hlbiBhc2tpbmcg
eW91IHRvIHRlc3Qgc29tZXRoaW5nIHdlIGFzc3VtZSB5b3UgYXJlIHVzaW5nIGEgcHJpc3RpbmUg
a2VybmVsLg0KPiBXaGF0IGRvZXMgdGhhdCBwYXRjaCBhdHRlbXB0IHRvIGZpeCBhbmQgd2hhdCBo
YXBwZW5zIGR1cmluZyBzdXNwZW5kL3Jlc3VtZSB3aXRob3V0IGl0ID8NCj4gDQpSZW1vdmluZyB0
aGUgRFBNX0ZMQUdfU01BUlRfU1VTUEVORCBmaXhlcyBhbiBpMmNfZGVzaWdud2FyZSB0aW1lb3V0
IG9uIHRoZSBUMTAwVEEgYW5kIFRBTSBzeXN0ZW1zIA0Kd2hlbiByZXN1bWluZyBmcm9tIGhpYmVy
bmF0aW9uLiAgVGhhdCdzIGRldGFpbGVkIGluIGFuIGVhcmxpZXIgbWVzc2FnZSBvZiBtaW5lIGlu
IHRoaXMgdGhyZWFkLCBhbmQgYWxzbyANCmlzIHF1b3RlZCBtb3JlIGNvbXBsZXRlbHkgaW4gYSBy
ZXBseSBJJ20gYWJvdXQgdG8gc2VuZCB0byBSYWZhZWwuICBGcm9tIGEgdXNhYmlsaXR5IHBlcnNw
ZWN0aXZlIHRoZQ0KcmVzdW1lLWZyb20taGliZXJuYXRlIGkyY19kZXNpZ253YXJlIHRpbWVvdXQg
ZXJyb3JzIHdlcmUgbW9yZSBzZXJpb3VzLCBzaW5jZSB0aGV5IGRpc2FibGVkIHNvdW5kIA0KdGls
bCBJIHJlYm9vdGVkLCB3aGlsZSB0aGUgc3VzcGVuZC9yZXN1bWUgIlRyYW5zZmVyIHdoaWxlIHN1
c3BlbmRlZCIgZXJyb3Igd2FzIGp1c3QgYSBtaW5vciANCmFubm95YW5jZSBpbiB0aGUgbG9nLCBz
aW5jZSBpdCBkaWRuJ3QgU0VFTSB0byBjYXVzZSBzdWJzZXF1ZW50IHByb2JsZW1zLg0KDQpJZiB0
aGUgcGF0Y2ggdGhhdCBSYWZhZWwganVzdCBwcm92aWRlZCBkb2Vzbid0IGZpeCB0aGVzZSBpc3N1
ZXMgKEknbSB0cmF2ZWxpbmcgYWdhaW4gc28gaXQgd2lsbCBiZSBhIA0KY291cGxlIGRheXMgYmVm
b3JlIEknbSBob21lIGFuZCBjYW4gdGVzdCBpdCkgSSdsbCB0cnkgc29tZSBmdXJ0aGVyIGV4cGVy
aW1lbnRzIGFuZCBJIG1pZ2h0IGhhdmUgYSANClQxMDBUQSB3aGVyZSBJIGNhbiBpbnN0YWxsIGEg
bW9yZSByZWNlbnQgQklPUyBhbmQgc2VlIHdoYXQgYWZmZWN0IHRoYXQgaGFzLiANCiANCj4gUmVn
YXJkcywNCj4gDQo+IEhhbnMNCj4gDQoNClRoYW5rcyBhZ2FpbiBmb3IgdGVzdGluZyB0aGlzIG9u
IHlvdXIgbWFjaGluZS4NCg0KQm9iIEhvd2VsbA0K
