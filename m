Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08776122AC8
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Dec 2019 12:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfLQL6Y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Dec 2019 06:58:24 -0500
Received: from mail-eopbgr60047.outbound.protection.outlook.com ([40.107.6.47]:5606
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727472AbfLQL6Y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 17 Dec 2019 06:58:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCjo7ImEWu4EdPowbdqKmXjbzyIPq+FvR//RKZzRF6qOIGUpJ/5EbskhE1UY2s3rpxTGopSyD++SHtOxPw9+LoZT5siWGZL1F0ecxiqPyOfWBkOR72urVHL7NpuntBc0irO3e5HA5j57xOeqzZvxpGj5oM+1+zSH2t9WX66/2H1SyjbyM65CtxVnwlqmfD48dN2TNP7+BMKqjGiGh13LTT2rsmqxVXixCg1IJ3Mpqn4jprS3ad5PO9JpdpwaTmrGlVHF/PMbT0bzu2N0hLv+ZKSDnetoW6tnu5reG9RkcQNbDMBofvA3QcaNBeDI1ktrVuZZguvN4uFB5xSv1P1pjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4XyvAIfZiJIM31z4Y+TwDYphN9EhW5kulEy+b4aRZw=;
 b=InI7468OpZE9c1OW6gf0+82aM7mCSqUFUQ7W44Zs5OtcrBhjMvPqc+tQz5NclhBmQOCEbdTkTeUBmFPaD0LKdRDnf5c53VpwetufMxUjVTILXLU17cG/1j8pK49vJR0pFVNhogIvKQNzGr62BGa0d/fMBM3Dq43frLLMA5huYsw9+Jm23M42Kfptw8Xxue+R88iZHCKqUaZY25y2WpYOZ1Ec1tAAw43LcKXtVMFAClnlqtvHoSqhaio3yUa5MdD+95pC5WSY9H43L9lMpUAbnFuUoQl7PPwdF2ZXH8SQZjHxdBNDWvNMOvudt94B9+NJXv6oZ8/0WvXWauHpNmQlYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4XyvAIfZiJIM31z4Y+TwDYphN9EhW5kulEy+b4aRZw=;
 b=sryukieI5licN6x5se4mVau9daANQ6UUpqhHvg1aJ1G1NfeUfa5NCOnM4xvS3CYoX5q2bkhSU7tdxwN/XsHbswXzWJriqiJ6+R2Xsfmp54xf+abrQ84Q+kWaFD5TZf507JMJm/ltwmK1YTbONPaGxsiICY4kMNR/f+e4IBHpmCk=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2685.eurprd04.prod.outlook.com (10.168.66.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Tue, 17 Dec 2019 11:58:20 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::8823:663d:c6ed:cbd6]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::8823:663d:c6ed:cbd6%12]) with mapi id 15.20.2538.019; Tue, 17 Dec
 2019 11:58:20 +0000
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
Thread-Index: AQHVs1oeh+jJ/g/JdU2kvN0Bjpwx56e8IO0AgAAVdGCAAHH+gIAAWRgQgAE40mA=
Date:   Tue, 17 Dec 2019 11:58:20 +0000
Message-ID: <VI1PR0401MB2496A549A21DD18B214A083BF1500@VI1PR0401MB2496.eurprd04.prod.outlook.com>
References: <20191215203303.29811-1-pankaj.bansal@nxp.com>
 <ffc5a6e9-cac3-d6c6-fe16-745b4f9e481f@huawei.com>
 <VI1PR0401MB2496E243F45C82E789B867A6F1510@VI1PR0401MB2496.eurprd04.prod.outlook.com>
 <eedbf670-00e2-93ce-06ac-469d6032ce74@huawei.com>
 <VI1PR0401MB2496DEA6CDEFD57C9427883FF1510@VI1PR0401MB2496.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0401MB2496DEA6CDEFD57C9427883FF1510@VI1PR0401MB2496.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-originating-ip: [92.120.1.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 587a6050-4e5d-4ae9-d209-08d782e86937
x-ms-traffictypediagnostic: VI1PR0401MB2685:
x-microsoft-antispam-prvs: <VI1PR0401MB268531F43FC68DFE9EC7831AF1500@VI1PR0401MB2685.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(199004)(189003)(13464003)(52536014)(64756008)(81166006)(33656002)(66556008)(66476007)(5660300002)(81156014)(8676002)(45080400002)(478600001)(66446008)(76116006)(966005)(66946007)(86362001)(7696005)(316002)(8936002)(53546011)(6506007)(4326008)(71200400001)(186003)(110136005)(2906002)(9686003)(55016002)(44832011)(54906003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2685;H:VI1PR0401MB2496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3F5uR1ZaB9wRP7+7xdPoT+9tor6F95JVWDSaG/Oqv9arH+eIrb+cGFsZHNt35gFE1IAdzrvCdjXD1seqgW6lV4HKPDtEUZ71xZq9gL0V3Y9vdZtR+wVHto+xFeD9ivvm1kw4IHpm5MbBcqEN2vzpJhlM5b29VDWH0eNlqDEIG9Ob8DIN3hrod4q9JYblpEdoysCOng1mk4JlbusFWXK92FVXtI8w+y/wSMSfLUJz85FaGS+iPwTcvGIDGyULvY2WwY9q2+swnGv9jQ4JkX3Us0/7CLQR4yOf2incT3alQS/4e/GD+Y/sT1jEdYiEEVzSpS+VJcNWniaUBAybn5vNpNIAIF4Xtw4MpC/CrPGuWj6lP4ZW3FhPjGuA4f4s0dmn31mn72fQkurvsJ79RZzqgJa45NtioQnnXdUdPTiEHZuEkUOMzd2y63bpANP09oUstufd/ymv+m92HCjAWw0D395WNcz1i/z77CHGc1SeH5CwaLfzheGa87B12HrU9el0
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 587a6050-4e5d-4ae9-d209-08d782e86937
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 11:58:20.4824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aktrBoD5niCi5Epa7YhMj1wU2vfTPuW5fUuqPCNgEcbuN/bIdEaYy+oG8ljmNlAFJQ9GplMqJHTyA9NFyQkIrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2685
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFua2FqIEJhbnNhbA0K
PiBTZW50OiBNb25kYXksIDE2IERlY2VtYmVyLCAyMDE5IDEwOjQ4IFBNDQo+IFRvOiBIYW5qdW4g
R3VvIDxndW9oYW5qdW5AaHVhd2VpLmNvbT47IExvcmVuem8gUGllcmFsaXNpDQo+IDxsb3Jlbnpv
LnBpZXJhbGlzaUBhcm0uY29tPjsgU3VkZWVwIEhvbGxhIDxzdWRlZXAuaG9sbGFAYXJtLmNvbT47
DQo+IFJhZmFlbCBKIC4gV3lzb2NraSA8cmp3QHJqd3lzb2NraS5uZXQ+OyBMZW4gQnJvd24gPGxl
bmJAa2VybmVsLm9yZz4NCj4gQ2M6IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOyBsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IEpvbmF0aGFuIENhbWVyb24gPGpvbmF0
aGFuLmNhbWVyb25AaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gQUNQSS9JT1JU
OiBmaXggdGhlIGlvcnRfaWRfbWFwIGZ1bmN0aW9uDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+ID4gRnJvbTogSGFuanVuIEd1byA8Z3VvaGFuanVuQGh1YXdlaS5jb20+DQo+
ID4gU2VudDogTW9uZGF5LCAxNiBEZWNlbWJlciwgMjAxOSAwNToyNCBQTQ0KPiA+IFRvOiBQYW5r
YWogQmFuc2FsIDxwYW5rYWouYmFuc2FsQG54cC5jb20+OyBMb3JlbnpvIFBpZXJhbGlzaQ0KPiA+
IDxsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tPjsgU3VkZWVwIEhvbGxhIDxzdWRlZXAuaG9sbGFA
YXJtLmNvbT47DQo+ID4gUmFmYWVsIEogLiBXeXNvY2tpIDxyandAcmp3eXNvY2tpLm5ldD47IExl
biBCcm93biA8bGVuYkBrZXJuZWwub3JnPg0KPiA+IENjOiBsaW51eC1hY3BpQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+IEpvbmF0aGFu
IENhbWVyb24gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT4NCj4gPiBTdWJqZWN0OiBSZTog
W1BBVENIXSBBQ1BJL0lPUlQ6IGZpeCB0aGUgaW9ydF9pZF9tYXAgZnVuY3Rpb24NCj4gPg0KPiA+
IE9uIDIwMTkvMTIvMTYgMTM6MTQsIFBhbmthaiBCYW5zYWwgd3JvdGU6DQo+ID4gPiBIaSBIYW5q
dW4sDQo+ID4gPg0KPiA+ID4gVGhhbmtzIGZvciByZXBseWluZy4gUGxlYXNlIGZpbmQgbXkgcmVz
cG9uc2UgaW5saW5lDQo+ID4gPg0KPiA+ID4+IEhpIFBhbmthaiwNCj4gPiA+Pg0KPiA+ID4+IE9u
IDIwMTkvMTIvMTUgMjM6MTIsIFBhbmthaiBCYW5zYWwgd3JvdGU6DQo+ID4gPj4+IEFzIHBlcg0K
PiA+ID4+PiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91
cmw9aHR0cCUzQSUyRiUyRmkNCj4gPiA+Pj4gbmYNCj4gPiA+Pj4gb2MNCj4gPiA+Pj4NCj4gPiA+
Pg0KPiA+DQo+IGVudGVyLmFybS5jb20lMkZoZWxwJTJGdG9waWMlMkZjb20uYXJtLmRvYy5kZW4w
MDQ5ZCUyRkRFTjAwNDlEX0lPDQo+ID4gPj4gX1JlbWENCj4gPiA+Pj4NCj4gPiA+Pg0KPiA+DQo+
IHBwaW5nX1RhYmxlLnBkZiZhbXA7ZGF0YT0wMiU3QzAxJTdDcGFua2FqLmJhbnNhbCU0MG54cC5j
b20lN0M3OGQNCj4gPiA+PiA4MmE1NjANCj4gPiA+Pj4NCj4gPiA+Pg0KPiA+IDU3MTQyMTkxOTYw
MDhkNzgxZGIwNmE3JTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJQ0KPiA+
ID4+IDdDMSU3QzYNCj4gPiA+Pj4NCj4gPiA+Pg0KPiA+DQo+IDM3MTIwNjUwMDE4OTgzODE0JmFt
cDtzZGF0YT0lMkZSaEFUVUt4JTJGQTJnUEV4JTJCTlk5WCUyRjdrcVYNCj4gPiA+PiBDckVlUm5i
RSUNCj4gPiA+Pj4gMkIycWxUa2RHRGMlM0QmYW1wO3Jlc2VydmVkPTANCj4gPiA+Pj4gaW4gSUQg
bWFwcGluZ3M6DQo+ID4gPj4+IE51bWJlciBvZiBJRHMgPSBUaGUgbnVtYmVyIG9mIElEcyBpbiB0
aGUgcmFuZ2UgbWludXMgb25lLg0KPiA+ID4+DQo+ID4gPj4gSG1tLCB0aGUgc3BlYyBpcyBjb25m
dXNpbmcsIHRoZSBzcGVjIG1heSBuZWVkIHRvIGJlIHVwZGF0ZWQsIGZvcg0KPiA+ID4+IGV4YW1w
bGUsIGZvciBhIFBDSSBidXMsIGRldmljZSBJRCArIGZ1bmN0aW9uIElEIHdpbGwgdGFrZSA4IGJp
dHMNCj4gPiA+PiBhbmQgd2lsbCBiZSAyNTYgSURzIGZvciB0aGF0IFBDSSBidXMsIG5vdCBzdXJl
IHdoeSB3ZSBuZWVkIHRvIG1pbnVzIG9uZS4NCj4gPiA+Pg0KPiA+ID4NCj4gPiA+IEkgYWdyZWUg
dGhhdCB0aGlzICJtaW51cyBvbmUiIHRoaW5nIGlzIGNvbmZ1c2luZy4gTm90IHN1cmUgd2h5IEl0
DQo+ID4gPiB3YXMgcHV0IGluIHRoZSBzcGVjIGxpa2UgdGhhdC4gSSBndWVzcyB0aGV5IHdhbnRl
ZCB0aGUgbnVtYmVyIG9mIElEcw0KPiA+ID4gdG8gYmUgMA0KPiA+IGJhc2VkIGluc3RlYWQgb2Yg
MSBiYXNlZC4NCj4gPiA+DQo+ID4gPj4+DQo+ID4gPj4+IFRoZXJlZm9yZSwgaXQncyB2YWxpZCBm
b3IgSUQgbWFwcGluZyB0byBjb250YWluIHNpbmdsZSBkZXZpY2UNCj4gPiA+Pj4gbWFwcGluZyB3
aGljaCB3b3VsZCBoYXZlIE51bWJlciBvZiBJRHMgZmllbGQgMC4NCj4gPiA+Pg0KPiA+ID4+IFdo
eSBub3QgdXNlIHNpbmdsZSBtYXBwaW5nIGZsYWcgZm9yIHRoaXMgY2FzZT8NCj4gPiA+DQo+ID4g
PiBBY3R1YWxseSBzaW5nbGUgbWFwcGluZyBmbGFnIGRvZXNuJ3QgbWVhbiB0aGF0IHRoZXJlIGlz
IHNpbmdsZQ0KPiA+ID4gbWFwcGluZyBpbg0KPiA+IGFuIElEIG1hcHBpbmcuDQo+ID4gPiBJdCBt
ZWFucyB0aGF0IElucHV0IElEIHNob3VsZCBub3QgYmUgY29uc2lkZXJlZCB3aGVuIGxvb2tpbmcg
Zm9yDQo+ID4gPiBPdXRwdXQNCj4gPiBJRC4NCj4gPiA+IElmIHdlIHB1dCBzaW5nbGUgaWQgZmxh
ZywgdGhlbiB3ZSBjYW5ub3QgaGF2ZSBhIGNhc2Ugd2hlcmUgd2UgaGF2ZQ0KPiA+ID4gYW4gYXJy
YXkgb2Ygc2luZ2xlIG1hcHBpbmdzIGZvciBvbmUgZGV2aWNlLg0KPiA+ID4gZS5nLiBhbiBhcnJh
eSBvZiBzaW5nbGUgbWFwcGluZ3MgZm9yIG9uZSBQQ0llIFJvb3QgQ29tcGxleCwgd2hlcmUgd2UN
Cj4gPiA+IGhhdmUgYSB1bmlxdWUgb3V0cHV0IElEIGZvciBhIHVuaXF1ZSBCREYoSW5wdXQgSUQp
DQo+ID4NCj4gPiBBZ3JlZWQsIHNpbmdsZSBtYXBwaW5nIGZsYWcgaXMgbm90IHdvcmtpbmcgZm9y
IG11bHRpLWVudHJpcyBvZiBzaW5nbGUNCj4gbWFwcGluZ3MuDQo+ID4NCj4gPiBEbyB5b3UgaGF2
ZSBhIHJlYWwgdXNlIGNhc2UgZm9yIHRoaXMgZml4PyBJJ20gdGhpbmtpbmcgaWYgd2Ugd2lsbA0K
PiA+IGJyZWFrIGFueSBkZWxpdmVyZWQgcGxhdGZvcm1zIHdpdGggdGhpcyBwYXRjaCBhcHBsaWVk
LCBzaW5jZSB0aGlzIGNvZGUNCj4gPiBpcyBub3QgY2hhbmdlZCBmcm9tIDIwMTYsIGFuZCBpdCdz
IHRoZSBrZXkgbG9naWMgZm9yIG1hcHBpbmcgdGhlIElEcy4NCj4gDQo+IFdlIGhhdmUgdGhpcyB1
c2UgY2FzZSBpbiBvdXIgcGxhdGZvcm0gTlhQIExYMjE2MEEsIHdoZXJlIHdlIHByb3ZpZGUgdGhl
DQo+IGFycmF5IG9mIHNpbmdsZSBtYXBwaW5ncyBpbiBJT1JUIHRhYmxlLiBBY3R1YWxseSB3ZSBj
YW4gb25seSBoYXZlIGxpbWl0ZWQNCj4gbnVtYmVyIG9mIG91dHB1dCBJRHMgZm9yIFBDSWUgZGV2
aWNlcywgc28gd2UgYWxsb2NhdGUgdW5pcXVlIG91dHB1dCBJRCB0bw0KPiBlYWNoIEJERiBjb25u
ZWN0ZWQgdG8gYSBQQ0llIHJvb3QgY29tcGxleCBhbmQgcGFzcyB0aGVzZSBJRHMgaW4gSU9SVCB0
YWJsZS4NCj4gDQo+ID4NCj4gPiBJIGNoZWNrZWQgSGlzaWxpY29uJ3MgQVJNNjQgc2VydmVyIHBs
YXRmb3JtLCBOdW1iZXIgb2YgSURzIGlzIGVxdWFsIHRvDQo+ID4gdGhlIG51bWJlciBvZiBJRHMg
aW4gdGhlIHJhbmdlIGluIHRoZSBmaXJtd2FyZSwgd2hpY2ggaXMgbm90IGRvaW5nIHRoZQ0KPiA+
IHNhbWUgYXMgdGhlIHNwZWMgc2FpZCwgYnV0IChyaWRfaW4gPiBtYXAtPmlucHV0X2Jhc2UgKyBt
YXAtPmlkX2NvdW50KQ0KPiA+IGlzIHN0aWxsIHZhbGlkIHdpdGggdGhpcyBwYXRjaCBhcHBsaWVk
LCBub3Qgc3VyZSBmb3Igb3RoZXIgcGxhdGZvcm1zLg0KPiANCj4gSSBkb24ndCB0aGluayB0aGF0
IHRoaXMgcGF0Y2ggd291bGQgYnJlYWsgYW55IHBsYXRmb3JtIHdoaWNoIGhhcyBJT1JUIHRhYmxl
DQo+IGRlZmluZWQgYXMgcGVyIHNwZWMuCQ0KDQpMZXQgbWUgcmVwaGFzZSB0aGlzIHRvIHBlcnN1
YWRlIHlvdS4gVGhpcyBwYXRjaCBpcyAqaW5jcmVhc2luZyogdGhlIGFsbG93ZWQgaW5wdXQNCklE
cy4gVGhlcmVmb3JlLCB0aGlzIHBhdGNoIHdvdWxkICppbmNsdWRlKiBtb3JlIHBsYXRmb3JtcyBh
bmQgbm9uZSBvZiB0aGUgZXhpc3RpbmcNClBsYXRmb3JtcyBjYW4gYmUgYWZmZWN0ZWQgYnkgaXQs
IGJlY2F1c2UgYWxyZWFkeSB0aGVpciBJbnB1dCBJRHMgd291bGQgZmFsbCBpbiB0aGUgYWxsb3dl
ZCBJRHMuDQoNCj4gDQo+ID4NCj4gPiBUaGFua3MNCj4gPiBIYW5qdW4NCg0K
