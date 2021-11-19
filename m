Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A9D456A3E
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Nov 2021 07:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhKSGeC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Nov 2021 01:34:02 -0500
Received: from mail-sgaapc01on2121.outbound.protection.outlook.com ([40.107.215.121]:63328
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229457AbhKSGeB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 19 Nov 2021 01:34:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxEf0zVRWXePVTE7HyM+OSO0g0eu1evBhMo2yYJmhcurgCMOgy6Oaa3QA3xrB8e+nPU1Z2BoEDxIhjj39u7vkgwaOeMnBpJ+TEI2kjAUQ3Zgu93Vs49i19j5fmezeaYQ4DAJKrgCZiWHmDZgLpROW1KCrndwdAOYHAqt3Or5lAA+by6eC+8EBJG/Umlpl30rgH2ZLUkRck+Tp5XLOci4IBt7RPx0BIpuHdeEq2gDXCFFsmoo0UQP+AcVUpyNeOlEB3CfpLuIolQoXxsCDVxfTKsGxoR+Cff7gh586cOmzXFEL9IhiEwikoWgDDYu7e4CYuRzkUKSz41RRH39qrzkmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZSluOO/qOL6IxH9mU9H6mYcMMYIjcub7C58SsRjshg=;
 b=EWWHoAluPCgZSLvWdfWBX3jWFsQf4fg6e0xOKX9ctsHUEJADlmbFp+twMFERQ0CMU1VJzaPkjM50QlK7sjqhF8vBUNj+wblxHAizaVulL7St3NO1E6hZ5o1x9lbHEOKzcOU96ytnkz6b3q9H90JYU+l+Nh6O8YbKr3/Lf11CP02RV0KTevF4O4epbmLxUhSrpcvICXvVkRgIUw4Dh4UsBcTHwk6N7930uAFYsUQIhJ3THzuMPgDd1iExa1AZnoT4iqB2EOT1cb+bEGBI0HYW8dGDA5UE162dwCH0Y5xqRNNLPIW65vmWQzz/Fj+Q6e6kWQL0teIylkE0BqB+cq1xQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZSluOO/qOL6IxH9mU9H6mYcMMYIjcub7C58SsRjshg=;
 b=Meo7xbsA9O3NaTuxat63tElkAxoc/5zeK10tYNqsQ4ov2TJ0ImqPkgiol4pCneTIKmX8eIU0Dx4aZfDiFt3Izzha941pPhQWTXUfD2kTc7KMefciVhODk9mqRPTI4+qEliXgXr1BL9DND16UdwHEw3YWirZjPVlID8kpsiS/3H8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by HK0PR06MB2354.apcprd06.prod.outlook.com (2603:1096:203:46::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 06:30:55 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::814a:4668:a3bd:768]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::814a:4668:a3bd:768%7]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 06:30:55 +0000
Message-ID: <db9c50a4-dab7-4aba-1ebb-e38fda08cfe1@vivo.com>
Date:   Fri, 19 Nov 2021 14:30:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] ACPICA: fix swap.cocci warning
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel <kernel@vivo.com>
References: <20211109134728.1710-1-guozhengkui@vivo.com>
 <AIwACwDlE6oYbcAnsFaroKpJ.9.1637246783998.Hmail.guozhengkui@vivo.com.@PENBSlo1djBpeHR2ek5pQXd3THRYWGdHLThGZHZ0V1l5N1JVaDBwRno2NXNqY215dU5kUUBtYWlsLmdtYWlsLmNvbT4=>
From:   Guo Zhengkui <guozhengkui@vivo.com>
In-Reply-To: <AIwACwDlE6oYbcAnsFaroKpJ.9.1637246783998.Hmail.guozhengkui@vivo.com.@PENBSlo1djBpeHR2ek5pQXd3THRYWGdHLThGZHZ0V1l5N1JVaDBwRno2NXNqY215dU5kUUBtYWlsLmdtYWlsLmNvbT4=>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR02CA0150.apcprd02.prod.outlook.com
 (2603:1096:202:16::34) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
