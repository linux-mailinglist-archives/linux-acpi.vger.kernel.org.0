Return-Path: <linux-acpi+bounces-11371-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D06CA3F5B0
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Feb 2025 14:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9048189D05B
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Feb 2025 13:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A2B20E318;
	Fri, 21 Feb 2025 13:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s2OE14ap"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB921E87B;
	Fri, 21 Feb 2025 13:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143689; cv=fail; b=SwkYEHtnlhuJSfw3R6QvNEuXn5rndNt3PAOx8BKmzjq/YA2zudOpRXiSs0AweEvbOpmotJzXcXfF7k9oQ4T6NHo+AN+ndE8j43hO82z2UTxeMNLSJfyq5HxJmW5W2vFEgL0h0sLdOYljHBkZY7s+fPTYbyhQquPco1vM5dAeh/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143689; c=relaxed/simple;
	bh=BkNmySyZ0vq2vc3/32hvXLVv5wLXERBOSZJhaPBo5FY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Y047wqWRNZpfFJyz/ar0nonlFIAaKjmn60sR8S9LwC4Zi878bWB2tU6Z9ZHuHljE+EOSTwpBrW6PQASj1zbCsCQMlnkEv5uIYXTht4AerbT+4q0X04Ft/UJ2k5KhRRcKTSnTP4nMNXhatcULORDJeN+aeiRqWxS6rrEzEFnbtQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s2OE14ap; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ibfj9wTBMrA45GVHbYSavzDktQpIpK9IZIZ+Culgkq/FHraFCTitr3uqsbXmV/lIDCFgKJolXoxj7jF5gZXYSUrqz8hassM1V5Zqfwg7asvl76gFSx9GfKXdsBBEaJzuO19cLp0nzmQCzDzXzBQtWxhpLhSxVkxicrMm+qoIi4jvoV3B1NkYAoo50AvIvL+U/2GiDzApp8tEuX8/ONvpa5i0oZ4jGY28uYOlAjWMx2ujbFhB/0O1Dke21QDfx7NUvQr/D/8MbMHpgi9loSAaDYVYLmmgkOVnjKPUEa2pAq8p99S38qNDxsTqfcay2c+Ivhb36M+Jau/b4TaX/vvPOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WaFukh8+tB9PxqkAkUSFbLsniGJgAwAxHNorMAf7OxQ=;
 b=VzSadEIlRzpz5IcIxdRFGSS1Dje/XglGyvk76U5kPw5jUgAZW7xG93Jch6yq8o7RdhItQUXTJp0hpbH2e+Xz/3N5SIgqSRENuCLhxHERyf0Sjb7fY3T/QX14SOAm7IG9nFaxEgvWk2rzOjiAN4BMPFEdmYvN8U0tEn6hDhS4N/GtIO2jFzknwUddfJDyt8U8LNTc801QigUj01LWHGfGxNT4UM4YHsJv1RPZlNPyCd8hZAOTV2wbH3wn5kzm06dRqp51z+VLxSRxKo2HjuxIUEz7OWjpjKidNw+5LdAtGMykhW11Hf1x36s4BpRxXrzqVQVbfNBRAN/De+rWUxQyew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaFukh8+tB9PxqkAkUSFbLsniGJgAwAxHNorMAf7OxQ=;
 b=s2OE14aphAD4bSZ5yk49DZrmqTk2YZWtQwx0nrHoHaw5CNsfPL5WqS+naBtPeNE/KsexOodKm7pO+G9f/k1r8Q/QSCAUNWjQbTM3+dAiCVFRQ99A4k/1eSDCZ/mrKSEZv5xldtGzdIasXeIZNB/BHo9MquuceUHWzhE+/mNNpXFqL/D8tb1/08ecN5PIY7k9w6LPpEXwue5I5fvtq6TBz9IWeS5kEG659yrj5MIDK+FRydv1BHXp93kHpQNE9jTY8ZotqZYPkoHBbxjGaS7wpfscUHaOT0eusIDG+e0tFJ1J/s8ayv+xIJ1OE8ElhrFe/FrcipcO+jP/VApv1zmovw==
Received: from MW4PR04CA0067.namprd04.prod.outlook.com (2603:10b6:303:6b::12)
 by DS0PR12MB8341.namprd12.prod.outlook.com (2603:10b6:8:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 13:14:43 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:303:6b:cafe::5b) by MW4PR04CA0067.outlook.office365.com
 (2603:10b6:303:6b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Fri,
 21 Feb 2025 13:14:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 13:14:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 21 Feb
 2025 05:14:22 -0800
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 21 Feb
 2025 05:14:17 -0800
Message-ID: <e58a20f8-e8bf-409c-a878-af2bd3c7d243@nvidia.com>
Date: Fri, 21 Feb 2025 18:44:14 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch 0/5] Support Autonomous Selection mode in cppc_cpufreq
To: "Rafael J. Wysocki" <rafael@kernel.org>, "zhenglifeng (A)"
	<zhenglifeng1@huawei.com>
