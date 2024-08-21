Return-Path: <linux-acpi+bounces-7770-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BAD95A5E7
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2024 22:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A3411C2331E
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2024 20:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EDD16D9A7;
	Wed, 21 Aug 2024 20:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UMzF55i7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A845F16FF2A;
	Wed, 21 Aug 2024 20:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724272252; cv=fail; b=nwn71r4/z5W3z+3zNhdAX/PsWZofJmD4OajwSyhjxUoX7rr0tiIXX2g5CvUyPbGExUaz6K1dDk+HUwKupN2tR0kKRJfsh8EKPzcD9E4nRqrOGcYCfzJZF0e2Vh6lluTOQuV9mi+iUft45pspn667C7Jn3Uf/9im3iNVNl4Y3HkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724272252; c=relaxed/simple;
	bh=qSMCyGuNfnVRjnTZAXKQY71c7GRwqgV9ESRyoxNNyRg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KaEvrwwFC5SvwmkmhqHTHGMsXWg3nlafO5Nh3dkpkIwHCkm6N2FCToqEbfsDx1hkeGEW0oF9auv+pxVn3vhHoo3frL1IWyQRleQZ3ldawHY5SOgexnb0QpdR2g2seft3n67sVZQC7jYZdZkH/FXImthOrapdaygv03Gceb43nEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UMzF55i7; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724272251; x=1755808251;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qSMCyGuNfnVRjnTZAXKQY71c7GRwqgV9ESRyoxNNyRg=;
  b=UMzF55i78UvQYbEgZRY3xIKzZpFDBThPXpruhmv6sZlZH0sCCnvxrWvD
   w1BJQNZG9dnUCSY/bmKic6lktNDBZ6oASbgRmyoIjpuZyXAxT+c5PsNAU
   k02SRG7M+efcNKjEpFYAbpHcbrjFSkHGS3vLoQ2Vilu0/N23BwRwj9cOO
   fCEd7YrlcokjmOggKc4keaG6BC4rpubE0zapCmDE3kCmTprknpyaiJkal
   byrd5gVU8qcxO4qa/s7lRt1t8pe41HuMse1NlSaJ5igNV/4m3vz4IZMaJ
   JVH63GbZsaFEAkGJ78o0DCgc8k2ZZSov1NZnSA0jNplyyNbLszOowJLrh
   g==;
