Return-Path: <linux-acpi+bounces-13444-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4DBAA8C57
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 08:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ACB11886BDA
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 06:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC561C5D57;
	Mon,  5 May 2025 06:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VO62Xyc7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253F78F7D;
	Mon,  5 May 2025 06:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746426897; cv=fail; b=TNeDvv+FxfwIgXxhjPPYdSvTfThAqu/djcKrDQ1g2VaNatfsjc6TLfwiYLRHsDoTEFH17hItnelcSg4nQAT2LJKlvQQ4UpYEWHQUXpBTw52GFy5nVUxKZkkA4Jo1o1DXWUtccK9Wi9y602SeMy+TNNHRJzGt92VUaS6as5lmP7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746426897; c=relaxed/simple;
	bh=UZ3zAlXtuzYUpW2N5OcuDJqequmU401ytJ6ReIz2qfc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qvBks5HxvlrOpO7uETQVdbHY7PxsF0LKo6xV9tXnCxk9JI2OZ0qimyL3Hzxq320HutFV0mplZFPY3QRme5tMzhfhWnVAYvQ5srH0dJyPQHuDUAa4kp8P2tkRV/HsbmrNTxv72pmh+dce1cgAur6ATrisN8AjXcqxZk0Ubj36Gjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VO62Xyc7; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUPgkxQMgOwf/KfH90z4xDfLAr8Ztyh57G1XVjIK1QXCMmfAmI378ciBhoxHNoqL55ayUdKhQoxm1HvYoO5DwkuoKMvnd7pXc90iVUPBeEzaG1FEgnDAGxP9glK74FBxHtnGIaHYze5RQIbf4awkiOeQPhB4NgMC4EI9vC8AqyJXArkqdTagapGPwyLy0TpPqDKGQbg72moS+1dfRGEEaKkM6InjO1LWd1TtK/G3hd8xsOzew6EkpFT9xo1f+H9i1c6cmpkFPhEPYSBNRVPJBkVu4ogzOEMepACyT95aEduLmLJjUyMy3ojdA2U6d/q5z4rFm5dbRMPwd9uPKqQcHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCuRicOEQxQn1byJ5ru1kmze8gs1yM5ONztDihNoGmw=;
 b=a1DBl5LZu3q/2a6wrPDFiDNdXkW5sY2+rxPMQzaGnqQWTiv1dKxraz3iaLmqHDWXmOS40J8MWzJrejy7C8pE2uyCZwWnQu3AB0rYb4EuaD06djdl/lqEc5ywVPTp75Q6t6Zu7qkM5bY1RIyCjtqLxe44S4g0DtF+IqXmfyIZpw4Y0b/HI9YXe1u5VcICMrf/JLNx6rQiBHr7Eu90ugqXVqua4aIMNFd7RO0EHSJpSWZPn9tvtpmw25J9lslg4Ex4pDDEkOeAsH7tWr3+KTDNqel1KOmQonBrNB6ayaMgBkRuYsexnSTR/ox0naPRNJ1dRx4aJeIFrnmzn9hYFBBO+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCuRicOEQxQn1byJ5ru1kmze8gs1yM5ONztDihNoGmw=;
 b=VO62Xyc76iOSh7nsm3SmuKKZGljeazpRok14w6xKq5KBUCt2en+oRpksaLxpBh+cgx/ibCKqLVBGcuTNF8SmCsBIJ/EGGPcb2whFBFR8LYllNHnfs3rsNsfz0f4ZXFcLOTXOMO9oU3eDAlwRxmJoah1kQIenAPD2KscrLL/eoOJpTmXf+LLRVmzN/KYE/JYoaY68RukYgeFCQ8DC7Abvy3oNQkSvhWsR51tKtOfAmlyA9Evapp15M1/8nSUVJQEhrwBHZRyop+BZoY0z0pJL55IIgy9fifOWdTBNvkVQo84EwhX1gJp2MMcE0c3CiE7r6u7e3ExEgrIYlzgQLxFePg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 06:34:52 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%4]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 06:34:52 +0000
