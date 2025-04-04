Return-Path: <linux-acpi+bounces-12753-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59A6A7BEC3
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 16:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A313F179CBA
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 14:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83151F2BAE;
	Fri,  4 Apr 2025 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iDjyO/mF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C0D1EB191;
	Fri,  4 Apr 2025 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743775938; cv=fail; b=d98jght7M7aDTCr90kydQdA8xbePOU1TG22rW4kKh4vS0did6flFqNTmcvCzwpCT836259O3y4eXOGOANqI0niNatplmiOMeo3wDnhnJpB5/CeA0FUI2q0j1wbuVymSC/n4kZLpdLDapePxXGPef2X5hkff0bMdsxKzX3u6rTkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743775938; c=relaxed/simple;
	bh=E6wwuKeWxbYMKcYlyXCSIe+8tcHXEi7dlN2B644mkRo=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GwIQIxL8zT8BF2n0wkUZtlRys5L9Qy8CISdJuEoSaKFJQXQgaapqzaUWwRKz2fxS+vnMAyMDyB+M/vFK8WeVoHYlCitZXN4+51a+0Da9GAR3ae3FX3Sj/ezlgTMOmDeWSeLhgMhOo222tRfmBltc3gFr+A5o3yuh0i1+RKRyeC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iDjyO/mF; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743775937; x=1775311937;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=E6wwuKeWxbYMKcYlyXCSIe+8tcHXEi7dlN2B644mkRo=;
  b=iDjyO/mFyadcjaE/wTzjoVNYa0Y93Ov4bYghfGev1hF6gHg9nLQ+r+ve
   Bb2Lc+6sC8mEF/N/M9WScT7d0KKao6t9rpwKUy5ZD/A2ypZrpzjrtait6
   bU45WPjuGEgAf9ndPP8o3aXZC8O0oyi6ZxILyQRnmEYlkRh9dmi4NZEnW
   mhUTjI/Sp/G21soCVztoZJj3QPmJFkS3qMxLO/Pt2kj2pwTA9b/h9pzFh
   iZGcli/98eXQzR4u8fN+uQ1UtxPJ7LaLl2O8QeR1R1ytEYZdqPs+5O4QV
   0lpG81lX9MXcQ4UsU6FngT2eCSrr23SFQ4cQTefV8OYdM0cztFGnWWbI5
   g==;
X-CSE-ConnectionGUID: 1WA2bLLuQNCtVoKAeJvoYg==
X-CSE-MsgGUID: wGX62F3rSD60GUaSOvmZcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11394"; a="44937517"
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="44937517"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 07:12:17 -0700
X-CSE-ConnectionGUID: TfQdgNUpTEG28r27Vbwpjg==
X-CSE-MsgGUID: pFgD8A6xQvKpUtsLwkpo9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="132180058"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 07:12:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Apr 2025 07:12:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 4 Apr 2025 07:12:16 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 4 Apr 2025 07:12:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZycJQZYzKcHKDoTWb9vdehu+Gtu7t9qBUEagljCOgJn2iQoqEhKc68DykJMXhz9m9jW5IbN78R35nNs3q0B6Vur0D/imvOzRVZa66qtDT9W9W7v0Rodl0DwP/KpL+QA60GA5hyelS2uJY6Cp7fD//WudqyeElcv6n16bsdEVTQ0Yr8URQglp5u7i8q9pPYEqvu88Z8Tl5wKqM2hXbZM6Db9nKeBFsGd+vsdUR5ESz+ZzS9GxweYFhip9/la7ttlN8Bw9jrORsuCLq70EIGXboi87B+6qq5euEFOxareW9tlfc1E3+fz41vP9yAxhbFTzhAH2qH/NZiTnnZ5OsC4qAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anCNt7AkYS9dko1795VX9rSM4Gs6VgJB5KfrfGivLHk=;
 b=Al4W7x9p2os0Ec2QUvCywKTiRkJSWzbggzgw36kmrVEe2sa3AxaySluUh9gnFiRQuTeJ/K9dPWmDbsUpkYryir7fvovVfFpmH9pn44dd7InHDaZ08uc4m0pxBv20BbP2e37TokiYjzkAuycu+0MtYJh/LcIShSSXU4wWgj0H7mB9uX6iW2fX5mRUg1VfWjfjRZZXtE2O7PFouxE//QSIHu7FsJCcq3ZtsIWmqYkdTTJ0rr2E5ChVGY4WT66/36b3f5O99sXE7ZRnsli3c+7NgZtpExp8p1KUCBOhdmK+rgiBLs6RQ94P/TC1NE96FHpsVm1gb/Mowq85AVsDnXmtOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by LV8PR11MB8698.namprd11.prod.outlook.com (2603:10b6:408:205::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.42; Fri, 4 Apr
 2025 14:11:59 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8534.052; Fri, 4 Apr 2025
 14:11:59 +0000
