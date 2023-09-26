Return-Path: <linux-acpi+bounces-151-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F5C7AF0C6
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 18:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id DBE47281BB5
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 16:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E2634CC2
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 16:31:49 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0631D30CE6
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 16:00:58 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24B4FB;
	Tue, 26 Sep 2023 09:00:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZUli+Nxi09W1wDZoOp3UwaojY92seCwHCDPv0kwpuLp+l7MI8c4YXoB1AhMhsK2g2KMGgzHzrHf04XkPHhSaM+A8nQuxKEoECvPbms44dwdo6ZFSxMxAmgdlm/s+KaJlo2PrLvVfryqiwv/SpTxpScyD426eU5Tcz6MbcIFoie71wWu0zA84RQeNfD7OflHBwIyL8HD2jF4q+0PNjyLHL9e1CQKCBUzEr/WkyMPMK+DqJwEfFQJLXtIRuKvJfS8vpBNviRC2MF7R9qT6ynks+dn6HS9D2SgIhFwqhMLWvDLzrFVP3xj4JqstYqmreLEw8C/ma0mN3NG+MZugvzU7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THrlwfg/mBC6+PnTRUH9Y8uZsKKhvVscuHRZ5EFKEKE=;
 b=Y7VcecMD74KKp0vcv8InXGBAjLbK0EFaFd83jP/T42Utbv9V2WkJzbaBUYy4N4fls7BuD90eMjh6fHIgBXpXpZzJduf52NmBH++EyedKZD5ZydBL5ZcQ2jZRVdLDSmm/QCBJxxARs06e7EmXWqa/tKc1zNl0X6YJsffnWgusDlzATuChuwfEQeWPgePigPDT25oVSXrhDcbQf+pfUdcEWDXvL5WIwOX2BHSVA2VlLT8tOEjxsnzKzOCZnvVPH9X4cAi8+MgQU0voICaUYTDSx0DdwYZwXPeoGoBJMYNrBOLHQ+Nr9qbCgh2hHgO6qsyloAAoc0kuq0YvgxkAbtx29g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THrlwfg/mBC6+PnTRUH9Y8uZsKKhvVscuHRZ5EFKEKE=;
 b=V1+V9AOf6nhPx5fgIFm0AsQFQrAx2D1IeLtEfLDb9kRBRuiUYqmKn+B91JqBh6zoGANasSNL9XUrd5W2886/O/RGMQsa0aCSxCDStZqRZ7e+Xf2usuycllaEbn+WVI7XTJy+c/6BXed5PWGXBqA/mxaMTFt+3dvA7XopNHwxvZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3268.namprd12.prod.outlook.com (2603:10b6:408:6c::18)
 by PH0PR12MB5678.namprd12.prod.outlook.com (2603:10b6:510:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.27; Tue, 26 Sep
 2023 16:00:53 +0000
Received: from BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::6423:58db:9384:4031]) by BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::6423:58db:9384:4031%6]) with mapi id 15.20.6838.016; Tue, 26 Sep 2023
 16:00:53 +0000
Message-ID: <af16e740-2076-f87a-055c-a892d0b211ce@amd.com>
Date: Tue, 26 Sep 2023 11:00:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 3/3] ACPI, APEI, EINJ: Update EINJ documentation
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: rafael@kernel.org, dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org, bhelgaas@google.com, yazen.ghannam@amd.com
References: <20230925200127.504256-1-Benjamin.Cheatham@amd.com>
 <20230925200127.504256-4-Benjamin.Cheatham@amd.com>
 <20230926120539.00000a4a@Huawei.com>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20230926120539.00000a4a@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0521.namprd03.prod.outlook.com
 (2603:10b6:408:131::16) To BN8PR12MB3268.namprd12.prod.outlook.com
 (2603:10b6:408:6c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3268:EE_|PH0PR12MB5678:EE_
X-MS-Office365-Filtering-Correlation-Id: 22fe7f50-cf4b-4342-dbc1-08dbbea9c336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JfmNikhWgQoegcRc99KFz02VtP02Q5ZWGiUNAIznd7YKWV+Frm+OfNuWboWN6+K7JvvYeVQlXiQGTa+7/xMtOUBfHrYUAjBpg+yMzE08bOGDb0Yr+mL7HVjJw0AUztuI6TZeM3B4fpnLPumv6nyrssULuUMWF+O6pB0gcNjzbGJxabof27u001U0HUMrvkRmuGbVyxzGUPqNzHfNH6rciHeQ6nFAe49WcLOR+8kMmu6mso91xXSJtHkD+0sYE6a713G4sCFxaAlukqAnbdj2yCzLSHfhxOYE8AkVzHPJ0opgQOPJZnfzHheNyjuxiDd52zW6Mkfx/Ut9wthxsUU4TVfdEvD59iVK1Vq4/bJdWknVJF7MkS/aVyaXuDsAWene4STQ7hBd5YuZvzib+6WqUejO7NvwcI+Ujxij2sJKrDPG7hNLe09aHOvK+MHGSWEFbXm6Dv8oKzt5tHHi255Q+EORqYEq+le/4kfwwI1JORklad156j3L/VugLhaWHbFfIM6emfSLdCpuCDsYXFNP4uSvQhkTWShAUNzQfXptUd5t+tXBPpOSj0XaxJXcj7Z/IJ/5Wdh4ov2PFtkdazOc/AFjJfJD3n9IbK4pwmDiqZ6itcYrD2/q/A31BQvOCDGKHwXWMo/eup5qthCP/XjPyg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3268.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(230922051799003)(186009)(451199024)(1800799009)(316002)(6916009)(41300700001)(31686004)(66946007)(66476007)(66556008)(6512007)(8936002)(8676002)(2906002)(4326008)(15650500001)(478600001)(26005)(6486002)(5660300002)(6506007)(38100700002)(53546011)(36756003)(2616005)(86362001)(31696002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0JWc1pBWVRqS0JMVFlIMVBuZTdMMm8wY0hvbWdMU2UrZ1VRUTNnUXQ2ajdh?=
 =?utf-8?B?akYvYnpTc3VCVnFqTnZYOXlyTWJwelovQnRJTGNHdWVLa0NIRmhhd1ZlL0lD?=
 =?utf-8?B?bC93NjJRZWUxelJ4V0dYOTJEdFQyYVJNcFZOTityYVgrajR6cE5QTk4waGNN?=
 =?utf-8?B?cnRSRm01azd1OUZCZGlCeVVnSndsd0tXcTRoeWZ0Zm9xTGpVeWI5a2FVTVBZ?=
 =?utf-8?B?eGZCdUkrc0I0YkRhSk5NMkVKdW5iTE1CcUl2V3RFeTlJbW5DN2h2RTNSanpt?=
 =?utf-8?B?Uk9qUXl0MGV2V2tpbFJHNCttOFNLamk1S01FNk1GRlY3djVXeFVzZnJzUlFr?=
 =?utf-8?B?Mm91eDA0dzBNSVMzRFc0Q01PN1VBVHc3VDFWcFg0aUYzNWtrU2dYalkvUXhr?=
 =?utf-8?B?RU5mR29TN1J0R3hwbkZmYTVPRWRHNU9IWXg1WnhBdzdyQnZiRHVMSVN0Z1dU?=
 =?utf-8?B?Rm9BbmYyZ1hxYlk0MFhHbS9EdGdxQVMrSG1VU29WdzhaMFREL2hPaGUvUk9i?=
 =?utf-8?B?MUs1ay9kVklrb1N4WjdHRlEwelJ0MU56Yi9SQjRBRFlsWnl2b2dvWTNWYUtZ?=
 =?utf-8?B?QXkzV24xVHMzN2VmOGRpUXh6ZitITGF6cUZqRkIxcU4zaG0waWJVS2VDNWR1?=
 =?utf-8?B?U2lZVUhwNW5kL3orZHFhdHpHWlZOTlV6M25hSWFSWm5Ld2kzamlqeG1BaWtl?=
 =?utf-8?B?UFVYUytZYXUrdC9NUDN2aDNqWDl2VUlFNlNiT0hBVVRQcDZ6eHR3RGJ0OHVO?=
 =?utf-8?B?U091dDhBWGdWR1NZY3pLUXU2ODBmMjlrQ0Q3andwTUFmbkYyWkRxSmQ5bnAx?=
 =?utf-8?B?dmEybm5ZUmtnc1pCWEJuU2lnR1FXaDdxVWtGaVJhaGlGNDh4T1J0M1VVQ3Vy?=
 =?utf-8?B?WlI0WWJRL0hQNk5jK1lleEpoUGhNNVVpZHRnMkFvTTFOcnFvY3FITUhIWGw0?=
 =?utf-8?B?QTBNb29oUDFlZHVUcldiakVHL1dzM3RrdGFzZ3A1VytOT053allPanRtOU05?=
 =?utf-8?B?cEorM2lBTUhTdnI0NEVERnkzRUdVOVhlTGh5eFd5N2tqTDEveVRMc1ZrSHBR?=
 =?utf-8?B?dDVPL1k3OGltM3BkQ1c3OW53OXZDK05JUjBtdytrUEJDVFlsRVlteWhWWWdK?=
 =?utf-8?B?VWpobzZqY3dvVzFENjVSVEhOUXJTS1JGSVBwQ0grZmJnYjlSQlVqZWpaSTY4?=
 =?utf-8?B?a0Z1OUp0Mk5pQWUxOHpWaXluTVdrRUMrUlFYdnB5WXg4RzM1NVRZRkNZYUtP?=
 =?utf-8?B?dWIyQzlXckZGb1QzaDliWG9NYlgxQVY4SWpNTlpCSjl0SlBGNHhPTFh5c09j?=
 =?utf-8?B?TXVmVWFzWXVWa2ZWVWUvQXJBcDArL2VEUWtTOEYxbFQyNWM2cDkyQ29GSW5C?=
 =?utf-8?B?QTd2T0tyTnJQaU1vbTRoYmJ1a1JCRCtxMTZrbGJEbjBBMktVbXNqdk1BMjZT?=
 =?utf-8?B?UGRlc01vNzZPYVc0cDN0OVZLR1lsU2JYTDZxWjAzdSsyZUtyb1M5MXFjbUtS?=
 =?utf-8?B?VC9QOWM1VG9SZmdmd1AveGNRNUxoaWoxN2dvUTd2SW42cjVZVzZtOWZkeG9N?=
 =?utf-8?B?Um1IVnNkQ2hkcHk4cktvN1BheXVmVDRsajFydnVPNE01SnJPaXgvaTkzNkl0?=
 =?utf-8?B?akNaTTZuNUFiL0M4ZEtpYnFKOTJXYUx0Q3VQOEdvTlBGVXdMQys4ZytzalB5?=
 =?utf-8?B?TTUxQ0NkdkNKUzIxbTVtWHhDS1ZxbnZTeGJGMkF0eTg1T2E3YThYcTRmVHRx?=
 =?utf-8?B?Z0hKL3Y3RUpBK3plc0xUaHRSdUJ6WnByTisxNnhJNkdSbzErRWtBVm95bkg1?=
 =?utf-8?B?NHY2WmVGbFg2MzhFT1prbVZhUE9CN0hBV05DZUdwOThndC9UYWxGYVpyUUJZ?=
 =?utf-8?B?N01xdTRkNmYrRGQwUDBCSEgzWlNNSEh2TWtKRUR2a25peEorUmlLRGQ1Tzdl?=
 =?utf-8?B?aUhtckhPWFB0R2ZpQ0Y2aXkraE1lRHJjcXJVOGFZVWJFT3pkdjNEbjhPbEw3?=
 =?utf-8?B?Vi9ZRlRXeWtmdExVOTdhTnB1QkJWelE4R3hlZmVWOGpwVWxzSzJTT3NVQlNI?=
 =?utf-8?B?VW9Rc0pndGlHcEdkSE9iaFA4dWI0RU5lV3NSK0lvNmVNSXJvT1ZIM2JsRW1M?=
 =?utf-8?Q?iLC9jewIAtOaaBIIlrCNoi0Xw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22fe7f50-cf4b-4342-dbc1-08dbbea9c336
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3268.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 16:00:53.7680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iDgtPk6YoEHiCy4j8gCdIFyY2Uci6M/sSbER++SgLL8m3tsX+YFR07LPTzV0a8uq6Ym19DRk+PkjnWOOJBFufA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5678
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/26/23 6:05 AM, Jonathan Cameron wrote:
> On Mon, 25 Sep 2023 15:01:27 -0500
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
>> Update EINJ documentation to include CXL errors in available_error_types
>> table and usage of the types.
>>
>> Also fix a formatting error in the param4 file description that caused
>> the description to be on the same line as the bullet point.
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> A trivial comment inline.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
>> ---
>>  .../firmware-guide/acpi/apei/einj.rst         | 25 ++++++++++++++++---
>>  1 file changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
>> index d6b61d22f525..c6f28118c48b 100644
>> --- a/Documentation/firmware-guide/acpi/apei/einj.rst
>> +++ b/Documentation/firmware-guide/acpi/apei/einj.rst
>> @@ -32,6 +32,9 @@ configuration::
>>    CONFIG_ACPI_APEI
>>    CONFIG_ACPI_APEI_EINJ
>>  
>> +To use CXL error types ``CONFIG_CXL_ACPI`` needs to be set to the same
>> +value as ``CONFIG_ACPI_APEI_EINJ`` (either "y" or "m").
>> +
>>  The EINJ user interface is in <debugfs mount point>/apei/einj.
>>  
>>  The following files belong to it:
>> @@ -40,9 +43,9 @@ The following files belong to it:
>>  
>>    This file shows which error types are supported:
>>  
>> -  ================  ===================================
>> +  ================  =========================================
>>    Error Type Value	Error Description
>> -  ================  ===================================
>> +  ================  =========================================
>>    0x00000001        Processor Correctable
>>    0x00000002        Processor Uncorrectable non-fatal
>>    0x00000004        Processor Uncorrectable fatal
>> @@ -55,7 +58,13 @@ The following files belong to it:
>>    0x00000200        Platform Correctable
>>    0x00000400        Platform Uncorrectable non-fatal
>>    0x00000800        Platform Uncorrectable fatal
>> -  ================  ===================================
>> +  0x00001000        CXL.cache Protocol Correctable
>> +  0x00002000        CXL.cache Protocol Uncorrectable non-fatal
>> +  0x00004000        CXL.cache Protocol Uncorrectable fatal
>> +  0x00008000        CXL.mem Protocol Correctable
>> +  0x00010000        CXL.mem Protocol Uncorrectable non-fatal
>> +  0x00020000        CXL.mem Protocol Uncorrectable fatal
>> +  ================  =========================================
>>  
>>    The format of the file contents are as above, except present are only
>>    the available error types.
>> @@ -106,6 +115,7 @@ The following files belong to it:
>>    Used when the 0x1 bit is set in "flags" to specify the APIC id
>>  
>>  - param4
>> +
> 
> #Unrelated change.  Probably reasonable but should be separate patch really.
> 

I'll take that out.

Thanks,
Ben

>>    Used when the 0x4 bit is set in "flags" to specify target PCIe device
>>  
>>  - notrigger
>> @@ -159,6 +169,13 @@ and param2 (1 = PROCESSOR, 2 = MEMORY, 4 = PCI). See your BIOS vendor
>>  documentation for details (and expect changes to this API if vendors
>>  creativity in using this feature expands beyond our expectations).
>>  
>> +CXL error types are supported from ACPI 6.5 onwards. To use these error
>> +types you need the MMIO address of a CXL 1.1 downstream port. You can
>> +find the address of dportY in /sys/bus/cxl/devices/portX/dportY/cxl_rcrb_addr
>> +(it's possible that the dport is under the CXL root, in that case the
>> +path would be /sys/us/cxl/devices/rootX/dportY/cxl_rcrb_addr).
>> +From there, write the address to param1 and continue as you would for a
>> +memory error type.
>>  
>>  An error injection example::
>>  
>> @@ -201,4 +218,4 @@ The following sequence can be used:
>>    7) Read from the virtual address. This will trigger the error
>>  
>>  For more information about EINJ, please refer to ACPI specification
>> -version 4.0, section 17.5 and ACPI 5.0, section 18.6.
>> +version 4.0, section 17.5 and ACPI 6.5, section 18.6.
> 

