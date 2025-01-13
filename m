Return-Path: <linux-acpi+bounces-10576-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F65A0C2D8
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 21:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4F61888FD2
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 20:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00C61C9B62;
	Mon, 13 Jan 2025 20:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mWC+g/03"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FA435280;
	Mon, 13 Jan 2025 20:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736801862; cv=fail; b=QyGscgBqETVK9W9/Y8Zd5mRxTgqPyd2JENa9cib/QltZ1sWSZMmH2jjbt9+5kSJKWG3phGw40HjG+OlnTte9vFH72qJ36N4mElbNxMsUv3V5tQM2oGN14ztQ6en8woa+ZZ9XEt+FNNF5eL6RlNS3v9dnuLTRvMNkINN1Yy6qJEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736801862; c=relaxed/simple;
	bh=+uxO7osgW8CLWB6CvABS2WjrWebhZnmRgJh0QQmTIKw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aTaDB9XSJ5VvGPXDOTktat/jIja6l1v03Brymrfs8KBgpJSDhfudFOQEAI02CpNDTJhJiRjRMZ7DJcnN6/NrbM41UOvljuxCyWWOjuYPm3b50hObdLb66Mb3yYObMdcqi9KSzSrtz9OBkRRMKat0ujFb1HnGIOcpXQlVs3fg/DU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mWC+g/03; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736801861; x=1768337861;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+uxO7osgW8CLWB6CvABS2WjrWebhZnmRgJh0QQmTIKw=;
  b=mWC+g/03+V9BDdG/5pOgE3odKv0CpjhdJm8yiqnikBotVXaY519kXJe0
   bpxubCveJ3VcpcLmQSOFRGMYSot3g3aov7hTYOzZM6yhS+kJ1Nglr8mYk
   V6SLrCHuKhFU6LR2UHJCWY14x+ZeLAum+f3p2XSb8ZVTmBAQAO/Gje1bU
   HmSBLVNAe8cv79QAzJUKvoKpbFZwfcfaBB96s/9r3+BvGPwzXAmdLhAiJ
   CTJY1OxFw0j6lSB197prXF/VI/Fo/34oX3RMNs96OfL7QeYZjV16XoMLb
   5eO6ABW+GaS3iXzjeCe7F+QyNlBPG/i0BL5DqLJ7UDSlx3PFTWKUzUlC0
   w==;
