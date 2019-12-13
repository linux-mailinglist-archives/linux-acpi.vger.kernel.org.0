Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEB2611E98D
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Dec 2019 18:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbfLMRzV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Dec 2019 12:55:21 -0500
Received: from mga07.intel.com ([134.134.136.100]:24893 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbfLMRzV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 13 Dec 2019 12:55:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2019 09:54:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,309,1571727600"; 
   d="scan'208";a="204390013"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga007.jf.intel.com with ESMTP; 13 Dec 2019 09:54:31 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 13 Dec 2019 09:54:30 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 13 Dec 2019 09:54:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVepaSUiGAWyixkjVzBVN/dj0XcHTckkFuBTxEKlg9m1uTBu6PJjoHwHU739DhHpqG0inBIpVnONdONTy0/m4jlU2ZElFOE3EEYaa7FA8PiLIBnZ9noiTvphsF7a2jg3ZrGfY0zk27BY0noCLjvOTCLbHuzKD+NBVEr/hM9h95uq7xHGLVSQDZl9x9QEeV9ctbc5KZoESEDbpu34L1sitctqhe9d2wtLd9bttP+kY+MTadsA86nQlTqSsKvfhVKMxoq5rJ1nPXRWjsJ9En1tJfQxZUtL9F3sY3TiueAOLngL4PRGasWDFa+CqyTidcbUCBcG6QDOogXyFixTFtX8lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRBI5ysTDWsAqUVVcT/cnzE0YTE/WAwGoUKeXHwkZpg=;
 b=OscPGciYHelZMPjLO9yq8ysn6Bz0tWhbXRsTWoMPLX9ZJQ71rHSgoJihzdqIelqHbKz0kQaYH+FQ+4vXIIXOI8AbbIGZN3SmegF/+fBuM8CapW4pRqzis90hT6y4F+i+cWPiDUkHU+Ok9pycdFSpozndqXJEpwZ9wXpiVn1RwC9vybp/aPzGWQsZ7drLDh4LFHtSIPduhjNHhXCdXgqOoyyjKSIXdqZoK16EClotAf2L4lClqKikHVb6tjO2ui0X97p5EoUgqaFVvLvSXWbgcy2JQ+lVo/C5ViBbES3nzYUYvsZPFJDR4BQZyGFO64ywq/Zdt91lW1PYt4b1WHNTxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRBI5ysTDWsAqUVVcT/cnzE0YTE/WAwGoUKeXHwkZpg=;
 b=J8K9mXOPG85W//pRyzktvdM9rDgpM25ne4SWVrIoLofsEe2tJrs7tnsU+Y946uw4+eEEjimi1eJpXHTfIi0pmBGv/5UhRIaLRguVmeUZtvga37admsmaETXAj5WTLe81i8wvu2oDa/aprxmwnFVXB2ErFd6Wd5WN86GD3TmQgq8=
Received: from DM5PR11MB1274.namprd11.prod.outlook.com (10.168.107.8) by
 DM5PR11MB1564.namprd11.prod.outlook.com (10.172.38.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Fri, 13 Dec 2019 17:54:08 +0000
Received: from DM5PR11MB1274.namprd11.prod.outlook.com
 ([fe80::fcfe:10a6:14c3:3463]) by DM5PR11MB1274.namprd11.prod.outlook.com
 ([fe80::fcfe:10a6:14c3:3463%7]) with mapi id 15.20.2516.018; Fri, 13 Dec 2019
 17:54:08 +0000
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
Subject: RE: [PATCH v1 1/4] acpi: dptf: Add new Tiger Lake hardware IDs to
 support DPTF drivers in acpi
Thread-Topic: [PATCH v1 1/4] acpi: dptf: Add new Tiger Lake hardware IDs to
 support DPTF drivers in acpi
Thread-Index: AQHVsT0SGPOaKKT22kSwDXF5cy2bSqe3zpeAgACKxYA=
Date:   Fri, 13 Dec 2019 17:54:07 +0000
Message-ID: <DM5PR11MB1274745919B8F1A51B60BE98F2540@DM5PR11MB1274.namprd11.prod.outlook.com>
References: <cover.1576189376.git.gayatri.kammela@intel.com>
 <baaa3d7d1d1129a31c5a000578d1ad8198ca3881.1576189376.git.gayatri.kammela@intel.com>
 <20191213093437.GO32742@smile.fi.intel.com>
In-Reply-To: <20191213093437.GO32742@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiODM3OGZiOTEtNTZjMy00MGI0LTk1OWQtZmRlNDE3ZmQ2YWYxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiaFlrbVRTSzlzdDhIZTBnU2J5V09vTjFqa2VYcVhMZ3pyT1wvNlFQXC9WelhKRlcwM1ZYcGkySm53ZEp2MHc5NTdBIn0=
dlp-version: 11.2.0.6
dlp-reaction: no-action
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gayatri.kammela@intel.com; 
x-originating-ip: [192.55.52.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e78f141b-cd66-42b2-822c-08d77ff573b2
x-ms-traffictypediagnostic: DM5PR11MB1564:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB156437421F6638D20EA48AC5F2540@DM5PR11MB1564.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0250B840C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(39860400002)(346002)(136003)(189003)(199004)(7416002)(5660300002)(86362001)(66556008)(478600001)(66476007)(2906002)(52536014)(4744005)(64756008)(54906003)(316002)(33656002)(6506007)(9686003)(8676002)(4326008)(6916009)(26005)(81166006)(55016002)(66446008)(7696005)(8936002)(76116006)(66946007)(71200400001)(186003)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR11MB1564;H:DM5PR11MB1274.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YZKDXu7kafUGYzSStK4JsA/h8NLazqGZFjGjNy5NeFcW3GEFWRkujYQJG4rYTxOIDgCSCU0JLqIU7eif1SYfFUw1q9xB5R4ZlMKgze10SfX/Q07sEzBWCjTDuOk07C7LJ1lowaaFAosuz5PfvNwKK1LynyGXNlIGMpD1Cp95uCb9CcPWMbZVrCYmr9v5Cx7nT2mu4MIqMkGv36lurch+RAZk/SLJS7kxm6VBO6h42SHgTesu8eqlMgJq4KyfTtltmFkimX8jDH9S2dXUTaDjcFvRBpG3IkyygKKiAEcIXuekwZAZhfGSYjYgW828I34j8PJcVEb/sR/vHmcURyEQ6+JfCyi9m2uD/XbPKMM7hXmU1S7wkNx/17vJEUiccXRGDPNxQ98qIarujZLdTA8uR0ynciBHOtYtl0c9L+f+Q/3xlXLoCsIf6vW0amqDZW0S
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e78f141b-cd66-42b2-822c-08d77ff573b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2019 17:54:07.9768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DwiaH48B8LpKmBwMbkS2MVLkGdBCHGKYIv0QpQaZDF86pLV19CbBE8VYNHIk9ckuULzW4C8sorNa4zGiakyBgmhMd3qec9AHUcY72ey46+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1564
X-OriginatorOrg: intel.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> On Thu, Dec 12, 2019 at 02:37:17PM -0800, Gayatri Kammela wrote:
> > Tiger Lake has new unique hardware IDs that are needed to support DPTF
> > drivers. Hence, add them.
>=20
> >  	{"INT3407", 0},
> > +	{"INT1047", 0},
>=20
> Can we keep them in sorted order?
Thanks Andy! I will keep them in sorted order for all the patches in the se=
ries in v2
>=20
> >  	{"INT3409"},
> >  	{"INT340A"},
> >  	{"INT340B"},
> > +	{"INT1040"},
> > +	{"INT1043"},
> > +	{"INT1044"},
> > +	{"INT1047"},
>=20
> Ditto.
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

