Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C18312118F
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2019 18:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfLPRSF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Dec 2019 12:18:05 -0500
Received: from mail-eopbgr60087.outbound.protection.outlook.com ([40.107.6.87]:8350
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725805AbfLPRSF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Dec 2019 12:18:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vv8LGMqOGkJyflPaSXyQE4p7zAAtGkyd0WsJa5gjbX+9/4D2UJTTqJ6ZN7dhCqdGAz9Ka+g9bNPuaOTe36UHhTUD1WEf21rv2VOGV4BlTC3dxoyCQkSDaWdvpFoUlpoctZqODw8GhffzSPM5XtJFN2c/9gWjCgctkjjz35RFFUS4DOkY8ugwj15YGJkN62Rwga26KEJ/Pi62LrRR//SDk/+ynW/iJUVaO28Qg7fQlRo6rVtH1CqGslPMkULkwVaLN6anpAh0sLoJqalBBC7HV0qakkRsPqAUl0V/amO5Z1fBHNxZXCUd+KDpvR76cqiDPI+U3L/osUff2TbMPbTj2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbRVersQlPr8Bx52aoWr0qx/xTlslifg8y490caAkZw=;
 b=IPQiKHi36rdv7lwQaOEU7Fr+yDfrFJfhWjL07gbzPUy3ZewN3xrNi2F7fLj4khYHSAt61CclqwMgHA1nrlnmv+bUJfb/d9cfCqNBejen1JyAg3CeGfeKLmR8BpkJyHstxE/4UMCk/VXuT3GR6VJAS1Tvn63Px8OGxv731BIKaV8fF9MQzyRVdAw49+UoMOESDWqWqEdXCGZrFVWK8XaueNR1emXOBhhOhkfH+VRbvh5PTGHlMdM0D5tfkqZO+Jnb1ozw/Q6te2iANsUL/VPLAWBqYC5xfgZkM2ue3JGVbwt43GMJ35r9A76YK18vnDIdNZDNePESqHJPxpy+3xjXBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbRVersQlPr8Bx52aoWr0qx/xTlslifg8y490caAkZw=;
 b=VWMY0K/r1hSslS9xAdmBu56A4dGULED0EUJsxr0OMEaFN+q/gFzWQDn9YnNPtkFcvMY2AgpfQL5LujydwD46/1CUzZAkv9rf/vPrJqqW+horIdCV0AoI0zFFGJ/agWazAf1U9oIi5DDEScNFZjdfPGG7HfXIwUBnVE3Gg59uFhg=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.19; Mon, 16 Dec 2019 17:18:00 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::8823:663d:c6ed:cbd6]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::8823:663d:c6ed:cbd6%12]) with mapi id 15.20.2538.019; Mon, 16 Dec
 2019 17:17:59 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: RE: [PATCH] ACPI/IORT: fix the iort_id_map function
Thread-Topic: [PATCH] ACPI/IORT: fix the iort_id_map function
Thread-Index: AQHVs1oeh+jJ/g/JdU2kvN0Bjpwx56e8IO0AgAAVdGCAAHH+gIAAWRgQ
Date:   Mon, 16 Dec 2019 17:17:59 +0000
Message-ID: <VI1PR0401MB2496DEA6CDEFD57C9427883FF1510@VI1PR0401MB2496.eurprd04.prod.outlook.com>
References: <20191215203303.29811-1-pankaj.bansal@nxp.com>
 <ffc5a6e9-cac3-d6c6-fe16-745b4f9e481f@huawei.com>
 <VI1PR0401MB2496E243F45C82E789B867A6F1510@VI1PR0401MB2496.eurprd04.prod.outlook.com>
 <eedbf670-00e2-93ce-06ac-469d6032ce74@huawei.com>
