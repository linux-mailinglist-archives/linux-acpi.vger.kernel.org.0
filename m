Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D87D1199CF6
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Mar 2020 19:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgCaRfO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 31 Mar 2020 13:35:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:41437 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgCaRfO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 31 Mar 2020 13:35:14 -0400
IronPort-SDR: 7B6OmWA6Ja3nudc5XaVCO8fNUtxzOMzzkI4DeAp3D9oyH8+HQIA41IRBnp6pZQHMz2fcca1760
 6QqiwF0jSY1w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 10:35:13 -0700
IronPort-SDR: K4q71e3FiKinwDJY8QXebJq1TnnUumfTQgW0L2COljLSbQO7R22WyjKiFC596MCAY5IfPpYi3W
 gSshmY80UwPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,328,1580803200"; 
   d="scan'208";a="395579130"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga004.jf.intel.com with ESMTP; 31 Mar 2020 10:35:11 -0700
Received: from fmsmsx116.amr.corp.intel.com (10.18.116.20) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Mar 2020 10:34:57 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx116.amr.corp.intel.com (10.18.116.20) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Mar 2020 10:34:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 31 Mar 2020 10:34:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJNaCvOjKJ6Za348t1I78sudH7246s23OZLyi0/6XzvJe8BI/yTnkYbgJQjsPAHY7XUWZlSfPWp3H37iI2U4s4twHka/3+0wCNdCC+Hf6oEsDv67vUIyK+d5Y31UKMyfwbE9SfSOADU66J50abx5UT6ElUk4J8v+yjT21nOBdo/+e4i2wSHGbcYj5F/O8gdp+H2SMG33dYmzQn45fY+O5VlAvE/upLMr9SpYwg7kWxL0uSzGR/6XRBYDcJkgiFl2vwiEYzkroTxtG/UcrGWTUoO2HUjpziHWd2n/cDOBiHIoIQOjXeMI8c7oYCiot0qlm8D/T+TVGv7cyE9NDQdgqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Nvc5EcEMhqVfGj3H+ZWjAzziWW6Jw3heW2VjMOFYJ0=;
 b=fKFMAc2YiXZ6dmg+TZ8UO+/AmvWZXqZD04Mk8fQppB6f5uC3H5evyW4yxc4chYeClMPgj0n/vwbqfPZfSOEdD803PkLCLihlXSdtLfIzhj5qtQO0a0u3Schm9MjRyWMT3Yvs4A3ZkBWOKiKwRhJCl9m684OmEpAG1JOCNGikfyiFUeoJrRqdwPQWn62gYXypViMXoivg17B6GE8MuxJQXnLsr8RIwJjx9YNioGW+hi7v2rRpNVTg5OZbRd9DxObH14/rxyyYTjH09iao3SenYie9yQBZmwb9awOrf81moXh/tuY+V1SwA30f+xi0qobZb/aJXRYnYNlSsmsPOvKCWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Nvc5EcEMhqVfGj3H+ZWjAzziWW6Jw3heW2VjMOFYJ0=;
 b=kLkKVaoJI9z5ZgaJhpTIrZ6cOFQmofPL3t8OoRZlBdJf1bqChKVllv9wuzlZF6GuHWgJ96p2APSTxfWBaJVdYAnGO0YelNzgynmGqwueOBqv0TGUZGD9Z3FOzmw4ZP36PrcDLFnjX1svdrL+rJK9HlWelXTufvnDunIHzHNgliw=
