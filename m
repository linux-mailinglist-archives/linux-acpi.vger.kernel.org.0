Return-Path: <linux-acpi+bounces-4282-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F0887979D
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Mar 2024 16:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 687691C2179F
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Mar 2024 15:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BBB58AD4;
	Tue, 12 Mar 2024 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZI18UvIT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2049.outbound.protection.outlook.com [40.107.212.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC451F4FA;
	Tue, 12 Mar 2024 15:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257591; cv=fail; b=cwzc+/mNqmGoSitXP3rR0YcofzTY+en5Tdjt+r1btYOw/5VkePijlxl1yZDuoFpyQeza9OS69AQFyj5sK2BxadsP92OiQTOhOL1Nyww2ECNWe5trkSqmIYMY4ROYWWx8Per/TL/bpIg41xML6WQ0JX3GQY7ASDg4UnYGbdQgk50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257591; c=relaxed/simple;
	bh=mni5s5VRe4sRnpNHedFUTmq1H4VUvhvW5cPfBph0uxU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WCopBOjaOLYzAx/aXQCJFs5pXxTYqqiDQTG78pp9dONmpQHm6QPBU+x2sAK/Ja4n/yB2L0H5zunn5Y8LuiG3k82TC3KY+sAiELufBCniFu+X4hRMe/v7+V1X++bzm/S82zio9eBPVlyKvgLi/gGGJgfniqHyDktifhtcR9QbBe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZI18UvIT; arc=fail smtp.client-ip=40.107.212.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPGf/KwQkShPTnnWA9bXhjcrFOAcCPtoD3RRaPhpuxSLW049lKSfISG6WpF4ctolfcjAIy+g2tVdjBGIl01tY8XBeDgif2+fcjsyfb0ORp7D2FVgAIYvuSC8Oma//KyS+jZJN3AbXoc9u53pTKuDNjAGPWdu8Us0E0HmPFlL+e5d0Zn8v8di0jjOgeVAR0jYvh0bBNfynW6fRT3S8IomGtx+eitc/4I5A/1hh4mYlFbM6TRYU3mg7VspFH0J7fGLIbOw+hg4C/lbiy5+c1PE6ee4jEpu0+Ez97zage22LwHXjQqLetAcgUTrYi+bknY+i1g0KDrESyKRzYUPw+x8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bv7ZUd6O07qvvVVmgLG5rv07Jy/sP4rm/mdqy50GGKc=;
 b=f69OJFFgSorgolqAaojHaBtYzm+ZtfOFVU9AD8Wq1c4Rsof/4EAAFhvBRTeBvy5fPvabaYce2Nu1wt5LDjZTDarWtYgeh0n+7s9gTGcLAsdrPWTtuo8rzlEvYeq3V9PlDfPEIabIXwKTOKCjUuwLpS7CmWHjxFxaZDzCvm0JBaTHcy3L1AOO9VIL06vb6m/FaG7iX5ttTNDsGtPhmvsGdezcrgO+gXH0CaA5KrUDgZZ2iep06TWA8hiw6GVweczU0Q0+3qwNSL5sIBkLWNrybeL+Uweal538q2vz4//I6oFqlZ82EYwERxWPIVN7mTmaQsF3g+adRkLLEkE0+knaPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bv7ZUd6O07qvvVVmgLG5rv07Jy/sP4rm/mdqy50GGKc=;
 b=ZI18UvITIhNGGr7Q4w5JmQgJL3I64dC/zKiA/4NoFZdZ9TaX9usrRyGOK3EWG6n0QZH0dWFLZtDa2BD1xxIeO4H/QiwVI+VM4k5NtWsoWQDcmA6We6b2nMmANbJ7e8TTAtk6lyLUrLuHK2vvnvcisEmEDcHB8UCxJ7d1ZNFk/nc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by SJ2PR12MB8942.namprd12.prod.outlook.com (2603:10b6:a03:53b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 15:33:06 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::5302:26cf:a913:7e06]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::5302:26cf:a913:7e06%5]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 15:33:06 +0000
Message-ID: <6f4d6962-3093-4f21-93b8-f2fa2bb2b465@amd.com>
Date: Tue, 12 Mar 2024 10:33:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 2/4] EINJ: Add CXL error type support
To: dan.j.williams@intel.com, jonathan.cameron@huawei.com, rafael@kernel.org,
 james.morse@arm.com, tony.luck@intel.com, bp@alien8.de
Cc: dave@stogolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20240311142508.31717-1-Benjamin.Cheatham@amd.com>
 <20240311142508.31717-3-Benjamin.Cheatham@amd.com>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20240311142508.31717-3-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::26) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|SJ2PR12MB8942:EE_
