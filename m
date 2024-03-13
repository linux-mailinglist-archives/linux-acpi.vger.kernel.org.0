Return-Path: <linux-acpi+bounces-4314-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A93087A837
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Mar 2024 14:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0271F23627
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Mar 2024 13:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999283B798;
	Wed, 13 Mar 2024 13:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XfA93gWy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3366D3FE58;
	Wed, 13 Mar 2024 13:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710336262; cv=fail; b=ibIcJ3zMcetRdPnTKK/BDeL8Y1CChT/92Fxv/6werkqXvWyt6uuTdotrVzRsr9gomyHgQ1sJWgDWgoP9rpDC2kDIyfx1YXuDNuG2me+35uzZKugCy3eqfN+s9MgLHr45/rB9vgSRNcyCQFTXMU6IYWi1eSxkxJqdambZ3YbklnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710336262; c=relaxed/simple;
	bh=2bsY1s4YktYXKG7LuuYN3jkngdE5b53dMbffr3M353E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lfaxtXNDFYqoRndGmMSm5fUS0UvJVObF6TVMnMfBBGZ1mRwWoV0It1mVkhMs5DzNxtJZYbFxM4ZBxY7/0kc1ELlrMyGtBql8AEjx1yTrpU2a9qg00kvaoLd9Ske8kyK9VnIRcnmCKVfPeeC8lYhw4XMzTF7dU7ZqiHtJuEc/J7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XfA93gWy; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kr5rHLhKegQTjZZaTRCVMrKa0t2z1EPLJc3KIITP6L+fsCM6MJfii+LzaHQSt5HIwir5Dv78H+eOe8VbB5YVtxYDLFY+OcOaEmQpiYbmRKrnqzwfmCJvMHs76I1sZkKRGVcuIiZdLG12LAIrtjb2E5ztaoAP5WU+xUthWDhokH88vShp+TwTEtxbP3WY+7cxMGxgZPRN00SmdrFxVIIGT89D8V1EO8bDCXUhz6pS1Jdv+0WI5RUPXwE9RL3pltp0UrnCrwpXvQgLopFs2445SISu8eXh5fKoBC+7aiMQH99ZYbE3JZut6YlWN3yZy8epDL2ltUAu4i7aleB3GliqDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbUGhI7MbAc+L1ajytT4wty1vLe97BSdCc5zT27QfeE=;
 b=AIrHx1x2a3iWOWfVoNc8QSYFL3c1O0aTNJsHHAD/ypHFNQtuD3RZ5zwPZvz1Qk7pSwY9H1Ec9WYBiMZUziVM7gapQ4I4f2PDX96qMiIzAxOUhVRwHgd4ZAzEcU1TjMsdAs+MHWQXtiQ7tI95tqxqe+/ZdgXiqpfbcNU1JVsOqPFYbRZzDNha6T1iXYCotOVeJNyaQpTS3ZsGCimrGnq6iB1/Y6xiMX4iwpKIH0FVPQSC0nFoAIUjrUxByDu0UV6PReX9KoIEnyPLCPv3dFO0cDRt3E7hvVKx2AvFhrn/WMsW/huRMtGZN0La/fKEUtHyho2Zj7gR6cCr8kp2fDQIZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbUGhI7MbAc+L1ajytT4wty1vLe97BSdCc5zT27QfeE=;
 b=XfA93gWymnuO/fpfvS7hQtEnNe0OX0/W/lkxRFsgXAWiKnSIdadHybZlRMHQHFG0X2BwtXapNGnbPGfvf4CpRWVlNVoRZRo5AqsIjAzNz9ulhEWpAeZhAn6JAdGrrq50wYnEpjO28wi5E3fcN+RN9MxbtFj5o0CctYJPTlj3v+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by BL1PR12MB5777.namprd12.prod.outlook.com (2603:10b6:208:390::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Wed, 13 Mar
 2024 13:24:15 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::5302:26cf:a913:7e06]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::5302:26cf:a913:7e06%5]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 13:24:14 +0000
Message-ID: <5dd9cf4a-decd-42a0-b6bf-2456a8efee99@amd.com>
Date: Wed, 13 Mar 2024 08:24:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 2/4] EINJ: Add CXL error type support
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, jonathan.cameron@huawei.com,
 rafael@kernel.org, james.morse@arm.com, tony.luck@intel.com, bp@alien8.de
