Return-Path: <linux-acpi+bounces-10575-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F6CA0C2C6
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 21:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443441888B3F
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 20:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633FA1C5F28;
	Mon, 13 Jan 2025 20:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G8/GDrYj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCBC1C9DC6;
	Mon, 13 Jan 2025 20:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736801508; cv=fail; b=VKxYfmMPu8RapqF15uAFBSSCoBz+Ikm2txDXBNo9rFORvZ64TBhfjd6AG+wrmjpyThFfy+q6v+dhbsVZecliJCNi/t22JChcTwJt3tEdgKcy/3U9hBqcHxPEb6OckmY98U093G4UK+GEmSSLAvqvfFO7zTncWBFzNb2rAwp+7T0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736801508; c=relaxed/simple;
	bh=+4/gITe3qROiqpuR5n54Up8KTKuYj2G4+1EiS6taL9E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EVumLImWvNekDe3uguSc9OzE7mqQ1m4f0cm9D7sQoqJe8LRHMV5RsHqT5UnGWXpcsszqlZo4ptcV2sMlKoYH6OwZDy3N7/n6fCYPc41BQE3Zbfqo91dIa9vwSYZVoqtwm2LRqh3k82iXXr/+FrhjgErjsJcucJkf8SncwkNKttI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G8/GDrYj; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736801506; x=1768337506;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+4/gITe3qROiqpuR5n54Up8KTKuYj2G4+1EiS6taL9E=;
  b=G8/GDrYjNn+tom731Cx3VxKAhpOLyFcFDhkHLGLW4Rh0qs7RAr/SWYOS
   bVjzCphl69vlhpb9/IEaAmGpvZuPV+XAJblLm1I5JuIpy3Yxi3aYMSgWb
   8dUZ/2sysOtN+l3qW2tPcQr7ER/YNTSIi+x730FBq3/PPTP2Iuk2ZE/0g
   jROrBCUPMAGjZaqDaDNW/J9/xl5J6eZGG/WyRjblyjZeiam03bjza2h5L
   JKTuseLh4XrwIyk9upoMfM/8l54vhnBkE8lrbKzgWrUds8k9PKrM3aOzZ
   ma1s3etJsLflyz4sV+0JJZmThVNlg+erhiC1gAkHBodqEbE06mH+fArOt
   w==;
