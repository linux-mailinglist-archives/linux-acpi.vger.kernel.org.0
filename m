Return-Path: <linux-acpi+bounces-2215-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E63809741
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 01:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EB4F281FFF
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 00:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA93E3C16
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 00:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PSuQ5X3z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822FD1712;
	Thu,  7 Dec 2023 15:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701991846; x=1733527846;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yC/W5Ny/GXlXvKhabmHbG3uITaHFgGIqZlWlRImUak8=;
  b=PSuQ5X3zshDJ20lovoeE5DnMOQH1Xuy4D6rHuWqmbYWPCkgjhvGd+yiV
   W3DfQ+uDhfvVu0P6aWLqHcLOMHnWtmu0NOJdodaAHRlyChDUc1FWCENBV
   5+2ZO9JFtcL/cLNxwqz7flIf0vE4/rPzlTlHFqc9w+gZCKXawB6rK5qke
   r2ML8SBErB0rTmFUPsONAfyJ0BsJ1rColtCRA45iLVOpe4G1cHFtUQjFY
   zBFcClwrFnc0aSJI+FTQ1WIGDYuQHM130N1njj72cyZV09QLV++6C7mxO
   pZgQU9+mY3M1nZtCNVqAO2nkIHrL6EiM9qU/K+ZOqhZW7jzKjpjgcZMZA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1431753"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="1431753"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 15:30:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="771924304"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="771924304"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 15:30:45 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 15:30:45 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 15:30:45 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 15:30:45 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 15:30:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D58uknNyQ9DGBjhtcDCRPv2omioYxxKwS7OFXYua8+smFu45ZhIXi3dhhnjNMyJZfEewlWyGjk+LD0ZnoAh4CaodvsiFT2rOUUWK3qqwoz9MgIlVNglENgZcDY81YFHWeYUMupg+7z1JPzNimvhCXiHrE416lyyTCctOoXXxnWFBnul14ZfwqRBxJY4KB7zJmqdzqrrS9/NiD7V2h+tmeGwXQ4DPoBsfZ6Qk1xwARqAcQeAmHsUc5/Ke0fvAZCF++xFfg7ssJfG6CMiidb3J5JRATUCdv5F5xssVh+wW0i5YOLnOyHkd2Cx8HukmG/r+k/mi1zX/rCXMh3/6lhJypQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVUqa2T2Et/h5G4qzaYx3G/rAW7BUVTYGOT1lt9/alY=;
 b=YVnkFfp0llATq9zuveaxVLHcOzqIYh1oCJt8cIxG+WRUi5/MsdW7XH1N8eQ7IL7Z1b3oF8SkwGxxPurz49bCcxKbQPy4uEpsJkRES0za4+8tCtCApUYt1VFKu6ZD3S3xIpC/Ch/uKjUEbU+D33DE/lzMHbB6RA29wuI28/QpvEED4h+aLxFSBPalQskII07U1IS/PyOjk64PdbCEOKcjoqC2/KzrM/Z+2BMzgLpg7KSIshPpOBLQvS6HjDDXPQSNOVYImyQLDXbJQ/i8TujPENJHvNvUkAagz3yiNBIByvKsAF8uehZ/ERvv8H7XHaYlZltjggf2/3IaAqzddJgn0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB8451.namprd11.prod.outlook.com (2603:10b6:a03:56e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 23:30:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 23:30:40 +0000
Date: Thu, 7 Dec 2023 15:30:38 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <rafael@kernel.org>
CC: <benjamin.cheatham@amd.com>, <yazen.ghannam@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v7 3/5] EINJ: Separate CXL errors from other EINJ errors
Message-ID: <6572559e11029_45e01294f4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231128160656.166609-1-Benjamin.Cheatham@amd.com>
 <20231128160656.166609-4-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231128160656.166609-4-Benjamin.Cheatham@amd.com>
