Return-Path: <linux-acpi+bounces-12705-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD56A7A996
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 20:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D183A7EA5
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 18:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BA92528FC;
	Thu,  3 Apr 2025 18:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bFIBEEKO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF902500DE;
	Thu,  3 Apr 2025 18:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743705443; cv=fail; b=PPbMJNilz+oonnVtihuqZD4xsVH/8NaCfJMx68PUJXqdZy2hQPg6x+V/hKGClWVLV1OxxFBs0H7SlFIRLKmrrT9h1OCbky+pNyGrRB8TBaDuE9s0BLMdHCS1M95s0Tf3/WGV2c5AINPTQ4FU5BmI3qFVEtA5TKBeFQUZPIqsuTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743705443; c=relaxed/simple;
	bh=mtxQG9HCy6eKO9J8VpSetH+mFFFZYSIu2nRwp4CYW0Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kTcdB9M9uAbW5fTPGppdpFvJLuUyn/9WLWvNuB0T8mWkzyZbVskI/r1cRxz+OshHjwUy3J3Iw6dmZM6V09qTWyee66xKsjDfGuxIbsLTYKoxp5f9quetQyYkIj0BIN33GEFl2bATUPjqnGBjNakTwmFi1oSqbza8M9xyed5VnnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bFIBEEKO; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743705440; x=1775241440;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mtxQG9HCy6eKO9J8VpSetH+mFFFZYSIu2nRwp4CYW0Q=;
  b=bFIBEEKOtSGOUJPJr26gcdGhNkYRC3c3ZVzi6lFGmNhCR2geownhyXnq
   LHbqlwxGFWQjQ6ZGcrc5mbhFr9xNTlrSuxYK9nsULbDN2+xNNM4fKOECs
   fgA3C8AXGgam+6tbisQdwTobOUz8ATYh4XJLkUjbHABAyVu+NKhy0l398
   Ex+rR7MGj5+qYbM284s6Emrm4dCHmJbqyNXdu8P3be0Sft06zq/jpXNTM
   2YbW+o2ChSkl47SelTOoQgZyDpYmlMYkdsuCDURcR/Ae3qAf+I/pzOfVv
   eQS0dn8AH5xduqM4fPT+FWPbHoyTKey4xHWE9AodiK7YMucBO9iLDOZFC
   w==;
X-CSE-ConnectionGUID: c4THQgQvR+Sk3C94P2Pbhg==
X-CSE-MsgGUID: pDCSFx1BR1WDrqnKprtUaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="45016929"
X-IronPort-AV: E=Sophos;i="6.15,186,1739865600"; 
   d="scan'208";a="45016929"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 11:37:19 -0700
X-CSE-ConnectionGUID: ZMXqrKbyTHqDg3sEEiusrA==
X-CSE-MsgGUID: ko7ArauVRTiyQPrTOlZp6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,186,1739865600"; 
   d="scan'208";a="126870390"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 11:37:18 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 3 Apr 2025 11:37:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 3 Apr 2025 11:37:18 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 3 Apr 2025 11:37:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QmPk0MflmxT+DfRF6xeGgB8MGBBHR8koUtq9Gx4Gqxe8rDunGqz44zrnpiEBDJD8UEUJNb+3ZwZCxIfR8aPPD5ol4Mbl+AiTFj/bbSkPmQcPW8zdCq51X3RySQaQWCkXxgbxSOzBQqi7VVqyn3wV53oxZbbNK+fiVyGnKZMSLgLu9wi8squGzURIm8uHeFlLjIE+fBcNikE0x+aQeqyFJHcg9BWErr3q6VL0/D+MbdYjxmC2l2lCY84TRkrMkNvKTyOkYoAL2D2c1rUowR9vhq/ws9l6Xig2bQ0WwoYNRjQ0SKQcp0jZbP94KMxkDFMxMfEdH4XxoABJeRI1h0blLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aazDlQYQXHzcsrsz/z+H8iKPSDuKtwQrxT8uf8TKhGs=;
 b=k2V7kPjmzPCIe7DNkKbPH1O6CqrL4UqZNib6Fj68hvr+lS6KOu4OxaDfkDQ2WuDlmCqE2pF46pijBr5y48mJhFnEvZavHdjNaqiyJyzYhklTmDDJwHb1sTEqUOLUPqh/NPHcK6mLfXqKFlyMCHnVJUHR05W1PKc2HQT2kGxm1Ke+QgFI5RpRJunQy64u7m4LitFeqypZVnU7Ozh3uXKsP/YLUrfK6eiCkbnCsdzHNwnwoMc5KB7SvClsuumjBVgYiUEcKyMfOx2BpiLZaBDpUjX4Z2EeJik9AlsE1O9xMpQYFwijPE9HQRMXX/vSkPJt+oDchWDSsIwnp5cJx6GAxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by SJ0PR11MB7701.namprd11.prod.outlook.com (2603:10b6:a03:4e4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.42; Thu, 3 Apr
 2025 18:37:14 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%4]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 18:37:14 +0000
