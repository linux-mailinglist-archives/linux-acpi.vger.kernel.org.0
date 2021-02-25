Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48E13257E3
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Feb 2021 21:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhBYUqm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Feb 2021 15:46:42 -0500
Received: from mga14.intel.com ([192.55.52.115]:40980 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231881AbhBYUqm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Feb 2021 15:46:42 -0500
IronPort-SDR: txQA+lmNJWCaMFpLhtye74TUaFuQ2BGlYZmJtxr33/rkCXP7HfGAEZp1fZtzDA6ItscH/2AuCF
 sA3R1Qla2bxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9906"; a="184976362"
X-IronPort-AV: E=Sophos;i="5.81,207,1610438400"; 
   d="scan'208";a="184976362"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 12:45:59 -0800
IronPort-SDR: aJA9bFIEoh1m01yJi6v84+ua/3JceqFvdRS1Cpwh1uiYNRj31v9O+5dEC9oZ/g9NZeL+77SXMK
 6Zmc3Ht3DpTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,207,1610438400"; 
   d="scan'208";a="392564654"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga008.fm.intel.com with ESMTP; 25 Feb 2021 12:45:59 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 25 Feb 2021 12:45:59 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 25 Feb 2021 12:45:58 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 25 Feb 2021 12:45:58 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 25 Feb 2021 12:45:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6+s/J82sSlsT42Fyv3eeiVnB5twVuWFUogN8PS5psNXpGddzbgIhW0PE6TU+d5d4urKdiznQ+DVWuUtJ9KvaZTcs+fYqQHDdGOBjvSZ9SPY9IJifZdxeYy0HzTDinKGAdur733nIMrU/dHJEVJ83BH6SL4oZBwIzFRoBapXobQ3vYqcNvtgC4rF1JbsXmzYeIqv5ZaaPWEkODEBWaro6sVjDVlDjtb3wBpSlMhkZFkr8wMJcdFzQFH53m2gaOQpijtREv5vWGzbCDE2nRaOorQxrxDo/lac8ZtlMq22rVpHEA1yKb5aQRFn7gd0Incu5rBGryCOKbKZzReHt2LeUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qU3qqGJztnyYX4eUlt4+HN4YXrheRl82Jen1zbITXrs=;
 b=Nlj2tyfdeib642+l/Kt+/b4a/LqoYh1vwzJ98dU10D8a2X9R7mSCqfysLOudvAOyLcwYezwXfjrspxdVjIVrGRWwHdGIF1/DRa6J4t+XO5z+NdxCP9ClvRzqaXjTtj4PHWyJIjWG9NxUgiaumHCr1a6BUiiJ7T/4r7wi+lPT5TWHMCuh0kYheCXX+Q4QTvuTFZriZ8OitWdinJ5+Gi7NOdXIFu8NjwjDD/+arg4V1GrZyW/PRBL7L01a+xxtpI/NDYuMa8xeyqkoB/yj/I0RfPjA+BhSbQLLOyOyJl06lqeWgMYB7B+IJdLF4YJ4CkShK7AnDWYlPKq1jivn+GC84Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qU3qqGJztnyYX4eUlt4+HN4YXrheRl82Jen1zbITXrs=;
 b=RsfBnTe6+UJU/gGlni0gJfanWWGKoUn3YJu3/bxIJiq1PRt/g3kdR2adOK6N1lxNIuYOnJN/1kzM92EJOJvinL1p57g/tQVvUX+bb/Oya5BwzOTvukvnIVNaNiuTc7o+nNveE3zte8XEkrvxlOWnJJ9TUx5oTOt9/dU0/3YUTNU=
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by SJ0PR11MB5008.namprd11.prod.outlook.com (2603:10b6:a03:2d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Thu, 25 Feb
 2021 20:45:56 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::ac1e:2d22:3f90:4dc]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::ac1e:2d22:3f90:4dc%7]) with mapi id 15.20.3868.033; Thu, 25 Feb 2021
 20:45:56 +0000
From:   "Moore, Robert" <robert.moore@intel.com>
To:     Zenghui Yu <yuzenghui@huawei.com>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
CC:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>,
        Kunkun Jiang <jiangkunkun@huawei.com>
Subject: RE: [PATCH] [ACPICA] IORT: Fix HTTU Override mask for the SMMUv3
 subtable
Thread-Topic: [PATCH] [ACPICA] IORT: Fix HTTU Override mask for the SMMUv3
 subtable
