Return-Path: <linux-acpi+bounces-3801-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C206485E906
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 21:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4DA71C22731
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 20:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F27127B50;
	Wed, 21 Feb 2024 20:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UNzsJmiR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2078.outbound.protection.outlook.com [40.107.96.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07A486AFE;
	Wed, 21 Feb 2024 20:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708547274; cv=fail; b=Aa2uBVH6H8uPJvy0lJDHdhU1Q4xhkPnGRXhwTuG9c9RZ/ooJbR1vT12Tc+nm+rj1eG6t/MKy9hSrL6BrfwwTByUoAppQ0rSX13Se2l3IzWTg1SkAVn7muyAg8kS2IuP7mhtvYsxGHZGBGSIySbsLr9HQLy9VlrQUF45z6LMgrWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708547274; c=relaxed/simple;
	bh=D7VReppZ9fxW9MaVRCAtXxTuFSw7BYeJl96Y39W8c4E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sYfutBW7PoIU4ARrs3FDXfB+/i6M4I2Udh1pswmHGWZ4vP3v1NkyhzI1/Fhn/49o4bKeNuE45pZfw2P7j3yKOIkDjHoM3PjTlMuWzGfapX7O2Mznnt2T8U4PMSxOsoUcnOs0LyFOFhqUmrtCxnOO1DzDcHuMioveuRnjhq6IxNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UNzsJmiR; arc=fail smtp.client-ip=40.107.96.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/WuBMmvzk3HZXVZxxZZAJ/9mqu9qtctSURzrGPHijC/8wMnCMLH8Sr4w+ZcvrxLciJM+xBKSqWQZLlv/UkpYjzjUdh94doNOujFTQxJ8qjv7b9blgYEE2tAn0yv0+z6yv/3z2OUt2XONUaYoDZSRu17q+UEEe2xHJR8nqOG9kklwi7NNpDpBb8OuDGexCtV8lYtWigcaHXx9QJXVXmvjZbZu4iq5WS+WUurxXxQhjuuIIi3cvrGIJ6mI1du54Tp258sD/n89HffglNBTTz/xzoqttUDxXlLv7j3e9xpVTZq2/l435ToK8spvl256VTNMhB6fqOHN8H1wx4zz8J8rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HaTpZRpjOr58LHIqKzGWv2iQq6AWd8GeOzQKgrXlig=;
 b=iTowrQSl278qRXJUV03Ykbt8bmKZjS0RR9MR5VZXGEqVrPUP7cBNySD5O7SDs5iuJWxMuCk3NzMp5cDTe9It2OxmOWVgeZsu1JqCo1ZaQQuuoWTDPIYCTUQkNjeUdGDddsBGzhXgRPexMxrIQwiyLoC/4M3zKhlQzQXOTWjszvXq4sKxckdmX263rZlo3rDLMTFdteXcmvbj9tBChw1pnzn/ax/yuznTYRPB8ed8eEgLCVEuIkPTsYmeTRhI2c1CJe1Y2VakOmjkE/tKn6P1I2Ih+NvlsXRdbTBGB6tXRcXgDswOy+2fILrhxmU53u96mWOvzDjiCyyyngNAItnnhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HaTpZRpjOr58LHIqKzGWv2iQq6AWd8GeOzQKgrXlig=;
 b=UNzsJmiRTjjLJusfi54JV49uzFQtGk/h1CchtgTxEVJxnr8s7ZC8YIr+J0gjYTSRg8ob6T0LaAHgXl3SzpXpE93asYeswd27HAgadyDMRhtVmnETWzSkgEEszfU49RtQYuyw+ZEOU0DVsU+VwGS666+xqsGa3cq+Z+RCPUg3x5s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by SJ0PR12MB6685.namprd12.prod.outlook.com (2603:10b6:a03:478::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Wed, 21 Feb
 2024 20:27:36 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::d493:7200:e0ae:1458]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::d493:7200:e0ae:1458%7]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 20:27:36 +0000
