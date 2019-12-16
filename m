Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 873A111FDD7
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2019 06:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfLPFP1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Dec 2019 00:15:27 -0500
Received: from mail-eopbgr130040.outbound.protection.outlook.com ([40.107.13.40]:6166
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725789AbfLPFP1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Dec 2019 00:15:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XULisgYXSAc3GqeJStajJP4pRiBmqNW9ahVmkai8eLf04iSshfsKbJVLF1Tjnmf5/DonHALxS4rnjsIcS5PO2DsLLV/gO2xzklkapaxFH44eoJh4uR1QsquI7AH7qgOSO03QboAL4zVH8S/RyYi2JI3SFlf0o69SuwpbJ48IWqTqVduxNn7/CoMlz4nI8Kjv8Y+DNDBu04qsGzec9mIk9YOS/7beVuON0ZyB3jkJK4WMDygOLGukUan1Zxau3gPqZJvr8I1gVnDk+dHT/3V8A+qZ2zCqVfZEY2WB0YZkP0+09qkO9Uw//bsKQqu3rhjiXnF/nwWDqgdKhHxE4Ma+qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYWDGpYzSgNCSAHWfPM8BZ2kBiWoaR7bQgGj7T8W3Ck=;
 b=DGsfhA35fRUix/nhZtZQUtMGOLjK9BfT+4PbI6H0Swfc4+lXN2R35yF30frNS7MAXXoCHP9vqubSlnKDlEDSwnOOUsjdShNGpbQUepFDhOoJ++bxah+FRIawTw7GuUvJQPXhWs3FMV3ox/+xDqPRKBteWirP81N9Z4/mmiDlLNECb429bbcAjMMFEvzE2uVhHLYaT6c6cAY7W/HW28IN8XklnG7Ku/p2iaotaiQL7tiMdDUhR4xhrd0H9mUOurR/aOOodjgGzZA2YKZYwbAEPiNDYiX7nML8pOr51Zq91WYshAPePIUBL7HUOwC1tbx7QNjMOqi05q5zn1GZBSBs6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYWDGpYzSgNCSAHWfPM8BZ2kBiWoaR7bQgGj7T8W3Ck=;
 b=LsKNDsIFJWy5ZsaiwcsdsiFeQee8WurR/3kXRjZk1dCqRvZW4OtOLCDV3gDlXhAEN9cvY6++IPjqa1xyG56gpLOGHZ6VJlgiYQkA++64tu4sCaKj1h/1CC/Vqkf0ra3Mw1MQ2PXGMIr8F43wricRpFj0Re5dOBVZplfuJYzRLsc=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2495.eurprd04.prod.outlook.com (10.168.63.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Mon, 16 Dec 2019 05:14:41 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::8823:663d:c6ed:cbd6]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::8823:663d:c6ed:cbd6%12]) with mapi id 15.20.2538.019; Mon, 16 Dec
 2019 05:14:40 +0000
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
Thread-Index: AQHVs1oeh+jJ/g/JdU2kvN0Bjpwx56e8IO0AgAAVdGA=
Date:   Mon, 16 Dec 2019 05:14:40 +0000
Message-ID: <VI1PR0401MB2496E243F45C82E789B867A6F1510@VI1PR0401MB2496.eurprd04.prod.outlook.com>
References: <20191215203303.29811-1-pankaj.bansal@nxp.com>
 <ffc5a6e9-cac3-d6c6-fe16-745b4f9e481f@huawei.com>
