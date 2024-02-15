Return-Path: <linux-acpi+bounces-3542-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 931CA8566CA
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 16:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B773D1C21547
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 15:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5EE132C05;
	Thu, 15 Feb 2024 15:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nDo70MEp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF075132C0C;
	Thu, 15 Feb 2024 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708009313; cv=fail; b=RSy9Vzh4IO/O4IMW4no1YG4PUMhzJMM72gibLK/LDHfEd9Q5e7YFYggq5wnmbAOv/n2k7t32bKdW/tLPEvRZmiCuGWnWcl7EH/GDg+lsPVxrmcnwwiRpurB5YBQWaGn55xBe2YisxJfMPDH8zkrQykUhZ1mItEjMHbhvcEGBqbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708009313; c=relaxed/simple;
	bh=TRvmQsZgepgJ5xn/LwcaDovkQfVuoC7yIcDkj/tZfNQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cEuMHKkQ2pLuMStQ+q32e9zkiBEOqNrpHv3xmPiVhvY3r3yIYJEsOMiovyOZ2qUQMQXMjvDZBUskwQdSSjPgDm38SXoKqSq38xMKp5Vzd3Wz27MEWlmPyhNy28f/GqdBr3G8rGdhrxFPySniil9hGg3+v71dtFtpmYq9hOoZbk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nDo70MEp; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9MfpxeuVLN0HGqXR58Xqy4z5YEAkvxDgSX1H+br98MSEWBb6dzHlfLVF1S2hWg0aVVwHbSwqPAloZoH8Kbu+/4cyKWNpdkak4XyeZorveSVH44DKdhINfJb1zNaMIcCcsszETdL8lns9LP6qpVmUGA0eK+QjO7b5JWMpEkuXQKxOSXUA5OKPjLGo/CNYi3An5z4cbZtqnEIIrVIuwl2O0IwDkqRJQhO1dYaR5jRifkiDN1gcw5dAFbI8pg5bz7ydzL2/F/IqJ6ZmExXts2/68WeI+mPQwsMMBdNX9yeKGJuEbQvmvwSc8idx3KbVga6vzkNJVh7WBlxe879CSUQ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGNqecfdGiqx5yV8B4bjFIlUYSjRlrMlBuA0IDT/bII=;
 b=NrH+1EQu3j67RqkQK1blHrL+YOLkA4GnZ09tHFJcXtmrKyTkO+UOFa9+tS4/SFap+5Woe4SKxRGqupRGBspWSSWU0lURjRkG2GwC/nIYeRyBckZFq3jbIf2OYSvksvZYN50cN8NMd2cea9NajpprGV7lbudbQxxUlQWPLreJ/yg0FGPMCkHsidF/Ox9yL0M1QACUE8LxrFHJgLPKboKSfOHpug+sImcfMmy8GmBBGvavpXBv35EJRF2qBS3LZ63SXFuWb2HPPOEeZJoqx7w3gcctTBTRl60XPXyiZfBBuazgnZUS1SG2xFOHbsX4mype6hpUpNEfdUWzv587oBzhrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGNqecfdGiqx5yV8B4bjFIlUYSjRlrMlBuA0IDT/bII=;
 b=nDo70MEplYPtTxhXBF0Hs0sdKKXatIOr1q6tHeYNCSgcmjklM4uxRpC0DUrnmHFdtpRV7R2qc9M0Yy1/UyxIdqDuVAK1wp2mY2GwoUCrNYF9cBMZ5Kp1hHC9w28WjEvM/OA5jqFjQiDyskCA5YD8WdHg/tUOCDpFwrf8mEaet1w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by DM8PR12MB5414.namprd12.prod.outlook.com (2603:10b6:8:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Thu, 15 Feb
 2024 15:01:49 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::d493:7200:e0ae:1458]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::d493:7200:e0ae:1458%7]) with mapi id 15.20.7316.012; Thu, 15 Feb 2024
 15:01:49 +0000
Message-ID: <adf4aaf7-4767-4589-b395-bfacf6d0b381@amd.com>
Date: Thu, 15 Feb 2024 09:01:44 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/3] cxl/core, EINJ: Add EINJ CXL debugfs files and
 EINJ helper functions
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: dan.j.williams@intel.com, rafael@kernel.org, james.morse@arm.com,
 tony.luck@intel.com, bp@alien8.de, dave@stogolabs.net, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20240214200709.777166-1-Benjamin.Cheatham@amd.com>
 <20240214200709.777166-3-Benjamin.Cheatham@amd.com>
 <20240215093322.00000a5e@Huawei.com>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20240215093322.00000a5e@Huawei.com>
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
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|DM8PR12MB5414:EE_
X-MS-Office365-Filtering-Correlation-Id: d608401f-0833-409a-96b4-08dc2e370942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4M5wn/AJ+i2ahWgHMVfYpLchyd+8Fd9vG3NexGJfjjha0LdwWjelPwqRWAN6zmal9yfmYniNjtOWrkMTW5MmHqW4FAlLVIkCqN6BM/VbeAcn7/TnQ0dLmZAhWrhGai5KENwKuGA29uA0N1ytqV+/a9FTsa0py9y5sEpbil+JUVm0CUeoMT6D4krfXMYSyCLJ4Vv0VKc20293oYxg+AP0o1Vf7qNi29IcIr7II+CwW8DHnV5VOs2LOun1gSDYtSugm0vBfR6KSI9IyySGz/8IYu+TU6PtaQmeQF1M6+Flocn49bZmkvwpnOk4LO4X3M4BRri4ZVBlM16NKXNsNiSnYxHYZT59bh1LPAiF6akwPRbq/ZVuXk823vSD1cWQ39ewgEj+xXfR8TuOnkziUWKYb0APg5xh4tYhCVH0jomnlSJ2xuhaWgU6e0vHBGZqDSNrLsC7v2M7wjjAJlghIYgDUzMZhYVCu6njmXhrP6d3YlGTHk9OkM1uE93d4Bt6TrK9MgI2OSIfAeaVPT7hoUtCfymVjGCjGmhHwWVv2UHml1H5WzFkUgzT9e9cUrzD0wgc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(39860400002)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(8676002)(8936002)(4326008)(5660300002)(7416002)(2906002)(83380400001)(26005)(31696002)(36756003)(38100700002)(86362001)(53546011)(66556008)(66476007)(316002)(2616005)(6916009)(66946007)(6506007)(6666004)(6486002)(478600001)(6512007)(31686004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHVEaXhxZTc1N2JUcTBFYTJBbFh5SVg3R3FGSUhqNXQ3aDJGNkdnbzZEU2xr?=
 =?utf-8?B?OXZINzJZelBhbW9GQkVXSi9tcGFaKzdmcmdYTUVYZ0h4aDh1M0p3cDlKK0xK?=
 =?utf-8?B?QWZxd3l6QjR0T1IzTW1HUWg4YzUzMjd5ODM2WUNIYWQ1T25XMThjK3hSdTND?=
 =?utf-8?B?eThFcmd0L1BXNmc2Z3E4QzRyWm1EdUZsRFNjeE1MRG1OVWx5ZGNmV1V6dFZJ?=
 =?utf-8?B?Rm44ZnlBSlZlbmhGbTlhUWc5Z1paajhaeUNXZ1ptaFloWk5MdXE5Yy9iVmtK?=
 =?utf-8?B?NVZzaUtBOS94cFVvSytMdmFUdlNpUXRGdDBYV0I0ejlJREpZUUI0NHo4aTBT?=
 =?utf-8?B?SDBLdWY2UGYzQ2IrSm9XL2dUM296UGdyZFk0S3haSVZGM0FZTkFvRGozVEZn?=
 =?utf-8?B?UU1jVllZMHhGRXZsdksvYUhDbVlpS0pzY2hFcFdvNlFFSzlyUTAzaWNnMFgv?=
 =?utf-8?B?bVArTVRyRzlNVDFQa1hyazV6SXoxRHliaUdCZG5JUnZMTHZmZkR4cEdjU2RP?=
 =?utf-8?B?bVliY25hMFVuZ3JuTThQMWFock9Tc00zVnRYRGF1Zm1MV3VPMUpjcUd6UXgz?=
 =?utf-8?B?bjZ2RUtadi9kcUNOR0dLVUtMY3dEUVl5Q1BBZ3hZYldrRW9pUGl2RGhtM3Z1?=
 =?utf-8?B?OVordng3RHRMMHJIV20xWWpGblhQZnY3cmZwbmVQek5qdFBIUFcyL3NDY2g1?=
 =?utf-8?B?VDl4YnYvVGwvby82L05JTVZuN05EYVFHODB0T2tuVTJ4ajdJMlpWcTkrbTRU?=
 =?utf-8?B?VHhNSFRaZ2trSEJraWJTczQwL3UxMjRVc3BmdFExa2JKR01SMEZaYWlKb3Rn?=
 =?utf-8?B?NDlJSHJLRjdoLy8zSTNwYVh0bW4vMno4d2R4OTd5b1FUaTZCTkhtdWZNd1pl?=
 =?utf-8?B?VS9CN0Jaald2UUdHRkFLMnhienRuVitGZTgxU3ZvMG85ZVZsNVRCdHhXbTB4?=
 =?utf-8?B?eG9WMUdYUTVJZFpWVTl1LzZKenFZQmhVcnAzaVJvYzdseC9RK1lQa241cHhT?=
 =?utf-8?B?Y1AzR1RVRlF0RWxsNDdXSnZLcVVQYzJ3RW5MTk5BbTlxTkI3OUF2YUF6V2Nw?=
 =?utf-8?B?YWJQd2JLcDhkOGlhQUlIaWVua0hMeHVGU0R1T2lMT1hzN3ordGdtRXdnQ1Ns?=
 =?utf-8?B?ZWx4YlJOa3o2c0VGZmZmMkNHS1N4MVhiTzExdERXWUpYYW5DTFZwc2xCakpt?=
 =?utf-8?B?dTFYdi9WZ0h4OVlXMUlzWER6MXNuZnBPTWFidTFGS3JlZlBmU3BQWTJFMkxL?=
 =?utf-8?B?aDBlYzliZi9QWDVPcmVPdEVaSWQwbTQ0VklDdS92OVlNVG1WNnR2aGhWOUhR?=
 =?utf-8?B?L0tUOVNXOUJUa0pzWFRMZlcrNW5lL2g2QjR5dUYrVXpTYUNreEFBUlpiMGU0?=
 =?utf-8?B?VUhnbU9yOGxpNkh5Ui9rV2txUlp1cUxWaHdnOE9VYy9IZnVuY3hmTEU5Zm9M?=
 =?utf-8?B?dm1ZQnpZK1hpZGxRb3BuL2Y0bEc1bVpQUWxyYTY1cWJPellSU2xidjFYcmdo?=
 =?utf-8?B?cGk1MlVTZUJGRWRIT3ZRZUY0N0RkbHV4TWpRaTJKYm5Yb1V2dS9heXE0ZXVW?=
 =?utf-8?B?NHlobzdxRWhMMS95enZ3UEduRmUxK0gvZ0MvSnVrY0p2K0EvUFVSSmhQU2F6?=
 =?utf-8?B?OHAvTWppZG9OY1pZKzBZZjB2T2hIdVBFK0pDaWlFQ3dGdVo4UUhWdXRuTU9u?=
 =?utf-8?B?R3ZQWEF6RFhERjNKU3M3YUE0bHRXRGsydmhKUWR5YnlXS0RYMXB6Z0tBenhw?=
 =?utf-8?B?bjZmV1dwV2Z5V2hsbHJXWTMxVjVRdUF3YldxT2JlRFJvdXhlY0NML2VsMEFH?=
 =?utf-8?B?aVdxVCtaNlVybENmVU9YQTZjdGdOZ3h3bHNuYmZEdmFvc0trNm1nWUovelY2?=
 =?utf-8?B?SVRnYVJnbWVvZk5mQmU0N0k5NkhvMEVXd1BseURuZUI0eW5DZDNWWjhHZ002?=
 =?utf-8?B?eEFlOExtdjNWQzhYR3V1MVRzUmNGTlI2R3hURE83TFZlQ2JBQlJRbEo2N2t6?=
 =?utf-8?B?d25BQ2F5QjZyWW84M2tiaVF2RGVSVjJNTldGdTBFVVZLWDlnRUZnN0d4UzRE?=
 =?utf-8?B?eHRQaUttUzNVbm5GV0VnMTFBWFlDaTlXZmE1MUV5cGxmbC90d29FUkkwaGNM?=
 =?utf-8?Q?6G5SIaQoIERl66hTwqPClTh6g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d608401f-0833-409a-96b4-08dc2e370942
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 15:01:49.4518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4bpYqmuaTY8qMOJdV+Yt79z6lPwD0OpsqbRvO6vDEL75bQQcEcZsbPi8SjoQyUpbHjzyBzb7sQwjOj+MqQcWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5414



On 2/15/24 3:33 AM, Jonathan Cameron wrote:
> On Wed, 14 Feb 2024 14:07:08 -0600
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
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> 
> Hi Ben,
> 
> Just one trivial thing to add to Dan's comments.
> 
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
>> +int einj_cxl_available_error_type_show(struct seq_file *m, void *v);
>> +int einj_cxl_inject_error(struct pci_dev *dport_dev, u64 type);
>> +int einj_cxl_inject_rch_error(u64 rcrb, u64 type);
>> +bool einj_is_initialized(void);
>> +#else // !IS_ENABLED(CONFIG_ACPI_APEI_EINJ)
> Whilst C++ Style comments are allowed for a few specific case, you should stick
> to local style. In the include directory a quick grep gave me loads of
> #else /*  */
> lines and only 2
> #else //
> 
> So C style comments preferred.
> 

You are 100% correct. I did a grep for examples and didn't notice that I did it
from the base linux directory, so of course I found a bunch of examples of C++
style comments :/. I'll fix it in the next revision.

Thanks,
Ben

> 
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
> 

