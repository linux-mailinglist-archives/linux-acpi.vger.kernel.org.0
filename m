Return-Path: <linux-acpi+bounces-10573-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A010A0C266
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 21:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F9C169D3C
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 20:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9E21CBE94;
	Mon, 13 Jan 2025 20:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O67p2dw8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBC51C549F;
	Mon, 13 Jan 2025 20:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736798917; cv=fail; b=h8Zl9vXYdo30yu8+UFE5NcXTmyx1ObiZ7OdfrrK5NdYuNkqemNxvvHLCX/z8lt3twP0abuYmiH2qNpkjsPZvv7sLDatzffLz/9zlNnUj0mAyRdiVjob4RkIp4R3DBF1Ntr5v/su+Jici6sbcr/tFOiFWP4CEyG0L9XDm6ZeMXh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736798917; c=relaxed/simple;
	bh=OGzu7tUe1cq7agl3kVrX0FukyTo5NGBTzikG08HeUKY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H/NMgxyqyC8m4hRvrz+pvZlB2u8U5y6kfr4Jgsp+5PYcL8q5fYgasj1c3KUD30Ae3JVSRFzJlJ3CsS8vMEoMwacohK2XQ5i94fTYobDOFJ4nSk93eURRhGJzNXJPdMPx9ol+lcM7t8CfyjgKqNaqszhyyuXePz69qPDhkyUxrlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O67p2dw8; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736798916; x=1768334916;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OGzu7tUe1cq7agl3kVrX0FukyTo5NGBTzikG08HeUKY=;
  b=O67p2dw8u8fPqvD9IsZ/JS3aO1z7FugdKMenU4rrmzvQsWol4IX5shsb
   8VCnSyhoKqEL1TOSq0r1Qpes1kiXEzxNWuqMiN3gDkZxBSACfOGjSCdpm
   Z+dTP7pCLMGjGnfZgocCY0amjNUer5VZ4WE9WmhGACU7fTslMMJ1mBTiH
   YQ0v9TYUv05yEz0cQlsuEt1ZIyuy+fplZ/d9y9dHF9LOjOhuqCuCleoSd
   Z2k9q+HqV3w5QKDfhk9lwPCroaUaKrDrhlvLPVpjw2uBHoP6pWuVOP5cU
   a6h/PULiiSgkMai156SETSdL1WG4hsUWLhq9uQs0+5v68IpbDz3KCcRID
   w==;