In-Reply-To: <ffc5a6e9-cac3-d6c6-fe16-745b4f9e481f@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-originating-ip: [92.120.1.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ac381bfd-4ca0-4388-56ce-08d781e6dac1
x-ms-traffictypediagnostic: VI1PR0401MB2495:
x-microsoft-antispam-prvs: <VI1PR0401MB24954C212BB15283659C559BF1510@VI1PR0401MB2495.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(13464003)(199004)(189003)(2906002)(44832011)(478600001)(45080400002)(966005)(33656002)(110136005)(54906003)(8936002)(8676002)(52536014)(81156014)(81166006)(53546011)(6506007)(5660300002)(186003)(26005)(4326008)(66946007)(64756008)(66446008)(66556008)(66476007)(76116006)(71200400001)(9686003)(55016002)(7696005)(86362001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2495;H:VI1PR0401MB2496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d9OUUiy1Q7Z46XdNXD/2Qi7NsjQ5KcGijfXwAgDaBg3cinEjtQa7FyFwJhzgmqJObAc78+AafqR6rpP/C7hISbM1fKESlTQCgbhadxNTp01Goc6S+bYUeCYtzrOfjPQjBcj9AWKo8ZgEj5LhJTh4BiD9VUn/owyYMXP3ui4AAZ1uCV4cNiq4/9Qd1i8zaE3y+f9DmSOLyr+zUbkcC/UXRqkYNHHcloZ4Dm9xqhAKFNAWGHA4KkuOwvwdBwOJ8HWRt7saYMXvo/wk+txC+UPYO3k8ruasyNY7IOBs2Kya3AFtZxClUq3uIKKhHIJyQnpqwbBF4EdosCVebImwCT/Mb4/QOTmXA2tuH3902kI/UF/pOE0QNbuXbl/B7H631ZJh+fbNtdgYGHYBvt7YD5V+ZE6N+sSFAV2OZsPmZXQ18On4i6XGUUGb/qkpJ3WVHC8XHwIa3hvKWz+H+z3aByfSWXrl4AUZaHyfcVr2mQCdrQgmQhty1ij+5Ut4hc6eXsoC
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac381bfd-4ca0-4388-56ce-08d781e6dac1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 05:14:40.7540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zn/u/BqHGbt0xGqP+gyyImoSApaOmj9/sXY5YGa7ms/Yum+qgOhcCzsZAL1yN0OVPTUCRtA9/O8Y4x4iP4OvHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2495
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGkgSGFuanVuLA0KDQpUaGFua3MgZm9yIHJlcGx5aW5nLiBQbGVhc2UgZmluZCBteSByZXNwb25z
ZSBpbmxpbmUNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIYW5qdW4g
R3VvIDxndW9oYW5qdW5AaHVhd2VpLmNvbT4NCj4gU2VudDogTW9uZGF5LCAxNiBEZWNlbWJlciwg
MjAxOSAwOToxOSBBTQ0KPiBUbzogUGFua2FqIEJhbnNhbCA8cGFua2FqLmJhbnNhbEBueHAuY29t
PjsgTG9yZW56byBQaWVyYWxpc2kNCj4gPGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20+OyBTdWRl
ZXAgSG9sbGEgPHN1ZGVlcC5ob2xsYUBhcm0uY29tPjsNCj4gUmFmYWVsIEogLiBXeXNvY2tpIDxy
andAcmp3eXNvY2tpLm5ldD47IExlbiBCcm93biA8bGVuYkBrZXJuZWwub3JnPg0KPiBDYzogbGlu
dXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsNCj4gSm9uYXRoYW4gQ2FtZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIXSBBQ1BJL0lPUlQ6IGZpeCB0aGUgaW9ydF9pZF9tYXAgZnVu
Y3Rpb24NCj4gDQo+IEhpIFBhbmthaiwNCj4gDQo+IE9uIDIwMTkvMTIvMTUgMjM6MTIsIFBhbmth
aiBCYW5zYWwgd3JvdGU6DQo+ID4gQXMgcGVyDQo+ID4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3Mu
cHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZpbmZvYw0KPiA+DQo+IGVu
dGVyLmFybS5jb20lMkZoZWxwJTJGdG9waWMlMkZjb20uYXJtLmRvYy5kZW4wMDQ5ZCUyRkRFTjAw
NDlEX0lPDQo+IF9SZW1hDQo+ID4NCj4gcHBpbmdfVGFibGUucGRmJmFtcDtkYXRhPTAyJTdDMDEl
N0NwYW5rYWouYmFuc2FsJTQwbnhwLmNvbSU3Qzc4ZA0KPiA4MmE1NjANCj4gPg0KPiA1NzE0MjE5
MTk2MDA4ZDc4MWRiMDZhNyU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCUN
Cj4gN0MxJTdDNg0KPiA+DQo+IDM3MTIwNjUwMDE4OTgzODE0JmFtcDtzZGF0YT0lMkZSaEFUVUt4
JTJGQTJnUEV4JTJCTlk5WCUyRjdrcVYNCj4gQ3JFZVJuYkUlDQo+ID4gMkIycWxUa2RHRGMlM0Qm
YW1wO3Jlc2VydmVkPTANCj4gPiBpbiBJRCBtYXBwaW5nczoNCj4gPiBOdW1iZXIgb2YgSURzID0g
VGhlIG51bWJlciBvZiBJRHMgaW4gdGhlIHJhbmdlIG1pbnVzIG9uZS4NCj4gDQo+IEhtbSwgdGhl
IHNwZWMgaXMgY29uZnVzaW5nLCB0aGUgc3BlYyBtYXkgbmVlZCB0byBiZSB1cGRhdGVkLCBmb3Ig
ZXhhbXBsZSwNCj4gZm9yIGEgUENJIGJ1cywgZGV2aWNlIElEICsgZnVuY3Rpb24gSUQgd2lsbCB0
YWtlIDggYml0cyBhbmQgd2lsbCBiZSAyNTYgSURzIGZvcg0KPiB0aGF0IFBDSSBidXMsIG5vdCBz
dXJlIHdoeSB3ZSBuZWVkIHRvIG1pbnVzIG9uZS4NCj4gDQoNCkkgYWdyZWUgdGhhdCB0aGlzICJt
aW51cyBvbmUiIHRoaW5nIGlzIGNvbmZ1c2luZy4gTm90IHN1cmUgd2h5IEl0IHdhcyBwdXQgaW4g
dGhlIHNwZWMNCmxpa2UgdGhhdC4gSSBndWVzcyB0aGV5IHdhbnRlZCB0aGUgbnVtYmVyIG9mIElE
cyB0byBiZSAwIGJhc2VkIGluc3RlYWQgb2YgMSBiYXNlZC4NCg0KPiA+DQo+ID4gVGhlcmVmb3Jl
LCBpdCdzIHZhbGlkIGZvciBJRCBtYXBwaW5nIHRvIGNvbnRhaW4gc2luZ2xlIGRldmljZSBtYXBw
aW5nDQo+ID4gd2hpY2ggd291bGQgaGF2ZSBOdW1iZXIgb2YgSURzIGZpZWxkIDAuDQo+IA0KPiBX
aHkgbm90IHVzZSBzaW5nbGUgbWFwcGluZyBmbGFnIGZvciB0aGlzIGNhc2U/DQoNCkFjdHVhbGx5
IHNpbmdsZSBtYXBwaW5nIGZsYWcgZG9lc24ndCBtZWFuIHRoYXQgdGhlcmUgaXMgc2luZ2xlIG1h
cHBpbmcgaW4gYW4gSUQgbWFwcGluZy4NCkl0IG1lYW5zIHRoYXQgSW5wdXQgSUQgc2hvdWxkIG5v
dCBiZSBjb25zaWRlcmVkIHdoZW4gbG9va2luZyBmb3IgT3V0cHV0IElELg0KSWYgd2UgcHV0IHNp
bmdsZSBpZCBmbGFnLCB0aGVuIHdlIGNhbm5vdCBoYXZlIGEgY2FzZSB3aGVyZSB3ZSBoYXZlIGFu
IGFycmF5IG9mIHNpbmdsZSBtYXBwaW5ncw0KZm9yIG9uZSBkZXZpY2UuDQplLmcuIGFuIGFycmF5
IG9mIHNpbmdsZSBtYXBwaW5ncyBmb3Igb25lIFBDSWUgUm9vdCBDb21wbGV4LCB3aGVyZSB3ZSBo
YXZlIGEgdW5pcXVlIG91dHB1dCBJRCBmb3IgYSB1bmlxdWUgQkRGKElucHV0IElEKQ0KDQo+IA0K
PiBUaGFua3MNCj4gSGFuanVuDQoNClJlZ2FyZHMsDQpQYW5rYWogQmFuc2FsDQo=
