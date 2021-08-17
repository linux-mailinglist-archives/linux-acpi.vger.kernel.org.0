Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D32B3EF210
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Aug 2021 20:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbhHQSmR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Aug 2021 14:42:17 -0400
Received: from mail-co1nam11on2076.outbound.protection.outlook.com ([40.107.220.76]:42369
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229874AbhHQSmQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 17 Aug 2021 14:42:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHB3KDEluTAatDYveoXhMo6q+KcC7QOwZULpjgW5yoMBRbh6TjBga7UsAOBZZZdGnhZS8dX5OPLc5kyP0FlEO1g6igNNu1heMuoIvx+U9S37dLOE34fptKGjNkqOIr1CKI9gcrXgZwCJZMFFkQcfuvqrlDhVI/z1TpwefLX5RBmY9Ilbu6OMBW9MobUAXfmycQOpaVPXR/uvu5lqFkGhbJZCgCRFWxfOh8M+nzODky+AA8GCtzo4VL/Z6Eto1cuXNKoWsW/xg/GGvliUonT921abF8S4XB5+g6bwXyLm0PeFRtF4rFa3uQ3ELxeDaxIh6oWIM5t+XjH4MUfxuKcfqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t52wkSBkM0uAg6lszi8nILLoXuewmvLaJ5TlbSnRfKQ=;
 b=Pm5PKuZp5n/H0tBajxrgww5jaMwHBocWxOi2FDkUOAZVIRMkQ2RkJsId6s/Yrh+KN3PYGKbEn/FIxESXNhQzsAYgLJsV2muThx+ZpV3C5YWrEsZ8Vxx+otTJCJ3wuSQT7haOa8k+AjDKx33ld2XQzU/Jm9ZfWxEtQsyJpnceHZSPbI1N3kRDL63SOz16Cw+2ggbPc0bvPnCmr7Tl9Frh/lzAYGNub6RszFpTzQp7bK3S5BqP7O2dJzGSZN1E/43eXQbh+P9Tjw1WOeW3DYWrAs+3f4si06EWQaFlpLVG29NimdWsmDdygR6UmoU9JK6Zl9L7eZO/Toe3560syOsd6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t52wkSBkM0uAg6lszi8nILLoXuewmvLaJ5TlbSnRfKQ=;
 b=BxquaULQEqaOUyz4ggDgFrzZaecd5inSjRNGc+Th5qEuz9JlnQVds35rSBk0+cwbVxPp28++Z9p6Kk/XrwLNJSEFM5ArHqHFqAN3s6F1DQNGQjEpBJctKe29gjB2DtgtWbJwBmppNvUJSwJDuZQykRBbk/8FQviDYRw5i6SED6A=
Authentication-Results: acpica.org; dkim=none (message not signed)
 header.d=none;acpica.org; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN6PR12MB2640.namprd12.prod.outlook.com (2603:10b6:805:6c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Tue, 17 Aug
 2021 18:41:41 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::e8ae:ebd6:7f5d:4b36]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::e8ae:ebd6:7f5d:4b36%7]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 18:41:41 +0000
Subject: Re: [PATCH v2] x86/acpi: Don't add CPUs that are not online capable
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Ray Huang <Ray.Huang@amd.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
References: <20210813161842.222414-1-mario.limonciello@amd.com>
 <CAJZ5v0jynpMMnMBQuyJPYfSG-6JSe5=a6wW0UtUnpGuh68CqkA@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
