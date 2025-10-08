Return-Path: <linux-acpi+bounces-17658-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3405BC4450
	for <lists+linux-acpi@lfdr.de>; Wed, 08 Oct 2025 12:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 375B04E4DFF
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Oct 2025 10:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180CE2F5A1E;
	Wed,  8 Oct 2025 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f9FkGVqF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013030.outbound.protection.outlook.com [40.107.201.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF882EC55E;
	Wed,  8 Oct 2025 10:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759918612; cv=fail; b=QvkXpyEqvYu6psVI1tjR7jGB78vWEauhWH3VrAFaS8wcubtiNfnjFg+djOLkvezadU+za+g16MVDrWx+ZHlZ/uVNCC6ucARzXsjT3h8UOAskUrj8Mw2mbdkb5YQWOguXi1NXZJNO3LfbpXC+nQy7+BcIK/shImqja+SRmp9hN2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759918612; c=relaxed/simple;
	bh=4R0x9lEfTgVceN5vDsZE2DXVbjxC/1QOJsYpCXitJ3w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b02L+W7jmWfmmYNtfQmW9OpB0PTRB/uOyKVzqwN8TgU13zLATT94UaOf8OZCDc9L9aEkSeMBuQ6qCNNmEE1HqO2JGkpJ1kCn8ZNrZ7Y++Cstkjgf4AXnNea3NNOJD2wAuryxysQ6iSHbj4wf82v5HpMjktSGPqk/eEFK0VxSJOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f9FkGVqF; arc=fail smtp.client-ip=40.107.201.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1+ET1KxiK5W7eM0GimVG4J5bwPOwLw6Alk6KWEgp2GirLC/i5mSk6W0Rh5KLAzDtpETtsJV2fgYzpTBJ737Pj2E2TiBXO0hgiam44obl1gtzAnFigERcPHKL+o98s70EKqqrAbPTan1h38UgrIrfruzJGXz1xAtEOpwmigpLiTcUAf63cbhtCswQK8JUUE4+tkc3l9JZjjqQPsl4X1/Kyq4hIgukt6MciYlpuXOPL//XEgakElfAd3L4fYCLBIXzTuPYo6x0ChJwC0Pr+5ykh7vKI1IwAzjyJBFyncBVj0x6N31r4woY7+925bK8VdjbguFW69+mpcz6uJTKD9igA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3McLj+HalFO/qPNRJH1pbHNBBTsSNxRcCRRAc/1lhig=;
 b=ReT7thqJj+CpTh1sDHJZ6/VxhaDg+nuv3abvI8TiYHpSl+kwSAiERYDaxacaB1JwnED52eG+EzJ8B9EK5bgDOxKx96MFBcpJjOpvhsG0Wsy+9eXWcl52BPeGPJzvBBrAyjpsGFN7Spg3nWS4NsDCtQ+JWqZ5lAy7a5A2pMe4XwY8j0jMsivKYNiyOtnlM8llDhtVn9I9ItypzMRI+mRtek+rnXXHDSeXEvJsa0WILyEtOTGt5KZEkWSYJ8Eq49cs10cGmhipIR+hYQEM74aiVTD9cSbw4JIj3gZ/kSl2kdK9fyneOcb+6QSJL1HFPgAwFVuEv0HTByirY1piXk9bAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3McLj+HalFO/qPNRJH1pbHNBBTsSNxRcCRRAc/1lhig=;
 b=f9FkGVqF5G30I17j14hEFGBX0D7HX3a22uqejgwfDluV+4OB6is54e0zU55tz3y2oU9G26w9ElubyC+uA8zYL6MmXUhUXknZZlU5a3TRDJNf2ZJTz3eRc9FMnO2e47fj7Dm3MloM0mVCw7gwwC168LPM00OM0rSooVmyO8HFxeQgBDOvm7tg52KgpSjS8JqAIry+o31R1FGKJZ/eCZCzKgGG9Alq1rEZE5Rc2J/T/783BZz3IWkYv0eJJyvozIS2uZDm5odmujAbaR67YwqT691klG4pcbta0Jq3dMqAJiavwhDEy9zr4WfhbYc+QNOrdC0BinZpVxbnIaL4uD4PlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by SJ2PR12MB8979.namprd12.prod.outlook.com (2603:10b6:a03:548::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 10:16:42 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%7]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 10:16:42 +0000
Message-ID: <b7b137d2-373d-4705-851e-1b4bc99dae28@nvidia.com>
Date: Wed, 8 Oct 2025 15:46:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] cpufreq: CPPC: Add sysfs for min/max_perf and
 perf_limited
