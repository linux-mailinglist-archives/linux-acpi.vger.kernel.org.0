Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071621F5DC5
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jun 2020 23:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgFJVn1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Jun 2020 17:43:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:26698 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbgFJVn0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Jun 2020 17:43:26 -0400
IronPort-SDR: wnDHQEpkQDK8+M+N/RHh8IYzZ5l00Etk1iGf2f5h0Bbf9mHBGrEaGo4rWUU9ZgZl8w4F86J80F
 w/hFMDPRQQuA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 14:43:23 -0700
IronPort-SDR: duF84cIY4SmP4cIWDhOcahumCSOZDIJuh6ZyKIgKAL9EHeEaqPhZsqtMHilFVxx3vYyWIsXA11
 Y4VbjcAOLv7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,497,1583222400"; 
   d="scan'208";a="473487589"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jun 2020 14:43:23 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 10 Jun 2020 14:43:23 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX114.amr.corp.intel.com (10.18.116.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 10 Jun 2020 14:43:22 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.51) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 10 Jun 2020 14:43:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBd6CfAt7SAQ8Z1gEz51ZFVzpow8JhseZKRmEglgXPmVOqVdGuau8fSMNbzmOEBsv33Em1dj39OCgNApi2W8IEpACVF1ZZvQw6lOoQjE/5QSt32JrZ7JAr1MAoQiTnHDfeLvC59X9YsjC8JUu5fv/bMUKy7xcKX8KB5ndnhlh/ZBTa+RGWmYI7LkE9qQTAHGzQpuf64btf1MREeMYwwuj2lOU+Lmu7ats3ut5mIu+cwM44YIH4Zfox3wIhPM+gtz+n0Za18B7Y2yHdn5Mn3a+IMacWPYVEm/S7IRcHpe7mJr89EGjjZ0ut4aXpF4H/gCD/dEbPwLZkDqtd8uHtBSsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8YZ8uuPm8A4/2N2U8UPpnxn5g/L5LUVhtT7OKV7g34=;
 b=gtolI7KxskRqoKm4bsSJ3ilN8WokXs8lKZ40V/l4as6oiwVL7nS3SKA0PVO0BYfx9qgYslbObQ1zstf5R1GSAo42J1XSbKf4TUPmplfIHQ1dFbLx6ncIsBLLT+4Kd9g5P9C8GhWLfxCkDwbq7vhUvhav3BEL3DmIRvr6OT4fLzVMFErjEZs0G3zGZvOYQGrf8cvcXLm0l7gMMlf1ivif2YV1w5qjxKWnk8uE7eN6z3QFY1u8THEYdCpCSvzElnVlBIEoRMmQXUZzVOPY+kw2cOLQ6COeflruFYhKgt1A7urA7IWzmwqg1S51tIwdIWpLtGtXM3s+qBkVElM4PADVNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8YZ8uuPm8A4/2N2U8UPpnxn5g/L5LUVhtT7OKV7g34=;
 b=PWCIwpNbtd/CWre53zOoRfN7T1rbBAlxxreywYD42umakGRnV5BOl2jZ7OQWRnhRwbPcECEkwwrjtx25OJQIrrLFufl3WopVS//89WjIPhckbLOj5/YbFz2jozDGxITuV2qamkRgb6Og555Nu/bazK9v2gKC+RbIM3+ARq+wb50=
Received: from BYAPR11MB3096.namprd11.prod.outlook.com (2603:10b6:a03:8f::14)
 by BYAPR11MB3223.namprd11.prod.outlook.com (2603:10b6:a03:1b::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19; Wed, 10 Jun
 2020 21:43:20 +0000
Received: from BYAPR11MB3096.namprd11.prod.outlook.com
 ([fe80::ad0c:c6a9:6f39:eb92]) by BYAPR11MB3096.namprd11.prod.outlook.com
 ([fe80::ad0c:c6a9:6f39:eb92%5]) with mapi id 15.20.3088.019; Wed, 10 Jun 2020
 21:43:20 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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
Thread-Index: AQHWOSW4bJIORmu8HEGpC35q6d9DM6jG3LQAgACpyRCACudN8A==
Date:   Wed, 10 Jun 2020 21:43:20 +0000
Message-ID: <BYAPR11MB3096F413EE4CF211E35A9422F0830@BYAPR11MB3096.namprd11.prod.outlook.com>
References: <20200602213958.GA32150@embeddedor>
 <CAJZ5v0hd87G055A+ezkyF+UJQAeBvozFCvoC2Fxa1o-5YXrEhg@mail.gmail.com>
 <BYAPR11MB3096970A214F9C46C1767FBCF0880@BYAPR11MB3096.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB3096970A214F9C46C1767FBCF0880@BYAPR11MB3096.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.192]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73101d7b-e532-45a7-b9e1-08d80d874b36