X-ClientProxiedBy: MW4PR03CA0265.namprd03.prod.outlook.com
 (2603:10b6:303:b4::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: d99cad57-ddc9-4ace-79bb-08dbf77c8650
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K4RVTRJQxUj/ccXsFSfzlAWehOGbXekg/JNtwXArQnjNuUB5xVIq2EkcOmC7GxqbzlHxUzwWgdXEgjycVLEAagA/UUls5N+hi2lNBxpedyfJGOaVlps6xIGC323TipowP41HO/fXcTc6lgHVJBpbkGGBdTVbCxPmJTPyaIoCov8bmhnW+460FTVMhqs2S8K7OKvX202g4v+Wmo5cuBeh8Ni5PmGcR3P5Rpil71iGSp0fs9WFHC2o5U9xWll2uxFK6xMwATQZOC+DGrQNUR1mCp8htqdF4jIaUs3MVTJTxvdB9LpByJ38QJp7DGX4OiJznlX4ETbrsakx08+uqro15xruW+AZlV99n483KuUwdC77FIKFI9raT5CNAasv7KCVvdg2GBGuJn15zyQUUNM0wh07M+D4J1ORPi21unK7XHIENCRpnmF1iLjz+IsoNyf3jFbCkG2w4ObhMJ22pliH7RjLCVzePP9dqK2iUTZPFwPVbWdF2hr5Q5ZJGLvHWmizRPze7MbKEAsu3e2hUOFeVO2N+aQXn/U8Wk+UA1kNPdSVNL+mnaJjXeDWJnnvflYP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(6512007)(6506007)(9686003)(38100700002)(82960400001)(86362001)(4744005)(4326008)(41300700001)(8676002)(8936002)(5660300002)(316002)(66556008)(66946007)(66476007)(2906002)(478600001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iIEYzA8/tWZOjNpkM6Br3jRBOG/q+Z2c3FrTE1q28CxTuGVKSDDSzUWfLPDY?=
 =?us-ascii?Q?jBIxelGMk62AkN2Ts5Sl/XLO+jwZCwrP9C0VJZwwu5B5K2q2MTm+iJXyXM/7?=
 =?us-ascii?Q?CcptEC1P/yfOy1r9qdVPeQjeC+DbzAbppycAp9Cq1bK3Cun3G5PsJUVX4EJS?=
 =?us-ascii?Q?EOQcpVStebDXX+df1wlctD5dr9vBSW7QLlwoQY82p0zTkQIKzstNzHhoiwSc?=
 =?us-ascii?Q?Rwer/qbJIN2hOEHU07djf5RezHC5bx7P/WNdvA9HCbYeG7pTCg/vE6tCHBs6?=
 =?us-ascii?Q?q2qA2xYB6svAWOJojbxkOclqqp1ivu4RISTD+yL8Y4LCPMy2sxQnf/Ag1fvd?=
 =?us-ascii?Q?o2kRFpijf07bVRhtOhMja/BfCSDHnW7OYccoY0vgvsJvKiE/EjaMTlHlvZZR?=
 =?us-ascii?Q?FKRPSpclBvFfGUD3KlNUlmtWoinnARmaEhmPN7RWmXi5ZRXaJWzadSeFlO+d?=
 =?us-ascii?Q?q/8KqqWA1hhlDioCVcwhUOuR5N/7VZ0v0INxJSghb5lR1r+DHrkgEDnRKpwf?=
 =?us-ascii?Q?ut2zY35/lrKfVadXEioy89vp+6d/FEeDbiGmfEM/PXiGCvqyez2geZ2K/Piv?=
 =?us-ascii?Q?vMgYAbfBt2zLa9sI1bFLQxSc2vD5N2fCbTA961lwZoJXe7f+hjhYIOl7QfPL?=
 =?us-ascii?Q?8jgTV3z3UsY2p4FkepTVZeRrodV2Y1Pm81C96fSVUAP7BmTYkyiYRJei7xcq?=
 =?us-ascii?Q?T6PsEaOU8eqCnjujNkp8tIDMhVM6srd3Jd9tXpPH1TiD4NVWpTeLSXvtdFWg?=
 =?us-ascii?Q?7BrJsA5BBM1Bz+FpQpNKHhvuNQohjZ7h6Nv2pTULd63UXCU+LAX0aqOLeT+r?=
 =?us-ascii?Q?z2IOKOnMzmOG9go1MKEklypQl6b85V09jyfCJt5cH6oJ88RSUUbxkfzbqBcC?=
 =?us-ascii?Q?t1iEttzOS99xk/u124LO595xvRyE/JFHvu3Do1L1jqAloNCM33OGtaYLKSF0?=
 =?us-ascii?Q?SIs/pjefDncxtC1dYug1adMwZ5H4JRWpG9jsSKd152zMMAQAznCMzkR9hr/x?=
 =?us-ascii?Q?rITGWcGiIb2/wcL2CfaeZwemKxRJuK2ozh515Ei0cyp4/UUmCSGqaPCGEcIX?=
 =?us-ascii?Q?44GUzKUjAGakSrVCsUUzKgveTDO0ezReA3Xt57K2vNbyaYTdXF5qRggp9EUt?=
 =?us-ascii?Q?C4v8p15Lm3AX3V6Rnoy5qMrQqkJ9914c6qq7Ldup8oEpf/NhCRHwdnierisB?=
 =?us-ascii?Q?aJMqR4IH7fHj8MB9eEKQVJJNP8w+vPoeaEFtK7qx+UShNi13xNL7rL3zIa7X?=
 =?us-ascii?Q?r/isrbtCpidscdgTbqzkh73gdg/VGBRv5RDc/Ys1qxKyl6+PV3mX6GrRe1Nm?=
 =?us-ascii?Q?0IpXQ/H5ICnDBLzhfiDZFi3X+hpyyXR6Omnvcfpy8rdRCd2MIHNq6182mCoM?=
 =?us-ascii?Q?J3iPlWtuCXffjdFimpYPcpIwbkntNP+PFFnfBLCD+8hQ9rOvt7H1RKyGPxUb?=
 =?us-ascii?Q?Jouo2Qs//VENdZSQ+r09nazuOionP/yai5e3oAgmKoDREeH9U39eaJwMQTXQ?=
 =?us-ascii?Q?6pAZ5A6LPaUbeH2ta63jsx92dNbuam+GV9EGdVuf/wrubq2RLsykCsQsQvnc?=
 =?us-ascii?Q?L8akvCCW1gtyT6XhaG1/CqPOl4sHUn0bUW9Gd1wa4SHy4PskB4Ip4qCqDl+z?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d99cad57-ddc9-4ace-79bb-08dbf77c8650
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 23:30:40.6328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lqP7yWJagwVRoV8pGxN9pZaAu3KLNmxc0tWQ5LMQM9Ht/kDrKGw7Y2yx2Wqb/Cfr/8vzMPYvsftOrPrIvv+ncqIdf41AnQPMU4+z7am9pEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8451
X-OriginatorOrg: intel.com

Ben Cheatham wrote:
> Separate CXL error types from other EINJ error types and disallow them
> in the legacy EINJ interface under /sys/kernel/debug/apei/einj. Support
> for the CXL error types will be added under /sys/kernel/debug/cxl in the
> next commit.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>

Looks good to me. Would be nice to get an ack from ACPI maintainer so I
can call that out to Linus about the cross-subsystem work.

