Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F94E37AE46
	for <lists+linux-acpi@lfdr.de>; Tue, 11 May 2021 20:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbhEKSV2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 May 2021 14:21:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:65002 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231462AbhEKSV1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 May 2021 14:21:27 -0400
IronPort-SDR: cx9CPgVGjpcKmcZ5nR540jhLtdscY63I/BPUhuWxr2386S31bGBWpKcjtl32J9IOdAzWAYR0kX
 55FhJ5BIyYxw==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="197533684"
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="197533684"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 11:20:18 -0700
IronPort-SDR: sNoJ44FPwDqH0PrROnGFEGDjMA3oXGcZLdZM0u6m/aOVGlvRTsyf6TQQgfl4lV99m1S0px08c4
 wEjrxanfJPNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="434716089"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga008.fm.intel.com with ESMTP; 11 May 2021 11:20:18 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 11 May 2021 11:20:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 11 May 2021 11:20:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 11 May 2021 11:20:17 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 11 May 2021 11:20:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRbldM6akF8rGWO9N5nJwSAosu931i0N0H0EQwqUA+LnFl7qL89fVwIoJSLAUraxtaxaQX1jperpw7KwNWi2WdYt5U9z4bM+8SNv6l8SW/qiKCZ8pu6IPH2r4lv6LTGRzQDo+x92iZ6WvF9WEs+ocfTM4eoSGxfaxvNB6mCK6SSnOliRI//k3jNpbHHtq3X0/tO1XRg57VM3aGTfMu7ChJK+ibnUU2oRcXI+AZl/RmnY1cU9HmOWnfSWgzYQeGxuo5Dcx2WLSrjZhCvAytOPAYPaNj10xXzloWi0OgRG/UFxQGrm41AIXsNz0hmrkVwcEA0sHd/D83H5k+RbauhDeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhOLvQXiHHz/ECoS+f4AqPZ01QkeqdDb4z3y2pQmKA4=;
 b=ckvi2TskyF9+RYmW/WyFZCaw/mmP1II2pvR1syrvEXFu/5k8YCYQ9MzcdV5Tfqs0doUCGKKCF+auMUt3O2/L13ulznOmvsipnWfK7s0BbWOZFqyI7qKscm2bTOKG21o93bzxqM1WKP+QgTzu+PMUC5zlUgg7/vvqozFu08mb63NJXvLKoK8WfsbNpd7GrfdUsLK/LQg+MWoOQHuHzpmG0/ozs+EJGAAUA2+B4BwTui1UTLU4OP2iIcS/qOiClMNyiE0jrO+tHlsiTNKmdzZNB+6BjqfqY54nvXHCHvea6bLhaYbLPW9JgZicAt2HULSD1sQPK/s5tj5oiktaSCnKRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhOLvQXiHHz/ECoS+f4AqPZ01QkeqdDb4z3y2pQmKA4=;
 b=oP2/Iu049xvOmn8qbKyhin328oGZKT+xpZMKa24XQCztsSDORb1ofXuqJz8T3dfYgTwW81l/NQpfQF0Rx4K/5tRjbLvE7vFnaxcf4R+RLsOSAqscXgPWWS8Ra2lAKa0o/dQtk2dUkTE1Vsmx8EKyyzV5EWOXxazpemT4oafQi+U=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by CO1PR11MB5057.namprd11.prod.outlook.com (2603:10b6:303:6c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Tue, 11 May
 2021 18:20:16 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::48df:6af5:afe:ea7e]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::48df:6af5:afe:ea7e%7]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 18:20:16 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     Wei Ming Chen <jj251510319013@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: RE: [PATCH] ACPICA: Use fallthrough pseudo-keyword