Received: from CY4PR11MB1719.namprd11.prod.outlook.com (2603:10b6:903:2d::23)
 by CY4PR11MB1526.namprd11.prod.outlook.com (2603:10b6:910:7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Tue, 31 Mar
 2020 17:34:54 +0000
Received: from CY4PR11MB1719.namprd11.prod.outlook.com
 ([fe80::e43e:7b93:3758:44ad]) by CY4PR11MB1719.namprd11.prod.outlook.com
 ([fe80::e43e:7b93:3758:44ad%11]) with mapi id 15.20.2856.019; Tue, 31 Mar
 2020 17:34:54 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     Yuehaibing <yuehaibing@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>
CC:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next] ACPICA: Make acpi_protocol_lengths static
Thread-Topic: [PATCH -next] ACPICA: Make acpi_protocol_lengths static
Thread-Index: AQHWBLOwN44FvSmcW0SOH+jvjCG2sqhduQiAgAOyyQCAAKPaAIAA6+GA
Date:   Tue, 31 Mar 2020 17:34:54 +0000
Message-ID: <CY4PR11MB1719137B8415BD947EA62C3BF0C80@CY4PR11MB1719.namprd11.prod.outlook.com>
References: <20200328034706.17840-1-yuehaibing@huawei.com>
 <CAJZ5v0ikZoo5bgrfUsGic7FTCZQu7m_EYLDH1LMcMGNwNjtvqw@mail.gmail.com>
 <CY4PR11MB171942777865293C74EF1D9AF0CB0@CY4PR11MB1719.namprd11.prod.outlook.com>
 <81c23927-e3eb-dd97-6b9d-5e91d19a61b8@huawei.com>
