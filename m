Return-Path: <linux-acpi+bounces-10818-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 413FDA1BC80
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jan 2025 19:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C02603A54AA
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jan 2025 18:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F181DA2F1;
	Fri, 24 Jan 2025 18:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YCX/pg9K"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED591D54D8;
	Fri, 24 Jan 2025 18:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737744845; cv=fail; b=VTMV9XNf/58M2UFaK+pBOUwp/La2eaTnH1reMkcA5neRkCQaynwgJVWUNlrK9fNAR0Ot9Dnu1FqvEj+eN4isH1/9UE97K6Onbv2vXppWdpeB9BUkYgTy3VWm/OC2W2xAFmyI5thU8rPhxwFJk3JuIfW+Gc7+c7MqUcazEfUIRl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737744845; c=relaxed/simple;
	bh=a8O0Xi7ZGiEIvrLpS9CSnqLKxvRUYNi+O6tcNjXwwRk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iSxdhxBzrgkYOokGH88XRTzXs0ruhQVy7fCIElReQPEAIIvgTh2xZmP+XWwns1I6TyIZIJW2xC6noyIVD3j/wAKZZkAsR3H4xvWmzdh5Kpvf6f3YIfRHBmkWxMt4a5tmiO0xh3IfLj9ZeRPh2zznD2aqkS17GuXHCltlEIIPlRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YCX/pg9K; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737744843; x=1769280843;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=a8O0Xi7ZGiEIvrLpS9CSnqLKxvRUYNi+O6tcNjXwwRk=;
  b=YCX/pg9Kbk7K5mKfU13OKzYj+F35+jqHdZCRUBPnPNtIeLLVHzwhGN1Q
   OHp6JheUzORXpKe3Fi2UmG+9qVV32Yu78MpPjpYX0HEdDpAPultlbGUH8
   9TgA19XQJ9oXWWJTiKvBoUuVzFTK76eaLPZhhsBIUCVlXgkqOjJO/2yLy
   AkTcPFhYJOUX9aPTXcqGdMTUhQqTY/wOpBLecXkHuZ4mRxYFNGJdp2Bd9
   A0slABGsAEu9wHn+oT5wlOhoI8SdfM6koDO43JFTeg8a9D3E7J9vCt5sG
   tcQRkxC3hMq02bDEmvnPvNKLu8Z1pSPrSyaL5rGGHgm8/JTwWSQwzn/mf
   A==;
X-CSE-ConnectionGUID: MuLRZW2IQWuJ5URyaFydsQ==
X-CSE-MsgGUID: 4j8bQaGfRn6r/C3f5I71jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="42219079"
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="42219079"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 10:54:02 -0800
X-CSE-ConnectionGUID: DXJhabY5QmGDw4dbJmOZbw==
X-CSE-MsgGUID: MOqYvBy6SaeVvwx0ZjZS/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108283742"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2025 10:54:01 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 24 Jan 2025 10:54:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 24 Jan 2025 10:54:01 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 24 Jan 2025 10:54:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HwgbbgLJgh5BFD065s6UbDYY6pYSDTk6nLGyitrtOlr2eg6qSY4h9dxVC5Y6cE/qC3shZhe2QYqVXLuQpsRXNcsTEfJ7XtiKUmMjr0UCbWmSPoG1OfSeCTQbtgJ8nY4MuJx41/4WwoVQffvBczlCSJ/Wl2bwSAB7QZPAPG6PtwhxOu5huCOw3/2Ls0KwbwYVE/xyNOtKHPxdOnIWFwOkicXMSUvhqKsbe8ZmRWZk53lj8yNaeAXmnyC6mzDVotlSZETC0IVceCd+Y5Gr+XSV7UNULS6psUAOYEImGvx9iRb50aKCQrP8+0XixYWY0R/Y535IEujDFz29322FGAI3ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6qwraxRvW6IhGbNm0ZS+mtIOnTfnosJVjFtqgmdjAE=;
 b=WSDxXWSB1Ra7/dobQUnaS6NNFrAgq7+PEvnoH13pF4O8p/BoovxFc3hYP/E+YIiGxNyY5T7lxUAiJ5jXzHBahx+aQ5Pvl2sYNWuOv4qD5+wk2hixZ/GPzUH+OVuj9KhiMfe77iKPAsrcXXWukXDLysV6anjAHCTzAaFXwvKsLPLU3v3fX+fp69B0a8N/zL/C4UVvfW0zW9152464Ggp2S6h2rwOG7kEnXUdWwQ11wUNwvykNE6tPDpzYdSwcHqmSUoC5Z7GX82BA2XhpothX5AxPXtTlW5GheBsKDDwqn5e8Bco90nrtsyQMHB97YCBSQdA6RXWHp7iNIKDjFTMaHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW4PR11MB5890.namprd11.prod.outlook.com (2603:10b6:303:188::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Fri, 24 Jan
 2025 18:53:13 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 18:53:13 +0000
Date: Fri, 24 Jan 2025 12:53:08 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Murad Masimov <m.masimov@mt-integration.ru>, Dave Jiang
	<dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"syzbot+c80d8dc0d9fa81a3cd8c@syzkaller.appspotmail.com"
	<syzbot+c80d8dc0d9fa81a3cd8c@syzkaller.appspotmail.com>
Subject: Re: [PATCH] acpi: nfit: fix narrowing conversion in acpi_nfit_ctl
Message-ID: <6793e1945e9f2_9caff29489@iweiny-mobl.notmuch>
References: <20250123163945.251-1-m.masimov@mt-integration.ru>
 <649ed1bb-0686-42f0-802f-9f1909aeed8c@intel.com>
 <741f409ae5be4f1f9b62d9223f026e26@mt-integration.ru>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <741f409ae5be4f1f9b62d9223f026e26@mt-integration.ru>
X-ClientProxiedBy: MW4PR03CA0247.namprd03.prod.outlook.com
 (2603:10b6:303:b4::12) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW4PR11MB5890:EE_
X-MS-Office365-Filtering-Correlation-Id: c147838c-5f09-4232-b33f-08dd3ca85abf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vzh3Z1VZRUdxdmc1Z04vTzdhQ296VFltLzJ1N0RDaTFjWll1UkRrR0RpUmpF?=
 =?utf-8?B?VlNwaDEyT2JIYlk3dWNHSE93K2tyYUF5bmlxNzRjSDUzcXZFbERiSGxtVWxY?=
 =?utf-8?B?Y3dCYlg0L3Y1SklNZEpZZ3IyVFFaYWc1bUxnV0lPeHl5TXEyREE4anBZdEpO?=
 =?utf-8?B?TkhZeWJ1bVFUU1I0QWVvNjNVczFsNFc3dzFINDMrRWt5TDQzbEl1MnhoOGww?=
 =?utf-8?B?RCtXNXhmNkd0bmthSjVtTTc3MGd2R2kxd3l2MTc2aWRlbkZncFVBZkQ1ZDhD?=
 =?utf-8?B?VVpURE9ZVXIyM1lJZTNaMGxLYmFSYWRvSmNMdUZ1Zk1rRkVSZ0htaU1ZWklV?=
 =?utf-8?B?SmI5MlRISTVFR2pBOWhla0E4alY3OHFDcENWUWdCdkdvZThMMVJZeTB3RUFq?=
 =?utf-8?B?TjhFU3d6eUJ5MHlKVC9xOHZ2bWo3ZGJMR0E5M1Z0ZExudVZVRWpuVEttV0w2?=
 =?utf-8?B?ZFg0NThPVC9uVGZTcHVORGNJYnNaazVsck9hMzAwYzVuc0RNbnNiRGFXSTV2?=
 =?utf-8?B?WnRQS1JFTHhKeVNOV01IakVFYkNxVlNSNGY3QlY1TmJ0dEo4dWZOYk1DWFRJ?=
 =?utf-8?B?K1RGVjNLQlQyaUJiUEUrRzdaUWd6b2hEVElGUU5FMVZpQU1vbVAwblhZK3Yr?=
 =?utf-8?B?Sm5NQkl4VmtFNkV4SDlMbi90UlJVLzl2ejNYaS91UkxIZEVCbnNySFF2VWFF?=
 =?utf-8?B?YmhteDhnVFdtaFErUTlkVmF2UVNLVUJacldzaHZpaVRIb2x1MkcwSWtwQnlU?=
 =?utf-8?B?T0JyWjZacU9ENWFWWmxkRUNaMXlzMG9wZGFjOFU2VWoyVHpOMThUSGRZUVUz?=
 =?utf-8?B?anVPM2ZyTmtGbmJYNWdwSGI0d09MWWFubnVhZ0dIcnlyVDY0djNZdFlpNW5G?=
 =?utf-8?B?TzUwTFZSRFN4SWRRK3VObm1QTGpvaDluNDJaclNLL1FtMnBWaTRQR3BiMWRr?=
 =?utf-8?B?TFFhOHp3Sm8ycytsQ0N6Z3NlRnZRT1l2VlRub3hpaXp0Ykk0elpZMElHL2ZH?=
 =?utf-8?B?ZlVQbkxyRXFtV0xzaEVEMllkRHhXKzNORTY2WlJLODRnV0RWbXhqZ3VocC84?=
 =?utf-8?B?N0tPT2FienNCSDlhYU8rYnRiZG5IQlZsVjlSUDBnM2VZSUJUMmNmR2NpNGFm?=
 =?utf-8?B?cFN3dUZvZ3BCMFlaWmdWaHA0ejFqOUNhNldEbnFxTUNyakVRSFFqNlVMS1Fa?=
 =?utf-8?B?OFY4b1EvSlgwaGZsRXNzcXZ4OFVneG45TmRyS3pNeENIaVgyQllSTWVUYjIz?=
 =?utf-8?B?eWZUSWlwOXlyeGZYREFCWEVoaVZibmpLMzA5cGpXcmVuZHpWY0FXdHh4S3Y5?=
 =?utf-8?B?YmJweG5FYXEybkZrdXZ2Q1JRcnRmNjkzWW1MODBtL3g0TWJhSksyTGNiVGRZ?=
 =?utf-8?B?SG9pSVpUMldsOVU3T1dVYmw2YTVQU201bE1iNnIxVWthNnpXS1UwZHhMcDVM?=
 =?utf-8?B?ajNxcUJkS1lPb1lQeDcxdUFDWXhObkRPcktvK2ZtRXA0SjhZWnQybERDbng5?=
 =?utf-8?B?YW9ENEZSSHBPWEtndkRmcUovZEZYeG1XeEFPZlZLc1VhM3BTY3NQdUhBT2VZ?=
 =?utf-8?B?bE5kNWlxbmlQTUt2M29xVHltcWhxMHA2a2srZFJ4WlF2bGpWUTU3akxEWXhW?=
 =?utf-8?B?dVo2ajhkUTdJaXdlcFp0Yndya3Q1VHJMOVdUVjZzQ21zSzlncnB4TmNQdkFz?=
 =?utf-8?B?aWprYXZOMmptSVY1SE9OTXNraHRTM3NITUY4YmFmcExtZEo4QkVIbVpJK3pq?=
 =?utf-8?B?S1Zwek8vZVJJU1VpOThnaVRPTFJ5TWxhVU9yNHhEaDhTUlQ5cHZ0K2N4bDBN?=
 =?utf-8?B?Q05Xb1V6VkpnQ3pORGN6Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHZUYmpXTEROcjhUZlVORFhNZGlaTG0xOVRzNk5LZ2Q4U014RTBKU0dPRWRO?=
 =?utf-8?B?TUtTSnZpUk9PbEp5SEVtL2drODQ0MmRzZnJTNDdoYXQyR1hQMTRwMTQrdVJn?=
 =?utf-8?B?TTFLSUphcWMwNEtJUjFSdVdzRGhUeXdzY0xyVGNOakRwbmJtWHBVU21JT003?=
 =?utf-8?B?RmI4a3N2R1VGcGI2cWhYUXhTT2RxNmlkcjNWRnNiT1FHR2M5aXJKRnBqbTFU?=
 =?utf-8?B?Smd3MERISHE4VFVQQnVNYnluVUNkTkU4WGhOYnRkVEc2ZUhQL25PNjgzMTZm?=
 =?utf-8?B?SDhlWXRSWkMvbXlYa3ZiRE9JNWtqa3dHc09LamllMkhDbmRva0lOMUMwM1FM?=
 =?utf-8?B?Q2VQdmIvMVVYaXprNGNsM2JQN0hvTFRYT1ZzcDlwVHFTYzFld2psVEFaaEgw?=
 =?utf-8?B?YzNabkZXc0xtMlZkd0hKQWFDL3dZQnFsejNSbmNDa0RJVG5Oa2tRVDgvdW5s?=
 =?utf-8?B?eFZkNXNGWERhRG5aMFc1eHJRZUhiTTZLWGJnczN1bUljaUdFOFRURVFWbFlZ?=
 =?utf-8?B?emlVazdxc1lTUVcxeldidjNYWWwwZGp0SzkvaVViRjJLUWNJcXJ4dTlnTmIv?=
 =?utf-8?B?OWJ5d1B2REsrTVVQelQ4VHNWOXo0bUc2MDhSVGM5ZVdrNUwxK3pUb2IyUm1O?=
 =?utf-8?B?UnFBeW90QzkvSnVEay85TFFnOVRVRTZWa3lNdjhqaTJteHFiN3d0SHZ1RzJQ?=
 =?utf-8?B?MkZ2Y290RHk1dGVJU2lqaVhxNWtzQzBmNjVIU0huOWY5c3ZwV01oeFZwakhS?=
 =?utf-8?B?Z3BmL1pJLzc2VUlCT3ZXSnA0NmMwaUZ4blN1U2phWWdFTm0wdVF3SnZCZXls?=
 =?utf-8?B?NXhDdjM3eWZraGIwckVGM2c3cWtnOWZJNXFqRzgxYVpUUUQ0YVVIUS9HcFRD?=
 =?utf-8?B?UGFSMVphTkF3YWh2SXBPTkEwbVhwQ21KcExzVldvVURoZDREb2tWODIvY2NR?=
 =?utf-8?B?a2hZcmJNNWIwZVBISlgvclMwdk11RXhQb0trZDQrNkszSldybUcvWUNmMHVY?=
 =?utf-8?B?K2hvTlhDZkxPcWo0QitpWE5BOGY1WVNMclp4d3pEek1MWS9sWnd1aTNrUG13?=
 =?utf-8?B?bUlENE0zL0dGWVBYZGVkbkh3UjJ2QVd1L0VFSmdpRk1oMVRpbERLVkcxMEhk?=
 =?utf-8?B?NmxOSHp2TmYvcGNuN0twOXk0TE9ZTlNkbHI4bEJvTUU5c0w1K0F3eGRHR3h3?=
 =?utf-8?B?QjNPMWRqNldMRHh3aUE4THhUVHJyRElzY1RhQjAvaEY4c091MWtKa2NTcEtm?=
 =?utf-8?B?MU9WTFpCamVvUWkrT3Jjbm1FNFcxVDlHQm1WOFZDcVE5UlpXamQ2WlBETnh6?=
 =?utf-8?B?Q1BIVW1TdnZvL0liQ3poenQyUEt0RWdvL2RjM3JMQUZQZ0h4MHdZU1dnZmZi?=
 =?utf-8?B?VEdnU3FiZHFRelBVbjZPZnhma2lwRFFBeXVyYUU1Z3kwSzZRT3NjYnVyVUkv?=
 =?utf-8?B?OWsvdnN1dWM3NDRDMUY2RGNuMWxKMkhyK3RwYTVNc1ZsZWtUUVdWZHF1VGlI?=
 =?utf-8?B?VytVd3Y1aERBemhDK3E1TXl0anR3d2VBWkxGVmJYRGNhWkVTNE1SVUpBeWdZ?=
 =?utf-8?B?UE1qSHJMNkJjNnpZS3lVcXBtUmoyU09aSUx4dmpvTS9oNWIzdEdTV3BsUnV6?=
 =?utf-8?B?VHd3YkVYKzVsTHNxTHJaQXBUdWF0SmdzRTIzSFVGVCtqTU1XZ2doQi9nYnZJ?=
 =?utf-8?B?NHNaQ0x0cTlVWkRmZG5kRUhIdWkwNHpYcXdDeVRoaUVOSkMxanlpM08wZ1BC?=
 =?utf-8?B?WDdEV3ZMYzN6cVBrdHpPa1NTSE00RkVyOFVVbEx2QmhKSkJWM3E3bG5zdFBn?=
 =?utf-8?B?Z24yV2NONUtSVGhpUnBoN1hxTHdUVU5UMy9JSEV6SHNKN0JlejIyYXcrZll5?=
 =?utf-8?B?WXBQazdhYSttaWZuMXlRWnNSSFNZYjh1cmhrQmt5UmplNDJSSzRHeDBTVWtN?=
 =?utf-8?B?ZnZGQWMxbWM0Y3g4Q3ZoS1cxdlZjSXpRclBIL0tvNDgvNGZCSTh1elNocTZy?=
 =?utf-8?B?WGFBbXRmNDhNRmJ1QTlHWVJQbG5VVzQrZGM5NEVJN3pLdmFwa25vZUJEK291?=
 =?utf-8?B?WVljNjZrYkh0QU9CQTRyMnJ1VlovdUNrOWhRazZsNDVmQ2E2TktWUDB5WEJM?=
 =?utf-8?Q?ODjVzhco3KfBZTBgBIgOHIXmR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c147838c-5f09-4232-b33f-08dd3ca85abf
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 18:53:13.3036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LU95RkePPvC5nST9DwbWckyqfJ0WbCvs3rz53bFSpzwQ5F82RbhhHomxH1QSQPB9LCDgyZWzv9cAazliZM1M1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5890
X-OriginatorOrg: intel.com

Murad Masimov wrote:
> 
> ________________________________________
> От: Dave Jiang <dave.jiang@intel.com>
> Отправлено: 24 января 2025 г. 2:43
> Кому: Masimov Murad; Dan Williams
> Копия: Vishal Verma; Ira Weiny; Rafael J. Wysocki; Len Brown; nvdimm@lists.linux.dev; linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; lvc-project@linuxtesting.org; stable@vger.kernel.org; syzbot+c80d8dc0d9fa81a3cd8c@syzkaller.appspotmail.com
> Тема: Re: [PATCH] acpi: nfit: fix narrowing conversion in acpi_nfit_ctl
> 
> > On 1/23/25 9:39 AM, Murad Masimov wrote:
> > > Syzkaller has reported a warning in to_nfit_bus_uuid(): "only secondary
> > > bus families can be translated". This warning is emited if the argument
> > > is equal to NVDIMM_BUS_FAMILY_NFIT == 0. Function acpi_nfit_ctl() first
> > > verifies that a user-provided value call_pkg->nd_family of type u64 is
> > > not equal to 0. Then the value is converted to int, and only after that
> > > is compared to NVDIMM_BUS_FAMILY_MAX. This can lead to passing an invalid
> > > argument to acpi_nfit_ctl(), if call_pkg->nd_family is non-zero, while
> > > the lower 32 bits are zero.
> > >
> > > All checks of the input value should be applied to the original variable
> > > call_pkg->nd_family.
> > >
> > > Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> > >
> > > Fixes: 6450ddbd5d8e ("ACPI: NFIT: Define runtime firmware activation commands")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: syzbot+c80d8dc0d9fa81a3cd8c@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=c80d8dc0d9fa81a3cd8c
> > > Signed-off-by: Murad Masimov <m.masimov@mt-integration.ru>
> > 
> > While the change logically makes sense, the likelihood of nd_family > int_size is not ever likely. Given that NVDIMM_BUS_FAMILY_MAX is defined as 1, I don't think we care about values greater than that regardless of what is set in the upper 32bit of the u64. I'm leaning towards the fix is unnecessary.
> 
> Thank you for the review! But I believe there is a misunderstanding. The
> point is that the code fragment affected by this patch is intended to
> make sure, that family is in range between 1 and NVDIMM_BUS_FAMILY_MAX.
> This is necessary because call_pkg contains user-provided data. However
> the implementation of these validity checks is erroneous and leads to
> passing an invalid value. The syzkaller report proves, that this bug can
> be triggered by a user. Here is an example to demonstrate, what exactly
> happens:
> 

I tend to agree this is not ideal.  But IMO the issue is that family is
treated as an int throughout the code rather than u64.  Even u32 would
have been better than int because negative numbers are not allowed AFAICT
just skimming the code.

Unfortunately, ripping through the code to change family to u32 is
probably not worth the churn.  I'll think on this but I'm tempted to apply
this.

Ira

> 1. Let's say call_pkg->nd_family is equal to (1ull << 32).
> 2. Expression (cmd == ND_CMD_CALL && call_pkg->nd_family) evaluates to true.
> 3. Since family is of type int, and call_pkg->nd_family is u64, assigning call_pkg->nd_family to family will lead to a narrowing conversion.
> 4. As a result, family equals to 0, which will be passed in to_nfit_bus_uuid() triggering the warning.
> 
> Moreover, family may also be a negative integer (e.g. call_pkg->nd_family == ~(0ull)). This can lead to an undefined behaviour in test_bit() and potentially out-of-bounds in to_nfit_uuid(). Thus, even if triggering a WARN is not concerning, the bug still should be fixed.
> 
> > > ---
> > >  drivers/acpi/nfit/core.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> > > index a5d47819b3a4..ae035b93da08 100644
> > > --- a/drivers/acpi/nfit/core.c
> > > +++ b/drivers/acpi/nfit/core.c
> > > @@ -485,7 +485,7 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
> > >               cmd_mask = nd_desc->cmd_mask;
> > >               if (cmd == ND_CMD_CALL && call_pkg->nd_family) {
> > >                       family = call_pkg->nd_family;
> > > -                     if (family > NVDIMM_BUS_FAMILY_MAX ||
> > > +                     if (call_pkg->nd_family > NVDIMM_BUS_FAMILY_MAX ||
> > >                           !test_bit(family, &nd_desc->bus_family_mask))
> > >                               return -EINVAL;
> > >                       family = array_index_nospec(family,
> > > --
> > > 2.39.2
> > >
> 