X-CSE-ConnectionGUID: cYOUQR+KQb22afe3Gyu6bw==
X-CSE-MsgGUID: 2qm1875tTzCxlGT5tLTSgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="62456119"
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="62456119"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 12:51:45 -0800
X-CSE-ConnectionGUID: cT4X9osTS6aTsGfBcyOQwA==
X-CSE-MsgGUID: g60Dskj+Qe28zgMQDaTsIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="104367635"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 12:51:44 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 12:51:44 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 12:51:44 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 12:51:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrrYihGoXH+V0cXL05rE/AW+Hw2VxViJwvKQdNnNF/PfiQHYgHxtYWAE3WXL4yGn24AsM4qHpFPMG41cZya60vdb9jOHmNOU/uPg8squf6UgvQMf5irfkAkVySHQBdz5PkE7mfl5OLWt5FLH9wtBUJjYH9j0hEzf2qNgqJog46GzMTwH8JD0/S72kLga6Bq7bf6ch7U5sTF276+5NOYH848y3sRZDmVBGlGToLW2cnEe79lU/JmC5ll28wcon6RoEZLv8n6cofmGEBNgY0rGTxQ/Fj0EaLjQoKSaJX7WRwUGSwu03QALrLoSOTHGb4mndLY/H4w9v5+hLhouW1XeIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sE06a3R6vZrB8BuTTEHNmw3Qe/2D4Rh0/oBmADmsl9c=;
 b=GBGFqg7C0h8AK5Zu3kvHMEBCC5CJm6vbIujVmuQkSnS+3PvSNcFkQIzr9pPZT8qHzfcXG/n8Ps2/Ir4qaZdqkB2Xc20IsNGCQa3eiEq9JjNnU9fQHmHARqU86giWD0HF8nfzogTK8uuiS0VMp2Y+gpoSC30FO57q8B3OpmF8TuvNljSMwD5H2yQuM7d+ptPAREBHCCfhOlE7SnZZwGjhzljSdnoZmz0NzVdgMHhHSa/myRH0imz2hBIaXEhWDHotX8C6UGMaqW4XiF+r37IN1vwFWIjS1eJ/w3wb06HQbReBASPHFyTh+5sn9e2IfdykuvbGnYakBQYsc50BzmUDJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB5214.namprd11.prod.outlook.com (2603:10b6:a03:2df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 20:51:36 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8335.012; Mon, 13 Jan 2025
 20:51:36 +0000
Date: Mon, 13 Jan 2025 14:51:30 -0600
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
	<bfaccini@nvidia.com>, <haibo1.xu@intel.com>, <dave.jiang@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [RESEND v7 1/3] memory: implement
 memory_block_advise/probe_max_size
Message-ID: <67857cd2524a9_1863f3294d8@iweiny-mobl.notmuch>
References: <20250113174439.1965168-1-gourry@gourry.net>
 <20250113174439.1965168-2-gourry@gourry.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250113174439.1965168-2-gourry@gourry.net>
X-ClientProxiedBy: MW4PR03CA0044.namprd03.prod.outlook.com
 (2603:10b6:303:8e::19) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB5214:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eb9e1de-9e01-4355-b641-08dd34141234
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Lxf35fuZeGNwwplseVgI0HfCl/8RHZ/4qTEI2cxNMZ3hCR6eTSZ0DPk2qkiv?=
 =?us-ascii?Q?rHsirokXfZuKSBKkfeci5ll47urkxZDn1TSI63jMyQcrMrmNTilyEyNzgVWb?=
 =?us-ascii?Q?M31tUPUNS0ikj0QIKalOdZskAeqphG2b0Y1NU7HF0zLT4gj0m1eiyOeiH+xP?=
 =?us-ascii?Q?reVS7CgZZ99MZqOpvewjC86WDpFp+Ecc2F8REJ2f9Y6wSTVcR1vdizl9fSUw?=
 =?us-ascii?Q?d5V79vKxLRA0MYsDMafhccQpW2p4fqzvIODOwyc7YhUlg9BSbQ+FfEufek6h?=
 =?us-ascii?Q?X7izHTP3gkVp6MNBeZtuGymTKE3Ygb4A1q4OJlTOKN1m7OkV05TmslhMnm0t?=
 =?us-ascii?Q?8liQUhuf0ae47ZPM62y0HyZqAj9RixNn12wuzHNXIPpvApwlOlQe/hk5tZxY?=
 =?us-ascii?Q?VURo5qzF8f55h8vH6/J6wJPuSRjNXLi3zp8zJWvtPDA1Z+e7aCXYmRYXE+vz?=
 =?us-ascii?Q?MIc8m6kS0cIfTwYkJ2WBuOvZIQ+Yo4L5CW8eLwXdEb8roRAIRmm+NQ3/O5bw?=
 =?us-ascii?Q?IaEwaPEiIadYdf55BSFApfRR8E8132EUdqye+gmqeR10lnLafnxW7EQrV43g?=
 =?us-ascii?Q?sTKllGFr/yfecuIjqHcRIJoeqO71y2j7xKlA5kwnAJ635x7B4nqR7le+3tOX?=
 =?us-ascii?Q?jHuLSNrPqbzwXMf7/HiUBjuSWqri7UNDDDbv6WWYV/Q0QX6vZ2+ydoHBxq4F?=
 =?us-ascii?Q?/QhSFIPf7cpoGULmYwFTh1msKh5C26Kve/S7E0sFgpObc7K7RgT4eOX039Mt?=
 =?us-ascii?Q?Rs2UqD7uixhMU1LvUGlHJxPBuJU40+tknK37W7/SvB6ZWWwjFKANyXaS9w3E?=
 =?us-ascii?Q?J+wSXV2YLBVn/C+IBN25nCCCxQUFV90/lXNUY6mSLd2OdpRCKlcu07+ZQI3Q?=
 =?us-ascii?Q?43EWQkBCAFXpDEvJqD6OheTL4TNJoJ7atCgtXDE/MuNOlDd7o9VPcNIj4ZoY?=
 =?us-ascii?Q?CP8VTlQ6gXJ/tqK8KJFmJHVttiLv59Izo9D/avAEkZwLfIBfACFqSkS9b7Dw?=
 =?us-ascii?Q?mkcf+VogN5pslUY/hpnlEUi5YM2f5WjkRRo8VyuOZ1GwuGb5f5c3Ha1IMMLd?=
 =?us-ascii?Q?gzgJyRtTdk60m7Fc5PTn30kQ+aMQjpCZjqbaTB4hxnQuDswdIjthoXaS6Sxc?=
 =?us-ascii?Q?sxR+0mCI6WqjBGc/6pXW733i71n5xgtqr4175fHeST0KQuUFUhQKBZqZNxLj?=
 =?us-ascii?Q?KN0uJI0rrQLz+dUrUalcXVfGTEpkepAj4AnkJFF3yn85XbUNNB+FHFQZE4ty?=
 =?us-ascii?Q?L/aIUUtRFo+2o0NjsAalNVUAKMzIGrqFPyoNkNGlk35AqqKYGqbkofacMZU+?=
 =?us-ascii?Q?Q2MEbxiYXCDOIdCSUhCeKKf0eg26KsV/+uL54ybdQZ5BmLek3NGn6AS0xZVS?=
 =?us-ascii?Q?bjaf2QUiPwdxguHOMR7wZ8lOGAwx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C7zU+s5Bxx9VeYk1hi05PDttfO9I6MfbPotiqfCwxcBhtZd0m3icqutcw0b1?=
 =?us-ascii?Q?B0g0C+OeLwwILVmdDJSV7DtzHXQLfgDvLTweJ4tUeTmXVWXU1qYyiZlLVUcG?=
 =?us-ascii?Q?eZZfZBvKZfLUePQ+WIiQZr5cIgAKVYqhCl5wAy40yNNgH6S1sOFAlg3grQA2?=
 =?us-ascii?Q?9T32Gg5UHGzLaHhVCZKi8CIyxbX8q0gMSuIhVebi6/Hr5DEFGYEWwCGezOQX?=
 =?us-ascii?Q?RcCBWsrDs2OpKBaLcrm0jlttErqQeC+93TiVu2QEgxXGehmWukSSlU+RUoN1?=
 =?us-ascii?Q?mKA8o9W6t1wNJKsa9XBZ+kYK2jPTG6SNvJXorEjJI+aBNtoHHChSIRN2JTTG?=
 =?us-ascii?Q?647rhgwj3mzRV6YdBtsiVEaQxf3YAcJ1ECuLHLUFY4GyIDSNn0DgO8zKDWJF?=
 =?us-ascii?Q?k9d7e3CHorROV//70C+YOKw5K17wSbQ92GCyktxBtB/wlGGdGOlkyXML+KqT?=
 =?us-ascii?Q?62sfB5lfvANZR+Fy+w+pf6QkRNX1Z5uFUc3WW44UmzTT9KK2Zg5cnjmEx02T?=
 =?us-ascii?Q?0GRSDnycV7qrJRj4i74TpI0CSmqTOT9rntuuGqHj9PgT0zdm+VsRhUlxdQTJ?=
 =?us-ascii?Q?G+PcAvgsGM6lt2t/gda3HGKTUFBZrg0lKaDUEqJGEiXa1kcgPDKrDBcG9eRR?=
 =?us-ascii?Q?a4vb9ZR3hmz8yFSgyGkirI/qjgkXVWoo8++I+QUZ8GBh/H24rfpMpTZqVZ3i?=
 =?us-ascii?Q?PMe6zb+10MdqnG9UDr4KDmusHeTh0BJMAA2fi71fFRUgoAnPrs48EciSBky8?=
 =?us-ascii?Q?txY9XHz0rv0QSRhuXIV2Y2jXM+3neQ4HpnncgGGDRbabCS3QXbdkADEI9OzW?=
 =?us-ascii?Q?rI268TIVxDHBqGQ+9RZ9nuc2lsiNTJluMF+av56QRMon+1Fq216rBoBlBdem?=
 =?us-ascii?Q?E5aTKDAXG2CiK9/dXL84Py8SXaCh+z+yYF1mLd5k+CO8g64m9SBSSLxnf2KE?=
 =?us-ascii?Q?I1loR0tkt88W8Zfq90JcbRnhIooDYx/ZX9izWdTwNvZYkAD6CcpACprsJBLx?=
 =?us-ascii?Q?Z1m+z+0bZZ55V6KncMVawwGFfBFfLnFz4B0I/wVInXnoq5vThvYrP4tXsBYW?=
 =?us-ascii?Q?9SajpdG2wCt8A5i7+9r5qR7dwxBWh2fnnICxzjbZUlXx+7aroR/xLQxYVMDW?=
 =?us-ascii?Q?rUcXIHvVUpgmwj8taCWS/2XVPXVRsLhAz4WPBxylLBg01XxWWMbbcyvpdaje?=
 =?us-ascii?Q?rOVPNQw3Jp366ly12KBGaGpA/ItIy3i5jg+/KdJgDmpzhL6xFLXyP5G9b36d?=
 =?us-ascii?Q?bKkX2AaHP4bWEybcXFriaZpIgzpGv26F1713WvwF0LYbpBnJ+Zoo0hjvEevy?=
 =?us-ascii?Q?b72//sNu/y/kIKUqr9+J/6/lYFMY8Ova8aVAd5cebPgVbFqNkidoY6wzzGHl?=
 =?us-ascii?Q?TVnffUr9HA/Hjo0csdoNrPal61OHzfESyx5vktaHoSrI7EMEDLXVD08fAsas?=
 =?us-ascii?Q?R4pjkGWhVR+SyfBzSKWeGJSOXvloDVuuwtdYeJIPODRY5ejr5BG2/7/87FAW?=
 =?us-ascii?Q?6k9CzYxmduy+IBTbzTbE8Jumk3qfbR+XGOgd3yLc4nQIYNxg6LonUkbl9v9F?=
 =?us-ascii?Q?9z9NssdYhOVaoV9FvvXJscoEKwyH455Df/NU7DVm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb9e1de-9e01-4355-b641-08dd34141234
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 20:51:36.8324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XqD+zJrkzyXxl/xbYFn8AxoEg7Fcp4TPvebLlF/yoLQq5MFlpO4SU9ySUG96r2ATrM+fX4ZlSCtfSI9Hf57oow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5214
X-OriginatorOrg: intel.com

Gregory Price wrote:
> Hotplug memory sources may have opinions on what the memblock size
> should be - usually for alignment purposes.  For example, CXL memory
> extents can be 256MB with a matching alignment. If this size/alignment
> is smaller than the block size, it can result in stranded capacity.
> 
> Implement memory_block_advise_max_size for use prior to allocator init,
> for software to advise the system on the max block size.
> 
> Implement memory_block_probe_max_size for use by arch init code to
> calculate the best block size. Use of advice is architecture defined.
> 
> The probe value can never change after first probe. Calls to advise
> after probe will return -EBUSY to aid debugging.
> 
> On systems without hotplug, always return -ENODEV and 0 respectively.
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Tested-by: Fan Ni <fan.ni@samsung.com>
> ---

[snip]

> +int __init memory_block_advise_max_size(unsigned long size)
> +{
> +	if (!size || !is_power_of_2(size))
> +		return -EINVAL;
> +
> +	if (memory_block_advised_size_queried)
> +		return -EBUSY;
> +
> +	if (memory_block_advised_size) {
> +		memory_block_advised_size = min(memory_block_advised_size,
> +						size);
> +	} else {
> +		memory_block_advised_size = size;
> +	}

NIT: Style: single statements don't need '{}'

Other than that it looks ok.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