Message-ID: <a5a6e279-82ec-4282-9cf2-6ec4a77a38f1@nvidia.com>
Date: Sun, 4 May 2025 23:34:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] ACPI: Add documentation for exposing MRRM data
To: Tony Luck <tony.luck@intel.com>, rafael@kernel.org
Cc: lenb@kernel.org, Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev
References: <20250429202412.380637-1-tony.luck@intel.com>
 <20250429202412.380637-5-tony.luck@intel.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250429202412.380637-5-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0376.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::21) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|MN2PR12MB4286:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba27cc2-963d-4001-9d45-08dd8b9ef116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHlXSjF6S3JjbXdqN1FlNVUxMkUwdlZjZGhEUGoxY2srQ0hqK3B3S1lJVDBO?=
 =?utf-8?B?WEtObTlxRWVOSm1YY2xPV0JENDdQdjhBY2V5dy9mOFMrRE0weHpiM1FSZDdn?=
 =?utf-8?B?cGpianpQbnZmOVdoU05mTkpYVUZYZ2o3Z1RpS2U1VWlYV1BmcmhpTzJudXZj?=
 =?utf-8?B?RkM0bUNyYlE5dXZxVlBUOW9IK1VlSzBSMytkd3R6cUUxVjMrTGpvYWZ0ZjU3?=
 =?utf-8?B?QkZJNnR1MXN5MTNhTVdHYUFsQkhKU2NlR0lzcnd4cDV6WDR2S2NZak5aTVRx?=
 =?utf-8?B?bGlwZXpBY0RWc3ZqU05ldmFUV0VJLzUvaVA0MHNjRDE5c2llZ3NYakxwUFhQ?=
 =?utf-8?B?dU9xeVE5WWhuK1NzMWFYb2RZd053bXVTeElKS3BJcmtjTDZuOUVKUEVTM2Jl?=
 =?utf-8?B?c1kyR0lIejZkakN5M25qOTkzS3d2V1RLYTdKbFhqNEU5blhyM3RqM01UbVF6?=
 =?utf-8?B?dUR1RmdVWDROSDNhaWRscldjWXBwRE40bzEwd3p4UHR3MGdkTDU2ZDhqdnhh?=
 =?utf-8?B?Tmt1a2JqRDA5d2FLVTFHYzBzZDZob2JUNkdkUEF1YnBYUEhMVDhHRzMwUGpR?=
 =?utf-8?B?eWR2TlhRRWlnc1Q0M3c4Yk8xenBVenhRb09vY2J4TG5PdHV5SG9iM2N3SnVJ?=
 =?utf-8?B?ZVhnTTZ6TzdKV0JUcHUvbXplTXZyT1RTSk8xL1h2NFpFbjZ6WU91WWI2eWpG?=
 =?utf-8?B?UzFlMU1zb1NrdzNtVHNua3ZsQjcrdUw3VWtsOWkvRDNHK0k4Ums5b255cWRZ?=
 =?utf-8?B?clRzeHM0bngzbzhwTFVVYkswdFhrblRlem9CeEs3MUhpMlhOQzIxbjVhdmdq?=
 =?utf-8?B?djZlTXg4SkthYXRoOFZSUitQV3NjNkxtMldUMnBuR2JwK2RGOTVjWkJ2ckdu?=
 =?utf-8?B?Y2VGY01FZEY2Skx2THdIVHQzM2lVRlVPUWtxM3FRa3JWWVBjRlBsY1k0Y25q?=
 =?utf-8?B?YnVhekx4NFhFb2NNdXFXdVM0VU5HL2ZFK3gxbktVYXFFWWNvTXloN2ZMVzNW?=
 =?utf-8?B?VlN4Qk15RVBjTTBLTEtKUnVnRkxjRjJNMnJFTzlWVFZBQzFKRnJKb1J4Vllx?=
 =?utf-8?B?aWRtRmRwNGxJbzdaNXQyOTFoczNFQURwRVNmK3h4WEVMTjVVb0VGSjVJZndj?=
 =?utf-8?B?NzBrNFRvMnlBdWVmZFNtZjE3UTZVT3Erd2NEMVZuMGNoS0xPaDBIemRKS21l?=
 =?utf-8?B?Mjd2TWhaWHphUUhoUkhRbDNqeFpVdkZxMi9TMjV6UDVyNkVwcklrWWdjbmZR?=
 =?utf-8?B?akRYRFVXVGVZMXdkT3BVbnA2bUc1ZVVqZzE3R3h4d3Y2U0d4bEFjV08yclp5?=
 =?utf-8?B?eGlpYUNRNFJ0NEVuclo3d0ZIa2FQNURvS1k0RURjWkdUUWtkOW5lVFRSVzV6?=
 =?utf-8?B?MGl4ZU5SbW5RTFFDTkVYbnBRSVZMenJaVFZReUF0NWdvZ09kdHhIRWVQK0Jy?=
 =?utf-8?B?SnRnczRzNjVXVWMvNm1ZeGo0akJUOURuQ3hjNVNNQWpXMFI5azkxNjZueW5W?=
 =?utf-8?B?YURXSTExWVpQSDVkYzZtdEhJT0NxazNVUlplZ0VpaXJKWFlTSFYxOWcvR0F6?=
 =?utf-8?B?OVdDakxZNG9jL0xDZDZyaWszSmlLb3pyZksyc0FxM0MybnBEcGJUY2NqbUFJ?=
 =?utf-8?B?ZnpwQ3pKN0ZkYkZpdVRGTm1YTlR0WmpPeDVCcDZmYzN3RDdVZGRVRGdwWm5K?=
 =?utf-8?B?QmhzU0VMcy92d2lzMUxobTJHRlIremp6aTN2QjRPUjZQdFAzeFdqb1l3UHhU?=
 =?utf-8?B?ZjVMaUNUUGF1MEdhVWdwZ1BaTTVsbG8xcmpkQWVFRWVYTUNSN0V3aHMyd3Qx?=
 =?utf-8?B?c2Fjak1YeFNnSTBVbTZsQVhnd1lMRkFIaHdDZ2NlM2VwNWFzKytLUjNadTc3?=
 =?utf-8?B?YmcrYVBTVmdScjhqbm80NndlVGF3ZjdnbkR2SU50THpiOW94OHNWY2tNWmpR?=
 =?utf-8?Q?hK3/XvTOR3s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmxUNE5JNktjSFBYVHdVdlNCQmJyREdBWTVuTGdWZVFSMXhKRndqTUVPNlVP?=
 =?utf-8?B?ZklFQVhzcEp1eWZPRVJ5VXhzdDJvdlhJbmdzR1hBN0M1SFVrMUphQlVqVWxN?=
 =?utf-8?B?ZEg3c1pSY25zWVMwRjJQVmQ5UkpJUUFOOUZnY0YzNjY4M0hEL0xUNXlaMWNV?=
 =?utf-8?B?RS9od0h3OGgvVzk2TmlwUW1FMklWbU81SVFDSmFuTGJGWEYxbFoxeUxmQ0R6?=
 =?utf-8?B?V051K0FHcCtPZHB6Tmx5VCtyREd3b1JSQzRqQjd1N2NHY0x5ektlTWREL01w?=
 =?utf-8?B?TUJ0ZVVVNUxiSmM5RVFWbkNFaC81dk5YU2ltUit3WTZCak5ESnRENnA0Q3Av?=
 =?utf-8?B?RzhtSERuU0drbUo2a0YyY24rSTZoNkVPcDZmd3ZrMWdUZWpRcTRHUnhpNUtW?=
 =?utf-8?B?Yis0R2o2UUMyVDdDZVc3em0yN3p6cVNOR3AzTm00dnlYQ1M2S0ZRbUp6OFho?=
 =?utf-8?B?WHpqdjNCdkNtM09DZTZlRmlwQkZ2Zkl0UVhtK3E2Zkp5b2tzK2FLcXlyaWRE?=
 =?utf-8?B?cHVNYk52eDBCU1AxNGVUWkFoWHBCMVpMa1pITW00eGZBUU9hOVh5MGtBdUpG?=
 =?utf-8?B?NHk2SDFhWW02SDlHNWVYczFVVmtsOUN2SDhuN1gzdi9UZVhVRE9UazJrbnNJ?=
 =?utf-8?B?a1FPR2Y2WVhLOTZhTFY0cDZFZDBEMnpYMHV4TFU5YU9Ub0p3TGdzUURlUkZs?=
 =?utf-8?B?S0t1akJtL1ZObWFwOG81Y0xLWGFCdUNMMytXeGVpTkpvc2tRTXBCZURxWURq?=
 =?utf-8?B?RG93dXFOQW81eXd1MVlRakM4a2g4RlV5dGdHQ1IyU2k0d1V5eFhsNzUyOGhx?=
 =?utf-8?B?dnVDems0WjFSZzZWYmYvTGpNcWdkdVJZUmdQU3F2MlA5Y0hicnhvSVUwcjZN?=
 =?utf-8?B?ODc5ajRJZ0hSVlUxYUtrQytVaEFQZktZMTRsNjNad1J2dkVqN2hJMGV6Wk1V?=
 =?utf-8?B?NDFkdlYveUdYdUI2U1lldnBLSkRBRWNmZzlXckI2WnpiWnRlTnZtZWxTdmgx?=
 =?utf-8?B?ZTRWc1FXY2lVQkRESEhMNDN0TnExU1hKeTI1SVBPYnlSdlRvYjNmay9NeXZQ?=
 =?utf-8?B?ZTNOOEdmRzJReE13SEo0eHNkUThQYXRaT1lmVUdEb2Vvd0Mrd0ZTQktRUG15?=
 =?utf-8?B?UlVGS3lsU3RWRDlUT2FvN3BaUVhmbG9teElXaktBcEhtbFdXSjlvZU94dEEv?=
 =?utf-8?B?eEVoSFYzYnkvUGNnaXFIeEYxR3JBS0JKcTVkOVMvb3p1OTlwWUVsZm1lbmpx?=
 =?utf-8?B?elJpRU9yZi9vTzY3Z2FOaWpQNjArVlZPM2FTWDFpUHJpbVNWVzFtSU1GQ08r?=
 =?utf-8?B?WisxUTBtSURLeUtuRXEwa0NHMi91bWFvSDV1UlVLSFBNQ2lNMTgySWtzU05E?=
 =?utf-8?B?LzhDRlVsM2pmOEdtR0pDV3dGZFVOQ0hUNXlxakpJVXQ5SlQ3Q3pYVks2NWly?=
 =?utf-8?B?dGpPbXFvT28vRVBRUng2TUlLd0VVbENxdUhJN213K0hSNDBqM1BZWDVvaUk3?=
 =?utf-8?B?Q0tTdkNmOWJXQkgrSVBxSnFkY282NzM2VEd3L09DNGNldTRyc0FhMlpoR0FZ?=
 =?utf-8?B?dzM3MU9QYmUyNUhsWGZMTFVTc2Fkb2hqNGI3bktVekluMkE2em16dWloRFJs?=
 =?utf-8?B?WDVtQmtxbFNmdU9wdEpuWGRCZ2JJb2I2QmR6L0lpMkFUN0N1SkVxRzRQenJz?=
 =?utf-8?B?RGpBSk1nb1VSbkJ3SlcyOHhlWm1hMEo5bWx3M2VrTTZld3Q3YitaYXBudERC?=
 =?utf-8?B?eGtva2FQMWtPNUdLbmJYdFlpZU9QbGgwTU9GVDRyZEpya1ExcEJXYlNwdm1n?=
 =?utf-8?B?THgrS2ZhVDVwOXVLOUp5eGxMWHNOa1dnNHBYU3A5bjVWd1RqWTJ3aXZ4SldN?=
 =?utf-8?B?Z2dXcEs1VjM2bjJJSndxeVJlVE4rY3F6cFpCOHZSZGEyL2RvbnEwbmY3dFNU?=
 =?utf-8?B?RWg1bGhaM0Qrbnh4cytnL05pSVh2T0dwTWFPa2JIdE5ZSHZ1a2lUMHRVa3hT?=
 =?utf-8?B?Y3hkL254ZHdLeEdvVk0vdHhSaWJNOXhNcUVUMnNFOWVPMUo2eXF2WFBycnI2?=
 =?utf-8?B?eERPdmkwOHFYVEVyTENKaU92L3V3WTNKUzZablVlYUMrZVdoY3hjRm13dHhl?=
 =?utf-8?Q?9RAhCSDb8+ImyWtac+ly96HLO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba27cc2-963d-4001-9d45-08dd8b9ef116
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 06:34:52.3843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jXVUW2xx7TTZ2PfXS2F05wmXUgeEVdSPD5HeF+HvxwP7NuZIffmmAZXBLZTbr6ZMmd+g9KMy685kp3BPIEiQDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4286

