Return-Path: <linux-acpi+bounces-9585-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C229C8868
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2024 12:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8C61B24CFE
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2024 11:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555961F7082;
	Thu, 14 Nov 2024 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DryA8gkQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A103C1F6669;
	Thu, 14 Nov 2024 11:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582285; cv=fail; b=DK0bUc+bgaP/9g6Z+frtou3W1jX7NhU7/bD/fdEEIYqgdKczhR54meP0NeKkrBbpUEUCONQ9Rqn1bL8nzpcDY7Ra2hgOl8G2ikrL3elR8at7fferylqXwmP7do8415eY/MOiEmtISaQtvXHNTyzTt9DU+1sjddZX4g3+J97MVeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582285; c=relaxed/simple;
	bh=JHt8w0Vn3Q716fMzrtm/etZshdNlF6eWseO9HZ0hYos=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l8AtUv+YoFo0kEoqqFKuiuS7L990hmVl42DyaNlj5QhGaBNeJEMuu1dGq5gSQKXeRV8aPYwkEpe0IHByaudXuts+yoB5lcs3K+ou2uc4FwJuOJw76pNB5N5nDdF4fM/8iNf17tfNNJmgKoiCwMlEs+KYevVetTAvEKBWPG5o6i4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DryA8gkQ; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aL320+43Db5AJDviDYRSP6IGDwbNTwHZlGqDvkXc+qfmxsrcVu99S+Qt3rMu9pQBkxTdSc68OwmASPmsFxbBZJqx/dSNJi7oGdpuZivmJWvzZ43Y1J58sQvHNI3pPjhwgV9qGEBgIHRwfHSGWacMETjVjPimen50R5o6lLWjaTSoQkxMY+VUQBBCX4QqundYvR3KLw0fsK5eVveXZQfiZJcozx9UPc5/kZ8fbrRKoQzI/M3VUPMMtIg3dIIVU04kmj95L00MagNEQs3YoNvffTn0vxyNbNL0H8taffE+DP+Y+zvQy9uc6f2qnA1E252hyACEa4w2GkWXB1e86kLtwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/350Cv913SGKavgmlDTHkyAc2/VupVjHdfBOcxIMZGY=;
 b=I0P2P/KGLF9kxY+wLc6AbmHjy3NRhlP7J7AWJKeGEQOYl/Z9meON/gwp3hmHT47QEFlkQ7epUOhypFTN/g6zGx0LCkmYzPkhv2a700+5HKiqdZdmi8qePXTuvm3GNkDsKIlfhWyuqpBwvVZnWBFnAs9CigjhmAGwx5ApH5ZfoSDzQgsNUAoebmRRcL8NoPI0FOvFEId4RnU1u9+mwNwWxqnnwWTjKWtzXpQrlIrxvFi06JiR12sn0WpXFrZnvufIR9q1WdaeDs/fcYGBQWwBUTmCIi9L5X/jgLCvBv3XSFNCmnX8fIY6wiLPX80YbBiHeg7JkrT13S8uinIhLDiBrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/350Cv913SGKavgmlDTHkyAc2/VupVjHdfBOcxIMZGY=;
 b=DryA8gkQ+X+vY4vHtnyST5lGDlJv9qE91+Z5Vjc9KRog5X2X+FiR+r5TLAPIq5WoHu5VO/4L1ir0IwXQpSV8dZO6CWdVsjLeGy3GR3AD/C6C2AcgPjfKALxWeOeu8m0FbQml5CQSIViFxrrheRgjA/qN5YaDsDyVFsHI4yyWU2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by SN7PR12MB8602.namprd12.prod.outlook.com (2603:10b6:806:26d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 11:04:39 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%5]) with mapi id 15.20.8158.017; Thu, 14 Nov 2024
 11:04:39 +0000
