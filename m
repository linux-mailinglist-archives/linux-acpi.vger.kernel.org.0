Return-Path: <linux-acpi+bounces-2784-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C6F82A249
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jan 2024 21:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19F86280DC3
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jan 2024 20:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DB04B5BB;
	Wed, 10 Jan 2024 20:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bqi4UIW+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653B52A8C1;
	Wed, 10 Jan 2024 20:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOuBjVa/nVPYzg1HsYuqlCkyKI87eZvj808u8tVCVM+u2SbVDuU6FQSMgfmufI84jJs4AwkvNp92kOkKKfrZ6kRK1BRUjh+gj3YFJ7kFtow3qCt1QkFWJs6STBuF7umuKih6mwT92naH/baWpmfKaMyCIvunT8N8fsOB+a6xuD4jnsUlJl93uGVa8X11OGXJoyre9NiInEHVcjJNZY3xAm2vZGvXCeka5kax0HP5+/CopW0fV1nxo/vMBWyrzXafP8aULWsWWlfL+7XAcuZ58gqgcNd7fhxj6A6jklDx9/Kh6u3co0q+P1ybC5VrCCmDKJOssbpV/IGpvtUaIuCuRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gw9QLg2BQuoJLMfXW8U39rpBEBG2X1HyOxljn2+cU2I=;
 b=mt1E+VMhUOFc8UkLJvezUAkE376EnEfS8x2iPsEEFj9TJtb671uVF/j3xnCvetd62/EWl0FV39LK8IQACEweWZB6XdQQop2QQ/rger2wU+qmGSDL3vS0qngXuGeoeSY0XNK/FFpsqHP4lMhQz+hev2djEv0t3wpQt+8h8rB9ctsE+roDB40J3gIL/rwBboPikZ6VHeamHjum9MnOtPNL/ltrxdpHcsIbyU5EWoM4ReENmphoFGl6iP3lewWCHHnsxzKgjrD06thN47Ohf6kTupW3Ptrm34XrSuMrNejszfP+lq7fyfwznQBCUog1E6nBIuT0Ey2Q3HOKtOtZf17bPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gw9QLg2BQuoJLMfXW8U39rpBEBG2X1HyOxljn2+cU2I=;
 b=Bqi4UIW+x/mKoGQeKgXZ0771DBbpMVDOFYn+f6c5/K1XEtSL12qkeOopRHDiuk2zlvtUFyu+U+hwMLQOTt+iyIPhtjDwSxuLgXGWM+c+H1NGCG0PRPSWc1cmUZIK45werl++d5XNncTvlaj8Eg+GnGkmgecP9sEQGWVvSk0wHbY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3268.namprd12.prod.outlook.com (2603:10b6:408:6c::18)
 by MW4PR12MB6682.namprd12.prod.outlook.com (2603:10b6:303:1e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 20:31:45 +0000
Received: from BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::cc71:1a30:afcb:c569]) by BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::cc71:1a30:afcb:c569%7]) with mapi id 15.20.7159.015; Wed, 10 Jan 2024
 20:31:45 +0000
