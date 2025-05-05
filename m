Return-Path: <linux-acpi+bounces-13443-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C75DAA8C45
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 08:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FE0D1893D8B
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 06:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BA713C3F6;
	Mon,  5 May 2025 06:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZtmZ/6jw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DFD1BD9CE;
	Mon,  5 May 2025 06:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746426239; cv=fail; b=oYNC8lrJLT39nj/mkMBThUTPvl7h59le1VZFBthd+VBlCxs+qhbhWRq4tBfIhtdKB/y7JkG9KjC+pbwe11M6v5NCexxDU42fSg8nnjQDSztLUl6W9x1KIIQwEuTuDj5DKyYmg5gVZXG5m60uOB+b+DuhJnPf0PLoyBMraEYlNMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746426239; c=relaxed/simple;
	bh=luiUgxEdz4DnaiGrxkzrpEcTsmfV2mVul7yaQsi5GSw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p/dfulY7VuMri+XSMq8i6WSNYfKhh2i3Nh4SHk1TIWPz2A0giX4Z3gpuHVWB4q/ohhQ7W5m1+pdH7lHdbi/wRPzUuFPNa5qS01oU/iMOmtwC4lFpPxoKkMTRyRTgPQTMj2z4mOV/NNFSRuSWh9X43XqQbl57ucis14BTA2CHzaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZtmZ/6jw; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MrMPSouRUdphy58OwLNUTTevGCx4tyTYCc6L34dQRlGh/w85CeAFvwVFtAl7WARqC446gahFV68cH3dfyewKvWLSMSCxfgG8aRkbLFhwd5/fA0t+hPhHNwjoGx5DvGZTpos7B1b087afv0mSwdLx2ZyaF888KUDxsE3BiNPw076ASujguZoH1BJZPiJFhq3s0FXhQR5SDmDEbtXRwTkVI4SywahYYc7pcDQVT2oCPrOEhC/igpRozNIVYnimdbWv6EeaDEyZIKasZo5ZcK67JMvbRiAQchl72vhC1/9u2S0ieQplRPaQyCl09GWsrWoBgKxvCfsBSiFyVQsiTXzwRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRMPnpZo8lTIk7SUL+rWcJGyDoYhwsGqOPAwqVsZ+uU=;
 b=r44qwc2g71VTSBQwzYQ05fKKC7XDd9rz5AexIGhr9tYmPG638YKbA6uTaWMsPSdI15s8J9L3IcjHrZi4AszjvA84XDi0nQNsPH3q4vmI2OfJSE+p/v80hZRF8rRcT0828jsVPJdzTQ6vJu6wL5xNMAptGfkqGq8fqqiwiUx4Gg3gZaSGOFp+q0iNrLRUnPQHQstIe96Irwa7izZO8wngu8ixzmxsuwsSTP7VQTGbIKEoK1pcQXame9iuK2tEzJjLZhWJUtBkrjUzts8xdLDSJZ5s8SGJqZpwpQSNIMt5H/2bJPkghllv1uW+jlN/G9HPjCT7vkAB5lfRQkoYZcAqrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRMPnpZo8lTIk7SUL+rWcJGyDoYhwsGqOPAwqVsZ+uU=;
 b=ZtmZ/6jw7dGsH7Kw27qGCSMsEz+4mf/W8yJxXAjCeh9KP3JiCG1x6bbjfaVnwJRpMs3Uq9xGPid3Dw/XAfl/a1oFqNlwvqmeTQFz2Txhaf05/kQCtb8WBhm39vDRAP1Nsk7MVVGs9qYmWHTp+hnnuaVKs8TXjlhubJto0KDPPzL2tzPRRz8W8aQvIEAP935Yt5wPaXJ+n0HiZURhWersLT0wG1XmIUabbFGPmmMeKxRe/TEbpaOgHpTfh2RAgLZIrobkpfg+pfoi9naImIpjCWIUJ/g73ylexPt41ebxodqs/4/GQvY96oaXVB4EEYWt44vQu3UpQBp+ekceVI8oPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 MW4PR12MB6779.namprd12.prod.outlook.com (2603:10b6:303:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 06:23:52 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%4]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 06:23:51 +0000
