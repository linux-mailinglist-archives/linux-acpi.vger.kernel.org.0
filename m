Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6C421982BE
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Mar 2020 19:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgC3Rw2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Mar 2020 13:52:28 -0400
Received: from mga05.intel.com ([192.55.52.43]:9270 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728903AbgC3Rw2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 30 Mar 2020 13:52:28 -0400
IronPort-SDR: 7HlzV+ZINBEL9p62As44div3RHLbd/VthigZps2/Lo5oXtFMrC0yHAmfZopPg8ztO995xL1aXJ
 432kPQlVSCDw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 10:52:27 -0700
IronPort-SDR: y20KJcxqNDWEsfilSexEMd3jeGUIKKnInobanW2MIqsrauboxXZNLI/gBGrsEK7OsTjPLz/Jdq
 TPizolHkJSgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,325,1580803200"; 
   d="scan'208";a="241684428"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga008.fm.intel.com with ESMTP; 30 Mar 2020 10:52:27 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Mar 2020 10:52:27 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 30 Mar 2020 10:52:26 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 30 Mar 2020 10:52:26 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 30 Mar 2020 10:52:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGPz1Wsb1OEcpR6ccfVHUvWmdJxn7N/MKChcu1eDI4zjGDpVCiXzGR3bzwF504WIVoTf6T2wt5KW71Y2eCQXrNiLGyP9gYMIA7iGKTYumHNnPrs8nLJfC4eiZF262d62snahWatQwC6fIFvLWrfFBDePJm8tvshgq5LC/w2B24GCrEdEaGHFzb9bgmyB96SN8OXwmq4t/sM2CGJLfb5dx4rnLWXD3tgnFO5qBftS3g6gTfDNvHmpncHbRZBbLeZU1VHfe2TQF+Vhw26+OQc0vkegSONqpe2N25csibdYAOn82N7sXpU99PbaJhxdyzznbPf1dnfONir/EAEJmqsZkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtJtq8MNeAs3RGTsDXr7DmM0+iZvIbDXJeFJbeKTb2k=;
 b=e8iBvxtL6T2OEA+bXY6M6occ9lH71C80bgyiSDqd2dKhviDBDltkoHigLRwwnhITo2bMtT7ZE19akYLC6jEgtkLWcSXeBaM+5sKtgzF7tLQNHNT4GXw9+nAn7qRDk/SM1qcwt5ta7QimF9DZfs1FANRprCX6EPVOVJzUBnfL5VKttGbKxCF8Ti9EXB6rMNaYacpHfT2Ox5K6avG4pLtG0voRSAEEgy4DGpTIfabUSpYRfsZ5eDjwb2IVtdJAPjIcu5veEbyk/o77eil1LGnJ6k2FuZuPjzmSlUAPb0ZmD/6wOHae5FXB9qcMi8qiuvE1m8t4cwRyyWSwFJ/g1aoAlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtJtq8MNeAs3RGTsDXr7DmM0+iZvIbDXJeFJbeKTb2k=;
 b=ukfUUFCvEmmgviXx0TVfSbSVjm2YPVPiAp+uK7bAGeuFSHzOoZCG5cO9nnOKmUGv3zDRvRm54Gu/VKmS76I3TFEDh02u3cHr3NTnofxO091QRxkbaxTJ2eNesaun0vNhOMxZyElJJV1i/iGDqmmjNGa92tUIOM4rDhDIU+/eE/s=
Received: from CY4PR11MB1719.namprd11.prod.outlook.com (2603:10b6:903:2d::23)
 by CY4PR11MB1671.namprd11.prod.outlook.com (2603:10b6:910:9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Mon, 30 Mar
 2020 17:52:24 +0000
Received: from CY4PR11MB1719.namprd11.prod.outlook.com
 ([fe80::e43e:7b93:3758:44ad]) by CY4PR11MB1719.namprd11.prod.outlook.com
 ([fe80::e43e:7b93:3758:44ad%11]) with mapi id 15.20.2856.019; Mon, 30 Mar
 2020 17:52:24 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        "Moore, Robert" <robert.moore@intel.com>
CC:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next] ACPICA: Make acpi_protocol_lengths static
Thread-Topic: [PATCH -next] ACPICA: Make acpi_protocol_lengths static
Thread-Index: AQHWBLOwN44FvSmcW0SOH+jvjCG2sqhduQiAgAOyyQA=
Date:   Mon, 30 Mar 2020 17:52:23 +0000
Message-ID: <CY4PR11MB171942777865293C74EF1D9AF0CB0@CY4PR11MB1719.namprd11.prod.outlook.com>
References: <20200328034706.17840-1-yuehaibing@huawei.com>
 <CAJZ5v0ikZoo5bgrfUsGic7FTCZQu7m_EYLDH1LMcMGNwNjtvqw@mail.gmail.com>
In-Reply-To: <CAJZ5v0ikZoo5bgrfUsGic7FTCZQu7m_EYLDH1LMcMGNwNjtvqw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=erik.kaneda@intel.com; 
x-originating-ip: [192.55.52.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ee16c87-a56f-45ca-5326-08d7d4d31a6c
x-ms-traffictypediagnostic: CY4PR11MB1671:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB167151B2DA0429D37EC0606CF0CB0@CY4PR11MB1671.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:85;
x-forefront-prvs: 0358535363
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1719.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(346002)(39860400002)(136003)(396003)(366004)(376002)(7696005)(478600001)(8936002)(4326008)(110136005)(55016002)(316002)(9686003)(2906002)(54906003)(71200400001)(86362001)(66556008)(33656002)(6636002)(52536014)(53546011)(66446008)(186003)(81166006)(81156014)(66946007)(6506007)(5660300002)(66476007)(64756008)(26005)(8676002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X+aAQy+EoRqHuBfEvBYccWFOG+3AcQRU5H3/OF3CL6iizp9uU8hQ07Li6PNnDi1E+DVFNs4dzxNXX5/yPnFsxEU3/SM78yloUXnZhIrUOHDPoOC2rhSmlmtShuX4NRoNslj0+KHIgR9kO6FtxRLM97chlRdgl/UA8v5xbYqpXKDpkWY9B+4lrbCUo/vGqu8x2mgtkoahV7sa+ICnM0PpTvVeJoC0eyCGCo1zHOlGlSR/79QLULZ9Fyg+7eaLsFWHUJO4v4VG2mdi/KHg46doSES7ZYO/1/9rlZ8dLQr4OzUWfubUSjSiJ5qRhhs5GrLLUZ9/+LXY4JOn5Z8bi1Get2yNRWfd0QWIUjs09i4hay4OrUqVbp1XfUE4jC149FWmXj1f0lGI7FiBrzsJOFusVoqGUB4tW5q/XV0o78IGgU5z8DePR9GHBw9jwdLPHM3i
x-ms-exchange-antispam-messagedata: Wl0tn/GJ6hNWKIz0WugTLJqCEGuys+VoFdUmjh3sQdQ+RRHtcKZcB8UkoD23qZvvGyys+6ucwbt6F+WwGlYXJYNpIjI/09C+ikNfmf15Mfto8qu9mTnUjo85W2MhPzMJKF9ed74FngT2M2U/TdycSQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee16c87-a56f-45ca-5326-08d7d4d31a6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2020 17:52:24.0460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hwWmW1onTc3nmun/pcHPjxQ2zm5msJzwRUpKrIhrtfuxYXdoIxwija6QlFHvEMCfIo7/ycKJbJK0JGyPFwbcbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1671
X-OriginatorOrg: intel.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtYWNwaS1vd25l
ckB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWFjcGktDQo+IG93bmVyQHZnZXIua2VybmVsLm9yZz4g
T24gQmVoYWxmIE9mIFJhZmFlbCBKLiBXeXNvY2tpDQo+IFNlbnQ6IFNhdHVyZGF5LCBNYXJjaCAy
OCwgMjAyMCAyOjE0IEFNDQo+IFRvOiBZdWVIYWliaW5nIDx5dWVoYWliaW5nQGh1YXdlaS5jb20+
OyBNb29yZSwgUm9iZXJ0DQo+IDxyb2JlcnQubW9vcmVAaW50ZWwuY29tPjsgS2FuZWRhLCBFcmlr
IDxlcmlrLmthbmVkYUBpbnRlbC5jb20+DQo+IENjOiBXeXNvY2tpLCBSYWZhZWwgSiA8cmFmYWVs
Lmoud3lzb2NraUBpbnRlbC5jb20+OyBMZW4gQnJvd24NCj4gPGxlbmJAa2VybmVsLm9yZz47IEFD
UEkgRGV2ZWwgTWFsaW5nIExpc3QgPGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnPjsNCj4gb3Bl
biBsaXN0OkFDUEkgQ09NUE9ORU5UIEFSQ0hJVEVDVFVSRSAoQUNQSUNBKSA8ZGV2ZWxAYWNwaWNh
Lm9yZz47DQo+IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggLW5leHRdIEFDUElDQTogTWFrZSBhY3Bp
X3Byb3RvY29sX2xlbmd0aHMgc3RhdGljDQo+IA0KPiBPbiBTYXQsIE1hciAyOCwgMjAyMCBhdCA0
OjQ3IEFNIFl1ZUhhaWJpbmcgPHl1ZWhhaWJpbmdAaHVhd2VpLmNvbT4NCj4gd3JvdGU6DQo+ID4N
Cj4gPiBGaXggc3BhcnNlIHdhcm5pbmc6DQo+ID4NCj4gPiBkcml2ZXJzL2FjcGkvYWNwaWNhL2V4
ZmllbGQuYzoyNToxMDogd2FybmluZzoNCj4gPiAgc3ltYm9sICdhY3BpX3Byb3RvY29sX2xlbmd0
aHMnIHdhcyBub3QgZGVjbGFyZWQuIFNob3VsZCBpdCBiZSBzdGF0aWM/DQogDQpJIGRvbuKAmXQg
dW5kZXJzdGFuZCB3aGF0IHNwYXJzZSBpcyB0cnlpbmcgdG8gc2F5IGhlcmUuIFRoaXMgdmFyaWFi
bGUgaXMgZGVjbGFyZWQgaW4gZXhmaWVsZC5jLi4uDQpDb3VsZCB5b3UgcHJvdmlkZSBtb3JlIGRl
dGFpbHMgb24gdGhpcyBzcGFyc2Ugd2FybmluZz8NCg0KRXJpaw0KDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBZdWVIYWliaW5nIDx5dWVoYWliaW5nQGh1YXdlaS5jb20+DQo+IA0KPiBCb2IsIEVy
aWssIEknbSBsZWF2aW5nIHRoaXMgb25lIHRvIHlvdS4NCj4gDQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvYWNwaS9hY3BpY2EvZXhmaWVsZC5jIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2FjcGkvYWNwaWNhL2V4ZmllbGQuYw0KPiA+IGIvZHJpdmVycy9hY3BpL2FjcGljYS9leGZpZWxk
LmMgaW5kZXggZTg1ZWIzMWU1MDc1Li4zMzIzYTJiYTZhMzENCj4gPiAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2FjcGkvYWNwaWNhL2V4ZmllbGQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvYWNwaS9h
Y3BpY2EvZXhmaWVsZC5jDQo+ID4gQEAgLTIyLDcgKzIyLDcgQEAgQUNQSV9NT0RVTEVfTkFNRSgi
ZXhmaWVsZCIpDQo+ID4gICAqLw0KPiA+ICAjZGVmaW5lIEFDUElfSU5WQUxJRF9QUk9UT0NPTF9J
RCAgICAgICAgMHg4MA0KPiA+ICAjZGVmaW5lIEFDUElfTUFYX1BST1RPQ09MX0lEICAgICAgICAg
ICAgMHgwRg0KPiA+IC1jb25zdCB1OCBhY3BpX3Byb3RvY29sX2xlbmd0aHNbXSA9IHsNCj4gPiAr
c3RhdGljIGNvbnN0IHU4IGFjcGlfcHJvdG9jb2xfbGVuZ3Roc1tdID0gew0KPiA+ICAgICAgICAg
QUNQSV9JTlZBTElEX1BST1RPQ09MX0lELCAgICAgICAvKiAwIC0gcmVzZXJ2ZWQgKi8NCj4gPiAg
ICAgICAgIEFDUElfSU5WQUxJRF9QUk9UT0NPTF9JRCwgICAgICAgLyogMSAtIHJlc2VydmVkICov
DQo+ID4gICAgICAgICAweDAwLCAgICAgICAgICAgICAgICAgICAvKiAyIC0gQVRUUklCX1FVSUNL
ICovDQo+ID4gLS0NCj4gPiAyLjE3LjENCj4gPg0KPiA+DQo=
