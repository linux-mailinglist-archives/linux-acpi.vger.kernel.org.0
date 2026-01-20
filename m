Return-Path: <linux-acpi+bounces-20454-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JrxGLBbcWnLGAAAu9opvQ
	(envelope-from <linux-acpi+bounces-20454-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 00:05:20 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E7C5F398
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 00:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FDEF9032DF
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 14:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F65438FEE;
	Tue, 20 Jan 2026 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GCcOsb7x"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A15939E17E;
	Tue, 20 Jan 2026 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917968; cv=fail; b=JX9eOkdDC5N5PrF+ckeTANqsSs01osoTRTrO/HY1jjFVSUoHRaMad/KwdUzuLGe9WCZ1T8+NYCENwGOOrO5pjGU5XROH+ayoHKFzU9BHz2zmWlXBLsnTWh4Q9DHpsSmsC20tjX8amigRH2NKADve9GaoX5zq4toECflv45cRBnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917968; c=relaxed/simple;
	bh=xGgwRuttlf0PhC3jVnviL8F3PqLDw+gj/cgSAJ7qdh4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s4QevdOG/3POqp9IPmDZiuI61UU/jultJT+O9CAGsl2JmjSiJSjjIrYcpEduFHVShFOdQ8o49a42bEq6VBKr8wdLbXsGFKZGpbedht27L25k1uq4kDaK6RrXwWGt/McP6LH1av2Pgq/kjWWegpTW9XA3hX+ZA+dzs+vIZ2kKpsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GCcOsb7x; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768917967; x=1800453967;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xGgwRuttlf0PhC3jVnviL8F3PqLDw+gj/cgSAJ7qdh4=;
  b=GCcOsb7xs1z9akguYwzj1peIzP3WOhq3TB2gbEDPPsTFhBHwNy63vdFO
   rlTIMFHVJY3n+gvHynB3S7t4DxB041bFQjzOkn2+5UxjuKhL7My4P1vCH
   thIpqIawdR5lbdcFGYztipqpclMJ0ulwRHVD1JR3kHG5EcPcfFLbhaUw9
   trAundnPLuyJZgVrk569ZKpYs5qobsB+e//bDBPobYuNruXRMRkggCpKM
   Gfqva1VljL/DdKsUhtyFawwgxpDraiAQnLrl+tkljDvy6oyOmS7fmkE7c
   mMD25qh2ggw0muk8rgtQd5GyWGPlxy5Ftyl2JKrkziPTv+phGeEn9vSux
   Q==;
X-CSE-ConnectionGUID: ZVVhJYIkSmaXJoON7u0BiQ==
X-CSE-MsgGUID: GHHJ8FxrQg+pfomqW+oipQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="72712413"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="72712413"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 06:06:04 -0800
X-CSE-ConnectionGUID: h5OrvkVmQCuRcD7fcBelAA==
X-CSE-MsgGUID: hbqZKURzRGe16Q/SUu9Ydg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="210980946"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 06:06:04 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 06:06:03 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 20 Jan 2026 06:06:03 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 06:06:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a26C96jztA6MNefYbtEIvL8tQfsF9ja65uerEE1TK1j+aIi1/DPHnh1LbAclGerlWjFAwn6yzBqWI4Ycj/d6azK20r4ywcFejUi98jfO1mr4aruIlgyym6VsDpQF4cI0GSHdlYAG52vYRouhNxsK4uMAzPvGxeRwIlsbNnjN6bMyGUqutUV5yoFzUYbwICq45TQShY0eE+Awarn2WZRPPKzqNNE/vEm/lvykkQW6EYeP3lJZvAD3GCP86UsWCzVhmMvIWsiuAoYtq2F6b6ahF51zz3uqD/SM3hGgoMBFTOqLciOCxDChOPPS9ztiNwQiLu2BcHJCxeMIrS3piE0iaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eud389N6r9HqbdWUo4zGlJL9mjT8wJRu10r9QWHlQsI=;
 b=Cpc99Ut2Jn2UM1kIG1NL3yg2+/R3rGH6CItGE8Kbe6H+1FUkliEsHfo5LNo1JLlK39lzd+6WjWadwrJG4/ttN6iS8Glem+g0t+AoS2agbwt50TBYw1OjGsyGFNb8pvvTUSYBzOyAi688s75wbLrZD1re87i+s8FQ24wNUhbiJsK9mKvlwQT6aiC2YTeAtjS9N2j1kNajSJvbXihvARYxJUFh9L896o337MGpwAOUhCCWrZSuQRClHVhUJiorc5nkG/SMMBbBIi/c4sjZ+RkUHaDkj4DdQiL6F+OvOAp7PfoNRah2sbyx00zXcjNK4V1cMbI4ZdXfVm+2Nhlv6iQjbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN9PR11MB5530.namprd11.prod.outlook.com (2603:10b6:408:103::8)
 by PH3PPF67C992ECC.namprd11.prod.outlook.com (2603:10b6:518:1::d28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 14:06:00 +0000
Received: from BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::1451:ad37:6612:37fb]) by BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::1451:ad37:6612:37fb%4]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 14:06:00 +0000
Message-ID: <d64b79a1-f014-46bb-9924-c111e397ca48@intel.com>
Date: Tue, 20 Jan 2026 19:35:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/12] drm/xe/pm: Refactor PM Sleep Ops
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <intel-xe@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <anshuman.gupta@intel.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<rodrigo.vivi@intel.com>, <varun.gupta@intel.com>,
	<ville.syrjala@linux.intel.com>, <uma.shankar@intel.com>,
	<karthik.poosa@intel.com>, <matthew.auld@intel.com>, <sk.anirban@intel.com>,
	<raag.jadav@intel.com>
