Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE2334AA9C
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Mar 2021 15:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhCZO50 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Mar 2021 10:57:26 -0400
Received: from mga03.intel.com ([134.134.136.65]:7128 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhCZO4w (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 26 Mar 2021 10:56:52 -0400
IronPort-SDR: 5REz2iZ/h0lXwkIRM1fEWfTrlBdNZtjgMmJ9hlOF+fOUXUmJLj3NqHkzAZ3Zbtls5XRmVhOVMr
 n5T74u8JlaNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="191190251"
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; 
   d="scan'208";a="191190251"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 07:56:51 -0700
IronPort-SDR: S5U1sDc4mzmYiGP69Xeeg44JeAG8I+otPjDlDdCwlcZJQKyVc2gUEXbsrA4UwNe/RuDJmvXxN9
 i/C2T7ZMF1BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; 
   d="scan'208";a="443368410"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga002.fm.intel.com with ESMTP; 26 Mar 2021 07:56:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 26 Mar 2021 07:56:51 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 26 Mar 2021 07:56:50 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 26 Mar 2021 07:56:50 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 26 Mar 2021 07:56:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4L8tKev/Y/elnHAXke3wO33MP5lxKgJZaEEcCmu6Houy9wzDzAxUgeUohPuNI2ujixA1d+qsBMxdlKBTx/+tkOAieVwWJbpWRN5rTBq0v/iFjxVSw/8Tm6F0RTgV80wLfbqZXAE1jnVLNdYfWhI/1HvtRc2p9jW0fMn4+UQJNHQ9mfsfSllMu8vFHgrpwdyTh8GwP+DTohhrfhUokehzDKwjzGeuY3FmSUYT3wbjji7yHHsJvQGrr7bOmX4RSAYDFv/KVU/jvYzKpVkXkgX4NYMw3VPIqkM48M61KbY2ZbQBAiwdKRi3na27BSvgCwq7J5r+EfmhhENUNHj9+vWOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B52owGdVTwA3OI1VL3WGYFLxZ2KAyIu5O9I9+UvzAvw=;
 b=g85venkANngbew8Gc+H+Bk4Dc58GUwxTZ0+7I5xMYmrSDb3A/Kf/U/X6dsz1NFn5DJTMT5R9v6p2JzOi6ds7uczr+2KKboab2WY7VicAMkhh8b9jQU2mATXv3idMOwtdss2CDMcM+NkS26Zf3LrWXdOe3y5Og+ERl58MFqRk8cr62BHUm0etU0r6VsnHWozRtzRtA9fX09WFSauLfExZkA4rQ8zKNa3jc9qVYj+uz2HXcyD3k8eIhJyDB2j2qY2RiPKf6yi6HAqUR3vANPovQAH9sg+mmKwFmgMIg/pnCr5ySO++oh/xNaG2EbpjJh9cll9Y1IqHviwaBjcxDbUZug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B52owGdVTwA3OI1VL3WGYFLxZ2KAyIu5O9I9+UvzAvw=;
 b=sp9tquqO5Yv5BCS8MxUCy4mZXTTdBSuZ4GwIhMr9kV+3odBJrN9gDeKDKLO7IlqKty0fmrithE7wNKxPueBsTxa0LoiZC2diNvpJskI1b2Ca4IJ3d+0aDxLfauMAKmkH71TovNa264YaFBgOC7V+NjhMNyJqEldwadtGrQTU1aY=
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by SJ0PR11MB5088.namprd11.prod.outlook.com (2603:10b6:a03:2df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Fri, 26 Mar
 2021 14:56:46 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::41e6:b61:67ef:2712]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::41e6:b61:67ef:2712%5]) with mapi id 15.20.3977.026; Fri, 26 Mar 2021
 14:56:46 +0000
