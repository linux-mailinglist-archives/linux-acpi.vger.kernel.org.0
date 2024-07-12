Return-Path: <linux-acpi+bounces-6867-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF80B92F935
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jul 2024 13:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33591C21F1B
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jul 2024 11:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F60155C81;
	Fri, 12 Jul 2024 11:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qu/Pxr6V"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61234145B09;
	Fri, 12 Jul 2024 11:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720782111; cv=fail; b=IkoPh7qdkrIVZxTqjg5sz/b5KtwfrULeZLT57ISzBiJvhEXncsMnCp/rllZT26BWN6SrHKsMux777fuEhnViMf+VVQV+lsH2nx111TDI192KabFireRxJw9E8UgkWY4AZbkYOwrF7bCXWPk6qZwP+touSxRK6UdVQOe6jQuVQJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720782111; c=relaxed/simple;
	bh=vWdvfRsg/E3nXcMnS8DzIPnjU0TW+opAZf0+lU6IpRM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=auYMV5G4EQBEi+npeOm2M8Skm8y1yieGcBoFNXUMncZizjFMrlHXufdJADarkyfd6OROa1319m0sFNxh+KyJ3TtbsLsYk7CDHKrapGIFNO/Eo+LLCLbkzWhSGVVibCO0KszU2L24uZyophKsShYbn3CI1XDraSR3SCgjOw2wdSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qu/Pxr6V; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFl7rEaU6boVDhrNmafAiuteFo1m5CU/K243q10an60vvM/25SylQHJaCFvgm/ypsVPbpBnGTmGH4ADhvzJCNiwDOfIkRxxjAH61w3JLi/AFS1K0wcPbPHrS5MEg30er7gLNBqHUa+8FQJJ1522X0elH6HW0AlqC4aj69w55V6mNP+p1NEfGaGM/QOA78gae8CuPHZcXUGvTWo930lguq7iN+U2oRMCUpRyjPQOrUddebFyhdfBjRRSl/mHFizT+hdyRrYHZR/JUcjmk+9F0WeABO3tfrLtYZ1WI9YMJ42Bg8mR4K8gPemee8xrL6l3ty30QRhGZWt8yM31ihajJfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNm6bc0NP/rklWxUDoDBPMbgrEzxFgXVGXR0b0fpb0A=;
 b=RCIqhyTAlrMsoiAADG53ftxcXng0bpQydirn6pOinOLQUbPVtbcp4BxQwj2+/94Yv0ncbNIeP9OUbi6P6cXqA2jpcUQ8gGwzOEN7P9BpyLiV28rHUbpCG4yBjdC7d0RmS4pnEwtV6214WcFO5Qc0mtFK4Tp96iI4oU1e6PUj5xfC/OJSCatmdUqB8hI0k1kuNtZugx9itShI3HJaJvRp0ooL1fFRw/mNv7EDAH2Bwl2RLnvTyNZISzqWMCnODyGlpRdwDXhKwMqdEBz3ZcSpbyp47XLyZDnr5/5bYEtpUJcNa1kAsxCEGmxgil4g+fxY3Q8ABtsv5g8nsqSkjw6tzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNm6bc0NP/rklWxUDoDBPMbgrEzxFgXVGXR0b0fpb0A=;
 b=Qu/Pxr6VlDr5oQqzonjSf+Je2weF1tnIdfzppLPgp3IEmXJUxFzOBbJpM4jAxWV/u+RcdcKo3JtR4bE7fzcokwdQu6DbvhfAZ8nqNlwOmDkVd3+TRX6fOxEPlw4YJJTYvhmnAwPRRwqGxY9VVn1tbKPCaTCTTL0MBg2HeFAb24hU5wB7JgaV6Csn8MUbuoASRxrOBWVIYiYS0Qc0UVlmjvON0TCbAzEDuanXPIiFkmim7le4syj6oeYgiLb5dfrBmgvAb2F+CBN1IUujknl2hQ2Ye506Gptn7bw5bUFsUs8vrDU+v1Afc0w1RgZ1SnkKOyiuPuGXyFOk1txnKSSSWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DS7PR12MB6190.namprd12.prod.outlook.com (2603:10b6:8:99::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.21; Fri, 12 Jul 2024 11:01:45 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3%6]) with mapi id 15.20.7762.016; Fri, 12 Jul 2024
 11:01:44 +0000
