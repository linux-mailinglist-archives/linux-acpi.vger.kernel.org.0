Return-Path: <linux-acpi+bounces-14211-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7305AAD0B26
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Jun 2025 05:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1761895DCA
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Jun 2025 03:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12196258CF9;
	Sat,  7 Jun 2025 03:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L95d9vKM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AFB13BC0C;
	Sat,  7 Jun 2025 03:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749267165; cv=fail; b=cjuQqtx131ySso/roSrc7onqtOxpZioKbrbrK5Lc6NaeXpXzwH158bTsihPwn4JnCj7oslAwVPxI7iXG5dyYV9fb66Nau1MRbpuCeW4B3/R0Swsdx5OU0SLRiyRn27JuVQgLU8PustZunINzpt4TH2wZiZcq0W6s8ekeFS6tCZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749267165; c=relaxed/simple;
	bh=YR5qQNCrhGecNnHzIhS5kxDaQ/uJtcrty8IC/ZMomKI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sm0AtZr/patMioH02Sq67fzptuxmDxQII9N0CrQn1CMPLTkqmA5ljiSWyVRHDN5Mkkp3AF2/VZR26mavekKZxgksjwZdjxtwHYwhi6gHD+L/WOHt1sJJK0zc201ok6UM7ZbDCcUxnqrd6vAZrO5Pa7HdFp0hAcXSS2ecJDxvjlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L95d9vKM; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749267164; x=1780803164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=YR5qQNCrhGecNnHzIhS5kxDaQ/uJtcrty8IC/ZMomKI=;
  b=L95d9vKM4kUn37u6Xm4bevB6ISI+XTHdIttCs1PJ7/b1jj+gDV02L2yZ
   tRsK0H/qcCua39fhQnoiHSFPnUTykejy9qOeKLSftwdHspumLwq7T1xBY
   0OGUDtJSE6fHYak3kOI8B5aXdFjFxnTNZQH7o3r4dsrDha+0G8z208hxK
   CaaJKmq4WvKtQaa1XjHKnvWD1axNkng+HGZm2OLBpZ3P/SheGQ7+UEi7G
   ERYAJ/5LOgkHRqNhI4ocaAwZT6Q6lxDhU8HBMF0y1QG6X57q13nzuB3Eb
   cqpIFpRqb3wGmIOdeoSXpl5x0ZJb5gu6Sx9M7oVV1EsY5/iS5IMq5dOOk
   w==;
X-CSE-ConnectionGUID: T9y1Gs9YSH+ittOdazQZaw==
X-CSE-MsgGUID: 3lc4zodASMuYPoYV4wbVIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="51561760"
X-IronPort-AV: E=Sophos;i="6.16,217,1744095600"; 
   d="scan'208";a="51561760"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 20:32:44 -0700
X-CSE-ConnectionGUID: xGdTx/iOTE617+Vvg9lr3g==
X-CSE-MsgGUID: mMJXweQETa67X8jQFRAQvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,217,1744095600"; 
   d="scan'208";a="183183121"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 20:32:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 6 Jun 2025 20:32:43 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 6 Jun 2025 20:32:43 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.55) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 6 Jun 2025 20:32:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JtL/p40yisQDaCk7hlgjlvFyJJDSAEGjNGCsyJFWIXiDsLr2B/ET4sO6KAqlD0z1qvTzp5VgAWpuo+rCtMTo1KSmZZGRayAPm8WzCFr7W6ks8IYX0Xo/9hzfD4rN+UthhF1CDxdolItTy1zQHQXTFSp+t06olrxUj2gyClyxWyVDsxC+o8atMeKmUjqPdWZbA/psYzdpgGznsbIB6+z+zAbzhFXPNq+QK16Zmf2BWUkJpkzx2yyhSfjxpIPh7DOUltSAlIGaqa6yIXEEU4vvGuJmu3+SC2SvG6pb8YaiLAzk9xvtZLz9ZpdmdgFYIS9uaHDKGgCENoZcPj3JrZx5ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtB3ccQJf+DzQ4sNtOlIZ/9T5kMj+8yGQSUIaLxr81M=;
 b=XiijAvc6DiYbZiuEwezEDnfrcLJpevMRda3kn4Fxz1b6y4dVN0PZUKY5H1PCcJ+nu4Z5qTPxJztGdC0iWfEVTe/6dgNhQjHxfk85HpNRuYlZJGuqoRXL6IxMl9sLoWa2p+LT+Z83dhhB5CbN/jlZqH/FaXsoKi6YZA06rqk64CzJXgKPhD+8iSqqhuaegQNfIdIP0icpwPQ56YarIAUQLaZKegbrnjf22rO6zQgEfG9sRMWvZ+AZatF3lPIarIfQocEOYk/YqCre24OKLW0Ufm7NotT5ZlU35zRgqq4ckqU5huOS9ZxDfjOCD6AklRFrNtSTmotxwKec3frGTyRGvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Sat, 7 Jun
 2025 03:32:34 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8813.021; Sat, 7 Jun 2025
 03:32:34 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <gregkh@linuxfoundation.org>, <rafael.j.wysocki@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>, Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [PATCH 3/3] ACPI: APEI: EINJ: Do not fail einj_init() on faux_device_create() failure
