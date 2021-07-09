Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B113C2616
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Jul 2021 16:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbhGIOlY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 9 Jul 2021 10:41:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:57561 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232054AbhGIOlY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 9 Jul 2021 10:41:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="189390913"
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; 
   d="scan'208";a="189390913"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2021 07:38:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; 
   d="scan'208";a="488065044"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jul 2021 07:38:32 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 9 Jul 2021 07:38:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Fri, 9 Jul 2021 07:38:32 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Fri, 9 Jul 2021 07:38:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQVotHgM14fOgBTqWEMKfaExU8aWx6yX7Uw0ZjU4903LUKlFLFTAvy4x74c8q0TWtPwuS4TpeMh8GEu2qERkZal9lEtxFjOprWT/JaUj/1t9vT7JyKhUzkbebHjx1jhDCtq5O9OC6Y8xm8TKQt0GtDC+i8Yrnu+AwCktI7T/6xnw7BqL8UAELcilXggIoTUk+as/ttvnH3Np/GJconHGQyiBOFLJQ6q8y05WRKarMSqhhsa/aAhtQs17JKnQ9fvDVdv21QasfeidGlYCLfN3va/W2CGfK5v7lpZabCcI+J+JP95c9wCW6UjWHzgF/Iak39oNRhtmGsGuxGcNRyhRCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEuLkWXuReMYZ4l1TulUZGC/8uriRVz24/VIvXscVVQ=;
 b=j0TBhaV01wuzFItrpoXkfYkatim7cvotHJpjE6SuyjXhbTClTIX2Xz22+tthZ2u46I/qgk38S1zIMlwCza85VSDAZb44QgEOO89gzx5ygUg8NlcnFBgiqt8JOzR8A3N+/wXNN19nC0JrE+oJL8BvgFGKSMBMyj2zH1xyU8al4dOtpepPSZwOJxCGtlPfarMpzdMPKfDJUs9kE+NN/QUH9BHZRnxNaKa3Twh4Jt3FqQlXWKnHIkHA2Q4OVqIKyCEyngxYmClOhi51tfI6dDAPoHV8xnNUTJHVRkNb2HFhwtGxJ+FJv7CHtNbH4xALrThPQ2mSP9ZfpQh4oQcHjOGcAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEuLkWXuReMYZ4l1TulUZGC/8uriRVz24/VIvXscVVQ=;
 b=Z9cQhXkUiz3sqwiD8mjve7r3DRfzlaSU3k7zu0UwawBheJGCghlKoEMbia7+QGs+lA1UWLhhzal0qoQq/ZtPIgguD/mMRYdiru/EP1+YdVtQtyp/OmEyzLFE+I4UurFULv8HaFSNAdVoQYTuh8Ti2S+P5MgllHmZQpL7sgzx1mQ=
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by BY5PR11MB4353.namprd11.prod.outlook.com (2603:10b6:a03:1b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Fri, 9 Jul
 2021 14:38:27 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::f1f3:ba46:dd24:f466]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::f1f3:ba46:dd24:f466%7]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 14:38:27 +0000
From:   "Moore, Robert" <robert.moore@intel.com>
To:     gushengxian <gushengxian507419@gmail.com>,
        "erik.kaneda@intel.com" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        gushengxian <gushengxian@yulong.com>