References: <20260114180003.GA827167@bhelgaas>
Content-Language: en-US
From: "Nilawar, Badal" <badal.nilawar@intel.com>
In-Reply-To: <20260114180003.GA827167@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0218.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::13) To BN9PR11MB5530.namprd11.prod.outlook.com
 (2603:10b6:408:103::8)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5530:EE_|PH3PPF67C992ECC:EE_
X-MS-Office365-Filtering-Correlation-Id: bd67354b-477b-4220-e5ba-08de582d0a5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2RNbCtQSmtFTUZad0tObGFCYkkxN3VOeTJFdmNGNjZ4cW5zeUV6TXNqeE95?=
 =?utf-8?B?UjFoMkVRdGI4OWQ5YTJmTmVONFZxdGlLdWJycy9NWHRrUVlPck5QWmlPMVBx?=
 =?utf-8?B?TWpNamFKWExYai9sUmdESFROOHJmcGtPMHJhaFZrZlMrQTdDVFhMMSs0MWc4?=
 =?utf-8?B?N05aUTdVSUtPN3M3b1E3TFVmcnpQWVhpbjJJOVRIRVZ3TUMrR2RVdFcrRStX?=
 =?utf-8?B?bktQVmJ1M2lmYVlhbHdhRjhqckNFd0kwUCtpU08wMTkrYk1GR1g0bkw4Nzdm?=
 =?utf-8?B?Ynd3KzhWWVpWVjZOWlZxOVlRb1ZXN0gzejExU3FaaXBiUWJPeWQ5a1gzSkNy?=
 =?utf-8?B?ZW81V3ZoK0RERkZZRFpnK1VTTEVyQkl2UzN3ZnMwQjQxczlqYVZmSmtTVHdU?=
 =?utf-8?B?Qkc4SzNPQlZWeUJTSWw1SGFKN2YvTk1vckRPckkvQXZGN0JvcTErLzlERGhp?=
 =?utf-8?B?dERQS1RYdGVzUERlTjgwRjVtYmpMMXp1SWZjYWIwOERQWU5mQTFyOGFiNVdU?=
 =?utf-8?B?UjA5UElxYXJHcEFVY0R1ZW1QQU5hNXA3OGxNbTI4cFZxQnN0djkyTnBQMkFL?=
 =?utf-8?B?TEw0TGVQT0lRVXg3Z2xlMm5oYk11RmdLMUFiWHppOU9XS3JhMHIxaWlXSFFP?=
 =?utf-8?B?RXdVMEJGUDZrZS9MOUw5Q1pHdWRUbFFKZSs0RmpnZXlJVldMaUpOb05VeHND?=
 =?utf-8?B?WGVaZlBsYTlzRG5WSk1ZSndmOHpJMHZMWUdDeHB5a0RoazgyNzJKZVgyRVVz?=
 =?utf-8?B?VFF3aDJ5c2tBVHdVYWZsV1UzQmpONG12S0J5ZTBNdjZIRDZzZ2NEdk05TGov?=
 =?utf-8?B?TkRVemREUzVTZFlZa0ZOM2NEcjlhZ0pOVjgycVdoVktBMVMzUnFmNEs5SVk4?=
 =?utf-8?B?MTU1NlBQU1ZwSXNiWjg0SFJGUXpyb2VIVHVrbmFlRUxaVnU2aHpFRlF2dEVS?=
 =?utf-8?B?Qy8xcmx5WGVQMCsxbGdBa20rb3BkYjBVQ2thYXpQc1Y1Tk14NmJkbkJWWnpJ?=
 =?utf-8?B?U0I1K0s1UE9WUlEwcmpjc0MxZWtQTjU3NEZDNy9JNEpseUk3WGdTUU5TM0hu?=
 =?utf-8?B?d3cwUnV2R2EvdFhXTlZKOWp4cGVsSnF2eHBxODhuOWtCblhTSHdCa2I0SnFT?=
 =?utf-8?B?Nk53ak0yYUg2bW5uQ3kvVkZVSEJpOTJGOHhXd0pxWHQyTjA5QzkyMlV5UkN4?=
 =?utf-8?B?bHpaZHBod04rUHF2cUExN1k5L1hROTFlU3ZqQ0pYUDJ0eFp3cWlWQ055UWtx?=
 =?utf-8?B?MkF1V01MeXhJc215Tlhlc0kralpiaVlEd2h2TVpJaHUzanFyZVh6aSthYmw3?=
 =?utf-8?B?SUkyK0IzRnRoT3daMStla2g2M3hxQ1BjUjE1cE9iTHA0dTZhL2ZiMFBjUDBT?=
 =?utf-8?B?TWNpTkloQ0dlNDBzYnFkTEtWdmNmajBtZ0pRVDl0UDJrTFBFUW1MTWZsVDJW?=
 =?utf-8?B?a01qa1dCZVdpVUVvK3BkeXZnamZhckg2ejVQRTRGcXFkRVJVMmxmckFrOVpH?=
 =?utf-8?B?Mmd1dG5rKzhlcFRnWjhweHlScnNaTS96aHBuNlpCSFhoVXBhOTcwMkZpYWh6?=
 =?utf-8?B?OEV1aXZqaHE2dTRpSDRQWFIrRDBUSUVVL285eWYxNUZ2Q3NwSnA5SlhoZGxi?=
 =?utf-8?B?ZWpXaVQ0YmkzbnM3WFhPNzVUZUZFcWxoc3RqK2o2UXllZHdWdEMwQ3M5ajU2?=
 =?utf-8?B?Q253UFpWeGM2alBhaEFUbEpqUi9DTUFMRGJkd2RKRTVVRGhoTWRNRU4xRFVE?=
 =?utf-8?B?alRvVU9Ob1NrVVF6VTVMZmE2eUFud28wT1l3RUZuWHltdWVQZVFIbTl3VUh6?=
 =?utf-8?B?Y0U0SGROaTdXNE1DTWFyZVFKZkdLMnpUVUpnd3RqbXg4WjN3OVE0eGpqSlFI?=
 =?utf-8?B?S21iNGV6TGhIRkdNdlNuVmsranlKaTh4RFlvcEdkS2VJL1p0WlJiR3RMemNp?=
 =?utf-8?B?UlZZZCtHUWVqdUtYVWFxWmd1SmEwbVlFQm5Jc1FHalRhR00ycy9qaXFGeFg1?=
 =?utf-8?B?YzFuMlpyR3FzTlNBNkF6NE52dFkwMWlnYnhtVHlkb0FaeW91Uk05MXNhMXNt?=
 =?utf-8?B?MlhoNzFUUkRHd0xtcTdpbHJURWhDV1VRQjk3aHEzYnN1WERDT29xZERGS3Q3?=
 =?utf-8?Q?9llg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5530.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWk5NjRIRGVYWDJBYnUyUGlwSW9IOFVYRW1SaE5xN01KeWpsREtDV2ZpNXNW?=
 =?utf-8?B?VmIvRFJmS090V05RTFRSOCtsRDdqdlZYaDFFQ1N1aG5xODQvMnIwUmhUZWhL?=
 =?utf-8?B?b1NxMFExMHVXM0Z5QzRWQmdsb1g1VTI5WWRpT2NVRmhraDVtRy8wSm84Qkwv?=
 =?utf-8?B?aGZFNTNSdEYremorK1JZM3dQbW95NzRwSTVYalkvbC8rb1dBenRGN0tNN0pQ?=
 =?utf-8?B?WUFpTmh3Y1FmVTM1bkF0ZXhDczJTRkpKNk95Y1FrUVFhbVlFMkxQLzBJZWlC?=
 =?utf-8?B?c1RZU2xua0VyVVcxQnhtWEZ2dlI2ZUV2bFNmNHdqc2YvMjVlSGxYdVBhL1I3?=
 =?utf-8?B?RkdBT0R1aVpLaFloSXozMkd2LzdHRlNEaXJuMUVzSVdDMEFTazFNbVQweFR0?=
 =?utf-8?B?SlJOUVVpYit4eld5cmdhTUxwVUVCNEEzMXgzdWpDYUZHNW9xV2NuWU01d1lP?=
 =?utf-8?B?VDF2c1FkYktzcThNVUhvdFlFQStZRndWWjdvdHJ6Tk9JMlYyekd0Mk5HaG51?=
 =?utf-8?B?SHk5aWFSbkc1SlhTM29DT0VtTURNU3RaVnNNUW9vQ0dldUpLSnBjeFdOdWlu?=
 =?utf-8?B?TGJrcjA2QmFEa0RBVUhGeER3OHFZb3l1SW04NTkvUFpHei8yUnVNc2xNUFo2?=
 =?utf-8?B?NXNjQy9ubUJMQ0dHUEEzcXFSNnROQklLL1Y2SzZ4TDU0ZjFlWTc3MzFYeG8z?=
 =?utf-8?B?UDg0c0xXZHc0cTJ4aUFPWFduenFpc0dyN0dpZW5VdVZMM1dNSnlNZ2lveWI1?=
 =?utf-8?B?WVJhNkY1T0xLZXhrdlZpekNPVWg3MHZVMnhHT2J1MjZkRmFITmx2Y3QvMVpS?=
 =?utf-8?B?Z1k5UUZkYXI1R0J6UkltNHZxbTFPRXRKVXpuQlB5RCtLY2tFOXJzZFRSR2pI?=
 =?utf-8?B?VVFIL3dzK1prTFFPa0l5RWRUZVh0VDFJYUpzVDVXaU1jMnJyeDhQOW9Pa2JS?=
 =?utf-8?B?V3V1bnZQVDgvWCtKWnd5dFN0bjNVM291T1p4RGx2OFUvcDY2QTBMVVpNazNo?=
 =?utf-8?B?WEZoYmZUaE50dHlZeElVaEVpcjdrSkEvdmZvYXZzUlBQTDJJcmErRkZxdThO?=
 =?utf-8?B?N0krbzVrdkIveDcyL0EyQWJQaHdSaWJhUmcvT2JiVkphS1FrK00yMENZR0ZP?=
 =?utf-8?B?aTg2S2Ywbzh3Y0toSHZTam92ZGpCbGlJcDJ1Y0VlTG40eWJteWp5MklPSTA0?=
 =?utf-8?B?OUFSN3NISFJrTXZlRWx3TU9qdGZ4MGZ3OUxDSVM4SkhJenpmQTZsbzEzVmhh?=
 =?utf-8?B?Y0dhekREMy9BOVJGa1Z2RzYvMW5vZ3d3N0xpaEhXbEJ0bGU0Q1NzNldKYmF1?=
 =?utf-8?B?eVFNektMN3FENTIzWnZPWmFGMnlYcmRhWHNqVnpKRHFxVWQyNlpob0dDYm9G?=
 =?utf-8?B?OXZhTUtDb0VkN1d2c1FlV2JraWpONXFLYnhrY0pVTmY4QzhTcG1GeXZaY0ND?=
 =?utf-8?B?cW5ISUY5YldEZXBtSUhUYk41UW1iSklsSzR4OEdBYWUraE9zeWJaWG1sMlI2?=
 =?utf-8?B?NG8xWlJOSEc4UTJXeFo4VmtoQUZYZWs5OVNuMFVHc24xMTRhd2lCaXdkVTY5?=
 =?utf-8?B?TVZKRGZpSGJVSHVkV1ZpYlp0aUpFSlp3MEVMeW9vZVZ5MDF4bTExSUpRNnBa?=
 =?utf-8?B?RVF4YzlMLzR0ZUlscVpjdENGMUFCTDNPSzkyc0dRYXhQUUlsb2xjdTRhT0Z5?=
 =?utf-8?B?SjYzbUhDR2ZtNk1JVlJZQ0NpUFF6NC93SzlPVkh0YlJkUktKQkxGenAvZW9T?=
 =?utf-8?B?L0g5bUJ2cGVjaGdFdXh6bkNBci92U00yUlFGL0F5WWE4SnY2NldWUWs5WmtZ?=
 =?utf-8?B?UjlBcldUMW11T0RSVmh0TzR3eHNTWC9LbUI4M3ZVaEpLU3J6RE5neWQ1N2Nn?=
 =?utf-8?B?MHB6aEVNMisxdlFvUjM3M3FaZmU2WFc0K0ExTUFKV0FPN3VQWCtyNkJFS28v?=
 =?utf-8?B?Y3BFdWdleGV2TDJrajFxQ0Y0V0NGNDYzSGM5L1hnb1ozMEFrYXpTdWcyQkJZ?=
 =?utf-8?B?S0ROQ1lqblZOZHcxVG56OVRQWEMxOWE3aVZEOEw2Y2JtTnpKN090SFROQnl4?=
 =?utf-8?B?TmpadytnajRJSlBrNFQvZ3lkaWVCcVhuUlNTRHd3SjdLdTBGYkFnWFFwVWps?=
 =?utf-8?B?aTdZbkJQSGVYQkdXN3p4b3JPbDhvVEFHdTVjL09MWkszT3M3T1RNSUxnVzRl?=
 =?utf-8?B?b01TRmZqSVZyekcrbEZhZU5lMEQ3amtQRHdHcEhQOEc1QnBuT00xY3NLSDhI?=
 =?utf-8?B?ZU5FYys3RTZVeCtmQTJUSmVLbHowL3pEMkVUVVB4a1dWdGk3cFBrYVFubDZV?=
 =?utf-8?B?NEFJVEpyNU1JZkVnZlpCTTZVVllGRGJMd01CcHJHYndMNkFPVTgvQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd67354b-477b-4220-e5ba-08de582d0a5a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5530.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 14:06:00.7295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltVF/mw9ZlBvtg419MAYu9I/KzO+O8cuJDmL9vdIWafZ+ObQgsChGNpuzlHRBEzz9f1/cn1fcPUWaJx8PAYoEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF67C992ECC
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	DATE_IN_PAST(1.00)[32];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	TAGGED_FROM(0.00)[bounces-20454-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,intel.com:mid,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[badal.nilawar@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C6E7C5F398
X-Rspamd-Action: no action


On 14-01-2026 23:30, Bjorn Helgaas wrote:
> On Tue, Jan 13, 2026 at 10:12:10PM +0530, Badal Nilawar wrote:
>> Refactor PM Sleep OPS to indicate xe_pm_suspend/resume is called
>> during hibernation (S4) or suspend (S3/S2idle).
>> +	 * Enabling D3Cold is needed for S2Idle/S0ix.
>> +	 * It is save to allow here since xe_pm_suspend has evicted
>> +	 * the local memory and the direct complete optimization is disabled.
> s/save/safe/ ?
>
>> +	/* Give back the D3Cold decision to the runtime P M*/
> s/P M/PM/
Sure I will fix above comments.

Thanks,
Badal