X-CSE-ConnectionGUID: y0YQGJ8pSjCqCFksd3l/Dw==
X-CSE-MsgGUID: lwH1XlQuSNCd9mJZMrUx+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="25550013"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="25550013"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 13:28:42 -0700
X-CSE-ConnectionGUID: 4yvPNElAQS+jSdvkz3742g==
X-CSE-MsgGUID: IqSkVjQqRB6bpW1McnSq8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="91939813"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Aug 2024 13:28:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 13:28:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 13:28:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 21 Aug 2024 13:28:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 13:28:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQBZa2P60/d2W2JAga5vRTjhwn5YnlwGGLjZUH3BiOS261kcOiGpm6LWqZDOYvCsMttZNhy7hme91p+kiwh4pPS0wj58Gq8n7xVGtvzbQTaz/0QSUWaGI1FojjKTiIr8Mcby5D1TPSGeHXa4q4vHuLKEJEeGIxCI9ikMqXoa/Lq74dEFB8z0Pdl8ehK/duguDD5yS0mZ703/3X5BKkLkf3jSfOrdbZLV0gBjbsB/n9P9kmgh4zR7B7nfXIgWV8+/H6W2U+fubS24UlYrdu4ogr8Qo6N/DmRa14mXNYiSmQtIeNsFlFstQaYaWFb9R520kUu1lsxnb0wJR1V6u0woFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFb6V2uzyvhwcgKBvHekcBRxygRKGPUN9NAjGsYtkHk=;
 b=yHLCOH4hrn0PpSu+/4VIY8jt3mZV6IpCpXFiSqj69P39wuvpye0d4L+5IvQ7X43uylnAGMxqbHYErkaD5J/uaNnOfJ+Y1p+9qV5tptnA6jrzY0cTRWKgEkDubvFRQ8H9RXkW5W7OPxmHNcwvMN9dGM9JmlH5neWLFL15pqug7/1CX7B00mN3HrENWEECQSsQWoFMd5XLeeB+UGYGNuo6PzpfCZR6EupNLcCMB62w7RuPn/Iath6pdoQLPG8ubSfjO7ZQgyPvKp8OyQep65oFxo7mZQ+R/RcdR91vlYfUiSbpMniuUVpNw1Z0ki1oE+HfWiNiuSntp3ue38hBky++/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB7557.namprd11.prod.outlook.com (2603:10b6:8:14d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Wed, 21 Aug
 2024 20:28:30 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 20:28:25 +0000
Date: Wed, 21 Aug 2024 15:28:18 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>, <ira.weiny@intel.com>, <Jonathan.Cameron@huawei.com>,
	<dan.j.williams@intel.com>, <dave.jiang@intel.com>,
	<u.kleine-koenig@pengutronix.de>, <xueshuai@linux.alibaba.com>,
	<shiju.jose@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: Re: [PATCH -next 7/8] acpi/ghes: Make cxl_cper_fifo and
 cxl_cper_work static
Message-ID: <66c64de2b476a_1719d2942f@iweiny-mobl.notmuch>
References: <20240819120055.3884953-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240819120055.3884953-1-ruanjinjie@huawei.com>
X-ClientProxiedBy: MW4PR04CA0079.namprd04.prod.outlook.com
 (2603:10b6:303:6b::24) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: c4316d72-9f26-4f45-6720-08dcc21fce83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qzdR1CMwOWoXSiBbO6q8sAANnVSeJ8+Xpzk1ihKGBIe18+IDxozqmsW+2pn2?=
 =?us-ascii?Q?eQd/42vq9kI7jrWlftBYcIXmMI1XIw6Je8Kw0M7nal5kOk7LwtAXjUvbvjqU?=
 =?us-ascii?Q?i0Z2UHVWk6vKt2WzOZyo0mspdAxe2X4W/Sd1V9OR3Wgx6OUhf2lPbpWohfeJ?=
 =?us-ascii?Q?fjJfebAtAtENXbLvyFbT9K/ICsqZiIlIso9rOAYSj4dqBKRsOsT+9yvKQlKk?=
 =?us-ascii?Q?w9HfGMPi8w2nndHCG3bh+92+qFpFcRnasRMqNuB7VhaSLqzNDCQG5QgZDJTy?=
 =?us-ascii?Q?2buxHFsVkbM7PBDDmchrNk1YV3KFuCKujAIhceT68GT6r4sfvXdeyeRkelR2?=
 =?us-ascii?Q?xDDYDTrtppa7E1F20wemfa8OrmOwf559Z8xYoNGsZ+uKEHGB0923i6BXsank?=
 =?us-ascii?Q?D3IJd8RqrqrUVhFTYJZ/JHW2fuUlJPlzccgC1YmQ//WLigU4qg2MHIGLYmEp?=
 =?us-ascii?Q?c3uz9R5eXqOgsMYR4vWfLImnqvhjwbf4I7leFAWNvgE1r63NFhjH+WKJUmP6?=
 =?us-ascii?Q?UEu03vRQFUgKSYzCIcOp/vJWelaXMy47ZgpkkrCtlsB4pYgxNnPEHkUL6PCy?=
 =?us-ascii?Q?HkGYZ5L1vrwbD48NQ0Zk2zqiu6wjufq492QDkQdWJUcKyPNfibA8KzFCv61z?=
 =?us-ascii?Q?VURQTlx4OUwX6XkmQyjRmbE6DrkYTNetKv1iHfTv9Dg1tF4JzHHmgC2m7mXI?=
 =?us-ascii?Q?S5wJSf8AhWdErcaFLwdSkoHZc78znI1OE5+NC1VdhQGcm1eHmYy70kJPhmjQ?=
 =?us-ascii?Q?9tOSk3yMsZ1pg1MyZI+kIVfjCZ49VMgg2kQs5sd9kXa7kyRXwVNTeeO9ESha?=
 =?us-ascii?Q?4HDRd2VCl8upYCnlG4Amh68AonL1Oz1Tcfn29vc9/3vsoryHNFGbrBh5NMVa?=
 =?us-ascii?Q?OqNXfJCZvn3XKayiN1pIvHv2U1vXpWjYQE0be6Vmq0IJRUmM+xH4Q8I+xoCn?=
 =?us-ascii?Q?APXv6p5RSweCxh2l7DcN5O23fIp85OSu2B0MHXkhiQLrNHFSEZsyAjXLXgU4?=
 =?us-ascii?Q?GcRE2+pZqeZhz+eF1xUwMnulxsDlJ2n5AGlB1qdQILOgU8jwjL6CI2SVIlD2?=
 =?us-ascii?Q?qf/RfGZvh/qMHCddJ1hnzX+gFYJXN9znZTSoeOIB6flHkx2GUDR1A0FprO0m?=
 =?us-ascii?Q?O3ilpvYcjG2c1YRq4Vg0OsyfygtYLO1mgeWvFe4Krys5+8Fq5KmUMPYYQv7Y?=
 =?us-ascii?Q?i9/OtrBxhif53oSL/3v3II35FC21g9OHQFHBu2lNoshGIjEnOs5r7ihXvsFD?=
 =?us-ascii?Q?LgIMVY1f+fmEjMyY4piChmdki1SNjcgPuPDAJLfELfr6u7UtyBSFL9tcTZNa?=
 =?us-ascii?Q?gBK49/BwJDzfYsL5j8yL1ggLlp321eYj24Oi2Z5NGsQm1JtNJuHWbiJKimHZ?=
 =?us-ascii?Q?//M3G9LbYDAupinztshWNPwgSYgY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ovcavMu1CJ3TUM15cJAle3eVj+N2O/KKlx60ouIz+RcsKT9fKwjpIfsezoJk?=
 =?us-ascii?Q?D0EjwzKVc1i4DRhmy1HxmAXhPgQE5y0cnLyuYlYVjl7O0vCaaJYNeYCV6PWo?=
 =?us-ascii?Q?Eqb/6MN86zNpqj42SUkKeUoHaTB0VYh6I9Ejjl97f5lLyk4scXm2Cd5OILEx?=
 =?us-ascii?Q?WS5ARRIGnbZCj7btm3nautbOyrZE4KQgjq/GFY3l5wW3/TSqki7frOruJfIa?=
 =?us-ascii?Q?Y196FBT1AI8C2hz67SddLKnu42rJDJPc+4D1BSEXvTmYhn6225Syn99UwLrF?=
 =?us-ascii?Q?kycemJ/ltTa/FPusrWXx64VcWsSxfP7WH4Mvpg5hcR5sG3pudS6zwQxI6HiG?=
 =?us-ascii?Q?wqXwOs/yf4klUi9ALeVXTzid9S6bXRqYmwLX7QKbYHVMN6PylBHvZi803Cyp?=
 =?us-ascii?Q?A2QTP7wcCM6PwxZzwztIF5coycWnMmw9w++QIEFj7saJ85IatzQEtK7cYyCv?=
 =?us-ascii?Q?f6to7QcjqkkQCqK0dj6IJmfryMb9lj4pF9ceY2gZmvlA4HQ27DGCFTqeuf3W?=
 =?us-ascii?Q?49u1UaFZoLGEwLuqaVvF9OMT/1VzxQHsEYYgMTISXzj8Qz9USLKHa8xMnFTv?=
 =?us-ascii?Q?5pPc0VxcISaSUyw7ckG60iz3zUxKtswAytlaBVmD7QsfDHXxShexV+gdYxM6?=
 =?us-ascii?Q?Hd0ikf6YV+bg0Jp+rvkwkNu8KQZmnA4rSpqY6LxOp8HxYWPUenaxUI9Y0peQ?=
 =?us-ascii?Q?oskjfPCiXxOGIQo6zE+cBqR02zqP5jumO6IR8tzbI8hlNci3BP3AB5Glsdmj?=
 =?us-ascii?Q?DAfncSlrbSuk4fvVucMyQZrVVHnD7XFEnmabdu2hGkMK/7YAuPSpACaixZ9k?=
 =?us-ascii?Q?fu2RygHpnlOkho7bXVmY3lU2Yxbkx6KEEX/htzny2x89MeuSo5XkFW3G+xml?=
 =?us-ascii?Q?UiZ8YtKfaLgtTvBot4p0DnaZ49G0gGGb5xiFGLorHaJdgO4+JtrrMR6IJlxh?=
 =?us-ascii?Q?Wv4CBFwT/l1ceHHNhWiuQ0qPV1IwLYI8/WkMg8hKz43FqeuFUXdz5sXq6hzn?=
 =?us-ascii?Q?cOTCR6xLpthvaKN5pzRR3d2tCh/v5Zp0z51mi3glsFW+ffXv7SrTCc80EeUs?=
 =?us-ascii?Q?fPv/U42MsWfokDt0NRKIIvnCLzKxEUX2pAPrl4jaDuEIXSwbYHlHb/NRi1nB?=
 =?us-ascii?Q?07Qq3kPFSs6YAOYVN7RWm8aAS+sBmmGovTCy+mpgVCTh59HJVtTKIoNczOjw?=
 =?us-ascii?Q?Se4XMdwhvA3orAWVRquwum/ckaiyM+kiIjvUzt0q9KifWM2283Y5x4jih97g?=
 =?us-ascii?Q?jUmUWpFdVG21ifGBOCzEbkjAAo2s68k5hEPM7gQ0OPVxYrm65b5urjF8KuGR?=
 =?us-ascii?Q?4K7KKm6Qoa6smIATRzjVfrJXHCoII0b7CjbFUOUafpqpjkc0T+Z7pgHmbJlH?=
 =?us-ascii?Q?nKwR3w6KsMJshokeG9mEpKPWHyXo0Em8P5kWKO+llG1bBB0y/J6U3ZDGdVya?=
 =?us-ascii?Q?900TKLGnvSOaUbRVJk6Y6J8hG3AYWielKuNHtG+JoJvZOmxjFzbSJ0bzl6qN?=
 =?us-ascii?Q?Zl2vsD9tuC3nR3s9h2dHGaoo/ToTLPBJT+hEz4SXwQYKl6LCD5JIIcD7yOM1?=
 =?us-ascii?Q?giywhKdNwQWv7KXJJ0ZJc4B44eflBu7w+fFpi2h2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4316d72-9f26-4f45-6720-08dcc21fce83
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 20:28:25.0012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VPUctbJqWnv+3WnK/0cT+GAvOKlgZlCTD576/qzPCQg02FcoBcHu70pIiig3rz5G3I+6w705dHY0ARuB3dD8lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7557
X-OriginatorOrg: intel.com

Jinjie Ruan wrote:
> The sparse tool complains as follows:
> 
> drivers/acpi/apei/ghes.c:681:1: warning:
> 	symbol 'cxl_cper_fifo' was not declared. Should it be static?
> 
> drivers/acpi/apei/ghes.c:685:20: warning:
> 	symbol 'cxl_cper_work' was not declared. Should it be static?
> 
> These symbols are not used outside ghes.c, so marks them static.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/acpi/apei/ghes.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 623cc0cb4a65..df31b3acaf0c 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -678,11 +678,11 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
>  
>  /* Room for 8 entries for each of the 4 event log queues */
>  #define CXL_CPER_FIFO_DEPTH 32
> -DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, CXL_CPER_FIFO_DEPTH);
> +static DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, CXL_CPER_FIFO_DEPTH);
>  
>  /* Synchronize schedule_work() with cxl_cper_work changes */
>  static DEFINE_SPINLOCK(cxl_cper_work_lock);
> -struct work_struct *cxl_cper_work;
> +static struct work_struct *cxl_cper_work;
>  
>  static void cxl_cper_post_event(enum cxl_event_type event_type,
>  				struct cxl_cper_event_rec *rec)
> -- 
> 2.34.1
> 



