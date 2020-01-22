Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD32145C4D
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Jan 2020 20:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgAVTMq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 Jan 2020 14:12:46 -0500
Received: from mga12.intel.com ([192.55.52.136]:55654 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbgAVTMq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 22 Jan 2020 14:12:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 11:12:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,350,1574150400"; 
   d="scan'208";a="259574457"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga002.fm.intel.com with ESMTP; 22 Jan 2020 11:12:45 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 22 Jan 2020 11:12:45 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 22 Jan 2020 11:12:45 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 22 Jan 2020 11:12:45 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.56) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 22 Jan 2020 11:12:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0EluqU/vzrnTdPMb1CpXBASYeLd98q3QA63KmdmpdShE+NZuwRdS4tZ1/ZZLscKHxh/fj7599W1FzJRmNP95OTuw4pEIwYI7Y6mqcflxvPnpyL/Gw+iCkAwyJ9tX1nzhDWJmXD5jcbczsLISm6zpa6/OPVybXcPsm8HHaQ1lCUz6xQkUaLPPx/2oup/Xeb3N8HTfsthihoWIsT0ZM5NyRSGKSsSh64doxjmCkFibWMCUklisg3VPFwYQ8TpU9rS4Y4dTklYTfquFjhxmMriVgo6OvyQSZuZ0yGeKsGe8jVckTpl4BydBtFfPZyoZHRRHfHbysSdEYckyUYsgAPPzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoR9IU1JUgqc7HwuvKTEAxyN+pShqBgsdJXOPl2W2xY=;
 b=FUU6xQqdKoMznOihRWh72ulEYWuERqO2nMeoSzgSpfsCu8Kv5KLaFNRWix64CKGijXnM9/NpfZJQIjrevK6vevPHlNHxXElKl5HAwLsnj/YQfAqrX5PlzAUnLDzTPIKO6k0S0Hzfs2EZCqtyemzhOawyoXw4UW2HYDAaGNDXXTPf/nB/CHHgJydSpomoKCGgtJOBZj9Z3ZeHU8FnUAfj0CyoW+WiWugShmFYAhZCMaUTlOoZsBj+fN7y2ehvy5dIOVn63pKW7CYLcPjtYixEU795zbY2fA/p6QDiUcoYnsjwU7+I7irpo/gh7eZwSRJPPvrzWWBIQQsHzAmalSTJGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoR9IU1JUgqc7HwuvKTEAxyN+pShqBgsdJXOPl2W2xY=;
 b=bAWMjXrP13VJf36Gc+4PvLMxNSa6NI7S+0KhQRWa0gACz7pn1jLgHHjH1fsSsLpu4GqI6kqP8HAwS7jChqUdai0yP1ZMiK9FvwFrdghkd4ufFAOeeO5IDvwQTHH9/jBYgmqf21ig93Vcz6C/QE77UOrRh95c9mlhAFR2m+66rVw=