In-Reply-To: <81c23927-e3eb-dd97-6b9d-5e91d19a61b8@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=erik.kaneda@intel.com; 
x-originating-ip: [192.55.52.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f9fcb6f-9ba0-4c30-d00d-08d7d599d341
x-ms-traffictypediagnostic: CY4PR11MB1526:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB1526FB25704DDA8C9D7D0E99F0C80@CY4PR11MB1526.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1719.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(346002)(376002)(366004)(39860400002)(136003)(396003)(33656002)(66446008)(7696005)(316002)(54906003)(6506007)(66556008)(64756008)(478600001)(53546011)(110136005)(71200400001)(966005)(52536014)(5660300002)(26005)(9686003)(76116006)(2906002)(66946007)(8676002)(6636002)(86362001)(66476007)(81156014)(81166006)(4326008)(186003)(8936002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QEAuel/w9UWb96aAXppDf/zMUnnfghoYjDzLSLrjfqIFiq44Jir/2gT+RGrZsxpYcQJct5Objn6rNBeA1/FBWjrJ71Fri8OHCHFJVdExt/gzrLGSLhM6RBSR61kHrv7jU+J951ReZPXtjc3U2NlyZbnL2fyM6KimWySC/WGCYGu2Dp9aDUkyVsabakDy1MWodHqb+3IrdTyi1c1XcpTfMNOLm/UiTeF0omrRU0pwi7eB4XfdVwvA0k4JU38gF5QZZ6/NX3LMToP0o1aw1MWgF71R2Z6kuxDbCaWDwniA5NQ1lntWruMX5QUpMc2DviQxzS8zeCM2xmh5GeUGQgbFB+aS85f3rBM+SNkyk9ijP1wMsxUXd8tjXIm8QCCAWY/HMkrHD9CChgY/GvpFCO/fl2nGR/aKZYUsMqTMXCJlYE7r02FYf/V+xcQ9hTWa6xCKgP1NATRdLZ1V+/RF1AfbSc91wTR8a2q1a54VJ5tOG3oZkp+8Z/AjyrtSnkUuQM22XVLJnaP3ac+NIpS5BrF27w==
x-ms-exchange-antispam-messagedata: RPHveWexp6x2MRAF5afGiHJ7t54L0z1yMgqpZvm8FFp47J7f9KhS4QJFAFjYqhFywTAVdWN5fauNKTN7Y/qVmVyKhYcffyB/Zfi4qoXE5jVWGqTaxifIrQ+CG/iRWyDRIqnk+UkBNM6CmnqiqNXzPg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9fcb6f-9ba0-4c30-d00d-08d7d599d341
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 17:34:54.6193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aPFbHWaIPYTAw+8v+CGbuMBISApjRD3dNlX8s3auc3Z0GtLhh8NfbhMfv0WXyW2NOHGfqDMFVp3x3EVR5Hivbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1526
X-OriginatorOrg: intel.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtYWNwaS1vd25l
ckB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWFjcGktDQo+IG93bmVyQHZnZXIua2VybmVsLm9yZz4g
T24gQmVoYWxmIE9mIFl1ZWhhaWJpbmcNCj4gU2VudDogTW9uZGF5LCBNYXJjaCAzMCwgMjAyMCA4
OjI5IFBNDQo+IFRvOiBLYW5lZGEsIEVyaWsgPGVyaWsua2FuZWRhQGludGVsLmNvbT47IFJhZmFl
bCBKLiBXeXNvY2tpDQo+IDxyYWZhZWxAa2VybmVsLm9yZz47IE1vb3JlLCBSb2JlcnQgPHJvYmVy
dC5tb29yZUBpbnRlbC5jb20+DQo+IENjOiBXeXNvY2tpLCBSYWZhZWwgSiA8cmFmYWVsLmoud3lz
b2NraUBpbnRlbC5jb20+OyBMZW4gQnJvd24NCj4gPGxlbmJAa2VybmVsLm9yZz47IEFDUEkgRGV2
ZWwgTWFsaW5nIExpc3QgPGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnPjsNCj4gb3BlbiBsaXN0
OkFDUEkgQ09NUE9ORU5UIEFSQ0hJVEVDVFVSRSAoQUNQSUNBKSA8ZGV2ZWxAYWNwaWNhLm9yZz47
DQo+IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggLW5leHRdIEFDUElDQTogTWFrZSBhY3BpX3Byb3Rv
Y29sX2xlbmd0aHMgc3RhdGljDQo+IA0KPiBPbiAyMDIwLzMvMzEgMTo1MiwgS2FuZWRhLCBFcmlr
IHdyb3RlOg0KPiA+DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4g
RnJvbTogbGludXgtYWNwaS1vd25lckB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWFjcGktDQo+ID4+
IG93bmVyQHZnZXIua2VybmVsLm9yZz4gT24gQmVoYWxmIE9mIFJhZmFlbCBKLiBXeXNvY2tpDQo+
ID4+IFNlbnQ6IFNhdHVyZGF5LCBNYXJjaCAyOCwgMjAyMCAyOjE0IEFNDQo+ID4+IFRvOiBZdWVI
YWliaW5nIDx5dWVoYWliaW5nQGh1YXdlaS5jb20+OyBNb29yZSwgUm9iZXJ0DQo+ID4+IDxyb2Jl
cnQubW9vcmVAaW50ZWwuY29tPjsgS2FuZWRhLCBFcmlrIDxlcmlrLmthbmVkYUBpbnRlbC5jb20+
DQo+ID4+IENjOiBXeXNvY2tpLCBSYWZhZWwgSiA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+
OyBMZW4gQnJvd24NCj4gPj4gPGxlbmJAa2VybmVsLm9yZz47IEFDUEkgRGV2ZWwgTWFsaW5nIExp
c3QNCj4gPj4gPGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnPjsgb3BlbiBsaXN0OkFDUEkgQ09N
UE9ORU5UDQo+IEFSQ0hJVEVDVFVSRQ0KPiA+PiAoQUNQSUNBKSA8ZGV2ZWxAYWNwaWNhLm9yZz47
IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QNCj4gPj4gPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggLW5leHRdIEFDUElDQTogTWFrZSBhY3Bp
X3Byb3RvY29sX2xlbmd0aHMgc3RhdGljDQo+ID4+DQo+ID4+IE9uIFNhdCwgTWFyIDI4LCAyMDIw
IGF0IDQ6NDcgQU0gWXVlSGFpYmluZyA8eXVlaGFpYmluZ0BodWF3ZWkuY29tPg0KPiA+PiB3cm90
ZToNCj4gPj4+DQo+ID4+PiBGaXggc3BhcnNlIHdhcm5pbmc6DQo+ID4+Pg0KPiA+Pj4gZHJpdmVy
cy9hY3BpL2FjcGljYS9leGZpZWxkLmM6MjU6MTA6IHdhcm5pbmc6DQo+ID4+PiAgc3ltYm9sICdh
Y3BpX3Byb3RvY29sX2xlbmd0aHMnIHdhcyBub3QgZGVjbGFyZWQuIFNob3VsZCBpdCBiZSBzdGF0
aWM/DQo+ID4NCj4gPiBJIGRvbuKAmXQgdW5kZXJzdGFuZCB3aGF0IHNwYXJzZSBpcyB0cnlpbmcg
dG8gc2F5IGhlcmUuIFRoaXMgdmFyaWFibGUgaXMNCj4gZGVjbGFyZWQgaW4gZXhmaWVsZC5jLi4u
DQo+ID4gQ291bGQgeW91IHByb3ZpZGUgbW9yZSBkZXRhaWxzIG9uIHRoaXMgc3BhcnNlIHdhcm5p
bmc/DQo+IA0KPiBUaGlzIGlzIHNwYXJzZSAtV2RlbCBvcHRpb24ncyBqb2IsIHNlZSBtYW4gbWFu
dWFsOg0KPiANCj4gICAgICAgIC1XZGVjbCBXYXJuIGFib3V0IGFueSBub24tc3RhdGljIHZhcmlh
YmxlIG9yIGZ1bmN0aW9uIGRlZmluaXRpb24gdGhhdA0KPiAgICAgICAgICAgICAgIGhhcyBubyBw
cmV2aW91cyBkZWNsYXJhdGlvbi4NCj4gDQo+ICAgICAgICAgICAgICAgUHJpdmF0ZSBzeW1ib2xz
IChmdW5jdGlvbnMgYW5kIHZhcmlhYmxlcykgaW50ZXJuYWwgdG8gYSBnaXZlbg0KPiAgICAgICAg
ICAgICAgIHNvdXJjZSBmaWxlIHNob3VsZCB1c2Ugc3RhdGljLCB0byBhbGxvdyBhZGRpdGlvbmFs
IGNvbXBpbGVyDQo+ICAgICAgICAgICAgICAgb3B0aW1pemF0aW9ucywgYWxsb3cgZGV0ZWN0aW9u
IG9mIHVudXNlZCBzeW1ib2xzLCBhbmQgcHJldmVudA0KPiAgICAgICAgICAgICAgIG90aGVyIGNv
ZGUgZnJvbSByZWx5aW5nIG9uIHRoZXNlIGludGVybmFsIHN5bWJvbHMuICBQdWJsaWMNCj4gICAg
ICAgICAgICAgICBzeW1ib2xzIHVzZWQgYnkgb3RoZXIgc291cmNlIGZpbGVzIHdpbGwgbmVlZCBk
ZWNsYXJhdGlvbnMNCj4gICAgICAgICAgICAgICB2aXNpYmxlIHRvIHRob3NlIG90aGVyIHNvdXJj
ZSBmaWxlcywgc3VjaCBhcyBpbiBhIGhlYWRlciBmaWxlLg0KPiAgICAgICAgICAgICAgIEFsbCBk
ZWNsYXJhdGlvbnMgc2hvdWxkIGZhbGwgaW50byBvbmUgb2YgdGhlc2UgdHdvIGNhdGVnb3JpZXMu
DQo+ICAgICAgICAgICAgICAgVGh1cywgd2l0aCAtV2RlY2wsIFNwYXJzZSB3YXJucyBhYm91dCBh
bnkgc3ltYm9sIGRlZmluaXRpb24NCj4gICAgICAgICAgICAgICB3aXRoIG5laXRoZXIgc3RhdGlj
IG5vciBhIGRlY2xhcmF0aW9uLiAgVG8gZml4IHRoaXMgd2FybmluZywNCj4gICAgICAgICAgICAg
ICBkZWNsYXJlIHByaXZhdGUgc3ltYm9scyBzdGF0aWMsIGFuZCBlbnN1cmUgdGhhdCB0aGUgZmls
ZXMNCj4gICAgICAgICAgICAgICBkZWZpbmluZyBwdWJsaWMgc3ltYm9scyBoYXZlIHRoZSBzeW1i
b2wgZGVjbGFyYXRpb25zIGF2YWlsYWJsZQ0KPiAgICAgICAgICAgICAgIGZpcnN0IChzdWNoIGFz
IGJ5IGluY2x1ZGluZyB0aGUgYXBwcm9wcmlhdGUgaGVhZGVyIGZpbGUpLg0KDQpUaGFua3MgZm9y
IHRoZSBpbmZvLiBJIG1hZGUgYSBwdWxsIHJlcXVlc3QgdG8gQUNQSUNBIGNvZGViYXNlIGhlcmU6
IGh0dHBzOi8vZ2l0aHViLmNvbS9hY3BpY2EvYWNwaWNhL3B1bGwvNTgxDQpJIHdpbGwgc2VuZCB0
aGlzIHRvIExpbnV4IHVwc3RyZWFtIGFmdGVyIHRoZSBuZXh0IEFDUElDQSByZWxlYXNlICh0b3dh
cmQgdGhlIGVuZCBvZiB0aGlzIG1vbnRoKQ0KDQpUaGFua3MsDQpFcmlrDQo+IA0KPiA+DQo+ID4g
RXJpaw0KPiA+DQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogWXVlSGFpYmluZyA8eXVlaGFp
YmluZ0BodWF3ZWkuY29tPg0KPiA+Pg0KPiA+PiBCb2IsIEVyaWssIEknbSBsZWF2aW5nIHRoaXMg
b25lIHRvIHlvdS4NCj4gPj4NCj4gPj4+IC0tLQ0KPiA+Pj4gIGRyaXZlcnMvYWNwaS9hY3BpY2Ev
ZXhmaWVsZC5jIHwgMiArLQ0KPiA+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvYWNw
aWNhL2V4ZmllbGQuYw0KPiA+Pj4gYi9kcml2ZXJzL2FjcGkvYWNwaWNhL2V4ZmllbGQuYyBpbmRl
eCBlODVlYjMxZTUwNzUuLjMzMjNhMmJhNmEzMQ0KPiA+Pj4gMTAwNjQ0DQo+ID4+PiAtLS0gYS9k
cml2ZXJzL2FjcGkvYWNwaWNhL2V4ZmllbGQuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9hY3BpL2Fj
cGljYS9leGZpZWxkLmMNCj4gPj4+IEBAIC0yMiw3ICsyMiw3IEBAIEFDUElfTU9EVUxFX05BTUUo
ImV4ZmllbGQiKQ0KPiA+Pj4gICAqLw0KPiA+Pj4gICNkZWZpbmUgQUNQSV9JTlZBTElEX1BST1RP
Q09MX0lEICAgICAgICAweDgwDQo+ID4+PiAgI2RlZmluZSBBQ1BJX01BWF9QUk9UT0NPTF9JRCAg
ICAgICAgICAgIDB4MEYNCj4gPj4+IC1jb25zdCB1OCBhY3BpX3Byb3RvY29sX2xlbmd0aHNbXSA9
IHsNCj4gPj4+ICtzdGF0aWMgY29uc3QgdTggYWNwaV9wcm90b2NvbF9sZW5ndGhzW10gPSB7DQo+
ID4+PiAgICAgICAgIEFDUElfSU5WQUxJRF9QUk9UT0NPTF9JRCwgICAgICAgLyogMCAtIHJlc2Vy
dmVkICovDQo+ID4+PiAgICAgICAgIEFDUElfSU5WQUxJRF9QUk9UT0NPTF9JRCwgICAgICAgLyog
MSAtIHJlc2VydmVkICovDQo+ID4+PiAgICAgICAgIDB4MDAsICAgICAgICAgICAgICAgICAgIC8q
IDIgLSBBVFRSSUJfUVVJQ0sgKi8NCj4gPj4+IC0tDQo+ID4+PiAyLjE3LjENCj4gPj4+DQo+ID4+
Pg0KDQo=
