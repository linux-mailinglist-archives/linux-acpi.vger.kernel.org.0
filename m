Return-Path: <linux-acpi+bounces-17496-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 542D3BB27A9
	for <lists+linux-acpi@lfdr.de>; Thu, 02 Oct 2025 06:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A7D3BB0A6
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Oct 2025 04:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E6D1FCCF8;
	Thu,  2 Oct 2025 04:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UkpSo1Dv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012049.outbound.protection.outlook.com [52.101.43.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CEE28E0F;
	Thu,  2 Oct 2025 04:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759379458; cv=fail; b=ZNPk4TAtWne3rS73oIioujVtL/dHDBHudNAx35XN7beClFZlLAXT+bciFcsP4MXimX4bwTQlGbXOIh25XoPp0NDDUMB+Jmil8FLKoSvOTWhIT0X2zFvoid1QpbwzFszyvqpkdXZgRefIUe7G/DyE17v9/gF8kBqlWqu6tuziIXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759379458; c=relaxed/simple;
	bh=1W9JtObHfsmLdfRkBhah2rK7j4nHvPfCRWHU0zzyGxQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RQeVQhU+HUgzkwnpnSgGU7D0rWnoNx4wqLCE/8xO+av8tuJtKkUPmDhn3pF7NbBMC4stb4x0Y4YY0NnY9zHDWOvANtdxNRslayUcEOfU43yb+ua3LvYo75/Y9qEMsEiOnaY+GaJP3duG8G2YQjJWxO1YF7UnzrarrSnPdkvABOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UkpSo1Dv; arc=fail smtp.client-ip=52.101.43.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hYNfEKkwYkqEKXsIUCedB8+tfgEGrTJc9/wemgq8R15KP/6UIKn6a0E5PJO6BNt6Mzy4U26QhLA4fsuvSNE/00Cf+8RF3aG85tQnT6CuyVYfrG6aLzGpq9ItvoGDcavhLydtO503mhUW9mheF414yospiv1kg8voerzj7sBhiRoab1OLnu7L5b2yB6dvIcbVbctegD1KD7oG4MiV316TSmgLo//7UxJWClzNRpsxWaJ/6EPCzfhW8oSF1IF+Lsmv7XfK3WLqwGM+JPyto9AfjkDyZxOCp/eGkunU8+bu6USitUCaDJbxw4SRlr+CANrpgQtcLaEk3C2AWsMTmvmJdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzYNChO+i3pZbzDFTLsUFdXtaY5mZIXMJZLZF1/CgHw=;
 b=ReCRcGKrD+p5SeSE4TUMPMDVUGIDJjU7X3egyczcBOjUulq9LuHsOoB8Ef8dDJMd81Kqwk28QppMd+AR88N5gqyVddomCgAdfpcctfsyKEofOTzmPHDbBQ671paPR/35lQJR63B0m5HtnfmS8iij6ySnluOjKH8IfuhFbj59sOhFCSTKRz1xJHamJGBv9LT5YTR8AmkMFiG8qr4Rtd6P3MxjMPvw7oletnEulTEeqmBAJS91qVIBJPuXSuJFlu8THRhus1wg9r6J2gnQ2eARRgx9BacS9zTCOdrS7+9FGILJzrJ8RPYlx4s2fFs76/HX7B0ysT+Np3TD2q5TueTTIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzYNChO+i3pZbzDFTLsUFdXtaY5mZIXMJZLZF1/CgHw=;
 b=UkpSo1DvF8Hdh7dZQ2YDqT/3rTRoNnuTurZ7E0lcbrkfM4SwV7Fm4zNa6eFdAaUzJYzBK/+RmUUy11kRfDZ3zd5PmJ2jKD9BUtD5vr9I+DbdWGLu5Xa+iGqMO4BJjMQWk7GO7BYCFuIfjQ+79Bz+mfCRwJVb8I0WmRdi2weOYsBjYKzXN1V7P276M29vt1rolntslS/dgSOtoWdnI8WiW+6z+EKNrXqwLpUXM9lwoHdNF2gKfOLzAKyo04gGb4GgvqEghnP7uxzHK5qILgnCYHTveLvJKTYG5qWjjsxsIQ8kkNZqZJVgMnxkpXEnzkBpGAfKAGnaPcVyZckUeoKe6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.18; Thu, 2 Oct 2025 04:30:49 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9160.008; Thu, 2 Oct 2025
 04:30:48 +0000
Message-ID: <5607ff12-1445-433a-b9f7-fffe20076be3@nvidia.com>
Date: Wed, 1 Oct 2025 21:30:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/29] ACPI / PPTT: Find cache level by cache-id
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
 <20250910204309.20751-4-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250910204309.20751-4-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0048.namprd02.prod.outlook.com
 (2603:10b6:a03:54::25) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SA1PR12MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f0f9336-00ff-42fa-a759-08de016c763b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFMyMVgxVEcwZnRrZC9aaW9jamptVTA3dGhMRzBXcGY0V01MR3luMDNydytY?=
 =?utf-8?B?bUlRWHZYZ1liY3pqMHh0dzAvcUZTOVd4ZjRkQkRZWHM2aS9ORWhYSkhXb0Q5?=
 =?utf-8?B?dW5lc1Z2NjlXVDlqVTdBaDVwYTRaYXEzQmxidzQrUmx3clRqeWpRZmF0Rmcx?=
 =?utf-8?B?Q0k3VGduMW5OeUc4TGxScVZEeE82aDJrbmViZE5FVWtmMG5oOHVBVGpmR2RF?=
 =?utf-8?B?WlQzR1MvYUhSL0pwMUlDWnowNGZaUkV4TXVNSnduV1BDL29idytTOEVDajRo?=
 =?utf-8?B?RnNHZXRDS1JSaVVZeEhOMjZUdy9wZnhkVFlxaW5SblV2ZXhDdnJLYWdiWkI5?=
 =?utf-8?B?UzdKa3lzSlgrMnczM2RpL0ZHVGNwOExTQUE5aVhUbHJjNGZjQU5acHUxMHFX?=
 =?utf-8?B?bXNKL0UzcEhnWDZyaXo1RVVDcDQ1V3VLL3ZZSktuOE1jaFQyZytZcGVVQm5q?=
 =?utf-8?B?b1hlNWtYeHFpcS9LNU1SMmRkSGZwWnVJTk1pRGNkODJEU1ZPQzNJMXBRZjcr?=
 =?utf-8?B?Y2RwQ2c1SG9Wd25JMlNXWkZqNXZLNks1U1B5SDdqakVhRm1JNG9VeTlUUU8x?=
 =?utf-8?B?VUZoMVQzaVVMdGNnU0FQUi9DYlF4TkxudmhLUDd2bzk5UFJodTk2WkNueE1j?=
 =?utf-8?B?V1NyMW1ZdGgxelpJUm92V3RvN1BKMjMydWRid1lFQ2svTnM0QzU1WGZFWkFQ?=
 =?utf-8?B?bWhiemV5R2NPN1c0YkZpUjZKVkp4UXhLdVU2VHBvTWFPK2ZLbk82Rko0bE40?=
 =?utf-8?B?a2tTU1VvVjBMV09zY2YyMlRmUXVmN09JbDBocXdCM3I0bE94MlZuUFUvRGZR?=
 =?utf-8?B?SGsvSmFWZms3d0Mwblh2ellrT2U0R0o3SzV5djJOcVhsZXg1TlhsQitFUnAv?=
 =?utf-8?B?NUNRcXhvMnFqZ0Rub2I1bFYwUTQ0aG9SN0lUR0Qra2R6UTVNWFQ0UjdUMXZu?=
 =?utf-8?B?aklJMDBOSHZWSXA5WGNIT2d3cG5aaW12K1Z0b2Y1S3ZJZUM5TEJnNEVoM0M3?=
 =?utf-8?B?L1ZtR2UzTHR0alFvMjFDZTdKZXdrR2ZpN2FQOTR4V1ZyZ3F5R2sxZjM0NWlt?=
 =?utf-8?B?U3pmV0RyOUMzb293SDhQNGVqZ0VpdnNyaC9ldHhxQU4wVUV5QkRBQ3NhUnht?=
 =?utf-8?B?UENYUktQS0tBTG9qQ3JoUytEb0tvcUtVNnB0TytrN2x5UUNsbWsxSHNNZGlF?=
 =?utf-8?B?bzBEaktiRVliQ0c1ZzVQUEt0TUYvUGpxVzRRVHExanlRdFhtMm4zZFFyYzlS?=
 =?utf-8?B?RHRtUFVWRU5wUVMyUENweE01aEoyMlZJdStyZENKV1JvTjFaZzRPZkNHbjVz?=
 =?utf-8?B?ZEN4THYyMk5IRGJqTXFFU2oyQzhCclpKL01CUm1selJ1a1dKc25IS2ZSMTRM?=
 =?utf-8?B?ZkttelhWVkZCc0pMYkhZRkc2RlBLSk4rNW95dkt2SmZhRVkrczBBZjRvTEhG?=
 =?utf-8?B?ZkRwT3dGdU00cC93dDdGeW5JRWtUOFdnTnJKU3RSRFNVYUdXYURLUVUzWnRs?=
 =?utf-8?B?YzlyNmRZYmU5b0poaVNzcmZON1dDQ0wrc2tTL1NJRG45UE1qdENnb2lYaGlJ?=
 =?utf-8?B?bjJrRVV5dkNCekpRMnZkMVFJdDZQYmQwRzRHNFFYNGZ5YUcxY29zb1dhL3Mz?=
 =?utf-8?B?d0NaTU5aSCtqRjJQbGFObkE2bTVSc2RXRDN4L2NxQkpHVGxKOTFndTdCU1JB?=
 =?utf-8?B?L0FMcWRNak1NWHJDYUJSMmNyYTJLY3ROUGxERm9jTDNjVmlHbHZReTFCSXd4?=
 =?utf-8?B?a2ZGbVZ0MW9uMzVEZno1Z284aVQyL2J3amdadTEwanF5S25zT1lmb0g5UStM?=
 =?utf-8?B?WkY4S0NneXpMMmpuWlU4b25lN0lNWnVlWGwwUHVrZU9aZ1pxNFR1V3NIT1pQ?=
 =?utf-8?B?SHJnQ212eDRWd1lITWp6dTBLV2hhV08xa2JmcEpFS0tnelFtaHdQSlUrSm9F?=
 =?utf-8?Q?Qdsmky7Dy2X1fxM2shR5KKfwuKwVTaol?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjdBUk1WaTVMUW1EZUVyQ2hKMExPZmdIR0JwaXZhMUQ2MG5aQjgweGZRWEgx?=
 =?utf-8?B?Wk5zOTNxdy9GM3NQVkpTeTl3c21jU21YVGdMNkl2V1NDU0dHQUl4MjNJL2Fh?=
 =?utf-8?B?MmUyOU1NR3RqdERld2M3a204ZENXK2dEUklTU2F2c2NHcWFZVzUzd3NMUmpz?=
 =?utf-8?B?ZnVQdEJaM1NBaC9mN3A2OEpaZEQwenZ0RURDNm9DU2wzSFhjcnkvcDBjaU05?=
 =?utf-8?B?bktPcXl5V0tRS29wZldKcWdOYzRKL081VmM5T3dXN3FBbm9ndklkWmkvQkpK?=
 =?utf-8?B?RXdTUTJHUUhLMjBDZVlDdTBDY2JabjQxdFlCbHhGa3NhOVdSajV2b2RBSHhk?=
 =?utf-8?B?Z2gyaVRnYjRxdHdjVy9Qb0tFY01lK2JQUTJmb2V3ZUM1ZERzOUVaSGVzaUpX?=
 =?utf-8?B?eU1GV1llTWFTTlNLTjdSRXhSTkxBenFQU2JwV3FkT0UyZVpUMnZiMXR2L2M0?=
 =?utf-8?B?OGZ3aWhJNGVoN2FyRTdmelhuQ0lDYlpVcmFvZm5PVEY0SEsvRDFwYzdKY0xS?=
 =?utf-8?B?ZGtlZ2JnaFdVUFBhazRzOWszYmR6NnhwMnBrRW9QYVNNQmNQV05UT0ZBcUo0?=
 =?utf-8?B?UmR4bWExUW1MMlRDd3IvSGVRa3RXemVRMktzV1hvMlM4KzRPZW9CLzZycTlD?=
 =?utf-8?B?bCtpSUcrY08wRjN2NEtKeWd3NWtCaWk0dFdKT0JVcG9heUFWcTZORXpSMDN5?=
 =?utf-8?B?QWdRRUUybmJuTm1xdnFwOVFQL2RvS204U2RJNDROdnpBRmtRWklTeVdDc1dZ?=
 =?utf-8?B?eGJoV24yb25UTWtCc0FtZUl3cFkrdnBvZURYdEhxQlZKRytxaGpNN2VTd09M?=
 =?utf-8?B?M0FKa254ZTgrY0lZNS8rUTJWU2pOdCtHZ2lLR3ZHUzRiLytNeHI2U1kvM0lN?=
 =?utf-8?B?RkdRNTFQZXZxdHhXcU93YkJxTDJjRVhCbVlqN204YitOVVQyWWlBRDdHamlh?=
 =?utf-8?B?RFoxWFU1Njl3NmErRU5RKzQ4aHA4eVdZZ0dYaS81SUtKelU2Q3VlT1JMZTg5?=
 =?utf-8?B?VGhXRmJqZW1Ib0JSL3VhQXkrdXZUR2hrb3pONUVESG56cTY1U0hpb1Y3eVBO?=
 =?utf-8?B?VjFVK0ZWQWVZMC9tMGN5TnhEYUR2dDI4WGVaR00weUJXcjFWYStTUDdWdFMz?=
 =?utf-8?B?bG82OTdmRHhOYzRTOG5kS2VEem1URC85cStHS0hOTnFkeEdyUFpOOWhsUlhu?=
 =?utf-8?B?STY1US9jdStVRWlBU2xIZVp5N2F3Z0M2OW9qVE4rdVhKMElseHU3ZnZoMjRG?=
 =?utf-8?B?NnFVNHE5SzhvbnFLTFIzMGYxMzkwVkxKWUdReEpqUWYrQXRqaFBPemlvWjNQ?=
 =?utf-8?B?Z1htNCt6Mzh5cExxU1BMMmVJZGUxYzFLdU9xZ2d6RzQ0M3BzQWpLcElEOVdJ?=
 =?utf-8?B?YUp6eTlTM1ZZSWs3M0J1SEozcHZWeW1tM2NDVVZZcE9YU1M5RUtzQVl5MTN0?=
 =?utf-8?B?ZkRxOU92TzhZTjRDZ1FvZVY4QXY0RjM2Zkd4SjNnck9Da1BOSmhsT040K25P?=
 =?utf-8?B?YlE5SmpGVEN3alh0a210MDQvc3k0aDE4UUU5S0ZuQTJwMy9Gb09BazBRcksr?=
 =?utf-8?B?VWJYWDAvb21BM2Y0VUZwbjZMbElvMkVVc1NSL0x1TFZCd1picTFEblRCY0kv?=
 =?utf-8?B?bVRVUldUK01CU2R3NjJ2R0lWeHh6N3lzandDMjd2WHF6d1JyZ0JwbGJUZEE5?=
 =?utf-8?B?V09qeXhHSExWZHNraEZJay9pazR1UU9lQU4ySlZ1WGFVMVhCZ1FRUHFqOVVw?=
 =?utf-8?B?SGc4L2tFOGU2dzErUlB5TXJMSlJSemJVaSsyb0RjcHB3QkhDRWFTZUN4LzE5?=
 =?utf-8?B?N0ZkTWxveisrcTBxTTZycHBMUW42YUlLNmFPaUlITGVPSVB6UldFbDhsTGVB?=
 =?utf-8?B?STAzTGFnYk5iSjJxT1JxaDNrdzZWSlVvR3E2S2lON3Z6czNZSXphS0I3MTFB?=
 =?utf-8?B?ckVmOTVtWEwwMy9yR3Bnb0NZOG9mSU9XeXFOcE1SN2dpT3dWWFdPV0ZHSGE5?=
 =?utf-8?B?Y1NRN0FMZ3dRVVIrbkJNbWpwendGc0RHcTNDTkVIQkFPSnZ5WUwyYS92dFN0?=
 =?utf-8?B?R1NCY1RjUmR2Rm4rUVlJZ0xER1RRb1lsWVhFaWpaM29IaTd4RlU4bzA3RFVy?=
 =?utf-8?Q?HaVcOIkOE/go97S/z7FfGv52j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0f9336-00ff-42fa-a759-08de016c763b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 04:30:48.7461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rs8W+VO0eK+0NI0tmXqKA359Sq8kss7MSEUf7UKdVhRA3bz/2sItSDprgjNbRo6PUKDfRovX8VecA2W8pBhkuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614


