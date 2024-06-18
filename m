Return-Path: <linux-acpi+bounces-6500-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6668790DC0D
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 20:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3B61F228C0
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 18:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC5115ECEC;
	Tue, 18 Jun 2024 18:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="le8QOYep"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BEC46426;
	Tue, 18 Jun 2024 18:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718737094; cv=fail; b=foJbbZeIZxJyI6HJMkZCpPcfqQ7lCQ4YLCLlbMd8OdtOwgQsBnwLM5e+nqmP8UYW91Qq8QeI3Xe8yGQMQ5Dm6VmCLS4lGF15vYSKKm6hyhYjv2zGLVL9P3TZ4e23JCCC59//H+erTRH7iC0OGjZdApjhzosKCg1MLGBh6dKwU94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718737094; c=relaxed/simple;
	bh=tMdipFqh1fef7UpJjB6/DWs7tDpqStEtAsPcLXYO/Wk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JYx/iZNIGowaLpXjv/F5/TavN8X9D94l1YfsjDDSI8DYI3qS1VKgqZnYCMN2DTL1ZNsIgXCBdtn2QENcZ0PmSPSO1R1manqUNMDTNHZy0eqIMfA99Y9tcfHK5RdQZCQKfYWb/lCuD81O5PHwH5tijBGwlG94AWb63w9TAXOBMxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=le8QOYep; arc=fail smtp.client-ip=40.107.220.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlUA1Kx4GSYqReCUy/G57o46eByWBQzxtHcNJvwZFtvCOW1dhepk41zpU1F0cDk5wOog45dVwsnAADpm7fgMH6rcP6ywe2lLLB2ZF/fsEgiNGhfUsY5YXCnGQBn4Xaip8FpCGf2gYtNwyS3dJJ99wtUtgd3bLpkgdEdWU33W3EdpxROGjS5njWmbUkeszMHNnzZMVNaDQ+DZzZZ8d2l8iA//IsymAmyX1stadMW74Ane+xBFNLjzOjBijtY4fedhgZUHV2Kz1cuJupu4KZz9H7p6MGzyq2UN5j8tABz1jbjp9d1UkmWtr7DX01O4cZ1YEMnUg5YuNQJiTjj94YNXOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjTx8GJPEaaQNOhOD9AQiNKVCx8KvnxrPu1tAltvBeU=;
 b=jSAyRjssUKJM79bi0PlWsi8CdbkNYth2xQsQ+MgRKMcvSAhHKijR+bt9GWTTUYrv/fjDa+FmS58vRZP3AE2398IAcjlpxYyoAN8s6bLtsoOpc5fVkNfxuw6AUmijQMWkiggOcWj5ai8vEK9c3zJHVCKb1a4ixuT48uEjx0r1D5NwB6ubADIax9cbYdu4tQ3aCEjXP54E/X1ekllWRKiGZQjTEb7NJvUVWXkfE2eUmLCmrfjvl946NGFBhSuVnXCjEn9x0Nu1fp/oVl6FfQoc63u95momPcVLYg8UjSVQnlT3evrXxYrkdYRaHctms6Bc0ABeRG57woR7DZ+hN9Qgtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjTx8GJPEaaQNOhOD9AQiNKVCx8KvnxrPu1tAltvBeU=;
 b=le8QOYepOJ4B3ym+Bx4ZQn7BIRPSFwm6nb7rKRyVfm+xFcIYXOhm8mC3ZVsIkfuw3a+RfyCCi+9E6PRbG/jzifEh6gnTFXlDLZ1lZV742hp/4hFKy9PbUISfKHg2I7Bs5YiDnBOo0OKIC/GSpzcJo5fTgNHRSdTsmcNuBtysjvQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB8816.namprd12.prod.outlook.com (2603:10b6:8:14f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 18:58:09 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 18:58:09 +0000
Message-ID: <b4d65232-b69e-419d-9b15-d0ca64b78b26@amd.com>
Date: Tue, 18 Jun 2024 13:58:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] acpi: Allow ignoring _OSC CPPC v2 bit via kernel
 parameter
To: Aaron Rainbolt <arainbolt@kfocus.org>
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
 linux-kernel@vger.kernel.org, mmikowski@kfocus.org, Perry.Yuan@amd.com
