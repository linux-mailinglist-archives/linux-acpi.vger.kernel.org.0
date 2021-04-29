Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7B736EF41
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Apr 2021 20:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240947AbhD2SBd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Apr 2021 14:01:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:52898 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233706AbhD2SBc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Apr 2021 14:01:32 -0400
IronPort-SDR: 0TmyzwR900fMIJIRqifaYypWoSo9O75WqfZGo55c4xwIRr+qAEAmBOJg0YndjU4MwnBLSqXkBG
 aRJT4nBydSaw==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="196633584"
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="196633584"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 11:00:41 -0700
IronPort-SDR: sL0I83nSKoqiQE70tv2oGDvJqet59QbHRzYME7aetfk9TAjR+pek0nLDUfTZ3NGdpE9FJ0qD0m
 wZUrGBZgZZfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="404240344"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga002.jf.intel.com with ESMTP; 29 Apr 2021 11:00:39 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 29 Apr 2021 11:00:39 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 29 Apr 2021 11:00:39 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 29 Apr 2021 11:00:39 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 29 Apr 2021 11:00:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXy7allgTZmKb+2mMnhyVm2xUSgD/S8MNMmHlXeHDNOc6qWl0+5OiH5EUIBwOriiJASvR6T+QRTA0EOUJMD7J+OqLlLiCorK9J/dus8mi/lhrKlvAp3Wzec4+w3fss+TCqYDXZ0OJXZfi08e5Oz0nEmLlTNjNTH0yHtG/zYwe7wD/poyePrxipPVkly0OIg6EjjgVljgparY0DBRYLETcA2rFlq8H+8NgQdoTsACzPlY8Osh9V+x20LN3A0SKD/MB4DWvZGZHxvCcZIp0xibFRjt1IyQa4nLvHdFz9q4nUStTUbsSxpJ6iboDlE09lpBUMWfRXpBpsA45Atcw3BKzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58mi+6v9uF2A1aH/mjxRjOCBXNbJEWGtkMFf84X1DLI=;
 b=Ojw9eqHFc7xIlddqZDClnTSjcTzX196ogvs40YnarqGaYEEn/hsf94/7z2kzGgGfe1pRNeRFn4HP+YfH1HP2XsvPe0hrwFAfivArafrs4b/tZO4YQ8Gia/Rwc1TYY5HD3Ea6nKUG4V9vO+4PnpCvwPhHEMsVa5ean2HhUVAZr2ia6N5rVp1rhM7R9ENi3WZ31BdeJTyBd7g2638ixIGA0ilgE/KGsSnZ/bebdZEwU8kSk5neWT388Mk6dirsFJ/qKS4/GrzR6xU/JKdFHycHQZmGrFCL5q9vzLAlVy03RnmNcZwX59ZoHoJ3ImBNv6pgoKck8ZNgSXhK5DBeAinzyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58mi+6v9uF2A1aH/mjxRjOCBXNbJEWGtkMFf84X1DLI=;
 b=F9xOAgKBltKnOSKri8+tGENEN/llPjtUv0Q6AX1Rhb/YvMh2yDYDYpEj7LtYlPaFN/R56/QU/gMiIH85b3bdAc9VH6hx0Ck7LkXLfucZxrIkWkMmRBQ3I8Op8ROogr9zDjtBjOi7cw1Op4yMoYifkAkfDSbnMs8AqFXuFWJbWOg=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by MWHPR11MB1965.namprd11.prod.outlook.com (2603:10b6:300:110::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Thu, 29 Apr
 2021 18:00:36 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::48df:6af5:afe:ea7e]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::48df:6af5:afe:ea7e%7]) with mapi id 15.20.4065.028; Thu, 29 Apr 2021
 18:00:36 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ACPICA:dbnames: Fix a error free in
 acpi_db_walk_for_fields
Thread-Topic: [PATCH] ACPICA:dbnames: Fix a error free in
 acpi_db_walk_for_fields
Thread-Index: AQHXOwaEMMs9kJYcc06jsm/pDRsLMarLxwAw
Date:   Thu, 29 Apr 2021 18:00:36 +0000
Message-ID: <MWHPR11MB15992FA009C23A74FCBFD204F05F9@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <20210427014134.3568-1-lyl2019@mail.ustc.edu.cn>
In-Reply-To: <20210427014134.3568-1-lyl2019@mail.ustc.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: mail.ustc.edu.cn; dkim=none (message not signed)
 header.d=none;mail.ustc.edu.cn; dmarc=none action=none header.from=intel.com;