X-CSE-ConnectionGUID: XMOODT86RqOacABtK9W5aw==
X-CSE-MsgGUID: qj1pnep8R+S4misxS39yZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="62452709"
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="62452709"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 12:08:35 -0800
X-CSE-ConnectionGUID: NphxfBubS9mqD0lbGr55rw==
X-CSE-MsgGUID: 2m35Zz4USeqMEO9sZMqrlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="109609708"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 12:08:35 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 12:08:34 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 12:08:34 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 12:08:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9YXFYr8giPEsXJo/GBnXseHW/FJYmcYO4KB9hqD5p4mSX0gccc1YAjmU1m9FISLwKl7q9YHb/4cql0LeQCkQkLY1jAmvwfyxyKe+AYubKXZ+TynzEEtHxuxgDI9a/Gb4F+xY7X9fd0Ta68w5m4dk+2+oavg+aHG6nzJodiGRxHfleWg2yoTvn/vy+Y1S9zuOOvGT1sUBkt7TfYjPVcXuZHOYGqsU97E5Cb1s94paRNz/9edPOKpDpirBCf4+mPQhSwYa3s9UQnarwZ3o0c3Q3uR3IuH5XC9J6vbkGznosx16TekbYZPlvYMQfOJbEp6Ue5pOeb8xpUHb/rmy33Diw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVWvtN+x4NmnlrwKnutlBwtQeG/Hl88bKzgxCDkm8bE=;
 b=hYLJr2dXhsRvF4qFOzdAomNNebiBIeIQIKG3jU5IOOL0+x4hhKi6FqwAgg6ZO1Oz6P17LPr2BnH6/j6wZeR4rFPJKPls/OilxjFTmz3YjkUkusvOVRz8kQf20yixGyQ8p+NbL9nTqABflr8X4V3GIpvhP0GEQkAXrubVN2z8dDzdGeaPvo+YS08666QWUn/VIbWoursTx9jEjoEQEfEAbKYKMG3HYHQk+QkQ5Z6BeUaNBPXioMwT0yL8sQbpu6Sfhr0HQ+EmcZNlOS1HrDx3p/Rw5yV/9UbaLUSXQoEPAG8vuC+6iU2QtkKFcXEJQ+RkCKYrYChYHE02zWdy+R9otg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB6371.namprd11.prod.outlook.com (2603:10b6:208:3ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 20:08:30 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8335.012; Mon, 13 Jan 2025
 20:08:30 +0000
Date: Mon, 13 Jan 2025 14:08:23 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Borislav Petkov <bp@alien8.de>, "Rafael J. Wysocki" <rafael@kernel.org>
CC: "Huang, Ying" <ying.huang@linux.alibaba.com>, Feng Tang
	<feng.tang@linux.alibaba.com>, <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, James Morse <james.morse@arm.com>, Tony Luck
	<tony.luck@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>, Andi Kleen
	<ak@linux.intel.com>
Subject: Re: [PATCH] APEI: GHES: Have GHES honor the panic= setting
Message-ID: <678572b7c28b0_182bf92941f@iweiny-mobl.notmuch>
References: <20241230121009.GDZ3KNoe0-hUwQDLG7@fat_crate.local>
 <Z3KaSxr2sjCC8FpJ@U-2FWC9VHC-2323.local>
 <20241230132403.GEZ3Ke8zm7HxSv84pA@fat_crate.local>
 <Z3OS4LCCxfVN32uH@U-2FWC9VHC-2323.local>
 <20241231092358.GAZ3O4LroNtlnztneC@fat_crate.local>
 <Z3PEXxFTGXW2j2F3@U-2FWC9VHC-2323.local>
 <20241231111314.GDZ3PRyq_tiU002p5d@fat_crate.local>
 <87ikqydja9.fsf@DESKTOP-5N7EMDA>
 <20250102083509.GAZ3ZPvcUhl9v6Kbp_@fat_crate.local>
 <20250113125224.GFZ4UMiNtWIJvgpveU@fat_crate.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250113125224.GFZ4UMiNtWIJvgpveU@fat_crate.local>
X-ClientProxiedBy: MW4PR04CA0113.namprd04.prod.outlook.com
 (2603:10b6:303:83::28) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b49ea6-018e-4869-542a-08dd340e0c80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VCFfMlc7Sp/XmCF6NDPEEVY7SRh6AdzifO1di/tukgfpkIV4f7UIMuestJYT?=
 =?us-ascii?Q?kTZM+sgvJb35MRzB63sCaHOpkiPWqPpgO3L66MqONLYeAHkfIagFiMtNbx/J?=
 =?us-ascii?Q?TO0nh9S10w+4nLWazBGT0BYspPPcaQZx3azPNMUAAO5Cu7NMHFEyuI2e0tv6?=
 =?us-ascii?Q?y77k243FMK+x3dbfaN9QzgPiUSzAYsuZRiCGjj/+YQF19UXcvHzW2VOPOQGD?=
 =?us-ascii?Q?QyZ4V4c7QyiIx09vDPPeie2JAUUoX1rODTRWH5xcMizxOoC1J4aC/m/y742d?=
 =?us-ascii?Q?pqM17xZvqS0HKihCm2Ljo5nnfCUM1L0p8lboIs6liY8LZPGvJFHOTJ/GLo61?=
 =?us-ascii?Q?jsMB0WRGBObaJV/8KbL/LR7HPZW6LhYw37ryB2A4vykTesqmreOlYfPm4NyU?=
 =?us-ascii?Q?S53K5koKUZydh/Hu+B+6O/71iBr/xhUvSju00DhwXSsVXnjrX8XIz0KnB147?=
 =?us-ascii?Q?6qqREABi1Ug+S63i+XqqUGwtT6plYIzgURcKM1e6IguatWNvb9PkxfUf1jom?=
 =?us-ascii?Q?LkTMkvYO1d50RTwI7Z9UHKonMLaGA+314j3MSgABUxYCHf5K2kHtHDorePde?=
 =?us-ascii?Q?t+8WX+yKBqdLw/pfYCWlPNq9rPoz9dwxp2+lVbPiS6WzrX85fnygV0hCgw2Y?=
 =?us-ascii?Q?j+MYRGa0AwgonY0RWakH9kDeq6PL3KaHthtgCs3hiX5uwobhPxpA90qFLhQz?=
 =?us-ascii?Q?QTG8fv1d9T260j4T5trEJHy1lauGWwbb3IC/2zo7+ChSvA0bALcC/1kM98CI?=
 =?us-ascii?Q?WDLRZbjB5+JcZqNRjfWZCRezO0crSFRY2FQU0HJZ509b8rL2UdFz4WrOCAMp?=
 =?us-ascii?Q?uyVcObaOZMaOS7OOR0315/b6g6PpL/DYtwwxghfn8gehL1uISpb55RU4b1Eh?=
 =?us-ascii?Q?HmHdu79lWNDcR5yiksPYIPi69XYtZbMsH2e34Mho7muz2QwZLPRKYNa2uFX6?=
 =?us-ascii?Q?geRiYE60WZiOWsw9Xo8QayLb16pZWjRgl79uzG3CTwJNNBVRCUUzd8RCY5Bm?=
 =?us-ascii?Q?Rlupy+ytCEKk/Wz7ucmdpurwd3rcnhSyZbkSEX008MItdnwzeCbcJ1ph4g7w?=
 =?us-ascii?Q?E/jlhQVGSaygAgnDVbUDGL8nNW5T8J4HI12rQ/S8LE7FwoPStXbMNxuoDWaX?=
 =?us-ascii?Q?b3JypZJnIOGMLeXti4BjiuifsjRpwrvDtp4ogbv8IiYoBPxpw0bx39iAHYG4?=
 =?us-ascii?Q?I9tZKa2kAZdk2QOHYcJ5eBpW/njbPDyJjKPHPCM09+fyCOfftHZRMVA2S0nP?=
 =?us-ascii?Q?IFkGbQtusdU86TEXcZqvyIBnT35GJhizQ+xo/0y4FG0qz4x7cL1qaEqw2jaZ?=
 =?us-ascii?Q?wxcERQo7n3b1b1ivbr1tjMIzVrxmociEVr9K504Evw1DepT0yU3EHFBmuWCP?=
 =?us-ascii?Q?vHs5C6ujGrJWEq2hPHlEoeO8lwUt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3oHCMDch+p821UNj9b+ZzjayX8nMTteVyiNnPgcN/CDErwiIeaAUmbZ0gRrd?=
 =?us-ascii?Q?WHJ9ozlhx4ikIW1yKIyINJ0sWbtlSs7UPZcWGvWP29bsRyitjwDCmf4Eruri?=
 =?us-ascii?Q?IwFQ4m+LX46jyM9ngmFmHG8X2HBeTkAw5SnmOB4tE1eBYvXhxmd3xKbQeVVJ?=
 =?us-ascii?Q?njpFJhTEPgv5vcu5jzdkqo5oEC2Te7WEaGXrz/3eOYcQlZdsomfWhqgYl7WT?=
 =?us-ascii?Q?WHlPcE95xjsB596Wib3WnDXfWk6XBTTmDNelaD0b3H5zqbw/S7vs0VCfQ/N8?=
 =?us-ascii?Q?YdjTlx4fdSCyNtGZs8b8BRtVSpc/QFgqyU4RIudiJQlZmesaVycG82VlhBcA?=
 =?us-ascii?Q?vhIIEbMlGIDXnHzPHqOz6bPOBI+w6+8O853NwoXcKWhQBMzY4uXJJe0/2quh?=
 =?us-ascii?Q?wwlbAsBUCfyXYLHMtxSZgnhqEKMiJ/1a5EUsQGndowGDdSuramR7/WicZFpI?=
 =?us-ascii?Q?0RYovbgAV2a2hPLtFGxBG4p1lELgcEW/EyJMjVb5gUgTMbZ6d2yNDrMByCqL?=
 =?us-ascii?Q?BS8Y3gqtflra498V/dh2jNwJFFTA7wkmpQw1JZr9a2Vb7Ou4SWYIrTaSERt8?=
 =?us-ascii?Q?zDI02JC+yLFKmzxMPqnpm7xEm7vKrxcNUvHjiNsKCF3pG8IFmxgjrFXGSZoP?=
 =?us-ascii?Q?xS35bSFSBuYXyScYj9L167IWcnDw61eqZEjHQIgfWfcLNBTOAqFEIZli3de4?=
 =?us-ascii?Q?VMJ2InHDFCzV/R4bo6eLbz3ivW4xYjun+6897pWM/s0dXXNiYOYVMdIBhp1J?=
 =?us-ascii?Q?rf+uZQCqfpvcwG44v8JYutyHYH8YWggSvVbaLdWa2rKRVFQW0x0NuL79PXd3?=
 =?us-ascii?Q?e8DdJQjFNAbIig5DT+08jy88hodR1GUzKu+DBWZgtUQ4fX3AeeTsjqgmtCoM?=
 =?us-ascii?Q?Y8PdY0o1v4+0fuBnO2mlLHFtfuToCWDE9Kyp/W+PHPwdXIsDsPLV4+VkqMOy?=
 =?us-ascii?Q?8QSuiV8O+fFy/LO+vugFAh8h44h5CPjBsB4r6bDAaXTPvF0oCZtZjboPpPgO?=
 =?us-ascii?Q?vEPvRmnSHEJQXHBY316/qBWLJJxpx/r5XtQRNZEs94SCwtDMgE7EivcbZTSm?=
 =?us-ascii?Q?tB52Xu7rCobM5Z2sh2XL5jcldYOm7xScrP7unvQyHg1krhRDEfCl29sKGFRX?=
 =?us-ascii?Q?gQUxQEzAbp5IxLfQ/1usvx5Xj7l9EYe7FVN+AQsjCJkISdDjG7Yg2PrG9qBR?=
 =?us-ascii?Q?yJzkv2i8ZnPNdQjl41LgYBKsw3PwlecARqVs3cQhi/VpZwNzGwURPt7kTWnN?=
 =?us-ascii?Q?BRrb/FXDzPnngnAKiQYpE9x/IN3hOE7672W/Lfco6f5d4YJBf81z1QuKIG1Y?=
 =?us-ascii?Q?X9t/GgW3qM6SSyDUloGjJH8I90kJkNMenLODkwONrcoFT4uq2ErUEZqwuB77?=
 =?us-ascii?Q?8POPIcJTKPKoRlwNfd75nLo/KpLKO8sQ/8JBiTagZN/PplpujDIkOCcbT9sa?=
 =?us-ascii?Q?YZL/ErLyxceZFA0LLdet9+pO1Qz/KgJ2QF640wmb+Q+BT6VkfpHlfMw7DxfX?=
 =?us-ascii?Q?p7JFPM2c30tl4UlGsSm886Pq4DZERxeXcGFw6WB0S0BXSP5UZq/r5B4nbE4Y?=
 =?us-ascii?Q?cpy8BVHWkrTnsk0xJbZD827sbrmPZGk+ApLN22vg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b49ea6-018e-4869-542a-08dd340e0c80
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 20:08:30.1924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXmuoysdIy+ii1U19/Szx+YAicwUvQc6kj1ZOnWd47d84faYd65xX5G/G+UJe1AFeM5wOkQSUbU8unGAsdvsaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6371
X-OriginatorOrg: intel.com

Borislav Petkov wrote:
> The GHES driver overrides the panic= setting by force-rebooting the
> system after a fatal hw error has been reported. The intent being that
> such an error would be reported earlier.
> 
> However, this is not optimal when a hard-to-debug issue requires long
> time to reproduce and when that happens, the box will get rebooted after
> 30 seconds and thus destroy the whole hw context of when the error
> happened.
> 
> So rip out the default GHES panic timeout and honor the global one.
> 
> In the panic disabled (panic=0) case, the error will still be logged to
> dmesg for later inspection and if panic after a hw error is really
> required, then that can be controlled the usual way - use panic= on the
> cmdline or set it in the kernel .config's CONFIG_PANIC_TIMEOUT.
> 
> Reported-by: Feng Tang <feng.tang@linux.alibaba.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Reviewed-by: Feng Tang <feng.tang@linux.alibaba.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

