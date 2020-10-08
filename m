Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39236287B1E
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Oct 2020 19:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbgJHRlE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Oct 2020 13:41:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:28159 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbgJHRlE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 8 Oct 2020 13:41:04 -0400
IronPort-SDR: i1OKN/sDnflyBbt1v5/25YnnxOjV4jhKC/3CJlygRKSlnL45mfUi9H2Q4fuMFjikh6OM7H0tFR
 9wR9BoI3Fsfw==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="250071317"
X-IronPort-AV: E=Sophos;i="5.77,351,1596524400"; 
   d="scan'208";a="250071317"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 10:41:03 -0700
IronPort-SDR: j6xGKbXbrALzSK7UnJ6+iwXmvICWYXh6CC34wEPk3Q5O09+wZPntbWwZohtrq0FB9LlpiMCahx
 wnLn2tfwXorg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,351,1596524400"; 
   d="scan'208";a="343499474"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 08 Oct 2020 10:41:03 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 8 Oct 2020 10:41:02 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 8 Oct 2020 10:41:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 8 Oct 2020 10:41:02 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 8 Oct 2020 10:41:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxJF4VOaWw56LAuAzke+lay75m7eGmCCjGMnjusJHNc3osscASFpmk2WUi06hkLI2dMWwUvpFfeKbtUEEnCoYeW4Yu0sazqA9ryA7/p3+MavjJzI3fdMnxHIj5ElrJgqoZznZyRGpIVBWQ/kcN2rTxlvzs9n3HvBNXk5BgghpQgQ8U3YvW/wnj2GF6TqCbIVIlxNppmaFG9TGIxMXEtNE8PeTJdLNql3iAVsMcWn4T9qrIXMCK+nR3kRiKvUwDpmKh/3fHXmmmq83B8By/p/b6QZzr7frSTVlgI9heesxUDZ57btVsI7iKv+eVYz0oOA408l3aKTz+geFP7TujrGZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5DWFXxATTOJQbIOWsSQ5XIrIiczc+7caCzQLVNohGg=;
 b=G/4dzvjS/Qubj4b1w8UMWBOZGTHBHDqwuqJpsrvt/7mOrYOqBtD6rwvY8K0hKyEHi/1gn77DZag10kOuz9FxqkmIXaw7wn5wNx62BjtPe2LgbdgCGUuO1x5899w6Yw6b/o4mk+ICZNyCCPyFROrACxfT7AqueTFZIzs22A+V29O9ZqefRdVIcXcfm+FHAQKnTwcUo8CVwEibmy/jeqkOUUJ2c6D6uBALbpEMOPBQ0W0j6ScuHkf6cU2owqqwvQgzOHWvO3XR2LAIsi1y6PQgyTwiCa/Wg6W1FoC4/T5I7Jv/IXUQszfSKYPo3RzYpC1VSOBdoVyLr18alO8FvvBIxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5DWFXxATTOJQbIOWsSQ5XIrIiczc+7caCzQLVNohGg=;
 b=La+7ea85YUcRZdD9HOG5ZOaDE74Delxrk6CzSU3hTUUdQoMhj/mUF1QqhFoD0f1WkhssgAEfOiBH+hy7RAIXA68D04SjyoBYZmMJyexOVEKz//CfvHj20uUL/WaJOfdw/b3BVDvMl89Y/Z1Ez4MNZaaOFDjy7i12tt0itXgjA9M=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by MWHPR11MB1247.namprd11.prod.outlook.com (2603:10b6:300:2a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Thu, 8 Oct
 2020 17:41:00 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::4c08:c078:72e5:a036]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::4c08:c078:72e5:a036%8]) with mapi id 15.20.3455.024; Thu, 8 Oct 2020
 17:41:00 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH 0/9] ACPICA release 20200925
Thread-Topic: [PATCH 0/9] ACPICA release 20200925
Thread-Index: AQHWnSIyHQh1OjYi+U+jilDqdKoYbqmN38gAgAAWSrA=
Date:   Thu, 8 Oct 2020 17:40:59 +0000
Message-ID: <MWHPR11MB15995EEABDAE593954507FC6F00B0@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <20201008025403.2401736-1-erik.kaneda@intel.com>
 <CAJZ5v0hod0bH6xE34P_wfbN0P1FV0jnk+Q9jF=YG+OALDvNg7A@mail.gmail.com>
