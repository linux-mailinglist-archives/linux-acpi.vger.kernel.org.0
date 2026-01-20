Return-Path: <linux-acpi+bounces-20450-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKbGIh4ZcGkEVwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20450-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 01:09:02 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2464E510
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 01:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E5A0B704C21
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 13:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E1842882B;
	Tue, 20 Jan 2026 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZopDSq6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC48D3A0B17;
	Tue, 20 Jan 2026 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768915715; cv=fail; b=F7xiUBkl8g5aj7MAS+l7IOB5tr7LI0JCKc9SbgTgnETbJfdci40K1BOQ7PPg4ubIU08vpiK/BKaT/r8T/OPFFGmwbbfutMmuOz5uAk6ny2heZsYdvjuGXV9cozAnfRQ/x1p2r3EYfj+AB0vTdqbbwjOijf5YxiKymnE2jGPggI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768915715; c=relaxed/simple;
	bh=6jtv8m7gbrrLxNSGcSIt/RL0HGYfhNmWr5kkRI97VcU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KZaz56RLq69jDGHBLeOLJCaBSZe58MDf8cR267GO51UsTxDi/t7hNEl9YH/0wwHV3wdxbrsT6ijvGHfYiNzw2ZR8LSOPbR0hxd0Zeaw40ML3hHFItperxpzOZxnGMH2DNde9H8zTvpTfFq3AbQlDFPsNal96f407Pnmx+MNTT0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZopDSq6; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768915714; x=1800451714;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6jtv8m7gbrrLxNSGcSIt/RL0HGYfhNmWr5kkRI97VcU=;
  b=ZZopDSq6f+7eAZme2pj/EIwnMXUnn+TQUfj5gzbRE2SzAAXCl+pKtIXM
   9nFDkV0Ug6glQ2XVjQMte5/yd0wYgIf419/0vVV6NpAhyehuSQUKrtlfS
   CW3pXL+K9XuxMTi3sv/LUkzckB+zbH798WS1VnKXxD9Cj5/R3j8qWSpEn
   r2gbVcAXf9xNJVbof32d82DoEhrJDoPyhFCorypA5N4XzSrrmC1H+PEys
   0hnyKGRbHCTnz7kFr/7K9NwJJ5hBluN1ZgtVVdKgoFofnAgQCUuT6JGna
   fvoCMhoTHlkaFCWH+++FTnoRU19QiEshvhdinTfXEzqcY9o5cGwmr1G9a
   Q==;
X-CSE-ConnectionGUID: FilCPqUnR868ocN0Y1M/5w==
X-CSE-MsgGUID: qXqG8DbyTdWl7agcpMwM7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="80424995"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="80424995"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 05:28:34 -0800
X-CSE-ConnectionGUID: snJuwej3RrGr//ltRNtBjQ==
X-CSE-MsgGUID: b8phCT6ZRkehh9L+5x7C0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="206546520"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 05:28:33 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 05:28:32 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 20 Jan 2026 05:28:32 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 05:28:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mRknDnEvVOVss+EmEM+ROABbQN/VQK9+gm4WfBH1VArQx8Qa7GCE0Ohcm05SQy3+4G8/p/hJOPxVjYDqH8Wf9Q/xZ/dOq83aVgpjoYgLKTRAA8+FVP+5GrPc2gmA+nIPnSj0zJpRTowOqBTK+n3AHBt34kgTW35tUO4N93NrgvC/MXGQKVb5qpVfnZdrPzDwAAd0JJd1ksDwYWmkMbLNh0XewzrPVmGpo1lzGM2d7tXvpZecK+Jf/MWxWaz84ZzG0rjxpMHOdLs7AMlcNfH7s647Qg1tBW5rnjWeDof+x0f0eH0eE0m3vL76SkINGm+2iggnAU757Ue6FUue/PE3ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFqOMHuVC7KkchNBcFPATSOvLHvloI1JyHYtkWUr708=;
 b=ab0JpXbG9N697BUAJGTM6OiAm49tlxTkbZGbJo0b/lDMlpEQogY+Lk9MSIm1rsDztQSw5MqfKz4KxInoKoNIwj67X2HeYGeGKl5JRIn/azTd2QBGrnSDwVmaSzf1q70lYavM6UP1rD2Bjgc/4wO3yqopLDl8Kf4eznKTyQhCbzPWmS8aLElbBAkcpKNrAyAXEx7ssQnAZMogSHvnukQwDbndvqcZNgshAAvyeBQdVI3Mk724ZkOx2l44HArOLJpbzGAAvKvjTue3201Ho2ObuaU2EBfkGmk2ahOB0UHllPaMC7dcCcEibz36ECmha5d70heZPKLrnYnDmZqFpGDtEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN9PR11MB5530.namprd11.prod.outlook.com (2603:10b6:408:103::8)
 by PH3PPF3ECB6A513.namprd11.prod.outlook.com (2603:10b6:518:1::d19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 13:28:23 +0000
Received: from BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::1451:ad37:6612:37fb]) by BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::1451:ad37:6612:37fb%4]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 13:28:23 +0000
Message-ID: <431ce6be-b083-4002-8dc1-4be8e557d07c@intel.com>
Date: Tue, 20 Jan 2026 18:58:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/12] drm/xe/vrsr: Enable VRSR on default VGA boot
 device