References: <ZnD22b3Br1ng7alf@kf-XE>
 <b516084f-909e-4ea4-b450-3ee15c5e3527@amd.com> <ZnHSKiaYf2tIQo58@kf-XE>
 <a7790c74-2bec-4a24-b6e5-223c4e1ed372@amd.com> <ZnHXfLEwk2uRbg58@kf-XE>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZnHXfLEwk2uRbg58@kf-XE>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:806:f2::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB8816:EE_
X-MS-Office365-Filtering-Correlation-Id: 823a51a0-9b7a-45bd-684c-08dc8fc89894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zk40N0plMWQ5TkQweVlxRTJza3dQN1VwOXVJUFU4dXFLbHM5QUliNmgyRlFH?=
 =?utf-8?B?ZDNvRGlJSVppaGZUVERwbVh1V3dqZk5JSkJhSEZtL2FEbE8yM0dsTVliNU1n?=
 =?utf-8?B?b1IwdFd2K2hzMUNCUWIrSFJZcitZdHZTdVNKYk1GQUJ6WFZlMFlDSTV5ME8x?=
 =?utf-8?B?SU9PcExxaGM1QVhQZjVSL0g0Zy9PMEQ0MmZZaVl2ZzBPQjdjblh4ak5xMC81?=
 =?utf-8?B?UWZ4WE15Y3FVTkFiMHZ6OUNaSGx6NXZhcjFkSWJGcmV6TnBLSTNWT1Y4WE5r?=
 =?utf-8?B?ZTJNWUNETFo2TVo0Z2VwYWRsU1lLUndDQ1VzOXNITHViNW54cmczU3JqV2N1?=
 =?utf-8?B?aDgzN2dmMk1OdWwvWHZaRTZ4V2pUK1A3eTFxc1k0cnlISUZBYTd5bSthMjcy?=
 =?utf-8?B?RWpodS9hZFE5Y2pJd0VoWUhTbUtsUHEzVXRqL3JrWFV6M1g5Z1NXQnJ4YVdH?=
 =?utf-8?B?WSs2aTN0bXI0RzkzVkw5UGN4Szc5c1llUWVaV0s5ZGFlWmFPdUdEa3NGWFht?=
 =?utf-8?B?RG9TQ0hYWDNyalNUdVc5ZVRXY1A1VG03VWdWTWp0M3hhWFJuUjFBSTFqZWVL?=
 =?utf-8?B?UmU1ekRBZ1o5NkVxeG5XczRtUE8rZkQyWW96bGtmL29wWExVZThMbG02ancx?=
 =?utf-8?B?VStnK2F2b2xQbHI4QWhYQ09aTzhYMUhWbEE4dDJwakloamEvNmFSQUY4ZG9I?=
 =?utf-8?B?Z2poOFBQa2xFczU4VXVEc2NkSVlGUHFXMWEyZXRLNW54WDllY2dSUStuajl0?=
 =?utf-8?B?eHcyb3dzd2w2K09CKzZTL2xLUGJ4bk05R1haRHQ0ak0yZVFWUXI0cHhGN3BQ?=
 =?utf-8?B?WnNrSVZRelovYTlwMVcxU3RQN1dQd2NyNzY4L1VLbHBYSDh5Qk9PdDFDd0Nw?=
 =?utf-8?B?STJha05IYmM3RHVSV2xXYVhycTEyZ2lSb0EwWVhlUE01S2NFQ0FHblBWOVc2?=
 =?utf-8?B?Nml5L1JpODYyNFA4ZkRnMUhNdTNpOVZqdUo0MTZhZ3VGR2JDU055YlJjRnRE?=
 =?utf-8?B?Z3E0RFhXMjJqdHN0MlJvVlZqTmJYYm1tQncvVFNxZVp3eFNnOTI4OVByVjI4?=
 =?utf-8?B?NzBzN0d3ZFNSYXQ5ZktvZXVPOVdkM2EzdjRGV2lJQjhJUkFQMHJSdWpUdmU0?=
 =?utf-8?B?UTFBRzJ1bWgxanR3VDhtRVJrcDBjTzJIKzJLTDdOQnlNY2FvU3lkVkZsZkFv?=
 =?utf-8?B?SHhYeE1jay82WE9INXNEbUpzeUs2YmJ1ZllKcVF3WUlGVElWOWN4VWFVZGs0?=
 =?utf-8?B?dTZNVjRBT0Y1RG9semthWGNuVnp4cGpqTG5JdHJUUkw1Ulh3eURPaEJidDJ0?=
 =?utf-8?B?QUE4NzFXUm1laU95ejk2YWVtd1hEVDF6Q0VpVERUZVpsVVdhL1cxWkNCc0s4?=
 =?utf-8?B?VDhaekJRd0QrVmZpbElzaGpuWnJ4VEhWK25oSHhxVEtpNXY3RXZSZ25xV1hK?=
 =?utf-8?B?OG1vMVVnbStMdkVuMnJoV0JQcGhjeHphRkxSaEVpN0dvRER3d1o4YnJPdG14?=
 =?utf-8?B?ZEEzcmc5OVRWLzREZEcwbE5XWFRYZ2lHYmxXelZ6Ry93RGRSK3NpbzlGcGlI?=
 =?utf-8?B?RG5HaGtUSlJuSU56cUU0K01aRm11R1hueDRXTmhwSFZxdUhpU0VSSDk0Tk1r?=
 =?utf-8?B?dUNDMjY0d0VLVWFNTFBVQU44dXVWNW1OekMvRjFEWkJuc2tzUDJmUkN6ODEy?=
 =?utf-8?Q?BxD/iC2nIULgJYt0aAbj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnljVk1xRkU3d3BPYTRzWDRYcHF2ZDdSSmE0UWYrRXZUeWx1NXpYY3RXKzJp?=
 =?utf-8?B?ZkdJRE9pVmR0WmM4azIwV2pYNFNmYUNkcm5oYVNtM1NZNHA1ZFFjZ1lqaXh0?=
 =?utf-8?B?aURXdEFBMUFRUFZlM0JpRjNyN3labWxraFplYVFlQ283UjNrSnJXZ0VieUN6?=
 =?utf-8?B?NTNFb0JYSmpuZnRWaThTTVl0NVdLaXhuM21mdUt0cVJhbktnNlFOOERlVVVS?=
 =?utf-8?B?NkVLTE12N2htUG8wRkIvQTNYY01GZ3RYSFEyaG5YYmNqcG5vRmNUejhTWVNW?=
 =?utf-8?B?S0pUU21DYXR2VEo4a3dVUzZyRDV5d2FpdmgrdWI5VWNVdmFPcVh4Yk95QndJ?=
 =?utf-8?B?emVleUVrQ2Nhb2h1MHZka1VFcnhFdTlMMDdEQXBocnJYUGd2MlI2YUwrME9k?=
 =?utf-8?B?MFcyUkh6dVUzOWtEQ3VVV0FWVmdyM2s1Z2VmYnAzYnRsdVZES3Y4eWIxNTVW?=
 =?utf-8?B?ZDlwL0RDTzYzQjZsR1BaN3lnbnlEb3FxSGZveDlaWWdJWG84OGtEYjk3cjdv?=
 =?utf-8?B?aTBWUVBzVGU0cDZWVDV4bHNxTDFybjNGVGxGWTdVWWdjQWhKVy9JRTZSNUNO?=
 =?utf-8?B?N0ZPZS9TUHFrUTNxbFg4aS9KRTVQSWphd2VtTnkrWTVrR04xemk0d1JwbjJO?=
 =?utf-8?B?dFJhZVRXbUY0TDdPNmJQdkN2cXk5dmFSQ2dLRWJ0VkZjVTRyMFpqMkNSdk5w?=
 =?utf-8?B?ejc0cEhMcVNQMXZyVmRnc1I5clN1RkhJYUJiWTF4OFNGOTlmTUJTOHN6RkFI?=
 =?utf-8?B?TjNRSVY0L2t2OUVtVzluaWF6L2QwWUNvZm9saWF2ZTZvU0dSVVhKa3Eza2FE?=
 =?utf-8?B?b1dWbXNEM0xncnBCN3Y0RlU4dmMyYWN3MW8xWjhBRXBac2U4TWw4YThtVVZJ?=
 =?utf-8?B?M0d1RGZWMkxhT241QTg4Si9qNXl0eTBjbVJqM1dEOHNFelpsZlFQWE4yZXR5?=
 =?utf-8?B?WU96VXhzL2U2cVlTMW9kMEYxK0NpSEpuNDNwdmFHNy9Cd3dhQnRuWUZGdHNM?=
 =?utf-8?B?eE8yQ0I0VWFiaktWdWZQcDJYWVR3dUNjOHhseUZxTUJlM2tLMzB0QnF5d0tO?=
 =?utf-8?B?OVFwTjVybmI1MGZLS1BWMzZYNzBDREorcXREQ29zWEZROWY3ejFvdGdzWnNj?=
 =?utf-8?B?bFk3dUhBenpQTzBGMEpBNWVqMWdnUkVrMXJrQ0VmVE04UFlVWW5Bc3NkTWph?=
 =?utf-8?B?OXFYcmpZYkVHcVlvYzltdGlEZWFWL1F4T2VrRWdpcXNZUXpkM1Z6REJKVjha?=
 =?utf-8?B?WnhXUFNjcnN4VldxQkZ6YWpYVWJUbndZdjlLTEcyTWxCSThndUxDNVUwdGFW?=
 =?utf-8?B?V05tdlUyWHUrbDVCQ01MZHVlYVkwNmpKYnhUMmh6dEY0UzQ4ZE5TakJNOTJ0?=
 =?utf-8?B?ZGd6TndHcDM0dEJUdExJbHlQN1VDd0Roc1JKSERTN3ZIZGNXdk04ajZMaW9U?=
 =?utf-8?B?bXFxWGVWdUpFSTR4MW8xU2RRTGUwZHJQeEFiRU1ZMXJpL2E0bHB3RDFHUjRK?=
 =?utf-8?B?NFRTMGZDbzlqT2I3L1FyWllwSzBsNGhKUWZ4MVF0d28vU003VFYrdjZ3andn?=
 =?utf-8?B?SWhLd1p3eTlzWGRGUnVGdDZabHYwUlpDZlVtL21OdERxUml1NG9DWEJ2SHla?=
 =?utf-8?B?a01rMlQxcktLbXhyYWl0U25mT0pTYVFTejFnaGxBMkNjSVpMWVhGUExlQXFx?=
 =?utf-8?B?bml2NFZweUNFS2pmd2lhZWJpSjg1K1ZiRjdBcnpwMEJVa3NlTkg5TjV4b1hz?=
 =?utf-8?B?MmZ0LzVadm53Z3gzQ2R3M3BiallZV2RpMWNWSnBjV3ZSTFdqSkhOWlROQm9K?=
 =?utf-8?B?bHlFSzhqUUc2eStiWUV1NDRpaENKZEpnMmhYbmErc2doSFhDS1puM0VtSy84?=
 =?utf-8?B?SVMzRmhXUENSVzRiZzlqOTZoelpaY0p6aTdVV2t4VWlRTkVieFpqM1VFMWda?=
 =?utf-8?B?dVJ6N1VjdHF3SDFORXBORjhYSWxBcnQ1dmJaVFFFVkxBSEkyQ1VSSmlHM01z?=
 =?utf-8?B?UTRsMVN0T0dpM2NkTWdkSUZEK3F6cjhLcnpINnYvR1lRZDFXeHNLRnFSUjN3?=
 =?utf-8?B?Q05rcEh6N0xldlZJOTM1MzA2bmdQbCtiREFGbzk3Q0poUGJxUEFwR3F4UFFk?=
 =?utf-8?Q?bXPGcTcPrI/WCaC/g2bBxdrzI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 823a51a0-9b7a-45bd-684c-08dc8fc89894
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 18:58:09.6985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4FnShuzYa2/64KSAcF9UzMexPUtOZkdDsdjve5paw/IOvqHNCtqDeguJ7qzU+ZEALJoi9OJTRN8/d0Xu8GOvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8816

