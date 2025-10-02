Return-Path: <linux-acpi+bounces-17498-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B03BB2806
	for <lists+linux-acpi@lfdr.de>; Thu, 02 Oct 2025 07:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 384133A9A4D
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Oct 2025 05:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E29126BF1;
	Thu,  2 Oct 2025 05:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pBKu0Gbq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011068.outbound.protection.outlook.com [40.107.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ED4288AD;
	Thu,  2 Oct 2025 05:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759381635; cv=fail; b=Qk4162/EXE8uWl8hBs7inOrGAJLdu/a9spi9QIHUWK9BjkFn2xGu+wVOuzUostXQwo1kZZdFgU7h9M1ZRGHWDDAZhWFEKwCh5BFFA6D7Y/8oM43pBmmL3d8dNtKda4Yp53r3GcSSTWwJiocmHkyU0dibTmmgRF/Ixi3vV7CQzVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759381635; c=relaxed/simple;
	bh=+BnV1CuLPYpLff6h0NdLRP5BNPGv/XodhTObtEsAx2o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lJEULwH676FhY+qbTQQZu4XUFfrg7c0zBBSo9FZZH5IHNH2AfGd9xobbpq55ai9Xjicr3hh66W8tz1PdKhCqTTEK9fF0/3icKsFn8shzmm4NZHtA0+MJUg9COWPD3KFyXcAm+AZ1QiZJkquo0PcPIMEJkZswYD6QQbazildpnPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pBKu0Gbq; arc=fail smtp.client-ip=40.107.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+mkglKvIfaVVP3mrwhjCbbIVzq1y1lm4oxV1HV0kEpGvxB1ZxX5HdWKmT6ETdU8gDEgUFai1G4h90Tn3BCkL52H8nJVigpJnAeoqFd4iKNFUP6xcb2oSMALGMPqeL/0+5rqDBBi0LkLDUBtxRbZ9CutW9LpbvA8HxN82rlXhtbdKBBoxBnHj3tG5yv8MWU0NsDNoEPi1ubZRe4RaapqBgYRT5wkMTg6MlsfE8oc+EHWP+ZD6Y3ngtEPrEVssZ5B1flmRm+t7bWsrMW/HWj8DcrJN731Zh7vN6DfZqpCp/B9WAwcfRT+z1YzDBtO7M7ujgi4kzyHTBOAGPSUlCahvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+BnV1CuLPYpLff6h0NdLRP5BNPGv/XodhTObtEsAx2o=;
 b=E8KClKUfed5gNMP4w8bkmQqDFRBj/k9Yk/zoH2A4TGeIR4U0qVGeRxgLur4DIZuwfbWOd2w7wHstQVncesIpyr1qqEp0wX1hMFFtMQoFoi0BP+aPo69tfXyMdS4zfUn93++K30PYG+1nxSRrjtS1PkmmBxWsbQ871qiH3gSnf4OATOKGpCsFhwQsh6fiQqLOEhlwNqGCKLRadqwjp9O5Pcz24w8xnHLFypFR/4eo0fk/yOYW1zwcofXJrg6Y4v3q83SMsjNd8HWpheZOuKYP06mnxaA1ml+63QtUWcMfQiYSycWupN1U9zCtX5R9txkS3ovkZz4st4Vo7kNeXJVgUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BnV1CuLPYpLff6h0NdLRP5BNPGv/XodhTObtEsAx2o=;
 b=pBKu0Gbqk9AeW8TLJ3UvB/+a4NR7TB/KygZWOTDYZUcDa1qBcMc127a2Gmz4URi0R5/2r8LfWIlChBXgQ1iVSGUTxtdUM8EwM74cBhKUabzezf2aMn+5I7XAcqkNC4sZEtnW2N7v+3xyGU2pukssx+3uRKZ6zuXZy4zVzqiQ26Q0sx7PH5wX1kosyjPVMpy5vGvqG3wkRpTG3rKv02CPkvqDzjCPFu0QmddO2aaVpgEBJvR85u1nkIQmz6o6Jl6V8+A4frDDSjPrGp9g7x6zeS/XlVRSP8p3zzIO14k0gvkPuq2t4SWxlmp2RphTxzNQzkS2fowhpKbMIYzY6O/iUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 05:07:02 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9160.008; Thu, 2 Oct 2025
 05:07:01 +0000
Message-ID: <378ae328-089d-4f81-b48b-b5edac7515ed@nvidia.com>
Date: Wed, 1 Oct 2025 22:06:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/29] arm64: kconfig: Add Kconfig entry for MPAM
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
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-6-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250910204309.20751-6-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0018.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::31) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|BY5PR12MB4147:EE_
X-MS-Office365-Filtering-Correlation-Id: 64eb3072-d72e-4bae-8514-08de0171851e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1lTYVdLSDJQK0dUZlp3K2pJeUZPbVFJdkRMWTJWYXpoektLYk1SZGdvTmtH?=
 =?utf-8?B?aVdzclp4ZDY1Wm1CSUtDYTUrM1N0QTJoak1HQjRyMUpmcEpGNkYzNmpMR1Ro?=
 =?utf-8?B?a2ozbVRkMkxKdm5DUHJQWDNkenFjK0Nvek00WExWYUlzVlpkNFUyRGVBRXdw?=
 =?utf-8?B?N2diOUZzRndTc0ZEeWR2WDBpRjdpOVo0NUVldEw2KzBaYVAyV0JWQ1NQWExw?=
 =?utf-8?B?cWhsVCtMMzlhTXo3ZGNaTUhUVFc0VjBJUXVpNkxlbkFzVFBTOGhOM1g1eEhF?=
 =?utf-8?B?b1Izc3ZobHo3bkxKampERjZ1Nit6VnJZQnVGVldZQlZVR2JkZy90TjRTTTNh?=
 =?utf-8?B?c1Vha2JiVURJQUNyWlVLa1pwcGdseDluUUZWRCtVUVkrS2dMc1VXNkJiQXpI?=
 =?utf-8?B?K2hMeVhvWFh1QlhvN0hZUXNUV3hCMm01cmxWRVBCOWFKNTZjVk1OUnBjWTJ6?=
 =?utf-8?B?VWxHcG5rSENoQzFDY1ROMUdwN0dCdzFtZEFCaTI1ZldBM1g4RzB3V1dEVDRa?=
 =?utf-8?B?LzBkSVpUS2p5b2krMmExVTExWGpjdWM1SlpBYlFkMmtRZ3N4STRLM0ZnOHlJ?=
 =?utf-8?B?bE9Kekt1NHV4Nzl1NmV0RFFka0g5dHRyaDFTa0dSRHFYckJabzE2VHo0SkF5?=
 =?utf-8?B?MVJtejlwSUpzNnZsMmo5WXYrdmlnVEYxSDJ0OHhxaGlNYllqOENUZWVlYVo3?=
 =?utf-8?B?S3NSZ1gyNGVrYzhTQmdNdklMMFU2S3FNdGtodmhmU0Y4dlM2dnFqTzRjRlla?=
 =?utf-8?B?MlpLZUh1WVBYQ2t0ZnBnWXVDL0ZpQW5Td0xwR3hxNFJvc1pTVzZJMjlMaWFK?=
 =?utf-8?B?ckpObVdTM0R2MlNhWVhBM0YvRzVhb0lNV1EyNlI2bHg1RytySHc5Y0s1YVZs?=
 =?utf-8?B?OFFaRTJQbWxERFY0bGFvdklDTXg5Uk9UeFJsU3FQdGZDeS94R09Xak5iWGtD?=
 =?utf-8?B?eVR5aHpKVyt6QUdYcENqNnQvQ2dMcC85S0JXZHdzTHA1clVCNG5RdGRvMW95?=
 =?utf-8?B?T2QvZmtkQ3o1blFUQnVIanR4WnZxeHQ3SCtzaVpIMXo2KzBncmtGMXppU3JE?=
 =?utf-8?B?RlhpS3JPZ2hydFNWazZXdklvY01xU0M4TXQ2YVQyOG01LzNZTEJwTGRod3JQ?=
 =?utf-8?B?STd3K3JEeldDRDA0MUlQcE1oelB3YnVIemFQWVM2TlZYNUphZmdaOFI0akNm?=
 =?utf-8?B?ejJ3UlVpU05mbWs1R0Y3bzVqdjk5TkJrM2ZMUVNscHlJRGhNZDBkcEN6Y2t5?=
 =?utf-8?B?R2Q5aEVVdlN1RkZCVy9Hcy9wb200b3JoaWRkaVFDcHhEK1FGaU9rYTBlZ2dL?=
 =?utf-8?B?Smc3bm4yUk54SnVmYnlkKzFQY0MzMDBQYXJVRDhtbWFjN3ptREkyaU05ZW1W?=
 =?utf-8?B?djB0SFJXK2hmSEhPU2RIQ1R2SGprMEs5SHpSUlFFWkJRVnhzMUE5bFpjMVY1?=
 =?utf-8?B?aGhDU3kyeGtNT29EdEh1c0hmWVJTNDBhTy9ZZnUrNkNHSnpkTFR0dGFjOThC?=
 =?utf-8?B?TGIxaW1KdXVORStmSW5GcVB5VlNuNDh5S3dqWjhYL25KcEJMdUU2NlRzT04x?=
 =?utf-8?B?MDduTkVRRmN2N1ZicmdLZXRtUm83Ym1jeHFKZkhqdERtNWhBRExydHo2THRO?=
 =?utf-8?B?TDVtNlNhM2xTcGpyZ0hGYW9HWVlTMW9va29YWGwvcFp4YU0yVU9hZGtlbXVt?=
 =?utf-8?B?OW91V2dCUVFwbmJaako5WSs1QnA0RXhyTUlROXAzdDFLVDdOclFrdXpJWHdB?=
 =?utf-8?B?Qnh6ZDNLQTFHMUhXbitIbnQ2TGhMTWlVd2cyVmZ5Q2JjaG4vNUZjWG44cGFJ?=
 =?utf-8?B?NFVmM3YwNkNXN1h6bFlFdXRFNHErR1JQNmlnNFd4cUI2SE5HK1dwdUppdWlo?=
 =?utf-8?B?dkp3dHh5ZVFRTlVzc0VXUjdDZE5OdGZIc29OTWhZcUhlTDhsUmFCM0V5QkxX?=
 =?utf-8?Q?TuizoBDYMxiUkKsWe++gFBjk4FO+YM3h?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHRNYkFoenN1S2JLMFRxR3ZNdUpzQkMrQ3pVazdJVkhnT2lLcHZMUHNXWktT?=
 =?utf-8?B?YWlnM2pyQ1NLOHNCd1NQUXVPTzNZaTF1MVJsSkNKdTJtTW9BR3h2RjFNb09w?=
 =?utf-8?B?UFg4TWxSbDI2L2JEb0REYUdSd3BzV0VNWGpkME5GMGQ3Z2dQbU1tWXgzVVFJ?=
 =?utf-8?B?cnVDekVLalRLdnFqR1g4Y01CdVFvbmVsMUR6U1FSQlREeVpQVGlJQ3hibXBZ?=
 =?utf-8?B?Z0E2eDBRSzRYYk1XQThMYTgzS2RJVlphNURYUFNRRmIwWUxtdHRWOVkzMGZO?=
 =?utf-8?B?OXBZemRVT3Q3VkpYTHRFMnhvNGJKdGwxMXBxVVFxeUtyT3ZCcGsxazlaOVZx?=
 =?utf-8?B?eS9zNCtmVU42Ui9aUDhkZDRHK21kSlY3K0tGeWloTzRjNW1EL2N5WXVqOFNZ?=
 =?utf-8?B?ZmFnMklXUEhGbnlkNERIVTYwaUNCN2xZbGdleENJVkFTUEFzelh4Q1YzTG9E?=
 =?utf-8?B?QnZJeCtic3BuU1FmVUZyUUNmNURaVzY5RytaTHBvVWI0cDhPSGFadk1KUEVv?=
 =?utf-8?B?b0xRLy85cWNseDl1WStsU2VaQm1hbitmUlNrdHNJZDZ4MTJUT1l4Q08rL0FU?=
 =?utf-8?B?S2V4S2dVT01tVjV0NWt4cU95TlNQZ3QweDc1eUI4M0FCQzJwa3h5UUJhMkhW?=
 =?utf-8?B?QWxuY1M3QTRydG5rQ0JDU3lTRDB5dU5JS0ZKVU8zS0ZZZXZNNmtrdmVDSTds?=
 =?utf-8?B?QzZ2SEJBdXpad05RRDI5ZHdOVVp6dThEZGgzVDZJTXBTYStRUTE2Snk2VWJq?=
 =?utf-8?B?aGx3amtsMU9manNRRE5FViszUnoxWElIbFlhQUtwZGp0OHhtbC9vb20wSFBZ?=
 =?utf-8?B?Z2ZHc0IyN0g3azBCamtOMWltdWlud2pRRC9ZRXZrWGl3cWVPK1RMSTdsNGxN?=
 =?utf-8?B?YXBzWEhCenN1cXlPRjgvbWJGcUZmM3h4VjlzbjNFQWFBaER3UmZOc0Y5YWNy?=
 =?utf-8?B?c2FCM1BBanpCQkRNV0NkMUI2Q015NGQ5NnlURS9hdTFFQStldTdQVi9WUVZl?=
 =?utf-8?B?U2Nvc01ISHRvK0M1U2srMlJ5Sys3ZTZKSGpiSXFsL2lGV1pLNGgzNzJva0Vs?=
 =?utf-8?B?U1pnSTl1cW1xVEdwb2owSVZQUU1FbVE3aVMvVkQ1YzhDcTJDNEdGQmliRCtN?=
 =?utf-8?B?WncxcjJoOGdtMVBOWlZ2MDVhYTFNRFVNeER4L1IxQ1BWTXdsR0VBMS9FN2ZY?=
 =?utf-8?B?NER3eEZrOXBTU0VFbUYrSmJ5TUhvMG9yQ3h4RWhnN210VE02Q2c1ZzZ3RUZq?=
 =?utf-8?B?RlM1WURuL3BsR1V3MVNRRG1HaFkxcHQzaXRZakdvNWxiWGN5Z1BMUW11OUhI?=
 =?utf-8?B?eGhCcVQzNFZ1WGJJWXpCaVRJQ3drckFRQzVseVEvSjN5U2hrQWdFS2cvU2p2?=
 =?utf-8?B?SVZEWlo3NHlMWDF6VGJCTTRDNDFhV3JLMHVnZVJHZU4xaEZmeHNCUnMzY3ps?=
 =?utf-8?B?UWpKOXNJRkZnRm44YldZUDFCYkZPRGlTUTBXYUsxeUQrd01KcUNjSkxIaUI1?=
 =?utf-8?B?dWt2UVByR1NXQ2FOMmRjYTFUZkVzTW5qTHlrN2JUbWFaZ2J1YTFQbjZ1SURq?=
 =?utf-8?B?eExxVldiS1VMRkxlSUVkT0lJRTdDSlY2MUFkY1R0Tk16VmpsR0lMejRrL05v?=
 =?utf-8?B?ejRiZlhyUWdxUko3N2RZMExObk5Scy9HU2oxMnR3aGVXNUl1Q3RKd2M2YUFO?=
 =?utf-8?B?UndwYVcyMU5ncllwYmNwUTRvRkNCWXpmZEQrdTRTUGlQUW1HeEVoTnY0ODFG?=
 =?utf-8?B?U1NtQVFiZlBkK1VhTmtkemJpeEY0ZU9IQk5wM1kvQjA5QnNYMkgzNnh1QmhF?=
 =?utf-8?B?Qkp4MGxKTks5OHVPZGJBMys5RVlGK2pkaXNrNXRvWGY1SzRtWWVzSGdZajNz?=
 =?utf-8?B?S0JHYzY5eDVoRXhJWExLYm05bWpKR2R2TEVxckJnYWNaOUhsdGNuWVRhQzJn?=
 =?utf-8?B?SXMrUnRpRi9BWDkycmZOa2d3aTNBM1dQRGF6SzB4VnYvSmM2ZVlWSUx0MEV3?=
 =?utf-8?B?b2xUNVRNUVhPQjc4K3RHZjRFYVFnZHVsK2pGYzRtVVJ6aHplbFE4dEkwWGY5?=
 =?utf-8?B?Z3JNajNhTjhaU2x1bmd4SnZZcWpLbHhJOGRqa2sxNC9oQ2tNa2FHd0pBM0M5?=
 =?utf-8?Q?2uUIo8cfI7USj1oOoPof5C0X8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64eb3072-d72e-4bae-8514-08de0171851e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 05:07:01.3000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AbuHzpfycbhyJFA5YXryh4BxshuoZgyu70HebfXDV2J7PP1aWFxqPhU1qNeow+dWMFe69a2tsjvEfOBxYC5gQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147


On 9/10/25 13:42, James Morse wrote:
> The bulk of the MPAM driver lives outside the arch code because it
> largely manages MMIO devices that generate interrupts. The driver
> needs a Kconfig symbol to enable it. As MPAM is only found on arm64
> platforms, the arm64 tree is the most natural home for the Kconfig
> option.
>
> This Kconfig option will later be used by the arch code to enable
> or disable the MPAM context-switch code, and to register properties
> of CPUs with the MPAM driver.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> CC: Dave Martin <dave.martin@arm.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua


