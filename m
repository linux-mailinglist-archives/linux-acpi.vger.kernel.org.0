Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C45A2B275C
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Nov 2020 22:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgKMVpn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Nov 2020 16:45:43 -0500
Received: from mga03.intel.com ([134.134.136.65]:21780 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgKMVpZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 13 Nov 2020 16:45:25 -0500
IronPort-SDR: VIxFvNo5M8mSGP1OrwMDpHzPOOesNHv5TEI6VBLgRIQxeV6utv2cXVP0/WBdpWBD2r5L2Dy1Ex
 gh1HdFHBstkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9804"; a="170640743"
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="170640743"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 13:45:24 -0800
IronPort-SDR: YQnZxJc/63KjXkNcQ+i7+88KuKRA2Niaf7LIYjkXGHhB+Ae3hwxxyu25w0iNTyvQBcIwbMXFWq
 9GxEPy6aYOqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="531172350"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 13 Nov 2020 13:45:24 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 13 Nov 2020 13:45:23 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 13 Nov 2020 13:45:23 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 13 Nov 2020 13:45:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgSSPQaPj+IE0y/EdBfpaf2Chu6+QBfBw1NDr8u2Gw9nl5/Etx51OnELz4brBbytGP0GqupOdYpE5AkJMcUxLKnHDFZYahBin5LBw1SRnCtdcjZD2iwvhqqQZxVMYbMdKi3DtzfDU6qMy8GnRpSpNcbUl1mWFETPKYCwW59xKD3NynRWh9TADQuG4JXBdhiAXDSoI7k1W98K3X/vCbaNcUwdsqiJoEWQsbExcNSqe3L7GVdpJ2eNbHp1wmxU21xJtU5Mm6k757J226k1tae/QthWXMgunQy6kCnRrT/ikPhtLI+xTq/BPd2sNZdZgYt5lFjTnEfuBpixAWjNW3iYhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSZB0+yE4T2z1kPc2TkpTCyfqYwHHgEyabDuSYyP5VI=;
 b=fes6YfS+2k80xuba1HH3MpgQtrHF4HSk3XJXpxeqQJLIk94aKBmdgvvT1GPxVu38t9UCklDPN4hQup0cnC2xGOFA+RZ5+aO2/PoowdnbioRfdJUBHmncjcedDpOVLgB9HuWGm8uOJ6JXM5myTJDbBLDzs8Wmdl5vU4AmeVwRwwnc739L7DCotF78GXnD4xMYU+jtOgWIeMqgLoJ0Gcy4x340P3sq6SgnurksOjBV5dGhRr3FLnbDPfBcHPBqgp4IHQcvAZdT4lUin4PrUC9aJNXNUpib10NdAakLeU3gWD+OxL/8Yzq9wu/emzIGu8UvDZ4G180VxDoJbAO7oDwdng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSZB0+yE4T2z1kPc2TkpTCyfqYwHHgEyabDuSYyP5VI=;
 b=zqokXVnpauinqd1BQ5L/Md8CWHnMzGIBiu6LiNbVl59itEd0y6bocp5Sj6fS9bJ7ypnqqL15bM2RHJC2F97L8SH0qtyMx/s/QgYtOVloRw7ZzVKYW+212IjN9Z5GH18cmc+4TvmtZ3jjR9j9WfVhxArQ/LR1TjOj1AP+7lqfYWg=
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by SJ0PR11MB4976.namprd11.prod.outlook.com (2603:10b6:a03:2d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Fri, 13 Nov
 2020 21:45:20 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::9d74:8937:bd5f:3c6b]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::9d74:8937:bd5f:3c6b%6]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 21:45:19 +0000
From:   "Moore, Robert" <robert.moore@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
CC:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ACPICA: fix -Wfallthrough
Thread-Topic: [PATCH] ACPICA: fix -Wfallthrough
Thread-Index: AQHWt9BSaSJ92WwBRk6cKvxE5xanpKnGl5SwgAAB3QCAAAJ3cIAAAHnQgAAAbfA=
Date:   Fri, 13 Nov 2020 21:45:19 +0000
Message-ID: <BYAPR11MB3256DD34C3DABD2CB4FE347D87E60@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <20201111021131.822867-1-ndesaulniers@google.com>
 <BYAPR11MB32568FEEF4CFA1C20296427B87E60@BYAPR11MB3256.namprd11.prod.outlook.com>
 <CAKwvOd=qDNnOu1oTeEN+chvfJcQSS5dxREo0JQHC=W0zhpYeLw@mail.gmail.com>
 <BYAPR11MB32564DD5B9D140AFE8C3D1EB87E60@BYAPR11MB3256.namprd11.prod.outlook.com>
 <BYAPR11MB3256E6E37618702C5EA761A087E60@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB3256E6E37618702C5EA761A087E60@BYAPR11MB3256.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7717ead9-c3f4-4882-4271-08d8881d6ac3