Message-ID: <1e06a47e-7d85-4abb-b09f-4287c9074c16@amd.com>
Date: Wed, 21 Feb 2024 14:27:34 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 3/4] cxl/core: Add CXL EINJ debugfs files
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, jonathan.cameron@huawei.com,
 rafael@kernel.org, james.morse@arm.com, tony.luck@intel.com, bp@alien8.de
Cc: dave@stogolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20240220221146.399209-1-Benjamin.Cheatham@amd.com>
 <20240220221146.399209-4-Benjamin.Cheatham@amd.com>
 <65d6377778823_5e9bf294b4@dwillia2-xfh.jf.intel.com.notmuch>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <65d6377778823_5e9bf294b4@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::22) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|SJ0PR12MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: e21f3079-5bfc-45ad-5a4d-08dc331b8a7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tfSWhWhq7AwBZb4wVcetUNwfaRNoy0kUJYK+TLE27nBlEtBRUCgQqYKHHo678VlLMfVTs2plb0AC+ZOW/0W40nc0IkdOxTHQrpohtX9uXu63ixzR/Ynx6lsxCEvi+X3jiB7ECVscQjPCcv5JcLD2vu1lYyXAGefusYqA79rhJVvBAHrgUDv20WYSQY6PFpRoG96qFikkaocN0Z0QtmE4YFwRAdDrPJ+cDmkj9fF0YSzvh8nKyY/OWBACNsL98HzrfMCOi/FaAhqmQC1T1WvcFeOCSXE0T7VSdLiFDmSOaic5y7ckIbzg0MaFI6+WMlVjqXXrVEyYFq0eFHbO/k9rsIFAoQZTd03cQynX+s5EyjR87Fld0PXXUHlBifiNY5zPe5f19UkSnwHH1mbHs2296yXOPJjU5Mmi3ccBs5s3h03UrCnYrptfGyRd1cb+qD9DjHRuPCRpnIoOb0i09k7MJYw8JI0q4cpzh3ZoJE+GIq7kVE9WpBtguT490PCjit3ryXcYU30QvLMxz/+1VMDDuQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGVpdm9OemU1Z0puNHUyVmlSWTg4aXdNNGhSb3JOc3o4TTJsTEpNTGZUZTJT?=
 =?utf-8?B?OUVXUTdRMm5ubmx4Y053WW9YSHN6SXNKMnRDV21SZWhDVGQxTHd1S3R0OXFP?=
 =?utf-8?B?RHhDeDRtajR3Rk5VT3ZNZWFxTHBCVWxqOEdBNnNKSG5JdHVHYnF0ZHFUajhR?=
 =?utf-8?B?RzQvT1EzMDAreWk1bVRFRXlKZDgvTVIzWDIzNTZUOURjaHM2dzBJeDllN3hW?=
 =?utf-8?B?R0p2STl4ZVdiYm1KTUtGZlc4Z20wREVybmswaVlyQkFyWnRDNlJURllGWTEz?=
 =?utf-8?B?dHQvUjJxR1dLM2hQVllyUnJBMWxQaThpUGk5aW1YdFZtV29HNlZ4RXAyWlF6?=
 =?utf-8?B?WFVjN1BJU3Q0dDZqczJ6eVdqYXhKRFZ5SWdPREJHLzRuUkhOOW43b3ZWMDdj?=
 =?utf-8?B?MEFLcTBYc2VlNTJpb21sbWgxa003VkpGcWVIZzA3YnRKbnhyOWtzanVvM3dv?=
 =?utf-8?B?TFJENDRQTE9rVnYzTVhhUTZROFFZbjlRSXlWdmg1cUZHUEZ3SHhUUHU0V2ht?=
 =?utf-8?B?a2FnMjIxWmFRWC9IaDhEaGxjTGhMczQwMXFFbmdGeTlVME53czV6QzNpcGZ2?=
 =?utf-8?B?M1RwWnpZSzRrL2w0SjVyeFhXUkdaNUJZdk9GYlhaV3hnL0padnRpSE8wTDV5?=
 =?utf-8?B?dThUb09IQjJ2dS9TbXBjcmNuc0RlVGpoVW5pR3BGK3ZaMWxhVVZCYW02bWlh?=
 =?utf-8?B?TEdENnJMZis3SmdUTkhwdzBYOGxTb3JuMVhMV1dpZklTRHd4Q01NOHYvNnc3?=
 =?utf-8?B?anhUU3RtVVhtNVRONTNGeGpHWVh5K0tZREp6U2FLZkhTOXIxY28za0dheHhF?=
 =?utf-8?B?d3RsNUhVcHB3YzRVZmxtR3dxMllkbEkzYUFxMjRrM0JWSE5ISDhvNDBReEh4?=
 =?utf-8?B?eFJKN0lzQ0c3VkMyZ0ZyTHpXVEN4QlJiYllvWkJOUk1jeWdORDBUUUM3T082?=
 =?utf-8?B?VTRFbnhSR0NibjN6Ym5DQUV2NUZpbDBlSEJmOTF1d0lSSkZSM1pvYzhvUUh3?=
 =?utf-8?B?WFZEZEhxTXlqQW4rQkVJdDFvV25CU2o5SEJGM21EYVVjcDVjN3dpUEFtRER3?=
 =?utf-8?B?dEw1aG54b3FEYjQweGRlbGNMU2NzMTBKdnZ6NlZwTEFGWXUycmVldWY5c0tL?=
 =?utf-8?B?QkxXTHZyVWhsaUMzSHFVNVUvSUJrelZTU3MrWGpRUU1oQXNhN0tFRm5qQU10?=
 =?utf-8?B?VDh1RytjdEpjYVU0d25VdFZEa3ZMeDREeCttZDV4NVZjNWhDQTdITVdYM0F1?=
 =?utf-8?B?SkxkT2NVYmVJY2hmTFdmWVI2S2RJNUVEd3BSdVlsTjBpZ1R0VkZNUVdNcS9Z?=
 =?utf-8?B?UFRIclNCNmtMenlGTGZQbVlUdFVNcEt5MFNHd3dkSmloQXlUdjVEVTdBWVdS?=
 =?utf-8?B?R3J0b1VibEFEZklXOG1McDhyWnUyaDRMbk9uQW40anc3SHR2Zm5zNmQ1anZV?=
 =?utf-8?B?L1RJR2xtSks5VHM1QW9OaWJ6K3ZSZlBZb0hCaFdEU3VDeXd5SjJxcG9IZnFw?=
 =?utf-8?B?Q2JLa2tqWlcwRGZGdGkxK0xuSE9NUlhTV2NpTXMyUFdVV0xJZkNwS3drOXNL?=
 =?utf-8?B?R3l3NWFwUlorOXdwbDVLdURMYWtVQVVPSDZFWEczOVZBZTMrSGliQVZwd3U3?=
 =?utf-8?B?cWFoYnVuZkxUcnhIZmg0eDBPNk5BaVc5Qk9GVnZDcmJVbVFvNC9TQlVXTWls?=
 =?utf-8?B?eTRqVjkxdnY5aDRQYlpERVFRVkwwdHJoSG9iNmMya3dUUTBNajV2eW5JdnY3?=
 =?utf-8?B?UTJhclJQSUE4R1BudU9ydWNYT0N0d2dxdUw5cFhIUkJsKzE2Z2JiZVpOMFRT?=
 =?utf-8?B?RExoSmJJN0RDejV3ZDU0YzhGSXVhM3l1MS8vL1JRZTNXZ0lPZHBNVnBuR2NM?=
 =?utf-8?B?Y3lMWnhnYVBUVEk5U050M1FaWUVMa01wOGhUWm80MDdRTDlVYVpKQUxQTWds?=
 =?utf-8?B?d00xenNTTWlPa1U0RE5NR0VDamx5KzJIZHVTU0QwU0dGREZITTFVaWo4dzho?=
 =?utf-8?B?c0xaM01hQ2Y2bWhTd3pMdGxRWU5XZ1NQZUZ3aUdZRlh4TUdvcEhjditpazRo?=
 =?utf-8?B?dHVZb1FsYlVzTy91QVhwd0JYSXN0S1F0Z3RIYWg0ZmJvbDU1TXhwb0IwMFdB?=
 =?utf-8?Q?EUY5D/9DfqDG3UkqIOv7sbhwS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e21f3079-5bfc-45ad-5a4d-08dc331b8a7d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 20:27:36.1316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xanvIvrqMBwP5y6XyRgH51N6vLi9j2OKPMcWE8PHKOEdlVrhloNk4AtMyZ1onjv3M0HPh9FUJRyEFXLbCSRUbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6685