CC: Viresh Kumar <viresh.kumar@linaro.org>, <lenb@kernel.org>,
	<robert.moore@intel.com>, <corbet@lwn.net>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>,
	<sashal@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <bbasu@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>
References: <20250211103737.447704-1-sumitg@nvidia.com>
 <20250211104428.dibsnxmkiluzixvz@vireshk-i7>
 <b45d0d81-e4f7-474e-a146-0075a6145cc2@huawei.com>
 <868d4c2a-583a-4cbb-a572-d884090a7134@nvidia.com>
 <8d5e0035-d8fe-49ef-bda5-f5881ff96657@huawei.com>
 <94bdab73-adc4-4b43-9037-5639f23e3d1e@nvidia.com>
 <CAJZ5v0iAg6HFROHctYQwW=V9XiV8p3XVYgeKUcX4qBgfwQK6Ow@mail.gmail.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <CAJZ5v0iAg6HFROHctYQwW=V9XiV8p3XVYgeKUcX4qBgfwQK6Ow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|DS0PR12MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: 370b9286-daa1-49bb-f4ba-08dd5279b492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VW1iYURCTytZM25LbEs5SVNoeW1QZFgzWHRNTUIydjhtZzRQcGMwQStrZzdV?=
 =?utf-8?B?dk1abGhUQ1FwOHhTYXcxRVBGRS9uV0RrRkpkQWZWTktwQld6THVvdWZUSDI4?=
 =?utf-8?B?QXM4Q2twQ2d2U1dvbVY0VTN6THNYRGFHUVZnV3NJNmM4b0ZjTmIvQ3dEZDRZ?=
 =?utf-8?B?RkhIVzc0YXQ0RXBhYTJWMWFjdzdFUHJld1MzWWxsR0JXV0phVkRBTC9RL01S?=
 =?utf-8?B?K1R2TUt3bFV1L0FuTXEzMVlMVVNObVFrc0YyV1FXNDVuNWVQdVhwSXRVQUdO?=
 =?utf-8?B?OENTTURzNHMyTThaODVhQzZ6TGl1bXlxTFdXRUdoZENuL3hOaFEySitCWWNl?=
 =?utf-8?B?TlhPVU9yajFtTU10YzAxTnpXM3grVnd4ZUZwNVpPTGQwQnlQZkhKS1Jia0x5?=
 =?utf-8?B?dU1TK1BzeTVIN3hRaGVnM25NRTl3eUQ0cFFldSsxTWZKK0ZpMUh3RDg3K2VZ?=
 =?utf-8?B?ZUJZVjk3Y2szeGdqQjF0U0RlUDlMc2RYTmY2N1U2ZzNtbEJSaHJWa2ErbGlF?=
 =?utf-8?B?bGdVenluR3doVEYxTE9TS2QzZU5CYUVjZWZ6UlF6TExFL1U0NGpNZ2F0V2VW?=
 =?utf-8?B?bThnamt3Q29LVk9sSDRUMWZZbXV2Wmh2Z2pjeHlzczVqMkZnMjYzaDhKcFYw?=
 =?utf-8?B?N29xdExXQk9CRlFOVStDT0diV2U2aXp3SmZ0M2Mydm9BcTdadzIzbXBHWnU0?=
 =?utf-8?B?SFdrS1pqNVVnMDFwZkgxdEtCQzYvMW53SDNBbEc3aE1YYXBES2dyRjYwbXd6?=
 =?utf-8?B?VzhvNjA5NzR4RjduakQ4T1lucXRlVW1oY0J5YXBjYW9HQXpjSHFQdWJ6bWtL?=
 =?utf-8?B?M3ZhSGNyNElGOHl1QjRNZER2RGV6bGRseFJycUtXZE1xY00zTC9ubDd6ZGNK?=
 =?utf-8?B?UThMcnhPL01Ed1dJc2VOV1l6R1lySmdsUWlNVUpKQ3ZaVGFBNWRpTXZwYWVT?=
 =?utf-8?B?R0VUZktPVE1pSGlZV0tlY1hLVzJIaG11Q1U3TXR1Q0xGK0haNGlCMm1BT0Z6?=
 =?utf-8?B?emtKUGQzNGtPZkZ2WDFPbWR5T0luc1hyckxPZ2FyTXRsai9zWGxQaUxOK2pV?=
 =?utf-8?B?VkR1Y2JSbDEwM2JPL1BEaWZMVXFYdGFXbFYybWNmNDVNNEFZYmpmWjRvM1Ju?=
 =?utf-8?B?dldFZUtXL0JFZkpMWlhVa3Z6SVFtSlB3YnBKRW1CQTBoMCtIQnk1R0VxZzFz?=
 =?utf-8?B?TVNDaVAvYVdUV29VSGNLdTJYOVNJSUh4VUdJU0VXWThtdkRwR21iMkhxUTh4?=
 =?utf-8?B?UDY3WTRtd1pIdzkrYmFRV1VSNlFaU1FnWXpKWDRjekRxcVNNZE9DZTNQeHFU?=
 =?utf-8?B?ZVMyOWlFUStjSksvdlZibW1kdFNQL1MyQ2l5ZkxBR2ZPUlFnVVFJNjM5VmJU?=
 =?utf-8?B?eUFBY3FHZy9YcGlid1dQaDBQbjhCM3paMVB3VHQ2WHJkVmx2VFhtQ1YrOVZT?=
 =?utf-8?B?aS9tc0dQdENDQmdGMXYzMjZmTjBNMDhzU05xZVlRb0ttZWFBRm16OVI0Tlg0?=
 =?utf-8?B?djBOYUFIbjd3V3RuS1NWcHAralpVanBvSWdsMjlWdnUwR0ZYdFlpOXRwMjMv?=
 =?utf-8?B?OHJKME40eTRkZ3pBOVJVdUhlUFZmUUlINXc1WktaQ1dWVVZFcjZvbmMyZnQ3?=
 =?utf-8?B?cTRVSHo3VXZKWkMraTJWbmxiZEdmdU1oaDIrenZKZU1zaXg5SVdPRmJldDQ0?=
 =?utf-8?B?clgwUVVsVis0ejVsQlVUelhXc2hHUlJvVkVlYnFHOE8wcUlvckIyMjJKd3Fh?=
 =?utf-8?B?QXFnU2k0YitZVDNqVTR2Z1liL1NzZjY3SUdaVjZlbkh0YVlMSEc4cFdjSXFE?=
 =?utf-8?B?SmpDc3hHOU0vRTVQdmhIbmM5aVlPa2VwckZZOGNFamZqbkwzOHYveWNtbHZB?=
 =?utf-8?B?cEpTTGdKcVpSYkRIUEpCYW5IVVU2MWlXZTEyRnRENVJzM2Q4bzJWRUFVNmVH?=
 =?utf-8?B?dkV2dkVUWWlqMmtuSm5jUlVKSHFNa0p0N3JyQ0hJUjhTTGtJS3pKTEZHUXlG?=
 =?utf-8?Q?5QaIWCcnvayyEk8/Sl05UVQp4cYeXY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 13:14:43.0216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 370b9286-daa1-49bb-f4ba-08dd5279b492
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8341



