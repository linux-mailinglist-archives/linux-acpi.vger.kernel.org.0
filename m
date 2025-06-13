Return-Path: <linux-acpi+bounces-14363-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBE6AD93DA
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 19:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8EB41E130F
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 17:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8799224B07;
	Fri, 13 Jun 2025 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UWSIIClg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F552135DE;
	Fri, 13 Jun 2025 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749836387; cv=fail; b=DglaLwfNuWnZH1Bjrhjr/H+0xY/0zSwCOsgTyNA/dPiclMQlbSLXXdPkSALatrAQ/jwXGXUl8O5W4RM+7+AevG8nmypfRyKOWTs7ZZ0sjizySQ7agFkNlIPb/N/CIw2dvmVqBXsn0kkC9j0V4GbjF2Tv6ETp6FpjowFAtKSX9Vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749836387; c=relaxed/simple;
	bh=eUaIfANy+mhsPs+oX+e4lIYYXx7v6/+cy5hxl4iTt3s=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mmfkVFYvbJVJVoLITUoOmvXreM8IemVlT9rYL9Q0bh2lbF++8tF0Z82BAnfdNE6BTjJ801OhPKlhi5gRfZek+4DtGJtf9O7ICGlfPz5fTHBbQb87is/jM9D5+8WFHVlea0wU3lnobJMUUmjyLyYlOM1gIMsxJAlJMbZhK4bReI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UWSIIClg; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749836386; x=1781372386;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=eUaIfANy+mhsPs+oX+e4lIYYXx7v6/+cy5hxl4iTt3s=;
  b=UWSIIClg1rSNbOZ7yfQaD4f4mwJFao3Rj3k2xf1YmPIQlTtFKCfFw6UA
   JyU91/ytdscZhZNUbeqZ3qcQJf+RoKysOxqhyeZxml2Bv/XW7U+KCIuFw
   MskXWIP2Kd9QxJ7RIAxe6FnzKto9DzuzBjYv0vUvRqWCVLPp7dYTxp4dh
   nscuywLsCkoMJ1MZqQDfcIcI7ySspvEYEnv5y1NLBs+dXhCeK1hlBmJB+
   jHnwjRKSYV/1H3EIcm+tvvOpT7W06HbT2xrPNXK87VpgbdGEx+oVtK0Ut
   1I5+kac9h07qKklM3RysZF4DpjAWiQ++OJ8+pmBhRUpsYvoEgqcUy8LLB
   Q==;
X-CSE-ConnectionGUID: m/Yev2kZRHWunp4fJqVpoA==
X-CSE-MsgGUID: GuAvg8lRRQ2FuxE7XcEwvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="51171786"
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="51171786"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 10:39:42 -0700
X-CSE-ConnectionGUID: HY4rNckeRHqCGgrJcjPXbA==
X-CSE-MsgGUID: o8csiuOuSJ6s7Tt2SbUQJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="151700204"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 10:39:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 10:39:41 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 13 Jun 2025 10:39:41 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.85)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 10:39:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OgBSoaeczeGjxzmfrIei92XJRws9uT2yhqtJIe8CQTM28ZMHWPk/FEcOR6/tRXqFh7g6vfQh2hGnkPx+ivnDDPOwgNhHi2ZFli8dMl2KBc7wqbY5KUCDqxNNk7/aDJ++PSXfirGprXQUC9sHycrdZwt9sABN4Zu0f35YoZpAPP5kb5Fa7TtTvyAsOetEFcJfYHQ2yDyNwSJiJ/m3CtKSua9PdwYsiRcSkAZhRbUj9q1WTvoqxYI2/spopuz5wn+mRUmXzO+j8uCcV0sgHE5TKrGR/jKdW/SG/C+wTcJyEGjcbFr1qpj0GWruFziTzpfzc0S8jcOJofuXIoOBia6TfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bj6DLj2ccGs3nJI8ogVPzcHdwm4fGmUtR6RsPXG/27c=;
 b=m4SPaXOxFvO2Py/1GqVNTT3fYspfAyxoZNH6crxPoK1ivNcD0qRvS57HXu9V7bJj/1V5fQV9+owEkEgj8THd+W36+mWe5zsx0JNaH0QqYLigjl5klQLp1dgBS10V2Jks8/TNTR/sSu8CQ0jDXg+5ZvxwFhkMibNW/smRTSSQWPEPjOrUWysSsbvfFlgxMpeSBD9a4sEVWrxl1BwtRnAf8nPyo/YRpHB5Wufylg+AitAAsHa3hPFXJs/heG/hKQ6Y+ZB392PwdFFxRHa8wFAUJrqMlbG+EBGNI7YBqWMeVN+Yj18InSQWye8apOcGkq4wmWw9xoBvqdY6IuMVVXSijA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by MN0PR11MB6181.namprd11.prod.outlook.com
 (2603:10b6:208:3c7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Fri, 13 Jun
 2025 17:39:23 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f%4]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 17:39:23 +0000
Date: Fri, 13 Jun 2025 12:40:30 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>, <kees@kernel.org>, <gustavoars@kernel.org>,
	<Jonathan.Cameron@huawei.com>, <sudeep.holla@arm.com>,
	<jonathanh@nvidia.com>, <u.kleine-koenig@baylibre.com>,
	<dan.carpenter@linaro.org>, <viro@zeniv.linux.org.uk>, <ira.weiny@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<gregkh@linuxfoundation.org>, <peterz@infradead.org>, <dave.jiang@intel.com>,
	<Benjamin.Cheatham@amd.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v9 7/7] ACPI: APEI: EINJ: Update the documentation for
 EINJv2 support
Message-ID: <684c628eb0605_224f6a29415@iweiny-mobl.notmuch>
References: <20250612231327.84360-1-zaidal@os.amperecomputing.com>
 <20250612231327.84360-8-zaidal@os.amperecomputing.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250612231327.84360-8-zaidal@os.amperecomputing.com>
X-ClientProxiedBy: MW4PR04CA0167.namprd04.prod.outlook.com
 (2603:10b6:303:85::22) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|MN0PR11MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c320365-632c-49f3-480e-08ddaaa13c66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ysHAgRP4bsihauwN/Y0kpz8l/Xmt6qOuz3BFmCBT3VxJlrGCC0bGiI3DMoXO?=
 =?us-ascii?Q?Lu2rpGnu4vrnmouH70z7qvxCxU8q1KAZ4B4mkhyUHdbj2cvrGKD6jiXkIYso?=
 =?us-ascii?Q?+8HZ6gahbh75qAxtNrLkSRYfKy0jME/rc/VEEY3JGnhU6qcqd4fyqW49lj5C?=
 =?us-ascii?Q?SDJC/rutpl/klxfFzaR5bKc6zh5nWgkVA+fC+9KaTE0+Uehv+Sp1D7Ik27TL?=
 =?us-ascii?Q?/5M7Yp8w+u88Zbt7+bn5OfRqdcSpOt6zEhWsNosGWpIDJ4GjTyvolKi6m0o7?=
 =?us-ascii?Q?l/77VXdyALGr1mf6457a9ChfMYajlZqjqJKyEIcdxL/HBn7x8MkVP0x5jFcG?=
 =?us-ascii?Q?F+oBs0KfU6j5BLuVeim7q3uUEF08FUuy6l/kpqxoynAnbnIYZ2mqN5QgDIhY?=
 =?us-ascii?Q?shgQ7Ye99k+Zm8I5mZLtJ4dfMjhoa8DZHFY5MWmRQbaBabmoP8NRf6KVLi1g?=
 =?us-ascii?Q?tSvCgK9uul7hwOsRvuErokP69OnIaJYFcC7knxuJb+cu3U6oRVTKiqZf2cJ8?=
 =?us-ascii?Q?UK0AJzuWX/43ugR/EGuTpKBcnQagL6aeJzlp020V1lWQa5ekg3vQkGMQuvYx?=
 =?us-ascii?Q?C1441Ud3CAu4Yl7UFNwHPjqzAaGxBqj4EGAWsqa3o0/XCO4q4qlS/UKmG1JG?=
 =?us-ascii?Q?Ah5zwcacELwDWymDZ5X2+t9h8q3y9XL9WAZ+2W4xcd2btrSp49FwWBKhbpKU?=
 =?us-ascii?Q?VglmPQgJNHxHoqIXW0WxzG6YK3W7S87B11guqL5YR5GnwqU7Gj3I3d6IVLgf?=
 =?us-ascii?Q?CzOqkJSd2EXvBkg0FcOP4u2IvRemqOKkXxECBYNYZxI32gIXsE/klEFgpZp2?=
 =?us-ascii?Q?ndXP/zInU4H7yGS4UPU/KBcqIbPqQuoMto0FSJMTqQvy5Gy7eoMpsdjjmfkD?=
 =?us-ascii?Q?jtAARXd6cC5QCXtEKyhQuublu9SeeKWaUZLeYQ81QdBvGdo0XYh3FhgO8Tu3?=
 =?us-ascii?Q?fZZpnVTJ9KwjoaQyHTROeAI8m3Id67pkjQ4hhdanD+Qhum3p8b/6eX+wPjoj?=
 =?us-ascii?Q?xNs2VRYxxR9LZRtmkbe+1fQYfq+pHY49LnYDwOGZuEdvJONDEXAyVVPWmIsQ?=
 =?us-ascii?Q?LsAVnH6qE8kEKZ96z1bxSHpAtRLe637LToIva9DFEeqdlVQg61sXLBVRRtu+?=
 =?us-ascii?Q?gvVOEEnE/uAWXyVe4CZrsxRQochPPbiNhOgrR/oLTegv27U3uiEZP36O7ysD?=
 =?us-ascii?Q?O+NjprXLstpUXUFfip2jusn7lBl9UINKDDFk8K7Sf6qmdoENcnLine+ziYER?=
 =?us-ascii?Q?GytHzJuLCaz7ihLlhJ6iVbc7G9Nuo9DhekmvbNnG8UxkpplKWwQYG4DtIdTd?=
 =?us-ascii?Q?O8gqRE3RTeHpdk7U2PECYHPQ4h2MfzoypvDKll/Q39uoNYyhFI3MNsb/Gp6L?=
 =?us-ascii?Q?YprLcOnzP9KklQPm4r5EghiHjT1Gngh6o9RakLhc2hcqDuHtmlCQSve+xkg3?=
 =?us-ascii?Q?bixEpCTcl/o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4ceHxZ793l8IUV/vMmXLt9POaBJ4H5NoJUUnUcPo4bpN7Mawzwmsjwj7gLtp?=
 =?us-ascii?Q?oZ3fUGJ0eAW9nRbLnNHJ4FeE9FmoLz+eP75zxJI4BxhhdJkw5b1+vLbvAOeX?=
 =?us-ascii?Q?ZA9TqZfIQn8KD7z07Jt/xehRR5lIeg4jaBFxBjYiWFbTYBDhDKz05JMpjmA6?=
 =?us-ascii?Q?UrTKHOe5oFLYxRfPoT5X4pqItud2uRK1hTLO/qMAUb5RrJjq79wlsW1SZgj2?=
 =?us-ascii?Q?wpaUJoYElwANVVeDGsBYTuMPsldX/maGvtdmUgTley5KC7IgaCWC61soRm62?=
 =?us-ascii?Q?0aVis4/g20gXlVtbgiOvi1pi0wz+ChlnUaBceOBxxAjQ03IW9KkqdCob6d1r?=
 =?us-ascii?Q?DnLxU7M8TTOT7WBhOXJCdSHK5HqKd6QFxyIQt9wNI9jSRlHbRGruaEhDnKti?=
 =?us-ascii?Q?KsVlJyVOxZWwNfmxyKto1tmSqUouQMyTePVhUEgYqhz+16fLFzFjgWERLTTr?=
 =?us-ascii?Q?Gqt87I/FE1msj6oEbjDIAHzXzom6btrYnz2rJ27HHzs3YczMjOs4A8ebmGkO?=
 =?us-ascii?Q?KOB+pm6fMkDlcNdAUV5BADXJmNR9xEH82n+01UIB1E/W0fQ89xLcS1oWGxJz?=
 =?us-ascii?Q?77DIbQO61+mH+0gLN9gztTcfIw1iw1R5FsDZHeDdj0xYFXh66tceymSgPMfE?=
 =?us-ascii?Q?Vkf5ni2rBgkRgP83AOiYG0rPouECG6SFacVAAlN5gaKEiw3y1YWR0WO39aDv?=
 =?us-ascii?Q?UPrs35sUcO/1hvBNORpGR1mW18f72wSNFJ4coFRlvvpo6jiyfBsItl1ZVdo9?=
 =?us-ascii?Q?rXjn+ThDmdBel5/wB+0gnqD2NCILpnSeaR+gRMDqeTgI7hPSB1EAN3GGKY7q?=
 =?us-ascii?Q?rJNmtFIShB5OWi5+yneJf1mnA+4CbhO03azC8Iq2I7eGv3N//8iG22su2341?=
 =?us-ascii?Q?hN/zGpKviFvf4qOKGe/Nkq4rAwelLvr3ufubbj8W5m9G00YeOA7c6pudqDDZ?=
 =?us-ascii?Q?PtzKvlfeLf5r59Avv5yUDZVUj0W1iG1puN+ZYL+bBTddNq1P4kDB6WyOFQb8?=
 =?us-ascii?Q?Y7B36zcoU7Zx3WD/c6Nvhiz9pZFap/S6/IW3CWv2RD2qVb+VwSv7UQANJyIS?=
 =?us-ascii?Q?x8faekZKY38cE2Rrrn4AoL79/psaYzdPHAq0y3nzKfxQlK3iSY/ThCce2EIC?=
 =?us-ascii?Q?wkc4PgK7lDcFBaOiS5aFHAK+lYSDlxEbPkdRfgEJdXLue0i/AOKmhYCWDxcH?=
 =?us-ascii?Q?QO45vaNcrmMKYmAoAlSCTqruEYcIn5pykSwyY8+gITUYbrFNFjnKgRCthcr6?=
 =?us-ascii?Q?sgbIAFLuQ/v32XYJy4Ygo6/ZbFVy4kSyqE3WPMrcYV3NDJ4ucGOoNex4TSK8?=
 =?us-ascii?Q?EfSlm3j2NGzPwV2qo3CUtHILjNwWO+Dc1wUfG30Qd8drAf7wIoDZaPD86jyD?=
 =?us-ascii?Q?uODzVgkYiUM+oO2tSL2G4M92XcArXIQxL/rJWXn0DGb+Xx7YGt+IXvVA/YuC?=
 =?us-ascii?Q?pi+N51oEwKjf3b66xc6RKV2v3f5eOT03hcG5TdtOeH+EUSjIqmCbjY6Z/cAk?=
 =?us-ascii?Q?LtHnRKAVUNukZxPDIGpNA0oMj0hJ5u3PUuJG3K0ZUO2wz1TgGd8DapdctcSI?=
 =?us-ascii?Q?JkJeY3CfnE+W+IQ9af3eME9/eYi+bBnbJEA8N5hw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c320365-632c-49f3-480e-08ddaaa13c66
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 17:39:23.7594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gQQdtbeUF1z8eYcQIAzwOHiugktGnwz8Y2yMlZHs7saFaWjycK6rOyOSuBSY0+NanA7MFyGozK91yQR0MvLT3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6181
X-OriginatorOrg: intel.com