Message-ID: <83ab6ac9-8e64-475e-8ef3-a605cfafedac@amd.com>
Date: Wed, 10 Jan 2024 14:31:41 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/5] cxl/core, EINJ: Add CXL debugfs files and EINJ
 functions
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, dave@stogolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 rafael@kernel.org
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20231213223702.543419-1-Benjamin.Cheatham@amd.com>
 <20231213223702.543419-5-Benjamin.Cheatham@amd.com>
 <65812045c086b_71549294aa@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <65812045c086b_71549294aa@dwillia2-mobl3.amr.corp.intel.com.notmuch>
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
X-MS-Office365-Filtering-Correlation-Id: a2065677-74b3-48ad-085e-08dc121b29b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a1E7KrYgk7hMl6iz+mnURo+i5svzUXXxFcaXu27BzK1QIin1hYf/3/zC111fHlqyc0gA/gBegBKZkG1Pc3ahDRXEhoU7XxWsvGhqzn3koKY8h7PTfhwlAPSypU8vtcjwAcmZc24TLvKll/kW/muBrNuCiy0G1nLtyX6XoIG+u6QYzn3GN9rfYTCyvgGnjexiT6YYCz18WaSKpGoLaIYLaIFX5i7xoRr05cMtNBmLGZfAc7a0rG3KlnOiU8SJcx9VZs4wJ1veZ3ZR9vomldX5+RDJN+9cKFwJp4LPNtvRrnAUfodj5m36fjv7Uh/5MoHHw2at7BE7UdGZeBDbZB8EV4jO0Ul2Escub9s0ll18cjISDefA/0UOFmrZZI6qZyfOEIUp0pQiTHca9tqWQEw1Wt0Hf0If967Ri0ee2WNqwrbHNhDoBsqXdPSnNM1sN/3M8CR0zIrZgul66V/loNIDfWISjEU71GjJMa6k0nRbHgdjrQJzPA3bsxwZB8BgwHza+6tGF7Qu9CHTSqRHbxAnZIV3CTq+P13lmTrfjqm/UASGXkmg0ovx7VDNbcUETze8mBdU7df62Z1kfsyauW0HfDk23+9W9PTlUS4asWa8XbYKEJiuN8qZ0JWnAlhXQ5jAheLCu5Jw/01EpRp3osbmUw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3268.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(136003)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31686004)(83380400001)(41300700001)(36756003)(86362001)(31696002)(66946007)(6506007)(66476007)(2616005)(26005)(38100700002)(53546011)(6512007)(6666004)(6486002)(2906002)(66556008)(30864003)(478600001)(316002)(5660300002)(8676002)(8936002)(7416002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWZTUWY2ZHZtTzN6M3J6QzVuS3ZFS3VNdGJBVXRKbkNkaWhRdXNXRWFlZFNR?=
 =?utf-8?B?RHpIVGFXNFR6U3RQSERUMmtseDdPRE1KN0NTOUtvZ25OTlRGZWxwVHdjc01O?=
 =?utf-8?B?eXlPSm9sSG40SlFqVGlldHFSeFhTZjNWaVFzckQ0bG1JanhoRlc3Tzg5bGVV?=
 =?utf-8?B?bEV4ckJUZW1xNkZsVU5BWFBWVldHMGNIRmh5T0lXUlVFMzhIS1BJR05BQktz?=
 =?utf-8?B?WVQ0TVdzdU9jUzFncVlxeXpqaGZocDYwZXRWUVFNMzJCd3llRDM5cmRmV0Qx?=
 =?utf-8?B?Y3RhK0VveENrdUFXUWQrWnB1WlBNaWp5dktQRjhabDRVRGpMNmJqRXRKSGJB?=
 =?utf-8?B?aEZidy8wSzdXR2F1YzMvWU82VCtMR3hyRS9JclZqMWNnRkFPdkFnY2o0RFlG?=
 =?utf-8?B?TWcyYjVDanFGVlFpYVl1RDY1SEVVVFplQTJHUWVEZENHUFViaVhpdWVIby9V?=
 =?utf-8?B?MEFadUQrZll0MGtGeUhZQWUvU3FtdUZaR2lmcmplandYQllVYUltOUdZenJw?=
 =?utf-8?B?dmh1WVdmYW5KdmVmdFg5NXI1ZzF2TFV4ZndScjR1akVMZzlVUTMrUHdiUEdO?=
 =?utf-8?B?ZW5PenRBeTBEVlpVMytlakV1dExyQm9pUlQvZVFsN0N2M0N6TG43d1BSSWcz?=
 =?utf-8?B?RGx4ZHpScHMwRm1KODJydlA5RVFNdjdDWmdWSVNxS0hud1luTXl1NFlwMndy?=
 =?utf-8?B?dXhoSHk3Zk8xTndrT29HU24wek5rdmpMRktYMUFGdFNXNU1IY2taZndvNXkx?=
 =?utf-8?B?azFzMHVZWUZNdkJURVdzN04ydlFMTG91NjlrWXZlSjUzT3U1R25VNXAvdzl5?=
 =?utf-8?B?ZXRiQW92QWZIM0p2QWlDZ2lCVFNCV0FRNVFLMzI3WGo4T1lYZmVuQmM4YnRK?=
 =?utf-8?B?QXJKVU1ZK2Nnb1NaT0lSTzBXMnRYdFVyTXBBbHdTdXlQQ2ZvZUw1ekxaR2Ur?=
 =?utf-8?B?eDhuMy8vNktpem4zT2thdFBUajdOcSt2NzRHV0JMbS9qTVhFck1yNHc4U2RF?=
 =?utf-8?B?eTQwWUFQZjZjZHhENmlvb0pva1VyR2owcUkyb1VPS1VYZFc5QlNITkRRS1N0?=
 =?utf-8?B?NkpIZjkrV1dCQnljTk5sSlNjbER3dm5ieEV6bjBCNk1WTWxBZS9PTkNmTDdX?=
 =?utf-8?B?a2pXRFROWVpiU2xCdDhwbFY2WERRQVEwbFF3ZmcyeWNJZlZWU2hQeUwwVFFT?=
 =?utf-8?B?U1lMS0VZSjZnaFhabW5ObURrR0d5OG9lQjU0YXk2ZytSNlUzV0VnQ2RsVTd6?=
 =?utf-8?B?RnRseVBnbWFLUWdaWVVWalQ3ZmNzb3EwK1RxN0dLbkF3M2huTDQrZFA2SkJG?=
 =?utf-8?B?TnkxdVQ4TFIwOFA0VVZSTVM3MkhsVUErK1Z3andueFRMckZPZUs4dWdtSmRx?=
 =?utf-8?B?a2c3QTEwUk00QlJ1bWFUMzhhVjJSQTVEY0kyTS82M29Mallydkl3N0xJR1d5?=
 =?utf-8?B?SjVNVjRUWGxnaWhDRGRGN1FKZ1JNVUZOalNEemVrUXNIN3hHWFUveVc2bmE1?=
 =?utf-8?B?TnJlNFdWWTVtT01Tc09pc2Y4cTBGTnR0bHdSekp3UzZjTGxyVElwZ2QxcGNN?=
 =?utf-8?B?aTF6UzFKZ2UwWncrOG9HRUtJVytrSElyVEhxTVhsK3R1MEVZYXlHWXdVbnB0?=
 =?utf-8?B?L1pITFB2b1k4Z3pIYVlxS05BakpwblVZeWVuZUNLRi9sZ0FZczFmckZPanpB?=
 =?utf-8?B?M1doSlRZTTZyV3hXays1cHN3SDFCNFJzanp0b0VWTzFaUW9Ga3VEQTlkbWhS?=
 =?utf-8?B?ckZJYW14d2tpWGhGdW5NNkdHWVBJSVZQSEY5cjV4MGN1cEtmVXozZ1cvbmJZ?=
 =?utf-8?B?bjlNR3lEcmhmVG1RQ1B4NkZIdlVFNmhQSUNjbFNDUnJMbSs5eTFIK2VRMFUz?=
 =?utf-8?B?SGhCQzlGNytOd2xVR0hOMWZTL05jZkMvTFJTUlYrcWUyVDh1aldiM3RVb3Jo?=
 =?utf-8?B?K2hIeVdXTjB3dEVkTDNpNkdOSlFYaFVLU3FqMTdTSUJjSTFBaEszTW1XUmtV?=
 =?utf-8?B?ajA2WkpmcXJZWXozcjJYRkVvQ2pvUTJRUVVxdXY2alZ0UUFmR3U2NWJnUFh6?=
 =?utf-8?B?S2doQXNkbkhBSnBZbHVrYzAzTk1MZjJ2T29VT2lqZ0YyN1I0MTJLWDYvTGY3?=
 =?utf-8?Q?xW+p2VRO0bCCzpoKMF4Oq5ccK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2065677-74b3-48ad-085e-08dc121b29b5
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3268.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 20:31:45.4214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/iYXUXcgf0xFZyUolDKiJtxBbJ6rgH/42xXqomSc74tIIqjD0PHeiR0r9gQRBDGKDHHAfxWTo4PYEbQPT06qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6682



On 12/18/23 10:47 PM, Dan Williams wrote:
> Ben Cheatham wrote:
>> Implement CXL helper functions in the EINJ module for getting the
>> available CXL protocol error types and injecting CXL errors and export
>> them to sysfs under kernel/debug/cxl.
>>
>> The kernel/debug/cxl/einj_types file will print the available CXL
>> protocol errors in the same format as the available_error_types
>> file provided by the EINJ module. The
>> kernel/debug/cxl/$dport_dev/einj_inject is functionally the same as the
>> error_type and error_inject files provided by the EINJ module, i.e.:
>> writing an error type into $dport_dev/einj_inject will inject said error
>> type into the CXL dport represented by $dport_dev.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
>> ---
>>  Documentation/ABI/testing/debugfs-cxl |  23 ++++
>>  drivers/acpi/apei/einj.c              | 144 ++++++++++++++++++++++++--
>>  drivers/cxl/core/port.c               |  33 ++++++
>>  drivers/cxl/einj.h                    |  58 +++++++++++
>>  4 files changed, 248 insertions(+), 10 deletions(-)
>>  create mode 100644 drivers/cxl/einj.h
>>
>> diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
>> index fe61d372e3fa..97a8684bad84 100644
>> --- a/Documentation/ABI/testing/debugfs-cxl
>> +++ b/Documentation/ABI/testing/debugfs-cxl
>> @@ -33,3 +33,26 @@ Description:
>>  		device cannot clear poison from the address, -ENXIO is returned.
>>  		The clear_poison attribute is only visible for devices
>>  		supporting the capability.
>> +
>> +What:		/sys/kernel/debug/cxl/einj_types
>> +Date:		November, 2023
>> +KernelVersion:	v6.8
>> +Contact:	linux-cxl@vger.kernel.org
>> +Description:
>> +		(RO) Prints the CXL protocol error types made available by
>> +		the platform in the format "0x<error number>	<error type>".
>> +		The <error number> can be written to einj_inject to inject
>> +		<error type> into a chosen dport. This file is only visible if
>> +		CONFIG_CXL_EINJ is enabled.
> 
> I don't think the Kconfig dependency needs to be mentioned here.
> 
I'll remove it.

>> +
>> +What:		/sys/kernel/debug/cxl/$dport_dev/einj_inject
>> +Date:		November, 2023
>> +KernelVersion:	v6.8
>> +Contact:	linux-cxl@vger.kernel.org
>> +Description:
>> +		(WO) Writing an integer to this file injects the corresponding
>> +		CXL protocol error into $dport_dev (integer to type mapping is
>> +		available by reading from einj_types). 
> 
> Maybe mention that $dport_dev is a device name from /sys/bus/pci/devices?
> 

Will do!

>> +		enumerated in RCH mode, a CXL 1.1 error is injected, otherwise
>> +		a CXL 2.0 error is injected. This file is only visible if
>> +		CONFIG_CXL_EINJ is enabled.
> 
> Same "drop the Kconfig mention" here.
> 
>> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
>> index 26a887d2a5cd..1a2195779b52 100644
>> --- a/drivers/acpi/apei/einj.c
>> +++ b/drivers/acpi/apei/einj.c
>> @@ -24,6 +24,7 @@
>>  #include <asm/unaligned.h>
>>  
>>  #include "apei-internal.h"
>> +#include "../../cxl/einj.h"
> 
> I thought this was going to move to a top-level header?
> 

Sorry, I either misunderstood you a couple of versions ago or misread the original request.
I'll move it under include/linux.

>>  
>>  #undef pr_fmt
>>  #define pr_fmt(fmt) "EINJ: " fmt
>> @@ -36,6 +37,12 @@
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
>> @@ -537,8 +544,11 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
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
>> @@ -590,6 +600,9 @@ static const char * const einj_error_type_string[] = {
>>  	"0x00000200\tPlatform Correctable\n",
>>  	"0x00000400\tPlatform Uncorrectable non-fatal\n",
>>  	"0x00000800\tPlatform Uncorrectable fatal\n",
>> +};
>> +
>> +static const char * const einj_cxl_error_type_string[] = {
>>  	"0x00001000\tCXL.cache Protocol Correctable\n",
>>  	"0x00002000\tCXL.cache Protocol Uncorrectable non-fatal\n",
>>  	"0x00004000\tCXL.cache Protocol Uncorrectable fatal\n",
>> @@ -617,29 +630,44 @@ DEFINE_SHOW_ATTRIBUTE(available_error_type);
>>  
>>  static bool einj_initialized;
>>  
>> -static int error_type_get(void *data, u64 *val)
>> +int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
> 
> Oh nice an einj_cxl_ prefix in the global namespace, looks appropriate. I
> mention this here because I don't think a later cxl_einj_ wrapper makes
> sense, see below.
> 
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
>> +		cxl_err = ACPI_EINJ_CXL_CACHE_CORRECTABLE << pos;
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
>>  
>>  	/* Only one error type can be specified */
>>  	if (tval & (tval - 1))
>> @@ -648,9 +676,105 @@ static int error_type_set(void *data, u64 val)
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
>> +		seg = bridge->domain_nr << 24;
>> +
>> +	bus = pbus->number << 16;
>> +	*sbdf = seg | bus | dport_dev->devfn;
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
>> +		return -EINVAL;
>> +
>> +	rc = validate_error_type(type);
>> +	if (rc)
>> +		return rc;
>> +
>> +	param1 = (u64) rcrb;
>> +	param2 = 0xfffffffffffff000;
>> +	flags = 0x2;
>> +
>> +	return einj_error_inject(type, flags, param1, param2, 0, param4);
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
>> +}
>> +EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_error, CXL);
>> +
>> +static int error_type_get(void *data, u64 *val)
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
>> +	if (val & CXL_ERROR_MASK && !(val & ACPI5_VENDOR_BIT))
>> +		return -EINVAL;
>> +
>> +	rc = validate_error_type(val);
>> +	if (rc)
>> +		return rc;
>> +
>>  	error_type = val;
>>  
>>  	return 0;
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 38441634e4c6..4ed4a24138c3 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -11,6 +11,7 @@
>>  #include <linux/idr.h>
>>  #include <cxlmem.h>
>>  #include <cxlpci.h>
>> +#include <einj.h>
>>  #include <cxl.h>
>>  #include "core.h"
>>  
>> @@ -783,6 +784,32 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
>>  	return rc;
>>  }
>>  
>> +DEFINE_SHOW_ATTRIBUTE(cxl_einj_available_error_type);
>> +
>> +static int cxl_einj_inject(void *data, u64 type)
>> +{
>> +	struct cxl_dport *dport = data;
>> +
>> +	if (dport->rch)
>> +		return cxl_einj_inject_rch_error(dport->rcrb.base, type);
>> +
>> +	if (!dev_is_pci(dport->dport_dev))
>> +		return -EINVAL;
>> +
>> +	return cxl_einj_inject_error(to_pci_dev(dport->dport_dev), type);
>> +}
>> +DEFINE_DEBUGFS_ATTRIBUTE(cxl_einj_inject_fops, NULL, cxl_einj_inject, "%llx\n");
>> +
>> +static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
>> +{
>> +	struct dentry *dir;
> 
> I think an "IS_ENABLED(CONFIG_CXL_EINJ)" is warranted here.
> 

I agree. I'll add one.

>> +
>> +	dir = cxl_debugfs_create_dir(dev_name(dport->dport_dev));
>> +
>> +	debugfs_create_file("einj_inject", 0200, dir, dport,
>> +			    &cxl_einj_inject_fops);
> 
> I will note that I am little bit uneasy about this ACPI'ism escaping
> into the common core, but he mitigation for me is that if some other
> platform firmware invented a platform-firmware method for error inject
> it would simply need to reuse the einj_cxl_ namespace to make it common.
> 

I'll be honest; I'm not sure I understand the concern here, but that's probably
just inexperience on my part. That being said, I don't mind changing it if you
have any suggestions!

> 
>> +}
>> +
>>  static struct cxl_port *__devm_cxl_add_port(struct device *host,
>>  					    struct device *uport_dev,
>>  					    resource_size_t component_reg_phys,
>> @@ -1136,6 +1163,8 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
>>  	} else {
>>  		dev_dbg(dport_dev, "dport added to %s\n",
>>  			dev_name(&port->dev));
>> +
>> +		cxl_debugfs_create_dport_dir(dport);
>>  	}
>>  
>>  	return dport;
>> @@ -1170,6 +1199,8 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>>  	} else {
>>  		dev_dbg(dport_dev, "RCH dport added to %s\n",
>>  			dev_name(&port->dev));
>> +
>> +		cxl_debugfs_create_dport_dir(dport);
>>  	}
> 
> Move the above 2 invocations into 1 common call from
> __devm_cxl_add_dport().
> 