Message-ID: <60883883-6961-49ec-ac47-adeee81bdf70@amd.com>
Date: Thu, 14 Nov 2024 16:34:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] i3c: master: Add ACPI support to i3c subsystem
Content-Language: en-US
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>, Sanket.Goswami@amd.com,
 linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20241108073323.523805-1-Shyam-sundar.S-k@amd.com>
 <20241108073323.523805-3-Shyam-sundar.S-k@amd.com>
 <ZzS1-nJMPiCp5jDi@kuha.fi.intel.com>
 <079db1b6-0f95-452e-832b-7d392e130028@amd.com>
 <20241114075601f451d590@mail.local>
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <20241114075601f451d590@mail.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::9) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|SN7PR12MB8602:EE_
X-MS-Office365-Filtering-Correlation-Id: ab18aac3-bb76-4414-cdbf-08dd049c222f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXFrWjVOMVRXUTlteEo1UXdxV2JaVGhaYlRuN3g1SzBnSDhxZFAyUFpYR1lt?=
 =?utf-8?B?LzJsSXJvUEV6RW1IUTBYZGNwVTRyMVRsdU9taTUvemhhNkR0VWFlS0I2bHNU?=
 =?utf-8?B?aUxUMjBMZU0xb056enNVeitqTUtUYTI3MmJrK1RaYXg2TFhvZ3MxbWhORWNO?=
 =?utf-8?B?QzBQeDE4ejhIRi9zb3Ixa3BRcUcwYVlpM3U2bmdVcldTYWg3NldJdnJTUWFE?=
 =?utf-8?B?VGFkbzQxOFBJY29UdmtBQis2R25TaXk0RGJkSXBMR0l2bEJVVDJqK1pzMXRP?=
 =?utf-8?B?RmxMVkdiWmJIT0hJNEtyRUhNZ0Z6bjJaUkFXVVZtM0d1TmxaNWlGY1NVbEM3?=
 =?utf-8?B?M09jR0tZWVIyL2VEb1BjdVNjdzI2c1dRY2o0cTlvMU5RbVF6aUVWSHdEK2V2?=
 =?utf-8?B?c3FWUWtFSXd5YTMvbnAzNnlMbnBRaEtGeERHV3FKZENLQU45MGJETWFrRDVp?=
 =?utf-8?B?TVhLQmk0UzVBVzdIb1RWTkhCTExRRHhuZ3VOblptNHJ0Y20rRlA4QVlaVEtl?=
 =?utf-8?B?em0yR1lXWXRKd3luZWNKVENjQ2x6Tldnemw2d3hzZzFFQVo3bGQvdHM1TmlM?=
 =?utf-8?B?WHdjWlVwelBGampmRS8rRzlEQkZTWW9TcU05WmdSVzNFeXpKd1hPUjR1RG1i?=
 =?utf-8?B?VnZpTlhtZ0dEeGhvV3pUNG1CZDUwOWRvV0JtMkd4eldQeGJaRkpmUkFJVks1?=
 =?utf-8?B?cVM1WENzM2hCM2JlQy9ONFhLMVFoUXBMdnBsakQ3RDMrNWZwdndvWWlYNFh5?=
 =?utf-8?B?clI2UVVGMTYwbUFyc3hJV1dLTGpYY3VsWHljWElJY0FYNkR5dU1hb25PNEdJ?=
 =?utf-8?B?MGJYZlVIZFdlVjMrK3B2YWc1eW5hWDBEdkx6NHFsM1lZdkNnR1docy9wUVNV?=
 =?utf-8?B?M01KcXNWdTgxVFpFbEtENWJjS2g2NThtdElITUplNXhJTFJodkJ5a1FRMHpK?=
 =?utf-8?B?aDJhZ0xrdEFLTnM4blhEeWVUMGFTV1pZaVdLZTRjL0JxMWxxRWVZME9hakxU?=
 =?utf-8?B?T1lZZlpCbHpIa1k1NUd5aEF2Qy9ycU5sRVhaRitXS285OGJEcE5WRFlncHVo?=
 =?utf-8?B?UjVoeW4rTGFOajFhcmFsbTdIbVJ1UFFuWFBWZHlJMVdpdDlCSk9Sd1B2RHpC?=
 =?utf-8?B?UGE2Qi9lNklQTDRHUDFnMG1zZ2dVQXg5Z3RTVFRKYkx2TmZpNzVuaE0yWUM1?=
 =?utf-8?B?dWkxTWd4SkV5V0dXV0hxM1FyOW1zaytGY3I1VDFNR1lPRzlSVXNkcWNJNDJR?=
 =?utf-8?B?bHZnRWRGc1hGVy9HY000aktwLzhPdmZ3eXlxelNxUm0yV0N3cUtCY1E5MmxP?=
 =?utf-8?B?eldMVy83cXYyMUg0SVdkakllTUhYekFTVWxNeGdXSGVYa0dEa1NVZmgvcXR5?=
 =?utf-8?B?ZmtkbFQ2cmdrOFBuRUgyZG9TQVhxdjhYbHgzN2h1UElURUVNRk9xZkJQM0Fk?=
 =?utf-8?B?dEl6dEgxT0VUVUFzN3RjUjZiQTd0SFVKRk9hczkrWHErR0hpU3dFbHI4bkJJ?=
 =?utf-8?B?Qy9jWHZrSFZvZHQ4WHZGbkpJdEphK3NGVFo5emhxbXliTFcrWjAvWU9yR0NO?=
 =?utf-8?B?ZjljWTd4RGROcG5XRmJXUGJVemg4MzJpMHVNdXVHVllLQ2VSdkRLNW5ETkdI?=
 =?utf-8?B?NHpEOGJWWDQrZEhaODdXV1o5ZGIyckxlUHBJY01YWWpzMFBjNFNEa2FZTEpU?=
 =?utf-8?B?WE1INk1EWFZ4VlN2QzJUenU2ZGlETXpnLzR6ZU1FSFNyVE5wb09iZ3l1NnRy?=
 =?utf-8?Q?o4mnvsxc8uubBfMTbpZhPCMJ/N4CsCserSILU+N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0NmVFNEdk1VZG1KRm84QXhEVnZYKzB2dFFhN3VtL3FFTzVnaitjVVFuYzh0?=
 =?utf-8?B?TDl6ZU1XemRoODlhcnA0c3EvTU9yTTYwOWJ2aGRXY2RWMU9hbllOV0hrWkFK?=
 =?utf-8?B?VGV6V0Z1Sng2TWt3Y0pmRjdDWkV5a3Y3ZEZCdFVIZ28rdENWcWtaY0hicVdG?=
 =?utf-8?B?dTc0d3JSVzZsU2FjNC90dm90a0tWdW1GaWhIak53NlZKQlFBTUFBbFpqZUVp?=
 =?utf-8?B?RjRwWmJ1VVpTQ1hNTHBXTHVMSVRwb29iMkhKRE56Qjlja3lHVmQ1RXV4YmRP?=
 =?utf-8?B?cUlHSGpyTmVHNHFnN3FuTEF1dHptbnVtU2Y4a2s4QXF2Zkw2b1U4dFV3U1ph?=
 =?utf-8?B?V2hIWU1PN2pmQ21lZ2dMQkN0ZkVLMFpYSzh4UGJzL1Z3SGp1dmhabThOKzBK?=
 =?utf-8?B?NEZIOWRNS3ptVFBMLzF2eTZXbzBnQ3RMMC9sbmtLbVJyUStrTEhXbE40M2Mv?=
 =?utf-8?B?OWZPUENab1hTVHpvbDlBaVBMVDNheU4yK0JuVTVJYkhBbTZkaGc5MERsYWpK?=
 =?utf-8?B?d2RlblVma1JuTlhYNnZxV2NtbXpFV1FqYnhlcHk1T0I3R3VJTk5KRGNHY0pp?=
 =?utf-8?B?b1lqbEJiNkdTVGR0Z0pOTVROQ3dIUHMvTTlZcjEyYXRNK0c0U3pSWUZhUUFE?=
 =?utf-8?B?K1liVDVRVEJBOTNGeEszN29WRGFkM1FYWC9WSmc5bUZDWTBwYUlpdUtCeUpP?=
 =?utf-8?B?K2VFZy9DWjdQTkJ5U2dCZ1RTZWUyUFh2eDdCL1dtNFFvVEdDTjhHejRLbUdK?=
 =?utf-8?B?cFQ3T2Iyd0Y0SE1mUlFZYTRWVStDbm5EQjB3Qnh5ekhBZWtyUGhMN0ZBaE1D?=
 =?utf-8?B?aFlFTjA0WS9PZlIwL3ZWZ0s3VnpWV0xkTnVIUjhzRkJKeldxYk5RSFRUWmJj?=
 =?utf-8?B?Z3NJZXVjRUlOQ1diWXZFRU9QNTg2VnFIWlJpU3c0NEV1bUpJNDRRcUZXbmFZ?=
 =?utf-8?B?aW5mVGlQZjIvR2VYbUgxdExoNFhvb2Y1cklIV3J0ZmpJTDdDaVNFTi9mQzlT?=
 =?utf-8?B?c1lwcTZvQTg5K09wOWpKaXFFemZzUWoyTmo4bTBkcnNMWkJhR2RqbVZGR0RX?=
 =?utf-8?B?aTd3N1E1cWFYaG54Q0Q2T081aFJNTTJjakltTlJHSWF5cU9BK1hKMmcwQzMy?=
 =?utf-8?B?UHNMdTVZaEJaa0xYNHl6ZEZGVU1mZlBGbEJzVzdIOCs0elFJQi9VWUxpWEIw?=
 =?utf-8?B?MkF5MlU3VjZlcHBxZVBWSjVQVGcrdGVKUlIvdjdIS25kMi9sYkNyZnl4NFRP?=
 =?utf-8?B?cS95RHdvQ0FsZi9yTCtMYUZrUGUxRElqd0xFcFF0bnNDdWdUcTVXdmxJNGE4?=
 =?utf-8?B?VGlkRloxU2pyblpxTEtGMzZLTUZYZEpDa0pmYVJENm5qdVJLWWR5NWIzenRR?=
 =?utf-8?B?cWp1RGExSGFDOUlQUXM4T1VkYzZrTi92MWl0bUpMZy9qVzQzOVVVbER6emhx?=
 =?utf-8?B?bm1ucXlOU05ZMS9UZVJLWXFaZ1hWcG1aNUI2NzhGQTlET0Q2ZUlBQVIrMmpm?=
 =?utf-8?B?OXV5SFNWY0I3N3BsME1WbktDSzNVMzRRV21WaFlZZUZsNUpXRWo2SU96MzJM?=
 =?utf-8?B?MEJSY1I4TmdNaXlZZkhsNjFxTTBPVitEMmhBQTJnL3Q3aVliVFNidHN0dEtP?=
 =?utf-8?B?STZYWGJUaW1pMjJyb2I2aTIxWWZvaHRiRy9wa2E0ZUNsQ1ZhaFVnRmNNUXhs?=
 =?utf-8?B?d05lT0lCNE1BaGNNZ3ZJOWRXVFJTeHdabEdmMmxvazMvWkhoclB5Z0pxb3lj?=
 =?utf-8?B?d1VVS3hZbHNFWERZWmIwcDdxK2FtNE42WGc1NkpBUnMxVU9pOHI3V3RENnpo?=
 =?utf-8?B?TDBERW9lWE9PMFcrcFgvUmxMV0lKY0RweXpLZHIwc3BWeXdjdUJNU0ZNbHhk?=
 =?utf-8?B?d05CSFNUdmpnWGc1NkhleWFtZ1d1a1FKcnY2dEw2OElmbjJyRnlyNllBc2pi?=
 =?utf-8?B?L1RlMjBuUFhOYVVGM0crbnlMeHBYamV6dEVvcEM1SjlGOFBQNEJLVUxQQytr?=
 =?utf-8?B?R0tlY0I1TnplZ2I0b213eXd6d0JNN2pUTVRSbEhIVis4Ymo2QmlXeU96OEs2?=
 =?utf-8?B?RlZocVZqVGlmUEtRdHRQT2M4L1JpVmZWUVN3WHhJYUhuK2ZUNzhnN1JBTUNL?=
 =?utf-8?Q?A0u78sya6yGn9mh7epZPyB6gX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab18aac3-bb76-4414-cdbf-08dd049c222f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 11:04:39.5455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tcNJj2cSnPaWBxoc8YplP2XV6mfy5laUx5+7UPnBKgP5cXqKe3YNUYdfgURQ0FTwAQMoHXgT+04rvAJwfVfCEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8602



