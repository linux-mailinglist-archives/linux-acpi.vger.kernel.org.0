Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE0E3121180
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2019 18:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfLPRPG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Dec 2019 12:15:06 -0500
Received: from mga06.intel.com ([134.134.136.31]:51957 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbfLPRPG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Dec 2019 12:15:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 09:15:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,322,1571727600"; 
   d="scan'208";a="266311934"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Dec 2019 09:15:05 -0800
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 16 Dec 2019 09:15:05 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX154.amr.corp.intel.com (10.18.116.70) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 16 Dec 2019 09:15:04 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 16 Dec 2019 09:15:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=moUZh/B2DKfc5aOyihVBkPhhCR0M4Ra+tSP2+ahOUvuOepa514qtesSHlhKgpdd+IiRKkns93l9yTUAGKP+i/zzkF+26HLCRAvpmkWTO8pXmHGrZiDV6v3Quzgo4zcleesNXCWdUseOfIedBsBD1cLXXWH4e9JiTO8NiRe7B+kHJ2jM1JifU+t3+4nLCCpHcHmuWFDosZb+oY6yeWBJL/e81gxgCCN6+/yHBw7QDm1SvwyFFMlb9Yha5F/guLXAelDfQ/v6vQfaneJ6MqqEDlY9VZxpmZ9PwC4H5Dr9DrFqN1odS4U7yCeSAVaceQQU2Y652IQgiWKwglKNcgLjmWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hidp3rroC62o1+GEjxg+g5E1Pvw/JljO+ZWzBIV4qXU=;
 b=XVDqKBp642XElc01kgwYRNPNZg8TJyKmPcOWhE0a92go/4nh7AJTgqMDcQdkElDDvercTzOsA58lgwD2Db0nKbh7CllEbSXyjTiPuEyvpZ27SBfe+/IF6erihhMPY6YyFWt9LY6C8BVS/7coFvfnDmVVldgsU3nkvSQrKOZAh7Cm2/tsfvIt1NI5J3qPsIxoMeigju4WeHi7ZoXX5TXI/MBrzNPCRGRtNhGdC6q/dGierK52Ju80J4eAb5fLauBQw9G28KZdFIHi9mrTEb2NEJb5H1l734d/fdta9Nnyrdt483RQqwccVfEioHzU7s9Dwzg0II8VPD53r1L9iioXag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hidp3rroC62o1+GEjxg+g5E1Pvw/JljO+ZWzBIV4qXU=;
 b=V4tpLqbDk9w4ELHgiS/aC5jS9CtBqbFRKv7ZD7OmZgurd2dV/I34hte4631PrlbCRM8cTVyneLJDa5HG5et2x7RjTk3fOHDdKQ3kYbt12j8JShlvCfJko6+Vz7x1adRZAOSX9nu2VY4VEcliMhtcgpINgfxyAV72+smmPZaqE6U=
Received: from MWHPR11MB1278.namprd11.prod.outlook.com (10.169.230.151) by
 MWHPR11MB1757.namprd11.prod.outlook.com (10.175.50.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Mon, 16 Dec 2019 17:15:01 +0000
Received: from MWHPR11MB1278.namprd11.prod.outlook.com
 ([fe80::707d:8cdb:8345:664e]) by MWHPR11MB1278.namprd11.prod.outlook.com
 ([fe80::707d:8cdb:8345:664e%4]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 17:15:01 +0000
From:   "Kammela, Gayatri" <gayatri.kammela@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "alex.hung@canonical.com" <alex.hung@canonical.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "Prestopine, Charles D" <charles.d.prestopine@intel.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: RE: [PATCH v2 3/4] platform/x86: intel-hid: Add new Tiger Lake
 hardware ID to support HID driver
Thread-Topic: [PATCH v2 3/4] platform/x86: intel-hid: Add new Tiger Lake
 hardware ID to support HID driver
Thread-Index: AQHVseGHq+zrIytRcUCV9+Gk16TRT6e8sKUAgABT3IA=
Date:   Mon, 16 Dec 2019 17:15:00 +0000
Message-ID: <MWHPR11MB1278DF04E0B8EB516DD64650F2510@MWHPR11MB1278.namprd11.prod.outlook.com>
References: <cover.1576260216.git.gayatri.kammela@intel.com>
 <a70a856e9a87c89ba92da514c1dda1f46f10b0de.1576260216.git.gayatri.kammela@intel.com>
 <20191216121320.GQ32742@smile.fi.intel.com>
In-Reply-To: <20191216121320.GQ32742@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzE1ZTBiOTEtMDM4Ni00MGI1LTk4YjItNTRhOTRkNzY5NThjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiakYyVHZuU3hrdElPb3Z4RHhHNVFESnQxK1NzOWFtalwvQjNoMDE3SDFxYmZwQ1pVazhBZzZDeGdEUXdtdzcrN0EifQ==
dlp-version: 11.2.0.6
dlp-reaction: no-action
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gayatri.kammela@intel.com; 
x-originating-ip: [192.55.52.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfac8efd-96d3-4cfa-77d9-08d7824b7c08
x-ms-traffictypediagnostic: MWHPR11MB1757:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB17576498FA7302ED809C634EF2510@MWHPR11MB1757.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(189003)(199004)(66446008)(64756008)(66556008)(66946007)(76116006)(5660300002)(66476007)(71200400001)(52536014)(498600001)(186003)(33656002)(86362001)(9686003)(8936002)(7696005)(81156014)(81166006)(2906002)(6506007)(7416002)(55016002)(8676002)(54906003)(4326008)(6916009)(26005)(558084003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR11MB1757;H:MWHPR11MB1278.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7tZgULeZD2e+7vb0/h1jDBewrghXKde7fQFOsBgsfENebFBVNqqzj4YH4T3fTKBiLfTtrDkr2q74vHqSvBvLOW0tZ3lNLAvcBRFRLl7d3ljsi34qF9+UY0DaTa7wwEDd7MjEdly2oigowhqiAN69JdP9YxCsBcHkJx6wFMP+9e+uYVY9g/p0d+xtqKyRiwl3YbTLBBom2uYZRe6MGk4d7D+cW9pJc3AGWpBZnGR+Dx/jDJaOG0EsGLggJ/QXtu3D3eZ6fd3qNrTTqOB+SY5+Q23w17kRtuO9OkN98coJU2vkXou2zjjGZwKU5nUNJLxYqDqdhukB07u6LaO5jviWAIoHpJygvUSLjacaEwTbraB78fjln3TPkS6UfUWgyonaooQ0xuPyo1t+M6u45Vk2pKj98/M1TKysfEa1GwRtYdLw6YASO0TMLs1eEDrckaOw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dfac8efd-96d3-4cfa-77d9-08d7824b7c08
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 17:15:00.9383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wSOH2YCH5vhWloMYjKufOhgiV71XyBOLcKjuCOuZzMJnFovsTlc4g08W9LJpWeJDzgDNP9lzLZFNoEa3usVJsZUMqeNcUgvbF9TMkC2XlU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1757
X-OriginatorOrg: intel.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


> On Fri, Dec 13, 2019 at 10:14:22AM -0800, Gayatri Kammela wrote:
> > Tiger Lake has a new unique hardware ID to support Intel's HID event
> > filter driver. Hence, add it.
> >
>=20
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Thanks Andy!
