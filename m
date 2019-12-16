Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4828121C38
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2019 22:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfLPV5b (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Dec 2019 16:57:31 -0500
Received: from mga18.intel.com ([134.134.136.126]:57586 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726940AbfLPV5a (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Dec 2019 16:57:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 13:57:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,323,1571727600"; 
   d="scan'208";a="212184232"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga007.fm.intel.com with ESMTP; 16 Dec 2019 13:57:28 -0800
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 16 Dec 2019 13:57:24 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 16 Dec 2019 13:57:23 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 16 Dec 2019 13:57:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5FIrWyLoglElaDJ0JAelgTKpBiayb8I4xjfktFdIvHrP47eClVMsURNrhZiVYDYDa4tXSHWWXjQdV2viRzb++18vdqLmgmfVEuPz/eNfCZ+z7wuWm6a8+I3gwWZIq/Fnf65+jSuQuMkVx9qnecVi6vkVlyQYz9qvrm/juNZu9AIwrw74vJ//YlwjjWjckI5u7WhzS0aDi9qFfXQdjeeX6sbfdBtk3mDk3mIzurZHW2oin21zRu2wrr+OFWoRsOMx7tUkdT7l5AdXOP1emQrfHHtMc9iGwTR7MbJwqiOJ2TPol19e+EmwrZvGXyKIOgpi13O9cvweNI3AJJO4tTyIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYSttqBuTRRTRFXgIMDEVizo05qA0uhw3A2Xj5OUgiY=;
 b=YHm2hVAR2Gcy6TpRgvlZ6j24zQY3ReMEFmliZewnqtFVZ9Pv5kZ9r2WjHeC8NYDRZxDwoD/YMKiTlQg0TgaztB2tS+gXiEJpQSbfeBVM1CdujyLW6L9iV0jgCmIPZs92CB9zQkCUpEc9Vvt9f2x2/OVuxsyTKGxogWPQP1PniKAZ9SoiXOneby9fzI68Ie/Hm99uGpNuglX6Q638hS56VEen1YL3QKWDLMedgOCmK8mW5yBTkPrzK7kxXpzSdPUCa5GOheIoACjKAzjV1gnic1yqGdboIUZ+26dwdGjnq7dawjoXbFPOCkzSnkyNr4CWEdfKplTSVFTT5pFKUjh/xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYSttqBuTRRTRFXgIMDEVizo05qA0uhw3A2Xj5OUgiY=;
 b=nqbswclvkorWKYwsTj+cAzBVOgGz2RzAkD9ll5/gNQWXvICc4fAMGMAi1Qxfm55/atQ7JfDu2e9k7ixjA8mN5sQcRs5h7ffSKTyAkuNZBP2sFfLntoQb46tVFXUBetri5croZ1hBhCbp1FBu2vEKOe7dENpTV+zqXjnZxE4orDQ=
Received: from MWHPR11MB1278.namprd11.prod.outlook.com (10.169.230.151) by
 MWHPR11MB1791.namprd11.prod.outlook.com (10.175.53.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Mon, 16 Dec 2019 21:56:55 +0000
Received: from MWHPR11MB1278.namprd11.prod.outlook.com
 ([fe80::707d:8cdb:8345:664e]) by MWHPR11MB1278.namprd11.prod.outlook.com
 ([fe80::707d:8cdb:8345:664e%4]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 21:56:55 +0000
From:   "Kammela, Gayatri" <gayatri.kammela@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Linux PM <linux-pm@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Alex Hung <alex.hung@canonical.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        "Prestopine, Charles D" <charles.d.prestopine@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: RE: [PATCH v3 0/5] drivers: Add Tiger Lake hardware IDs to support
 ACPI,
Thread-Topic: [PATCH v3 0/5] drivers: Add Tiger Lake hardware IDs to support
 ACPI,
Thread-Index: AQHVtD9rz4F98Q5KHUWM8j7jsII8yae9SQAAgAAFuqA=
Date:   Mon, 16 Dec 2019 21:56:55 +0000
Message-ID: <MWHPR11MB1278E9E06FBB5847444B11F3F2510@MWHPR11MB1278.namprd11.prod.outlook.com>
References: <cover.1576520244.git.gayatri.kammela@intel.com>
 <CAJZ5v0g2UHJcnczekgegX6_7kzHrmXNS_e3KRCC2d4LQ1+RceA@mail.gmail.com>
In-Reply-To: <CAJZ5v0g2UHJcnczekgegX6_7kzHrmXNS_e3KRCC2d4LQ1+RceA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzc0YmUyYzktMzRmYi00OWIyLTlkMzktZTVkYTdlOWZlNmUwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRHU4T3lIRVBQNEhUTEVOSmFmWWpiMEhoT0Q1eVZleDNpc0hUdG9ZR0xjRGptWUJwRlwvZER3S2dYNkFveG1tQlQifQ==
dlp-version: 11.2.0.6
dlp-reaction: no-action
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gayatri.kammela@intel.com; 
x-originating-ip: [192.55.52.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6105267-965f-450e-4571-08d78272ddc1
x-ms-traffictypediagnostic: MWHPR11MB1791:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1791D5FBAC22144C5123D69EF2510@MWHPR11MB1791.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(13464003)(186003)(76116006)(26005)(33656002)(7696005)(66476007)(66946007)(66556008)(64756008)(66446008)(53546011)(52536014)(2906002)(71200400001)(6916009)(7416002)(9686003)(55016002)(81166006)(81156014)(8676002)(8936002)(86362001)(6506007)(4326008)(54906003)(316002)(5660300002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR11MB1791;H:MWHPR11MB1278.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NKkWMnf79zepVBK8W/W9ipVWJpzgeQY9g1OmxPWElEjpuxIxpAsSN8hELgAHs7jcoEOdNlO4Ik0hqPM6L7QiQeBcwOMm4t0Li8QygBfiPE76lVhjz3DDmbM5ZSdlRGlCOivF8uVFfv5FoqznABXkbwyJlLn0coiDOUE1plTDafZPqga1izgXFmQ8hX6DiVSUb5zaR+4EwEnbvXc3R99cMtiicMYfjPSkK2DntjVDQ8qr6oaIgMcDSs1Ndqox6SPVc3tEefFdYZzl5045+2CvzdD9eGZJ5Whd4SuiQRfg70FbSPpTUuUZJ2ihT5yUFMUivB8OJqimwvGZXwfm9L37G993+q0W4egRnZZxiQQi/XYlbx7QjfLSRVCgKAnUEoPIHaNP0SpQ4VcJTMVX0bhExfxTtHeq1Kj0vEVwba1ksZw9kWJKmHSz2sBonhN+ZlXQ9SFLJGpYgQNIvjAVn1K4ssle5agY+tYpADA42NwEvHY2BHnoAECV/LH21GvLabXH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f6105267-965f-450e-4571-08d78272ddc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 21:56:55.3388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LHCmePyJVBBfA93y+casjCEtSi4nBnmCawUWSSFEgUeH8+btttt1hqkFHjuYXfuj+KknCw0fXm+4z2sZDu904GY6+7gWHN8zUXpn3uqLfZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1791
X-OriginatorOrg: intel.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFmYWVsIEouIFd5c29j
a2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIERlY2VtYmVyIDE2LCAyMDE5
IDE6MzYgUE0NCj4gVG86IEthbW1lbGEsIEdheWF0cmkgPGdheWF0cmkua2FtbWVsYUBpbnRlbC5j
b20+DQo+IENjOiBMaW51eCBQTSA8bGludXgtcG1Admdlci5rZXJuZWwub3JnPjsgUGxhdGZvcm0g
RHJpdmVyIDxwbGF0Zm9ybS1kcml2ZXItDQo+IHg4NkB2Z2VyLmtlcm5lbC5vcmc+OyBBbGV4IEh1
bmcgPGFsZXguaHVuZ0BjYW5vbmljYWwuY29tPjsgQUNQSSBEZXZlbA0KPiBNYWxpbmcgTGlzdCA8
bGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc+OyBMZW4gQnJvd24gPGxlbmJAa2VybmVsLm9yZz47
DQo+IFJhZmFlbCBKLiBXeXNvY2tpIDxyandAcmp3eXNvY2tpLm5ldD47IExpbnV4IEtlcm5lbCBN
YWlsaW5nIExpc3QgPGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgRGFuaWVsIExl
emNhbm8gPGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+OyBBbWl0DQo+IEt1Y2hlcmlhIDxhbWl0
Lmt1Y2hlcmlhQHZlcmR1cmVudC5jb20+OyBQcmVzdG9waW5lLCBDaGFybGVzIEQNCj4gPGNoYXJs
ZXMuZC5wcmVzdG9waW5lQGludGVsLmNvbT47IERhcnJlbiBIYXJ0IDxkdmhhcnRAaW5mcmFkZWFk
Lm9yZz47DQo+IFJhZmFlbCBKIC4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+OyBBbmR5IFNo
ZXZjaGVua28NCj4gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT47IFpoYW5nLCBS
dWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+Ow0KPiBQYW5kcnV2YWRhLCBTcmluaXZhcyA8c3Jpbml2
YXMucGFuZHJ1dmFkYUBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMC81XSBk
cml2ZXJzOiBBZGQgVGlnZXIgTGFrZSBoYXJkd2FyZSBJRHMgdG8gc3VwcG9ydA0KPiBBQ1BJLA0K
PiANCj4gT24gTW9uLCBEZWMgMTYsIDIwMTkgYXQgNzozMyBQTSBHYXlhdHJpIEthbW1lbGENCj4g
PGdheWF0cmkua2FtbWVsYUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSGksDQo+ID4NCj4g
PiBUaWdlciBMYWtlIHN1cHBvcnRzIGRldmljZXMgd2hvc2UgaGFyZHdhcmUgSURzIGFyZSBjaGFu
Z2VkIGZvciB2YXJpb3VzDQo+ID4gZHJpdmVycy4gSGVuY2UsIGFkZCB0aGUgbmV3IGhhcmR3YXJl
IElEcy4NCj4gPg0KPiA+IFBhdGNoIDE6IEFkZCBUaWdlciBMYWtlIHN1cHBvcnQgdG8gRFBURiBk
cml2ZXIgUGF0Y2ggMjogQWRkIFRpZ2VyIExha2UNCj4gPiBzdXBwb3J0IHRvIGZhbiBkcml2ZXIg
UGF0Y2ggMzogQWRkIFRpZ2VyIExha2Ugc3VwcG9ydCB0byBkZXZpY2VfcG0NCj4gPiBQYXRjaCA0
OiBBZGQgVGlnZXIgTGFrZSBzdXBwb3J0IHRvIEludGVsJ3MgSElEIGRyaXZlciBQYXRjaCA1OiBB
ZGQNCj4gPiBUaWdlciBMYWtlIHN1cHBvcnQgdG8gdGhlcm1hbCBkcml2ZXINCj4gDQo+IEknbSBn
b2luZyB0byBhcHBseSB0aGUgd2hvbGUgc2VyaWVzIChmb3IgNS42KSBpZiBub2JvZHkgaGFzIGFu
eSBpc3N1ZXMgd2l0aA0KPiB0aGF0Lg0KPiANCj4gVGhhbmtzIQ0KDQpUaGFuayB5b3UgUmFmYWVs
IQ0K