Hi, Tony,

On 4/29/25 13:24, Tony Luck wrote:
> Initial implementation provides enumeration of the address ranges
> NUMA node numbers, and BIOS assigned region IDs for each range.
>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>   Documentation/ABI/testing/sysfs-firmware-acpi | 21 +++++++++++++++++++
>   1 file changed, 21 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-firmware-acpi b/Documentation/ABI/testing/sysfs-firmware-acpi
> index 5249ad5a96d9..fffba38f9ce1 100644
> --- a/Documentation/ABI/testing/sysfs-firmware-acpi
> +++ b/Documentation/ABI/testing/sysfs-firmware-acpi
> @@ -248,3 +248,24 @@ Description:
>   		  # cat ff_pwr_btn
>   		  7	enabled
>   
> +What:		/sys/firmware/acpi/memory_ranges/rangeX
> +Date:		February 2025
> +Contact:	Tony Luck <tony.luck@intel.com>
> +Description:
> +		On systems with the ACPI MRRM table reports the
> +		parameters for each range.

Is there a need to explain what's "X" here? The "X" is not a number 
directly reported by MRRM, right?

Maybe something like "range ID is enumerated from MRRM starting from 0."?

> +
> +		base: Starting system physical address.
> +
> +		length: Length of this range in bytes.
> +
> +		node: NUMA node that this range belongs to. Negative numbers
> +		indicate that the node number could not be determined (e.g
> +		for an address range that is reserved for future hot add of
> +		memory).
> +
> +		local_region_id: ID associated with access by agents
> +		local to this range of addresses.
> +
> +		remote_region_id: ID associated with access by agents
> +		non-local to this range of addresses.

Thanks.

-Fenghua