x-ms-traffictypediagnostic: BYAPR11MB3223:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3223DBDBE73825F500293700F0830@BYAPR11MB3223.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0430FA5CB7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6tj64UvNKvz7QuwuLsjQVdfn1+620DcFDhkbymoeupo7hVjdAxQsUfa+82czN1WFd7cdNIKHdCNbFIJQ6dxGie0YxAP2C828k+gUQT+umGdCn/V6e41wMctv+ljVa3jF/k3PXy85BNNICI59ww0tnzUvR2Gi/qRZfd3hrMTU5zh24CWM2wfGz0H1qw6rZ8+/rOUTI44vTjvbL8XNUXROqhHzy+hgoTNT2RbzXZzoVzL9TZlj90f1fYXDCPex5h6QRxJyN57fFYihtuLrgkMOCizY7mgV7EBGxVCsD1o6+Xw7AZOZSLoIc2fKQtpbD2J3XpoQdqwF2q+qpqPvbJ13MFgKtqO/EiXcV46sFLSC/JC+x09qSW9fkSfzbvCon2jDIyhm7jTp2sPwKjEWc4J3Lg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3096.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(396003)(136003)(366004)(346002)(39860400002)(186003)(54906003)(83380400001)(33656002)(64756008)(66446008)(2906002)(26005)(478600001)(86362001)(110136005)(71200400001)(66556008)(8936002)(6506007)(66946007)(8676002)(9686003)(5660300002)(316002)(7696005)(76116006)(66476007)(53546011)(966005)(52536014)(4326008)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: A4aqswjznOt3iZSEfit6IX/XwKdij79viljFIsfsecF83kXR8yNIqYHAiVYloAeMvq//oOfJKx/qQq0q7IL3X2gJpe2zYboGYW1kqvZQjsLMA7yQAvY/gqlqVFszr5J/cRUKJUNDL4Rrm0YbWnJsQKy0v93oRK+VTVF8Hnh3ww6YwS9GQAFlsVjnOUmv975klShjOGUg7t4il7dPnPlxDY48y9D4vg5MlXTt31dK1sdTGwfLtU0pa7ABdfiECYnucZO6nsjdMvdEnfTRXL+QJkP3uPD02m6GzI5Wuw6/jcJ5onBFStaWNKSeQQEl56Lnvph6sOqQtJjxTatfAEdOC2DbouNPAgQgaGWXu+BzkWTHU3XqIsoN8wtZUluHujlM3QJ3pJNaF/rFyueaH552udYrdjIgziGA1MDezTw8uz+8uIcFoKFD8Oq/I9oSgb8qz0eKnbftS05ZEMyRVhYvsdXaQpdT9M0BcMYPTV4kzWzM4FBHg7PrlsVBOia9OKPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 73101d7b-e532-45a7-b9e1-08d80d874b36
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2020 21:43:20.4999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HPV5pbQJ/sWo585lTrOxS1pCzQ4vyzNH67u1TfEfAaLc7/uXdjIbDKbQimxdkqEwAFMa5hHuyGLlfbjt9Y851w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3223
X-OriginatorOrg: intel.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtYWNwaS1vd25l
ckB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWFjcGktDQo+IG93bmVyQHZnZXIua2VybmVsLm9yZz4g
T24gQmVoYWxmIE9mIEthbmVkYSwgRXJpaw0KPiBTZW50OiBXZWRuZXNkYXksIEp1bmUgMywgMjAy
MCA0OjEzIFBNDQo+IFRvOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+OyBH
dXN0YXZvIEEuIFIuIFNpbHZhDQo+IDxndXN0YXZvYXJzQGtlcm5lbC5vcmc+DQo+IENjOiBNb29y
ZSwgUm9iZXJ0IDxyb2JlcnQubW9vcmVAaW50ZWwuY29tPjsgV3lzb2NraSwgUmFmYWVsIEoNCj4g
PHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPjsgTGVuIEJyb3duIDxsZW5iQGtlcm5lbC5vcmc+
OyBBQ1BJIERldmVsDQo+IE1hbGluZyBMaXN0IDxsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZz47
IG9wZW4gbGlzdDpBQ1BJIENPTVBPTkVOVA0KPiBBUkNISVRFQ1RVUkUgKEFDUElDQSkgPGRldmVs
QGFjcGljYS5vcmc+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0DQo+IDxsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnPjsgR3VzdGF2byBBLiBSLiBTaWx2YQ0KPiA8Z3VzdGF2b0BlbWJlZGRl
ZG9yLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSCB2Ml0gQUNQSUNBOiBSZXBsYWNlIG9uZS1l
bGVtZW50IGFycmF5IHdpdGggZmxleGlibGUtDQo+IGFycmF5DQo+IA0KPiANCj4gDQo+ID4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBsaW51eC1hY3BpLW93bmVyQHZnZXIu
a2VybmVsLm9yZyA8bGludXgtYWNwaS0NCj4gPiBvd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJl
aGFsZiBPZiBSYWZhZWwgSi4gV3lzb2NraQ0KPiA+IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSAzLCAy
MDIwIDY6MDQgQU0NCj4gPiBUbzogR3VzdGF2byBBLiBSLiBTaWx2YSA8Z3VzdGF2b2Fyc0BrZXJu
ZWwub3JnPjsgS2FuZWRhLCBFcmlrDQo+ID4gPGVyaWsua2FuZWRhQGludGVsLmNvbT4NCj4gPiBD
YzogTW9vcmUsIFJvYmVydCA8cm9iZXJ0Lm1vb3JlQGludGVsLmNvbT47IFd5c29ja2ksIFJhZmFl
bCBKDQo+ID4gPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPjsgTGVuIEJyb3duIDxsZW5iQGtl
cm5lbC5vcmc+OyBBQ1BJIERldmVsDQo+ID4gTWFsaW5nIExpc3QgPGxpbnV4LWFjcGlAdmdlci5r
ZXJuZWwub3JnPjsgb3BlbiBsaXN0OkFDUEkgQ09NUE9ORU5UDQo+ID4gQVJDSElURUNUVVJFIChB
Q1BJQ0EpIDxkZXZlbEBhY3BpY2Eub3JnPjsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdA0KPiA+
IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgR3VzdGF2byBBLiBSLiBTaWx2YQ0KPiA+
IDxndXN0YXZvQGVtYmVkZGVkb3IuY29tPg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIEFD
UElDQTogUmVwbGFjZSBvbmUtZWxlbWVudCBhcnJheSB3aXRoDQo+ID4gZmxleGlibGUtIGFycmF5
DQo+ID4NCj4gPiBPbiBUdWUsIEp1biAyLCAyMDIwIGF0IDExOjM0IFBNIEd1c3Rhdm8gQS4gUi4g
U2lsdmENCj4gPiA8Z3VzdGF2b2Fyc0BrZXJuZWwub3JnPg0KPiA+IHdyb3RlOg0KPiA+ID4NCj4g
PiA+IFRoZSBjdXJyZW50IGNvZGViYXNlIG1ha2VzIHVzZSBvZiBvbmUtZWxlbWVudCBhcnJheXMg
aW4gdGhlDQo+ID4gPiBmb2xsb3dpbmcNCj4gPiA+IGZvcm06DQo+ID4gPg0KPiA+ID4gc3RydWN0
IHNvbWV0aGluZyB7DQo+ID4gPiAgICAgaW50IGxlbmd0aDsNCj4gPiA+ICAgICB1OCBkYXRhWzFd
Ow0KPiA+ID4gfTsNCj4gPiA+DQo+ID4gPiBzdHJ1Y3Qgc29tZXRoaW5nICppbnN0YW5jZTsNCj4g
PiA+DQo+ID4gPiBpbnN0YW5jZSA9IGttYWxsb2Moc2l6ZW9mKCppbnN0YW5jZSkgKyBzaXplLCBH
RlBfS0VSTkVMKTsNCj4gPiA+IGluc3RhbmNlLT5sZW5ndGggPSBzaXplOw0KPiA+ID4gbWVtY3B5
KGluc3RhbmNlLT5kYXRhLCBzb3VyY2UsIHNpemUpOw0KPiA+ID4NCj4gPiA+IGJ1dCB0aGUgcHJl
ZmVycmVkIG1lY2hhbmlzbSB0byBkZWNsYXJlIHZhcmlhYmxlLWxlbmd0aCB0eXBlcyBzdWNoIGFz
DQo+ID4gPiB0aGVzZSBvbmVzIGlzIGEgZmxleGlibGUgYXJyYXkgbWVtYmVyWzFdWzJdLCBpbnRy
b2R1Y2VkIGluIEM5OToNCj4gPiA+DQo+ID4gPiBzdHJ1Y3QgZm9vIHsNCj4gPiA+ICAgICAgICAg
aW50IHN0dWZmOw0KPiA+ID4gICAgICAgICBzdHJ1Y3QgYm9vIGFycmF5W107DQo+ID4gPiB9Ow0K
PiA+ID4NCj4gPiA+IEJ5IG1ha2luZyB1c2Ugb2YgdGhlIG1lY2hhbmlzbSBhYm92ZSwgd2Ugd2ls
bCBnZXQgYSBjb21waWxlciB3YXJuaW5nDQo+ID4gPiBpbiBjYXNlIHRoZSBmbGV4aWJsZSBhcnJh
eSBkb2VzIG5vdCBvY2N1ciBsYXN0IGluIHRoZSBzdHJ1Y3R1cmUsDQo+ID4gPiB3aGljaCB3aWxs
IGhlbHAgdXMgcHJldmVudCBzb21lIGtpbmQgb2YgdW5kZWZpbmVkIGJlaGF2aW9yIGJ1Z3MgZnJv
bQ0KPiA+ID4gYmVpbmcgaW5hZHZlcnRlbnRseSBpbnRyb2R1Y2VkWzNdIHRvIHRoZSBjb2RlYmFz
ZSBmcm9tIG5vdyBvbi4NCj4gPiA+DQo+ID4gPiBUaGlzIGlzc3VlIHdhcyBmb3VuZCB3aXRoIHRo
ZSBoZWxwIG9mIENvY2NpbmVsbGUgYW5kIGF1ZGl0ZWQgX21hbnVhbGx5Xy4NCj4gPiA+DQo+ID4g
PiBbMV0gaHR0cHM6Ly9nY2MuZ251Lm9yZy9vbmxpbmVkb2NzL2djYy9aZXJvLUxlbmd0aC5odG1s
DQo+ID4gPiBbMl0gaHR0cHM6Ly9naXRodWIuY29tL0tTUFAvbGludXgvaXNzdWVzLzIxDQo+ID4g
PiBbM10gY29tbWl0IDc2NDk3NzMyOTMyZiAoImN4Z2IzL2wydDogRml4IHVuZGVmaW5lZCBiZWhh
dmlvdXIiKQ0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEd1c3Rhdm8gQS4gUi4gU2lsdmEg
PGd1c3Rhdm9hcnNAa2VybmVsLm9yZz4NCj4gPg0KPiA+IEVyaWssIGNhbiB5b3UgdGFrZSB0aGlz
IHRvIHRoZSB1cHN0cmVhbSwgcGxlYXNlPw0KPiBZZXMsIFdlJ2xsIGhhdmUgdG8gbWFrZSBhZGRp
dGlvbmFsIGNoYW5nZXMgdG8gb3RoZXIgc3RydWN0dXJlcyB3aXRoIG9uZS0NCj4gZWxlbWVudCBh
cnJheXMgYnV0IHdlJ2xsIGdldCB0aGlzIGluIHRpbWUgZm9yIHRoZSB1cGNvbWluZyBBQ1BJQ0Eg
cmVsZWFzZS4NCg0KUHVsbCByZXF1ZXN0IGF2YWlsYWJsZSBoZXJlOiBodHRwczovL2dpdGh1Yi5j
b20vYWNwaWNhL2FjcGljYS9wdWxsLzYwOA0KDQpFcmlrDQo+IA0KPiBUaGFua3MsDQo+IEVyaWsN
Cj4gPg0KPiA+ID4gLS0tDQo+ID4gPiBDaGFuZ2VzIGluIHYyOg0KPiA+ID4gIC0gRG9uJ3QgdXNl
IHN0cnVjdF9zaXplKCkgZm9yIG5vdy4NCj4gPiA+ICAtIFVwZGF0ZSBzdWJqZWN0IGxpbmUgYW5k
IGNoYW5nZWxvZyB0ZXh0Lg0KPiA+ID4NCj4gPiA+ICBkcml2ZXJzL2FjcGkvYWNwaWNhL3V0aWRz
LmMgfCAyICstDQo+ID4gPiAgaW5jbHVkZS9hY3BpL2FjdHlwZXMuaCAgICAgIHwgMiArLQ0KPiA+
ID4gIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+
ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvYWNwaWNhL3V0aWRzLmMNCj4gPiA+
IGIvZHJpdmVycy9hY3BpL2FjcGljYS91dGlkcy5jIGluZGV4IDNiYjA2OTM1YTJhZDMuLjIyNWYz
YzYwMjAzYzcNCj4gPiA+IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9hY3BpL2FjcGljYS91
dGlkcy5jDQo+ID4gPiArKysgYi9kcml2ZXJzL2FjcGkvYWNwaWNhL3V0aWRzLmMNCj4gPiA+IEBA
IC0yNjMsNyArMjYzLDcgQEAgYWNwaV91dF9leGVjdXRlX0NJRChzdHJ1Y3QNCj4gYWNwaV9uYW1l
c3BhY2Vfbm9kZQ0KPiA+ICpkZXZpY2Vfbm9kZSwNCj4gPiA+ICAgICAgICAgICogMykgU2l6ZSBv
ZiB0aGUgYWN0dWFsIENJRCBzdHJpbmdzDQo+ID4gPiAgICAgICAgICAqLw0KPiA+ID4gICAgICAg
ICBjaWRfbGlzdF9zaXplID0gc2l6ZW9mKHN0cnVjdCBhY3BpX3BucF9kZXZpY2VfaWRfbGlzdCkg
Kw0KPiA+ID4gLSAgICAgICAgICAgKChjb3VudCAtIDEpICogc2l6ZW9mKHN0cnVjdCBhY3BpX3Bu
cF9kZXZpY2VfaWQpKSArDQo+ID4gPiArICAgICAgICAgICBjb3VudCAqIHNpemVvZihzdHJ1Y3Qg
YWNwaV9wbnBfZGV2aWNlX2lkKSArDQo+ID4gPiAgICAgICAgICAgICBzdHJpbmdfYXJlYV9zaXpl
Ow0KPiA+ID4NCj4gPiA+ICAgICAgICAgY2lkX2xpc3QgPSBBQ1BJX0FMTE9DQVRFX1pFUk9FRChj
aWRfbGlzdF9zaXplKTsNCj4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2FjcGkvYWN0eXBlcy5o
IGIvaW5jbHVkZS9hY3BpL2FjdHlwZXMuaCBpbmRleA0KPiA+ID4gNGRlZmVkNThlYTMzOC4uYzdi
Y2RhMGFkMzY2YSAxMDA2NDQNCj4gPiA+IC0tLSBhL2luY2x1ZGUvYWNwaS9hY3R5cGVzLmgNCj4g
PiA+ICsrKyBiL2luY2x1ZGUvYWNwaS9hY3R5cGVzLmgNCj4gPiA+IEBAIC0xMTQ1LDcgKzExNDUs
NyBAQCBzdHJ1Y3QgYWNwaV9wbnBfZGV2aWNlX2lkIHsgIHN0cnVjdA0KPiA+ID4gYWNwaV9wbnBf
ZGV2aWNlX2lkX2xpc3Qgew0KPiA+ID4gICAgICAgICB1MzIgY291bnQ7ICAgICAgICAgICAgICAv
KiBOdW1iZXIgb2YgSURzIGluIElkcyBhcnJheSAqLw0KPiA+ID4gICAgICAgICB1MzIgbGlzdF9z
aXplOyAgICAgICAgICAvKiBTaXplIG9mIGxpc3QsIGluY2x1ZGluZyBJRCBzdHJpbmdzICovDQo+
ID4gPiAtICAgICAgIHN0cnVjdCBhY3BpX3BucF9kZXZpY2VfaWQgaWRzWzFdOyAgICAgICAvKiBJ
RCBhcnJheSAqLw0KPiA+ID4gKyAgICAgICBzdHJ1Y3QgYWNwaV9wbnBfZGV2aWNlX2lkIGlkc1td
OyAgICAgICAgLyogSUQgYXJyYXkgKi8NCj4gPiA+ICB9Ow0KPiA+ID4NCj4gPiA+ICAvKg0KPiA+
ID4gLS0NCj4gPiA+IDIuMjcuMA0KPiA+ID4NCg==
