Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5859465E10
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Jul 2019 18:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfGKQ6z (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 11 Jul 2019 12:58:55 -0400
Received: from mail-eopbgr810048.outbound.protection.outlook.com ([40.107.81.48]:21632
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728224AbfGKQ6z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 11 Jul 2019 12:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blq2a2g/1C2WanZzF6LBY88eshJgfND+aJiXRMLe9N4=;
 b=Ii2+kv3keVeGAYRX2IXfL5dgc2E2oYq+GiSzmuKc1MCaHDTBT4ugyO0m+AMq07/DsCbnqC0MWO/GTRKkljXmj35hzukRn1At6byHXW8I/4AH8LZ5y6etQVpoXnGca7Tz3BsSbpx6srIO/KyZXeBweAE8jZplaHccw7sNdrp6n/Q=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2751.namprd12.prod.outlook.com (52.135.107.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Thu, 11 Jul 2019 16:58:47 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::a475:e612:8e1e:ed28]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::a475:e612:8e1e:ed28%3]) with mapi id 15.20.2052.022; Thu, 11 Jul 2019
 16:58:47 +0000
From:   Janakarajan Natarajan <jnataraj@amd.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Subject: Re: [PATCHv3 6/6] drivers/cpufreq: Add a CPUFreq driver for AMD
 processors (Fam17h and later)
Thread-Topic: [PATCHv3 6/6] drivers/cpufreq: Add a CPUFreq driver for AMD
 processors (Fam17h and later)
Thread-Index: AQHVN06AuI3rG5PgEkGK1o9FtbMXtabE8IYAgAC0qYA=
Date:   Thu, 11 Jul 2019 16:58:47 +0000
Message-ID: <eb208b15-d6b5-192d-b600-1f791c91eb4c@amd.com>
References: <cover.1562781484.git.Janakarajan.Natarajan@amd.com>
 <e48c6b836f996a16472c777612f1e3343c542077.1562781484.git.Janakarajan.Natarajan@amd.com>
 <20190711061208.yqxt4ps67vmsy7sp@vireshk-i7>
