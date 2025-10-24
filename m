Return-Path: <linux-acpi+bounces-18187-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DF7C0685A
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 15:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28CEF3B4E55
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 13:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C951318131;
	Fri, 24 Oct 2025 13:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XT0PkT73"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010054.outbound.protection.outlook.com [52.101.85.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E0961FFE;
	Fri, 24 Oct 2025 13:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312747; cv=fail; b=iA5Cmz1G4a1FdTWRTRSHb43kLchH1ktJ1E+e4YHTcSk2sunBvWQ6G93dI+Df3OT6imIluR5LUfEQDnP0+jsvcBfZwtP3vycsdU0CRJWgNXbhGdinyfZJtiVk6f6IgO97RWsxH8XO3N0D9FCyUunVBe3Gx1CvkH3Uuzg+HD6ScLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312747; c=relaxed/simple;
	bh=INu3UZj3dV7cccRioC6apesIop5jNiIemKSa3/wgpEQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jX7+LlUidlOs+24zUTQuWRJAXRXXk+K7OOVhaoql3MDqu4lusOMSIrsdMiUgxjYFiV+YBi7gE7Wgqmq3kmSiXYm25RRcKyJT3Qh7ltOgHxhzSgMg0MTmGuh+wB0HI/S/3GsBLtleyCGSz6RitzjN+7PS2nmEwu3k72a2e0wY3gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XT0PkT73; arc=fail smtp.client-ip=52.101.85.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtslCN47JhP4sAqWLZlKeFJEh7U3Pr2Aamq5DT8pblaOaKhwF353sxQF/yBo5PrvmEBV1wLkezF8XLGCTQoAkIpbHE8eUbPiZWukXZ3hXjB513kjeS4XL91NSgfDpfDITx8jODArHO9UCvWgmNfN8R7qUvua79TwNC/+Z9TkKNZKw73uqRwVmyvI9pP8EgU5ptyxFc3yAuPpV5giXvzPwCf1SxKHn11viSfDGQYRdo4B1jZp3R6ueDyG43uGUr+F351sn9YDlftliYvKIqtWxxmU0GxFVbyFjpJmkMF7QhP76TFGRjsgV9cuSI8CNQx+cbEM9fkPRKIOCN5UtX6RBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ramreu4I2yRY+5LEOM+D0GrDnaZaAoQUPu+PD3dv2qo=;
 b=PPWmWankI4x+Juno2sREzDMcwdAdfBFK/kLK32ao8iYSvCh810KsBey+W8sQca74Be/jtBO78YLRglXDbtm/HFVMima9GVW5fgZ/APda5eZS4M7tAEdOqGZpRgby40u4vnvAeztz9COEcYAWLguZhLT2AuliC9H+DNBcezcku+MbSJ50J5sFLKkDEp8TQJ2P4ikKofJMf/mWDfHok3hImOu0fWx/0LYOmesozQLLrUILARqtY3xcjUsqwLilvDB5osKQX2nGHr71qMpmbXGAuDMWg7Ylq0xaexHXJ2UNAnXFTiKRVLsH5+uvd63uhZ6KAevLMBTT2mCpl4dBw9tUug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ramreu4I2yRY+5LEOM+D0GrDnaZaAoQUPu+PD3dv2qo=;
 b=XT0PkT73P5itSWlWwJToY7hlpq45frxktKuB+NT5RzRjn+CBfKeITkst8ef8RTJ1JTmlqKskvQ4Y4BU5xwjbd5JORkaAPuKULxl0+hq0r5k5tEZiVu/BbJTf8Qa/KrpWzu8VCvC0U+vPsTWGcVjQZ5b7dl6dpGEfwQj8cNgUmVqsJvkHVQ0EoTv2THSVqg67fKGYL/wpJuvdLhBFs7YCOfKFv2NZJg7gRbt0oeWyS1awvoZsrPemnsmoeYb9iSo6UOxnPPz2deSUSgzhf1i6rAxa4HevC38vCr/TkfNyF8EyXLldvX48Rrg7JynTT71sQhf/fxm9fla2xmdlb0kJYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by BY5PR12MB4049.namprd12.prod.outlook.com (2603:10b6:a03:201::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 13:32:19 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 13:32:19 +0000
Message-ID: <ee56e056-3c7e-4df7-9186-fc458d4379eb@nvidia.com>
Date: Fri, 24 Oct 2025 19:02:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] cpufreq: CPPC: Add sysfs for min/max_perf and
 perf_limited
