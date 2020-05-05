Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2990B1C63B2
	for <lists+linux-acpi@lfdr.de>; Wed,  6 May 2020 00:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgEEWLX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 May 2020 18:11:23 -0400
Received: from mga12.intel.com ([192.55.52.136]:64838 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbgEEWLX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 5 May 2020 18:11:23 -0400
IronPort-SDR: l+Ot75inr/OuaFzvsVGXLJEs5kh6rnXRBH9zHI8Ik3xXzhwmEm5CPgZasblhc+8Z7KLPNMmNA1
 BUS6zAMP0f5w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 15:11:21 -0700
IronPort-SDR: KI0zdDXVCA/4vZGVX3hD9wp4EJ57uOOUiEDvthK42BqcNpCSynkAa4cF5EJouYA1fyvfOwt5KL
 tk6/tCq46j+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,356,1583222400"; 
   d="scan'208";a="304619362"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by FMSMGA003.fm.intel.com with ESMTP; 05 May 2020 15:11:21 -0700
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 5 May 2020 15:11:21 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX112.amr.corp.intel.com (10.22.240.13) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 5 May 2020 15:11:20 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 5 May 2020 15:11:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6ChUxsbBoIILI2tVeGUSxObEf690NDBKznK1FNvTAOb4f5Vs0V27GeQdqyhsuAYJKCIE7l3C+XT/JPW0ZpE909jYIjmmGMo/8mJQBroqqJ9Us4sOtSxjeukFxcqzL5i2anKQyfugSLkPYW/pGvMmFzj200vs99iOmQIOfdE1jq87RxxADyKvwwMeJuWtzMhB5rjtKTk1gTTFbbVCYPtvlUThhvWuJF4Q15sK9TjzCCpffs5S09MCa1X0OS38KkmXnz5icNowKtMw3TYkKjwCWUHT3+kI70VINpdZJRd112TnLS+ORxesl45MRNAlFIOuZs4CiTbAhodTU5vKx7Zcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gdr12+b8DBiKTVYvTla7OwFnhsvs5Yv3FJ7wYJUk0qA=;
 b=NTROHYskUKQt4gOFDVSyFOgSpRI0qTBY/Uq073vqgJ7ex6NVBXGCGNH2dZWkaVnpbYduicQc3NSTkC5e5oawR+mh5B219dWvR+gAItMZ8vkKruPfJMeuN/UhGsAXlhUPJlFUnZpfk5nQy7eqoDmaya3iSYqTXG+3xFprvwxZS86py5JvnbDjISbhgenOpsv8HNpCwDhkRUxXnyCN6rUFtwupdDM4gQPkiLQlhHDyEKoYoZ5Vt2B95QOSAB6ztVr6OSZBySVmSp9Ay7j+DYTNxMjWRQ0gfckORvvplSg7fh2P2y1yKAhK0A4nmbiQsYuURZv0oTj7CIEcufi2NvCwnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gdr12+b8DBiKTVYvTla7OwFnhsvs5Yv3FJ7wYJUk0qA=;
 b=F94TFo/8K3RhE/C8s0wcWDzQldHFHRqAQ3e4glL1Eo5QPLcjclyfN/XXszyN1RuBClFS+Fxw6jtNUcbO8+6o/x+ZXVWsmHn9StDubGTI6bPJnizrLQKX+7txw4VtZi/xFfUwmSeRchXXjUowUN10DzCuKap6FsElnZXKcVKLAus=
Received: from BYAPR11MB3096.namprd11.prod.outlook.com (2603:10b6:a03:8f::14)
 by BYAPR11MB3189.namprd11.prod.outlook.com (2603:10b6:a03:7c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Tue, 5 May
 2020 22:11:19 +0000
Received: from BYAPR11MB3096.namprd11.prod.outlook.com
 ([fe80::94e7:471d:f545:3c3e]) by BYAPR11MB3096.namprd11.prod.outlook.com
 ([fe80::94e7:471d:f545:3c3e%5]) with mapi id 15.20.2958.030; Tue, 5 May 2020
 22:11:19 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        Mattia Dongili <malattia@linux.it>,
        William Bader <williambader@hotmail.com>,
        Dominik Mierzejewski <dominik@greysector.net>
CC:     linux-acpi <linux-acpi@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: RE: 5.6 regression caused by "ACPICA: Dispatcher: always generate
 buffer objects for ASL create_field() operator"
Thread-Topic: 5.6 regression caused by "ACPICA: Dispatcher: always generate
 buffer objects for ASL create_field() operator"
Thread-Index: AQHWItydHp8QZpO9T0eN3xY5/bYUbaiZgnyAgAB6zRA=
Date:   Tue, 5 May 2020 22:11:19 +0000
Message-ID: <BYAPR11MB3096868FE8523B2F94A50F9DF0A70@BYAPR11MB3096.namprd11.prod.outlook.com>
References: <49f20a91-9362-6249-d413-1461258d56a9@redhat.com>
 <11795a75-70de-5fcc-878f-14a0381947ea@gmail.com>
In-Reply-To: <11795a75-70de-5fcc-878f-14a0381947ea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [50.39.96.101]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49144d63-529e-4ad0-37cf-08d7f1413d03
x-ms-traffictypediagnostic: BYAPR11MB3189:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3189945661B14B2B093BBA07F0A70@BYAPR11MB3189.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0394259C80
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mLuQSQJokkhpYn6SwDlOr0ZV3x/MNJc/nnYSSgENgr1iVZUUHJ+kWS9RXXAWe0otTl0kxWj3CbKD+r4F7aIFQT+HZNPNGNpB9iD/Mv5rAbXonOaWYCz9mCEMJQ4oCpup39XEKr6LmAGWnQN+81a9tEgyyG4vbmI0OkGYcCyenjqSvOPRIBwRcTKwenkFUA0K2Je7ZI6OYjw7RxxWGiDqwW1YyXFLWgVR5trBZUzeEsE9o6U6UmjyzxVN+sp8XureDK4fOWCA7ATVXfjJBvsso476iGrfxzFjMyE0zz4qMnVt5lYw7s651+yOkBqNodT0dVjGfOSvpAz4Uii8jpXDdX0O0WB6Gw1ScAYY8yRijEyqjLu/HGJEMRbeJAXCsAOyb7pvVcmQQIf5TfQJL3StkHgYEpwujLaNE4XOGpBq1UJ7QNJYbm4HXSF8DdKhCnINCVeJXbPnZnZRK5YGNSQN7Hwpd4rrVqz9GgDaaKzVaRNQD3URf8FJiR+bDMLQdaFDJ240Qqcz31I9LkDtmJ6L9JggJN9fhTYn/G4ci52fibVmyTT6o9Z8rF4dR0tEh1J1A7LWS8strdl3qTOSiXBhdB/mnamLuwJYD35YLdvP84A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3096.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(366004)(136003)(346002)(376002)(33430700001)(66556008)(76116006)(45080400002)(66946007)(186003)(66476007)(5660300002)(66446008)(64756008)(478600001)(52536014)(8936002)(9686003)(55016002)(53546011)(86362001)(7696005)(6506007)(26005)(966005)(316002)(54906003)(8676002)(4326008)(33656002)(2906002)(71200400001)(33440700001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Mhyl4n3PPPe4v04gyKS6a+7tirsh96hHIUPkc9JAwOW0q6pjGpLA+UXoHiNhPKuNMl7FvuLh5jJ4guuFOnmR3psPweuFfqxs2QcNcRIEDPYJug6F9RUOMK9WBwiiofXWWGGgQssnZ6WZt00BsBiWHItikvcoiehcLd5ZTt/oyweSWqOwmufjDK9YFAuatHSzFOBfvVm3npSoyj8X2UY/5gie7XoZz+CbRgBbkPijmdWCTINAJD8yqZb9Z3sWfFD5kFWny6pI8YY9dWn3idy3jqVNVMLZr7nt1iDsh9tdI+0nS8mRv66eRPgNa04+YYm99Jn2W7hTU4d79JprJ1vGS1QTJtoP8eABqsru6b0Iua5dbrYS9IDclpmZZs5+WWvoc62/tGURDgDQ7meTNzqUBBE/NjTnfGVL8RgG+huycK434DOcA1uASs2RKRF3sza6BsHfKb7W/w/fNffj1X26E41S4icnJKrYN+mr7J/LmK2zGgGrTwFY3M5pVulgxcOp+kbyFOmb/xqS2trCeCaSHfMppcmmt+oCUIdmUOaAdLIsv5I2WZHlFIjjyxWsuttd96iESLlOWdWLyJF2lIV5QJzhdFhylPOgNxWnbwRSNRCbfApR0yiI+oPtYs+aPOCJ0ec2FyvBiTGOxrTQKrRVsg2vytYlBHWR4UOLg7yEVDthsXIsRbgEF8NSo4rV0viRWycgy9UsqACBx3oEZVU4MiGmfmDosGeASr1Ncfl8CRbjDzYP6fTp+s13whMOtSBvHcgwRRovnwi1qZGdl3BDqySWkPMFz4OaVGSvyg3Hc9g=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 49144d63-529e-4ad0-37cf-08d7f1413d03
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2020 22:11:19.3044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 42qMFBQSl6hdkqlaY3za4jig3Xiri0k5hX31fhdLFVXhA8DJLmdc9XyQixHaSdPX5kRU1xX2OPDPdtWdlnLm3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3189
X-OriginatorOrg: intel.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtYWNwaS1vd25l
ckB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWFjcGktDQo+IG93bmVyQHZnZXIua2VybmVsLm9yZz4g
T24gQmVoYWxmIE9mIE1heGltaWxpYW4gTHV6DQo+IFNlbnQ6IFR1ZXNkYXksIE1heSA1LCAyMDIw
IDY6NTAgQU0NCj4gVG86IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+OyBXeXNv
Y2tpLCBSYWZhZWwgSg0KPiA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+OyBNb29yZSwgUm9i
ZXJ0IDxyb2JlcnQubW9vcmVAaW50ZWwuY29tPjsNCj4gS2FuZWRhLCBFcmlrIDxlcmlrLmthbmVk
YUBpbnRlbC5jb20+OyBNYXR0aWEgRG9uZ2lsaSA8bWFsYXR0aWFAbGludXguaXQ+Ow0KPiBXaWxs
aWFtIEJhZGVyIDx3aWxsaWFtYmFkZXJAaG90bWFpbC5jb20+OyBEb21pbmlrIE1pZXJ6ZWpld3Nr
aQ0KPiA8ZG9taW5pa0BncmV5c2VjdG9yLm5ldD4NCj4gQ2M6IGxpbnV4LWFjcGkgPGxpbnV4LWFj
cGlAdmdlci5rZXJuZWwub3JnPjsgRGFycmVuIEhhcnQNCj4gPGR2aGFydEBpbmZyYWRlYWQub3Jn
PjsgQW5keSBTaGV2Y2hlbmtvIDxhbmR5QGluZnJhZGVhZC5vcmc+Ow0KPiBwbGF0Zm9ybS1kcml2
ZXIteDg2QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogNS42IHJlZ3Jlc3Npb24gY2F1
c2VkIGJ5ICJBQ1BJQ0E6IERpc3BhdGNoZXI6IGFsd2F5cyBnZW5lcmF0ZQ0KPiBidWZmZXIgb2Jq
ZWN0cyBmb3IgQVNMIGNyZWF0ZV9maWVsZCgpIG9wZXJhdG9yIg0KPiANCj4gT24gNS81LzIwIDI6
NTUgUE0sIEhhbnMgZGUgR29lZGUgd3JvdGU6DQo+ID4gSGkgQWxsLA0KPiA+DQo+ID4gQ29tbWl0
IDZkMjMyYjI5Y2ZjZSAoIkFDUElDQTogRGlzcGF0Y2hlcjogYWx3YXlzIGdlbmVyYXRlIGJ1ZmZl
cg0KPiA+IG9iamVjdHMgZm9yIEFTTCBjcmVhdGVfZmllbGQoKSBvcGVyYXRvciIpIGhhcyBkcm9w
cGVkIHRoZSBhdXRvbWF0aWMNCj4gPiBjb252ZXJzaW9uIG9mIHNtYWxsIGJ1ZmZlcnMgaW50byBp
bnRlZ2Vycy4NCj4gPg0KPiA+IEJ1dCBzb21lIGRyaXZlcnMgcmVsaWVkIG9uIHRoaXMgYXV0b21h
dGljIGNvbnZlcnNpb24sIHRoZXNlIGRyaXZlcnMNCj4gPiBoYXZlIGNoZWNrcyBsaWtlIHRoaXM6
DQo+ID4NCj4gPiAgICAgICAgICBpZiAob2JqZWN0LT50eXBlICE9IEFDUElfVFlQRV9JTlRFR0VS
KSB7DQo+ID4gICAgICAgICAgICAgICAgICBwcl93YXJuKCJJbnZhbGlkIGFjcGlfb2JqZWN0OiBl
eHBlY3RlZCAweCV4IGdvdCAweCV4XG4iLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIEFDUElfVFlQRV9JTlRFR0VSLCBvYmplY3QtPnR5cGUpOw0KPiA+ICAgICAgICAgICAg
ICAgICAga2ZyZWUob2JqZWN0KTsNCj4gPiAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFM
Ow0KPiA+ICAgICAgICAgIH0NCj4gPg0KPiA+IFRoaXMgc3BlY2lmaWMgYml0IGNvbWVzIGZyb20g
dGhlIHNvbnktbGFwdG9wIChwbGF0Zm9ybS94ODYpIGNvZGUsIHRoZQ0KPiA+IEFDUElDQSBjaGFu
Z2UgaGFzIGJyb2tlbiB0aGlzIGNvZGUsIGNhdXNpbmcgc3lzdGVtcyB1c2luZyB0aGlzIGRyaXZl
cg0KPiA+IHRvIGhhbmcgb24gcmVzdW1lIGZyb20gc3VzcGVuZC4NCj4gPg0KPiA+IFdlIGhhdmUg
bXVsdGlwbGUgYnVnLXJlcG9ydHMgb3BlbiBmb3IgdGhpcyBhbHJlYWR5Og0KPiA+DQo+ID4gaHR0
cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMDc0OTENCj4gPiBodHRw
czovL2J1Z3ppbGxhLnJlZGhhdC5jb20vc2hvd19idWcuY2dpP2lkPTE4MjkwOTYNCj4gPiBodHRw
czovL2J1Z3ppbGxhLnJlZGhhdC5jb20vc2hvd19idWcuY2dpP2lkPTE4MzAxNTANCj4gPg0KPiA+
IE1hdHRpYSBEb25naWxpLCB0aGUgc29ueS1sYXB0b3AgZHJpdmVyIGhhcyBhbHJlYWR5IHN1Ym1p
dHRlZCBhIGZpeCBmb3INCj4gPiB0aGlzIHVwc3RyZWFtLCBhZGp1c3RpbmcgdGhlIHNvbnktbGFw
dG9wIGRyaXZlciB0byBkZWFsIHdpdGggdGhlDQo+ID4gcmV0dXJuZWQgb2JqZWN0IHR5cGUgbm93
IGJlaW5nIGEgQlVGRkVSLg0KPiA+DQo+ID4gVGhlIGdvYWwgb2YgdGhpcyBlbWFpbCBpcyB0bzoN
Cj4gPg0KPiA+IDEuIE1ha2UgZXZlcnlvbmUgaW52b2x2ZWQgYXdhcmUgb2YgdGhpcyBicmVha2Fn
ZSBhcyB3ZSBtYXkgc2VlIHNpbWlsYXINCj4gPiBicmVha2FnZSBlbHNld2hlcmUuDQo+ID4NCj4g
PiAyLiBEaXNjdXNzIGlmIHdlIHNob3VsZCBtYXliZSByZXZlcnQgdGhlIEFDUElDQSBjaGFuZ2Uu
DQo+ID4NCj4gPiBJZiB5b3UgYXJlIHJlYWRpbmcgdGhpcyB0aGVuIDEuIGhhcyBiZWVuIGFjY29t
cGxpc2hlZCA6KQ0KPiA+DQo+ID4gV2hpY2ggbGVhdmVzIHVzIHdpdGggMi4gSSdtIHRlbmRpbmcg
dG93YXJkcyBrZWVwaW5nIHRoZSBjaGFuZ2UsIHNpbmNlDQo+ID4gaXQgc2VlbXMgdGhlIHJpZ2h0
IHRoaW5nIHRvIGRvIGFuZCBkZWFsaW5nIHdpdGggdGhlIGZhbGxvdXQuIEJ1dCBzaW5jZQ0KPiA+
IHRoZXJlIGlzIGZhbGxvdXQgd2Ugc2hvdWxkIGFsc28gYXQgbGVhc3QgY29uc2lkZXIgcmV2ZXJ0
aW5nIHRoZSBBQ1BJQ0ENCj4gPiBjaGFuZ2UuDQo+ID4NCj4gPiBTbyBBQ1BJIG1haW50YWluZXJz
IHdoYXQgaXMgeW91IHRha2Ugb24gdGhpcyA/DQoNCldoYXQgYSBtZXNzLiBTZXZlcmFsIHRob3Vn
aHRzLi4uDQoNCkkgdGhpbmsgd2Ugc2hvdWxkIGtlZXAgdGhlIGludGVybmFsIEFNTCBpbnRlcnBy
ZXRlciBiZWhhdmlvciBhcyBpcyBiZWNhdXNlIGl0IHNvbHZlcyBhIHByb2JsZW0uDQoNClRoZSBB
Q1BJIHNwZWMgc2F5cyB0aGF0IGJ1ZmZlcnMgdGhhdCBhcmUgc21hbGwgZW5vdWdoIHRvIGZpdCBp
bnNpZGUgb2YgaW50ZWdlcnMgc2hvdWxkIGJlIHRyZWF0ZWQgYXMNCmludGVnZXJzLiBIb3dldmVy
LCB3ZSBmb3VuZCB0aGF0IHRoaXMgaXMgbm90IHRoZSBjYXNlIGZvciBDcmVhdGVGaWVsZCBvcGVy
YXRvcnMuIFRoZSBpbnRlcm5hbA0KcmVwcmVzZW50YXRpb24gb2YgdGhpcyBuZWVkcyB0byBiZSBh
IGJ1ZmZlciB0byBtYXRjaCBNUyBBTUwgaW50ZXJwcmV0ZXIuDQoNClNOQyBpcyBub3QgYSBwcmUt
ZGVmaW5lZCBtZXRob2Qgc28gd2UgYWN0dWFsbHkgZG9uJ3Qga25vdyB3aGF0IHRoZSByZXR1cm4g
dHlwZSBpcyBzdXBwb3NlZA0KdG8gYmUuIEF0IHNvbWUgcG9pbnQgZHVyaW5nIHRoZSBkZXZlbG9w
bWVudCBvZiB0aGlzIGRyaXZlciwgaXQncyBsaWtlbHkgdGhhdCBzb21lb25lIG1hZGUgYW4gb2Jz
ZXJ2YXRpb24NCmFib3V0IHdoYXQgIlNOQyIgcmV0dXJuZWQgYXQgc29tZSBwb2ludCBpbiB0aW1l
IGFuZCBjb250aW51ZWQgdG8gYXNzdW1lIHRoYXQgaXQgd2lsbCB1c2UgdGhlIHNhbWUNCnR5cGUu
DQoNCkZvciBtZXRob2RzIHRoYXQgYXJlIG5vdCBhIHBhcnQgb2YgdGhlIEFDUEkgc3BlY2lmaWNh
dGlvbiwgYnVmZmVycyBsZXNzIHRoYW4gb3IgZXF1YWwgdG8gOCBieXRlcyBhbmQNCmludGVnZXJz
IGNvdWxkIGJlIHVzZWQgaW50ZXJjaGFuZ2VhYmx5LiBJIGRvbid0IHNlZSBhIHJlYXNvbiB3aHkg
dGhlIGRhdGEgaW5zaWRlIHRoZSBidWZmZXIgc2hvdWxkIGJlDQppbnZhbGlkLg0KDQpFcmlrDQo+
ID4NCj4gPiBSZWdhcmRzLA0KPiA+DQo+ID4gSGFucw0KPiANCj4gSGksDQo+IA0KPiBJJ2QgbGlr
ZSB0byBhZHZpc2UgYWdhaW5zdCByZXZlcnRpbmcgdGhlIGNvbW1pdC4gUXVpdGUgaG9uZXN0bHks
IEkgZG9uJ3QgdGhpbmsNCj4gcmV2ZXJ0aW5nIHRoZSBjb21taXQgaXMgYSBnb29kIGlkZWEuIFRo
aXMgd2lsbCBicmVhayB0aGluZ3MgZm9yIGRldmljZXMgdGhhdA0KPiBhc3N1bWUgTWljcm9zb2Z0
LWxpa2UgQU1MIGludGVycHJldGVyIGJlaGF2aW9yIF9pbnNpZGVfIHRoZSBEU0RULiBTdWNoIGFz
DQo+IHRoZSBNUyBTdXJmYWNlIGRldmljZXMgZm9yIGV4YW1wbGUsIHdoaWNoLCBhcyBzdGF0ZWQg
aW4gdGhlIGNvbW1pdCBtZXNzYWdlLA0KPiBkZXBlbmQgb24gdGhlIHR5cGUgYmVpbmcgQnVmZmVy
IHZpYSBhIGNoZWNrIG9uIE9iamVjdFR5cGUoLi4uKS4gVGhlcmUgaXMgbm8NCj4gZml4IGZvciB0
aG9zZSBkZXZpY2VzIG90aGVyIHRoYW4gYSkgYWNjZXB0aW5nIE1TIGJlaGF2aW9yIGluIEFDUElD
QSwgYikNCj4gaW50cm9kdWNpbmcgYSBxdWlyayBpbiBBQ1BJQ0Egd2hpY2ggc3dpdGNoZXMgYmV0
d2VlbiBiZWhhdmlvcnMgb24gYSBkZXZpY2UNCj4gYmFzaXMsIG9yIGMpIHBhdGNoaW5nIHRoZSBE
U0RUIG9mIHRob3NlIGRldmljZXMgc3BlY2lmaWNhbGx5IGZvciBMaW51eC4NCj4gDQo+IEknZCBh
bHNvIGFyZ3VlIHRoYXQgc2luY2UgdGhpcyBpcyBNUyBiZWhhdmlvciwgdGhpcyBpcyB0aGUgYmVo
YXZpb3IgdGhhdCBhbG1vc3QgYWxsDQo+IGNvbnN1bWVyIGVsZWN0cm9uaWNzIGRldmljZXMgd2l0
aCBBQ1BJIHdpbGwgZXhwZWN0LiBDYXNlIGluIHBvaW50LCB0aGUgRFNEVA0KPiBvZiBvbmUgb2Yg
dGhlIGFmZmVjdGVkIFNvbnkgbGFwdG9wcywgd2hpY2ggY29udGFpbnMgdGhlIGZvbGxvd2luZyBj
b2RlOg0KPiANCj4gICAgICAgICAgQ3JlYXRlRmllbGQgKFNOQkYsIFplcm8sIDB4MjAsIFNOQkQp
DQo+ICAgICAgICAgIENyZWF0ZVdvcmRGaWVsZCAoU05CRiwgMHgwMiwgQ1BXMCkNCj4gICAgICAg
ICAgQ3JlYXRlV29yZEZpZWxkIChTTkJGLCAweDA0LCBDUFcxKQ0KPiAgICAgICAgICBDcmVhdGVX
b3JkRmllbGQgKFNOQkYsIFplcm8sIFJDVzApDQo+ICAgICAgICAgIENyZWF0ZVdvcmRGaWVsZCAo
U05CRiwgMHgwMiwgUkNXMSkNCj4gDQo+IFRoZXkgZXhwbGljaXRseSBjcmVhdGUgYSBCdWZmZXIg
ZmllbGQgb2YgMzIgYml0cyB2aWEgQ3JlYXRlRmllbGQgYW5kIG5vdCBhIDMyIGJpdA0KPiBJbnRl
Z2VyIGZpZWxkIHZpYSBDcmVhdGVEV29yZEZpZWxkLiBJJ2QgYXJndWUgdGhhdCBpZiB0aGV5IHdh
bnRlZCB0aGlzIGZpZWxkIHRvDQo+IGJlIGFuIEludGVnZXIsIENyZWF0ZURXb3JkRmllbGQgd291
bGQgYmUgdGhlIHN0cmFpZ2h0LWZvcndhcmQgYXBwcm9hY2guDQo+IA0KPiBVbmZvcnR1bmF0ZWx5
LCBJIGFsc28gZG9uJ3Qgc2VlIGEgd2F5IHRvIGlkZW50aWZ5IGFsbCBhZmZlY3RlZCBjYWxscyB0
byBBQ1BJDQo+IGZ1bmN0aW9ucyBhdXRvbWF0aWNhbGx5IG9yIGVhc2lseSwgYXMgdGhpcyByZXF1
aXJlcyB0byBsb29rIGF0IHRoZSBEU0RUcyBhbmQgdGhlDQo+IGNvZGUgYmVoaW5kIHRob3NlIGNh
bGxzLiBJZiB5b3UgaGF2ZSBEU0RUcywgaGVyZSdzIGEgd2F5IHRvIGlkZW50aWZ5IGlmIHRoYXQN
Cj4gcGFydGljdWxhciBEU0RUL2RyaXZlciBjb21ibyBpcyBhZmZlY3RlZDoNCj4gDQo+IElmIGEg
Y2FsbCB0byBhbiBBQ1BJIGZ1bmN0aW9uIGV4cGVjdHMgYW4gSW50ZWdlciBhbmQgdGhlIEFDUEkg
ZnVuY3Rpb24gcmV0dXJucw0KPiBhIGZpZWxkIGNyZWF0ZWQgd2l0aCBDcmVhdGVGaWVsZCguLi4p
IGFuZCB0aGUgZmllbGQgaXMgc21hbGxlciB0aGFuIDY0IGJpdHMgKG9uDQo+IDY0Yml0IG1hY2hp
bmVzKSwgdGhlbiB0aGlzIGNhbGwgaXMgYWZmZWN0ZWQuDQo+IA0KPiBUaGUgb25seSBzZW1pLXJl
YXNvbmFibGUgd2F5LCBhcyBmYXIgYXMgSSBjYW4gc2VlLCB0byBpZGVudGlmeSB0aGlzIG9uIGEg
YnJvYWQNCj4gc2NhbGUgaXMgdG8gZ2V0IHRoaXMgaW5mb3JtYXRpb24gb3V0IHRvIHRoZSByZXNw
ZWN0aXZlIG1haW50YWluZXJzIG9mIGRyaXZlcnMNCj4gd2l0aCBhcGNpX2V2YWx1YXRlX3tpbnRl
Z2VyLG9iamVjdCxkc20sLi4/fSBjYWxscyBhbmQgYXNrIHRoZW0gdG8gY2hlY2sNCj4gdGhvc2Ug
Y2FsbHMgYWdhaW5zdCBEU0RUcy4gQWxzbyBtYXliZSBoZWxwIHRoZW0gYnkgaW50cm9kdWNpbmcg
YSBmdW5jdGlvbg0KPiB3aGljaCBkb2VzIEJ1ZmZlci10by1JbnRlZ2VyIGNvbnZlcnNpb24uDQo+
IA0KPiBSZWdhcmRzLA0KPiBNYXhpbWlsaWFuDQo+IA0KDQo=