To: Mario Limonciello <superm1@kernel.org>, linux-doc@vger.kernel.org,
 corbet@lwn.net, Randy Dunlap <rdunlap@infradead.org>
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 bbasu@nvidia.com, rafael@kernel.org, viresh.kumar@linaro.org,
 lenb@kernel.org, robert.moore@intel.com, pierre.gondois@arm.com,
 zhenglifeng1@huawei.com, ray.huang@amd.com, gautham.shenoy@amd.com,
 perry.yuan@amd.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, sumitg@nvidia.com
References: <20251001150104.1275188-1-sumitg@nvidia.com>
 <20251001150104.1275188-7-sumitg@nvidia.com>
 <dbee61be-4e1c-4f58-ae20-32447b6767fd@kernel.org>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <dbee61be-4e1c-4f58-ae20-32447b6767fd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::10) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|SJ2PR12MB8979:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b81d062-29a6-4886-27c6-08de0653c684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WW9iNHF1bllwQm5ienM1VzNYWEJVcSs2SWFOc0k5MlQ4eXRYcTQzMEIrYjE0?=
 =?utf-8?B?UG9kMUprWVRJYjZaakJ5YUtTTGwvTTVPNTlGYmlDendKcVZBcC81UWxWZlg5?=
 =?utf-8?B?ZkxNbWlJdGFrL2VFaEJZT0JTdWZZcXJSUG0xWkpYMUJzbmhRTlZHTHhpL01r?=
 =?utf-8?B?YnIvSlAycmhOeUlSSmJKSTZvN0ZsQTdKY0ZxNEVTd0N2aFlXaVZSa1hPYW02?=
 =?utf-8?B?blVEWUdodGxpak4zTXVKL1E5YjdILy9YV3FYd3Z0NEJ5VXBzQ0dMMHhWdFJl?=
 =?utf-8?B?aVRFNUsrdFhISFRoeXhOTzZvemprTER5SGo3MUVkWW5GRm1YeE1ldHVrUGZS?=
 =?utf-8?B?MFhHUTNmdUhRczArSXBxV29Qc2RsNERrZ2k4N3E3V2xVUm1CemxheTVJM3o5?=
 =?utf-8?B?ZFFLdWphMFZsSEpyNVBGdzg3ZkZteENHYzJpNWgwOWNGRkEzNmUrL0NoUlJF?=
 =?utf-8?B?RUJCcUxnTEVhVkVCQ0wzRVQ3RmJhdW9ZcjFveHhBTjdDcEtJTE9FeTFiZU1X?=
 =?utf-8?B?UmNKOGlHWVpmUUFxVUx4YkVoZWdVdGJIak9yaDVXR1NTQXlLQnQrQmpoTlRI?=
 =?utf-8?B?amJlai9uU2c4Q0pvVzRmcVoxRVJ1OXBZdnhmSE0rckNNKy8zSHkydmNSTnR2?=
 =?utf-8?B?NmdDQ0RiMlpUZ2dMYW4vcGlnMnhIY3c0cHFFK2lPU1RtRnhQeTEzMEVCak92?=
 =?utf-8?B?ai9UamtNU0dkUEdvNWNucUM2ZGxWTEZwWWR0MmhaWi80azBxeXg0R2QzSHA3?=
 =?utf-8?B?V2lHTThTd2Y1QndoWlZrSEdueW9hN0pkaGE3R2VVL1lsWlZXaThaTDFjTS9a?=
 =?utf-8?B?SlB2cXFFbWJEOGxGTWRSUnRFM3krNDAyZlRJaGNxVlNEekZTYmppN1pSRlJ2?=
 =?utf-8?B?MHhOSWxBZFlydytMQXlTZmx3L0IzNVRpRmpnZUdOOGxKd0ljUkR2bG8vRVVQ?=
 =?utf-8?B?Skk1Uk1MekdiRWNkTzhueC9SbEd1QkRXZEg0RHVXSDlhWXlibDhqdnRLL2dj?=
 =?utf-8?B?M28vOVo5R1p1REVwWDZwbDZlMk1mWHJuN3RQUzdIOEMvelJCRmNBOUtDcHpL?=
 =?utf-8?B?czJiOUVqbk54eE9ZeVBhNzVJRVovWWU5M0V2VWNPM0JHV04rMFpMNGdPWEha?=
 =?utf-8?B?aGptU2VWMEhUNTNTOEVTZ0ZEeTRUN3FLblV3dmVjRE5SWnZ5RGk4bXFKeFBP?=
 =?utf-8?B?ZC8va3hoc09NYThvV0d3dHY2bm80d2ZjbGtUY0gwMkl3Z2s0SW1OaDJBUmV1?=
 =?utf-8?B?aUZrQ290UmtkRVdBYmFGZlpjS1UxaXIzRGFiZkl1U0FEWVVMbWVvb1pzWC9p?=
 =?utf-8?B?bHVLQmxkT3JXYlVhLzdkK29TUHlveG12WVU0RTBUcCtML2locjBubXRlYnpz?=
 =?utf-8?B?aHVxUVRxV1UybjdMeVZ4MjMxbEs4dUpQYWcvbW9RaTFwcjJGWVRNdGYrQkg4?=
 =?utf-8?B?M201dlN2RkdiRGtJVndTOXpKR0VmYy9rV0F6L3lzTGZKQVN3ZHdGcVN6MnVk?=
 =?utf-8?B?NC9uQTZqRW96QnZacVRUQjRnc2xwSkxWaGtnZm4zNUFXanEwTHNSRGhUWURz?=
 =?utf-8?B?UGRNcmhsazlhNTlTcWZkQ2Rwa2xtQXZLVWZBNFY1N1l2bnV5SXZ3R01MZjlv?=
 =?utf-8?B?OFh1cmtqa2lvREZqWWl6dDUvaVZsUXlBbzVzUXpLNU01Z1M4MnpWR3FIWWJV?=
 =?utf-8?B?OStCVmVFVUZkUko0blpjWGlyWlEyNHZKRzVqY2pMWmVxOERYMm1PRUxBV0Jz?=
 =?utf-8?B?K2ZWa05tTExXNFc0MFpHbzdlbDJJcTZuMlcvMEwxWDEyT1k5TXJMcXdhRDk1?=
 =?utf-8?B?OHoweDg4eFNKK3kzUnQ5Mk54VVhtbng0QlNjWEtUakVQMVQvelVITjM5WUxv?=
 =?utf-8?B?N2NYSk90a0xobUJjbWlxMm9qeEtkUzJkbXlZbkF2RnJSWUZJYkJnTDFGRTNR?=
 =?utf-8?Q?7c9nvXQ6MiMw7vZkSR6cWnjWXyf+QHK7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?am9zYUoyNGdFOHBpeDljSEtJRG9La0RzOFVFU08xRWkwZG5GdUE1TnZIWWZU?=
 =?utf-8?B?b2dtUS9LMjI2bHM1SW41bkxzZ1ZJL1FaczZka2NDQmpFMlE1cnBNMDg0cnkw?=
 =?utf-8?B?bWxvbGtTemRLN3FXL1RTUkcxMUpqTVJaZXhmRnpEUXNCYjFKc3VlamE5OWd0?=
 =?utf-8?B?VGxvMEdET1FtRHZ4MGlia2ZZcVd5ejcvTlpXV1h1YWJmRWVPTDdNZWRiY29k?=
 =?utf-8?B?TkUwZ0oraitiU1pNdEt3WS8vUTY4R3lMNVV3d2M5NFdWSTQ0N1dkKzdIVVhx?=
 =?utf-8?B?Q1d6UmR5ODN4M0srQWJRNHh4V1NxTk5LelVkRXZCMjJMQUhid3oyYjdoMnZH?=
 =?utf-8?B?dHdoSzhsb2tmTVIzQ2tRUzBKTit4T0VTZVVFbEZwTkRSd1BwZ3h6THdoT0Np?=
 =?utf-8?B?N3NOWS9WSFA4bElxTGVWZXZVUmM4ZG93czhOaFhrejMxaEw0MjdoNnFueW54?=
 =?utf-8?B?TWlLUkxqUlN5bGVWQXBWYU1uN3lsejlxa3BQV0FVN1ZEZmdyRnpZUXJYSkxF?=
 =?utf-8?B?eDlBdys4Y2RRN3paemp4VUMxOUNhck9kM0NHWVAxS2xiRm1JUkZFZWtLaG9h?=
 =?utf-8?B?dGlHcGJmQURxd2toTS9GVHBmcEwyWk1ERE5PdU92SXE5SlVYbVd6cGpDaDZz?=
 =?utf-8?B?UUozY0dFcEVrNmZzb1pOWDc1amZ0Q0RtVS9KckFuajh6bE5aTkpvdUpVc2Nj?=
 =?utf-8?B?OFpMTUJEL3ZyYW82M1BmSWZTT0U4QkVTaUxVajhIWHVZQ1d4REZPVjk0cDh0?=
 =?utf-8?B?QjFmNXptOGluTStpZG0zcmZDVlFhSmVqRDFwODhZU3R0WElETUx1bTBvSmZM?=
 =?utf-8?B?REs5QUxrTFdkeFgwSmljOC94T3lJOGYxUkorcWNWSTB5cFJaMUMzZ2RjT2NM?=
 =?utf-8?B?WDNvU2N0NjF0MkR3TmEvS3I2UVF3M05ZT24rRGc0UzhkdXBydWFWeXBsNTFp?=
 =?utf-8?B?cE1helgwQjJ4UldVaDNMdGQ1WEplbjQ5RkMweURFdFhnWVBwbWdWVDVEU1JC?=
 =?utf-8?B?eTlkTXV0WGtFZzhNRS9SMFlqQjJFL3duLzRXZkFJRld6dURlemxEMFhPZWVM?=
 =?utf-8?B?WDJUaTFTaEs4ckl4aUpWdW00R1RJc1RKd1U4YVMwN2drdktUS2hHbDFvN005?=
 =?utf-8?B?YnA3azJ4ekJBSzFhdjZNQkFnWThJYjFMeG0zRXFiT3RMRWtlMU1qZVRxbytz?=
 =?utf-8?B?VVYzWWdpYlV5L3JNeDBIanBaZjh2YUVhSXlVTVhwL2NaMGJDcDdIUmt0anhp?=
 =?utf-8?B?bEFnNVNhdURpVzlPL20xTEFBbWVmRWpMTkVQb1pXMWpDT0YzRDVlYlI2VjlV?=
 =?utf-8?B?Umc1YXIvYy8vVzdZcUt0b1NWZnNIMGRVTG1SV09zejhaNXhTRXhONnoyZjhs?=
 =?utf-8?B?S0tzaUZhZ3dvQktUemZwTXlzK0s0Rmc0L0p4cmtidXdPa1gwT2Z3OHdTOEF2?=
 =?utf-8?B?MXAxY0k1OVJENDVWcjE3bVBZNy9MaVpES3BUTkdYSW9EU0ZxQTZnUWVwcFo3?=
 =?utf-8?B?UU50Y2RvekEwYWx3L2cvNGtvMUZRN3BITW9VcTN3c1Z3RVltMkhSTlZsOGV6?=
 =?utf-8?B?Z3F3Nzc5QS85L0cyWmtjYkZ1bTBBY0xYUGJicE9TZlJOc2hUZnBmTithQkhx?=
 =?utf-8?B?UnYrSWkxdnJIeXRaWTd1blV3dG9OSDJSdzlUSEVJQ3Z2Rk9aRW5zU2k4RzJM?=
 =?utf-8?B?cnF1VHNueVFuRVBseUNjZnZUci9Razd4ZzVHOXBQVTR6ZlZpdUpWZGFzeHJr?=
 =?utf-8?B?T1h3Zy8zSzBVbVlaZ04xY3ZRQUFqanZtL3VaOXJabWJXQSs0OHZrLzNPQTR3?=
 =?utf-8?B?ZVVxTjdpLzdTNEtZa1hPOHl4ZGVUVG5WWWJQZHA5dWhyWWdZNHVJWDUvVUxu?=
 =?utf-8?B?NGdKQXNhWmNoMGRhdFMzcTh6bUgraDlnZlVoVTRGOFJLTi9TNGhvcTZWTkQ3?=
 =?utf-8?B?dGhHNXRWZmduait3eVBEc2c0bWNDT3hCbVUyQnQzWGhlSXJyaU93eWtiVlFt?=
 =?utf-8?B?QWJ4bm9IL3dtTTMrQTRaVW1YaG9sd1ZZZXNEVzVhT0U0QVpTai8ydXN5bVlq?=
 =?utf-8?B?amtnaVp0S3JvbTYyRkMzdmNrOUhUWVU2bW5WQld0TkhnY0YxK28yZUhEb1Q0?=
 =?utf-8?Q?HD4lqROLQJ5Tv4T1aGz5wNT2f?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b81d062-29a6-4886-27c6-08de0653c684
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 10:16:42.0151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Btxlmrenu2ppjwMnZUZ+NeQhvZ1sxzMVJzzGSLAoi4lMB8b7hNNZKnxEUgPplq++2I3s4IX75Epb6aU88IrOGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8979


