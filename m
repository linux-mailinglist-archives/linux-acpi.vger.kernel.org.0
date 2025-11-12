Return-Path: <linux-acpi+bounces-18840-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E2CC547C9
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 21:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 24A34346E7A
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 20:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE212D3EF5;
	Wed, 12 Nov 2025 20:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NXJY8N3v"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011058.outbound.protection.outlook.com [40.93.194.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E642D3A75;
	Wed, 12 Nov 2025 20:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979980; cv=fail; b=h8YiXuVaJ7QDJCCJNaPMP7nR8QNaPxZZsUiSLVR0BJoYifTELq4ImnfUetivuihl+f3h34B4JJpIhxiClHzkxgFqKm759AmIigHb1nwVPipS6Y/plfjw36ZpfTREM9gzcRbjdJt5Lc40OL00ZM3HagTHM+vsk9HV+AzXSI5r3ME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979980; c=relaxed/simple;
	bh=jpPgVTu+Mmrw/NLn+cI35yPqX1qTZ9nO56+rgMamESk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W1+2jBBKlhC7cPivP6kIFMcjmwW+aMUcKWGU3m5VajxyWT2X31s2gtAYuLYMG11APKeigrHyCB8oHXSFJy4sYhXQsWBnSOtNdD9JwZZPF09ZwzRj5+XTKsAWTNF20tKJrI2GqcQWBSTsFjmcWgbHUnZ0PyMBBwZkKZzhoDTve9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NXJY8N3v; arc=fail smtp.client-ip=40.93.194.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2av7b2wDqQl+ezPzaqTqpPKGp/FIscilC6kC43z3aqvuJvK4qsvyjLkpdVDj+6DQlmlRHcxxzVXdfI69V6YKk+ykYeOHfYgia6JEPK1bPso2SjNQYeMdkcon9Qcb3JH6arIKzrBwXn4m2x86XqoDwoByuk/VK9vkdkclxklztWUp/UBI19epgT7zsHdQ/4j3vQ7JPdIA2AeV/s7DxHZpMqCL+B+5I5mFMtdfIrMZyuXpGP8PSRww98bTwW/NM/IZ6VQqqzizPrEPRjyrvrwAyGey//07skEBNJnXpQ3YfVOrkY/79Z0d1//BqoTdoAkIEEa/009NcXzSOH24T+aTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZurKfd2bhdEbsw5S1ss+bxF/jbnbku4yxDKjQn2bvs=;
 b=t8cJUEllQS6B1QXH+qcJ+QrtxDGURRynFclg5w9HSmEOmR/1YzMP/9W9/kBPeI4bSIs+QHUHSXzqLNjCmhy5RrLg1QDibhbc3KOz+FBj5AcvlyDgFuQMBASznHfJBZ6ywdCXLyxPMxDzvQf7vEyoR8NbOX+8/5qxL9ncafhlBxTEtxLx3QQr5nOVEAdR32a5PO4FI0sKrZND9PJv1KaBmGEM/W4ZrsoCJDeNW/lFPkYcyEc9HN7j9tJgrXKIjKQq+G9CsjljRRjxXM9L1zcYoEril0J0TxJzx8YmNAjB9tQFS/jCkcImd5Yzz6grTz8qhflxvsoepFrEzAL3hIBvaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZurKfd2bhdEbsw5S1ss+bxF/jbnbku4yxDKjQn2bvs=;
 b=NXJY8N3vBlfDOkO4poQJhz0rj1knvXD4OfcdLHB0j3srBg0MGFyfxORmJPSSaTWqADrg5arvXXpEYrgjep11PKaRPvQeIsRSEuFGZXMS0JmlNUlE4aTK9C85EWg0AZ8Ea/GGomKMwReVa5Hdb/3oGmYutdwbvV419I+lkmPEa1wXJQswN2hipzNGw5K8DO9KOkmHzQ7as71KnpoRsUbXql6tSUxtiGIvAIScKihCFl4hca/Y6SpRfeB1+1N3A+o/z3/gVqhpx1a9Q66HGKOGyh7rJeh6un/+0Bio/8AVQmJhoU3oZDdY95WTz2N+5pY1pmNsN+GfCJwqfwFOlVSD4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SA1PR12MB9248.namprd12.prod.outlook.com (2603:10b6:806:3a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 20:39:34 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9275.015; Wed, 12 Nov 2025
 20:39:29 +0000
Message-ID: <13376c0c-8a33-43bd-aa72-b696baa2932b@nvidia.com>
Date: Wed, 12 Nov 2025 12:39:26 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/33] ACPI: Define acpi_put_table cleanup handler and
 acpi_get_table_ret() helper