X-CSE-ConnectionGUID: SOnQipwjSna/9jh8yso2/A==
X-CSE-MsgGUID: dAQymUP4TDyXa7X5mnREEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="36993101"
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="36993101"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 12:57:40 -0800
X-CSE-ConnectionGUID: ebR7tNmLSAiqvwPKNQagmw==
X-CSE-MsgGUID: Q3B9tLhRTZSrwXt6WQhRIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105098766"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 12:57:40 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 12:57:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 12:57:39 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 12:57:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FV2lXOSMLLRPh8gNwI8ZiCKPW6x92ZQZnze+U6/SFfuIBBWPUvGN2ZwzK5CqXaH3mcI2MMJ0dLWEMinABqx588c4rZY1wVKprYXDv5C+SrCLq3CXrdv2gNWXVs0oEHTrtKG6zcU06bDilPKxCaFWrcumQZJMfaAOVPyjF3xqurYDQ6ZlMSB29m0WhIgDKm3kGQ1MRRo9E9/VdIQRTNr7pZek2fqwEmyKe5e9dPOallm6LrpSGkLzTzpn4dsoYqT69e9vX/zbscP3yKgMfk/Gk0dXrgCvpp/+izbZwqq2pMgK7UunntnciuA2p3Pgiw+UoQXNaMRLCPKQLs93PbzgIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqugcuJK+KgEmCHXNNrM2ZwUmzTlNtHmxLz8zTt0mDA=;
 b=O9Q6HV1Mnfmb19IzH5fBAzM6gL1U5yg4WwPjWXj9FjrZj26wz4WzR/OTy+jwcDkItw9uWNi4l4bQJL8RGquSqusrgPdk6oJ2X+VhRovz2jMapU8o0+0yvczR7OCgOkZ1FM1dUfBtUjBV57bk5Np4hSmL40/cnR/sCAq0hEFzXQAjB4v0JYsw7STlJXpgjp/0UdXfMtO7sKSFeAIFIY5V1FcfZJ9pWsuVJwkmLzpBxEqPt5Ln7eHRcuHn/5Ak+Y6j0bVcHiaBahcU8pyyNrLrHjmw9R8p+JDoXnkjChfWe8dquPPCzBBMPCJaulUKbCCKAOwcWbECPVcKCcN3ArpEpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY8PR11MB6844.namprd11.prod.outlook.com (2603:10b6:930:5f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 20:56:56 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8335.012; Mon, 13 Jan 2025
 20:56:56 +0000
Date: Mon, 13 Jan 2025 14:56:50 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Gregory Price <gourry@gourry.net>, <linux-mm@kvack.org>,
	<linux-acpi@vger.kernel.org>
CC: <kernel-team@meta.com>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
	<dave.hansen@linux.intel.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <david@redhat.com>,
	<osalvador@suse.de>, <gregkh@linuxfoundation.org>,
	<akpm@linux-foundation.org>, <dan.j.williams@intel.com>,
	<Jonathan.Cameron@huawei.com>, <alison.schofield@intel.com>,
	<rrichter@amd.com>, <rppt@kernel.org>, <gourry@gourry.net>,
	<bfaccini@nvidia.com>, <haibo1.xu@intel.com>, <dave.jiang@intel.com>, Fan Ni
	<fan.ni@samsung.com>
Subject: Re: [RESEND v7 2/3] x86: probe memory block size advisement value
 during mm init
Message-ID: <67857e1234ada_1863f3294a1@iweiny-mobl.notmuch>
References: <20250113174439.1965168-1-gourry@gourry.net>
 <20250113174439.1965168-3-gourry@gourry.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250113174439.1965168-3-gourry@gourry.net>
X-ClientProxiedBy: MW4PR04CA0375.namprd04.prod.outlook.com
 (2603:10b6:303:81::20) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY8PR11MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: c373b62e-35fe-444c-41f8-08dd3414d0d8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wHkhd9Ykdf3e/+KgnP8t/cxpoRZ5BS1b1dKDnd8/0jN6U6jCtg2dF5gzZ7v4?=
 =?us-ascii?Q?UjBNOZqelhYEd/FXfvGyXrsc3OwS95XcNByljp0LgWiWvx8eS+gvsQeRafYC?=
 =?us-ascii?Q?0c7/oAwocXffe7aqEHDz4EJh9FXelcB5Ir34YAVvxNE4Q2SdNlb2ZOQhzun0?=
 =?us-ascii?Q?+1iXwcaBc1rU0HHuJvPSwbaFjlQ4TArUHjerzYlVFUIfoxGUR2sDt2bplNJu?=
 =?us-ascii?Q?rLt4KkeuTU7H1eCo9rUUQ3VKHCk6mognEl5MgAeAOvAGM9VMdxqODYdog0/u?=
 =?us-ascii?Q?VDRYY7ZkMlv9mZ8KEG6J9vUzXN2nLXtoIlyEsjdezj/XCXZeq+kd4OsBxasx?=
 =?us-ascii?Q?a/pvnvcppiupDoW1y2MJONSxw+jL1uOViM0Lj0dreDjgutUZk4E80SZ/oijF?=
 =?us-ascii?Q?SdTQHdxCapuzCOICIjbtrQM51gutQ4l4ALktJhHF9OrhygTuZGFVA3IQEf/f?=
 =?us-ascii?Q?CbId5KsFiIgu+9wOiP8X7BUWg4+yrEa9qC7uYW6hmqtzKUKBIZQbndi0Kck5?=
 =?us-ascii?Q?mtkJI5NtvIap1h9Aee3OvjzVXu3DBYnqXuV+Ro+4SFPtcsyafFmaJCny3K1A?=
 =?us-ascii?Q?9PnIs5N7vL5v98I3NHDGz9ytO7TSnL+aLiPiCzS0pnQ7WOjJODEad5jYS8K8?=
 =?us-ascii?Q?ZaN55p7oDhdTx5RodKO6TtcMKyol3b9M7czUH3bTA8ch3nR93XL/j7Hpiv5F?=
 =?us-ascii?Q?XR/Q8ereB2rKglsGMcNHM4+8N8sdHFx+3+CNJ8CPfWMf3WNACFx+DdUhMduA?=
 =?us-ascii?Q?CeadpsqsN6sgHrXpK5ZqFMKBUwvZvLYu8+iQ6c3b8+qa6TLLUD/f/5zDocPo?=
 =?us-ascii?Q?3jSGYZa/rQDfwUMAy4cDhj7bjvJm75qcNC+V7kOd4Sot5xn5i1orOOOVd63/?=
 =?us-ascii?Q?AP4ZjRj+u19/h0UZy+hExLzgNQn7lpsZc2zjFD4XENAem21RCDW2AQybnfK8?=
 =?us-ascii?Q?PdUC6AfF8oWg/7/Wvsid/AdQkY1bWr+KIDVgn+VuJomQqR64497EfiThSrjH?=
 =?us-ascii?Q?CHOE7F4pGsNYjroJNT+3iDCffb0zTkQZ+bvoaaNJUPygLUo9TnC1AOmIpikK?=
 =?us-ascii?Q?0V6DJ32XuXp5LS7pgvci2OObnvj0QEXQhykQeVUkX3d2yQhSVdBenfZebcDV?=
 =?us-ascii?Q?Ods4wNZxkwlb7yqH3X2kHMSnUigkrg2Js7iWLLJ4DKFO0/St59Y95LvuBMrc?=
 =?us-ascii?Q?57gENe1gX+49V3Q9gWwauFwVxpR33Ma2p2hyaEP6eQxiSVf050E0nDmw2pfz?=
 =?us-ascii?Q?/cM2Pb02o8Is3T1YWzeKnqWKSQrBXgIHzOmGf1tWrZv296ixuvC5ANtZTDKX?=
 =?us-ascii?Q?HYrNbXXSE7wOG/7CyQrRoYMBjWQnTXsFfwTIDDG5hMDTxXLwBijru/mB4Gku?=
 =?us-ascii?Q?+/JN+8mUXhZlIytagpaoUZ/PZ9DM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eGWyNJIOnDo4aif6gC9TTkMlD1IHrEN5ndFomovmsxgTqeMCPO8X/5SYWksz?=
 =?us-ascii?Q?21bQcS/63zIjxmOYOnEa3SImpNVEZSdFWGORBAYZl60kvac/TaEyIGzHHU7/?=
 =?us-ascii?Q?HjtZ8ncobw8A+93HPMAqBccxBNkBJEnW07Cpw691MffLIGuO9BZ9B4V+DjUX?=
 =?us-ascii?Q?Ksp5PuNXz8pJ7Qbr67IBsKgc3LlykNyJWWasQvP+5QvE39gFQMk2GQmTQxaw?=
 =?us-ascii?Q?r6a0pLcoZtqahpKnX53S6mdP6d1lm7JJ1nUe+GE+kBjtd8jurCcc3R1KQczi?=
 =?us-ascii?Q?Ya1OwJhWvr6rR3GHiA+2eTQQT6EV2jG7ZteI3rLg8OLtZJNVd9F4pVAxtBE7?=
 =?us-ascii?Q?Phock2TLnuq+4e+rWDETTnfGEeNld9C/FcKjCB2hE50tVCGBBrxIsTwTZ1Ol?=
 =?us-ascii?Q?QEoJeWO++C4hTWY+S9FLzxjnPTO/WURXt1YFUynR/cHUJyCA4dzlT4HBr7NU?=
 =?us-ascii?Q?Fz9+zXVk5a72UIWTozccZ3hhvnb0tCAbiWslyFvvbhVAWim0XBGqrTHXwOwG?=
 =?us-ascii?Q?71eOnGBvMMsWdjYNFn2zh3uhERr2XBZgTC+zBGIDwyMq5ZvzY7NBS0X8EBK1?=
 =?us-ascii?Q?4HI5mJhUO5oYfVAWpvF4vVvyO9BTUfNVC3EgtP2b70KaMgiufSTH4y/Wi0wh?=
 =?us-ascii?Q?bSrYGn8BRl5wNc/8zxwb9VhSbccshTY/60AWrEg1GCz0hBspbpPY8YBYnyHX?=
 =?us-ascii?Q?Ve2LYfKwA3sn+X5SjQwa+Lmzb36iBFCBKBywOr4PfWfA1a9n8SyHCIPLpWol?=
 =?us-ascii?Q?IHyInCfl2cD0HsgZ/VRYke91zoW3VDdkiY4HbigmxANrpR5aDu71BwqHrJJH?=
 =?us-ascii?Q?uqhWp31WEGekfumUsyNyVUAd7XLspAtPVPRpPzuNefaroUgg/eSagToRQR5t?=
 =?us-ascii?Q?+SBpx/uyJM9Irhhhc+XySsNf1aWUiDCiMhCyZYQmcfJaLojuTz9/C4hSdw7O?=
 =?us-ascii?Q?Ozo6b/0UUxDRM8/i89C6zi2ltnlIsnBg5e0aY+CW6YjIuOB4rd1+nMN+vVr/?=
 =?us-ascii?Q?Msoy0LKfKjud93iy5GazzkYeAa9MhqLNpwQZK1IuSjIcW4TO6nKcQm9GzGU6?=
 =?us-ascii?Q?LVz7fJ7iJcAsG4memJksEAaFQe+rLqktuOc+KRgjNwE3dAjWPeAP+TVi/7mF?=
 =?us-ascii?Q?I6p1ertTdo+OKTkll+LOA+ArbslaH8TZhia/vFxUFcNn6oJTQPm+KonFjrMK?=
 =?us-ascii?Q?mMRF95YYjZ7vF0niQhLrXyd2gY0EDXjpbJpz6oMQNRfc+emr1f4QCN5Hfbwi?=
 =?us-ascii?Q?sjTtbJrS9Wedcr/EGLCLlfvGdw8jMMs+gfMFYR8LRT5DDrp5gw0j0sPQrnWP?=
 =?us-ascii?Q?7Oc6cxZM4uguQ3QuB7eUgh9meVQnZIghuefOaPKClAJfZlcbmve9QgS/oMR5?=
 =?us-ascii?Q?+sjpK31EA/VYwXf1juOQ8W5NWuCPyerq+llOAOIlhMnHqmtF0klJDr1JPfwg?=
 =?us-ascii?Q?RlbssE5j804p3OKujNA6jqLHGaON28IKw4219SxWdtnN/bsqKacuJn4Tqctn?=
 =?us-ascii?Q?EI1yPPjJRzAXM1WDD7O6kwvVToGOm//4dfdX8i/ApUJpcDxhzRHmTZEGcii3?=
 =?us-ascii?Q?Z5Pwwr6cgKbIlSechtCF/uQHCZinNfYoG+aehh25?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c373b62e-35fe-444c-41f8-08dd3414d0d8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 20:56:56.5985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFAZF14ugcEUqOiO6oQVKdJP558aAHa6R0+IPwKmniQz/RkYJ/YooYSMOj29QyV5kKAbNuEjFOOk16b18HlvIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6844
X-OriginatorOrg: intel.com

Gregory Price wrote:
> Systems with hotplug may provide an advisement value on what the
> memblock size should be.  Probe this value when the rest of the
> configuration values are considered.
> 
> The new heuristic is as follows
> 
> 1) set_memory_block_size_order value if already set (cmdline param)
> 2) minimum block size if memory is less than large block limit
> 3) if no hotplug advice: Max block size if system is bare-metal,
>    otherwise use end of memory alignment.
> 4) if hotplug advice: lesser of advice and end of memory alignment.
> 
> Convert to cpu_feature_enabled() while at it.[1]
> 
> [1] https://lore.kernel.org/all/20241031103401.GBZyNdGQ-ZyXKyzC_z@fat_crate.local/
> 
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Tested-by: Fan Ni <fan.ni@samsung.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