Will do.

>>  
>>  	return dport;
>> @@ -2109,6 +2140,8 @@ static __init int cxl_core_init(void)
>>  	int rc;
>>  
>>  	cxl_debugfs = debugfs_create_dir("cxl", NULL);
>> +	debugfs_create_file("einj_types", 0400, cxl_debugfs, NULL,
>> +			    &cxl_einj_available_error_type_fops);
> 
> This should be gated by "IS_ENABLED(CONFIG_CXL_EINJ)"
> 

Will do.

>>  
>>  	cxl_mbox_init();
>>  
>> diff --git a/drivers/cxl/einj.h b/drivers/cxl/einj.h
>> new file mode 100644
>> index 000000000000..b913763c3238
>> --- /dev/null
>> +++ b/drivers/cxl/einj.h
>> @@ -0,0 +1,58 @@
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
>> +#include <linux/pci.h>
>> +
>> +int einj_cxl_available_error_type_show(struct seq_file *m, void *v);
>> +int einj_cxl_inject_error(struct pci_dev *dport_dev, u64 type);
>> +int einj_cxl_inject_rch_error(u64 rcrb, u64 type);
> 
> See below, these should be within the ifdef guard.
> 
>> +
>> +#if IS_ENABLED(CONFIG_CXL_EINJ)
> 
> This should be
> 
> #ifdef CONFIG_ACPI_APEI_EINJ
> 
> ...because that is the module defining the exported public interface.
> 