In-Reply-To: <eedbf670-00e2-93ce-06ac-469d6032ce74@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-originating-ip: [49.36.128.25]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 58906403-9225-4826-12a2-08d7824be693
x-ms-traffictypediagnostic: VI1PR0401MB2496:
x-microsoft-antispam-prvs: <VI1PR0401MB249603C0A7A2FF37324D8275F1510@VI1PR0401MB2496.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(199004)(189003)(13464003)(316002)(110136005)(6506007)(26005)(86362001)(186003)(54906003)(2906002)(44832011)(53546011)(7696005)(5660300002)(66556008)(81156014)(81166006)(9686003)(8676002)(66946007)(55016002)(66446008)(64756008)(8936002)(76116006)(45080400002)(71200400001)(33656002)(478600001)(66476007)(52536014)(966005)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2496;H:VI1PR0401MB2496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1HSHzLk/QiaTJ5O28y75sun38RtFxl4/g9/2r3Eaq4xFM4fJxb0JybQ7FXRs0LRTelMQkRllCoN0Hy4cVnU7Q/ZyWT9YsTC6TKwE7SxdNZMgdw4I3gYAV6Kr14mb4WAcXA4Ggoo1j1bnvSlymsvZSvOCfpCKszVOB3eLgsthaY110PCzDN+L0BcVctoBg4At70ruKbhCMfshpRHm4/wnwEBl86mYa9De3anQVVVc8OE1c0SzSegb1ScPv0DOO+1JXiavApZiam199qS5LNM2+No/ymaDerbalQ5xov0BqDyLyKpaCUhHwE4FDsUZkyyMNI5KdTQ5AYzRTPNqCFVNWDcK074+gMD8qCNhNqB33piwrRa09x0rAb+4g1gOQo2/P6uh9faZ7AAeQ/k7MRF5OH5MstX4jBxMkNVuSI4ba0dIvjyCc+1SxopKPSi5PP5eoPElJI6QxoUDXSKh5KZnyrJkdMH4Ude/0wOIyVtQt7NbHur/URxRpJQcGbU0ECCq
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58906403-9225-4826-12a2-08d7824be693
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 17:17:59.7941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 33PXpocZf0iuF/fYNxj9UwYPH6WWL3rqciiP+I0UtgwbKkuorl4deSOhxoKl40ll7FdNCKLh5kYnHP8jYq6r1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2496
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIYW5qdW4gR3VvIDxndW9oYW5q
dW5AaHVhd2VpLmNvbT4NCj4gU2VudDogTW9uZGF5LCAxNiBEZWNlbWJlciwgMjAxOSAwNToyNCBQ
TQ0KPiBUbzogUGFua2FqIEJhbnNhbCA8cGFua2FqLmJhbnNhbEBueHAuY29tPjsgTG9yZW56byBQ
aWVyYWxpc2kNCj4gPGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20+OyBTdWRlZXAgSG9sbGEgPHN1
ZGVlcC5ob2xsYUBhcm0uY29tPjsNCj4gUmFmYWVsIEogLiBXeXNvY2tpIDxyandAcmp3eXNvY2tp
Lm5ldD47IExlbiBCcm93biA8bGVuYkBrZXJuZWwub3JnPg0KPiBDYzogbGludXgtYWNwaUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gSm9u
YXRoYW4gQ2FtZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIXSBBQ1BJL0lPUlQ6IGZpeCB0aGUgaW9ydF9pZF9tYXAgZnVuY3Rpb24NCj4gDQo+
IE9uIDIwMTkvMTIvMTYgMTM6MTQsIFBhbmthaiBCYW5zYWwgd3JvdGU6DQo+ID4gSGkgSGFuanVu
LA0KPiA+DQo+ID4gVGhhbmtzIGZvciByZXBseWluZy4gUGxlYXNlIGZpbmQgbXkgcmVzcG9uc2Ug
aW5saW5lDQo+ID4NCj4gPj4gSGkgUGFua2FqLA0KPiA+Pg0KPiA+PiBPbiAyMDE5LzEyLzE1IDIz
OjEyLCBQYW5rYWogQmFuc2FsIHdyb3RlOg0KPiA+Pj4gQXMgcGVyDQo+ID4+PiBodHRwczovL2V1
cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRmlu
Zg0KPiA+Pj4gb2MNCj4gPj4+DQo+ID4+DQo+IGVudGVyLmFybS5jb20lMkZoZWxwJTJGdG9waWMl
MkZjb20uYXJtLmRvYy5kZW4wMDQ5ZCUyRkRFTjAwNDlEX0lPDQo+ID4+IF9SZW1hDQo+ID4+Pg0K
PiA+Pg0KPiBwcGluZ19UYWJsZS5wZGYmYW1wO2RhdGE9MDIlN0MwMSU3Q3Bhbmthai5iYW5zYWwl
NDBueHAuY29tJTdDNzhkDQo+ID4+IDgyYTU2MA0KPiA+Pj4NCj4gPj4NCj4gNTcxNDIxOTE5NjAw
OGQ3ODFkYjA2YTclN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlDQo+ID4+
IDdDMSU3QzYNCj4gPj4+DQo+ID4+DQo+IDM3MTIwNjUwMDE4OTgzODE0JmFtcDtzZGF0YT0lMkZS
aEFUVUt4JTJGQTJnUEV4JTJCTlk5WCUyRjdrcVYNCj4gPj4gQ3JFZVJuYkUlDQo+ID4+PiAyQjJx
bFRrZEdEYyUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiA+Pj4gaW4gSUQgbWFwcGluZ3M6DQo+ID4+PiBO
dW1iZXIgb2YgSURzID0gVGhlIG51bWJlciBvZiBJRHMgaW4gdGhlIHJhbmdlIG1pbnVzIG9uZS4N
Cj4gPj4NCj4gPj4gSG1tLCB0aGUgc3BlYyBpcyBjb25mdXNpbmcsIHRoZSBzcGVjIG1heSBuZWVk
IHRvIGJlIHVwZGF0ZWQsIGZvcg0KPiA+PiBleGFtcGxlLCBmb3IgYSBQQ0kgYnVzLCBkZXZpY2Ug
SUQgKyBmdW5jdGlvbiBJRCB3aWxsIHRha2UgOCBiaXRzIGFuZA0KPiA+PiB3aWxsIGJlIDI1NiBJ
RHMgZm9yIHRoYXQgUENJIGJ1cywgbm90IHN1cmUgd2h5IHdlIG5lZWQgdG8gbWludXMgb25lLg0K
PiA+Pg0KPiA+DQo+ID4gSSBhZ3JlZSB0aGF0IHRoaXMgIm1pbnVzIG9uZSIgdGhpbmcgaXMgY29u
ZnVzaW5nLiBOb3Qgc3VyZSB3aHkgSXQgd2FzDQo+ID4gcHV0IGluIHRoZSBzcGVjIGxpa2UgdGhh
dC4gSSBndWVzcyB0aGV5IHdhbnRlZCB0aGUgbnVtYmVyIG9mIElEcyB0byBiZSAwDQo+IGJhc2Vk
IGluc3RlYWQgb2YgMSBiYXNlZC4NCj4gPg0KPiA+Pj4NCj4gPj4+IFRoZXJlZm9yZSwgaXQncyB2
YWxpZCBmb3IgSUQgbWFwcGluZyB0byBjb250YWluIHNpbmdsZSBkZXZpY2UNCj4gPj4+IG1hcHBp
bmcgd2hpY2ggd291bGQgaGF2ZSBOdW1iZXIgb2YgSURzIGZpZWxkIDAuDQo+ID4+DQo+ID4+IFdo
eSBub3QgdXNlIHNpbmdsZSBtYXBwaW5nIGZsYWcgZm9yIHRoaXMgY2FzZT8NCj4gPg0KPiA+IEFj
dHVhbGx5IHNpbmdsZSBtYXBwaW5nIGZsYWcgZG9lc24ndCBtZWFuIHRoYXQgdGhlcmUgaXMgc2lu
Z2xlIG1hcHBpbmcgaW4NCj4gYW4gSUQgbWFwcGluZy4NCj4gPiBJdCBtZWFucyB0aGF0IElucHV0
IElEIHNob3VsZCBub3QgYmUgY29uc2lkZXJlZCB3aGVuIGxvb2tpbmcgZm9yIE91dHB1dA0KPiBJ
RC4NCj4gPiBJZiB3ZSBwdXQgc2luZ2xlIGlkIGZsYWcsIHRoZW4gd2UgY2Fubm90IGhhdmUgYSBj
YXNlIHdoZXJlIHdlIGhhdmUgYW4NCj4gPiBhcnJheSBvZiBzaW5nbGUgbWFwcGluZ3MgZm9yIG9u
ZSBkZXZpY2UuDQo+ID4gZS5nLiBhbiBhcnJheSBvZiBzaW5nbGUgbWFwcGluZ3MgZm9yIG9uZSBQ
Q0llIFJvb3QgQ29tcGxleCwgd2hlcmUgd2UNCj4gPiBoYXZlIGEgdW5pcXVlIG91dHB1dCBJRCBm
b3IgYSB1bmlxdWUgQkRGKElucHV0IElEKQ0KPiANCj4gQWdyZWVkLCBzaW5nbGUgbWFwcGluZyBm
bGFnIGlzIG5vdCB3b3JraW5nIGZvciBtdWx0aS1lbnRyaXMgb2Ygc2luZ2xlIG1hcHBpbmdzLg0K
PiANCj4gRG8geW91IGhhdmUgYSByZWFsIHVzZSBjYXNlIGZvciB0aGlzIGZpeD8gSSdtIHRoaW5r
aW5nIGlmIHdlIHdpbGwgYnJlYWsgYW55DQo+IGRlbGl2ZXJlZCBwbGF0Zm9ybXMgd2l0aCB0aGlz
IHBhdGNoIGFwcGxpZWQsIHNpbmNlIHRoaXMgY29kZSBpcyBub3QgY2hhbmdlZA0KPiBmcm9tIDIw
MTYsIGFuZCBpdCdzIHRoZSBrZXkgbG9naWMgZm9yIG1hcHBpbmcgdGhlIElEcy4NCg0KV2UgaGF2
ZSB0aGlzIHVzZSBjYXNlIGluIG91ciBwbGF0Zm9ybSBOWFAgTFgyMTYwQSwgd2hlcmUgd2UgcHJv
dmlkZSB0aGUgYXJyYXkgb2Ygc2luZ2xlIG1hcHBpbmdzIGluIElPUlQgdGFibGUuIEFjdHVhbGx5
IHdlIGNhbiBvbmx5IGhhdmUgbGltaXRlZCBudW1iZXIgb2Ygb3V0cHV0IElEcyBmb3IgUENJZSBk
ZXZpY2VzLCBzbyB3ZSBhbGxvY2F0ZSB1bmlxdWUgb3V0cHV0IElEIHRvIGVhY2ggQkRGIGNvbm5l
Y3RlZCB0byBhIFBDSWUgcm9vdCBjb21wbGV4IGFuZCBwYXNzIHRoZXNlIElEcyBpbiBJT1JUIHRh
YmxlLg0KDQo+IA0KPiBJIGNoZWNrZWQgSGlzaWxpY29uJ3MgQVJNNjQgc2VydmVyIHBsYXRmb3Jt
LCBOdW1iZXIgb2YgSURzIGlzIGVxdWFsIHRvIHRoZQ0KPiBudW1iZXIgb2YgSURzIGluIHRoZSBy
YW5nZSBpbiB0aGUgZmlybXdhcmUsIHdoaWNoIGlzIG5vdCBkb2luZyB0aGUgc2FtZSBhcw0KPiB0
aGUgc3BlYyBzYWlkLCBidXQgKHJpZF9pbiA+IG1hcC0+aW5wdXRfYmFzZSArIG1hcC0+aWRfY291
bnQpIGlzIHN0aWxsIHZhbGlkDQo+IHdpdGggdGhpcyBwYXRjaCBhcHBsaWVkLCBub3Qgc3VyZSBm
b3Igb3RoZXIgcGxhdGZvcm1zLg0KDQpJIGRvbid0IHRoaW5rIHRoYXQgdGhpcyBwYXRjaCB3b3Vs
ZCBicmVhayBhbnkgcGxhdGZvcm0gd2hpY2ggaGFzIElPUlQgdGFibGUgZGVmaW5lZCBhcyBwZXIg
c3BlYy4NCg0KPiANCj4gVGhhbmtzDQo+IEhhbmp1bg0KDQo=