In-Reply-To: <20190711061208.yqxt4ps67vmsy7sp@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0064.namprd04.prod.outlook.com
 (2603:10b6:805:2a::41) To SN6PR12MB2736.namprd12.prod.outlook.com
 (2603:10b6:805:77::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03a66e3e-8862-4257-670c-08d706210a39
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2751;
x-ms-traffictypediagnostic: SN6PR12MB2751:
x-microsoft-antispam-prvs: <SN6PR12MB2751A696F736BBA926705DE6E7F30@SN6PR12MB2751.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0095BCF226
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(189003)(199004)(66066001)(71200400001)(71190400001)(66556008)(64756008)(36756003)(66946007)(66446008)(66476007)(446003)(7736002)(6116002)(26005)(6506007)(53546011)(31696002)(386003)(3846002)(186003)(14454004)(305945005)(102836004)(5660300002)(6636002)(8676002)(52116002)(81156014)(81166006)(486006)(476003)(8936002)(6512007)(110136005)(316002)(6246003)(76176011)(99286004)(54906003)(14444005)(6486002)(256004)(53936002)(2906002)(478600001)(11346002)(2616005)(6436002)(31686004)(68736007)(25786009)(4326008)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2751;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fdhYieu2Zz7t6PZ3d9lEaK2FluAdAgax7LnZKuDoiuE/taGCoVdW0wQCL0bGGi8U3VXp/pqQTrwZ5dSjmmB/OJMOkO9LzTQ/Ap46jtwvcbrjEadTA9UDJ+gIQnogXSl333Em1b1q3GbvqMfDGGkb6+CxNPxMTA+YihVvn5ZV1mQnSeGMS7w5nzoeTmdb4zNP058YRWZqJ+qG7TSJhnvXY9rafSqGUCSRmlXs1Qq1BVNpWyWbMGfnVM2Zq/paAJOvDwLRrbd8l3dekn3wr4qPiqWVob2OzrZwczmV3N7zj7rXRKnP/ZObenWXLijsof4BmhCtGYv//JMCWd6POCkkcVpIv5pHZE+sQ6EASGVGFoHjADhhO5daqEGQJduRpMwow+a1CHjJopcdT4zYTso17XZGtg7rK6nh8IB8P3f1YVo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79552F95E21840478493D526A422E376@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a66e3e-8862-4257-670c-08d706210a39
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2019 16:58:47.3075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jnataraj@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2751
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gNy8xMS8yMDE5IDE6MTIgQU0sIFZpcmVzaCBLdW1hciB3cm90ZToNCj4gT24gMTAtMDctMTks
IDE4OjM3LCBOYXRhcmFqYW4sIEphbmFrYXJhamFuIHdyb3RlOg0KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvY3B1ZnJlcS9hbWQtY3B1ZnJlcS5jIGIvZHJpdmVycy9jcHVmcmVxL2FtZC1jcHVmcmVx
LmMNCj4+ICsjZGVmaW5lIHByX2ZtdChmbXQpCSJBTUQgQ3B1ZnJlcTogIiBmbXQNCj4+ICsNCj4+
ICsjaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQo+PiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5o
Pg0KPj4gKyNpbmNsdWRlIDxsaW51eC9jcHUuaD4NCj4+ICsjaW5jbHVkZSA8bGludXgvdm1hbGxv
Yy5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9jcHVmcmVxLmg+DQo+PiArI2luY2x1ZGUgPGxpbnV4
L2FjcGkuaD4NCj4+ICsjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4NCj4gUGxlYXNlIGtlZXAgdGhl
bSBpbiBhbHBoYWJldGljYWwgb3JkZXIuDQoNCg0KT2suDQoNCg0KPg0KPj4gKw0KPj4gKyNpbmNs
dWRlIDxhc20vdW5hbGlnbmVkLmg+DQo+PiArDQo+PiArI2luY2x1ZGUgPGFjcGkvY3BwY19hY3Bp
Lmg+DQo+PiArDQo+PiArc3RydWN0IGFtZF9kZXNjIHsNCj4+ICsJaW50IGNwdV9pZDsNCj4+ICsJ
c3RydWN0IGNwcGNfY3RybHMgY3RybHM7DQo+PiArCXN0cnVjdCBrb2JqZWN0IGtvYmo7DQo+PiAr
fTsNCj4+ICsNCj4+ICtzdHJ1Y3QgYW1kX2Rlc2MgKiphbGxfY3B1X2RhdGE7DQo+PiArDQo+PiAr
c3RhdGljIHVuc2lnbmVkIGludCBjcHBjX2VuYWJsZTsNCj4+ICttb2R1bGVfcGFyYW0oY3BwY19l
bmFibGUsIHVpbnQsIDA2NDQpOw0KPj4gK01PRFVMRV9QQVJNX0RFU0MoY3BwY19lbmFibGUsDQo+
PiArCQkgIjEgLSBlbmFibGUgQU1EIENwdUZyZXEsIGNyZWF0ZSBDUFBDIHN5c2ZzIGVudHJpZXMu
Iik7DQo+PiArDQo+PiArI2RlZmluZSB0b19hbWRfZGVzYyhhKSBjb250YWluZXJfb2YoYSwgc3Ry
dWN0IGFtZF9kZXNjLCBrb2JqKQ0KPj4gKw0KPj4gKyNkZWZpbmUgc2hvd19mdW5jKGFjY2Vzc19m
biwgc3RydWN0X25hbWUsIG1lbWJlcl9uYW1lKQkJCVwNCj4+ICsJc3RhdGljIHNzaXplX3Qgc2hv
d18jI21lbWJlcl9uYW1lKHN0cnVjdCBrb2JqZWN0ICprb2JqLAkJXA0KPj4gKwkJCQkJICBzdHJ1
Y3Qga29ial9hdHRyaWJ1dGUgKmF0dHIsCVwNCj4+ICsJCQkJCSAgY2hhciAqYnVmKQkJCVwNCj4+
ICsJewkJCQkJCQkJXA0KPj4gKwkJc3RydWN0IGFtZF9kZXNjICpkZXNjID0gdG9fYW1kX2Rlc2Mo
a29iaik7CQlcDQo+PiArCQlzdHJ1Y3Qgc3RydWN0X25hbWUgc3RfbmFtZSA9IHswfTsJCQlcDQo+
PiArCQlpbnQgcmV0OwkJCQkJCVwNCj4+ICsJCQkJCQkJCQlcDQo+PiArCQlyZXQgPSBhY2Nlc3Nf
Zm4oZGVzYy0+Y3B1X2lkLCAmc3RfbmFtZSk7CQlcDQo+PiArCQlpZiAocmV0KQkJCQkJCVwNCj4+
ICsJCQlyZXR1cm4gcmV0OwkJCQkJXA0KPj4gKwkJCQkJCQkJCVwNCj4+ICsJCXJldHVybiBzY25w
cmludGYoYnVmLCBQQUdFX1NJWkUsICIlbGx1XG4iLAkJXA0KPj4gKwkJCQkgKHU2NClzdF9uYW1l
Lm1lbWJlcl9uYW1lKTsJCVwNCj4+ICsJfQkJCQkJCQkJXA0KPj4gKw0KPj4gKyNkZWZpbmUgc3Rv
cmVfZnVuYyhzdHJ1Y3RfbmFtZSwgbWVtYmVyX25hbWUsIHJlZ19pZHgpCQkJXA0KPj4gKwlzdGF0
aWMgc3NpemVfdCBzdG9yZV8jI21lbWJlcl9uYW1lKHN0cnVjdCBrb2JqZWN0ICprb2JqLAlcDQo+
PiArCQkJCQkgICBzdHJ1Y3Qga29ial9hdHRyaWJ1dGUgKmF0dHIsCVwNCj4+ICsJCQkJCSAgIGNv
bnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50KVwNCj4+ICsJewkJCQkJCQkJXA0KPj4gKwkJc3Ry
dWN0IGFtZF9kZXNjICpkZXNjID0gdG9fYW1kX2Rlc2Moa29iaik7CQlcDQo+PiArCQlzdHJ1Y3Qg
c3RydWN0X25hbWUgc3RfbmFtZSA9IHswfTsJCQlcDQo+PiArCQl1MzIgdmFsOwkJCQkJCVwNCj4+
ICsJCWludCByZXQ7CQkJCQkJXA0KPj4gKwkJCQkJCQkJCVwNCj4+ICsJCXJldCA9IGtzdHJ0b3Uz
MihidWYsIDAsICZ2YWwpOwkJCQlcDQo+PiArCQlpZiAocmV0KQkJCQkJCVwNCj4+ICsJCQlyZXR1
cm4gcmV0OwkJCQkJXA0KPj4gKwkJCQkJCQkJCVwNCj4+ICsJCXN0X25hbWUubWVtYmVyX25hbWUg
PSB2YWw7CQkJCVwNCj4+ICsJCQkJCQkJCQlcDQo+PiArCQlyZXQgPSBjcHBjX3NldF9yZWcoZGVz
Yy0+Y3B1X2lkLCAmc3RfbmFtZSwgcmVnX2lkeCk7CVwNCj4+ICsJCWlmIChyZXQpCQkJCQkJXA0K
Pj4gKwkJCXJldHVybiByZXQ7CQkJCQlcDQo+PiArCQkJCQkJCQkJXA0KPj4gKwkJcmV0dXJuIGNv
dW50OwkJCQkJCVwNCj4+ICsJfQkJCQkJCQkJXA0KPj4gKw0KPj4gKyNkZWZpbmUgZGVmaW5lX29u
ZV9ydyhzdHJ1Y3RfbmFtZSwgYWNjZXNzX2ZuLCBtZW1iZXJfbmFtZSwgcmVnX2lkeCkJXA0KPj4g
KwlzaG93X2Z1bmMoYWNjZXNzX2ZuLCBzdHJ1Y3RfbmFtZSwgbWVtYmVyX25hbWUpCQkJXA0KPj4g
KwlzdG9yZV9mdW5jKHN0cnVjdF9uYW1lLCBtZW1iZXJfbmFtZSwgcmVnX2lkeCkJCQlcDQo+PiAr
CWRlZmluZV9vbmVfZ2xvYmFsX3J3KG1lbWJlcl9uYW1lKQ0KPj4gKw0KPj4gK2RlZmluZV9vbmVf
cncoY3BwY19jdHJscywgY3BwY19nZXRfY3RybHMsIGVuYWJsZSwgRU5BQkxFKTsNCj4+ICtkZWZp
bmVfb25lX3J3KGNwcGNfY3RybHMsIGNwcGNfZ2V0X2N0cmxzLCBtYXhfcGVyZiwgTUFYX1BFUkYp
Ow0KPj4gK2RlZmluZV9vbmVfcncoY3BwY19jdHJscywgY3BwY19nZXRfY3RybHMsIG1pbl9wZXJm
LCBNSU5fUEVSRik7DQo+PiArZGVmaW5lX29uZV9ydyhjcHBjX2N0cmxzLCBjcHBjX2dldF9jdHJs
cywgZGVzaXJlZF9wZXJmLCBERVNJUkVEX1BFUkYpOw0KPj4gK2RlZmluZV9vbmVfcncoY3BwY19j
dHJscywgY3BwY19nZXRfY3RybHMsIGF1dG9fc2VsX2VuYWJsZSwgQVVUT19TRUxfRU5BQkxFKTsN
Cj4+ICsNCj4+ICtzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAqYW1kX2NwdWZyZXFfYXR0cmlidXRl
c1tdID0gew0KPj4gKwkmZW5hYmxlLmF0dHIsDQo+PiArCSZtYXhfcGVyZi5hdHRyLA0KPj4gKwkm
bWluX3BlcmYuYXR0ciwNCj4+ICsJJmRlc2lyZWRfcGVyZi5hdHRyLA0KPj4gKwkmYXV0b19zZWxf
ZW5hYmxlLmF0dHIsDQo+PiArCU5VTEwNCj4+ICt9Ow0KPj4gKw0KPj4gK3N0YXRpYyBjb25zdCBz
dHJ1Y3QgYXR0cmlidXRlX2dyb3VwIGFtZF9jcHVmcmVxX2F0dHJfZ3JvdXAgPSB7DQo+PiArCS5h
dHRycyA9IGFtZF9jcHVmcmVxX2F0dHJpYnV0ZXMsDQo+PiArfTsNCj4+ICsNCj4+ICtzdGF0aWMg
c3RydWN0IGtvYmpfdHlwZSBhbWRfY3B1ZnJlcV90eXBlID0gew0KPj4gKwkuc3lzZnNfb3BzID0g
JmtvYmpfc3lzZnNfb3BzLA0KPj4gKwkuZGVmYXVsdF9hdHRycyA9IGFtZF9jcHVmcmVxX2F0dHJp
YnV0ZXMsDQo+PiArfTsNCj4+ICsNCj4+ICtzdGF0aWMgaW50IGFtZF9jcHVmcmVxX2NwdV9pbml0
KHN0cnVjdCBjcHVmcmVxX3BvbGljeSAqcG9saWN5KQ0KPj4gK3sNCj4+ICsJcmV0dXJuIDA7DQo+
PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBpbnQgYW1kX2NwdWZyZXFfY3B1X2V4aXQoc3RydWN0IGNw
dWZyZXFfcG9saWN5ICpwb2xpY3kpDQo+PiArew0KPj4gKwlyZXR1cm4gMDsNCj4+ICt9DQo+PiAr
DQo+PiArc3RhdGljIGludCBhbWRfY3B1ZnJlcV9jcHVfdmVyaWZ5KHN0cnVjdCBjcHVmcmVxX3Bv
bGljeSAqcG9saWN5KQ0KPj4gK3sNCj4+ICsJcmV0dXJuIDA7DQo+PiArfQ0KPj4gKw0KPj4gK3N0
YXRpYyBpbnQgYW1kX2NwdWZyZXFfY3B1X3RhcmdldF9pbmRleChzdHJ1Y3QgY3B1ZnJlcV9wb2xp
Y3kgKnBvbGljeSwNCj4+ICsJCQkJCXVuc2lnbmVkIGludCBpbmRleCkNCj4+ICt7DQo+PiArCXJl
dHVybiAwOw0KPj4gK30NCj4gQWxsIGVtcHR5IGhlbHBlcnMgPyBUaGVyZSBpcyBub3RoaW5nIHlv
dSBuZWVkIHRvIGRvID8NCg0KDQpXaGVuIHdlIHBvc3RlZCB2MiBvZiB0aGlzIHBhdGNoc2V0LCBS
YWZhZWwgbGV0IHVzIGtub3cgdGhhdCBoZSB3YXMgDQp1bmNvbWZvcnRhYmxlDQoNCmdvaW5nIGJl
aGluZCB0aGUgKGFjcGktY3B1ZnJlcSkgZHJpdmVycyBiYWNrIGJ5IGxldHRpbmcgdGhlIHVzZXIg
DQpjb21tdW5pY2F0ZSBkaXJlY3RseQ0KDQp3aXRoIHRoZSBwbGF0Zm9ybS4gVGhhdCdzIHRoZSBy
ZWFzb24gd2UgaGF2ZSBhbiBlbXB0eSBkcml2ZXIgd2hvc2UgDQpwcmltYXJ5IHB1cnBvc2UNCg0K
aXMgdG8gZXhwb3NlIHN5c2ZzIGVudHJpZXMgZm9yIHRoZSB1c2VyLg0KDQoNCj4NCj4+ICsNCj4+
ICtzdGF0aWMgc3RydWN0IGNwdWZyZXFfZHJpdmVyIGFtZF9jcHVmcmVxX2RyaXZlciA9IHsNCj4+
ICsJLm5hbWUgPSAiYW1kX2NwdWZyZXEiLA0KPj4gKwkuaW5pdCA9IGFtZF9jcHVmcmVxX2NwdV9p
bml0LA0KPj4gKwkuZXhpdCA9IGFtZF9jcHVmcmVxX2NwdV9leGl0LA0KPj4gKwkudmVyaWZ5ID0g
YW1kX2NwdWZyZXFfY3B1X3ZlcmlmeSwNCj4+ICsJLnRhcmdldF9pbmRleCA9IGFtZF9jcHVmcmVx
X2NwdV90YXJnZXRfaW5kZXgsDQo+PiArfTsNCj4+ICsNCj4+ICtzdGF0aWMgdm9pZCBhbWRfY3B1
ZnJlcV9zeXNmc19kZWxldGVfcGFyYW1zKHZvaWQpDQo+PiArew0KPj4gKwlpbnQgaTsNCj4+ICsN
Cj4+ICsJZm9yX2VhY2hfcG9zc2libGVfY3B1KGkpIHsNCj4+ICsJCWlmIChhbGxfY3B1X2RhdGFb
aV0pIHsNCj4+ICsJCQlrb2JqZWN0X2RlbCgmYWxsX2NwdV9kYXRhW2ldLT5rb2JqKTsNCj4gU2hv
dWxkbid0IHlvdSB1c2Uga29iamVjdF9wdXQoKSBpbnN0ZWFkIG9mIHRoaXMgPw0KDQoNCk9rLg0K
DQoNCj4NCj4+ICsJCQlrZnJlZShhbGxfY3B1X2RhdGFbaV0pOw0KPj4gKwkJfQ0KPj4gKwl9DQo+
PiArDQo+PiArCWtmcmVlKGFsbF9jcHVfZGF0YSk7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBp
bnQgX19pbml0IGFtZF9jcHVmcmVxX3N5c2ZzX2V4cG9zZV9wYXJhbXModm9pZCkNCj4+ICt7DQo+
PiArCXN0cnVjdCBkZXZpY2UgKmNwdV9kZXY7DQo+PiArCWludCBpLCByZXQ7DQo+PiArDQo+PiAr
CWFsbF9jcHVfZGF0YSA9IGtjYWxsb2MobnVtX3Bvc3NpYmxlX2NwdXMoKSwgc2l6ZW9mKHZvaWQg
KiksDQo+PiArCQkJICAgICAgIEdGUF9LRVJORUwpOw0KPj4gKw0KPj4gKwlpZiAoIWFsbF9jcHVf
ZGF0YSkNCj4+ICsJCXJldHVybiAtRU5PTUVNOw0KPj4gKw0KPj4gKwlmb3JfZWFjaF9wb3NzaWJs
ZV9jcHUoaSkgew0KPj4gKwkJYWxsX2NwdV9kYXRhW2ldID0ga3phbGxvYyhzaXplb2Yoc3RydWN0
IGFtZF9kZXNjKSwgR0ZQX0tFUk5FTCk7DQo+PiArCQlpZiAoIWFsbF9jcHVfZGF0YVtpXSkgew0K
Pj4gKwkJCXJldCA9IC1FTk9NRU07DQo+PiArCQkJZ290byBmcmVlOw0KPj4gKwkJfQ0KPj4gKw0K
Pj4gKwkJYWxsX2NwdV9kYXRhW2ldLT5jcHVfaWQgPSBpOw0KPj4gKwkJY3B1X2RldiA9IGdldF9j
cHVfZGV2aWNlKGkpOw0KPj4gKwkJcmV0ID0ga29iamVjdF9pbml0X2FuZF9hZGQoJmFsbF9jcHVf
ZGF0YVtpXS0+a29iaiwgJmFtZF9jcHVmcmVxX3R5cGUsDQo+PiArCQkJCQkgICAmY3B1X2Rldi0+
a29iaiwgImFtZF9jcHVmcmVxIik7DQo+PiArCQlpZiAocmV0KQ0KPj4gKwkJCWdvdG8gZnJlZTsN
Cj4+ICsJfQ0KPj4gKw0KPj4gKwlyZXR1cm4gMDsNCj4+ICtmcmVlOg0KPj4gKwlhbWRfY3B1ZnJl
cV9zeXNmc19kZWxldGVfcGFyYW1zKCk7DQo+PiArCXJldHVybiByZXQ7DQo+PiArfQ0KPiBJbnN0
ZWFkIG9mIGRvaW5nIHRoaXMgb25jZSBmb3IgYWxsIENQVXMsIGl0IHdvdWxkIGJlIGJldHRlciB0
byBkbyBpdA0KPiBldmVyeSB0aW1lIHRoZSAtPmluaXQoKSBjYWxsYmFjayBvZiB0aGUgZHJpdmVy
IGdldHMgY2FsbGVkLiBJZiB5b3UNCj4gaGF2ZSBvbmUgY3B1ZnJlcSBwb2xpY3kgZm9yIGVhY2gg
Q1BVIChpLmUuIG5vIENQVXMgc2hhcmUgY2xvY2sgbGluZXMpLA0KPiB0aGVuIHRoZSBpbml0KCkg
Y2FsbGJhY2sgd2lsbCBnZXQgY2FsbGVkIG9uY2UgZm9yIGVhY2ggQ1BVLg0KDQoNCldlIGFyZSB0
cnlpbmcgdG8gYXZvaWQgYW55IHVzZSBvZiB0aGUgY3B1ZnJlcSBtZWNoYW5pc20uDQoNCg0KVGhh
bmtzLA0KDQpKYW5ha2FyYWphbg0KDQoNCj4NCj4+ICsNCj4+ICtzdGF0aWMgaW50IF9faW5pdCBh
bWRfY3B1ZnJlcV9pbml0KHZvaWQpDQo+PiArew0KPj4gKwlpbnQgcmV0ID0gMDsNCj4+ICsNCj4+
ICsJLyoNCj4+ICsJICogVXNlIG9ubHkgaWY6DQo+PiArCSAqIC0gQU1ELA0KPj4gKwkgKiAtIEZh
bWlseSAxN2ggKG9yKSBuZXdlciBhbmQsDQo+PiArCSAqIC0gRXhwbGljaXRseSBlbmFibGVkDQo+
PiArCSAqLw0KPj4gKwlpZiAoYm9vdF9jcHVfZGF0YS54ODZfdmVuZG9yICE9IFg4Nl9WRU5ET1Jf
QU1EIHx8DQo+PiArCSAgICBib290X2NwdV9kYXRhLng4NiA8IDB4MTcgfHwgIWNwcGNfZW5hYmxl
KQ0KPj4gKwkJcmV0dXJuIC1FTk9ERVY7DQo+PiArDQo+PiArCXJldCA9IGNwdWZyZXFfcmVnaXN0
ZXJfZHJpdmVyKCZhbWRfY3B1ZnJlcV9kcml2ZXIpOw0KPj4gKwlpZiAocmV0KSB7DQo+PiArCQlw
cl9pbmZvKCJGYWlsZWQgdG8gcmVnaXN0ZXIgZHJpdmVyXG4iKTsNCj4+ICsJCWdvdG8gb3V0Ow0K
Pj4gKwl9DQo+PiArDQo+PiArCXJldCA9IGFtZF9jcHVmcmVxX3N5c2ZzX2V4cG9zZV9wYXJhbXMo
KTsNCj4+ICsJaWYgKHJldCkgew0KPj4gKwkJcHJfaW5mbygiQ291bGQgbm90IGNyZWF0ZSBzeXNm
cyBlbnRyaWVzXG4iKTsNCj4+ICsJCWNwdWZyZXFfdW5yZWdpc3Rlcl9kcml2ZXIoJmFtZF9jcHVm
cmVxX2RyaXZlcik7DQo+PiArCQlnb3RvIG91dDsNCj4+ICsJfQ0KPj4gKw0KPj4gKwlwcl9pbmZv
KCJVc2luZyBhbWQtY3B1ZnJlcSBkcml2ZXJcbiIpOw0KPj4gKwlyZXR1cm4gcmV0Ow0KPj4gKw0K
Pj4gK291dDoNCj4+ICsJcmV0dXJuIHJldDsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIHZvaWQg
X19leGl0IGFtZF9jcHVmcmVxX2V4aXQodm9pZCkNCj4+ICt7DQo+PiArCWFtZF9jcHVmcmVxX3N5
c2ZzX2RlbGV0ZV9wYXJhbXMoKTsNCj4+ICsJY3B1ZnJlcV91bnJlZ2lzdGVyX2RyaXZlcigmYW1k
X2NwdWZyZXFfZHJpdmVyKTsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBh
Y3BpX2RldmljZV9pZCBhbWRfYWNwaV9pZHNbXSBfX3VzZWQgPSB7DQo+PiArCXtBQ1BJX1BST0NF
U1NPUl9ERVZJQ0VfSElELCB9LA0KPj4gKwl7fQ0KPj4gK307DQo+PiArDQo+PiArZGV2aWNlX2lu
aXRjYWxsKGFtZF9jcHVmcmVxX2luaXQpOw0KPj4gK21vZHVsZV9leGl0KGFtZF9jcHVmcmVxX2V4
aXQpOw0KPj4gK01PRFVMRV9ERVZJQ0VfVEFCTEUoYWNwaSwgYW1kX2FjcGlfaWRzKTsNCj4gQWxs
IHRocmVlIHNob3VsZCBiZSBwbGFjZWQgZGlyZWN0bHkgYmVsb3cgdGhlIHN0cnVjdC9mdW5jdGlv
biB0aGV5DQo+IHJlcHJlc2VudCB3aXRob3V0IGFueSBibGFuayBsaW5lcyBpbiBiZXR3ZWVuLiBB
cyBzdWdnZXN0ZWQgaW4NCj4ga2VybmVsIGRvY3VtZW50YXRpb24uDQo+DQo+PiArDQo+PiArTU9E
VUxFX0FVVEhPUigiSmFuYWthcmFqYW4gTmF0YXJhamFuIik7DQo+PiArTU9EVUxFX0RFU0NSSVBU
SU9OKCJBTUQgQ1BVRnJlcSBkcml2ZXIgYmFzZWQgb24gQUNQSSBDUFBDIHY2LjEgc3BlYyIpOw0K
Pj4gK01PRFVMRV9MSUNFTlNFKCJHUEwiKTsNCj4gU2hvdWxkIHRoaXMgYmUgIkdQTCB2MiIgPw0K
Pg0KPj4gLS0gDQo+PiAyLjE3LjENCg==
