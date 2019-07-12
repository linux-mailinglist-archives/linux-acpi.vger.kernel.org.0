Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7DC67385
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jul 2019 18:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfGLQoe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Jul 2019 12:44:34 -0400
Received: from mail-eopbgr790052.outbound.protection.outlook.com ([40.107.79.52]:35680
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726449AbfGLQoe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 Jul 2019 12:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJh2QdKyRDeI+h1cLj/I3dSJssXGfixlPTxQkwmnFlI=;
 b=fK2Lw2bxeMym8IXms4CqzOPrZhg/nOKBZaOM0MWrglqJ+2gNKO4N+BwC27YbXMlVYrCgPRwD/WtqsQhSRMd7vHnfCtbP0EwGzTueAY/HYjILSCYhaPnvD++/25r3D3viBGGb/0Fg/EK0P1rnmt5v/qEO4czDls0Ya9llgLtiVOY=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2749.namprd12.prod.outlook.com (52.135.107.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Fri, 12 Jul 2019 16:44:26 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::a475:e612:8e1e:ed28]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::a475:e612:8e1e:ed28%3]) with mapi id 15.20.2073.012; Fri, 12 Jul 2019
 16:44:26 +0000
From:   Janakarajan Natarajan <jnataraj@amd.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
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
Thread-Index: AQHVN06AuI3rG5PgEkGK1o9FtbMXtabE8IYAgABg2ICAAP63gIAA42sA
Date:   Fri, 12 Jul 2019 16:44:25 +0000
Message-ID: <3199bd27-68d6-3cda-7c03-fca6eeda96b9@amd.com>
References: <cover.1562781484.git.Janakarajan.Natarajan@amd.com>
 <e48c6b836f996a16472c777612f1e3343c542077.1562781484.git.Janakarajan.Natarajan@amd.com>
 <20190711061208.yqxt4ps67vmsy7sp@vireshk-i7>
 <eb208b15-d6b5-192d-b600-1f791c91eb4c@amd.com>
 <20190712031025.mylhtzehv3vs6db3@vireshk-i7>
