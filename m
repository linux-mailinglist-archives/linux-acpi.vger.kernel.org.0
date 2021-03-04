Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C687E32D82D
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 17:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbhCDQ5Y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Mar 2021 11:57:24 -0500
Received: from mga03.intel.com ([134.134.136.65]:26079 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238505AbhCDQ5O (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 4 Mar 2021 11:57:14 -0500
IronPort-SDR: fkdQhbAQoVujyG+aTasdSoJ8oKYGHkRLqCgVt4N9jtJ7qo2GW8TyefmOQAqo9J3PpgwLr8FiJK
 +3kADcgC86kg==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="187506510"
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="187506510"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 08:56:32 -0800
IronPort-SDR: WVIlmacODEbag1qS3K/9hi0A+4uEB19iVvXOFpVz5Nbg2J2PUkZXiRZ7FVtsXHjGme1c22wNYk
 lqKsGVrk3zaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="368246862"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 04 Mar 2021 08:56:32 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 4 Mar 2021 08:56:31 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 4 Mar 2021 08:56:31 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 4 Mar 2021 08:56:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NM/6HBhqK4pxv62YdyOSp5PDW8lmhn/lx1kcTtJDOKHtXHq1bRBnTE8nMpRehXisCUlKs4J+jryZq9jeQA0S1Cgzcv8rhp3HbAsd/iFWRc3cLa7rk2NWjc0d7esaQSFkgFrmLwjpjkU6UWyV5Vsy/azvkGjgnELpeJ/FIZaUBl6eUYX24UnQUamlbQoGegpezuRWqIyXfF6/3gWKtJCh6X4/qu9hEgn5wir8X6DoyTzVEeJDXw8oEvhvqaMqGPR3o4oBk2VIIVTH5hzWH4gVnhrBqIWE2O0UKQLal1We6kyag6d5j85ACyVQ7cvC08+RcI1ovv8VC6cm1pd0xoP3EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNf0JoHGEQ1C98CKYFMKrqhti9BcAKK2Y1Plnx6tKqo=;
 b=hN4pHmntrEOxrGOAgJAYR6uYkQrKA66k75uzP55/6Z1ExUxVDVcIveu7M5DT7e9t4e5YZD+3b+y+YDObRbiNh6Z6t/P9Tm5grb7Dd+1tnOv/r4e8QOk/O2Y2xDnOZ0ii32kMZp+ehMW3i8YAn1YABnm03RBciV1QY3rgztYAPnBPF2MdcMIHpUo1nmWDlu/q6xuYXSzy6euGiFX3OXKZtJtSFiu9ycmBZq+sdKHDIDETvGfXrYbWM6QPpit5hwgS7TjDh7zLH80r9V6/yB9MlnS4rHN/LsYL3UOrloc5v0gczbZKjR+UCWsxz6kloxCr/9JAL8n2tJmcJqEqBFhxHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNf0JoHGEQ1C98CKYFMKrqhti9BcAKK2Y1Plnx6tKqo=;
 b=ducySPQjdg+lE8+cYPai1eRyZxiq1AO64tMoL0GQdixF8zxGd7NMWiSZhAuIvfTNJfOB31qyZfwf3yJvL28Sq6Uye6aq7BWuMtlqYqvi47mKSWyuGEZf+mQFA4cI7p8J2vhpM+1isQGGflQEx9xEwHJTN6IkmSWaPlCFDXijaG4=
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by BYAPR11MB2631.namprd11.prod.outlook.com (2603:10b6:a02:be::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Thu, 4 Mar
 2021 16:56:28 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::ac1e:2d22:3f90:4dc]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::ac1e:2d22:3f90:4dc%7]) with mapi id 15.20.3890.032; Thu, 4 Mar 2021
 16:56:26 +0000
From:   "Moore, Robert" <robert.moore@intel.com>
To:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        Weidong Cui <weidongcui@gmail.com>,
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
Thread-Index: AQHW/pI3ruT7cwkxjEOUSsZ8OrOy5apyuR4AgAF306A=
Date:   Thu, 4 Mar 2021 16:56:26 +0000
Message-ID: <BYAPR11MB325658379DB73F6EEDD6C76F87979@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <20210209031744.26474-1-weidongcui@gmail.com>
 <MWHPR11MB1599D81078925FFD128E954EF0989@MWHPR11MB1599.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB1599D81078925FFD128E954EF0989@MWHPR11MB1599.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed1e6995-139b-4673-7016-08d8df2e731b