On 19/02/25 00:53, Rafael J. Wysocki wrote:
> 
> There seems to be some quite fundamental disagreement on how this
> should be done, so I'm afraid I cannot do much about it ATM.
> 
> Please agree on a common approach and come back to me when you are ready.
> 
> Sending two concurrent patchsets under confusingly similar names again
> and again isn't particularly helpful.
> 
> Thanks!

Hi Rafael,

Thank you for looking into this.

Hi Lifeng,

As per the discussion, we can make the driver future extensible and
also can optimize the register read/write access.

I gave some thought and below is my proposal.

1) Pick 'Patch 1-7' from your patch series [1] which optimize API's
    to read/write a cpc register.

2) Pick my patches in [2]:
    - Patch 1-4: Keep all cpc registers together under acpi_cppc sysfs.
                 Also, update existing API's to read/write regs in batch.
    - Patch 5: Creates 'cppc_cpufreq_epp_driver' instance for booting
      all CPU's in Auto mode and set registers with right values.
      They can be updated after boot from sysfs to change hints to HW.
      I can use the optimized API's from [1] where required in [2].

Let me know if you are okay with this proposal.
I can also send an updated patch series with all the patches combined?

[1] 
https://lore.kernel.org/all/20250206131428.3261578-1-zhenglifeng1@huawei.com/
[2] https://lore.kernel.org/lkml/20250211103737.447704-1-sumitg@nvidia.com/

Regards,
Sumit Gupta