Thread-Topic: [PATCH] ACPICA: Use fallthrough pseudo-keyword
Thread-Index: AQHXQnZJJRYKSXe4kUW+3iw540Yyuqreny+g
Date:   Tue, 11 May 2021 18:20:16 +0000
Message-ID: <MWHPR11MB1599BD99469D7F2157A4C27FF0539@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <20210506124912.7725-1-jj251510319013@gmail.com>
In-Reply-To: <20210506124912.7725-1-jj251510319013@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [2600:6c55:4c7f:e63f:1d7d:df99:244d:2776]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46fb13b1-07d6-4856-316b-08d914a96d10
x-ms-traffictypediagnostic: CO1PR11MB5057:
x-microsoft-antispam-prvs: <CO1PR11MB5057562C010D32E4386A9340F0539@CO1PR11MB5057.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:478;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2kp6+xuAj/9voBTKZxH/KjZAeZKSvtRtK85Qe2leAxT/fUhqEAJeCxJi6wIqxRK3QXJmSjw+dJEs0hg6zNW7i9yjGtz4L1dRr+0+q0u1pUue6KK3xTNzj/jTgTuKO9cyl+w7I+K0hxHUzR+EOWQkE0bpMJmATil7Rb8jxiBsxGmU4PIGfX6O7VTHktnVXNQWV6NfPaJihiC9pJY1oFwiNSebRmdn2nJ/2hwVehFOWkG5wJH6kZtaieo5DaUC+6Mm69tznRZQNcn/90KFNzyoqJhtJoGP4kvv1BZNMu6xj0IN9bGWHfaUyYGnelIfdKn3e7XGRXvc4yU6axlsoCQxeq3VQo904r5oievgrw9q31vdXq5a9cOvIpXf02u3IkzAjpDUmCWIWNFvJs+6IAbAsNAL13iT5ewX3NPWUaK5K3Jy43WO4Eh6WbYy9BfNtCAQSI//30t0rgnmLLUogB7EiSxtz+IXGb2fU9r5rEZsMuyQhMP3MQejQtlavUV63yGGKeGShXlzPo2f1sb4BiQrrJHjLq16c+guozgBtgxa+x21U2B2SEZnz63DM0wM1m5VpV9b4z939qoqlMBwdh+29jyWsuGw1pVIj/PDhu4yzzEt00aTVDn2232OyUlh6XYrCIHG+R1zjSc3KR9uWOWrkwxgIbWDHfY/8jHEWocgSZXQJcaLF4+lQ1s80Mk56rwoa9VX1hhfqKTkUfRPxj1lyWG7mjeEyWumnsoo+fdVOYS4SJxmeiuX4r4wn7HEvmCt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(396003)(376002)(366004)(7696005)(186003)(966005)(53546011)(38100700002)(5660300002)(83380400001)(6506007)(86362001)(54906003)(478600001)(8936002)(66446008)(33656002)(66476007)(66556008)(71200400001)(122000001)(2906002)(55016002)(66946007)(64756008)(316002)(8676002)(76116006)(52536014)(9686003)(4326008)(110136005)(14701465002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?HIG+eAOBJOTzQJ8lRB1qkn+OR95Vu3MRN8AXVGnkCxjNVdJu6bG2pywdr2Zu?=
 =?us-ascii?Q?gc4bA63h8rKlkONUhneU2VGKPJ3kxHrAQEyJbDbGVInPMdVh8pkGoW++ZS4B?=
 =?us-ascii?Q?M5CtehWfqTA43RuDRkFw7aUCzqnv8hu+2nc4alMH/wmLdxDaIv0ixsWcVpl4?=
 =?us-ascii?Q?kX4nH3KalNreL0TnWyfcYFN0iedHrjonQzKr3Jdh4wnOJpRqUnI2M9N+1DFh?=
 =?us-ascii?Q?RrHulLdsRGZv8ze8nCo/TwGFaNvI446f0Qjq5jWYw1WTGY1wrfXkqnn6Rcqd?=
 =?us-ascii?Q?y6a9LLafyZwLZ68gVGUBN6Nnfh6k4IllRPGAJo5GEpPAOge+riF+a4fu5pX8?=
 =?us-ascii?Q?1n6OWamjgbT6FRtQlFuG1qB+OTntqP4ZNv0laebPFduYv+KVZZk1T3j+38CI?=
 =?us-ascii?Q?8YKCDhi4zA8MaZH5G6xfjGz8dy1DrhEQ8DPjFaEvERQA9BPb594JsfjnvZD4?=
 =?us-ascii?Q?KCT8MOgmhQnUZ5B2FMPebscymXRE7VtUrQ1Rxnd+F5DtlYuiz3imJJF9GUB1?=
 =?us-ascii?Q?6i+1QEeAOXIQ2qD/cajkr48MBQwjD3WfkTnO2231x5SYCpr/VfwDMB9CVgky?=
 =?us-ascii?Q?KsdL5KXX04+Jhf3x8A1+eZ47SZ7pHteMQfv1bVac/aW5tC229ash/7wuvQgT?=
 =?us-ascii?Q?sjkAsahXUsuu6N9JQFHZoySTmOfIm6F5BZUzIft+NaN7yjPt6/pn0ZDm3gTY?=
 =?us-ascii?Q?7D9nx+F2pLUmQzShRjht4e0IdABcGc5mlnNaUpjM/yPc1C/y/BkmUMDsIQ8N?=
 =?us-ascii?Q?ZM/ZUMFmkKO7jPKRExiUzCR0OblIj1E/0gUG871XE4ADODOuhLVhF9xWBdFQ?=
 =?us-ascii?Q?ux50PHWWVSMFRoYEgtu8Fzydyw1cYXPGSSlMbH01Ve7CydiKMe2SeFwCBBUZ?=
 =?us-ascii?Q?deJNAwCjkQR/5ItHtyE99mfF96ZSph7BytE2kVwx9kX99sIWhDHpCYGqp30b?=
 =?us-ascii?Q?5Pdykc2Xow26bQfz6VqPPzRErqEBRC6GEOve52Atx4ZvZzSn8+4Nof3k0LLs?=
 =?us-ascii?Q?/PBMGa5EW0PnWyEDWJfoCGsilTe7hHNtADJoeDw0gSrpxyeInChQTpc6adSE?=
 =?us-ascii?Q?ON8EsNbjzxj4KG9Y9B3r/n23Xr3XTD45833ganhDeaX+8P0qFtDav7NXquNn?=
 =?us-ascii?Q?XqVjGR+F8eG5mvXNpTP81xP0/eKyOg3DKN+MSz7z2Bq3409szGSSWK05cp52?=
 =?us-ascii?Q?+Ut7oZ9wlsPwfKgqfNUP0IDcGp8qjU9KviSJFkLIePw40hbTWk7MaDGMP3sZ?=
 =?us-ascii?Q?bsQpRtBoPkCKCiu2aIMXba9hpAe98mVyf4VbIE5W46Ljtn76t8B1+ykMXMD0?=
 =?us-ascii?Q?TPFt856YaQSjhWCrNKIU7htEfoVIo8x6lZQnXsp1enEIwT8MNZBVCKeYNmjm?=
 =?us-ascii?Q?LlmCVdJ1fjSAdin+J7CD8XWkWELr?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46fb13b1-07d6-4856-316b-08d914a96d10
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 18:20:16.0282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mIpAtPuapfDM2LVFbP3w+2Wvj9QuzyvOuwpmpUfALTFHsETMetO/Adbyu/PnK1x35RxPWdHiJyRIoOQG1GmnBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5057
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Wei Ming Chen <jj251510319013@gmail.com>
> Sent: Thursday, May 6, 2021 5:49 AM
> To: linux-kernel@vger.kernel.org
> Cc: linux-acpi@vger.kernel.org; devel@acpica.org; Wei Ming Chen
> <jj251510319013@gmail.com>
> Subject: [PATCH] ACPICA: Use fallthrough pseudo-keyword
>=20
> Replace /* FALLTHROUGH */ comment with pseudo-keyword macro
> fallthrough[1]
>=20
> [1]
> https://www.kernel.org/doc/html/latest/process/deprecated.html?highligh
> t=3Dfallthrough#implicit-switch-case-fall-through
>=20
> Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
> ---
>  drivers/acpi/acpica/utprint.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/acpi/acpica/utprint.c b/drivers/acpi/acpica/utprint.=
c
> index e37d612e8db5..0b511434b80b 100644
> --- a/drivers/acpi/acpica/utprint.c
> +++ b/drivers/acpi/acpica/utprint.c
> @@ -475,7 +475,7 @@ int vsnprintf(char *string, acpi_size size, const cha=
r
> *format, va_list args)
>  		case 'X':
>=20
Hi,

>  			type |=3D ACPI_FORMAT_UPPER;
> -			/* FALLTHROUGH */
> +			fallthrough;

Since fallthrough is specific to gcc, we use the macro ACPI_FALLTHROUGH for=
 code in drivers/acpi/acpica. Please resubmit using this keyword and I can =
take the commit for upstream ACPICA.

Thanks,
Erik
>=20
>  		case 'x':
>=20
> --
> 2.25.1