To: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, lenb@kernel.org,
 robert.moore@intel.com, corbet@lwn.net, pierre.gondois@arm.com,
 zhenglifeng1@huawei.com, rdunlap@infradead.org, ray.huang@amd.com,
 gautham.shenoy@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, bbasu@nvidia.com,
 sumitg@nvidia.com
References: <20251001150104.1275188-1-sumitg@nvidia.com>
 <20251001150104.1275188-7-sumitg@nvidia.com> <aPjHw5Sr4IYw+Dum@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <aPjHw5Sr4IYw+Dum@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0114.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::11) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|BY5PR12MB4049:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c8f8792-77dd-4195-b199-08de1301c152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjZmOUVFNjdzWnRXRzU2ZTVRMnVkSUkzVFl5SlFwUnFQOWtOZTdBb3h6Q2VO?=
 =?utf-8?B?MDVzNUlobnc3VWxjRjhZNUdTK3RMUlVHN1N6YW9VKzFSbURjU1BXV3JGTXRl?=
 =?utf-8?B?bi9OaEVuR2pod0xvZFgyMGJCbmFzOHlEN3V0TFlVWjV4K09TUTJ3Mlc1MzRh?=
 =?utf-8?B?anE1clI0ejkrRTlNR0Z6VitDT2pvR0h5bnBRNWU2R2hrUFMyQUtUMGJIR21l?=
 =?utf-8?B?Vkl3WEJESHJxbmFzYWRIdnE4TnV4MTBabzZlMVdsdjI0UDJnc1NYd0dlSWs1?=
 =?utf-8?B?citpbmQzOUFobm5uVHNaQnRvQ0htb2lwVmt6dUVLSWpRaTJmWHA3OUtLdHgx?=
 =?utf-8?B?eDd3QVl0R0pBa3BQNitwaDZjSGJHSmJjY0FacFdWMXR3QWlMQnZZaEVZUDVZ?=
 =?utf-8?B?VXM5ajBQVlFxTXFWMjJsOU5MZWpiN2tvdndMNy9uUWJHdzhMaHl4VVVibCt1?=
 =?utf-8?B?NG01cS9KakxUc3FQM1UxUVllRzExMkw0RFMxUmtobkhheDVMY254cjUzNGpY?=
 =?utf-8?B?dTloRFVuNzJkdlBMODNXdjJlSkdYMUpqd1FlV3Bsb3VSNFJEamVrckdkdGI0?=
 =?utf-8?B?eVROaDlwVTc1ZzJOTjJsSHJtVjNwbzIvakE4WVhZQzNvb09Yc0VrVjV3ZzlJ?=
 =?utf-8?B?czFEeGtKQ2N1WTdPUFZwNjBjYXZKTTJhRUhnaGtVNWdaWnoyL0FWWUp1NkpX?=
 =?utf-8?B?WnVjOE1Yb2JZR3JrT2x0Q3BmMjRZSUtBRTgrMThWUUJicFA5cWl2cHAxY3lX?=
 =?utf-8?B?bkoxVTFLcHo3dWlIY2FjMHZvbGsyYWxwbjJrZ2RvekxBc1BEd2J6MW1PSGpB?=
 =?utf-8?B?cGd5TFoxK1NxUThRT290MWUwV3RZSWRxWjBKcHVFU0FORk5nZEhQbmsxa3BZ?=
 =?utf-8?B?M3lJWVFaWGtuMGllaGhDMUVrbUF5SHNuWklYTHNwM3dBMFRvQnQvbmorTWZH?=
 =?utf-8?B?bmpqL0duUjA1ejI1N212NDZZM3dkU2gyOVlqU25CTEZDYlZPOUxXQ2x4OGRP?=
 =?utf-8?B?aSt4c3J0VldHSktRMW5DOXJ3VDVpdFZYbXFVQ0pVS0srNmd5b0VQaW1uM1A5?=
 =?utf-8?B?aGNlL1h4aUhpWSs4M1dHQUpEL1ZTMHV3SEhiQmV5UlZkUUtyM1NtSUFxNUl1?=
 =?utf-8?B?TUloOUZvVkN0UHd2bnd1V1FDZXlvc1YydFRUUkt2QUI0dU03TXdaLy8zZXlH?=
 =?utf-8?B?UWE4Z3U0cjhIbXBnWGJTN01yTzF3RU82N1ZOWGQ4UGxrdGxCVlA1NXRoMmZX?=
 =?utf-8?B?amNaS09kWDYzUnREUml6VGJ1QTdReVJXZlJ4cldLcngrZHh0SW92NDkwODlY?=
 =?utf-8?B?RnZzTXVoWDNxSEJtWVdOTFZuZm50WjFmdTBvTjJtZ1lLa29GU0RrSExCQTEz?=
 =?utf-8?B?YzJVeURyS05uelVSb2VTbWt6R3dZdS92L2hqRUJMY3hHMTk5QjJNbitsbHZ4?=
 =?utf-8?B?bDdMdHBHeE9KMHRVaW9UOHpjSmptSDA5UXFLRlpQRUVwMDVlS3psemEvZmp3?=
 =?utf-8?B?NmphbTBqZzY4YWRXQjJ0NUs0Q292WXRWSTFqckd1Ui9wYmJMa2NKSkVzUjBm?=
 =?utf-8?B?c3VsTGM4T082ajNyeTVoUUxsNjVVRVErSCsyMUNyeEFvTTQvSWljZHVHcFpq?=
 =?utf-8?B?NU8xaTV2bWVkY0t4cGxvTDVMVE1nQU91MFU0MGIvZURMTjVMY3c4aTZNVloy?=
 =?utf-8?B?Y2ZWTWM4TkFBQU1rWHR0N0UrVm12MnN4bmo5QllKY0RONmp0eXkvczJpdHRo?=
 =?utf-8?B?UWZiMWdJeCtBTEJoYjdqaTlZK1Fsc09PWXF3K2o4aUFudlQ3eXRqY1MrOGhS?=
 =?utf-8?B?M0QzeTBEQURjdFh3NDk1bXZCVWRQV09Mano0VFJJRlNZaFdoL2FVLzBXNTdz?=
 =?utf-8?B?by9kQjlUWnh6aHhDTEw0b05xOURkSEYzd0tkZGlRemRnb2luWXU0eGFUa1VB?=
 =?utf-8?Q?c/SW+wmWawMaDSqZRX8JnNZkUeX6SNa6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1piOU1Qa3BpMG12SmkrT00vOTlEMHNNclFqYlcvMnBiRUJ2T1JRbjRkUm0w?=
 =?utf-8?B?cTZkcFRxcHBhUHZURm5jUVVOQk9ta2RRNTZzQTR5Y0tucTFQL3l1SnRpbHAv?=
 =?utf-8?B?RE5ESEpJTUZkSTlmS3JRa1VTVU9GWG9EVjFoaVRXQUFVY0VGSW8wRmJGKzhi?=
 =?utf-8?B?bmNpdnJPWTh6Q1haVkZjMnZWQ1VSM1FONlNXbmNwcDJKdmpHOVpoc1RHcC9H?=
 =?utf-8?B?UU8yaUpGbG9tSFZMS0hldGs1UHdrUDdCTklOS3lMZkJXK3RUTGd2VnMyUlp2?=
 =?utf-8?B?NDYrVkt1bUdMUThZSE93cHlsSWJSWUdMSmlMcS80ejYrekdsYUs5cUpGV3NM?=
 =?utf-8?B?dThEY01ZM3l3YWMzN1JrTG5OS014WE1ISk5Rcm5JNldjK0JxYlpPR0J0NW5W?=
 =?utf-8?B?S3kxZ1NpUFpPS0dDL0VzVG9LSzMwaEU3NTJ6eXBWTmRwQ0hnTDIrT0F3VExZ?=
 =?utf-8?B?MGgvclZuMTBmbEczNVNNUXFGYW1za0djdEZabzZadjArZFhIRHNZeEJyOGtN?=
 =?utf-8?B?NWZoUFdJNWJwRUF5Tk9FS2hqSGdFK0dGSlVNM2cxRlVyMlZxNXlFL1l2bTY4?=
 =?utf-8?B?dnJQMm84Ryt2QzFLZzk4bSt5QzJHc2dMbmpIQXVpc2JCWmhnS2FzZEVnbTZj?=
 =?utf-8?B?MS9mQk9NVFI0R2VONU9RVXNaaTd6bzNJNExUVklwZ2xsclBnTlFEdUZjU1A0?=
 =?utf-8?B?M1NsVnJNTUEvdldVWjJWRnZmalpqVGt3M0dKVGJQamNGYXByTkQvY3BuZm5s?=
 =?utf-8?B?R3V2dVo1dXJ2dW94M2JuczMwQmtmcEtGeWl0MFJHMU1MSUQ0L2prclp4Q2ps?=
 =?utf-8?B?akZXWnlIRnpNTTQ5UDdoR0UyenNIRldGTGY5Y1ZPYzMvK0RJdUZUYzFlaFdJ?=
 =?utf-8?B?a1NlcEpnMnB4TlkwV0hCOFRIV2hsN20weStlQVVkTnhLNWtqSThQbmpLeTJ0?=
 =?utf-8?B?V2VxdUhQZVFlYVJGZ2kyNVFxdTI4REZrd1FTZ040M29oWDZSa1Q4WENjbHdO?=
 =?utf-8?B?QVVIZUlPb29vM2VNUWZHWWdYSFJ1Sml1S3V2bEw2ZnE2ZHcwbGx4ZzJMYWFD?=
 =?utf-8?B?OGlxcUhiWFJuVTdvbjA4VmliV0FMbEowZmNJeVZOc0E0M1BTcjF0OGJxSEtI?=
 =?utf-8?B?N1hwaVhJQ1JibjRLRHVRN3BLeDlrNEtNTy85c2d4V203MGpRanpYcEgzdXdM?=
 =?utf-8?B?bE0xUGp4YjJ1TzNoSkwyRDZoOWtGWE5ISUN0TGdBbHlOLy9ydjR5WnpBMXFy?=
 =?utf-8?B?NmFOa3NXZnFjUTliZ0ZVSFczekFNVWdnenV4WDBWRFcwNUszYkhxSHJ6YzF1?=
 =?utf-8?B?YVhDUEN6akJySjJnc2gvd2VSbTBMcnpGd1hXMDJXTHZQSWlTVkdnczNJZVlE?=
 =?utf-8?B?OUx5bnlUUVovODFqclFiL0c4TEdzOWJVdWpMV2t1dnB3R3VLU2d0S0Q3Z2VE?=
 =?utf-8?B?VW9leU9xbzlGMkpUN1o4RjF0SVUvZXpQYVJxSVVEeG1wYkp5cnUzMkZJaExo?=
 =?utf-8?B?TGFRVEFDVGh5R0pMcHRqL3RhdzdORGJNNmJDOTY0em8yZURIR0ZYRWFNZHdC?=
 =?utf-8?B?UjlTRjlXaWdyUG5CVzBJTGRBL0VEY0ZHVS83UzJ1STBQOERVV1oxQjNIV25Z?=
 =?utf-8?B?M3dFdEhlVmgrazgxcENDRDZsWmp4TUw3R09KTTVxMUl6RWd5T0crN2RKQU5U?=
 =?utf-8?B?b2s0ZzZGamxteG1ub1QxSXhXbzNlQTRNZWlLWERsWmRWWVZQSFh2elJDR3Zy?=
 =?utf-8?B?a1VQNlk5U0Fndy9WMElaUU5aQTRuYnk1UFVkZTdQR2hOR1o5R0NFTG1uZzFU?=
 =?utf-8?B?ajhYQjZONGE5YW1xYlFxRS9PWkpudnIrRnhUYVBqOU1EelUrVlRpb3RnZEtz?=
 =?utf-8?B?QXVDUWg3N0NkNThQZUJTclp2RDc2cHNlMDMyNmNsalQ0QkNkaXNPYUZTUkpj?=
 =?utf-8?B?YTEyV2FnYlByN21pNThFZWE3cTJPbzQ3NzlEdkFMRzFvRUdXL0R3L0NjUzRv?=
 =?utf-8?B?REZPc0d3b2ZENjVWd3VQU0RjczQ0VHA4VCtXbFF6QVJpa3AvaWZVS1ROTmcw?=
 =?utf-8?B?NENlNzJPUlFyTEVPUXpwZE93YlQvSVZ2c3lsQ2l0T09oZWNmQm1Ca1hZUU1N?=
 =?utf-8?Q?N4Y9IN0HmpNBnfqda0DMiCNTD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8f8792-77dd-4195-b199-08de1301c152
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 13:32:19.6339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IRLoGyd6zonKBkQr8Qt7qMvHj5zs9h2Xj6KZfdQeOXfoQBX5O/QLm99iQ/x6/A6kUIoVLnfUYWzmLgFi2byvkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4049