x-ms-traffictypediagnostic: SJ0PR11MB4976:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB49765DF640D1CD91F21339F487E60@SJ0PR11MB4976.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x8MJsb9ALf1xF426Ail7Kh6Zmssv+ADwzn9DMNDE7PV5hw30jMRufvAFQ6o4AQIDfbzMuesoQsqlP7jRwxOwlGQO/AaZbqxAZIfPhImwLPqNUgyekbTimc531n1NXwaY9uruwtxwRVK9erWlJ3RbCzYShtAod1iWma8+AKNviPFIrGOGPKpabSQN0arCBH/t4GHwn9i85IJ9iBtNrKxW6qrwdxPGTDk1gfhlrV8k8MNBXS452TJGRKyUg64ysFujSX/487fG+C7EvNL00T4I9Fugq2qyizeCm6/2ZceytAfqP5B1Es81fdELjDYiLxopRfRlatOd0DtxeI61a/DB7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(53546011)(478600001)(2906002)(71200400001)(8936002)(5660300002)(54906003)(6916009)(76116006)(64756008)(83380400001)(52536014)(33656002)(9686003)(6506007)(2940100002)(66556008)(316002)(26005)(186003)(66446008)(66946007)(55016002)(8676002)(86362001)(7696005)(4326008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 6uAPDj/42JLZ1qfkexKalu2DZ7+FT/pdHdaCRn4iXj7OMfuqySNQePsyXXlPEN29h/3xe84I/QmRDEaNteRVHdKnZkf+0yD+PJBAeuHNLX5to3keFpu0ekx/ECRYmtZpZHYzqZDvOpCn6umKdDihbkLwjPuEWhYtrXIUgi22OFpfaquc9VFwBXhyd6kG5Xnv5sWKBn5Wusw0LRd4j8kL02VEXwN89CSI4WVEzojcz43tP67R941iwPN0YWoWLu15ZSG8UyekMgI4iYLrGsagz92K0k7I1wPw6Ls1hMQRnmNkwpDSchATHbDquYiduf2h2Qu24E9ITetSGKneHXROlrNwR4t1//R+Nm7O2ReXINY4tStNGs6jZU/KJ1tmLRdWfZyBiY3v32JfCoI84qQ1oYeZwmobILDY0eWQwpZvy5QEcae1nM7+2o05OM6z9qgHKh0sHrdRDLMEZz/75w/NE/CvZ/tIjJDV/9qgAGPKznsLoIzfxxIQETp/wRpZA7DmYMbjKkldgRG6XCun+2qDfQIx/IlOLRX9mRBDIE7cReGyUGnr5scc4kynPjsP/gGPikoKeeOteGBmLKO11DbqaMPVyNi108UKamX/12ybONzhXStx8EX9jqiLGJxLyW7iQ8ScVM6zi8pLjqZnrC9clw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7717ead9-c3f4-4882-4271-08d8881d6ac3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2020 21:45:19.8716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RaSad993TR1IavDXYmh7roZagyODpptPAMcEYE6HCaR7KY0oZuP/BoaKyCKWVQJweQaMo+pHKYE8NTk78aHMUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4976
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

QlRXLCBpZiB5b3UgY2FuIG1ha2UgYSBwdWxsIHJlcXVlc3QgZm9yIHRoZSBwYXRjaCB1cCBvbiBn
aXRodWIsIHRoYXQgd291bGQgaGVscC4NCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogTW9vcmUsIFJvYmVydCANClNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMTMsIDIwMjAgMTo0
NCBQTQ0KVG86IE5pY2sgRGVzYXVsbmllcnMgPG5kZXNhdWxuaWVyc0Bnb29nbGUuY29tPg0KQ2M6
IEthbmVkYSwgRXJpayA8ZXJpay5rYW5lZGFAaW50ZWwuY29tPjsgV3lzb2NraSwgUmFmYWVsIEog
PHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPjsgR3VzdGF2byBBIC4gUiAuIFNpbHZhIDxndXN0
YXZvYXJzQGtlcm5lbC5vcmc+OyBjbGFuZy1idWlsdC1saW51eEBnb29nbGVncm91cHMuY29tOyBM
ZW4gQnJvd24gPGxlbmJAa2VybmVsLm9yZz47IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOyBk
ZXZlbEBhY3BpY2Eub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBS
RTogW1BBVENIXSBBQ1BJQ0E6IGZpeCAtV2ZhbGx0aHJvdWdoDQoNCg0KDQotLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KRnJvbTogTW9vcmUsIFJvYmVydCANClNlbnQ6IEZyaWRheSwgTm92ZW1i
ZXIgMTMsIDIwMjAgMTo0MiBQTQ0KVG86IE5pY2sgRGVzYXVsbmllcnMgPG5kZXNhdWxuaWVyc0Bn
b29nbGUuY29tPg0KQ2M6IEthbmVkYSwgRXJpayA8ZXJpay5rYW5lZGFAaW50ZWwuY29tPjsgV3lz
b2NraSwgUmFmYWVsIEogPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPjsgR3VzdGF2byBBIC4g
UiAuIFNpbHZhIDxndXN0YXZvYXJzQGtlcm5lbC5vcmc+OyBjbGFuZy1idWlsdC1saW51eEBnb29n
bGVncm91cHMuY29tOyBMZW4gQnJvd24gPGxlbmJAa2VybmVsLm9yZz47IGxpbnV4LWFjcGlAdmdl
ci5rZXJuZWwub3JnOyBkZXZlbEBhY3BpY2Eub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnDQpTdWJqZWN0OiBSRTogW1BBVENIXSBBQ1BJQ0E6IGZpeCAtV2ZhbGx0aHJvdWdoDQoNCg0K
DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTmljayBEZXNhdWxuaWVycyA8bmRl
c2F1bG5pZXJzQGdvb2dsZS5jb20+DQpTZW50OiBGcmlkYXksIE5vdmVtYmVyIDEzLCAyMDIwIDE6
MzMgUE0NClRvOiBNb29yZSwgUm9iZXJ0IDxyb2JlcnQubW9vcmVAaW50ZWwuY29tPg0KQ2M6IEth
bmVkYSwgRXJpayA8ZXJpay5rYW5lZGFAaW50ZWwuY29tPjsgV3lzb2NraSwgUmFmYWVsIEogPHJh
ZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPjsgR3VzdGF2byBBIC4gUiAuIFNpbHZhIDxndXN0YXZv
YXJzQGtlcm5lbC5vcmc+OyBjbGFuZy1idWlsdC1saW51eEBnb29nbGVncm91cHMuY29tOyBMZW4g
QnJvd24gPGxlbmJAa2VybmVsLm9yZz47IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOyBkZXZl
bEBhY3BpY2Eub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTog
W1BBVENIXSBBQ1BJQ0E6IGZpeCAtV2ZhbGx0aHJvdWdoDQoNCk9uIEZyaSwgTm92IDEzLCAyMDIw
IGF0IDE6MjcgUE0gTW9vcmUsIFJvYmVydCA8cm9iZXJ0Lm1vb3JlQGludGVsLmNvbT4gd3JvdGU6
DQo+DQo+DQo+DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IG5kZXNhdWxu
aWVycyB2aWEgc2VuZGdtcg0KPiA8bmRlc2F1bG5pZXJzQG5kZXNhdWxuaWVyczEubXR2LmNvcnAu
Z29vZ2xlLmNvbT4gT24gQmVoYWxmIE9mIE5pY2sgDQo+IERlc2F1bG5pZXJzDQo+IFNlbnQ6IFR1
ZXNkYXksIE5vdmVtYmVyIDEwLCAyMDIwIDY6MTIgUE0NCj4gVG86IE1vb3JlLCBSb2JlcnQgPHJv
YmVydC5tb29yZUBpbnRlbC5jb20+OyBLYW5lZGEsIEVyaWsgDQo+IDxlcmlrLmthbmVkYUBpbnRl
bC5jb20+OyBXeXNvY2tpLCBSYWZhZWwgSiANCj4gPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29t
PjsgR3VzdGF2byBBIC4gUiAuIFNpbHZhIA0KPiA8Z3VzdGF2b2Fyc0BrZXJuZWwub3JnPg0KPiBD
YzogY2xhbmctYnVpbHQtbGludXhAZ29vZ2xlZ3JvdXBzLmNvbTsgTmljayBEZXNhdWxuaWVycyAN
Cj4gPG5kZXNhdWxuaWVyc0Bnb29nbGUuY29tPjsgTGVuIEJyb3duIDxsZW5iQGtlcm5lbC5vcmc+
OyANCj4gbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7IGRldmVsQGFjcGljYS5vcmc7IA0KPiBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSF0gQUNQSUNBOiBm
aXggLVdmYWxsdGhyb3VnaA0KPg0KPiBUaGUgImZhbGx0aHJvdWdoIiBwc2V1ZG8ta2V5d29yZCB3
YXMgYWRkZWQgYXMgYSBwb3J0YWJsZSB3YXkgdG8gZGVub3RlIGludGVudGlvbmFsIGZhbGx0aHJv
dWdoLiBUaGlzIGNvZGUgc2VlbWVkIHRvIGJlIHVzaW5nIGEgbWl4IG9mIGZhbGx0aHJvdWdoIGNv
bW1lbnRzIHRoYXQgR0NDIHJlY29nbml6ZXMsIGFuZCBzb21lIGtpbmQgb2YgbGludCBtYXJrZXIu
DQo+IEknbSBndWVzc2luZyB0aGF0IGxpbnRlciBoYXNuJ3QgYmVlbiBydW4gaW4gYSB3aGlsZSBm
cm9tIHRoZSBtaXhlZCB1c2Ugb2YgdGhlIG1hcmtlciB2cyBjb21tZW50cy4NCj4NCj4gLypsaW50
IC1mYWxsdGhyb3VnaCAqLw0KPg0KPiBUaGlzIGlzIHRoZSBsaW50IG1hcmtlcg0KDQpZZXM7IGJ1
dCBmcm9tIG15IHBhdGNoLCB0aGUgaHVuayBtb2RpZnlpbmcNCmFjcGlfZXhfc3RvcmVfb2JqZWN0
X3RvX25vZGUoKSBhbmQgdnNucHJpbnRmKCkgc2VlbSB0byBpbmRpY2F0ZSB0aGF0IG1heWJlIHRo
ZSBsaW50ZXIgaGFzbid0IGJlZW4gcnVuIGluIGEgd2hpbGUuDQoNCldoaWNoIGxpbnRlciBpcyB0
aGF0PyAgSSdtIGN1cmlvdXMgd2hldGhlciBJIHNob3VsZCBsZWF2ZSB0aG9zZSBiZSwgYW5kIHdo
ZXRoZXIgd2UncmUgZ29pbmcgdG8gaGF2ZSBhbiBpc3N1ZSBiZXR3ZWVuIGNvbXBpbGVycyBhbmQg
bGludGVycyBhcyB0byB3aGljaCBsaW5lL29yZGVyIHRoZXNlIHdvdWxkIG5lZWQgdG8gYXBwZWFy
IG9uLg0KDQpJdCdzIGFuIG9sZCB2ZXJzaW9uIG9mIFBDLUxpbnQsIHdoaWNoIHdlIGRvbid0IHVz
ZSBhbnltb3JlLg0KDQpTbywgeW91IGNhbiBnZXQgcmlkIG9mIHRoZSBsaW50IG1hcmtlcnMuDQoN
Cg0KDQo+DQo+IEJUVywgd2hhdCB2ZXJzaW9uIG9mIGdjYyBhZGRlZCAtV2ZhbGx0aHJvdWdoPw0K
DQpHQ0MgNy4xIGFkZGVkIC1XaW1wbGljaXQtZmFsbHRocm91Z2guDQoNCj4NCj4NCj4gU2lnbmVk
LW9mZi1ieTogTmljayBEZXNhdWxuaWVycyA8bmRlc2F1bG5pZXJzQGdvb2dsZS5jb20+DQo+IC0t
LQ0KPiAgZHJpdmVycy9hY3BpL2FjcGljYS9kc2NvbnRyb2wuYyB8IDMgKy0tDQo+ICBkcml2ZXJz
L2FjcGkvYWNwaWNhL2Rzd2V4ZWMuYyAgIHwgNCArLS0tDQo+ICBkcml2ZXJzL2FjcGkvYWNwaWNh
L2Rzd2xvYWQuYyAgIHwgMyArLS0NCj4gIGRyaXZlcnMvYWNwaS9hY3BpY2EvZHN3bG9hZDIuYyAg
fCAzICstLQ0KPiAgZHJpdmVycy9hY3BpL2FjcGljYS9leGZsZGlvLmMgICB8IDMgKy0tDQo+ICBk
cml2ZXJzL2FjcGkvYWNwaWNhL2V4cmVzb3AuYyAgIHwgNSArKy0tLQ0KPiAgZHJpdmVycy9hY3Bp
L2FjcGljYS9leHN0b3JlLmMgICB8IDYgKystLS0tDQo+ICBkcml2ZXJzL2FjcGkvYWNwaWNhL2h3
Z3BlLmMgICAgIHwgMyArLS0NCj4gIGRyaXZlcnMvYWNwaS9hY3BpY2EvdXRkZWxldGUuYyAgfCAz
ICstLQ0KPiAgZHJpdmVycy9hY3BpL2FjcGljYS91dHByaW50LmMgICB8IDIgKy0NCj4gIDEwIGZp
bGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDIzIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9hY3BpL2FjcGljYS9kc2NvbnRyb2wuYyANCj4gYi9kcml2ZXJzL2Fj
cGkvYWNwaWNhL2RzY29udHJvbC5jIGluZGV4IDRiNWI2ZTg1OWY2Mi4uMWU3NWU1ZmJmZDE5DQo+
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2FjcGkvYWNwaWNhL2RzY29udHJvbC5jDQo+ICsrKyBi
L2RyaXZlcnMvYWNwaS9hY3BpY2EvZHNjb250cm9sLmMNCj4gQEAgLTYxLDggKzYxLDcgQEAgYWNw
aV9kc19leGVjX2JlZ2luX2NvbnRyb2xfb3Aoc3RydWN0IGFjcGlfd2Fsa19zdGF0ZSAqd2Fsa19z
dGF0ZSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgfQ0KPiAgICAgICAgICAgICAgICAgfQ0KPiAtDQo+IC0gICAgICAg
ICAgICAgICAvKmxpbnQgLWZhbGx0aHJvdWdoICovDQo+ICsgICAgICAgICAgICAgICBmYWxsdGhy
b3VnaDsNCj4NCj4gICAgICAgICBjYXNlIEFNTF9JRl9PUDoNCj4gICAgICAgICAgICAgICAgIC8q
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvYWNwaWNhL2Rzd2V4ZWMuYyANCj4gYi9kcml2
ZXJzL2FjcGkvYWNwaWNhL2Rzd2V4ZWMuYyBpbmRleCAxZDRmOGM4MTAyOGMuLmU4YzMyZDRmZTU1
Zg0KPiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9hY3BpL2FjcGljYS9kc3dleGVjLmMNCj4gKysr
IGIvZHJpdmVycy9hY3BpL2FjcGljYS9kc3dleGVjLmMNCj4gQEAgLTU5Nyw5ICs1OTcsNyBAQCBh
Y3BpX3N0YXR1cyBhY3BpX2RzX2V4ZWNfZW5kX29wKHN0cnVjdCBhY3BpX3dhbGtfc3RhdGUgKndh
bGtfc3RhdGUpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKEFDUElfRkFJ
TFVSRShzdGF0dXMpKSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBicmVhazsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9DQo+IC0NCj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvKiBGYWxsIHRocm91Z2ggKi8NCj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAvKmxpbnQgLWZhbGx0aHJvdWdoICovDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZmFsbHRocm91Z2g7DQo+DQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgIGNhc2UgQU1MX0lOVF9FVkFMX1NVQlRSRUVfT1A6DQo+DQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2FjcGkvYWNwaWNhL2Rzd2xvYWQuYyANCj4gYi9kcml2ZXJzL2FjcGkvYWNw
aWNhL2Rzd2xvYWQuYyBpbmRleCAyNzA2OTMyNWI2ZGUuLmFmYzY2M2MzNzQyZA0KPiAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9hY3BpL2FjcGljYS9kc3dsb2FkLmMNCj4gKysrIGIvZHJpdmVycy9h
Y3BpL2FjcGljYS9kc3dsb2FkLmMNCj4gQEAgLTIyMyw4ICsyMjMsNyBAQCBhY3BpX2RzX2xvYWQx
X2JlZ2luX29wKHN0cnVjdCBhY3BpX3dhbGtfc3RhdGUgKndhbGtfc3RhdGUsDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcGFyc2VfZmxhZ3MgJiBBQ1BJX1BBUlNFX01PRFVMRV9MRVZF
TCkpIHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgfQ0KPiAtDQo+IC0gICAgICAgICAgICAgICAgICAgICAgIC8qbGlu
dCAtZmFsbHRocm91Z2ggKi8NCj4gKyAgICAgICAgICAgICAgICAgICAgICAgZmFsbHRocm91Z2g7
DQo+DQo+ICAgICAgICAgICAgICAgICBkZWZhdWx0Og0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9hY3BpL2FjcGljYS9kc3dsb2FkMi5jIA0KPiBiL2RyaXZlcnMvYWNwaS9hY3BpY2EvZHN3bG9h
ZDIuYyBpbmRleCBlZGFkYmUxNDY1MDYuLjFiNzk0YjZiYTA3Mg0KPiAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9hY3BpL2FjcGljYS9kc3dsb2FkMi5jDQo+ICsrKyBiL2RyaXZlcnMvYWNwaS9hY3Bp
Y2EvZHN3bG9hZDIuYw0KPiBAQCAtMjEzLDggKzIxMyw3IEBAIGFjcGlfZHNfbG9hZDJfYmVnaW5f
b3Aoc3RydWN0IGFjcGlfd2Fsa19zdGF0ZSAqd2Fsa19zdGF0ZSwNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBwYXJzZV9mbGFncyAmIEFDUElfUEFSU0VfTU9EVUxFX0xFVkVMKSkgew0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICB9DQo+IC0NCj4gLSAgICAgICAgICAgICAgICAgICAgICAgLypsaW50IC1mYWxs
dGhyb3VnaCAqLw0KPiArICAgICAgICAgICAgICAgICAgICAgICBmYWxsdGhyb3VnaDsNCj4NCj4g
ICAgICAgICAgICAgICAgIGRlZmF1bHQ6DQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkv
YWNwaWNhL2V4ZmxkaW8uYyANCj4gYi9kcml2ZXJzL2FjcGkvYWNwaWNhL2V4ZmxkaW8uYyBpbmRl
eCBhZGUzNWZmMWM3YmEuLjlkMWNhYmUwZmVkOQ0KPiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9h
Y3BpL2FjcGljYS9leGZsZGlvLmMNCj4gKysrIGIvZHJpdmVycy9hY3BpL2FjcGljYS9leGZsZGlv
LmMNCj4gQEAgLTQzMyw4ICs0MzMsNyBAQCBhY3BpX2V4X2ZpZWxkX2RhdHVtX2lvKHVuaW9uIGFj
cGlfb3BlcmFuZF9vYmplY3QgKm9ial9kZXNjLA0KPiAgICAgICAgICAgICAgICAgICogTm93IHRo
YXQgdGhlIEJhbmsgaGFzIGJlZW4gc2VsZWN0ZWQsIGZhbGwgdGhyb3VnaCB0byB0aGUNCj4gICAg
ICAgICAgICAgICAgICAqIHJlZ2lvbl9maWVsZCBjYXNlIGFuZCB3cml0ZSB0aGUgZGF0dW0gdG8g
dGhlIE9wZXJhdGlvbiBSZWdpb24NCj4gICAgICAgICAgICAgICAgICAqLw0KPiAtDQo+IC0gICAg
ICAgICAgICAgICAvKmxpbnQgLWZhbGx0aHJvdWdoICovDQo+ICsgICAgICAgICAgICAgICBmYWxs
dGhyb3VnaDsNCj4NCj4gICAgICAgICBjYXNlIEFDUElfVFlQRV9MT0NBTF9SRUdJT05fRklFTEQ6
DQo+ICAgICAgICAgICAgICAgICAvKg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2FjcGlj
YS9leHJlc29wLmMgDQo+IGIvZHJpdmVycy9hY3BpL2FjcGljYS9leHJlc29wLmMgaW5kZXggNGQx
YjIyOTcxZDU4Li5kZjQ4ZmFhOWE1NTENCj4gMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvYWNwaS9h
Y3BpY2EvZXhyZXNvcC5jDQo+ICsrKyBiL2RyaXZlcnMvYWNwaS9hY3BpY2EvZXhyZXNvcC5jDQo+
IEBAIC0xOTcsOCArMTk3LDcgQEAgYWNwaV9leF9yZXNvbHZlX29wZXJhbmRzKHUxNiBvcGNvZGUs
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2FzZSBBQ1BJX1JFRkNMQVNTX0RF
QlVHOg0KPg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGFyZ2V0
X29wID0gQU1MX0RFQlVHX09QOw0KPiAtDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAvKmxpbnQgLWZhbGx0aHJvdWdoICovDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBmYWxsdGhyb3VnaDsNCj4NCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBjYXNlIEFDUElfUkVGQ0xBU1NfQVJHOg0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGNhc2UgQUNQSV9SRUZDTEFTU19MT0NBTDoNCj4gQEAgLTI2NCw3ICsy
NjMsNyBAQCBhY3BpX2V4X3Jlc29sdmVfb3BlcmFuZHModTE2IG9wY29kZSwNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICogRWxzZSBub3QgYSBzdHJpbmcgLSBmYWxsIHRocm91Z2ggdG8gdGhl
IG5vcm1hbCBSZWZlcmVuY2UNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICogY2FzZSBiZWxv
dw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgKi8NCj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgLypsaW50IC1mYWxsdGhyb3VnaCAqLw0KPiArICAgICAgICAgICAgICAgICAgICAgICBmYWxs
dGhyb3VnaDsNCj4NCj4gICAgICAgICAgICAgICAgIGNhc2UgQVJHSV9SRUZFUkVOQ0U6ICAgIC8q
IFJlZmVyZW5jZXM6ICovDQo+ICAgICAgICAgICAgICAgICBjYXNlIEFSR0lfSU5URUdFUl9SRUY6
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvYWNwaWNhL2V4c3RvcmUuYyANCj4gYi9kcml2
ZXJzL2FjcGkvYWNwaWNhL2V4c3RvcmUuYyBpbmRleCAzYWRjMGEyOWQ4OTAuLjIwNjdiYWE3YzEy
MA0KPiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9hY3BpL2FjcGljYS9leHN0b3JlLmMNCj4gKysr
IGIvZHJpdmVycy9hY3BpL2FjcGljYS9leHN0b3JlLmMNCj4gQEAgLTk1LDggKzk1LDcgQEAgYWNw
aV9leF9zdG9yZSh1bmlvbiBhY3BpX29wZXJhbmRfb2JqZWN0ICpzb3VyY2VfZGVzYywNCj4gICAg
ICAgICAgICAgICAgIGlmIChkZXN0X2Rlc2MtPmNvbW1vbi5mbGFncyAmIEFPUE9CSl9BTUxfQ09O
U1RBTlQpIHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuX0FDUElfU1RBVFVTKEFF
X09LKTsNCj4gICAgICAgICAgICAgICAgIH0NCj4gLQ0KPiAtICAgICAgICAgICAgICAgLypsaW50
IC1mYWxsdGhyb3VnaCAqLw0KPiArICAgICAgICAgICAgICAgZmFsbHRocm91Z2g7DQo+DQo+ICAg
ICAgICAgZGVmYXVsdDoNCj4NCj4gQEAgLTQyMSw4ICs0MjAsNyBAQCBhY3BpX2V4X3N0b3JlX29i
amVjdF90b19ub2RlKHVuaW9uIGFjcGlfb3BlcmFuZF9vYmplY3QgKnNvdXJjZV9kZXNjLA0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0NCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBicmVhazsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiAtDQo+IC0g
ICAgICAgICAgICAgICAgICAgICAgIC8qIEZhbGx0aHJvdWdoICovDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGZhbGx0aHJvdWdoOw0KPg0KPiAgICAgICAgICAgICAgICAgY2FzZSBBQ1BJX1RZ
UEVfREVWSUNFOg0KPiAgICAgICAgICAgICAgICAgY2FzZSBBQ1BJX1RZUEVfRVZFTlQ6DQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvYWNwaWNhL2h3Z3BlLmMgYi9kcml2ZXJzL2FjcGkvYWNw
aWNhL2h3Z3BlLmMgDQo+IGluZGV4IGIxM2E0ZWQ1YmM2My4uZmJmYWQ4MGM4YTUzIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2FjcGkvYWNwaWNhL2h3Z3BlLmMNCj4gKysrIGIvZHJpdmVycy9hY3Bp
L2FjcGljYS9od2dwZS5jDQo+IEBAIC0xNjYsOCArMTY2LDcgQEAgYWNwaV9od19sb3dfc2V0X2dw
ZShzdHJ1Y3QgYWNwaV9ncGVfZXZlbnRfaW5mbyAqZ3BlX2V2ZW50X2luZm8sIHUzMiBhY3Rpb24p
DQo+ICAgICAgICAgICAgICAgICBpZiAoIShyZWdpc3Rlcl9iaXQgJiBncGVfcmVnaXN0ZXJfaW5m
by0+ZW5hYmxlX21hc2spKSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAoQUVf
QkFEX1BBUkFNRVRFUik7DQo+ICAgICAgICAgICAgICAgICB9DQo+IC0NCj4gLSAgICAgICAgICAg
ICAgIC8qbGludCAtZmFsbHRocm91Z2ggKi8NCj4gKyAgICAgICAgICAgICAgIGZhbGx0aHJvdWdo
Ow0KPg0KPiAgICAgICAgIGNhc2UgQUNQSV9HUEVfRU5BQkxFOg0KPg0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9hY3BpL2FjcGljYS91dGRlbGV0ZS5jIA0KPiBiL2RyaXZlcnMvYWNwaS9hY3BpY2Ev
dXRkZWxldGUuYyBpbmRleCA0YzBkNGU0MzQxOTYuLjgwNzZlNzk0NzU4NQ0KPiAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9hY3BpL2FjcGljYS91dGRlbGV0ZS5jDQo+ICsrKyBiL2RyaXZlcnMvYWNw
aS9hY3BpY2EvdXRkZWxldGUuYw0KPiBAQCAtMTExLDggKzExMSw3IEBAIHN0YXRpYyB2b2lkIGFj
cGlfdXRfZGVsZXRlX2ludGVybmFsX29iaih1bmlvbiBhY3BpX29wZXJhbmRfb2JqZWN0ICpvYmpl
Y3QpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICh2b2lkKWFjcGlfZXZfZGVsZXRlX2dwZV9i
bG9jayhvYmplY3QtPmRldmljZS4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGdwZV9ibG9jayk7DQo+ICAgICAgICAgICAgICAgICB9DQo+
IC0NCj4gLSAgICAgICAgICAgICAgIC8qbGludCAtZmFsbHRocm91Z2ggKi8NCj4gKyAgICAgICAg
ICAgICAgIGZhbGx0aHJvdWdoOw0KPg0KPiAgICAgICAgIGNhc2UgQUNQSV9UWVBFX1BST0NFU1NP
UjoNCj4gICAgICAgICBjYXNlIEFDUElfVFlQRV9USEVSTUFMOg0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9hY3BpL2FjcGljYS91dHByaW50LmMgDQo+IGIvZHJpdmVycy9hY3BpL2FjcGljYS91dHBy
aW50LmMgaW5kZXggNjgxYzExZjRhZjRlLi5mN2U0M2JhZjVmZjINCj4gMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvYWNwaS9hY3BpY2EvdXRwcmludC5jDQo+ICsrKyBiL2RyaXZlcnMvYWNwaS9hY3Bp
Y2EvdXRwcmludC5jDQo+IEBAIC00NzUsNyArNDc1LDcgQEAgaW50IHZzbnByaW50ZihjaGFyICpz
dHJpbmcsIGFjcGlfc2l6ZSBzaXplLCBjb25zdCBjaGFyICpmb3JtYXQsIHZhX2xpc3QgYXJncykN
Cj4gICAgICAgICAgICAgICAgIGNhc2UgJ1gnOg0KPg0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICB0eXBlIHw9IEFDUElfRk9STUFUX1VQUEVSOw0KPiAtICAgICAgICAgICAgICAgICAgICAgICAv
KiBGQUxMVEhST1VHSCAqLw0KPiArICAgICAgICAgICAgICAgICAgICAgICBmYWxsdGhyb3VnaDsN
Cj4NCj4gICAgICAgICAgICAgICAgIGNhc2UgJ3gnOg0KPg0KPiAtLQ0KPiAyLjI5LjIuMjIyLmc1
ZDJhOTJkMTBmOC1nb29nDQo+DQoNCg0KLS0NClRoYW5rcywNCn5OaWNrIERlc2F1bG5pZXJzDQo=
