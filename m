Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A613CA03C
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jul 2021 16:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238388AbhGOOK2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Jul 2021 10:10:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:59890 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231446AbhGOOK1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 15 Jul 2021 10:10:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="190232478"
X-IronPort-AV: E=Sophos;i="5.84,242,1620716400"; 
   d="scan'208";a="190232478"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 07:07:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,242,1620716400"; 
   d="scan'208";a="495445439"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jul 2021 07:07:33 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 15 Jul 2021 07:07:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Thu, 15 Jul 2021 07:07:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Thu, 15 Jul 2021 07:07:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ev1doja6eC+21ZYreweoam3UNEiyDlE4UdHcNc9B2SpnI56T+ouH6wvfkItf6eob3M1ZiL7SoVPY9Lfx4ghGC2KforbCCVRDO+sb85CBhu08XFBVJaMCHwyLXGL4VuwSSTG9u8VqX3AENFAw+fYyPqCifvvSHmy5DfAN5kufgpmuEf11MMkqXioqPjTghklfY9cZ/vCExPEwl/CZGYp8dJ5viUujVUz3I5gQIE5VCQLwiUfraaHsa9k/CEhJbVlD6ktEh0S8B02AmS5Egzvaj0uHxQ801+JegL3e6cTodVYdArzgtA94gMzyu662+s5w9U2S33tRY+Stzf2IDqBn0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQBdv8XpvtSkWtfTDa6UYa928vjjCK6yigCXiAlstck=;
 b=Nh3jiv6f1fTeR2Urea+NAlPMpcPLWgdaRXXh7LsJNprirl/fkdDmIkhoICB6BYVbpYKDHU+M1m9zUuS14roG73eP2/j+BME7cFfVfdcxDVEg+4lW1lzf4c5MZhm4zgxeRMk51wOYwwP3cJBffkSdYUuclVqhjFZZeH2iiq8JFHUY2DNlKJIXQjWPBXIXxA2sKvwTgQmhmHoDKZfW6zeQqZC/wK7zTY38zacFE8Gxz1ZClLWlPSFyc+67ws0AABfsXKPUwKPi8jKgtixN+TJqvnLIH8xXkn0w1K56vIJmj385Cdhp16RfS/1xlgkN3SA5jAbsraty214WikMdwdMcKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQBdv8XpvtSkWtfTDa6UYa928vjjCK6yigCXiAlstck=;
 b=fJMq7PAUwEwTGvCCrHXktM96iy5+DYYa1/prAWS0FSI/ie1ya9fV/avATlJ3AGK8jGBJHM+GZiRaetdZ7CYIFtTru0uyUlgdbOqTYIGoVe9ntUOZS3O9ah1pAnT4uSP3dCVOt+yb9K7/DnE6BZHhiDJFkeLs7TYvylkz3g/NfYw=
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by BYAPR11MB3446.namprd11.prod.outlook.com (2603:10b6:a03:1a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Thu, 15 Jul
 2021 14:07:28 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::f1f3:ba46:dd24:f466]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::f1f3:ba46:dd24:f466%7]) with mapi id 15.20.4308.027; Thu, 15 Jul 2021
 14:07:28 +0000
From:   "Moore, Robert" <robert.moore@intel.com>
To:     Marcin Wojtas <mw@semihalf.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
CC:     "jaz@semihalf.com" <jaz@semihalf.com>,
        "gjb@semihalf.com" <gjb@semihalf.com>,
        "upstream@semihalf.com" <upstream@semihalf.com>,
        "Samer.El-Haj-Mahmoud@arm.com" <Samer.El-Haj-Mahmoud@arm.com>,
        "jon@solid-run.com" <jon@solid-run.com>,
        "tn@semihalf.com" <tn@semihalf.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>
Subject: RE: [PATCH 1/2] ACPICA: Add new DBG2 Serial Port Subtypes
Thread-Topic: [PATCH 1/2] ACPICA: Add new DBG2 Serial Port Subtypes
Thread-Index: AQHXePnnR//FH/r3cki0IN+Vh3tJWatEEynw
Date:   Thu, 15 Jul 2021 14:07:28 +0000
Message-ID: <BYAPR11MB3256CACCFB4A08B5D450D3A087129@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <20210714214346.1397942-1-mw@semihalf.com>
 <20210714214346.1397942-2-mw@semihalf.com>
In-Reply-To: <20210714214346.1397942-2-mw@semihalf.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: semihalf.com; dkim=none (message not signed)
 header.d=none;semihalf.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3762b71d-8271-419f-a951-08d94799e138
