Return-Path: <linux-acpi+bounces-17325-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8ADBA238C
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 04:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC3D1BC6EB1
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 02:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AFA25F7BF;
	Fri, 26 Sep 2025 02:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bb1ntsL+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672891DE4F6;
	Fri, 26 Sep 2025 02:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758854133; cv=fail; b=GOuD6wfmPOtdDuayb1HIFB9Y6POiNMuUxjV198GqQRcSKNUNQmiMeErLlnq4m+UR1fuq9tozEqQAZApHN3raCPv6GYQZBi29cnDtCzBPLa+1W9xiyvIh0Zx4VksMpsOXrat6yGsgyxnzs4mF/B1nR8gO3yIX+7bESy+DDuTwCrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758854133; c=relaxed/simple;
	bh=XJWG7n3y6IQ6nitZWqOB/u8jjZRgPySlHY5CDIdDSuw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=flyUlwHlKFI6zH6ldvUUdzpt1496tOgUUBh9vnBlVgmEg39nfWJ92uCA85G911mU15ujvwsOjyPdFH52haHFTb4zDijAzr875nbAt77NGTep1Nj9xutf+ZDCUve3LBkUtIxJoJxjgUX1a15US8b9YF1XIcoLMeMVyueJzv0J9Qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bb1ntsL+; arc=fail smtp.client-ip=52.101.46.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyDgR90Hf39mSroA8NCJlUZDQYQL6cOsvKJirPwiHMeFdUpphFgNgg2TMINlC0Kuj7pW1wwpHeztSbpXt5GJsacQocwp6Ql53GikcyuXXc3EZfLfM1l5CmYrnYVLFlVnkp0SzOpp3CtL1AJHp271MlYkTHWdMBXnM+eKFNKDlZ/41hSb1yc2rL9hpQSBq+TFIhfPspMDHjhQbKR054BZFroP+7e+6k32/y6BDll4M+o1jxhD1+fQduEgo4e5McDY9JPmaWr6FInv54069VIUdUe5QxJ+PdrHayb4K5/vx79gHcyzLVenkiSdmF9hczqfTetfVIUl/ZoSkmqSxSv44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJWG7n3y6IQ6nitZWqOB/u8jjZRgPySlHY5CDIdDSuw=;
 b=hjqs96IIEDRGluuYyea50Dc3RoFUmn4XocZ6njXrlW7su5LOfxB1Aw5cPwhpFqUPjdg1mwJ3fTqEa4NZz/1l7o7G96TctQlHUhsH6kn7Rz1w74Q8dPU5ZB9CMX1ZnbruCQoHeWvMqyL02h4T570HEPYLjnkiD8UwjkSWfWHkLNrZoG4Yadgis0RR8x9kmiLeThlEmXJUi72kH1y/NusGKxIayvzdwzr/izWKQWX0Y3OBECitgy8/s5ZoGYqybpZU149FAD7+3y+HlPq52hKlbljBRUOfT6lKQFwQN4ggJQunCMxuA3WEcyKIWb72xWWu4xmuPMdg++ox6AP1caM3Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJWG7n3y6IQ6nitZWqOB/u8jjZRgPySlHY5CDIdDSuw=;
 b=Bb1ntsL+LMJIdHQEejMlPYRbeeVpvYimbYWAZJ7hGNxVEvr5I12ZqeNfavj6wb44KjisY8Y8yOuE87rkkDzMPDEG/eORNygv9hyq2aUcnyeWM4kASJzEyFaItGRoMDVY+WF8DD9fy/fOnpToo6fkgTyZX1WCZCCkj4KBlj7xHK346p8GV29r1rrZTH1c/QHJamWr3HkLOjD81IhrxGqlqCQcrZAhizDNfTTbCDKA5vc3dI8dVAIiPYxIMLnql9NLe8wY7wN9Z+YmAMlJecdEjv+MCJjK6ZFPTkO97sfDeYUslSVZtGS9Fc7lJmwFnimRrcbT4VAbvLHAQT12cZCMIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SJ2PR12MB9137.namprd12.prod.outlook.com (2603:10b6:a03:562::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 02:35:27 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9137.015; Fri, 26 Sep 2025
 02:35:27 +0000
Message-ID: <cb13db6d-012e-449a-8a70-57e8ca7f0d29@nvidia.com>
Date: Thu, 25 Sep 2025 19:35:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 28/29] arm_mpam: Add kunit test for bitmap reset
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
 <20250910204309.20751-29-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250910204309.20751-29-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:a03:331::24) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SJ2PR12MB9137:EE_
