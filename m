Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9E7A670F
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2019 13:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfICLIN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Sep 2019 07:08:13 -0400
Received: from mail-eopbgr30046.outbound.protection.outlook.com ([40.107.3.46]:54437
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726840AbfICLIM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 3 Sep 2019 07:08:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gp+c3EdgaqBXcsSDrJHEsIS4IdE/EW2H3IQKVVcX2JaxGitFcpSH5BKqUu1ULmZu0D3Wysm613GPIN02dvkh7xwwCI8lk/G9ppDWhUM1kNtLjusOKcuPqTlaEWY7Cr68Boo7pV75divpIKWx1nQOWQzchflZ40YRb1eFG/WkVfpsYS8qeiL2EKN7FBx4BG7pgRyEkpCNi/Y+IG/Ci89nmpnTShsQjtSPFAfIMAs4QOl/BvWCpyZvlF7dcHu1IxRaEoQLSbXhGAPeca9/H5I5GOUtc6XzFsCTzNAv66QYyGqLlNXSsVp3Mqsfc/mxfEvqxXseyVb2Jd/fwtaYJ1fZGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUUjl7Qk2LcRdvxXw6wUbqypIl8HJ39+ZkSbbJrzRh4=;
 b=N8lccngXjUPqcuHrsPG9HLGgT9XO5fDgnu4acKCtxXk/kUSZKYrJYPPjlwct2uZysxw8s+GTuOvnXk8tKy0F7BRnN4bXO/Q86jYvJRVT+UTqU85xgj45EwPkuujQtWPVVp1P1EJYK7MkjnbMku7vUyafNnm6+/8RCs/pmT9t3PPWiMbgdTvp1d41iiAGZ/7GgT56pmJ2Nz84x3O//SbTiyBmarqWuTUL81xIgHc2x5evp5N30KT/WQfZ77ZKRED0EyJdspQ0mIkiulUpWGmFupwEjIsQyqzPLC1SSwkWnoehtQQVXFAFaCCgcGDRIGqsyDG6u0+fXeo24o2pGows7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUUjl7Qk2LcRdvxXw6wUbqypIl8HJ39+ZkSbbJrzRh4=;
 b=BNgLidfJpKXB8KcLi27/FNYpWinw80K6STVTIJQoIt11zZBywIaZNC3ouDYMeUW4gbl8Uv/BEOgBLgvV0ucO4qzejj3h48nNq62GDSK0OU/p+nwpbDWRirbm7/z9EBXUwNedLmylVF6a5kMdkOkn/aRjkfYnvsbwwmzYSzTbzHI=
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com (10.141.173.142) by
 AM7PR04MB7046.eurprd04.prod.outlook.com (52.135.56.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Tue, 3 Sep 2019 11:08:07 +0000
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::78c5:bb0f:88cd:3a2a]) by AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::78c5:bb0f:88cd:3a2a%2]) with mapi id 15.20.2220.021; Tue, 3 Sep 2019
 11:08:06 +0000
From:   Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Chuanhua Han <chuanhua.han@nxp.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Biwen Li <biwen.li@nxp.com>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Leo Li <leoyang.li@nxp.com>, Udit Kumar <udit.kumar@nxp.com>
Subject: RE: [PATCH] ACPI: support for NXP i2c controller
Thread-Topic: [PATCH] ACPI: support for NXP i2c controller
Thread-Index: AQHVN9RWONVodUogYk2tb4fLvCueOacZMhcAgADo7oCAAATh4A==
Date:   Tue, 3 Sep 2019 11:08:06 +0000
Message-ID: <AM7PR04MB688567ACF4B42510E6492AC78EB90@AM7PR04MB6885.eurprd04.prod.outlook.com>
References: <20190711102601.20582-1-chuanhua.han@nxp.com>
 <CAJZ5v0hY2sL+XfN_4v07_hjvoxgCAt+Q89+wNg5Pky6XKP-mqA@mail.gmail.com>
 <31e7c1bb-d153-5feb-0b86-946caca5206c@pengutronix.de>