x-ms-traffictypediagnostic: BYAPR11MB3446:
x-microsoft-antispam-prvs: <BYAPR11MB3446718EF5E57BE6440A944C87129@BYAPR11MB3446.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:374;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1HWT/Yxtw0jj9gnvQXHR+kKb/rBiO+r8NLC5Tw8h/g27mmOoZZ+ufHRDsaKLj0OljGqiHSGCw6nezO7KQO5BJnWiHVur7CPTYi+SNnGu6p1mwNNaSA9fs2hC8HYNx45mJiKMI5fbNly0c/yUc9Xij/EOBWD+2bhv4p9k83i5lDmKdWw2UOMVUYAgIwYa9n5lGCAM786rffOEcfzsw0yT0CryrcbnkeRWmSd//pp/6oUpGV2Se35MHBl9IOk1R6w59CrIdcGpC9in+SN1zWmcI3FtkfYyvQ89DeCUIiigl2ThLNKZZdKlgYG732t8+SmcxLhwKYZ3ZAHJ5U+9gjiigS8plI/Ejgj6T5QPlxS4yhCVwS3Y16Y6iltAjir6QYdIcDzOhkDRLY4RPctdzLdg/Ut5nTKsL4C9/pytDBnKCysu/Yb9FVzqy7C0VPHP3eINGDTa8DfZGO3f4YgSdtxd2JzImD0Iy4+To3DB0kNhL2LrCLgzQp/Nnk+QAdCOgoK/JwcOz7kbYsROdgdwUBqL7z+d735Dfo+2Ni+086kAqAroKXvvPgUsTDEW3+0XXjm5dR/rKZCyBqw6aL9OwtLdVtnturEP+CuDvVYXiU1k3uirxYBbIXev7ffAN2CLCTE0BY57HBMjckDP0VIsjADKC5sTYrrRJUTecpK0G9x8BLIvb7nNoAA19SOXwNLukd1821v+PwAO3XbJtV6aREPWJsDnBhXu/4Z6oz6TtYVPDwZ3afeY4Xoib/Jgwl+rjkuw9Fi8Fb/5OxwJqTgdHSdaalgo4LiWywc1qu/5JUADui+ckBGzGkFVYSssFprpDJyZdJyfWVN7CcgxUgDjg3yMBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(4326008)(71200400001)(86362001)(6506007)(52536014)(64756008)(66446008)(83380400001)(66556008)(66476007)(66946007)(316002)(8936002)(2906002)(54906003)(5660300002)(53546011)(76116006)(110136005)(122000001)(55016002)(8676002)(966005)(33656002)(38100700002)(26005)(7696005)(9686003)(7416002)(45080400002)(478600001)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h3F+9zv7A560Iup7AhONYCGU5zBmOq+Wy85jKCkSvap2mkOYM7HsoNYYhshq?=
 =?us-ascii?Q?YGiNK4ZUK4X1vLHKMhMma9yakkWtloKe3v7UBEZUHqWyHwJfOL4j82jaT2Jj?=
 =?us-ascii?Q?axpHxWJayj3577g4xuvcr4li2wrcs7BVqytGJ8NXclKYmVg+6LCzklksa+J5?=
 =?us-ascii?Q?lNTMebGFZu0xWeNqepT21gKMzg3A0o8Gri1g+6jRFQRdh8352Uz3cUgDHhmx?=
 =?us-ascii?Q?9AYjvaoyRkThXxPSSQ4UYjLC3VSJjVZVx3YnydAthdj3jIec1DQ1JdLo0rrg?=
 =?us-ascii?Q?5FXuDUFnikD2X0ngRWAeRjGXl6VQxt/AAiAtAjkKVveMl8WkAA4qtTmRJGJm?=
 =?us-ascii?Q?WWg08hAb7k4w9ZQ0HgWv0IFPs31iZ+QOR4XSf7B11EN+t164jf9jwaBdb5ph?=
 =?us-ascii?Q?CHFMDHfvp764SU8E4UGyYoOrhpaqRx1KOu04+msjQF0/Eb2OBPkYEszTkWBY?=
 =?us-ascii?Q?mmle5WxJ5UtyT3tR/NwB9A3DEYoxpPuTEYzl/nJHxOA56Rf8pK0ptHTbG2TX?=
 =?us-ascii?Q?P2fOfNmgZCD/SyaCYKiBk/Cyp5kp8CHc6s++YSm4Sd2CtVukKOy2ybVAPgXB?=
 =?us-ascii?Q?Grod/8Lt0+PaEAN3EXAOMdmZ+YYdveFhWHLy0s48jWG/LnCR7XZptX/be/V8?=
 =?us-ascii?Q?Rj3FdwrkCFTWvxo/A5dW0MKSwsEcI6AcBPLdwDUl1L4NGwFuQvs9pFBaOkAY?=
 =?us-ascii?Q?BtDOR86KIOs1C2VcMiX2A4Dgkc2VcAWxC87k5yHJB5+DyUzf5FfcAo9+nYTi?=
 =?us-ascii?Q?jZgtt/u6NzCvxFzgs3J7/nrHyuNly3sBj7Cb4WdSREU8JJZNDp2ytz8K8ypd?=
 =?us-ascii?Q?2cLr1+yda1FPjSDtilYd04L/HgrPR2DkBw4vtnusf5zubzlliyIhkye4ahYS?=
 =?us-ascii?Q?CzGIEkKfkgIiLe8SHVVPXOPwaMx8ffyW5Rcfa5IBH7mH4vWRJeJmTlItbdob?=
 =?us-ascii?Q?ZrFPl54OMKn1vhhaNMtuptqpl/RVTlZlqZ5y/29FPcnTv5cwwrCoMfC0qfXW?=
 =?us-ascii?Q?nDwJcM5/IMdkz5uR57KtMz++W5/qvZ2AvC6Qgsfq5FplboL9dpLE426wTyrM?=
 =?us-ascii?Q?YQSGT7qSgkT8wXGMhZFva9XhwN/6MiRtvyBvAFjDQeLQ7CNSGjnRTKW5UEf6?=
 =?us-ascii?Q?mypLlBvZSbTHytXkD70uoHfLDNTkWTcxyUYnnBu1SPTmasl3bPBDoxHUIdYl?=
 =?us-ascii?Q?RoQ0xeDrtYw0iIJ6rpGXDi0fqQeXAzLDWC+IfuYpRRI2kb8f8QbGQaCOwBiL?=
 =?us-ascii?Q?vXKcu5e/JQzpcvCj1EabddfAw+jOXTXmx0vLmT2kefRGNY6avd22C1OXWK00?=
 =?us-ascii?Q?32V5rQcJ8ZbhacOXPSNnwTih?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3762b71d-8271-419f-a951-08d94799e138
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2021 14:07:28.3141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yIaI63kJzqsO/PYoz4CJe3u1TUxgAobJN/bMyjec2KT+kzObUZisHdxPjV2M0MU+DUk9PJPHvnjCyWU2AqZ+AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3446
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This was already reported (with a patch that we've already merged) by semih=
alf-wojtas-marcin

-----Original Message-----
From: Marcin Wojtas <mw@semihalf.com>=20
Sent: Wednesday, July 14, 2021 2:44 PM
To: linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org; devel@acpica.=
org
Cc: jaz@semihalf.com; gjb@semihalf.com; upstream@semihalf.com; Samer.El-Haj=
-Mahmoud@arm.com; jon@solid-run.com; tn@semihalf.com; rjw@rjwysocki.net; le=
nb@kernel.org; Moore, Robert <robert.moore@intel.com>; Marcin Wojtas <mw@se=
mihalf.com>
Subject: [PATCH 1/2] ACPICA: Add new DBG2 Serial Port Subtypes

ACPICA commit d95c7d206b5836c7770e8e9cd613859887fded8f

The Microsoft Debug Port Table 2 (DBG2) specification revision September 21=
, 2020 comprises additional Serial Port Subtypes [1].
Reflect that in the actbl1.h header file.

[1] https://docs.microsoft.com/en-us/windows-hardware/drivers/bringup/acpi-=
debug-port-table

Link: https://github.com/acpica/acpica/commit/d95c7d20
Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 include/acpi/actbl1.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h index ef2872dea0=
1c..7bbb3e2bd33f 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -482,7 +482,7 @@ struct acpi_csrt_descriptor {
  * DBG2 - Debug Port Table 2
  *        Version 0 (Both main table and subtables)
  *
- * Conforms to "Microsoft Debug Port Table 2 (DBG2)", December 10, 2015
+ * Conforms to "Microsoft Debug Port Table 2 (DBG2)", September 21,=20
+ 2020
  *
  *************************************************************************=
*****/
=20
@@ -532,11 +532,24 @@ struct acpi_dbg2_device {
=20
 #define ACPI_DBG2_16550_COMPATIBLE  0x0000
 #define ACPI_DBG2_16550_SUBSET      0x0001
+#define ACPI_DBG2_MAX311XE_SPI      0x0002
 #define ACPI_DBG2_ARM_PL011         0x0003
+#define ACPI_DBG2_MSM8X60           0x0004
+#define ACPI_DBG2_16550_NVIDIA      0x0005
+#define ACPI_DBG2_TI_OMAP           0x0006
+#define ACPI_DBG2_APM88XXXX         0x0008
+#define ACPI_DBG2_MSM8974           0x0009
+#define ACPI_DBG2_SAM5250           0x000A
+#define ACPI_DBG2_INTEL_USIF        0x000B
+#define ACPI_DBG2_IMX6              0x000C
 #define ACPI_DBG2_ARM_SBSA_32BIT    0x000D
 #define ACPI_DBG2_ARM_SBSA_GENERIC  0x000E
 #define ACPI_DBG2_ARM_DCC           0x000F
 #define ACPI_DBG2_BCM2835           0x0010
+#define ACPI_DBG2_SDM845_1_8432MHZ  0x0011
+#define ACPI_DBG2_16550_WITH_GAS    0x0012
+#define ACPI_DBG2_SDM845_7_372MHZ   0x0013
+#define ACPI_DBG2_INTEL_LPSS        0x0014
=20
 #define ACPI_DBG2_1394_STANDARD     0x0000
=20
--
2.29.0