On 9/10/25 13:42, James Morse wrote:
> The MPAM table identifies caches by id. The MPAM driver also wants to know
> the cache level to determine if the platform is of the shape that can be
> managed via resctrl. Cacheinfo has this information, but only for CPUs that
> are online.
>
> Waiting for all CPUs to come online is a problem for platforms where
> CPUs are brought online late by user-space.
>
> Add a helper that walks every possible cache, until it finds the one
> identified by cache-id, then return the level.
>
> Signed-off-by: James Morse <james.morse@arm.com>

Other than minor comment issues as follows,

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

> ---
> Changes since v1:
>   * Droppeed the cleanup based table freeing, use acpi_get_pptt() instead.
>   * Removed a confusing comment.
>   * Clarified the kernel doc.
>
> Changes since RFC:
>   * acpi_count_levels() now returns a value.
>   * Converted the table-get stuff to use Jonathan's cleanup helper.
>   * Dropped Sudeep's Review tag due to the cleanup change.
> ---
>   drivers/acpi/pptt.c  | 62 ++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/acpi.h |  5 ++++
>   2 files changed, 67 insertions(+)
>
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 7af7d62597df..c5f2a51d280b 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -904,3 +904,65 @@ void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus)
>   				     entry->length);
>   	}
>   }
> +
> +/*
> + * find_acpi_cache_level_from_id() - Get the level of the specified cache
> + * @cache_id: The id field of the unified cache
> + *
> + * Determine the level relative to any CPU for the unified cache identified by
> + * cache_id. This allows the property to be found even if the CPUs are offline.
> + *
> + * The returned level can be used to group unified caches that are peers.
> + *
> + * The PPTT table must be rev 3 or later,
s/,/./
> + *
> + * If one CPUs L2 is shared with another as L3, this function will return

This comment is not clear. Maybe it's better to say:

+ * If one CPU's L2 is shared with another CPU as L3, this function will 
return

> + * an unpredictable value.
> + *
> + * Return: -ENOENT if the PPTT doesn't exist, the revision isn't supported or
> + * the cache cannot be found.
> + * Otherwise returns a value which represents the level of the specified cache.
> + */
> +int find_acpi_cache_level_from_id(u32 cache_id)
> +{
> +	u32 acpi_cpu_id;
> +	int level, cpu, num_levels;
> +	struct acpi_pptt_cache *cache;
> +	struct acpi_table_header *table;
> +	struct acpi_pptt_cache_v1 *cache_v1;
> +	struct acpi_pptt_processor *cpu_node;
> +
> +	table = acpi_get_pptt();
> +	if (!table)
> +		return -ENOENT;
> +
> +	if (table->revision < 3)
> +		return -ENOENT;
> +
> +	for_each_possible_cpu(cpu) {
> +		acpi_cpu_id = get_acpi_id_for_cpu(cpu);
> +		cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
> +		if (!cpu_node)
> +			return -ENOENT;
> +		num_levels = acpi_count_levels(table, cpu_node, NULL);
> +
> +		/* Start at 1 for L1 */
> +		for (level = 1; level <= num_levels; level++) {
> +			cache = acpi_find_cache_node(table, acpi_cpu_id,
> +						     ACPI_PPTT_CACHE_TYPE_UNIFIED,
> +						     level, &cpu_node);
> +			if (!cache)
> +				continue;
> +
> +			cache_v1 = ACPI_ADD_PTR(struct acpi_pptt_cache_v1,
> +						cache,
> +						sizeof(struct acpi_pptt_cache));
> +
> +			if (cache->flags & ACPI_PPTT_CACHE_ID_VALID &&
> +			    cache_v1->cache_id == cache_id)
> +				return level;
> +		}
> +	}
> +
> +	return -ENOENT;
> +}
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index f97a9ff678cc..5bdca5546697 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1542,6 +1542,7 @@ int find_acpi_cpu_topology_cluster(unsigned int cpu);
>   int find_acpi_cpu_topology_package(unsigned int cpu);
>   int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
>   void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus);
> +int find_acpi_cache_level_from_id(u32 cache_id);
>   #else
>   static inline int acpi_pptt_cpu_is_thread(unsigned int cpu)
>   {
> @@ -1565,6 +1566,10 @@ static inline int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
>   }
>   static inline void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id,
>   						     cpumask_t *cpus) { }
> +static inline int find_acpi_cache_level_from_id(u32 cache_id)
> +{
> +	return -EINVAL;
> +}
>   #endif
>   
>   void acpi_arch_init(void);

Thanks.

-Fenghua