Zaid Alali wrote:
> Add documentation based on implemenation of EINJv2 as described in ACPI
			     implementation

> 6.5.A specification.
> 
> Link: https://uefi.org/specs/ACPI/6.5_A/18_Platform_Error_Interfaces.html#error-injection
> 
> [Tony: New user interface for device id and syndrome]
> 
> Co-developed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> ---
>  .../firmware-guide/acpi/apei/einj.rst         | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
> index c52b9da08fa9..7d8435d35a18 100644
> --- a/Documentation/firmware-guide/acpi/apei/einj.rst
> +++ b/Documentation/firmware-guide/acpi/apei/einj.rst
> @@ -59,6 +59,9 @@ The following files belong to it:
>    0x00000200        Platform Correctable
>    0x00000400        Platform Uncorrectable non-fatal
>    0x00000800        Platform Uncorrectable fatal
> +  V2_0x00000001     EINJV2 Processor Error
> +  V2_0x00000002     EINJV2 Memory Error
> +  V2_0x00000004     EINJV2 PCI Express Error
>    ================  ===================================
>  
>    The format of the file contents are as above, except present are only
> @@ -88,6 +91,8 @@ The following files belong to it:
>        Memory address and mask valid (param1 and param2).
>      Bit 2
>        PCIe (seg,bus,dev,fn) valid (see param4 below).
> +    Bit 3
> +      EINJv2 extension structure is valid
>  
>    If set to zero, legacy behavior is mimicked where the type of
>    injection specifies just one bit set, and param1 is multiplexed.
> @@ -122,6 +127,13 @@ The following files belong to it:
>    this actually works depends on what operations the BIOS actually
>    includes in the trigger phase.
>  
> +- component_id0 .. component_idN, component_syndrome0 .. component_syndromeN
> +
> +  These files are used to set the "Component Array" field
> +  of the EINJv2 Extension Structure. Each holds a 128-bit
> +  hex value. Writing just a newline to any of these files
> +  sets an invalid (all-ones) value.

