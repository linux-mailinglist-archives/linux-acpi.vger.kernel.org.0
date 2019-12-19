Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B60E112707F
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2019 23:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfLSWOi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Dec 2019 17:14:38 -0500
Received: from mga04.intel.com ([192.55.52.120]:28063 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbfLSWOh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 19 Dec 2019 17:14:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2019 14:14:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,333,1571727600"; 
   d="scan'208";a="206351900"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga007.jf.intel.com with ESMTP; 19 Dec 2019 14:14:35 -0800
Received: from fmsmsx111.amr.corp.intel.com (10.18.116.5) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 19 Dec 2019 14:14:35 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx111.amr.corp.intel.com (10.18.116.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 19 Dec 2019 14:14:35 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 19 Dec 2019 14:14:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvPe/Y5iVi3s3P2zWOewY2mr0dzyuTsOxFUUudhGCXIgqNArs00Wjcv20P4/wJ+Us6dgAEHc3oqqRCWDvUehGvqNkiwdE/nshwJOHhZGSKB+wY34iILamruQjXPjKiPpdfslPUugwonHgncxcOGnOoPue6Uwwnn0ZfQ0CuyIlBeb4Liy/VkO5KGF5gvYVEz2JFWp/X3yS/QIYfWqfwG2rtfKLut1RvQTkiOp/1k5sE2R/TRwK+ZsOc+YWUsfJ4cCquQ/xMR5Gifotf3kL+E2PsROc/0pSy+VlMBmyWzSN5FK6Yl04WuRCrmjSlK8NAK3YRtr4mOCpXJFuKOTtprjCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDC0mMNG9gOnvpjkDANpvWrHDLVgw3vryTPmD6wIXYo=;
 b=QXpwTVHzUHI8rMow1M6skflKXeR+yffIKU2Z84d85CYfytaGQPDw54dahZUQdc5L02nw61IZgPWoU/MoOFcl5ytSZpk6Eldf5Sa7bj8i9Qm/LENnycZSTTz4XZcsozfNIQiQoqS/Vs90S+YRDtZBAn2e9GykYVE8ouB8llSukwH5W/zPxiOX8PVCkJhT+mEnLawf2UxO2FwSpCuSlUxBxj80SS/AI1bjlPZ8rVjFXyULiSJQ2ZlCjMUD1aGLFnYmKuXwza66XEFwABNHdN0LSjH0PA4rvo8B+ime3ChTal7/ePUVipl+LLI1OZIwZX49aMj+8VG0XBxNZcFySRTAPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDC0mMNG9gOnvpjkDANpvWrHDLVgw3vryTPmD6wIXYo=;
 b=bSnCF9rwIvcVF2O7rYaSfMnyySLHgeZJJPIWZC5dIpBhUojazqMdVaJ4zaPxj7apMDWm+MWzyQGe0pznlyuSlryzADSTvypWPM8p+WfQBgSN0ibNRNovBmlf5xZznJOMP3Mg81sQ5HfZOaZcQBE2jpWd+fyd51IBor/HOlKouaY=
Received: from BL0PR11MB3107.namprd11.prod.outlook.com (20.177.205.12) by
 BL0PR11MB3235.namprd11.prod.outlook.com (10.167.235.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Thu, 19 Dec 2019 22:14:32 +0000
Received: from BL0PR11MB3107.namprd11.prod.outlook.com
 ([fe80::96c:e58a:8ab:b602]) by BL0PR11MB3107.namprd11.prod.outlook.com
 ([fe80::96c:e58a:8ab:b602%5]) with mapi id 15.20.2559.015; Thu, 19 Dec 2019
 22:14:32 +0000
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
Thread-Index: AQHVtD9rz4F98Q5KHUWM8j7jsII8yae9SQAAgAAFuqCABLblgIAABOCA
Date:   Thu, 19 Dec 2019 22:14:32 +0000
Message-ID: <BL0PR11MB310782F0B4141E8295133C46F2520@BL0PR11MB3107.namprd11.prod.outlook.com>
References: <cover.1576520244.git.gayatri.kammela@intel.com>
 <CAJZ5v0g2UHJcnczekgegX6_7kzHrmXNS_e3KRCC2d4LQ1+RceA@mail.gmail.com>
 <MWHPR11MB1278E9E06FBB5847444B11F3F2510@MWHPR11MB1278.namprd11.prod.outlook.com>
 <CAJZ5v0ji2f7XsR2__t5Fw8Vi1hB2XXHbp-LCZABN29yQ4VOyKw@mail.gmail.com>
In-Reply-To: <CAJZ5v0ji2f7XsR2__t5Fw8Vi1hB2XXHbp-LCZABN29yQ4VOyKw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDE4ZjE0NmItN2IyYi00MWJiLTgyYjctMDZjMWMxZDA0OTAzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiT3ZqY3RmNzNoSWtTTTJWTkdVSStMdzE2SmltVjZZc1psMW51VTEyTWlOYzQ2ZTlPN3lYRmZGVElzOXJFb0k2ayJ9
dlp-version: 11.2.0.6
dlp-reaction: no-action
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gayatri.kammela@intel.com; 
x-originating-ip: [134.134.136.218]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49e27d50-b068-41ee-99ed-08d784d0d314
x-ms-traffictypediagnostic: BL0PR11MB3235:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR11MB3235CDB80649B4066E7E04FDF2520@BL0PR11MB3235.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(54534003)(7696005)(6506007)(76116006)(66476007)(4744005)(71200400001)(186003)(64756008)(66446008)(7416002)(66946007)(66556008)(54906003)(26005)(6916009)(86362001)(316002)(55016002)(33656002)(478600001)(2906002)(81156014)(8676002)(4326008)(9686003)(81166006)(52536014)(5660300002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR11MB3235;H:BL0PR11MB3107.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GL7KVHWr0ZdjqnM51KgKVMxT7F2zzX1qSGTqShJYSCqJzUjQqusUK6VfbZJDrgb4kTkVOYAhyqHnuk5fzOpNmkUnGY024YUHk2BtYmLqjmDKrMCjJeH3PO2pV5qh5GtjhyVnfVjYJ4kZq8TQzS9497bjkKn0HRFrOgOM3xG5poodM/FNZw62YLbotCRlc1bysRqUzqwYdFRg5ZAa4TlodrEC3jig7P/0LQtT86oeJLPh62KXb1rdfenvEQ+gbvlLxenAIoxY1oiSrKPyJyhde3a3uhhI/divncIuOsoxySwwxJc2TnVo815g2BQ8D7Ox0WEpF6LHArbuS3i+Rz3ulIumUTyJuOcxHg5j6h96d+EH0xGmHzNVopTnc/7F6zpwuSUbyq/ZRCOVze2Ejy04pHQ822oBuYIEDzm6xI/zBg5fiXN9bYrU3+E5Ugj1sYmcdAOLI2UEucXpDed3zXBtqVA/KrnqvYxfUDtR9K/rlRmp42gp/OAMnZrETaTZ5cC4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e27d50-b068-41ee-99ed-08d784d0d314
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 22:14:32.2013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AtYaeR5crA6AGTG37Kggr0iajPD2Rv+I8V0TwNiiGVsH6aIeIxw9GlFRLzIKSpu/48tG+Z8q/ajzVGnsQwvOhKJIgQfxI4DGgSSfZxjd/9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3235
X-OriginatorOrg: intel.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PiA+ID4gPiBUaWdlciBMYWtlIHN1cHBvcnRzIGRldmljZXMgd2hvc2UgaGFyZHdhcmUgSURzIGFy
ZSBjaGFuZ2VkIGZvcg0KPiA+ID4gPiB2YXJpb3VzIGRyaXZlcnMuIEhlbmNlLCBhZGQgdGhlIG5l
dyBoYXJkd2FyZSBJRHMuDQo+ID4gPiA+DQo+ID4gPiA+IFBhdGNoIDE6IEFkZCBUaWdlciBMYWtl
IHN1cHBvcnQgdG8gRFBURiBkcml2ZXIgUGF0Y2ggMjogQWRkIFRpZ2VyDQo+ID4gPiA+IExha2Ug
c3VwcG9ydCB0byBmYW4gZHJpdmVyIFBhdGNoIDM6IEFkZCBUaWdlciBMYWtlIHN1cHBvcnQgdG8N
Cj4gPiA+ID4gZGV2aWNlX3BtIFBhdGNoIDQ6IEFkZCBUaWdlciBMYWtlIHN1cHBvcnQgdG8gSW50
ZWwncyBISUQgZHJpdmVyDQo+ID4gPiA+IFBhdGNoIDU6IEFkZCBUaWdlciBMYWtlIHN1cHBvcnQg
dG8gdGhlcm1hbCBkcml2ZXINCj4gPiA+DQo+ID4gPiBJJ20gZ29pbmcgdG8gYXBwbHkgdGhlIHdo
b2xlIHNlcmllcyAoZm9yIDUuNikgaWYgbm9ib2R5IGhhcyBhbnkNCj4gPiA+IGlzc3VlcyB3aXRo
IHRoYXQuDQo+ID4gPg0KPiA+ID4gVGhhbmtzIQ0KPiA+DQo+ID4gVGhhbmsgeW91IFJhZmFlbCEN
Cj4gDQo+IFNvIGFwcGx5aW5nIGFzIDUuNiBtYXRlcmlhbCB3aXRoIHJld3JpdHRlbiBzdWJqZWN0
cyBhbmQgY2hhbmdlbG9ncyBhbmQgd2l0aA0KPiBwYXRjaGVzIFsyLzVdIGFuZCBbMy81XSBmb2xk
ZWQgdG9nZXRoZXIuDQo+IA0KPiBUaGFua3MhDQoNCk9rYXkgc291bmRzIGdvb2QuIFRoYW5rcyBS
YWZhZWwhDQo=
