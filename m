Return-Path: <linux-acpi+bounces-3541-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EF48566C9
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 16:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61ED21C213A5
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 15:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4D313248D;
	Thu, 15 Feb 2024 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cBWfdJF3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C673212EBDB;
	Thu, 15 Feb 2024 15:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708009307; cv=fail; b=OF6XwBHMI/FrKpYknAKLmSXnbB4W7GVbLr6c2/iaPMPlDrNFGVxif3p0t1y+I6lzznfJo1kUR2hFcxE0l/yU4hzQVQgf2x2zMvd9xFBtxZjWvCvznLZ96bqkVdVJHT82KXLF4Y//Yx58bEehxd+558afzDg5qstm24XOCEzNWgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708009307; c=relaxed/simple;
	bh=3f28mxyZlzE/RNoYK2KLhaX2ggYbx+EPOkLlsxeizQ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hYdVJ/Bo6K4YOZ+Bw3FFYencerSBR3VVXjRGxVwE8+013+Zm6NDYpWDfuk4VH9F1sDhDgC+CpKtBY7tVSe8ZmE0k6g68wajV78NbEpESJNAA72kjLRO1wqsyYC9A+SkQ7fA3ay26Xs2ZnWYAzk+jdea1WzwMg6ulrskEShdFU5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cBWfdJF3; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9JgAGn/ua7XgMeN4x49tXOw9qrUpeO6hFhd5EJHop7oqQ7MSWGEdTjFQ8O7yEsaVAiDjmbGP/+SauJ5s/Xg52MpmVtr7aE4Nwg06kHniqaZLXecN1FNicKBIVQObP5A5UKWjlIdgljfXwFpJCPBQnEQB3KiHQMfXqkTDlXt95NVOQJrVohVGaVqs+kPq1xruubgPWWOcMQStCD8kWp1J/11r3JBDsAmmzQg6WKPWIXjoiEIKqzQEmD5E1PiuFYBgzfe+ivxv7RSZo95BkBXxkBCV0QTzmpzuLm2Xg+d+HNWdcWE9Q6V1kop97Hb8K40PZY4IaxmyWsjwtgYODfP1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUhrc7V6vjYszv52S94EELGNw/HoUTgqqJogsTKwrLE=;
 b=gq3GVeTpGxFFQ4XC0qvBFLZPX1IQtTKqw2qpIk0Wpw77Tne2pBHEUQlhJwIxOX4DD6e/wpNRTErrLzsYkSqBVPCk6BF3V3HknW/YNIJmORMWRRycZr+zvquOGf1ZPOO92xhXrqbdERsLo4mDjFms7PCbxMjnGb/qtPI8pIblr2qqmhLEcYYJwbE2KZHp+TwUujTwO75QgF6AiYcM/0C4+7oXwGG7ONF4W7tG4eAq6A58Yewh2U+WgiMoE/JyzU6JM4fQW0r3VCvRW1ziTmEga1ffIZDmNNod2d6YDq82GaJmfm/jwxyI2CmaSineT84WpJbJtajqBMTGwYbXmL2aqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUhrc7V6vjYszv52S94EELGNw/HoUTgqqJogsTKwrLE=;
 b=cBWfdJF3kRczrnfBzkRoBd+HJ3Bc6tcTNRPLzkzrD34KH4m3S9vH4SCZL8C/RocEWM19ykEOsjj4dE7FG3OxMfxNYGqH3BSC+DBBhMvJ88BXdVqcbi8gqcxnutXfrZzDMB/O/o7buXLHLgmP5shOitigxRrfk1dtIRcAClWBoNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by CH0PR12MB5314.namprd12.prod.outlook.com (2603:10b6:610:d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Thu, 15 Feb
 2024 15:01:42 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::d493:7200:e0ae:1458]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::d493:7200:e0ae:1458%7]) with mapi id 15.20.7316.012; Thu, 15 Feb 2024
 15:01:42 +0000
Message-ID: <e1c652aa-830f-48c8-85ed-b00a7c153efe@amd.com>
Date: Thu, 15 Feb 2024 09:01:36 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/3] cxl/core, EINJ: Add EINJ CXL debugfs files and
 EINJ helper functions
To: Dan Williams <dan.j.williams@intel.com>, jonathan.cameron@huawei.com,
 rafael@kernel.org, james.morse@arm.com, tony.luck@intel.com, bp@alien8.de
Cc: dave@stogolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20240214200709.777166-1-Benjamin.Cheatham@amd.com>
 <20240214200709.777166-3-Benjamin.Cheatham@amd.com>
 <65cd76286de08_29b129412@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <65cd76286de08_29b129412@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0071.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::23) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|CH0PR12MB5314:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a97cfb-67d4-4bbd-b5d5-08dc2e370501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pIReyTlPobUV2TQ6C2akvwrZ0zd2iSOL0DLocvl9x3pXgNanA5XXi2DRjlVqME9KhXBoQeSUup0+jMFAjFqX904UcjlmEvMNYlcI23DNobyfHnydTTPHP+VA1aDZWLu/jQ7KADhYMji1oMlxyu2Fa/QqDctPK4wYklLS+bJITMqat0lusYG92YQgl2M1QJ+zdhkf7+JZQW7J9zQpSz4KznS1tmjy7xOHuETaFsBGTNo5fk9r0jvDsRSF1MakDivpcVukvbC68s70QRYmkT1KfhUV0P3ubyQ8oQhQ1pCoTPUXFF8Neo9nTe/GOiQC1OG7UWqeDcOt6flw/0Wee/gxC3NBG4qj+txkbZhOiNm96d+IiGEednLOX9ysbYZof8lk9SneGRMCaY821CuRkeeg3HXEW8BBNpxsiZjO865J+hgU/k8JC/D2bi655vKbcySdt4JPREIrgORXrQLIuJ8hE6jlsHs9Q749Atbjo9ed2mVBGn87s4m1PgbEZQvMJ89snOoveSlUc1kwBhSCkC6yDHCW9SDRHVNuVRKBut2uhr4QHDq0Ogo2OPiwXhZUSpyo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(39860400002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(31686004)(7416002)(6506007)(8676002)(26005)(38100700002)(83380400001)(6666004)(66476007)(2906002)(4326008)(316002)(8936002)(66556008)(5660300002)(36756003)(66946007)(478600001)(6512007)(2616005)(53546011)(86362001)(6486002)(31696002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGdaeDBQQVhiNmZnWVB1SXdlSVR6cjY4M3YzOEt0UGNObmM3MklXUkgxOW94?=
 =?utf-8?B?YS9RV1lYNEtKUzc5eE5vTFR4aGxabWdRWnQwaTA2VlE5NFJ4dy9kR1Bvd0lJ?=
 =?utf-8?B?eEJoSkJxL1hGOVVOMUJjTE82c0dyNTdaU056VkdYOHdpeFZETWFjeGMxU3Fv?=
 =?utf-8?B?TWx6M3UzOVQ5cVFmMm95NlcvbmY3c3pYbnhCamVJY25LT0pyU3p2TEtrOWVO?=
 =?utf-8?B?UCtTSTZLM0VyMTl0cVNKVGNCQUFVejQwTTBHNmptczhlSVdyYUx2anV3c2Y2?=
 =?utf-8?B?dVBMVi9IeUV6c1A1NmgvL0hOQnFOc3cwSDhlNEVvSzIzZTJ2VWRsMDVoTzEv?=
 =?utf-8?B?Vk1jZFBSZnhURXRnYUtCajQxeFRWSmxuYmhsK3JjVlBqWkI4WnJFZmI2bkNx?=
 =?utf-8?B?M0ExOVRodTRXaXhMVW84dXJJSVdQYU1qVVNFaFRVUnJyUTRYRzVFaTNjdG9s?=
 =?utf-8?B?NWw4eTVKYXZWSGdiMVpxN2xwZnNZUTBSbWpnUHIxZCsvN3pLeTBzLy9BM28x?=
 =?utf-8?B?S0N2bGpFUUlFTFVsbzdFRXVOc0RBZ0ZNdldxVnEydzlpM0RicE1oV0dVSXZy?=
 =?utf-8?B?S2Y3Nmt4a2tjbHUyaTgvTGRJaG1hTHpqTG1UbUk4MENPejBwRkpxb3hrdk00?=
 =?utf-8?B?RFF2Q2t3cGJRbzBrRXRDZHV1TnJxcG83RGNDTW41Y29SOUFjTjVUUkNrNE9J?=
 =?utf-8?B?NjhjRjQ0cXRIblV1U1RXVVRaUHFaaWoyYWZHakF3MGRZcmE4UkZmVnJyc1RG?=
 =?utf-8?B?dEtlenl2c0R6V3VNaHd3ZnlpbXhFMDAxOCtCcnFESmNIb2xlME84RVB2MllB?=
 =?utf-8?B?cFNmZXNuNU4wM2lEMllORVpGMm5OOWVQaEZhU0ZoRmZleWNubklOU2NxNTYy?=
 =?utf-8?B?TXF4cEtOOU5qSjVBZ2xMVG9CMStlWkRCV3NYdlNuZFpHN1JydnJQNmx1c3hM?=
 =?utf-8?B?NUcrUnpUY2JZZm1hT1BEV0labktSWmFHQ3J0MVdwS3NBajJZUEU5eWJ0b3pZ?=
 =?utf-8?B?UnVUaURhWElTbm9LSVdWbnlyRGd0NVB6RlZaVHROMXMvQ0JXT29xS1N3MlY2?=
 =?utf-8?B?djZqdFFHNnpEZllVME45UTFDcDZRakVWdGMwVW1KRUpyZHdpSDVPRVUyMnZu?=
 =?utf-8?B?Z2svRE0vN1Y3dVN6K1BOL0xwWWNFUlpwSlBnS0pZUWl2alRrR1UvVHhNNE9w?=
 =?utf-8?B?SkQxMHdXK0Y0RTE2b21sa2dEelcwTzZQM093T0dQMGZiOW80ZEdHcGFlL04y?=
 =?utf-8?B?d0dLeHNTMXBQVXkvUnFTZFhZSEU0Sm9yY0ZQTW5xTElmSjViZkk3d2xDb3JQ?=
 =?utf-8?B?ZlVtZVFuMFMvRmdUZHl0ZTlSTnFRcmJiTWRTOWdsZXRhbVh4Y3ZFUlZFbkYz?=
 =?utf-8?B?N1FkQ0R1VEhLYy9jZ2h1Rjc3T3E3ME1LTnlQdEtsOVNIVFlMVTVxQkJWSzVX?=
 =?utf-8?B?cjlteEpjV3dlK0dpUDBGOENuZTM2eWt2OTl6TnA4dFE3QUlWNGVHckpKYXZu?=
 =?utf-8?B?TWZGSi9rdkwrRXVjVVNIZUVzQWMvaGRQcmZGMW9RalQxWTBJWXl6bmUzaTZZ?=
 =?utf-8?B?Rk90VUdBeEExVTJEYS9rK0YzNEU1aWpJbjlGODNoNEUwdGNia01Ia2RhUDgy?=
 =?utf-8?B?akoxcEJPSk45ZjZxZDBnZmk4RzFRQ3Y3QVM3K2RsSWxhd3NDSU1mdGFWRHYr?=
 =?utf-8?B?ZzFscStlVHRsL2d6cDZxNWYzazlzM0k3SHR2Rm5DRkdyYmVkMGhyVVhFNTF2?=
 =?utf-8?B?bXc2am1pNmlXSU5jM0FHZ01iSWFEMkRqMzQvRE9IMWlpOVpiOUVETzFseTBn?=
 =?utf-8?B?ME9JbWZ5ZnpXQjl5ckVhaGEwa3dpMy90MkZ2aWFnK0IxQTFtYmxKVjdwREhv?=
 =?utf-8?B?dWRqbVNZUm5QWGlqQnNzbXJma2NvTzhyODdYQlVHMUlUOHhNQzFpWE5QV3FU?=
 =?utf-8?B?a0ZwSUROcDUycWxqU2ZvaFhKZjljNURoQi9uOW8wWVJQTlk1bHBnK0ZnK05l?=
 =?utf-8?B?ZkJtcGl1ejZyVnBlVEQ5aVBncE16RGlLb3JxVjNsbFc4U3FsZ2IzU1A5QWQ4?=
 =?utf-8?B?Q1ZMTnZ0S0tMWHdLYm9LZnlJRzZVL2hTN1dSZnJ3RlVWdXpvOUFjb2hVQ1Y3?=
 =?utf-8?Q?MpbexwB9iIo293kmEGiRYWE2R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a97cfb-67d4-4bbd-b5d5-08dc2e370501
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 15:01:42.3621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M6vZED/gSN6Cy3VLJhUhtQvYWTish/KxvtrwYjMMMsOwMU1CPky0QtZIwOyvMv9E4n2U5xetlczXL6hz5ZlGzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5314



On 2/14/24 8:25 PM, Dan Williams wrote:
> Ben Cheatham wrote:
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
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> [..]
>> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
>> index 67998dbd1d46..d1fc3ce31fbb 100644
>> --- a/drivers/cxl/Kconfig
>> +++ b/drivers/cxl/Kconfig
>> @@ -157,4 +157,16 @@ config CXL_PMU
>>  	  monitoring units and provide standard perf based interfaces.
>>  
>>  	  If unsure say 'm'.
>> +
>> +config CXL_EINJ
>> +	bool "CXL Error INJection Support"
>> +	default ACPI_APEI_EINJ
>> +	depends on ACPI_APEI_EINJ = CXL_BUS
> 
> So I do not see CONFIG_CXL_EINJ used anywhere, not in a Makefile, not in
> a header file. My expectation is that if this variable is not set then
> no symbols from einj.ko are consumed by cxl_core.ko.
> 

Yeah, you're right. More on this below.

>> +	help
>> +	  Support for CXL protocol Error INJection through debugfs/cxl.
>> +	  Availability and which errors are supported is dependent on
>> +	  the host platform. Look to ACPI v6.5 section 18.6.4 and kernel
>> +	  EINJ documentation for more information.
>> +
>> +	  If unsure say 'n'
>>  endif
> [..]
>> diff --git a/include/linux/einj-cxl.h b/include/linux/einj-cxl.h
>> new file mode 100644
>> index 000000000000..92c0e2e37ad9
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
>> +#ifndef CXL_EINJ_H
>> +#define CXL_EINJ_H
>> +
>> +#include <linux/pci.h>
>> +
>> +#if IS_ENABLED(CONFIG_ACPI_APEI_EINJ)
> 
> Per above this needs to be IS_ENABLED(CONFIG_CXL_EINJ), otherwise what's
> the point of the config symbol?
> 

So I've tried changing this to IS_ENABLED(CONFIG_CXL_EINJ) and always get redefinition
errors that I can't figure out how to get around cleanly. I should've elaborated more
in the last revision, but part of changing the dependency rule from ACPI_APEI_EINJ >= CXL_BUS
to ACPI_APEI_EINJ = CXL_BUS is that the above guard stays as IS_ENABLED(CONFIG_ACPI_APEI_EINJ).

I'm pretty sure the only thing this symbol is doing is enforcing the above dependency.
I would love to be able to remove it at this point, but doing so would require moving the
dependency to either the EINJ or CXL core modules, which sounds worse. I could implement
one of the other solutions I outlined last revision, but I don't particularly like any of
those (and I know you don't either :)).

I think the solution here is to move the einj_cxl functions into a new file, gate that
file by CONFIG_CXL_EINJ (or change the name to CONFIG_EINJ_CXL to match einj-cxl.h),
and add declarations of the functions in the EINJ module used by said functions to
drivers/acpi/apei/apei-internal.h. I'm not sure of another approach at this point,
but if you have suggestions I'd be very happy to hear them!

Thanks,
Ben

>> +int einj_cxl_available_error_type_show(struct seq_file *m, void *v);
>> +int einj_cxl_inject_error(struct pci_dev *dport_dev, u64 type);
>> +int einj_cxl_inject_rch_error(u64 rcrb, u64 type);
>> +bool einj_is_initialized(void);
>> +#else // !IS_ENABLED(CONFIG_ACPI_APEI_EINJ)
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
>> +static inline bool einj_is_initialized(void) { return false; }
>> +#endif // CONFIG_ACPI_APEI_EINJ
>> +
>> +#endif // CXL_EINJ_H
>> -- 
>> 2.34.1
>>
>>
> 
> 
> 

