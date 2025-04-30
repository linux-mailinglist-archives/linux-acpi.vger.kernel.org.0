Return-Path: <linux-acpi+bounces-13383-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 367F2AA4F7B
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Apr 2025 17:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 228861B66C2B
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Apr 2025 15:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1DE1B6CE0;
	Wed, 30 Apr 2025 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hNlRQj3+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A4619E97A;
	Wed, 30 Apr 2025 15:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746025254; cv=fail; b=Wo63lU8UCqNPQ2Npciw3ybGVaqR9Q7Pu2sK39KTajPi4jn1jwd+Wo9++Lr1zadAWSBe9dKvkUg5TZTcpwDsNBcdMgT1n9Q3bQrh5hbh17ggREL+CoM0DffFjBdeEXdgkaR4QMgksTNzHk8935Tk2WWCQgj59O860148c/Ga71dY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746025254; c=relaxed/simple;
	bh=Co0Mtx8xaUqOmzSsefGPsxE/gS7wCpYDgR/dKvqigdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jpJJGaP9cH+m3KkthWF7NUDFHsIRiwAJGjusKQLds0ddLnlC7GLICnuikePl/lvpOrQoEntmip3LD0keJ9lbE8pBjsfZ3HGv1MoOk44wLrhljOS/+6wLZwD+NZ6d5BhVoGjMmsTDdk6yaxzoDlfzFYx4eW/LoTGasru59Kqp9+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hNlRQj3+; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xwXhlRo4v/0CqFlUZnThRkErRxvPJHnkduDGWVQXJiks86TUc4nqSwC903Bk085cSw2E3FsAyssQ9D8JiyDDLNlh+1Jj80QJPEe4S0GswkV61FTNZiBgA4v2UljHCD2OvKmwI25gld4ErEHZP/Pc1Z4h7DdLdDv1o+6MyeVUQWyeADEX5+OhlZt4pEdoClQWBy+YRfvNjJq6WkqZ6LPhK6hl0I+h/Y39GF2UmJwqi18rYpN9QY7E3dqB/CvUaee6dSbWOeKY2iw/yKMLitcSOfAb2OZJQgdxUHAiOWKJnRE8jx7YS39AtYN5TsLp3P0IMDy42zjdjeFqI/SjpUKQug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zZr7MV5mk49o3tlE/YdDYH29AhJzm05h0Q2AKre1/o=;
 b=AIUQGElqpbV6R3rdNiQa00aRILxWDkoj6UPHUGJpESmWfKPSVNulRxNXLBlEo+sbl3Gt1Ugy3cwtMGsf0mW6FXNv+j4xPDAh2a0HXGZQ4hv4DsmYbx/xDE18M1tC046mhTDNNDCPfvZx6Xq+VMUUDGJu29rNFnrc/bqPxJyJzrGSnH4MYZJnPcMJfjIPbLW2r4UwSqxyJoAHRT4fTyBJ9GSCyPQTtoHhAUEw7LW/kgMuTTTyI9+5MX4C7VbL8w55+bzHUJOI9Sekka6mbnAeJrZX/zYlRrbjtMkHgkvyVnA1McgZ8g5sfwYHPX9dbQ2GkWdj91rzdWRjNRJv4vrTRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zZr7MV5mk49o3tlE/YdDYH29AhJzm05h0Q2AKre1/o=;
 b=hNlRQj3+kXr0yJ5jLZD8s+XPNaPxugNaCkWYdqkkCWFIcMOsVcp2niA3vvY6tpwWV1uBcMPUY7wSSFcpESQDrfcxGbqmH5Ss79CzFsCAYNYibD1gC7lG4MWSTd6fUWYoTpK0SsG5XJ2bdrWonHC9z1sHbf43X4ajN2SgnHl1s9BoO6F/rLmciIqW5tYdMRFZ84VILnG1cUd+tzxmkA06a7oN3ZOI682vlPwdK5tHB+1cKaR9GxCAXVoEqUXXX26Qa6sPuTIyPxyIaLFHMUBXi8sGQA1IT7FzYCWq/Jxv/KJv3NrfUsymD19K5bA4zo9o/463zpDUfi3B0KLZ+Rkgwg==
