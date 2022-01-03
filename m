Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B106483470
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Jan 2022 16:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbiACP5q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 Jan 2022 10:57:46 -0500
Received: from mga02.intel.com ([134.134.136.20]:29066 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbiACP5q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 3 Jan 2022 10:57:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641225466; x=1672761466;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ku6OJ/eOSbO2say2fzou5NIOMwMcQ2AC6UIQUi6q3hQ=;
  b=M8EafplMPUk6vEN1iubrBydppx8JMNgqG/5FOQEmQ+8Opp/W7wSPyltu
   sRuLZp+NITTVy4UCzhPZobAlPwy/gOAS+WnS6cUrd2v6u2QRznt/IPX9V
   5j32/x3vZkc4std5Mw7CUk8OhXvdjIWFdykUKu3sXekmIyFOe0Iq9QS1Y
   GsqyiE3sgt1AprjP+apMIPLGzYnFNXr40oEeYm4a/p5qjhRqgV5c180UV
   9jBdIY1QpHvdyHnv6YDkSWOzuiP4h7ccEep4KIrXcCJunloplGEJtY3mG
   +22wXyJLyUDMaQYQtfO85i/NPA4D5OtLewGaa9cUE4lyUl90cp3BvXgR4
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10215"; a="229391408"
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="229391408"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 07:57:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="620342375"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 03 Jan 2022 07:57:45 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 3 Jan 2022 07:57:45 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 3 Jan 2022 07:57:45 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 3 Jan 2022 07:57:45 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 3 Jan 2022 07:57:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OziKVH2bArXrePPNvdnulLc2eKJS2S/9VOU+nt39JASzYAb0KKVW4qLI7UHpmoo2LO89w68tgYFq0xsx7hklVWuUf9IqB44SvN3ULXVHO1RuYysOTHk1qDRQORsDK3dfLUex6H7pPXPBNOOjYsbSKRiDObbUtWplm/TEsvnTo/cP5ITt11Kn50YDqKw+Jcay5Pn0XWLeRnTfydlBexQ2qgJxEqAt32iIWOWBeNYL1OJQRaK38MXJ57wKyPbCu1GTWtzaSPkvuRkhlbZA5MYk0VelkUNeyaxBH4ixph9bsD5+k+x+sSSAkbPRHwQCEvSXyKfATcxG1+eWB7qknG7fcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNOe8SF7KXer7juVtKN3fysqhH2aQnm1+RT79AsYijg=;
 b=RAI8VWlSPcmuSGBO2VQqo91ovDESc9QXXPGqw3ykEE54oJx/wTeWvHTP0OxUyOAjtPf8/OqoEa9R9qFRo+UF4AKiamU3v86Ivsp0d34MVVlCXB2zxMF1IrTzt+HP8AwCKZq0X7fjdOEQZ6jhkYmEi/xxVErW+FN8rikciSkzoWcL5vulkvcPoTc3KxF6tO2otDL9k/VhaBbuKEeumF1Reh+OwhmBtz2ok9bCWFjI78PjbbX76pALZMhGPRY7sgFb4dRMFsBx1Ik2GAsZ7dxjSb64nJHxtaW8oNaQgtpWcl9duQoKXe7AiVtM2aPvY/6gFZBnUU8u4jv+VmnCp6bj2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by SJ0PR11MB4877.namprd11.prod.outlook.com (2603:10b6:a03:2d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Mon, 3 Jan
 2022 15:57:42 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::6d1b:52fc:309a:bff7]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::6d1b:52fc:309a:bff7%5]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 15:57:42 +0000
