Return-Path: <linux-acpi+bounces-6553-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0646910FD7
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 20:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9ED1F2305A
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 18:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0151E1BD51D;
	Thu, 20 Jun 2024 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O8NCGNDQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7631BD4F2;
	Thu, 20 Jun 2024 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906250; cv=fail; b=MNOoLjz1dV/odPuwMcAXmboW037eIi1ZmJce3rYaTTO9ft23MWDCwBriQE/dFbYTxz+GeMZfD+ZWT9YzDiuNBkXZI148dlJmv6dEXTfCFfMrv1zoqJOqXvfjmsldHM0ukQfbXOAMKnCILHWfjG36d+CCUqRkIerWBqR4Cs2Z3NM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906250; c=relaxed/simple;
	bh=Nyv4lRasvsonzC7EW5TLbPgS6zwAfftwJz+Zypi747M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P1Ejfmded1xzyEKmERL5oE3nXuyV+T0wDZkBp3bDFyD7SXbVpbhq5MdwrC7DMIiA3QKGHRvxdZhVRmkP+MW+9hNrWbIyzBZnpq0r4Rz6/A4XQmNxwhrE80baYRuXhkljqHKIFxAEmNEGUaw1ilfllAhEFIONiEIzh6NMCMw4qHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O8NCGNDQ; arc=fail smtp.client-ip=40.107.100.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXq6JLbfHfAuJ5FBBCSxlEv9OJVD99hNfDuv4LV8hsYAiIsVwG39KSPYO4Sx9reUayX6BnKBzENo1GMcnnQYnClgMEMJRR36dvETvFpz1cFHaVTCV4C6gLnoCDjkC9UbaBIVglIozHtY3b4m1EI+ircbWJMUctQ8+g97OqRteNF75xF48Pscb5CU7Eiqt810aaPxQDY/Kgw+YFvf96QyRYbE4pO3F/+U0eGh0wEf4FZV+JUD4flKGtCaTCIh+1aLOZnUCUOVBI/WISVjcWwAYP2sbomF/GHGOj2IKYGxd+8BEWRlL/RXpCRwUP2PUbhnDaMuJ5ZcCWehpxqsBNhAUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXkNXIDaPq7DcUXVU1zWa7dDY+B4z+qFts1Gpue3LG0=;
 b=L+gcCcORB2QpZe0UoOgE5x/O596ADq2GvdsSD3NX3HcG21+MH8u2hNyR+m1xLkiz5JE78tbPDQ8+foEESLddAxrbO0fPA2PT1cWaZX7H0bal1cY+cxCKcI26A4zcU92dr5KeI4mgLGGhG8oPJ4wuXJGo5LSILLU7JSuTEdrKnhgQwN9+w8NZUhLi/qp2LGOdjO2or7oJ6mtjJ83nehnTu8agHhsB+eO/BjDFbnEXcBKyWrTpIIekJdQRuDgC4oaVwCi7BMdmP6+YBqHJxVWW6llP3jg7p2krpW7Cfjw55sBR5zFgIDJCilApsffKR8L0y6skbMLDjxJbrt+U2trOPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXkNXIDaPq7DcUXVU1zWa7dDY+B4z+qFts1Gpue3LG0=;
 b=O8NCGNDQD8ybXiRZ48t8pe/DNz/nFfFEOBmBToviRfm91Fa9+br+VrM4bLGUgXlNuPhcCpRr4rtK1kYDXV2LnHhwPr4gfdlBigKi3c8i6pucyAPYhiJOETyxZlpVX+cnixUnqtlAKzxMWro0oG3gn55vtm3R+e4cPUVjQio0plw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB8522.namprd12.prod.outlook.com (2603:10b6:8:18f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.35; Thu, 20 Jun
 2024 17:57:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.030; Thu, 20 Jun 2024
 17:57:25 +0000
Message-ID: <8f97bab7-c504-4d8c-977b-44f20b4c1402@amd.com>
Date: Thu, 20 Jun 2024 12:57:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpufreq: intel_pstate: Use HWP to initialize ITMT if
 CPPC is missing
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Aaron Rainbolt <arainbolt@kfocus.org>, LKML
 <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <12460110.O9o76ZdvQC@rjwysocki.net>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <12460110.O9o76ZdvQC@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB8522:EE_
X-MS-Office365-Filtering-Correlation-Id: c4803a8a-b8bb-49e1-ae72-08dc91527163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akVLSngyRzg4dXExUFY1K2ZHZHZYNTR0QUZUdWdwaE5aaTQ5WjdkdUVvQmlz?=
 =?utf-8?B?b1FDQjh3RkJ0NXB1bGY3V1VOYVBkT05kV3hEb0RGeUdVMlg5UU91ZGd3SzdB?=
 =?utf-8?B?Z2RDenVIOXB6VGZQbFhIWnVISEZyeUNPSjIrdjF1NUt2UGE1d09tMnZuckdu?=
 =?utf-8?B?TWxtV0ZtWndhWlduSUpUKytaSUZXa2lNTTlyN3lpd3IyYjkxelJqMGFRMFM0?=
 =?utf-8?B?MDVGbTd4c2t2SGJtMFovTEFKc0pud1dvaTZQc2ZSaGRsY0NCTlZjL1EzV3dl?=
 =?utf-8?B?cFkzRlJpUzlveG1sWmNMK2RGeXB6anM5ZVZLZ25CUnJxa1pITFZKK3lzd3g2?=
 =?utf-8?B?VGc4YmR6TnlQQlF0c1RiUXFCMHZJZVJFVjR5U000MUVtMkV6U25kYkhqcXR5?=
 =?utf-8?B?bHJLV3IyVStpN2ZpQ255Zlh2NTdLMkUwTy9hd3JyQXlRUjR4dGtaeUdFeHov?=
 =?utf-8?B?WS9TTXFkR28zNVBRSmxDOFlDN0loRXJXdjNVejR5bHRJVXIyOGh6QzNjaEov?=
 =?utf-8?B?R1dBaTEyMWJzZjRYOGFOTUhJcGMyMThWSE52UklvcTJBRy81WkFjTHdGM0tJ?=
 =?utf-8?B?QUhNZ1QySWVqWEFZTWFtZkw0RXFPOVp5bXJqWDdrSHErNEh0NktxWFhlN2M0?=
 =?utf-8?B?UTBVVUJVQXZuaXRHcittMzBJV3N4cEx0NXdMWDBLc29jdUVKTzBwQitWejFz?=
 =?utf-8?B?OTJhdis5bDRwM2QxcURHaTFUK0thelNCQkl5d0lwOXJSTGU0VFA5NEtXZk1z?=
 =?utf-8?B?dkdXRmNacnUxb2wzL2VNc0h0MVB6aEtqVFFnM3g0bVBYN2FNdFNYcDk3OFBF?=
 =?utf-8?B?TUZHa0p5YTVMdlc0ajJjcHNLK0UvcS9sUWl5YmxqUjV0TEYrbWZZZjNwd1Nx?=
 =?utf-8?B?MHVRMzVVaGtYbUxWc0svRnFMb1ZhNG9SUXIvM1NUYlRZOVM1elFhNFJwVlRI?=
 =?utf-8?B?OGV3LytqYU1VbEhYVEZxMkdDejZTUEJOaFVXZFFsd0oyUUUwaFIrT1VWcFNa?=
 =?utf-8?B?L1R4R0ZkMEh1aW5CcnJPY0kvQjZ3MzYrWW1JMUEzeXJkTlh2dXpvaExGeFpI?=
 =?utf-8?B?UERCZk9mVXRlVjI5eHNvMW9SczUzVXkxOFpuU1d4SjU3Tkx5MEg5cjZRek9p?=
 =?utf-8?B?VUtwait4eWpDK1l6eW5CRnNrS1paNUdUQ1dibUV6MFhxUmFoL1VFN2pFSWpW?=
 =?utf-8?B?aSthQjIyTVJyYTNMaTFRd0I2dWFQTktIRWNzY1JDMzJCL2JFTjNsTGtUT3VL?=
 =?utf-8?B?bHpFaDk3ZEJOTzM3SFJOSXVET3d3QTZrUFpPNTVETmtacVNGUG5MNU5PYmlw?=
 =?utf-8?B?ZGFoT2FIcTJXUitPRDBIQWlVNUpUaEJlY3JJOGk2VXNvSnJVT3FFOTVsRWtz?=
 =?utf-8?B?STF4eDh5R1J4dldXcnhlN3BSMWZGMmFwVmVpTHlMMHFuNzdLdHdoZE1rWlUv?=
 =?utf-8?B?czNmb2hQQ01qdjdWeVdpRXRXNlFFSlAwU0w5aDBvbnlWdjRMOEZXbHQyQS9o?=
 =?utf-8?B?c3Y4YzhXYnBQZkZhQnNnMWRCM2tsQXBESHo5YkhHb0pvQitiNEV6ZzUxRnF5?=
 =?utf-8?B?UE5kVDd0ODRIVjFaS0t1YTcrZ0JMS291dEsxMm1saTJFbTUwT3ZFM2JyaDdk?=
 =?utf-8?B?c0NkTUViNHpMZVVjelZvWGRsYWYyOWliTjhyOGxPR01BNmhJcDJlK09NV1RG?=
 =?utf-8?B?emVwWXlGaTBXNjZzNElQb01QWHp1Nm96RkpUcWg5UklLTGNidFdPdEdBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tkd3RU1mWUliei8yUEgwMk5YcmhKTE9XbDl0TU93N3lxVlg3UEpxMVI5Ukpt?=
 =?utf-8?B?VkxaRFBtcDJHT2RacnZoZUJDQmsrUVVaZVU4b0E0VkV1ZXVJVWRDVUYvSDUx?=
 =?utf-8?B?QmtVWW1LcWV1VTVKUXpiNUE2RkEyYWh4cWFyUDhSWllsRHUwdEtoaUdsSUpy?=
 =?utf-8?B?ZHh4c21oenEvQlExUnFVVGVmRkhlTTNBTENZYjFBYys1bktKb0U1UjBMLzkz?=
 =?utf-8?B?dlM0cVNHd05reHdMUjU5RTlERHdiQlc5aWVYNlByV1RYY0xrcjVaZHVzQWhz?=
 =?utf-8?B?eGlwWXE1dXN2Mk9WMGttRHYzd1lKWHYxQ2hISjBCUFZ6eVY5MnBSUDV5emY5?=
 =?utf-8?B?RkhIYjJOMnF0V1U3QWVDd2RTVzVHZXZuYWRMRVZGL2FOOGNZQklTM2NyVU1D?=
 =?utf-8?B?RnFWc2E3SERUYUl5ZkF5MGVaOTBLOGk3QzY3UWg0ODVSMjc0NnFoUVhMRE5Y?=
 =?utf-8?B?aVhwalE4MTcyaVl1RDJpQk5XbFgyZEZHQWxrTldOZDZNN2d6N3dxcWZQU1Bv?=
 =?utf-8?B?VnI3MTdhcVhPOXVhRnlkSnhTRzNNVm9XemVyZUpLRzdaSHZXQ2hSRVpXQVFq?=
 =?utf-8?B?cngrWkxBajZSTnBMZytZRkxCOVU2bzZ4dEMvN2NERDZ4M2xObGFIaEo4Wmgz?=
 =?utf-8?B?Q1NQY2JtZThpL1Fja0dFYzU5SXBaNUdoQmNGcTdXUEt4VjRxcUV6R3VKSnRz?=
 =?utf-8?B?V2xmS0lsTEdVKzFtYXQxNVB5ZzlGckQ3RTI5UmxpNUc5VGxrNFV1RHRuRUFa?=
 =?utf-8?B?ZjNwQVRucUN3ejg4L2RKSUd3bzU5dGdCNEczOEpmUWdLZnh2eVJJdWZCZXF1?=
 =?utf-8?B?RDNHVW42dVFSQlRzclZCM05ocVVDUTdZRHExNStRZ2paZ2dMeXM4VS9ucisw?=
 =?utf-8?B?SG9TZEFSQUJSVEg3a0lwUnJzTVZJc1ZPN0U4clV6NVZMRVhsVURoNXhmT3RE?=
 =?utf-8?B?SnhIZnUydExkaUxrTkdBblhGOWJQdWxXcVRCUlRNOFRyRER0ZnRXaHFtZW1i?=
 =?utf-8?B?b1VRZmFDcnVIVUNSTVZveHhLU2Z3Z3NISGxTa3BaTVliQjlnM1FRUkF3d0Qx?=
 =?utf-8?B?Q0l5NW0yNm1HWUFzQzJ5TzBFUStHRUxWYzhJSDJRZWYxckQ3dGh0WERvVTNV?=
 =?utf-8?B?dkFGTHZULytQNkJIckV2Z1hzTjN2OXFiaU0zUHhhNzhuUmhNZEl0VkJLakhn?=
 =?utf-8?B?MEJPUjcydUJXMGhUVnpnUkFBZkVkbkFTV3pYS2dRRUljd2pUY091SGQyclNB?=
 =?utf-8?B?UnFRWHV5ZkFNcnovcUVWQU5iY3FaT2FUbzdzTHBlcWhzci9lOVo1SEk2cGlY?=
 =?utf-8?B?ZGluRmhpVmJWYjJ1ZDBzWVlBTFo5dEh2eUxDYW5Tbm1ROGlsVzVINlcrM01u?=
 =?utf-8?B?bVFPMjdWWXJ6VTdyS1hPbklzSzdtaUovUzlCZXJpK0VoSFh4ZjMzNzNxdk9w?=
 =?utf-8?B?bGJwd0dZVFJidG5sVEI3ZTlvWTVsQ0V1U0oyTVliakhldy9CRm9CUG5JYlFK?=
 =?utf-8?B?ckJDYkk1dGdhRVJHMXN3Mk9yMm11ejhRVzJNQjR6V2NxYmJYTmsxZDJ4UGNq?=
 =?utf-8?B?MXNkazhybmRDYUs3eStXS1hUakZsYVNyM2RocU5kTGltTVduQ1RSVWFiQy91?=
 =?utf-8?B?NVpwSlM5Z0RXekNMR2VJbW1lYkFNVnpMV2dqNG82R0wrajVTSkt1dEUraEJw?=
 =?utf-8?B?eXZmMmRvc041ODBtU1U4WnNTb0lrczlveUdwY1VBOVI2OXJsQ010d2oyNVc4?=
 =?utf-8?B?cEdiQ2ZWL2FYc3pmSXByVmNLUVN3R0wwaC9hcmdiVEJaTkE5WUJJeTUyMkR2?=
 =?utf-8?B?Y3V1czVyQUdoVEk2N2orUEhBRER6Z1BlZktFY3QvTXhRcWV6ZlJsVUovR2VD?=
 =?utf-8?B?UUFQbmVnZ0RPaUlEcmkrUDlMS1Era0k1V2JnR0NRbFVOOGRVYVhTSDAvRDFu?=
 =?utf-8?B?eWExcmdjT1o1ajhtdkNiT2JkV1p0dVRYMk1LYk5OV28wd2ZTYlV0Sk5SNTNw?=
 =?utf-8?B?S29hNVkvZmlhR3ZrYkEwSWZMeXJGRVg4SE5IRUZpSFEyQkxnbmdmWFVYa0o2?=
 =?utf-8?B?ZUZ1ODVRSi9aQjFZcWlMZ1gzVjZvdUsyQndDTHdIUmFDVU1Mbm50VWRNSnFw?=
 =?utf-8?Q?woV+tZsdqKmAv0W140du6cOEq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4803a8a-b8bb-49e1-ae72-08dc91527163
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 17:57:25.6402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ew8i45UpYKw/yrNmMWTh/uv+vjf8PgSV00q+Xc7zYchM5kSlVEtvnLdpdTvZ+RIy63ETwk74FABJCIqCMgMG9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8522

On 6/20/2024 11:14, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is reported that single-thread performance on some hybrid systems
> dropped significantly after commit 7feec7430edd ("ACPI: CPPC: Only probe
> for _CPC if CPPC v2 is acked") which prevented _CPC from being used if
> the support for it had not been confirmed by the platform firmware.
> 
> The problem is that if the platform firmware does not confirm CPPC v2
> support, cppc_get_perf_caps() returns an error which prevents the
> intel_pstate driver from enabling ITMT.  Consequently, the scheduler
> does not get any hints on CPU performance differences, so in a hybrid
> system some tasks may run on CPUs with lower capacity even though they
> should be running on high-capacity CPUs.
> 
> To address this, modify intel_pstate to use the information from
> MSR_HWP_CAPABILITIES to enable ITMT if CPPC is not available (which is
> done already if the highest performance number coming from CPPC is not
> realistic).
> 
> Fixes: 7feec7430edd ("ACPI: CPPC: Only probe for _CPC if CPPC v2 is acked")
> Closes: https://lore.kernel.org/linux-acpi/d01b0a1f-bd33-47fe-ab41-43843d8a374f@kfocus.org
> Link: https://lore.kernel.org/linux-acpi/ZnD22b3Br1ng7alf@kf-XE
> Reported-by: Aaron Rainbolt <arainbolt@kfocus.org>
> Tested-by: Aaron Rainbolt <arainbolt@kfocus.org>
> Cc: 5.19+ <stable@vger.kernel.org> # 5.19+ > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/cpufreq/intel_pstate.c |   13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -355,15 +355,14 @@ static void intel_pstate_set_itmt_prio(i
>   	int ret;
>   
>   	ret = cppc_get_perf_caps(cpu, &cppc_perf);
> -	if (ret)
> -		return;
> -
>   	/*
> -	 * On some systems with overclocking enabled, CPPC.highest_perf is hardcoded to 0xff.
> -	 * In this case we can't use CPPC.highest_perf to enable ITMT.
> -	 * In this case we can look at MSR_HWP_CAPABILITIES bits [8:0] to decide.
> +	 * If CPPC is not available, fall back to MSR_HWP_CAPABILITIES bits [8:0].
> +	 *
> +	 * Also, on some systems with overclocking enabled, CPPC.highest_perf is
> +	 * hardcoded to 0xff, so CPPC.highest_perf cannot be used to enable ITMT.
> +	 * Fall back to MSR_HWP_CAPABILITIES then too.
>   	 */
> -	if (cppc_perf.highest_perf == CPPC_MAX_PERF)
> +	if (ret || cppc_perf.highest_perf == CPPC_MAX_PERF)
>   		cppc_perf.highest_perf = HWP_HIGHEST_PERF(READ_ONCE(all_cpu_data[cpu]->hwp_cap_cached));
>   
>   	/*
> 
> 
> 