On 22/10/25 17:32, Ionela Voinescu wrote:
> External email: Use caution opening links or attachments
>
>
> Hi,
>
> On Wednesday 01 Oct 2025 at 20:31:02 (+0530), Sumit Gupta wrote:
>> Add sysfs interfaces for Minimum Performance, Maximum Performance
>> and Performance Limited Register in the cppc_cpufreq driver.
>>
>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   .../ABI/testing/sysfs-devices-system-cpu      | 43 +++++++++++++++++++
>>   1 file changed, 43 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> index ab8cd337f43a..82141b45d58c 100644
>> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
>> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> @@ -327,6 +327,49 @@ Description:     Energy performance preference
>>
>>                This file is only present if the cppc-cpufreq driver is in use.
>>
>> +What:                /sys/devices/system/cpu/cpuX/cpufreq/min_perf
>> +Date:                September 2025
>> +Contact:     linux-pm@vger.kernel.org
>> +Description: Minimum Performance
>> +
>> +             Read/write a 32 bits value from/to this file. This file
>> +             conveys the minimum performance level at which the platform
>> +             may run. Minimum performance may be set to any performance
>> +             value in the range [Lowest Performance, Highest Performance],
>> +             inclusive but must be set to a value that is less than or
>> +             equal to that specified by the Maximum Performance Register.
>> +
>> +             Writing to this file only has meaning when Autonomous Selection
>> +             is enabled.
> In the ACPI specification I don't see a clear dependency between the
> minimum and maximum performance registers and autonomous selection.
> There's nothing to say that min and max do not have meaning with
> autonomous selection is disabled.
>
> Thanks,
> Ionela. 

