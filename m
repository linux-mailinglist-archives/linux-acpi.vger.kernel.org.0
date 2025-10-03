Return-Path: <linux-acpi+bounces-17570-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9109FBB79F6
	for <lists+linux-acpi@lfdr.de>; Fri, 03 Oct 2025 18:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 118BE3474F6
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Oct 2025 16:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E025A2D46AF;
	Fri,  3 Oct 2025 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q11LJZOw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011016.outbound.protection.outlook.com [52.101.52.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9964F255F28;
	Fri,  3 Oct 2025 16:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759510505; cv=fail; b=gzbiqdhv0QbCJYwwHyytInKs2fYshOv8mVX2yVSPCbR+aby7AP1aJpdc9zv39crR6nTqKb6+jywrf4wa6dUXWJ1I9gTfLQZkteZpWj/1AMtJUjf7Td9DuvxcZK5GUcexAdPXEvWqDvIocHghyXA7s0FaLkuN38IJ/7zJMiUnZhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759510505; c=relaxed/simple;
	bh=8VNWwn+3/iouTodgXQjdfe9twjvioo7qMQUykHVIlkQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YrmOzIGnhW38aCYhPC7Y1Id+5OhXFti495Defw5iI/VGdYbcIkzsGBCV4T9Kx+0MG7RzDcWZbsOLp8iQ8gK02o1AWvjt5N9RwFPRyA9XNQJaZDOVcOir1zu+O4a28l2deDPfl8eLDI7zBXonXIdva9d9gBTe4fV1pVuhCnk1wnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q11LJZOw; arc=fail smtp.client-ip=52.101.52.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUVZhLdpUTWpXRqzCBOBHRgC97n/DlEYvbHPLvaTRG842JjcCM9+gMpXnLRGACAwATNQwrlvvf4AzMn7aF7ALSJSyijBAg5ujbpgSzzjxgAEidvhSvqMcj6jd3Gv+RdgU/PgnTqkNiWr5XVR1qu6gbD1fiN/Tg6CzM5f1JhnS2UiNX4vEJolIwaxpHpDYL1xC/DYgj1BlD11OfxmbxpCPBniKQ0PxhhYXwsL9y60JhD7wrJ7W8uZIEFdmpluTsLjrOmSHF3xwKhpS6my/jKb2tgvKSJeauWJ2E/LBehNcyF5nuqtL1DNWP15g4I5f4zuYuhg79xbJJnaYcVYdWaf4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73z9t6jpqwcrum9QBqnpv8U74F2gKZpc5rLtFtd6wQ8=;
 b=N7lhaZA9z2XfsSyvbdrXPhIczCb+0ykGXme6BM15qe+B9Q03JYcDbGSkuiT7my9BHkjobQitMQGtgiLIA1VRZ2El7TbV2Jo6GbMDVh+8OG0LTyQjsPyckT9vrsqUGJKMBX8iq4wBpm4BQSVKq4ZYfOauZ9C9lapStau+F3S/xS6rrB6Tuu70CGjWtLMbMc+6obKinQVS1OkH/A01SJkHPLNrRPZKD7iEPmT7SvlXehIJkbTfZ1ty9T81+dTQroXDjVJ56/ZkHsYSoJqaYKxCROXvo2ulBJCLWH/ZeRP16rRSSlzC7BjoBWIb59tXlsjeFGX9xnm5+FWevT0ndZ8hhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73z9t6jpqwcrum9QBqnpv8U74F2gKZpc5rLtFtd6wQ8=;
 b=Q11LJZOwsr+CnyCDRfYXp7O+9nieQglsIcZEE39MinUhUvCUXOcy+1ZXWEQvfEoy9vhEZDqH4fUGSM0MtL/kLWE2JrtSCum37hUHFDMcotK+p4Zqzkb5lj0w9xOqbWU4u/aJ4oNwSBbkRv8re4RQJYM/rCpS6Rq0fkaWZqUSB7+Yer3Otts/B5NoA4tKKFsI0pBY4VEeu1Xmt94eWETZ5YmB/ZuH2kYp4xnwJCr4JiK0drvFgFSkBaWaRM1etrqp4oy3oyVmlWYsEFrZggOM91uWr3DAVw7SGu5Hhi8MqJhu7Vj9GNBT8KG86rywLcUNB7PYiBLCdbWTrTNIMgAdLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2661.namprd12.prod.outlook.com (2603:10b6:a03:67::13)
 by LV5PR12MB9826.namprd12.prod.outlook.com (2603:10b6:408:2fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.17; Fri, 3 Oct
 2025 16:54:55 +0000
Received: from BYAPR12MB2661.namprd12.prod.outlook.com
 ([fe80::f4fa:1948:9ea6:1ee2]) by BYAPR12MB2661.namprd12.prod.outlook.com
 ([fe80::f4fa:1948:9ea6:1ee2%5]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 16:54:54 +0000
Message-ID: <a0afaae6-0b7c-4a94-9b2a-b09c8016922a@nvidia.com>
Date: Fri, 3 Oct 2025 09:54:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/29] arm_mpam: Add the class and component structures
 for firmware described ris
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Ben Horgan <ben.horgan@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-9-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250910204309.20751-9-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0154.namprd05.prod.outlook.com
 (2603:10b6:a03:339::9) To BYAPR12MB2661.namprd12.prod.outlook.com
 (2603:10b6:a03:67::13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2661:EE_|LV5PR12MB9826:EE_
X-MS-Office365-Filtering-Correlation-Id: a9c5ddf3-4023-4f02-f3eb-08de029d935e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VkNVUktEV1F3Q2d0WlZ5bEMrNS9xYTRXMkkwVWJtS1FKNG5PYXBOWVRjRlZU?=
 =?utf-8?B?d2VsbXVuU0RzYzZVV2UxeTYwSjI5bkduejFENmlZM1h0alUvY2FWMVZPU3FS?=
 =?utf-8?B?c3NheHpCKzhheG54azM0YWVpVGtDdzFDYTl3cnJVZDdDTXlmVmlwS1FibkND?=
 =?utf-8?B?U21SS3BpTVY0ZzgvMTUyYmdjblJFRkIrZEdSbDNtRXdXVGdwTGtKblY3a2RL?=
 =?utf-8?B?bHZoREdvd1g3aVpRRXYwWFNUOUNNODdtTmw3a1hnbkN5UDlhd3RCM2l3SzlX?=
 =?utf-8?B?RTdoc0VKcDRpS3hFYU5sdE1pTFlTUTJPeHIyQWREaUlkY0g1VlI3V1RPTEJO?=
 =?utf-8?B?ZE56cXA2NThHWlo3QW9qYjR1SmJpMW9kY3Bpcm84aWRKNUNIbHBLRUp3MDZ1?=
 =?utf-8?B?MEdFamNtTWtQSmQzekY0RkQybFJDVDJvdVFmL2RaUGF5VmJhZVdzZnh3SVdR?=
 =?utf-8?B?TlpyK0ZYTHgzL05GNnhudVJmVUJjVzNEbU9nWG1YemF4Y1dqZjBPazlnQ1Z6?=
 =?utf-8?B?c2FNMGx0akpycDdEZ0RIRXB0ZERHWkE3bHF4dzEybGY4N1hHeERNRDFVQXNp?=
 =?utf-8?B?WjRVQS9nMnpscVlicUpyZjNUM3JpZEYxSmtGVnlzQm92SmNXN2lDMTVEVkFx?=
 =?utf-8?B?OVN2Sm4zZWtHbUtXT2V4RVhxYy9yT0lIOFlQd2x2ZHFMNFU3dFVGZVRnZEZD?=
 =?utf-8?B?TlNhbTFXeGtrc3hOb1NrS2xNR3dYNEFJakFSeCtIS3NBT2dOQ3l1eWp6VFZl?=
 =?utf-8?B?SVFIZGlVT0c2Q1FmclZIeE5kOTVyQ1NhUk5KWDgvdTFZTTIxYzBBN1M1L2VN?=
 =?utf-8?B?bVJKeTNCaVZ1Vjl1bzJqWVlBUDg3cVVqUXNwVEpxYkdGb0VWbHJXNmNTNjF3?=
 =?utf-8?B?Y3gyUThNV1FobU1KNEU5WTVBK0lReWRNRjAydllXVTFtcGlPTHUxVDd5TWZu?=
 =?utf-8?B?b3ZuczZpQ2pQaWErcnVSb050d3IzanZIeUhDUmRzajVBN2p0Zko4U3lhMUNV?=
 =?utf-8?B?d3Noem9KQVBiR29SZzZXUVh4S2JYeHd6aWd3eW5sTS9MbG5BS0crb2V2Q2tC?=
 =?utf-8?B?Yjk4UjNqQW1CQU9GOHNXL2Y3amFsS3BsaWlYOXlRNkJxNHhWeUhJS01VelhW?=
 =?utf-8?B?TzRySFFTOC8rSHk4bFBZTzBEUk5iT3RBWXJWQlJHTkV4eEUrRmNUYzhEZmFq?=
 =?utf-8?B?Qlo1b0pFR2Y5UTVQNHZhaEZ6M0RFVGNBNkV1czdVdDNwVDRLTytwa0lCdmVT?=
 =?utf-8?B?K1cvTExnY1U1N2V1enFVRVNaVEQ4dUt2NjBFRDRtaVloK3g0RGJXZU5oS1lX?=
 =?utf-8?B?cHVINWIybCs5bm5nODFTM0xtM1dxRzJxQXdZcnJRU0ErQUJ4NFhuMVN3WUJB?=
 =?utf-8?B?YjRma1JmeG5FR1ZTOVl5ckpOMHdvdEErdmE2OXZRbWppNUdmaXZQWitHZjUy?=
 =?utf-8?B?MEU2eFRzQWRLQTVJQ3NIT1lsTlFQaUdQTWhZUnQ3RzIwMERZUlVITzRYeDU1?=
 =?utf-8?B?TjkvbFNqT2krYi93dmRoVFlrNkNjajZlMTRZMmwxYjJyRUxvRjJPNFdNRDFx?=
 =?utf-8?B?SVcvaFk4SlhGcjVmS2JMM3ZHdEVGb0ROd1hSeEgvSG52aU9PckxDMUNOVVRy?=
 =?utf-8?B?U0hLOWlkaXBjUzN1REJmTDV4WlNvdEpXTTRJamRIZUVhaFdOODU5SmhxeXVx?=
 =?utf-8?B?UkpwM0hSeUJYd1RBMk5oUGhteW5KMXk2bXpCWnNFS2NYN25pTEVyZ1hQTVNY?=
 =?utf-8?B?ZmJEWk1EZkswNVRKNzQ3dTVvTU1qQlZpWmpNbmo4QkZBLzRHeERRZkZpWEgv?=
 =?utf-8?B?dEdabW9jQnhxMGcweWJIV1I5Mlh0ZVQydXNlS2dxMDlQSnJna3JUYW5hRVM2?=
 =?utf-8?B?dWRwZjVrdGUvY0NYeFhhWllKK1A1alFFb0hBbE40aWxXQ0JtN2JmSmRQSGJ4?=
 =?utf-8?Q?yr2qSTdhzObgf4NY0vjlTTgwQrMHC4IB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2661.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3VTN245TFBxRFIzNnQ4cmpLUHI0bk92cjhYR1d2T3dNQ09UaGJIcnVmT044?=
 =?utf-8?B?UGJjSmZDRy9iZlRHUndjMVhTcThyWDhLVHVGS0p5aEl6eFRYWFZzbTU1eHRr?=
 =?utf-8?B?MHdZYW5hU1VrSjFKTWxST1F3WDVKRHdzT1pCK3YrT092VGQ0cnZKalZkNk8w?=
 =?utf-8?B?RFR3TWpNajc4SHk2Y29CTTdwMmF0d0RidUZBZ1JsZnVWRXpOSnRPMnN0LzhG?=
 =?utf-8?B?MVByYVU1Vm5BVGJmWFozYmFJOVhiU3JQN0V1YnM3L0VLQUhwWDdlM1JhVWlS?=
 =?utf-8?B?WlJjL3oyS0pmNjdoVDB0akN6cFloNSt1clpLTlFRRFk2RE5yZ3NyUGxNUVpE?=
 =?utf-8?B?QTN1WnpHVmdTYzZtRlRMdDBFeGN6cWc1cklWWVpxUmk3WHJUWFVUTThsSTND?=
 =?utf-8?B?Vlc5ZGZtM1JDM3hZL3ZzQ01EeXdEdUsvaVVBaUcvYlFUMnhXa0xTMmlYU1Fu?=
 =?utf-8?B?WFdBQWVvcmErUjJ3bnZUaDU4MS90R3ViNlpPcklsWE45UmozdGpvZXRIdEFv?=
 =?utf-8?B?NWQ0eisvVXBsUFFmZHhONHpxNU9sT2RyWDg3eWpubjF3ZE5DdHpON2FZNzNr?=
 =?utf-8?B?bTg1WmZla2dYSVdSNTJPWkc1UUdudW8wSTVyOU9qdW9uT0llTUVUSjVhWHhS?=
 =?utf-8?B?eVQzenpqRkQyTEh5UjRTZ01rMWFxM1JUVFczTVVwRHMwN3JaUm5TSUYwSXBa?=
 =?utf-8?B?QytxZG9ONGRUT3ZXQVd0RDlmQTAweGNWS2VtNldva2lJR096cThzekNLZ3Vh?=
 =?utf-8?B?aVB1cUlBaDE1d2gyUGdVSEZCYVBld1Z1NStubDE1Yy85alFyeVRoOWhwREg0?=
 =?utf-8?B?S2JOQlZua2h6VDVkdG1LVngrRlVjeU1OTFVicmpidXlvVE5GOUF3SXlhcHcy?=
 =?utf-8?B?Y1o0V2tTR2N5YmZCcWpTeDBCTlpxbWpBU1ZUR0J6TFNwbllTOS80dFk2NjBo?=
 =?utf-8?B?ZkMxR0VDbit5ZlVDVy9JaU1ud2l1Zks0aUlBTnh6Zmp4NnhCTjJyWVZHMjRD?=
 =?utf-8?B?eXVKMFpYQUtUSHdOYjFxUXZlNTlKQ2pVOGYyRG5wUFZCdE9ocHJxakNxV1ZR?=
 =?utf-8?B?WUJrSjU4NE52YXFsekdpR1poQmlZN0Q2MVJOOUx0bzZJNFBaQzErRndRTE1h?=
 =?utf-8?B?MjBkeDZML1pIamIwNmNzZHNuNCt4MHpMek41VTF3cFMvNnhvb09QZVhoV1Rq?=
 =?utf-8?B?NEpSeHlieDE5aExCTDBHZVNIdVQzdnpmdEpOdGtlb2h3b0xxUDJGWjdqNTd3?=
 =?utf-8?B?RHRqdWc1b0tWdnUyMTNLTGsvVitLaDFFOWhMZTdFSjBrU3BIYVVmVjZaaHJj?=
 =?utf-8?B?endQMTM2dUF6WFkrZlhieEFGRUh0SytidjlLaERadHo1TWlycEdWa2l2UjVx?=
 =?utf-8?B?QjRVK3h0RGlkVjBWWVpEWS9LTmNqbGl0eTBFOU5OKzlQRi9BT1VwRlQvMVA3?=
 =?utf-8?B?SjhudU5JNXFSOXdaVC9xQ3l5T2d0ZzFEenh0ZE4wVTJ5L2dFUTBzek8zVjZu?=
 =?utf-8?B?SzZ0dzdFVC9ReDhNeU5qUFJVNmhuQlExK3MvZkZvU04xK2ZTMzBtalU5RnZV?=
 =?utf-8?B?UDFjSkk4RkdsVTRlSzZvT1djTStIaDBhVysxOFpra2RMWUliM0QweVBGVXdH?=
 =?utf-8?B?WnNnZ3BFeGpqTjJyUjRoaG9GREpFZ2VlczVLdVR4ejhDUVc2Y2FTci9MY21K?=
 =?utf-8?B?UVFyVlN6ZVBvY2JCSW13d1FjZVdaQlUzbkhFek9qVmppZU45S2lETDB2cUN5?=
 =?utf-8?B?TXVpZHhSQlJoSGN4MlY1Z1pxMWgrN2FjZVh4ZlVySTJCUFZTL1FiN2NncWFJ?=
 =?utf-8?B?MVRpR3ZUWGZwejhESC93VGc0TGJVTnZCOGFRTS9nL0tpVGN4WkJ6cHQ1Y1pM?=
 =?utf-8?B?c1BQV2V1MnFDQmpCbzl2WEJFa3lKNkVJVHoyRFZFL3pXZ3BJdys4Nmc1Qlkz?=
 =?utf-8?B?MHQvVXk1RXdabjgrZmExT0hJREhnY0tONzlNWnkwajg4VG55TVlsaFJpNGVX?=
 =?utf-8?B?bG03aGxsS1dPVFJML2pLNUVyR0lVMDVybU8zL25mSDdIVXZVNDlveUNlOEU1?=
 =?utf-8?B?eFFJUnE4T0lEQ1VZZHBsRnkrb2lYSzk4WEo2WFdSanlIWFoyVzd0MnlyV2hF?=
 =?utf-8?Q?MXCs9KTd443YB0f+ER9MkIFlg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c5ddf3-4023-4f02-f3eb-08de029d935e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2661.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 16:54:54.8933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJV8ZX9kZg+DFWQvFixfKKbHFtxyQbKRxjq4kTLVUkQYOemfOuzKA5j5/V4jRUZWRztjldOoSVHEwO7YwraXnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9826

Hi, James,

On 9/10/25 13:42, James Morse wrote:
> An MSC is a container of resources, each identified by their RIS index.
> Some RIS are described by firmware to provide their position in the system.
> Others are discovered when the driver probes the hardware.
>
> To configure a resource it needs to be found by its class, e.g. 'L2'.
> There are two kinds of grouping, a class is a set of components, which
> are visible to user-space as there are likely to be multiple instances
> of the L2 cache. (e.g. one per cluster or package)
>
> Add support for creating and destroying structures to allow a hierarchy
> of resources to be created.
>
> CC: Ben Horgan <ben.horgan@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>   * Fixed a comp/vmsc typo.
>   * Removed duplicate description from the commit message.
>   * Moved parenthesis in the add_to_garbage() macro.
>   * Check for out of range ris_idx when creating ris.
>   * Removed GFP as probe_lock is no longer a spin lock.
>   * Removed alloc flag as ended up searching the lists itself.
>   * Added a comment about affinity masks not overlapping.
>
> Changes since RFC:
>   * removed a pr_err() debug message that crept in.
> ---
>   drivers/resctrl/mpam_devices.c  | 406 +++++++++++++++++++++++++++++++-
>   drivers/resctrl/mpam_internal.h |  90 +++++++
>   include/linux/arm_mpam.h        |   8 +-
>   3 files changed, 493 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index efc4738e3b4d..c7f4981b3545 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -18,7 +18,6 @@
>   #include <linux/printk.h>
>   #include <linux/slab.h>
>   #include <linux/spinlock.h>
> -#include <linux/srcu.h>
>   #include <linux/types.h>
>   
>   #include "mpam_internal.h"
> @@ -31,7 +30,7 @@
>   static DEFINE_MUTEX(mpam_list_lock);
>   static LIST_HEAD(mpam_all_msc);
>   
> -static struct srcu_struct mpam_srcu;
> +struct srcu_struct mpam_srcu;
>   
>   /*
>    * Number of MSCs that have been probed. Once all MSC have been probed MPAM
> @@ -39,6 +38,402 @@ static struct srcu_struct mpam_srcu;
>    */
>   static atomic_t mpam_num_msc;
>   
> +/*
> + * An MSC is a physical container for controls and monitors, each identified by
> + * their RIS index. These share a base-address, interrupts and some MMIO
> + * registers. A vMSC is a virtual container for RIS in an MSC that control or
> + * monitor the same thing. Members of a vMSC are all RIS in the same MSC, but
> + * not all RIS in an MSC share a vMSC.
> + * Components are a group of vMSC that control or monitor the same thing but
> + * are from different MSC, so have different base-address, interrupts etc.
> + * Classes are the set components of the same type.
> + *
> + * The features of a vMSC is the union of the RIS it contains.
> + * The features of a Class and Component are the common subset of the vMSC
> + * they contain.
> + *
> + * e.g. The system cache may have bandwidth controls on multiple interfaces,
> + * for regulating traffic from devices independently of traffic from CPUs.
> + * If these are two RIS in one MSC, they will be treated as controlling
> + * different things, and will not share a vMSC/component/class.
> + *
> + * e.g. The L2 may have one MSC and two RIS, one for cache-controls another
> + * for bandwidth. These two RIS are members of the same vMSC.
> + *
> + * e.g. The set of RIS that make up the L2 are grouped as a component. These
> + * are sometimes termed slices. They should be configured the same, as if there
> + * were only one.
> + *
> + * e.g. The SoC probably has more than one L2, each attached to a distinct set
> + * of CPUs. All the L2 components are grouped as a class.
> + *
> + * When creating an MSC, struct mpam_msc is added to the all mpam_all_msc list,
> + * then linked via struct mpam_ris to a vmsc, component and class.
> + * The same MSC may exist under different class->component->vmsc paths, but the
> + * RIS index will be unique.
> + */
> +LIST_HEAD(mpam_classes);
> +
> +/* List of all objects that can be free()d after synchronise_srcu() */
> +static LLIST_HEAD(mpam_garbage);
> +
> +#define init_garbage(x)	init_llist_node(&(x)->garbage.llist)
> +
> +static struct mpam_vmsc *
> +mpam_vmsc_alloc(struct mpam_component *comp, struct mpam_msc *msc)
> +{
> +	struct mpam_vmsc *vmsc;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	vmsc = kzalloc(sizeof(*vmsc), GFP_KERNEL);
> +	if (!vmsc)
> +		return ERR_PTR(-ENOMEM);
> +	init_garbage(vmsc);
> +
> +	INIT_LIST_HEAD_RCU(&vmsc->ris);
> +	INIT_LIST_HEAD_RCU(&vmsc->comp_list);
> +	vmsc->comp = comp;
> +	vmsc->msc = msc;
> +
> +	list_add_rcu(&vmsc->comp_list, &comp->vmsc);
> +
> +	return vmsc;
> +}
> +
> +static struct mpam_vmsc *mpam_vmsc_get(struct mpam_component *comp,
> +				       struct mpam_msc *msc)
> +{
> +	struct mpam_vmsc *vmsc;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	list_for_each_entry(vmsc, &comp->vmsc, comp_list) {
> +		if (vmsc->msc->id == msc->id)
> +			return vmsc;
> +	}
> +
> +	return mpam_vmsc_alloc(comp, msc);
> +}
> +
> +static struct mpam_component *
> +mpam_component_alloc(struct mpam_class *class, int id)
> +{
> +	struct mpam_component *comp;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	comp = kzalloc(sizeof(*comp), GFP_KERNEL);
> +	if (!comp)
> +		return ERR_PTR(-ENOMEM);
> +	init_garbage(comp);
> +
> +	comp->comp_id = id;
> +	INIT_LIST_HEAD_RCU(&comp->vmsc);
> +	/* affinity is updated when ris are added */
> +	INIT_LIST_HEAD_RCU(&comp->class_list);
> +	comp->class = class;
> +
> +	list_add_rcu(&comp->class_list, &class->components);
> +
> +	return comp;
> +}
> +
> +static struct mpam_component *
> +mpam_component_get(struct mpam_class *class, int id)
> +{
> +	struct mpam_component *comp;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	list_for_each_entry(comp, &class->components, class_list) {
> +		if (comp->comp_id == id)
> +			return comp;
> +	}
> +
> +	return mpam_component_alloc(class, id);
> +}
> +
> +static struct mpam_class *
> +mpam_class_alloc(u8 level_idx, enum mpam_class_types type)
> +{
> +	struct mpam_class *class;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	class = kzalloc(sizeof(*class), GFP_KERNEL);
> +	if (!class)
> +		return ERR_PTR(-ENOMEM);
> +	init_garbage(class);
> +
> +	INIT_LIST_HEAD_RCU(&class->components);
> +	/* affinity is updated when ris are added */
> +	class->level = level_idx;
> +	class->type = type;
> +	INIT_LIST_HEAD_RCU(&class->classes_list);
> +
> +	list_add_rcu(&class->classes_list, &mpam_classes);
> +
> +	return class;
> +}
> +
> +static struct mpam_class *
> +mpam_class_get(u8 level_idx, enum mpam_class_types type)
> +{
> +	bool found = false;
> +	struct mpam_class *class;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	list_for_each_entry(class, &mpam_classes, classes_list) {
> +		if (class->type == type && class->level == level_idx) {
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	if (found)
> +		return class;
> +
> +	return mpam_class_alloc(level_idx, type);
> +}
> +
> +#define add_to_garbage(x)				\
> +do {							\
> +	__typeof__(x) _x = (x);				\
> +	_x->garbage.to_free = _x;			\
> +	llist_add(&_x->garbage.llist, &mpam_garbage);	\
> +} while (0)
> +
> +static void mpam_class_destroy(struct mpam_class *class)
> +{
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	list_del_rcu(&class->classes_list);
> +	add_to_garbage(class);
> +}
> +
> +static void mpam_comp_destroy(struct mpam_component *comp)
> +{
> +	struct mpam_class *class = comp->class;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	list_del_rcu(&comp->class_list);
> +	add_to_garbage(comp);
> +
> +	if (list_empty(&class->components))
> +		mpam_class_destroy(class);
> +}
> +
> +static void mpam_vmsc_destroy(struct mpam_vmsc *vmsc)
> +{
> +	struct mpam_component *comp = vmsc->comp;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	list_del_rcu(&vmsc->comp_list);
> +	add_to_garbage(vmsc);
> +
> +	if (list_empty(&comp->vmsc))
> +		mpam_comp_destroy(comp);
> +}
> +
> +static void mpam_ris_destroy(struct mpam_msc_ris *ris)
> +{
> +	struct mpam_vmsc *vmsc = ris->vmsc;
> +	struct mpam_msc *msc = vmsc->msc;
> +	struct platform_device *pdev = msc->pdev;
> +	struct mpam_component *comp = vmsc->comp;
> +	struct mpam_class *class = comp->class;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	/*
> +	 * It is assumed affinities don't overlap. If they do the class becomes
> +	 * unusable immediately.
> +	 */
> +	cpumask_andnot(&comp->affinity, &comp->affinity, &ris->affinity);
> +	cpumask_andnot(&class->affinity, &class->affinity, &ris->affinity);
> +	clear_bit(ris->ris_idx, &msc->ris_idxs);
> +	list_del_rcu(&ris->vmsc_list);
> +	list_del_rcu(&ris->msc_list);
> +	add_to_garbage(ris);
> +	ris->garbage.pdev = pdev;
> +
> +	if (list_empty(&vmsc->ris))
> +		mpam_vmsc_destroy(vmsc);
> +}
> +
> +/*
> + * There are two ways of reaching a struct mpam_msc_ris. Via the
> + * class->component->vmsc->ris, or via the msc.
> + * When destroying the msc, the other side needs unlinking and cleaning up too.
> + */
> +static void mpam_msc_destroy(struct mpam_msc *msc)
> +{
> +	struct platform_device *pdev = msc->pdev;
> +	struct mpam_msc_ris *ris, *tmp;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	list_for_each_entry_safe(ris, tmp, &msc->ris, msc_list)
> +		mpam_ris_destroy(ris);
> +
> +	list_del_rcu(&msc->all_msc_list);
> +	platform_set_drvdata(pdev, NULL);
> +
> +	add_to_garbage(msc);
> +	msc->garbage.pdev = pdev;
> +}
> +
> +static void mpam_free_garbage(void)
> +{
> +	struct mpam_garbage *iter, *tmp;
> +	struct llist_node *to_free = llist_del_all(&mpam_garbage);
> +

Should this be protected by mpam_list_lock and check if the lock is held?

+	lockdep_assert_held(&mpam_list_lock);

Multiple threads may add and free garbage in parallel. Please see later free_garbage() is not protected by any lock.

> +	if (!to_free)
> +		return;
> +
> +	synchronize_srcu(&mpam_srcu);
> +
> +	llist_for_each_entry_safe(iter, tmp, to_free, llist) {
> +		if (iter->pdev)
> +			devm_kfree(&iter->pdev->dev, iter->to_free);
> +		else
> +			kfree(iter->to_free);
> +	}
> +}
> +
> +/*
> + * The cacheinfo structures are only populated when CPUs are online.
> + */
> +int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
> +				   cpumask_t *affinity)
> +{
> +	return acpi_pptt_get_cpumask_from_cache_id(cache_id, affinity);
> +}
> +
> +/*
> + * cpumask_of_node() only knows about online CPUs. This can't tell us whether
> + * a class is represented on all possible CPUs.
> + */
> +static void get_cpumask_from_node_id(u32 node_id, cpumask_t *affinity)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		if (node_id == cpu_to_node(cpu))
> +			cpumask_set_cpu(cpu, affinity);
> +	}
> +}
> +
> +static int mpam_ris_get_affinity(struct mpam_msc *msc, cpumask_t *affinity,
> +				 enum mpam_class_types type,
> +				 struct mpam_class *class,
> +				 struct mpam_component *comp)
> +{
> +	int err;
> +
> +	switch (type) {
> +	case MPAM_CLASS_CACHE:
> +		err = mpam_get_cpumask_from_cache_id(comp->comp_id, class->level,
> +						     affinity);
> +		if (err)
> +			return err;
> +
> +		if (cpumask_empty(affinity))
> +			pr_warn_once("%s no CPUs associated with cache node",
> +				     dev_name(&msc->pdev->dev));
> +
> +		break;
> +	case MPAM_CLASS_MEMORY:
> +		get_cpumask_from_node_id(comp->comp_id, affinity);
> +		/* affinity may be empty for CPU-less memory nodes */
> +		break;
> +	case MPAM_CLASS_UNKNOWN:
> +		return 0;
> +	}
> +
> +	cpumask_and(affinity, affinity, &msc->accessibility);
> +
> +	return 0;
> +}
> +
> +static int mpam_ris_create_locked(struct mpam_msc *msc, u8 ris_idx,
> +				  enum mpam_class_types type, u8 class_id,
> +				  int component_id)
> +{
> +	int err;
> +	struct mpam_vmsc *vmsc;
> +	struct mpam_msc_ris *ris;
> +	struct mpam_class *class;
> +	struct mpam_component *comp;
> +
> +	lockdep_assert_held(&mpam_list_lock);
> +
> +	if (ris_idx > MPAM_MSC_MAX_NUM_RIS)
> +		return -EINVAL;
> +
> +	if (test_and_set_bit(ris_idx, &msc->ris_idxs))
> +		return -EBUSY;
> +

Should setting msc->ris_idxs bit be moved to the end of this function 
after all error handling paths? The reason is this bit is better to be 0 
(or recovered) if any error happens. It's hard to recover it to 0 for 
each error handling. The easiest way is to set it at the end of the 
function.

> +	ris = devm_kzalloc(&msc->pdev->dev, sizeof(*ris), GFP_KERNEL);
> +	if (!ris)
> +		return -ENOMEM;
> +	init_garbage(ris);
> +
> +	class = mpam_class_get(class_id, type);
> +	if (IS_ERR(class))
> +		return PTR_ERR(class);
> +
> +	comp = mpam_component_get(class, component_id);
> +	if (IS_ERR(comp)) {
> +		if (list_empty(&class->components))
> +			mpam_class_destroy(class);
> +		return PTR_ERR(comp);
> +	}
> +
> +	vmsc = mpam_vmsc_get(comp, msc);
> +	if (IS_ERR(vmsc)) {
> +		if (list_empty(&comp->vmsc))
> +			mpam_comp_destroy(comp);
> +		return PTR_ERR(vmsc);
> +	}
> +
> +	err = mpam_ris_get_affinity(msc, &ris->affinity, type, class, comp);
> +	if (err) {
> +		if (list_empty(&vmsc->ris))
> +			mpam_vmsc_destroy(vmsc);
> +		return err;
> +	}
> +
> +	ris->ris_idx = ris_idx;
> +	INIT_LIST_HEAD_RCU(&ris->vmsc_list);

vmsc_list will be used but not initialized. Missing 
INIT_LIST_HEAD_RCU(&ris->msc_list) here?

> +	ris->vmsc = vmsc;
> +
> +	cpumask_or(&comp->affinity, &comp->affinity, &ris->affinity);
> +	cpumask_or(&class->affinity, &class->affinity, &ris->affinity);
> +	list_add_rcu(&ris->vmsc_list, &vmsc->ris);
> +
Setting the msc->ris_idxs here is better to avoid to clear it in each 
error handling path.
> +	return 0;
> +}
> +
> +int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
> +		    enum mpam_class_types type, u8 class_id, int component_id)
> +{
> +	int err;
> +
> +	mutex_lock(&mpam_list_lock);
> +	err = mpam_ris_create_locked(msc, ris_idx, type, class_id,
> +				     component_id);
> +	mutex_unlock(&mpam_list_lock);
> +	if (err)
> +		mpam_free_garbage();
> +
> +	return err;
> +}
> +
>   /*
>    * An MSC can control traffic from a set of CPUs, but may only be accessible
>    * from a (hopefully wider) set of CPUs. The common reason for this is power
> @@ -74,10 +469,10 @@ static void mpam_msc_drv_remove(struct platform_device *pdev)
>   		return;
>   
>   	mutex_lock(&mpam_list_lock);
> -	platform_set_drvdata(pdev, NULL);
> -	list_del_rcu(&msc->all_msc_list);
> -	synchronize_srcu(&mpam_srcu);
> +	mpam_msc_destroy(msc);
>   	mutex_unlock(&mpam_list_lock);
> +
> +	mpam_free_garbage();

Should mpam_free_garbage() be protected by mpam_list_lock? It may race 
with adding garbage. I can see other adding and freeing garbage are 
protected by mpam_list_lock but not this one.

>   }
>   
>   static int mpam_msc_drv_probe(struct platform_device *pdev)
> @@ -95,6 +490,7 @@ static int mpam_msc_drv_probe(struct platform_device *pdev)
>   			err = -ENOMEM;
>   			break;
>   		}
> +		init_garbage(msc);
>   
>   		mutex_init(&msc->probe_lock);
>   		mutex_init(&msc->part_sel_lock);
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 7c63d590fc98..02e9576ece6b 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -7,10 +7,29 @@
>   #include <linux/arm_mpam.h>
>   #include <linux/cpumask.h>
>   #include <linux/io.h>
> +#include <linux/llist.h>
>   #include <linux/mailbox_client.h>
>   #include <linux/mutex.h>
>   #include <linux/resctrl.h>
>   #include <linux/sizes.h>
> +#include <linux/srcu.h>
> +
> +#define MPAM_MSC_MAX_NUM_RIS	16
> +
> +/*
> + * Structures protected by SRCU may not be freed for a surprising amount of
> + * time (especially if perf is running). To ensure the MPAM error interrupt can
> + * tear down all the structures, build a list of objects that can be gargbage
> + * collected once synchronize_srcu() has returned.
> + * If pdev is non-NULL, use devm_kfree().
> + */
> +struct mpam_garbage {
> +	/* member of mpam_garbage */
> +	struct llist_node	llist;
> +
> +	void			*to_free;
> +	struct platform_device	*pdev;
> +};
>   
>   struct mpam_msc {
>   	/* member of mpam_all_msc */
> @@ -57,8 +76,79 @@ struct mpam_msc {
>   
>   	void __iomem		*mapped_hwpage;
>   	size_t			mapped_hwpage_sz;
> +
> +	struct mpam_garbage	garbage;
>   };
>   
> +struct mpam_class {
> +	/* mpam_components in this class */
> +	struct list_head	components;
> +
> +	cpumask_t		affinity;
> +
> +	u8			level;
> +	enum mpam_class_types	type;
> +
> +	/* member of mpam_classes */
> +	struct list_head	classes_list;
> +
> +	struct mpam_garbage	garbage;
> +};
> +
> +struct mpam_component {
> +	u32			comp_id;
> +
> +	/* mpam_vmsc in this component */
> +	struct list_head	vmsc;
> +
> +	cpumask_t		affinity;
> +
> +	/* member of mpam_class:components */
> +	struct list_head	class_list;
> +
> +	/* parent: */
> +	struct mpam_class	*class;
> +
> +	struct mpam_garbage	garbage;
> +};
> +
> +struct mpam_vmsc {
> +	/* member of mpam_component:vmsc_list */
> +	struct list_head	comp_list;
> +
> +	/* mpam_msc_ris in this dvmsc */
> +	struct list_head	ris;
> +
> +	/* All RIS in this vMSC are members of this MSC */
> +	struct mpam_msc		*msc;
> +
> +	/* parent: */
> +	struct mpam_component	*comp;
> +
> +	struct mpam_garbage	garbage;
> +};
> +
> +struct mpam_msc_ris {
> +	u8			ris_idx;
> +
> +	cpumask_t		affinity;
> +
> +	/* member of mpam_vmsc:ris */
> +	struct list_head	vmsc_list;
> +
> +	/* member of mpam_msc:ris */
> +	struct list_head	msc_list;
> +
> +	/* parent: */
> +	struct mpam_vmsc	*vmsc;
> +
> +	struct mpam_garbage	garbage;
> +};
> +
> +/* List of all classes - protected by srcu*/
> +extern struct srcu_struct mpam_srcu;
> +extern struct list_head mpam_classes;
> +
>   int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
>   				   cpumask_t *affinity);
>   
> diff --git a/include/linux/arm_mpam.h b/include/linux/arm_mpam.h
> index 3d6c39c667c3..3206f5ddc147 100644
> --- a/include/linux/arm_mpam.h
> +++ b/include/linux/arm_mpam.h
> @@ -38,11 +38,7 @@ static inline int acpi_mpam_parse_resources(struct mpam_msc *msc,
>   static inline int acpi_mpam_count_msc(void) { return -EINVAL; }
>   #endif
>   
> -static inline int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
> -				  enum mpam_class_types type, u8 class_id,
> -				  int component_id)
> -{
> -	return -EINVAL;
> -}
> +int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
> +		    enum mpam_class_types type, u8 class_id, int component_id);
>   
>   #endif /* __LINUX_ARM_MPAM_H */

Thanks.

-Fenghua


