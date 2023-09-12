Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B54E79D405
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 16:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjILOtV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Sep 2023 10:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236084AbjILOtS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Sep 2023 10:49:18 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC41115;
        Tue, 12 Sep 2023 07:49:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEUQBJKHNwsPEnPj5Xl89M9U08FMV9vaNLxonEKKgCkiHFiy1/q9WyA9Nc191iOfclqNXyRMatpynJ3RpYf8dU4Z19walfbm0nJbTUwGJmGa1dJm28wUIh5aAAWyImbcUmCuTUZIU7JdQXKcQ+nDsaMjoIB9t332ibQQfM3i+dq5BIuwTVEdYqWzP930LzvW4TVefF9kZYowd+wYj0pa1xfWUfTrmcxkXBhZzkrKIDuuNtuR85seiP+bEyEeph6cFGWiaGoO1hvhIXxDNhPXivNLUQGP3xuPLDpZJCsnS+9DFnrnYWcB3/IeMU8qgPl/RshVnr5qJ6vOZ7gh061RNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rf2fznrMOfdiUYOOPXtWXoQIBvD9fvrOSX+l7EiSNOk=;
 b=J78CyL4aajTQJJ21o3/VYlXNhrQTsZwfN94kVP0CGGNlbKbM4rcprd7jn0AjhsBO3qZfiRDvBwiMFYO8qwh8bOx1Lft9+2SzfDvuVxuCuaVQRX7FDIuPjD5H7gFsWhRisWsIcPl3jOVcKMsY6nKiM1GjXKPkAta6cV+BwH55ukFbEma8FsqvuCL8v1AoAqDNUgCkFTDjDcGSno9BgFdmQQV/c3D8SNqB8qno4iOxmf3zRSHPcAVbRhN8Gi4ImTo90D4E8onk4J4OLzu4XYWKJKNYKYNo5F3JMAPNvQmgoRd5e+7IqVs4NeopAciqPl1WhcY7VR9987lnCOa/Jj3pjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rf2fznrMOfdiUYOOPXtWXoQIBvD9fvrOSX+l7EiSNOk=;
 b=MuRg8Y6DxyzjkdCQopu1wPEugRXnI1kGUiigKf+7699VhoKp9NzG1gSgow/AQ/XeK3vfOZv0BOoekoHoS68wqg8zDanTdFRmxAYI5NeUDHc4WO4CYqEsLnPQfEhn5GVsHTmS61uQDiX4ibXrh7Yp8deQk0axuuMqC8k9PRhRkwY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3268.namprd12.prod.outlook.com (2603:10b6:408:6c::18)
 by PH7PR12MB8123.namprd12.prod.outlook.com (2603:10b6:510:2bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Tue, 12 Sep
 2023 14:49:12 +0000
Received: from BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::6d0d:ad1a:c6e7:816]) by BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::6d0d:ad1a:c6e7:816%6]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 14:49:12 +0000
Message-ID: <7b505232-1acb-2fe9-17b7-1f2540a6b4be@amd.com>
Date:   Tue, 12 Sep 2023 09:49:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 2/3] ACPI, APEI, EINJ: Add CXL 1.1 EINJ error type
 support
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     rafael@kernel.org, dan.j.williams@intel.com,
        linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        bhelgaas@google.com, yazen.ghannam@amd.com
References: <20230907191956.674833-1-Benjamin.Cheatham@amd.com>
 <20230907191956.674833-3-Benjamin.Cheatham@amd.com>
 <20230912150045.00004137@Huawei.com>
