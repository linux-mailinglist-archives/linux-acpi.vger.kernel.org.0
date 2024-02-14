Return-Path: <linux-acpi+bounces-3482-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4A1854ED1
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Feb 2024 17:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 943421F25073
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Feb 2024 16:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A878604BD;
	Wed, 14 Feb 2024 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VOhVz6rW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA5260269;
	Wed, 14 Feb 2024 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928871; cv=fail; b=JphNJGjusauniesDirgNs6Vcv3VsKAIk7KYQVxX1qeE2iNSqURPa728fNlHdLkKJPyq7/qzyrQSPl0oPkp1pJiNYdcn4L9i+lYs11AJLXm8nV6qaddiY/DkzcfNTU36HuF2cJWIC6JASHB1/0dVCjFRJ+v94rZ+dkNYAj66OrMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928871; c=relaxed/simple;
	bh=hQmkGm0AMD/EG2sawovCAwzQ3JUrIua0p7gW9wfg32Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RMUR8f95WO9HGsZZjFSWtETX1tpsngPF7I6DUbDun4plYN2APelKMIG9HTVHtnknE3MRsRGvtk1FZqeH6XGeFgtbVJZKZHaClQpaXWcQgVF8zZ5UYjjHBfj/9vellevurH+bbCffWrrpEP/k3Eqce8RLLrYLv6oWtg83NIHmxrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VOhVz6rW; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFKUYaigEPExbqDGUBxEUxaq78NHAeyMKNlfJkOgN8NXwDk7ysiURTN2NtcNO8Pmzd07+3j2oJ1U/hlOLXGHs75lMND0oEA/2pb9EcpSu8dclMdM8RCRmQpnpRAy+6GQKg4L/UBFyF6ZFzlQEtl1NVGJUDzcFoi1cOZCp1oFXuMe8+6tmV4eOPu9tt7b0tjoQQOSR/419Q2Wb72IcvjVxfUaoHjJDqcaohETk9x9E9GGdbvSrSWNSB9CSmtz6BeIDSdLjV8UOSWfICQtTi5ouJOeJI2pFyHilfas3vCEobStpFD/NWOmMjMxKK3dsw4pHqxSxI1qRrIhBl+ClUgxcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQW7X3kYOqyhgmYRUFWZ3iG+4P8dbnae9h39xVvWYNo=;
 b=LyN9syD+LlrrvcqDhm5A+U9wyGmRJRe6sPO8d9OxCKos7FQgsR5Xvi7BBaIWuueNBW9kt+it4pe48+b1KCNGEjsd9uYI3D4j5MSI5dfNtCAW3ja+9evSYCBuUfICUmzgo1sCjBuTqmvYrO7CfyNgnZ2Hx5hr18IypniRFdlwtjvBoyBd5YBGANhYPcgElxXlKQF2C99MbuKfw6D3EpXMk3bs3YFYGySwiRDvBWkoviLy/VgxLFmknBgRuF6c4Qj6pJXNqkfycvaLRQne0XMltK4FyAyUvbvWghgSf7mEMJfe0hnjNcIwn8BHfsm6Ubpd/Bqmf5F3op/bd2+6nDxM4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQW7X3kYOqyhgmYRUFWZ3iG+4P8dbnae9h39xVvWYNo=;
 b=VOhVz6rWgnNJDy79zHMS/tbcFFOQLIL3G8JYpHvY0upopBi5KODL/0He9Nz4vlzU5AeWBvQacUGEka7pk/z3A+xTIbl3KIF/W66/FQHHC5gEGoluh8rL9WAv76ofONhuuA7zRo3lDKLUOV8WyhHk9V9e/2gFQ5uJL7RBbIcf8AI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by LV3PR12MB9187.namprd12.prod.outlook.com (2603:10b6:408:194::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 16:41:06 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::b21f:aced:8bae:a73d]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::b21f:aced:8bae:a73d%7]) with mapi id 15.20.7292.018; Wed, 14 Feb 2024
 16:41:06 +0000