In-Reply-To: <20190712031025.mylhtzehv3vs6db3@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0061.namprd04.prod.outlook.com
 (2603:10b6:805:2a::38) To SN6PR12MB2736.namprd12.prod.outlook.com
 (2603:10b6:805:77::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd67e51f-25fd-4415-a162-08d706e83315
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2749;
x-ms-traffictypediagnostic: SN6PR12MB2749:
x-microsoft-antispam-prvs: <SN6PR12MB274900989DEB629C66B0486BE7F20@SN6PR12MB2749.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(189003)(199004)(6512007)(186003)(6916009)(486006)(99286004)(53936002)(6116002)(3846002)(5660300002)(386003)(6506007)(4326008)(305945005)(8676002)(26005)(229853002)(102836004)(52116002)(76176011)(53546011)(81156014)(31686004)(81166006)(71190400001)(71200400001)(66066001)(6486002)(54906003)(316002)(8936002)(7736002)(6436002)(14454004)(2906002)(6246003)(36756003)(66946007)(66556008)(66446008)(256004)(14444005)(2616005)(64756008)(66476007)(68736007)(25786009)(446003)(476003)(31696002)(478600001)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2749;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BPWCYajQeLONG/40WMoyQeys6yqff+/lLDXoZMLhYwnOGxg+w15A4/iQ2DQ3UwrOkl86e8i//wYXd6pgT0CbLmWFhUTvWr64L8vbkGgm2P7mOdXd3dGH7Xjvn8t7LyR2l+D126YnQzrQBqcAakT204wWBs3QdZWPlBAG80uPJUMVln7UKZ8s7/5KpCUDYxz5VbqapkrJcpEMlBJlEd0mMmudYipO6ckhQbok4WCmgoLYw1DVVxLR2BoIv0O4hiZWboNlts87zh70O9Ltbvv5DoAuHqw1/zy5xPbc2Tu+qfSw5mTuBfbGUHQC6xmmGjjafJNMAzGNmaNNAAq10W4WGk2eYhVbMM1UCH6cTLaZpEwzYmnNiA+Nl0NBsfS821coIYQq0jHLBiPaAgBdsy8dptfSa9wNu6AxU7soEj+/AuY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38782C1E0788974C9CB662384F315DA5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd67e51f-25fd-4415-a162-08d706e83315
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 16:44:25.8497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jnataraj@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2749
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

T24gNy8xMS8yMDE5IDEwOjEwIFBNLCBWaXJlc2ggS3VtYXIgd3JvdGU6DQo+IE9uIDExLTA3LTE5
LCAxNjo1OCwgSmFuYWthcmFqYW4gTmF0YXJhamFuIHdyb3RlOg0KPj4gT24gNy8xMS8yMDE5IDE6
MTIgQU0sIFZpcmVzaCBLdW1hciB3cm90ZToNCj4+PiBPbiAxMC0wNy0xOSwgMTg6MzcsIE5hdGFy
YWphbiwgSmFuYWthcmFqYW4gd3JvdGU6DQo+Pj4+ICtzdGF0aWMgaW50IGFtZF9jcHVmcmVxX2Nw
dV9pbml0KHN0cnVjdCBjcHVmcmVxX3BvbGljeSAqcG9saWN5KQ0KPj4+PiArew0KPj4+PiArCXJl
dHVybiAwOw0KPj4+PiArfQ0KPj4+PiArDQo+Pj4+ICtzdGF0aWMgaW50IGFtZF9jcHVmcmVxX2Nw
dV9leGl0KHN0cnVjdCBjcHVmcmVxX3BvbGljeSAqcG9saWN5KQ0KPj4+PiArew0KPj4+PiArCXJl
dHVybiAwOw0KPj4+PiArfQ0KPj4+PiArDQo+Pj4+ICtzdGF0aWMgaW50IGFtZF9jcHVmcmVxX2Nw
dV92ZXJpZnkoc3RydWN0IGNwdWZyZXFfcG9saWN5ICpwb2xpY3kpDQo+Pj4+ICt7DQo+Pj4+ICsJ
cmV0dXJuIDA7DQo+Pj4+ICt9DQo+Pj4+ICsNCj4+Pj4gK3N0YXRpYyBpbnQgYW1kX2NwdWZyZXFf
Y3B1X3RhcmdldF9pbmRleChzdHJ1Y3QgY3B1ZnJlcV9wb2xpY3kgKnBvbGljeSwNCj4+Pj4gKwkJ
CQkJdW5zaWduZWQgaW50IGluZGV4KQ0KPj4+PiArew0KPj4+PiArCXJldHVybiAwOw0KPj4+PiAr
fQ0KPj4+IEFsbCBlbXB0eSBoZWxwZXJzID8gVGhlcmUgaXMgbm90aGluZyB5b3UgbmVlZCB0byBk
byA/DQo+Pg0KPj4gV2hlbiB3ZSBwb3N0ZWQgdjIgb2YgdGhpcyBwYXRjaHNldCwgUmFmYWVsIGxl
dCB1cyBrbm93IHRoYXQgaGUgd2FzDQo+PiB1bmNvbWZvcnRhYmxlDQo+Pg0KPj4gZ29pbmcgYmVo
aW5kIHRoZSAoYWNwaS1jcHVmcmVxKSBkcml2ZXJzIGJhY2sgYnkgbGV0dGluZyB0aGUgdXNlcg0K
Pj4gY29tbXVuaWNhdGUgZGlyZWN0bHkNCj4+DQo+PiB3aXRoIHRoZSBwbGF0Zm9ybS4gVGhhdCdz
IHRoZSByZWFzb24gd2UgaGF2ZSBhbiBlbXB0eSBkcml2ZXIgd2hvc2UNCj4+IHByaW1hcnkgcHVy
cG9zZQ0KPj4NCj4+IGlzIHRvIGV4cG9zZSBzeXNmcyBlbnRyaWVzIGZvciB0aGUgdXNlci4NCj4g
SSByZWFkIGhpcyBjb21tZW50cyBub3cgYW5kIHdoYXQgaGUgc3VnZ2VzdGVkIGlzOg0KPg0KPiAi
V2hhdCBhYm91dCBoYW5kbGluZyB0aGlzIGxpa2UgdGhlIG90aGVycyBkbywgdGhyb3VnaCBhIHBy
b3BlciBjcHVmcmVxDQo+IGRyaXZlcj8iDQo+DQo+IEkgYW0gbm90IHN1cmUgaWYgaGUgbWVhbnQg
c29tZXRoaW5nIGxpa2UgdGhhdCB5b3UgaGF2ZSBoZXJlLiBPbmx5IG9uZQ0KPiBjcHVmcmVxIGRy
aXZlciBjYW4gYmUgcmVnaXN0ZXJlZCBhdCBhbnkgcG9pbnQgb2YgdGltZSB3aXRoIHRoZSBrZXJu
ZWwsDQo+IGFuZCBzbyBpZiB0aGlzIG9uZSBpcyB0aGVyZSB0aGVuIGFjcGktY3B1ZnJlcSBvciBp
bnRlbC1wc3RhdGUgY2FuJ3QgYmUNCj4gdGhlcmUuIFdobyB3aWxsIGRvIERWRlMgPw0KDQoNCkJ5
IGRlZmF1bHQsIHRoZSBkcml2ZXIgaXMgZGlzYWJsZWQgYW5kIGNwdWZyZXEgZmFsbHMgYmFjayB0
byB1c2luZyANCmFjcGktY3B1ZnJlcS4gVG8gZW5hYmxlIHRoZSBkcml2ZXIsDQoNCmEgcGFyYW1l
dGVyIGkuZS4gYW1kX2NwdWZyZXEuY3BwY19lbmFibGU9MSBuZWVkcyB0byBiZSB1c2VkLiBUaGVu
IHRoZSANCnVzZXIgd2lsbCBnYWluIGFjY2VzcyB0bw0KDQovc3lzL2RldmljZXMvc3lzdGVtL2Nw
dS9jcHU8bnVtPi9hbWRfY3B1ZnJlcS97ZW5hYmxlLCBtYXhfcGVyZiwgDQptaW5fcGVyZiwgZGVz
aXJlZF9wZXJmLCBhdXRvX3NlbF9lbmFibGV9Lg0KDQoNCm1heF9wZXJmLCBtaW5fcGVyZiBhbGxv
d3MgdGhlIHVzZXIgdG8gaW5kaWNhdGUgdG8gdGhlIHBsYXRmb3JtIHRoZSANCnBlcmZvcm1hbmNl
IHRoZXkgZXhwZWN0DQoNCmluIGFuIGFic3RyYWN0IHNjYWxlIFttaW5fcGVyZiB0byBtYXhfcGVy
Zl0gaW5jbHVzaXZlLiBkZXNpcmVkX3BlcmYgaXMgDQp0aGUgcGVyZm9ybWFuY2UgdGhlIHVzZXIN
Cg0Kd291bGQgbGlrZSB0byBpZGVhbGx5IGFjaGlldmUuIGRlc2lyZWRfcGVyZiB3aWxsIGZhbGwg
d2l0aGluZyBtYXggYW5kIA0KbWluIHBlcmYuIEJhc2VkIG9uIHRoZSB2YWx1ZSBvZiB0aGVzZQ0K
DQpyZWdpc3RlcnMsIHRoZSBwbGF0Zm9ybSB3aWxsIGFkanVzdCBhIG51bWJlciBvZiB2YXJpYWJs
ZXMsIHZvbHRhZ2UgYW5kIA0KZnJlcXVlbmN5IGJlaW5nIG9uZSBvZiB0aGVtLg0KDQoNCklmIHRo
ZSB1c2VyIHdvdWxkIHJhdGhlciBoYXZlIHRoZSBzeXN0ZW0gaGFuZGxlIGFsbCBwb3dlci9wZXJm
b3JtYW5jZSANCmFkanVzdG1lbnRzIGJ5DQoNCml0c2VsZiwgdGhlbiB0aGV5IGNhbiBzZXQgdGhl
IGF1dG9fc2VsX2VuYWJsZSByZWdpc3Rlci4NCg0KDQpUaGFua3MsDQoNCkphbmFrYXJhamFuDQoN
Cg==