On 01/10/25 22:33, Mario Limonciello wrote:
> External email: Use caution opening links or attachments
>
>
> +linux-doc
>
> On 10/1/25 10:01 AM, Sumit Gupta wrote:
>> Add sysfs interfaces for Minimum Performance, Maximum Performance
>> and Performance Limited Register in the cppc_cpufreq driver.
>>
>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   .../ABI/testing/sysfs-devices-system-cpu      | 43 +++++++++++++++++++
>>   1 file changed, 43 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu 
>> b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> index ab8cd337f43a..82141b45d58c 100644
>> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
>> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> @@ -327,6 +327,49 @@ Description:     Energy performance preference
>>
>>               This file is only present if the cppc-cpufreq driver is 
>> in use.
>>
>> +What: /sys/devices/system/cpu/cpuX/cpufreq/min_perf
>> +Date:                September 2025
>
> These dates will need to push out since this isn't 6.17 material.

Sure.


>
> That being said I have a general question to linux-doc.
>
> Why is this is date based?  I would expect a date is meaningless to
> anyone reads this documentation.  People who want to know if an
> interface is available would normally look at their kernel version to 
> tell.
>
> So wouldn't it make more sense for this field to be something like:
>
> Version: 6.19
>
>> +Contact:     linux-pm@vger.kernel.org
>> +Description: Minimum Performance
>> +
>> +             Read/write a 32 bits value from/to this file. This file
>> +             conveys the minimum performance level at which the 
>> platform
>> +             may run. Minimum performance may be set to any performance
>> +             value in the range [Lowest Performance, Highest 
>> Performance],
>
> How will a user discover the lowest -> highest range?
>
> IE I think you should document how to lookup those caps too.

