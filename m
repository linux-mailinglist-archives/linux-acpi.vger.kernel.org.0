Return-Path: <linux-acpi+bounces-4165-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E413687523A
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Mar 2024 15:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137E21C24A4F
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Mar 2024 14:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FDC12E1DF;
	Thu,  7 Mar 2024 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bFYo/mCC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB3312DD99;
	Thu,  7 Mar 2024 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709822822; cv=fail; b=s9e+r/ujZIU/GoVgARQju3NR3tWwvyQKVbTkV0PIQCgAjqnRBg2+Yt+sb7U55ESNvbIMvhyHZT8A5EyY6hh8fqsji6vHe1/DtcdiPboLHwFiHVUHPbKVlmHvTreWcTSPNarF/r3ktC6VuzNoSnK+MBYg/2jgqJUCxrBVPkcehig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709822822; c=relaxed/simple;
	bh=KF12l75Ph4zZJPcUYiy3er8Sqzh+DO44AXOp4Z4gxPo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F0QRU6Hk6byq//nYWXd8vSk0wgbqju34udiMPI9fl56c50VwH7wmLJlEBMeIqZs+xpA0T70nD4QE1KDTArGsWSpPvw6uPLq31+uIleXAluQemNpUvjDquPC6yM/kXMihE3cCmjwygmtmbHl16jPyKtGnK1Ij398wW9VjX7Hr+1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bFYo/mCC; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAYZPxfMKh1UOeF7uiKVqUlrk4L8SlZtwCPdqVzb24qa34wHkey0pJc1AfEzHeaYQ+ZJP51+Lkzv3ZQL27FtcyrUONDy2iVzSp0Hp1o0VOulpST/qEIeAybmpJpVpQwjUVyghTEICagxzXHPU3rprT1Jb2vMUnRwB8TYEEmT4A8qOpdrdaGqyWDD/5F0bTvT0J8F5kURiVNo/Okw88SrvOrGaxjXzmuR0hlJK/v8X7K5nrn2yhq7MKF+cw3iYW2TyF/XLQdfWWXUW+m9kXJbXmepG3ELjE822D+L6BjVKMv4PG0I1/rGHucsgojYGp0kgWFfeRRgdBXAiTKAQrjQsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUiG0rnOLQehEfrJrpShIxYfrArOMw5jf2l1CTNIOas=;
 b=OnVVmFPFJjTGAISVR1gt2bAeE5vIhFvLPokTIzdNiFtx5RjbRJE6udeAnwE7FHs59TlLqKYAYoEIpEQT0WxYTiRLHill9NMBWhWCyVI+nF1ZiMAw9gAuxGobZsHmzhgA3NKjyLwBhWoBTbvKnxeAOBZiQKFyrkfcjwJ26ZK9mX+sB0z3WvUWXa201QIpY3gin2Hk27ZUJ9l4dRW+RaFnQb+cxyTP+UOcyFFAbNqQt732+M1P7RlpPKAzZmigdpkkwpOb8DsUX1YHTYLGlL0dz7zP9GcVlsiD+WaPKbhYyOmwik0tQoXzyGmNL3z1yzUB7SvqOGGQWh5Of+kXSlMO5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUiG0rnOLQehEfrJrpShIxYfrArOMw5jf2l1CTNIOas=;
 b=bFYo/mCC1DKOqxVng0WEQVyMEVspg5+odnslog4eC68LGnmZar4ZAfjo4s4j67f+uWIjb9rhq1pODj7TNR2WdNcukytiFsALcYKbW3VlUcqEFNFdEYeE36hHsfrJUZGh1bbaL2xZ08vW8KdhoayP/FKye6S/33ezZCOr/EU78Go=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by MW6PR12MB9018.namprd12.prod.outlook.com (2603:10b6:303:241::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.41; Thu, 7 Mar
 2024 14:46:57 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::5302:26cf:a913:7e06]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::5302:26cf:a913:7e06%5]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 14:46:56 +0000
