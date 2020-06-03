Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36BA91ED8F9
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jun 2020 01:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgFCXMz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Jun 2020 19:12:55 -0400
Received: from mga03.intel.com ([134.134.136.65]:37629 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgFCXMz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Jun 2020 19:12:55 -0400
IronPort-SDR: UAINF7qaX0GOAgL3vJsGqkq6vcZyfDmGy7afHqRwJkGH4qGQl3yoqYg88PY5s0E87L2Z9wdEHm
 R9F79OIoSTDg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 16:12:54 -0700
IronPort-SDR: 0n2I2ZztAhNf6t0MKdRcDMcLGkfuVOV96CLHcVK4O6BlQ+O5rqhf+hIZP9f5KTygRuiVRhp8YV
 uYl33ikkExFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,470,1583222400"; 
   d="scan'208";a="258162251"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga007.jf.intel.com with ESMTP; 03 Jun 2020 16:12:54 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 3 Jun 2020 16:12:54 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 3 Jun 2020 16:12:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJz+TsfSWdwQKi+SLUyTE8CNM6VTx8tqBHIGIx2pdkRi9VGhBzrvygPC4PVO98oH9s276NrkZAwBjWAxJY2gT6zgdQF58loxUv98OchbNghfOVfUt3iI/fl963o4IwTA3u+8wbXtBNoYFdUWM73LgAyyhjoBvByf8BcEwVQR0nLlpV9jnPFFmqfaVUrHuMKd0L+GDtt6AyTAP5hXFksH2jq0qTzWqzifwNDTe+guB1ZBEKOfi6VXvsN7ZnijM3f27nw7DJ69FuhBOMuE4YcsMLEqrT96qzNvnDnpp7zl+IBKc9ITj5TxoIuy6DSZ1wuA/OswpK+WXM/5K5P3gJXIow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFaSRmqCYwYQTmSbIGamyj2XJcgcxO9inCWPVYoFlIE=;
 b=HP4PEn4KQ//sTIJxmN87BXoPlbcOrILS2HL+8rA0f6lDRLTbpPnUhsNDoITtka0Iq7tnRQ4WnSPhfEIqNToyLksJ/TE61N9k5Me7JH8FY02R7B1pqd1h/rbQYobiUQAn23lBpTou3+dGtUQbO+mCZM7QPNMJe9i7vvx+82TvG1qbXCq/d9iPEEcjoEZDk3k8hmYjl8daQ4pXtyoyFEih838rC/nN/m42jSGekbWnF7sV4hZbq+XgC3muF1NeUsMZ1mCcdYCC/pnwQRKzqTOF+e54VSXYr0QNpY8NMROJft+cix/e86YCI5YAVCzqZDKMsDPkEUtx719vbF4W1ZOVXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFaSRmqCYwYQTmSbIGamyj2XJcgcxO9inCWPVYoFlIE=;
 b=dHe/BD+5eCN0a6q1PmmjVS2JbIq1h+jkaUOiHO0zKFM/i+KQd4LfUlWl3FWssr8BUa1jbxO/acasgBFkafVvqJsmSJv85KyX5hVsvNKG24AG6ttM0xoS2V4X5uIZKAISDI73DIgX528XJEnEST7l1BCF3bmniw1iCSlA+gUVls0=
Received: from BYAPR11MB3096.namprd11.prod.outlook.com (2603:10b6:a03:8f::14)
 by BYAPR11MB3576.namprd11.prod.outlook.com (2603:10b6:a03:b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 3 Jun
 2020 23:12:51 +0000
Received: from BYAPR11MB3096.namprd11.prod.outlook.com
 ([fe80::ad0c:c6a9:6f39:eb92]) by BYAPR11MB3096.namprd11.prod.outlook.com
 ([fe80::ad0c:c6a9:6f39:eb92%5]) with mapi id 15.20.3045.022; Wed, 3 Jun 2020
 23:12:51 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC:     "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: RE: [PATCH v2] ACPICA: Replace one-element array with flexible-array
Thread-Topic: [PATCH v2] ACPICA: Replace one-element array with flexible-array
Thread-Index: AQHWOSW4bJIORmu8HEGpC35q6d9DM6jG3LQAgACpyRA=
Date:   Wed, 3 Jun 2020 23:12:51 +0000
Message-ID: <BYAPR11MB3096970A214F9C46C1767FBCF0880@BYAPR11MB3096.namprd11.prod.outlook.com>
References: <20200602213958.GA32150@embeddedor>
 <CAJZ5v0hd87G055A+ezkyF+UJQAeBvozFCvoC2Fxa1o-5YXrEhg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hd87G055A+ezkyF+UJQAeBvozFCvoC2Fxa1o-5YXrEhg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75b05652-c19d-48b1-fee3-08d80813a3d1
x-ms-traffictypediagnostic: BYAPR11MB3576:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB35764BF6829F5C0553C593AEF0880@BYAPR11MB3576.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04238CD941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RmIFGI0B1O+8WclD4QTEYV18b5KdvJaRFZbxFAT26WknmifoOjo2NCUHdo+anZ5i78sB62g8mGSgIJauQL1vNIx2ogcnY3PTl2sCz2NQtlDf+Ht77CMasr1kvZOOOu2OE/++2eg4jJeeJS3kxvc4YYgJwPFrJpHjPw2DqFuhp1KgIKHT2CLR3vD0G/ML3Y4d+S1k5i612xT20d/dNgpjEObvwnvT/O/0nLGp1R9AO9XqR8lb0Rk+1NLHFLsqdQy2je0sBxINw8sWwW2QwyD3xGDG8tfcy1kr90ETCue4oORWFavfZxbBRDTpG5+phEGxP6cpsyUUl/LPRhRyCJ6kT9fLfJCpsIwIHrCWI/W5mQ3xKRIgVjsOcbo0csblROX+xuSPzDt2UQulSA7A/ZbisA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3096.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(376002)(346002)(136003)(39860400002)(366004)(76116006)(6506007)(26005)(7696005)(66446008)(966005)(186003)(66556008)(86362001)(4326008)(53546011)(8936002)(64756008)(52536014)(66476007)(66946007)(478600001)(55016002)(71200400001)(316002)(8676002)(110136005)(9686003)(2906002)(5660300002)(83380400001)(33656002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: qcH2lQ1G6eUZKGAgGpHJMVxp1FQqIXZ41cSLtUcQ4s5lNF01E5xcI+6jvtQ+vj2R9RVDnsnFdGtjY5G+z9IkcQgtu4cvLG1CO3QxAg3fQWL6P2J/qUEDkqcevzhYPDGvLyQeBRvb5vaUfQOSr0lnSR5amVmoS722F9a75nrUAFRJQh3DoIQTtmvXhxKV2oaKs6HbSc67Soj8MEloc5WlIkyFV1IQpWlMj10kVlLE6aBcc8EVoMMEGIz81JHL2Gxt9Qkg2BUa4ibwgUZQZlIuw9vWKNZ34pfEcNqLanlkN1s6xaTyWgXS5uto0JozXz8sAjF8vnMPzCK3InOleKyKpK1Y8NKzJ9QYZMgY+yGSSlQMeHOvM+9CExL1/mF6OQp7zTFiyJA3z8UVrqLwBdaZQDn4pS0ZxyvI3exHN7iTZpLVdzJwvX/KArl76ed4DLSMcFKNBUbQlCCA6BlcioSpPUM9srTemjsN3xoFsog5oEZYuI1myO+BMFbkG1GxdS+v
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b05652-c19d-48b1-fee3-08d80813a3d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2020 23:12:51.6995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5KkM5gcWxEWr5xiUMs0rBVPpGekTYfhqx5hwxxNcBbv+3Da2UfTHKKdTyZIxXSjp+Tb2heuF6eYneOTvzd2dug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3576
X-OriginatorOrg: intel.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtYWNwaS1vd25l
ckB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWFjcGktDQo+IG93bmVyQHZnZXIua2VybmVsLm9yZz4g
T24gQmVoYWxmIE9mIFJhZmFlbCBKLiBXeXNvY2tpDQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSAz
LCAyMDIwIDY6MDQgQU0NCj4gVG86IEd1c3Rhdm8gQS4gUi4gU2lsdmEgPGd1c3Rhdm9hcnNAa2Vy
bmVsLm9yZz47IEthbmVkYSwgRXJpaw0KPiA8ZXJpay5rYW5lZGFAaW50ZWwuY29tPg0KPiBDYzog
TW9vcmUsIFJvYmVydCA8cm9iZXJ0Lm1vb3JlQGludGVsLmNvbT47IFd5c29ja2ksIFJhZmFlbCBK
DQo+IDxyYWZhZWwuai53eXNvY2tpQGludGVsLmNvbT47IExlbiBCcm93biA8bGVuYkBrZXJuZWwu
b3JnPjsgQUNQSSBEZXZlbA0KPiBNYWxpbmcgTGlzdCA8bGludXgtYWNwaUB2Z2VyLmtlcm5lbC5v
cmc+OyBvcGVuIGxpc3Q6QUNQSSBDT01QT05FTlQNCj4gQVJDSElURUNUVVJFIChBQ1BJQ0EpIDxk
ZXZlbEBhY3BpY2Eub3JnPjsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdA0KPiA8bGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZz47IEd1c3Rhdm8gQS4gUi4gU2lsdmENCj4gPGd1c3Rhdm9AZW1i
ZWRkZWRvci5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIEFDUElDQTogUmVwbGFjZSBv
bmUtZWxlbWVudCBhcnJheSB3aXRoIGZsZXhpYmxlLQ0KPiBhcnJheQ0KPiANCj4gT24gVHVlLCBK
dW4gMiwgMjAyMCBhdCAxMTozNCBQTSBHdXN0YXZvIEEuIFIuIFNpbHZhIDxndXN0YXZvYXJzQGtl
cm5lbC5vcmc+DQo+IHdyb3RlOg0KPiA+DQo+ID4gVGhlIGN1cnJlbnQgY29kZWJhc2UgbWFrZXMg
dXNlIG9mIG9uZS1lbGVtZW50IGFycmF5cyBpbiB0aGUgZm9sbG93aW5nDQo+ID4gZm9ybToNCj4g
Pg0KPiA+IHN0cnVjdCBzb21ldGhpbmcgew0KPiA+ICAgICBpbnQgbGVuZ3RoOw0KPiA+ICAgICB1
OCBkYXRhWzFdOw0KPiA+IH07DQo+ID4NCj4gPiBzdHJ1Y3Qgc29tZXRoaW5nICppbnN0YW5jZTsN
Cj4gPg0KPiA+IGluc3RhbmNlID0ga21hbGxvYyhzaXplb2YoKmluc3RhbmNlKSArIHNpemUsIEdG
UF9LRVJORUwpOw0KPiA+IGluc3RhbmNlLT5sZW5ndGggPSBzaXplOw0KPiA+IG1lbWNweShpbnN0
YW5jZS0+ZGF0YSwgc291cmNlLCBzaXplKTsNCj4gPg0KPiA+IGJ1dCB0aGUgcHJlZmVycmVkIG1l
Y2hhbmlzbSB0byBkZWNsYXJlIHZhcmlhYmxlLWxlbmd0aCB0eXBlcyBzdWNoIGFzDQo+ID4gdGhl
c2Ugb25lcyBpcyBhIGZsZXhpYmxlIGFycmF5IG1lbWJlclsxXVsyXSwgaW50cm9kdWNlZCBpbiBD
OTk6DQo+ID4NCj4gPiBzdHJ1Y3QgZm9vIHsNCj4gPiAgICAgICAgIGludCBzdHVmZjsNCj4gPiAg
ICAgICAgIHN0cnVjdCBib28gYXJyYXlbXTsNCj4gPiB9Ow0KPiA+DQo+ID4gQnkgbWFraW5nIHVz
ZSBvZiB0aGUgbWVjaGFuaXNtIGFib3ZlLCB3ZSB3aWxsIGdldCBhIGNvbXBpbGVyIHdhcm5pbmcN
Cj4gPiBpbiBjYXNlIHRoZSBmbGV4aWJsZSBhcnJheSBkb2VzIG5vdCBvY2N1ciBsYXN0IGluIHRo
ZSBzdHJ1Y3R1cmUsIHdoaWNoDQo+ID4gd2lsbCBoZWxwIHVzIHByZXZlbnQgc29tZSBraW5kIG9m
IHVuZGVmaW5lZCBiZWhhdmlvciBidWdzIGZyb20gYmVpbmcNCj4gPiBpbmFkdmVydGVudGx5IGlu
dHJvZHVjZWRbM10gdG8gdGhlIGNvZGViYXNlIGZyb20gbm93IG9uLg0KPiA+DQo+ID4gVGhpcyBp
c3N1ZSB3YXMgZm91bmQgd2l0aCB0aGUgaGVscCBvZiBDb2NjaW5lbGxlIGFuZCBhdWRpdGVkIF9t
YW51YWxseV8uDQo+ID4NCj4gPiBbMV0gaHR0cHM6Ly9nY2MuZ251Lm9yZy9vbmxpbmVkb2NzL2dj
Yy9aZXJvLUxlbmd0aC5odG1sDQo+ID4gWzJdIGh0dHBzOi8vZ2l0aHViLmNvbS9LU1BQL2xpbnV4
L2lzc3Vlcy8yMQ0KPiA+IFszXSBjb21taXQgNzY0OTc3MzI5MzJmICgiY3hnYjMvbDJ0OiBGaXgg
dW5kZWZpbmVkIGJlaGF2aW91ciIpDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBHdXN0YXZvIEEu
IFIuIFNpbHZhIDxndXN0YXZvYXJzQGtlcm5lbC5vcmc+DQo+IA0KPiBFcmlrLCBjYW4geW91IHRh
a2UgdGhpcyB0byB0aGUgdXBzdHJlYW0sIHBsZWFzZT8NClllcywgV2UnbGwgaGF2ZSB0byBtYWtl
IGFkZGl0aW9uYWwgY2hhbmdlcyB0byBvdGhlciBzdHJ1Y3R1cmVzIHdpdGggb25lLWVsZW1lbnQg
YXJyYXlzIGJ1dCB3ZSdsbCBnZXQgdGhpcyBpbiB0aW1lIGZvciB0aGUgdXBjb21pbmcgQUNQSUNB
IHJlbGVhc2UuDQoNClRoYW5rcywNCkVyaWsNCj4gDQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBpbiB2
MjoNCj4gPiAgLSBEb24ndCB1c2Ugc3RydWN0X3NpemUoKSBmb3Igbm93Lg0KPiA+ICAtIFVwZGF0
ZSBzdWJqZWN0IGxpbmUgYW5kIGNoYW5nZWxvZyB0ZXh0Lg0KPiA+DQo+ID4gIGRyaXZlcnMvYWNw
aS9hY3BpY2EvdXRpZHMuYyB8IDIgKy0NCj4gPiAgaW5jbHVkZS9hY3BpL2FjdHlwZXMuaCAgICAg
IHwgMiArLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvYWNwaWNhL3V0aWRzLmMg
Yi9kcml2ZXJzL2FjcGkvYWNwaWNhL3V0aWRzLmMNCj4gPiBpbmRleCAzYmIwNjkzNWEyYWQzLi4y
MjVmM2M2MDIwM2M3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYWNwaS9hY3BpY2EvdXRpZHMu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvYWNwaS9hY3BpY2EvdXRpZHMuYw0KPiA+IEBAIC0yNjMsNyAr
MjYzLDcgQEAgYWNwaV91dF9leGVjdXRlX0NJRChzdHJ1Y3QgYWNwaV9uYW1lc3BhY2Vfbm9kZQ0K
PiAqZGV2aWNlX25vZGUsDQo+ID4gICAgICAgICAgKiAzKSBTaXplIG9mIHRoZSBhY3R1YWwgQ0lE
IHN0cmluZ3MNCj4gPiAgICAgICAgICAqLw0KPiA+ICAgICAgICAgY2lkX2xpc3Rfc2l6ZSA9IHNp
emVvZihzdHJ1Y3QgYWNwaV9wbnBfZGV2aWNlX2lkX2xpc3QpICsNCj4gPiAtICAgICAgICAgICAo
KGNvdW50IC0gMSkgKiBzaXplb2Yoc3RydWN0IGFjcGlfcG5wX2RldmljZV9pZCkpICsNCj4gPiAr
ICAgICAgICAgICBjb3VudCAqIHNpemVvZihzdHJ1Y3QgYWNwaV9wbnBfZGV2aWNlX2lkKSArDQo+
ID4gICAgICAgICAgICAgc3RyaW5nX2FyZWFfc2l6ZTsNCj4gPg0KPiA+ICAgICAgICAgY2lkX2xp
c3QgPSBBQ1BJX0FMTE9DQVRFX1pFUk9FRChjaWRfbGlzdF9zaXplKTsNCj4gPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9hY3BpL2FjdHlwZXMuaCBiL2luY2x1ZGUvYWNwaS9hY3R5cGVzLmggaW5kZXgN
Cj4gPiA0ZGVmZWQ1OGVhMzM4Li5jN2JjZGEwYWQzNjZhIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1
ZGUvYWNwaS9hY3R5cGVzLmgNCj4gPiArKysgYi9pbmNsdWRlL2FjcGkvYWN0eXBlcy5oDQo+ID4g
QEAgLTExNDUsNyArMTE0NSw3IEBAIHN0cnVjdCBhY3BpX3BucF9kZXZpY2VfaWQgeyAgc3RydWN0
DQo+ID4gYWNwaV9wbnBfZGV2aWNlX2lkX2xpc3Qgew0KPiA+ICAgICAgICAgdTMyIGNvdW50OyAg
ICAgICAgICAgICAgLyogTnVtYmVyIG9mIElEcyBpbiBJZHMgYXJyYXkgKi8NCj4gPiAgICAgICAg
IHUzMiBsaXN0X3NpemU7ICAgICAgICAgIC8qIFNpemUgb2YgbGlzdCwgaW5jbHVkaW5nIElEIHN0
cmluZ3MgKi8NCj4gPiAtICAgICAgIHN0cnVjdCBhY3BpX3BucF9kZXZpY2VfaWQgaWRzWzFdOyAg
ICAgICAvKiBJRCBhcnJheSAqLw0KPiA+ICsgICAgICAgc3RydWN0IGFjcGlfcG5wX2RldmljZV9p
ZCBpZHNbXTsgICAgICAgIC8qIElEIGFycmF5ICovDQo+ID4gIH07DQo+ID4NCj4gPiAgLyoNCj4g
PiAtLQ0KPiA+IDIuMjcuMA0KPiA+DQo=
