Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B323036EEE5
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Apr 2021 19:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbhD2R34 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Apr 2021 13:29:56 -0400
Received: from mga05.intel.com ([192.55.52.43]:26050 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232991AbhD2R3z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Apr 2021 13:29:55 -0400
IronPort-SDR: cLqU3RCFCsrK/osr7Nqmp2o2fOoj9ghe3PjCJyN5Q1SA9NDAFlZKWHn0Q2eG9hwOFw3GocFkgP
 fuJ29pKYj3Ng==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="282409821"
X-IronPort-AV: E=Sophos;i="5.82,259,1613462400"; 
   d="scan'208";a="282409821"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 10:29:08 -0700
IronPort-SDR: IogIaZ89R12vybkxGS58Q9xHMD/YUVw8Iteu4UhcqD8kZ0QNZssnhWwcC5IaMg7+8s6X4HAQln
 j0Us4QyGgrzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,259,1613462400"; 
   d="scan'208";a="455636454"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Apr 2021 10:29:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 29 Apr 2021 10:29:08 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 29 Apr 2021 10:29:07 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 29 Apr 2021 10:29:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 29 Apr 2021 10:29:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ja2yPNYi+eDQ/TgW8Te2R5Y5mnlXOdVzVo7WnguEQBuUPsX4DLcN62Hh+mX8qqtCuIznDrr59rwmFSg694ETWP+wS4uJ+ojRjCbRvGiXm9ISdMzdbd3MQpakTO3atKti/QqgkdQ6/YZxWarGyd0Y4uPdmuvlo+hl7d/0G/7cLdvMeem0EisT/PgEEzm13P3jPAKNOlmii5dpVlo8DSWFLOzJ71V5zjUzLLDF0+lA6OS7IotR+iSNhKFgy1mGkbM09PDGm9WOeBhHy8cyjY/K8901fjQAKiNVPISft3B/o4qU6hxYGykojJdZwVYMoD530n8zj7QhIciaLxCeLu8yyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgLQGeCjy2UlxneLicqQwSAKU6eO2Y8yATVL2Wljt3M=;
 b=JvBmYGLWKm6k9AEs56CMmqN4L6PAj8ekjTofZRCSA//hlLdOqMWp9fDtpY79ucfE2eNUi7RHms1VjCZ/4cv4VlzqbwNFnOooZkC87sz+dGeQlfzldMX0cbFHGtaTUVXZYnW3q6q7hdSEI+0PSPeD1BbY1qrnvFp/+OOToXyocOZBRqkaPNJ1z+lYytTwQqBbsiX3R1KJPzmwlISrfwBxzZx0rPxFqj4sq9UsWzXa7BJRMoyNlJLrBIrrz5Q4jUW2YU5wEzWiaiGAiHgFapcMI+gy1eS9Qq2SiEzDTYmPCfoEcmrGda6EQyWowX9gEBBHcVEnJY6k2yOmzcvrYAoWnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgLQGeCjy2UlxneLicqQwSAKU6eO2Y8yATVL2Wljt3M=;
 b=LiXKVynAwH7LtqDavFIvovSFBteWBxrqchOVJ526iX0Tl9qV8/U43NDY1Oe5JsDTUlBOCnwe0gAbTenXAOZ+o9FZb7zapbwZGaonSqvP/4KeV3uqBg0bgPxXXRVNsSMmSUrbZkK/n76gQyGQoE2/AFzn6vLeViAI1Frf9+5zTgM=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by MW3PR11MB4681.namprd11.prod.outlook.com (2603:10b6:303:57::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 29 Apr
 2021 17:29:05 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::48df:6af5:afe:ea7e]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::48df:6af5:afe:ea7e%7]) with mapi id 15.20.4065.028; Thu, 29 Apr 2021
 17:29:05 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     Shawn Guo <shawn.guo@linaro.org>
CC:     "Moore, Robert" <robert.moore@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Gordon Ross <gordon.w.ross@gmail.com>
Subject: RE: [RFT PATCH] ACPICA: Fix memory leak caused by _CID repair
 function
Thread-Topic: [RFT PATCH] ACPICA: Fix memory leak caused by _CID repair
 function
