Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADBCA32C440
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 01:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387775AbhCDAMD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Mar 2021 19:12:03 -0500
Received: from mga02.intel.com ([134.134.136.20]:45542 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1574520AbhCCSaG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Mar 2021 13:30:06 -0500
IronPort-SDR: 7SFkXseFxBxwX0CKkjshYFKchDXJYoOnWSbjgkSJ0qNo+5y7+H1W2WDT+gavSEtKugZhHwFlVS
 lOZBM72Ecy4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="174372986"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="174372986"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 10:29:25 -0800
IronPort-SDR: WX8R2c2+lw36QFxfwgl6OWS7k5zklNHhmxoL27zXKfOK+pP7prPqEHbWh8EuwMP1Z4PIr1+hOZ
 f+GRf0xQGiWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="518377116"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 03 Mar 2021 10:29:25 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 3 Mar 2021 10:29:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 3 Mar 2021 10:29:25 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 3 Mar 2021 10:29:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkxVly/aIpHhBnw6uEYoXdoDeMbQCLfzgWRIU6HND+/QzCHQSS5/bMO5qUOhPdr/MUEvErXl1zBEcrxz07aiAg7OuW8aBktKF9HACJEbpV2lAwKrEx0MEqafNVggxJp+lQwg1uLoj1VVQ2TCHB5dAN9yibLXrcCz2POlXyN8elPWCJpXdviaEjGnaCZP8PAr/sGk13dNOh2QPP4HvIHyyDzDA+9mqPNG+h8Iwq6/IAu6HGG1+S4UHmgugwGzwyhvLDQwLxwWa05sNWRaIIobC2tdQf/+XhDT8V1jss/DTNNQC4jagOtaatmp/uxBSdi8dn5AMgk2H28G3vTW+Wlqeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLrto80crs1Ex41rQWKIIc50nw4txg2E0PpVWkT7+Qk=;
 b=T9WDUbkyx0M8umQ5soNmTASCyc/GKGj2P5tx8KlpJAXy4/C21Cr6rNszx68vIrDPkJITweB1iqYMXLZ651AnDy5AIpmGZwYGfPE0E9WwEcyb44LrKZF/jCEShGwhSlpp2CMmhmk3d9XAtiSJ/90+ieVNfmheBSpN126/KsDSkDnX4iOrOFWMyA9lD+jJD6X6W1+7VJ+4+kIDH+7tKEXs3QcdJsq2KSs9nOw8PWnaSCKm+eKnFJeLPturAZE8bwJ3JAHt1Rczr3qr70KH59LENwjlDJUOMWHpR/wXTVFYo38zl/EBS9bETnn3chefQ9leqvdx1HZGQkpsLqc2/guNVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLrto80crs1Ex41rQWKIIc50nw4txg2E0PpVWkT7+Qk=;
 b=Rndo0XLwafN8hNP1atFacwCapDGuJ3lRjRPsxbPaRgiV6Ksd4jwPk+QTmFKz5wlfqV8vNYkEvpD3Ged82Gf5p7z60lPlZMNKAzx12nmAskCt8JewpKXgyWvnglRSKMVrFbkwtsqdqAC1yZ5ONjjaLLidI+BDkPQ0+CCB3+wcrHk=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by MW3PR11MB4730.namprd11.prod.outlook.com (2603:10b6:303:58::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.26; Wed, 3 Mar
 2021 18:29:23 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::4878:159c:ca1e:f430]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::4878:159c:ca1e:f430%10]) with mapi id 15.20.3890.030; Wed, 3 Mar 2021
 18:29:22 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     Weidong Cui <weidongcui@gmail.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
CC:     Xinyang Ge <aegiryy@gmail.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: RE: [PATCH] Enable ACPI_ADR_SPACE_PCI_CONFIG in
 acpi_gbl_default_address_spaces only when ACPI_PCI_CONFIGURED is defined
Thread-Topic: [PATCH] Enable ACPI_ADR_SPACE_PCI_CONFIG in
 acpi_gbl_default_address_spaces only when ACPI_PCI_CONFIGURED is defined
