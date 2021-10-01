Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAE241F313
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Oct 2021 19:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355389AbhJAR3F (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 Oct 2021 13:29:05 -0400
Received: from mail-bn8nam12on2074.outbound.protection.outlook.com ([40.107.237.74]:32352
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1355297AbhJAR3F (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 1 Oct 2021 13:29:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1jubHlx/YITRzUZuD3oL24acqGBEEQyrTWxQkyrNYm4IY+YsV12MG5pe4MpMFYGYcRCWbUbpYkWAL4+HOEo4U26Z4fnq8Ko41Joj6Vq7BaIHWouPsE1J6+HrCWwFQaNDG7CKfWRxL7OAvefI9DIsZfEh6fYwdyI5uDqLo0YUOKRT1yFlSf7vHKtMMBSXXSO/SCSYYpCOQvqtpHZNyQ3pcGppltizKTytLIyaX5g9NH8IVJshyYaU5FL906+4a4PKUjbqatApluqyV6b3wcKWJNrLOc6X0Ffz39S1EOADs5PSM5MTGTbKsA5D/4KvVX1JGy98qeN8H6fd+TMEANwKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpaNjKqYAyKev+mXrJscgOx2+ujlyXDISyLfAWAubOQ=;
 b=QwY1XbrN0VU3vpiv2nn/Q1fGWR9Bpw3L1dFH6ohmPvGJPWWt3k8IWUVBxgcVj+ajZ7HtPW//yJsaOxTPyv89mD9sD8VgrRamuiYbrhsXItne5sasbIFrDS8bzyl2eEPUa6aS7IEduk6n85RmKvflT5yTIFjEEoigTE+ELBAmkt3+IB6vD1kdeCLIOzGeyapP1tIgl7Fo93GVCv7iTxdXjuS7rpfIyoARQP2lEcs9gVmpPk59dGbeKfmfN3L43EoQgyG9qIhO0SB4fKZvl2Htk59lzOjRIVg1ZqrEwL2+Xe9lvlA4b0bQ8p4I8Q1lyStz55wc46VXYhfuSE/5UW/+Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpaNjKqYAyKev+mXrJscgOx2+ujlyXDISyLfAWAubOQ=;
 b=tAU/LzR5UtlU3hlFaN/uxaroQR0SMdC64z9V0OshOz798Lh6vapAmr95M3ixqdMgEi+SHavqS29inJip7hEHY01YW4+M9+/EzuCYhlg6Ywh3ManKM4Fq6LLNOwQdwy4yIYXfs3kS2nEzevW0ro9u0rHUBZkYR0TFCUgKs14RRgY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN6PR12MB2829.namprd12.prod.outlook.com (2603:10b6:805:e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Fri, 1 Oct
 2021 17:27:18 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::f909:b733:33ff:e3b1]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::f909:b733:33ff:e3b1%5]) with mapi id 15.20.4566.014; Fri, 1 Oct 2021
 17:27:17 +0000
Subject: Re: [RFC] acpi/x86: s2idle: Use constraints to enforce behavior
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <20211001161854.19802-1-mario.limonciello@amd.com>
 <CAJZ5v0ipP6YCrw+ypyTX9b_O-93Y=RY8PKNp=ojfZe0qP=Hh7w@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
Message-ID: <0571292a-286b-18f2-70ad-12b125a61469@amd.com>
Date:   Fri, 1 Oct 2021 12:27:14 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CAJZ5v0ipP6YCrw+ypyTX9b_O-93Y=RY8PKNp=ojfZe0qP=Hh7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN6PR1701CA0019.namprd17.prod.outlook.com
 (2603:10b6:405:15::29) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
Received: from [10.254.34.155] (165.204.84.11) by BN6PR1701CA0019.namprd17.prod.outlook.com (2603:10b6:405:15::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 17:27:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d002e96-c82e-44f8-ecd3-08d98500b776
X-MS-TrafficTypeDiagnostic: SN6PR12MB2829:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2829B2FEF43FB26B59F7D460E2AB9@SN6PR12MB2829.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qSIVxvGD5xocxpHpJajxprgRRzrtQHZPIW1gSG40xd9trzq1QKvnXbpO1C4QSE4uBNAMkiqV6Zww/BMzThO/Bjr1Emxlbpu5OUQ5PZA/KYpBzz0W+7MzRhHub6CXmyKmCfRkfvr2x5UxCvqLdBbLRMwTmWya+tp1uNEOAtP0OWcQ4RwRutBtlQioKCUQF2lfgRAR9xDiTQqntanJEwALh0uX3D08HmWWQRL/xrQ6tRP1PKpMmQxCehMgNHAn9UwbxPLUjLHNvk9GmclUiM6UUdO+BOqtO/Q/55Mpfiuzm++pao/O9j+4wUBYvI62xVQmYRyoWZvdnKEQdoJL+Gk3C/1psD/E16k6NyEkRNv5TFvEUjZJd8KoFBXSkBASTGXxMTCQJ4iURanhgPm1ywVjzOjeeKH4hwQ3MfcUvEE9kTiRFBVtzr+DoSoN/MZ2T9zu2XBoOGSTjBR9kB8wCDVgyUxgvXCUfVVAiGnxkr3XD1sfQSGpaox+Fl0W02JIkEL5Izlr9mHp6pmbsbwTg3y2DO5QkR16mnYAbZp53Tv0zbeubb4c1Gh3TwipnR/38d7L6tfVPpre3b3ELSsbEbUc+dAhXdW8RAtfOsM4FkOsjRPporZ3NdzmCDZzT5MurpLndD/mtYTxX/0jkbLL766JYlbGDElK+2sq2jteHu7jJ00HksInDmQwAa/+VYdbK+hjYBCFbUcZ6vimtqhhYx99ST3pNCnADkbJpcu1QBxszCdXvyaJweprMV2ncI96XELlzScM0Yf6mYbZWVDyb8/u8zWHyg39xuPLjfmVXI/w9ghHtyBFxAg7GU0TsBOLUno0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(16576012)(4326008)(45080400002)(316002)(36756003)(83380400001)(66556008)(2616005)(956004)(66476007)(66946007)(53546011)(6666004)(31696002)(508600001)(26005)(966005)(38100700002)(2906002)(8936002)(186003)(6486002)(5660300002)(86362001)(31686004)(8676002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXhVMGJ4bktVZDROZGNLbzAvSWVlb25UNjdiUWZ5a2RBdnFuZVBnYkk0c0d6?=
 =?utf-8?B?dVJ0T3pIZGtRUHZnSFlEbjc1RVdtM1ZhckZwTVBuais0SEVCVHVOb0poTkFl?=
 =?utf-8?B?Q0E5WmtmRXBMM3lxK0RUMktDOUJzZGlsb2F4Y2tOSGlRaXYrVFB0Q0ZxbTFa?=
 =?utf-8?B?dko0OUpDR1dCUy96R2tqbzM4dkpFTWZGVnIxbXBRc2xpNXY5dXZEY3ErUlNx?=
 =?utf-8?B?NnFvNFV4RVhzRWRkb3R1NU1rVjVOam1rakE0VklReFc1dGRvTVJGakY4aGha?=
 =?utf-8?B?M0RzOUVZanpuV1pldklLZlBINGNiRzJRdU4zdHhJT0pRVjJiSDJkSW4vWURx?=
 =?utf-8?B?c1hyYWxIVndKVGZ6TjVuQUxUTWhxWk5pVUNUcGs1Y1JDRU5JTmpKWGE4eGFR?=
 =?utf-8?B?R21waDBmcWt6SE5rVUxUYWp1UGltcmlscFBmNCs2R2dEQzBqQkhGNVlHdmIr?=
 =?utf-8?B?bnNRVFNkbVJwUFZ6dDIwR29RNXJEeXJuMm0xMGxySERNM3NNd2lsdTVJaHQ0?=
 =?utf-8?B?aW5nUzZFMFM4ZlAxMTFwUjhyaUtIamZXbks5cGwyV0FzcDY0QTRkSnNON3Ni?=
 =?utf-8?B?L1d3bUR6ekplYzMrTmd6eDdvMU03NGdPbmZDYlNUSmQ0VmNlWnpsRjFBRkQ3?=
 =?utf-8?B?aUpCQUhmTGVTVXB1aVF2OEdITUppdmpBcEpQekMvR3ArMUU2QmFHaThwMG4x?=
 =?utf-8?B?Z2cxUTVQOVRZaC9nNEFacXlMWmNRa05FNldCTjR0NGg1aUQrWTFpUnNvVkZW?=
 =?utf-8?B?OXNjckF0Yjk0T3lNTm1NSzJuMUllNXhsTVBuQURreFFhSmpvTlBsZ0dJZmlM?=
 =?utf-8?B?OURBTCtvUzM1OFdVZFd3RDUrN2piTDdaKzdFdVkrQUs2V0RnMVQ5R3NjOTRw?=
 =?utf-8?B?emNaU1l1dE1UZCtPaXJRNWNUZklUeXI4MHRxMlpRUzZTdXY5RXRYS2lZK2cy?=
 =?utf-8?B?bGY3VyttMmswdm1SYzdLbUk5TFNIM29yNkhkOHFKZzArc25YRkVTcTY0aHFH?=
 =?utf-8?B?WmFCNkRPTk5NQXpQZEF2c0tkNGF4U1pzVDBTK001aU1NcHk5ZHZkaGFvT2hN?=
 =?utf-8?B?THZ0Q1JFeEF0NkIyalgwK3FDU00xcENKWFFFaDVOb0R2VFlUUkNrend6dXls?=
 =?utf-8?B?aG00ZVorS0FTS0RST281eUJOdjNDajVIS2wvbEQvQ29tVTNoMjk0a0czNGxW?=
 =?utf-8?B?RW5HVll2ZWpZRG8xUFR5S0hQdlpOa0RRUVc1Zjk5MzV6TjJyNlJQOC81TUFm?=
 =?utf-8?B?bzh4YmZ2Z3ZMN3l3Mld0ZCtMRVdCd1hpdDNXQW1oQWpRRzEyUGxBQVRKSGln?=
 =?utf-8?B?cThCUnBGb04rZTZrY0EzTVRpUFJxaUJacXRYcWZJOFc3V2dvWHZUWGVRZGdG?=
 =?utf-8?B?WDVrMWNqaEJIRURUaXdObG9IYXFXUnRraENWWnZlZ3hFcThqcDdsMTJZSFMv?=
 =?utf-8?B?bTcxL3k5cG15T1RvNEQwc1ljZVM3VmRsWStiOCsvV2Fxb0FqVFE3RnVQa2Mx?=
 =?utf-8?B?ZVVmOTZTQ0pVTDludyt6VzJYLzRtOWl6OVMyUitkR3VzUGFGMysvdnE4TkIx?=
 =?utf-8?B?bGttWG5XbW9JMmxiWFRYNEhxL3hyUWZCK2Zpa3daMzhadWJ2eEI3Rit4akFQ?=
 =?utf-8?B?ZTlSZFBwZGpHNkE1MlF0UFE4bEtJbDdGOGRkRFNtV0IyTVFtMEJYK2N2bS9p?=
 =?utf-8?B?SHh5UE8vemMvL2JnVVB5c3VFQ3pUSllGWE1NNG9wTTFNcUYxZkIxc00zMit4?=
 =?utf-8?Q?Rd1d/rR7fDbCc+Wm8UZ1R2G0ISEjs+3tHxM7Kp1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d002e96-c82e-44f8-ecd3-08d98500b776
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 17:27:17.7838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSsynBxCce+YYimIiZbz4gPGE+G8Krfi7EuRi6/QLgUZ0kH8oVqiVJzRHnAAityEhzuGyaxM9ZWhNJ8n6uEvEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2829
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 10/1/2021 11:41, Rafael J. Wysocki wrote:
> On Fri, Oct 1, 2021 at 6:19 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> Currently s2idle constraints are only verified when pm_debug_messages
>> is set.
> 
> Very much intentionally.
> 
>> Although useful for debugging, it does have a tendency to paper
>> over some underlying issues.
> 
> What do you mean "paper over"?  It is not expected to do anything
> except for providing information.
There is a difference here in Windows and Linux for how this works -

In Windows the failure of constraints checking actually gates the final 
LPS0 notification and any actions that have arisen from that 
(ACPI_LPS0_ENTRY, ACPI_LPS0_MS_ENTRY, ACPI_LPS0_ENTRY_AMD).

> 
>> Of particular note, I found a case that a system that has two physical
>> SATA controllers that share the same ACPI Power Resource.  When a drive is
>> connected to one of the controllers then it will bind with PCI devices with
>> the ahci driver and form a relationship with the firmware node and physical
>> node.  During s2idle I see that the constraints are met for this device as
>> it's transitioned into the appropriate state. However the second ACPI node
>> doesn't have any relationship with a physical node and so it stays in "D0":
> 
> So the debug information is actually useful.

Very much so.

> 
>>
>> ```
>> ACPI: \_SB_.PCI0.GP18.SATA: ACPI: PM: Power state change: D0 -> D3cold
>> ACPI: PM: Power resource [P0SA] still in use
>> acpi device:2a: Power state changed to D3cold
>> ```
>>
>> Due to the refcounting used on the shared power resource putting the
>> device with a physical node into D3 doesn't result in the _OFF method
>> being called.
>>
>> To help this problem, make the following changes to the constraint
>> checking:
>> 1) Make constraint checking compulsory
> 
> That would break things AFAICS due to false-positives resulting from it.

For the RFC patch I kept things the same functionally - only emit 
messages if pm_debug_messages is set.  I would like know your thoughts 
on more closely aligning to the Windows behavior though.

> 
> The rule of thumb is to check the constraints only if you don't get
> the expected state
> 
>> but gate the output on pm_debug_messages
>> 2) As part of constraint checking verify if the ACPI device has a physical
>> node or not.
>> 3) If a device doesn't have a physical node, but does have a requirement
>> set the power state for the device to allow shared resources to transition.
> 
> This fixes your particular issue, but is it generally safe?

It doesn't actually fix my issue, but I found it as part of 
investigating the issue.

I don't know if it's generally safe or not - that's part of why the 
patch is RFC :)

> 
> Also, I think that this needs to be taken care of during system
> initialization rather than here.  Device objects without physical
> nodes that prevent power resources from being turned off are generally
> not useful at all and they prevent the SoC from getting into
> lower-power states through active-state power management as well.

OK, I'll try to find a better time during initialization to do this.

> 
>> After making this change, here is what the flow looks like:
>> ```
>> ACPI: \_SB_.PCI0.GP18.SATA: ACPI: PM: Power state change: D0 -> D3cold
>> ACPI: PM: Power resource [P0SA] still in use
>> acpi device:2a: Power state changed to Dcold
>> <snip>
>> ACPI: \_SB_.PCI0.GP18.SAT1: LPI: Device is not physically present - forcing transition from D0 to D3cold
>> ACPI: \_SB_.PCI0.GP18.SAT1: ACPI: PM: Power state change: D0 -> D3cold
>> ACPI: PM: Power resource [P0SA] turned off
>> acpi device:2c: Power state changed to D3cold
>> ```
>>
>> BugLink: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D214091&amp;data=04%7C01%7Cmario.limonciello%40amd.com%7C763dfde3eb0a4f9fcb2408d984fa6102%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637687033171350513%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=DayEDSMdysYB%2FdpHpzjZMVsSYr9IZ1U55YEjUpw%2Fj88%3D&amp;reserved=0
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/acpi/x86/s2idle.c | 22 ++++++++++++++++------
>>   1 file changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
>> index bd92b549fd5a..fbfac40733eb 100644
>> --- a/drivers/acpi/x86/s2idle.c
>> +++ b/drivers/acpi/x86/s2idle.c
>> @@ -304,14 +304,25 @@ static void lpi_check_constraints(void)
>>                          acpi_power_state_string(adev->power.state));
>>
>>                  if (!adev->flags.power_manageable) {
>> -                       acpi_handle_info(handle, "LPI: Device not power manageable\n");
>> +                       if (pm_debug_messages_on)
>> +                               acpi_handle_info(handle, "LPI: Device not power manageable\n");
>>                          lpi_constraints_table[i].handle = NULL;
>>                          continue;
>>                  }
>>
>> -               if (adev->power.state < lpi_constraints_table[i].min_dstate)
>> -                       acpi_handle_info(handle,
>> -                               "LPI: Constraint not met; min power state:%s current power state:%s\n",
>> +               if (adev->power.state >= lpi_constraints_table[i].min_dstate)
>> +                       continue;
>> +               /* make sure that anything with shared resources isn't blocked */
>> +               if (!acpi_get_first_physical_node(adev)) {
>> +                       if (pm_debug_messages_on)
>> +                               acpi_handle_info(handle, "LPI: Device is not physically present - forcing transition from %s to %s\n",
>> +                                               acpi_power_state_string(adev->power.state),
>> +                                               acpi_power_state_string(ACPI_STATE_D3_COLD));
>> +                       acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
>> +                       continue;
>> +               }
>> +               if (pm_debug_messages_on)
>> +                       acpi_handle_info(handle, "LPI: Constraint not met; min power state:%s current power state:%s\n",
>>                                  acpi_power_state_string(lpi_constraints_table[i].min_dstate),
>>                                  acpi_power_state_string(adev->power.state));
>>          }
>> @@ -446,8 +457,7 @@ int acpi_s2idle_prepare_late(void)
>>          if (!lps0_device_handle || sleep_no_lps0)
>>                  return 0;
>>
>> -       if (pm_debug_messages_on)
>> -               lpi_check_constraints();
>> +       lpi_check_constraints();
>>
>>          /* Screen off */
>>          if (lps0_dsm_func_mask > 0)
>> --
>> 2.25.1
>>