Received: from MW4P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::25)
 by PH7PR12MB9151.namprd12.prod.outlook.com (2603:10b6:510:2e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 15:00:49 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:303:115:cafe::e1) by MW4P220CA0020.outlook.office365.com
 (2603:10b6:303:115::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Wed,
 30 Apr 2025 15:00:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 15:00:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Apr
 2025 08:00:29 -0700
Received: from [10.41.21.119] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 30 Apr
 2025 08:00:22 -0700
Message-ID: <076c199c-a081-4a7f-956c-f395f4d5e156@nvidia.com>
Date: Wed, 30 Apr 2025 20:30:20 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch 0/5] Support Autonomous Selection mode in cppc_cpufreq
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<corbet@lwn.net>, <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <sashal@nvidia.com>,
	<vsethi@nvidia.com>, <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>,
	<bbasu@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>
References: <20250211103737.447704-1-sumitg@nvidia.com>
 <20250211104428.dibsnxmkiluzixvz@vireshk-i7>
 <b45d0d81-e4f7-474e-a146-0075a6145cc2@huawei.com>
 <868d4c2a-583a-4cbb-a572-d884090a7134@nvidia.com>
 <8d5e0035-d8fe-49ef-bda5-f5881ff96657@huawei.com>
 <94bdab73-adc4-4b43-9037-5639f23e3d1e@nvidia.com>
 <CAJZ5v0iAg6HFROHctYQwW=V9XiV8p3XVYgeKUcX4qBgfwQK6Ow@mail.gmail.com>
 <e58a20f8-e8bf-409c-a878-af2bd3c7d243@nvidia.com>
 <73fbf483-7afa-4cd2-84d1-6ace36549c53@huawei.com>
 <f0f1b31b-a0fc-4d21-8b79-c896833dae35@nvidia.com>
 <4a87269d-542e-4d4d-9c46-780f9eb55193@huawei.com>
 <00c0f7af-2e1a-41d5-9e56-abf5ef4a2704@huawei.com>
 <d12a2ee3-0ea0-48bf-9f75-b29fc0039d9e@huawei.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <d12a2ee3-0ea0-48bf-9f75-b29fc0039d9e@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|PH7PR12MB9151:EE_