Received: from MWHPR11MB1984.namprd11.prod.outlook.com (10.175.54.11) by
 MWHPR11MB1886.namprd11.prod.outlook.com (10.175.54.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Wed, 22 Jan 2020 19:12:37 +0000
Received: from MWHPR11MB1984.namprd11.prod.outlook.com
 ([fe80::f4b7:21f6:b050:5f33]) by MWHPR11MB1984.namprd11.prod.outlook.com
 ([fe80::f4b7:21f6:b050:5f33%8]) with mapi id 15.20.2644.028; Wed, 22 Jan 2020
 19:12:37 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Anchal Agarwal <anchalag@amazon.com>,
        "Moore, Robert" <robert.moore@intel.com>
CC:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "Singh, Balbir" <sblbir@amazon.com>,
        "fllinden@amazon.com" <fllinden@amazon.com>
Subject: RE: [RESEND PATCH] ACPICA: Enable sleep button on ACPI legacy wake
Thread-Topic: [RESEND PATCH] ACPICA: Enable sleep button on ACPI legacy wake
Thread-Index: AQHVy/txCopz8tiPmEersnUayPWmy6ftCekAgAoLASA=
Date:   Wed, 22 Jan 2020 19:12:37 +0000
Message-ID: <MWHPR11MB1984C969C026BC579F773F08F00C0@MWHPR11MB1984.namprd11.prod.outlook.com>
References: <20200115232629.GA9231@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
 <CAJZ5v0iHVzDzS5zZSTWOdy2CCSkyW74+p2-Et0+EcysOvL2CDg@mail.gmail.com>
In-Reply-To: <CAJZ5v0iHVzDzS5zZSTWOdy2CCSkyW74+p2-Et0+EcysOvL2CDg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjc4YTA0OTMtYWU5MC00ZjU4LTk5ZjItYjk4MGI2ZTI4ZjkwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiR29xQmxJbmNaWHpOc3JrcnpKOG5yQVNoVmhOOUpDVmJ2N21lK2dxMUFySEVmdXNZek0rTE1Jb0JHSklCN1pyKyJ9
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
dlp-reaction: no-action
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=erik.kaneda@intel.com; 
x-originating-ip: [134.134.136.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bbb5f53-e0fe-45d7-7a14-08d79f6f0b34
x-ms-traffictypediagnostic: MWHPR11MB1886:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1886F3F483A5C86B81EF5C39F00C0@MWHPR11MB1886.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(366004)(136003)(396003)(199004)(189003)(6506007)(186003)(316002)(53546011)(54906003)(110136005)(76116006)(71200400001)(66476007)(2906002)(64756008)(66556008)(66446008)(478600001)(66946007)(33656002)(6636002)(5660300002)(8936002)(8676002)(52536014)(86362001)(81166006)(4326008)(81156014)(966005)(7696005)(9686003)(26005)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR11MB1886;H:MWHPR11MB1984.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N+feD8AXtv7rhMFhzTdAcie+oWvK10SD5sVnPjoBah9D233fPZOWiwvwRHkXcDzRAN1Nx8+l/WwKxv0xXfQN64nCAZnq3GQAg1yJj+YBFZkBcpjhupy/rEcxSGzMgGRhkPIDEWGLSwq1VwkoXkwz3WgLSj69FSp7x3/TQk30pdXhmAQcLmJIoTxuP83irNUQftQe6D77oXHsuc0Ol3awP1gG1g9Nb1XT8RSZwyJiDVZfMRBwWig1ZXwU4gVEmdRCraqb3LohQqZcCxXyeczTVvSAyQyZsrfdOWiFs8dT6oYzm3xHDzkGrRAWRNsryV+0F54G2BcdxK7PLS4XoJ1D621f6zy5cXrs3zaJk1QGa2dRHCzwV292aizWTOaafMpTZMNyu53mvqIxLIX+fWXl7ib3gBbj5oSFoPJYDFwH/Ce5Cdb/6T48mujhPFlhV76JhzJHEJRwjQufnUNic00ipbVZ3H3D52tOuEJ9dkKGi8U=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bbb5f53-e0fe-45d7-7a14-08d79f6f0b34
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 19:12:37.3019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d6j934/22o4VQOhu77kTTrRz3UhPxP+Yx73A5sxJX9O8czRWffjq6T9n3voZ6V3rYcmU5a8nCTVwdVKhIH2DrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1886
X-OriginatorOrg: intel.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFmYWVsIEouIFd5c29j
a2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgSmFudWFyeSAxNiwgMjAy
MCAxOjQwIEFNDQo+IFRvOiBBbmNoYWwgQWdhcndhbCA8YW5jaGFsYWdAYW1hem9uLmNvbT47IEth
bmVkYSwgRXJpaw0KPiA8ZXJpay5rYW5lZGFAaW50ZWwuY29tPjsgTW9vcmUsIFJvYmVydCA8cm9i
ZXJ0Lm1vb3JlQGludGVsLmNvbT4NCj4gQ2M6IFd5c29ja2ksIFJhZmFlbCBKIDxyYWZhZWwuai53
eXNvY2tpQGludGVsLmNvbT47IEFDUEkgRGV2ZWwgTWFsaW5nIExpc3QNCj4gPGxpbnV4LWFjcGlA
dmdlci5rZXJuZWwub3JnPjsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgtDQo+IGtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBMZW4gQnJvd24gPGxlbmJAa2VybmVsLm9yZz47IG9wZW4g
bGlzdDpBQ1BJDQo+IENPTVBPTkVOVCBBUkNISVRFQ1RVUkUgKEFDUElDQSkgPGRldmVsQGFjcGlj
YS5vcmc+OyBTaW5naCwgQmFsYmlyDQo+IDxzYmxiaXJAYW1hem9uLmNvbT47IGZsbGluZGVuQGFt
YXpvbi5jb20NCj4gU3ViamVjdDogUmU6IFtSRVNFTkQgUEFUQ0hdIEFDUElDQTogRW5hYmxlIHNs
ZWVwIGJ1dHRvbiBvbiBBQ1BJIGxlZ2FjeQ0KPiB3YWtlDQo+IA0KPiBPbiBUaHUsIEphbiAxNiwg
MjAyMCBhdCAxMjoyNiBBTSBBbmNoYWwgQWdhcndhbCA8YW5jaGFsYWdAYW1hem9uLmNvbT4NCj4g
d3JvdGU6DQo+ID4NCj4gPiBDdXJyZW50bHkgd2UgZG8gbm90IHNlZSBzbGVlcF9lbmFibGUgYml0
IHNldCBhZnRlciBndWVzdCByZXN1bWVzIGZyb20NCj4gPiBoaWJlcm5hdGlvbi4gSGliZXJuYXRp
b24gaXMgdHJpZ2dlcmVkIGluIGd1ZXN0IG9uIHJlY2VpdmluZyBhIHNsZWVwDQo+ID4gdHJpZ2dl
ciBmcm9tIHRoZSBoeXBlcnZpc29yKFM0IHN0YXRlKS4gV2Ugc2VlIHRoYXQgcG93ZXIgYnV0dG9u
IGlzDQo+ID4gZW5hYmxlZCBvbiB3YWtlIHVwIGZyb20gUzQgc3RhdGUgaG93ZXZlciBzbGVlcCBi
dXR0b24gaXNuJ3QuIFRoaXMNCj4gPiBjYXVzZXMgc3Vic2VxdWVudCBpbnZvY2F0aW9uIG9mIHNs
ZWVwIHN0YXRlIHRvIGZhaWwgaW4gdGhlIGd1ZXN0LiBBbnkNCj4gPiBlbnZpcm9ubWVudCAgZ29p
bmcgdGhyb3VnaCBhY3BpX2h3X2xlZ2FjeV93YWtlKCkgd29uJ3QgaGF2ZSBzbGVlcA0KPiA+IGJ1
dHRvbiBlbmFibGVkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5jaGFsIEFnYXJ3YWwgPGFu
Y2hhbGFnQGFtYXpvbi5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEJhbGJpciBTaW5naCA8c2JsYmly
QGFtYXpvbi5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEZyYW5rIHZhbiBkZXIgTGluZGVuIDxmbGxp
bmRlbkBhbWF6b24uY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2FjcGkvYWNwaWNhL2h3c2xl
ZXAuYyB8IDExICsrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25z
KCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2FjcGljYS9od3NsZWVwLmMN
Cj4gPiBiL2RyaXZlcnMvYWNwaS9hY3BpY2EvaHdzbGVlcC5jIGluZGV4IGI2MmRiOGVjNDQ2Zi4u
YTE3NmM3ODAyNzYwDQo+ID4gMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9hY3BpL2FjcGljYS9o
d3NsZWVwLmMNCj4gPiArKysgYi9kcml2ZXJzL2FjcGkvYWNwaWNhL2h3c2xlZXAuYw0KPiA+IEBA
IC0zMDAsNiArMzAwLDE3IEBAIGFjcGlfc3RhdHVzIGFjcGlfaHdfbGVnYWN5X3dha2UodTggc2xl
ZXBfc3RhdGUpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW0FDUElf
RVZFTlRfUE9XRVJfQlVUVE9OXS4NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBzdGF0dXNfcmVnaXN0ZXJfaWQsDQo+ID4gQUNQSV9DTEVBUl9TVEFUVVMpOw0KPiA+DQo+
ID4gKyAgICAgICAvKiBFbmFibGUgc2xlZXAgYnV0dG9uICovDQo+ID4gKyAgICAgICAodm9pZCkN
Cj4gPiArICAgICAgICAgICAgIGFjcGlfd3JpdGVfYml0X3JlZ2lzdGVyKGFjcGlfZ2JsX2ZpeGVk
X2V2ZW50X2luZm8NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtB
Q1BJX0VWRU5UX1NMRUVQX0JVVFRPTl0uDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBlbmFibGVfcmVnaXN0ZXJfaWQsDQo+ID4gKyBBQ1BJX0VOQUJMRV9FVkVOVCk7
DQo+ID4gKw0KPiA+ICsgICAgICAgKHZvaWQpDQo+ID4gKyAgICAgICAgICAgICBhY3BpX3dyaXRl
X2JpdF9yZWdpc3RlcihhY3BpX2dibF9maXhlZF9ldmVudF9pbmZvDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBbQUNQSV9FVkVOVF9TTEVFUF9CVVRUT05dLg0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RhdHVzX3JlZ2lzdGVyX2lk
LA0KPiA+ICsgQUNQSV9DTEVBUl9TVEFUVVMpOw0KPiA+ICsNCj4gPiAgICAgICAgIGFjcGlfaHdf
ZXhlY3V0ZV9zbGVlcF9tZXRob2QoTUVUSE9EX1BBVEhOQU1FX19TU1QsDQo+IEFDUElfU1NUX1dP
UktJTkcpOw0KPiA+ICAgICAgICAgcmV0dXJuX0FDUElfU1RBVFVTKHN0YXR1cyk7DQo+ID4gIH0N
Cj4gDQo+IEVyaWssIEJvYiwgcGxlYXNlIHBpY2sgdGhpcyB1cCBpZiB5b3UgZG9uJ3QgaGF2ZSBz
cGVjaWZpYyBvYmplY3Rpb25zIGFnYWluc3QgaXQuDQo+IA0KPiBJJ2xsIHdhaXQgZm9yIGl0IHRv
IHNob3cgdXAgaW4gYW4gdXBzdHJlYW0gcmVsZWFzZS4NCg0KSSd2ZSBzdWJtaXR0ZWQgYSBwdWxs
IHJlcXVlc3QgdG8gQUNQSUNBIHVwc3RyZWFtIHdpdGggY2hhbmdlcyB0byB0aGUgY29tbWl0IG1l
c3NhZ2UgaGVyZToNCmh0dHBzOi8vZ2l0aHViLmNvbS9hY3BpY2EvYWNwaWNhL3B1bGwvNTQ5DQoN
CkknbGwgc2VuZCBhIExpbnV4LWl6ZWQgdmVyc2lvbiBvZiB0aGlzIHBhdGNoIGFmdGVyIG91ciBu
ZXh0IEFDUElDQSByZWxlYXNlLg0KDQpUaGFua3MsDQpFcmlrDQo=
