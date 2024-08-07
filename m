Return-Path: <linux-acpi+bounces-7428-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 782C994A8C7
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Aug 2024 15:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F09571F215F9
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Aug 2024 13:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EBC1EA0B4;
	Wed,  7 Aug 2024 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HTbTOrRH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106901E7A47;
	Wed,  7 Aug 2024 13:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038095; cv=fail; b=dN1P07ghfsTtG+p38JA92SnAnZBpUjwxIHKkSRJMbOpMogQrBHqSTkjwRzZtODEma7I9hj1y68PpsRSgr/hMho66WeMa+S+ivlsjKYV0H0pspKAL0CrMvgOVimt1QgVGMGdAButnLMZ3g4tPuLyrDv8c9NQpOCDsO9rEM4UNaxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038095; c=relaxed/simple;
	bh=NlqPaf0estw6Tij+eEM6lQwwdhse+nqM9tsQ4MBAMNU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Sl3PSSQAGObU8vGbBNtMqNRpItXZJ1ZLQe4jIegywRiUh4V9jXBLwZvVUrxpY2nU/+OIGxbiuXraVD/PBSHSr4li95mbOrAvANUHRWOF53L2jVvxvMVRg/+U+pp4HDad91VjxkqxjjiyTK5oBbSFqy4SqEBMC3lVTHwaurF/cLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HTbTOrRH; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723038092; x=1754574092;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NlqPaf0estw6Tij+eEM6lQwwdhse+nqM9tsQ4MBAMNU=;
  b=HTbTOrRH8D4Hx2YGU8Qds4P+7YIuVfbTRPAVdeF4hEx0bZ/6u6xq4F9R
   MOdYrL8QtTCow+Dl1Nf+HTfaILQAR33a1gGq3ujSdfpdbDKyxisvB2NQf
   FvtD22jV0Mbe9RmoIJc6sOLOIwuzFfFhU1aexPJnNk+iuh3mSJDDg0jON
   voqYvPS2K3v8YaRR6Ms2uodjQ1dSbMJgsaJk16Bc6mkJAtkaS8yoFnLh/
   utJkrMFmdM97ciuRdXe5s9Uewl4KylzUzRYz2PFt9o0L0zW2+KSGYa9LM
   2boWHPOx+EJm4th/rFxrmy/7sXcHgaLPg3nZt0e1WqvfHwQCq14DoCEHu
   w==;