Thread-Index: AQHXC2kwib+gFmscGEib3bZcV79rGKppV0XA
Date:   Thu, 25 Feb 2021 20:45:54 +0000
Message-ID: <BYAPR11MB3256E28FD567C5FEB0EDCA94879E9@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <20210225112620.1827-1-yuzenghui@huawei.com>
In-Reply-To: <20210225112620.1827-1-yuzenghui@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ada872a3-6631-49e6-296b-08d8d9ce5981
x-ms-traffictypediagnostic: SJ0PR11MB5008:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB5008CF2B2ACBA4B91D72B106879E9@SJ0PR11MB5008.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tm9LUmr6kKQFZux2ggGF/qdPUVjLKeGyvuCXp1qZ7AyYx46zQE9BRXkx5wCB/DMxLo01V/XCbGqAcJDl5GXqpqDd12nvv6o0BbzaG5XN3Q5ekNeW/PIav4n5hqvAEVYC40Ni0irX6joDyIkoZCAcB6ccLjDbG5nQkNUWIc2ntoLkLyvWPgvmnYs+LlpxbwPNde6LA28muJlhqeXdJAUsIsfnYGosatAHprwKOQoA0pEE0d6ou0L4yrP9aWzKuYs6lF9unJfnX2x95pE16NQ2dUwwkpME6JOL9tPI04jef9TX613Wp99eRwAvbN1omvsj/eJzz2nJBV3LfJIQ9MMQnmtLr9ZBputD8gdB1QaKiRT/Xf1PWFTaeb5pBG9pgTU9WKjj1Evc3Rrq/zhMzcquU59SZ8UC7I+spp1foF3zoQ9XA0JgwzC8m+vWEgWRkF4ZbGjwU0278CxU1STGp2wioo5/9d1uLaOb9IAyT37hFGyYc5Ykn1fqmOyheclNHYyAq2dR3AI1aaNZBlp5rQx5nA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(376002)(136003)(346002)(33656002)(110136005)(4326008)(8676002)(8936002)(86362001)(478600001)(9686003)(71200400001)(54906003)(2906002)(76116006)(64756008)(53546011)(26005)(66476007)(66446008)(6506007)(5660300002)(83380400001)(186003)(7696005)(66556008)(55016002)(52536014)(316002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3e9aYdhOmkK02BNBPXAgCX4ydCN+oTb10l1PKVVA/LIYLhM6T+P//xxSTSm3?=
 =?us-ascii?Q?SxfGDiSd4mwhbnW5hOLrfkx15OIMteO3moaVbEU0wA8cIW8GFVTH3fRXPXd/?=
 =?us-ascii?Q?p7GvRKZK2LkUwEaJdYEJJuPRsWws0E9VDQJBFssk9XkZ6eIwQziyflXz2H1H?=
 =?us-ascii?Q?ZVnBmfPscgaKTzIFpPcNNNi/lacz8mSkrQ8zn9KC7PIFKcvu8Mnd2PhidFMf?=
 =?us-ascii?Q?XPzM8eYho6m8TQPj2cG022rDGqu1+MAGccEvf/MdS/2W3/DN38so3112QSnd?=
 =?us-ascii?Q?GOxVchLBoIbI8bAdqvWNO8VFrDoUw/2E7R/O1oFIGws7AUFV38BdNGB3W1Px?=
 =?us-ascii?Q?t/GnX6ad16+vHd2SjADvu+W/sfcUUdeB750axgd6OHqyZQziXprdjcWncKB5?=
 =?us-ascii?Q?L6VuFI8349tBlaYAE9zfJ3I3+nKs64zS5D+zag6U6jnMaJmbG6I58o/696f/?=
 =?us-ascii?Q?/lgH0w6zqqjgyvi5F2B4DwTDoPem+jkcvmSBzEt4PDs2WTnGY+34XyNFfQdl?=
 =?us-ascii?Q?1YfngyGNCbmRyG3GMTJCHnCJvjCsgFtT15BklYJqKxLQUdS/E5Q4xDGQw2Y4?=
 =?us-ascii?Q?ixOAY9GMHu5yFsBVKIW1lgT7PpvlgK5KWKsuuAGQYxiLJTpb1OueDEA4zdSP?=
 =?us-ascii?Q?5KHh8J+DB+lSB3tBlIa8WiOaY6imoJq8ZTZyP7hQyROtQdW5nYGMWXldlp1h?=
 =?us-ascii?Q?votxnyBOuiHzZhOMKqVRuIhc8rvYhV25oortLQyXsk/mTJWHRQZH6xRbbvpC?=
 =?us-ascii?Q?0+yP9UAtg3xpYRJDP0Cq6Ff1NWIG5BjWIzEvCTt0IxcHS1Msv1u8jjPBoNpp?=
 =?us-ascii?Q?8le8XS8Jh1ZaZjc3jVahjFl+Rhtm+Tspyv6ff24N+McjzmJUQ8GVWETcH3or?=
 =?us-ascii?Q?Rj8gL6qhCCzn1MsrCnrTDJZGI5TjF3vE3R1YGrximxKjHYiTjeJVkqSG/5nt?=
 =?us-ascii?Q?MEUzdQfDA9WglnKYXnS4/BkXfCgAujnjr7irfjXjm5A1NLOD/YaP1kN2i7kf?=
 =?us-ascii?Q?fCgPo48TUpLEBz5hdmuHJYa5Q9TxNAXqico0rqnHfFJ++rOgz380SyTn6TWA?=
 =?us-ascii?Q?o4O+l91Yw1zPt/BSVJp8ggeefathibYRETqpoK8qjxpt/4dgFInSX9LtY44+?=
 =?us-ascii?Q?Ee4pg5aoFYxP2US2eCf3M1dHD9bpTetodNbKpSZ6IzEFjcuAsNDVpJy2FSoS?=
 =?us-ascii?Q?j6j5NQWrehI0Wndnh09BCws32Jm92iuL5GOv688GSzF7codyhaTy9EkTlxiA?=
 =?us-ascii?Q?7iD2cW3gHdcq6u5E28dJi5lKCtaeg21OlUJ16uY11e+x6LNobj8fO9Mt38bk?=
 =?us-ascii?Q?/vQYFnAcezD+Q4wn01U6QTUF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ada872a3-6631-49e6-296b-08d8d9ce5981
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2021 20:45:55.1527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jFWYMwaO43gjabwfpC0EVUjpOphlHkwCoZM+uqZPu9NjGL2+aSwk9OrGO1I5MH/y5lQ4213czsjo5uv8KVdreQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5008
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

If the field is two bits, I think the ACPI_DMT_* symbol should be ACPI_DMT_=
FLAGS2, not ACPI_DMT_FLAGS1

-----Original Message-----
From: Zenghui Yu <yuzenghui@huawei.com>=20
Sent: Thursday, February 25, 2021 3:26 AM
To: devel@acpica.org; linux-acpi@vger.kernel.org
Cc: Moore, Robert <robert.moore@intel.com>; Kaneda, Erik <erik.kaneda@intel=
.com>; robin.murphy@arm.com; Wysocki, Rafael J <rafael.j.wysocki@intel.com>=
; guohanjun@huawei.com; wanghaibin.wang@huawei.com; Zenghui Yu <yuzenghui@h=
uawei.com>; Kunkun Jiang <jiangkunkun@huawei.com>
Subject: [PATCH] [ACPICA] IORT: Fix HTTU Override mask for the SMMUv3 subta=
ble

As per the IORT spec, this field overrides the value in SMMU_IRD0.HTTU whic=
h should always have been 2 bits.

Fixes: 9f7c3e148f44 ("IORT: Add in support for the SMMUv3 subtable")
Reported-by: Kunkun Jiang <jiangkunkun@huawei.com>
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 source/common/dmtbinfo2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/source/common/dmtbinfo2.c b/source/common/dmtbinfo2.c index 17=
a80ba21..321f106fa 100644
--- a/source/common/dmtbinfo2.c
+++ b/source/common/dmtbinfo2.c
@@ -343,7 +343,7 @@ ACPI_DMTABLE_INFO           AcpiDmTableInfoIort4[] =3D
     {ACPI_DMT_UINT64,   ACPI_IORT4_OFFSET (BaseAddress),            "Base =
Address", 0},
     {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (Flags),                  "Flags=
 (decoded below)", 0},
     {ACPI_DMT_FLAG0,    ACPI_IORT4_FLAG_OFFSET (Flags, 0),          "COHAC=
C Override", 0},
-    {ACPI_DMT_FLAG1,    ACPI_IORT4_FLAG_OFFSET (Flags, 0),          "HTTU =
Override", 0},
+    {ACPI_DMT_FLAGS1,   ACPI_IORT4_FLAG_OFFSET (Flags, 0),          "HTTU =
Override", 0},
     {ACPI_DMT_FLAG3,    ACPI_IORT4_FLAG_OFFSET (Flags, 0),          "Proxi=
mity Domain Valid", 0},
     {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (Reserved),               "Reser=
ved", 0},
     {ACPI_DMT_UINT64,   ACPI_IORT4_OFFSET (VatosAddress),           "VATOS=
 Address", 0},
--
2.19.1