Message-ID: <466e9d9a-d0f0-443b-93d5-58d0ba968480@nvidia.com>
Date: Sun, 4 May 2025 23:23:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] ACPI/MRRM: Add /sys files to describe memory
 ranges
To: Tony Luck <tony.luck@intel.com>, rafael@kernel.org
Cc: lenb@kernel.org, Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev
References: <20250429202412.380637-1-tony.luck@intel.com>
 <20250429202412.380637-4-tony.luck@intel.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250429202412.380637-4-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0202.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::27) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|MW4PR12MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 3471b776-37d8-4d72-93ec-08dd8b9d6743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkJKU1ZITU8rMUIrR1NtT21uU1UwS3dxZk1rSlg0OEdVV1N6RjZpQjRZZEd4?=
 =?utf-8?B?bHJoQ29UeFE2S1FvckxPRDVWRFpGSzA2L2pPQ202d1B3Z2dGSjNHbUZuak8v?=
 =?utf-8?B?dzNGTWljR0RLMU9rYXNXaFo4Wkp6anNoRXM1WUtsNWdkakNLcUIveHBlRm5X?=
 =?utf-8?B?TXVuL1pYSk9tZG1mR2dIMlFEemt5bEFrU0IrZ01kRG1iSGJiS0xLV1RuYnJF?=
 =?utf-8?B?bVhqcjVaRGR3Wk1WYmpHU2pGUWFUREtodFZ6SHhhaWZGbURqV1p6UTNMZGlV?=
 =?utf-8?B?andJWVIrSUZCVXFuc2RFdFZWODJzQ3VYZk1OWm1pL2lZNFoza05wb3dJL2Rm?=
 =?utf-8?B?MndLM0RMTjZZcFVsTlU3ZTdFWmVDVEg5aHNobThXdS93cDNmZk9zU0pJSkg1?=
 =?utf-8?B?WXhWL1dSMGFISDF6VlE0VHo2SnBmb3RPbVNZeldTOWZ2ME0yQUFRLzFxSG9j?=
 =?utf-8?B?NnNWWC9vbFBrUXFGcGhHVzlnMzNncGp4NHNsRERsQ29VL1ZkcVhCN1o4Qm9s?=
 =?utf-8?B?aE5lWHlKNkl3Zm5tMUJPNVA1SzdRNGhGcXUxMGtIazhwVHV2S2RxdmR6U0Y1?=
 =?utf-8?B?T0t3UUtYWEpPV3pRSUp5KzZCamxOeVY3NVJkSWhXNDg4Z0IvU0pXMkxaRkRs?=
 =?utf-8?B?TkhQMTZ2R2xyLy9yWDRXWWhGNmtuY3FhSnMzeGhaVUtkWUdUZzRBa2g2Zk1V?=
 =?utf-8?B?VFBteFB5V1EwV3c3UDBiNWx4TDFnVkFQdmxKT013NXdKYzNSSjFIOGxvUmJq?=
 =?utf-8?B?aVpNVVhEL20vZEZJV2ZLU2tKbkNGcWRPdjNEUUdyYUd6dk9lSHJ3d3hiRzFO?=
 =?utf-8?B?OVZwU1FCcEo0VWdIcjNoOW5PYzhUSmEzclJYNU1YZmNYb2JhNC91ekhJRmM2?=
 =?utf-8?B?SmhFby9oRlV0VklzSzdhVm9CcWNHT3lsQWJYdGFBaFJIMnFsellrdmJIVUM2?=
 =?utf-8?B?R08zRVFxdXNHeXE4WWliZE5CMXlLeHZaRVpsMVN3aUZ4bGppQ1RPTnFqeW9z?=
 =?utf-8?B?MUNhb09Ja3F2bnJUbENHLzI0VHhRZStaZWJLM3grTWdxMHR3QTRBOEZabC9K?=
 =?utf-8?B?UXRweFJTTXNLdFo2Z3Y4SFZBUzdack92YUxLbklnQjRCL2VMSzVsdTd1MnBx?=
 =?utf-8?B?MndJclhIMlRGNkhYdWFwM3gzTDlPUnRkM21Ia2tKbFZxVGR3MDNSRWRaa285?=
 =?utf-8?B?cUNoeXNIVDJvSHowd205dEhmNXgxUWpiRkxtbG42MlFGa0pZamVNUHV6UG4w?=
 =?utf-8?B?SSsyU2E5RThIRjNwMHh0Y084TXlhTmlXOWVqZ2VDakJwTHpEMmlob3ZkM0RM?=
 =?utf-8?B?TmtHa0R4Vy9hZ3Z4T1dFS3k3cWFLeHJlWlpkbWUraTk0Q2Z5OHpDN1hqOURs?=
 =?utf-8?B?YStCMEdrdWVnR0p1cWgxZXBlR21EeE5OOEgvd0ZmM2Fpam0vdG5xMmRjRytN?=
 =?utf-8?B?TkRqL1RZV0R4MGM4YzhJejE1L1VlMzB4T2NpNXNPcmYrTzErOUVQblMxQ21K?=
 =?utf-8?B?d0VmbEhURUVjMlZwWm9CMnlUbUFHZVFVZ3p4bDl5YVplYlNxaVdnblhPSmEr?=
 =?utf-8?B?ZTBEZ2pNVFBMZ0k3OElPTm9ubW54Ujg3U3RLTGU4TjRRTkhocndhU0tNenpH?=
 =?utf-8?B?UWo1QVlLTlp1aVNQN3BCdWQ2N05saGVIenByUllCb3pyb1B6NFc4SHFJUk42?=
 =?utf-8?B?eDdROWV1clY5UXF1MFIwaHNqa2tOTGpnMm5lODg5cnlYQW9sTG8zTzRMbkFU?=
 =?utf-8?B?UTBVZXk5TkUwZHRBWnk5cDJZQWl4V1QyUEN4eE04dC92UGdjVGNrUmRoQ1Yr?=
 =?utf-8?B?NFRveFptYWMySVRrSWg0OXVvU3czaTA0NlJpZFpvVDVIOEhiRUp5ZmpBTHA2?=
 =?utf-8?B?ekg3ZDh4bFliQnRHK3ZSdlVmdzY1WTdPeDU0T3JxSzQwaTBaZDFXTElCa3VP?=
 =?utf-8?Q?wAcdaAOJF5w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFo3WFZiZks0Q2paM29zNmMwOEppUFErZmcrMTJrWTdLMFI1WlltODNZaGRJ?=
 =?utf-8?B?RTFqSFg2YnpCN2M4NW1PNjNlRDhsRGdlRFBYNnlnQlVXR0w1VkhhcWxmNkpE?=
 =?utf-8?B?QnZVQzV1RGxtRUcxVURRbmRCcVhwUDRkYWt1Mk04U1g0RUM5RkJ5czhsRUw3?=
 =?utf-8?B?YWVvQ3Q5WHVNVFRDZ01MRS8veHdWV1hpTGZGMTZVWXZMUzh2NTFsNUdxeTh5?=
 =?utf-8?B?THZDUzFHNFFXWFdreW8zMks5S3o3WUhkQ1k0R3pwaW1adWljUmF4eTE2QW1G?=
 =?utf-8?B?Z3VKMG9JS0dxcFJtQllwTWVESTF4TnArUWdTSVliRUtYZGIyZGlYeDlKSVJp?=
 =?utf-8?B?RW41R0tNc2ZTSkNiR0QrYkJEc1ozN3d5a1VLTjd1bHY4a0M3OVVLYzhpNy8y?=
 =?utf-8?B?TDFNS3c2OXI2MzBKVnVxS0UvREFJWlNCeHF5bytURUJUem15clpMUWthK1V3?=
 =?utf-8?B?STZFWVFyMnMraFNVblJucVo3SUx1VnlEVGpnQjk0c2RXWHI0MXB2bytiWFA4?=
 =?utf-8?B?bkxIbGNYejd0dTZRNERwbVJFZ2RKUWtKTUovOXlVdjFUYzBxbkozb0Q0Sy9C?=
 =?utf-8?B?bkQzUW5jQ0w4QlBKSE9qY1J3NlFqQUZwT2FySk9aajRvbE9rUjRudzZZVTVW?=
 =?utf-8?B?bmt1V2lvOWxZSDY3ZHBTWUd3eVdtS2ZiNkt2ME1NcW5LbGcwY0VpQXFDV1Va?=
 =?utf-8?B?dlNZT2JSTzJZUXBKUE9MQ0U5OWtzRFJ5Z3B5Uk8zUmRSZDBkWVJHMUxUYWwy?=
 =?utf-8?B?dlUvUld1VnNqN0IyNkNjZ0hFRTZic1Flc0p0Ni9LTm92R3ZnTFZsWVBsUTJ4?=
 =?utf-8?B?LzVyUDhVOVBTSDh3SVJvZzBHRVRQdm82VHZaU3F3Znl2c1MvTVh3eDYyRVlU?=
 =?utf-8?B?UVFWN3hkNWtTYitFaEorNlN6L2s0STZhdi9qQlVpd2xCcDU2UzMycklxb2ZC?=
 =?utf-8?B?aWZuRk1QejVwcWc5OHpLQjN0TzJRanVaL09ENFhBeHpYaFgrUEtaa3ZXM0RG?=
 =?utf-8?B?VmlZVFFTd08va0tabm80V2hlcml5MllDRXltaGVWVThvZytRb2pPNVZ0THF6?=
 =?utf-8?B?YVNPazNsL0Q4MHhvbVlnenduNGR0ZkErL05QMHh2ZDUxZUprZlJYWWxqUnFi?=
 =?utf-8?B?ZFNhWlF6QUhUTXVQSnZwc1pJWUhyZTA2OVNKU2h4SDhsc2JLNDZsZkxYNEwx?=
 =?utf-8?B?WlNUNzcyYUpYdkZ2MHdFOXEvVDc4RkpCNWl0Wkl1NGZnSWlGMG5oVVhtaURw?=
 =?utf-8?B?NENHSnRQclJXL1ZJSWlva2VKd2Q4NmhRL3NyeHM4NER4K3AxTzVlSnFWNEp4?=
 =?utf-8?B?SjNXMDRLU2h0RU1Lck51aTV1MzJyTUY3dmo4NzlNWXdJSTRYMWx2WmZCVjI0?=
 =?utf-8?B?VVdXcmI4L29KQ1dlTWJhOVBnZGtzdThFSkhPTW5pREo1NVF4d2c5NkdXUFNj?=
 =?utf-8?B?aFJreUVlVk9yZTFMUVI4K2xmVHVLdnNELzJQMHltTGNITWxieExCbUVXTjZN?=
 =?utf-8?B?YlZDZHdrMWwxVGl0clhSd3dzZTNRU0xDVFBZQXpXbDVmTjhEMnRYYXlLZlBH?=
 =?utf-8?B?WXV5dUxWaFpjUHVBdFd3clN6bkdZdis1TzZnbTRFZGx5Mzk0ZTRrZllzdSty?=
 =?utf-8?B?Q1FYbHlRdi9zTFBhdVNSakl1YXJKcGZuK2hBUnlFWTFsbDkxcjh6R0t4a2dS?=
 =?utf-8?B?clpFakxFZzE1dUo0MDZUVjF0U2Z1Z0EyZCtzTnZ1amN0UThwditjNHBkUlVa?=
 =?utf-8?B?YjZpOG01YnlRUGQyb04xb3d6RlJXdldMQ0tjN0tabnNTQTdZRE1zU3JMUUNM?=
 =?utf-8?B?WFJzWmVSdTFqNnh3RTlsVGlkRGpTT2hJWUExL0JwOFRZOGZFaEJUYlBOSXdw?=
 =?utf-8?B?RTB2aGdZL0VSSFR1ZGE1MEErWkxkMy9XYWIwak5tcGRtdFJjZHdVdlVTWmtu?=
 =?utf-8?B?Z0oxMGdURkxQTnpGaXZZNjhxTlloRzJUeHlRTUVXbXJWdDcraGdRL204TENG?=
 =?utf-8?B?T2crVzdvMWJDMW9hOHJYaXdDM3BKcXZoQjA2dW5jWkhLY011UGlFbHNtblNj?=
 =?utf-8?B?Q3d4dG1SUDBCaXllUTdpdFdnMmgzNjFsSkUyeHY5bzIvVHlCWFpOMnRjU1dY?=
 =?utf-8?Q?Ad4jvdX5mB64vvQeKQwLprCWz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3471b776-37d8-4d72-93ec-08dd8b9d6743
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 06:23:51.6972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbnNhfgi/tWShXJ8QqK4/7UZKreV7x4cPh09NXrsqyjX95zTQNhMfzc5cDqN0hRuJMxnpJ8jCXKGIuz1EVFuNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6779