Cc: dave@stogolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20240311142508.31717-1-Benjamin.Cheatham@amd.com>
 <20240311142508.31717-3-Benjamin.Cheatham@amd.com>
 <65f13f8f15389_a9b42944a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <65f13f8f15389_a9b42944a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::33) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|BL1PR12MB5777:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b037e08-3d3b-4f8f-83d9-08dc4360e088
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KxfoGWZKmXeuVb6vymktdPNEnrBDanSJeg0k2dYBcwTW+Ly7PxguAdTj+aRogc+TKErMjY8eWzpX8B7CRpdKqdjObAHnQCoRbfsVHoqa76E5w+o1YUKpYDv5VuFI7+fmB0btgPexw/ns/l+C1+FR1rbN8IQYVO51tQdwdRTqvcwNyWP/h1giMod9ZBHNvFZv7K3uwumwVQUgKGw0YaWnJ8YT3yhQ8IDpJcT6WsIEExxnQSzhkOLqLYaOJlSvoU9Twj0uLx8bZpwAHLMINj9zyX/c4HB3AZY8MtGiU5OKgEZB1P5br1U2Jh3wg0oTVu6T1i6J4muqKXT0N1xM0xxlneRvBeKBIrTvgBY3BqkXsJ1x9m6a0Oba1rbOq27jzuXXNVXekZeiS03TJYMLWni8EW4S+2A5bWTHLKsqkfUDvgahtOUJT/uPov37L1klJO7ye1fqsBgAJKm6e2Ee+hRt428shJelIcC1/v1nrTESwzg+KCaNZM2vMfRImwGx19cxQyj19BuLgfIpuWEWEvbuqvFndy13cty4d/OHHhz6NZcu7JgURXr0tJGMbMp/kSgCWOUb0kFR6Pf0r9u9GXm5cmW42PEasU4L+Fp7B+Flejvi4FA+q1P0p4NCXOXUAOA+SbbC6fzYSfAjE+ctu9Xak0phvSamdLFoUFPYoL2Jg0o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVord3JBWm9OL3lKQjVCRno5ellwU2dQZDl5WmdCUURnVDVJUmR3TFNIWCtE?=
 =?utf-8?B?UmlYN2hvWndPUWYvTkIxSWZPK3pGK1dHdEdxaHl6ZW9qalk4c2szdHVEV0hm?=
 =?utf-8?B?d0VQVzZobm9vdzVydzFubFUyVXE0MlNMRHM3WklCM0Zvd0tNRXQ4MnZWODRS?=
 =?utf-8?B?eGpMWmxSUTBnT01SOEI0S1hTbk9vT1p2K0ZhOUlSSEN0Vmt1ZmRLL0hkcUhR?=
 =?utf-8?B?bUljOGh4L1I0U1NiYUcwY3lXSGNuc0F3UGRvcStDZFNlUkxlc1k0YWhkWVBw?=
 =?utf-8?B?SHFpVElrVnFSZTl1eUFYT3hMWW5QdEFJbFFxMFlVdFV4NHczWE42ZlN3M0tM?=
 =?utf-8?B?QWw2WTNrZmxyYzZKM3U1R3o1cWdEa0c1a0dUM1VSTmxYUWd5aEY3NFNpc1h6?=
 =?utf-8?B?TjVnZnprNklBMlB1S1lRYkdodkxRNjlaQWlMZlA4cVJpYXZEL25JYnBHOG00?=
 =?utf-8?B?L1BLRWwraFhvUER4QVgwR3Rjem1oSjEybmg0S0xrNlBCeTJxenlON1puUnAy?=
 =?utf-8?B?ckJnRWxrN2YzZ01obXdobmZNVmowSGdmMmh2QjM4TWFSVkF2SkZhREEwR1g4?=
 =?utf-8?B?Y0tVL3dGMTNqNm91dm1ISlAzZFFWVzdQUHkzZi9PR3I3OFp2WGptYmtzUjBn?=
 =?utf-8?B?OTV1RGJKS0QyMnUveWpydEhJQ1pZUTltOGtYMituTHh1YjE3VmxyWUxBcy9T?=
 =?utf-8?B?ak44ckFna0xpVHVRYnVRRmdJMStLRXJPY1FCclNDTU5HSjZ5b043R0w3Y2o4?=
 =?utf-8?B?eWNrMW8zZW9nS3lRS1h6eTRPcXgwdHJpVHo5RTl3ZFFsM1gzRThrL1U3WE9m?=
 =?utf-8?B?MitDK2JPZHBTT2ljR0VOb0dmbnNuNEQxNDFiRHNaUnAyenFuSUVFMkRKRHhw?=
 =?utf-8?B?LzBUR05ZNExUczBHMUxwOFB5ZFdXd0p1R0Y2bHdJcDRDNFc2VXpJVDhaMmJQ?=
 =?utf-8?B?OVorRWhraFRIQUlMWHkveU9PMlZIamxmbHdmR0c3bEp5SGtOUWpLN0JrSHV1?=
 =?utf-8?B?cko2ejZka1ROdFZNSURJMUNxVUxwTjAzNkxsajNOejdLSjd2SjgwcUpOU3A1?=
 =?utf-8?B?cDlpY2I2dEtWYXVsd1BZbklBZE45cE82bDFxV25HUFJEMFRHZ0FWM0VUSGFy?=
 =?utf-8?B?UVFIK3U4VmlSL3NRWWk0UXBMYnVxTDJhSUpBcjByM2xuaTA2TTU1b2lxZEds?=
 =?utf-8?B?VjV0M2VvTWhpSW9NOFpyVHN4U0U1Z0kvU1p6cmRyVjBpcTNMY1QrY2JOVVZL?=
 =?utf-8?B?WEVJMFFuSzlRb0FZckZjZm03aEw3c3hoVExRZkZhN0VpZ1JsT0I0QVN4WXFE?=
 =?utf-8?B?N3NQWit0U2t5UjB1NDIwNVc0MStQaHl5OWpSajFlZ2U3T0UrTlY2UHpVUWF3?=
 =?utf-8?B?cmpiY1Zxd2tMT1lqelNJSVBydVYwY0FxeGZvcWJ4ZlZVNXgzQjI4WlNKYmlv?=
 =?utf-8?B?MVdiSzFpanVCcmRtWERCTVRXZE1Nc3p3cHRqVWZtVlJTeEZDOWpYVFZSbWo1?=
 =?utf-8?B?SFJiUWNyYStKV05ubHU1eHlSbk5kRXdmU2tiN2J6dE9FM2FmVFkwOHBpSnpy?=
 =?utf-8?B?dmxURXVYRGlYYlZEUEF3VU5lei9sNlZadHBiTTduc1JyNktQT0ExMkUvdEE1?=
 =?utf-8?B?L2lzNWhMUFBqVWl2RStSbjZaMlE5anQwbGlPTjI3WWtmNUlmbEVSaDJOYURW?=
 =?utf-8?B?SHB5TWNlNTF2b0pCdW5nbmZwNjFWWVBqckRId1V4UmVKS3BaZFhrUlYzL0hn?=
 =?utf-8?B?eEtYNFhGL05qTlVXSGJXa1kwNnFhSTdVMGY2Ykk4OG9EYlB6akJNZXVEdzZP?=
 =?utf-8?B?MDJGVDRJUm8zWnpWWFVYRU9FN3dQQTV4VkxiMDZ2bm44SHV5T2s5ejRmc0Q3?=
 =?utf-8?B?dEhpVFpxS1ZJbGY3OFdRSTJZSXVaMFN6VjBnTjVKTkE4c3FKeVpDZTVUQnBB?=
 =?utf-8?B?citETXRUT2E1MUM2QlZVVUEvQko5cVF6NENkSlJEdjJEeHFDMHNwZC9JSGIw?=
 =?utf-8?B?b0hYUVpBSU1tUkwxOGdmK3JJU1BSVVJRM3RqNDB4M2sxajh4NEQ2M2hnc1E3?=
 =?utf-8?B?TXBoL0tXeGlEbEdvdVlVaE4vWGovWEkxeGZwZ21sdzVVWFlFUVZkM054RkxV?=
 =?utf-8?Q?j0S6UXNpn9qXiPPfSG5jDXdyx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b037e08-3d3b-4f8f-83d9-08dc4360e088
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 13:24:14.4893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sHAkU2wbejv0y46Dctd9iCfOwAr2DXeYaiVlx7g/JzfzIWu/RWCXf3qIuFlMOcUlgOo/cfTg6DMKHEfU2v9WpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5777