From:   Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20230912150045.00004137@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR17CA0036.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::49) To BN8PR12MB3268.namprd12.prod.outlook.com
 (2603:10b6:408:6c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3268:EE_|PH7PR12MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: d69f1f66-00d1-48a0-310a-08dbb39f6d79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ARzshNefXz3MhkxnvkohS26aaSwGBd7G1BmmQrlXrhlAhMDFzKf3wDvVFW0i9CJSttBdCdWSimzoXYXcSj7cAT+LkoLgYjcYwNVDuYyXsmWQebcWuu0ACi76okT0TFoAG6GQ0n/DR2vk0cGB/uUeNxa6xQ6rEFSER3a3ufmaZFMrQLA+v5y/c6yW5lIENSoXdDE/6W1OaYG1pioXOB0wk16yJA7AlDbMvWXT7nmNHcOBwpw5dNKcOpCx0TFpGdbdCOG99hmAFcRmu9qOpdsTrH+OKhsi3kj77U6JzQgedDS9dpjiboimcGXJA/IqnA59zYJRhz6T2TVPiuPpGqUEG8TS5Vdke0UOM9tPrzTGD/8FV6tNEvkpxdznrA3FxSM5BY+M0ZkyVFzECKuTlAyer8sc3FQKLAeEJ+y21Ihas3fYHrzynpUL0cs2mVepYGmMnvgwg5L3j0Zp3VDHNMl626/JskRKqQ7mC7LQlWRv5XIZVJoD/hsy/Skhdg/GlWRWrJGf8YA8Gm1tYze5XN9JFAs+ynpRxPybawJC5XvYakZh0EiYHfr508gJNGG7Uk66OZt+tOIWWGxbg9H1CMZeglBSJaS6IrgZ7YSCV7y2ydor/P38K21mhfXQFxD6BUcj/Sq5PWd+f/zArsRittrR9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3268.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199024)(186009)(1800799009)(31686004)(53546011)(6486002)(6506007)(6666004)(31696002)(86362001)(38100700002)(36756003)(26005)(2906002)(6512007)(478600001)(4326008)(2616005)(41300700001)(8936002)(8676002)(5660300002)(66476007)(66946007)(66556008)(6916009)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am5NUlpqM21XbmZRVUtKOG1XWUo3QlIzYzVBS00wUXlsWGZnejVQNWVRelha?=
 =?utf-8?B?cUpKd1lpZzB2eEU1KzlVbWJxb2dEQjJBUnNJVW5NVlp0T1NFeVdkZ1ZnTmRP?=
 =?utf-8?B?a1JEMWhya0ZJUFF4WXBya2wyRmZ3ZXVqS1NrL01UdHBMaHdJM29IYW9FVG9G?=
 =?utf-8?B?V0krQjdBR2tqVGtZN1dKTmYxdFN1MjFRcXQzUklLVVdUOUZLcEtVaks4L0NS?=
 =?utf-8?B?OGZWcGhueXgzM3BVU3FVYWNhL2tRVkdKNlpjcmxId0lUWDRPTy9DcTRLdjhG?=
 =?utf-8?B?ODMyZkxuK1lXaERjdXpCUWY3Y0dXTHhpeExGNEYrVTk3UWpSYzczSGNndVBs?=
 =?utf-8?B?R1JNMnJ2TWsxYmF1b2d3QWdUSmJtSGVzSHNDazRlN1VsaDJydzlZRmZra2Fp?=
 =?utf-8?B?QXoraDJUQXlRa29MYzgyQ2xzM2ZUYW1sbVBiVXVwU1l2RnUyMVAxQWNENkZp?=
 =?utf-8?B?UzQ4TzFqZlpJbUVveE1PdWZIVk11N0EzaXB5clRzWS9LQUVvTlZoRENNcHB6?=
 =?utf-8?B?VGJodGtnUGNQQ1RHM05ZYXA4dVpoaHNYMVZrTEhvbWtsZWZnV0VqZURwa29E?=
 =?utf-8?B?NGxjQ1dPQi9rVEU0WGRKaXhGSVpBQ0d6NU5TTUF1T0FwUVBrUGJtY3ZweUpt?=
 =?utf-8?B?WW5xc0N1dnRDNk01bC9aZkRwMXVrOWFuVEJjNEJNdGc1OTJxWXp2TzhCNDcr?=
 =?utf-8?B?ZWNIZnFnT0ZkRnI1WjdsYm8zY1paeXNVRmtQZ2E4blFpWTF5M01kOGFvd29m?=
 =?utf-8?B?V0tyOGM5aDlUbU5VeWYzbWJCRDVuYXpram1KRVRzL3JPck1LbzVVUnV0aU44?=
 =?utf-8?B?Q3ZwblFIV2VuclBLZURlQTR6UjlqalR3aytvbkxsbi9wWkt3Y1Z6WTFvUFJE?=
 =?utf-8?B?a3FxMFNSVmVCeGdkNG5PUDUwN0dxUm9UOHlzenRZT0VUdXE2UDlHYlExTmlW?=
 =?utf-8?B?dC8zYitOWU5mZjBSZXpXYmNxWUMxL2lOV2ZlVVV6b2lHTHlaL2JoZkt6Z2s1?=
 =?utf-8?B?WDBpMmhRWWZoZ3UyWE1STGFRVGRuUjhySFBPQjJBeU1JR001Tzd4MFhtbEps?=
 =?utf-8?B?ZTNKQUE0NnhDek5OQlRWdkt3MTJpcFM5YVB4YU1hRTNock9DN0FHRzJGRHYz?=
 =?utf-8?B?QTlxRE1VMHpKbCtRMDlVMlpJZHNLaVhNU294Q0tLQ0d5SEVOTXhzdEE3ckxr?=
 =?utf-8?B?Qk5NNXRMaGdCd3ljMXJYMTFZem5KNFpTcmRCbUhDaFNmMGZiTE5UOVQraHg0?=
 =?utf-8?B?R1psK1VoRnBRbEZ6VzYyRDhJU09vZmNVV2svckdUVktIc09UN3lmMUxjUVNN?=
 =?utf-8?B?aGdiajRJb01ZVjZpZHVYcFhHZGZTM2xZVFJrc2ZjWll3YmxOdlFHWEFiZnZX?=
 =?utf-8?B?QlFlbTFlbWU2ZmhRb2dQTXcycmNCT0tpNXEyU3NPZlRTUjc0VmNIU3crbHFv?=
 =?utf-8?B?LzhBOTVTOGRHRUlTeEl1VnZEYTJ1OFlCdHQxbFZST0htc0FGU1lRV3N2SzZh?=
 =?utf-8?B?KytBcUJROXBDN05wdHpDTlBBcnp2d3dZaFNDb2VtNFliYXRzaWpzSVZ2UTY4?=
 =?utf-8?B?ZFMvQ2tRZ0RyMWMyQnhKanIwRUFtNlc1L2h0NFIraUVsamdkcjVOK0dsRXYr?=
 =?utf-8?B?bnpGcmZuK3hCWFVwNk90YVQwVWsweTgvVURhRzJHUFU0MVpNcDArL1IrRHRX?=
 =?utf-8?B?cmhzZ054Yk1OVWR4Z0FyN1ZaNUt3eFdyV3BUU2Rna2xQYVQrZ2IxWUtnNXV0?=
 =?utf-8?B?TmxQOEtadEVsTTV6dDB0ZEJDVVovSk9qTngzY291azBCTHkxcjk1aVhRVzRw?=
 =?utf-8?B?cWc1OW1UU3lZb05QWjBQT3ZWVFhtWHQvU24xZFpZaE1HK3dSakhUcU94Vk9O?=
 =?utf-8?B?N2drWWJmcVhXZlYwa2VTNS9kSFNzdTQvaE9NOVIvMmtYNWZrV2RSWFc2TVky?=
 =?utf-8?B?dmVuWGt0VUgvZG1xTHk0SDZieFVMZ1YxOVhYNENWVHlmc01pdDNmZU1OKzhJ?=
 =?utf-8?B?eC9rSW1zTHpGbVdnWXhVNGc4TkFiNmp6Unl1WXNzeDVwbnBVS2oxZ1F4SWlT?=
 =?utf-8?B?eEQwclhwREEvWFZRQ0lDVkwzSWlNd0g4N2N6WTA5ZGVsVC9NdXZkNmN5Vlhs?=
 =?utf-8?Q?tOFxSDhCOibejllo9YSUDNLA6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69f1f66-00d1-48a0-310a-08dbb39f6d79
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3268.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 14:49:12.2049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sR7YeoVnyBHEcDGy/teKGNCNqBVxtfd8kVKCsGO0fwVNbARntqqnXVQjlzGyrja/m0aAISwqFUsE4Uku9o8V5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8123
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 9/12/23 9:00 AM, Jonathan Cameron wrote:
> On Thu, 7 Sep 2023 14:19:55 -0500
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
>> $ echo 0x3 > flags
> 
> From einj.rst (and the ACPI spec) bit 0 here is
> Processor APIC field valid.  Why is that relevant here?
> If it were you'd be writing param3 I think.  So probably
> harmless, but I think this should be 0x2 > flags
> 