On 2/21/24 11:48 AM, Dan Williams wrote:
> Ben Cheatham wrote:
>> Export CXL helper functions in the einj_cxl module for getting/injecting
>> available CXL protocol error types to sysfs under kernel/debug/cxl.
>>
>> The kernel/debug/cxl/einj_types file will print the available CXL
>> protocol errors in the same format as the available_error_types
>> file provided by the einj_cxl module. The
>> kernel/debug/cxl/$dport_dev/einj_inject is functionally the same as the
>> error_type and error_inject files provided by the EINJ module, i.e.:
>> writing an error type into $dport_dev/einj_inject will inject said error
>> type into the CXL dport represented by $dport_dev.
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
>> ---
>>  Documentation/ABI/testing/debugfs-cxl | 30 ++++++++++++++++++++
>>  drivers/cxl/Kconfig                   |  1 +
>>  drivers/cxl/core/port.c               | 41 +++++++++++++++++++++++++++
>>  3 files changed, 72 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
>> index fe61d372e3fa..4c0f62f881ca 100644
>> --- a/Documentation/ABI/testing/debugfs-cxl
>> +++ b/Documentation/ABI/testing/debugfs-cxl
>> @@ -33,3 +33,33 @@ Description:
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
>> +		The possible error types are (as of ACPI v6.5):
>> +			0x1000	CXL.cache Protocol Correctable
>> +			0x2000	CXL.cache Protocol Uncorrectable non-fatal
>> +			0x4000	CXL.cache Protocol Uncorrectable fatal
>> +			0x8000	CXL.mem Protocol Correctable
>> +			0x10000	CXL.mem Protocol Uncorrectable non-fatal
>> +			0x20000	CXL.mem Protocol Uncorrectable fatal
>> +
>> +		The <error number> can be written to einj_inject to inject
>> +		<error type> into a chosen dport.
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
>> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
>> index 67998dbd1d46..c86ae4c65c03 100644
>> --- a/drivers/cxl/Kconfig
>> +++ b/drivers/cxl/Kconfig
>> @@ -2,6 +2,7 @@
>>  menuconfig CXL_BUS
>>  	tristate "CXL (Compute Express Link) Devices Support"
>>  	depends on PCI
>> +	depends on ACPI_APEI_EINJ_CXL || !ACPI_APEI_EINJ_CXL
> 
> This statement is always true "x || !x"

Yeah, I lifted this from the Kconfig documentation (https://www.kernel.org/doc/html/next/kbuild/kconfig-language.html#kconfig-hints).
It allows CXL_BUS to built if ACPI_APEI_EINJ_CXL=n, but restricts CXL_BUS >= ACPI_APEI_EINJ_CXL otherwise.
Now that I think about it, it seems like this just flipped the dependency I had in v12 the other way.

> 
> I mentioned in the other patch that ACPI_APEI_EINJ_CXL needs to have a
> dependency on CXL_BUS.

Yep I agree, I was just having issues and was able to get it working this way.
I'll change this back to what it was.

Thanks,
Ben