Date: Fri, 4 Apr 2025 09:12:22 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>, <robert.moore@intel.com>, <dan.j.williams@intel.com>,
	<Jonathan.Cameron@huawei.com>, <Benjamin.Cheatham@amd.com>,
	<Avadhut.Naik@amd.com>, <viro@zeniv.linux.org.uk>, <arnd@arndb.de>,
	<ira.weiny@intel.com>, <dave.jiang@intel.com>,
	<sthanneeru.opensrc@micron.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v5 3/9] ACPI: APEI: EINJ: Fix kernel test robot sparse
 warning
Message-ID: <67efe8c62f379_9807c294e7@iweiny-mobl.notmuch>
References: <20250403231339.23708-1-zaidal@os.amperecomputing.com>
 <20250403231339.23708-4-zaidal@os.amperecomputing.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250403231339.23708-4-zaidal@os.amperecomputing.com>
X-ClientProxiedBy: MW2PR2101CA0007.namprd21.prod.outlook.com
 (2603:10b6:302:1::20) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|LV8PR11MB8698:EE_
X-MS-Office365-Filtering-Correlation-Id: df5bbc7b-c229-497d-60f9-08dd7382aa2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0Uk2GshATFtS6JRlEhd9/f4Z2abvCuCR0a6GCBeazM9ytQaYDyz3K2NQ9FzM?=
 =?us-ascii?Q?FyGxPlox8w2w8P6UGcEN25Xyw3CLN8ur4LAHS1BhkJdKkL30bwKqdHAv42Oh?=
 =?us-ascii?Q?EKywZ7WZ10swxjOnPbliV2SiphnAG+CKm4Ejluink5lNIfhukM2J5ZCZxnwK?=
 =?us-ascii?Q?3UK0DvTGmQrFqz41OMFeHMEOSZBps6zIYB5eyBcUEtpMMZyrkxv3uVQ3jJVP?=
 =?us-ascii?Q?hvuMGV+yIdntRWKvXlWjO5mmJZGK9EJzzSEVD10PtBAlFUHjHU/qndO9yjaH?=
 =?us-ascii?Q?FvLmhFa2PEUv0Th7pFKYPgXamlZYXLVGQ0cayJg2uX2x53NE/JSNG25ZvBCk?=
 =?us-ascii?Q?C00aajfhYd4wj5C3pwGqr7ECwRtTZpurU+m2dAX1S88RxPBQMpyY310oPBNu?=
 =?us-ascii?Q?rUUxuo1+82l9bNTfToyZ+46369NRpiOolOamW3H7KCSAq63Wjtk3+YCCA3oi?=
 =?us-ascii?Q?LtV1qVFlGtx1jQw41c0U71UArt+Wemf7rvbC/dzx01Sk/QqQTJyIy5TXImyx?=
 =?us-ascii?Q?To8bocXqNSuTcHiV99mFUkKPMvalh37gskmaBAD/Z/9nL4/1GphtJXPhL2zj?=
 =?us-ascii?Q?EVR7uPRcCCZzTQCPi7MJQKGRIUQaC9GZXQR3teFHeScVEz2WcJgBbmvzUG0f?=
 =?us-ascii?Q?ftdYom3XB+G6sADwDvNrFv+uEh6S0vhrIJF3OQLo9/ZgmkqkeWYhAxN4X0JL?=
 =?us-ascii?Q?rjNLPWrjjOx+ibHCeV7CEb1NZdUYN9SS4NQTagn1O4P7GLQA4vtmzSPh1+sg?=
 =?us-ascii?Q?adVUStm3wI6K3ZjNx/I1tifSy+9eZn4mLkabiVKPsXmrX9p4rVaoEcFEiYkk?=
 =?us-ascii?Q?Y2NtDRsgs1LGfPMYEULmVoYdEzzIiIMRepUE1yjcyw0sWYZcBChiMlLTOHhH?=
 =?us-ascii?Q?A2gY49XUsoshLtoexw9LYE9vYReRaNEHNT1IP8ENKHadYB2T8BDwxgqBm5TR?=
 =?us-ascii?Q?JeGf2TSQH5ajxV887Ruq9RDmzYyB2SSd/G94eotRqIQ2XzwACtiSBU2LonJx?=
 =?us-ascii?Q?vrNHV1emhgX3Y7TFMPvRsEXizUuDU5J4U5HtoJ8Xsgbi31vGugvzHXbyEsAq?=
 =?us-ascii?Q?Cx+xZEBwGkanwwL22srW1l03K4bAaUUwzsM/NNBhkQ5bIQTX6RqccxO4ynT4?=
 =?us-ascii?Q?rWSVsmMihk9X2lLvBlhDe9As4wNvEPCYjZ8cHPEKQ5pf3l9DM527SdSMnD+X?=
 =?us-ascii?Q?rv/5Ls3GPzyDGHv4FlxNXdlAAvW6bN3oO+CM7gxJQ+zxDcEjRhqFcIXWnm+Z?=
 =?us-ascii?Q?bClGHlizD5YYH0GE0rg0mISuBmAB61xnKStEtd6y06vgyfj87OogEXCRLnh3?=
 =?us-ascii?Q?v7+L3lW1V8RpMAjJiy1Q5S5NCncvb39iE/mttpBDKCsTfmAV9FRfzFTCFpLy?=
 =?us-ascii?Q?1Ue+dhRmJ6GFBbtYI9NrVHbBx8DYqueYjTkfSKn/aMNM6LzRgMkwuhcmGTcx?=
 =?us-ascii?Q?d2KYGI+sch8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GMf4TljkrvjrjrkeCgpVDPwAlD9bCm6J5DTwTwdlcVILKEH3Cydb6sKKnmdJ?=
 =?us-ascii?Q?6PTpwhlcLdJ2ie11jmv7RUPQUOhADeYNmizxEaVvNpq/yqVOx2R7lTHTld8p?=
 =?us-ascii?Q?KpK2Ji80EGwECl4usg6zDPbosx0W1XrDTkIk+R3+sC2WzcnwkBSLOpTEjnOy?=
 =?us-ascii?Q?8KrSlC+PNJBvR+EMTPjgEsFvMC/9nyMho3fCkfBVqxxeUSXHMfiOmI73ldhc?=
 =?us-ascii?Q?YC5gMyVyBcERChsjCkAyMD9vJI7lwyCFHoatsFCbuEq/ORE7GZO0HljBCFcs?=
 =?us-ascii?Q?RAulskiesJW/EOxKXCW59iCIB6SZkChCIzAGLJLoN0gJIqaHjKEC+xJhu/EA?=
 =?us-ascii?Q?Pjm06c0jvzdrr13PHoWL0osL12snA0M2g8Zyas8nkEOu2CwWWLHFE5V/iFdl?=
 =?us-ascii?Q?hbHAPWrtHFG27cVvzm/sP+boaR/Y8mSPdGX8tpGhJH5M01skFTpkAH8Jk/OP?=
 =?us-ascii?Q?mtH3J1QK8aGG6pWRR0oJ+U1bvKwSTtGJ+WnGqc4axShPhEBoJew6L883mvAc?=
 =?us-ascii?Q?ycRSOj9Tzi4vYC8LBzNRk6XkQ/5GUqXBgwTW3ZLHJHP6CjiiHHeRAA0HwSHp?=
 =?us-ascii?Q?/1Fo8ptWjbdvePAYqAANGwZ8MFbfFe/bjxBGnoY8tXI6tdMenf0+FZVWFM/1?=
 =?us-ascii?Q?VIS32s8QmhqTLTmoMQaFDjxQjdxLuWOH2kF43oGHRSVm5ziFfIz7APZkdA+e?=
 =?us-ascii?Q?jVS+yqgAiNjL9QXiB9Gzsd9iKdZ+o0nVvEzbbeHFGJVLQ/JxnvYFDHz6KQ+s?=
 =?us-ascii?Q?zMtXgFNMOpklkyvXi/9hRhfbwIA7pELV06L43MM0iERWDYTIg7pYSX3TULbU?=
 =?us-ascii?Q?maDMnDslMXSAOTJbyqWQ0/X9l+ot2U/Gd3kgcaaq2BRjbxS9XntwGSwUAcd2?=
 =?us-ascii?Q?/AEWfoRYyHjBYSHHU0x4uOeMIc2IjbHjPW23252IcqijZrj3bvz/xx6fFm7V?=
 =?us-ascii?Q?e+U+og4ExcCodkqVULI7EEQJ+OODqEwqMMygr8H7SSs/qMJsnwSlbo8wKi65?=
 =?us-ascii?Q?NFpZLQlbd3E1N/tOSw53mQeKHdU1TpPyuFaNaHAvNAPCO/g3D64494MHzQis?=
 =?us-ascii?Q?AQM8I0AjYJiUrkFtfNmPEyHDGmuSfG6jQBhn794PhxQ/o7BCVnI56atpf4lm?=
 =?us-ascii?Q?4nvQwHELJXe2epNYls6VPNLpcqAJM+YpFjjr6k0yHudgrzrKCGJyL4YtbOz/?=
 =?us-ascii?Q?lx10koj+2OyTYBiakzb5zNX1HR+FN7y1nzUI4ZR+3ZZ/yWNCZ8n9sxn/uDo8?=
 =?us-ascii?Q?ChkRFMj8bhcOmEdmZtI34uWTikDvPRwdoB3ki1BlPSxdV1qUHXkaU0WPhErW?=
 =?us-ascii?Q?011I0fOsBbw4z5B9tMu0mTCHR3W2w3mFpkcn0Yfu46ju5LrK86p6h3ugtObI?=
 =?us-ascii?Q?AEB9A46ouuhfILd9e+eXpdNTuaqG8r0BaaIvikiiXnm8MKJkHq+BCsHuYcLJ?=
 =?us-ascii?Q?PB9YS8L5yg8yS0UEDvkquDU6iU1mNY7ZNNx4CCOjiSMoVlEZD3yM2BlSuskC?=
 =?us-ascii?Q?znCxuDdiBEd1sQyhHYHlbXON5dT7TeB08H+omAEr3rQ6ptytuOPSvXhnXjs0?=
 =?us-ascii?Q?2Xpzjy0AdEmF3qqa0Zfv/1wMbvWYqVuuRtYya0n4Dc15uV0M1LCNqKlK60Ov?=
 =?us-ascii?Q?4XJtM8jUXC1VykhNV4RrWw8mG5bILWNLebKv918HgEyb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df5bbc7b-c229-497d-60f9-08dd7382aa2c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 14:11:59.5559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tURmS5l47ruRoF9azLDipm/Ut79E8M4pSuqszy71KhvAqcNi1oU3H3cmsEYrXmzkavijgX6FuRYzMh6cniwVEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8698
X-OriginatorOrg: intel.com

Zaid Alali wrote:
> This patch fixes the kernel test robot warning reported here:
> https://lore.kernel.org/all/202410241620.oApALow5-lkp@intel.com/
> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]