Ok, will add the info about these nodes as below.

  Minimum performance may be set to any performance
  value in the range [Lowest Performance, Highest Performance],
  inclusive but must be set to a value that is less than or
  equal to that specified by the Maximum Performance Register.
  The range can be checked from nodes:
    /sys/devices/system/cpu/cpuX/acpi_cppc/highest_perf
    /sys/devices/system/cpu/cpuX/acpi_cppc/lowest_perf

Thank you,
Sumit


>
>> +             inclusive but must be set to a value that is less than or
>> +             equal to that specified by the Maximum Performance 
>> Register.
>> +
>> +             Writing to this file only has meaning when Autonomous 
>> Selection
>> +             is enabled.
>> +
>> +             This file is only present if the cppc-cpufreq driver is 
>> in use.
>> +
>> +What: /sys/devices/system/cpu/cpuX/cpufreq/max_perf
>> +Date:                September 2025
>> +Contact:     linux-pm@vger.kernel.org
>> +Description: Minimum Performance
>> +
>> +             Read/write a 32 bits value from/to this file. This file 
>> conveys
>> +             the maximum performance level at which the platform may 
>> run.
>> +             Maximum performance may be set to any performance value 
>> in the
>> +             range [Lowest Performance, Highest Performance], 
>> inclusive.
>> +
>> +             Writing to this file only has meaning when Autonomous 
>> Selection is
>> +             enabled.
>> +
>> +             This file is only present if the cppc-cpufreq driver is 
>> in use.
>> +
>> +What: /sys/devices/system/cpu/cpuX/cpufreq/perf_limited
>> +Date:                September 2025
>> +Contact:     linux-pm@vger.kernel.org
>> +Description: Minimum Performance
>> +
>> +             Read/write a 32 bits value from/to this file. This file 
>> indicates
>> +             to OSPM that an unpredictable event has limited processor
>> +             performance, and the delivered performance may be less 
>> than
>> +             desired/minimum performance.
>> +
>> +             This file is only present if the cppc-cpufreq driver is 
>> in use.
>>
>>   What: /sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
>>   Date:               August 2008
>

