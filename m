Return-Path: <linux-acpi+bounces-3802-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF2E85E914
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 21:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226601C219AE
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 20:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6C83A8F6;
	Wed, 21 Feb 2024 20:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LA+0mysG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31687EEB3;
	Wed, 21 Feb 2024 20:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708547699; cv=fail; b=ZihPyB5yzoKcVqnQu0ek9V/MiauYTsFCmIbPn7zLmLpAjyWWyeN8MqQwosxDt5Da18+Yd6Yif+H4ptlNcxfO6FqPtTBAaUYj1H/BIEFLH+1w6DTm8b8LIc1/xOQCBYWEIPAAWPIHV1wbIB+UAz5ZuyGbBOpsQslG68okZakEr0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708547699; c=relaxed/simple;
	bh=ubgOFrZ5pruubR0uIOclHHI2qJRje5WhYDXY5C7Mvto=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mK0GPkOSeaknqC7IOeyhs7JKeEEu/ET3nLKIQQR+/cAGJhAPEYC/484OYUYFYHEL5xeG76R/dRJMpzN7uTHUOOClLCx4XiS64af2hmNAyXuNu4OYb93ni5R3pnYCcJPkX/B5hHHtavkmI1Bz/RScfjIfuKj5/xLoV9N59ioK+qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LA+0mysG; arc=fail smtp.client-ip=40.107.95.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qkcrrd0F+7Aox9ePrsmfUv96ol73bH3BmZ6JcLb1jTxdPNx4OgzdtO3KYjIkvM1h1lhzdPQZuZ7wtDRyG8/R70UvUDwbfq6x6PhhDtJ+7uPh6DBIihblRSBHP6q+hPZwl/oCrRhOX+H1swgORNc7uBu86Hb0JKgMoo1Cke2c+CUbGW1J0BlogrKfEqDnERqT2T3P2awgBbdODoW9/OvS3xx+Z2UTgXb/ZtUchKfnn8vkron4DM2zAY4LM79xQSr8GLm0WBr8I+IXD7QyJvke9G9bEOmjSMEuZTbz0KgNodh3CMvRjwS/ArnRjfQsNTGtz4gvUbPMrMvTcMSce3E+Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S77/OwgkFF37PlhSbKktLzf5BNcxooJBAF7xVfJ5iLc=;
 b=I/ZMSB7gnmU0CU+vJVI5/Crx2j1HkQqYVg/SMFICv2afkFa3hIC5cvFY4uS8876zH+750jWyI8uCYhS1MEnDD3RNuyEOME2PJ9tyNSMyj5OGFH3e/mRs+elDT4lZa+dKePuEvrVNDUtZvLqA1ctD4nHhqtlE2q7QmOzjReHWEMRZnNQO5Y4YKTCl/IUkSWXYY2tzXuwjcZSePMGwzm/vqOoXVtefeLH7oIemjGoUeH/CtYyvcoyGX/VRyK1df8erPVAu63Uy5+m4voR26La0v+5XcgBXOohvlfwyxcBsSLEITz3Dfkji7TgtJt6YtpQxjS/b4f9XvRjKz2S3ijJJNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S77/OwgkFF37PlhSbKktLzf5BNcxooJBAF7xVfJ5iLc=;
 b=LA+0mysGNX6OJXKXJgauInWY58wNOv0f3QJDgCY0j7Ceomi171GGxrlUTRd6vcXmWEkCTUnMVHuQNhmPA/W1yJhDPPzvJOmqCcWEpnInwm0qCUrZZXPqQTMR8J+Dfeft+2JZ8UvvbWA+IyOflleIgrQW/AMuj9kn42rvSfjtTXw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Wed, 21 Feb
 2024 20:34:51 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::d493:7200:e0ae:1458]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::d493:7200:e0ae:1458%7]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 20:34:51 +0000
Message-ID: <7f1adaa3-107d-45a4-b194-2a06258bf041@amd.com>
Date: Wed, 21 Feb 2024 14:34:47 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 2/4] EINJ: Add CXL error type support
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
To: Dan Williams <dan.j.williams@intel.com>, jonathan.cameron@huawei.com,
 rafael@kernel.org, james.morse@arm.com, tony.luck@intel.com, bp@alien8.de
Cc: dave@stogolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20240220221146.399209-1-Benjamin.Cheatham@amd.com>
 <20240220221146.399209-3-Benjamin.Cheatham@amd.com>
 <65d63647ecdb1_5e9bf294d6@dwillia2-xfh.jf.intel.com.notmuch>
 <5a650a49-8f80-4ade-8844-61f88172cecd@amd.com>
In-Reply-To: <5a650a49-8f80-4ade-8844-61f88172cecd@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0140.namprd13.prod.outlook.com
 (2603:10b6:806:27::25) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|DM6PR12MB4356:EE_
X-MS-Office365-Filtering-Correlation-Id: e816562f-aa46-4c63-eb71-08dc331c8e19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lBOaealov4fviffbuuanzLEixUR/b1ipGF0QlGnYW+YupfokK0Kx7GSZHDJFuJXLOmkhCItX84P12sDJ08dk9Cb8TmSw2DcCu0Y2lnm4NU9aFKc2Mr/mV17juBBXTcNkhx9jsf5aCkIjXorBB6WWrMil55RLBWGhfY8D3MGxfbFf8t+0WSpHG0bJNOzC+R5coSFs8DmHw/I1RhfBKJwXyyTUhCZbFsvyVY6zom9Ry0ISJe/FLWh5OJXLKTQXhi8kvzzmqvNpd9zSufJPgrCQiTfrNBcUh8MxrdqBo5zXC2tdIIzTMLsIV8gDJUiKiZF0Fni9YPFUJsu6p39jm9pvwqqDlsnbaHCtE+rumlZBuQS/0VNlG/0lhL6mizcNNswkMozY1K79qHIoaA1yTqv/P9CwNfDfsVgebSjVOEYMFXvzUt2O1NgWPv4tu0kPEitGUzh2DV8pUg/GsS/zjDtBavSPHlUpShQPTvNSEI70jppMig61puQiYkJ0s1qg/MHFTHnQhNnuISwVaUwAR3KGbpLxHwamT4GRcGezdPRsKtY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVN3RG9zaTZONms0ajJZZnR1amI2cVZkcXgySnVQZHR5am1jRUprTklXbzFo?=
 =?utf-8?B?RWNwYmVlZlk5ZzIrdGdyOG9GeWQ1QytIcXpKOTZuOUdTS1JVcVhEajJiM0lj?=
 =?utf-8?B?NVlYSnNmU0IwV3FaOEIzNVdFMG1JWTA2cWVxVUlpc2pkS3pWVzQ0a0lwK0sx?=
 =?utf-8?B?emV6dTA5STdWYTdaZUx1T3hBWlAzckYrMXZwOEkzdW5kVHQ1UzJVYUF0dkxS?=
 =?utf-8?B?bUJ4Vnc2NC9RbWh1bnQyd0FWVUpVaUNFMldrUXNCZTlFVDVXU3J2SDNmME53?=
 =?utf-8?B?MUx1YWEzUjNQWDE1S1NHelN2LzN6WDd1U25WYmt0UVU2MU9yRW10cXQ4clNO?=
 =?utf-8?B?ZkFlaGZmRUFqSUZDMUtONjhHbHFBTUFDQ1hNRTF0eXM2R0l0eW9vTTcxQTFU?=
 =?utf-8?B?WGgyNWtFd055dXNFYjJmdTVXNFVRU3ZYN09lZ3hEK3lBWlN6N0kxbDhYakNZ?=
 =?utf-8?B?QXdOVEk3NWh1MjVpcEs1ZFlSKzFMZXEyRGFKaWV1bjBzalJaU0NsYXdzOUE4?=
 =?utf-8?B?Q01BKzlhMW1WTkZMMU02ZFlUWnNqbGwvaEIwTncvYUtOYWs1WjFETGdUT3VU?=
 =?utf-8?B?RHVXeTdadGhWaS9pQ1RxZ0JGMjhib2JKOGpVc3hBMEZRL0RFQi9MU0ZpZjdV?=
 =?utf-8?B?eEF1UTVQK1IwWXIxcEVXWDh5SEgxb2w4RHRDQ0NUZFFoWXNLVW1Wa2dUWGcz?=
 =?utf-8?B?M2g2R1kzY3FpRFVRcUVyQUoyd1VuN24rdUk2OVdEZndWV2YzN3lpNjlzVElE?=
 =?utf-8?B?WS9VSXo0NXk0VGRMUmJaUlNHUjBwT1YyRDlwcDl6VWo3OUM1L3VIVmZZMjFV?=
 =?utf-8?B?Q01yc3V0eHRWVkNFNTBzY25sTEs5UURjZlJSdWt5M3JUdFhFOWtDbnRJdUZP?=
 =?utf-8?B?N1R0MVhyY3RDR0tTZUx0ZnVUTnMzMlh3bW9QRlpteG4vbUZVVEJyWDdDbEdL?=
 =?utf-8?B?WHFUTFlXek1NMDBEYkdKS2laV01CQ1FVVGx2ZEk2NldraCt3N2tYazRPTEFa?=
 =?utf-8?B?OFdjdmc0REJEeGFIN0tBKzdmYjhnb0NVVHRxSWVINkhPRFh5NTJXSU1XL3VF?=
 =?utf-8?B?ZWlZNGdDY0N5MkVvUEJEZFErdi83L3B6eXVwK3JQUHpwck1lTXAyUUVHM1gr?=
 =?utf-8?B?Tk5RVzBQSmJ1aGljZHJqZ21YdS9IcW9uOGJrb2dwaCtSVk9RcVBJYzExa2Ra?=
 =?utf-8?B?QzNyTmNXZkNzaGcwSHdFejJxNlZjdWsrM3hLL2RJRVBDSFR2d3kyb2FrSEUw?=
 =?utf-8?B?anpMZVJjUEo3Q0FnUmVuOEIxRE1lMjRPTTYwdHN4R2kzUXJXNC96bmZNM1Az?=
 =?utf-8?B?SnF5WkhhZDhjUndyUnpUM0FCV1ZKb0ZteHRYUEtqNjFNVnp5Wk5LSGptaG9y?=
 =?utf-8?B?K2xhWHN1cFRqNTNXa0RuRzJYSUl0Smk5ZDlrUmNSdCtRTjA4V1ZVcVc5czJh?=
 =?utf-8?B?QnBBN1Y5UWM0SGRWanF3T2xwNVJ4bDFJVjY3RlM3YS9HbnQ0bXNFbE1mc0tI?=
 =?utf-8?B?VE9SeTAzdHIxTThYQ2dFcHFhbzBmSVhzelZtUkd1TFU0eHd4YmZiK0gwNi9R?=
 =?utf-8?B?YStWQ2NmWERadXRIMjYwUGJSeDh3bndyK3QvcWpBVWpBVHhsUHJJdWp4eS9E?=
 =?utf-8?B?bmY1TktyUVU5bW5lZkJXMG1jc0tGeTZFY1NRR2NxRFo1N0kySTRNYWZpVEg2?=
 =?utf-8?B?V3h3NWxqdWZPRG9lT3FsVkJBaDJaTnU2cDJuTWl6bzRjYUpNc0o5bTFlYXpn?=
 =?utf-8?B?UDRlWDZZVXVtMzd1UkVGOUhZZExxd1k5TFFIS2UrdEttUCtFWDF3NkVpZUVN?=
 =?utf-8?B?SHhzWmdkWXowaWNxZXZkMldzTnJjV2hrMXUxbU9rVHk0L2pkaFQ5OGVCcXR5?=
 =?utf-8?B?NlU2RWd5TksyZEZuZnFJZ1ErVldmRm9GVTVJanBIb1pTMmM1TDY5bVVOcFk1?=
 =?utf-8?B?bktFakc3QjhlUGFyZXgrWEVidkZHbXdLVmZlNVRkbDZRY2VvR1hkNWYrL2JW?=
 =?utf-8?B?c0M5ZmozL3pyZXhzNUMrbTJINlB3L2lmZUpjTmw1MmtCL2h6U2ZzYk9YbE1I?=
 =?utf-8?B?MzFLRUppTmFHUkM0M0RxVm5VVGRnTDZoRHRWS0F6TkhoRVJram8wMGROY3Vx?=
 =?utf-8?Q?p69XkFv0QcNrSk3hzcmHqtRvz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e816562f-aa46-4c63-eb71-08dc331c8e19
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 20:34:51.6961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqkRMvfAq/0/b5uVW/9/HGYqoQF6Ht12pOUDnlSwyEbCNjfg68rjFRwzEFNCQ6UY5uVyl5wfsrSJHaSR2rD8sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4356



On 2/21/24 2:27 PM, Ben Cheatham wrote:
> 
> 
> On 2/21/24 11:43 AM, Dan Williams wrote:
>> Ben Cheatham wrote:
>>> Remove CXL protocol error types from the EINJ module and move them to
>>> a new einj_cxl module. The einj_cxl module implements the necessary
>>> handling for CXL protocol error injection and exposes an API for the
>>> CXL core to use said functionality. Because the CXL error types
>>> require special handling, only allow them to be injected through the
>>> einj_cxl module and return an error when attempting to inject through
>>> "regular" EINJ.
>>
>> So Robustness Principle says be conservative in what you send and
>> liberal in what you accept. So cleaning up the reporting of CXL
>> capabilities over to the new interface is consistent with that
>> principle, but not removing the ability to inject via the legacy
>> interface. Especially since that has been the status quo for a few
>> kernel cycles is there a good reason to actively prevent usage of that
>> path?
>>
> 
> For CXL 2.0+ ports it's fine since EINJ only expects an SBDF which is
> pretty readily accessible by the user. CXL 1.1/1.0 ports however, it's a bit
> of a headache. It would require the user to find the address of the RCRB
> for the port and supply that to the EINJ module. I originally had this option
> anyway, but I think it got shot down for being too obtuse to use (I think by
> you, but it's been a while xD). If you think it's still worthwhile I can
> remove the restriction for both types of ports or just the 2.0+ ports.
> 
> For CXL 1.0/1.1 ports there's also the security issue of being able to inject
> to any address since the way it works is by skipping the memory address
> checks, but since this is a debug module I don't think it's that big
> of a deal.
> 
>>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
>>> ---
>>>  MAINTAINERS                       |   1 +
>>>  drivers/acpi/apei/Kconfig         |  12 +++
>>>  drivers/acpi/apei/Makefile        |   1 +
>>>  drivers/acpi/apei/apei-internal.h |  17 +++++
>>>  drivers/acpi/apei/einj-cxl.c      | 121 ++++++++++++++++++++++++++++++
>>>  drivers/acpi/apei/einj.c          |  81 ++++++++++++++------
>>>  include/linux/einj-cxl.h          |  40 ++++++++++
>>>  7 files changed, 249 insertions(+), 24 deletions(-)
>>>  create mode 100644 drivers/acpi/apei/einj-cxl.c
>>>  create mode 100644 include/linux/einj-cxl.h
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 73d898383e51..51f9a0da57d7 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -5289,6 +5289,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
>>>  L:	linux-cxl@vger.kernel.org
>>>  S:	Maintained
>>>  F:	drivers/cxl/
>>> +F:	include/linux/cxl-einj.h
>>>  F:	include/linux/cxl-event.h
>>>  F:	include/uapi/linux/cxl_mem.h
>>>  F:	tools/testing/cxl/
>>> diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
>>> index 6b18f8bc7be3..040a9b2de235 100644
>>> --- a/drivers/acpi/apei/Kconfig
>>> +++ b/drivers/acpi/apei/Kconfig
>>> @@ -60,6 +60,18 @@ config ACPI_APEI_EINJ
>>>  	  mainly used for debugging and testing the other parts of
>>>  	  APEI and some other RAS features.
>>>  
>>> +config ACPI_APEI_EINJ_CXL
>>> +	tristate "CXL Error INJection Support"
>>
>> This should still be a boolean because it is add-on functionality to the
>> cxl_core.ko module which has its own tristate configuration.
>>
> 
> I tried this but was running into issues, more about this in the Makefile
> portion of the patch.
> 
>>> +	default ACPI_APEI_EINJ
>>> +	depends on ACPI_APEI_EINJ
>>
>> The dependency still needs to be:
>>
>>     depends on ACPI_APEI_EINJ && CXL_BUS >= ACPI_APEI_EINJ
>>
>> ...because CXL_BUS can not tolerate being built-in when ACPI_APEI_EINJ
>> is not.
>>
> 
> Will do.
> 

Sorry, little clarifying question. Shouldn't this be CXL_BUS <= ACPI_APEI_EINJ instead?
The other way would allow CXL_BUS to be built-in while ACPI_APEI_EINJ is a module, right?

Thanks,
Ben

>>> +	help
>>> +	  Support for CXL protocol Error INJection through debugfs/cxl.
>>> +	  Availability and which errors are supported is dependent on
>>> +	  the host platform. Look to ACPI v6.5 section 18.6.4 and kernel
>>> +	  EINJ documentation for more information.
>>> +
>>> +	  If unsure say 'n'
>>> +
>>>  config ACPI_APEI_ERST_DEBUG
>>>  	tristate "APEI Error Record Serialization Table (ERST) Debug Support"
>>>  	depends on ACPI_APEI
>>> diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
>>> index 4dfac2128737..c18e96d342b2 100644
>>> --- a/drivers/acpi/apei/Makefile
>>> +++ b/drivers/acpi/apei/Makefile
>>> @@ -2,6 +2,7 @@
>>>  obj-$(CONFIG_ACPI_APEI)		+= apei.o
>>>  obj-$(CONFIG_ACPI_APEI_GHES)	+= ghes.o
>>>  obj-$(CONFIG_ACPI_APEI_EINJ)	+= einj.o
>>> +obj-$(CONFIG_ACPI_APEI_EINJ_CXL) += einj-cxl.o
>>
>> No new module needed. It only needs another compilation unit optionally
>> added to einj.ko. Something like this:
>>
>> diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
>> index 4dfac2128737..2c474e6477e1 100644
>> --- a/drivers/acpi/apei/Makefile
>> +++ b/drivers/acpi/apei/Makefile
>> @@ -2,6 +2,8 @@
>>  obj-$(CONFIG_ACPI_APEI)                += apei.o
>>  obj-$(CONFIG_ACPI_APEI_GHES)   += ghes.o
>>  obj-$(CONFIG_ACPI_APEI_EINJ)   += einj.o
>> +einj-y                         := einj-core.o
>> +einj-$(CONFIG_ACPI_APEI_EINJ_CXL) += einj-cxl.o
>>  obj-$(CONFIG_ACPI_APEI_ERST_DEBUG) += erst-dbg.o
>>  
>>  apei-y := apei-base.o hest.o erst.o bert.o
>> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj-core.c
>> similarity index 100%
>> rename from drivers/acpi/apei/einj.c
>> rename to drivers/acpi/apei/einj-core.c
>>
> 
> And this is what was causing my issues. I couldn't CONFIG_ACPI_APEI_EINJ_CXL work
> as a boolean because I didn't put it in the right compilation unit. This should
> also allow me to remove the dependency in the next patch and the exports below.
> 
>>>  obj-$(CONFIG_ACPI_APEI_ERST_DEBUG) += erst-dbg.o
>>>  
>>>  apei-y := apei-base.o hest.o erst.o bert.o
>>> diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
>>> index 67c2c3b959e1..336408f4f293 100644
>>> --- a/drivers/acpi/apei/apei-internal.h
>>> +++ b/drivers/acpi/apei/apei-internal.h
>>> @@ -130,4 +130,21 @@ static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
>>>  }
>>>  
>>>  int apei_osc_setup(void);
>>> +
>>> +int einj_get_available_error_type(u32 *type);
>>> +int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
>>> +		      u64 param4);
>>> +bool einj_is_initialized(void);
>>> +bool einj_is_cxl_error_type(u64 type);
>>> +int einj_validate_error_type(u64 type);
>>> +
>>> +#ifndef ACPI_EINJ_CXL_CACHE_CORRECTABLE
>>> +#define ACPI_EINJ_CXL_CACHE_CORRECTABLE     BIT(12)
>>> +#define ACPI_EINJ_CXL_CACHE_UNCORRECTABLE   BIT(13)
>>> +#define ACPI_EINJ_CXL_CACHE_FATAL           BIT(14)
>>> +#define ACPI_EINJ_CXL_MEM_CORRECTABLE       BIT(15)
>>> +#define ACPI_EINJ_CXL_MEM_UNCORRECTABLE     BIT(16)
>>> +#define ACPI_EINJ_CXL_MEM_FATAL             BIT(17)
>>> +#endif
>>> +
>>>  #endif
>>> diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
>>> new file mode 100644
>>> index 000000000000..607d4f6adb98
>>> --- /dev/null
>>> +++ b/drivers/acpi/apei/einj-cxl.c
>>> @@ -0,0 +1,121 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * CXL Error INJection support. Used by CXL core to inject
>>> + * protocol errors into CXL ports.
>>> + *
>>> + * Copyright (C) 2023 Advanced Micro Devices, Inc.
>>> + *
>>> + * Author: Ben Cheatham <benjamin.cheatham@amd.com>
>>> + */
>>> +#include <linux/einj-cxl.h>
>>> +#include <linux/debugfs.h>
>>> +
>>> +#include "apei-internal.h"
>>> +
>>> +static struct { u32 mask; const char *str; } const einj_cxl_error_type_string[] = {
>>> +	{ BIT(12), "CXL.cache Protocol Correctable" },
>>> +	{ BIT(13), "CXL.cache Protocol Uncorrectable non-fatal" },
>>> +	{ BIT(14), "CXL.cache Protocol Uncorrectable fatal" },
>>> +	{ BIT(15), "CXL.mem Protocol Correctable" },
>>> +	{ BIT(16), "CXL.mem Protocol Uncorrectable non-fatal" },
>>> +	{ BIT(17), "CXL.mem Protocol Uncorrectable fatal" },
>>> +};
>>> +
>>> +int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
>>> +{
>>> +	int cxl_err, rc;
>>> +	u32 available_error_type = 0;
>>> +
>>> +	if (!einj_is_initialized())
>>> +		return -ENXIO;
>>> +
>>> +	rc = einj_get_available_error_type(&available_error_type);
>>> +	if (rc)
>>> +		return rc;
>>> +
>>> +	for (int pos = 0; pos < ARRAY_SIZE(einj_cxl_error_type_string); pos++) {
>>> +		cxl_err = ACPI_EINJ_CXL_CACHE_CORRECTABLE << pos;
>>> +
>>> +		if (available_error_type & cxl_err)
>>> +			seq_printf(m, "0x%08x\t%s\n",
>>> +				   einj_cxl_error_type_string[pos].mask,
>>> +				   einj_cxl_error_type_string[pos].str);
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(einj_cxl_available_error_type_show, CXL);
>>> +
>>> +static int cxl_dport_get_sbdf(struct pci_dev *dport_dev, u64 *sbdf)
>>> +{
>>> +	struct pci_bus *pbus;
>>> +	struct pci_host_bridge *bridge;
>>> +	u64 seg = 0, bus;
>>> +
>>> +	pbus = dport_dev->bus;
>>> +	bridge = pci_find_host_bridge(pbus);
>>> +
>>> +	if (!bridge)
>>> +		return -ENODEV;
>>> +
>>> +	if (bridge->domain_nr != PCI_DOMAIN_NR_NOT_SET)
>>> +		seg = bridge->domain_nr;
>>> +
>>> +	bus = pbus->number;
>>> +	*sbdf = (seg << 24) | (bus << 16) | dport_dev->devfn;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +int einj_cxl_inject_rch_error(u64 rcrb, u64 type)
>>> +{
>>> +	int rc;
>>> +
>>> +	if (!einj_is_initialized())
>>> +		return -ENXIO;
>>> +
>>> +	/* Only CXL error types can be specified */
>>> +	if (!einj_is_cxl_error_type(type))
>>> +		return -EINVAL;
>>> +
>>> +	rc = einj_validate_error_type(type);
>>> +	if (rc)
>>> +		return rc;
>>> +
>>> +	return einj_error_inject(type, 0x2, rcrb, GENMASK_ULL(63, 12), 0, 0);
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_rch_error, CXL);
>>> +
>>> +int einj_cxl_inject_error(struct pci_dev *dport, u64 type)
>>> +{
>>> +	u64 param4 = 0;
>>> +	int rc;
>>> +
>>> +	if (!einj_is_initialized())
>>> +		return -ENXIO;
>>> +
>>> +	/* Only CXL error types can be specified */
>>> +	if (!einj_is_cxl_error_type(type))
>>> +		return -EINVAL;
>>> +
>>> +	rc = einj_validate_error_type(type);
>>> +	if (rc)
>>> +		return rc;
>>> +
>>> +	rc = cxl_dport_get_sbdf(dport, &param4);
>>> +	if (rc)
>>> +		return rc;
>>> +
>>> +	return einj_error_inject(type, 0x4, 0, 0, 0, param4);
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_error, CXL);
>>> +
>>> +bool einj_cxl_is_initialized(void)
>>> +{
>>> +	return einj_is_initialized();
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(einj_cxl_is_initialized, CXL);
>>> +
>>> +MODULE_AUTHOR("Ben Cheatham");
>>> +MODULE_DESCRIPTION("CXL Error INJection support");
>>> +MODULE_LICENSE("GPL");
>>
>> These go away when cxl-einj.ko is no longer its own module.
>>
>>> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
>>> index 6ea323b9d8ef..e76e64df97a7 100644
>>> --- a/drivers/acpi/apei/einj.c
>>> +++ b/drivers/acpi/apei/einj.c
>>> @@ -37,6 +37,12 @@
>>>  #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
>>>  				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
>>>  				ACPI_EINJ_MEMORY_FATAL)
>>> +#define CXL_ERROR_MASK		(ACPI_EINJ_CXL_CACHE_CORRECTABLE | \
>>> +				ACPI_EINJ_CXL_CACHE_UNCORRECTABLE | \
>>> +				ACPI_EINJ_CXL_CACHE_FATAL | \
>>> +				ACPI_EINJ_CXL_MEM_CORRECTABLE | \
>>> +				ACPI_EINJ_CXL_MEM_UNCORRECTABLE | \
>>> +				ACPI_EINJ_CXL_MEM_FATAL)
>>>  
>>>  /*
>>>   * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
>>> @@ -166,7 +172,7 @@ static int __einj_get_available_error_type(u32 *type)
>>>  }
>>>  
>>>  /* Get error injection capabilities of the platform */
>>> -static int einj_get_available_error_type(u32 *type)
>>> +int einj_get_available_error_type(u32 *type)
>>>  {
>>>  	int rc;
>>>  
>>> @@ -176,6 +182,7 @@ static int einj_get_available_error_type(u32 *type)
>>>  
>>>  	return rc;
>>>  }
>>> +EXPORT_SYMBOL_GPL(einj_get_available_error_type);
>>
>> There should not be any need for new exports from the legacy einj.c.
>>
>>>  
>>>  static int einj_timedout(u64 *t)
>>>  {
>>> @@ -536,8 +543,8 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>>>  }
>>>  
>>>  /* Inject the specified hardware error */
>>> -static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>>> -			     u64 param3, u64 param4)
>>> +int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
>>> +		      u64 param4)
>>>  {
>>>  	int rc;
>>>  	u64 base_addr, size;
>>> @@ -560,8 +567,11 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>>>  	if (type & ACPI5_VENDOR_BIT) {
>>>  		if (vendor_flags != SETWA_FLAGS_MEM)
>>>  			goto inject;
>>> -	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM))
>>> +	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)) {
>>>  		goto inject;
>>> +	} else if ((type & CXL_ERROR_MASK) && (flags & SETWA_FLAGS_MEM)) {
>>> +		goto inject;
>>> +	}
>>>  
>>>  	/*
>>>  	 * Disallow crazy address masks that give BIOS leeway to pick
>>> @@ -592,6 +602,7 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>>>  
>>>  	return rc;
>>>  }
>>> +EXPORT_SYMBOL_GPL(einj_error_inject);
>>>  
>>>  static u32 error_type;
>>>  static u32 error_flags;
>>> @@ -613,12 +624,6 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
>>>  	{ BIT(9), "Platform Correctable" },
>>>  	{ BIT(10), "Platform Uncorrectable non-fatal" },
>>>  	{ BIT(11), "Platform Uncorrectable fatal"},
>>> -	{ BIT(12), "CXL.cache Protocol Correctable" },
>>> -	{ BIT(13), "CXL.cache Protocol Uncorrectable non-fatal" },
>>> -	{ BIT(14), "CXL.cache Protocol Uncorrectable fatal" },
>>> -	{ BIT(15), "CXL.mem Protocol Correctable" },
>>> -	{ BIT(16), "CXL.mem Protocol Uncorrectable non-fatal" },
>>> -	{ BIT(17), "CXL.mem Protocol Uncorrectable fatal" },
>>>  	{ BIT(31), "Vendor Defined Error Types" },
>>>  };
>>>  
>>> @@ -640,29 +645,21 @@ static int available_error_type_show(struct seq_file *m, void *v)
>>>  
>>>  DEFINE_SHOW_ATTRIBUTE(available_error_type);
>>>  
>>> -static int error_type_get(void *data, u64 *val)
>>> -{
>>> -	*val = error_type;
>>> -
>>> -	return 0;
>>> -}
>>> -
>>> -static int error_type_set(void *data, u64 val)
>>> +int einj_validate_error_type(u64 type)
>>>  {
>>> +	u32 tval, vendor, available_error_type = 0;
>>>  	int rc;
>>> -	u32 available_error_type = 0;
>>> -	u32 tval, vendor;
>>>  
>>>  	/* Only low 32 bits for error type are valid */
>>> -	if (val & GENMASK_ULL(63, 32))
>>> +	if (type & GENMASK_ULL(63, 32))
>>>  		return -EINVAL;
>>>  
>>>  	/*
>>>  	 * Vendor defined types have 0x80000000 bit set, and
>>>  	 * are not enumerated by ACPI_EINJ_GET_ERROR_TYPE
>>>  	 */
>>> -	vendor = val & ACPI5_VENDOR_BIT;
>>> -	tval = val & 0x7fffffff;
>>> +	vendor = type & ACPI5_VENDOR_BIT;
>>> +	tval = type & GENMASK(30, 0);
>>>  
>>>  	/* Only one error type can be specified */
>>>  	if (tval & (tval - 1))
>>> @@ -671,9 +668,39 @@ static int error_type_set(void *data, u64 val)
>>>  		rc = einj_get_available_error_type(&available_error_type);
>>>  		if (rc)
>>>  			return rc;
>>> -		if (!(val & available_error_type))
>>> +		if (!(type & available_error_type))
>>>  			return -EINVAL;
>>>  	}
>>> +
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(einj_validate_error_type);
>>> +
>>> +bool einj_is_cxl_error_type(u64 type)
>>> +{
>>> +	return (type & CXL_ERROR_MASK) && (!(type & ACPI5_VENDOR_BIT));
>>> +}
>>> +EXPORT_SYMBOL_GPL(einj_is_cxl_error_type);
>>> +
>>> +static int error_type_get(void *data, u64 *val)
>>> +{
>>> +	*val = error_type;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int error_type_set(void *data, u64 val)
>>> +{
>>> +	int rc;
>>> +
>>> +	/* CXL error types have to be injected from cxl debugfs */
>>> +	if (einj_is_cxl_error_type(val))
>>> +		return -EINVAL;
>>> +
>>> +	rc = einj_validate_error_type(val);
>>> +	if (rc)
>>> +		return rc;
>>> +
>>>  	error_type = val;
>>>  
>>>  	return 0;
>>> @@ -709,6 +736,12 @@ static int einj_check_table(struct acpi_table_einj *einj_tab)
>>>  	return 0;
>>>  }
>>>  
>>> +bool einj_is_initialized(void)
>>> +{
>>> +	return einj_initialized;
>>> +}
>>> +EXPORT_SYMBOL_GPL(einj_is_initialized);
>>
>> The variable can be referenced directly as a global symbol.
> 