Message-ID: <b116a84b-c099-5bf4-6c25-f62cea856f45@amd.com>
Date:   Tue, 17 Aug 2021 13:41:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAJZ5v0jynpMMnMBQuyJPYfSG-6JSe5=a6wW0UtUnpGuh68CqkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0023.prod.exchangelabs.com (2603:10b6:805:b6::36)
 To SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.185.190] (165.204.77.1) by SN6PR01CA0023.prod.exchangelabs.com (2603:10b6:805:b6::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 17 Aug 2021 18:41:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 901ed9b7-4de7-4277-18e8-08d961aea74a
X-MS-TrafficTypeDiagnostic: SN6PR12MB2640:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2640976BD8F844F69E31D221E2FE9@SN6PR12MB2640.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5BN2eBpNONscfm8j82uLd20VcloofTouyk+dHN6eGeC/n2cn8EJBDlifXuCvFllJpPJWPyDVpuWaLLAlrjM9Yly/c9JG7l+RWBf2Th0tZt/rVW1Qr6k8ZvEamDKkcoidHNYoszU7s7FtGD7SoQ0FtAtOUnd/gwUrqMxFQ/cI0mtX6337iszFvV5gsPBpxvOBsQ45DyIMP+wgV84mmqcj90HOSEBTHtzxLuofInKuEfAe2h474PNbcPdHauA3KHbjNBVmHuRsXCBwKdEYvRVAt8nbkeUeOcukGW89dP4MrAdpPfJs+UU0n3687lZfj0UYaYrZ+oGHOXwsz0bDHPCKkjtoDGcAmwl3uwU4UgXYldntvCEu2GxCZBofvEOdl7rb3lapGmkcdrZn1ZlpVnCFrPwxJpwm36Kr/Q21l5Umeavmk9V9qHtwFEHP90EXYdLgiRaKjjfzbpT6wvFRT8lWPHAKoN5R+YEhoBvqd4ACupoRekdRF2PgLPKxGsdJmR57+gFV6UXgXWw00w2wLWfe46bnGOFwTIYax9PbplCFTXAwLHHuK8OH78S21xZgqya1RewP5eKQb9HQIeq/iBCK8pmr046VjUuN2tJ/phyYwI3erZzB2RBwkahCwyhw1pWSgf0LwEMmft0eayTjH8PUiARms4eXEznDLEJg+W6Yrj8WU31V93Tdz5PTI7MCjYiG3azK3cCxgctPU73O/3ce+pSu1q9KICg6sDb0K30/2z7q/isNM5hipZ7bRkFe5PVPVvVHecwPH6d+Kg/KGTZ7EPX1Hger5fjhOFZlfXH2Yvn4crrOS0Cm9flfYnCZrhY2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(6916009)(2616005)(8676002)(16576012)(316002)(53546011)(45080400002)(54906003)(66476007)(8936002)(478600001)(966005)(26005)(956004)(6486002)(36756003)(31696002)(5660300002)(38100700002)(66556008)(31686004)(7416002)(186003)(4326008)(2906002)(66946007)(86362001)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU1pSjdiaUtCeHlrT3lUZ1NOMjhmaG5pbHkvMjBKdzMxckFHQ0YvZm5KSXZh?=
 =?utf-8?B?VU8yNXBEM1JnTjA1dWhKNURXNUlGS3lkWEw0ZXJsZG41SHRGcE5temZIc2JX?=
 =?utf-8?B?YmkxQWdUclJ5TStHcHQxSVRuY2VJaXpxdjZOWFYweUJDWWhEb2paajBvaGMr?=
 =?utf-8?B?MXlYMk4vdXpTOHB4QWJZaXRBT0FKVXRONVcxT1dhdTRXeHJtUTQrRll1dkhw?=
 =?utf-8?B?cGkybE0zTS9DSVJyRjlJNFFpNE53SXNpU0liOFNFbUNxWFVva1hFNmU0T0x3?=
 =?utf-8?B?d1V0M1JobCszZVEvQlg3aXN1aXJqQWZZZmR0N0ZFdG92QTZtZnRaNEZjbkpy?=
 =?utf-8?B?R1N4Qkw0TnowRlZQL28zczF4bXJXM3ArY05qZ25zMW1mUTJzUFFSNTdOcGRU?=
 =?utf-8?B?SVJtd1ozdkNCQUh5RmUyVkdLK3lHMytHUkRnby8zZTVUVzJ5SFVNai9GL1Uw?=
 =?utf-8?B?NmhLWUF2MmplTG9aRzhjOGcxVGZSWHh4UEdnVUF0SERMUnN1Zi81MWNWYXVw?=
 =?utf-8?B?ODhac2N1R3RraWhTOWp0M3E0ZnJKemdhQ1BQUTlLMUh1T3o3OUVJY3czSlRh?=
 =?utf-8?B?Ykl4THgzMjBDaEp5dVJIYlhmdmpvSFdtOXNaYWZvdVQ2MnRGUjZOQ09pOWFZ?=
 =?utf-8?B?RzkrZThhcjVmV3ZSU1BiTVpOamc3djc5aUJtOEVkT1hWT1BmZVlrcmF1bUtH?=
 =?utf-8?B?NG40anNmanZSSVl6ejkxU3RBa1I1Y3dLQUNFbnhBdGxKTXpFZ2F5bHJwUENB?=
 =?utf-8?B?M3BsQ0kvR3dTcnZ6QlN1dko0cFMrTzVEQUFuekYyaVlNaUdRN3JGemdYdWFa?=
 =?utf-8?B?YUNWdjJ4blY0MHNGdUpJVE5SMkZuWStoeUhYZThzay9RaDZLR3VNQ2p6ZzJ6?=
 =?utf-8?B?SS8rdTVxUzZjdUpmL2ZPbkRVWFlVK2Exa0pQMTVIUFJycXRFRUIvU0pwNFA0?=
 =?utf-8?B?S0FjaWFJUk16TEUvZXVTN1gyQnF1YnNUMHBGZ04xc2lZV1VjcVg2cEswb0d0?=
 =?utf-8?B?SUMzZmhGWW5KeE1LQm8rSVZLb0hkL2ZHZXlsZE9mcDZIc0pGcThubmkzOXVW?=
 =?utf-8?B?MG9EWHJheFZYZmxKOHFsZWNzWGtqMGxycjAzVUFlM1N5NlNKNDh6OEpGTytW?=
 =?utf-8?B?ZitqTU9KVktmOGRma1ovRXJvTVBocTZ6Z2pycFNrbkwzS3NsaFFrZWp4Rlps?=
 =?utf-8?B?N3JNMWdxL21OTjYrT2xPNGdNU0hmK2dQSEw4NEJMaW5TWTdranBuMTFZUnMy?=
 =?utf-8?B?Y3JqbXR3aDYwakcrQ21ha2tudDBJSE1NMTYzd0VqWCt6V2JkeHpDdFV0WTdJ?=
 =?utf-8?B?ZUxDTEVEREpiOU10MER2bVNQek1iSFlrYlM5a3hERFlEMkxIdkRhMDNWbzFh?=
 =?utf-8?B?Y3hndTd2VkU3U0R3cktrYnJEZFRINk4yZHRjVDN4eVBNYmVoNE9nejZyajd3?=
 =?utf-8?B?aUtzN3doNFNFTjRVdVp5M3VPYVdRL1ZJVXhOazNNNHFEU01WTVJ4RXh6WXVi?=
 =?utf-8?B?TjRnK01yRmcyVWFHRng3M2tvNUx1TnJqRHRQK1JPNEhLZ1BtczllVm12cnNr?=
 =?utf-8?B?eUxQa0JRMFhvNktOWTRncERrdEw4Q2IxQ0xGMlgrL2pUNUJZakVFMzRtWkhj?=
 =?utf-8?B?TVpXSjJlZ0g0UXVnZlFRQkI3Y240MWdKeWZ1K1plb1VnQThDWlNnWUc5ay9r?=
 =?utf-8?B?Y3hOYzFRay9Ob2x6c3BzRklqU2pLT2JDMk5FbmtNcmtQa3BOZXV4cTkrY1lz?=
 =?utf-8?Q?oPzvFj+Q9JJtcNmCth99Qa5IjwFHL6i4BlDA+LI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901ed9b7-4de7-4277-18e8-08d961aea74a
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 18:41:41.1069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TzGuzAlvDXWOcpCossb9DaakKNQfGsBRndfUVT1jDCaZhX39SsZDR2CiG9XNnz5G5ertapxRcfZBU1Ztu6KqOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2640
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 8/16/2021 09:04, Rafael J. Wysocki wrote:
> On Fri, Aug 13, 2021 at 6:19 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> A number of systems are showing "hotplug capable" CPUs when they
>> are not really hotpluggable.  This is because the MADT has extra
>> CPU entries to support different CPUs that may be inserted into
>> the socket with different numbers of cores.
>>
>> Starting with ACPI 6.3 the spec has an Online Capable bit in the
>> MADT used to determine whether or not a CPU is hotplug capable
>> when the enabled bit is not set.
>>
>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fuefi.org%2Fhtmlspecs%2FACPI_Spec_6_4_html%2F05_ACPI_Software_Programming_Model%2FACPI_Software_Programming_Model.html%3F%23local-apic-flags&amp;data=04%7C01%7Cmario.limonciello%40amd.com%7Ce6a384bf25274f88b49508d960bee40a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637647195281368169%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3MWJ5NcRVJ7TP4tJH6uQRbqfZKSqe5RHjGxGbQEP13E%3D&amp;reserved=0
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   arch/x86/kernel/acpi/boot.c | 10 ++++++++++
>>   include/acpi/actbl2.h       |  1 +
>>   2 files changed, 11 insertions(+)
>>
>> Changes from v1->v2:
>>   * Check the revision field in MADT to determine if it matches the
>>     bump from ACPI 6.3 as suggested by Hanjun Guo
>>   * Update description
>>
>> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
>> index e55e0c1fad8c..bfa69a5c9c0b 100644
>> --- a/arch/x86/kernel/acpi/boot.c
>> +++ b/arch/x86/kernel/acpi/boot.c
>> @@ -53,6 +53,8 @@ int acpi_ioapic;
>>   int acpi_strict;
>>   int acpi_disable_cmcff;
>>
>> +bool acpi_support_online_capable;
> 
> Missing static?

Ack, thanks.

> 
>> +
>>   /* ACPI SCI override configuration */
>>   u8 acpi_sci_flags __initdata;
>>   u32 acpi_sci_override_gsi __initdata = INVALID_ACPI_IRQ;
>> @@ -138,6 +140,8 @@ static int __init acpi_parse_madt(struct acpi_table_header *table)
>>
>>                  pr_debug("Local APIC address 0x%08x\n", madt->address);
>>          }
>> +       if (madt->header.revision >= 5)
>> +               acpi_support_online_capable = true;
>>
>>          default_acpi_madt_oem_check(madt->header.oem_id,
>>                                      madt->header.oem_table_id);
>> @@ -239,6 +243,12 @@ acpi_parse_lapic(union acpi_subtable_headers * header, const unsigned long end)
>>          if (processor->id == 0xff)
>>                  return 0;
>>
>> +       /* don't register processors that can not be onlined */
>> +       if (acpi_support_online_capable &&
>> +           !(processor->lapic_flags & ACPI_MADT_ENABLED) &&
>> +           !(processor->lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
>> +               return 0;
>> +
>>          /*
>>           * We need to register disabled CPU as well to permit
>>           * counting disabled CPUs. This allows us to size
>> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
>> index 2069ac38a4e2..fae45e383987 100644
>> --- a/include/acpi/actbl2.h
>> +++ b/include/acpi/actbl2.h
> 
> The one below is an ACPICA change and I'd prefer it to be integrated
> via the upstream ACPICA.
> 
> Could you prepare an ACPICA pull request for just the bit below and
> send it via GitHub?

Sure thing.
http://github.com/acpica/acpica/pull/708/

They said they would take it later this month or next month.

Given that, how do you want to proceed with the first part of this?

Should I send a 2 patch series that will add the MADT bit to actbl2.h in 
advance of their next release, or should I wait to resubmit until after 
their next release and you've brought it into your tree?

> 
>> @@ -808,6 +808,7 @@ struct acpi_madt_multiproc_wakeup_mailbox {
>>   /* MADT Local APIC flags */
>>
>>   #define ACPI_MADT_ENABLED           (1)        /* 00: Processor is usable if set */
>> +#define ACPI_MADT_ONLINE_CAPABLE    (2)        /* 01: System HW supports enabling processor at runtime */
>>
>>   /* MADT MPS INTI flags (inti_flags) */
>>
>> --

