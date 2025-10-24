Return-Path: <linux-acpi+bounces-18185-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8511DC066B4
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 15:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A9744E6781
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 13:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0AB31B119;
	Fri, 24 Oct 2025 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TP2cF3gN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013007.outbound.protection.outlook.com [40.107.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0DB2C21FE;
	Fri, 24 Oct 2025 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761311575; cv=fail; b=Wts/KbKWijGDmFsxcg2T4fO8hitCqARSKQbvMI6824rkyHnTfhRZdxTRyMU8RfZkMWAXFG2u36gqtI/RAQQhkGiDfVIXZQlVjr6exSHAVniLttbXYLsopWI6xBv5Fa8gRutmhYonrNXeUAeIkO2QbGgfF500m2fVklw++bsC9NQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761311575; c=relaxed/simple;
	bh=gqB75aY4BUZ9qBtD6+Y+0gEGI/XUaUqB4i7XSZYsYyc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tIWqFefNnoTYgTxYk7YNFMXl9IiMyeKPbVRvZKgOOGhbN3QI7Y3JAKwzJEO/5rCTyE1ATR18ns4fj+h2XGApT2mmaiNbQZcaqgoOfRyvCrRutAff7B/TS8xfj+kJQRpwGmsCDaisqC2FS/+XlphYCLgNU7e0Gv3uYld+G/CuJvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TP2cF3gN; arc=fail smtp.client-ip=40.107.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohOHIYc3QxTquJZ2BRUMwKk5GQEtZ7wkW14hQyWrSMQ1ofzrI8PQCbes+S9BjFpqLm403y2sZuPvNvngvNcuEt3v+FkVpBj071oQCLLyksmvvy0O9YVgOKysGswsQ9oxvgzpDSlfjbqJu+CcUAMkABlDZJmhsvX557RZSatgNBmbrm3zA6NHItTTNXiEA/2wHZwFOTalOAGz99Vfmz7+5M9bisqUKFtdeqv54a5E/7YWYDcZdYAELyggfAOaC+Ug6GHYrRRg2VyGzr2BuAx3Kc8RCGzzqI7dkOv4R1X9fuvnS7EpP4jNg4foVAAqY7H4+6qXauL85byfvDOYEuNH5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G21IsyPKk/WJTtD9LvlwxiFbyGN16zLGRZN0OwHvayE=;
 b=hGy4Unq8oNhnZ9fsk0m4AlbiVEU2QRFSoOacDr6DiPMufvxnOuYdFSexfEP1P6W06wr7vKV5q+rza9Tq+8riX2wnrPICHD/pLKNZL3XaGOtYdTfP1RmV0FxZRiLGn0H0U5dukiSQZ+6Atab3CiE1t8d3edRtlOZrdhf+9/mqpZ7Jzx0rJUfFcdeOYCf8tWngOFP0LTek3eeeJpLxstGm75fLM+SyCNnMqNu2QRTZZHxdWcP5/rsLlYmKSxsB3JocKS9efQDAJ0zGBsqIoj1ALch34DwebJ2UyeL+E6R/K77596LgvfNtG5f/eO5TQqsFBrEyx9A7muMAjeUcAMAyYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G21IsyPKk/WJTtD9LvlwxiFbyGN16zLGRZN0OwHvayE=;
 b=TP2cF3gNWgcdyB2n8TidS95FfW7Z69CelEUkdSTY0eppN6tbJPi0JTWvEe2Sa32ND0rCbN/c0GncauuD7/9uQrZFQGg1VVQGUvvG71De94WrIwIeBnP8IIE4380niX9pWQZX9g+fC8RgD4MgQFwzQjaic183VNdyJEX6f5JQYZwPcfenEK+z5MEGTosI+IZbWzLDCqE6UyopDlRJbY7iOMsc8jZyL5qW2jxHhnz32iKZ3Ll0nzrwm8YA4xWn+1jmGMNERzIGM+dO1i7bwDcNS9OfstPW9ULwRIZ9YcgVHsJJtmRVznMqBDdwMBnfORGerVUyWR1uzKABnTALJpz2sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by DM6PR12MB4170.namprd12.prod.outlook.com (2603:10b6:5:219::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 13:12:50 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 13:12:50 +0000
Message-ID: <acb19233-1ab1-4c6e-a150-5657daa50846@nvidia.com>
Date: Fri, 24 Oct 2025 18:42:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] ACPI: CPPC: extend APIs to support auto_sel and
 epp
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
 <20251001150104.1275188-4-sumitg@nvidia.com> <aPigDd0QTiRjey7K@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <aPigDd0QTiRjey7K@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0053.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::18) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|DM6PR12MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d218a5-5dcc-434d-29d0-08de12ff080c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGF6bGRVZzNCRFMwQ203TFhmQnEvbFpEZzJWN1RsUmhNQXdrMk1WVUJ3VzM4?=
 =?utf-8?B?WTFQci9wZCtIb0xqMmxpZnBRbmR5bDQ3NUhMTHkzdWVNSktMak9heUYvdWho?=
 =?utf-8?B?OWxFdEZQc1BOSGlQazM0dHdvU3kybDJlNTh0d3VOWE15a280YnNkVGNpdWRt?=
 =?utf-8?B?Zkk2RUZVaU4vb1czRkIrMnAzMnB5TEh0cy85WmFaRTEyM0ZlVmFpTlZxNDZz?=
 =?utf-8?B?STNwU2E2QUJwNUtBNFJYYlVhcEYrM2cyU0xrcjJXci9rREVMS3Y2MGUrblVE?=
 =?utf-8?B?U2xaaXp5MkdDalg2SG5XaFM4d045SjJaQmN6VmlzVFNPY1doYWRUUnpJRUJB?=
 =?utf-8?B?M1JOcTQ5anlNT0hFVDFWb2J1RXcyTjJoaXg4bGppQzFNTEVDOFVoYXEzTVdB?=
 =?utf-8?B?ZmI3TDhTRGpGVVZXMm00WmV6R1ovVjNjVWdqbkZFcWZnb3F6OWxSbzNVUVRK?=
 =?utf-8?B?Y0RlU294b3B5UVVTdjVBT09YYlR0MWRJdVJJenVwVjFGODFJMkFEdEdnQmMz?=
 =?utf-8?B?RTVmN0pFNkkvTFVEdk9KaS95OWg5Wit2bkRGOTZzMWtsM0w3YzU2Y0YvU25l?=
 =?utf-8?B?QWllbnhkKzBaWUJHRGQrNWJ2WC9vM3F4UlkreGtBMnZxN0pEeUxEcUlreWVH?=
 =?utf-8?B?eXZwUUh6T2Q0cGFCYytMYlZ3UTRSV05NVk5zMTVUVGpVRjg0bVM4K0k5ajdj?=
 =?utf-8?B?VFp3WlRveFd6N0xXM3FtL3AxVzJFRjROREFGZ2VXUXAreDZONnRwR1pNb1RD?=
 =?utf-8?B?cjJvZlhSaytyOHZjYkRvUVJiZWZNaTNVeWRTdGNLeW01a0Jpd1kxMG1HL3VH?=
 =?utf-8?B?V2ZkaU9JZ0c5dEhYQlpmOU45V0ZjRVJGV0h5U0Z1bVpsa1ptaDh4YUxUbXRy?=
 =?utf-8?B?akRNcytYaDdESEdMeStjWTNwc3hEa3JyNjc2c0s4azJvK1lCaXFOblMzcjQ4?=
 =?utf-8?B?VG1YMDRwMVM5emxTUlVyMVlqUEt4dnJaZFNkUERwbTRQMlZnc2pXbTU2NStW?=
 =?utf-8?B?NU4wbm1sMVBpY0VlMU56ejk5QUxjelNjT2RMKzhxZ1BrTFc4QkdTUFRYQnRY?=
 =?utf-8?B?V1ExcFV6cHZxRlBrNmtISjlqN0ozajRaS29CMlNSYU15NnRCeTNhbURxNVBi?=
 =?utf-8?B?K3UyNGVYQmk3cCtkSlYxM0RaaGw5Z2lURlhmcnp2UWJJYVV1N3hacU55YkhG?=
 =?utf-8?B?UDdPMHFjNWlsZ0tYUFB0N05NSnhwVEkwOXdaVjRYeXVyekpUc21jNUszNnJB?=
 =?utf-8?B?Mm1ZSnozRmxoQ25ybjgybmM4ODVaQzRxb3F6MkRMSTBWNExla0hWNkdLNzRm?=
 =?utf-8?B?WlcxbUhTQXM1bytMN2NJZ0xHeVF3VjM5R09jbXh2NndtNVlvazNSSkdrT0NB?=
 =?utf-8?B?SVJKVE1VTDN1d1FwNWhaU1FrQmhSUkNZSHhtUVRoYVNUa1kyZmdEajMxZEJN?=
 =?utf-8?B?US9Md3pmMDJQWFJhVUF5NXZrZlJ4UTczeG16M0dNa05BaklhRHFKWXF1OUlU?=
 =?utf-8?B?NlRQZzZQcm9uV1U1K2NGQXh4bXNCNTlCUHBvUTQ0NHFKVklrRDRIYkdYdUZq?=
 =?utf-8?B?QzFNcmorNzRTYXhzS2ZTOXlocjV1QjJiS0ZpQW1MV0VSSUZRRGRKZGd2UGow?=
 =?utf-8?B?cFJQaDNqdFNDS2lZSENOZ29kdkp2dkhFNUx1dXBxMzJUem5EM1ovNWdkVWpz?=
 =?utf-8?B?cFJ2ZDEvd2RwRGtzbTNhcVlsSWZ4Q0lSdmx3SzlSeExHdldSalJ3K2N0MC9l?=
 =?utf-8?B?c0xwa2NuSUxoQjFKdFJGejJCZ3ljNWJ0SExBVWtweFVSMUFVdE9QV1V6K3VP?=
 =?utf-8?B?WUR1R0tFZFNMUFJJQWVpc0dxUVBSZEdtSWtJU1NIcEc3V0sxWk9OalNaL1Zv?=
 =?utf-8?B?V24rRnZHa0dXR0hmcEJJQkJyVWRpYmlrMDJMY3JyaXk1b0RNVFRCVnZ6cFph?=
 =?utf-8?Q?8w9gI6ZSkoCXOUVqGlxFIwKR7z1wlcSC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWtKOFk2ZFZlckYxNjVkWE43T1VjeXlubTczdGV5Qk4wZjdHSDRFQVdBd2FT?=
 =?utf-8?B?ZVc4Y1l5UXJDNkgxaHN6czRFeWIyWWRrMVduNHY5SzNzNi9ubStmV1BCSHQ4?=
 =?utf-8?B?S2UxZDhSdC9ySG9oSkVneERTSVB0Q3NrbkpEM0FsNlB2ZlZwWml4QWdjZzhN?=
 =?utf-8?B?VStwbUM5Z1NqYUg2R2k3L2FzT3dTb3hudUlOTnR5NW1TU0xibWE2M1EvR2pG?=
 =?utf-8?B?WGhtN2ZHOGFTckV1OTgvSlZsT2FCUzJJWGNOZ2RvNzVQSWx4bUc5YVVKT2d0?=
 =?utf-8?B?OGxaOHIvbENPTWVYdWRkN0FqaEYwblJtdlYyNVIwcCsxMFFhTzNhSlJ2d1pX?=
 =?utf-8?B?VXpyQ2RWQWh6a3BYaEJoK0lkNW5Dd0ZRblNTdGlyYU11ayt6dEF0ZmxqdHJv?=
 =?utf-8?B?NGZYTjQ2bXlGYWMrNE1kSXdwWVIrclM5cEJnd05uVElxVUlEWFFQTXEydWxI?=
 =?utf-8?B?eUFQTHovSU5vSVEzZVBFdjdKN1NtUUIzMWhSNlRMS1JrQ2M2eEdCT0pYQk1v?=
 =?utf-8?B?b013SlZRL0g5a0lvbUcrV0NXWjdJVUI4aWxsRGc2YVo4SVFidzNsK1ZURkhZ?=
 =?utf-8?B?QXJUcmhGTHZMQTVPVk1xbW9HUEt0bFVmcjl3Um9HNFVrbnZPanNJYkUzVGpx?=
 =?utf-8?B?dXlHNS8zQ2pHYnFxa3czaVNjY2wwazFyK2FrcFJFZ2V1WGNsZnZkWWh6S1pX?=
 =?utf-8?B?YWlCS3JOTEZiVkhnUkdGb1dFMWhYMWFoSFE3UllxQ2dqZXBRd2NQM3NGNkhR?=
 =?utf-8?B?Y1VNeWdqaXdEUnBZNGVwRlNoRzZpLy90dUtQRUk2dzZsRFQyeXRPUzh0dGlT?=
 =?utf-8?B?ck11QTFsdStMQTlORm5NMWNSckRqWHNFTTJYb1VSbVB2MGV5eCs4dGs5TERl?=
 =?utf-8?B?WFNuVytpRkxlZUtXcjRsdHNjV0ZGcnVmbHArMmtjcjdSWHI3Z3lvaEo4ZlhR?=
 =?utf-8?B?cHNYaDEzWTlIVUkwOU55dzhPR3p5akQyZzVxTlNEZEVyV1llYTRSODdpbWNr?=
 =?utf-8?B?TkZrQnFENkZiSy9OOTBPU3cwcU1USHd1TFliMzJyRkpadCtCS3laUGlPWTZp?=
 =?utf-8?B?VkQrVUR0eDFGazVXbkRFQnlNblRKWll1MGdUaUxCL3o3Zi9senJQMUROaEt6?=
 =?utf-8?B?L3JUMm8vdGJMOUY2WUNRS0FjWkJNVDA0YVZHZ1dKRit2TlVSL1lXSUo4TUtS?=
 =?utf-8?B?d3R0OTgzak1Ma2pNTzZCZVdZQkx2Wmc5OVdoeHAzVEZ5OWFKMm1Tdmc1RkVz?=
 =?utf-8?B?dE9acUx0MEhHRXk5NXNNeFdUZDU0SlFvTk81VXgwVHRieTRuUk9FZUE4OCth?=
 =?utf-8?B?bEpVZUt2ZmxNUjhxN1lNeWErbEp6eEZDTGRFS2tBa0ZGVkd5NGxuMXpzVXdM?=
 =?utf-8?B?eWc5N1dqVXZaMG40N1Vib3lpMUZZOHgvK2J1N216V0RsOTV1Ujkwa29mM05N?=
 =?utf-8?B?QlZhVzE2azFMTXdqd1dhUHJwMjJxblRVZjBhS1RsVlFRMHJKVU80elYxT0Fy?=
 =?utf-8?B?SFdpbDljYXpxd3VLSjdFdDc4QmtONVlSbFRTazNlWEoyclg5NEpJT1VHdEdl?=
 =?utf-8?B?T0VIYVZ6a0xsSjdPMGlsNnQrcWw5WGs2a3VGR0hKOWRXMktUaWJiTkJyR1Uz?=
 =?utf-8?B?M21VVnB5WmFZeWVhR1N6M0pZbmREZGkxT09zYnpWcWJZeXlEYVNwWlVmaG5T?=
 =?utf-8?B?Z0ZTaUFBWXM2dzIyZ3llTW9jT3BIMGR0S1pjZ3JoalFVNWM3SVNaNEp5NmFw?=
 =?utf-8?B?MHg4bkFyM0cwWW1yNFc0QWVVMDZyTjBkR0c4cG9odHlkTG1aS1ppQmNyMGJH?=
 =?utf-8?B?Ny9rbTY1ZVJnbHkzelBjOGFCdGNDQXpSb3ZVK0RJYTRmcTRiL2Fld2xhMUhV?=
 =?utf-8?B?MVB3blptWVFobHRtMW5temlzTWcvRUpPLzU1ZDJPMDd4dXdyQ3doS3l4Qk5j?=
 =?utf-8?B?M2ZXb00waWdzMUN6cVQxUDloSFhrRjZRdStyNnNhRnVlVUNuQnc0OWRBM2Jr?=
 =?utf-8?B?bys0aHk5YUxKdDVNRDBuN002cFFoWjkrcjQ3N01xUVFOMXVmV3NLMFlKVjNS?=
 =?utf-8?B?b3Z1bkNyVGJJSmtUbHUybUpUMnZLWDI5aVlKaE05S3BKRTRXd1NuMkIySlFl?=
 =?utf-8?Q?E5eM9hI1UZRnL4CK1Z1gZNQMI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d218a5-5dcc-434d-29d0-08de12ff080c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 13:12:49.9055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XDK+0DABmbfVWU1lxv/R+3BR883Ur2WB3YQfcj8BhpnZWB7d/2li2KR85Nnzk0ecywAcMpgfcBqiTUmeAVeTRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4170

Hi Ionela,

Thank you for the comments.


On 22/10/25 14:42, Ionela Voinescu wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Sumit,
>
> On Wednesday 01 Oct 2025 at 20:30:59 (+0530), Sumit Gupta wrote:
>> - Add auto_sel read support in cppc_get_perf_caps().
>> - Add write of both auto_sel and energy_perf in cppc_set_epp_perf().
>> - Remove redundant energy_perf field from 'struct cppc_perf_caps' as
>>    the same is available in 'struct cppc_perf_ctrls' which is used.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
> [..]
>> @@ -1555,6 +1559,8 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>>        struct cpc_register_resource *auto_sel_reg;
>>        struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>>        struct cppc_pcc_data *pcc_ss_data = NULL;
>> +     bool autosel_support_in_ffh_or_sysmem;
>> +     bool epp_support_in_ffh_or_sysmem;
>>        int ret;
>>
>>        if (!cpc_desc) {
>> @@ -1565,6 +1571,11 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>>        auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
>>        epp_set_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
>>
>> +     epp_support_in_ffh_or_sysmem = CPC_SUPPORTED(epp_set_reg) &&
>> +                             (CPC_IN_FFH(epp_set_reg) || CPC_IN_SYSTEM_MEMORY(epp_set_reg));
>> +     autosel_support_in_ffh_or_sysmem = CPC_SUPPORTED(auto_sel_reg) &&
>> +                             (CPC_IN_FFH(auto_sel_reg) || CPC_IN_SYSTEM_MEMORY(auto_sel_reg));
>> +
>>        if (CPC_IN_PCC(epp_set_reg) || CPC_IN_PCC(auto_sel_reg)) {
>>                if (pcc_ss_id < 0) {
>>                        pr_debug("Invalid pcc_ss_id for CPU:%d\n", cpu);
>> @@ -1590,8 +1601,19 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>>                ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
>>                up_write(&pcc_ss_data->pcc_lock);
>>        } else if (osc_cpc_flexible_adr_space_confirmed &&
>> -                CPC_SUPPORTED(epp_set_reg) && CPC_IN_FFH(epp_set_reg)) {
>> +                epp_support_in_ffh_or_sysmem && autosel_support_in_ffh_or_sysmem) {
> Isn't this problematic for when auto-select is an integer set to 1 or it's
> not present at all? In those cases the EPP register won't be written and
> -ENOTSUPP will be returned.
>
> I suppose for the case when auto-select is not present at all in _CPC
> (it's an optional attribute) it's not very clear what one should do
> regarding writing the EPP register. The specification mentions that
> "Writes to this register only have meaning when Autonomous Selection
> is enabled.". From my perspective the OS should not block writes to the
> EPP register for this case, as autonomous selection might still be
> enabled but not exposed to the OS.
>
> Thanks,
> Ionela.

Will change in v4 to write them independently as below.

-------------
         } else if (osc_cpc_flexible_adr_space_confirmed) {
                 if (!epp_support_in_ffh_or_sysmem && 
!autosel_support_in_ffh_or_sysmem) {
                         ret = -ENOTSUPP;
                 } else {
                         if (autosel_support_in_ffh_or_sysmem) {
                                 ret = cpc_write(cpu, auto_sel_reg, enable);
                                 if (ret)
                                         return ret;
                         }

                         if (epp_support_in_ffh_or_sysmem) {
                                 ret = cpc_write(cpu, epp_set_reg, 
perf_ctrls->energy_perf);
                                 if (ret)
                                         return ret;
                         }
                 }
         } else {
                 ret = -ENOTSUPP;
         }

         if (ret == -ENOTSUPP)
                 pr_debug("_CPC in PCC and _CPC in FFH are not 
supported\n");

-------------

Thank you,
Sumit Gupta


>> +             ret = cpc_write(cpu, auto_sel_reg, enable);
>> +             if (ret) {
>> +                     pr_debug("Failed to write auto_sel=%d for CPU:%d\n", enable, cpu);
>> +                     return ret;
>> +             }
>> +
>>                ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
>> +             if (ret) {
>> +                     pr_debug("Failed to write energy_perf=%u for CPU:%d\n",
>> +                              perf_ctrls->energy_perf, cpu);
>> +                     return ret;
>> +             }
>>        } else {
>>                ret = -ENOTSUPP;
>>                pr_debug("_CPC in PCC and _CPC in FFH are not supported\n");
> [..]