Message-ID: <77533c2f-99c0-4281-bc1b-cc970957510a@amd.com>
Date: Thu, 7 Mar 2024 08:46:49 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 2/4] EINJ: Add CXL error type support
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: dan.j.williams@intel.com, rafael@kernel.org, james.morse@arm.com,
 tony.luck@intel.com, bp@alien8.de, dave@stogolabs.net, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20240226222704.1079449-1-Benjamin.Cheatham@amd.com>
 <20240226222704.1079449-3-Benjamin.Cheatham@amd.com>
 <20240307120918.00003c56@Huawei.com>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20240307120918.00003c56@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0088.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::21) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|MW6PR12MB9018:EE_
X-MS-Office365-Filtering-Correlation-Id: 49088add-c50a-4165-c8dd-08dc3eb56feb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2je7RZ9u81IiyxxzwNHat+o/Pw2Y94LwukK6jcMoJyQAazMJfIAZ65uRpuRMbV7Pv+O+8s640VfkwwVnEDodrRbpa8tl8+Uy9/Zj4D7PnjlZVscF1keBPmPZJAq8gc3m76zAu7pmqxcSE9eijZwIW+SZDHX/XZ8srIJrcO9HzStTh9n2LSHSqhvSMXiNjhn6yNw0KnPf8wxGIXHgnzy+A5H0L6XekHoecZqPEXVCEuZfPKv3ARYjqfAnZxV8rGclrDz1JBZvuYx6v41XlV6ZLs+OfaZqLn0I7yrz+bwISYC7Kl+78XM5K5Bsn/SBvozF5pOb7c1YqAYVeuF9q39gvW6S+kK7HrUmWdeDV/fY8bQTqIT25X8WhtvF5DWg1C/488OWxGzTSeKbxpDs+oTyLtJiSk6OLccDQMEhC1CJiTWdsjduC+nqMjZ2WUOM0snZ8uorqyEVoH981gOlt9oHLAtA6MyW89BpTQ8RivZj5fEJBxWRLS+K4grDUnYMHzQck6UShCYbzZPJzlq5YKkAnDXp7aSnzH/cp2eeOMwj/CiC+dx7MhTHEcNGIKsiSUJaCWlpM4o61hb+1N1dV4jQSJp1QMwEE6armXJDRy0+5O/ATyCDR7tPu/EQrfpRTzPhMG/RmcZXyWwyNfGtmNVx/M6Iqw0yJZvGrhGoMnLou/g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmVXem5QWE1jTXFTU0p2dmJuaUcvb0tUaGZCcWpaWS9GL21SekdMRll1SHlm?=
 =?utf-8?B?dlR3R1VGNGtMZ1VlZTdQeEcwQit0c3ZBSWpMUHRPOHRvVUMwL1U5WVFmcmFE?=
 =?utf-8?B?SWhSeU9hOHoySHdlckN1akt0VXlScFlydDRaM2JCeUZXRk50Y1dXcEpNaVpw?=
 =?utf-8?B?TlNEdHlqVnA1MDNneVBNVmVyQUpPUWlIc255emdqYmpudHpFUWZvMzhGSUx2?=
 =?utf-8?B?WE5mSWY1cXVjZzlWV3lyeHBBeTFBM0JzYlBxSlB1eWZrQ3QwKzVwYnFSWHRM?=
 =?utf-8?B?VHg0NkswQjZQYk5tRlFaak5YN0FYRjM1Z2RLYlhYSE9WU0ZsV255Q2NMNHdn?=
 =?utf-8?B?ZmVxZzZzd21CSEtKVzZFRkp4MTdhUGxpUzdSQXFMMk1hR3JMYXB1WkpRUG8y?=
 =?utf-8?B?UzNOOTVuRThGdWVnVVRXL0FES1NjN0JvVld5UXZidkZESStZL1Y4Mk0xQlhT?=
 =?utf-8?B?OHNneE1sSmEzdmZTTmROVVl4WkZLa1VZbnNpcWdZTWtzS0c1dmF3eHlXQWNC?=
 =?utf-8?B?TGt1aEU0ajBBMWo5VTM5L1lGdDZOaU5KN05MZDRVZk13Z25oL0cyMEJ2UEsw?=
 =?utf-8?B?STNhbGxNUStRNlloTkErUXlxZVlKUWFBKzhXWEJTN294UDJnZUxPdWlpUWpp?=
 =?utf-8?B?SytYc1FUV3Q2S2RZSUdNdFIyd2FMYWhvNW1laFgwejZiMDYyUmU2M1JZUkJP?=
 =?utf-8?B?ekNiaVhYV1BiV3IzVDVRL2tncmRCZjB6RXFCSzlUYVQ3VkZVeE1veXIvTytz?=
 =?utf-8?B?blM1WVB2a1RYejBnN3FpalYxWE53bEtkQkNaRGhpbUU4Qk93ZkFtS1BPUXFU?=
 =?utf-8?B?RFhFWkY0dTBvL2l3TEh5d0NVNDNVWXE3OEVHb0NaTDVJVk1QdSt6bVVTZ2ZG?=
 =?utf-8?B?R1NhYTgyNEZXaTQxVDlGZHEyd1U4UGJ3NDdmblhnOTNuSU9yeW1HbmlHQ2wx?=
 =?utf-8?B?azFnVXZaWEQrd2RSTDYvVXRvd2w3aXRRdWJZemRVWElsbjNHekNhK0VaVzdF?=
 =?utf-8?B?KzAwbkkzZklrWld6RERHSGpUL1VKWE54ZUQ0TTRaVzFNSllTaEluQW1IRUhM?=
 =?utf-8?B?ekFFaVFnT3hNV3RqZWE2aXFZL2xVZXd4YWZ4SmNMR0hQQzNZdkF1QXYrdDB6?=
 =?utf-8?B?VURTMVU5cm5PbDZnNWhYbVpQOUhvK0g4bk9ST0Z6a1Q0WWlPOXlCQzlod0Fn?=
 =?utf-8?B?amREQUhZNG5HU0lLeFB6MnBuZmcrY2JMcisvMDRFVE5tVjMyNGpIWm91eXdK?=
 =?utf-8?B?ZWhiWUVsZFhoNStNYmJ6cVpNWkJsRDdSTFNmOExWb29QY3EzK3VvSmUrMkZq?=
 =?utf-8?B?RUlSN3pvUUgzNi9BR0pXR1hUSDh6RlRibUN3WURMZ0FUb3VVS0VsN3Y1QzJ0?=
 =?utf-8?B?S1ZTZlNKTGU3M3A0cVYzR0hDUUdWNFRCR1FDaGp4Ky80ZjJwaXZ5YlQxTlRS?=
 =?utf-8?B?WEhDWXZyd28remFqc0ZXVkJKb1U1MDFKVm0ydEptenJkdE1Qd0hXOTIyTXFH?=
 =?utf-8?B?K1o2a295M0psbnkvT1ByRUJYM3lhb0tnUDlMaHhublYwd3RTOUIzOExreG9j?=
 =?utf-8?B?WkxCVm9DZlJwaGpGTTdJU3dRbGovaHJXbTFBMTQ3Z0hyYnAveWJnYmlYcTRO?=
 =?utf-8?B?UnZVTGhRNjRQWGhKeDhmNHRrWjF3c3BlOFppK2NkSExnT0lXdFlCV2JhSXVn?=
 =?utf-8?B?QU0xcElRbERaNlpyWXNMdmU4VzNIZE5sb01UT0ZlazE0NWcyVHpPMnkzTHg5?=
 =?utf-8?B?c3A2YVhHYnJ6cTNEUnBKQ3lnRjdxbjdlLzVpRVc3ZWFQL0xzMzNRVEJjSC9w?=
 =?utf-8?B?Q3lORmJpRDVOTUkzM29ITTZ3Q0ZndEZGNGoycUwzY0FFdG5rV1VpSDNJdWlv?=
 =?utf-8?B?cWwrdzlxRmx5YUpULytPZmJrZkRDSWNoUS8reXZxWjRtU3VnQWsyTWRzd0hO?=
 =?utf-8?B?SSt4UlVKdlJ4bWh4VEFxUk5FWWNnUHN0bkE4MUtVQ3RNSlRKWVRCWHNYbUFo?=
 =?utf-8?B?WjV4STlNdENWR0h1cXlVV25UYjlYTzNlT0R6MCtHV3FzWmcwdEFoaWdyRmtM?=
 =?utf-8?B?R0tjeXdFRzlFQXdhR2ZRbEFTaWN0ZTE4eFVGUE5vcVNBZll3bTZWaW05K3pO?=
 =?utf-8?Q?gr2pziPddR4mh4Cfvh94KHDqn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49088add-c50a-4165-c8dd-08dc3eb56feb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 14:46:56.9152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vDObHr07ic0abW66NeF/DcVJLhCI+UHZNr7A0qXeCBMFv0uRrOKhA8dM+advRdoAm3aLl5REcZ51YaibcXmdkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9018

Hey Jonathan, thanks for taking a look!

On 3/7/24 6:09 AM, Jonathan Cameron wrote:
> On Mon, 26 Feb 2024 16:27:02 -0600
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
>> Remove CXL protocol error types from the EINJ module and move them to
>> a new einj_cxl module. The einj_cxl module implements the necessary
>> handling for CXL protocol error injection and exposes an API for the
>> CXL core to use said functionality. Because the CXL error types
>> require special handling, only allow them to be injected through the
>> einj_cxl module and return an error when attempting to inject through
>> "regular" EINJ.
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> Hi Ben,
> 
> Some minor comments inline given you are doing a v15 (yikes!)
> 

Yeah I know :(.

> Jonathan
> 
>> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj-core.c
>> similarity index 94%
>> rename from drivers/acpi/apei/einj.c
>> rename to drivers/acpi/apei/einj-core.c
>> index 937c69844dac..1a5f53d81d09 100644
>> --- a/drivers/acpi/apei/einj.c
>> +++ b/drivers/acpi/apei/einj-core.c
> 
> ...
> 
>> @@ -640,29 +648,21 @@ static int available_error_type_show(struct seq_file *m, void *v)
>>  
>>  DEFINE_SHOW_ATTRIBUTE(available_error_type);
>>  
>> -static int error_type_get(void *data, u64 *val)
>> -{
>> -	*val = error_type;
>> -
>> -	return 0;
>> -}
>> -
>> -static int error_type_set(void *data, u64 val)
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
>> @@ -671,9 +671,37 @@ static int error_type_set(void *data, u64 val)
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
>> +bool einj_is_cxl_error_type(u64 type)
>> +{
>> +	return (type & CXL_ERROR_MASK) && (!(type & ACPI5_VENDOR_BIT));
>> +}
>> +
>> +static int error_type_get(void *data, u64 *val)
> This is reordered, but fairly sure no need to do so and it will
> make patch cleaner to leave it above the validation code.
> 

Sorry it's been a bit, but I think I moved it to go with the other error_type
functions. I don't mind leaving it where it was though.

>> +{
>> +	*val = error_type;
>> +
>> +	return 0;
>> +}
>> +
>> +static int error_type_set(void *data, u64 val)
>> +{
>> +	int rc;
>> +
>> +	/* CXL error types have to be injected from cxl debugfs */
>> +	if (einj_is_cxl_error_type(val))
>> +		return -EINVAL;
>> +
>> +	rc = einj_validate_error_type(val);
> 
> Trivial but I'd have preferred this factoring out in a precursor patch
> just to make reviewing this a tiny bit easier.
> 

It would probably make sense, but at this point I just want to get this
across the finish line :).

> 
>> +	if (rc)
>> +		return rc;
>> +
>>  	error_type = val;
>>  
>>  	return 0;
>> diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
>> new file mode 100644
>> index 000000000000..34badc6a801e
>> --- /dev/null
>> +++ b/drivers/acpi/apei/einj-cxl.c
>> @@ -0,0 +1,120 @@
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
>> +#include <linux/debugfs.h>
> Follow include what you use principles a little closer
> (there are always exceptions in kernel world...).
> The following seems resonable to me.
> 
> #include <linux/array_size.h>
> #include <linux/seq_file.h>
> 

Will do!

> 
>> +
>> +#include "apei-internal.h"
>> +
>> +/* Defined in einj-core.c */
>> +extern bool einj_initialized;
>> +
>> +static struct { u32 mask; const char *str; } const einj_cxl_error_type_string[] = {
>> +	{ BIT(12), "CXL.cache Protocol Correctable" },
> 
> Use the defines for the bits? Not sure why the original code didn't do so other
> than maybe long line lengths?
> 

I agree, this was merged from some ACPI tree changes in rc4 and I don't think
they have the defines in that tree yet.

> 
> 
>> +	{ BIT(13), "CXL.cache Protocol Uncorrectable non-fatal" },
>> +	{ BIT(14), "CXL.cache Protocol Uncorrectable fatal" },
>> +	{ BIT(15), "CXL.mem Protocol Correctable" },
>> +	{ BIT(16), "CXL.mem Protocol Uncorrectable non-fatal" },
>> +	{ BIT(17), "CXL.mem Protocol Uncorrectable fatal" },
>> +};
>> +
>> +int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
>> +{
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
>> +		cxl_err = ACPI_EINJ_CXL_CACHE_CORRECTABLE << pos;
> Hmm. This is a little ugly.
> Could do something like the following bit it's of similar level of ugly
> so up to you.
> 
> 	int bit_pos = ACPI_EINJ_CXL_CACHE_CORRECTABLE;
> 	for_each_bit_set_bit_from(bit_pos, &available_error_type,
> 			     ARRAY_SIZE(einj_cxl_error_type_string)) {
> 		int pos = bit_pos - ACPI_EINJ_CXL_CACHE_CORRECTABLE;
> 	

I agree it's ugly. I think this version has the added benfit of parity
with einj_available_error_type_show() in einj-core.c, so I think it's
better to keep it this way if it's the same to you.

> 	
> 
>> +
>> +		if (available_error_type & cxl_err)
>> +			seq_printf(m, "0x%08x\t%s\n",
>> +				   einj_cxl_error_type_string[pos].mask,
>> +				   einj_cxl_error_type_string[pos].str);
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(einj_cxl_available_error_type_show, CXL);
> 
> 
>> diff --git a/include/linux/einj-cxl.h b/include/linux/einj-cxl.h
>> new file mode 100644
>> index 000000000000..4a1f4600539a
>> --- /dev/null
>> +++ b/include/linux/einj-cxl.h
>> @@ -0,0 +1,40 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * CXL protocol Error INJection support.
>> + *
>> + * Copyright (c) 2023 Advanced Micro Devices, Inc.
>> + * All Rights Reserved.
>> + *
>> + * Author: Ben Cheatham <benjamin.cheatham@amd.com>
>> + */
>> +#ifndef EINJ_CXL_H
>> +#define EINJ_CXL_H
>> +
>> +#include <linux/pci.h>
> Use a forwards def
> 
> struct pci_dev;
> 
> and drop the include. Also need
> 
> struct seq_file;
> 

Will do.

> 
>> +
>> +#if IS_ENABLED(CONFIG_ACPI_APEI_EINJ_CXL)
>> +int einj_cxl_available_error_type_show(struct seq_file *m, void *v);
>> +int einj_cxl_inject_error(struct pci_dev *dport_dev, u64 type);
>> +int einj_cxl_inject_rch_error(u64 rcrb, u64 type);
>> +bool einj_cxl_is_initialized(void);
>> +#else /* !IS_ENABLED(CONFIG_ACPI_APEI_EINJ_CXL) */
>> +static inline int einj_cxl_available_error_type_show(struct seq_file *m,
>> +						     void *v)
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
>> +static inline bool einj_cxl_is_initialized(void) { return false; }
>> +#endif /* CONFIG_ACPI_APEI_EINJ_CXL */
>> +
>> +#endif /* EINJ_CXL_H */
> 