Hi, Tony,

On 4/29/25 13:24, Tony Luck wrote:
> Perf and resctrl users need an enumeration of which memory addresses
> are bound to which "region" tag.
>
> Parse the ACPI MRRM table and add /sys entries for each memory range
> describing base address, length, NUMA node, and which region tags apply
> for same-socket and cross-socket access.
>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>   drivers/acpi/acpi_mrrm.c | 143 ++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 142 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_mrrm.c b/drivers/acpi/acpi_mrrm.c
> index ab8022e58da5..f04645a0407f 100644
> --- a/drivers/acpi/acpi_mrrm.c
> +++ b/drivers/acpi/acpi_mrrm.c
> @@ -3,12 +3,16 @@
>    * Copyright (c) 2025, Intel Corporation.
>    *
>    * Memory Range and Region Mapping (MRRM) structure
> + *
> + * Parse and report the platform's MRRM table in /sys.
>    */
>   
>   #define pr_fmt(fmt) "acpi/mrrm: " fmt
>   
>   #include <linux/acpi.h>
>   #include <linux/init.h>
> +#include <linux/string.h>
> +#include <linux/sysfs.h>
>   
>   static int max_mem_region = -ENOENT;
>   
> @@ -18,25 +22,162 @@ int acpi_mrrm_max_mem_region(void)
>   	return max_mem_region;
>   }
>   
> +struct mrrm_mem_range_entry {
> +	u64 base;
> +	u64 length;
> +	int node;
> +	u8  local_region_id;
> +	u8  remote_region_id;
> +};
> +
> +static struct mrrm_mem_range_entry *mrrm_mem_range_entry;
> +static u32 mrrm_mem_entry_num;
> +
> +static int get_node_num(struct mrrm_mem_range_entry *e)
> +{
> +	unsigned int nid;
> +
> +	for_each_online_node(nid) {
> +		for (int z = 0; z < MAX_NR_ZONES; z++) {
> +			struct zone *zone = NODE_DATA(nid)->node_zones + z;
> +
> +			if (!populated_zone(zone))
> +				continue;
> +			if (zone_intersects(zone, PHYS_PFN(e->base), PHYS_PFN(e->length)))
> +				return zone_to_nid(zone);
> +		}
> +	}
> +
> +	return -ENOENT;
> +}
> +
>   static __init int acpi_parse_mrrm(struct acpi_table_header *table)
>   {
> +	struct acpi_mrrm_mem_range_entry *mre_entry;
>   	struct acpi_table_mrrm *mrrm;
> +	void *mre, *mrrm_end;
> +	int mre_count = 0;
>   
>   	mrrm = (struct acpi_table_mrrm *)table;
>   	if (!mrrm)
>   		return -ENODEV;
>   
> +	if (mrrm->flags & ACPI_MRRM_FLAGS_REGION_ASSIGNMENT_OS)
> +		return -EOPNOTSUPP;
> +
> +	mrrm_end = (void *)mrrm + mrrm->header.length - 1;
> +	mre = (void *)mrrm + sizeof(struct acpi_table_mrrm);
> +	while (mre < mrrm_end) {
> +		mre_entry = mre;
> +		mre_count++;
> +		mre += mre_entry->header.length;
> +	}
> +	if (!mre_count) {
> +		pr_info(FW_BUG "No ranges listed in MRRM table\n");
> +	 	return -EINVAL;
> +	}
> +
> +	mrrm_mem_range_entry = kmalloc_array(mre_count, sizeof(*mrrm_mem_range_entry),
> +					     GFP_KERNEL | __GFP_ZERO);
> +	if (!mrrm_mem_range_entry)
> +		return -ENOMEM;
> +
> +	mre = (void *)mrrm + sizeof(struct acpi_table_mrrm);
> +	while (mre < mrrm_end) {
> +		struct mrrm_mem_range_entry *e;
> +
> +		mre_entry = mre;
> +		e = mrrm_mem_range_entry + mrrm_mem_entry_num;
> +
> +		e->base = mre_entry->addr_base;
> +		e->length = mre_entry->addr_len;
> +		e->node = get_node_num(e);
> +
> +		if (mre_entry->region_id_flags & ACPI_MRRM_VALID_REGION_ID_FLAGS_LOCAL)
> +			e->local_region_id = mre_entry->local_region_id;
> +		else
> +			e->local_region_id = -1;
> +		if (mre_entry->region_id_flags & ACPI_MRRM_VALID_REGION_ID_FLAGS_REMOTE)
> +			e->remote_region_id = mre_entry->remote_region_id;
> +		else
> +			e->remote_region_id = -1;
> +
> +		mrrm_mem_entry_num++;
> +		mre += mre_entry->header.length;
> +	}
> +
>   	max_mem_region = mrrm->max_mem_region;
>   
>   	return 0;
>   }
>   
> +#define RANGE_ATTR(name, fmt)						\
> +static ssize_t name##_show(struct kobject *kobj,			\

