Return-Path: <linux-acpi+bounces-17315-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AB7BA0A57
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 18:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B1D1C237DB
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 16:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36C5307486;
	Thu, 25 Sep 2025 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RCDXVwMA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012001.outbound.protection.outlook.com [40.93.195.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032C61C75E2;
	Thu, 25 Sep 2025 16:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758818269; cv=fail; b=b1Ktftj8R/Bw4eReOnhsPiG+CdHhTu63jXJiMTR+VC5VytIsTr0blyd1sBijCijPFCHZLea+tFWpFjfVRD/ZRvsNz8fstARfa2mPA6FhsuUfiWsf+CukK9LT41gsHD01j3R5tVSmFsI4MLu+pJ3S+nVtElZG6AUudGUlVcEo19o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758818269; c=relaxed/simple;
	bh=Eepp6lMnYEjkTR80QYdaTKsCHGGEqO7dbP5lZNAF0ys=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dGMeGyqcv2SAvjSjht5tht1aq96Dbt5M++adIReT1L7VLLaMnfh4MBs4QWC7qfeguAHfAF5lu2PsRxRrtQd5++gS9SOk9kHZJUfeIq9HbBaRVSJQCiqxrWyVR5e2gYXpi5oa9GV5ILz4V6TMnLFs4cd7fFTs6gNQOU3KMnHIolc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RCDXVwMA; arc=fail smtp.client-ip=40.93.195.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sTWA1AjFzWOYriFdLeJ+CyWHnNnuN2C9ek/+7wGYkRombEucZnhvXSHwlpuZbjpvhaP2P4EuQIy4AMOFrFTIcksIilGpnDock6JR73aqI81UtnhPswdjTB5lMaEyt+5oRPZqjYmRa1bRzVlpB+aiIY4HvK6m8cYg8lQCTWA8AH/hJ4flD+Amowx8YoTtgw8T5fDkjDrjxR7xnO8u3z9I/Z9w6b8+DBBlQu/8QW90lwXAIwt7r3nZwMDTDsjJUMB4x7iE4hFinC1WsMuS1f0AFn+aLjCL2/6gYY0VxuZ+xgUJRK8H2/2PPy9kAXZLlzs4bn6Zpo6XCpHuHlTXtz3F2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AuYdaPtaGfPY5ppseKuTvK5DWsTCcJcZgSW7eV/8paY=;
 b=BpOIfQENZj90rwX3syFwM6A+mwyLkmzKt6lQWMvf5yl5WeN+yfgyAFbjEM1fKma+kdULfXc4zPREqAkOZ/WnNemRyz5mZq1DBmusnd7qZ+BcwqSiuLmpP6HDvIXqOFaPVqKO88ttmu25BetHHJ6UzLN8DCa/j1G4kxHXH+fqKVrhVwzzUS6RKqKUdHRju3Y2d5CvO61k7prZBLArzd0xGHggQUa2ZLgNYO0EVibKrXZ34AY2jjAgj5waZhN8//31NT6kwboIQ06ode5/XlWIU8FsApJMm8TzW4MG8h0hsHCf/Q5n50IsQjw+kS8RXG5LlArTrN0Lz0rUYNJ39cdp1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuYdaPtaGfPY5ppseKuTvK5DWsTCcJcZgSW7eV/8paY=;
 b=RCDXVwMAqjhcANoJZDI5IU2KdyCe6b6x/K4vKfhzmJ9gL1EGyh+D0VPALl3AURSsSXPn6JX5wzgQZJVoXewfgqA+hObl3AnZtxP2AHa/OzTBkwtO7vh36a+k3mQX/w8WlvBD/bQzyinKe2rRrDGoy2ExpKMuKjxJ8JQXPVC3qYQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7SPRMB0010.namprd12.prod.outlook.com (2603:10b6:8:87::8) by
 DS0PR12MB6533.namprd12.prod.outlook.com (2603:10b6:8:c2::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9; Thu, 25 Sep 2025 16:37:45 +0000
Received: from DS7SPRMB0010.namprd12.prod.outlook.com
 ([fe80::b021:a6a0:9c65:221e]) by DS7SPRMB0010.namprd12.prod.outlook.com
 ([fe80::b021:a6a0:9c65:221e%7]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 16:37:45 +0000
Message-ID: <87be8589-d3bf-4b1a-a9b4-4dfad30924a3@amd.com>
Date: Thu, 25 Sep 2025 11:37:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] cpufreq: Make drivers using CPUFREQ_ETERNAL
 specify transition latency
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Qais Yousef <qyousef@layalina.io>,
 LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Prashanth Prakash <pprakash@codeaurora.org>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>
References: <8605612.T7Z3S40VBb@rafael.j.wysocki>
 <2346363.iZASKD2KPV@rafael.j.wysocki>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2346363.iZASKD2KPV@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0130.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::21) To DS7SPRMB0010.namprd12.prod.outlook.com
 (2603:10b6:8:87::8)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7SPRMB0010:EE_|DS0PR12MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f86f65a-8e9d-4d03-9a9b-08ddfc51dad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjBxRjhxWi9LTUE4bE5jZVZrdDlRV1dONHF1N0Fsd2RMcE83eVBwTks2WUJK?=
 =?utf-8?B?QlMxSmtnVjl1QWNtNUJ0UE9QSEF1RExwQ2ZlKy9Lakc0a1VBa2NvNURBTzZM?=
 =?utf-8?B?a2REZURIZm5FL2xhbENTOEFYZmt2RktnS1pqa3BzSS8vdU1sNFVRbFBiU3p0?=
 =?utf-8?B?NE9TeTlLRlRXS3VqR3Q5M3lQZHZ0aWRmajZjdjZEQzlMZ1pMcmErelVnVnNS?=
 =?utf-8?B?TGZJRjliMGZYVklSWndOTmZpZDVSMXBjN2FwMVdsUjJkWGozQ1lFTVBOYzVv?=
 =?utf-8?B?Rkc4ZzBwSkU2Zzd4WTdzMGRqdzlzZndrZTdrL3N0ZTdodngzai93R0JpdjVI?=
 =?utf-8?B?TDhtNnMvQkF2enV2QW9TL0NkNVU2bjF4dm1GSDFVaCtWTWNXNlI3ZTFabVF2?=
 =?utf-8?B?aS9mSk42Uk5MancvZFJTRGJOSkZNMmJlR01pRjZGemtNblJFYjNDclRtWGhL?=
 =?utf-8?B?RThXZUt6MnQxQ24xL0E1c1NOQU04KytzZ0hHMUdkaHZqeDJ4dmVLRzlxZ2dq?=
 =?utf-8?B?OUNPVEpNSkpUY3ZxL3l5VHc1K0hCL1Zjc0ducE9FeVNDTXFXTmVzQ3VoMHIz?=
 =?utf-8?B?VnkrekQreWVtRmNJS1RRdDIwOCs4OEdialdtOVV2Zk40WlZNclB5VngwQ3Iy?=
 =?utf-8?B?MnB6N2VsVzJpRmFoMVFHcUpHNnBtRkxXckpINVlYUHNQSXhVRmJ2T3F3SlRG?=
 =?utf-8?B?MnI5azB2Y2FPdGZKUnhlVGVlcTVLQkZUb3pPbHN4L1VxNm5zam1HcG5uZU1T?=
 =?utf-8?B?SXowOTRlWC9td3ZGMTdDdklHMytMbkNwZnFXbEcrNElMdUFIVWxzVndZL0Qz?=
 =?utf-8?B?TDVNS01nQllzNm9zNzBmM3dqL1MraHF3U0I0Y2VWOTlCNXVyR1l4eVdlUzkx?=
 =?utf-8?B?OFZza1hMTVVSUStpNEQrQW51Z1p2UjEzVDBLQzcwOEN1VTZ5SHNRbE4rbVBs?=
 =?utf-8?B?b0xOeTlmdC9NbUROTGdhUS8vSzJ2cVBQQUptRXZkY2YzV3djbXJqaXZ1L1lq?=
 =?utf-8?B?Wm9NNmJqckZhUjgzM1lLV3dzZVA3R3NSNTZMK1Q5SFJWaCtIU0phM1FqUS9x?=
 =?utf-8?B?bC9td0R6azl1dEp6bnRlYlZpdktqcXVnMjNDV1NnQno5VHI1Y09pRHBJdUpx?=
 =?utf-8?B?Q09SbGlncWxLYnJmYXNxZENRWlFoZmg5dHZLN0tEenp2QTFFV04vUEM3Rkxx?=
 =?utf-8?B?dWtFeHZXTGdPMjBYa2hPQTAzdWsvckt4MXA0RHp0Zzk4c3dXZDRtRmNwU3hY?=
 =?utf-8?B?bWsxZnU0Uk5XSUxjOHR4MFB5Tks0YkNUaVF2RHYvcVNNK2l3ZXc4Y3k5T2dI?=
 =?utf-8?B?MGdnQ2ZTelhqcVcyWk5jYmUzUmlVWlJWQnlYTStLeExPVHNFbDRvaXJUdEdZ?=
 =?utf-8?B?Skp4RTFWZTNSL2FaZ3Q2MnphSmpNMXU0OXR0cG9QSjYrNlVVVE5lREtDL0Vr?=
 =?utf-8?B?ZUZ6ckYrc2FMNncrU2w0YlljQ2gzdTVpZW9oYlZqWEx0cG9CNEFYenF1V0h6?=
 =?utf-8?B?VDhsU0hGK0c0SzFRTUViZ0pOTk5XMTdiQlhXNExzRDhTUlpLc3JsVTB1emFG?=
 =?utf-8?B?dWVmSmFxSWRXUzA4WUF5VS9RREVwdmxjZ0hWTWt0THJFQ1ovT1hwTGVaQlVj?=
 =?utf-8?B?TWtMRFh0bGUzbW5SakVnK1FsQ0hhWGREUXVBaFZzalFlSlVxMHlyYWtHU3N6?=
 =?utf-8?B?WWhsZUVrTU41MmxUNGtWTHNWSk1JTS8zVzdTTWMyR2lKVU9kcE83ZHIyZHdq?=
 =?utf-8?B?cVhycjFvS3VWOWhKRW5LTGtGY3c1M2lEWTlTblV4U2lpZHd1em90TjRHY2R6?=
 =?utf-8?Q?UmVx0q82II0LnJThB9XtYkbF8EbLXeZgBlm1c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7SPRMB0010.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0g2alpyeGRZT3ZzemUxT1RpM0J4Mi9yeDA5OG9EN0tmMnBFNElWcE1hSWJu?=
 =?utf-8?B?ajMrYVdjeVdydkdpVnFBdW90SzNsNHNPMFozOThYVGx1bklOMXZhZnBFNnB4?=
 =?utf-8?B?eG1ZYlNZRXBhNVZWTTVxTFhCU2h2OFp0Ly9UR3FBS25SWCtZRDh2cWU5WHdN?=
 =?utf-8?B?NFpoM201bWZabG40UzVKSjAyZ054NEgrTkhwbjE1VmRwd3p3MVdIVms0S2k5?=
 =?utf-8?B?V3Q0VS9ONE16N0Y5a3VtSDFBb2tPNHcwZFpITElaL0E5bGpRNWdrcDhxYlhk?=
 =?utf-8?B?YW9JYzVXZGdLNGg5ZHRhNXdoKzRURkpNT3lsbWp3bkRteUJLNXY4R2k2Z3dG?=
 =?utf-8?B?aTUyWkg1Zmo4L00xSnNmOUtWTW41MGdFeUxyM2l4d2c5TUs1WFd5bi9zQVYy?=
 =?utf-8?B?R3hFaVd5Umw3TWR2dmYwbXhvRTNyd015ay94ZExoYTg2V1lzVHhUMktrd3ZU?=
 =?utf-8?B?cWExVlo2dVU0emJNWjFHYTNlamJHbWxtREZwYkhMUzlPd1RVS2RhSjEwdlk3?=
 =?utf-8?B?VW9ZaWlnZ3pwRVNUNDRlUXNXOXdLTERzb0xtczFBai8vM29mQWYvanA1YkxM?=
 =?utf-8?B?SWpEUjltWmdTQUFYM1F4MzgvZUFhVXVkN0NpcmIvVzY3Q0ErSUd6Z2s0d2xH?=
 =?utf-8?B?TTlIVW4vbnAwZTFCeVdPQ0dJY0lLbnh4c1BrdFFqc2ZvWkk1Zi9ia3NzL2Y5?=
 =?utf-8?B?VEpubnNIZ25iQk1GT0NnWXVZRkx5REJCZytPdHlLbVBsSXl2VWJRVHdsOHVC?=
 =?utf-8?B?cFBFUlY4UGV2TWRkZkFHR3dWNWdka01Lc0FadE0zK0wwZ2k4aE5weGxVbmZr?=
 =?utf-8?B?T3gyVGE2d1hkNy83Q3gvclI5eDlWNW43MzBiZEhPT2w5TGFJUCticUt0cDBZ?=
 =?utf-8?B?VEFXUi9Xb0lKS292VS9wMzk3Z2VtVUZ6UGd6U0h1U21tZFAyRS9vOHJiQkdn?=
 =?utf-8?B?T2k0b0VaamVVeVN6WmxPUFJvT3VOaWptWjJ2UXc1dUJ6aWhLN3lidmk3bGtT?=
 =?utf-8?B?WTMxbTFBQUVHVmdxNDA2MmtHTkxrcGt1a0pZTi9wRy83cWY5VjdWOUU2Rnc0?=
 =?utf-8?B?emJEQmlBK1JIR2FySGhaQlBPbzU5YUpLdXpNQ0ZhbE1zNWRhaEdlZ3U2NXRl?=
 =?utf-8?B?UDRmRVlRRWVZMzhqUHgrK1hWNXF2VDIwQkt4U0xmWWFTdmlXNUR2bm8xcm1q?=
 =?utf-8?B?VVBRYW9selZteENRSWh1bmZhODNOVFJWOTFFdTFXTTZ6VzhzRVB3RFFtUTdM?=
 =?utf-8?B?b0pzZStZZ3FTRHBWRVhPb1ZpMmhkVnUxL3p0NnJPdnlWWHZTc2kwcEtyV1Jt?=
 =?utf-8?B?UEdGeXExMmRGaXg1SEw0UmFGdmtXOTFPeDBvdmpESXBjWEdQRjk2VXk2ZFFB?=
 =?utf-8?B?ZlovUjRHa05QQ2ZuWm1VZ3ZHanZzeThHbmNBQUYvTTZrbUpZRjY5ektXbFgw?=
 =?utf-8?B?em5tWHoyVkdrZWNtQnNvWU9mOHhwS1BldHJ6ZGpBUXlaeHh5dkNpYW5EMHBh?=
 =?utf-8?B?Lyt4T1FMeXhVNXVibXhrMmNRc21nMlZLTGpJMXI3ellBL2tzWjl3bUg1QzRI?=
 =?utf-8?B?UThYSkxta2F4MWszR3g3OW4xL1dTbG1VTDZzUXFQZ2FvMEZSTk8vd3pRWlJo?=
 =?utf-8?B?L1E0OXJlUkZmVnU5eTlpdkpuUGcrTkdPSTBvelNxdVJGeUhTV29NUEdhZmhw?=
 =?utf-8?B?RFU3WG9mYlpNRGFHTGpFRnVDakUvVWdZU3B6c3Q3enVnazl2QXlpT2NqTzkz?=
 =?utf-8?B?eW5KeVBmcWZEUDF1T2ZzYzZVL2ZNNXBzV2gveEUxRDBrdTFpbkJ4UGRqM3Zw?=
 =?utf-8?B?em1ESjRkelNLdnMwT243Nm5SZC9DdG9MeEV2SEpOaDFmeUVnK0x6dE5tWTk3?=
 =?utf-8?B?TE4xWUt4WjBRZkxTQVR3UUJnSklndXBaQjFhTkFSNlZweTlOMW5zOHkrR1p4?=
 =?utf-8?B?dUpmeHQvOWJlZUpnTHJjVzZvb1VSM3V0YXU0ODE0UkxlV2NoMXV3dnZYeDdh?=
 =?utf-8?B?Z0o5MDNMNWwxVDdaNVIrWVJXdnhrTHNOMkVXK2dXOHNvamgrbDBURk1nVFdQ?=
 =?utf-8?B?WW1lR3BtMUR4YUVWSkhhMExrQ0ZVV2pJMEw1TkFRZUxNamlaOE96NTlncmJY?=
 =?utf-8?Q?iKY7+CuNz2RkfExB7QkryJ/Yp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f86f65a-8e9d-4d03-9a9b-08ddfc51dad4
X-MS-Exchange-CrossTenant-AuthSource: DS7SPRMB0010.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 16:37:45.1950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uorG8YP6gfk2q4rv3b+SUdXNBPDmUOkniNftiQE5y5/m3aNquCZfV8RRqDjDUUWNf0JkDXp1nIfWYXC92grSbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6533



On 9/25/2025 10:44 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit a755d0e2d41b ("cpufreq: Honour transition_latency over
> transition_delay_us") caused platforms where cpuinfo.transition_latency
> is CPUFREQ_ETERNAL to get a very large transition latency whereas
> previously it had been capped at 10 ms (and later at 2 ms).
> 
> This led to a user-observable regression between 6.6 and 6.12 as
> described by Shawn:
> 
> "The dbs sampling_rate was 10000 us on 6.6 and suddently becomes
>   6442450 us (4294967295 / 1000 * 1.5) on 6.12 for these platforms
>   because the default transition delay was dropped [...].
> 
>   It slows down dbs governor's reacting to CPU loading change
>   dramatically.  Also, as transition_delay_us is used by schedutil
>   governor as rate_limit_us, it shows a negative impact on device
>   idle power consumption, because the device gets slightly less time
>   in the lowest OPP."
> 
> Evidently, the expectation of the drivers using CPUFREQ_ETERNAL as
> cpuinfo.transition_latency was that it would be capped by the core,
> but they may as well return a default transition latency value instead
> of CPUFREQ_ETERNAL and the core need not do anything with it.
> 
> Accordingly, introduce CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS and make
> all of the drivers in question use it instead of CPUFREQ_ETERNAL.
> 
> Fixes: a755d0e2d41b ("cpufreq: Honour transition_latency over transition_delay_us")
> Closes: https://lore.kernel.org/linux-pm/20250922125929.453444-1-shawnguo2@yeah.net/
> Reported-by: Shawn Guo <shawnguo@kernel.org>

Not 100% sure, but I think checkpatch gets pedantic about Closes 
followed by Reported-by and instead wants Reported-by followed by Closes.

> Cc: 6.6+ <stable@vger.kernel.org> # 6.6+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>> ---
>   drivers/cpufreq/cpufreq-dt.c          |    2 +-
>   drivers/cpufreq/imx6q-cpufreq.c       |    2 +-
>   drivers/cpufreq/mediatek-cpufreq-hw.c |    2 +-
>   drivers/cpufreq/scmi-cpufreq.c        |    2 +-
>   drivers/cpufreq/scpi-cpufreq.c        |    2 +-
>   drivers/cpufreq/spear-cpufreq.c       |    2 +-
>   include/linux/cpufreq.h               |    3 +++
>   7 files changed, 9 insertions(+), 6 deletions(-)
> 
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -104,7 +104,7 @@ static int cpufreq_init(struct cpufreq_p
>   
>   	transition_latency = dev_pm_opp_get_max_transition_latency(cpu_dev);
>   	if (!transition_latency)
> -		transition_latency = CPUFREQ_ETERNAL;
> +		transition_latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
>   
>   	cpumask_copy(policy->cpus, priv->cpus);
>   	policy->driver_data = priv;
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -442,7 +442,7 @@ soc_opp_out:
>   	}
>   
>   	if (of_property_read_u32(np, "clock-latency", &transition_latency))
> -		transition_latency = CPUFREQ_ETERNAL;
> +		transition_latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
>   
>   	/*
>   	 * Calculate the ramp time for max voltage change in the
> --- a/drivers/cpufreq/mediatek-cpufreq-hw.c
> +++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
> @@ -309,7 +309,7 @@ static int mtk_cpufreq_hw_cpu_init(struc
>   
>   	latency = readl_relaxed(data->reg_bases[REG_FREQ_LATENCY]) * 1000;
>   	if (!latency)
> -		latency = CPUFREQ_ETERNAL;
> +		latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
>   
>   	policy->cpuinfo.transition_latency = latency;
>   	policy->fast_switch_possible = true;
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -294,7 +294,7 @@ static int scmi_cpufreq_init(struct cpuf
>   
>   	latency = perf_ops->transition_latency_get(ph, domain);
>   	if (!latency)
> -		latency = CPUFREQ_ETERNAL;
> +		latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
>   
>   	policy->cpuinfo.transition_latency = latency;
>   
> --- a/drivers/cpufreq/scpi-cpufreq.c
> +++ b/drivers/cpufreq/scpi-cpufreq.c
> @@ -157,7 +157,7 @@ static int scpi_cpufreq_init(struct cpuf
>   
>   	latency = scpi_ops->get_transition_latency(cpu_dev);
>   	if (!latency)
> -		latency = CPUFREQ_ETERNAL;
> +		latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
>   
>   	policy->cpuinfo.transition_latency = latency;
>   
> --- a/drivers/cpufreq/spear-cpufreq.c
> +++ b/drivers/cpufreq/spear-cpufreq.c
> @@ -182,7 +182,7 @@ static int spear_cpufreq_probe(struct pl
>   
>   	if (of_property_read_u32(np, "clock-latency",
>   				&spear_cpufreq.transition_latency))
> -		spear_cpufreq.transition_latency = CPUFREQ_ETERNAL;
> +		spear_cpufreq.transition_latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
>   
>   	cnt = of_property_count_u32_elems(np, "cpufreq_tbl");
>   	if (cnt <= 0) {
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -32,6 +32,9 @@
>    */
>   
>   #define CPUFREQ_ETERNAL			(-1)
> +
> +#define CPUFREQ_DEFAULT_TANSITION_LATENCY_NS	NSEC_PER_MSEC
> +
>   #define CPUFREQ_NAME_LEN		16
>   /* Print length for names. Extra 1 space for accommodating '\n' in prints */
>   #define CPUFREQ_NAME_PLEN		(CPUFREQ_NAME_LEN + 1)
> 
> 
> 