On 3/13/24 12:54 AM, Dan Williams wrote:
> Ben Cheatham wrote:
>> Move CXL protocol error types from einj.c (now einj-core.c) to einj-cxl.c.
>> einj-cxl.c implements the necessary handling for CXL protocol error
>> injection and exposes an API for the CXL core to use said functionality,
>> while also allowing the EINJ module to be built without CXL support.
>> Because CXL error types targeting CXL 1.0/1.1 ports require special
>> handling, only allow them to be injected through the new cxl debugfs
>> interface (next commit) and return an error when attempting to inject
>> through the legacy interface.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
>> ---
>>  MAINTAINERS                               |   1 +
>>  drivers/acpi/apei/Kconfig                 |  12 +++
>>  drivers/acpi/apei/Makefile                |   2 +
>>  drivers/acpi/apei/apei-internal.h         |  18 ++++
>>  drivers/acpi/apei/{einj.c => einj-core.c} |  77 ++++++++++----
>>  drivers/acpi/apei/einj-cxl.c              | 116 ++++++++++++++++++++++
>>  include/linux/einj-cxl.h                  |  44 ++++++++
>>  7 files changed, 252 insertions(+), 18 deletions(-)
>>  rename drivers/acpi/apei/{einj.c => einj-core.c} (93%)
>>  create mode 100644 drivers/acpi/apei/einj-cxl.c
>>  create mode 100644 include/linux/einj-cxl.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 2ecaaec6a6bf..90cf8403dd17 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -5289,6 +5289,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
>>  L:	linux-cxl@vger.kernel.org
>>  S:	Maintained
>>  F:	drivers/cxl/
>> +F:	include/linux/cxl-einj.h
>>  F:	include/linux/cxl-event.h
>>  F:	include/uapi/linux/cxl_mem.h
>>  F:	tools/testing/cxl/
>> diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
>> index 6b18f8bc7be3..f01afa2805be 100644
>> --- a/drivers/acpi/apei/Kconfig
>> +++ b/drivers/acpi/apei/Kconfig
>> @@ -60,6 +60,18 @@ config ACPI_APEI_EINJ
>>  	  mainly used for debugging and testing the other parts of
>>  	  APEI and some other RAS features.
>>  
>> +config ACPI_APEI_EINJ_CXL
>> +	bool "CXL Error INJection Support"
>> +	default ACPI_APEI_EINJ
>> +	depends on ACPI_APEI_EINJ && CXL_BUS <= ACPI_APEI_EINJ
>> +	help
>> +	  Support for CXL protocol Error INJection through debugfs/cxl.
>> +	  Availability and which errors are supported is dependent on
>> +	  the host platform. Look to ACPI v6.5 section 18.6.4 and kernel
>> +	  EINJ documentation for more information.
>> +
>> +	  If unsure say 'n'
>> +
>>  config ACPI_APEI_ERST_DEBUG
>>  	tristate "APEI Error Record Serialization Table (ERST) Debug Support"
>>  	depends on ACPI_APEI
>> diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
>> index 4dfac2128737..2c474e6477e1 100644
>> --- a/drivers/acpi/apei/Makefile
>> +++ b/drivers/acpi/apei/Makefile
>> @@ -2,6 +2,8 @@
>>  obj-$(CONFIG_ACPI_APEI)		+= apei.o
>>  obj-$(CONFIG_ACPI_APEI_GHES)	+= ghes.o
>>  obj-$(CONFIG_ACPI_APEI_EINJ)	+= einj.o
>> +einj-y				:= einj-core.o
>> +einj-$(CONFIG_ACPI_APEI_EINJ_CXL) += einj-cxl.o
>>  obj-$(CONFIG_ACPI_APEI_ERST_DEBUG) += erst-dbg.o
>>  
>>  apei-y := apei-base.o hest.o erst.o bert.o
>> diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
>> index 67c2c3b959e1..cd2766c69d78 100644
>> --- a/drivers/acpi/apei/apei-internal.h
>> +++ b/drivers/acpi/apei/apei-internal.h
>> @@ -130,4 +130,22 @@ static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
>>  }
>>  
>>  int apei_osc_setup(void);
>> +
>> +int einj_get_available_error_type(u32 *type);
>> +int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
>> +		      u64 param4);
>> +int einj_cxl_rch_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>> +			      u64 param3, u64 param4);
>> +bool einj_is_cxl_error_type(u64 type);
>> +int einj_validate_error_type(u64 type);
>> +
>> +#ifndef ACPI_EINJ_CXL_CACHE_CORRECTABLE
>> +#define ACPI_EINJ_CXL_CACHE_CORRECTABLE     BIT(12)
>> +#define ACPI_EINJ_CXL_CACHE_UNCORRECTABLE   BIT(13)
>> +#define ACPI_EINJ_CXL_CACHE_FATAL           BIT(14)
>> +#define ACPI_EINJ_CXL_MEM_CORRECTABLE       BIT(15)
>> +#define ACPI_EINJ_CXL_MEM_UNCORRECTABLE     BIT(16)
>> +#define ACPI_EINJ_CXL_MEM_FATAL             BIT(17)
>> +#endif
>> +
>>  #endif
>> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj-core.c
>> similarity index 93%
>> rename from drivers/acpi/apei/einj.c
>> rename to drivers/acpi/apei/einj-core.c
>> index 937c69844dac..9affbe807ded 100644
>> --- a/drivers/acpi/apei/einj.c
>> +++ b/drivers/acpi/apei/einj-core.c
>> @@ -37,6 +37,12 @@
>>  #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
>>  				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
>>  				ACPI_EINJ_MEMORY_FATAL)
>> +#define CXL_ERROR_MASK		(ACPI_EINJ_CXL_CACHE_CORRECTABLE | \
>> +				ACPI_EINJ_CXL_CACHE_UNCORRECTABLE | \
>> +				ACPI_EINJ_CXL_CACHE_FATAL | \
>> +				ACPI_EINJ_CXL_MEM_CORRECTABLE | \
>> +				ACPI_EINJ_CXL_MEM_UNCORRECTABLE | \
>> +				ACPI_EINJ_CXL_MEM_FATAL)
>>  
>>  /*
>>   * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
>> @@ -141,7 +147,7 @@ static DEFINE_MUTEX(einj_mutex);
>>  /*
>>   * Exported APIs use this flag to exit early if einj_probe() failed.
>>   */
>> -static bool einj_initialized __ro_after_init;
>> +bool einj_initialized __ro_after_init;
>>  
>>  static void *einj_param;
>>  
>> @@ -166,7 +172,7 @@ static int __einj_get_available_error_type(u32 *type)
>>  }
>>  
>>  /* Get error injection capabilities of the platform */
>> -static int einj_get_available_error_type(u32 *type)
>> +int einj_get_available_error_type(u32 *type)
>>  {
>>  	int rc;
>>  
>> @@ -536,8 +542,8 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>>  }
>>  
>>  /* Inject the specified hardware error */
>> -static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>> -			     u64 param3, u64 param4)
>> +int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
>> +		      u64 param4)
>>  {
>>  	int rc;
>>  	u64 base_addr, size;
>> @@ -560,8 +566,18 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>>  	if (type & ACPI5_VENDOR_BIT) {
>>  		if (vendor_flags != SETWA_FLAGS_MEM)
>>  			goto inject;
>> -	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM))
>> +	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)) {
>>  		goto inject;
>> +	}
>> +
>> +	/*
>> +	 * Injections targeting a CXL 1.0/1.1 port have to be injected
>> +	 * via the einj_cxl_rch_error_inject() path as that does the proper
>> +	 * validation of the given RCRB base (MMIO) address.
>> +	 */
>> +	if (einj_is_cxl_error_type(type) && (flags & SETWA_FLAGS_MEM)) {
>> +		return -EINVAL;
>> +	}
>>  
>>  	/*
>>  	 * Disallow crazy address masks that give BIOS leeway to pick
>> @@ -593,6 +609,21 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>>  	return rc;
>>  }
>>  
>> +int einj_cxl_rch_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>> +			      u64 param3, u64 param4)
>> +{
>> +	int rc;
>> +
>> +	if (!(einj_is_cxl_error_type(type) && (flags & SETWA_FLAGS_MEM)))
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&einj_mutex);
>> +	rc = __einj_error_inject(type, flags, param1, param2, param3, param4);
>> +	mutex_unlock(&einj_mutex);
>> +
>> +	return rc;
>> +}
>> +
>>  static u32 error_type;
>>  static u32 error_flags;
>>  static u64 error_param1;
>> @@ -613,12 +644,6 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
>>  	{ BIT(9), "Platform Correctable" },
>>  	{ BIT(10), "Platform Uncorrectable non-fatal" },
>>  	{ BIT(11), "Platform Uncorrectable fatal"},
>> -	{ BIT(12), "CXL.cache Protocol Correctable" },
>> -	{ BIT(13), "CXL.cache Protocol Uncorrectable non-fatal" },
>> -	{ BIT(14), "CXL.cache Protocol Uncorrectable fatal" },
>> -	{ BIT(15), "CXL.mem Protocol Correctable" },
>> -	{ BIT(16), "CXL.mem Protocol Uncorrectable non-fatal" },
>> -	{ BIT(17), "CXL.mem Protocol Uncorrectable fatal" },
>>  	{ BIT(31), "Vendor Defined Error Types" },
>>  };
>>  
>> @@ -647,22 +672,26 @@ static int error_type_get(void *data, u64 *val)
>>  	return 0;
>>  }
>>  
>> -static int error_type_set(void *data, u64 val)
>> +bool einj_is_cxl_error_type(u64 type)
>> +{
>> +	return (type & CXL_ERROR_MASK) && (!(type & ACPI5_VENDOR_BIT));
>> +}
>> +
>> +int einj_validate_error_type(u64 type)
>>  {
>> +	u32 tval, vendor, available_error_type = 0;
>>  	int rc;
>> -	u32 available_error_type = 0;
>> -	u32 tval, vendor;
>>  
>>  	/* Only low 32 bits for error type are valid */
>> -	if (val & GENMASK_ULL(63, 32))
>> +	if (type & GENMASK_ULL(63, 32))
>>  		return -EINVAL;
>>  
>>  	/*
>>  	 * Vendor defined types have 0x80000000 bit set, and
>>  	 * are not enumerated by ACPI_EINJ_GET_ERROR_TYPE
>>  	 */
>> -	vendor = val & ACPI5_VENDOR_BIT;
>> -	tval = val & 0x7fffffff;
>> +	vendor = type & ACPI5_VENDOR_BIT;
>> +	tval = type & GENMASK(30, 0);
>>  
>>  	/* Only one error type can be specified */
>>  	if (tval & (tval - 1))
>> @@ -671,9 +700,21 @@ static int error_type_set(void *data, u64 val)
>>  		rc = einj_get_available_error_type(&available_error_type);
>>  		if (rc)
>>  			return rc;
>> -		if (!(val & available_error_type))
>> +		if (!(type & available_error_type))
>>  			return -EINVAL;
>>  	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int error_type_set(void *data, u64 val)
>> +{
>> +	int rc;
>> +
>> +	rc = einj_validate_error_type(val);
>> +	if (rc)
>> +		return rc;
>> +
>>  	error_type = val;
>>  
>>  	return 0;
>> diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
>> new file mode 100644
>> index 000000000000..bde7e20c7fbb
>> --- /dev/null
>> +++ b/drivers/acpi/apei/einj-cxl.c
>> @@ -0,0 +1,116 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * CXL Error INJection support. Used by CXL core to inject
>> + * protocol errors into CXL ports.
>> + *
>> + * Copyright (C) 2023 Advanced Micro Devices, Inc.
>> + *
>> + * Author: Ben Cheatham <benjamin.cheatham@amd.com>
>> + */
>> +#include <linux/einj-cxl.h>
>> +#include <linux/seq_file.h>
>> +#include <linux/pci.h>
>> +
>> +#include "apei-internal.h"
>> +
>> +/* Defined in einj-core.c */
>> +extern bool einj_initialized;
>> +
>> +static struct { u32 mask; const char *str; } const einj_cxl_error_type_string[] = {
>> +	{ ACPI_EINJ_CXL_CACHE_CORRECTABLE, "CXL.cache Protocol Correctable" },
>> +	{ ACPI_EINJ_CXL_CACHE_UNCORRECTABLE, "CXL.cache Protocol Uncorrectable non-fatal" },
>> +	{ ACPI_EINJ_CXL_CACHE_FATAL, "CXL.cache Protocol Uncorrectable fatal" },
>> +	{ ACPI_EINJ_CXL_MEM_CORRECTABLE, "CXL.mem Protocol Correctable" },
>> +	{ ACPI_EINJ_CXL_MEM_UNCORRECTABLE, "CXL.mem Protocol Uncorrectable non-fatal" },
>> +	{ ACPI_EINJ_CXL_MEM_FATAL, "CXL.mem Protocol Uncorrectable fatal" },
>> +};
>> +
>> +int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
>> +{
>> +	int cxl_err, rc;
>> +	u32 available_error_type = 0;
>> +
>> +	if (!einj_initialized)
>> +		return -ENXIO;
> 
> One of the unnecessary einj_initialized checks leaked through...
> removed it on applying.

Sorry about that, no clue how I didn't see that one.

