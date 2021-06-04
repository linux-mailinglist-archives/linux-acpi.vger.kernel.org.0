Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C49939BFDB
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jun 2021 20:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhFDSua (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Jun 2021 14:50:30 -0400
Received: from mail-dm6nam12on2052.outbound.protection.outlook.com ([40.107.243.52]:63457
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229810AbhFDSu3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Jun 2021 14:50:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9LrK2yhPhk3wZB7TCarvBWBs6mCspYncceTEdQXO4ZJpMYn/kEcrKb6kVQ8BvtWaef89/tj9wxY4rfpD0JpJJpRaRJllswDJnhVyNh5c5GaiZH1kqXR44AHfZhxDgy3JqdUSVgZoO3NxB6G+Odv4inltbNG5avh9616hZ/42DZcT+5YzGY20WSP90L5AWomDrlPhAJ9BFsKfg9EsNBCQhXYTqxdOlONH0Bd7YRrJO/tc/S09doovBrk65dObA+CjOobdRAfk0zShHbfcgAIX0Afien2U+A3QLhHke2DqoUPDmUKXaavZDTyiiuh4YTMn0x3zXd+ODQ3IQc0Akqw0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9gfk0wT6bnhJ0XyCr2OsDjY/51H8YtzZpIxz8dod2k=;
 b=SE/CP30XRGcNYa/5oHLYTdnj9TNKojJFigkBSsgHXcWr/Y8VzahBDWeUF7kaciujPT0pINrdElxHPLoP/Tp4dh/LNAgmSUD9TRiF2YMy5NBnHEiyR8MMllrjUGwnHHQMIVnhI0Tfpae5LgYDdscOrecahok4qdwczexNdSW6Tl63KOFiE/U8rmJW+XnhcXDb8rWCIs9k9+0qrl9RKpw7WKRx1jts3EzDvRHJv9OuLHA1cv8uZpYqfTFFTXjUGw2RcX1LYFMgts6o+LBRfmok94t6Qfq5UQyr5wkYtuciULGP1z/4FBInoZAXfv3dg8974muAYoJiXChmbUvEJvGVdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9gfk0wT6bnhJ0XyCr2OsDjY/51H8YtzZpIxz8dod2k=;
 b=PGrVk7xsduKeIs70RFZ2qg79Pbl00RAen9SeHNBfeUFKywggTPP7AF3pbF6dzsZAgVSL7EKaIUv7GjLzWIfHXulrY+Z042uF5qo0aSyPa+ZF+ycnLW1IJebGtaWrxMiD2C22vhCD9PWAZRL0RJ+S4s/QsWVQa8MO30s9OQwFFak=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Fri, 4 Jun
 2021 18:48:41 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%9]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 18:48:41 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Raul Rangel <rrangel@chromium.org>
CC:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "david.e.box@linux.intel.com" <david.e.box@linux.intel.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Liang, Prike" <Prike.Liang@amd.com>,
        Julian Sikorski <belegdol@gmail.com>
Subject: RE: [PATCH v5 2/2] acpi: PM: Add quirks for AMD Renoir/Lucienne CPUs
 to force the D3 hint
Thread-Topic: [PATCH v5 2/2] acpi: PM: Add quirks for AMD Renoir/Lucienne CPUs
 to force the D3 hint
Thread-Index: AQHXWWJADYBNW8WMtkuzG8HMlelIgasEH2QAgAAEIYCAAAk54A==
Date:   Fri, 4 Jun 2021 18:48:41 +0000
Message-ID: <MN2PR12MB4488E83A1117FBD5DDA51FF4F73B9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210604165403.2317-1-mario.limonciello@amd.com>
 <20210604165403.2317-2-mario.limonciello@amd.com>
 <CAHQZ30BWzY=oLvOtj==uinW2Fu__skuoLNYhz5NmDg=oRwq4Sw@mail.gmail.com>
 <acd70140-aac1-bde2-225c-1a8c1c272753@amd.com>
In-Reply-To: <acd70140-aac1-bde2-225c-1a8c1c272753@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-06-04T18:48:37Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=84415ea8-8da5-476a-8b1f-46cf03ca2ec2;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.10.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: afa477fc-c194-43a7-3af9-08d927895f5d
x-ms-traffictypediagnostic: BL0PR12MB4849:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB484904A128EF845919B96B16F73B9@BL0PR12MB4849.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qE/TLOnGq6ODsYBx97vPgMw7WPl73GgNVTCxEZXQuZugRGA3uFjI/pMpk7tqJS86KVCX0DA23z8BeGROKLB/w05OiNjpGtbJk7n+67zFljW7DudNmwZZfVNPr+NOqdroDmhvb6/yh/lDa0yBYPuxs6Fc4GP8jBXYDC2YEjdW7BSVCd/uiPLYqEVIgZA9UIQHoY3A4KIWAFZ4lCQ0XG4O8+ZI9qGkCJ9cDP5ltgow2ZkrvFNhUU3uxbjOuoRC11a9WESv/BRnLKoIBi0zDEmo7kvt5/YAsAefe4wzF8AG3zUE4Pm0WtIp4aljQigzrPtwZu6nhHwCS2bduRb8QVFeXHo5RGDjaAZmnD/nncdLBcb30SQf/p5BwfDwvxHgxeM/xp3Td7dwLyXKMPvDoSxjOeqRsk137UCpoRP05W/IF172OyMXMHnU9rXYFEgsokFVStDUGXoCa4av8JynXn/4fxQJSdNXeye7sB0dLSc/J4hoqlsfAmjSftwkzut7m/i+140lViSxuS6MMQ2v6t4KAHXdo0MHuL8qqbHC8SaMat5Hxs8K2oSphLA/nikVvYplWYa1Cza0yLyn4P36iC4Ogvr+ZY11IoqeF8PoObfyIAY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(7416002)(316002)(66556008)(2906002)(110136005)(55016002)(66476007)(5660300002)(66446008)(76116006)(66946007)(54906003)(64756008)(52536014)(122000001)(33656002)(53546011)(71200400001)(38100700002)(8936002)(7696005)(8676002)(478600001)(4326008)(186003)(83380400001)(86362001)(26005)(9686003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?K2NUdUpzT0hBTStKOGsyNEdCbXpON3FCbW1XRzNFV1VXNVRKcmFuTzlOU0x3?=
 =?utf-8?B?S2t1clAwWmlENEQvS0FHWWw3QXFwL1JjaW8rYThXYlN3RXcva3B2Qm9QdnUr?=
 =?utf-8?B?R1JNMG5BbmFIZmo2M081aERZWFNMN2tJaERhUWJpb0p1Y2pjZDFYWFVEaE1q?=
 =?utf-8?B?UTdFbW9sOXdKUU9MbTVJL2dVdnpXODJIazR6SVR0VTNDWGl2V1RDak9tOHlm?=
 =?utf-8?B?cGdlMmFQc2lVdk41OTA0bGFUQ2lPUkUrNXdCOEdveHFSWDFQNm9US3F4WXAx?=
 =?utf-8?B?R0c3SXdIWDh1SWh1cXFvSkFPYTBXelhUTy9Ubm9yZUtRRHpPMm9aMU5Oc2NX?=
 =?utf-8?B?aEkyMDFjdDhWUTRwYjYzTUhLMUZVQm1YSlFNNXBzTUQyc1I5Y3Y1OXBpRktJ?=
 =?utf-8?B?SllhWTJPdlJMS2wvbW82cGtZM21aWEV5Y3pYZzNJeW1jUHl6d21uTXRCdHhL?=
 =?utf-8?B?V1YrWjE3ais5ZDVYdHFXZmkyRUFHelVTREo2SFZpK3BIWUt0NkVZYk1mbjN3?=
 =?utf-8?B?citvaVRuV3liajBHQWc3aTRZOHRrRWNpODRJdG5ZWStONGlFUGhuWldrTHM5?=
 =?utf-8?B?eDZiU3dKQnlab3RISUtaQ0FHa3FidFE2SzI3YXFkdG1WZkV6NEdsWTdnczFo?=
 =?utf-8?B?Mnplb1JiZklFNThiT2ZEQUlua3dVM1ZuYjQ0MHBqVzk1YTBxc0FJVW9KclFY?=
 =?utf-8?B?dTR5K256dDN1WXZqcDhVL2JPeUZpNVp2ZTZ5dnVpaEQrd0pQM0FCMTgxeGcz?=
 =?utf-8?B?dFZyTmpQcGdsWStNZGVYQXJQMGx6b21aKzdKN3hHWUdpZTBlTGdOQWxiSkVY?=
 =?utf-8?B?a21uYnYrOVdrUjJ5TzcxYzV0aDU2ZlNiZUFxS3VuSU5VTDhZRDdITHI1Y2Vi?=
 =?utf-8?B?ckVwMTlXd25kV2pNSjgyUTQzYUMxN0NtVHVCVVNnUEFDZG11L2wxYUtDcm1M?=
 =?utf-8?B?S21sL2Rrem93Vyt1MlUxWm5TSVVwaFQ3Wmo0OGp6L1dNKzFHTURKdWx0VHp4?=
 =?utf-8?B?ai8yNk9rbzZJeW10WEZKUUlodmpvdHRONG91aUZ1RGFIbFU2MjVLTHgvWlpI?=
 =?utf-8?B?SWpSMEFQYXlPOHhzMGw1SGNUd0JlTUhIUlZzOWJON3RBcndETU9NdlFVajc4?=
 =?utf-8?B?aDk0ZGtyWTg0S25zQmd1Q09paVNFNWhCdDFxSGlYWmtpOTZ2dFRvZ0swL2kv?=
 =?utf-8?B?VXRQU0hxNHFnVFE0SG02d2NGc2QySFc3VkMrdzlsTkNQR3ZONFpXQTFXY0p5?=
 =?utf-8?B?d05lVkM4ZkthSVBDWkF5VVpFK0E0ejJwN3lJaDA4SDZtbElqM0NsVit5RGNl?=
 =?utf-8?B?eXBVMFk4emdZNFp4eGN3MTBIREZtZFFoa0htTE5KVlBRaWZtM0t6QSszRlZj?=
 =?utf-8?B?MGpMRUZVYS85RTFpVkFuWmhFMU0zT2ludmF5VXdIdGxWaDVVOG4zME81R1p2?=
 =?utf-8?B?U1RnTG1mQUNGQmRFekdkOFBUZlI0VjFsQXRmRW9oSG84eFFKYmZ1TUhJYU9n?=
 =?utf-8?B?SE41azMxOHpLd0N2L05RY0FrZFBJQlpwYjdvckxOZHA0K0ZicnlhRnNLNFcv?=
 =?utf-8?B?MXRWSHdYdUMxa2ZYZjczaEorTmcvQXBGZ1lTWFV4T05salRhKzkvbkhoZ0Fz?=
 =?utf-8?B?d0x0MDhCTW1RU0VCNG0vRjBkN01ndTBmZUZVOE11Qkxpd0ZPYXBmdkNpOW4v?=
 =?utf-8?B?Q2FKS21aZjAzemtwMjNHWE1WL0twQXJDdjhiNlpUTUpFSVMxWHBBYUlQRThE?=
 =?utf-8?Q?6iRxKAvZOIjOgbgOyq/ecmSn1oZ7vqkSGBBsuO9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa477fc-c194-43a7-3af9-08d927895f5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 18:48:41.1861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: erFVF9HT1HPJRuClEDrmZVRsxWTXoQ+/6TG7FujQujKM8kVdcIsawyZ8h1ZxvVR3vhmW5dtjFG2dbGs0cPPG9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4849
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

W0FNRCBQdWJsaWMgVXNlXQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT4NCj4gU2VudDog
RnJpZGF5LCBKdW5lIDQsIDIwMjEgMTo1OCBQTQ0KPiBUbzogUmF1bCBSYW5nZWwgPHJyYW5nZWxA
Y2hyb21pdW0ub3JnPg0KPiBDYzogS2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPjsgSmVu
cyBBeGJvZSA8YXhib2VAZmIuY29tPjsNCj4gQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+
OyBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPjsgUmFmYWVsDQo+IEogLiBXeXNvY2tp
IDxyandAcmp3eXNvY2tpLm5ldD47IG9wZW4gbGlzdDpOVk0gRVhQUkVTUyBEUklWRVIgPGxpbnV4
LQ0KPiBudm1lQGxpc3RzLmluZnJhZGVhZC5vcmc+OyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9y
ZzsNCj4gZGF2aWQuZS5ib3hAbGludXguaW50ZWwuY29tOyBTLWssIFNoeWFtLXN1bmRhciA8U2h5
YW0tc3VuZGFyLlMtDQo+IGtAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVy
LkRldWNoZXJAYW1kLmNvbT47IExpYW5nLA0KPiBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47
IEp1bGlhbiBTaWtvcnNraSA8YmVsZWdkb2xAZ21haWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHY1IDIvMl0gYWNwaTogUE06IEFkZCBxdWlya3MgZm9yIEFNRCBSZW5vaXIvTHVjaWVubmUN
Cj4gQ1BVcyB0byBmb3JjZSB0aGUgRDMgaGludA0KPiANCj4gT24gNi80LzIwMjEgMTI6NDMsIFJh
dWwgUmFuZ2VsIHdyb3RlOg0KPiA+IE9uIEZyaSwgSnVuIDQsIDIwMjEgYXQgMTA6NTQgQU0gTWFy
aW8gTGltb25jaWVsbG8NCj4gPiA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4gd3JvdGU6DQo+
ID4NCj4gPj4gKw0KPiA+PiArI2lmZGVmIENPTkZJR19YODYNCj4gPj4gK3N0YXRpYyBjb25zdCBz
dHJ1Y3QgeDg2X2NwdV9pZCBzdG9yYWdlX2QzX2NwdV9pZHNbXSA9IHsNCj4gPj4gKyAgICAgICBY
ODZfTUFUQ0hfVkVORE9SX0ZBTV9NT0RFTChBTUQsIDIzLCA5NiwgTlVMTCksICAvKiBSZW5vaXIN
Cj4gKi8NCj4gPj4gKyAgICAgICBYODZfTUFUQ0hfVkVORE9SX0ZBTV9NT0RFTChBTUQsIDIzLCAx
MDQsIE5VTEwpLCAvKg0KPiBMdWNpZW5uZSAqLw0KPiA+PiArICAgICAgIHt9DQo+ID4+ICt9Ow0K
PiA+PiArI2VuZGlmDQo+ID4+ICsNCj4gPg0KPiA+IElzIHRoaXMgdGhlIHNhbWUgbWF0Y2hpbmcg
bG9naWMgdGhhdCBXaW5kb3dzIGlzIHVzaW5nPw0KPiA+DQo+IA0KPiBJIGRvbid0IGhhdmUgYWNj
ZXNzIHRvIGNvbmZpcm0gdGhlaXIgbG9naWMgZm9yIGl0IC0gYnV0IHRoZXkgZG8gaGF2ZSBhbiBh
bGxvd2xpc3QNCj4gdGhhdCB3YXMgdXNlZCBmb3Igc3lzdGVtcyBiZWZvcmUgU3RvcmFnZUQzRW5h
YmxlIHdhcyBpbnRyb2R1Y2VkIGFzIHdlbGwgYXMNCj4gYSByZWdpc3RyeSBrZXkgdG8gb3ZlcnJp
ZGUgaXQgaW4gV2luZG93cy4NCg0KDQpNeSB1bmRlcnN0YW5kaW5nIGZyb20gdGhlIHdpbmRvd3Mg
dGVhbSBpcyB0aGF0IHRoZXNlIEFNRCBwbGF0Zm9ybXMgdXNlIHRoZSBhbGxvdyBsaXN0Lg0KDQpB
bGV4DQoNCj4gDQo+IEluIExpbnV4IHdlIGNhbiBkbyBpdCBhIG51bWJlciBvZiB3YXlzOg0KPiAN
Cj4gKiBEZXRlY3QgdGhlIENQVSBpbiBSTi9MQ04gcGxhdGZvcm1zDQo+ICAgIC0gTGlrZSBJIGRp
ZCBpbiB0aGlzIHBhdGNoDQo+IA0KPiAqIERldGVjdCBzb21lIG90aGVyIFBDSSBkZXZpY2Ugb25s
eSBwcmVzZW50IGluIFJOL0xDTiBwbGF0Zm9ybXMgYW5kIHNldA0KPiB0aGlzIGhpbnQNCj4gICAg
LSBMaWtlIHNvbWUgZWFybGllciB2ZXJzaW9ucyBvZiB0aGlzIHBhdGNoIHNlcmllcyBmcm9tIFBy
aWtlIGRpZA0KPiANCj4gKiBJbnRyb2R1Y2UgYSB0cmktc3RhdGUgbW9kdWxlIHBhcmFtZXRlciBs
aWtlIGQzPWF1dG8sb2ZmLG9uDQo+ICAgIC0gU2V0IHVwIGxvZ2ljIGJlaGluZCBhdXRvIHRvIHVz
ZSBhY3BpX3N0b3JhZ2VfZDMgcHJpbWFyaWx5IGFuZCBsb29rIGF0IGENCj4gcXVpcmsgbGlzdCBh
cyBhIGZhbGxiYWNrIGlmIHRoYXQgd2FzIGZhbHNlLg0KPiANCj4gKiBBZGQgYSBjb21waWxlIHRp
bWUgb3B0aW9uIHRvIGluY2x1ZGUgdGhlc2UgcXVpcmtzIGluIGVpdGhlciBhY3BpIG9yIG52bWUu
a28NCj4gb25seSBpZiBhIHVzZXIgc2VsZWN0ZWQgdGhlbS4NCj4gDQo+ICogRW51bWVyYXRlIGFs
bCB0aGUgZmllbGQgc3lzdGVtcyBTTUJJT1Mgd2UgY2FuIGZpbmQgd2l0aCB0aGVzZSBDUFVzDQo+
ICAgIC0gRXhwZWN0IHRoaXMgdG8gYmUgYSBsYXJnZSBxdWlyayBsaXN0Lg0KPiANCj4gSSBkb24n
dCBoYXZlIGEgc3Ryb25nIG9waW5pb24gYmV0d2VlbiB0aG9zZSB0d28gZmlyc3Qgb3B0aW9ucywg
YnV0IHN1c3BlY3QNCj4gdGhlIDNyZCB0aHJvdWdoIDV0aCBhcmVuJ3QgcmVhbGx5IGFjY2VwdGFi
bGUgb3Igc2NhbGFibGUuDQo+IA0KPiBJJ20gb3BlbiB0byBvdGhlciBzdWdnZXN0aW9ucyBidXQg
dGVzdGVycyBvZiB0aGUgcGF0Y2hlcyB0aHVzIGZhciBoYXZlIG1hZGUNCj4gaXQgY2xlYXIgdGhh
dCAvc29tZXRoaW5nLyBuZWVkcyB0byBiZSBkb25lIHRvIGF2b2lkIHRoZSBwcm9ibGVtcyBvbiBS
TiB3aXRoDQo+IExpbnV4IHRob3VnaC4NCg==
