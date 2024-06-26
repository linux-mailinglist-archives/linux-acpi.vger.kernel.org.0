Return-Path: <linux-acpi+bounces-6625-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EF8918160
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jun 2024 14:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 616B91C23058
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jun 2024 12:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6901779AE;
	Wed, 26 Jun 2024 12:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kkh9MGcD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E3319BC6;
	Wed, 26 Jun 2024 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719406107; cv=fail; b=r50qtz1a7QK3o08lBg5IidsOnBtRKFE7ZNDLtiZwcdJw5H6By5Z24TGkm6aQkLosFt6jFW+OGVx0VSqGjtjtzxiZuuyK2ZkMjuFGdkcHVxYKIUSDA9yT41/oY5MrackXIKPBVaG5hiSPfoGUB31FD0ZFlAdL1cAeNmjlwBc0MFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719406107; c=relaxed/simple;
	bh=5epyRU04jph8n2sa2xw+1VSGV+z4m9M+TEYui3rEu6Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C3axaoE6D0M4iqzMGqr2MlHDC7g2Qv0+HpPKEwhw5FSXyI+tOr/9GdzFTyovk9Uq6kESeJqFWy9qw5TD2saB1Ws7RMutPxlAv1f5QdTAYonHao+Lx2b39VddmgKlRjlgqOI6OVxxkICn4vx2WbPIACmxZpPayg9+eJJuGmyfdLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kkh9MGcD; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719406106; x=1750942106;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5epyRU04jph8n2sa2xw+1VSGV+z4m9M+TEYui3rEu6Q=;
  b=Kkh9MGcDefPoCKLiL6POKADTaGrCAPuYUlxWwHHK6th7J5WNpoxEAzmB
   CJy4Dg6td2ZvsOChyY6fINHKlAC+zGGfYw+DTwvIRMC3FtqHsnezuDVF4
   F2nxZ5HG5FZmkQk/iZhCs6jIlDoxBBEVVdTkbQjf4QNyFhnMUv4o54wYo
   QCp4LshvyF67key8ZEDCqkc1ZbR8+OmyFtai3fzY+Mk1z6oGOHSocA6t1
   1TTlsd5Im53U9ZFYS8afyydkpsVA5oqOqMzeok88DalKNmIdvrJA1wvAH
   3HwsksCUU/1f2pH2stTREKQcBZljnAMsDb+aKmkq2HST7JyNP95ZV09PO
   w==;