Thread-Index: AQHXPIYWuGr/QPGIrkWhdTH5uwrxLarLv8wA
Date:   Thu, 29 Apr 2021 17:29:05 +0000
Message-ID: <MWHPR11MB1599F8F0546802A6A0E20D49F05F9@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <20210428225247.1701392-1-erik.kaneda@intel.com>
In-Reply-To: <20210428225247.1701392-1-erik.kaneda@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [47.7.17.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14ba4fd3-693f-4c94-06bd-08d90b344a08
x-ms-traffictypediagnostic: MW3PR11MB4681:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4681DDBDB88FD3C27AC50B1CF05F9@MW3PR11MB4681.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UB7ORPofGLIK690jmPJZDSBhvu8127G3fsLlT+3Zt5apJEi3So0cCV1N/bii4nDxPQHeEYNs58FHvvFpf0G+lF2aYsP8rlQnWFqvRtfl7DQLnKwkZR6gnBQDrWOWfFVcg/eg9iu880usi38iljxjjk+WGlR2yh1LRiL+dUPX/PGp64/jaRFb2NMEzm3hXWF327VuuKoXFint4y9mGcyvlnZKh99zAzUs1+7zqO15loefHiMiGevWY3HGMLGY2R6Rq7g+3zmIxTc82QqAvxrbL9u0Isy2Uc3jKtFLrP1J79WZlfMjELNWO5jKeZtiYmYSQKLUOi8/AocrFRd1THQYnI4K0UXWbT+8Wob50/japNEIbtHn6wa38cXe2mnr3fuAIgD24ctxJI1xvrdAA4TMukncQQbcO7O8DTrKHBeWVaRtHla/tQfRO2Xc2tabV7yM3hzrXwlslN4j2bLuH/q/iNa7U1wcz1nX0GAB6YGpRhPglxbECL6/g5WgVyytY+D1i1Fi8Hnnzp8IUiZFGX4jiUn/kLrbKP0MOxvLqxxkKZk/m1Rfkgq+NTaH1JJGQ8g0xud5tJza0nt0bIJmURsqVzRPzLdSIzFo6OyKPv6lFRNHrPr5tt6I68s1vrMyO2If9wE/6MHlDMmeVAclyCZyfZ+M3IOl6Bqr5vs56P0pJVSegieI3GWN+T9IROGBU5VZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(136003)(396003)(376002)(366004)(5660300002)(83380400001)(33656002)(55016002)(478600001)(7696005)(8936002)(52536014)(6506007)(76116006)(6916009)(26005)(66446008)(38100700002)(66556008)(53546011)(966005)(54906003)(186003)(66946007)(316002)(86362001)(4326008)(122000001)(2906002)(71200400001)(66476007)(8676002)(9686003)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FQ3v50CaAI2xX32gHEvENuvMvPDKo1tWUJ1yyPc69rUB2Y67xu1g/3wGNe2D?=
 =?us-ascii?Q?LaOXVJejr0eX0G++sC78hbKDXDrvQzGWCSRf8wN7u54CyEx7nfFZPczfWLsi?=
 =?us-ascii?Q?MmUdJFUY+9mFkRQwLblhTl5+vGdMSuhi+9eYbgC5CSMoQnPuomKEAmyIPu/v?=
 =?us-ascii?Q?sOAEqiDFls43dVdndc0Gpoi5uny2dOFdL9QLIMu85wF2ZscraP+RUi/3g/hV?=
 =?us-ascii?Q?tO0Nj3gEBepbEBZymvBoNNtQ7PFoTgweonqrS4Y9UOgb93viHfb077Ge0uTI?=
 =?us-ascii?Q?LEo3q+ToBxRsDrzVuHqUk11h95b15xOUocM7pXZa5V0KcSWWhknpEL5btFIq?=
 =?us-ascii?Q?DVKapSmDiL/dJP1baAp8jwsFsFb9SuX3oKcxHUxAOe44hn0yePKyykQg9tZi?=
 =?us-ascii?Q?r8bKcjp1s1/bEF3Hnr0pI5mV512MedktaI0kZ1jeekqgMWHyvdAoAxRvbAu8?=
 =?us-ascii?Q?8c0Lm0+nYMc/x6CubDyuGx76kI9fGoG0ClaYjffIiEGbgQwQvbr05wvlTKue?=
 =?us-ascii?Q?vImXCIjt5+z6ittGgzLu9q5lYkE8LeHiW5IBcdIYW3lvekiAM8avCcHc+EDz?=
 =?us-ascii?Q?NPht2tJfKagUxN6Kd2SJQbM4t9mkuJybi+tU+GoErfYoXe+q7tFO5hFRKnIO?=
 =?us-ascii?Q?SbT+wgGuSRjyWQ15o5a8/dvLW7Oa1VTFJFfGBxHpQblrVHTBBnb4d+pavw1O?=
 =?us-ascii?Q?RzpyhFggvvUef8gSELZP+RyJhvayodBLPHtdTuePptbHMlkuLvAaDzIiTA6V?=
 =?us-ascii?Q?Jv3C7nBGJimONUcbBsoCaG0g5jgK3cOWuKgQ68fWeNL83rKjRsAc/LtVTaY9?=
 =?us-ascii?Q?ABA7wMCl77jwEFDZvQ9ritBZza847KlzDxV7KLrjVhvbjj15YTa12G3IdR+N?=
 =?us-ascii?Q?872xE3RvQibUi0ncpmwRge2UuSO4tu4RlV2DfsnuayduqmsfgJmEa5Oi7agl?=
 =?us-ascii?Q?Gjugs15jS2NLSpWPOyujAx/JEcRht2DDC483OcgK1tmnF9CxEDSwjQ3FRoxk?=
 =?us-ascii?Q?Y2Dbp8XjfDQ5yO8EQxexp7+l2YN7UNsCF7f8aS5S9ScGR9//aVmQlCQ7xYf4?=
 =?us-ascii?Q?vFiHf7tRKj++fqrT2Kjn/a8Bkiy2Bsclnd1oPRpl5msjkuqIAP3EvY1Dqq0q?=
 =?us-ascii?Q?R/EMRiifbkZCjOMvl9wVS6axQ9ZcRmJuFM6hHZy2ROFaWym1NGD9HQ376L5t?=
 =?us-ascii?Q?vxO8eS3o22Glo1/aiVN8OnO7eiA8klmcVijvpTjtYVmvYms3rkK+s6kyqi25?=
 =?us-ascii?Q?WxmAN4WyMTovX/2+0VVBbqeHQk4OZTnCFx3lTrxQfWKAEboYRMakBMIrGK4B?=
 =?us-ascii?Q?Bvc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ba4fd3-693f-4c94-06bd-08d90b344a08
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 17:29:05.7251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qfqloQWvlf7VnhdAkcTr5gq3GN4sD7CQ7g1imIWJSkFlU0w6Hq8dSPzsJ8LijhFGDyT91uDPHkYWGxmd4JUmNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4681
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Shawn,

Could you test this patch using the setup that you used to report the crash=
?
https://github.com/acpica/acpica/commit/d095b337ae1f107ad66bec19a99b4d7affa=
e2fc4

Thanks,
Erik

> -----Original Message-----
> From: Kaneda, Erik <erik.kaneda@intel.com>
> Sent: Wednesday, April 28, 2021 3:53 PM
> To: Rafael J . Wysocki <rafael@kernel.org>; ACPI Devel Maling List <linux=
-
> acpi@vger.kernel.org>; Shawn Guo <shawn.guo@linaro.org>; Gordon Ross
> <gordon.w.ross@gmail.com>
> Cc: Moore; Moore, Robert <robert.moore@intel.com>; Kaneda, Erik
> <erik.kaneda@intel.com>
> Subject: [RFT PATCH] ACPICA: Fix memory leak caused by _CID repair
> function
>=20
> ACPICA commit 5fc4f4b87d6890d48d050ab279ed01f0132662ca
>=20
> According to the ACPI spec, _CID returns a package containing
> hardware ID's. Each element of an ASL package contains a reference
> count from the parent package as well as the element itself.
>=20
> Name (TEST, Package() {
>     "String object" // this package element has a reference count of 2
> })
>=20
> A memory leak was caused in the _CID repair function because it did
> not decrement the reference count created by the package. Fix the
> memory leak by calling acpi_ut_remove_reference on _CID package
> elements
> that represent a hardware ID (_HID).
>=20
> Link: https://github.com/acpica/acpica/commit/5fc4f4b8
>=20
> Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
> ---
>  drivers/acpi/acpica/nsrepair2.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepa=
ir2.c
> index 14b71b41e845..38e10ab976e6 100644
> --- a/drivers/acpi/acpica/nsrepair2.c
> +++ b/drivers/acpi/acpica/nsrepair2.c
> @@ -379,6 +379,13 @@ acpi_ns_repair_CID(struct acpi_evaluate_info *info,
>=20
>  			(*element_ptr)->common.reference_count =3D
>  			    original_ref_count;
> +
> +			/*
> +			 * The original_element holds a reference from the
> package object
> +			 * that represents _HID. Since a new element was
> created by _HID,
> +			 * remove the reference from the _CID package.
> +			 */
> +			acpi_ut_remove_reference(original_element);
>  		}
>=20
>  		element_ptr++;
> --
> 2.29.2