In-Reply-To: <CAJZ5v0hod0bH6xE34P_wfbN0P1FV0jnk+Q9jF=YG+OALDvNg7A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [50.39.108.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 950b56e7-312b-44ca-3837-08d86bb15222
x-ms-traffictypediagnostic: MWHPR11MB1247:
x-microsoft-antispam-prvs: <MWHPR11MB1247B09DEE96FE3470EBE839F00B0@MWHPR11MB1247.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vfbm+CXfle1DJweTCDqLPATkAH4rNJAcNpsfzTG4S/X57XwwenEKEFvw7kzudHdRjioqNELevhbGjosbjCT61i7/rEXs7ih5dD1Uns509pFLP3+2O7Zok1il+PRn95vx7PUFolg8kJRBVPSu/HtEjdqIuLFJsRkZY02uoymtOtfw2tEqJKLZ/Ui9omHaKzWxMTPwbNIavQUf3y+MriB4r3te7AS6phpxy2jvtDp5Ege86Ag14VdkMRADXt12yNu4S5hOgEDZtz2A0C+Y7Hwc23n+NLc/W2SoL57La/QfL9ZcT8hnMXCJAUonxKMSVJyCgOCpjNdeHkrJOIkN4DD4Iw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(4326008)(33656002)(7696005)(9686003)(186003)(52536014)(2906002)(26005)(66476007)(66556008)(478600001)(64756008)(66446008)(53546011)(66946007)(6506007)(76116006)(8676002)(71200400001)(55016002)(86362001)(5660300002)(8936002)(83380400001)(316002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: YqAzWoJwV+5xVMUgc+KFRg307/gMTJ82PYl5ckO+lYrS64ICsfH5N61GhWmFIp9r+J6Lg+nUIaUGkbXFz1MDVQ6xzNe8TbH6ws0HiH8+e+i7DK3uCwYP9ROxr5/kQ4UZZFT1zAKVf/G2By0BbEyxcTcAv1GF0x6CGXNV5ulrjwkO6A/azhEL0Iq+/+7eXLbKxZs3KI1pXmOoT6EunAiHmq0PBJzN3mLAhh2crKSygdVWsMm0i1EFCVeUB2IExCBXtYMNqlct+LkRApdaSZcZc2oLnPgFH23dhKRXbp49xC03weWMIyuRfnpGkxUhQ9sIFg2ztE0d8ADTbL68/kElFvymZe4HdYgScuv+yAlAQZtO7XfKT0nXiP5daHcgRv3ft9zs1I+ATCuGk3kvCcJ8Sim8CJVnFv5yHPwCLJlzi2T9rUFVRg3vYnCrlTVT8vGsiCQoEhaw4odqB2fHA7r7ynpMCuBcfsRGrlLsO87PoCmVZfHOdR4+z9taTFuna7af6N0HmboSI6ueTcwvB1qo6xcyaXc6oHFd58kl2lEcsB2gMIAKMiy/JMWhck/0488YXhDFQVrYRZYv2U/vR4uJ4B4pIYEyuVJSxe0NxGNbzPWoMDuUpcly6z9WYc6MfNU9Rn0JuVdr5kAV9I85vfbbKA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 950b56e7-312b-44ca-3837-08d86bb15222
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2020 17:41:00.1734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UCkBELUBJ/YdEnvnODsHpPFydrEOE8psEXBsOA8PAuDy0ucfMZI2vJvVzCRnl0fVJAUOODbcJj3Y3RhCa16lUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1247
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFmYWVsIEouIFd5c29j
a2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciA4LCAyMDIw
IDk6MDcgQU0NCj4gVG86IEthbmVkYSwgRXJpayA8ZXJpay5rYW5lZGFAaW50ZWwuY29tPg0KPiBD
YzogUmFmYWVsIEogLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz47IEFDUEkgRGV2ZWwgTWFs
aW5nIExpc3QgPGxpbnV4LQ0KPiBhY3BpQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCAwLzldIEFDUElDQSByZWxlYXNlIDIwMjAwOTI1DQo+IA0KPiBPbiBUaHUsIE9jdCA4
LCAyMDIwIGF0IDU6MjEgQU0gRXJpayBLYW5lZGEgPGVyaWsua2FuZWRhQGludGVsLmNvbT4gd3Jv
dGU6DQo+ID4NCj4gPiBUaGlzIHJlbGVhc2UgY29udGFpbnMgdGhlIEFDUElDQSBwYXRjaGVzIGZy
b20gdGhlIDIwMjAwOTI1IHJlbGVhc2UuDQo+ID4gVGhpcyBjb250YWlucyBwYXRjaGVzIHRoYXQg
YXJlIG1vc3RseSBmb3IgdXNlciBzcGFjZSB0b29scyBzdWNoIGFzIGlBU0wsDQo+ID4gYWNwaWhl
bHAuIFRoZSBvbmx5IGRpcmVjdCBpbXBhY3QgdG8gdGhlIGxpbnV4IGtlcm5lbCBpcyB0aGUgYWRk
aXRpb24gb2YNCj4gPiBzZXZlcmFsIHByZWRlZmluZWQgbmFtZXMgdGhhdCB3ZXJlIGZvdW5kIGlu
IHRoZSBTTUJ1cyBzcGVjaWZpY2F0aW9uLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRXJpayBL
YW5lZGEgPGVyaWsua2FuZWRhQGludGVsLmNvbT4NCj4gPg0KPiA+IEJvYiBNb29yZSAoNik6DQo+
ID4gICBBQ1BJQ0E6IEFkZCBwcmVkZWZpbmVkIG5hbWVzIGZvdW5kIGluIHRoZSBTTUJ1cyBzZXBj
aWZpY2F0aW9uDQo+ID4gICBBQ1BJQ0E6IGFjcGlfaGVscDogVXBkYXRlIFVVSUQgbGlzdA0KPiA+
ICAgQUNQSUNBOiBpQVNMOiBSZXR1cm4gZXhjZXB0aW9ucyBmb3Igc3RyaW5nLXRvLWludGVnZXIg
Y29udmVyc2lvbnMNCj4gPiAgIEFDUElDQTogRGVidWdnZXI6IEFkZCBhIG5ldyBjb21tYW5kOiAi
QUxMIDxOYW1lU2VnPiINCj4gPiAgIEFDUElDQTogUmVtb3ZlIHVubmVjZXNzYXJ5IHNlbWljb2xv
bg0KPiA+ICAgQUNQSUNBOiBVcGRhdGUgdmVyc2lvbiB0byAyMDIwMDkyNSBWZXJzaW9uIDIwMjAw
OTI1Lg0KPiA+DQo+ID4gQ29saW4gSWFuIEtpbmcgKDIpOg0KPiA+ICAgQUNQSUNBOiBBZGQgc3Vw
cG9ydCBmb3IgNjQgYml0IHJpc2MtdiBjb21waWxhdGlvbi4NCj4gPiAgIEFDUElDQTogVHJlZS13
aWRlOiBmaXggdmFyaW91cyB0eXBvcyBhbmQgc3BlbGxpbmcgbWlzdGFrZXMNCj4gPg0KPiA+IFJh
bmR5IER1bmxhcCAoMSk6DQo+ID4gICBBQ1BJQ0E6IERyb3AgdGhlIHJlcGVhdGVkIHdvcmQgImFu
IiBpbiBhIGNvbW1lbnQuDQo+ID4NCj4gPiAgZHJpdmVycy9hY3BpL2FjcGljYS9hY2RlYnVnLmgg
ICAgICAgICAgICAgICAgIHwgICA0ICsNCj4gPiAgZHJpdmVycy9hY3BpL2FjcGljYS9hY3ByZWRl
Zi5oICAgICAgICAgICAgICAgIHwgIDMzICsrKy0NCj4gPiAgZHJpdmVycy9hY3BpL2FjcGljYS9k
YmV4ZWMuYyAgICAgICAgICAgICAgICAgIHwgIDM5ICsrKy0NCj4gPiAgZHJpdmVycy9hY3BpL2Fj
cGljYS9kYmlucHV0LmMgICAgICAgICAgICAgICAgIHwgIDE0ICstDQo+ID4gIGRyaXZlcnMvYWNw
aS9hY3BpY2EvZGJtZXRob2QuYyAgICAgICAgICAgICAgICB8IDE2NyArKysrKysrKysrKysrKyst
LS0NCj4gPiAgZHJpdmVycy9hY3BpL2FjcGljYS9uc2FsbG9jLmMgICAgICAgICAgICAgICAgIHwg
ICAyICstDQo+ID4gIGRyaXZlcnMvYWNwaS9hY3BpY2EvbnNhcmd1bWVudHMuYyAgICAgICAgICAg
ICB8ICAgNCArLQ0KPiA+ICBkcml2ZXJzL2FjcGkvYWNwaWNhL25zeGZvYmouYyAgICAgICAgICAg
ICAgICAgfCAgIDMgKy0NCj4gPiAgZHJpdmVycy9hY3BpL2FjcGljYS9wc3BhcnNlLmMgICAgICAg
ICAgICAgICAgIHwgICA0ICstDQo+ID4gIGRyaXZlcnMvYWNwaS9hY3BpY2EvdXRwcmVkZWYuYyAg
ICAgICAgICAgICAgICB8ICAgNSArLQ0KPiA+ICBkcml2ZXJzL2FjcGkvYWNwaWNhL3V0c3Ryc3Vw
cHQuYyAgICAgICAgICAgICAgfCAgMzMgKysrLQ0KPiA+ICBpbmNsdWRlL2FjcGkvYWNjb25maWcu
aCAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKy0NCj4gPiAgaW5jbHVkZS9hY3BpL2FjZXhj
ZXAuaCAgICAgICAgICAgICAgICAgICAgICAgIHwgICA0ICstDQo+ID4gIGluY2x1ZGUvYWNwaS9h
Y3BpeGYuaCAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMiArLQ0KPiA+ICBpbmNsdWRlL2Fj
cGkvYWN0eXBlcy5oICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKy0NCj4gPiAgaW5jbHVk
ZS9hY3BpL2FjdXVpZC5oICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA3ICsNCj4gPiAgaW5j
bHVkZS9hY3BpL3BsYXRmb3JtL2FjbGludXguaCAgICAgICAgICAgICAgIHwgICAzICstDQo+ID4g
IC4uLi9vc19zcGVjaWZpYy9zZXJ2aWNlX2xheWVycy9vc2xpbnV4dGJsLmMgICB8ICAgMiArLQ0K
PiA+ICAxOCBmaWxlcyBjaGFuZ2VkLCAyNzAgaW5zZXJ0aW9ucygrKSwgNjAgZGVsZXRpb25zKC0p
DQo+ID4NCj4gPiAtLQ0KPiANCj4gQWxsIGFwcGxpZWQgYXMgNS4xMCBtYXRlcmlhbCAoSSBkcm9w
cGVkIGEgZmV3IHRlcm1pbmF0aW5nIHBlcmlvZHMgZnJvbQ0KPiBwYXRjaCBzdWJqZWN0cyksIHRo
YW5rcyENCg0KVGhhbmtzIGZvciB0aGUgZWRpdHMhDQpBbHNvLCBJIGFtIGN1cnJlbnRseSBob2xk
aW5nIG9uIHRvIDIgcGF0Y2hlcyBmcm9tIHRoaXMgQUNQSUNBIHJlbGVhc2UgdGhhdCB1cGRhdGUg
dGhlIEhNQVQgdGFibGUuDQpUaGVzZSBwYXRjaGVzIHJlbW92ZSBzb21lIG1hY3JvcyB0aGF0IGFy
ZSBpbiB1c2UgaW4gZHJpdmVycy9hY3BpL251bWEvaG1hdC5jIA0KSWYgSSB3ZXJlIHRvIGFwcGx5
IHRoZSBwYXRjaGVzIHdpdGhvdXQgZml4aW5nIGhtYXQuYywgSSB3aWxsIGdldCBhIGJ1aWxkIGVy
cm9yLiBJIHdpbGwgc2VuZCBvdXQgdGhvc2UgcGF0Y2hlcyBhZnRlciBJIGdldCBmZWVkYmFjayBv
biBob3cgdG8gZml4IGhtYXQuYy4NCg0KVGhhbmtzLA0KRXJpaw0K
