Return-Path: <linux-acpi+bounces-18120-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A18BFDF4A
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 21:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8DE1894E0A
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 19:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F70EEB3;
	Wed, 22 Oct 2025 19:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GYzw8crD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010063.outbound.protection.outlook.com [52.101.201.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BAD2222AF;
	Wed, 22 Oct 2025 19:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761159672; cv=fail; b=GxQKDbneyAL4/I3ov91n18PfERjSd3RF5QsP3ZY+XRbo3qQJCDcxL3bzu63wAaKlbJnZzaONo+wE4XZOBztNSUN3x57l0vubbSEjAmerq5PpOihiReBYRUU7OXR4Kl/ln3TFvUHIgIF/dMkTKYStRn2yp1czCEgBoyVvfYPdimw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761159672; c=relaxed/simple;
	bh=655Piqr+RwaH2C8YPRcmRGLwIUzrqSVJZ5oLBmgiDPM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l3ilb0AemC2tV3abWLH0ZO1P6T/Gk7JzQ4H/y4l6Sv9b9wpLNiMwuyKcykOszer/HWO/Xq6xgw5MwDGUXacAYa/WcpXiQI4dcXh245HMT7C8b2rfNyYxYZv5XdpDFhKtXIRNwh3iKHYDi/YNK8IEOu9OtfPzoAIAlh3islFZDmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GYzw8crD; arc=fail smtp.client-ip=52.101.201.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CyJe84d91oUSDy/UvXUNheJZKkjox3PtdRJVeIfQ3J+3H2pGcdkCe7Lf71/lwGqoTXyDqJBobDkasNiG5eEV2f+/kRLtA36ypGJFa13yseFYYL98GxZWCFlx8XKcwncoVgJav9JgUoVu9hnSKfXjXrZM7FbckKwbN/3qlb8367J0xwgsAGtAKRHjDOAqy2wLIPyyd4QdS6Qja0kq0pEKzzAnxMRz0T64A+VXdTqMykXfIZK6NbF7rVivgpg0S/NRVgSy8VzS7hdfvo50Qg5aeDw7SaD5tFtNe67HMYYIkuHdcRsTZgDiOBMKwVqpxVgNhMAMbWKrrIVTipuI5D1JdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLpi83YtaPPTf6HlkOIBuuGYuTWggmWH1mlBBal7Rv0=;
 b=pQRzDeThKI/9qTcdSu1nxVQjaaz6oOllt4iJbUZ8/cJ5HQ5nECHtfa5uiuFojQ7/H7DJUq9fRql/qMXh1o0ZJwJhoTNvBCgwKzHMeNDKXoNaEYwwSMy7MsF7W4AM6hiBdrGoKT+bvmq+3hsEW7CcRI0F4Ykw8wD/0PlqrAEvtp1vR7P3RKBRV1gDp8RzQu1bu82JjMX+KrHswjhS7SnK64ngf3rb1YomrwlxyJArdBSqPgCHp5TjreaSwsm2VBWYevmBsEwF+KeFJ/vxp7voxMerqfwQvlZyVt9Mp/0zS12yLpcvN32Zg3LEswYDuQOtm2KxwIOkimBFXwZsFKUjTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLpi83YtaPPTf6HlkOIBuuGYuTWggmWH1mlBBal7Rv0=;
 b=GYzw8crDst8pTC+Oc08GpeEUoeMSt3z3+sDIPvQcWDB6vtTMjd4/0BzP9w/BK5eZCYteN/VvmHsmmKT4v2CXPF43mDvK9au18tDpX26k//mwUGnq4gvz+wP5emLYx+/jmvZScrd4hwoeR0rheZs7m40iul1rHzjCp+QCyHtrryOgSjNauxIP1gPRv2gVN84H5CPng8nxsMBvn0eO5TxUMVMeh3qx+n2bI1h6TchNBZ5XxgashNpqQZrmMP2iditJyGg2/LxLwZ+prMEnUhaERfBNme31ROqptccL5kbVJ3btmMGYyqK6sCtr0ve8KaXd89Hl3yliRWAeI5fYCR6rfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11)
 by SN7PR12MB7300.namprd12.prod.outlook.com (2603:10b6:806:298::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 19:00:51 +0000
Received: from DM6PR12MB4186.namprd12.prod.outlook.com
 ([fe80::af59:1fd0:6ccf:2086]) by DM6PR12MB4186.namprd12.prod.outlook.com
 ([fe80::af59:1fd0:6ccf:2086%5]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 19:00:51 +0000
Message-ID: <183a54d5-0f07-4d37-915a-55ff9ab0e86d@nvidia.com>
Date: Wed, 22 Oct 2025 14:00:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/29] arm_mpam: Add probe/remove for mpam msc driver
 and kbuild boiler plate
To: Fenghua Yu <fenghuay@nvidia.com>, James Morse <james.morse@arm.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org
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
 Danilo Krummrich <dakr@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>,
 Gavin Shan <gshan@redhat.com>
References: <20251017185645.26604-1-james.morse@arm.com>
 <20251017185645.26604-8-james.morse@arm.com>
 <fa5187f0-293e-48f0-ab75-6641e284e8b4@nvidia.com>
Content-Language: en-US
From: Tushar Dave <tdave@nvidia.com>
In-Reply-To: <fa5187f0-293e-48f0-ab75-6641e284e8b4@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::24) To DM6PR12MB4186.namprd12.prod.outlook.com
 (2603:10b6:5:21b::11)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4186:EE_|SN7PR12MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b62aca-62d4-49d2-0f37-08de119d517d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmFIM2pQOG41R24xcDVCRXA1REdEa1dURzNkOXU5bHdWeXpIQkF4RjNldmJt?=
 =?utf-8?B?ZWtvS05Zclh4M1NlRDVkT0tNTnA1dll0cWozUjhLYjJ1Q0Uyek5CZXZwenEz?=
 =?utf-8?B?anc5a0dZd1VWdUxkalphOUJlQUhaUVhQcU9Pa25lV0FDN1J2aGxDVU9XTXo0?=
 =?utf-8?B?U1B0SjNnUis5QzQya3lnYjBoM2xIVDl0SzR6b3g0dnJHZDZ1S1BvUERpUWE0?=
 =?utf-8?B?bFRQaDdHOWU4UGQ4QkMrNmMvN056K3pvYjBUV20xMGhNdGpUbm4rMHZ3emFF?=
 =?utf-8?B?MXdHWlRZREp0c2VHbldEcW5kN3RiVEVtaW01ZjlHN0x3MUEvTTZKeGpqUGdZ?=
 =?utf-8?B?ZjcwZlprZzQzZFFpNVdqbjF0Z29CNnJsbW1iS1ErK3diQnhMWko4ZzRKQjZH?=
 =?utf-8?B?S2hUZm40eUQ3Zm14RGxKTDg2YlJwRndleE0wSUxQeGVhVUpXTjhaSkdtenIr?=
 =?utf-8?B?M3EwRkdWSXlrM0owRmJBaml5eWtmQVhKeU9TellqL1hHTnBGd0pBaG91WmhN?=
 =?utf-8?B?bURvQUw0MWZXY0RjQkNzYkZIUXNDZjdMYXJqNldhQlgxL0xnTVRWbFk0ZW5x?=
 =?utf-8?B?MC9uSXBtMjViRDlBQ2N0ejZ5enFaMWZ2OG9zWTJ0djFRczBHMWdBMkxhSTBM?=
 =?utf-8?B?WXdpMDRZNldzSjRYem9weDlqVEdsRmROa01FTUtER3I2b2lCakVTVHlpQ3Vt?=
 =?utf-8?B?QzV2Ti8vL3JCS1pLa05HazZXdWFERUpDOTRkWmQxajcwOHNTaTJ2ck9na0d6?=
 =?utf-8?B?YXNRN3pMQ2l0R21EQS9YWWMvNEszUmNWYTJuSTFUSHRveCtNVkM4QzZRc3BO?=
 =?utf-8?B?bVdwb2IxLzZjSFVnRjR2M0IvWk5sUDdiQzJRaDRkRXFaeCsxV3prZEdLRGNY?=
 =?utf-8?B?STdRWjU2K25oSzZIS3RNQkZsam56cG91NXdsRFpOR3REU3pXeld0MDZmQi9Y?=
 =?utf-8?B?UXZqcDIyMGQrNi9BcWMxdDlpVjZTYVEyR2ZFdW1ISWkwNjJqY1hnR2JTWHlj?=
 =?utf-8?B?eW1TTEY2cjdsOVVxMGxKWUxSYVU2NWwwcFJCeXNodXZKbC9UUXFpbG1FM1hD?=
 =?utf-8?B?a3paZW51L25UTnVId3VQK1VqeEU3ekcvbG82Y3JJT3pSS3l6aFpobVFvRlBo?=
 =?utf-8?B?a3JJNFpxTUQwVzBxOWhscDlKTlNteFczd0t1ZVNob3dSSlIydENhaHZucU9G?=
 =?utf-8?B?b2VJLzQ0N3dWTm51ODBiOWNuR1BIVzdyNmEybjk2L2lhczRVR1FXWExpbzQw?=
 =?utf-8?B?cjhHMjdncm9iWlk3R1p6enBzL2dpTFB4c21oSkwrL1d4Z1p4UjFEOGlkUjVF?=
 =?utf-8?B?K1lSc0ZlQzl2NDlkYzQ4NlBHNGFHNzJsaHN0NVVRUmV6UU5Qbk82TG9JL25Z?=
 =?utf-8?B?RXRZL2Jncmo4YkI5SUVycm9LMitEVklEN0kxN3dnYUc3RWxtY2ZLRElLZkFD?=
 =?utf-8?B?cDBQNmhqRlpwTjk0aDlYV2hKSjJmQmdYQXBHbERXSnZMRENUenhSbll2dWpD?=
 =?utf-8?B?YzluVW9XcUF5Y2I1dkg5cXg0YU8vWlNrZnAzQ3p0V25xeXFXcHVXZEJlSlN1?=
 =?utf-8?B?alFtckg4UHc5T0NyWHNIWFBFbVVXVjhpWG9tRzNvbVU4ZVlPa1NJazgvaDJ2?=
 =?utf-8?B?bEVlemxWODBOdGp2ZUJUTjB6b1FCd2U3bmRILzVMdlA3Vi9TYVI1Z2luTTNy?=
 =?utf-8?B?L0VMNXlCZDA1dlQ3azR0V1N2R1k4eENtdndiTWY2NTI3OVZUQTBuSGJIcitl?=
 =?utf-8?B?RkREUkMyQWFOOGNqL3BEd2daVFEwcFNUTitaV0lKQkJmVGFLbCt6QnBjVnFk?=
 =?utf-8?B?cUE5NWlaVUhCVXFBdGdaM2Q4OXh4amMvN0hFTWUxZUViNDhjZ04wRlVpU0t1?=
 =?utf-8?B?b21WVkhoM3dVOWx3U0pidFcxVkdjcXBnZ2p1NktxNTgwbHp4cXUxMnVnc3FS?=
 =?utf-8?Q?QyR5ANbGzhcAgeS5R0OQskjS6SO7GosI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4186.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFZaVW90N2dsbXVhcUV4NzlGRXBpUEg0QkFFUlg5S3lBSWNSdXovOTF5MDlE?=
 =?utf-8?B?SDhGaHd6UjlFUUpvMjZmdW9sdHZZV2owSklYbXhIWk5GVXBRWTlKdmN2MVpS?=
 =?utf-8?B?MXYzb2NLdFN0bzZ6RlBsS1VNVWFoODl1Y0d0dUQzWlluRmxENkpFWnBRL1lr?=
 =?utf-8?B?S2pJOUpUMis2WG9KUjlFVkdwNnZWQ09NTlg3b0FuZEdtTjk3N1ZBL0QrdkNY?=
 =?utf-8?B?ZGwrdUoyako0YjNWS0lYWlZMdk1kQTRvV0s4YkMySEFuRkZSdUlUWUdvNDRL?=
 =?utf-8?B?bkFKMElpcGNMbm1FenFMVk9QZXlnRStjUVNpSVprREU5MFhqUXNkY1N6VkFC?=
 =?utf-8?B?cHVtSDRqWWNDN2tIdmtVRWJpN2I5Y012bGFYTWV3SEF3RUtncGo1dDdWMFJI?=
 =?utf-8?B?TjA5RGQwNGlMRDBrUHp4SWlxVk5IYlJTSHR4a0J1TUY1S3JPeWNSYmYzaWMz?=
 =?utf-8?B?enJWYkZwN1FKdlk0RXQrUWpYUlpBY3pkU0pDbHhvRk1PM1Q1Z0kyc0dENHZU?=
 =?utf-8?B?ampvSm54OFNFOG1VSkJzeFVHR0pYL3VjclM4dlN5Qi9iYXRiZWRUd1hyTy9x?=
 =?utf-8?B?ay9zRSs5aEhGYVZxVTkzUkNvakN3RkI0MDBHdlVSa0x0blRNNUcwcmVKVEc3?=
 =?utf-8?B?elc2VFphMlpMNVZab21sUjl6a3N5dXcxcmlTd1lQM1BmdXMrdXFkMEJhNHRS?=
 =?utf-8?B?T3A0WVpPNmp3K1FZc2JGcHRwUDlncDFIMnRBdlRDdmk2Wis5UTZ5SXpzQmlj?=
 =?utf-8?B?bE9jSzZsSFhPOVVnNjAwZjNGRGhIaDRnSDhEcEIyZEZ2dEFkbkhOazJBbFB0?=
 =?utf-8?B?Q3dVS3Ewc1o0c21yWllFU2ZSUjY0S0R3dlJQTDJ3OVlVK1RCbkN2S1lYbUYv?=
 =?utf-8?B?bUhyd2xVdXM3YkhzejZNUlpRVjVOeVJKR2N3TzZZS0dSaWhWRHVZQ3NZUlV5?=
 =?utf-8?B?SVAyUFI3NW9RbkNVL3k4ZlpWQ2NxS3hkTTRBWnZnWTJvRUdZbmpFdGUyUWQ2?=
 =?utf-8?B?VFFWNW5kY2J0eVJ2VXhqT29vVTl5U2EyTnYzVTErL0N6MTRZN3NTdVFlL0Q4?=
 =?utf-8?B?UGppY2lncUFVOXZGbGw1bnRPMjZlTkpwY0kvS2E3UXAwWGdPNTJlNE9VVkhE?=
 =?utf-8?B?VzJ1SUZHdXB5UmRjYmNBd1VFSTJsdlNHVXJ2TnZvMmk1bnRuMlZFcTBZUFBj?=
 =?utf-8?B?TzIxaVNONGVtZG9VTGtZUWhnTzZ5ZFhJV3NFdUtpMFdQU3VWZVU2TW5MUVhv?=
 =?utf-8?B?aUZlZ25JMHlZUjFXZUpZY04yWEVIWlhIT01SZ3RCQzZ3WERCNnZFc1UyeGgy?=
 =?utf-8?B?NjVZU0Q3TEZDSGsyS2RiYzh0WS9KMkhYRmxLV0ZJVjA3RTNrNTZuY0djVE5O?=
 =?utf-8?B?NEk3Yll3UE9pdm1TTzd3TGZ3cytONkRUdERBTGY1VGt4eng5M1Jjd3BMN1Ny?=
 =?utf-8?B?QWNWUHJnWmdJazZwUzhuYkpuc3BNamdEUUIvTVNQelRrYmJkOE1vUFRaT2tt?=
 =?utf-8?B?clNxYkd4SU1QSTBjVXd4cDk5bEcxTkphcTlaWmo1MDR0eFRNU1MwdzQwMHhG?=
 =?utf-8?B?aWZwVFVucW5GaXhEVjVjb2tuVkxQT2xSckhDSlFtcHBOT1pYZjVObFdCQUJs?=
 =?utf-8?B?dHc3U0dmUWkxNHNMeDd4aWxSSEVkaXpLUjdvWlMzWnJPQVFyOXo1Ni9abXl0?=
 =?utf-8?B?NlJHSHlrY21KRVZ1SlplNUJxMVhVSFAzZ3F0V3dRL1BSeEVUemdEQlc3L3la?=
 =?utf-8?B?dE1kQTFucE0rWFV6ZS9CMUFrMW9wM1J5aGMvK1pmbDc5cWE1TFRHMlhDS0FP?=
 =?utf-8?B?eDNMSyt3WXgrZDVaS0RoaWJYZ1FycEEzcHRkSU9jdmVCNE5tMHNrTWZrSEh2?=
 =?utf-8?B?TVd6QTVRa1VGdUdUWE8wc2JUbGpiWkdldUhjWDEwNDlYcmpzUnFid3RTckkw?=
 =?utf-8?B?SXNxbm1teDE1d2xjUUxwd08wRlJkcUFEUERUcVpDSU9STk5TelBiVzVsT1A3?=
 =?utf-8?B?VGFubW5kYjFuMHlBbGxTQlZqWHhuUXlIODNWMFd6YkFidXhtVWRmcXo2Yjdt?=
 =?utf-8?B?Z1diZW9zcktJTHI4RVZlWWY4MlYwM21CWnkrQVVJZXVsVVh4ZlBoU1hXaFk4?=
 =?utf-8?Q?8+XCFtQLQjgeXwmmV7RB4LFuH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b62aca-62d4-49d2-0f37-08de119d517d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4186.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 19:00:51.0085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MjMsea/Hy17q5L1N7frZO7cfN0PuzP1+95Dmt1/XVWYwHd260Bt/WQUu1EwWbOMETysZu/YisZWgrNIXoIRxkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7300



On 10/21/25 7:29 PM, Fenghua Yu wrote:
> Hi, James,
> 
> On 10/17/25 11:56, James Morse wrote:
>> Probing MPAM is convoluted. MSCs that are integrated with a CPU may
>> only be accessible from those CPUs, and they may not be online.
>> Touching the hardware early is pointless as MPAM can't be used until
>> the system-wide common values for num_partid and num_pmg have been
>> discovered.
>>
>> Start with driver probe/remove and mapping the MSC.
>>
>> CC: Carl Worth <carl@os.amperecomputing.com>
>> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
>> Signed-off-by: James Morse <james.morse@arm.com>
> [SNIP]> +/*
>> + * An MSC can control traffic from a set of CPUs, but may only be accessible
>> + * from a (hopefully wider) set of CPUs. The common reason for this is power
>> + * management. If all the CPUs in a cluster are in PSCI:CPU_SUSPEND, the
>> + * corresponding cache may also be powered off. By making accesses from
>> + * one of those CPUs, we ensure this isn't the case.
>> + */
>> +static int update_msc_accessibility(struct mpam_msc *msc)
>> +{
>> +    u32 affinity_id;
>> +    int err;
>> +
>> +    err = device_property_read_u32(&msc->pdev->dev, "cpu_affinity",
>> +                       &affinity_id);
>> +    if (err)
>> +        cpumask_copy(&msc->accessibility, cpu_possible_mask);
>> +    else
>> +        acpi_pptt_get_cpus_from_container(affinity_id,
>> +                          &msc->accessibility);
>> +    return err;
> 
> The error is handled and there is no need to return the error to caller.
> Returning the error causes probe failure and the mpam_msc driver cannot be 
> installed.

Ack. I see the probe failure too.

e.g.

[    7.118297] mpam_msc mpam_msc.183: probe with driver mpam_msc failed with 
error -22
[    7.118383] mpam_msc mpam_msc.370: probe with driver mpam_msc failed with 
error -22
[   10.208127]     # Subtest: mpam_devices_test_suite
[   10.208129]     # module: mpam
[   10.208215]     ok 1 test_mpam_reset_msc_bitmap
[   10.208275] mpam:__props_mismatch: __props_mismatch took the min cmax_wd
[   10.208285] mpam:__props_mismatch: cleared cpor_part
[   10.208287] mpam:__props_mismatch: cleared mbw_part
[   10.208294] mpam:__props_mismatch: took the min bwa_wd
[   10.208296] mpam:__props_mismatch: __props_mismatch took the min cmax_wd
[   10.208310] mpam:__props_mismatch: __props_mismatch took the min cmax_wd
[   10.208345]     ok 2 test_mpam_enable_merge_features
[   10.208411] # mpam_devices_test_suite: pass:3 fail:0 skip:0 total:3
[   10.208413] ok 1 mpam_devices_test_suite

> 
> s/return err;/return 0;/

Yes, this resolve the probe failure.

Tested-by: Tushar Dave <tdave@nvidia.com>

> 
>> +}
>> +
>> +static int fw_num_msc;
>> +
>> +static void mpam_msc_destroy(struct mpam_msc *msc)
>> +{
>> +    struct platform_device *pdev = msc->pdev;
>> +
>> +    lockdep_assert_held(&mpam_list_lock);
>> +
>> +    list_del_rcu(&msc->all_msc_list);
>> +    platform_set_drvdata(pdev, NULL);
>> +}
>> +
>> +static void mpam_msc_drv_remove(struct platform_device *pdev)
>> +{
>> +    struct mpam_msc *msc = platform_get_drvdata(pdev);
>> +
>> +    if (!msc)
>> +        return;
>> +
>> +    mutex_lock(&mpam_list_lock);
>> +    mpam_msc_destroy(msc);
>> +    mutex_unlock(&mpam_list_lock);
>> +
>> +    synchronize_srcu(&mpam_srcu);
>> +}
>> +
>> +static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
>> +{
>> +    int err;
>> +    u32 tmp;
>> +    struct mpam_msc *msc;
>> +    struct resource *msc_res;
>> +    struct device *dev = &pdev->dev;
>> +
>> +    lockdep_assert_held(&mpam_list_lock);
>> +
>> +    msc = devm_kzalloc(&pdev->dev, sizeof(*msc), GFP_KERNEL);
>> +    if (!msc)
>> +        return ERR_PTR(-ENOMEM);
>> +
>> +    mutex_init(&msc->probe_lock);
>> +    mutex_init(&msc->part_sel_lock);
>> +    msc->id = pdev->id;
>> +    msc->pdev = pdev;
>> +    INIT_LIST_HEAD_RCU(&msc->all_msc_list);
>> +    INIT_LIST_HEAD_RCU(&msc->ris);
>> +
>> +    err = update_msc_accessibility(msc);
>> +    if (err)
>> +        return ERR_PTR(err);
> 
> The returned error causes probe failure and the driver cannot be installed. 
> Return 0 will make the probe succeed.
> 
> There is no probe failure in mpam/snapshot/v6.18-rc1 because its returned err=0.
> 
> [SNIP]
> 
> Thanks.
> 
> -Fenghua
> 


