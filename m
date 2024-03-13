Return-Path: <linux-acpi+bounces-4315-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D62887A838
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Mar 2024 14:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA3571F23326
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Mar 2024 13:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2814E40860;
	Wed, 13 Mar 2024 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cjtHzNJC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2603B3F9CE;
	Wed, 13 Mar 2024 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710336269; cv=fail; b=G1s+DX/2RHN5FnzeGVqYp74M9h63iFikRVGrEWmOiHvvKbr3cOuOg4vxplTWuxy3efSKKS+Eijbqs0In0zyOCisD7kMdL6xVVdhlN3GAslonapfxHMGy6sabMazpUSjOGFTp7pdMNxgYN1qXwMagUNnBoYKRoX31n/Koc8N+zo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710336269; c=relaxed/simple;
	bh=4+AHPW2lvVXjQmcYpSe1sLTv4dnPy6wahFe0MbXjMME=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CcDwSsHOLfe9+MuxARLz70rbB0xRqQRTDajCmC5xlei3BuO06BljsWKlyvXk889Pl7PHpM1nOCmqIOpubNWRo+L4FRxd6029C8ywhnjQJmTwVGxYcuc0FCc0DIQ9qvCpLvVpkidji3sIaeu5iHWiOQL/HNpIJ/pfCKiMLO9TtUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cjtHzNJC; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfClkYup88a6RQ10CXkmwUNHqWacL9zlHwWyCHNx0iYGe7NdGaCKJ7sU27PCiQX3iw7K+vqrWYBLKJMaKtkiRu9W5AGfiTzGQ2a5AtqXEvjNe9AjeWOZFXD9y7h/CYjWv2aFfDLJ2+9BiuoLMevZ2CgxVj9Pwz32JJzSE5dWgPnVbSi2W/ErXwuTbcr3yhSESynGQXiRPGZhi52056ac+cWGPAh+amLehLNnGNL/bzob/UFY5R3PlThkWbKphDDwXn9dGnkgyxuWgzGyUOIjWsR0X1IjTctzT+HMHEaTrvMO+8EIM0WGat99W/+Rl0i1BsUilQDD97vC0ctONpGU8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtaXMZ0VsZTcZ6EwHWXi+1RSzJbLG7C5vB9gvet9+Tw=;
 b=ZMIfn5+ifJelSYY/s2pKzRwS1qJdVRXqck4nveBD57YO4XqliNifc02x2qGLfQgYJYqGksJqVSk6Cl7abBq+90CACpQH6FFK1YbYKxZooke70XV3AoUA4tz7NMMfrdTjTYsyWmIv271qsnAT3smPhUHSiMMCHpV1SLR8SkPVuCRKmH4y8VoqlJHEdxgXwqe5dXFCxlHR7mt9Zzz+l6M9u62AN2sYE+jiuO1FoIDuLyzFY6wnQ/usFCINCHYVScNGDmDLiynG/yORCZagO2K5R1t/G7NeR4fb/tN7QTIQBrAXul0EuP7lUTCfOOyRm/yy/ecJ+g+cW0qTXDld4HTUzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtaXMZ0VsZTcZ6EwHWXi+1RSzJbLG7C5vB9gvet9+Tw=;
 b=cjtHzNJCZRbDhpidRw/TzZnC9Wamig4MmBh6huDAJ+BxRJpTf2Aj4nukuow+PQz+ZQnV0ZjMKjKl6/LDUEpohzPdH/9zXlFwlkmvkMoaYIcL1lLV8+sk3ARhrqtHz74QLX7Af9N3oshHDmObJGvikMQ3GANt/HYqwkZFaZl51E0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by DS0PR12MB8320.namprd12.prod.outlook.com (2603:10b6:8:f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Wed, 13 Mar
 2024 13:24:25 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::5302:26cf:a913:7e06]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::5302:26cf:a913:7e06%5]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 13:24:25 +0000
Message-ID: <41563ff5-30cc-4343-a0b6-a0bd3c7b09a3@amd.com>
Date: Wed, 13 Mar 2024 08:24:18 -0500
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
 <65f14075cea72_a9b429414@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <65f14075cea72_a9b429414@dwillia2-mobl3.amr.corp.intel.com.notmuch>
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
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|DS0PR12MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: f885bdaf-2713-407c-406e-08dc4360e6f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mjZpjUgMD75RsIaCstZWfL2JbPwSBg2gbw5RpuDlei3102l0Uf3pnV/f6GpfgA0368NM+SSe7zSyGdgc0I2KdReo9YaBIvzvAoOaRc7aRoKgCcTXkXke1Sx9cq+uswkdjQ9/0gzjrqkFbGN2PiOyvXWhmv3l+Ki2od020Ok6W+fxfpe2BRaM2oN88IaC+KYXfnH1VNXN45ga1earflWe/j7X5yjAawW3xYyjdHs9A1q6JVGKIEfViG/83KgRFiVVIVBy34AICo1Pqr7Ee6Jp5tiw5Y/9wnlUOiHtAmKhJL4ZnAVbKnAbO9BPoiRKOYdpffwEyjkI6OZiSkVQ50QotFSI5hq77bP/P9jfobaajbu084hPnWH615iSqyYn4l78xYIndhxZUu9HB7LVWaKjV+hyK5IezhRw1ddX5vMUyfQXTJl/NpSkQKmOOiE79ExM3kNHApBPsAD7+fCg4FJ/3M/bznwteFWLa3NM7rXc9zhx2TsqpxZD96PzHXjfbCnQTjjD52pRP3q/gMZckzwPpzuWKOjbvyENBGW5I5a24a9aQz5Tq4S0ezxrsWhKvVQ5rIGZH8xmCFWEe9Cso7liAoqQF7c4mUg9muZ8YDRyz076z3pdP9UKico220eaL4d5CLfWxVkji/M6oR385pONpiHW8BXA81HKZMp6RbDueiE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?em9Xc1B3a3ozSHp0cDlwVjdaSzBWRnF4T1hxYkg2OHZlWGcxR1Z5OHE1L0wr?=
 =?utf-8?B?Tm11S2EydktaZUlFWm1NZDFBVjhSRmhiRnBsbjRuSlZKa1NPeWxHNC9kVEUy?=
 =?utf-8?B?bWFHTjdZdlQxb0l5NWpQbUJOSjUyUFZZcFc1REFjdGxJR1BzOHk1TGtiYTg5?=
 =?utf-8?B?OVJVemVXK2dXODgxTHBNUUx0RW9zVm9SV1lhTlNCRFRkZ2wyTnpZZStIUWI3?=
 =?utf-8?B?ZGVGVGE0UHJWWGVHdUVFdmpWNjRRVk1wUSswc1p3TEIvcEsydHNvNTBBdHlT?=
 =?utf-8?B?TmJTT3V4RFBsVUZibnRMbEdGQnlPVmlYRFJWcEo4OExMY1hLNUxKYnRyS1I0?=
 =?utf-8?B?bmNaRVcxbjhWd2Ftb0MvOElrVWxPNzNNQ3dCQ3B1c1djeFBNdFZnSDFXbUJ4?=
 =?utf-8?B?WEErY0dKQ0I4U2s2Q0loOHJoME0rdGJ5RVRPSmRNa2RUUXdOc28rbXhURlBz?=
 =?utf-8?B?YkxnalVTY0hlT3l4Wkkzay9nYXNvYWJpaFZDM2JEVUhzekJXWEhBNG53dUtQ?=
 =?utf-8?B?Rnd1V1JIVGVqR3Y1aHJkRVYyOE1LSG1oMldkaGtBM0NNQ3JmQnRIMHFmL1R6?=
 =?utf-8?B?QklGd09HaDVvd1dYbGZWNkdkdWNJUDBhVGU5REhsdy9NNXdJdGFsK1ZCUFJh?=
 =?utf-8?B?N1BzWngybnZCY3J2UXF1R0dWaHhTYVdNU0kvYnZlU09hbGt1ZlI2WWJ3M1JB?=
 =?utf-8?B?cDlVR3dBYVVvTk9ScTdmMHQraDVLT3Y5Uk1tV3Q3QjFmZHduRjlDNVd4bEtK?=
 =?utf-8?B?ZDRWV2p4U1hHZWFkSWdpSWxqQU5laDhUa05iVS8zZmk1MzU0bGY4YkJBMWFY?=
 =?utf-8?B?V2cvb3d5bk5NaXZCSXJIYitmYnBvWXo2a0NQUk1nZytZMTJtUHdNdU5icTRp?=
 =?utf-8?B?WktUSVNPOExCRytvdjhBSkZWc0JrOS9IWHk2K0t4VVlucDJzQW1JOTRCdytH?=
 =?utf-8?B?bTl2MzB5WHU1bUcwS1FDdmFMVHNzWnU1ZUNTQUpWMzBhVnZoVTZRcVlFejJS?=
 =?utf-8?B?elU3UExIS1hXWVJHMGhOSENPTHlSaWZaQ3QyYzBqVmVoaGNqbExpUkhOczE3?=
 =?utf-8?B?S1lJTVJDTllJV1NBY1BiMUVHVjAxNnAzMlk5T2NOaktYTldubnJTUmRWdklw?=
 =?utf-8?B?Q1VlMGsxZ2FFWmY0algxclhOYy80QVZvQ0ZBb3NHcUJBQVB5d3l6YlFENnZz?=
 =?utf-8?B?SFNQeSs1QVhscnlENjl2OFhIQzNkZm1YM3BCcGNjbW51YlRrQUVmWGtMV2Nz?=
 =?utf-8?B?Y1BJQXE4cmIwNXk4a0R3bEw2djZxMU5iTUY1YVNLZXBDMDJSMjBGQlhQZnNT?=
 =?utf-8?B?aUhHZE0xcnVKcWJINStsZm16Mll5TXNjaWt6bmkwa2RFZVdWMEtTeXFQOFpE?=
 =?utf-8?B?OVVrM280WVNOcjBsZ1VRMFZPU0pFQ3NpeFJDTFdEOHZNeEZXT1E0SDdpVkRz?=
 =?utf-8?B?ZnRvbUJxTW9LcVBTT0ZaanFQVWZVVjE2eVplZmF4NjZSS2VKekszVTlWNnBE?=
 =?utf-8?B?NWVldkcrSHBvakhlSUZFRUtFSy9mRDNnOVF4aW5kcEJ0UmwvZUVPdTVrWEJo?=
 =?utf-8?B?eHZDT0xkRlBMQzY4bTlCMXhSSWttN00xQ0JEOThVL3pBQ3huNWpkdnkyOElx?=
 =?utf-8?B?T2JhWWUwYVE3R0E0OURYeUhhMWZlUFJWMUt1RzRvYzF1VHdxT0kzejVOdkVj?=
 =?utf-8?B?WmhjblhRSm83ekJVL1UrRUI4ZDUrS3M5UitjRzJ6ZFk3bm4wdHhIQS9BeHd5?=
 =?utf-8?B?SEpyWDFWZGJ5Uk9nTU05U0xOLzJSQXNOS0h5eVZEV3gwTmFwWllXdFFxRmtD?=
 =?utf-8?B?bVBNL3BtS1VHM2NBS1NiNE52NjZidngrNkFqbXJXM0pJY1hVNWwxZ1pLdzdp?=
 =?utf-8?B?L29yVklyNEp3MjRyZ25QTjZzWlMzVmw3OU5DR2s4WG5DeTB5cWhqaGliK3FR?=
 =?utf-8?B?aDNkd2xXSmJobURFZzcxelppMm8vcFJkTUh4RGJ3WXNXTGZhSTVySlBhcEpN?=
 =?utf-8?B?WnBveFBoVW1uRHR4UVRLOWhlSHY2bGFVRUhoREgyZ255cS9lT2NYYjZmWVJT?=
 =?utf-8?B?bVpudVA4aEZCNCsxR1ZUaWFzd1pxMVhkdXc3Uzlta3VBOEhzZHdIU1paREVT?=
 =?utf-8?Q?91v5CUUu7nNGvnFhaacoO0X56?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f885bdaf-2713-407c-406e-08dc4360e6f2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 13:24:25.1836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QwPEKywB6hWESwa0YbhRxDg1EsL/DLRQ0cM8uPhWA4zIxJ3yAfI3gTDRpqnAKfQekzJC+dR+slXPvy5hM8MRnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8320



On 3/13/24 12:58 AM, Dan Williams wrote:
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
> [..]
>> +	/*
>> +	 * Injections targeting a CXL 1.0/1.1 port have to be injected
>> +	 * via the einj_cxl_rch_error_inject() path as that does the proper
>> +	 * validation of the given RCRB base (MMIO) address.
>> +	 */
>> +	if (einj_is_cxl_error_type(type) && (flags & SETWA_FLAGS_MEM)) {
>> +		return -EINVAL;
>> +	}
> 
> Checkpatch says:
> 
> WARNING: braces {} are not necessary for single statement blocks
> #170: FILE: drivers/acpi/apei/einj-core.c:578:
> +       if (einj_is_cxl_error_type(type) && (flags & SETWA_FLAGS_MEM)) {
> +               return -EINVAL;
> +       }
> 
> 
> Fixed.

That's interesting, I have checkpatch set to run on git commit so I should've
seen that. I'll need to take another look at my setup.