On 6/18/2024 13:52, Aaron Rainbolt wrote:
> On Tue, Jun 18, 2024 at 01:35:57PM -0500, Mario Limonciello wrote:
>> On 6/18/2024 13:30, Aaron Rainbolt wrote:
>>> On Tue, Jun 18, 2024 at 12:09:19PM -0500, Mario Limonciello wrote:
>>>> On 6/17/2024 21:54, Aaron Rainbolt wrote:
>>>>> acpi: Allow ignoring _OSC CPPC v2 bit via kernel parameter
>>>>>
>>>>> The _OSC is supposed to contain a bit indicating whether the hardware
>>>>> supports CPPC v2 or not. This bit is not always set, causing CPPC v2 to
>>>>> be considered absent. This results in severe single-core performance
>>>>> issues with the EEVDF scheduler.
>>>>>
>>>>> To work around this, provide a new kernel parameter,
>>>>> "processor.ignore_osc_cppc_bit", which may be used to ignore the _OSC
>>>>> CPPC v2 bit and act as if the bit was enabled. This allows CPPC to be
>>>>> properly detected even if not "enabled" by _OSC, allowing users with
>>>>> problematic hardware to obtain decent single-core performance.
>>>>>
>>>>> Tested-by: Michael Mikowski <mmikowski@kfocus.org>
>>>>> Signed-off-by: Aaron Rainbolt <arainbolt@kfocus.org>
>>>>
>>>> This sounds like a platform bug and if we do accept a patch like this I
>>>> think we need a lot more documentation about the situation.
>>>
>>> It is a platform bug, yes. See my previous email,
>>> https://lore.kernel.org/linux-acpi/d01b0a1f-bd33-47fe-ab41-43843d8a374f@kfocus.org/T/#u
>>> (I meant to send this email as a reply to that one, but failed to do so.)
>>>
>>>> Can you please share more information about your hardware:
>>>> 1) Manufacturer?
>>>
>>> Carbon Systems, models Iridium 14 and Iridium 16.
>>>
>>>> 2) CPU?
>>>
>>> Intel Core i5-13500H.
>>>
>>>> 3) Manufacturer firmware version?
>>>
>>> The systems use an AMI BIOS with version N.1.10CAR01 according to
>>> dmidecode. This is the latest BIOS available from the manufacturer.
>>>
>>>> 4) If it's AMD what's the AGESA version?
>>>
>>> Both affected systems are Intel-based and use heterogenous cores, not AMD.
>>>
>>>> And most importantly do you have the latest system firmware version from
>>>> your manufacturer?  If not; please upgrade that first.
>>>
>>> We are using the latest firmware. (We're trying to work with the ODM to
>>> potentially get a firmware update, but since this affects more than just
>>> us and a firmware update may not be possible for everyone, this would
>>> likely be worth providing a kernel-level workaround for.)
>>>
>>> I can easily provide more detailed information - would the full output of
>>> 'dmidecode' and 'acpidump' be useful?
>>
>> Does your BIOS offer any options for these?
>>
>> Intel(R) SpeedStep(TM)
>> Intel Speed Shift Technology(TM)
>>
>> I believe you need those enabled for this to work properly.
> 
> Neither option is available in the BIOS settings UI, however our ODM
> confirmed that both Intel Speed Shift Technology and Intel Turbo Boost Max
> Technology 3.0 are enabled by default. They did not mention SpeedStep,
> but I assume SpeedStep is working since frequency scaling in general
> works and the kernel patch fixes the issue.

Got it.  If those are enabled I think it would be good to get comments 
from Rafael and Srinivas about your specific situation then.

But regarding the patch, if they are agreeable to this "kind" of knob 
for debugging I personally think it's better to have 
cpc_supported_by_cpu() look at the kernel command line than plumb 
arguments from the module down through every function.

> 
> In case it's helpful to know, when booting without the kernel patch or
> without 'processor.ignore_osc_cppc_bit=1' set, neither of
> '/proc/sys/kernel/sched_itmt_enabled' or
> '/sys/devices/system/cpu/cpu*/acpi_cppc/' exist. When booting with the
> patched kernel and with the kernel parameter set, the 'sched_itmt_enabled'
> file appears and the 'acpi_cppc" directory for each CPU appears.