On 11/14/2024 13:26, Alexandre Belloni wrote:
> On 14/11/2024 10:03:13+0530, Shyam Sundar S K wrote:
>>
>>
>> On 11/13/2024 19:51, Heikki Krogerus wrote:
>>> Hi,
>>>
>>> On Fri, Nov 08, 2024 at 01:03:20PM +0530, Shyam Sundar S K wrote:
>>>> As of now, the I3C subsystem only has ARM-specific initialization, and
>>>> there is no corresponding ACPI plumbing present. To address this, ACPI
>>>> support needs to be added to both the I3C core and DW driver.
>>>>
>>>> Add support to get the ACPI handle from the _HID probed and parse the apci
>>>> object to retrieve the slave information from BIOS.
>>>>
>>>> Based on the acpi object information propogated via BIOS, build the i3c
>>>> board information so that the same information can be used across the
>>>> driver to handle the slave requests.
>>>>
>>>> Co-developed-by: Sanket Goswami <Sanket.Goswami@amd.com>
>>>> Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
>>>> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>>>> ---
>>>> Cc: linux-acpi@vger.kernel.org
>>>>
>>>>  drivers/i3c/internals.h            |  3 ++
>>>>  drivers/i3c/master.c               | 84 ++++++++++++++++++++++++++++++
>>>>  drivers/i3c/master/dw-i3c-master.c |  7 +++
>>>>  include/linux/i3c/master.h         |  1 +
>>>>  4 files changed, 95 insertions(+)
>>>>
>>>> diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
>>>> index 433f6088b7ce..178bc0ebe6b6 100644
>>>> --- a/drivers/i3c/internals.h
>>>> +++ b/drivers/i3c/internals.h
>>>> @@ -10,6 +10,9 @@
>>>>  
>>>>  #include <linux/i3c/master.h>
>>>>  
>>>> +#define I3C_GET_PID		0x08
>>>> +#define I3C_GET_ADDR		0x7F
>>>> +
>>>>  void i3c_bus_normaluse_lock(struct i3c_bus *bus);
>>>>  void i3c_bus_normaluse_unlock(struct i3c_bus *bus);
>>>>  
>>>> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
>>>> index 6f3eb710a75d..0ceef2aa9161 100644
>>>> --- a/drivers/i3c/master.c
>>>> +++ b/drivers/i3c/master.c
>>>> @@ -2251,6 +2251,84 @@ static int of_i3c_master_add_dev(struct i3c_master_controller *master,
>>>>  	return ret;
>>>>  }
>>>>  
>>>> +#if IS_ENABLED(CONFIG_ACPI)
>>>> +static int i3c_acpi_configure_master(struct i3c_master_controller *master)
>>>> +{
>>>> +	struct acpi_buffer buf = {ACPI_ALLOCATE_BUFFER, NULL};
>>>> +	enum i3c_addr_slot_status addrstatus;
>>>> +	struct i3c_dev_boardinfo *boardinfo;
>>>> +	struct device *dev = &master->dev;
>>>> +	struct fwnode_handle *fwnode;
>>>> +	struct acpi_device *adev;
>>>> +	u32 slv_addr, num_dev;
>>>> +	acpi_status status;
>>>> +	u64 val;
>>>> +
>>>> +	status = acpi_evaluate_object_typed(master->ahandle, "_DSD", NULL, &buf, ACPI_TYPE_PACKAGE);
>>>> +	if (ACPI_FAILURE(status)) {
>>>> +		dev_err(&master->dev, "Error reading _DSD:%s\n", acpi_format_exception(status));
>>>> +		return -ENODEV;
>>>> +	}
>>>
>>> Why do you need to do that?
>>>
>>>> +	num_dev = device_get_child_node_count(dev);
>>>> +	if (!num_dev) {
>>>> +		dev_err(&master->dev, "Error: no child node present\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>
>>> I think Jarkko already pointed out the problem with that. The whole
>>> check should be dropped.
>>>
>>>> +	device_for_each_child_node(dev, fwnode) {
>>>> +		adev = to_acpi_device_node(fwnode);
>>>> +		if (!adev)
>>>> +			return -ENODEV;
>>>> +
>>>> +		status = acpi_evaluate_integer(adev->handle, "_ADR", NULL, &val);
>>>> +		if (ACPI_FAILURE(status)) {
>>>> +			dev_err(&master->dev, "Error: eval _ADR failed\n");
>>>> +			return -EINVAL;
>>>> +		}
>>>
>>> val = acpi_device_adr(adev);
>>>
>>>> +		slv_addr = val & I3C_GET_ADDR;
>>>> +
>>>> +		boardinfo = devm_kzalloc(dev, sizeof(*boardinfo), GFP_KERNEL);
>>>> +		if (!boardinfo)
>>>> +			return -ENOMEM;
>>>> +
>>>> +		if (slv_addr) {
>>>> +			if (slv_addr > I3C_MAX_ADDR)
>>>> +				return -EINVAL;
>>>> +
>>>> +			addrstatus = i3c_bus_get_addr_slot_status(&master->bus, slv_addr);
>>>> +			if (addrstatus != I3C_ADDR_SLOT_FREE)
>>>> +				return -EINVAL;
>>>> +		}
>>>> +
>>>> +		boardinfo->static_addr = slv_addr;
>>>> +		if (boardinfo->static_addr > I3C_MAX_ADDR)
>>>> +			return -EINVAL;
>>>> +
>>>> +		addrstatus = i3c_bus_get_addr_slot_status(&master->bus,	boardinfo->static_addr);
>>>> +		if (addrstatus != I3C_ADDR_SLOT_FREE)
>>>> +			return -EINVAL;
>>>> +
>>>> +		boardinfo->pid = val >> I3C_GET_PID;
>>>> +		if ((boardinfo->pid & GENMASK_ULL(63, 48)) ||
>>>> +		    I3C_PID_RND_LOWER_32BITS(boardinfo->pid))
>>>> +			return -EINVAL;
>>>> +
>>>> +		/*
>>>> +		 * According to the specification, SETDASA is not supported for DIMM slaves
>>>> +		 * during device discovery. Therefore, BIOS will populate same initial
>>>> +		 * dynamic address as the static address.
>>>> +		 */
>>>> +		boardinfo->init_dyn_addr = boardinfo->static_addr;
>>>> +		list_add_tail(&boardinfo->node, &master->boardinfo.i3c);
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +#else
>>>> +static int i3c_acpi_configure_master(struct i3c_master_controller *master) { return 0; }
>>>> +#endif
>>>
>>> I think this code should be placed into a separate file.
>>>
>>> If the goal is to add ACPI support for code that is written for DT
>>> only, then I think the first thing to do before that really should be
>>> to convert the existing code to use the unified device property
>>> interface, and move all the DT-only parts to a separate file(s).
>>>
>>
>> Thank you Jarkko and Heikki. Let me work and these remarks and come
>> back with a new version.
>>
>> Jarkko, will you be able to pick 1/5 and 5/5 without a separate series
>> or do you want me to send one?
> 
> Please send a new series.

OK. I am spinning out two based on feedback received.

Thanks,
Shyam

