Return-Path: <linux-acpi+bounces-3120-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEE684437F
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jan 2024 16:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0129284414
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jan 2024 15:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE9A83CD9;
	Wed, 31 Jan 2024 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lMsWrtW8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D01433CB;
	Wed, 31 Jan 2024 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716616; cv=fail; b=V9n3OUIJbiGdmuZeYdVopYcf1g0D8I1qy2y811chD6hRLjmtoYD/rMf4tBdRlxEZO7Xo45RFUsJOM/CRoriRCOzxfoufbANp7bGskWM2IgQk4hzZtc8Yc1RpSDRE4ABjjY2k2tCLr314GlDQUz5X/k0U2SSdlbfGxc1EksHVSUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716616; c=relaxed/simple;
	bh=71i5XWZVaAl1Zw863vi/wUx2chNMsJajlEyNl55YxYE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kWbWiaHX8bBkVecBh1zM0NoiMDfFvqGQzweIRFN8B4o3qtUhGDyFXu4Sk5gHy9DkBpCp01QlmLHJlUuKLz78so99EkmVvLuWJxCFTxHd3JRSRXOJA0pv/MsI/7nxZ/u16V6oNzKLsLizXN+xOW5zQX1ukfQAKKV5Y95LAlxqTbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lMsWrtW8; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706716614; x=1738252614;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=71i5XWZVaAl1Zw863vi/wUx2chNMsJajlEyNl55YxYE=;
  b=lMsWrtW8LnAoGtVN/XQqCUKWB4tYvlND2aSac2Gz6cVUiNutQcU/6s6/
   LTgkQVcI4dxugPfEnOjuaQyQ4Q6kQnzZFDi44knUK8tR0isgGRBc0iKgA
   XVywJnYvu5CpuRqc5rHUsaNEkmocTq56VP2RJNXqMMbj2/4Or4qM21MZa
   OOqDAAjHAR0t0kJJ2b6xbCCOIlZf38TnNSVUP9pwV9+ERG+V31XOAh3lr
   kywaTt9gcMBgMK/X2aU/OnW7fabp+bX/Dk1OuNcJPuYv4P9FwHk1O5q5X
   ye/H//aYEDpUq0Qm2DSKgB7Ns0JCW9kga3BmBFlOccNyGFjmkcmNYnZjq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="17172335"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="17172335"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 07:56:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="30540955"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2024 07:56:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 07:56:52 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 07:56:52 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 07:56:52 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 07:56:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8rlm8HCNdUBc5JaktrIfnngliRUq454PZpxj2ekZ2fYybKAk8DDwk6y/2srKMMQG/jZQFTKTXw7om9aw3DPKrG1K3eD2hjxYHbNkDrEmcToclarbIRkuj+d2mjbvR19iEWoxMUMETf29wf2zR3k/oS9ZGd0SXQRPcVxwOzEP+2i4nUbMXWswZMDbg798p6de50mIGQ6vu85ssPq8EmbX1uk8J2qvxvEOD8fRUaG1cUQmcrbpiGIpuQUjN/+F12KhGowF+3EzxZfRkzayUpsPaA/GE/aQpYYAT6tuFM4LfU0mf95CbZgoq7NVp1mTt5KGBbrB5vg1Wysoe5ydpBG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+TZsqGLWd+0w50/Qgrem9dN+5PySx79vdlvxl3EBag=;
 b=C2YKHQ+KAejZAxYpCm4/biun2e/lvenndAE2R/Htr+58JjP6qDT7GAFRoDFj4a+6oJf69Z8dMS6IlVmHn4obM6nWegVigUNYl+j4QjGGBGve9n2pDeSs4KXZE0N7k7fRd1TfXWjEIPPktOc2kI6koM203C+3UFaI02VTv4ipOILfX+OVvxYO9mcjZ8sTaeWQB7HuyjEc8nPwDq4pa6nYW1fA1t5cV3Mnt9vfXpgLOiKAZd0N+z5hrcgNmKlHHnRnc3ugI2DBtVQ3BM3VUuiEF1biBCm5vLsWV7NNMU/ULuDQBFibYMjNlOOq07TAvfYmuLMhjrhHKDKmtHg9FMoVKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by BL3PR11MB6529.namprd11.prod.outlook.com (2603:10b6:208:38c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 15:56:47 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::c403:9b0a:1267:d225]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::c403:9b0a:1267:d225%6]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 15:56:47 +0000
Message-ID: <b243e80f-1b24-4756-8bb3-8389d66ea13a@intel.com>
Date: Wed, 31 Jan 2024 08:56:41 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v4 08/11] cxl/region: Calculate performance data for a
 region
To: <wj28.lee@samsung.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "brice.goglin@gmail.com"
	<brice.goglin@gmail.com>, "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, KyungSan Kim <ks0204.kim@samsung.com>, "Hojin
 Nam" <hj96.nam@samsung.com>
References: <170568503239.1008395.2633682569497108646.stgit@djiang5-mobl3>
 <170568485801.1008395.12244787918793980621.stgit@djiang5-mobl3>
 <CGME20240119172408epcas2p2e461bf193d43347c70c18ad7681774a8@epcms2p4>
 <20240131022226epcms2p47d09167da93641ea88461563c494335a@epcms2p4>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240131022226epcms2p47d09167da93641ea88461563c494335a@epcms2p4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0189.namprd05.prod.outlook.com
 (2603:10b6:a03:330::14) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|BL3PR11MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: b79ffa02-12f7-436c-e5f1-08dc22753ad4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 466ZGrkA7D+dlT13xN348ywponMmTKNmF8i1gSpkR68Ns58jXSv7+EEQpoclKdLkU6fHyA4NyDPao5cSGkfLmbHHnG6OGEdWlgsbkktCS0suozSHajtiLZ8OCxjlHeby0BcqQqyblQzQdBIRD4I/Lu7SMYMi0eURNeYdblF3nEQJgYuFr3jVG/Bt/XehldC+KAGuFzn9koaB16JlxaSi9e3g/BACATqvvjTSRM3iTo+PHMglm/ua+4KulZoIDaiKfuElwKd26hiqiguRLUEy7W3fMZFpdsj0w4Ga7TaYCzmPJW7FHdVpEYIcVpAf3z7SHN5K79y1NpXVq8OHw6nDZW5igETCyusPDjmlMcw74MLBREAA66TzUHMCSAauO5cxStLNyy9jamgwEs0FsyADwqs27v5V0d9ZFZ2bvRLrFkhLqK0wghouwE1SGHAlu6lw6TtdZBpdzvvvhsKiyHporFc7hLy7joMjkyZ9XfZMqtjJLA4eon58uBm1Ul042jUoIxWFN2BQx/JpXXlB6y7ENXzqNs2guh2A7q7dIMNKb4oU2VByL0fMLqVZTUShGKRmhmLVzY7AhKLRXWDjR4w6EHIZPzfgC5BvDGgpXEyiHwtAGNPbijOwRegCcqNjc1a5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(26005)(2616005)(83380400001)(478600001)(53546011)(6486002)(41300700001)(6506007)(6666004)(6512007)(8936002)(36756003)(4326008)(8676002)(82960400001)(44832011)(316002)(66476007)(66556008)(66946007)(54906003)(2906002)(5660300002)(38100700002)(7416002)(31686004)(110136005)(31696002)(86362001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHNFMG1KVFBSdENjbDR5dEpPSzFyQll5MTZ6M1NYMmEzbXAzeDQwMC9scWZR?=
 =?utf-8?B?eWZzZVJpZlloOTgwSkc5K3o3UXlVRlJ0QUpSRXNETGhHTHRZWFlLV0xxdmVz?=
 =?utf-8?B?Y1lEWUVzazNRUmpCMlBRWGdxeW1xN1FrM0RPUmZiMVdnWTV5YXpRdzV1Nmx5?=
 =?utf-8?B?WFUvZXFKQW9xenJxQ3FvazNVM1o2T3dJMWxpVDkvME5lK3RnZUJWTzhoRVE3?=
 =?utf-8?B?RWNKbmpHTCtydGxPYUhvSzF0ak1WZlFnenkzVFpXaktHUTJQdXloZHJCaGcv?=
 =?utf-8?B?MCtjRDZiaTBGaFV5NXk4Zm1RdTB6QW1FQVdhQW5UVXF1WTU2UnBUdGhJekJt?=
 =?utf-8?B?cE5BQWdmRjJScW0wdHcyOURQNitMRzY3VWZqTHZNY1JJbFNZcEhxODU5ODY2?=
 =?utf-8?B?a1FndWlOTTFycFRNaExrTlhVQk9xU3Nyc05hdWgzeEI3SG9QVkpEVkFxU2Ro?=
 =?utf-8?B?ZVRFUm55dU9LdGtmVDk4azZxZW5iSmFkdGU5S3JlM1ZsRkMvSVZyRnE5bTVz?=
 =?utf-8?B?Y2N5SENIZlVrMnlRdVZKYjljdWpQR1AvdnlrQXlOQWF4dWIxT3pvNXhvMHI5?=
 =?utf-8?B?UGQ1dVJoWUVGUXc3bWhpU2V4Wjh1UGJBcTV2SHFVSkRWTnQwMFBDY09QL3FH?=
 =?utf-8?B?Nzl3Nk5QR1M4VHVCWnVORTJ3S2JuTS9TRFlPRjI5Z3JoM0R3UndnTzJBYXBM?=
 =?utf-8?B?ZXpNMzhTc3ZvYzEra3o4OGREUkFpdDU1bnhDTW0wR2NFd2NSZTlkd1RxcnEz?=
 =?utf-8?B?bDhsQTZnZWdCUTZlSTdDQW04MTdETGlZYjB3clRrV1V0ZkRWeHl0OStwRkZ3?=
 =?utf-8?B?anJPdWUrTm9wcVprNWlRZ242dm1wRnZwdlVXc292NmRpcXp5ZTh1elY3bU1y?=
 =?utf-8?B?TzhzaEU1QWRiUXEyenhrUFlrK2EyL1dqVUhveGp2d2RuV1dWcExjbVIrVGFI?=
 =?utf-8?B?V2c2dXp2bHB5MHJXSzYyVEZQL3VkWllBdENJWHBVNVVqYmd4bHdOUkdFT3NO?=
 =?utf-8?B?dW80Y2luY0o3TlkxcElrNjVaeVlBUFc4eUJXVTFDeWRmd1YxazM3NnBCKzhJ?=
 =?utf-8?B?RUNhVnF3dmFkUTdBbEgxZ0E3bFlMek5IWEdzbGlVVnhtVGtmK0tMdWJWekJV?=
 =?utf-8?B?VjdQS3haTVFoUzBTSlUrOFVQRHFkdzhzV2c0K2tlaUt2ZmdNbzJBSFVydEQz?=
 =?utf-8?B?RWxxV2tydjZpUUF5M2JMV0EyU0ptTGtuK1V2WWZHR2NQRHR2eEZzUGkvdEtW?=
 =?utf-8?B?OXUvN2NNR0hqeWJBOWhzYXNKcHIwOFB0c0s4RWZwRmZFVHh2aWVwcG5xMjhS?=
 =?utf-8?B?MDMrTVpKa21mREo4TlFXb215bWVUYU4zRWFMbjdNMmpwenVnT0VyL2psdFFU?=
 =?utf-8?B?L2pJS0VzK0hyL0tqZ3pVK09QSU1YSlJDaDNhK3R3TkhxUkdBODN2UVJsNXlm?=
 =?utf-8?B?QUwvSks4Q0l1eEZtMWpjRjhaSWNFcFlmWVBkWGZmMW1ESzZRdlRCQ2s2Wlph?=
 =?utf-8?B?K0dsR09yUWQwUHc4VmQ5Q3NZQUdZN0NzbGNHUW9Ma1YxWWtob1F0NXhuenVI?=
 =?utf-8?B?WlpNWkNzK21hVHVjVi9nNC92TEJQdkJ2U1J6MXJxaEpVbUJhRHlKZzF1YmFI?=
 =?utf-8?B?U0hQVmxsWGNmZ2ZiS282azhva251Vnc0UUlwdlFYNElpVWNJTGN2d0NOZ2xM?=
 =?utf-8?B?WDB6TEdDUVRGVEppNnlOWFJFRWkrd1dINmVwbXN5clJpN1ZmRG1KM2haTWJz?=
 =?utf-8?B?dWJlaVJwVVlmNlplQ2VzSzNxWXAzNjJIWFRpbVRzSVNhSTl3b1dyeHFoYkpa?=
 =?utf-8?B?UVkrSkhOZmhDWURURzdMSnE4QnlBZWozSjljb2RwVUlWRENLTjIxZWkvZzRF?=
 =?utf-8?B?U3FYcVd4b2FZc2ZzUGhrTjg5U0Exb2hlT2hJZFhsVHIyVWdoSkJEZ3VkM0tN?=
 =?utf-8?B?enU4ZEFZSElwOUdBUnRUdmM5VEhhQjBrdjZGOWNDNDVERDRVclNzOEZSY3FF?=
 =?utf-8?B?UlpXVVppdmRZQ1ZPY1lFenovcTJyRS9vNVN6RURPNVprbUxBWTRqZ3pvUTcv?=
 =?utf-8?B?SjVEMHFEYUxHRlRtYTYxYUM3R2pWMFRiZlZmZVRNVFdVdG9zanNtckl4cnpH?=
 =?utf-8?Q?IIDELq9pOtzHan6sJ9lNUvp+5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b79ffa02-12f7-436c-e5f1-08dc22753ad4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 15:56:47.4630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tuo2w8f/gh87TaarA1h10JglhjvRr4O20oI99T8aBkwMLR3FYB2g806osfa8Q0Lc8Lu01x9aheJaHHUEC6e+YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6529
X-OriginatorOrg: intel.com



On 1/30/24 19:22, Wonjae Lee wrote:
> On Fri, Jan 19, 2024 at 10:23:52AM -0700, Dave Jiang wrote:
>> Calculate and store the performance data for a CXL region. Find the worst
>> read and write latency for all the included ranges from each of the devices
>> that attributes to the region and designate that as the latency data. Sum
>> all the read and write bandwidth data for each of the device region and
>> that is the total bandwidth for the region.
>>
>> The perf list is expected to be constructed before the endpoint decoders
>> are registered and thus there should be no early reading of the entries
>> from the region assemble action. The calling of the region qos calculate
>> function is under the protection of cxl_dpa_rwsem and will ensure that
>> all DPA associated work has completed.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v4:
>> - Calculate access classes 0 and 1 by retrieving host bridge coords
>> - Add lockdep assert for cxl_dpa_rwsem (Dan)
>> - Clarify that HMAT code is HMEM_REPORTING code. (Dan)
>> ---
>>   drivers/cxl/core/cdat.c    74 +++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/core/region.c     2 +
>>   drivers/cxl/cxl.h            4 ++
>>   3 files changed, 80 insertions(+)
>>
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index 6e3998723aaa..7acb5837afad 100644
>> --- a/drivers/cxl/core/cdat.c
>> +++ b/drivers/cxl/core/cdat.c
>> @@ -8,6 +8,7 @@
>>   #include "cxlpci.h"
>>   #include "cxlmem.h"
>>   #include "cxl.h"
>> +#include "core.h"
>>
>>   struct dsmas_entry {
>>   struct range dpa_range;
>> @@ -546,3 +547,76 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>>   EXPORT_SYMBOL_NS_GPL(cxl_coordinates_combine, CXL);
>>
>>   MODULE_IMPORT_NS(CXL);
>> +
>> +void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
>> +                struct cxl_endpoint_decoder *cxled)
>> +{
>> + struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>> + struct cxl_port *port = cxlmd->endpoint;
>> + struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> + struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>> + struct access_coordinate hb_coord[ACCESS_COORDINATE_MAX];
>> + struct access_coordinate coord;
>> + struct range dpa = {
>> +        .start = cxled->dpa_res->start,
>> +        .end = cxled->dpa_res->end,
>> + };
>> + struct list_head *perf_list;
>> + struct cxl_dpa_perf *perf;
>> + bool found = false;
>> + int rc;
>> +
>> + switch (cxlr->mode) {
>> + case CXL_DECODER_RAM:
>> +    perf_list = &mds->ram_perf_list;
>> +    break;
>> + case CXL_DECODER_PMEM:
>> +    perf_list = &mds->pmem_perf_list;
>> +    break;
>> + default:
>> +    return;
>> + }
>> +
>> + lockdep_assert_held(&cxl_dpa_rwsem);
>> +
>> + list_for_each_entry(perf, perf_list, list) {
>> +    if (range_contains(&perf->dpa_range, &dpa)) {
>> +        found = true;
>> +        break;
>> +    }
>> + }
>> +
>> + if (!found)
>> +    return;
>> +
>> + rc = cxl_hb_get_perf_coordinates(port, hb_coord);
>> + if (rc)  {
>> +    dev_dbg(&port->dev, "Failed to retrieve hb perf coordinates.\n");
>> +    return;
>> + }
>> +
>> + for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
>> +    /* Pickup the host bridge coords */
>> +    cxl_coordinates_combine(&coord, &hb_coord[i], &perf->coord);
>> +
>> +    /* Get total bandwidth and the worst latency for the cxl region */
>> +    cxlr->coord[i].read_latency = max_t(unsigned int,
>> +                        cxlr->coord[i].read_latency,
>> +                        coord.read_latency);
>> +    cxlr->coord[i].write_latency = max_t(unsigned int,
>> +                          cxlr->coord[i].write_latency,
>> +                          coord.write_latency);
>> +    cxlr->coord[i].read_bandwidth += coord.read_bandwidth;
>> +    cxlr->coord[i].write_bandwidth += coord.write_bandwidth;
>> +
>> +    /*
>> +      * Convert latency to nanosec from picosec to be consistent
>> +      * with the resulting latency coordinates computed by the
>> +      * HMAT_REPORTING code.
>> +      */
>> +    cxlr->coord[i].read_latency =
>> +        DIV_ROUND_UP(cxlr->coord[i].read_latency, 1000);
>> +    cxlr->coord[i].write_latency =
>> +        DIV_ROUND_UP(cxlr->coord[i].write_latency, 1000);
> 
> Hello,
> 
> I ran into a bit of confusion and have a question while validating CDAT
> behaviour with physical CXL devices. (I'm not sure if this is the right
> thread to ask this question, sorry if it isn't.)
> 
> IIUC, the raw data of latency is in picosec, but the comments on the
> struct access_coordinate say that the latency units are in nanosec:
>  * @read_latency:   Read latency in nanoseconds
>  * @write_latency:  Write latency in nanoseconds
> 
> This was a bit confusing at first, as the raw data of latency are in
> ps, and the structure that stores the latency expects units of ns.

Right. The numbers stored with the HMAT_REPORTING code and eventually NUMA nodes are normalized to nanoseconds, even though the raw data is in picoseconds. For CXL, I left the CDAT and computed numbers as raw numbers (picoseconds) until the final step when I calculate the latency for the entire region. And then it gets converted to nanoseconds in order to write back to the memory_target for HMAT_REPORTING. The numbers we retrieve from HMAT_REPORTING for the generic target is already in nanoseconds.


> 
> I saw that you have already had a discussion with Brice about the
> pico/nanosecond unit conversion. My question is, are there any plans to
> store latency number of cxl port in nanoseconds or change the comments
> of coords structure?

The numbers for the coords structure will remain in nanoseconds as it always have been. 

> 
> Thanks,
> Wonjae
> 
>> + }
>> +}
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 57a5901d5a60..7f19b533c5ae 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -1722,6 +1722,8 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>>       return -EINVAL;
>>   }
>>
>> + cxl_region_perf_data_calculate(cxlr, cxled);
>> +
>>   if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>>       int i;
>>
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 80e6bd294e18..f6637fa33113 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -519,6 +519,7 @@ struct cxl_region_params {
>>   * @cxlr_pmem: (for pmem regions) cached copy of the nvdimm bridge
>>   * @flags: Region state flags
>>   * @params: active + config params for the region
>> + * @coord: QoS access coordinates for the region
>>   */
>>   struct cxl_region {
>>   struct device dev;
>> @@ -529,6 +530,7 @@ struct cxl_region {
>>   struct cxl_pmem_region *cxlr_pmem;
>>   unsigned long flags;
>>   struct cxl_region_params params;
>> + struct access_coordinate coord[ACCESS_COORDINATE_MAX];
>>   };
>>
>>   struct cxl_nvdimm_bridge {
>> @@ -880,6 +882,8 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>>                     struct access_coordinate *coord);
>>   int cxl_hb_get_perf_coordinates(struct cxl_port *port,
>>               struct access_coordinate *coord);
>> +void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
>> +                struct cxl_endpoint_decoder *cxled);
>>
>>   void cxl_coordinates_combine(struct access_coordinate *out,
>>                 struct access_coordinate *c1,
>>
>>
>>