Message-ID: <dd996549-dd52-4181-ba62-a1a8a2a18a35@amd.com>
Date: Wed, 14 Feb 2024 10:41:00 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/4] cxl/core, EINJ: Add EINJ CXL debugfs files and
 EINJ helper functions
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: dan.j.williams@intel.com, dave@stogolabs.net, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 rafael@kernel.org, linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20240208200042.432958-1-Benjamin.Cheatham@amd.com>
 <20240208200042.432958-4-Benjamin.Cheatham@amd.com>
 <20240214152759.000076ec@Huawei.com>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20240214152759.000076ec@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:5:60::40) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|LV3PR12MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d280eb-b434-4c33-5fc7-08dc2d7bbd7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zrupHMmWoD8rWtd7z2K1N/vCEYty9e0sHq93pzXZg+ALkEp6iCvLM78V45E6THdT02M+e/zfBETxRXBqQWpbITYyte1MYZLFutU/9gMd7oCwlU8ySwYpAeWinzkCcSUlxYSsPxA8MZKuVr3yApp84myxwghskhEJT9lHAgAILsH9+L8zlJZj6UTh0NH6HILx8M6MZbyLn1fSrxu6EKVmv9sdvUJnUIm6wK2B+bZ1Za6fqcLGhweYW3+RY8md79f2bIjKXTBQQpnBuhqHOIgEE1ZhywDSupjwHeZ/4dDK7HXTR/sN4u/elBjvGUnkrG84swDjrLPLPL23Ch40709YNtQg8Qk/SatHUAFvNs45KjWAPAwGOLiWN1LwU76SWztGkFYXwG+mTzsMWYORNTmQn+av3fpmT9m6rA+U4ltIUqFUoeQ/Rll5LHhOK7mNfxEgjinfbAEagc7A72ew0U4tPpHWDUyDaG8wCuDuRx09f2B0TWOY9GPsdV3yTYGhVS/k4ygWvMfZCaVp0/Ib3Z1M+mtNUXYLXtAC8nuXZCfwIy0kgbwlAnYuNT2AMlEYHS54
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(366004)(376002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(31686004)(316002)(66476007)(6916009)(66556008)(66946007)(41300700001)(5660300002)(30864003)(7416002)(2906002)(4326008)(8936002)(8676002)(31696002)(478600001)(6486002)(6512007)(6506007)(36756003)(6666004)(83380400001)(2616005)(53546011)(38100700002)(86362001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmFtYWRWR0xkenBkaTVIbit0VlMxY1k0MGRBWnhXUnpMSXRNbVh6WFc4N2R0?=
 =?utf-8?B?NHZPRng5L0JrMFp4Z2xKUm00dXg1enVUb21jcDdZaHBDd1d0VWVxc09vMUIv?=
 =?utf-8?B?NzlBVW9jNHQvemk4Z3pUbWJDS2dhZ2RuZnY2QkUvLzBqNGhQL1dGblFWb0c0?=
 =?utf-8?B?Ukd4VDlhcGdwaWhoZTlWQmxQYXF0aUNkZ1JBQ3RYa3lYWEtJTmNWUTdmeHRq?=
 =?utf-8?B?T1I0dEgvNUJNWDJTcW4rSE9TVGxxcDhTYjV4SmNUOTMrM2xFY1hXbXJhWFZX?=
 =?utf-8?B?dU5zUGlsck1SVFJyZzdDNWZweHlyaVRCWVZKQytFaW81T1hhdXlGeEZTblhS?=
 =?utf-8?B?M2xjTFRzUWlGT0gzSmdKN1pTdHU1T1BYcStCSTh4bFp5OEJTTXJ5b2ExbkpI?=
 =?utf-8?B?alNVWVIvRlh0RGplcXhyeHFxTVUrdzFqdUhxanR1SExGQ2dvcWtmSDlJQmJL?=
 =?utf-8?B?aTN2V3JRSmwrcHZGRENaZmJUeW9Qd1Z1dUpXakdmR1lrR1dFbzJxaTUxTjB4?=
 =?utf-8?B?dnQzai8zb2dqL0lCaEc5OWdCNENLQUhJcExrc1pRT1c3UFIwUVJoWGFCeHhq?=
 =?utf-8?B?amR5blBnOFNJTTZIblV3MFd5V0FLRUsrb09Pa3M0MDRqL3dmV2xZVlVpeWhx?=
 =?utf-8?B?cnJlVnVYcldwWVlRbUdRd21TT2tTN0VMdDI4cVFJRnc4QnVSUDE1cmErcVpI?=
 =?utf-8?B?b3R5NStPOENEQk9PeXJoTGs3b1ozYnF5MHdBU2Q1cDFJNXROOG05ZUU2Tjhr?=
 =?utf-8?B?VEZXVjhteWpnd29FL3BEVS92OG9JekVDVGxabGhSa2VaUHAxOUtGcmhsdEh0?=
 =?utf-8?B?WEZoZUtLMTdpdjJWN2Zyc1MyT2d5elRDcytXUGtuT0ZrTGNlZWpvelh3c0E1?=
 =?utf-8?B?WkpycVVSeFNQTEMvRWdCWXNRNkJSeTMvSFVWZ0t2b1FwRm9RWHdHcURId3Yr?=
 =?utf-8?B?SXNWblZnaHRyVTZDK0I5QTZ0NFZKTy91Z3VWdXdjWnhWWHFaUWdYSVkwZ1Yv?=
 =?utf-8?B?QWFWNkQyVFFNWVdndEE1dlJ5d0tKVk1QdC9kekpzZkhYVU9kRjFQc3NjS2Z6?=
 =?utf-8?B?eVNOZkdaV3BhcjZhWDBoOS9ZZVBYYW1WWkJiS24zMVBCczNhVUcvNk54bVBM?=
 =?utf-8?B?R1E3czQ1MkVvTnRDMnhJVkVFYzkvM0o3aWVHMU5vSXJVbVJGR3lLZHFMcDYr?=
 =?utf-8?B?Mi9HTzV3ZGozOFVYeGNOLzVIdkNXS1Q1L0U0UmdnSk1sdGxMZzhFWXJyQWxB?=
 =?utf-8?B?RTRwelVrNzZ5Y1BQRHFyZ3gwV0pObjROM1ZQZ2tUUWVxbjUvMVVORW1mLzBL?=
 =?utf-8?B?WlFaeEdnSVBqayt5bUZhbXZwQ1Z4ODhzSWtWRTNmUUtLRmF1MENSWjZYN3lN?=
 =?utf-8?B?WDdYSXVnZ0UrUnBIMXllNlpFdUlSYW1HUXl3a016L0ZveWVNVFFpMi9jdnpp?=
 =?utf-8?B?TTMzZE45ekpZSEprb1VDeVRCSXNKWVJMRkYxZE0rcVFiV1MwbDVHUGpXMTdW?=
 =?utf-8?B?dW0rMnJrMDhQUXVBTndaY3dpMDQvSjd5TXYvTnZ5RVN0ZXVPYWQrbDVhbVBv?=
 =?utf-8?B?ajJWNE1Ba0tMNTlpYkc2Y1NEQndJQ1prQnE5eG9Tc0ZKbXUrU3FucHJKN1Ji?=
 =?utf-8?B?VkVzZDRBYWxpTXAxa0IrTnF0UW14TGdVUGNjMm5SK2t5Zlp0akRXd09ldjRH?=
 =?utf-8?B?cXNBNkJBZjBaRjJ2TjRXUTlXUGpjaHhJU1BWeklTdFdzamluRUJtcG5HQ1dG?=
 =?utf-8?B?SmZMSjJjZVBYSjNtRS9GcGNrUEVsRG1mWmJpL2pIRmtuRWVhOVJsa2l6MDhU?=
 =?utf-8?B?Lzc1ZzdsTVEvSDByTERpTWsxV1ZzLzR5YWFUbHVBRU02c0wrNGhVR00raUEy?=
 =?utf-8?B?WnMrOVFiSHRUeGI3eHZVN285MjVCSnkrTlBzZ2JNOXQxay9DOW5PMnRSRlY3?=
 =?utf-8?B?MTExRGtuRTZ4cFluYzJnaTB4TUN5QnErdEdZWkxoVjd6dnZzbjdMaUJTL1Ji?=
 =?utf-8?B?dHo2eTRyRVJVcVVmQlh4MzNkQm81MTV4UHNVMWNoVnFiRDJyRXdkb0kxTEY3?=
 =?utf-8?B?WllEeFhwRElXUHhucnIyTzZsOEkzU1BWUkJQZDlLVmJuVnBFekU5SE94blBz?=
 =?utf-8?Q?VvhP7cXFY5z7rOA5KvIW0UJjp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d280eb-b434-4c33-5fc7-08dc2d7bbd7c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 16:41:06.4535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97pzwgMvd1xbvtT7zW0/XJBKYrIhwifEGhQiInMqHDulXSS4bXmqPsknBl60X8y9LE51+V4eVZXzkJIlkVOWQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9187



On 2/14/24 9:27 AM, Jonathan Cameron wrote:
> On Thu, 8 Feb 2024 14:00:41 -0600
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
>> Implement CXL helper functions in the EINJ module for getting/injecting
>> available CXL protocol error types and export them to sysfs under
>> kernel/debug/cxl.
>>
>> The kernel/debug/cxl/einj_types file will print the available CXL
>> protocol errors in the same format as the available_error_types
>> file provided by the EINJ module. The
>> kernel/debug/cxl/$dport_dev/einj_inject is functionally the same as the
>> error_type and error_inject files provided by the EINJ module, i.e.:
>> writing an error type into $dport_dev/einj_inject will inject said error
>> type into the CXL dport represented by $dport_dev.
>>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> Hi Ben,
> 
> Sorry I've not looked at this sooner.
> 
> Anyhow, some comments inline. Mostly looks good to me.
> 
> Jonathan
> 
>> ---
>>  Documentation/ABI/testing/debugfs-cxl |  22 ++++
>>  MAINTAINERS                           |   1 +
>>  drivers/acpi/apei/einj.c              | 158 ++++++++++++++++++++++++--
>>  drivers/cxl/core/port.c               |  39 +++++++
>>  include/linux/einj-cxl.h              |  45 ++++++++
>>  5 files changed, 255 insertions(+), 10 deletions(-)
>>  create mode 100644 include/linux/einj-cxl.h
>>
>> diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
>> index fe61d372e3fa..bcd985cca66a 100644
>> --- a/Documentation/ABI/testing/debugfs-cxl
>> +++ b/Documentation/ABI/testing/debugfs-cxl
>> @@ -33,3 +33,25 @@ Description:
>>  		device cannot clear poison from the address, -ENXIO is returned.
>>  		The clear_poison attribute is only visible for devices
>>  		supporting the capability.
>> +
>> +What:		/sys/kernel/debug/cxl/einj_types
>> +Date:		January, 2024
>> +KernelVersion:	v6.9
>> +Contact:	linux-cxl@vger.kernel.org
>> +Description:
>> +		(RO) Prints the CXL protocol error types made available by
>> +		the platform in the format "0x<error number>	<error type>".
>> +		The <error number> can be written to einj_inject to inject
>> +		<error type> into a chosen dport.
> 
> I think it's a limited set, so docs could include what the error_type values can
> be?  From this description it's not obvious they are human readable strings.
> 

It is a limited set, but that set has 6 variants. It may make the description
a bit long to include all of them, but I could include an example string instead?
If length isn't an issue then I can add them all in.

>> +
>> +What:		/sys/kernel/debug/cxl/$dport_dev/einj_inject
>> +Date:		January, 2024
>> +KernelVersion:	v6.9
>> +Contact:	linux-cxl@vger.kernel.org
>> +Description:
>> +		(WO) Writing an integer to this file injects the corresponding
>> +		CXL protocol error into $dport_dev ($dport_dev will be a device
>> +		name from /sys/bus/pci/devices). The integer to type mapping for
>> +		injection can be found by reading from einj_types. If the dport
>> +		was enumerated in RCH mode, a CXL 1.1 error is injected, otherwise
>> +		a CXL 2.0 error is injected.
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 9104430e148e..02d7feb2ed1f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -5246,6 +5246,7 @@ L:	linux-cxl@vger.kernel.org
>>  S:	Maintained
>>  F:	drivers/cxl/
>>  F:	include/uapi/linux/cxl_mem.h
>> +F:  include/linux/einj-cxl.h
>>  F:	tools/testing/cxl/
>>  
>>  COMPUTE EXPRESS LINK PMU (CPMU)
>> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
>> index 73dde21d3e89..9137cc01f791 100644
>> --- a/drivers/acpi/apei/einj.c
>> +++ b/drivers/acpi/apei/einj.c
>> @@ -21,6 +21,7 @@
>>  #include <linux/nmi.h>
>>  #include <linux/delay.h>
>>  #include <linux/mm.h>
>> +#include <linux/einj-cxl.h>
>>  #include <linux/platform_device.h>
>>  #include <asm/unaligned.h>
>>  
>> @@ -37,6 +38,20 @@
>>  #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
>>  				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
>>  				ACPI_EINJ_MEMORY_FATAL)
>> +#ifndef ACPI_EINJ_CXL_CACHE_CORRECTABLE
>> +#define ACPI_EINJ_CXL_CACHE_CORRECTABLE     BIT(12)
>> +#define ACPI_EINJ_CXL_CACHE_UNCORRECTABLE   BIT(13)
>> +#define ACPI_EINJ_CXL_CACHE_FATAL           BIT(14)
>> +#define ACPI_EINJ_CXL_MEM_CORRECTABLE       BIT(15)
>> +#define ACPI_EINJ_CXL_MEM_UNCORRECTABLE     BIT(16)
>> +#define ACPI_EINJ_CXL_MEM_FATAL             BIT(17)
>> +#endif
>> +#define CXL_ERROR_MASK		(ACPI_EINJ_CXL_CACHE_CORRECTABLE | \
>> +				ACPI_EINJ_CXL_CACHE_UNCORRECTABLE | \
>> +				ACPI_EINJ_CXL_CACHE_FATAL | \
>> +				ACPI_EINJ_CXL_MEM_CORRECTABLE | \
>> +				ACPI_EINJ_CXL_MEM_UNCORRECTABLE | \
>> +				ACPI_EINJ_CXL_MEM_FATAL)
>>  
>>  /*
>>   * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
>> @@ -543,8 +558,11 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>>  	if (type & ACPI5_VENDOR_BIT) {
>>  		if (vendor_flags != SETWA_FLAGS_MEM)
>>  			goto inject;
>> -	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM))
>> +	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)) {
>>  		goto inject;
>> +	} else if ((type & CXL_ERROR_MASK) && (flags & SETWA_FLAGS_MEM)) {
>> +		goto inject;
>> +	}
>>  
>>  	/*
>>  	 * Disallow crazy address masks that give BIOS leeway to pick
>> @@ -596,6 +614,9 @@ static const char * const einj_error_type_string[] = {
>>  	"0x00000200\tPlatform Correctable\n",
>>  	"0x00000400\tPlatform Uncorrectable non-fatal\n",
>>  	"0x00000800\tPlatform Uncorrectable fatal\n",
>> +};
>> +
>> +static const char * const einj_cxl_error_type_string[] = {
>>  	"0x00001000\tCXL.cache Protocol Correctable\n",
>>  	"0x00002000\tCXL.cache Protocol Uncorrectable non-fatal\n",
>>  	"0x00004000\tCXL.cache Protocol Uncorrectable fatal\n",
>> @@ -621,29 +642,44 @@ static int available_error_type_show(struct seq_file *m, void *v)
>>  
>>  DEFINE_SHOW_ATTRIBUTE(available_error_type);
>>  
>> -static int error_type_get(void *data, u64 *val)
>> +int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
>>  {
>> -	*val = error_type;
>> +	int cxl_err, rc;
>> +	u32 available_error_type = 0;
>> +
>> +	if (!einj_initialized)
>> +		return -ENXIO;
>> +
>> +	rc = einj_get_available_error_type(&available_error_type);
>> +	if (rc)
>> +		return rc;
>> +
>> +	for (int pos = 0; pos < ARRAY_SIZE(einj_cxl_error_type_string); pos++) {
> 
> Trivial so feel free to ignore but, I'd stick to local styles and have pos
> declared in more traditional c style.
> 

Will do.

>> +		cxl_err = ACPI_EINJ_CXL_CACHE_CORRECTABLE << pos;
> 
> Maybe clearer as
> 		cxl_err = FIELD_PREP(CXL_ERROR_MASK, BIT(pos));
> 

I'll think about it. I think I agree with you, but I've seen a good amount of
people who aren't familiar with the FIELD_* macros in which case it isn't much clearer.

>> +
>> +		if (available_error_type & cxl_err)
>> +			seq_puts(m, einj_cxl_error_type_string[pos]);
>> +	}
>>  
>>  	return 0;
>>  }
>> +EXPORT_SYMBOL_NS_GPL(einj_cxl_available_error_type_show, CXL);
>>  
>> -static int error_type_set(void *data, u64 val)
>> +static int validate_error_type(u64 type)
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
>> +	tval = type & 0x7fffffff;
> 
> Could flip this to GENMASK whilst you are here.
> I don't much like counting fs :)
> 

Me neither. Will do.

> 
>>  
>>  	/* Only one error type can be specified */
>>  	if (tval & (tval - 1))
>> @@ -652,9 +688,105 @@ static int error_type_set(void *data, u64 val)
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
>> +static int cxl_dport_get_sbdf(struct pci_dev *dport_dev, u64 *sbdf)
>> +{
>> +	struct pci_bus *pbus;
>> +	struct pci_host_bridge *bridge;
>> +	u64 seg = 0, bus;
>> +
>> +	pbus = dport_dev->bus;
>> +	bridge = pci_find_host_bridge(pbus);
>> +
>> +	if (!bridge)
>> +		return -ENODEV;
>> +
>> +	if (bridge->domain_nr != PCI_DOMAIN_NR_NOT_SET)
> 
> Ah. x86 is not using the CONFIG_PCI_DOMAINS_GENERIC
> so I guess we can't just use pci_domain_nr(pbus)?
> (for the generic case bus->domain_nr is filled in when
> the host bridge is registered). Pity.
> 
>> +		seg = bridge->domain_nr << 24;
>> +
>> +	bus = pbus->number << 16;
> I'd do the shifts whilst building sbpf.
> AS it stands you end up with what look to be wrong values in
> seg and bus because you'd shifted them in the local variables.
> 
>> +	*sbdf = seg | bus | dport_dev->devfn;
> 	*sbdf = (seg << 24) | (bus << 16) | dport_dev->devfn;
> 
> (with shifts dropped where seg and bus are set)

Will do! I was never 100% sure about this function, but I
never had a problem with it in my testing.

>> +
>> +	return 0;
>> +}
>> +
>> +int einj_cxl_inject_rch_error(u64 rcrb, u64 type)
>> +{
>> +	u64 param1 = 0, param2 = 0, param4 = 0;
>> +	u32 flags;
>> +	int rc;
>> +
>> +	if (!einj_initialized)
>> +		return -ENXIO;
>> +
>> +	/* Only CXL error types can be specified */
>> +	if (type & ~CXL_ERROR_MASK || (type & ACPI5_VENDOR_BIT))
> 
> As below - a utility function would unify the 3 uses of this and
> avoid need for comment.
> 
>> +		return -EINVAL;
>> +
>> +	rc = validate_error_type(type);
>> +	if (rc)
>> +		return rc;
>> +
>> +	param1 = (u64) rcrb;
> already a u64

probably left over from an earlier revision, I'll get rid of the cast.

>> +	param2 = 0xfffffffffffff000;
> No need to initialize these to 0 above.
>> +	flags = 0x2;
>> +
>> +	return einj_error_inject(type, flags, param1, param2, 0, param4);
> 
> 	return einj_error_inject(type, flags,
> 				 rcrb, 0xfffffffffffff000, 0, 0);
> 

Will change.

>> +}
>> +EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_rch_error, CXL);
>> +
>> +int einj_cxl_inject_error(struct pci_dev *dport, u64 type)
>> +{
>> +	u64 param1 = 0, param2 = 0, param4 = 0;
>> +	u32 flags;
>> +	int rc;
>> +
>> +	if (!einj_initialized)
>> +		return -ENXIO;
>> +
>> +	/* Only CXL error types can be specified */
>> +	if (type & ~CXL_ERROR_MASK || (type & ACPI5_VENDOR_BIT))
> 
> As below a utility function would do this nicely (and avoid need
> for comment).
> 	if (!is_cxl_error(type))
> 
>> +		return -EINVAL;
>> +
>> +	rc = validate_error_type(type);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = cxl_dport_get_sbdf(dport, &param4);
>> +	if (rc)
>> +		return rc;
>> +
>> +	flags = 0x4;
>> +
>> +	return einj_error_inject(type, flags, param1, param2, 0, param4);
> Why not
> 	return einj_error_injecT(type, 0x4, 0, 0, 0, param4);
> ?
> 
> Maybe flags is useful as "documentation" but given the parameters are nicely
> in order and you already didn't bother with param3, I can't see why
> keeping param1 and param2 as local variables is useful.
> 

It's a good point. I originally had the RCH and VH variants in the same function,
and the param variables did matter then. Now that that's not the case, I'll
remove them.

>> +}
>> +EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_error, CXL);
> 
> 
> 
>> +
>> +static int error_type_set(void *data, u64 val)
>> +{
>> +	int rc;
>> +
>> +	/* CXL error types have to be injected from cxl debugfs */
>> +	if (val & CXL_ERROR_MASK && !(val & ACPI5_VENDOR_BIT))
> 
> Given you have inverse of this above, maybe it's worth a little
> helper function to have the logic only once?
> 
> 	if (is_cxl_error(val))
> 

I agree, I'll add it.

>> +		return -EINVAL;
>> +
>> +	rc = validate_error_type(val);
>> +	if (rc)
>> +		return rc;
>> +
>>  	error_type = val;
>>  
>>  	return 0;
>> @@ -690,6 +822,12 @@ static int einj_check_table(struct acpi_table_einj *einj_tab)
>>  	return 0;
>>  }
> 
> 
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 8c00fd6be730..c52c92222be5 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
> 
>> +static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
>> +{
>> +	struct dentry *dir;
>> +
>> +	/*
>> +	 * dport_dev needs to be a PCIe port for CXL 2.0+ ports because
>> +	 * EINJ expects a dport SBDF to be specified for 2.0 error injection.
>> +	 */
>> +	if (!einj_is_initialized() ||
>> +	    (!dport->rch && !dev_is_pci(dport->dport_dev)))
>> +		return;
> 
> Trivial: Even though it's a little more code I'd break this up so that it's clear
> exactly what the comment refers to.
> 

I'm fine with that, will do.

> 	if (!einj_is_initialized)
> 		return;
> 
> 	/*
> 	 * dport_dev needs to be a PCIe port for CXL 2.0+ ports because
> 	 * EINJ expects a dport SBDF to be specified for 2.0 error injection.
> 	 */
> 	if (!dport->rch && !dev_is_pci(dport->dport_dev))
> 		return;
>> +
>> +	dir = cxl_debugfs_create_dir(dev_name(dport->dport_dev));
>> +
>> +	debugfs_create_file("einj_inject", 0200, dir, dport,
>> +			    &cxl_einj_inject_fops);
>> +}
>> +
>>  static struct cxl_port *__devm_cxl_add_port(struct device *host,
>>  					    struct device *uport_dev,
>>  					    resource_size_t component_reg_phys,
> 
> ...
> 
>> @@ -2220,6 +2254,11 @@ static __init int cxl_core_init(void)
>>  
>>  	cxl_debugfs = debugfs_create_dir("cxl", NULL);
>>  
>> +	if (einj_is_initialized()) {
>> +		debugfs_create_file("einj_types", 0400, cxl_debugfs, NULL,
>> +				    &einj_cxl_available_error_type_fops);
>> +	}
>> +
>>  	cxl_mbox_init();
>>  
>>  	rc = cxl_memdev_init();
> 
> 
>> diff --git a/include/linux/einj-cxl.h b/include/linux/einj-cxl.h
>> new file mode 100644
>> index 000000000000..af57cc8580a6
>> --- /dev/null
>> +++ b/include/linux/einj-cxl.h
> 
> 
>> +
>> +#if IS_ENABLED(CONFIG_ACPI_APEI_EINJ)
>> +int einj_cxl_available_error_type_show(struct seq_file *m, void *v);
>> +int einj_cxl_inject_error(struct pci_dev *dport_dev, u64 type);
>> +int einj_cxl_inject_rch_error(u64 rcrb, u64 type);
>> +bool einj_is_initialized(void);
>> +#else
> 
> It's trivial but if you are respinning, I'd like to see a comment for the
> else and the endif to let us trivially see what they match with.
> Lack of indenting for this preprocessor conditions can make this really
> hard to undwind once a file grows more complex over time.
> 

I see, I'll comment them!

>> +static inline int einj_cxl_available_error_type_show(struct seq_file *m,
>> +						     void *v)
>> +{
>> +	return -ENXIO;
>> +}
>> +
>> +static inline int einj_cxl_type_show(struct seq_file *m, void *data)
> 
> A stub for a function that doesn't exist otherwise.  Left
> over from refactors?
> 

Probably, I'll remove it.

Thanks,
Ben

>> +{
>> +	return -ENXIO;
>> +}
>> +
>> +static inline int einj_cxl_inject_error(struct pci_dev *dport_dev, u64 type)
>> +{
>> +	return -ENXIO;
>> +}
>> +
>> +static inline int einj_cxl_inject_rch_error(u64 rcrb, u64 type)
>> +{
>> +	return -ENXIO;
>> +}
>> +
>> +static inline bool einj_is_initialized(void) { return false; }
>> +#endif
>> +
>> +#endif
> 

