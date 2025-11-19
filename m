Return-Path: <linux-acpi+bounces-19060-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3306C6CC6A
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 05:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F327834F6A3
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 04:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6366F307AC4;
	Wed, 19 Nov 2025 04:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="liiv3YtE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010052.outbound.protection.outlook.com [52.101.61.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472A323817E;
	Wed, 19 Nov 2025 04:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763528046; cv=fail; b=rOrK3hGPeTg3EuITAq0F7MH3yzYktD7dqYXhO5GHzaG4XXLIsp7m6GQtH2/UCzGTJmbXyJ1UuNxl2A6btjn4QemoFl9kg556Jrz+eKbRsO7rflk9OhmWpDtWY5HEcwpJcXXsQqQq5JExEwQ8N2NTyCbuye/EXiCJRQAAGc8/4Po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763528046; c=relaxed/simple;
	bh=HOE+ib6uoaE6XPo+Gl4SaB8xPfRO52ceNNrHLUcnfyE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DN8ibLDEGxQJwYYEfedXTLSaS/ICPFq2z8HDIPE2Ihv8fprjB2UGhW+vmSGyHSe/XfrCziRNC+825kB/60FNtc3Q/8a8qKKfDKFLtDKJEllNkBP/GMF4yojrmFAFsZdkWvm8ji32PN2jNKmUzgHWvsi4RyhoGitlYoHxrs1G9jI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=liiv3YtE; arc=fail smtp.client-ip=52.101.61.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+XF5iVVkjQ13Ql+bBm5J4JWVJ+Hd5csgqIXO0OhK7D9LKtRbLl2Um3RGMly4sZNjbg/ChclTh0C6HII09uhaCikj0pZN8STNoUfXOpA9j5H1cWCbH9R/xSMXYQbMsel0ELYS2IotN8Mx4FysDeJOPmTb7Olz5qlbaHt2Jum/ywB8OCWKMvLOcyel9CgUTDr7Q8XU0fYW5VFj5HzyEPg/qDSxAap21fQhl7BMgxDZ3CPD7RSRviVfGrZkl6aahfgtrEdH79O1usiIKy++3FCiMYRxghkVUFfWzVfb/1qwYvMnx5vDnNoSJJrPUqpSr6mEGRKiwGzeU1E6F7bF5s36w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vs9oucmF/bMZxc5wX08jDiBBAQ5nFmcF/NP9FZ2hd0k=;
 b=mEtd1qn0ZBVbgSmaattsYI14t3Bd03ozwwPoYnASfxGv9eUjuGqiPWwwQbE6rFWO10ABQFpQ3Ya8+cXOC6pVOitkSVO7f5gAV1qGCmWB0MJLTqCNqexo+ZcC+KQy8+5KEIzzh7LIpzd0moE6IyAzTy0f+PzPle7Nouj6n3CCqOMVJK9vGt4ZyxB2CriKgrn1IKWQsTHH6DN/zrBkiVD3JwenmUF/AxGAK1X8uxbuWmE0b0UOEMQPz5th0VW7VBm4RkQeOfYaR0VUiyESBeFGzO82o4ipdyNNjmPlnvop4gEzm65MCou1sCeAzZwHcCz/7dbL/xREUoJYYl/JqulG+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vs9oucmF/bMZxc5wX08jDiBBAQ5nFmcF/NP9FZ2hd0k=;
 b=liiv3YtEgOfk1xZwp3Ehmc/AkZQafC3PjEd1YxkgOqyrIEYJEKDxQGseo4RptqSEmObG5osLWt3SjUe4pk/S/S4Y7emHClFG28SjSO8mrVULGlJGlD8NMMNcV50Z4uuD0ZjqUC9Q9TwncnY+9YvRYqhFcHe8i1MT72TCzxhAYv6KibotlA9JBQnBubFp2KQpouukkDIIUVoNvA6eylNz9OPfX5a/+SWq1eGYesCn32O9TB/AJl4u9udASXCeed/LQRtYLo2g/dTAAyAtQuV/gszqy0L6LmkktKiIbCjIf0OKni2nZFSsI5CL1UJ9ThPfIdqEvWjq81YQlNUjULJQFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 DM4PR12MB5961.namprd12.prod.outlook.com (2603:10b6:8:68::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.22; Wed, 19 Nov 2025 04:53:59 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9275.015; Wed, 19 Nov 2025
 04:53:58 +0000
Message-ID: <741517cc-b9d0-4f9f-851d-035dd5e4989e@nvidia.com>
Date: Tue, 18 Nov 2025 20:53:55 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 23/34] arm_mpam: Allow configuration to be applied and
 restored during cpu online
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
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 Zeng Heng <zengheng4@huawei.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20251117170014.4113754-1-ben.horgan@arm.com>
 <20251117170014.4113754-24-ben.horgan@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20251117170014.4113754-24-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P220CA0147.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::21) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|DM4PR12MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: 091372f7-1cda-4877-4585-08de2727a69e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2V6ckFZU211WklMaExZc2NaWnpBOTc4amZMNWZDcHVQbkZzOUw4R1NIU21v?=
 =?utf-8?B?TVZaRWhrSnJIUEJvSDZadkRqQU9KZUdpYWZpdnNLOTBGRUhMdkVHanBocVVj?=
 =?utf-8?B?WTB0S3NHd2tJZlhta1JqeU1ETXM3emFSenZjSFluZFRTYmZHVXR0VmxIdFZC?=
 =?utf-8?B?THZLRVFCMmZSYjg1REVsKzQ4cUwxblFITXdLeVJCQU9QZnl0OVZyYlQybDda?=
 =?utf-8?B?MVdLNGR5RGh3UkNSRmpxK2JtNkJ0cjhvTXN2VzE5dXhHdUJFWmNubFVoSCtV?=
 =?utf-8?B?dnJBRmdaREZVa3NuSFNZTHV0VXdLM3RoaTdtN0l5Uy93QUEzWGEwQXpYaG1C?=
 =?utf-8?B?MUJ4aU1SZThkWExMV1VYZGpkbXdBbTFyamxKTVpFSXNFRm51T2VhRC9jRW10?=
 =?utf-8?B?MDRwYllpRXRQZW0xbmJROUkvZnJkdk1yOThjL3dBRkhFdDNzVExNdWcrRW16?=
 =?utf-8?B?eWFKMjF6R3A5SmFnTDhkNE95TDcrTXM4aFdhOXRuZWRSSTBQTG1LZEMwZjA4?=
 =?utf-8?B?MWtNRjR4TEJtdkFURFNFNnl6b3h3QUtNNUI4MTBtdDFMU0xYaHVCclp1c053?=
 =?utf-8?B?NDI1UmM2NFAyNXdqd2ZzeXZiV09XeGdGdVJCejJDcGNYVnpFVk9pbW4yQS9H?=
 =?utf-8?B?QVl6TVJiWmpaMzh1SjFGSWFMd1lNbmhzWjBuVUxTVGEzQUs0aWpYN1JEQk56?=
 =?utf-8?B?NTVEVThHSDZFc2FwQ29SRG1hVHNUU2FkdUY0djdwVWVITlh3a2I5VTB6eVVI?=
 =?utf-8?B?K0d2dEVVbURCTFNqYlhYeWFmTlU1aktHKzF6ZW9RL2lMdUNYYnBERHBoUTRh?=
 =?utf-8?B?cTVkYWVGTWwrcmhFQnUyWmlBaXdFMzF4a2lTalpmV0IrUnBUV093bFlWMkNP?=
 =?utf-8?B?aVdhcXJ6c1VjWno3R3ZMSHd5ZWZKeHhtYWxlYlJyT3NnaE5SYmxHbGM3NVMr?=
 =?utf-8?B?ZjhqdStMUUdIS1RpQXd0M0VDbmdlQTE4VEUwWDhhb2ZGWEFPamNIeWFWb1JO?=
 =?utf-8?B?b0F6eVhUWGhjNlhRSW0yNE1HQzBWcGY0THoxT2hIdjIzM21rSDV2eXE0QlMr?=
 =?utf-8?B?cC9vU3N0NnpxcDBUU2FOWVVObHlaT0RCUHZET3hJb2VSa2VUaklvcGxCaDdy?=
 =?utf-8?B?UGNzOG5IdnFTNm0wV1Y3ZUMwUUNBbVpTNytOOFRrQks5WUlEQUZtVWVTUzFs?=
 =?utf-8?B?cm50NnJRNEdtaW5aNmlOdlg2WnA3L2pqak13M3I4T3JGbVlyMVpZbmVjdE51?=
 =?utf-8?B?eEVCRVY5a081K1hQdGhsL2phRWM4dTNOWlFJczBLQmxqY1N4YjhLNEM0TWVn?=
 =?utf-8?B?eSsycnZhdi9hZkNNTmo0NXN6Mlk0S0pualpxazNXQ0gzTTVNcldWZm1UMk5F?=
 =?utf-8?B?V2VoTklTTHVmdVlTWjdoVzdWZ3UxY2pQM1JuRGR5blVLV2tVZm9HZHprS0dP?=
 =?utf-8?B?Y2tnWjBncWgvcGFZekNQWElnd2ZLRUY2dnFGRG56NGRRTHZOR0tMeVYvRHV0?=
 =?utf-8?B?Ynd3NGFKZCs1Uk1Gd3k0N3k3STFKSmQyRWdXaFI2RytEVVdTbUlkMVh4TUNO?=
 =?utf-8?B?VWYvQUF2ZnJOTzJOWW1sbVVKL3hHNHpJSmdqKytQVVJYdkpUZERuaVZLRDRx?=
 =?utf-8?B?K1E3eDBzSnE3Y2Q3K2FBLzN4UmVta2VDOG5aOGh2Rm43OWYrb1dhWEVOOFFT?=
 =?utf-8?B?ZSs4MXpGSW5kYWxTVmFlMlZCQUg1YUZiaklEbitPbk5MYm45cHRYcUdIR0c2?=
 =?utf-8?B?dnFWL1diME5mVXVqcDFpL0FBTzhxczZKUGpOSUFsd2JkM3E4d3AyZ2pwTEJu?=
 =?utf-8?B?T0lZRHZOd2NoWlNPYjYwYmlNWWRXU3hkR0tHYUNjQW0yMHpZc2lybjNBV3dj?=
 =?utf-8?B?UXhYdzZ6MUpBRmU3MGdCemd3R0NIbi9zNy9mdjFPQk53dlk5KzBTTS93MlJw?=
 =?utf-8?Q?oo+RfNuvEmEzV/sobVYlGSGaZe8ZXm3u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2ZQeDdXSWpKNCtpTWRGZkJjaXlTVFZoLzNGQjFEWlFIOWtBVlVWOHRYWGZS?=
 =?utf-8?B?ellvd1V5Z2ZzR2MxQmlVOEFjZW40RkpLWFNSTno1UG1CcjNwOEZSNUpiRFhB?=
 =?utf-8?B?SE9EWno3aFMrOWVScXk3NGl1VVVaZU5Ja0lOY1FkKzEydFJicWRxRm1UOHNB?=
 =?utf-8?B?THRtUHhzcEVoSlFhRmtiNjdGWDdhUStFeW55UWFvSnRuZEZWeXVIN25jUkVy?=
 =?utf-8?B?dVk4Y2JaRWFnb3laaVFUdCs3VGh1cmhDTkZHdFFtU1d4SzAybml2ZTdMLzYz?=
 =?utf-8?B?aFdGeWFmM2lERTBLOUZQUnBpNitsd0IyR0JpYnFhNE0zOFA3dStUNFRWaXhT?=
 =?utf-8?B?ZFFBcXNYM0VpQjlxaFh6VWhJTWZuTjRPbVVObEFZYjRtVDNjSUFXeTJmcnFI?=
 =?utf-8?B?ajUxUkV5clpjN3QwVUU0T0dzOWJSOGlrSDIwaVlqek8rNmdEV0ZoVVhFelRa?=
 =?utf-8?B?VWNtSU5wSXZKeHgxM2ZOMk9SMnYxbUkrQzE1dnl0TzYrSnY1dWtxVVZuWXht?=
 =?utf-8?B?RWNSZEdVa0hjVXVrT2YvVytRbHdyV095eUo5VkdmY25qdnJrUWRHUVlpbTFW?=
 =?utf-8?B?dHZ3Y2ZiK2lZcVVvR2d6UEdmczdrYkUvTnRndVplN0JZNEQ5VmxHNk9WWE5Y?=
 =?utf-8?B?OERYNHhMQm96YkRLVm5kY0c4ZVM0QytyazVRN243ZXpaUEIzRXNTckkrdFNx?=
 =?utf-8?B?cllyZWFmdXNLOGQvTFgwRS93NVE2S0p4ZVhvbU9POTF4WSsvTDlJeTRtTUhm?=
 =?utf-8?B?Wnh2a255TWNhb1BXN1J5VGJmcXZzR3kvWEJiRzhwQXZXQUxIek8waXZuQkQw?=
 =?utf-8?B?amJlbkp3QnZyamx3Ni9RSXVqVjZtRjlMYkJiOHBNY1dlZ0RmVjVibjdRRCts?=
 =?utf-8?B?RGJNSDJXeUxBZThUSWpHYytObnNPVGVMN2I0VVMvblFiZ3pNMHg3Qk4yVzBH?=
 =?utf-8?B?bUUvSDBzS2JjWXp4SWxQci80K2x0ekUrYlgyVjVvdHlBS1pzVnhDK1htMFla?=
 =?utf-8?B?MW9KY29CYzRKVFpyTUhnZWZBUlI0ME16RUxCbzE4WUM2REs5ZDl6ZkxwVE1C?=
 =?utf-8?B?UFV5MEs1RUdmakVDSzdXcG1mRGVRWnNqL0hibnJvMk5mcFpyTFNtMVNXUFRL?=
 =?utf-8?B?VGdZSHpLWDNNR0Vxb2lmMzZJTWVndWNjWU9FUTl3Y21PdXBZaXhKOTBwQWo5?=
 =?utf-8?B?QVlpdFFzUXl5NDFYN0k1TXRKZHEvUzljby9hNjN4K0hsU2hiNmNabjNySXpz?=
 =?utf-8?B?T0c0ZnhZd2R6SWxjMWxuTkgxVVJDRkN0ZU9INmVBNXJvZTNBSHlmVEkyWXpk?=
 =?utf-8?B?eXBTbTlGV3RhM2FDSXRjVE5aRE9lZ2tZZnJHWkdVZzQrY2JnT2twWmdzZ3Iy?=
 =?utf-8?B?ZVBBOXB1NEJ2M05NQUpUL3VUcGFYZmVBcGdXOHg0MWRLeng0OXJ1MWlTMVls?=
 =?utf-8?B?ZjRBU0FtVmNTV3RnbjRxRC9BaHdwUTBvcDEzOEp4YWVIOFpqUWZGbUFvVDR2?=
 =?utf-8?B?cG16T1JQQ1lDcW5ZbVVvaFpybWpBWHpBaVJZbXFjbGZRZEVIeHBCRThraGUr?=
 =?utf-8?B?SFZYS1hxdExneG1KUmZqSEZKL1pUSjFGSXlKTnpZNTdPaDhORWxHbjZEWmdy?=
 =?utf-8?B?Y0xXVGNnRmRQMmpGeTZPVUtDa3pjV2NSeVgydklSanJ6QklUYzB1OWdyRHpj?=
 =?utf-8?B?UjVXbDNycWQ2dVRTMk9KblAzQ094c050Sk02Z0ZQK3lScU9ML0t6VTBPY3Nw?=
 =?utf-8?B?Z3RwV1N0QytDM0FrSEIrNCtvMGdRRGFVNkxiN1B3NlFieWN6ZEdRM0g1aS9p?=
 =?utf-8?B?OTV3TEg5TjNLVlF0WGtWVXM1b0o0akFyODNWYnBWZHVSMHkvUFR6Q0t6aHlq?=
 =?utf-8?B?WW02d3RXOTg1SjZCZk0xMjQ1bytDUEM2NWhhMmxndllza0R5Mk1HVXQxcEVH?=
 =?utf-8?B?NWdJa09YdTJ2OUdLc01aVnJJbzlqaWdFUWRYOEZ1ekYxc3NsTjEvaWdWRktj?=
 =?utf-8?B?SmxPYmZ6NmdpMDgwTXdvdXpNTXROVlJwSk9rUXZzYjR5NUVkeml1bjU0ZmhG?=
 =?utf-8?B?OUhYT0EwVFRERWtjOEV1V3VJbS9WTE1lOGR2cmNZbExTb1FQbndTTnhPZGpv?=
 =?utf-8?Q?4B9CQaJh3YrFq7hLMD2kZsIEt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 091372f7-1cda-4877-4585-08de2727a69e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 04:53:58.7581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AIOjR6GsiK0tJgvIqMwTOmhTPeQT5QEmpa7richgHJrP+IGHG0BLXPtxblzaLhe8S9aZhQ4mnNW7EMBsI41KpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5961



On 11/17/25 09:00, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> When CPUs come online the MSC's original configuration should be restored.
> 
> Add struct mpam_config to hold the configuration. For each component, this
> has a bitmap of features that have been changed from the reset values. The
> mpam_config is also used on RIS reset where all bits are set to ensure all
> features are reset.
> 
> Once the maximum partid is known, allocate a configuration array for each
> component, and reprogram each RIS configuration from this.
> 
> CC: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Cc: Shaopeng Tan (Fujitsu) tan.shaopeng@fujitsu.com
> Cc: Peter Newman peternewman@google.com
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com>
> Tested-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Zeng Heng <zengheng4@huawei.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua

