Return-Path: <linux-acpi+bounces-150-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BC57AF0C5
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 18:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D8F14281C45
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 16:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FDD34CC2
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 16:31:44 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4481C30CE6
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 16:00:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1F8EB;
	Tue, 26 Sep 2023 09:00:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nmsc2k4HavF6vAbQdnzn7DwDrBSfhyNG87xWJnb2n0sBKopyMfh1cVB54eaeWjp2TK/5qFQmTbupahsIu1UGIX5A5IrOlRzyM34WC52PnTzCMO46VaZiTAT+sZU9fb7pfLG8IDSE0Y3YvICWp6U758GxP1RsPe+vsgovUFuzbRE+BN76MO0LtD07CGZkPytyHYOae98NzJKP9YrIDdlWBirHzizJQFFEpBa6HTFI3N/fM16mhKOS1wDP5mrFy5a81mbdLKqoAoxZfOLxNqjIYY0gZDCH5NGO2VJLU0VQGIxcsQSyQ6Sl16UXbyumnHmWfNTzAdQF+I33dcBvyu17Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKbLGYwtF1iBqeQeRpIuhyJNew4HMDRdYeZjykzZgp0=;
 b=kUQOeTx5i6Pi/jd31OsRT0UD4lmAjWo1UMY6S8Cr4O2MgY7+XXfN1/8Ms5QhcFm1e97F8gDaGM3EXWeSZyfneect+wlFJTiTBj+2w0es1U1F1EGdt+eMdxNcWtrKMhNgiyvHiJFfCTnVNjMKtaByaldRnpuOsjbb2Nmeg/b0EreNBowJnAs3DqwO56llZDDVIZp/8jgPmNbBzbHGgRnuotU68skSN/CoqjhykOaeX4MoujEbGSKmMpXpAl0iWkKn1FfkgmbbuWq3G9YM8/hdElfhabhWJcnZwdsbJPoNd21eJu0Kyc5SMYOPxMPFtKH+doeUIdshO9jc4FUJJvitIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKbLGYwtF1iBqeQeRpIuhyJNew4HMDRdYeZjykzZgp0=;
 b=mBqr5GhpKohQs0iJKjx1dw+iIWuRBkGeFC/W1jdap6L0DABBlRq3cWm/MZHxjdft9X2qSOJNFSvDs6HvqBbPBngPDwZs+OCIB78vb9OaJZ2gI8rlxjOoLFwYOArcI3FO5xYJbDVfVkodNmRpEA+S2NNxO8dH4Ym037Asu5h3PWc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3268.namprd12.prod.outlook.com (2603:10b6:408:6c::18)
 by PH7PR12MB8040.namprd12.prod.outlook.com (2603:10b6:510:26b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 16:00:44 +0000
Received: from BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::6423:58db:9384:4031]) by BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::6423:58db:9384:4031%6]) with mapi id 15.20.6838.016; Tue, 26 Sep 2023
 16:00:44 +0000
Message-ID: <4b215fe1-3d65-f016-7854-730d646f2fca@amd.com>
Date: Tue, 26 Sep 2023 11:00:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 2/3] ACPI, APEI, EINJ: Add CXL 1.1 EINJ error type
 support
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: rafael@kernel.org, dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org, bhelgaas@google.com, yazen.ghannam@amd.com
References: <20230925200127.504256-1-Benjamin.Cheatham@amd.com>
 <20230925200127.504256-3-Benjamin.Cheatham@amd.com>
 <20230926120418.0000575d@Huawei.com>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20230926120418.0000575d@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0530.namprd03.prod.outlook.com
 (2603:10b6:408:131::25) To BN8PR12MB3268.namprd12.prod.outlook.com
 (2603:10b6:408:6c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3268:EE_|PH7PR12MB8040:EE_
X-MS-Office365-Filtering-Correlation-Id: c274422c-3360-4e6d-10d6-08dbbea9bd7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Wox6z+2qYNLHzAyQ3wnU9hkDyqEkme9qoioFhY+RZJWsuv/x78NeNMy7vv9w7Iv/knIUK+h3NQQeNa19bYtpouA9b8IXWEFcT9E8Lr07vy3BNDwpKlzn1O5OXBW3aukYtpbR8YkjpOg1xTNyvBurcU6dh2/AJMNApsmoatQULiNO2W4bqk6nHJ4J4tmI7Z8vfPHpKv11VGQH3AYtNfCPBHT7hDcYqegn5l4pupjIBO6hIIhMvEjjgt0R8CBkd5mdw1IgLb0pXIxFbRsNfDG6ZkI+KwzYmuRT5NdCuj1sBJahGOcUwZoMpuqHKpeBeJBHqX5fCZ+3eQADthWWxS3IdyBs9ryM/bWHDpvavMVLr/3NHGuEbOghVrXqxdFa4r5JpuYDk8f8HErCOd3b5AkvHW4idPfDAQf08o5ZgLUlUBZBtfLupTJAfIWIUnfel8S5zlpClLbSdEh0vLxq0kClSV768YQguVM8TN/jTRe64P8K8qImoxfrrOWwUz4mMl+p4aEV5W8tKJZpVKYsihozPawTdHWq3afRkegV9JRkP23xiibaqO1ghjd6K1J6U8S0kEJMuSqRZGB79rOC3EIIhZwuAErdW3/9CBHVVPyCfob9pydpdPWG31K/Ob6AiFZwQeaGYpUUAPuMoQUFftohbw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3268.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(136003)(376002)(230922051799003)(1800799009)(451199024)(186009)(2906002)(31686004)(5660300002)(66476007)(66946007)(66556008)(478600001)(966005)(6512007)(53546011)(2616005)(26005)(6506007)(6486002)(8936002)(4326008)(8676002)(316002)(6916009)(41300700001)(83380400001)(38100700002)(36756003)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REF4MjRsYUozcEhCQzMxODYrSGlMcklmTjNEK1ZMeW9VRFUrejVMRkpJemM0?=
 =?utf-8?B?R2lGM1RKdVQ5bERzSG0wT20vaDFwM2l3czRKS2ZxcUkrVFQveEZWQklrRzBX?=
 =?utf-8?B?clhjazVzUFFVQm5JemI2U2Y5M2p1a0RhekdZYmdDcUI5eklnR1Zmb0ErdmU1?=
 =?utf-8?B?UnJlbkkwcVIwSXRvUElmRWJoeUVVRXdCUXNLZnIvSlB0bzFCaWdERTFYclZt?=
 =?utf-8?B?YWRVNzY1OGVzUlhDTCtaVzhuSXRKTFMreTNZdzQwV1FROXdKS25YUHZDZUVn?=
 =?utf-8?B?dWsxWGUxd2pBak1vRHVtQyt5Vmx0eGc2dzdUSXRKaTk4QUJXaUVkeUV4eEp5?=
 =?utf-8?B?Z2krL0w5czliMWhUTEZ4RHdSblBqbkJJTXZwVDFCN0xJendyNzYreEttZ3hx?=
 =?utf-8?B?eW92WEoyWUVqeTFqWGZlQTl3TDNVcC9KYXdBOUp5UGtsV0szOFlON2JrbGc5?=
 =?utf-8?B?WFhZZGE5aGxIWTd2NTFKeC9YVVVXcFVSbzZzdDF0bUVRQXpjS216QmlHVkpT?=
 =?utf-8?B?T2pXU2tLWVNteGx2K0JQbFF1TXVJcWRObGVjUjFtVWMvQW5HSk1MVGVQNDND?=
 =?utf-8?B?cEo1Q1NSUlBnWWhIMEdhRWcvWDUrdmtOU2tHK1I1QWQ3OWdwYWpnMVI5OTBE?=
 =?utf-8?B?RVBadzdwUitWNE9KMlRUNGNxWHpxM1U5U0o3Ry85TW10em5DZlo4MVZ0Umht?=
 =?utf-8?B?QnNMV3Rza1F3a2V4bHRzSENkT0x5ZjIzU2l3RUUzODJMb2lSTDNOVzI1a2tl?=
 =?utf-8?B?V1lkNHlFVUdoT2pBVHA5NCtlUys0dnJsQkxHYlB0dmJOclRWZWw1SWR6RVF0?=
 =?utf-8?B?NkVsenNCNkNIQXVNNWt5dnNGaW4vTnE1bmg1WGt3TkpWQ1l6RTZOUG5XRVhG?=
 =?utf-8?B?LzhyY0k2Qkx0ZFY4SkhjUmRtTmIydzNFd2xIZXpvaElDN3pqU0N4RXlpUlF5?=
 =?utf-8?B?YWFUT245QzNEUFM2WSs1VnFTN0tveHZRbHBhZ09aTmZ5cXBiUXdXTEh5R2sv?=
 =?utf-8?B?S0FKTlAvUVVoN0pjL1hKQ3d2d3Y1V2tDN0xILzJtK21uU0RGMnl5bG5UZUN2?=
 =?utf-8?B?VTZWZnRnZmxYYi96YXRkWmVrQ21uR3ZnbWk5bExybmNJN29uUVpzMHhTakZ6?=
 =?utf-8?B?TUlTVkhvaEhiQ0JLYVRBWGgvU0tQeUNTVEduV0FPYVlCWmZNT0FRUUZkaThE?=
 =?utf-8?B?djdrOHZCUXNDUHI0QVZZaDJxdlVxdjA0dFl2TVUvbUcrSlBQN014YndIeG1h?=
 =?utf-8?B?b1R2VFphRG1ib2NxZHV0V0JUL1Jka1hOYmxBY0s3M0pjbFBtZk9LYXhDVFNz?=
 =?utf-8?B?Z2UxWTZZWnlkK1hkTXM2K2xSZzN5U25LTENDN2RURi9JSDliTDRrSWFHbW0w?=
 =?utf-8?B?UUQvNW43YWdwOEYzc3lCbUVOaWo0SDZ2SC96U1JFc3VnT0hQZVQ4ZEFhM1JK?=
 =?utf-8?B?K1FoUXhTcDY2S1BicE1iYnJQT0FDMmFVbldTMkJIK01XeGZRWlVhZTNMZm53?=
 =?utf-8?B?enNUSEFzN3g1bVVrR2RSdm1sZWZ3K1o4Z1kyTDJwZTgzeEwyNDV4Z2QxUG5n?=
 =?utf-8?B?ZXhYSUtBbFA5SzRPeFdOMEZrSy85MXdET0ExSFRWdXpQbDFWNXVNT1ZsSktS?=
 =?utf-8?B?K0VURm1pK1NzcHZKd3BOR0NaTndSN0hFWS9oTlQvMmpDVUdGQzJvcWIxU3pu?=
 =?utf-8?B?ZWpick1rdkFOMXRyOTIxSTNKekJyTTliZU5mQkNJaFN4U3VhK0hyODRSTEVz?=
 =?utf-8?B?ZVh4WkV0Tk1pVWRiek1XaGFGblNWK3hKUWtMRE02Ry9WMTNDWHRJb1dqM0RH?=
 =?utf-8?B?b2xBcEVTNTEwZHduMnhsdWlubGZnZWdiSWxFYmRTeGZKK1g2Q0JSeHJyRHY3?=
 =?utf-8?B?SHJaR1crQ3BsVjNuU1ptY0RvZ3Jqa2Y2L1RQQUNJYnJXdUlRRkR1cmxkVGtx?=
 =?utf-8?B?SUFJc2p5UEpRcnhwN05EakJuaHByMk5BMyt0SG1KbmxxbFVpejNuOUxBOVRv?=
 =?utf-8?B?Vk5rV1NaM0JXQmtxaE5odEo5ZFFZNDRISkI0aDFNZ1Q4Z2hLeWsxK1VCY3Er?=
 =?utf-8?B?aS9ySjYxcUtsOGFUOGFFYWRvU2t4cjdPdExxV0xkMUprSDloUTJ5S0g2VFIv?=
 =?utf-8?Q?WmGNZpGRvAgwrYBoP66ucowLp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c274422c-3360-4e6d-10d6-08dbbea9bd7f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3268.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 16:00:44.1786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5dZjL9hxX7qStG95MOIRn2oW73pPFmjhHjMEDRYhMALs3Cg7dUZ1IXSxJ1mHG/HTYWFY1rPKXGLM3JsFC4mPjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8040
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/26/23 6:04 AM, Jonathan Cameron wrote:
> On Mon, 25 Sep 2023 15:01:26 -0500
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
>> Add support for CXL EINJ error types for CXL 1.1 hosts added in ACPI
>> v6.5. Because these error types target memory-mapped CXL 1.1 compliant
>> downstream ports and not physical (normal/persistent) memory, these
>> error types are not currently  allowed through the memory range
>> validation done by the EINJ driver.
>>
>> The MMIO address of a CXL 1.1 downstream port can be found in the
>> cxl_rcrb_addr file in the corresponding dport directory under
>> /sys/bus/cxl/devices/portX. CXL 1.1 error types follow the same
>> procedure as a memory error type, but with param1 set to the
>> downstream port MMIO address.
>>
>> Example usage:
>> $ cd /sys/kernel/debug/apei/einj
>> $ cat available_error_type
>>     0x00000008      Memory Correctable
>>     0x00000010      Memory Uncorrectable non-fatal
>>     0x00000020      Memory Uncorrectable fatal
>>     0x00000040      PCI Express Correctable
>>     0x00000080      PCI Express Uncorrectable non-fatal
>>     0x00000100      PCI Express Uncorrectable fatal
>>     0x00008000      CXL.mem Protocol Correctable
>>     0x00020000      CXL.mem Protocol Uncorrectable fatal
>> $ echo 0x8000 > error_type
>> $ echo 0xfffffffffffff000 > param2
>> $ echo 0x2 > flags
>> $ cat /sys/bus/cxl/devices/portX/dportY/cxl_rcrb_addr
>> 0xb2f00000
>> $ echo 0xb2f00000 > param1
>> $ echo 1 > error_inject
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> Hi Ben
> 
> A few trivial things inline.
> 
> Jonathan
> 
>> ---
>>  drivers/acpi/apei/Kconfig |  2 ++
>>  drivers/acpi/apei/einj.c  | 24 +++++++++++++++++++++++-
>>  drivers/cxl/acpi.c        |  1 +
>>  drivers/cxl/core/port.c   | 17 +++++++++++++++++
>>  drivers/cxl/cxl.h         |  1 +
>>  include/linux/cxl.h       | 11 +++++++++++
>>  6 files changed, 55 insertions(+), 1 deletion(-)
>>  create mode 100644 include/linux/cxl.h
>>
>> diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
>> index 6b18f8bc7be3..eb9cc7157342 100644
>> --- a/drivers/acpi/apei/Kconfig
>> +++ b/drivers/acpi/apei/Kconfig
>> @@ -55,6 +55,8 @@ config ACPI_APEI_MEMORY_FAILURE
>>  config ACPI_APEI_EINJ
>>  	tristate "APEI Error INJection (EINJ)"
>>  	depends on ACPI_APEI && DEBUG_FS
>> +	imply CXL_BUS
>> +	imply CXL_ACPI
>>  	help
>>  	  EINJ provides a hardware error injection mechanism, it is
>>  	  mainly used for debugging and testing the other parts of
>> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
>> index 013eb621dc92..8000417a5f26 100644
>> --- a/drivers/acpi/apei/einj.c
>> +++ b/drivers/acpi/apei/einj.c
>> @@ -21,6 +21,7 @@
>>  #include <linux/nmi.h>
>>  #include <linux/delay.h>
>>  #include <linux/mm.h>
>> +#include <linux/cxl.h>
>>  #include <asm/unaligned.h>
>>  
>>  #include "apei-internal.h"
>> @@ -36,6 +37,7 @@
>>  #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
>>  				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
>>  				ACPI_EINJ_MEMORY_FATAL)
>> +#define CXL_ERROR_MASK		GENMASK(17, 12)
>>  
>>  /*
>>   * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
>> @@ -512,6 +514,22 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>>  	return rc;
>>  }
>>  
>> +static int is_valid_cxl_addr(u64 addr)
>> +{
>> +	struct cxl_dport *dport;
>> +
>> +	if (IS_REACHABLE(CONFIG_CXL_ACPI))
>> +		dport = cxl_find_rch_dport_by_rcrb((resource_size_t) addr);
>> +	else
>> +		return 0;
> Flip this logic probably so the quick exit is the indented path.
> 
> 	if (!IS_REACHABLE(CONFIG_CXL_ACPI))
> 		return 0
> 
> 	dport = ...

Will do.

> 
>> +
>> +	if (!IS_ERR_OR_NULL(dport))
>> +		return 1;
>> +
>> +	pr_info("Could not find dport with rcrb 0x%llx\n", addr);
>> +	return 0;
>> +}
>> +
>>  /* Inject the specified hardware error */
>>  static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>>  			     u64 param3, u64 param4)
>> @@ -537,8 +555,11 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>>  	if (type & ACPI5_VENDOR_BIT) {
>>  		if (vendor_flags != SETWA_FLAGS_MEM)
>>  			goto inject;
>> -	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM))
>> +	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)) {
>>  		goto inject;
>> +	} else if (type & CXL_ERROR_MASK && is_valid_cxl_addr(param1)) {
>> +		goto inject;
>> +	}
>>  
>>  	/*
>>  	 * Disallow crazy address masks that give BIOS leeway to pick
>> @@ -807,3 +828,4 @@ module_exit(einj_exit);
>>  MODULE_AUTHOR("Huang Ying");
>>  MODULE_DESCRIPTION("APEI Error INJection support");
>>  MODULE_LICENSE("GPL");
>> +MODULE_IMPORT_NS(CXL);
>> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
>> index 3e2ca946bf47..a7adf3d9814e 100644
>> --- a/drivers/cxl/acpi.c
>> +++ b/drivers/cxl/acpi.c
>> @@ -756,6 +756,7 @@ static void __exit cxl_acpi_exit(void)
>>  {
>>  	platform_driver_unregister(&cxl_acpi_driver);
>>  	cxl_bus_drain();
>> +	set_cxl_root(NULL);
> 
> Why this patch rather than previous?
> 

Good point. I added this a bit late and seem to have accidentally
put it in the wrong patch. I'll move it into the previous.

>>  }
>>  
>>  /* load before dax_hmem sees 'Soft Reserved' CXL ranges */
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index c3914e73f67e..cb653cb1a1ea 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1147,6 +1147,23 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>>  }
>>  EXPORT_SYMBOL_NS_GPL(devm_cxl_add_rch_dport, CXL);
>>  
>> +struct cxl_dport *cxl_find_rch_dport_by_rcrb(resource_size_t rcrb_base)
>> +{
>> +	struct cxl_dport *dport;
>> +	unsigned long index;
>> +
>> +	if (!cxl_root)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	xa_for_each(&cxl_root->dports, index, dport)
>> +		if ((dport->rch && dport->rcrb.base != CXL_RESOURCE_NONE)
>> +		    && dport->rcrb.base == rcrb_base)
> 
> Local style in this file has && at end of line above.
> 

I'll fix that, thanks for pointing it out.

>> +			return dport;
>> +
>> +	return NULL;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_find_rch_dport_by_rcrb, CXL);
>> +
>>  static int add_ep(struct cxl_ep *new)
>>  {
>>  	struct cxl_port *port = new->dport->port;
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 4d5bce4bae7e..3e6779dbcd23 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -8,6 +8,7 @@
>>  #include <linux/bitfield.h>
>>  #include <linux/bitops.h>
>>  #include <linux/log2.h>
>> +#include <linux/cxl.h>
>>  #include <linux/io.h>
>>  
>>  /**
>> diff --git a/include/linux/cxl.h b/include/linux/cxl.h
>> new file mode 100644
>> index 000000000000..6702caa78e7a
>> --- /dev/null
>> +++ b/include/linux/cxl.h
> 
> We have other code outside drivers/cxl that gets to the
> CXL headers directly (to avoid this include being created before now).
> 
> https://elixir.bootlin.com/linux/v6.6-rc3/source/drivers/perf/cxl_pmu.c#L24
> 
> There wasn't much enthusiasm for creating a globally visible header hence
> I did that ../cxl stuff for that.
> 
> Same probably applies here.
> 

I'll look into using the private header. Thanks!

> Jonathan
> 
>> @@ -0,0 +1,11 @@
>> +#ifndef _LINUX_CXL_H
>> +#define _LINUX_CXL_H
>> +
>> +#include <linux/xarray.h>
>> +#include <linux/errno.h>
>> +
>> +struct cxl_dport;
>> +
>> +struct cxl_dport *cxl_find_rch_dport_by_rcrb(resource_size_t rcrb_base);
>> +
>> +#endif
> 