X-MS-Office365-Filtering-Correlation-Id: 8887d08e-7075-4ab0-b8f3-08dc42a9b6d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xXMMf3oPMXhbvow6IjlOLCca7+gcJtWmeG5UarSJ9lZvG7KQz7XqFTq3tay8b0d1888Vd55WFdQacx7JuOhLCVPSxUt2j9bLCA/Wnd2wGHKMsrgfJ5AxfA2leeez7oluz0RYk4fzVb4OdjOQIemTfx3DPXvLCZobEeaYJ3IdtdEwXA2jdg4c6jln4JnNL+ISvT2CM+ymRzaW2CMVOEuWhEXGoDxpN7UAaykfTduqaCr6eMxnMvnC1q7IC5XJXjMFaRVNr0tY5pqZ2aCc3IUGXx76jkEIufxQeLrXgeSbvsG7GJJKAjG5nounW3zESlQ2cX1yAL9DQ7i1P/xEX3LkL2VzM4A15atGYi0Rb8CokF0H7UTj6mkN4F5WCmvAGOaGlB3enYv7T0FrwBIFrXz73bMG/Jc4I/P8vt0KGlls3zhoaqZVMwwiYpWGzRpidDk5sC2r+Y1Mffyxgjo6zajXTeXdVDEBnzqrrGhxSNIat0TVkxSIVLQWe7Yq9SmSMoT0kC86w5lGpzIfQRQT3HP9Uw28+/7EGOMQVUowojyhQNA/YPCOXVCmcEgMtsakMJAPgc04/gchRiW80AqIwzTj//gTDdcloWIr2LFaDXuJOlKR9pRyqgj6jLf9mqkDDcvlHg4boylwAiRmaLNbGMDRc/kRom2+W3fZhYkvGBLRbWY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2pndDltSWM0NnR5ZWdLSUNqQndBMjlydTcvcDhjZFloV3VORHphNnZ4QXJh?=
 =?utf-8?B?MWt4YWJpcHNYU0NSYlNySzM0bTFSRyt1eFBFeW5pWjhjNnZFeDM4T04zVUUr?=
 =?utf-8?B?b3F5ZHJWYWJUQ1FJZTJOQ0NvU3BTTExuVTdNMkt4NXR0UXhsTlc3MGc4WnZ4?=
 =?utf-8?B?UkZvZENQa2xYWjY3ejJnenhoM2FIU3N4SEY1RWFOVytLeFV2eDdvVldhN3dR?=
 =?utf-8?B?YjRqUTJtaytBNWRCV1ZJTTRqWERZcFdkTjd5MGU2c1ZZL3V3NUgyNWZRNUZU?=
 =?utf-8?B?WlpjRGZDTHNqU3Q1WFhuYnRqV0pnWEhCdmVZOWRRNGN5Y3dzOVVNVUFENUY4?=
 =?utf-8?B?UHlCWkRYdzNMUXdQTmk4eGQ3clRBTmdnM0F6Mlc2WE9NbWFBazBOVVJmbU85?=
 =?utf-8?B?VzZsVkU4RFAzTlVvTnZScU9xc1BoWSsyQlhTRkwrNWNpOHN6QVFpdVU0cG5k?=
 =?utf-8?B?UmFjMmFMeEhpVDFTa0hoMm5teHFwTEhtM3Y5RzdiUW00SW9mWWErM1NWdkxi?=
 =?utf-8?B?UDVMZW5DcFhWOFhqL3hvaW12SlIzM1FUMzJhRGFla2pGVUNjai85dlg3clFS?=
 =?utf-8?B?bndNcWNScXNXODA5UXZMYno4NnFwSzI4MkZwTElENlR5eUlZeFQ1NEU3dU9Y?=
 =?utf-8?B?b2ZMdm1BSXdSTHFrUkpEa3hoSXdmeSsxQlZOTlB6VzkzWDRCUEplNjhJdGV0?=
 =?utf-8?B?c0d2VTlmNFptaFV5T3B2RTNvRy9lbXU3dTUvZVBIVXRBZlB2SlUxT2ljRHhX?=
 =?utf-8?B?SzhPNGFoYi9OUEV4TDZydEl0Y2NsNTZobVh5dTRoa0ZNUVNydnFkbXFxcmUy?=
 =?utf-8?B?S204TWU3eDZHUWlScWw1LzZFU0ZQRU4wUTlGTzgvWlorWjVyekpYSHNEd2VS?=
 =?utf-8?B?TnBRcGRNNkdpcXRCNDVhcWtVMjd4ZWFqMU40ZU0yeDVjVEFiYWNKVTlJeXhq?=
 =?utf-8?B?VmphcjhYbG0xeHQ3T0RnNXZOdHFUK2daNXNaLzZZMTd5b0hEK1RsWGVUWHg5?=
 =?utf-8?B?aS9iV0VWY3hqMUdTbHhHcEdjL1VEaC9zNjVmSDB5VDJtcWl4VnRoZlJrR052?=
 =?utf-8?B?OG1ZWmljTnVTb2ZjZWxPQWFhSzE0SWcycTdLTW55SEV4WnlQbUNrNmJTc1FK?=
 =?utf-8?B?YjNBYkpyYzhvV01JR3AvcVREcEgzblRlMVZJZWZLSG9QazdsVlkxdDZzcnRs?=
 =?utf-8?B?bjlHTHV3VnpXWDBjRmxUTktKSjlOYk1meng3b1kweEpMWlQyTVV3NUZlc0xk?=
 =?utf-8?B?OUkvWnJ5UU1tcFRaM1Erb2JSSDRidGk3WmNzYlZmYnA1Y1lRdW1aeXlPOWVu?=
 =?utf-8?B?RHF0aVZWYjg5ZDRIOGdVREVUcFJISy9kQlA5ZytxMmFya1dPU3ByWlVFejR0?=
 =?utf-8?B?T0JvaHUrYlhTZnlZTjVQaW5HY01vSEVva0Z4VHU4VGFBK21KRUJra0FyOUVr?=
 =?utf-8?B?MFlmbTh3dU1SZ3UwZnRCd2xwQVBVVkdKWWg0N2pGMTArNjVBNGFxRlNSc2w1?=
 =?utf-8?B?YnZnUWdVemg3OHZBTUJTZnhDTHZNbkJReGIxNDhJdUUvQmtqZFdYZGJ0VVNs?=
 =?utf-8?B?NU9QS0RzU3d3QTBLSGhYZUtsUDRtWlEwWWFNa2lmUlQ3TGorK0gzRXgvY1pu?=
 =?utf-8?B?NHM4dnpORVdZUjJqZkJiYlBCZElnaXQ1RW0yOWtTRUJGRUN5S2d0QUZ3T3Q0?=
 =?utf-8?B?SHZTd0loYTYvQ2RDTnFMWnZTTzBTaGlmTHBqa3RDVyt3MklLQXhDbFNnWWV0?=
 =?utf-8?B?bXYrZVF4QWVQSHpFbmdNdVQrbDF4VSs2bzE4SmNOSDYzSkRVMExsYkVGd1Uz?=
 =?utf-8?B?OUxRQzlhY1VNVjlEQmZreDRpdmcxblkwTzVMNE9KVGpNUXNDVXRRc2pzcWx5?=
 =?utf-8?B?eTlqT1dGYlVTaXJwUThTNHpIU1U4Y05DZnFaVUNIT05nSEtINWxUakEwZ1Ir?=
 =?utf-8?B?cTRSRnUwenJBbXdGZ0dDdnhva2xscEJOcHJ6Vk9lcXllWHNUVVlzTlo1M2NW?=
 =?utf-8?B?TEJ1Z1pVVGFTUzl2UmI1NFUxSi96Z0xWRmxab3B6WnQ4amU0NE5sTU9QQ2xP?=
 =?utf-8?B?ZjFsUTBFWnZUUzVrNnpKblZWUlFlM0N4OGs2aE9VRW9odGh2MllsOUw1WEE1?=
 =?utf-8?Q?hWbdkGs5a45hGmuE/tNf700H3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8887d08e-7075-4ab0-b8f3-08dc42a9b6d0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 15:33:06.5671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 89WhkkPQRJIMSaSMWlB4O9THVbIv6pbSMW/bNfP5l/AsJtVyrvtH3ODzldw5TbTrAa8/wltMeguGcEprOiST7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8942