"name" is used as a macro parameter. But "name" is also used as a 
variable mre->name in the macro. checkpatch complains this kind of usage.

Maybe change the parameter "name" as something like "range_name" to 
avoid the potential confusion?

> +			  struct kobj_attribute *attr, char *buf)	\
> +{									\
> +	struct mrrm_mem_range_entry *mre;				\
> +	const char *kname = kobject_name(kobj);				\
> +	int n, ret;							\
> +									\
> +	ret = kstrtoint(kname + 5, 10, &n);				\
> +	if (ret)							\
> +		return ret;						\
> +									\
> +	mre = mrrm_mem_range_entry + n;					\
> +									\
> +	return sysfs_emit(buf, fmt, mre->name);				\
> +}									\
> +static struct kobj_attribute name##_attr = __ATTR_RO(name)
> +
> +RANGE_ATTR(base, "0x%llx\n");
> +RANGE_ATTR(length, "0x%llx\n");
> +RANGE_ATTR(node, "%d\n");
> +RANGE_ATTR(local_region_id, "%d\n");
> +RANGE_ATTR(remote_region_id, "%d\n");
> +
> +static struct attribute *memory_range_attrs[] = {
> +	&base_attr.attr,
> +	&length_attr.attr,
> +	&node_attr.attr,
> +	&local_region_id_attr.attr,
> +	&remote_region_id_attr.attr,
> +	NULL
> +};
> +
> +ATTRIBUTE_GROUPS(memory_range);
> +
> +static __init int add_boot_memory_ranges(void)
> +{
> +	struct kobject *pkobj, *kobj;
> +	int ret = -EINVAL;
> +	char *name;
> +
> +	pkobj = kobject_create_and_add("memory_ranges", acpi_kobj);
> +
> +	for (int i = 0; i < mrrm_mem_entry_num; i++) {
> +		name = kasprintf(GFP_KERNEL, "range%d", i);
> +		if (!name)
> +			break;
> +
> +		kobj = kobject_create_and_add(name, pkobj);
> +
> +		ret = sysfs_create_groups(kobj, memory_range_groups);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return ret;
> +}
> +
>   static __init int mrrm_init(void)
>   {
>   	int ret;
>   
>   	ret = acpi_table_parse(ACPI_SIG_MRRM, acpi_parse_mrrm);
>   
This blank line seems redundant. Maybe remove it so that the "if (ret < 
0)" sentence follows the "ret = ...." sentence immediately?
> -	return ret;
> +	if (ret < 0)
> +		return ret;
> +
> +	return add_boot_memory_ranges();
>   }
>   device_initcall(mrrm_init);

Thanks.

-Fenghua