x-originating-ip: [47.7.17.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d43b4932-1ea3-4dd2-2ca6-08d90b38b0ed
x-ms-traffictypediagnostic: MWHPR11MB1965:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB19653EBB80AE8C6DA0F22FA6F05F9@MWHPR11MB1965.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wP/NUUz66me2iSqPknn+xTogF2pjY7vMzMDS6toqLYWPwNc0XH1uH8Hilr6EZd0vmbcdNQVSX6tj5FQOxkWFV7ul34/oW3NJbk0qY6t73hBNelSY0hSlCGM3TfrD7sX3sE/VhoYZcMhtXVYGdF0rB6h8wjLVNm4LiIkSjweChIUV7ZZHPqFEagHZ5yDgbmbtK5gZG072ZIvaeXacF6azM4U2UZ0G2aDO/5dC7GRdHoPDZztVhopgQUtQ9ZusBTO0TtUUEskqac4XOlQx6M7NLj5L7pAd1gTYiMTRtBGyHqKTx7JeC6vj83r+uCmaRFBSZuft/MfppkSwxF+uZCjcEbdA/FxKHG2g5hCtj7Hm2M2ySNjJfeLUOUR1/OugPgJw/i+k1rODvksS99CfqUbp4rBK81WAafKAv6Ow4RhrVYu3K/t5dhOQLeOsTRN8ZxMhcyIlcBEoJpCi3lVD3s8xPXGWTEl39HOUTQujlBu9Ru3DbqauKwq5/TnM+MSzt9EJAkePCIWEV+ji+/oSqJH2FASlLbVYsZCEq8+e8rc64ElNIkeT1xF63PXIVORqYMa8QeTdUYUp5UtE8/aVVEddwUNxaPdOEeOzQpFyJMB+VrQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(346002)(376002)(136003)(366004)(66476007)(66446008)(5660300002)(55016002)(7696005)(66556008)(83380400001)(64756008)(53546011)(2906002)(33656002)(76116006)(122000001)(9686003)(26005)(38100700002)(316002)(110136005)(8936002)(478600001)(66946007)(4326008)(86362001)(8676002)(71200400001)(186003)(52536014)(6506007)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?tk+HZToYBlAWhRf/mBuaC9XQ99WlaVGvcg+x1xBkQtHO3qnmvAOlZuwH3YQr?=
 =?us-ascii?Q?Qymmf8L/24tEAUyjsOhGM7REB91jaQZb0tJGtTYdNT/8/QfWKvhJkLlwRSxv?=
 =?us-ascii?Q?Il7gOBoZrm2F+eEPyOTBm3nvUmqcbTs4jHGHIybKKkjw50l34qZSvqfTZZ45?=
 =?us-ascii?Q?0C5OKGITwQCEhJHpsMLAeD7xiSUhC+CeybElas8YXwEkBbZR0XnFazwzQs2z?=
 =?us-ascii?Q?h0OM0YUAo0Ss4bX99tZq+oE0hr3k0G/dmk0T1sKRUduvt08SlbO3F9wsHkjl?=
 =?us-ascii?Q?ogY1iYc8xyqXU6aFB6Y6LLbPevTjo/VgmOi4wwUkt7k8/Q6HD9IZ+xZDPRYO?=
 =?us-ascii?Q?u/bPuvYbGiVzjaAd2YckOLjzGFKqbfIlsRoy310qoVEW7sr6A8Lh7+OxyjSy?=
 =?us-ascii?Q?hU0XLf4PWph9cc2nebqHVdU4t//KcrfzQmzQzbUvZk0Elef0N50nlCt+ArG/?=
 =?us-ascii?Q?i0x+YemH87uLHsfL85QXnX2PJSxti8AIrqbW+S1uZ9HJU7tzhtT6Atkk+skL?=
 =?us-ascii?Q?1/DD3Z9lSjvZdTnH0HWlJQWhIaUt6cBQdlkKys0yfny5hMSjI5qQUXANz5fP?=
 =?us-ascii?Q?vM5+q/i9IUc1641MPl5Sx4sXiz0iiepfRH8LQZexOmSSl89LbRDka+xsmXaL?=
 =?us-ascii?Q?whvgt5GpRspsw03eCnU/ywTAiNG7F2G1rKupjacRgBurDDSv+SMOf1+dK5l3?=
 =?us-ascii?Q?w0wIj+4zZW/elIzd5/h0OQZQPKB53TQq4bQndz2Eyz+HnJ/0V1aPxd4Vhv8t?=
 =?us-ascii?Q?Apa02vPmLKVdlpKnQtnjDsdlthus+TVyst8Dhq9T/MzqtTzLSENEDDRn4T8q?=
 =?us-ascii?Q?8Tz0QndSyp+uRHyRw8zLf38g12V2/Xw6SNYFAPeTLs1skMjCpJcKSe94s8bL?=
 =?us-ascii?Q?s0gIWn1vJz8oO+ytLQViR9TWmvgY6sMLMLCJdE5MmJ36yvjQIuBr6CmlH/D8?=
 =?us-ascii?Q?vj1A4A9jUa5ZiSL5W2sN9FN1D7Lct8ZsAnZjgyMlqVM1AVYOuD2e8XVHnrhW?=
 =?us-ascii?Q?1sOc1zhC30O4kV4WbMvqVIBGxGxqGNfoiWZBZmSsxkBD5kZHgKj8i+SDYb7i?=
 =?us-ascii?Q?aIgMOZbY0sy31gdNHDciH8X3lcTx7wzLm/xF7hDVz47TIWww/HtDg2mpWGf3?=
 =?us-ascii?Q?GFewI/kRS5/RVDoJ/cwJ6eW4+NiNqE8/ckZDQVrkVr4A2UUAoIBXG/zg4nF+?=
 =?us-ascii?Q?Lb1oSHkpi+u3RoN25QI8QPCRp8ElJ5wHwB87tVe7BfhDT3+Zy1TDF59mk1UI?=
 =?us-ascii?Q?4FLuD9IIjfxHRUrsXiSgyp7jxRm6CzNocouW13Skdd8SL2WaXbqKexGKzegz?=
 =?us-ascii?Q?NGo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43b4932-1ea3-4dd2-2ca6-08d90b38b0ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 18:00:36.3673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l1rUZEU+o9jcHlpBXjdY7FmBIIfal+kurLMoE5TVsj1CkldxlsTAD28sW6fKwmZLf59LjGFx4nFUj5RqZZx+Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1965
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> Sent: Monday, April 26, 2021 6:42 PM
> To: Moore, Robert <robert.moore@intel.com>; Kaneda, Erik
> <erik.kaneda@intel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>;
> lenb@kernel.org
> Cc: linux-acpi@vger.kernel.org; devel@acpica.org; linux-
> kernel@vger.kernel.org; Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> Subject: [PATCH] ACPICA:dbnames: Fix a error free in
> acpi_db_walk_for_fields
>=20
> In acpi_db_walk_for_fields, buffer.pointer is freed in the first
> time via ACPI_FREE() after acpi_os_printf("%s ", (char *)buffer.pointer).
> But later, buffer.pointer is assigned to ret_value, and the freed
> pointer is dereferenced by ret_value, which is use after free.
>=20
> In addition, buffer.pointer is freed by ACPI_FREE() again after
> acpi_os_printf("}\n"), which is a double free.
>=20
> My patch removes the first ACPI_FREE() to avoid the uaf and double
> free bugs.
>=20

I'll take a look

Thanks

> Fixes: 5fd033288a866 ("ACPICA: debugger: add command to dump all fields
> of particular subtype")
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> ---
>  drivers/acpi/acpica/dbnames.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/acpi/acpica/dbnames.c b/drivers/acpi/acpica/dbnames.=
c
> index 3615e1a6efd8..dabd76df15ec 100644
> --- a/drivers/acpi/acpica/dbnames.c
> +++ b/drivers/acpi/acpica/dbnames.c
> @@ -547,7 +547,6 @@ acpi_db_walk_for_fields(acpi_handle obj_handle,
>  	}
>=20
>  	acpi_os_printf("%s ", (char *)buffer.pointer);
> -	ACPI_FREE(buffer.pointer);
>=20
>  	buffer.length =3D ACPI_ALLOCATE_LOCAL_BUFFER;
>  	acpi_evaluate_object(obj_handle, NULL, NULL, &buffer);
> --
> 2.25.1
>=20