The kernel build bot found a build error with the following config:
	CONFIG_PCI=n
	CONFIG_CXL_BUS=n
	CONFIG_ACPI_APEI_EINJ=y
	CONFIG_ACPI_APEI_EINJ_CXL=y

The following diff seems to fix the issue:

diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index f01afa2805be..7d5634357d4c 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -63,6 +63,7 @@ config ACPI_APEI_EINJ
 config ACPI_APEI_EINJ_CXL
        bool "CXL Error INJection Support"
        default ACPI_APEI_EINJ
+       depends on PCI
        depends on ACPI_APEI_EINJ && CXL_BUS <= ACPI_APEI_EINJ
        help
          Support for CXL protocol Error INJection through debugfs/cxl.

Or if depending on CONFIG_CXL_BUS is preferable (it also depends on CONFIG_PCI):

diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index f01afa2805be..3cfe7e7475f2 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -63,7 +63,8 @@ config ACPI_APEI_EINJ
 config ACPI_APEI_EINJ_CXL
        bool "CXL Error INJection Support"
        default ACPI_APEI_EINJ
-       depends on ACPI_APEI_EINJ && CXL_BUS <= ACPI_APEI_EINJ
+       depends on ACPI_APEI_EINJ
+       depends on CXL_BUS && CXL_BUS <= ACPI_APEI_EINJ
        help
          Support for CXL protocol Error INJection through debugfs/cxl.
          Availability and which errors are supported is dependent on

I could send out yet another version, but since this is a one line change I would appreciate
it if whoever picks these patches up would just include this fix.

Thanks,
Ben