Message-ID: <0eec5f84-6b39-43ba-ab2f-914688a5cf45@nvidia.com>
Date: Fri, 12 Jul 2024 12:01:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] iommu: Resolve fwspec ops automatically
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Yong Wu <yong.wu@mediatek.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <cover.1719919669.git.robin.murphy@arm.com>
 <0e2727adeb8cd73274425322f2f793561bdc927e.1719919669.git.robin.murphy@arm.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <0e2727adeb8cd73274425322f2f793561bdc927e.1719919669.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0162.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::20) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DS7PR12MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: 239126b5-1712-49f0-4051-08dca262043e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VC8rbUR1dEpZSWxuczlRZDZyRXd5Mjc4cE9Rem9HSVJaVkFrZXFObGJ6d1ZO?=
 =?utf-8?B?WGFob1ZmZHd5MU1tbGhOQVNvUUJCOWZZMjNXRTNwQXp6V0RCV2V2VTI1cklK?=
 =?utf-8?B?elZiR3dVd2MxbHFTSEJBUWVwMmFmY0J5SkZ5U0RKUWJQUUdIVTViZEJJV1VZ?=
 =?utf-8?B?MG9nTnpoWHFqSmFHWHRpUkl1d0Z4UFFzd0RUeGVxZFdnVE5LNGxoczI0bzBa?=
 =?utf-8?B?bFhxTUsxVEhtVzVqOEdiQ0NQaFZRRjBjTmg4TDcrcDgySmJTcnZJR3k2ZlEy?=
 =?utf-8?B?eDFuazVuMFRVTDB2MEN3bFdNWHI3QzNwZmJKRzBEc2d4OUR2L1cvMG5SWVNp?=
 =?utf-8?B?VjlZbHJBWldhT2JHQzQrWHFEUUhqSWQxMEsrSFpVRWlnYVBncWdObm1oRTAx?=
 =?utf-8?B?WkNPUHRFbVEveXNZOGlrMndPRXQwY05qNGphdDF3QXEyYThPa3ZBUVBuT1VE?=
 =?utf-8?B?aEJuT1FrQ0NnQncvcGhZMFI1S2Z3emM2Y3gwdk5PQ1B4OS94b0tDZS95N1Zz?=
 =?utf-8?B?dld5anRYZHRkaTQ5Sm5LUTRTWG5SSkEvNFhTVHB6OW1Nb3BIamhGcC9pSS9B?=
 =?utf-8?B?eEtEVUYyRUJvTVhtZWNJaE9CUVJjbURVMlRYOXlCK1IzbzVsN2FMR3VrbXUr?=
 =?utf-8?B?QXdQampheElNa0pGZXpHc1dQTE03bXorR1NRMVplTUxIUi9aRmlFUmtFbW1R?=
 =?utf-8?B?RmdKaktUR3RJclpmbjRFSmtTdi9xZkRVamxJZy96L090aHUwQ1NaWEg2d2cx?=
 =?utf-8?B?KytkUE96WEV3dlZCVzIySWo1ZUtMR09scUVDOG5vL09MYkNVZkdOWWIzV1Zr?=
 =?utf-8?B?b0xWTWRTV2dndXV1OUZPZ1pOR3JqWWkzcFVUcEc0Q2JPRFpuSWt6eG1BWUcr?=
 =?utf-8?B?U0pydWw1czE4YlN2Y3M3RzlhQkgwdjAxdW9OcUo1YitiTFRWWFhEeXFtdGpa?=
 =?utf-8?B?d1FIaXNJWVEzN2N2U0FyNHVITC9ES285RC93N3hpRW9lVjN1dndxekRLSUNz?=
 =?utf-8?B?enVPeDllaW9NbDdKODRhVzhrNmxmMzc4bEZnZ1F4c0NCRzJ4WDF6bExCbSsz?=
 =?utf-8?B?SUxUZlJKdW4vRXNZbUo5amd2ZjZlODV6cXZ0MldiUTU4cVo5RFl0NTBJREV1?=
 =?utf-8?B?ckR3c2VjQjJpUlFGcXRDZHZlUCtJK3F3MnByUTQrMWVlakt4V0JKYVBtOW1X?=
 =?utf-8?B?cmRCTDhNa0JkRHpZZ0xibWN5bktCTVZRQVl0VEdXUGhjUVdydjRvRFFPdzFE?=
 =?utf-8?B?aG12dllvK1hvNkdwcDcwUHBjeEo3bFk4N2pNNGRvK3BjUFBhQVBiZi92QUR6?=
 =?utf-8?B?T3IwUUVuVERnMExPWnVQMEgrdU40TzhtaVIxcWUvMzl6OTV1NlI3MHJ4WVJi?=
 =?utf-8?B?VDFGOVhOWkRuQ0dEL2dhZkRSMEpWQkNWQWN6enNIMnVKN2hDT3lIVDFnUVVu?=
 =?utf-8?B?cUs1djgwdGx2QktGWmdsMWZhb2V1VWNEdU9kWHFMaG5icCtNQWZnZ3VlVGcv?=
 =?utf-8?B?NzZTVGZiOU5PS29kLy9ZeTU3bGREZ3U0NUhRQkFrUTIyTERFN3o0R2t4Qy90?=
 =?utf-8?B?ZEZ5TVVEQlYzL2J4YTQ3aTdIc1N5bmVQT3YxUFFsOGFxY2lwVmc4cXdNc1Fw?=
 =?utf-8?B?MFU0VEVoMTRsTlFGVlA5WDF3WmcxdjFZeDJWVldHNXBGei96NTV5WjhBWFhk?=
 =?utf-8?B?eXU0cnZrRkVIc1ExV0lQaWZMcDU5SHg3VnVidGhoMzkyRDlwcFJtcFZnWXZE?=
 =?utf-8?B?Wnl2L1RESDM2cGw2WVZnOEo4R2pNaXlEVW95TU9JR015aWVZT1RsRkt2NGxS?=
 =?utf-8?B?Z3E5azJ6eWVBaFF2Q0U5Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUZqVTRHMmhUZDMyb01YOHVNV3dPcFRNQ0k0Z3FvUnFOUkcxN0NnWURXZERs?=
 =?utf-8?B?cXk2Q1J0ZDhNcmNPZTY4N0FFakswbStyQVZJcnJ5YjE3cFhVblJMOVhhK0U4?=
 =?utf-8?B?d1lXSFMzZStRR2hHRkZ5UjFtVTRCTDJXUXpDa0NwK01TTGI3OWVsYjZqd3Fi?=
 =?utf-8?B?U2dDLzV1Z3B5ZHRKaU9WRG1XK0R4RUtDRUE1MDR1b21yS295b2haZ1VkY3Yv?=
 =?utf-8?B?TFdxZGhDKzNHaUd5TXdQdmtYYlZFa01MbWdJWFg5OGRSSlNGcURkbW1IVFRR?=
 =?utf-8?B?QTZDdHk0V0dCTGM3ZkpkSXhBaFFWYVhDRjE1czRvMnZOTGRoTmNoWEplZC8r?=
 =?utf-8?B?OG82NzRUNGk1bjN0MXJJTVNHaWZGVVpJdHJ2OXp3ZEdZcUsxczVmUWRMZUVr?=
 =?utf-8?B?UVFtMTVzMDUwOGtDMTlaMkZtRmJ3STVIeE5WT3hmemszZUl4MGNDMGZjWGhK?=
 =?utf-8?B?ZlBvOGU4S0NDc3pEUHFYdzl1Mkt4cysxK3A3R20ybTBSNTYvZ3VNZndETUFO?=
 =?utf-8?B?RnJQd0Z6T0ZJKzY0L2R1akZvRW5hZnA4bEw2WUxWRFZqU2V2ZVNFS0g0cFRp?=
 =?utf-8?B?bFlOWXcxM2hFTzJTUFV4UXFFQm13WkpPTTAyb2hDTDEyRkF3RllJeEwzdm9I?=
 =?utf-8?B?TTJacElKdTZzTHRlRXVzYU8vUmVud2Y2anlmMjdUWnczTzNmWC9JU1lqaVFW?=
 =?utf-8?B?cXJRZjZ3YXRYQy9tVnZtbDRRV0pJT1EyQUxWOE9oZGQwYVNUekt3RXVqNzEz?=
 =?utf-8?B?YU9QTkdFTFhYMWhvYS93OEVEV0YyOVFEZ2J4U2tLN01wYnQwL2xldnpEQTY4?=
 =?utf-8?B?SEpNSnA0ZUFnZnpiQkhwUFRkcEV6N0tTOEN1Z2JYdHgvZjZRQjIyRXg1MlRn?=
 =?utf-8?B?cnY5eUNaSkZWS255aVNsWjdjeUJoaURyZmYwZC91TnNwRnFOVDY5VFk1bWt1?=
 =?utf-8?B?U1ZPSm9tU2diK3Mzbi94K0R2UkRqL1NaOTVZTkxKcDZRQXEyWityK1hDWmxM?=
 =?utf-8?B?ZlVzdVZkUlhucHAya1llbXBZbld6a2J5N2tZb0U1cXhYTWppMGsxRGh1WHpn?=
 =?utf-8?B?ekl0VDZDRUUzMUJjTkJHdVhpQllTWC9FUEFkd1E5UlQxZXEyM0JwNXlTSmFT?=
 =?utf-8?B?djhUbWhSUGh3cTdNRmJwWTRGV1RiK0sweXA1Y0IwbnJqaEtPWW9mY1BxZUMr?=
 =?utf-8?B?aTdONFdtd1pZbjM1NXk4RUVxaWVKOEgrMWZxYitsek1zS2VYNEl6SFlCc1d6?=
 =?utf-8?B?eXYxL0E0emx6OVRjU25Pa1BTV3dGWnVGNERMbkQ0UGc0cTJuOFBBcFNvbDlQ?=
 =?utf-8?B?L2Exdm93TlpzdDFHakZVUmM2TDFybitpZTR4WkRBQjBiZGh3cEVqZWorT2RX?=
 =?utf-8?B?eWt6NHVqTHU4ZDNJOFkxL1lZaW5hY05NY1QyYWlvMmVvWE05MUpIZ1NTNm53?=
 =?utf-8?B?ZjlYd29qbmRNQklmWmF3SGlEZU9GR1RvOElCK1Y4ektLYklBYTNweVhPN2NU?=
 =?utf-8?B?SFBxRFEwdTFUcDVQRU1GQUlEbVF2TlF5SGtJTmVGNWx4M3N2eS9jdGlQS0t3?=
 =?utf-8?B?QnVBdnhxQ1daNWFZV0RZZHNZYndYR0p0Tm1lQUNMNjBOOTZYUCtlbWE4bGxj?=
 =?utf-8?B?TzRwdFpCWDhoaHRJQ0lPZHdTZmlMR1hhWmgybTFUUXpyanlmU21SWGNrbGlF?=
 =?utf-8?B?NnozTFRBYXBlcGdNMVE2VURySWJmdWo3QzRyMEM5TnRKZ2RLL2tWa2h4ZmV1?=
 =?utf-8?B?dlZaZC9kWjJMU0xiUDM3YnRhTDU5ck5rOHNrSkhSY2UxNnUxUGRBRzNLem5Q?=
 =?utf-8?B?cEtvb0JNNmFYVEw4Y2FkZ1BmTiszNVpxRGxlTjJrRGJ6OXljaTcrcWdhRURq?=
 =?utf-8?B?TkYyM2VTQzQveUw2SWt2cHRoSFF2RUgycDB1czhaNTVWc2VtazV4NTg0SGlI?=
 =?utf-8?B?ZjdFazJlVWRrU2lsWUh0cm1PVEV1bDdaSWkwTHk1K3FXTkhIMXN6TkJjSmhm?=
 =?utf-8?B?TVdpeUNNODNGMTBMNVlneDhOSjgvUWx0TVRuUVluZ0oxQld0dkVzaU54M1ZB?=
 =?utf-8?B?NkVWZ05ZQWxJZVg1Qm0ycjc1bzZxRnluQXU2VE1ZekpQY1lud081RXlXUnJT?=
 =?utf-8?B?aDJiUnB4aXJTQ1hybG9ub1JZUE5sa2l1LzBkeUF4dlM4Nmo4MzNjMEtTZE40?=
 =?utf-8?Q?xwK7AxHk+VpvZdmyXMtgCvjhGArqEitx2jAC+XWbDjik?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 239126b5-1712-49f0-4051-08dca262043e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 11:01:44.5924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bkc0OkF8SgCpBAZ+fgdyuS+DFgUa6G5AQx4KkT/xZ0x8hB6NJQ8XV9ENkAgJz8WWwmwR31NYv9xaFC7wpGnwDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6190