I don't think it matters in this case, but I agree.
I'll change it to use 0x2 instead.

>> $ cat /sys/bus/cxl/devices/portX/dportY/cxl_rcrb_addr
>> 0xb2f00000
>> $ echo 0xb2f00000 > param1
>> $ echo 1 > error_inject
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> Hi Ben,
> 
> Why bother with the config dependent build?
> It doesn't save that much in code built and right now there
> are no non ACPI CXL systems so in reality it's always built
> anyway.
> 

Ok, I'll remove the config dependencies. It'll make my life a
lot easier :).

> Otherwise this LGTM
> 
> 
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 001ab8742e21..f8f300496140 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1122,6 +1122,25 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>>  }
>>  EXPORT_SYMBOL_NS_GPL(devm_cxl_add_rch_dport, CXL);
>>  
>> +#if IS_ENABLED(CONFIG_CXL_ACPI)
> I'm not a particular fan processor magic down in c files.
> 
> Do we really care about the saving of not having this in builds where
> CONFIG_CXL_ACPI isn't set?  I'm thinking those don't really exist.
> 

I don't like it much either, I did it as a quick fix for the build errors
from the kernel test bot.

Thanks,
Ben

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
>> +			return dport;
>> +
>> +	return NULL;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_find_rch_dport_by_rcrb, CXL);
>> +#endif
>> +
>>  static int add_ep(struct cxl_ep *new)
>>  {
>>  	struct cxl_port *port = new->dport->port;
> 