Subject: RE: [PATCH] ACPICA: fix if condition
Thread-Topic: [PATCH] ACPICA: fix if condition
Thread-Index: AQHXb+uPd/4bSt1baE6I7fGiwm5vRKs6wEAQ
Date:   Fri, 9 Jul 2021 14:38:27 +0000
Message-ID: <BYAPR11MB32562B564676F3A00DAC5B1C87189@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <20210703091218.650202-1-gushengxian507419@gmail.com>
In-Reply-To: <20210703091218.650202-1-gushengxian507419@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe1f095c-52dc-4089-39cf-08d942e736fb
x-ms-traffictypediagnostic: BY5PR11MB4353:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB4353EB73C00D36619325C5B887189@BY5PR11MB4353.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GqJVYtKtixCoQbEfE4oROltDjcRykXnLkL4Y2bN5R7Ded/nLjCgLVJcTQVzpq5He52ZUe+dXHIJbq8TPdJKARbxnfBSvG094XQbnK2ZmMu494ofo1J6B/bM5dRE0zWd+/l7Au4/2wUr8SFiXnlY6RLInVNv+K5lZm0PCg9GFRrZrGfot2bldhqWru8bZwIzxnEgvIImn4L5uFbWXmX9B2tUbFkN3Gpn7IDc5u+Kk+or5DRoI5UYhNuOdmCJrM/HqiOHVbNtalZR2FwrHMWBppIE/8x9IECw2qO9zAI0R+stFajXeAFz/DOu4xbz6yR3KM7eCq5k+YW3I93lmz04WSnJAwbrk3+lC2gmUrlM0KDvdbdqrJw02SfnRxATSP9prNEaIm0FvBAhH/YVycmTy271pD6jQ+ob3WZIDSYnOwMPqG2KNG3Y0rRQyDcleQU+MDw8H+dRNjfLjBEuBboaTdXkEaN9+BQaSEWv3dzF8YBWMBwV4V23yjlP+cPMoBncc7naDNTkfUpL/qvPSnBE4lMcTG2sa7sgSLYyUzTw0Ess4BPySs9BKJaYLrdOTjSWCKBaLbsYvZn84S3rpcA+G800LJzT/DOqdOJ5tZx6gcTA8WNgLmItDN7o8+I7VVFmJ6bRKqyYVnC3s3ukP6wkjcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(39860400002)(396003)(9686003)(66476007)(52536014)(53546011)(83380400001)(76116006)(66556008)(66946007)(26005)(5660300002)(71200400001)(66446008)(4326008)(38100700002)(7696005)(478600001)(64756008)(4744005)(55016002)(122000001)(2906002)(186003)(6506007)(86362001)(8676002)(33656002)(110136005)(54906003)(316002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Bn5YWb7228Q43HyKbiPoCMW9nwlL0mzrvT20QN4HOJH6DZk2V1yNtw2IwSkW?=
 =?us-ascii?Q?yvyI5I6mlAGpGsbdDdB5D4eayBqk7NyiTR3oIA3atMR4KamZA00yBg9+7VNT?=
 =?us-ascii?Q?hcaA/iP3M3paVlPAcxVpXVlU6OhDkwMVWNm7sM3d9eiLpPhUB5MUcx/RrAuu?=
 =?us-ascii?Q?GceT1qrxzOQSfN6rbkqCZ85K8MgcTqmyrKOlsP5dkGvvPum2l1Q7JCPxmGk5?=
 =?us-ascii?Q?jwXdGJ2vGbVotb7gZegeUdOg1nkUrzD1YZbYqrb3kYbd9ASKwQOT2axxpHB4?=
 =?us-ascii?Q?nQlzyjlz+pPyoCyaOvlhQvAtvFbMJsofe6L0pfz/z2/ryk2byAQLXIg6xIfq?=
 =?us-ascii?Q?zptE7RoF3qmCfcMY+AkvwiIU25j1F5q5CKL/Bd8J7BJYXXSiPFgrpJGfmhJ+?=
 =?us-ascii?Q?EJF7VXUseg+OWUJPZ2GCLu5I7x6b3VKMmII3EhAeFgSi6jh0xrVDGIwtDGwJ?=
 =?us-ascii?Q?2cCrrCabzJdogSeLLPt8yW89T2Qq1l1fiqyErLQwhoydwY5SbvVsakIJ2uAe?=
 =?us-ascii?Q?9tIUzw9WdXJkzl+aYthbyfj2F8XYIaKIBJY69Npn5thnRv54zPR7CoKxGJpB?=
 =?us-ascii?Q?jEtiRels7Z2SegoAbb6ADOJSG0wqL9gFH1jUpJCGXrRLzKAtDMf7r3LRcxsm?=
 =?us-ascii?Q?v/X4+MgEo68mUKqYZvIvxtnEdVz4T4KBYd7kIJEMoRJR6oOiQhlBL4PIt/r2?=
 =?us-ascii?Q?cI1e79BYKgBY3GYvz4+dd2SN22YxkC3UZz6AAc3Vcd60e7fWWmJsGQGlAJu+?=
 =?us-ascii?Q?3aX67xYglxN0X5+4y0D7LKTK9Tkp/yjkIRog3fpbNFoizOMOJ5ySm2Op40QQ?=
 =?us-ascii?Q?rOZPTA0ekDg11dy61yJrYI7PtAOhQ+MXCvCuQWsGaC6PhHeFcm6xrWd5heJJ?=
 =?us-ascii?Q?WQZHHRrlAP5LS9Mp03QtpiOzBAgG23yKsGOKrXJOlmnoVor9V4o6yW1s7r84?=
 =?us-ascii?Q?yuDD0rmo0Ww587s0iZ2aDaWmANa1Lpwg9wemUc5ug3ZJmlNj91i3O2Nw3azW?=
 =?us-ascii?Q?36+eWvlHkFcbmibNtKDf6QR32h1UGhtn8AVcsmDvsBltGlBG3MqIeqYsOjQ9?=
 =?us-ascii?Q?NDEfoysorYXe3cWuBvZoK4homGK1gtH0+VEdtfv56TaUvZkWIRc4iTUsgaDA?=
 =?us-ascii?Q?A0TvtljSdsMVUejXsG6PTcMdk8qb/exPRZom/9RMWwcKo7j3miChMW6lylro?=
 =?us-ascii?Q?XSDIx0nQPSUWVkdzMXG2H8svdr6pCXS/ICStRSqSQ3CdeYlmi/NugPRLIrhh?=
 =?us-ascii?Q?coJHDk0HNTlvX7aPvtjRaIGE+AlALJ+NdmA7Bz/5BwPqIJp2r95f2+EHYy6G?=
 =?us-ascii?Q?uPGHWELy7wioxVdgcIsf1ThH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1f095c-52dc-4089-39cf-08d942e736fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 14:38:27.5839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K2zvYEgXCZyE2FyJoWWHHO0q4Cr8pYtzxeILXU3fYJRJwYGb04u2bs0P+VDRXmhXaErtjS+pMYFDiIynMuNV3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4353
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Got it,
Thanks.


-----Original Message-----
From: gushengxian <gushengxian507419@gmail.com>=20
Sent: Saturday, July 03, 2021 2:12 AM
To: Moore, Robert <robert.moore@intel.com>; erik.kaneda@intel.com; Wysocki,=
 Rafael J <rafael.j.wysocki@intel.com>; lenb@kernel.org
Cc: linux-acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.=
org; gushengxian <gushengxian@yulong.com>
Subject: [PATCH] ACPICA: fix if condition

From: gushengxian <gushengxian@yulong.com>

Fix if condition.

Signed-off-by: gushengxian <gushengxian@yulong.com>
---
 drivers/acpi/acpica/dswexec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c =
index 41ba7773fd10..c4cd61469e1f 100644
--- a/drivers/acpi/acpica/dswexec.c
+++ b/drivers/acpi/acpica/dswexec.c
@@ -561,8 +561,7 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state =
*walk_state)
 								op->common.
 								node->object,
 								NULL);
-				if ACPI_FAILURE
-					(status) {
+				if (ACPI_FAILURE(status)) {
 					ACPI_EXCEPTION((AE_INFO, status,
 							"While writing to buffer field"));
 					}
--
2.25.1