To: Rodrigo Vivi <rodrigo.vivi@intel.com>, Jani Nikula
	<jani.nikula@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <anshuman.gupta@intel.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<varun.gupta@intel.com>, <ville.syrjala@linux.intel.com>,
	<uma.shankar@intel.com>, <karthik.poosa@intel.com>, <matthew.auld@intel.com>,
	<sk.anirban@intel.com>, <raag.jadav@intel.com>
References: <20260113164200.1151788-14-badal.nilawar@intel.com>
 <20260113164200.1151788-20-badal.nilawar@intel.com>
 <64894565d5eace99fd65f290ee807dabaa2de04f@intel.com>
 <aWkG5cEapt_attfS@intel.com>
Content-Language: en-US
From: "Nilawar, Badal" <badal.nilawar@intel.com>
In-Reply-To: <aWkG5cEapt_attfS@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0177.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::9) To BN9PR11MB5530.namprd11.prod.outlook.com
 (2603:10b6:408:103::8)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5530:EE_|PH3PPF3ECB6A513:EE_
X-MS-Office365-Filtering-Correlation-Id: 17fec48f-15ef-40d0-c723-08de5827c90e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEdUL2tvZ3lNV0ZXYVdSVVBvY0NSV3dnWlFwL0k3bCt1VDRaS1ViY25mV25i?=
 =?utf-8?B?OVVZd1VXTDYvSDdVVk1qM0ZZeUl1bjVrZXhvdWtyTW8ycHFDSDQ4eEQ0ejlN?=
 =?utf-8?B?UDNRQlAwOXNNWnM2NHlHRkt2OVpzbVFFLzJnVWVtU2Jqb0ZVMUhQN1haK3pL?=
 =?utf-8?B?OC9ZeDFrV2Z5WkFBVmN3Q1Q2RjZwNVhGdk82NHcxTnQrSldTY3JSWXlVMWVy?=
 =?utf-8?B?ZFJHaEprWTI4dFVGeFNqYiswL0s2My9aRXhVY3FzRC9hUXRiVnkza0NPc09C?=
 =?utf-8?B?OWdNS1Q5aVh5UkdmZ1JMWm4zR05yRWt2SlY3aUxrWTBqVi91VzhmUEd6ZGlm?=
 =?utf-8?B?MXU1cmJrUUNtV2tqUk1sUUhHMkRiZUYydXJsYVN2cnAvVnFLcUdUQW02b0RT?=
 =?utf-8?B?VE92bHNUYzJTQmFBUE5kbCtKNElIbFVoRzZaZ3pUSmlEczdUdEZIT2wvTUl6?=
 =?utf-8?B?YlpLb0hzSXl0a3c1aU5aY2YyWXllZFI2TUl3ME9uMXNINFRiZUhtK2FvVERQ?=
 =?utf-8?B?TWh4a3N4Y1Y0dmFLTUVOMWFyY25rYnRLcUtHeFY2SkhOMkJUeVU0a0dwS0dz?=
 =?utf-8?B?YjNiMmFGQzE2VFM4cnJBeFlWbW9DM0RaSUxyMjY4UWxJS2FKWFhDZDlkcklU?=
 =?utf-8?B?LzNCeG5peUwxajdYYjRybmMzMk1oejIyWk1kSHBrUWdFems5TTJzbldGaTQw?=
 =?utf-8?B?MnNHSFJEMmtUNnZPcVBUZm5jdU5McW4yUmJHS09VVmNnSWZlYnkrL1NmUWZF?=
 =?utf-8?B?aERLUGUrUko4Zkh4UUhjVVl1REo5bFdqUFRQTk9TWjBHTDdhOEVFVlUrMGd3?=
 =?utf-8?B?RmM3d3NWRkxxc2syTnIxT1dlQ0RpUHkxREFrbm03c2FLLzdGTy8zK3NOUHlt?=
 =?utf-8?B?bXY1dVRqYkNVMWRvdGttMmR3ZU1ISWp5WExzMVA5NlVjaEw4b09yd2xYVjZx?=
 =?utf-8?B?c2dvbkxhQk02MnhQeUwzZjA5aTY5VUtnVGVwc3Z1YlBPQmRXUlpTSk9iU2FK?=
 =?utf-8?B?WHFJZUREVC96K0VqZ0hjVHJ0NWZVZzQ4UnNCZUdGaWlwMU02eXIzblN0cTNz?=
 =?utf-8?B?S0hYK1RwNHpnRmdEN2JvSTNRdUVEcVJBSEdrOWNxWXdzUjUxR20vZlNmRmdH?=
 =?utf-8?B?UzFGYTRFaE8xNDkxbzI3Rm82MTJJUW5tdzYwTXJGaVg0UzRRZEF5enZrTFlm?=
 =?utf-8?B?THdSZHJrL2w4ZU9sV0NGWmk5dGx1U0ZMM3N6ZFN5SEg1YTVmUU1ONDkvK1Ix?=
 =?utf-8?B?Lzg0cHNRcXI4Qzl4MG1CWmliQlBMTjdwZFkyL0xIQTBuWlNyU2VNZm1abms4?=
 =?utf-8?B?bm9FZHFuZUV1RG1IMHRpa1FqLzM0SmJ5QzM0d3VIZHh2Z1RlcjcvbXdUL2tD?=
 =?utf-8?B?S0VvWFVlelEraE9MQWVOeVZTZ2RBeWRmaG1RZzh3UFZaMk8xMzFyQ0cxbGU3?=
 =?utf-8?B?NkVXWVlqUFdFdnBlZlJyQVo5S09VaXZscXBrUlFwTWY1QXFpSXFSdUNTbkh4?=
 =?utf-8?B?UitjczdOS0lFRklyU1dkc0JBT2Z6M25qRjl0WEFKaTFlaXhiamU3Uy95U3FI?=
 =?utf-8?B?dWpRN2dzdE9UaFV0d243RS80TmFTTVdoeDU5dncrTVBiT1pJYmpQSjZxMS9M?=
 =?utf-8?B?QTV2VTg1ZzM3eDZyci9nN2tlQmZSSzl1WkZMZlJxNXFPWFRMWE1pMERLcDVJ?=
 =?utf-8?B?T1JVTUptQnp1SDdEWk93QTdUcmFhQ2xTOEx4VUgvM2pNRGEwcjdNbmZOanpq?=
 =?utf-8?B?amtTNENDcXdZeWhldzBIanAzVStRV0hYS3ByWTd0eko3dlI4ODBpQVZxQ3hE?=
 =?utf-8?B?eGQ5L0xuNkNYc2szZ09kVG9HVS85SjJQeFhuSEFHZURkckFFMVNvODBvVjhQ?=
 =?utf-8?B?a1B0WGsxaiswWlVBRC9FazZRRVdCclVRQ1dDSEdQTzdNWWhMa0h4WFFEL09Z?=
 =?utf-8?B?VjdLL21yTHF1U3MvVTNDUGkwKzFML082cUVLTWFlMk5tUlVMb3NpSXNUcTMy?=
 =?utf-8?B?WUZNL2FyUWtZK2ZxRDF2ZWJKdGg2eUxvUGxzWXNlQ0d3UU5VeXlhclZVc1Qv?=
 =?utf-8?B?R3lsMUtTa2JjMEQ5aFhxSDhmQmtIWnQ3QWdQM3M3ME9FMzRsN1hiSnNuNXBC?=
 =?utf-8?Q?JpMU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5530.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXE2NnZBaTEvYmUwTUI1b2FQN09KU1A0OTRGRTNScnF1NXZ3czJFVm9nVmRV?=
 =?utf-8?B?aXZvQ3ZrcXJPeGxJamNvNXVsWW5IQ0FpaHJPREUrVHBjUUY1UVRSWXVORytK?=
 =?utf-8?B?ak9PM1IvMFB1T09SbU9OUXN5RFlCSVJuYXBpNUd0QllPZ0svUjJTc25NOG9M?=
 =?utf-8?B?NzUzVDRqOUI0Q1J6VjhORlBRZzd4NW5icGRmVE5GTHVtMmd4S2NxLzFjN0FP?=
 =?utf-8?B?Y29vejdQZ0h1UmgvcXFYb3dDdGxOS0tKNGZjdy9IQ3VpRHJ2dWEvK0R5Yndu?=
 =?utf-8?B?dGJWVjlJNDJpSnJPaXIxZXhVSEUzV20xU3YwZnRLN25RUHM0T3o5TkpGNHVn?=
 =?utf-8?B?N25JbTB4cFV5bjlHSStaenZLOGV0ZHNna2JhWk1Sa05kRUx2Y2dxS1J1cTdN?=
 =?utf-8?B?cXRyWXFaZk13eXJLMHZObVQ1T1JXaEFCRXM3enhaYTRWd0F2aU15ZHAzOXBP?=
 =?utf-8?B?VXp5OUJ6WkV0SEwrM1pSWGd2SDE5ZzZ1OTZ2Y3pkcFVSK3BORXVWaEFrYTBm?=
 =?utf-8?B?dUpHakxzU3E1em5TeWcyMTM2VXZWWXlaMENPa2NDZkowWkV4a0VURGwrdUJP?=
 =?utf-8?B?STZQNDdGbnBkTC9vN3ZYNFBmV1pVZGJ0N2c4b1RRcFhuQzhyUnBBWHE0T1dy?=
 =?utf-8?B?SEQ0VkxXUUh5RnZ4NVZoOUlXNWFBQkZhckFRNkxrRndMK2UwRzlLcktxY1dQ?=
 =?utf-8?B?VWpyejRNd3dMdG5VajhjTUNycVlMRTFTenhYOHhSRjUwbUJNbHl5TTlwcGNM?=
 =?utf-8?B?K1BUL3BoOTVlL2Jwc1kzY3UyMmRjOERNb1RRSWtBdk5Nd3A5R1MrU1ptdTg4?=
 =?utf-8?B?NDF4d2pEL1c1Rmp2WEFrSEF2V0ROVzR5b0NqU0xmNnFpNjV5M3k1aExlemlv?=
 =?utf-8?B?SC9tbEZwQy9oUjRLS0x2ZUJqcjlrdjVMcWhCRTZlUEp1NjF5SFZTMnp4dmJO?=
 =?utf-8?B?RFh3ZHdGZU9SL2NvNkwrQjhNai8zaUE3V2IzQks0TFBVRlZuWFczTVVBNzZ3?=
 =?utf-8?B?VlNzK3lMeVNsMU13akZWU0NPRndqZUFhZ09Mbm9jbWU5ZmxGMUt5RlpjLzJi?=
 =?utf-8?B?anFlVE5vUzJJL1VkVnRuN1QzQ3JLdWl5aE05VXQyNlJEWTJReVlpdVNsK0di?=
 =?utf-8?B?dXRETkVjZnBqVnNQbFJCOVdzYWs0Tm45RUVaWVl5RlljVk5oWTFLRDljNjla?=
 =?utf-8?B?UHdmRG5TMzdCcHh0aCswUXVqWC9KaHVicjIwcThDUHNDMGhBR0lSZ054V1c4?=
 =?utf-8?B?c1RBSGFDQUxDcVo4NklvMWpMQ3VYQ0I2VlVrcjFtamxOSDlVV2NhWWE1Ukw4?=
 =?utf-8?B?aDBPM0NXak1sK1pzOU9OU091RlVBN0ZsM01yZVdZTGcxRm5xSGlCQ1FsRXVD?=
 =?utf-8?B?ZldhSU1GY1lzeFQzWXM1UXJaZHlsOFA4a1lQaFFJR0txVDdsWTF1aUJFM2xt?=
 =?utf-8?B?ZzlHbkdVWXRRcURQbXpoVjRGTFp1SmpDTTU0LzF4dlZUdUxjL2c4YkRiSWZq?=
 =?utf-8?B?ZFlvMFNTNDVwVUZCMUVKNXNNYVU3VTlRdFVIem9OSFc1ME90d0svZTBvM1VQ?=
 =?utf-8?B?T1VQTEVxNHVNbVVWZldoVW9GNWZGNVZ1VkdNYjV3MEszTjBRblFrSmgyaUM0?=
 =?utf-8?B?eWpyMWsvNURiWnNWaEhwOXA5NlJlRWxKLzFnejVYSWRpL2pHd2txa0oxTElx?=
 =?utf-8?B?QXRuQWwyczVMNEM5My9XSDEwY1dveDVOemJqcDZrNmpLdEthdzhhS0JGb3d0?=
 =?utf-8?B?OEx5LzhLUXRsTUZHbTdPR3AzZFJEWGl3aDMwc3BTVm1iWTN4Z1pPUW1PMGZT?=
 =?utf-8?B?Z2xPdzEzcUNBR2lrVnN6QWhxSXd5VmRqVjRya3pOUlo1eTNvemRuR3F4RUow?=
 =?utf-8?B?UDRhZVFpZFVzWjkwbUc5SSszTzVrMklaRlJMU2VBSEhvTWUwQUVvcDVLczFJ?=
 =?utf-8?B?WFlFLy9lbkh4ZnMybWkveXBUNzFxS1hNcW11M2V3MXQyeHVtTnJJbHhJWWc2?=
 =?utf-8?B?R055NmNJQW8wZG1rM0gxRXg5cDlhc09yUzlwaFcxQ1pkTHNVRFUveGZqSDBG?=
 =?utf-8?B?WjFFMjBBRzJPanVFVUYxckxHcnBLenlxQ3MvL1hUNHJya3p6bjBHUmZCMjZO?=
 =?utf-8?B?eDB0bGZaTDM5cnFiZ21hdFRwUldDRlFxZXZZR3AyL1VYZlA4NzRXQzcwZzhT?=
 =?utf-8?B?QUloTitLSUV6S2IxZ05zVHJzaVVtWGxZcjR5Wi9WVVBsT2xlV0JaeXQrUk1r?=
 =?utf-8?B?Nld4TFBEYk1hSnhpZnlFUm9vT2ZkMWFremM3eXB3VTg0UEh0b3dMR3RSb2Ir?=
 =?utf-8?B?dzI4Sy82dkJMK0dYYkhBSUdKVjFGSTl2cXFnbUJlMzcwcytvSFhBdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17fec48f-15ef-40d0-c723-08de5827c90e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5530.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 13:28:23.5700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECC5SBFbK3pmQVMQQcvafUHl2b4GHsBHTEur0CN8+egbQTn1j4I8ahnNs9u0xyG81R1e6Xj4Wql/zhj9NKaKNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF3ECB6A513
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20450-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,intel.com:email,intel.com:dkim,intel.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[badal.nilawar@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 3D2464E510
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 15-01-2026 20:55, Rodrigo Vivi wrote:
> On Thu, Jan 15, 2026 at 04:25:06PM +0200, Jani Nikula wrote:
>> On Tue, 13 Jan 2026, Badal Nilawar <badal.nilawar@intel.com> wrote:
>>> The VRSR feature is to enhance the display screen refresh experience
>>> when the device exits from the D3cold state. Therefore, apply the VRSR
>>> feature to the default VGA boot device and when a display is connected.
>> I don't understand how you get from the 1st sentence "therefore" the 2nd
>> sentence. Please elaborate what you're trying to do here, and why.
> On a scenario with multiple GPU, only one can use the aux power and the
> feature itself was mainly designed for the display case - to bring up
> display faster after the d3cold.
This is to enhance screen refresh experience of primary display.
>
> But yes, the right explanation for the why needs to be here.
I will rephrase the explanation.
>
> Also, although unlikely, we never know what users can do out there, and
> perhaps we will have someone with multiple cards and display plugged in
> more than one?! We probably also need a global counter/flag to avoid
> a second one to quick in.
>
> But we definitely need to prioritize the first one with display connected.
At present there is no way to know which one is primary display that's 
why check is against default_vga_device.
>
>> So we have xe_pci_probe() -> xe_pm_init() -> xe_pm_vrsr_init() ->
>> xe_display_connected() -> intel_display_connected(), and that's the only
>> path and point in time to check whether displays are connected. If not,
>> the decision is "not VRSR capable", which is just a weird concusion to
>> make. The *capability* does not depend on displays, does it?
>>
>> If you boot a device without a display, and then plug in a display, no
>> VRSR for you?
> yeap, it looks like the check is in the wrong place. It needs to be
> checked when going to d3cold...

Yes, VRSR will not be enabled if display is not connected at boot.
*capability* does not depend on display but VRSR use case is.

>> More comments inline.
>>
>>> v2: Move generic display logic to i915/display (Jani)
>>>
>>> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
>>> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
>>> ---
>>>   drivers/gpu/drm/i915/display/intel_display.c | 22 ++++++++++++++++++++
>>>   drivers/gpu/drm/i915/display/intel_display.h |  1 +
>>>   drivers/gpu/drm/xe/display/xe_display.c      |  5 +++++
>>>   drivers/gpu/drm/xe/display/xe_display.h      |  2 ++
>>>   drivers/gpu/drm/xe/xe_pm.c                   |  5 +++++
>>>   5 files changed, 35 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
>>> index 81b3a6692ca2..97c74272fb19 100644
>>> --- a/drivers/gpu/drm/i915/display/intel_display.c
>>> +++ b/drivers/gpu/drm/i915/display/intel_display.c
>>> @@ -8426,3 +8426,25 @@ bool intel_scanout_needs_vtd_wa(struct intel_display *display)
>>>   {
>>>   	return IS_DISPLAY_VER(display, 6, 11) && intel_display_vtd_active(display);
>>>   }
>>> +
>>> +bool intel_display_connected(struct intel_display *display)
>>> +{
>>> +	struct drm_connector *list_connector;
>>> +	struct drm_connector_list_iter iter;
>>> +	bool ret = false;
>>> +
>>> +	mutex_lock(&display->drm->mode_config.mutex);
>>> +	drm_connector_list_iter_begin(display->drm, &iter);
>>> +
>>> +	drm_for_each_connector_iter(list_connector, &iter) {
>>> +		if (list_connector->status == connector_status_connected) {
>>> +			ret = true;
>>> +			break;
>>> +		}
>>> +	}
>>> +
>>> +	drm_connector_list_iter_end(&iter);
>>> +	mutex_unlock(&display->drm->mode_config.mutex);
>>> +
>>> +	return ret;
>>> +}
>>> diff --git a/drivers/gpu/drm/i915/display/intel_display.h b/drivers/gpu/drm/i915/display/intel_display.h
>>> index f8e6e4e82722..20690aa59324 100644
>>> --- a/drivers/gpu/drm/i915/display/intel_display.h
>>> +++ b/drivers/gpu/drm/i915/display/intel_display.h
>>> @@ -560,5 +560,6 @@ bool assert_port_valid(struct intel_display *display, enum port port);
>>>   
>>>   bool intel_scanout_needs_vtd_wa(struct intel_display *display);
>>>   int intel_crtc_num_joined_pipes(const struct intel_crtc_state *crtc_state);
>>> +bool intel_display_connected(struct intel_display *display);
>>>   
>>>   #endif
>>> diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
>>> index f8a831b5dc7d..54ed39b257ad 100644
>>> --- a/drivers/gpu/drm/xe/display/xe_display.c
>>> +++ b/drivers/gpu/drm/xe/display/xe_display.c
>>> @@ -64,6 +64,11 @@ bool xe_display_driver_probe_defer(struct pci_dev *pdev)
>>>   	return intel_display_driver_probe_defer(pdev);
>>>   }
>>>   
>>> +bool xe_display_connected(struct xe_device *xe)
>>> +{
>>> +	return intel_display_connected(xe->display);
>>> +}
>>> +
>>>   /**
>>>    * xe_display_driver_set_hooks - Add driver flags and hooks for display
>>>    * @driver: DRM device driver
>>> diff --git a/drivers/gpu/drm/xe/display/xe_display.h b/drivers/gpu/drm/xe/display/xe_display.h
>>> index 76db95c25f7e..11d4b09808e5 100644
>>> --- a/drivers/gpu/drm/xe/display/xe_display.h
>>> +++ b/drivers/gpu/drm/xe/display/xe_display.h
>>> @@ -37,6 +37,7 @@ void xe_display_pm_resume(struct xe_device *xe);
>>>   void xe_display_pm_runtime_suspend(struct xe_device *xe);
>>>   void xe_display_pm_runtime_suspend_late(struct xe_device *xe);
>>>   void xe_display_pm_runtime_resume(struct xe_device *xe);
>>> +bool xe_display_connected(struct xe_device *xe);
>>>   
>>>   #else
>>>   
>>> @@ -67,5 +68,6 @@ static inline void xe_display_pm_runtime_suspend(struct xe_device *xe) {}
>>>   static inline void xe_display_pm_runtime_suspend_late(struct xe_device *xe) {}
>>>   static inline void xe_display_pm_runtime_resume(struct xe_device *xe) {}
>>>   
>>> +static inline bool xe_display_connected(struct xe_device *xe) { return false; }
>> There was a blank line before #endif. Please keep it. Ditto throughout
>> the series.
>>
>>>   #endif /* CONFIG_DRM_XE_DISPLAY */
>>>   #endif /* _XE_DISPLAY_H_ */
>>> diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
>>> index 3fe673f0f87d..e7aa876ce9e0 100644
>>> --- a/drivers/gpu/drm/xe/xe_pm.c
>>> +++ b/drivers/gpu/drm/xe/xe_pm.c
>>> @@ -9,6 +9,7 @@
>>>   #include <linux/fault-inject.h>
>>>   #include <linux/pm_runtime.h>
>>>   #include <linux/suspend.h>
>>> +#include <linux/vgaarb.h>
>>>   
>>>   #include <drm/drm_managed.h>
>>>   #include <drm/ttm/ttm_placement.h>
>>> @@ -387,6 +388,7 @@ static int pci_acpi_aux_power_setup(struct xe_device *xe)
>>>   
>>>   static void xe_pm_vrsr_init(struct xe_device *xe)
>>>   {
>>> +	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
>>>   	int ret;
>>>   
>>>   	if (!xe->info.has_vrsr)
>>> @@ -395,6 +397,9 @@ static void xe_pm_vrsr_init(struct xe_device *xe)
>>>   	if (!xe_pm_vrsr_capable(xe))
>>>   		return;
>>>   
>>> +	if (pdev != vga_default_device() || !xe_display_connected(xe))
>> Simply considering the places in the kernel that call
>> vga_default_device(), this just doesn't feel right.
> I also don't understand why to check this vga default device...

As previously mentioned, a check for the default VGA device was added to 
determine if this is the primary display.

Thanks,
Badal

>
>>
>> BR,
>> Jani.
>>
>>
>>> +		return;
>>> +
>>>   	/*
>>>   	 * If the VRSR initialization fails, the device will proceed with the regular
>>>   	 * D3cold flow
>> -- 
>> Jani Nikula, Intel