X-CSE-ConnectionGUID: VBYpOvhBQJidtGVMLm370Q==
X-CSE-MsgGUID: h8nmVNHIRTqtZvk8rQ1J3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="20963140"
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="20963140"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 06:41:31 -0700
X-CSE-ConnectionGUID: oN7ahIOOTMqpdG/L0tfGNg==
X-CSE-MsgGUID: zhTK4LkmTMCY9URRENP1mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="56801868"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Aug 2024 06:41:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 7 Aug 2024 06:41:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 7 Aug 2024 06:41:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 Aug 2024 06:41:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ViDPZk8xSW1NMDZ/6JXlnEorwst1dcxAsc6RnRY7lC3tHZdehCp7SeveeKav+s8vNpYbRVMIvMMIkYZ0QGVvWvTtZsX28BmfQSTKEdRsiP3OMgx9h7R16hpqYeMxPjEV0kgvm2QSOHcjFQhfKesVScwY5YgkAmdsEmCdXp+R/KfPb3u42Xrn5v/U0cila4DTrdU4qqOhPmTjAYfOncEqtvH7EhqOBkVukayPAKeP9Zok6+wP2cS7Fb1iEEc6mFnnqo5oaSFaeegce8ino/ufAsJpxVD19e4SMUl+8NJ3zuK9x8c7bN3pqUaN/3BG8X1fs+4ZqzoYFD097klpUphP8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1DWyAr7B0VPBXbm1CACAKkr1PQcAeE1uAiXsBMBKsE=;
 b=MkipghDJmG3yzsqC36YW/Vh5oEZpUpuEzT4rYOBww/Y/YKhUxhEdj2uluwAJSxdvjmiUSi0bhGXoG72BUcav37VSCVWE7hQMMjHpoD7jodvqHY4n+x80i5QIGJrTZMdQS3kwiCq4tlbo4OSOZfjiOumILK8yygk9chivSYmC1E3C8NlVxckIimrnCvmnm5TO+KJ7ie8F2vjltgl9xyDSxP3jfsY54wlQSYgxiWEsWqH/kIpt13ET/SvHywxGWjgXls5LHumwPN6ByChAA7O4hry60cG6GsOJxP79V6gdoxIbv3VG0I5euaA+qbIA5xFnBsJ0J1RZxOTYKc1PRN/3QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CO1PR11MB5188.namprd11.prod.outlook.com (2603:10b6:303:95::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 13:41:21 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 13:41:21 +0000
Date: Wed, 7 Aug 2024 21:41:11 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-acpi@vger.kernel.org>,
	<devel@acpica.org>, <linux-pm@vger.kernel.org>, <ltp@lists.linux.it>,
	<oliver.sang@intel.com>
Subject: [rafael-pm:intel_pstate-testing] [cpufreq] 4a8311d560:
 WARNING:at_arch/x86/kernel/cpu/aperfmperf.c:#arch_set_cpu_capacity
Message-ID: <202408071616.efe30462-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CO1PR11MB5188:EE_
X-MS-Office365-Filtering-Correlation-Id: c03eb7dc-b5e7-4cb1-07f0-08dcb6e69f63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CWyHJCZHraZ5q0kO87L8Lrr3nk3kFOwoStoWSGTNJz0vDn8Py4igaUZUFuqC?=
 =?us-ascii?Q?JqhciNj2MWuBrQTTu7tdy0NgEnvUYAeRQznOgb2LXCTo3/2mJ5Xnez6/6USX?=
 =?us-ascii?Q?SnZVu109FypRGvCzodS0p9k26BUIUs2p2BZLqCsfIs1hHkSmJdlISU32sZ91?=
 =?us-ascii?Q?84LyzKtrAWFv0Akn3Xb6WfJ6kPs/sqr+e71WDSZRbWX6zfUuUlDQt/1A7Qc+?=
 =?us-ascii?Q?U+/aAdIC0VzPBPMF3jOx2D7tTr5dyI7VDE65SjbDJZTmL2x4cNw3KwyjuE4J?=
 =?us-ascii?Q?bjA8b+RqB/O8U0NUT1hgUEQcYobH2/w7JQe6yGRkY/S2XgnPZqLDdh58T5+l?=
 =?us-ascii?Q?WNJcKpP1aDXFaBQ1MHb7Fxw7JdVmAwc1gV7gKiQrD1JRwmiq5iXPcEhrzaFG?=
 =?us-ascii?Q?B7att9fRoOgE+U7QHkLFnV4ySgKozp4/uFt4p9I9QJENAiHSIjMA4tsxw99l?=
 =?us-ascii?Q?o7gxfY/pFNdctC7ge0YKSwZw58J+DBk0XYuK/SV4lQsIRuAkNYxMJEzoNtoE?=
 =?us-ascii?Q?iXdhbQWK/JCwgc/DFxd00CluZuMc1MNidb2lsXRBS3XN1DQAep8T1xKLFuEv?=
 =?us-ascii?Q?AsGkEm0+5uC9R4imURovGuCN0vsETPbRM0iTsTrTdIwrlTsU1L6Q+Nc64nRL?=
 =?us-ascii?Q?qLZGLliiCcjwVe+iMG//IDIEHSKBjG34sAiloN+JVegb/yj9MTywesOPrnTm?=
 =?us-ascii?Q?KO/zgDW5ij5hqo1l3IMepQhI0PfrIft5rkaNpPNY1mZYbtRNDH+qqG4yorAA?=
 =?us-ascii?Q?8WLn72OL0XR8xwc5W99hgw1eDr99VDWT+gd9cHjIN5ThXuF4Urwr9RlFAHtv?=
 =?us-ascii?Q?VrEBIKrubPiXQ7tVar0z2be3q90QRiLsaOnRORp3HwlPA0KNGVRn6KgZEye6?=
 =?us-ascii?Q?2l0ymOjW3xEbUR9AKLmwZrwQSkzBObe+rZrIRYKU+UVNH4l+COBoZj9QSV+P?=
 =?us-ascii?Q?wAHoMRaVlp8PRL2CmeDKg2IapSTUspjaCxOnjaFIwvtOUiUsJcOWcHjSU1SU?=
 =?us-ascii?Q?Ehz111f8jlhjDR4T4vyabQlVZHeAUxcwz9PcR7v3O23MVkLDI4YX0XzQXKwg?=
 =?us-ascii?Q?S6IfDk1wpE7ReFe3Ih3ae6Ca5vDqOrIPhrryjVkV15kwW6O6m4zbkyA4vBL1?=
 =?us-ascii?Q?j/OP+aHdEd0ExHv0MUIwmCpJ70xYF8OPero0sViqRheP83o/ZUK4H53LMJr4?=
 =?us-ascii?Q?JYo3u3PUKwAiWCJhGIgm+zqUny4U/ZqgYlVL9fkIuvAjEF+lgMWzaFGOCe0+?=
 =?us-ascii?Q?fpq8klKGKxDppDHNYfF/+MZlN6WEsKkb5LfbqDfDKgcClFOXfiR+61U4eP2f?=
 =?us-ascii?Q?bOLCkmpJaxBJaeGAOCKh34de?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wT46UJXMN/GROt2UG7LsQuS6rHoTg+rxtERERwDQ8WqUlzFJbsMLGoAKfnX1?=
 =?us-ascii?Q?yLR6JRX41pvgL521KLdFArbzAU2vXUK+reGJhtFXR0DilRQ39coGPgfyTPCY?=
 =?us-ascii?Q?gBxGQNVtmKXew0FzwWo6BM079QMLNwdHveOyfX8estslOhQtMG2LpUyyV1uX?=
 =?us-ascii?Q?SJ181CEqNOuvEfVRg5GxUP1v87oREZmJx44wC8rySU8aNvW2DzWMQgx3298r?=
 =?us-ascii?Q?D4FFpPIePsiHiqTCiaSwWIeLvz2JhTzyFbCCC5aDGkxMDVz5gQvqcN6ShdnZ?=
 =?us-ascii?Q?v0h1x6uejVGhHEK9HHjpJgHEdonOUgbQ9W7sKCwhwL1u+yUb+EBGZGLP3q1F?=
 =?us-ascii?Q?an84EH2m5Dn2863Ob13GGsGYgDBysVvq545eawJe03TA5GNDChFvhIkSLX/6?=
 =?us-ascii?Q?/X6dgX5GeeyDIqBi2l7cTwqxvaCYXSkm2Hb217krcBKtoeHQ/iSzd1mkQho1?=
 =?us-ascii?Q?x8tX7j6ueBXOmZWGwkUDqkV0AWW6bK/+dL0zNpj+5j1QggzNsx1+BmZMkVmD?=
 =?us-ascii?Q?b5kQXZzmx+eOJFKf0Cu0xaGaMyLz665nB6D4CNDpjU+2DEsySNdGm2D37Bj3?=
 =?us-ascii?Q?JA8J88ou+gURuIzsba7SXyRgCZEqjqtAMAjNcCyeKDfsKCFQ98GphgQWgZer?=
 =?us-ascii?Q?Aj3CQQ/ga1c3M/ArcqVmca/7sRQo/Z4nBI+v1dLOPFPm0kScXPRz5ErklbcU?=
 =?us-ascii?Q?eGsUy84fqkT3Z0eOsv2VZMd73/YDwtbLWfVTc8Y15GPZ4CuYwcm0PAm9wOc6?=
 =?us-ascii?Q?R4Pbi4OfUD7MsL+VykJJdMiu6DaonbKxvtacvwEtoqj9/S0F/SdwIy9eB/dH?=
 =?us-ascii?Q?2q//NsRquZbTJ30zdK5fJPPlaHXz+NjoqN3QkZ8wW2I5KlTeLg/Hy7Gbrm8e?=
 =?us-ascii?Q?WUFz2OUxs70a+XpM2j+ltZoZhd+VOP5IqpYWi2hzotHNs2z91n8p8vdHfUfo?=
 =?us-ascii?Q?C4B4Go1Fg1MjB0D5FTM5mJ/Kj8ME+uYiDtYm7LfQ6iFwwWmhIbadQnqI3XEU?=
 =?us-ascii?Q?kSZven3h1AFHc0kyCmQDzD/f/PWcycFEf8XcQ3oB81hJLctzbPQjfZRG2/tZ?=
 =?us-ascii?Q?pheoFLWhbjasJqcqEqBcJULWZLHvwF/tkykL3o8uD+T20gglkx9TSysSDU+z?=
 =?us-ascii?Q?t1PRQnPHpdbd1gnqg5HhvcAfu+xwSU2Yr86a5JqrRy+gbq+g2UN/lLrFf3ns?=
 =?us-ascii?Q?S4tt/BoiB5b3lO1KdFrC86QwzHMc694CiRhrF5eR0RTxVc6JuBRfgNc+ox3Z?=
 =?us-ascii?Q?qVa2HcWntQUe5/qMApU5O87ynQ/gG9NsxDjHbHqrVu26jRonTIGr985QlbS1?=
 =?us-ascii?Q?zVRCQKDcrza0MIvfX9OBu4zc8KLVwYIN6ulppGQDaRd2Wq8C8Fg3YXXqvYUp?=
 =?us-ascii?Q?VdDDuUGsZ4PtrtfP+rnM39cePPCxvZ7gmkhEL8ad0w9YyNXi11WrkmmV+QZD?=
 =?us-ascii?Q?ZBHeIfZC+tscDdXz3O3ZaAIrRhpwS2H6KReeGMmUHHKnyrYHYMbyNqa7KUBQ?=
 =?us-ascii?Q?agmw9cGZ+3dKEws5dUZ8JUoQwgabFXNmnzN7nCEvdVQF4XQKda7j/jq4ojDr?=
 =?us-ascii?Q?IepmJ95KNnGtV77+PEpbjnY1Jgv+tmMKucCKj7nXyvoMUbJdVpsWjh3kmXlD?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c03eb7dc-b5e7-4cb1-07f0-08dcb6e69f63
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 13:41:21.5968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +prms0SOsJjCsDxGsL4ocJleCWE3ty8JLE6PKwQzCvQGVNRCfHg7ZOqY4GznGlVs1D3vg7JaWYRWsf4+5gTihQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5188
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_arch/x86/kernel/cpu/aperfmperf.c:#arch_set_cpu_capacity" on:

commit: 4a8311d5601d98c0bc7547f3621236266282d44a ("cpufreq: intel_pstate: Set asymmetric CPU capacity on hybrid systems")
https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git intel_pstate-testing

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20240727
with following parameters:

	test: kernel_misc



compiler: gcc-13
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz (Ivy Bridge) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408071616.efe30462-lkp@intel.com



kern  :warn  : [  205.247811] sched: RT throttling activated
kern  :warn  : [  205.608733] ------------[ cut here ]------------
kern  :warn  : [  205.608911] WARNING: CPU: 0 PID: 3843 at arch/x86/kernel/cpu/aperfmperf.c:420 arch_set_cpu_capacity+0xe3/0x180
kern  :warn  : [  205.609129] Modules linked in: netconsole btrfs blake2b_generic xor zstd_compress raid6_pq libcrc32c intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp sd_mod coretemp t10_pi crc64_rocksoft_generic kvm_intel crc64_rocksoft crc64 sg ipmi_devintf ipmi_msghandler i915 kvm crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 drm_buddy rapl intel_gtt intel_cstate drm_display_helper ahci mxm_wmi firewire_ohci ttm libahci firewire_core drm_kms_helper intel_uncore libata i2c_i801 crc_itu_t i2c_smbus lpc_ich video wmi binfmt_misc loop drm fuse dm_mod ip_tables
kern  :warn  : [  205.610158] CPU: 0 PID: 3843 Comm: cpufreq_boost Not tainted 6.10.0-00003-g4a8311d5601d #1
kern  :warn  : [  205.610343] Hardware name:  /DZ77BH-55K, BIOS BHZ7710H.86A.0097.2012.1228.1346 12/28/2012
kern  :warn  : [  205.610522] RIP: 0010:arch_set_cpu_capacity+0xe3/0x180
kern  :warn  : [  205.610656] Code: f0 48 ba 00 00 00 00 00 fc ff df 48 c1 e9 03 80 3c 11 00 75 42 48 89 43 08 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc <0f> 0b c3 cc cc cc cc 4c 89 e6 48 c7 c7 00 36 c9 84 4c 89 44 24 08
kern  :warn  : [  205.611049] RSP: 0018:ffffc90002abfbc0 EFLAGS: 00010246
kern  :warn  : [  205.611192] RAX: 0000000000000000 RBX: ffff888103e1f800 RCX: 0000000000000023
kern  :warn  : [  205.611350] RDX: 0000000000000023 RSI: 0000000000000023 RDI: 0000000000000000
kern  :warn  : [  205.611507] RBP: ffff888103e1f948 R08: 0000000000000023 R09: 1ffff110207c3fa9
kern  :warn  : [  205.611670] R10: ffffc90002abfbe7 R11: ffffffff86231bfe R12: ffff888103e1f820
kern  :warn  : [  205.611846] R13: ffff888103e1f800 R14: ffffc900000f5000 R15: ffff88810b4e2800
kern  :warn  : [  205.612014] FS:  00007f50158be740(0000) GS:ffff88833b800000(0000) knlGS:0000000000000000
kern  :warn  : [  205.612189] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kern  :warn  : [  205.612327] CR2: 00007f5015aab178 CR3: 00000001eae4a002 CR4: 00000000001706f0
kern  :warn  : [  205.612484] Call Trace:
kern  :warn  : [  205.612574]  <TASK>
kern  :warn  : [  205.612652]  ? __warn+0xcc/0x260
kern  :warn  : [  205.612752]  ? arch_set_cpu_capacity+0xe3/0x180
kern  :warn  : [  205.612907]  ? report_bug+0x261/0x2c0
kern  :warn  : [  205.613018]  ? handle_bug+0x6d/0x90
kern  :warn  : [  205.613119]  ? exc_invalid_op+0x17/0x40
kern  :warn  : [  205.613227]  ? asm_exc_invalid_op+0x1a/0x20
kern  :warn  : [  205.613340]  ? arch_set_cpu_capacity+0xe3/0x180
kern  :warn  : [  205.613457]  hybrid_set_cpu_capacity+0xca/0x270
kern  :warn  : [  205.613581]  hybrid_set_capacity_of_cpus+0x63/0xf0
kern  :warn  : [  205.613708]  store_no_turbo+0x382/0x510
kern  :warn  : [  205.613833]  ? __pfx_store_no_turbo+0x10/0x10
kern  :warn  : [  205.613959]  ? __pfx_mutex_lock+0x10/0x10
kern  :warn  : [  205.614070]  ? 0xffffffff81000000
kern  :warn  : [  205.614167]  ? __check_object_size+0x75/0x1d0
kern  :warn  : [  205.614292]  kernfs_fop_write_iter+0x312/0x4a0
kern  :warn  : [  205.614409]  vfs_write+0x5b5/0xd80
kern  :warn  : [  205.614509]  ? kernfs_iop_getattr+0x10a/0x160
kern  :warn  : [  205.614628]  ? __pfx_vfs_write+0x10/0x10
kern  :warn  : [  205.614737]  ? __do_sys_newfstatat+0xa2/0xf0
kern  :warn  : [  205.614886]  ? __pfx___do_sys_newfstatat+0x10/0x10
kern  :warn  : [  205.615018]  ksys_write+0xfe/0x1d0
kern  :warn  : [  205.615120]  ? __pfx_ksys_write+0x10/0x10
kern  :warn  : [  205.615230]  ? irqtime_account_irq+0x51/0x200
kern  :warn  : [  205.615344]  do_syscall_64+0x5f/0x170
kern  :warn  : [  205.615449]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
kern  :warn  : [  205.615574] RIP: 0033:0x7f50159b9240
kern  :warn  : [  205.615678] Code: 40 00 48 8b 15 c1 9b 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d a1 23 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
kern  :warn  : [  205.616062] RSP: 002b:00007ffe2dcc6dd8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
kern  :warn  : [  205.616234] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f50159b9240
kern  :warn  : [  205.616393] RDX: 0000000000000001 RSI: 0000557a9ee97ae0 RDI: 0000000000000004
kern  :warn  : [  205.616550] RBP: 0000557a9ee97ae0 R08: 0000000000000004 R09: 0000000000000073
kern  :warn  : [  205.616712] R10: 0000000000001000 R11: 0000000000000202 R12: 0000000000000001
kern  :warn  : [  205.616907] R13: 0000557a9ee964e0 R14: 0000000000000001 R15: 00007f5015a8f9e0
kern  :warn  : [  205.617070]  </TASK>
kern  :warn  : [  205.617154] ---[ end trace 0000000000000000 ]---



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240807/202408071616.efe30462-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