X-MS-Office365-Filtering-Correlation-Id: c040a440-8450-44f7-2124-08dd87f7cafb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEhyVE52a3ZCbVl4S0RuaVFSak95VzByelh5UXg5eDdjTEQxdlJCdWpKc2NT?=
 =?utf-8?B?NkE2UTcxYkhYbVZYbCtXOHNEVFNlU1k4cXRneVF3WDFIMkxKbHB3N0habU5s?=
 =?utf-8?B?aWQ5d3pDNEpFNzJaeWhBeEczTjF5LzkxakxLS01KMDZMZjVnOGgwNkRqUm54?=
 =?utf-8?B?MjMxSEFQQk82Y2lSVHNhZGYrckF3aUVYMmFqL1ErbXdTanR2Ym9MOSsvZDY0?=
 =?utf-8?B?L0pnZlNuNXRQTG45U0w5MFE5UDFBa2tyTCtoZ3lrZDRMZFdQU1VxZFg2eTlj?=
 =?utf-8?B?bjlLbllrSXUzeFQ5Z3dET2pMaCt0YmlBeG1aNVJsSGFCYzZOdEhjV25zRVFy?=
 =?utf-8?B?TE5uUURKWWN3c25PekU5K1lmK05Xblp5Y01IdWhyOUk5NVh6NktQcWd4emo2?=
 =?utf-8?B?b01hK3YvMklDVDRrYk1SaEx3akR5UTJYbWx1THV3MkFZci9ENUNlQkt2YkZq?=
 =?utf-8?B?R1JsbUdXR3NJb3JqeFNNbVNXSXN5c1h3WDM1RktNM1o5eG9sMkpoL1B0bVd6?=
 =?utf-8?B?VEIvNURWZlh5TFEzQzcyVEJBZWRyV056MkVoWTZNL2NTVFBSaWxKSjljdHky?=
 =?utf-8?B?Szl1U0Z5QXRGL2ZNRnM2Y040L0VBWDFsZnQyVk4wd3grRzNEZTUzNkFUU2t4?=
 =?utf-8?B?bVA3MUltWituRHdycHdwcEs3MnpYN210dWZlNWRacHRGVzEwRk11UlpvbnBz?=
 =?utf-8?B?SmcxNWM2TVhLSDdrTG9HYlg0Tm8zQ04vQ2VYeEFrOVF2clRnQXdSc2N3QnFC?=
 =?utf-8?B?VFFGRjJCNmNRdzJacTVHVTNYVDRMbDlDeW8xbG1FbjBuc1VaTjhHTGxvZzJm?=
 =?utf-8?B?VmZkb2cwdlBFYiswNWRaY2kySVp2OGFINEZ4bkM4OXNOQkVBa1V6SXNBZ0RZ?=
 =?utf-8?B?VGZYZFZ1dEd0OXJUMEJ2cjRXQmxVRmp1Yy96ZFp4VDlKMFphN2lRYjVvUmRP?=
 =?utf-8?B?OHI1TFRNWFRjUXVWZm5iOGJMb0VvZnl4eURlTGUzUEFnSDluVDJZcnJydG1P?=
 =?utf-8?B?SGErSkoxc2ZtaHg1dXlmVG5aekFBc1BrZ1lhWGhuSFZzMXpPQ0dFQzZPbmtH?=
 =?utf-8?B?NHhyS1JzMkJlY3BjNDBNcTArUmY2bVNPWFRKSEkrQUdCN1J2NER4bHBZNll1?=
 =?utf-8?B?bXhyTFc5UC9hbW1qQ25MdkdiTnJ4bzNpa01kaEt4U2x0WXl3dWowbVFWTjhT?=
 =?utf-8?B?NUxsK2QwRGdUU1pMSzMxbTdiMW1FRzFnUE43Y2dpRHJWYjZqWGw1YUptaW5p?=
 =?utf-8?B?Z0V1VmUwVjVoLzIyQWNNQ1NSc0ZQYmV2QlV6RFRMWExUT0dSbHo3c2hGRGIw?=
 =?utf-8?B?TmFlVXRCUTV5YXNMLzFrQVZNS3RjNVRzZ05KK0JDOHhnRTgwbU5mcFlqYVVY?=
 =?utf-8?B?MzBLOGNpN1BkL2NhRzIyOHRZOHRsS0F3di9RNVRhZTdiNzVxaGV2RFA2WThm?=
 =?utf-8?B?dnFuUmVLSW84a21zVSszZFRpcXFwajdsdW81R2YwSlN5R1BpWFZvamVDdnRP?=
 =?utf-8?B?T2xCcnUxVnB3TkJWOFJYMHBtMXJ3Q1ZDYThCM3VuOVhkTk1BNzk1VVFiT2VU?=
 =?utf-8?B?TFF0c3JYeExEV0tHWXdxcnZGT0ZiRisyOHppSExuRUFyZ1Q1ck9HcnNJV0JU?=
 =?utf-8?B?RXNHTW9JYnI3VDQ4YVVIaEJWQXl1WS9ncjdIbEYvbkJzVE1jVnhXd29nbFpz?=
 =?utf-8?B?bUNXbWVEQ25RTDNlM0pLSENBVzJyWXV4QWlpVFFZZGduWmp6VkpNSXZrSVYz?=
 =?utf-8?B?MVRLUEVZY052L2YyUjdXLzBBVXpYL0lQU2FvblpJM21YTGJSQWUrd3ZYYXVI?=
 =?utf-8?B?aTlRRkg3dUhFZ2tyQ0ozV0M3OWtMSE5ERHI5NHF6NSs1VnB3cWtrcFFLb1FS?=
 =?utf-8?B?WWNXZFZzZ3h2VXdWRy8xcTBMYVJvc05RVmxrSklXaHN6REhSaFJPN2FCZUM5?=
 =?utf-8?B?UHpJM2w3Zi9OSmJHSEZqSklBTHE0ODNkV3FIZ2Fnd3kxQ0E1L2F1b0JsdDQv?=
 =?utf-8?B?cEZJZEw0cjFvRmptUjBuSWE2ME5wSmtQNEs0SFVlWXdXeWpua1dVdFg5MjR5?=
 =?utf-8?B?V3ZOcG9FUjF0d1dKdmtxYW1qSngxZXlwTDlrZz09?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 15:00:48.7913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c040a440-8450-44f7-2124-08dd87f7cafb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9151