Date: Fri, 6 Jun 2025 20:32:28 -0700
Message-ID: <20250607033228.1475625-4-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250607033228.1475625-1-dan.j.williams@intel.com>
References: <20250607033228.1475625-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0257.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: 8860e2a2-7e22-4b17-9c5d-08dda573f171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uXK9kF+xiaPDcI298agjulSrDe3phe8nWtCLo78E4VkslCTyhA/lEl4Twx6S?=
 =?us-ascii?Q?6WP+MD1O/yBzbXbwlTlZ8XqwviCnTVdWWQfEk+o3wUU7wfIRIVngjl5dvljK?=
 =?us-ascii?Q?o/8HCQLPSJXiupODDUcqdEgLO8FsSoxQcUNOf05QcVvBXGwD2ZHzH6VHPnxq?=
 =?us-ascii?Q?VqMYEtQ8Kq/qFYf0bFw9j4oYmdU/EkxuNEpg5L89TxRw2ZewW98WH8abXkwy?=
 =?us-ascii?Q?rh+uexNIoTMFPy5hLMofg4rqrZDT0Mo7SwAPJikDmt19Ff9tebMN+b/RvFY0?=
 =?us-ascii?Q?ESQ5hL3Y4MknVjmjjKHhacbzA+PREJrgb4cIvlKOHwl5M/FwVIfyGtirAaDu?=
 =?us-ascii?Q?K/8hJp19Tmh21XkFw/cn/jfGikSJLBvedMDxJTCnmdHU97ohq4vN3eyclguo?=
 =?us-ascii?Q?MgKX6XbQezWfpSFNkDWNnaMs93nGMrAWIbit5+aU27lO2D7giMLlqzBXnWNx?=
 =?us-ascii?Q?lr0dySHP6rAJIl/ToRNOZ8tsrKeaxY+AMqJgrCIs9MFbqA6MPxb5M2noDKOY?=
 =?us-ascii?Q?qA/8WdMK4NEIVTIH7wkPc/rHkrgmxf+X4UyFkuaNpP2CTAKoULhlVbeBwxYr?=
 =?us-ascii?Q?WQmmNgKV9mSEsf85q65GDGwx14OMlQCfsGA4PaDz6yWzZsWeltn/BsyYokTs?=
 =?us-ascii?Q?j0BW493Xst8inasWkJRkmurZg64DX2nZjJKTjRa2evFGcexE3LXZTvwy+u55?=
 =?us-ascii?Q?5WOd0F0VB1fK4/cLgMsIjNUagrkFyuSCAJTtNnrFR7n8m9lX0Fc15E0NG9by?=
 =?us-ascii?Q?eAZozEZJ1ykXwPuyLjeGyGss8Mzj6xfrPMMw2ryoWi5DsfXlbAardVDqUJde?=
 =?us-ascii?Q?F73omAJRCbLtRCcO3eetaC03OvNFI11JEHZX4CIXermSrNzLenyESovL+iIi?=
 =?us-ascii?Q?jIfTw31GECuqSYzCQ+F5hC4G0WXH0SPPTxMLUGbmRRg5KKopt+aoniRCwL2g?=
 =?us-ascii?Q?K9PVEbEWUdkjGFBASag1d8PJJU4zv2EmG8ztG2VcNE/CZccn89lC80gDn780?=
 =?us-ascii?Q?3SRTtZbK8O9yVYoUAytUAqon60NpioAa1LPGQc58925dP0wS1tCll3GBXujS?=
 =?us-ascii?Q?GQBQVgRTP1lLREe+mS1QuyEkJoLFAcZxi0IvoQA2HTNppKyS3DntoJ10Ag9M?=
 =?us-ascii?Q?H7tEImB3+ipKjwHXlcq0FZnILB9tbIUYaT/FS4rbDIMagJfzor6XkekM5pnT?=
 =?us-ascii?Q?hc0JPIrsoN1oyrcqghMhIcOPlgCAGw7XXgPdYh/W0dK00Pe7oyysu1r75ill?=
 =?us-ascii?Q?nXc79DwFWVmhfnN3CaSzMdmuwOEdSfmrm1WAXSkQAXKkiTDHX6ZIeJbLCPkG?=
 =?us-ascii?Q?GFoOHdhiybNHoAvZn0hTD5yOVGU9U39NX3LpBBbmfpME830h9TwwvW9174NB?=
 =?us-ascii?Q?rDY1ZrFt7ha2mC8u5uUKYreQJvMABxA+9DvYqXw6KZe15V+Qx6IufWyIpL3n?=
 =?us-ascii?Q?H6mSsKaF/Zg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6bgx57cV8Oc5L8Kq1u/fqykNe5lM9qmKww4ajrqojQ3a5PBhd+0jfnTGxlwx?=
 =?us-ascii?Q?b7NEj89FB6r4ty/kTE1FGiCfLiL5FKweiXuKIuAO7dH2NBsT+2MPEdSMFjJG?=
 =?us-ascii?Q?iPufg1ZG+ZAl32JpzG470oaJ+4DJRpQduoBJwRlyMxenBntiV46Frktzaiww?=
 =?us-ascii?Q?C9E2LjX5o1BKOg8jI1j6F4xTRP4XuYCplSwTCemrqG0eDPaqNXU+FO5QJjom?=
 =?us-ascii?Q?XD2pVryq9HTYMrPDXRXPxpZcQ6Di5ecShcmPdlmhNyIgz/orHM7cm/EcS+a8?=
 =?us-ascii?Q?jlYWTzeHGiIE+7PWHTRUHmT1jwdWunqKQGZ/zkgniGraqT61k7mWzJ/sQIBa?=
 =?us-ascii?Q?uIhQA4mZ95m23YXabR0gqmvDejcSD59XDxb3zRoLu/l8fLvwYvBkNckrjtut?=
 =?us-ascii?Q?huH+JDg98Ua5irgzWrS0zOUV0Gk04ibgBwwQBEnsAq6cwHkd617RhdKjMDLR?=
 =?us-ascii?Q?MpkRkOpoJ+ReyQkwJg2YDjJffyImjnbRa2jwUZsosUDHnU2MUtbc4sINtPEQ?=
 =?us-ascii?Q?+zUpErn7VNz9NtWEMuZGJSX/ue6h6t+9hKONBZijdjw84thVVFzkLdPH6Q/q?=
 =?us-ascii?Q?yFFToaBPIweJTMQJ4Z+iR8cik/VZhy/RbT63SOq7eQVgBzSY/blCS4zyenYW?=
 =?us-ascii?Q?JPOySJHq/L2/1GbzsITZLr4lVvIEVE85GjAaIBlunntbtQb0yykrcS/Vj4Wa?=
 =?us-ascii?Q?e8tuxmXUmGxQwmEAJDfK9qLYVrzqcAFJg3+kruJUiRRfjCeEjcp4IqrBUW9v?=
 =?us-ascii?Q?o0N5zbVET442RYDWbG5KcKa2drBt2CrwT7feAcwI4V3GA6bai1KihVK2PCMQ?=
 =?us-ascii?Q?GPrOvi8RcYAWslzeg/CP7xtRhlr8GTQK7gMhKuV6hBTiY2z0PrysN8MJ+s71?=
 =?us-ascii?Q?wy60Z4DaaWb2gEcJHWdgZVjhYzK2XpkS4NrOLwWeV7KK071IdPR/H7E8Y7//?=
 =?us-ascii?Q?3NOgwjH9n60pXdxepoVy+lwZj4Z2Eiz7gF+PFDMwW14TFiSJ48TYmVHp5+0p?=
 =?us-ascii?Q?5xIywHHvMadQns3uljI98tcNd/QHoHTWDyZbVQPccGz+zSoNx3pa5gPQG96N?=
 =?us-ascii?Q?9UWIQde2QeYSq5PAzQxD4cq2XiclNJvJo8QkcZRkXu6o83fRvTTaNMzQssxc?=
 =?us-ascii?Q?1uGTWp0nUEpkGrGAj5NoijqFmR1PloDrO1j30fam9IqyOEGONZAUmuX5vsEq?=
 =?us-ascii?Q?+69txLYjJRE2vfnWdITaN7Ht705S7TDfIldGMYlwN8ZBQS1PcsLDXs7dQTeU?=
 =?us-ascii?Q?5ntKmm9Ec5Ulssa3mKekOJEA2PqVSN/fKi8EIRpeQxmjEX+cqeA9UBdmE+IG?=
 =?us-ascii?Q?h5Me/g3tRXYKctwArj3kC4gB5B1iHuXAs+Ki1yjyaPwSocbB6krS0HvquTVr?=
 =?us-ascii?Q?cFFGwSx2khjg7E7o7IXTD6J3FbGa/sdejQwdaOoWg8R8M4JLvVfVVqxJVeJt?=
 =?us-ascii?Q?jYRFccMEIJj+M5Pnvvqeo8MDPJjzNdUAPBfNnAOBPIFug2kf4+M71LamNe2E?=
 =?us-ascii?Q?K0wkzVxbtxl4wIKAjNtf8TQw0+iqKZcMWv0NymqSNbcQx1FFVKOh3RXm1OpA?=
 =?us-ascii?Q?W4aXlMIoa4AnbOPherYBTALX5EHhRWLEK3T2nUJKpWN1oEjifJde4YP3KWrC?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8860e2a2-7e22-4b17-9c5d-08dda573f171
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 03:32:34.8665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vIo13DK2lacMfaw407+QDerY8pHoFgme533rwq0bXg5gNsf9MR7xj+UkslsTteWQFmQO1nGhWAq+OT9UAGVxtf2hGqylqW0t3zhPi8BKXRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6117
X-OriginatorOrg: intel.com

CXL has a symbol dependency on einj_core.ko, so if einj_init() fails then
cxl_core.ko fails to load. Prior to the faux_device_create() conversion,
einj_probe() failures were tracked by the einj_initialized flag without
failing einj_init().

Revert to that behavior and always succeed einj_init() given there is no
way, and no pressing need, to discern faux device-create vs device-probe
failures.

This situation arose because CXL knows proper kernel named objects to
trigger errors against, but acpi-einj knows how to perform the error
injection. The injection mechanism is shared with non-CXL use cases. The
result is CXL now has a module dependency on einj-core.ko, and init/probe
failures are handled at runtime.

Fixes: 6cb9441bfe8d ("ACPI: APEI: EINJ: Transition to the faux device interface")
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Ben Cheatham <Benjamin.Cheatham@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/apei/einj-core.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index fea11a35eea3..9b041415a9d0 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -883,19 +883,16 @@ static int __init einj_init(void)
 	}
 
 	einj_dev = faux_device_create("acpi-einj", NULL, &einj_device_ops);
-	if (!einj_dev)
-		return -ENODEV;
 
-	einj_initialized = true;
+	if (einj_dev)
+		einj_initialized = true;
 
 	return 0;
 }
 
 static void __exit einj_exit(void)
 {
-	if (einj_initialized)
-		faux_device_destroy(einj_dev);
-
+	faux_device_destroy(einj_dev);
 }
 
 module_init(einj_init);
-- 
2.49.0