To: Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 gregkh@linuxfoundation.org, gshan@redhat.com, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-9-ben.horgan@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20251107123450.664001-9-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0145.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::30) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SA1PR12MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: d4545f4c-cfed-4eee-b711-08de222b93ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0ZOakxITmhWL1RhK2luSlpJalRYTFVUSHZ1eTNFMmpWZ0ZxbFZMeVR2L0gz?=
 =?utf-8?B?TGtzQjV0allFVkRWSDhFQm9SdTczUHB1NkZQelF2SVYwOXpPZE5uZUxGMmxr?=
 =?utf-8?B?ZnlUV0l5YXBiTTl0SVFMY05MMVZCNjFkMzc5bUo1QWhqRktlRWgwa3IwRWlK?=
 =?utf-8?B?OTl0V3Q0eU96MUNjWUVnak5pS1gxalpyK1NsUjV3bVNnM2ZLcjJibjNKQ2pW?=
 =?utf-8?B?a2VBa2pycVhzR1hFeFBuRVlqd1l3V3JSUHF2RStzdk5iMVV1cFVBZWg1cnBH?=
 =?utf-8?B?dVdFWUpYbjREcE80bm5PWS80dkpYSHN2RGxraUc1cHdwTDV0VkdoeUpmYW4v?=
 =?utf-8?B?WitmZHpqYWdXK0UxaXdSYzE3VnBVY3FiTVd6UFI1b1dDTHBRRmExSWpKV0xk?=
 =?utf-8?B?OU0xU0FRa0x4YWxwbmdDT0p2REJ5Qml5Wld2b1hqQW5jR2Q3a1g2akFxbzVI?=
 =?utf-8?B?VlZZV3dRamJFeUhFNU1lZ2xwTG5HeVJQQW83UFhUWXFhT090ak56VHVzeUZZ?=
 =?utf-8?B?S3NDaWJ2Tkl1bHB2UDJZN29XTlA3Tis4bnhMNlNBUGxsUVBWaGVRWGN0dDZx?=
 =?utf-8?B?OEVRWnVoTFpSVVhsUFdBcFQxbWJKbWJiRWZtZWdWc3NqQTBZV3BkemlRTlZC?=
 =?utf-8?B?RHd0YzlyNFdFSEhUaTFnb09iTHJ4b1RBclJoNVNaQlZBL2w1TzViRk9UdWtG?=
 =?utf-8?B?eVZvREdNdGlId0NzZ0RvenBjU1BmUnVyNzZpb3VQWHpWeW1CSmlJekZRbW1N?=
 =?utf-8?B?RzJKY25LeGFwVzdlR2hHTzlTaXB0RDl3NTY2OFhOMWJIL3dLUGUzVW1zcFF0?=
 =?utf-8?B?MGxZQy9Jc2VwYWV1ZStjU3RVNjdSdEtNNERSaUZoVGhDNlFTMERhVTZQRXdS?=
 =?utf-8?B?OFduOEJZMzhVQk11SjlhZjFDNGU1VmMvMkpQTjBPYy9vdU9JNjV4UlpvUGxm?=
 =?utf-8?B?KzBEVjFkVzJ0S0hOdmFCcjg4U0RURmxoYXF1NzZHNHNsM3I4NVA2MlpLdDRm?=
 =?utf-8?B?dklRSWp1M3U1VVEvTUNlcEVwV040WFJyUUMzVGdwMEpNQktsV2JvUW1EQ3A1?=
 =?utf-8?B?NEQ3aGFOVGNROWFNU0VINUFTOFVSbFZxOXg2Q2JrN25wY0pRYjFxQkd6MFdG?=
 =?utf-8?B?UXJtbEJucHJJa3RjUjBhenVZbWIwcHZlS0g1Yi9CSHhPVVE4azlqRUxpWStz?=
 =?utf-8?B?TTFXVzVrMFMvQmp0Ni83dlJwL3FUcy85SEp2cFlNdE5RdVd2UjFNSzFXRTR4?=
 =?utf-8?B?KzV2Y0FEOS9YRENadC9NM0s4UjVyd0lQdE5ZSlpyWDZRVHBIWmRvOGRmdkgw?=
 =?utf-8?B?bWIwRkhiQjJQOEQzWWUxbnphMUFublRGVmN3WXlXaW82RVNXNDcweXV5YzZa?=
 =?utf-8?B?VEV0U3NUVk5NY2w4Tm9sMG0yT1p4Y0RVdHNLUlhsWkRyWnY2N2U1clpGUGtM?=
 =?utf-8?B?RThobS9wSGY0WWJaODFqd1BST3hzSXlFTEJLVURGME1iSXNnZG5kZ29nYnl4?=
 =?utf-8?B?S2F6REJxRURsTDd0b0NweGQySkFQaHhmemxuYnBpZTlKNWlVZE0rNTJZSzRY?=
 =?utf-8?B?U1JsVTdUVXJIUXRpdHVqV3U1VTdSN0plK0t5UjkzR3NaMUtuUi9ZeVJCbldC?=
 =?utf-8?B?Q1UzYTFQMWhMVVZEQWhwTHU1emtsT3JuYWpZMWFsSzVLMVpCeU16a2t1OTRE?=
 =?utf-8?B?bnhzeFQrVWhwb21ibG9OZWRZNnFQd3NlUHpPazcwbk9XUUlUS1NETUFsUGFO?=
 =?utf-8?B?YUZTYkMvYjZzR2k2dDZTcEJ0Q21CVGl4YlFlOW83QzNJcDdlSDFEaDhDL3BZ?=
 =?utf-8?B?MFUrTlVyay9WcGE2NzIrcEpaelNPZ0dZOTNzcEh0Ky9vbUM0NzJncFNLUUVq?=
 =?utf-8?B?dmJyS0NYajE0Y3dVR1RnK2tIOUdlZWNVOU5xa2RrSGxvSVNsWm84cHNWeVZQ?=
 =?utf-8?Q?S/zxkcuR8PLnJddm3bln7eM0n3pkcUZs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTd3SGM1NG9XYitoV0x1Y0Yzd3QvbkYxOHY3RTNQbjZyMlFpUzlMU1l0NVlR?=
 =?utf-8?B?WmgrTEhWaDJnRFBpTUdUei81L2dLa0dCMXNvbTJWVGhoei9XbUROSk80Y1Jv?=
 =?utf-8?B?S0N1QnhxK3VNSTloWUFkb2w1d3hPdk5raHVGbElQTlhPamN4VUcyeExXT0ky?=
 =?utf-8?B?SUEzMkRWL3dpZ3RoNFh1bkxQajlRd1pySXUyT042MFhjYVIyWXc2b3hZUWc2?=
 =?utf-8?B?OGEzRnFHVjlhb1doNDVNZWc1TlJBNDc3MGozaGVnRktjOXZvOE5PeUtmUDRT?=
 =?utf-8?B?WjNGdDNlcFVRa29ESDRVVGdzZzFmQXJ1VXFkSzNIYkcrOTlsN0d4TGtOYmJ5?=
 =?utf-8?B?M2JJeUN1WE40Q2xCY3V4MUNwZnBSaVhxVFJTbTZYNFdjcjBOclZDSFR5SEx1?=
 =?utf-8?B?aGJ6aytFSzc5blludU9PR093Y20vMC9DcDgrYUxXV0ZkSFRLNTRJOC8xeTVI?=
 =?utf-8?B?TjkxY3VsWXcxYzluc2xFakQ4THQrZkZvRTR2ZW1yeFhaaW02OW9VcDBlUlhs?=
 =?utf-8?B?TWNxSzUrdDZEYTRJQkVZMjN5WERZNmtYZWJvUFd3RWZ2L1dBaWo0b2tTZ0Z5?=
 =?utf-8?B?NkwyczdYaHE4R2VSdk5uK3FmbVA5NHRRUzJXdnI2ZmJhckFYYnFZOFFaOHpU?=
 =?utf-8?B?cEsva2hUcS9NZDhOU2I1NUp3ZWZ6WlUrbE5qaW9wOEZ1cjYzaU5BOE5iQXBZ?=
 =?utf-8?B?SFd6cHpKRzRXZVE1VHpxTk9ZVGRxZzRDZlExTXVXZHRnT2VZc2QyQ1lHaHZz?=
 =?utf-8?B?a2EyTDNHQ0J5cHRIaEhzWnBhdW1kM0RyZUhsR0pVQ3lpZm4xOEtJMXF6d25n?=
 =?utf-8?B?L1NHbWdyb1hkeGVmS1UrSjYxZnMvdlVjVUZ0aHRGcVZVMllrN2tCdXlrcy9x?=
 =?utf-8?B?R2xRaHZYMjJDTXBmVmV0Y0c4K0haanJGY1puTDNQSGd4b05za2w1ZnhFbHpx?=
 =?utf-8?B?VStwOC9HYkRsT1h4VDJUbzBjNTljVVpyeVV2ZkhpU3hWdVlwSG15dFdVcDQ4?=
 =?utf-8?B?SDZrUEpwUC9tVTdqUzlCK3BFdG91NWl6MCtLb1dXeUZqNUIzVDVBUGpEVjRD?=
 =?utf-8?B?Z3NnU2c4c3JKMWxxaTYwNW1kUjYxYzgzcXVtUzZ6a2lleHRISzVpTmdWMjZR?=
 =?utf-8?B?RmFnSDFmaGQ3NDFJdG00Uzd2a3pBTmFEVzlDR3Jsd1d2Q1BlZnN0TndieTIw?=
 =?utf-8?B?WWo4RFhJdzNvZWxDclFRQ1NiR1BOZmJ1K25qRGNnVDFqTEFTSXU1c2JDQ2wz?=
 =?utf-8?B?WW5UMmZWWjVPSmZ5alBaS0dCT2tBYmtBTVVrbXVsMHNiYWJxQ2wydTZXU3RB?=
 =?utf-8?B?Rkw1SHVBT1ZEZDdWSG1rWDNCT3RqUTVBUHR3bFVFdWVtZWx3aEtXc05HUnFF?=
 =?utf-8?B?anp1bTVRSFV6NWw3eloyd2pmaVcrTjd3bGdhbll1Qzg1N01BamVMR0VFTDhV?=
 =?utf-8?B?M0JJMkh1NFBVaElJYmxPS3k0cHBYWk11bHNzV0lCdDhvc09EQy9MRURBNXlE?=
 =?utf-8?B?bUVoMHI2b1hBeUN5L3B5dFpGWnVNZnZ1U0Y1ZllkcFBVV2FkTjhCVEpraFZq?=
 =?utf-8?B?OGNYOW5nRWplV2NYRHVZM3ZlYUtPV1JKTHNBNzAydHRNNmxNbFBYNmdwMFBz?=
 =?utf-8?B?Y2lPY2ZYblo1clBuR2h1ZStIWFRDaGloQWdJYTIrT01mdWI5dWErMFZ4akVI?=
 =?utf-8?B?RDJNNmJZc3VoMzNpZ1U1emNJSFNjVzFvMGp5YzQ2eGhRMmhIcS9EZG1RaEZo?=
 =?utf-8?B?aHVRMHBqM2NNeC8xR2ZZYVBKZXgyZ1drTkVYemZIMVFhb2FDTVV5c0NyazV6?=
 =?utf-8?B?aVJnNUdkaGxvMCt0d29nQUdEWVFjZXJseEJIaHdNY0grOTVpSkhnV2Z6T1FV?=
 =?utf-8?B?ejAwK2szQS9Ga0JoVzBqSEdWUDErbVV3c05EQkl5Tm43TmwwZ1hYWEgwTFUw?=
 =?utf-8?B?RFlQTkRsYitKMWtYQlNhemZYTTZKMWI1eVBhZWJ2UmhZQlRTMDRrbHE5Lzl2?=
 =?utf-8?B?WExhWnlNUitSdHA0VmN6c0djMUV1NlFUWnRTMSttK1l2Y2Jma25Xc1RUODNt?=
 =?utf-8?B?bUhYTkRJUE4zSUZnZlYxckIybGNVb3oxUEN1ZkNOSVVuZWVoaXhHdU5ES1VZ?=
 =?utf-8?Q?xUO/4EOD5l51Oi0PinP3KGDP6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4545f4c-cfed-4eee-b711-08de222b93ca
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 20:39:29.3953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+L+BX0RqHzjYlsZCbpzNcIpn9HqBn24OnLAYMSlXlUhvC9uL/IDeCrd305N4g9n2dr3GqWGx1UWXuO95PFzsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9248



On 11/7/25 04:34, Ben Horgan wrote:
> Define a cleanup helper for use with __free to release the acpi table when
> the pointer goes out of scope. Also, introduce the helper
> acpi_get_table_ret() to simplify a commonly used pattern involving
> acpi_get_table().
> 
> These are first used in a subsequent commit.
> 
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua

