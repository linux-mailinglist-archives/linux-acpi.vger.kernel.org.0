Return-Path: <linux-acpi+bounces-2783-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBB382A248
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jan 2024 21:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40AF11F22EE5
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jan 2024 20:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2313BB53;
	Wed, 10 Jan 2024 20:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wP44fh6C"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCF72A8C1;
	Wed, 10 Jan 2024 20:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TI5s5AUXlt8DcENRWdwb/jFNvcZEA+v+l4jFWWYzD8Cy3Ouh3/I+9XB6uDLeAC5PEhefwQgIUqVeUiSyHwqkkXPxf5WgvBhPx9D6NlS0itmNGrPsDdnMSxpP5h1Oow+DRyiS2DTMJwSWyseAlgqBzLdBz+MXbLSE1emaJbrwzbu7j2dspRBX7De5YZ37/RsLmvoz6QOOKyfP6PUuJ2YRuRwTw4pWwuzIZJyog5Kq7KcW9DI1hzrWIqU6/xPJ/GtcRWjQoJ3p2v1MSKPpLSuAuRdSGej5HRv3MmENk7vwrmsJOpnCZgvTeu9/iWfVkz945J7mpBXn8AxaysYo4fnufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RONxm2ZwjDMtJPG6PpRKR081LZBOIgo5fIDXTOwshhE=;
 b=dsPyI7XbRV3vzFkpPxaiqkn13bwfJnNMlc19i2lFZGf2+MWK9gDd1jTYfRy8Jqvrb3wku6KvM1yTzUxd4EM7SH8294M6r+6Q1uHrrR1MrvuClgZXrMMNDZOXezbWojFEO31P6ZA0igMkd3rtG33Yj2WmBBSfBiwwpaPrBQDIt7QrIZrkdGP+8Op6F22oIwmyKnpdHkpzhEJp7NlDHr3mzVvYiqOsg2a66Aurw3VwnlMZPAphTuKWRhkgWxK4a491fcF0LgBpORZL2sAfvUIm1abEdRWDRGLpiQjj3a5RXq7GNyoS9HQ3yelBP88NRz+JpYV8/7vOJ5aB/SG5gDwYPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RONxm2ZwjDMtJPG6PpRKR081LZBOIgo5fIDXTOwshhE=;
 b=wP44fh6CdE38xivpeXJFKE9dwnqcOBth/m0nY+FxfF7TX8L4to9osszEKmPye5LOTYszOgBY4qjBPBwjaA/LMWXrK4WcMT84+591XkyFzXZQqdPEKVYKQyw6hPgJOKPo3M4Ft2egd+qahbWNT4vGnNyH16NCQ55+xFCwzbVEi4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3268.namprd12.prod.outlook.com (2603:10b6:408:6c::18)
 by MW4PR12MB6682.namprd12.prod.outlook.com (2603:10b6:303:1e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 20:31:39 +0000
Received: from BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::cc71:1a30:afcb:c569]) by BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::cc71:1a30:afcb:c569%7]) with mapi id 15.20.7159.015; Wed, 10 Jan 2024
 20:31:38 +0000
Message-ID: <98d26376-a294-4eea-8b06-306b49d657b9@amd.com>
Date: Wed, 10 Jan 2024 14:31:29 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/5] cxl, ACPI, APEI, EINJ: Add CXL_EINJ Kconfig option
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, dave@stogolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 rafael@kernel.org
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20231213223702.543419-1-Benjamin.Cheatham@amd.com>
 <20231213223702.543419-2-Benjamin.Cheatham@amd.com>
 <6580da3199b15_715492948@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <6580da3199b15_715492948@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0089.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::9) To BN8PR12MB3268.namprd12.prod.outlook.com
 (2603:10b6:408:6c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3268:EE_|MW4PR12MB6682:EE_
X-MS-Office365-Filtering-Correlation-Id: 5679f60e-2da5-4c01-1307-08dc121b2571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HoR+Ywev8WKpfaOD++o7u51/jEbQ8m5/NY9ijkuqhwfaomhVD1WLhLo7ufYt2x7BQUY6SwBFDVW84LY0Yc0Pi4QQf93lE8M5htdeBgqziChz0aNGW0eJc6ZkmlPcuLhCMhBbmuU4IEvAJ+Eq//I7A3HE0LzejTnoNBSqRwieorhaZDyOdrphb5h7GO/viYX6Xy8b/6i3c5SUwftzeRkGdJZDViV0iPuGu9G4cMM9pF2xqIfe2UwLua5bBvXB3YKcLiRpjj03BuVOZcImRCRYqla3FBorGlHt/6sEawqYtTk8PVlIYhOLWDVJOgvUdcaEhNsCwdl1LlPtc3OlhMxEacP7OKSPJiX0QMp3Ls/pnJD7fsILYrDa2HEH8D1miRn7DyRcwq8ehSYvrrcBep7Y+7GH2TTlN9aD2mgzX6wTkYfRDiNk7KxmS5Onqa6QTqig4JSmib4osw9MblCVJ4bASRucf24nyJZGp8Ajr3HKSVFU/NqcP3T+rh3WBTeLSze0D0A/lU6Qfx1kOtEpv+icMCxvqFpALEAxojncMQkSFORGRmdNALGOyr7e5AY0JwZFAtwnugTti3p5d4mhwqOlEXM1gI9aKHpALKCzbz0x3FAHTqpsNVwL8WWXMHoAwUpS4XX9/ML0hACeB7Nb4EoTKQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3268.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(136003)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31686004)(83380400001)(41300700001)(36756003)(86362001)(31696002)(66946007)(6506007)(66476007)(2616005)(26005)(38100700002)(53546011)(6512007)(6666004)(6486002)(2906002)(66556008)(478600001)(316002)(5660300002)(8676002)(8936002)(7416002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0c3dGxQT3lIUzk5dXI2MlZ0di95WkVvYlR5VWp1OTdTWHRSUFVYeS9aYUFQ?=
 =?utf-8?B?R0NRMzZYYndBVXdpVnZEWDJvY1F6dzYxbHBrWmE3NlBnUHZZOUliKzc0cGlp?=
 =?utf-8?B?OG9wUHJEYm0xWU9TVnVNVEJCQW9maHUwWGNnU3laRkVGZGJaSW8zT0NjTjU4?=
 =?utf-8?B?Mk1IYmZLT1RJQlhTdUd1ZStCRDJZZVZKUHN3Z1UxaFZ5UkU5a2UzS2JjeGd2?=
 =?utf-8?B?MVBETGdIZWxTWnY5YXFMQzYrWHR5YjN0THNCNzByTWRuOUZTWXcyVWhVWFRL?=
 =?utf-8?B?V2ZBR1pNaWYzT1ZiZ3NUWnFkbEJkQ01rZzBvT3R3akw2bFcrNEdNNU5WY3kz?=
 =?utf-8?B?TTBWV2l2YUt3aDE4Y2VEeTZYYzZWZUM4TGlmL2lWNzQyN3d6YzFSQjVvYU9Y?=
 =?utf-8?B?VjFBQ1BQLzZOaTZpRW4vMjlRWUJsYVAySytjWFM4dzRlQUZhN29jVGlMdjYy?=
 =?utf-8?B?ZG1ZVEl4SFYwR0V3R05NNGRsUXRkSE9JU2lGd0ZINXkydHVvWHkxUkpwWnNU?=
 =?utf-8?B?Q2VYZWZvVk0rK3F0ckZrMU82REhqWlRCdTZVTzYrUUlWV05lMDRmSEZYZlJC?=
 =?utf-8?B?MnFUTXpiY0l3bTNoMW43Z2lFYkVYOEhGM0VjYnJWTS9VKzdtMjRJcHVLNDlK?=
 =?utf-8?B?ZWpzVlFLU0pFSEZBNWx4TTJoZklFanNkbVZac0hUVWZ3N1drKzJtQmJQbWtu?=
 =?utf-8?B?UDJxZE44UFk0NHk4Z00rRUVKQ2o0ekpWa1B2UzkwMDZNR0NjZW53R1kxdnhz?=
 =?utf-8?B?TkhEUm0vL1djeU9UWUdva01xNEdEN0x0VmRVNS85Qi8xcGFzR1FUdGpsVW9B?=
 =?utf-8?B?NFpMYzVRMWxHMjdaSnV0U0tFellFYWFWSzhDWWk4QmlnU2NaNVJ4OG54VzRj?=
 =?utf-8?B?Um9RS1RhdGFBd3lHREg3NWtrSFNBRTRnR1YvcTNiL05ucS9hVVhjSXkyTVAw?=
 =?utf-8?B?cUxpKzBWeWVJVHgraHBQc0x0KzRGdi8xd2EwOU5ZdFdwNytWSm5iaWtmK0FC?=
 =?utf-8?B?SlJraU5hQUtRQzVzQko2TDdNaTN6MG8rYjVPZmxVZzRJUzVtYlNCSkkrWjJI?=
 =?utf-8?B?SWpwVUVFMVN0NVBYc1JXekFqeEdjNEVnSTFoMDB3MXphaGxBQnpjbVg4bCtG?=
 =?utf-8?B?ZkNZc3hkOWo4UWlMQThHd050NkszQy83aGxScC9NSmdTaTk1ZTZYcXl4MEZC?=
 =?utf-8?B?NGc3RVVGMk1hNDZxRVV5MGdyaXBaYVZWL2FkOXdCTlBDa1dRaVp3UWFkQTMv?=
 =?utf-8?B?VThmR3EyOWJ1REpQQ2JURUViazVIM2lYbWZkZkxrcVJ6VjZaNDAzUjZ2Sita?=
 =?utf-8?B?c0VXODFPUVhJY0VWVjI1bCtWTlBRSVhmTk8yQlhUTDF1K3JBU3JxQnVjVXpk?=
 =?utf-8?B?ZUxDZ3A3dThWeGgyRUhYSHh1Tng2bkxOUlNvQysyaEJEbDMrdUliVVBNTjlp?=
 =?utf-8?B?dFVoNXI4cGJDcUgvRjJZeEJuUVZwdGwyL3lWMHpTUDBjK0h1Sm1YZjE4VkFE?=
 =?utf-8?B?SDBIbTgrQUlTcHpsbFVkZkRBbHlPWTNiVGVxWFByYUhkbi9CK2VsWCtvVzFI?=
 =?utf-8?B?M1I5bHduY3ZuSlRURk5MWDY2OTRUdjEvSmgwcVhnak9wa0VJNEpESkEwa3dr?=
 =?utf-8?B?a0QyVXlZa0l3U3pTakgvdzlXdE9ObUliQ3p2RUVRa2U0OHZKbFJDRkp4clRJ?=
 =?utf-8?B?K2tWanNyanlmZ2FHdFd5SWtocVpLSS92dlhIODIzYWxmTXQwZ24yWGFjWFpW?=
 =?utf-8?B?NjAvVUNkQzNwTlY4YTJSdGhIcG9ZMGNuQ2N3NzVmWHQ4MnVPWmkrb3U2b1dl?=
 =?utf-8?B?MXpUdXVzR2pxbm42cllxQktRYzg5dGNZTDRyK2YwS0o5RGt1Q2V6M01uZUxC?=
 =?utf-8?B?YXAxSHZiRmcxSUtHQzRWTlFvMjZjMnRwUlIxVkZ5bUlZeU5zRTlrYUZFalF6?=
 =?utf-8?B?U3pwWk45UWw0dC8rbWV4Q0F5b0dmUHU1RkNWNit3ZUlDWjJibi96dUUyUjhL?=
 =?utf-8?B?UVpGSXkwUjBIVXZjUzNzR1Naa0VOdjZUU1Q1RVNQZ0FmKzJEaXpnMVRUNWJR?=
 =?utf-8?B?NkhYNnhERUhjOVo1V1M0REgzWitXRTVEZWR5UjU4a21FL1haVkI5UG9QK2x6?=
 =?utf-8?Q?FucCGd1CSv66C5PuapSb50mtQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5679f60e-2da5-4c01-1307-08dc121b2571
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3268.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 20:31:38.2751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ci3lJpurdEkMOv1XDYGpgntZoG8FB1aquawNeSAyqd9Y6TTN2yGDJpxQDyalohRubp7KO4XhP4mazau9V4Ua3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6682

Hi Dan, sorry for the wait, but I finally am getting some time to take a look at this. I haven't gotten around
to taking a look at updating the module init to use a platform driver, but I should be able to get to it in the next
couple of days here. Thanks for the review!

On 12/18/23 5:48 PM, Dan Williams wrote:
> Ben Cheatham wrote:
>> Add CONFIG_CXL_EINJ to cxl/Kconfig. This option will allow for the CXL
>> core module to access helpers inside the EINJ module, while also giving
>> users the option of disabling CXL EINJ error types at build time.
>>
>> Also update CONFIG_ACPI_APEI_EINJ to set CONFIG_CXL_EINJ by default.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
>> ---
>>  drivers/acpi/apei/Kconfig |  1 +
>>  drivers/cxl/Kconfig       | 12 ++++++++++++
>>  2 files changed, 13 insertions(+)
>>
>> diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
>> index 6b18f8bc7be3..4c3f0ec5731e 100644
>> --- a/drivers/acpi/apei/Kconfig
>> +++ b/drivers/acpi/apei/Kconfig
>> @@ -55,6 +55,7 @@ config ACPI_APEI_MEMORY_FAILURE
>>  config ACPI_APEI_EINJ
>>  	tristate "APEI Error INJection (EINJ)"
>>  	depends on ACPI_APEI && DEBUG_FS
>> +	imply CXL_BUS
> 
> This can safely be deleted, it is sufficient for CXL_BUS to depend on
> ACPI_APEI_EINJ.
> 

Ok, will do.

>>  	help
>>  	  EINJ provides a hardware error injection mechanism, it is
>>  	  mainly used for debugging and testing the other parts of
>> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
>> index 8ea1d340e438..6f4adcd733e5 100644
>> --- a/drivers/cxl/Kconfig
>> +++ b/drivers/cxl/Kconfig
>> @@ -154,4 +154,16 @@ config CXL_PMU
>>  	  monitoring units and provide standard perf based interfaces.
>>  
>>  	  If unsure say 'm'.
>> +
>> +config CXL_EINJ
>> +	bool "CXL Error INJection Support"
>> +	default ACPI_APEI_EINJ
>> +	depends on ACPI_APEI_EINJ && ACPI_APEI_EINJ=CXL_BUS
> 
> It is ok for CXL_BUS to be a module while ACPI_APEI_EINJ is built-in, so
> the && can be dropped since CXL_BUS is guaranteed to be > 0 here, i.e.:
> 
>     default ACPI_APEI_EINJ
>     depends on ACPI_APEI_EINJ >= CXL_BUS

Sounds good. I don't have much experience with Kconfig and wasn't aware that >= was a thing, good to know!