x-ms-traffictypediagnostic: BYAPR11MB2631:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB26311350956B80199DF4490A87979@BYAPR11MB2631.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 61+WlOnsvXR7dxCplt5x4D/5mDcRmnSfA7LKd/Ha06pts57tdHbrHsDNPw030e4h00xAc2PzozQtRfvCG+z1nLWVc/dm/Y5bfMVjqbSYtDZ1clO5RzmEGV6M+USuNXfk+UHb/1C2MBY284GO8lWKsc9EoJztlZj6sfPaVKNbMHEOqohkrtZS4oaVxSGJIZSawxli0EXyroC9EZOBa/AxreiY9WoqSicZRMAo2MQlW1Bi1gHJDSRY3EllW0JBMCNTC/kVBdlrGhAb8Y9YuQQnEqeZaZp3QjOnfEAKNJgaVeBk8mfXHH0FFiVc1oudngf9tJFgwD/eBMvDHnWBTXnTu62YE2bIl3NG4mccIDe2/l4zLdE701989JTunhcshTDiILdheFzlTSGUbhCcuN3oQVO5i31yshZ3Lie30EN6KjWpQr9v6hgX97kmAZ/XLrN0P6aIWXh3tWfBJlH0bXxmy/3n3erERP/j521nl25gxU/zpoLjEO/D+eyPowzCZpjocpxm1EPP9x7HgbnwvKdzSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(39860400002)(136003)(33656002)(54906003)(66556008)(86362001)(8936002)(76116006)(83380400001)(110136005)(316002)(8676002)(52536014)(2906002)(53546011)(186003)(7696005)(55016002)(4326008)(6506007)(26005)(71200400001)(478600001)(66446008)(64756008)(5660300002)(66946007)(9686003)(6636002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?uqZDCcIHsS7i6AjbyMWpjalDVnXlW87ZnwdUtrQETCZQFrQqcazvLZA19n6w?=
 =?us-ascii?Q?QgZBvCOUYyqldvnJEXb3f8bO4RmpDk5O+e26PEBWOsv9BM1vMoOSrd7cvUVG?=
 =?us-ascii?Q?qXr9R0zSYOH2TVwCAGiI4pcwUvTO7mnV8OyTwdVEvn8puZ1N7V0Qzxt1voT/?=
 =?us-ascii?Q?zJdaO0+UBlgJ+X8Ib3HVTk8vACtVt1418qFlSHzKKGTeJycXrrH4KRZNvG6z?=
 =?us-ascii?Q?UwY8JWCIOTzu8diPNS1CinfWJlj73nsoNaXKyKqCSgzLtqVX6zLVei7dTnEp?=
 =?us-ascii?Q?17sJUo/mdtVonMr8dpchz9qVYH9maD2DsNrulJ5i7afdMbJzKucoO1mkyN0+?=
 =?us-ascii?Q?JGkrLG0ugcwHPg82tgsSRytMfBG74PyutUTkpspUmc6hPnoGT33X3N2ST0HB?=
 =?us-ascii?Q?evT8ip7g7nR5xUhDR1H7h17SnET1sImc82tY4PhJJLLGtW2+gUqbQ4p4pjne?=
 =?us-ascii?Q?C3Q0JELxYF7zdVv0ssdieaaDilAwOGbbmMO+/rJc5A46PgyTaSv7Bnka7jhm?=
 =?us-ascii?Q?a+FBxqDZoKDKc4+CT5ATiVoou6TP1jWGo461DB4tMj7LsaVxYuykrFVP52ke?=
 =?us-ascii?Q?XKlomBxaoFGOhHnbLZdxx3654Pm8KvRUYenSLf/C46V/bjDikvJf2gdPztsp?=
 =?us-ascii?Q?51Tu7vqIqBCPpfTBcAsCtOerklroQmNAdBcW8yDa3XgenXCH+F26+Pn/enh5?=
 =?us-ascii?Q?7E8a9nEyqwj6o7KqOYbClIV0kFIhowat3Cffa7eLfUN1v5NA4jM04CmKJPp5?=
 =?us-ascii?Q?MTDSmKee8w5YsAwcCHwJO62u4UA1jczju6zPl4yopNIO0y/4ibtwGInMD1I1?=
 =?us-ascii?Q?r7oXJ2o2BPs3/fcVyU7IHzuigK9j7XOnpuvxcxHTnQJJ55Y/MrI5BKr2uXe+?=
 =?us-ascii?Q?bt8mlC8xVfcNctGzWR9DdRx6lSAvC5FUfen/DomrwMniqGUH0R0d4tQPTUJt?=
 =?us-ascii?Q?4xlcLfTNyzhgandIWyyjaniBdadTF8FONoY8vbPUgyR38M3oEFcV3UkKy4gy?=
 =?us-ascii?Q?mG0LawFi/lE0EPaBhnPNXstKdjemRdWxIcbMUvrATYUFG8zVgk0TA7RB+UNV?=
 =?us-ascii?Q?OMXVvA/e3oKVMkFlY4p5pncqU5q1FpymYNta4+vS1jiRpQTQ+hKEyJ/YAeWN?=
 =?us-ascii?Q?bA1LUdb64MLDtQ6bQO5yO65VBygTDa2T0j6pMh4hmsACMS27uuy0odd44Ifc?=
 =?us-ascii?Q?Ojr5cc7pb1CQcr6mUiLxWTwhLw9ukQl9/DhBuvjKlZSbi8EJ8Q/dUR2DUBNS?=
 =?us-ascii?Q?L8WedlnZmEiqGRwCzrXUXcQI70S+90ITDLw4zO2O8LejGO6ot1cuLndiCmVw?=
 =?us-ascii?Q?VysfNyuyUjZZgAFEjXQnSzrn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1e6995-139b-4673-7016-08d8df2e731b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 16:56:26.3843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0PWn6wrwyiYyWWBLjp0sWzkN9XAxwusuGPp+9Hvrq7fh44SLi5dBqHDDZzNwvgk4R1Ord3UwJ+cWkoTqQCAwpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2631
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Well, I don't like the fact that PCI_CONFIGURED would have to be defined by=
 each current host:

> +#ifdef ACPI_PCI_CONFIGURED

I would rather the logic be reversed:

> +#ifdef ACPI_PCI_NOT_CONFIGURED

-----Original Message-----
From: Kaneda, Erik <erik.kaneda@intel.com>=20
Sent: Wednesday, March 03, 2021 10:29 AM
To: Weidong Cui <weidongcui@gmail.com>; Moore, Robert <robert.moore@intel.c=
om>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>
Cc: Xinyang Ge <aegiryy@gmail.com>; linux-acpi@vger.kernel.org; devel@acpic=
a.org; linux-kernel@vger.kernel.org; Len Brown <lenb@kernel.org>
Subject: RE: [PATCH] Enable ACPI_ADR_SPACE_PCI_CONFIG in acpi_gbl_default_a=
ddress_spaces only when ACPI_PCI_CONFIGURED is defined

This looks good to me. Bob, do you have any comments?

Erik

> -----Original Message-----
> From: Weidong Cui <weidongcui@gmail.com>
> Sent: Monday, February 8, 2021 7:18 PM
> To: Moore, Robert <robert.moore@intel.com>; Kaneda, Erik=20
> <erik.kaneda@intel.com>; Wysocki, Rafael J=20
> <rafael.j.wysocki@intel.com>; Len Brown <lenb@kernel.org>
> Cc: Weidong Cui <weidongcui@gmail.com>; Xinyang Ge=20
> <aegiryy@gmail.com>; linux-acpi@vger.kernel.org; devel@acpica.org;=20
> linux- kernel@vger.kernel.org
> Subject: [PATCH] Enable ACPI_ADR_SPACE_PCI_CONFIG in=20
> acpi_gbl_default_address_spaces only when ACPI_PCI_CONFIGURED is=20
> defined
>=20
> Signed-off-by: Weidong Cui <weidongcui@gmail.com>
> Signed-off-by: Xinyang Ge <aegiryy@gmail.com>
> ---
>  drivers/acpi/acpica/evhandler.c | 2 ++
>  include/acpi/acconfig.h         | 4 ++++
>  2 files changed, 6 insertions(+)
>=20
> diff --git a/drivers/acpi/acpica/evhandler.c=20
> b/drivers/acpi/acpica/evhandler.c index 5884eba04..4c25ad433 100644
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
> diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h index=20
> a225eff49..790999028 100644
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