From:   "Moore, Robert" <robert.moore@intel.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "rdunlap@infradead.org" <rdunlap@infradead.org>
Subject: RE: [PATCH] ACPICA: Fix a typo
Thread-Topic: [PATCH] ACPICA: Fix a typo
Thread-Index: AQHXIdYAvaU+6E62m0uLz/0U3uuRwKqWXKbQ
Date:   Fri, 26 Mar 2021 14:56:46 +0000
Message-ID: <BYAPR11MB325648858A1C06D2E80DF7AE87619@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <20210326001922.4767-1-unixbhaskar@gmail.com>
In-Reply-To: <20210326001922.4767-1-unixbhaskar@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3267f63-a941-416d-52e5-08d8f0676092
x-ms-traffictypediagnostic: SJ0PR11MB5088:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB5088F5B92C8AB866871CA3EA87619@SJ0PR11MB5088.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QRpLQTSmf8y9jKdVJp1RfX9xoP9feyJxyRA34j+ZBgy4BthCYAW7DbY9ST7xEqJAdIKBLURU5FekRvX+c6qhgsdxBDwCprkimYmHhZ8F61nT9aU7BKx+6kuN0p8iUtXDdbe07JxHlUCyo0nCWBXjLW1tNjHFU3QxxqSTQ1/Kzsno7wBS0QiZ8Ry7rvkAnaAPzYnZYQKrrsSr1RVlw/+JPWvPSZjBJZOg2IuaBVNWlBpIlkEX3cPgoRdYKVIJMnLLZVkF3nd81chrYWZaWaWmTCNaXkS5rfB01cXgN23MGABogW9nWMlZDOtoHH7g62MazorBl7Y3Uw0sBYQU/fkstpvDnowTkXSvdAIpr2eC70HG5S+xvSfNEI90O2aLdKk8rkarE7rYG+JKSCWjfxJrYLxFvbk0eJZVzm9MyX8Wj8wdNAQycgWKD0WaZ5lcKOjv9J+dpjF5HUvQ686x+DP3upA8aIEb7ck3G33oSiEmgVFlGszVTN2Z6IoZAbQaoDmjvaC2pue0khE7NZpXNCPMjyzZAKB0xgpCwHlEIdpKnsbVVFvsS2z6xer/mvFQboBb0chTRgKutrE756FNEGX0wQL4roKFgwYgwz8NsjxNOJ9dhxdtReljGE7h/by3Ca8jFMS9uLhqHawGUmWHExYUNQbBD9htaz7KeVLFZO7Op9A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(376002)(346002)(366004)(136003)(38100700001)(66946007)(66476007)(66556008)(64756008)(4744005)(33656002)(66446008)(52536014)(5660300002)(83380400001)(76116006)(316002)(4326008)(110136005)(53546011)(6506007)(7696005)(26005)(71200400001)(86362001)(8936002)(55016002)(2906002)(186003)(9686003)(478600001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?h84ksmg9csiTiDtK9OdSGwxPIykQNjnvsKZOPnxtCvQ7mGJdwp/clDnwiylq?=
 =?us-ascii?Q?pdeJLUxqyljcEB3uan8HtXGb3WXbpXfAEGMCUY4guIfgN1wKmX3H4r8/2Q4M?=
 =?us-ascii?Q?7O8ckbwi3agTIxpJ0Qb+aOKbM+5/qL+t0+8mVDaggTUZO6ZEGg0aRgoOExDh?=
 =?us-ascii?Q?lyEKP/9MTA1nPdGiLqEhYjl4w72kR4BDio7xgr4ktGrznFzgpmD3kw1Fz8jv?=
 =?us-ascii?Q?7V2vT/vVTGKZmFQwWx4mut3UBg8wikvZvX9T6189vF94x+Enfkcgb4ZBowhe?=
 =?us-ascii?Q?DrLfIUvYKRvXSYbKG69zfgOCiwwP3ZsmrvKeyNOBRvBaXgNtxXaaPbGU/tZl?=
 =?us-ascii?Q?aHJLBFBZHI5mpk94ANLuCVIkhX24QtrPlvey7KPeoYstQ1eUxRIZrGaFOq4H?=
 =?us-ascii?Q?z/WK+kevSNIQRT534t/bMJSAPlhklNNPIBNMbBL11HS7t6ME0vSzZqwIUCVz?=
 =?us-ascii?Q?nH/BNrDfYIR+f7txU6OxrYn1ROQoM2dkYdiQUJoa8r0iCO75BsXzcc3a0NsS?=
 =?us-ascii?Q?1Wa9BQgvqHI8zV0URCoi7lXxkqs+iNPfiKiYKjlrFH+C11qsQc4DGjH3GejA?=
 =?us-ascii?Q?N694fSHREzspa5SvEB1shJZvQgZQDYtlNaOgg0WGLhYDZf1Y9kBJsO8iDdi6?=
 =?us-ascii?Q?g/cYrbmoggEYL+OYcvFzeSG0ONUSV9c7n/AeiOt4C6WrYHed2+UKa1SQ68Ea?=
 =?us-ascii?Q?73riXosf0X/8HoPaIH77zdSuxt7mm0pOwE/wmFASPUSCHR6dvarPePPhJQI6?=
 =?us-ascii?Q?WLcPkLWWmIQpyPJHamuz/T30lZ6Ban8RA5lXdTx/cHt9xJ96ZgDqql+KxnDA?=
 =?us-ascii?Q?uf7q4O9RXPxOZxVcDswZPndOQL5MftDv/fpMzOiKapfnuu871Fx6lnlqR9rG?=
 =?us-ascii?Q?Pv8OOIGPz5kX9xeSGWz0uyMuB4duhVE4xhLD5fS6Irq1GCy/ztlu9w3NZuNw?=
 =?us-ascii?Q?zI+QvkhpZMB6ogDL/YTxE9Dce3MXLo7eFxK09FpW3BQtXfYyL7/aFyy4zTSV?=
 =?us-ascii?Q?ZwX0GeJ3/VEiz1telHs6vJWzz6qrnESKvlUcjSl30TNW5fvoHlFsGce9YJMY?=
 =?us-ascii?Q?Rw2mDYXVSBV9YbKcHLGv4Dnjqj1y6g36TsTuTc5EwOZFnemDZ3ZSNIgIBFjU?=
 =?us-ascii?Q?rGhbDrgMkG0y6lko61nHu8S2sK1ImXYZ24R/TOvgkiFux6mDpUviwEOQtnxQ?=
 =?us-ascii?Q?ed7wFKn+yfSrc6TccceFPNEhV+506f0imRUk5kRnZqUGuqyLX98UOWQex4oX?=
 =?us-ascii?Q?ZNFnFf/AOyjeUF01+oe6pXY2y1X2IJ3TJmCda3nRZJ8jpQ7FK3HLSoIcEAhf?=
 =?us-ascii?Q?emAG5+TBrDhRKy7eAczoOdx2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3267f63-a941-416d-52e5-08d8f0676092
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2021 14:56:46.4275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xoq77myK53nUiP0Ub/e2JayMa/RJBThaY1K1ubS8hq3oQjdkT+h6e6isMBVVZYNDby/fNkjN7zDcLalCLSBtdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5088
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Please make a pull request for this on our github.
Thanks,
Bob


-----Original Message-----
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>=20
Sent: Thursday, March 25, 2021 5:19 PM
To: Moore, Robert <robert.moore@intel.com>; Kaneda, Erik <erik.kaneda@intel=
.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>; lenb@kernel.org; lin=
ux-acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.org
Cc: rdunlap@infradead.org; Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] ACPICA: Fix a typo


s/optimzation/optimization/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 include/acpi/acoutput.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h index 1538a6=
853822..1b4c45815695 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -362,7 +362,7 @@
  *
  * A less-safe version of the macros is provided for optional use if the
  * compiler uses excessive CPU stack (for example, this may happen in the
- * debug case if code optimzation is disabled.)
+ * debug case if code optimization is disabled.)
  */

 /* Exit trace helper macro */
--
2.26.2