Thread-Index: AQHW/pI3C6eG9OK2N0OcTbEZ1E25bapyuPlw
Date:   Wed, 3 Mar 2021 18:29:22 +0000
Message-ID: <MWHPR11MB1599D81078925FFD128E954EF0989@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <20210209031744.26474-1-weidongcui@gmail.com>
In-Reply-To: <20210209031744.26474-1-weidongcui@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [174.25.99.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b4b5952-1b70-413f-f2b2-08d8de72447e
x-ms-traffictypediagnostic: MW3PR11MB4730:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB47306A1F4B289B539D5D1A12F0989@MW3PR11MB4730.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IhwxYf0CmYwUa1pNK4cQwKi859Ivrf/EXOIbwgwY7sjgbuJ+Y1IJGG0nCadHL95rRB0GYu3ezI5GO+NWmEGisFUvg0kEXRpSVgd1TnajDAl3gA+A379lUndORk+wiDUO6b9IW16a4oJ1pYD2YQth6YXQv8M5avVh9G30a8BZo3V3EUaL/xHDSexsqghIepQ9Cja/9pyV0TFINf7prbXwy+zyKHaM4TmWBlJcOwN4QYfiH3ZUYuGphWb9wypd+ln27jxegUTE736RMPtaCP/kFPLNQjg9FOUR2OCIOl7ejTo8PQp1W/qBqNd03U6xUAzfGmueZXTP1Zo471aA9fzKqxjB/ASTHHgxUfXRtnxxLXwt+j0RCSQu+tyJTpiQgyAPXDSbUcC/Y3EErz44H2XSGy2NpP4PK75obNn1D5ljziqvbvSmb0/QL5mhIfaujvI57Z5JFuiKVPiu/TkWinwtpSq89MTOSe/5gVwDfCGuZ8xcIb5dyc8l6qQ7dKKT+JgAAWMfjT5ISnpR4LjV2jtIhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(366004)(136003)(396003)(376002)(71200400001)(186003)(110136005)(316002)(26005)(66446008)(54906003)(7696005)(6506007)(53546011)(83380400001)(2906002)(9686003)(52536014)(66946007)(6636002)(64756008)(76116006)(5660300002)(86362001)(55016002)(66556008)(4326008)(478600001)(66476007)(8936002)(8676002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?PQ4qexTkPgq73VbM/4zLuG2DBxy/vjFkO6enlMNDNb9/I23pMSgxyITaw1Ys?=
 =?us-ascii?Q?blLdkybTbXUn9bJ3k5R3iBa7J5/CujBaJHtDpEQQn4Hcun+PMNhmmleNaFCd?=
 =?us-ascii?Q?PhQr1OX6Xa713ZMMbXvIyFytguDALb85EnYIsdOMPUBtyAQfpSknfCBpRbGy?=
 =?us-ascii?Q?I3EyZppItevqPsOLoFSeBM9Sss0U64l52doNDXlXEwzCyY+R568i9LQ61jpL?=
 =?us-ascii?Q?gF3i11XoZsHniqr6lD9qIYVK5ByKsx74bqnP9Iq+cdUmWIrlxgDO0IMaB5BN?=
 =?us-ascii?Q?bkWKslKHs2Vr2j0JG4H/ZEwHkIikEw6HjcwyNuQ2UqD2je0LvP11OtFrWoeu?=
 =?us-ascii?Q?SAXWJde12CN39uR9QdBHozZA9p4AO3URW/3Dfc4z6EgpsJPwkSrKT0bNysf0?=
 =?us-ascii?Q?a85kd5gs20l8ImF3locteZ7lYmknC/pYs/TCO+ogi+A5Bunu1Rqn19cXQhVq?=
 =?us-ascii?Q?FWsfotMLunxCfXPe/Py2jkaiM0QHoBFe169ILyH8aeh/RUJaMAN5rHlVhZF5?=
 =?us-ascii?Q?iTVD32vavuH619nzZ/GacT6sQaT3kASMXi9UrWIX0jbn5+6mtUMkGsyszrpt?=
 =?us-ascii?Q?UaKa3M2+ole1eGdqYQjlZ92TuGV8UnzP0Nrgn8guZcMBBIwWMZ0tXgjML2dB?=
 =?us-ascii?Q?17b7djDEiTV+eClN5F2R3A6syUWq55TPxKl0HZwYt2YQDpyTyGVO/rtxVZVy?=
 =?us-ascii?Q?zcdhlRYPBl2XpHsIMNU44OSFU23HMdttfwLXevFUlVzFmB9VAN7/7QyyN8Wp?=
 =?us-ascii?Q?FP6c2Uj2CHdXQX2jneGNs8FmCsXrGdSxJpxERRJ2+sbu8zgncfgwCSSKe4Mo?=
 =?us-ascii?Q?cSlZfkCSOpiRjeMmhF1F2kKB43iuPAmSWJmWtOGZgGeUmLT6J94u8TUdE98i?=
 =?us-ascii?Q?QAY0iyL08ZRp/JK9VjDV7bWVJ7BIt2THCAQPedkCgAbt8WjhHQqe3NrV4gNN?=
 =?us-ascii?Q?+SHMIDdlnXt1JhOWV6R2n/5l1dcH3/N6N8xNTJlP59cobQtuTp2qU6/Fy3hZ?=
 =?us-ascii?Q?Ar0gCxf/NEM091u9zMuUj60Qo3ZXHn0uS5R4H+0HQReU8+F51hjrJUpj+kW6?=
 =?us-ascii?Q?r+1F4pXFb4gSd3kStgJ0rD1LxJCsl0Wi1NbENZABHbEgpl0CL5DoG63TyNbi?=
 =?us-ascii?Q?O/PY7tjqwRZa0ttnSaBQ5MadiOBHE8WJHsmqEjTB7rEg4ZQdUUC+hA2I/M4X?=
 =?us-ascii?Q?Kml/aSr6t9CYegb2I1CcicG42ii+h0B8Zbr2AuioY8Oyzf/whhrT/9ZN5JwW?=
 =?us-ascii?Q?Ocsg3DOlclfw86DLrYbkFVeP42K57shQ+xFqnWnfkNT/xGfPIdXJa+fAPxRt?=
 =?us-ascii?Q?3ZOgia68d/EATvYsnEe4jjtJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b4b5952-1b70-413f-f2b2-08d8de72447e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 18:29:22.7894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z5blmKtATKiCdKhP1q2CpbX2+sD0qDinPKTdCrm4pZoGTowXl8k42cXajlcNEE52qKLyR/l9Pm9+5ZFw3DwQvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4730
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This looks good to me. Bob, do you have any comments?

Erik

> -----Original Message-----
> From: Weidong Cui <weidongcui@gmail.com>
> Sent: Monday, February 8, 2021 7:18 PM
> To: Moore, Robert <robert.moore@intel.com>; Kaneda, Erik
> <erik.kaneda@intel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>;
> Len Brown <lenb@kernel.org>
> Cc: Weidong Cui <weidongcui@gmail.com>; Xinyang Ge
> <aegiryy@gmail.com>; linux-acpi@vger.kernel.org; devel@acpica.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] Enable ACPI_ADR_SPACE_PCI_CONFIG in
> acpi_gbl_default_address_spaces only when ACPI_PCI_CONFIGURED is
> defined
>=20
> Signed-off-by: Weidong Cui <weidongcui@gmail.com>
> Signed-off-by: Xinyang Ge <aegiryy@gmail.com>
> ---
>  drivers/acpi/acpica/evhandler.c | 2 ++
>  include/acpi/acconfig.h         | 4 ++++
>  2 files changed, 6 insertions(+)
>=20
> diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evhand=
ler.c
> index 5884eba04..4c25ad433 100644
> --- a/drivers/acpi/acpica/evhandler.c
> +++ b/drivers/acpi/acpica/evhandler.c
> @@ -26,7 +26,9 @@ acpi_ev_install_handler(acpi_handle obj_handle,
>  u8 acpi_gbl_default_address_spaces[ACPI_NUM_DEFAULT_SPACES] =3D {
>  	ACPI_ADR_SPACE_SYSTEM_MEMORY,
>  	ACPI_ADR_SPACE_SYSTEM_IO,
> +#ifdef ACPI_PCI_CONFIGURED
>  	ACPI_ADR_SPACE_PCI_CONFIG,
> +#endif
>  	ACPI_ADR_SPACE_DATA_TABLE
>  };
>=20
> diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
> index a225eff49..790999028 100644
> --- a/include/acpi/acconfig.h
> +++ b/include/acpi/acconfig.h
> @@ -162,7 +162,11 @@
>  /* Maximum space_ids for Operation Regions */
>=20
>  #define ACPI_MAX_ADDRESS_SPACE          255
> +#ifdef ACPI_PCI_CONFIGURED
>  #define ACPI_NUM_DEFAULT_SPACES         4
> +#else
> +#define ACPI_NUM_DEFAULT_SPACES         3
> +#endif
>=20
>  /* Array sizes.  Used for range checking also */
>=20
> --
> 2.24.3 (Apple Git-128)

