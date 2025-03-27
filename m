Return-Path: <linux-acpi+bounces-12501-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3C9A733DB
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 15:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8973D3A7A14
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 14:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F0E216399;
	Thu, 27 Mar 2025 14:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OkwED3Rg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579CE210191;
	Thu, 27 Mar 2025 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743084282; cv=fail; b=E4urlL5TLCez/gdWOp2Nah6to3joxckgvwz+24Qtwm7ZY2p2IpFD7okVWKBioqSew5H2+sYHLd4YOJ3yYRj4Q7tiq3Gf39yKSiQbDRSFg7sOC6oBaclvp6D4JzlULiLPEunyjAkSV9oZWEPfFTS7vndlIn6ke/7QwpYx1x0Yl+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743084282; c=relaxed/simple;
	bh=/WmpfakWmHC+aRT9xINoBx6NFM5PcRrClUkQoDXD1j4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PRsQ5i8oaDWahKt61X1MYIAwc9yR4g9GNrwRlM11J5Hfis+zZj06fV6InjPaAtNUebayIA5iJ21p8QaGGe7FmOsQfbX/eELglzbvMm6r4CoWzrXzj/ol/OJoHYtrJNVHjKUm5tUlsp+Y/wP3Me9Fb9TmK3oo4n84ujRbPWDQ+II=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OkwED3Rg; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743084280; x=1774620280;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/WmpfakWmHC+aRT9xINoBx6NFM5PcRrClUkQoDXD1j4=;
  b=OkwED3RgC6ZDpV+8A4CszHVUjYA4XSu7d0PCaO3oOKp21bbRVW/ubZ+N
   zPbrKeNxsx8x9mInyK259HpLKCaiGUuNdK8iF8H2HLCK2vhWQGH7eMczs
   6wf+1DAgLvB8DZ710+t+J6gZC3gjPFH03OkgpzC/ubBf/au6AoL4Z8V5I
   DoSUODDa+OjDbKI/5WhqQ2ZUw5oxX2H1iyLqY1DQIpOYrSjk4fwVaPmEK
   yYVXfYd0L942tKPoa56vPDaK6iGvxyCUsZiPIjH3LB7R3N/OCFZ6qAT4f
   2B7zBrRYMbiFMMU9hLBQ9tyQ+BfZLWcuVhVXi22jiHa0dgd0m8mHxjTto
   w==;