Yes, will remove the text about dependency on autonomous selection in v4.

Thank you,
Sumit Gupta


>> +
>> +             This file is only present if the cppc-cpufreq driver is in use.
>> +
>> +What:                /sys/devices/system/cpu/cpuX/cpufreq/max_perf
>> +Date:                September 2025
>> +Contact:     linux-pm@vger.kernel.org
>> +Description: Minimum Performance
>> +
>> +             Read/write a 32 bits value from/to this file. This file conveys
>> +             the maximum performance level at which the platform may run.
>> +             Maximum performance may be set to any performance value in the
>> +             range [Lowest Performance, Highest Performance], inclusive.
>> +
>> +             Writing to this file only has meaning when Autonomous Selection is
>> +             enabled.
>> +
>> +             This file is only present if the cppc-cpufreq driver is in use.
>> +
>> +What:                /sys/devices/system/cpu/cpuX/cpufreq/perf_limited
>> +Date:                September 2025
>> +Contact:     linux-pm@vger.kernel.org
>> +Description: Minimum Performance
>> +
>> +             Read/write a 32 bits value from/to this file. This file indicates
>> +             to OSPM that an unpredictable event has limited processor
>> +             performance, and the delivered performance may be less than
>> +             desired/minimum performance.
>> +
>> +             This file is only present if the cppc-cpufreq driver is in use.
>>
>>   What:                /sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
>>   Date:                August 2008
>> --
>> 2.34.1
>>
>>