I guess I missed the all-ones value being set.  :-/

Ira

> +
>  CXL error types are supported from ACPI 6.5 onwards (given a CXL port
>  is present). The EINJ user interface for CXL error types is at
>  <debugfs mount point>/cxl. The following files belong to it:
> @@ -194,6 +206,27 @@ An error injection example::
>    # echo 0x8 > error_type			# Choose correctable memory error
>    # echo 1 > error_inject			# Inject now
>  
> +An EINJv2 error injection example::
> +
> +  # cd /sys/kernel/debug/apei/einj
> +  # cat available_error_type			# See which errors can be injected
> +  0x00000002	Processor Uncorrectable non-fatal
> +  0x00000008	Memory Correctable
> +  0x00000010	Memory Uncorrectable non-fatal
> +  V2_0x00000001	EINJV2 Processor Error
> +  V2_0x00000002	EINJV2 Memory Error
> +
> +  # echo 0x12345000 > param1			# Set memory address for injection
> +  # echo 0xfffffffffffff000 > param2		# Range - anywhere in this page
> +  # echo 0x1 > component_id0			# First device ID
> +  # echo 0x4 > component_syndrome0		# First error syndrome
> +  # echo 0x2 > component_id1			# Second device ID
> +  # echo 0x4 > component_syndrome1		# Second error syndrome
> +  # echo '' > component_id2			# Mark id2 invalid to terminate list
> +  # echo V2_0x2 > error_type			# Choose EINJv2 memory error
> +  # echo 0xa > flags				# set flags to indicate EINJv2
> +  # echo 1 > error_inject			# Inject now
> +
>  You should see something like this in dmesg::
>  
>    [22715.830801] EDAC sbridge MC3: HANDLING MCE MEMORY ERROR
> -- 
> 2.43.0
> 