X-MS-Office365-Filtering-Correlation-Id: 40a52fee-25fc-4091-a37d-08ddfca55a95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3RLamlVU1lpdGdub1c1OERZU1F5QjBlaHFsWER2dXQzNlFQSWI1ZVB4cjBl?=
 =?utf-8?B?ZTFxZjZic0JBQmhzVThSaEYwU3VTTEZoeU9tVXpYbHQ4LzdPRUZaZVhXa2FN?=
 =?utf-8?B?eTVHa0ZiSTZHNXY1Y2JMVDJNelRENTVpQUQvclZEQzlEZHhtcFBrS0lqZnY4?=
 =?utf-8?B?VW9hMXNTdWRWVUJoQTBMcnZDOXVEaE5HeHRmR1krcVI2M0dJTTFmbjhYWVJr?=
 =?utf-8?B?WlJpTFpacVRKOXJiRGdjdzdYSFN1VnZON1cvczBidkJZL1hubFVud3ozOVhU?=
 =?utf-8?B?RkJBZWM0bnFxZGRtMFJqYTlvZDNtak5ZV0F4OXRuOXVweWcrTWZyLzFJQUdo?=
 =?utf-8?B?Mk95YnhZWkM3S0FMdGJSN0FKbnBpWDM2T3pKS2JoUzVTUEc4Q2Rla3Zqbm1M?=
 =?utf-8?B?QWE0QW0wajltN04yV0JMVGFqWmlrM1ZScHpGWVFldjNQSzRRUVVjMDd3SHlV?=
 =?utf-8?B?NmxraUpJY0FVZmxUM0pkSFZpTkR6V2hNeDZiQ3JnMW42MXorc0Y5R3NnMlRO?=
 =?utf-8?B?MUdReE1hYmcxaWFzRFkvMytCVWtuYXFTeXJ0dkQ0OEpLbXF4eDlFWGozSGhK?=
 =?utf-8?B?QlU2KzZYWE55RER2TlpFL3d6VW9Sb3RZYkxSN2MwMGIzMXRkRmdkMlhjUUh5?=
 =?utf-8?B?NEh4a2Q3TE8zUzlqTzFPY2dZcXhVSmpSUHp0cXEzenplNGxJYWlmTUxreUl0?=
 =?utf-8?B?blF2Y29nUEZuWDRhTkVUM3NYSUVOZEJmZ056WnlwOVk1aWFtWHc3WVRQb0Z3?=
 =?utf-8?B?dUsyT1IzbCtMUTNsenpiOURhRXZRR2Z2eWxsVTRiOWNUWlg0eWpudXRkZTNV?=
 =?utf-8?B?UDNIaCtQOGYrdEJaSTdpbE9KRjhwRE9RM0szZWcvRnhrL21naXJDdGgxR3gw?=
 =?utf-8?B?ZnlsNVZsNTdpZVVOb09DR1lybGhrMGlUUmR0Vzh3SEJSQ3lSOGdnY0hPUXZi?=
 =?utf-8?B?VHFKYldrbTZuZjhRT284K3BYak96UEcwMk9DOE9oOUpuZng5bEIzbVR3R1pq?=
 =?utf-8?B?cUZCaFcrVDhzQ3pOMVg5UkQ3Qit4RkJnMmJRZk9FdW1Qd1lXZ1VBWE00cmRq?=
 =?utf-8?B?M1VWU0U2aExyL2hSaVZ2bVpma1l3WW5wUUxZdTlXQ2FHNnVBbTRlNGdWbjFE?=
 =?utf-8?B?bGl5MDIwU2N2dkt1RWxoRVp1bitJV0s4V1U0THA0ckZQdFpsUEIvREFMb2pH?=
 =?utf-8?B?dkRuU0U2aWo0Wk00SnYvMUlzeDhkdGROOTY3KzRsWVYzZkhsRy9pcWxyRk1E?=
 =?utf-8?B?THNFRC9TcDQvVUs1SzVacWV6SGtIUlB1WDJKWkVBaXBsZVQwZ0RhRERNTzNk?=
 =?utf-8?B?dlhtTGZjOTJWc0UrM1JwREZINVZzK253S1pTY2VGV2JGRDFnTzhua3dLNWdo?=
 =?utf-8?B?T0JBbk1Jd21udm5KT1orT1FjQUJWK1RMVXNMSXVpR0l2eUJlUVp5WXhMZTZY?=
 =?utf-8?B?RENBaDdEZitQd1Z2QldTUUlaQ1kzT2dqKzBWb2cvRGI1Q1NydFBXWEtmNWcw?=
 =?utf-8?B?eDVUWDFxSGJ0SWcxRmc1bTZ5YkNNMzJXT0FvU1UvQko0by9xcitRS3d2bjVH?=
 =?utf-8?B?enBpZ29xN0Q5RFdnc01oUkE0SjR4TzBueVpVVTFCb0xVUng2S09NeGxDQU9k?=
 =?utf-8?B?VGkyeUZUKzR2YVVUejlQclFKQ0lGN0RPa1Z4a2FNVG8vM2VOMHdxc0EzNTA2?=
 =?utf-8?B?SmVkWmJ1NDRUVzVWVldxaVZWQytnL2NDUGVJOWJ0SDBoSlhHMkdCVEJHV2JG?=
 =?utf-8?B?M212VnJnN0g4RmgxVnNCZ2w4dmpsMEZSNWlIOXdtb3dNNkwxM3I2bXJERWsr?=
 =?utf-8?B?K1plaWl5NzZxNDlUSGZLdzd0TzMwcjZvWU9tK2dDM2hjZmtwU2wvVWluUkpC?=
 =?utf-8?B?endEUTRkRnMwRVA4N0RDN1F4RkJHdXN0TW91cjlKRVYxMHpBS3JJRmhtZDJG?=
 =?utf-8?Q?tskmzdgojbyOmZuiXzU6CSOdCTXAq1zr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTEwaVk3VmtiMW8rQlVlUDBXaTBFNHhtVzJiQnkvTHRDN25BTzlzYlhmbmhk?=
 =?utf-8?B?QUZFNzRMU0Yzb3lSaFNDZnJFTkV2bVJnaCtFQy9uK1plbFUzVDd0R0g2dU41?=
 =?utf-8?B?NkpRYU9JWXJ0dlF2MDZhZ25adkxaR01KcGl1S3hZV3Nvbi9KbEt5WEZRNzdh?=
 =?utf-8?B?bFFlbk9La1RFZUl1aENiMlFrelVqUkJibGlpNUdkdGFRVVhsa1NLZUFMcUdw?=
 =?utf-8?B?elc2MkZKMkdsWTNHYkMxNjU3ajZaa1JDWTVyd1dhbWVVYnRzNW02OWRrTjFI?=
 =?utf-8?B?NmpOQlphS2xhWDR1VHVQeWZxLy9IeFBGQ3pOTUdXdDJ2ZjMzSjZuTTRXdWpQ?=
 =?utf-8?B?cUVMQ1FBSHRqVUhwRGdzSFB5Ym82MWU0cFlTd0lCN2p1dkFUNEUxQVE0aEw2?=
 =?utf-8?B?bHY3MG5HNVlKVzkzN3RRay9xM2RpdTlaSklkMVRzY1VlSWtScDRjMGI0NytU?=
 =?utf-8?B?L3doQ0l2enpwbUdLUjhSMFlFVVBIRGlNdU1aTGR1aVVwVFRld2NCeVh6elJ2?=
 =?utf-8?B?aXRXdHNaeERYZ05KR25BMEVYdzdqZXRwbGU4UWpLSDY5d2s4bzhIaDFzSmdn?=
 =?utf-8?B?ajdIbHNvMG8vOWJ2OHFJRVFiSDd4VzNPNUsyZ3ltYzNqTlkvaURPOWtpd3N5?=
 =?utf-8?B?eUFUQkFSNTVUbTlnbmFibjY3U21DUHBnemJiNUVxYWg2aERwelBlRzZIcDhk?=
 =?utf-8?B?LzVtM0s0cW4vNXhTWHQ1cVpIVUFVbmNqM0FKT2JYRGpmYWNZdWxqbUN0OHND?=
 =?utf-8?B?d1BPajhjOW12aHhPdHVGRDltcjNCLzFFYys0NVJWTEJzQ0NpWnF4SG5ia09O?=
 =?utf-8?B?clRqTnJTZkoySEpnR09lOCtnaUsreFlEQmxBRGZKTE8xWkFjMVYwNGxWYjEz?=
 =?utf-8?B?akR1SmxWRXRmZ3BkVTk1V1JXUVdrU1A5aTI5VjRWWjhUVGFISitBNGdmc1la?=
 =?utf-8?B?SG96OHZHVmFQRVBBdHlWVDBUQVpQcVZuZzFyeHRBZlhoWks4aXRkSUVsZTdw?=
 =?utf-8?B?QlQ5MTl2MXhIc0U0MHNDTXVHaGtJRHBrZlBOZjV3SzJZd0pIUkJSTVN5UW5w?=
 =?utf-8?B?Zm10SFFQc2JtUkFsWmdLR3FSNUx3enZXQXQ3Qm12d2ZDODFoNUtVN0VOenBz?=
 =?utf-8?B?eU9PbWR0ZnlsMjg1c0ViRFE3aTd0RG8vNFEyZm5PQkNOUGFpWmJIdzZ3NVhM?=
 =?utf-8?B?UFlCQnRjNzdSelpmSndrQmJySk42UTROZDN5dGJtd3pSemJVZ0tuSmhJMG0v?=
 =?utf-8?B?TzM5a1dkTE5uU2lybFBXTEM3eUtVdXBMZnVxeGtLc01zbERLMmJRUllDdFRC?=
 =?utf-8?B?RURkQm1uVmRHMkNzMjVqa2FLVXhlY0FXcS9qUHJRWHFnK3RyWnlQZzJlSjFU?=
 =?utf-8?B?NzJFR1ByY3VEZ0x0d2V4REYwdGl3YkJnVW5TemFpQ2pNV1dTVjduZFJKVWhX?=
 =?utf-8?B?bG1kTVcxN0UwU29yWUx5d1FNM3l2cWh3dWlnMFM4czZ4UTBlTU1odzRrM0Ex?=
 =?utf-8?B?a280WVR5M1ZxWjZuRWpBdmF1SVhpdXlxYndiR1U4STE4WkFwekMwT2JZcWFa?=
 =?utf-8?B?dFlTeW8rS2tWRzJaZXJaamJrakdrRVErc3pZSXk4S2N1T2V5QXFBNUZuMTdz?=
 =?utf-8?B?UE43YTJxRHRsWGVkYUlOUzl4YWJ4VG1xWHZMQUJPSHgwTElWaGtpV1k1THdq?=
 =?utf-8?B?T0E1b3VINlhlaHNUM1VZckZyNWxjbmlIcHRTSkNJNmRpZmR5RkdsdU5DOURW?=
 =?utf-8?B?V2dRa2RxcktRMnRNMm9Rc29aWkVnbVM4N2xFTGZ5QVluZmVjejR1KzhxdVYz?=
 =?utf-8?B?TVBtY0JsSVo4WE1NMlBTSUJzNjZoUHVtbVdKVWsranpVVlB2bVBidWtvb011?=
 =?utf-8?B?Y0NRUjdYb1NSZEJCeU9QL21RZTlibG04SklhWDRGWVZrZVVyL0R4SDYwZkZp?=
 =?utf-8?B?MkRUK3hDRElramR1NjZHVEZid3NTbDBCRzllR1hYaSszakRIWDNEckxkOFk2?=
 =?utf-8?B?REwzYkY1VlcvWlJScGJqVE1ZdG5aWkd1eFZEZ2dnY2hUSGtlSnVQQmN4V09M?=
 =?utf-8?B?N1pkNURZNGJZVnBDSmtXSmlNY1U2ai9ZbHB6MzRHTUw2dFI2SmNFbENscm5T?=
 =?utf-8?Q?T4r8yIjuyeEXMzFFgrMTU7nBc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a52fee-25fc-4091-a37d-08ddfca55a95
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 02:35:27.8081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PK5hCBxrUVcRz9V8OI2g5XhXhpDSWPP6Dw/OwC39MrJdlxM1EJWOvwNmU+Kg8iFgHAuaRQb0m8EH1YWTSXMdww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9137


On 9/10/25 13:43, James Morse wrote:
> The bitmap reset code has been a source of bugs. Add a unit test.
>
> This currently has to be built in, as the rest of the driver is
> builtin.
>
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua


