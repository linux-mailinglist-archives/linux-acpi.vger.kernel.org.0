Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03C9B121184
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2019 18:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfLPRPf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Dec 2019 12:15:35 -0500
Received: from mga03.intel.com ([134.134.136.65]:48079 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfLPRPf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Dec 2019 12:15:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 09:15:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,322,1571727600"; 
   d="scan'208";a="266312083"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Dec 2019 09:15:33 -0800
Received: from fmsmsx102.amr.corp.intel.com (10.18.124.200) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 16 Dec 2019 09:15:33 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX102.amr.corp.intel.com (10.18.124.200) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 16 Dec 2019 09:15:32 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 16 Dec 2019 09:15:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCWDNQ4D6mM9NmJ4jroAL/Rquiz+Fr8f1mnNPw/f5v0rpAhBpQihNY0G7i/xRR6rXRzXqrghIcljtXR1pIPrRXgYXdiawqVhacbIWIQtUvHZ/hJzg04s5MkrCXbEfGaTbwpiOqNmXBhCjVU2eo+Cc0jyKopsjsGP4sENBSXpB5ZvtqacQTkKH6KejMRBV+3BDxIWJLp/NIF3i8ITnKbqjCCtO4QJIp8hRkL8tGFAqkOMY9bWmuBgR6FGZmE3mHzjEI9e4eB3EVynYcQYTyevCyh9vrIzEFY3iEi36KL2BEjaS+hAOLQ32VjnBafRXGEUh2tqYisyy0P9DlSqpPCpLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFQvHEq0B+LjPmcIU/cQyu9NAa753mkm2kUcuNx24a8=;
 b=IDHN1gN6mHKsPha81j9ac1UzXbwDUTNqKHdKlG8IdUvV4Czx1+lvNesQqLRceQMA5Fpb7M6YgdlbAmSKac5yFhCQrx8TeMB1hK9TPAq53eXy8kogzF+eBSavrGgzthO/jzg5oO7yeopshMCSv4t6WQLWVn5kRvHlTPQwISsP+MeLK/cDDAOk625ieT20Jw5h9/KQpv667YeIofKFtovpZEqhDcD0wvgAAqhp1ha/F3HuwkN4+y33btJXWQsDqHz5UmRSWBRUzu+ScukB2JkdRlJWGFimFfUIq8OYoSYHbmPqq33907n62Y9RgDZWelYzVEwRsU9ElkmAm1EJxRo4jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFQvHEq0B+LjPmcIU/cQyu9NAa753mkm2kUcuNx24a8=;
 b=XuNkupx9I19dwi8UnW6EfazA6F7iIJAsi2DVGiAiT7jX8YkQuGhcIq54eXtFHqmq8SomNPqLddGyCVNB/mcaUuCX8h523mM9a41NzOSYQ7z3MgC+HGlOvawELJ/TBnSM99f8mF5d+m4EfIW8TFjrQv/QZ34vWKfeFKcVbKCGWfE=
Received: from MWHPR11MB1278.namprd11.prod.outlook.com (10.169.230.151) by
 MWHPR11MB1566.namprd11.prod.outlook.com (10.172.56.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Mon, 16 Dec 2019 17:15:31 +0000
Received: from MWHPR11MB1278.namprd11.prod.outlook.com
 ([fe80::707d:8cdb:8345:664e]) by MWHPR11MB1278.namprd11.prod.outlook.com
 ([fe80::707d:8cdb:8345:664e%4]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 17:15:30 +0000
From:   "Kammela, Gayatri" <gayatri.kammela@intel.com>
To:     "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "Prestopine, Charles D" <charles.d.prestopine@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "alex.hung@canonical.com" <alex.hung@canonical.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
Subject: RE: [PATCH v2 4/4] thermal: int340x_thermal: Add new Tiger Lake
 hardware IDs to support thermal driver
Thread-Topic: [PATCH v2 4/4] thermal: int340x_thermal: Add new Tiger Lake
 hardware IDs to support thermal driver
Thread-Index: AQHVseGLKMeMKZlivUi5LK2P7xCLTae9AmWAgAACjWA=
Date:   Mon, 16 Dec 2019 17:15:30 +0000
Message-ID: <MWHPR11MB12785D0329786CC2E1D2564FF2510@MWHPR11MB1278.namprd11.prod.outlook.com>
References: <cover.1576260216.git.gayatri.kammela@intel.com>
         <8964445c268f61beb8fbaa3f54b469ddd7f8cafa.1576260216.git.gayatri.kammela@intel.com>
 <752244e73e3703b6d20da3ab870e4e86f9e4a3fb.camel@intel.com>
In-Reply-To: <752244e73e3703b6d20da3ab870e4e86f9e4a3fb.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjRmOTRmZmYtMmExZC00YzZlLWJjY2EtYjczNTExNjc1NTk2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidThmNmFLd1FtRjNhbW16SHVcL2ZYdmpqUXpXbEpmWmNcL1dsV1NXc3o5bVN4cmk3VURweWhZdG1JdDdqbThmNm9TIn0=
dlp-version: 11.2.0.6
dlp-reaction: no-action
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gayatri.kammela@intel.com; 
x-originating-ip: [192.55.52.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 588948d7-e4c8-4f71-403e-08d7824b8dd4
x-ms-traffictypediagnostic: MWHPR11MB1566:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB15661FC15E5EE91CF7802108F2510@MWHPR11MB1566.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:669;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(346002)(376002)(136003)(199004)(189003)(54906003)(4326008)(7696005)(110136005)(55016002)(4744005)(86362001)(66446008)(66556008)(66476007)(71200400001)(81166006)(26005)(6506007)(9686003)(76116006)(316002)(5660300002)(7416002)(478600001)(186003)(66946007)(33656002)(64756008)(8936002)(8676002)(52536014)(4001150100001)(2906002)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR11MB1566;H:MWHPR11MB1278.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xAnyVysZt7FHw+SaLhThducqIq/hTmF0khQTChZT7+BmlVPUKVGAebrrC5Houqn9H2OyMI/XK+q3xyH2lgvGHq4fX/e5koAj1okMyPWMhvSzvbMD9cxF8bCzI3pZToMS3IWDlsCtSFRmnBI9nXY7W12QWMFyi5NQPhlJWDEk8XVpFM4E/optE74hLN4Axj+DLzQFfZ0+QXTxEbR0b2UeWrOJxgF88XtOUhguE3vlPONwHgU8QSH8P4PegXRuN6T9SuAVL1WXMRk6GCzy8H81UChBtPTTNIiscCsbROeWeoqyBVhi0wok8ZQWXwiZiXzfkeRAACbimugdYd6FrDL2g00YoRno82A9Eu4W1yyR995EY3Uc4wsTUQeAsazH+KH11ckSWZin7IlJEAEYQskl5DMyW+dcrBAd7DYFBO1DKR9YVH1VPU88PQP7M7C69mNV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 588948d7-e4c8-4f71-403e-08d7824b8dd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 17:15:30.7831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1sYKW0W5KQluY/l5jC22rmEoQz1i5UcrsaqEPpSpnvFZePKE4ijKAF4Fgz3HNZTCjhU3GeMHCfNsOzky3/k46hUVUHVsEBIFqKQX91kCC28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1566
X-OriginatorOrg: intel.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

PiBPbiBGcmksIDIwMTktMTItMTMgYXQgMTA6MTQgLTA4MDAsIEdheWF0cmkgS2FtbWVsYSB3cm90
ZToNCj4gPiBUaWdlciBMYWtlIGhhcyBhIG5ldyB1bmlxdWUgaGFyZHdhcmUgSURzIHRvIHN1cHBv
cnQgdGhlcm1hbCBkcml2ZXIuDQo+ID4gSGVuY2UsIGFkZCB0aGVtLg0KPiA+DQo+ID4gQ2M6IEFu
ZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPg0KPiA+IENj
OiBaaGFuZyBydWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+DQo+ID4gQ2M6IFNyaW5pdmFzIFBhbmRy
dXZhZGEgPHNyaW5pdmFzLnBhbmRydXZhZGFAaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEdheWF0cmkgS2FtbWVsYSA8Z2F5YXRyaS5rYW1tZWxhQGludGVsLmNvbT4NCj4gUmV2aWV3ZWQt
Ynk6IFBhbmRydXZhZGEsIFNyaW5pdmFzIDxzcmluaXZhcy5wYW5kcnV2YWRhQGludGVsLmNvbT4N
ClRoYW5rcyBTcmluaXZhcyENCg==
