Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97972170622
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Feb 2020 18:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgBZRap (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 Feb 2020 12:30:45 -0500
Received: from mga14.intel.com ([192.55.52.115]:36903 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbgBZRap (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Feb 2020 12:30:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 09:30:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,488,1574150400"; 
   d="scan'208";a="350433305"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga001.fm.intel.com with ESMTP; 26 Feb 2020 09:30:44 -0800
Received: from FMSMSX109.amr.corp.intel.com (10.18.116.9) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 26 Feb 2020 09:30:44 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx109.amr.corp.intel.com (10.18.116.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 26 Feb 2020 09:30:44 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 26 Feb 2020 09:30:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDmY7j7iVxG1cMSWx8TzEPh5HYb2XYxfhhQI64jnAG/qUGi/QMM4j1vDPqWjBcEq5qlP1KItoDXKp/ff8Cl+rlWrqeGZ8NbHR7xddT14JI/xv0/5WSVIrjxIOX2r8Swgdw3AA/TzrvomKXJK0uSqG7V7h3bdLSZ2HyYF9iJPh5BFPMfycQVtuWZvVzHLWHv3zJCb0x8lGHY1JZgacvf1W0/5uAL+xgvLFsvdWyPlqRhf1w0NcbgxCS7YRLdm674BH7BOvSNGcLZBjHNKeJcSPcCh7hUz8lnP5Jt5h1tZ365H39sY62tb80HAX2aYrc9Q5kpPfbtpjVwquLRhd7EqwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5iTeh04yrEBHKqF2wneDEi2ynYpP4JyYIbUAW1hcXs=;
 b=PVWEk18POC7/9u4ArWHuDVC9AlTItlnkPpQsayaUITYqS1G9ogviJ/jkFpqzMLjyeKyVuloTGmma0BcCBug4Wqc0Q+LlBxvKAwjKOPM7tz2GtwhVhUjlL6l9MsNftQeN1OcPxAHpcA8oR+HWby71wcLddtrpVNoEJ1AIYzh5z/u/sQRonkw8AotQ3rVP1mWZSRDs8bwULHn01Xl+4czDWacAyH8XSMaXKABAIIiBpwLB+DbqQa1yBIz1g7wBmdHTl0FX6fAVfSGKL0xmmV9n5Q9McMrsGuy0dIeV0OSObvqbiQuEMAeX6vHBx/cZAvlP5epifs2p4RC2tgGnAQIaXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5iTeh04yrEBHKqF2wneDEi2ynYpP4JyYIbUAW1hcXs=;
 b=c5c/Pg97PLHyGfiZsT89CvsIDAisUCxhHd+q/cW6YCnjtBL0feIFK4Js4Dwf1s9fwgpbwNxvWXwePY+85P86JlX6JPW5yV9HFmst6KfMPecMGqMv+PrTa0tQvwZVBOUrnW6tgLkDdmKVUlVCZcoYuxO0ouE5i+nxVH2juDpViw4=
Received: from BYAPR11MB2951.namprd11.prod.outlook.com (2603:10b6:a03:90::10)
 by BYAPR11MB2773.namprd11.prod.outlook.com (2603:10b6:a02:c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Wed, 26 Feb
 2020 17:30:42 +0000
Received: from BYAPR11MB2951.namprd11.prod.outlook.com
 ([fe80::3907:3e08:9e42:fed3]) by BYAPR11MB2951.namprd11.prod.outlook.com
 ([fe80::3907:3e08:9e42:fed3%7]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 17:30:42 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH] ACPICA: Log successfully loaded DSDT
Thread-Topic: [PATCH] ACPICA: Log successfully loaded DSDT
Thread-Index: AQHV7KY5FXRAijLPYkOTaQvtFhwEe6gtu4mQ
Date:   Wed, 26 Feb 2020 17:30:41 +0000
Message-ID: <BYAPR11MB295181C721AA7AA3BB49B5F0F0EA0@BYAPR11MB2951.namprd11.prod.outlook.com>
References: <8a124312-9f75-c1b5-60d2-073322651221@molgen.mpg.de>
In-Reply-To: <8a124312-9f75-c1b5-60d2-073322651221@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzYyMTBmY2UtYTg4Ny00MjdjLThmMTItMzdlNzRiYzkzZTBkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiK2hZWnc0T0NISWRkSHltUG1XZFk0c0dEVkt3NlR1MU5LcmF4MEdKWHN4c2JtdVpcL2tNdExCeHRkN0dYODZuZ0cifQ==
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
dlp-reaction: no-action
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=erik.kaneda@intel.com; 
x-originating-ip: [134.134.136.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b1acd5e-a1e4-45c6-c9bf-08d7bae19ab0
x-ms-traffictypediagnostic: BYAPR11MB2773:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB277309EEE1EECA7F341FC915F0EA0@BYAPR11MB2773.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(39860400002)(136003)(346002)(189003)(199004)(71200400001)(33656002)(26005)(66446008)(8676002)(8936002)(7696005)(66476007)(64756008)(186003)(66556008)(81166006)(52536014)(55016002)(6506007)(5660300002)(6636002)(86362001)(316002)(110136005)(76116006)(4326008)(53546011)(2906002)(9686003)(478600001)(81156014)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR11MB2773;H:BYAPR11MB2951.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xLZxAPO7HsXw4074pE2neQPwTV3CfDaWiUG7n5iPSc5KKqVSMC0vlfD0dMbyzvfO5GR4DGIOgP+pdH92IBEVytQQkCjfJXLmbq6Sita8hKHLgEbB28gUI2IM64IhqD8vaeBORWyd4Rex+VTY/XufExnirHeXWZHbFarBsfC0esQMelIcIr7X27RCszpuOG+ZcxNwAp5TnXf3aQyiBO7+BPqQ2ezmEnvR0wnU54xmOQKFbKRZ9YzW3n4WtQjNJoLPhwdFPY6QP1xujlkf4FFE9rIKFh3WJarKkVHhYzT2nWsYPfm97sZHAlWNxawswydfkh1LbUzGIWY5D2+cKlsEU5vfE86D5KwEMyZI/DPOKdC17m5sZJ49FFzHVElYLN39uxOBx8tXZv++PEz1dZtB9lTWgsCDvJLwslg/bTLFr2YGztr5TVFq0IsCrlrLvmdg
x-ms-exchange-antispam-messagedata: 2EumwsnnziQFH8ngSi+fwWBlFfrImb8gOWt1dJ/LtG/j6cR8M+jEJYQozFNrTAkQgY8tND6qNyhouF6dcderV+SLdcOAIZCfS8YJv5g1OP9VMqx/wgsApw6QG86tzg/pXZ+cpV0bZtb0d55neqjnEA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b1acd5e-a1e4-45c6-c9bf-08d7bae19ab0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 17:30:42.0160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DrVXg7BH/sM1Zd4rYb1IiHVpMr6ElwwClSOxaDxIbCEc7B3KyNNHex00qxVmyJBScxiiqomMYCabUH/yVSBoBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2773
X-OriginatorOrg: intel.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

K0JvYg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGxpbnV4LWFjcGkt
b3duZXJAdmdlci5rZXJuZWwub3JnIDxsaW51eC1hY3BpLQ0KPiBvd25lckB2Z2VyLmtlcm5lbC5v
cmc+IE9uIEJlaGFsZiBPZiBQYXVsIE1lbnplbA0KPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5
IDI2LCAyMDIwIDU6MTEgQU0NCj4gVG86IFJhZmFlbCBKLiBXeXNvY2tpIDxyandAcmp3eXNvY2tp
Lm5ldD47IExlbiBCcm93biA8bGVuYkBrZXJuZWwub3JnPg0KPiBDYzogbGludXgtYWNwaUB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIXSBBQ1BJQ0E6IExvZyBzdWNjZXNzZnVsbHkg
bG9hZGVkIERTRFQNCj4gDQo+IEZyb206IFBhdWwgTWVuemVsIDxwbWVuemVsQG1vbGdlbi5tcGcu
ZGU+DQo+IERhdGU6IFN1biwgMTQgSnVsIDIwMTkgMTI6MTg6NTAgKzAyMDANCj4gDQo+IEV4cGxp
Y2l0bHkgbG9nLCB3aGVuIHRoZSBEU0RUIGhhcyBiZWVuIGxvYWRlZC4gVGhlIHRpbWVzdGFtcCB3
aWxsIGFsc28gaGVscA0KPiBhbmFseXppbmcgYW5kIG9wdGltaXppbmcgdGhlIGJvb3Qgc3BlZWQu
DQo+IA0KPiAgICAgWyAgICAwLjE0MjI0OF0gQUNQSTogQWRkZWQgX09TSShMaW51eC1IUEktSHli
cmlkLUdyYXBoaWNzKQ0KPiAgICAgWyAgICAwLjE2ODc5NF0gQUNQSTogRFNEVCBzdWNjZXNzZnVs
bHkgYWNxdWlyZWQgYW5kIGxvYWRlZA0KPiAgICAgWyAgICAwLjIwMzkyNV0gQUNQSTogOSBBQ1BJ
IEFNTCB0YWJsZXMgc3VjY2Vzc2Z1bGx5IGFjcXVpcmVkIGFuZCBsb2FkZWQNCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IFBhdWwgTWVuemVsIDxwbWVuemVsQG1vbGdlbi5tcGcuZGU+DQo+IC0tLQ0KPiAg
ZHJpdmVycy9hY3BpL2FjcGljYS90YnhmbG9hZC5jIHwgMSArDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvYWNwaWNhL3Ri
eGZsb2FkLmMgYi9kcml2ZXJzL2FjcGkvYWNwaWNhL3RieGZsb2FkLmMNCj4gaW5kZXggYmNiYTk5
M2Q0ZGFjLi5lNDllYmNmMjU0OTMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvYWNwaS9hY3BpY2Ev
dGJ4ZmxvYWQuYw0KPiArKysgYi9kcml2ZXJzL2FjcGkvYWNwaWNhL3RieGZsb2FkLmMNCj4gQEAg
LTE2Miw2ICsxNjIsNyBAQCBhY3BpX3N0YXR1cyBhY3BpX3RiX2xvYWRfbmFtZXNwYWNlKHZvaWQp
DQo+ICAJCXRhYmxlc19mYWlsZWQrKzsNCj4gIAl9IGVsc2Ugew0KPiAgCQl0YWJsZXNfbG9hZGVk
Kys7DQo+ICsJCUFDUElfSU5GTygoIkRTRFQgc3VjY2Vzc2Z1bGx5IGFjcXVpcmVkIGFuZCBsb2Fk
ZWRcbiIsDQo+IHRhYmxlc19sb2FkZWQpKTsNCj4gIAl9DQo+IA0KPiAgCS8qIExvYWQgYW55IFNT
RFQgb3IgUFNEVCB0YWJsZXMuIE5vdGU6IExvb3AgbGVhdmVzIHRhYmxlcyBsb2NrZWQgKi8NCj4g
LS0NCj4gMi4yNS4wDQoNCg==