> 
>> Hi Sumit,
>>
>> May I resend the patch 8 in [1] first? Because I really need this new
>> feature.
>>
>> After that patch being merged, you can resend this series base on that,
>> change the paths of the sysfs files, add a new cppc_cpufreq instance or do
>> anything in that series. Then we can continue this discussion.
>>
>> Is that all right?
> 
> Hi Sumit,
> 
> Please let me know if you are OK with it.
> 

Hi Zhenglifeng,

Both the ways do the same job i.e. set CPC registers.

To move this work forward, I am Ok with adding sysfs entries under
cpufreq syfs node and not under acpi_cppc if the maintainers are fine.

I will later send my updated patch to add more entries under cpufreq
sysfs for updating more CPC registers as done in patch 8 in [1].

Thank you,
Sumit Gupta

>>
>> On 2025/4/1 21:56, zhenglifeng (A) wrote:
>>
>>> Sorry for the delay.
>>>
>>> On 2025/3/14 20:48, Sumit Gupta wrote:
>>>>
>>>>
>>>>>>>
>>>>>>> There seems to be some quite fundamental disagreement on how this
>>>>>>> should be done, so I'm afraid I cannot do much about it ATM.
>>>>>>>
>>>>>>> Please agree on a common approach and come back to me when you are ready.
>>>>>>>
>>>>>>> Sending two concurrent patchsets under confusingly similar names again
>>>>>>> and again isn't particularly helpful.
>>>>>>>
>>>>>>> Thanks!
>>>>>>
>>>>>> Hi Rafael,
>>>>>>
>>>>>> Thank you for looking into this.
>>>>>>
>>>>>> Hi Lifeng,
>>>>>>
>>>>>> As per the discussion, we can make the driver future extensible and
>>>>>> also can optimize the register read/write access.
>>>>>>
>>>>>> I gave some thought and below is my proposal.
>>>>>>
>>>>>> 1) Pick 'Patch 1-7' from your patch series [1] which optimize API's
>>>>>>      to read/write a cpc register.
>>>>>>
>>>>>> 2) Pick my patches in [2]:
>>>>>>      - Patch 1-4: Keep all cpc registers together under acpi_cppc sysfs.
>>>>>>                   Also, update existing API's to read/write regs in batch.
>>>>>>      - Patch 5: Creates 'cppc_cpufreq_epp_driver' instance for booting
>>>>>>        all CPU's in Auto mode and set registers with right values.
>>>>>>        They can be updated after boot from sysfs to change hints to HW.
>>>>>>        I can use the optimized API's from [1] where required in [2].
>>>>>>
>>>>>> Let me know if you are okay with this proposal.
>>>>>> I can also send an updated patch series with all the patches combined?
>>>>>>
>>>>>> [1] https://lore.kernel.org/all/20250206131428.3261578-1-zhenglifeng1@huawei.com/
>>>>>> [2] https://lore.kernel.org/lkml/20250211103737.447704-1-sumitg@nvidia.com/
>>>>>>
>>>>>> Regards,
>>>>>> Sumit Gupta
>>>>>>
>>>>>
>>>>> Hi Sumit,
>>>>>
>>>>> Over the past few days, I've been thinking about your proposal and
>>>>> scenario.
>>>>>
>>>>> I think we both agree that PATCH 1-7 in [1] doesn't conflicts with [2], so
>>>>> the rest of the discussion focuses on the differences between [2] and the
>>>>> PATCH 8 in [1].
>>>>>
>>>>> We both tried to support autonomous selection mode in cppc_cpufreq but on
>>>>> different ways. I think the differences between these two approaches can be
>>>>> summarized into three questions:
>>>>>
>>>>> 1. Which sysfs files to expose? I think this is not a problem, we can keep
>>>>> all of them.
>>>>>
>>>>> 2. Where to expose these sysfs files? I understand your willing to keep all
>>>>> cpc registers together under acpi_cppc sysfs. But in my opinion, it is more
>>>>> suitable to expose them under cppc_cpufreq_attr, for these reasons:
>>>>>
>>>>>     1) It may probably introduce concurrency and data consistency issues, as
>>>>> I mentioned before.
>>>>>
>>>>
>>>> As explained in previous reply, this will be solved with the ifdef
>>>> check to enable the attributes for only those CPUFREQ drivers which want
>>>> to use the generic nodes.
>>>>   e.g: '#ifdef CONFIG_ACPI_CPPC_CPUFREQ' for 'cppc_cpufreq'.
>>>>
>>>> These CPC register read/write sysfs nodes are generic as per the ACPI
>>>> specification and without any vendor specific logic.
>>>> So, adding them in the lib file 'cppc_acpi.c'(CONFIG_ACPI_CPPC_LIB) will
>>>> avoid code duplication if a different or new ACPI based CPUFREQ driver
>>>> also wants to use them just by adding their macro check. Such ifdef check is also used in other places for attributes creation like below.
>>>> So, don't look like a problem.
>>>>   $ grep -A4 "acpi_cpufreq_attr\[" drivers/cpufreq/acpi-cpufreq.c
>>>>   static struct freq_attr *acpi_cpufreq_attr[] = {
>>>>      &freqdomain_cpus,
>>>>   #ifdef CONFIG_X86_ACPI_CPUFREQ_CPB
>>>>      &cpb,
>>>>   #endif
>>>
>>> So in the future, we will see:
>>>
>>> static struct attribute *cppc_attrs[] = {
>>>       ...
>>> #ifdef CONFIG_XXX
>>>       &xxx.attr,
>>>       &xxx.attr,
>>> #endif
>>> #ifdef CONFIG_XXX
>>>       &xxx.attr,
>>> #endif
>>> #ifdef CONFIG_XXX
>>>       &xxx.attr,
>>>       ...
>>> };
>>>
>>> I think you are making things more complicated.
>>>
>>>>
>>>>>     2) The store functions call cpufreq_cpu_get() to get policy and update
>>>>> the driver_data which is a cppc_cpudata. Only the driver_data in
>>>>> cppc_cpufreq's policy is a cppc_cpudata! These operations are inappropriate
>>>>> in cppc_acpi. This file currently provides interfaces for cpufreq drivers
>>>>> to use. Reverse calls might mess up call relationships, break code
>>>>> structures, and cause problems that are hard to pinpoint the root cause!
>>>>>
>>>>
>>>> If we don't want to update the cpufreq policy from 'cppc_acpi.c' and only update it from within the cpufreq,    then this could be one valid
>>>> point to not add the write syfs nodes in 'cppc_acpi.c' lib file.
>>>>
>>>> @Rafael, @Viresh : Do you have any comments on this?
>>>
>>> I think updating cpufreq policy from 'cppc_acpi.c' should be forbidden.
>>>
>>>>
>>>>>     3) Difficult to extend. Different cpufreq drivers may have different
>>>>> processing logic when reading from and writing to these CPC registers.
>>>>> Limiting all sysfs here makes it difficult for each cpufreq driver to
>>>>> extend. I think this is why there are only read-only interfaces under
>>>>> cppc_attrs before.
>>>>>
>>>>
>>>> We are updating the CPC registers as per the generic ACPI specification.
>>>> So, any ACPI based CPUFREQ driver can use these generic nodes to
>>>> read/write reg's until they have a vendor specific requirement or
>>>> implementation.
>>>> As explained above, If someone wants to update in different way and use
>>>> their own CPUFREQ driver then these generic attributes won't be created
>>>> due to the CPUFREQ driver macro check.
>>>> I think AMD and Intel are doing more than just reading/updating the registers. That's why they needed their driver specific implementations.
>>>>
>>>>> Adding a 'ifdef' is not a good way to solve these problems. Defining this
>>>>> config does not necessarily mean that the cpufreq driver is cppc_cpufreq.
>>>>>
>>>>
>>>> It means that only.
>>>>   ./drivers/cpufreq/Makefile:obj-$(CONFIG_ACPI_CPPC_CPUFREQ) += cppc_cpufreq.o
>>>
>>> Compile this file does not mean that the cpufreq driver is cppc_cpufreq.
>>> Driver registration may fail, and the actually loaded driver may be
>>> another. It'll be dangerous to expose these sysfs files for users to update
>>> registers' value in this case.
>>>
>>>>
>>>>> 3. Is it necessary to add a new driver instance? [1] exposed the sysfs
>>>>> files to support users dynamically change the auto selection mode of each
>>>>> policy. Each policy can be operated seperately. It seems to me that if you
>>>>> want to boot all CPUs in auto mode, it should be sufficient to set all
>>>>> relevant registers to the correct values at boot time. I can't see why the
>>>>> new instance is necessary unless you explain it further. Could you explain
>>>>> more about why you add a new instance starting from answer these questions:
>>>>>
>>>>> For a specific CPU, what is the difference between using the two instances
>>>>> when auto_sel is 1? And what is the difference when auto_sel is 0?
>>>>>
>>>>
>>>> Explained this in previous reply. Let me elaborate more.
>>>>
>>>> For hundred's of CPU's, we don't need to explicitly set multiple sysfs
>>>> after boot to enable and configure Auto mode with right params. That's why an easy option is to pass boot argument or module param for enabling
>>>> and configuration.
>>>> A separate instance 'cppc_cpufreq_epp' of the 'cppc_cpufreq' driver is
>>>> added because policy min/max need to be updated to the min/max_perf
>>>> and not nominal/lowest nonlinear perf which is done by the default
>>>> init hook. Min_perf value can be lower than lowest nonlinear perf and Max_perf can be higher than nominal perf.
>>>> If some CPU is booted with epp instance and later the auto mode is disabled or min/max_perf is changed from sysfs then also the policy
>>>> min/max need to be updated accordingly.
>>>>
>>>> Another is that in Autonomous mode the freq selection and setting is
>>>> done by HW. So, cpufreq_driver->target() hook is not needed.
>>>> These are few reasons which I am aware of as of now.
>>>> I think in future there can be more. Having a separate instance
>>>> reflecting a HW based Autonomous frequency selection will make it easy
>>>> for any future changes.
>>>
>>> So CPUs will act totally differently under these two instance. But what if
>>> I want part of the CPUs in HW mode and others in SW mode? Should I boot on
>>> HW mode and set some policies' auto_set to false or the other way? It seems
>>> like the effects of theses two approaches are completely different. In my
>>> opinion, this new instance is more like a completely different driver than
>>> cppc_cpufreq.
>>>
>>>>
>>>>> If it turns out that the new instance is necessary, I think we can reach a
>>>>> common approach by adding this new cpufreq driver instance and place the
>>>>> attributes in 'cppc_cpufreq_epp_attr', like amd-pstate did.
>>>>>
>>>>> What do you think?
>>>>
>>>> I initially thought about this but there was a problem.
>>>> What if we boot with non-epp instance which doesn't have these attributes and later want to enable Auto mode for few CPU's from sysfs.
>>>
>>> That's the problem. CPUs can be set to Auto mode with or without this new
>>> instance. So what's the point of it?
>>>
>>>>
>>>>
>>>> Best Regards,
>>>> Sumit Gupta
>>>
>>>
>>>
>>
>>
> 