Hi Robin,

On 02/07/2024 12:40, Robin Murphy wrote:
> There's no real need for callers to resolve ops from a fwnode in order
> to then pass both to iommu_fwspec_init() - it's simpler and more sensible
> for that to resolve the ops itself. This in turn means we can centralise
> the notion of checking for a present driver, and enforce that fwspecs
> aren't allocated unless and until we know they will be usable.
> 
> Also use this opportunity to modernise with some "new" helpers that
> arrived shortly after this code was first written; the generic
> fwnode_handle_get() clears up that ugly get/put mismatch, while
> of_fwnode_handle() can now abstract those open-coded dereferences.
> 
> Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> v2: Add of_fwnode_handle() cleanup as well
> ---
>   drivers/acpi/arm64/iort.c             | 19 +++++--------------
>   drivers/acpi/scan.c                   |  8 +++-----
>   drivers/acpi/viot.c                   | 11 ++---------
>   drivers/iommu/arm/arm-smmu/arm-smmu.c |  3 +--
>   drivers/iommu/iommu-priv.h            |  2 ++
>   drivers/iommu/iommu.c                 |  9 ++++++---
>   drivers/iommu/mtk_iommu_v1.c          |  2 +-
>   drivers/iommu/of_iommu.c              | 19 ++++++-------------
>   drivers/iommu/tegra-smmu.c            |  2 +-
>   include/acpi/acpi_bus.h               |  3 +--
>   include/linux/iommu.h                 | 13 ++-----------
>   11 files changed, 30 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index c0b1c2c19444..1b39e9ae7ac1 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1221,10 +1221,10 @@ static bool iort_pci_rc_supports_ats(struct acpi_iort_node *node)
>   static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *node,
>   			    u32 streamid)
>   {
> -	const struct iommu_ops *ops;
>   	struct fwnode_handle *iort_fwnode;
>   
> -	if (!node)
> +	/* If there's no SMMU driver at all, give up now */
> +	if (!node || !iort_iommu_driver_enabled(node->type))
>   		return -ENODEV;
>   
>   	iort_fwnode = iort_get_fwnode(node);
> @@ -1232,19 +1232,10 @@ static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *node,
>   		return -ENODEV;
>   
>   	/*
> -	 * If the ops look-up fails, this means that either
> -	 * the SMMU drivers have not been probed yet or that
> -	 * the SMMU drivers are not built in the kernel;
> -	 * Depending on whether the SMMU drivers are built-in
> -	 * in the kernel or not, defer the IOMMU configuration
> -	 * or just abort it.
> +	 * If the SMMU drivers are enabled but not loaded/probed
> +	 * yet, this will defer.
>   	 */
> -	ops = iommu_ops_from_fwnode(iort_fwnode);
> -	if (!ops)
> -		return iort_iommu_driver_enabled(node->type) ?
> -		       -EPROBE_DEFER : -ENODEV;
> -
> -	return acpi_iommu_fwspec_init(dev, streamid, iort_fwnode, ops);
> +	return acpi_iommu_fwspec_init(dev, streamid, iort_fwnode);
>   }
>   
>   struct iort_pci_alias_info {
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 503773707e01..8d5a589db141 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1577,12 +1577,11 @@ int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
>   
>   #ifdef CONFIG_IOMMU_API
>   int acpi_iommu_fwspec_init(struct device *dev, u32 id,
> -			   struct fwnode_handle *fwnode,
> -			   const struct iommu_ops *ops)
> +			   struct fwnode_handle *fwnode)
>   {
>   	int ret;
>   
> -	ret = iommu_fwspec_init(dev, fwnode, ops);
> +	ret = iommu_fwspec_init(dev, fwnode);
>   	if (ret)
>   		return ret;
>   
> @@ -1639,8 +1638,7 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
>   #else /* !CONFIG_IOMMU_API */
>   
>   int acpi_iommu_fwspec_init(struct device *dev, u32 id,
> -			   struct fwnode_handle *fwnode,
> -			   const struct iommu_ops *ops)
> +			   struct fwnode_handle *fwnode)
>   {
>   	return -ENODEV;
>   }
> diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
> index c8025921c129..2aa69a2fba73 100644
> --- a/drivers/acpi/viot.c
> +++ b/drivers/acpi/viot.c
> @@ -307,21 +307,14 @@ void __init acpi_viot_init(void)
>   static int viot_dev_iommu_init(struct device *dev, struct viot_iommu *viommu,
>   			       u32 epid)
>   {
> -	const struct iommu_ops *ops;
> -
> -	if (!viommu)
> +	if (!viommu || !IS_ENABLED(CONFIG_VIRTIO_IOMMU))
>   		return -ENODEV;
>   
>   	/* We're not translating ourself */
>   	if (device_match_fwnode(dev, viommu->fwnode))
>   		return -EINVAL;
>   
> -	ops = iommu_ops_from_fwnode(viommu->fwnode);
> -	if (!ops)
> -		return IS_ENABLED(CONFIG_VIRTIO_IOMMU) ?
> -			-EPROBE_DEFER : -ENODEV;
> -
> -	return acpi_iommu_fwspec_init(dev, epid, viommu->fwnode, ops);
> +	return acpi_iommu_fwspec_init(dev, epid, viommu->fwnode);
>   }
>   
>   static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 87c81f75cf84..c200e6d3aed5 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -178,8 +178,7 @@ static int arm_smmu_register_legacy_master(struct device *dev,
>   		it.cur_count = 1;
>   	}
>   
> -	err = iommu_fwspec_init(dev, &smmu_dev->of_node->fwnode,
> -				&arm_smmu_ops);
> +	err = iommu_fwspec_init(dev, NULL);
>   	if (err)
>   		return err;
>   
> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
> index 5f731d994803..078cafcf49b4 100644
> --- a/drivers/iommu/iommu-priv.h
> +++ b/drivers/iommu/iommu-priv.h
> @@ -17,6 +17,8 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
>   	return dev->iommu->iommu_dev->ops;
>   }
>   
> +const struct iommu_ops *iommu_ops_from_fwnode(const struct fwnode_handle *fwnode);
> +
>   int iommu_group_replace_domain(struct iommu_group *group,
>   			       struct iommu_domain *new_domain);
>   
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 9df7cc75c1bc..7618c4285cf9 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2822,11 +2822,14 @@ const struct iommu_ops *iommu_ops_from_fwnode(const struct fwnode_handle *fwnode
>   	return ops;
>   }
>   
> -int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
> -		      const struct iommu_ops *ops)
> +int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode)
>   {
> +	const struct iommu_ops *ops = iommu_ops_from_fwnode(iommu_fwnode);
>   	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>   
> +	if (!ops)
> +		return -EPROBE_DEFER;
> +
>   	if (fwspec)
>   		return ops == fwspec->ops ? 0 : -EINVAL;
>   
> @@ -2838,7 +2841,7 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
>   	if (!fwspec)
>   		return -ENOMEM;
>   
> -	of_node_get(to_of_node(iommu_fwnode));
> +	fwnode_handle_get(iommu_fwnode);
>   	fwspec->iommu_fwnode = iommu_fwnode;
>   	fwspec->ops = ops;
>   	dev_iommu_fwspec_set(dev, fwspec);
> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> index 2b64ea46318f..c6ea5b4baff3 100644
> --- a/drivers/iommu/mtk_iommu_v1.c
> +++ b/drivers/iommu/mtk_iommu_v1.c
> @@ -412,7 +412,7 @@ static int mtk_iommu_v1_create_mapping(struct device *dev,
>   		return -EINVAL;
>   	}
>   
> -	ret = iommu_fwspec_init(dev, &args->np->fwnode, &mtk_iommu_v1_ops);
> +	ret = iommu_fwspec_init(dev, of_fwnode_handle(args->np));
>   	if (ret)
>   		return ret;
>   
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 3afe0b48a48d..08c523ad55ad 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -21,26 +21,19 @@ static int of_iommu_xlate(struct device *dev,
>   			  struct of_phandle_args *iommu_spec)
>   {
>   	const struct iommu_ops *ops;
> -	struct fwnode_handle *fwnode = &iommu_spec->np->fwnode;
>   	int ret;
>   
> -	ops = iommu_ops_from_fwnode(fwnode);
> -	if ((ops && !ops->of_xlate) ||
> -	    !of_device_is_available(iommu_spec->np))
> +	if (!of_device_is_available(iommu_spec->np))
>   		return -ENODEV;
>   
> -	ret = iommu_fwspec_init(dev, fwnode, ops);
> +	ret = iommu_fwspec_init(dev, of_fwnode_handle(iommu_spec->np));
> +	if (ret == -EPROBE_DEFER)
> +		return driver_deferred_probe_check_state(dev);
>   	if (ret)
>   		return ret;
> -	/*
> -	 * The otherwise-empty fwspec handily serves to indicate the specific
> -	 * IOMMU device we're waiting for, which will be useful if we ever get
> -	 * a proper probe-ordering dependency mechanism in future.
> -	 */
> -	if (!ops)
> -		return driver_deferred_probe_check_state(dev);
>   
> -	if (!try_module_get(ops->owner))
> +	ops = dev_iommu_fwspec_get(dev)->ops;
> +	if (!ops->of_xlate || !try_module_get(ops->owner))
>   		return -ENODEV;
>   
>   	ret = ops->of_xlate(dev, iommu_spec);
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index f86c7ae91814..4365d9936e68 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -837,7 +837,7 @@ static int tegra_smmu_configure(struct tegra_smmu *smmu, struct device *dev,
>   	const struct iommu_ops *ops = smmu->iommu.ops;
>   	int err;
>   
> -	err = iommu_fwspec_init(dev, &dev->of_node->fwnode, ops);
> +	err = iommu_fwspec_init(dev, of_fwnode_handle(dev->of_node));
>   	if (err < 0) {
>   		dev_err(dev, "failed to initialize fwspec: %d\n", err);
>   		return err;
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 1a4dfd7a1c4a..9d815837e297 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -736,8 +736,7 @@ struct iommu_ops;
>   bool acpi_dma_supported(const struct acpi_device *adev);
>   enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev);
>   int acpi_iommu_fwspec_init(struct device *dev, u32 id,
> -			   struct fwnode_handle *fwnode,
> -			   const struct iommu_ops *ops);
> +			   struct fwnode_handle *fwnode);
>   int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map);
>   int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
>   			   const u32 *input_id);
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 17b3f36ad843..81893aad9ee4 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1005,11 +1005,9 @@ struct iommu_mm_data {
>   	struct list_head	sva_handles;
>   };
>   
> -int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
> -		      const struct iommu_ops *ops);
> +int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode);
>   void iommu_fwspec_free(struct device *dev);
>   int iommu_fwspec_add_ids(struct device *dev, const u32 *ids, int num_ids);
> -const struct iommu_ops *iommu_ops_from_fwnode(const struct fwnode_handle *fwnode);
>   
>   static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
>   {
> @@ -1315,8 +1313,7 @@ static inline void iommu_device_unlink(struct device *dev, struct device *link)
>   }
>   
>   static inline int iommu_fwspec_init(struct device *dev,
> -				    struct fwnode_handle *iommu_fwnode,
> -				    const struct iommu_ops *ops)
> +				    struct fwnode_handle *iommu_fwnode)
>   {
>   	return -ENODEV;
>   }
> @@ -1331,12 +1328,6 @@ static inline int iommu_fwspec_add_ids(struct device *dev, u32 *ids,
>   	return -ENODEV;
>   }
>   
> -static inline
> -const struct iommu_ops *iommu_ops_from_fwnode(const struct fwnode_handle *fwnode)
> -{
> -	return NULL;
> -}
> -
>   static inline int
>   iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features feat)
>   {


I am seeing some failures on -next with some of our devices. Bisect is 
pointing to this commit. Looks like the host1x device is no longer 
probing successfully. I see the following ...

  tegra-host1x 50000000.host1x: failed to initialize fwspec: -517
  nouveau 57000000.gpu: failed to initialize fwspec: -517

The probe seems to be deferred forever. The above is seen on Tegra210 
but Tegra30 and Tegra194 are also having the same problem. Interestingly 
it is not all devices and so make me wonder if we are missing something 
on these devices? Let me know if you have any thoughts.

Cheers
Jon

-- 
nvpublic