X-CSE-ConnectionGUID: 9tOf4WwZTHObJ86xbTMIgw==
X-CSE-MsgGUID: O9sGWZ0/TBi83YMiUjBCcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44540337"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="44540337"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 07:04:40 -0700
X-CSE-ConnectionGUID: 3j+TT+4YTyqEaPYGxtNL2g==
X-CSE-MsgGUID: BsQMcVvcRXSRUio5wxLK8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="125168190"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2025 07:04:40 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Mar 2025 07:04:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 27 Mar 2025 07:04:39 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 07:04:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yoOFogfI0WQJMePsE8T+G/7rbt37+ZV3w7rhyWwQY0XtUIXozBpyZZ43odEqa+5/lA4OAcTBsw3Na5Sg0vl+FzXP31IYwQcZP2BpYj4SKs4BDR16TXpK8zDDLQOSqRgWs81ISwb38CLqdVeRk9RP8jNZFBJ/y5SbR1CywUbO3s454VDm5qiyluKRd5FyYgZXx+iQTrQ7xSGm17ubpPH0AL4Zz/jCseOA6mdKFccby5bJEq8jkNSHS9ORfSh7qAYsehj7IIIyAxJ6GWI+0dQ7epl3AILPXt+DAIQwA9pSVS5e2ctnJwZvOlbrROErvc91CokfGhPOZRyGWxBxHTNdGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FywzX2d8h70p2ZICHY8vL6f1o4E8gEOEs5feIPanw6c=;
 b=mzMQvm7X3JuFjNAbCWwpk0ozg3J53riOu7KCHiBhaL7M2gsUZDV0aQ1iCQOmHUAzP9FLiNE2LDez9QDjUJ4+dlDQd65MgaBPmsIJm971DXHrv7qx1/y9N4GOF6cbuHHhgK900efgmDWtHBSnCnc2NtZsqaHusH1Z21cuFr5DBL85FAMPjJWyySRzL+PG1g6n4OjHkbC9r6xLxamTiZn0nk5e2LlTU/+tIaLk4EmbOJf3llsnPrjH4pGwi9okF+DWUEdDsUy4EYUyhJT8M5OY3oiZpVWnsOG4V3N0EnTA2hUUuEXfx3kzvdu4/3PBC94jB5A++o6G0hmfrtbJbcuqCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7366.namprd11.prod.outlook.com (2603:10b6:208:422::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 14:03:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 14:03:53 +0000
Date: Thu, 27 Mar 2025 10:03:48 -0400
From: Dan Williams <dan.j.williams@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	"Ira Weiny" <ira.weiny@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	"Len Brown" <lenb@kernel.org>
CC: <nvdimm@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v2][next] acpi: nfit: intel: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <67e55ac4dfa2e_13cb29410@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <Z-QpUcxFCRByYcTA@kspp>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z-QpUcxFCRByYcTA@kspp>
X-ClientProxiedBy: MW4PR04CA0295.namprd04.prod.outlook.com
 (2603:10b6:303:89::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: a44be066-dc18-434c-4ae1-08dd6d383559
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xoDo3tgmWKHAjs57sc07upitHc2A+XR9Y/u2IP//blm94LX9rpN8oFZsrk2i?=
 =?us-ascii?Q?joYLCDaICc0+upoyAdjmZGa4nFitmm8vTJpNxXqoYO8heNboI/CrIml0hvZl?=
 =?us-ascii?Q?Jawx2ew7iCRMYREhGYVAz5jKenwdvyCIZuog/BsnhHg6vJdS2ijyQNmwFrvv?=
 =?us-ascii?Q?b2RsbKnlCImWWue+8E9QKf80upvPrCqjT495eRODB70xKN/CEF8lHB5gcdUy?=
 =?us-ascii?Q?0bpOz2Ka/+tEXkxKb0nzYteNEZK88scUOsbWJo4YlHIpGrPV0h9S1T4d7TDo?=
 =?us-ascii?Q?F0GTyhfSeBCXkm4zhxN6eXKLlv9s8m7f8rZrIoM+v8doKvS8kGKG7r++fb9f?=
 =?us-ascii?Q?Hkjk7fGywutjyuMBLqiM24CQZ7YvfCdX/5BzWFi15QFJGsdYdzz9PTsSpdwg?=
 =?us-ascii?Q?rByAJsOXS4WR8z4YT49vNFGXcv4djM9PYxbrLnx23PeseitBSkZTa/zFJWwk?=
 =?us-ascii?Q?7MWYHTE8oNj1WZJryn0ruNZSwKnsKiN9nTIfN4xIewXDIJKxJDjgQrtp3yZ+?=
 =?us-ascii?Q?C+cWOx5i+bjN5RpVUNIMHLSpLX8AprVHrR27Yfc+oUdG5WBisSJSMvaxV3Gc?=
 =?us-ascii?Q?yiPRTYQtVVtb/QCVfXVQHGroo7R5xstH6q7l5PRI4/limLn6uColIe0l303u?=
 =?us-ascii?Q?AGFUHJodmdvEjsCc5LPa7MuD07rENhy9KOmXid/+wBojspHdSrJvUTxFjAmF?=
 =?us-ascii?Q?tTeQy/ERG94c2JaGfteSfq5SuGn16KkO342VUAwYqnw6/nvjPw8Mer4SPbU6?=
 =?us-ascii?Q?kWmEyyQ4C1yXYxf612G0OOMMj38SIIRND6AwJoYX9GjS5ZjKqwwBcIEHFenS?=
 =?us-ascii?Q?z7mYRARJUQ2bsZDmUrHm1RkW7/Apc75LnGkdTVRfq+OcPrA6rz4xttvDeTpy?=
 =?us-ascii?Q?0b003cM8rrjO6K/2oxVv5YbnWDggsgBS3/f0g7on3vrgKjtyovs11a+fTN48?=
 =?us-ascii?Q?ktzjmHwANNKiqdL2B/dQBt/GMaEFlJBl3sys75rDWxXi4ToPeP3UiKP8IXWr?=
 =?us-ascii?Q?6ATDzAzfQDtEB5mO/eiiAFrbAoS6WeE7euQ9fTbnIOyROu4KKdvp2xq+ABBz?=
 =?us-ascii?Q?YQitkSfsG85Bj79FzH9dUInOK2EXeZJPb+ddpRwh9Vx/D4t8jfMQPVAbbnfz?=
 =?us-ascii?Q?0SYLZX5+8e+1T5nBxDtt1pnn+ozucz7616qTf4lOP5Ayw0ipntNkE7LpEtwR?=
 =?us-ascii?Q?2z8z+DOCxVa9uHRtcAJH+zMm583LZrA5YGj2oq0Ce+oDlPwCtNE30zr/VOyc?=
 =?us-ascii?Q?ZeAIei/OfKPp6VIahkKxTdxgI8Pos0ew6mW9Secl6LlpCberIbokMDGSRGAk?=
 =?us-ascii?Q?840NuXY2/zuaGFVc9QIRyrlNHAyk4jGXp7lFq6Rk7klO6IpTfHcLA3xpfcv+?=
 =?us-ascii?Q?hogb1yEr9iWL3ap1WA4r5pcioEQy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FXtwYhOGGVeVAvRy+gJIb6VUDmxE9odnEBU03RpWWuQyhaEEp0dtHgpn0Wca?=
 =?us-ascii?Q?uD06u/SeI0kcObL9+TJkqh0WIyaF+wceJYwdE0Z8j/jelPqu0lzYLCLZ6ebY?=
 =?us-ascii?Q?ZPcWEWd17i5kocXtj/iQYtcTkevH9p5gBHPYuo6BXkiafyIHzpnUCdUbh9f1?=
 =?us-ascii?Q?WBSYmyOZb9N1ImadBU4RUxPB2hEXyyUDmVmQC25bByNO3dPmPPPsbVVwK+Pm?=
 =?us-ascii?Q?yRHNBhj482DGjs+JmLUlQO1tpNlIBPaJIEI10mebqPhBjw1Z/BxMjJmAanFu?=
 =?us-ascii?Q?B0rPTj1lTrWBsPf5UnyKTQLABm5Nz/prW5uLFA0R0RCDmmFfDMZA8H0VuS0x?=
 =?us-ascii?Q?vJHI7PyoHIjv46fQw/paZz2iBLp1Z6tY/fkvKbh1A5ZcrkQmww1+TF+R+g0U?=
 =?us-ascii?Q?66Z6bckiHibdBXbVkxum8KxEXvPPZUFnnfEdE+OhCWr28fJX19HFuqQdktMK?=
 =?us-ascii?Q?kzcErkcepGhY4J/SdgA2RL2sNfwdmsh7iwob3TBwcud7kBO9p/bvgANAbu1c?=
 =?us-ascii?Q?Jje3voQ79nU507F6VeqDVwrCA9nZThVc25c64jt8q9xLxEEfaOBwcQ0izw5d?=
 =?us-ascii?Q?igTI4nlV55C6YYrdTbkiUiQ6tdBjCN9O0UhJa3S6xyoRr5hnHoDWQW/n/ln4?=
 =?us-ascii?Q?4z2kfSIn+pR7MCIY217N72kk/C67qQ4o4C4bgYAtpB5cbtQHiZ2JpYVN8MCn?=
 =?us-ascii?Q?i2wA/giANoXtLVH5bPo1Op3I8A0d0F2Y2AqjrPQ9nM5KwfebceCKKhsD1Wi9?=
 =?us-ascii?Q?hO5naVKfq8pWbudcmcxfUOYc1bOaIsdtfFHic6xE2h5HwlYfRlzcWOM7f5q4?=
 =?us-ascii?Q?8/6XkQOS8oUo9/2tQm9+yUnWfed/592KSKhD+71x/t2OmsQg1nyKq2taQ0vh?=
 =?us-ascii?Q?morbER4sEat7YnaYtbrcxDK3DeEpOIAWUegceD4sIz8ObmOebSbWfLngM6PH?=
 =?us-ascii?Q?8gPQvYACiwFClCxhN6Aj4DXfdZupglPX9mOgK8JpLHp5V4JTbfBwWPiHtgZY?=
 =?us-ascii?Q?hZmOcHFX7BQRSTe+VGEqbxRVlbOmRQgJnXXLqGZ6mC7UGYq13vkrDeAeTJOF?=
 =?us-ascii?Q?dGVVvC0f/IGG0BG0nwYyesLzIeK4bieZDuqNrlMQGHgOqVZf73BZchiO540A?=
 =?us-ascii?Q?GtM64BENRS8wF5MlEylPtUGaGf1d7mjC1osfOsluAhV5zujqe7J0OIvrkyPd?=
 =?us-ascii?Q?uARYK+nEqc/0SwbdgEdhKPCeLli+PLXQAeE86UybzVI3FcCprqa/wP7/WbKP?=
 =?us-ascii?Q?Ax0rATZWzoCuASYs1E1mBq6g4gooPCrkL/5cH7Xv7ZoeZlc+xuB+4BK40iRi?=
 =?us-ascii?Q?JmHl+7SSFpoc/b+AoOwINVnIgTdZVgE8DQtpXo/k3UI77SPRc1ZQVBxwcl3Y?=
 =?us-ascii?Q?HaHnW5pAsdwjCnstQzRLdZsCe99NyowXqroo2E9s8DM7ssB0TnNk5DARQNpG?=
 =?us-ascii?Q?lXf8i2+dqYsuTo5ljZ9K+5TRnRcCwVcsPOXxUtUgNO+SSCbr1nI2VzfKWU3E?=
 =?us-ascii?Q?t842Xw0BIvhcaXxDG7KVERMGO7VniT4dKXwoQLc8lz6Q1w1KQkum8edA7yRF?=
 =?us-ascii?Q?Dtgh4W35+odZHM7MFue2BFgi5qs0WehUfHAN8qZ1UTY8kfpCAWD8HnnBm/Pj?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a44be066-dc18-434c-4ae1-08dd6d383559
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 14:03:53.8992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/9xe4VyPfU0vzHP2vevL1J1KSYJ9aFAehN+vlvJ+unG3IQDscnIT5KoGxknagateUGTK9+LdlLPO2yHEba0vgNYxQb73H+YTDy4b+SYjhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7366
X-OriginatorOrg: intel.com

Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the `DEFINE_RAW_FLEX()` helper for on-stack definitions of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with these changes, fix a dozen of the following warnings:
> 
> drivers/acpi/nfit/intel.c:692:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - Use DEFINE_RAW_FLEX() instead of __struct_group().
> 
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/Z618ILbAR8YAvTkd@kspp/
> 
>  drivers/acpi/nfit/intel.c | 388 ++++++++++++++++++--------------------
>  1 file changed, 179 insertions(+), 209 deletions(-)
> 
> diff --git a/drivers/acpi/nfit/intel.c b/drivers/acpi/nfit/intel.c
> index 3902759abcba..114d5b3bb39b 100644
> --- a/drivers/acpi/nfit/intel.c
> +++ b/drivers/acpi/nfit/intel.c
> @@ -55,21 +55,17 @@ static unsigned long intel_security_flags(struct nvdimm *nvdimm,
>  {
>  	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
>  	unsigned long security_flags = 0;
> -	struct {
> -		struct nd_cmd_pkg pkg;
> -		struct nd_intel_get_security_state cmd;
> -	} nd_cmd = {
> -		.pkg = {
> -			.nd_command = NVDIMM_INTEL_GET_SECURITY_STATE,
> -			.nd_family = NVDIMM_FAMILY_INTEL,
> -			.nd_size_out =
> -				sizeof(struct nd_intel_get_security_state),
> -			.nd_fw_size =
> -				sizeof(struct nd_intel_get_security_state),
> -		},
> -	};
> +	DEFINE_RAW_FLEX(struct nd_cmd_pkg, nd_cmd, nd_payload,
> +			sizeof(struct nd_intel_get_security_state));
> +	struct nd_intel_get_security_state *cmd =
> +			(struct nd_intel_get_security_state *)nd_cmd->nd_payload;
>  	int rc;
>  
> +	nd_cmd->nd_command = NVDIMM_INTEL_GET_SECURITY_STATE;
> +	nd_cmd->nd_family = NVDIMM_FAMILY_INTEL;
> +	nd_cmd->nd_size_out = sizeof(struct nd_intel_get_security_state);
> +	nd_cmd->nd_fw_size = sizeof(struct nd_intel_get_security_state);

Can this keep the C99 init-style with something like (untested):

_DEFINE_FLEX(struct nd_cmd_pkg, nd_cmd, nd_payload,
             sizeof(struct nd_intel_get_security_state), {
		.pkg = {
		        .nd_command = NVDIMM_INTEL_GET_SECURITY_STATE,
		        .nd_family = NVDIMM_FAMILY_INTEL,
		        .nd_size_out =
		                sizeof(struct nd_intel_get_security_state),
		        .nd_fw_size =
		                sizeof(struct nd_intel_get_security_state),
		},
	});
	

?