Received: from [172.22.218.99] (203.90.234.87) by HK2PR02CA0150.apcprd02.prod.outlook.com (2603:1096:202:16::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend Transport; Fri, 19 Nov 2021 06:30:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80b5491d-0c8c-43a1-1076-08d9ab2623d8
X-MS-TrafficTypeDiagnostic: HK0PR06MB2354:
X-Microsoft-Antispam-PRVS: <HK0PR06MB23542C74839C9DF3E1FDD02BC79C9@HK0PR06MB2354.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Th3XbSjYPJYygNcD0q9AlqR8NHIRzlRFSRfbcQ6EfcKnyEpbujlN6mgl6c6Ua++m4MuA/hL/kJoZAZPVHQvembQwxyC1mxMXwR2i/Lyqr5v6g90pb8mXSWO1UR11YHBJR1gKVjkriFUCM4peFccaNpJO+DhddPeOLTL3urqQE0FpPyX8NqoDzjvCB+TdH7nSUNr9u7mSnov7cAkXzcwu8z8/dHyil12mJet+5lUnRK4xay4wVANGbwuEh6yVGwOdU2v/nO/bItKZnbzDjYUnsCCUuVUlDQBiTn74cmjx5f/mz5yHtFjgTDSeAekX9/eRiKJKc90VK/sX0Fps8mSCLA57VVjFjggy0Td01e3zhnZGAlSGsKAs2r2WvB3KyOzpEtPzr3O1/Bi/VMHZ2M3rZu2GPvW3C92A6juRpDv4JN+QeZ93uLK0ohiDqn9WwEDz/Y3E9ax1562sAfCT4+G5FpB8eVo9I7YF3veAEYw/FYLB8HOLAatu+TY3G1tKTntJDwR7Yg18n+ic1xNdF1+GpCq6U6ZWqJ52YWohqOAx5t7NsbtIFtCeSIrt/dkhfD+bJ6gVE7X4HPxLeR9ceIcl35yFwHzPf7iUJGmgRnw6copkt3NuweHCjcsn5LCNrJgudqFwRDQRtcGjnwq4Y59XgrKnXmdqqrvsWUie7yupEnZ+QGI+JROrVz1bsbQ2QL3x0PS+VoH8HFDJOwdV8Cd15J21xx/5rQTFA6mxNbvIXe9iRkKBBsMPFOWEUgbFwQvgeti2jqIPvMVt3bq9UQMO8SquKwpE3en2VS+T+JKn+JmFhosw0qkJy1wrqmu5R9Uk7r1Ne6XIHFn2xtq0ePhTW13oC6v9QsKalc81ta31nWE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(38100700002)(52116002)(31686004)(6916009)(38350700002)(2906002)(36756003)(66476007)(54906003)(2616005)(31696002)(8676002)(66946007)(956004)(5660300002)(4326008)(186003)(53546011)(26005)(508600001)(8936002)(83380400001)(966005)(86362001)(107886003)(6486002)(66556008)(16576012)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0FrZ3ZVM08reEdTNGoxOXJyVi9ybEV4dkVyMUI1UHFXbnAwOWsyeStMN3Jh?=
 =?utf-8?B?MVJFZEJ2VlQ5bEZZdFU4d29iTEJDcU5iQ2h6cFY0UmtSdE02cWxJamZ2ZE9G?=
 =?utf-8?B?TUVleGYxc3NiU1RRZFV3ZXptOEY5L2FHdWN2aFhJL01nbm10L3QvN0FLTFRN?=
 =?utf-8?B?UjVjRnN4Vm4xSzlqNWRsTmdJNFhmUi84aGVZUmlUMmtBa0hGUmNqZU5USFph?=
 =?utf-8?B?OHNzaTcwMjNGeS9MOUJldExUWGFrYUpJaDhPYnhzeUFwR0FhY2tEOGpheWNh?=
 =?utf-8?B?UGROQWpVaHhMVng2cjlQazlkbWkvTkx0RUZ5MkQxNWdyM3UrQ0p6Z3ExWUtP?=
 =?utf-8?B?aDhRTWFNSUQ0djNsUVhKcVdTRU9ZVnRSYktSNGJFSExqRzlNejRadzluREVp?=
 =?utf-8?B?NnhmL0pEY2ljK1ZVSFYyeVgwMHc1czVuc1Rqd3R5a3FMTkM0VnhZSlBPS2tp?=
 =?utf-8?B?U0ZmZDVVYmtLSzR4ODZobXJ6a3hhYnpqb0J5a3JNTUxnZUFXZ1BIWThvTmc0?=
 =?utf-8?B?VUFqY1NFWVRYMGlrV1JXSGlmZ0xQQWxOKy9BcEhrM2Z5TnRXdENUTTlPRHpP?=
 =?utf-8?B?cVJUSWgxT3hWTStMdENkYXBoenJ3VUJFb2JjdnVkU2cxMzBHWEZqa3lxMXJV?=
 =?utf-8?B?dDFKMmEzcWV5MkZuaHEwUGU5UUVSZG5QdE1PWXZWTUxNeVJxNGhGSDUzSzZP?=
 =?utf-8?B?ZHFiY0VtU3NhcmV2OThiYzBjeitFbFdZVHg3cm15dHM3OGQvNmlnT3NsRzlV?=
 =?utf-8?B?a0I2eVRLZkFsZ24vcUFvaUN1OTNGTzlvSWFld3dhS3lRZTJqRStOZkVIYkRz?=
 =?utf-8?B?QkxwRlFsNm5rekoza2Vma2M3T1B2Ums0N2d0emFKYWR3NmFGY1Y1UDk5U09k?=
 =?utf-8?B?TWo5YStaWjBZb29ESzFzakdLQkJpV21wcmcxWDA4bWhtdzMzWHh3TlR2QjdU?=
 =?utf-8?B?dlpMN05MM21aYTl2djBmVGRMZ3FMcm5yT2JHdEk3blo0NkVtTUhJVk1NVmN3?=
 =?utf-8?B?WWZaNUdXZXVISlJseTN1SGVLNENVQzZFejcraHFuUHREYVNBL2hQUnZGVXdQ?=
 =?utf-8?B?bXc4N2tJN1BzNGJMckZLYWR2Yjd4ZVNtcmZmTXdPV25EQWpwNm5Oc2lMdkJW?=
 =?utf-8?B?VW1XVjhDVEgzYWQwa0hFelhPVkgycnphR0p6OU9UYzU1Ull2b2E2NTNlcjJD?=
 =?utf-8?B?cHFwdk5XWTE1UEFORzZwSmJPcW91dm84NTF2T2lyU1MyR2VGUkVweW5aVUVN?=
 =?utf-8?B?Umlnc2FSb3NqL1AvYmlCVEdTcE1vZFdrNnhBNEExZ1ZBSFVnUFdnZmpmYW9S?=
 =?utf-8?B?dHhJVlFaR1BlU3RoSnFDWW9NZVh5c2R5TzBiSGdrek5UUlAzRi8rTFZCeHJQ?=
 =?utf-8?B?bkd3M1NmdSticWJ6NlFldlhVSWsyOWNjcU1ldXpNaG5ya0t4UzJNOVFpZ1VM?=
 =?utf-8?B?cnZZVTc5N2hXcGRxSVkvSlVVV0VDRTBub3NxSkZsa1pnQ2R3bkdLZDJaUjBz?=
 =?utf-8?B?dmpwaW5ZZUh1MyszVk1EN20zcVJ1V1YxdlFBMTFXVXVoVmk0aVYzK095TUlB?=
 =?utf-8?B?M1RnTnFWRUFGNm1uZXp1NFNDV2tmelF2TExSZDBBaEFCTG5weUFqbCt0bXI4?=
 =?utf-8?B?eWFkRjhBbTVhUUhYanc5Yzg0dWpLeEljTXY5MGwzT1N0clQ3Skx5WjkwRkRv?=
 =?utf-8?B?a2VzbjM0VTZyRXM4c0lGRThZY2pRQnJHVTJ5N0N6NjQwa1hJaWZzUHZ2ZFVj?=
 =?utf-8?B?ZjRETlBRMWZiK3pIU0FtVnhBZVpEM3BLZlI4YjhyMEtJZGNSYVdtTUJYRHBB?=
 =?utf-8?B?MWNlQ3hwYkczOSt2M1FZQW13THQzZ0IzeWtPcE5HRGd0R1hGSnJBMGY1RllM?=
 =?utf-8?B?YVgrbnVISWd3alFkNUthV2NGVS9QWkNSbzd1R1R1VXhBbGlROUF1cjlNRlVx?=
 =?utf-8?B?SzJTWWhDejJTTUZzeU5VdmtuUEhIcDdKWGROakNCSytmbWJ1TWVseWxvWTBm?=
 =?utf-8?B?aDFoTENOUitDbllYY3htQ29za093ei9DcU1DOUZYNTEvSzU5SDhwaWNYbE9R?=
 =?utf-8?B?bStIejd3cGxQRGhZZ0tWUE5jaGxDb01jV1BuTHdYcUdDZVRnVURJSUpzelBI?=
 =?utf-8?B?aWtqTGhyYm1rNm5ZWkRsV2hOREt3SmQxQUR5SDZGQ0RaVHVpL3hTbG9IRnMr?=
 =?utf-8?Q?yxYdQkycSdrUh1ucCOK8J6E=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b5491d-0c8c-43a1-1076-08d9ab2623d8
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 06:30:55.2203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yCWqDjvMnQHHDG3ApFF7l0C93tJo8QqnxdzRuCBkox10pf6qEr3s2eaiizzTVk0sjmUAW5TW30LNPpUPE0ybUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2354
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021/11/18 22:46, Rafael J. Wysocki wrote:
> On Tue, Nov 9, 2021 at 2:47 PM Guo Zhengkui <guozhengkui@vivo.com> wrote:
>>
>> Fix following swap.cocci warning:
>> ./drivers/acpi/acpica/nsrepair2.c:896:33-34: WARNING
>> opportunity for swap()
>>
>> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
> 
> This change needs to be submitted to the upstream ACPICA project via
> https://github.com/acpica/acpica/
> 
> Thanks!

So it means I need to submit this patch to upstream ACPICA project, not 
linux-next?

> 
>> ---
>>   drivers/acpi/acpica/nsrepair2.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
>> index 14b71b41e845..02a904ca4caf 100644
>> --- a/drivers/acpi/acpica/nsrepair2.c
>> +++ b/drivers/acpi/acpica/nsrepair2.c
>> @@ -8,6 +8,7 @@
>>    *
>>    *****************************************************************************/
>>
>> +#include <linux/minmax.h>
>>   #include <acpi/acpi.h>
>>   #include "accommon.h"
>>   #include "acnamesp.h"
>> @@ -875,7 +876,6 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
>>   {
>>          union acpi_operand_object *obj_desc1;
>>          union acpi_operand_object *obj_desc2;
>> -       union acpi_operand_object *temp_obj;
>>          u32 i;
>>          u32 j;
>>
>> @@ -892,9 +892,7 @@ acpi_ns_sort_list(union acpi_operand_object **elements,
>>                              || ((sort_direction == ACPI_SORT_DESCENDING)
>>                                  && (obj_desc1->integer.value <
>>                                      obj_desc2->integer.value))) {
>> -                               temp_obj = elements[j - 1];
>> -                               elements[j - 1] = elements[j];
>> -                               elements[j] = temp_obj;
>> +                               swap(elements[j - 1], elements[j]);
>>                          }
>>                  }
>>          }
>> --
>> 2.20.1
>>