From:   "Moore, Robert" <robert.moore@intel.com>
To:     lkp <lkp@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [Devel] [rafael-pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 8d681a5245f0a5cfb20326b4f6578af1adb8676b
Thread-Topic: [Devel] [rafael-pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 8d681a5245f0a5cfb20326b4f6578af1adb8676b
Thread-Index: AQHX/H2m2F4SRWODu0u8RazBbhdytaxRfDHQ
Date:   Mon, 3 Jan 2022 15:57:42 +0000
Message-ID: <BYAPR11MB32566B65A82D815C214720E487499@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <61cc007a.mWwpG8hntz2tC9i6%lkp@intel.com>
In-Reply-To: <61cc007a.mWwpG8hntz2tC9i6%lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dafd8301-f086-4065-5d67-08d9ced1c6a9
x-ms-traffictypediagnostic: SJ0PR11MB4877:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR11MB4877B947EEFDF7FE4C2D5C0687499@SJ0PR11MB4877.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:43;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 46gxumntrPnk5ARqtei4/L5bvViXe4vPvUZrVFqOlcmF7iLfPI4ThdkoLsF0bjAlN9ATLmqpNCz3O/9FJltO1Ry3hcryYiviboSzHaZDl3/wpmgpW2T0cMXibsOJ3Fva6nAnj+LBeAp4X1/k70lVfFX1iSg/2E1O+/u+Gvgmi+tCoYfWe+1YhKdFU1X3w1y/B4bt9esZi7TeXUUEDUjopguEblTQxVTruQ8G9EdAmwInsR/BOOMkT6zVnpQ+jarHgLvUKk89IYVqNcHv0R1T4tYeHMbMYjIxmZbIv18zTAjMe4FtbG37/vjUZ86DF2yeDKDERZJsfdtrSqPxYzUhB7a2oUNfaMHmSq3ukCzJ/vbUhEf2YCKNxkgYjK1FW3Up1oY6VS+iVe1b9w/Zc0UFR1qSpGCpUaTClJM3aucrf3/GPbOl1y5pOFvo5hEFX5cyM+Qc85xgrkswRZeoBjFPgingS5qELPluiNEq1ecfM8X+AV6WN67uMZZYuE+ni+Nlq7GoULMybMlxVpI2fwhAe13pWTqjAg4WgHkn250nqXdy7Ci6Tv4JULk57OQxZZL9srSc4s+RRclGGcKd3MDKzMaPAyLHTTSgyi5YGJ+ptt4so0HsSRVblDwNzXb+mRuCDUeqDFcWypoMvxTmnHcNHMZ8Rdv8H6ew/YDfkanqZAaMPyNJ2f4L4u47RbaRSQaJBzWgmJJJoziBsE5rshGsNTlwFStWcGCnGg3on1Yq6nGNI8snswRybybYcI45yUEYH6CjtTHYHfnSb0rQwO8n8Yr06NHCucKhTzZLvqDbDIk8QuuEQerSTpggQBMNhvyugdOHplpQS8o5ewvQo2h4XA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(38070700005)(9686003)(82960400001)(52536014)(83380400001)(4326008)(316002)(122000001)(38100700002)(71200400001)(5660300002)(508600001)(966005)(54906003)(110136005)(76116006)(86362001)(66446008)(64756008)(66476007)(66946007)(6506007)(66556008)(8676002)(8936002)(26005)(186003)(55016003)(53546011)(33656002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e4c2BVh7r8nPTvxKD5RubW2HUJAX6lyOPhdBXfXgjPGNQTy/mPC1IREf4n7i?=
 =?us-ascii?Q?L2HGxymq+Y8aFnGP2koWr432CCBcf6tp1KoP3wVBm1mID9l7Vy++9Z6Rnezu?=
 =?us-ascii?Q?ORCzmFQ7bIEv3R2i8245aeA0lKuUGTljvgv3bnmXz/Nibk94xuzBsApyBUPB?=
 =?us-ascii?Q?23/Up5/sqD1Io7MFSt3MCS7yH7fDpAJ7B2ZP8AMt5qEvurJ3mVK3F750hb0F?=
 =?us-ascii?Q?ybznxm6MKGu/ghl7hnwotWBZ0a6+cHt3jBIPEnyqGFNLwcDqnfvlT9/qQeuF?=
 =?us-ascii?Q?4y+II5c6F8n33vnTWxdbef+Qm7I0fntDWXyHz9zABmk74qQW6EsUB+ggj77Z?=
 =?us-ascii?Q?AuBvWoVy3e/NmWxV2JtmB2yKztM+SbRfabw1NJDeAGofIHWvV7tnMwP8G2I5?=
 =?us-ascii?Q?HbppqLu2mwGo39XEiKW01yk2XXCRrR++pJvJ7XLeJx2OiGM3OrM4GfUmYxBr?=
 =?us-ascii?Q?SVA8fd7vlmqd1Sj1teLdlrl8BmEvv1pkpnGn+NLN2qfAOq18Rpw+zlwyzOoO?=
 =?us-ascii?Q?wlhDQWXVutIFdDlHIa4C44/89GH2FqrQiDfKSBQlTAkS/pKFMocC9FmT+9Ua?=
 =?us-ascii?Q?yVOxaJai/cQNe7iYG+D/OLbKn82l/DV6lacMRjKmfBThNWxm7LeM6oJqynvR?=
 =?us-ascii?Q?lPln7qxNlzSl3EsBVkNov45/3XtnvQhP67KCK5oCyvDFMAC2gWLphMO+ZEzq?=
 =?us-ascii?Q?6/7O2Nqe464TRPmUC7z1BcLA8r9dxerheta6vqQmMDxHj5U1rBQVQIj7iGDW?=
 =?us-ascii?Q?QXaKuVU/Gl/F6HoAiGkm40dJ4ebFLiPNA+X/ScIk8USjz7I4sjiAZMKGJNNl?=
 =?us-ascii?Q?nV/VAz9lE6gvMi7asrUByAbscVeHwDZo/eOwV3kKSzd4L2rlanVPx2c5kvk8?=
 =?us-ascii?Q?GECqkHhBm/eCGzEla0cc/Gfxr8MWS2LRo2P6cgcH39igUn3lTJyklESEt5Qa?=
 =?us-ascii?Q?CWfpkYak7LG/1SbktBjADO8S6xhBN7J5k+uSVfeTDg1ul/UsYEcXWo8nJB+3?=
 =?us-ascii?Q?RzZ+G2TIuGmXBZu33WA0AtOSBD3zgIA+Ac+a8GPPhokTIPsPAhvTz5t2lF3/?=
 =?us-ascii?Q?BJsoqRy2EwWX7lAu6Xx++ysno2fUn6JvoymPsj+Eb4YyDTCt7rtfaxCrgzkg?=
 =?us-ascii?Q?LHRH5Ay2ULI+uJtqm0J6roIKQlK4SbDwARQlWlx1QVijiScaC4woRz/M3vOd?=
 =?us-ascii?Q?YQVYGaw/lDXksHC5GboZfYQsV/0vIt3xHDFR4DZXfvOq5R2wji4+xPVasVtt?=
 =?us-ascii?Q?RiDgf7sIAwxYcH25qCpsWpeBJ0X2uE2FjBfUtMKXNXAl+R7/Nr+O6tFtKzmx?=
 =?us-ascii?Q?PSeHXkCiVftPinnS5VTYT5RZLvPTSMSj6/wWqbdI2cJp6UbBYlI0qFy2JGhq?=
 =?us-ascii?Q?Ill3i4T2sxOD6Cmo1Nb9uR4sv0PmTdEz7y0WzdR5Tm5mKmR9nn1A9pEW2HJc?=
 =?us-ascii?Q?3dOBs3GrC6iHBXpzNYrbVSpGZPODE5FJdYPt+/ZNKNAEF328S2tRqlouXk6Z?=
 =?us-ascii?Q?KeGVV0o5gq19LLnZaBSbX734hD8lfNy8l5d9hkW7T66eupj0ItUwSvh2GRYx?=
 =?us-ascii?Q?7sqUILx2msDOwqE2qY2oZnwKbujq926LJTGKvTos07X1Z+zsTJvVdI0r6Z10?=
 =?us-ascii?Q?YpEk9kew5LNPh6KIGGwWYK8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dafd8301-f086-4065-5d67-08d9ced1c6a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2022 15:57:42.4704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yvib+RxDHl+2U+uDCtUYAnpWl9ynbZSopFmjO5Ec5HFyBl9KRGZyDUkfVKM7EVJcVXd7pWX+xFNe18IrdIzg6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4877
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Are these new warnings, or legacy warnings?


-----Original Message-----
From: kernel test robot <lkp@intel.com>=20
Sent: Tuesday, December 28, 2021 10:30 PM
To: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org; devel@acpica.org; linux-acpi@vger.kernel.org
Subject: [Devel] [rafael-pm:bleeding-edge] BUILD SUCCESS WITH WARNING 8d681=
a5245f0a5cfb20326b4f6578af1adb8676b

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-p=
m.git bleeding-edge branch HEAD: 8d681a5245f0a5cfb20326b4f6578af1adb8676b  =
Merge branch 'acpi-sysfs' into bleeding-edge

Warning reports:

https://lore.kernel.org/llvm/202112280907.gTYYYuB4-lkp@intel.com

Warning in current branch:

drivers/acpi/acpica/exregion.c:519:17: warning: performing pointer subtract=
ion with a null pointer has undefined behavior [-Wnull-pointer-subtraction]

Warning ids grouped by kconfigs:

clang_recent_errors
|-- i386-randconfig-a001-20211229
|   `--=20
|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a002-20211229
|   `--=20
|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a003-20211229
|   `--=20
|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a004-20211229
|   `--=20
|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a005-20211229
|   `--=20
|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a006-20211229
|   `--=20
|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a011-20211228
|   `--=20
|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a012-20211228
|   `--=20
|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a013-20211228
|   `--=20
|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a014-20211228
|   `--=20
|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a015-20211228
|   `--=20
|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a016-20211228
|   `--=20
|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-a001-20211229
|   `--=20
|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-a002-20211229
|   `--=20
|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-a003-20211229
|   `--=20
|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-a004-20211229
|   `--=20
|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-a005-20211229
|   `--=20
|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-a006-20211229
|   `--=20
|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-a011-20211228
|   `--=20
|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-a012-20211228
|   `--=20
|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-a013-20211228
|   `--=20
|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-a014-20211228
|   `--=20
|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-a015-20211228
|   `--=20
|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-a016-20211228
|   `--=20
|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-r012-20211228
|   `--=20
|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
`-- x86_64-randconfig-r024-20211228
    `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtracti=
on-with-a-null-pointer-has-undefined-behavior

elapsed time: 725m

configs tested: 104
configs skipped: 3

gcc tested configs:
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
i386                 randconfig-c001-20211228
arm                           sama7_defconfig
arc                        nsim_700_defconfig
arm                            qcom_defconfig
arm                          pxa3xx_defconfig
powerpc                   bluestone_defconfig
mips                      bmips_stb_defconfig
arm                             ezx_defconfig
sh                           se7343_defconfig
powerpc                     skiroot_defconfig
arm                         lpc18xx_defconfig
arm                       imx_v6_v7_defconfig
arm                          pxa910_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                     pq2fads_defconfig
arm                           sama5_defconfig
arm                        shmobile_defconfig
arc                    vdk_hs38_smp_defconfig
csky                             alldefconfig
riscv             nommu_k210_sdcard_defconfig
arm                  randconfig-c002-20211229
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
arc                  randconfig-r043-20211228
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64               randconfig-a001-20211229
x86_64               randconfig-a003-20211229
x86_64               randconfig-a004-20211229
x86_64               randconfig-a002-20211229
x86_64               randconfig-a005-20211229
x86_64               randconfig-a006-20211229
i386                 randconfig-a002-20211229
i386                 randconfig-a003-20211229
i386                 randconfig-a001-20211229
i386                 randconfig-a005-20211229
i386                 randconfig-a006-20211229
i386                 randconfig-a004-20211229
x86_64               randconfig-a013-20211228
x86_64               randconfig-a012-20211228
x86_64               randconfig-a011-20211228
x86_64               randconfig-a016-20211228
x86_64               randconfig-a015-20211228
x86_64               randconfig-a014-20211228
i386                 randconfig-a012-20211228
i386                 randconfig-a011-20211228
i386                 randconfig-a013-20211228
i386                 randconfig-a016-20211228
i386                 randconfig-a014-20211228
i386                 randconfig-a015-20211228
hexagon              randconfig-r041-20211228
riscv                randconfig-r042-20211228
s390                 randconfig-r044-20211228
hexagon              randconfig-r045-20211228

---
0-DAY CI Kernel Test Service, Intel Corporation https://lists.01.org/hyperk=
itty/list/kbuild-all@lists.01.org
_______________________________________________
Devel mailing list -- devel@acpica.org
To unsubscribe send an email to devel-leave@acpica.org %(web_page_url)slist=
info%(cgiext)s/%(_internal_name)s