X-CSE-ConnectionGUID: +UIWfisWRhGvSvv7K8ED0w==
X-CSE-MsgGUID: scDAt3rOSRmL4dZewFzKig==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="27614564"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="27614564"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 05:48:25 -0700
X-CSE-ConnectionGUID: c83qOOHXQamAFRrAzsdnBw==
X-CSE-MsgGUID: 46wI+1R+R+aR9C1rOptIgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="74764733"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2024 05:48:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 05:48:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 05:48:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 05:48:23 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 05:48:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JergShabCsaH+uRVUqtX1ZzW8T/zd7LvbKMXkC5eed7zvXfzXLeBTOv/ZwzRGdNCzSxKPSmWP6WfQcKqkg4Hg/r3znDnL7X9XHgsOcpb/ZJf6McgG9ebCtS/Key37rVLq29BaMMV81kz4OMDIqEDmzXb/dJ3Qi6YhifP6YhkUWjqfY3AHJsHye/c16jZBkaLSdIhOEbBvRRIkvinA2ZCQVKnqAeBvchC2vVCO1jr5NgL4K7hjv3PTAnOOYm1EXgiGemykd8JZIBNPb+yfzhesTT8un84GaxkLNYQMFE3mpCTLLh3ZkKvtZD3S7vvaatCCpjV9RgRF521K4pPLt6Myw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5epyRU04jph8n2sa2xw+1VSGV+z4m9M+TEYui3rEu6Q=;
 b=VoQjE297RJFVTUcPZp5kUvvSkH4Oh86DzCAe30gQHxgponKHN6Ag1fGkJrHfnbhr0tpH0tWDzTI0NEX8FXpapdl4j0fWqjElaLvoX4ta65YTELT081+evBHKDvHslnrKBbIL/xw4ERmNzcDNceGj5JgPvGTKfSazDEXEIvmgmi+j/fXcdtc9TMxgS8KALA7VHzrpSR3gn49wXL1VlVFmz1Pa/FPSirh4NYOi47zaSB/hrG4kdulMBaCthrzE76a4QU6+evAPKCOg/GHyBMvwCyH9T94wF7wpUxZx3XMgvp872hyzU1M7gfsYO14llJg0wc+o4Y0wq5v8uw2sNeM2Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB8478.namprd11.prod.outlook.com (2603:10b6:510:308::11)
 by MN2PR11MB4616.namprd11.prod.outlook.com (2603:10b6:208:26f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 12:48:20 +0000
Received: from PH7PR11MB8478.namprd11.prod.outlook.com
 ([fe80::6961:eda0:dc93:5b4d]) by PH7PR11MB8478.namprd11.prod.outlook.com
 ([fe80::6961:eda0:dc93:5b4d%6]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 12:48:20 +0000
Message-ID: <8ef4dc95-c41b-4f60-83b9-bb55a1ddd35a@intel.com>
Date: Wed, 26 Jun 2024 20:47:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/acpi: fix panic while AP online later with kernel
 parameter maxcpus=1
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <rafael@kernel.org>,
	<hpa@zytor.com>, <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240626073920.176471-1-zhiquan1.li@intel.com>
 <qtd7pvvw7vgev5ecqjmrvcule7eqyyqxbqg4bu3k37bwhyxtzt@gdp4sjr6expl>
From: Zhiquan Li <zhiquan1.li@intel.com>
Content-Language: en-US
In-Reply-To: <qtd7pvvw7vgev5ecqjmrvcule7eqyyqxbqg4bu3k37bwhyxtzt@gdp4sjr6expl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::14)
 To PH7PR11MB8478.namprd11.prod.outlook.com (2603:10b6:510:308::11)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB8478:EE_|MN2PR11MB4616:EE_
X-MS-Office365-Filtering-Correlation-Id: b665d5f2-f110-443d-5175-08dc95de41a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|7416012|1800799022;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2Q4aFNORWpRdTFyUnYyUU1wWmRwQkxDckdZZXdUdS9wZ2NXajI4YzlNaTJv?=
 =?utf-8?B?QW5VZk9wdWtUdlFZaWZodjJ6ZTFCeTVlN0hITzBmNU00aitSL0I5RnVpaEp2?=
 =?utf-8?B?eERtMkJEZzN5amdrUm9DRGJ1Y0RpRlB0SFpxMUFHam9sOGpQT2gvTnJEejJY?=
 =?utf-8?B?eTcrdmVWT2tsRE5HWXFic3ViV2ptRWdteTc1eVQ2eVRZY245SW1FN3lEV1d2?=
 =?utf-8?B?bkl6NWNyYXVYWWF3WG5UbSthUEJ5aWRKUXVpZU5ySEIxYzVJOEZmL21kRVFp?=
 =?utf-8?B?RHpJRzJuQmF4aXVwQkQzbHFDQnlkVTVrdllZajRCWjBwTjRDTmFEUHEwMTRu?=
 =?utf-8?B?Rkh4Uzg0d0IzKy9lMkNVWElvMFZMbmp6L0lVMUxHeFBaU3JKZmJTVFZYcEJ0?=
 =?utf-8?B?czl3cEltdHYzNTFoYmJ3N2l5NFUvWkJHcnF4aTlCL3E5K1dhTDdzSEovSktY?=
 =?utf-8?B?dVdJMFE1ODYvdmhkS1pYRzIyNmtKNHAyQmxqQ1RBNlJvOXBYWk5YNDhJaDVU?=
 =?utf-8?B?MFg1WFNGbFJ5bXAwVmJEMitocUZqeDFjWlE3V3FuUEw0bUZVMUsyWENPZXFm?=
 =?utf-8?B?Y0tSZm92b2ExZmVjb0szVzh2WjQ2eEZhNGJ5VktqK25GOE05RkVkTlhqdS9y?=
 =?utf-8?B?N2tGdmlaekNuRzl1T3hEU21HK3c5eTFBdTFvdW9ackhsWWlHU3NTdUQ2K0du?=
 =?utf-8?B?OUU3T3p6VGEySEhKdnJqSkRwdWZTWDVGVDFnQjBPc1I5SExhaUlOL2x5ZWlz?=
 =?utf-8?B?RkJqZ2hPemVpMDFLR09TTFVlUkxKTkIxa1I4UnlYYm95amIwcEkvaEdrLzEy?=
 =?utf-8?B?NjR6bnQ5N1dXbmNDU3hHbkNPRnVsT1NVdG5OZ3pGTmlEeEFDUDdSTzJMYk9L?=
 =?utf-8?B?eHZMTW5HMFErd3RRUE1GdE80NStDZnVVSmIvRmYrSUlpNmkvMVg0ZFVZNGNQ?=
 =?utf-8?B?YlUwK2ZBZ2VVQ1dOL0Y5RDd2VTNKeEVFSUFmakRHQzAyZTEvbVBCODhpdUlF?=
 =?utf-8?B?NCtMNUlvR2tQejVKdUVuK0ZXNWdYVGdZSm1kWklLblFGVzdNQWxyTjhHU0o3?=
 =?utf-8?B?NVd1dGI2RXcrOGhRK0xtQzlSTzIxUENkY2NrM09UR2kxSHVKSXdweWI4U0FJ?=
 =?utf-8?B?NGR2YzZ2U0JDSWZVNzlONW0zUmwySmFyaFdUNU0zTSthRmlCNXBjd2d6T1hp?=
 =?utf-8?B?QXJLTjc5dHZ4SFF4RFJyMkdTZU5OZ0lablgwMnExbUxLMHlsMFZ0VFk5dkNI?=
 =?utf-8?B?c3hkN3llZk41eUttdDcvOElISTZqdU5McXlQV2RxamNuMjI2dHNBQjJ2VW9l?=
 =?utf-8?B?R29lcmkwRmxLUi9iTzZHMUQ2b1R2ZGxUZmtmRlNWdmRmeW43VDhkOVkrUjdY?=
 =?utf-8?B?ZFFPZHhKRThLSlBzYlJIaE5lM0JKL0hWNXV0UHBBNkIvcWNUQUFRSmZOaWk1?=
 =?utf-8?B?eVdydjQyUDRVbEJHNU5iZ2NpQ0F5d0E2bk44bXRMbXNYdFZuclAzQTJ3eUds?=
 =?utf-8?B?cHZhRW1YVXhjSjlUNW55VmFNNGRFTE5ZT3VDaURueU9Pajh5Yk43ajdsS1FD?=
 =?utf-8?B?azBaUms2YitZVnEzblg1REtwL3FBS1AwbGlFWkxzaHN3L1FJL25lV0NyeTM4?=
 =?utf-8?B?QkhxdytDQTJENmRyOThDQXhHb014dTZvTlNjb1NvcllGYTNFUERLalJCc2tI?=
 =?utf-8?B?Y2t4K3NzWnlxNWZaK0oyQkhkbG0wY1lVZnBqcFFLZWxhU0RFd09YLytsTDAx?=
 =?utf-8?B?SzlIU0VJUXJTQytJVGswcW51Q1hEaTVMSE5uYlNsVWpHOWp3RmNWRVF2MzBa?=
 =?utf-8?B?Zk5udWNMMjFQWWNHRGlpdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8478.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(7416012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlZZekhzZHBOSHNGV0N5NEVoRW1LejZSa1ZlM0d5UFpWTWpaWjRXekYwNmt2?=
 =?utf-8?B?RDVicWxtMTJtam9Ma2JKcXdodmJMR0QrQTZUOTQ0K2VaT3U2R05DNXhac1FL?=
 =?utf-8?B?QzFjcEVQU04yYXFFdHppNzROaHdFUWxUNDY2d3E0M2RlZXUxaDBwYksxRWxU?=
 =?utf-8?B?WU9nVnhrNEFLTGRRaXFxNVlqdXl2TE9YYnFsZUZvY3grRTFzTXBENTlTaEhY?=
 =?utf-8?B?U0VzbmZaeEpQSVVZV3FjczJNUk84LzFSQWwzaGh0R0ZRVVNyZWI0NWhuSkM5?=
 =?utf-8?B?ZGtmM1NDVHVsd0Z1MlcwZUNlYm04OG9abEhJbkY1ZGJMWkVyZUdGcWpZdDNv?=
 =?utf-8?B?SWJaaFo0Z1hjMEJkei9lei9NTWRTSkdEWUpwUUQ4QVlHaFlmQXpVNEVNcVFa?=
 =?utf-8?B?NWdFWXBoMzQ5cDhiTzI1OU9EaEJ1M2VvNzM4M29QUmd6QS9NbGkvaGIrOFlz?=
 =?utf-8?B?NWJJWDh1SlhWTGhOb0ZWMXhCbHBjV0RMMmhQbThmTTFOVjkxUnA1V1IwckNx?=
 =?utf-8?B?aU04SllVajdvWmxMUDFoaUI5ZUx3NU1uY21jcll0dy9XSTVhdDJGSU4zWUdB?=
 =?utf-8?B?eWl4SXdBSjMvYlB5bUJYWUw1aTJhYVFwVnpUbU40Y0RtU25JZ3k2V3lxQ0oy?=
 =?utf-8?B?QmxLNmNPNEtReVFETWR6U2NKUVFhUkFsSFZaYzhzTytVL29QU0REVnFLMzQv?=
 =?utf-8?B?SjJmUSsvS2FmeGxjMkNMUFM2MWdGcWpSc3F2c2crN0VybEhyVHNwUXFIYTlS?=
 =?utf-8?B?b1k1QlBSTVRycmdlNkpaNEJEK05lSDh3UGlkL2hGQ1Z4YmJtQnlMT2pjUVRM?=
 =?utf-8?B?aDdIWnBRK0JaemxJMzBpdkFKVHJIWVZHQlZZbVFpWTJYUkFMUXJuN2xVZHEr?=
 =?utf-8?B?N3EyQy90UVkvTmgxVU1OTnNzLzYySnZmSlI1aUdnWCsxQjkvWU1sTU90TzlM?=
 =?utf-8?B?aDEvNFBGa2U1MDF4bGFOektKYXFjbitvL2xNMFBQMFpoYUF5MUVvVHlYdGdY?=
 =?utf-8?B?NXdoeFZXTnA4VHhKZmw0a0tNNVcxMFp2MjY2eEdzZ1A4UkNrUzhMMUtzUGhY?=
 =?utf-8?B?MnI1VUM1UWdNVG5aRHY4WHF5ZVQ4aDg1N1YyYlc1R29XYlVXYXpSaHlCMXlO?=
 =?utf-8?B?SFJzTWxQcmZkTmhNUnZKcFcxMkpRQjUzRlBlSS9xNzFsQUIxRUJ5aTMxWmEr?=
 =?utf-8?B?UU9iMk5ZcmVicVBkYWxZeU1nMzdadEVkVW5GYk96aEU1eUx2ODF6V21iV0My?=
 =?utf-8?B?Q3phMEh2cXJVdWpxbnN5U2FoQWJ3QnBxQW0rT2tucHQxUE5LSlhLdmpyR21j?=
 =?utf-8?B?RCtpQWhsdldFUGxIbkNzQzYzTXFqUitWeTJRQU41QTNneTdCbEhTM1lsdWND?=
 =?utf-8?B?cnBVNTh5bWVVQlloa1ZjOU5lRFJMTjRhU0lGQndEM0dtUUh1dlNCOE1TYzFO?=
 =?utf-8?B?NFVPM09hajNXbEVLa1YrdzdSbkcxYU1iREZxZDlCY2Jid2xDZitEUjRyMFpt?=
 =?utf-8?B?RkJXWktZME5pWmVYdXkzZUxET2JjT2R6ZHA3ZzBsV1dNeU8vbTVLSFRlZU0w?=
 =?utf-8?B?UGRmTHNrZ3IyTlZrMFh0SGZlOUpBVGJSbnIzSlRqTmpMdXdDQkNCeVpjeERh?=
 =?utf-8?B?bThybE01Z1VLVWx3TVFCanFXb2NjSHRzKzNiSlc4TnlDZ0l0N2J4Q3dUaUVt?=
 =?utf-8?B?VkwxT3JtakFJTERXM0toUjdnNUVSTzgzbmRZZGNDVWZEVkl2RnRoaURsdks4?=
 =?utf-8?B?VnF0cGd5SVZXZWFYemZWRkE0ZDRNTGx1UThEempKTHhadFdyOWpVcVowcFRQ?=
 =?utf-8?B?bkRRZnJicEpzWFkzWlFPSElDWWVhRGhiTGorRzFEaWVVQTVVeWZPNytobHFw?=
 =?utf-8?B?RUNROFFNUkhaSU4vRHNoQVRlV1I0aFRDbENHZk41bE02YlN4VmhLZ1dkOFhC?=
 =?utf-8?B?b01xbDFRVWh3NVdTWXA2MCszVWdPWXZ1MDB1RlNkZ3FqSzQ0WEt6bDM3MmFz?=
 =?utf-8?B?WWsrOE5QK1l5azRHczVOYWJRWnVoTW5udnRkMTlBYkovQk9mTDFWNzVoU2xY?=
 =?utf-8?B?djVEVGdzdlg3bjM3N25FaHVIbFFpcjB3dHYzSWhEWVZFak13UGFQU0Yxenlt?=
 =?utf-8?Q?U9pNh4r/CvmhKqGcnKjn/KVZ1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b665d5f2-f110-443d-5175-08dc95de41a5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8478.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 12:48:20.1720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2LTgPG23Ee4sguGMLUZylQ+lDzum+Qh8/QAecg18SAiI8LHg3o+O7ojBnt13kgcSAJYvZNgJkY0Dn+PMLL5LtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4616
X-OriginatorOrg: intel.com


On 2024/6/26 20:17, Kirill A. Shutemov wrote:
> But it is worth noting that the memremap() function that initializes the
> variable cannot be moved into acpi_parse_mp_wake() because memremap() is
> not yet functional at this point in the boot process.

Thanks a lot for your feedback, Kirill!
Especially this part I was not unable to express.

I'll update all of your comments into V2.

Best Regards,
Zhiquan