In-Reply-To: <31e7c1bb-d153-5feb-0b86-946caca5206c@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=meenakshi.aggarwal@nxp.com; 
x-originating-ip: [92.120.0.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90c7b93c-ebb5-4f9e-4d63-08d7305eff91
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM7PR04MB7046;
x-ms-traffictypediagnostic: AM7PR04MB7046:|AM7PR04MB7046:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR04MB704655A6D7E1D2CE95AC108B8EB90@AM7PR04MB7046.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(13464003)(189003)(199004)(25786009)(6246003)(53936002)(256004)(6116002)(3846002)(86362001)(44832011)(66066001)(66446008)(76116006)(66476007)(74316002)(229853002)(11346002)(9686003)(7736002)(486006)(6436002)(6306002)(305945005)(476003)(446003)(7416002)(6636002)(33656002)(76176011)(81166006)(81156014)(14454004)(8676002)(478600001)(64756008)(66946007)(66556008)(5660300002)(54906003)(71200400001)(110136005)(966005)(71190400001)(6506007)(52536014)(102836004)(316002)(45080400002)(53546011)(26005)(2906002)(186003)(4326008)(66574012)(7696005)(55016002)(8936002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM7PR04MB7046;H:AM7PR04MB6885.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QUVMiLIvHou/2QJWBZ3LGsIdiHiL2NRUo60WXV9LYH3G5o3fHVI275zwXMxqa8l2gSqGl8iDQs6gnV9Nvr+JohFxzfbt43A9gTtD4pKxKDsDkMd/D1rHd/A7kuLA0aJQGWQh7fxjdCWt8vPk4Twf4e/07jjMjPl2eHzQIK6pBIRYJAvOlL7o/kd8XU18snUL7tB+qipZGj+uaXJgl7oqsl1xKJbm1LIGvLVNP3LwajuxfGW6hoJuhFV91p+NmY5PL/qoSQBlL7Koc/qRRpKkZGXTCTg8kBXbNwL+UN7/lzh8w1L+W2dxpS7lYUazjxnMlR/8krFFbs8BoXiFHz1pRUhFJzhXE8BW8XMMxdy2Bx4bmvNZnLIbWB1QGPcxDJ9hXgFHdPsUdRun2IfNirA408+al8SsFgHWfhXthlwg/u8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c7b93c-ebb5-4f9e-4d63-08d7305eff91
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 11:08:06.7775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uMwPZO6KHFQ5jNbcB3Zgz4HwawDchp12c3+49S0ElSG0CKVkaLYoyZCPxtBQjIm8MPJ9ZiaAY8KyTGCD8eVNi5Qjm8rhmQ1hfPpMXf7ZPWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7046
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

K2Jpd2VuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogT2xla3NpaiBS
ZW1wZWwgPG8ucmVtcGVsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1i
ZXIgMywgMjAxOSA0OjIwIFBNDQo+IFRvOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5l
bC5vcmc+OyBDaHVhbmh1YSBIYW4NCj4gPGNodWFuaHVhLmhhbkBueHAuY29tPjsgV29sZnJhbSBT
YW5nIDx3c2FAdGhlLWRyZWFtcy5kZT47IEFuZHkNCj4gU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hl
bmtvQGdtYWlsLmNvbT4NCj4gQ2M6IFJhZmFlbCBKLiBXeXNvY2tpIDxyandAcmp3eXNvY2tpLm5l
dD47IExlbiBCcm93biA8bGVuYkBrZXJuZWwub3JnPjsNCj4gU2hhd24gR3VvIDxzaGF3bmd1b0Br
ZXJuZWwub3JnPjsgU2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPjsNCj4gQUNQ
SSBEZXZlbCBNYWxpbmcgTGlzdCA8bGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc+OyBMaW51eCBL
ZXJuZWwgTWFpbGluZyBMaXN0DQo+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgbGlu
dXgtaTJjIDxsaW51eC1pMmNAdmdlci5rZXJuZWwub3JnPjsgTGludXgNCj4gQVJNIDxsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+OyBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNv
bT47DQo+IE1lZW5ha3NoaSBBZ2dhcndhbCA8bWVlbmFrc2hpLmFnZ2Fyd2FsQG54cC5jb20+OyBV
ZGl0IEt1bWFyDQo+IDx1ZGl0Lmt1bWFyQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hd
IEFDUEk6IHN1cHBvcnQgZm9yIE5YUCBpMmMgY29udHJvbGxlcg0KPiANCj4gT25lIG1vcmUgcXVl
c3Rpb24sDQo+IA0KPiBPbiAwMi4wOS4xOSAyMjo1NiwgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6
DQo+ID4gT24gVGh1LCBKdWwgMTEsIDIwMTkgYXQgMTI6MzUgUE0gQ2h1YW5odWEgSGFuIDxjaHVh
bmh1YS5oYW5AbnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4+DQo+ID4+IEVuYWJsZSBOWFAgaTJjIGNv
bnRyb2xsZXIgdG8gYm9vdCB3aXRoIEFDUEkNCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogTWVl
bmFrc2hpIEFnZ2Fyd2FsIDxtZWVuYWtzaGkuYWdnYXJ3YWxAbnhwLmNvbT4NCj4gPj4gU2lnbmVk
LW9mZi1ieTogVWRpdCBLdW1hciA8dWRpdC5rdW1hckBueHAuY29tPg0KPiA+PiBTaWduZWQtb2Zm
LWJ5OiBDaHVhbmh1YSBIYW4gPGNodWFuaHVhLmhhbkBueHAuY29tPg0KPiA+DQo+ID4gV29sZnJh
bSwgYW55IG9iamVjdGlvbnMgdG8gdGhpcyBmcm9tIHRoZSBpMmMgc2lkZT8NCj4gPg0KPiA+PiAt
LS0NCj4gPj4gICBkcml2ZXJzL2FjcGkvYWNwaV9hcGQuYyAgICAgIHwgIDYgKysrKysrDQo+ID4+
ICAgZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1pbXguYyB8IDE1ICsrKysrKysrKysrKysrKw0KPiA+
PiAgIDIgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKQ0KPiA+Pg0KPiA+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9hY3BpL2FjcGlfYXBkLmMgYi9kcml2ZXJzL2FjcGkvYWNwaV9hcGQuYyBp
bmRleA0KPiA+PiBmZjQ3MzE3Li5jZjg1NjZjIDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL2Fj
cGkvYWNwaV9hcGQuYw0KPiA+PiArKysgYi9kcml2ZXJzL2FjcGkvYWNwaV9hcGQuYw0KPiA+PiBA
QCAtMTY1LDYgKzE2NSwxMSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGFwZF9kZXZpY2VfZGVzYw0K
PiB0aHVuZGVyeDJfaTJjX2Rlc2MgPSB7DQo+ID4+ICAgICAgICAgIC5maXhlZF9jbGtfcmF0ZSA9
IDEyNTAwMDAwMCwNCj4gPj4gICB9Ow0KPiA+Pg0KPiA+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBh
cGRfZGV2aWNlX2Rlc2MgbnhwX2kyY19kZXNjID0gew0KPiA+PiArICAgICAgIC5zZXR1cCA9IGFj
cGlfYXBkX3NldHVwLA0KPiA+PiArICAgICAgIC5maXhlZF9jbGtfcmF0ZSA9IDM1MDAwMDAwMCwN
Cj4gPj4gK307DQo+IA0KPiBJJ20gbm90IEFDUEkgZXhwZXJ0LCBzbyBuZWVkIGhlcmUgc29tZSBo
ZWxwIGZvciB1bmRlcnN0YW5kaW5nLiBIZXJlIGlzIEFDUEkNCj4gdGFibGUgZm9yDQo+IE5YUDAw
MDEgaWQgKGZvdW5kIG9uIHRoZSBpbnRlcm5ldCk6DQo+ICsgIERldmljZShJMkMwKSB7DQo+ICsg
ICAgTmFtZShfSElELCAiTlhQMDAwMSIpDQo+ICsgICAgTmFtZShfVUlELCAwKQ0KPiArICAgIE5h
bWUoX0NSUywgUmVzb3VyY2VUZW1wbGF0ZSgpIHsNCj4gKyAgICAgIE1lbW9yeTMyRml4ZWQoUmVh
ZFdyaXRlLCBJMkMwX0JBU0UsIEkyQ19MRU4pDQo+ICsgICAgICBJbnRlcnJ1cHQoUmVzb3VyY2VD
b25zdW1lciwgTGV2ZWwsIEFjdGl2ZUhpZ2gsIFNoYXJlZCkgeyBJMkMwX0lUIH0NCj4gKyAgICB9
KSAvLyBlbmQgb2YgX0NSUyBmb3IgaTJjMCBkZXZpY2UNCj4gKyAgICBOYW1lIChfRFNELCBQYWNr
YWdlICgpIHsNCj4gKyAgICAgIFRvVVVJRCgiZGFmZmQ4MTQtNmViYS00ZDhjLThhOTEtYmM5YmJm
NGFhMzAxIiksDQo+ICsgICAgICBQYWNrYWdlICgpIHsNCj4gKyAgICAgICAgIFBhY2thZ2UgKCkg
eyJjbG9jay1mcmVxdWVuY3kiLCBERUZBVUxUX1BMQVRfRlJFUX0sIC8vVGhpcyBpcw0KPiArIGRl
dmljZSBzcGVjaWZpYw0KPiBkYXRhLCBOZWVkIHRvIHNlZSBob3cgdG8gcGFzcyBjbGsgc3R1ZmYN
Cj4gKyAgICAgIH0NCj4gKyAgICB9KQ0KPiANCj4gU2hvdWxkIGtlcm5lbCBzb21lIGhvdyBnZXQg
cHJvcGVyIGNsb2NrLWZyZXF1ZW5jeSBmcm9tIHRoZSBBQ1BJPyBPciB3ZSBzdGlsbA0KPiBuZWVk
IHRvIHVzZSBoYXJkIGNvZGVkIC5maXhlZF9jbGtfcmF0ZSBpbiB0aGUga2VybmVsPw0KPiANCj4g
DQo+ID4+ICAgc3RhdGljIGNvbnN0IHN0cnVjdCBhcGRfZGV2aWNlX2Rlc2MgaGlwMDhfc3BpX2Rl
c2MgPSB7DQo+ID4+ICAgICAgICAgIC5zZXR1cCA9IGFjcGlfYXBkX3NldHVwLA0KPiA+PiAgICAg
ICAgICAuZml4ZWRfY2xrX3JhdGUgPSAyNTAwMDAwMDAsDQo+ID4+IEBAIC0yMzgsNiArMjQzLDcg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhY3BpX2RldmljZV9pZA0KPiBhY3BpX2FwZF9kZXZpY2Vf
aWRzW10gPSB7DQo+ID4+ICAgICAgICAgIHsgIkhJU0kwMkExIiwgQVBEX0FERFIoaGlwMDdfaTJj
X2Rlc2MpIH0sDQo+ID4+ICAgICAgICAgIHsgIkhJU0kwMkEyIiwgQVBEX0FERFIoaGlwMDhfaTJj
X2Rlc2MpIH0sDQo+ID4+ICAgICAgICAgIHsgIkhJU0kwMTczIiwgQVBEX0FERFIoaGlwMDhfc3Bp
X2Rlc2MpIH0sDQo+ID4+ICsgICAgICAgeyAiTlhQMDAwMSIsIEFQRF9BRERSKG54cF9pMmNfZGVz
YykgfSwNCj4gPj4gICAjZW5kaWYNCj4gPj4gICAgICAgICAgeyB9DQo+ID4+ICAgfTsNCj4gPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtaW14LmMgYi9kcml2ZXJzL2kyYy9i
dXNzZXMvaTJjLWlteC5jDQo+ID4+IGluZGV4IGIxYjhiOTMuLjk5ZjliOTYgMTAwNjQ0DQo+ID4+
IC0tLSBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtaW14LmMNCj4gPj4gKysrIGIvZHJpdmVycy9p
MmMvYnVzc2VzL2kyYy1pbXguYw0KPiA+PiBAQCAtNDQsNiArNDQsNyBAQA0KPiA+PiAgICNpbmNs
dWRlIDxsaW51eC9wbV9ydW50aW1lLmg+DQo+ID4+ICAgI2luY2x1ZGUgPGxpbnV4L3NjaGVkLmg+
DQo+ID4+ICAgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4gPj4gKyNpbmNsdWRlIDxsaW51eC9h
Y3BpLmg+DQo+ID4+DQo+ID4+ICAgLyogVGhpcyB3aWxsIGJlIHRoZSBkcml2ZXIgbmFtZSB0aGUg
a2VybmVsIHJlcG9ydHMgKi8NCj4gPj4gICAjZGVmaW5lIERSSVZFUl9OQU1FICJpbXgtaTJjIg0K
PiA+PiBAQCAtMjU1LDYgKzI1NiwxMiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9p
ZCBpMmNfaW14X2R0X2lkc1tdID0gew0KPiA+PiAgIH07DQo+ID4+ICAgTU9EVUxFX0RFVklDRV9U
QUJMRShvZiwgaTJjX2lteF9kdF9pZHMpOw0KPiA+Pg0KPiA+PiArc3RhdGljIGNvbnN0IHN0cnVj
dCBhY3BpX2RldmljZV9pZCBpMmNfaW14X2FjcGlfaWRzW10gPSB7DQo+ID4+ICsgICAgICAgeyJO
WFAwMDAxIiwgLmRyaXZlcl9kYXRhID0gKGtlcm5lbF91bG9uZ190KSZ2ZjYxMF9pMmNfaHdkYXRh
fSwNCj4gPj4gKyAgICAgICB7IH0NCj4gPj4gK307DQo+ID4+ICtNT0RVTEVfREVWSUNFX1RBQkxF
KGFjcGksIGkyY19pbXhfYWNwaV9pZHMpOw0KPiA+PiArDQo+ID4+ICAgc3RhdGljIGlubGluZSBp
bnQgaXNfaW14MV9pMmMoc3RydWN0IGlteF9pMmNfc3RydWN0ICppMmNfaW14KQ0KPiA+PiAgIHsN
Cj4gPj4gICAgICAgICAgcmV0dXJuIGkyY19pbXgtPmh3ZGF0YS0+ZGV2dHlwZSA9PSBJTVgxX0ky
QzsNCj4gPj4gQEAgLTEwNTIsNiArMTA1OSw5IEBAIHN0YXRpYyBpbnQgaTJjX2lteF9wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiA+PiAgIHsNCj4gPj4gICAgICAgICAg
Y29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCAqb2ZfaWQgPSBvZl9tYXRjaF9kZXZpY2UoaTJjX2lt
eF9kdF9pZHMsDQo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICZwZGV2LT5kZXYpOw0KPiA+PiArICAgICAgIGNvbnN0IHN0cnVj
dCBhY3BpX2RldmljZV9pZCAqYWNwaV9pZCA9DQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAg
IGFjcGlfbWF0Y2hfZGV2aWNlKGkyY19pbXhfYWNwaV9pZHMsDQo+ID4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICZwZGV2LT5kZXYpOw0KPiA+PiAgICAgICAgICBz
dHJ1Y3QgaW14X2kyY19zdHJ1Y3QgKmkyY19pbXg7DQo+ID4+ICAgICAgICAgIHN0cnVjdCByZXNv
dXJjZSAqcmVzOw0KPiA+PiAgICAgICAgICBzdHJ1Y3QgaW14aTJjX3BsYXRmb3JtX2RhdGEgKnBk
YXRhID0gZGV2X2dldF9wbGF0ZGF0YSgmcGRldi0+ZGV2KTsNCj4gPj4gQEAgLTEwNzksNiArMTA4
OSw5IEBAIHN0YXRpYyBpbnQgaTJjX2lteF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+
ICpwZGV2KQ0KPiA+Pg0KPiA+PiAgICAgICAgICBpZiAob2ZfaWQpDQo+ID4+ICAgICAgICAgICAg
ICAgICAgaTJjX2lteC0+aHdkYXRhID0gb2ZfaWQtPmRhdGE7DQo+ID4+ICsgICAgICAgZWxzZSBp
ZiAoYWNwaV9pZCkNCj4gPj4gKyAgICAgICAgICAgICAgIGkyY19pbXgtPmh3ZGF0YSA9IChzdHJ1
Y3QgaW14X2kyY19od2RhdGEgKikNCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBhY3BpX2lkLT5kcml2ZXJfZGF0YTsNCj4gPj4gICAgICAgICAgZWxzZQ0KPiA+PiAgICAgICAg
ICAgICAgICAgIGkyY19pbXgtPmh3ZGF0YSA9IChzdHJ1Y3QgaW14X2kyY19od2RhdGEgKikNCj4g
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGxhdGZvcm1fZ2V0X2RldmljZV9p
ZChwZGV2KS0+ZHJpdmVyX2RhdGE7DQo+ID4+IEBAIC0xMDkxLDYgKzExMDQsNyBAQCBzdGF0aWMg
aW50IGkyY19pbXhfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gPj4g
ICAgICAgICAgaTJjX2lteC0+YWRhcHRlci5uciAgICAgICAgICAgICA9IHBkZXYtPmlkOw0KPiA+
PiAgICAgICAgICBpMmNfaW14LT5hZGFwdGVyLmRldi5vZl9ub2RlICAgID0gcGRldi0+ZGV2Lm9m
X25vZGU7DQo+ID4+ICAgICAgICAgIGkyY19pbXgtPmJhc2UgICAgICAgICAgICAgICAgICAgPSBi
YXNlOw0KPiA+PiArICAgICAgIEFDUElfQ09NUEFOSU9OX1NFVCgmaTJjX2lteC0+YWRhcHRlci5k
ZXYsDQo+IEFDUElfQ09NUEFOSU9OKCZwZGV2LT5kZXYpKTsNCj4gPj4NCj4gPj4gICAgICAgICAg
LyogR2V0IEkyQyBjbG9jayAqLw0KPiA+PiAgICAgICAgICBpMmNfaW14LT5jbGsgPSBkZXZtX2Ns
a19nZXQoJnBkZXYtPmRldiwgTlVMTCk7DQo+ID4+IEBAIC0xMjUzLDYgKzEyNjcsNyBAQCBzdGF0
aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBpMmNfaW14X2RyaXZlciA9IHsNCj4gPj4gICAgICAg
ICAgICAgICAgICAubmFtZSA9IERSSVZFUl9OQU1FLA0KPiA+PiAgICAgICAgICAgICAgICAgIC5w
bSA9ICZpMmNfaW14X3BtX29wcywNCj4gPj4gICAgICAgICAgICAgICAgICAub2ZfbWF0Y2hfdGFi
bGUgPSBpMmNfaW14X2R0X2lkcywNCj4gPj4gKyAgICAgICAgICAgICAgIC5hY3BpX21hdGNoX3Rh
YmxlID0gQUNQSV9QVFIoaTJjX2lteF9hY3BpX2lkcyksDQo+ID4+ICAgICAgICAgIH0sDQo+ID4+
ICAgICAgICAgIC5pZF90YWJsZSA9IGlteF9pMmNfZGV2dHlwZSwNCj4gPj4gICB9Ow0KPiA+PiAt
LQ0KPiA+PiAyLjkuNQ0KPiA+Pg0KPiA+DQo+IA0KPiBLaW5kIHJlZ2FyZHMsDQo+IE9sZWtzaWog
UmVtcGVsDQo+IA0KPiAtLQ0KPiBQZW5ndXRyb25peCBlLksuICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiBJbmR1c3RyaWFsIExpbnV4
IFNvbHV0aW9ucyAgICAgICAgICAgICAgICAgfA0KPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5w
cm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnd3dy5wZW4NCj4gZ3V0cm9u
aXguZGUlMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q21lZW5ha3NoaS5hZ2dhcndhbCU0MG54cC5jb20l
N0MNCj4gNTM4MDFlNTkzZmJjNDc2MDZmMWQwOGQ3MzA1YzgwMjQlN0M2ODZlYTFkM2JjMmI0YzZm
YTkyY2Q5OWM1YzMwMTYzDQo+IDUlN0MwJTdDMCU3QzYzNzAzMTA0NjE0ODA5MDQ1MyZhbXA7c2Rh
dGE9UGtTMTlUcGg1bjRnTWNBSmFHM3NLcw0KPiBST2tPbSUyQmhvVXlrR1JkWXkwUFVPYyUzRCZh
bXA7cmVzZXJ2ZWQ9MCAgfA0KPiBQZWluZXIgU3RyLiA2LTgsIDMxMTM3IEhpbGRlc2hlaW0sIEdl
cm1hbnkgfCBQaG9uZTogKzQ5LTUxMjEtMjA2OTE3LTAgICAgfA0KPiBBbXRzZ2VyaWNodCBIaWxk
ZXNoZWltLCBIUkEgMjY4NiAgICAgICAgICAgfCBGYXg6ICAgKzQ5LTUxMjEtMjA2OTE3LTU1NTUg
fA0K