Makes sense, I'll change it.

>> +static inline int cxl_einj_available_error_type_show(struct seq_file *m,
>> +						     void *v)
>> +{
>> +	return einj_cxl_available_error_type_show(m, v);
>> +}
>> +
>> +static inline int cxl_einj_inject_error(struct pci_dev *dport_dev, u64 type)
>> +{
>> +	return einj_cxl_inject_error(dport_dev, type);
>> +}
>> +
>> +static inline int cxl_einj_inject_rch_error(u64 rcrb, u64 type)
>> +{
>> +	return einj_cxl_inject_rch_error(rcrb, type);
>> +}
> 
> Above 3 static inlines can be deleted, this section of the ifdef would
> just be:
> 
> int einj_cxl_available_error_type_show(struct seq_file *m, void *v);
> int einj_cxl_inject_error(struct pci_dev *dport_dev, u64 type);
> int einj_cxl_inject_rch_error(u64 rcrb, u64 type);
> 

Sounds good. I originally tried this but was getting compile-time errors in einj.c
most likely due to gating around CONFIG_CXL_EINJ instead of CONFIG_ACPI_APEI_EINJ.

>> +
>> +#else
>> +static inline int cxl_einj_available_error_type_show(struct seq_file *m,
>> +						     void *v)
>> +{
>> +	return -ENXIO;
>> +}
>> +
>> +static inline int cxl_einj_type_show(struct seq_file *m, void *data)
>> +{
>> +	return -ENXIO;
>> +}
>> +
>> +static inline int cxl_einj_inject_error(struct pci_dev *dport_dev, u64 type)
>> +{
>> +	return -ENXIO;
>> +}
>> +
>> +static inline int cxl_einj_inject_rch_error(u64 rcrb, u64 type)
>> +{
>> +	return -ENXIO;
>> +}
>> +#endif
> 
> Rename these to their einj_cxl_ equivalent.

Gladly! I wasn't a fan of using cxl_einj_ and einj_cxl_ at the same time since the prefixes are so similiar :/.

Thanks again,
Ben