Date: Thu, 3 Apr 2025 11:37:03 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>,
	<rppt@kernel.org>, <rafael@kernel.org>, <lenb@kernel.org>,
	<akpm@linux-foundation.org>, <rrichter@amd.com>, <bfaccini@nvidia.com>,
	<haibo1.xu@intel.com>, <david@redhat.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<chenbaozi@phytium.com.cn>
Subject: Re: [PATCH v2] mm: numa_memblks: introduce numa_add_reserved_memblk
Message-ID: <Z-7VT0KQFMQLBnZT@aschofie-mobl2.lan>
References: <20250328092132.2695299-1-wangyuquan1236@phytium.com.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250328092132.2695299-1-wangyuquan1236@phytium.com.cn>
X-ClientProxiedBy: MW4PR04CA0285.namprd04.prod.outlook.com
 (2603:10b6:303:89::20) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|SJ0PR11MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: eb4ac0ae-5950-46f0-9158-08dd72de8d86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rt2UAPcedjUHVhNGogAUhUiUdv5Ga4YWvIHUURL1+ryWXH9JRSrwMpWfLNHo?=
 =?us-ascii?Q?gAVAVgXbtJRbEK9kj25TJatRdpqoSgfAgeNoSbLkTobQk3sXnLl7xrw/1Nlo?=
 =?us-ascii?Q?8jsUjanHdrkLGk1tjFozIJCq+xLP4AFi/MCIFKM5vB++Sl+WUkOugGhDuokk?=
 =?us-ascii?Q?lG7C9cwlmIHB2ZEKto+IDE8FAanHn9wFEH2krm8Bxshzv+Bal7aTRBA0wh5s?=
 =?us-ascii?Q?yjVA3uz4B/NRuwDyjFRKJrutVloGVLYhNJ9ta+V3hxBWpuyjv0Fra6dt1mCs?=
 =?us-ascii?Q?4XtozzvX7OmlfhDnyVAUtHUeAnDBeZX3UAnjy3TBRm814AblOUE3yoXd66rM?=
 =?us-ascii?Q?e28b+0JuQc9sdpWjS5cELczHQ6p/yDGPKB6cGZnddTgz/77a/zp3WYZ543OI?=
 =?us-ascii?Q?8KUqdMjtiiYPAb+5rfZaz0zLIVJXDbpxwBlGI1thlUPdpm64awCgRQXszDoq?=
 =?us-ascii?Q?IO76onJq4P/8nYeT60wvMPn2gm77WIOgCE8FNrl9EQExOrw5CQcWN7vME4zp?=
 =?us-ascii?Q?t5ctXTsohg3B005I9yjoXAs5x4lBhA2UynNv4aM53iNzdKrj/maukj14wcmZ?=
 =?us-ascii?Q?s2LBAlcxpBXA0SPSXx/OxFiME9CkdHfk4NFvofclE/iNCcu3br48gF55ARZe?=
 =?us-ascii?Q?YMRbxDhOpS81Lf/5R8w8po3gm6oYl9UXDDo7i+7B2QI8qZc2Mn+TxG/J/xuG?=
 =?us-ascii?Q?LyweNMtKoh8FrtrmIiZy56mcoU6D3RP2+t7EvjQ9u4pexlxeNBIx6WFiEGgF?=
 =?us-ascii?Q?727zSnQ02oQHREzNw+oXVp4q4pAicq1Hz6WpBaU4eEu8QS73rvLNL3BSspNS?=
 =?us-ascii?Q?Q9MA9I1az3POulnzWmFsJtZ7nkOO7RNwEONdkmoLwAMqTEHmOwBq6DWKynq9?=
 =?us-ascii?Q?dyphBZCa0FcnohZkSQjzY+uUgZdrZnVWoCwLAk9pU0o9nKcIEj/XnwMiYWnB?=
 =?us-ascii?Q?cjra5SmA9HmWU9IJrFsmbU4a7tkO3rcFVmKI9ZrIG0fHxwhUAMeIy2uK9Qog?=
 =?us-ascii?Q?42+QSYJ/mPcVP0hm9Arwx1CBDNsmyFcd7P25lxoO3sWzYbeAPK4RzNTXfAzJ?=
 =?us-ascii?Q?mhqbrOQK8imX6bgDI57nubXn+ZlTSltN67Ws0bMAKcQ41WCd/l9VPWP/SSGS?=
 =?us-ascii?Q?iiPkhpn/ywsFe6JcnDSTVPC1ToT7L8HtpMxuESSkPDusVj4RVh1+ewMP6lrw?=
 =?us-ascii?Q?Lza67TH+E69etF/32NEG1hn5xQXgjZ5JGESaMaVQKCZpROjDUXs2yP4KjkkO?=
 =?us-ascii?Q?tYow+edNM/Qs9Jqnvp70WAWm0w2uYE7wUhwQ6j5s5XFEQlIn+WavNc2DRBzL?=
 =?us-ascii?Q?pkSBgb09TDl6DKIl947BYkZvuQl9V9QYIFcDZQPjib//4RtZ7W3YeO8k6jkY?=
 =?us-ascii?Q?aGb8/rs1qyLCqvn9ij7HWvtTfugYiMyO3stKc2qwc+97i6C9j2AHG2KzTiAa?=
 =?us-ascii?Q?7x38zW8ksWQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0Ap3i+7maLuoLSz0yM990U0dknwZpgvPWEwW98XgvdqVsrcaJVIKAGw1UKNL?=
 =?us-ascii?Q?kJ/TM7euYmg6eUSraxQ60DMbk8x5rGvc41mUJJM1r0Rbkac7ZMyfsn64AYLh?=
 =?us-ascii?Q?Ws0CfS1g2iOEa+KwxXRgg3yIRRz4g7fkEzrVI0t8zpZfn6QByT/ELnuv5/sA?=
 =?us-ascii?Q?pKTg9XFhjqvIwfK+ziGFy10U3Z+mYSTDONsitvI92O6/hRs55tLLKd354PQS?=
 =?us-ascii?Q?mKlojQWTRGHg483X0akDMXZqMGU2zxoLQmDCAHPoBrQyd/7GHCcVgEP8QJV3?=
 =?us-ascii?Q?fvEyKzL0OWbhE3pYb3XUHYl5HcQWDx70/IJK/V/kcIouTMA5ZnDzVtZlx4Ao?=
 =?us-ascii?Q?V4+SFtBIiddnqjT6XmP5XPTqW6LEs3K1xiFw73FzYbrjSi29IHM26nWI+3M9?=
 =?us-ascii?Q?I9ayAMIn4LWbcPbabgUjCtXeDsz0UEwljagdCVakAdaeJnwUimilR5yK7Von?=
 =?us-ascii?Q?5W/0P3h8LGolOnBp/Il3icPPy4OHDKB2su1nSn5NqDpNWITTIDZ/llHmi8uu?=
 =?us-ascii?Q?zRrWt4UrtwWRNWFYNDLfFyihgCHBrs7062aW90Al4HJgz1uZbfASX9JMGWK9?=
 =?us-ascii?Q?yEqn74lzkOF0cUlX1taJNymIXBG0Trr5aVoIq3OcF8PcDdqKloAySrBlVqyf?=
 =?us-ascii?Q?cHS0uul47Czo9CP9QEi2Hd5Dj+sCLjn9bgiOF1q22jIJKnnqAwgmMTbpTFIE?=
 =?us-ascii?Q?kQ+Of1Lc+2kkCMtEc1eeEIe4/FrywHwjOpGUX0wRHm00nRoWp49Yjo6CX2pn?=
 =?us-ascii?Q?fu2lFo4x3yNEn4CvuSN9j8v15xYMNUDHuEkTL+hqmPS/4WdfPQ0T62L7Pd7u?=
 =?us-ascii?Q?R1P+qg97hWeVk6GFiL/9wD0/3Bd7Tm/MeJEylELTSDBQtHr9uJwjgLkGIYd9?=
 =?us-ascii?Q?n+NxExIVgZD+kQ61+Sbg1qlgGtTTlaw7wIT1B6p4nW/26fp/cYVCf9MgE65P?=
 =?us-ascii?Q?+q9zZ8sjL3CWkXMSHO6blk6wxHVUvA8jhdWHjKFRVe8Yxhc6rkCB63lAexeq?=
 =?us-ascii?Q?ro9kAD1OrdrUCuZaNDzsxF6V9A/I8ZLaiAzMFEaNBdzrRsyyqV8l58LbBuO7?=
 =?us-ascii?Q?ZCAc8AOvZ+T3d8Eap5tJmpghhHbI8KJlepmsA2RWn7vipUvnGQlU/Z3/aBL2?=
 =?us-ascii?Q?F/cOHFLcTHwHsQ3KfYgIiFJgyRtrQQAqs5/Z/l6p9szi6H6HK23DwFVZknli?=
 =?us-ascii?Q?EcwhfgEy1KMfg4U6CV91gYbH6P1uYTlJehq4NMc9VZ0fudjnjS8sD2+glrvm?=
 =?us-ascii?Q?85NjnFVuQxZEP+6C8dWOUbcbMwr2uxGfqrV/tALsLnHsQSVsKk8VIr+QG1h8?=
 =?us-ascii?Q?NBshEzyijs1KAlp0ySKv7/8TtHmZwxMINv5tEqrKG4wPZNzEMQVcGoUT6UMb?=
 =?us-ascii?Q?zgcnjKmO37b/d7fQt7rlrlS5N+qq0gCA4MU/qtk050+WRL3cSgs4JDkyXbqf?=
 =?us-ascii?Q?B/NDhWsEANd20JlpaiTDwTo1yX3qiFFMdl5dWGHZDLIsYAWWbx/q+axY1Qry?=
 =?us-ascii?Q?7YbAmp9MIc0rEVsN2hgzEvmGdClrPw10gaV952gSi7/lK+PNEqIprjiWI4gE?=
 =?us-ascii?Q?whym8UGykTj5MWOnoNpYrBwYUb9yYMpvuhofjKVztkU159ynqRx7nxUCBYR7?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4ac0ae-5950-46f0-9158-08dd72de8d86
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 18:37:14.1764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKHEnmsb5AB5fwilWPZY3CKdbYaP/LZOwh/gkVi2Izb6LIj64mvEtqAxVHkkyzNfYd/MRJFYlJxAVZSiPrhLcpOdg7tSdZoVF5cTNy2qggw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7701
X-OriginatorOrg: intel.com

On Fri, Mar 28, 2025 at 05:21:32PM +0800, Yuquan Wang wrote:

Commit message from v1 needs updating to reflect what this v2
is doing: 'add empty CFMWS ranges to numa_reserved_meminfo"

> With numa_add_reserved_memblk(), kernel could add numa_memblk into
> numa_reserved_meminfo directly.
above comes last in commit log.

ie. State the issue like this:
> 
> acpi_parse_cfmws() currently adds empty CFMWS ranges to numa_meminfo
> with the expectation that numa_cleanup_meminfo moves them to
> numa_reserved_meminfo. There is no need for that indirection when it is
> known in advance that these unpopulated ranges are meant for
> numa_reserved_meminfo in suppot of future hotplug / CXL provisioning.
'support'
> 

Then the resolution:

Introduce and use numa_add_reserved_memblk() to add the empty CFMWS
ranges directly.


> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>

With the above commit message and log updates, and +linux-cxl mail list,
add:

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> ---
snip


