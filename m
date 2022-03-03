Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D270B4CC427
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Mar 2022 18:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbiCCRlC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Mar 2022 12:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbiCCRlA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Mar 2022 12:41:00 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2070.outbound.protection.outlook.com [40.107.95.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B5B1A06F4;
        Thu,  3 Mar 2022 09:40:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izGmmoiJek64qIzjjaj43IPKUAi49BxyO+EUVFl3rd0rggmA6acgJ72xyqdrvYeZ8BIheY9IKusPLvb4O3sGGGa/2wfDvM23TqtyvOZfB1jt5/s9g1RO1Ql15e1wYBSfdUv723AbBmkw9NWyS8+vSlA93eoCgqygAoLV7m0mkswKModzDT8O19C7G0DVHNKEI/47mdv0D2ubPZOfiyIMgLiWcFbu5XuPWKNIuJF/yNV0IRdi5984SyGtDSeremXDgAFn3DT5qreQRIvnHAia7XXzCFhJNTFmb0jTk4IgLXzMHuuM6XUteT+ruLoWnE+/JNVwY6fQSkzOU2cnX1skkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DR3+6I/3rbn1GbAHR9A18OmV+Co0kR5enaNISDDKL7I=;
 b=jiFmLnZG7CQOPPPGpIpEs1UsAplpGhzxPhtHF1nEdyzKzHHNXRgcivwUVvNiYp66SAXPIu4LIhe/X0RI10kee1ADYQdBp0QEQkqRtxz0J55gNbodniLHbpZLCG5E/AEqhRiziq27YHgKZWtZepvRkqgRsiO0aDueIzRqk1sj0/ZqpgqUijiqWLSOplGaPAzLKJUwOhXgZLd3555JS2oA5kYURo2zGSRzQZqyuRdl+WdBDvgUkG5A79PIYtbD2/OiMZg5kG7ResjUTaiI2Zv9kvPwTKx69HsoN4hGUgp/8PgfSnFI6XYXdj04eClcHRYE7ipR3NgRUjS9kfAVMfunZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DR3+6I/3rbn1GbAHR9A18OmV+Co0kR5enaNISDDKL7I=;
 b=0xIIjYCECpuXyl0fEL7iY0o379N0mORckIr1uKZZh5KeRB3WO8C+3pFTvuieb2LQO6WWJEgIYkcKgNDeTTRohGfWyFSUgxTWsoIWrV9vh1u10arAuRkdN2K5x1Thzb3kS2fwykaKMY73Gpn5edkQxvMON/JDgzPo8ia97Tw20VE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by SN1PR12MB2511.namprd12.prod.outlook.com (2603:10b6:802:23::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Thu, 3 Mar
 2022 17:40:09 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 17:40:09 +0000
Message-ID: <dfd8d8e1-9736-6c7c-1fc0-46dd00d58f10@amd.com>
Date:   Thu, 3 Mar 2022 11:40:07 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [External] Re: [RFC] ACPI: platform-profile: support for AC vs DC
 modes
Content-Language: en-US
To:     Mark Pearson <markpearson@lenovo.com>
Cc:     rafael@kernel.org, hdegoede@redhat.com, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <markpearson@lenovo.com>
 <20220301201554.4417-1-markpearson@lenovo.com>
 <e6a3380d-dcc4-8e61-cba0-813d2404ee1e@amd.com>
 <73656cdd-64d7-b9d0-aff7-61e5b98c2799@lenovo.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <73656cdd-64d7-b9d0-aff7-61e5b98c2799@lenovo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR22CA0026.namprd22.prod.outlook.com
 (2603:10b6:208:238::31) To BL1PR12MB5157.namprd12.prod.outlook.com
 (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b1816de-fce7-4962-d646-08d9fd3cdcbc
X-MS-TrafficTypeDiagnostic: SN1PR12MB2511:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2511631C6801E127E33CB3C4E2049@SN1PR12MB2511.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8NorQfgO9K7BadZtntUkwFfYiGNGhpGUo37V5eMZYEbei+0aI1dUFrrSotmiEsLfblDV7pNHDcfslPnbBxSzNZUWDOC7qMeRadmsVuKjB0wY5OBY3WPHcTgMMbedPcj9LAlxJ4S0n96L0Smd4BqxP7ty2Zl9EAfe2w6x1Z56PSaJQ1NiEHqQQp4+7uIfrPe7LChbvRvfa0vYwgzWhzE9QXpM25BEpTb5FGqsp7xdql6zUBb9gQRyhVpy0u/I6YFWpaldtdV54gbJHFIKqj5GrkN9Nj0nTurGCfOtPgNwa8DDYqN+/0vqGbCvqDG+9UOcTuyXoPMmkb9tvuadLof9ukMXhCDMkoRI52/a9IkM4zWdqvdqna2BE8Wjr72KLbX7a8779g2wQ53ECxF35SYcWcBgpDc+3oL5Xcopuq7TPpsu9LwEVOe//ajSLPWQ7edsta1Ewnk3/5xdtCSQLx7jTqwzqHl3kRPW4jA9d78sGVzdlNzi8pkh6I2i/rwqRNVcCsyQyFOYytY5yMN9UwVLsjDx1AZCQnq+3LODUvIUTY8QvXJltNkF974mH71QVAdtUuISTq+RH2wTflGcKdaeoOgrh0+wmzUdqk3mFj/CAk4mcS+GQ+j8hYNvvHqFZ9tyfqHUgt7Wq7bQgGhnFCy/SIkNEMppaQhzhuCOsq4nTTrefQ1vf4pxQcm7G87UUcigGdFi98owwUE5c7f7IgIKicIuibxB9hCNvdphSbpHHwnn0mdmQzp2IqYZUNVuV9ZT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(31696002)(86362001)(2906002)(8936002)(66476007)(66556008)(5660300002)(8676002)(2616005)(66946007)(4326008)(508600001)(26005)(186003)(6486002)(31686004)(38100700002)(6512007)(316002)(83380400001)(36756003)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGxvdVJ6c1BrYzFpYzdpVG95VENZVlpjcHBtV3Z1K3c5TTJBT0treTZsU2xw?=
 =?utf-8?B?ZUFOR1hETlpmSENKWUJmdTdhQkltYU5Ga1FIQnBLUGVaaTJVZUpSemhtd3h3?=
 =?utf-8?B?WDVJekRMYk13dFFWdEx0MkxEOFBuTFRCMmFiRlJMVklwdTh2T3FRd2t0alJZ?=
 =?utf-8?B?WklQTUpFaFZxc2dNNG41RW1BOHhzOUszSkEwWDRYcGFIeDA0M1UxRUt4aHU2?=
 =?utf-8?B?ZTZxTyswUjBTcDVmalVGMkg2LzBEbXJhcE1sU0ZLem82bUpVMHg2U25uVXVJ?=
 =?utf-8?B?bjd1OGJ0OCszZkE3UmxpaDJkT1M4WUlwRzJUN2MxM1RpbWpxNlFhUVhlTEM3?=
 =?utf-8?B?VlZocjhFRzNpaUd1NElXK1NHbTJtZHJlVS8xSDNuWm5uYWZrVk5nMVBXL29I?=
 =?utf-8?B?UktTVmtTYW9BSlEwS1V6OUpYREVXYnIzU1pITUh6NG1UWjlBeHAzZGwzUUQ0?=
 =?utf-8?B?eGI2N0pQQ2FXd1F1czRiTkh0YVR4NDRHanBHWFN1Z3FCaWE3OG1XVW83eFBj?=
 =?utf-8?B?dVlHV1JwUThYTmdicVo4VHMzWW9Jcm11d0d0UmVGaDdSSHpSWHNvcFBzM1Nu?=
 =?utf-8?B?RzUvWlhqNXpablkySkJHRHEwcEg4NzliazhJRWp2TUNDVHBCeGNva2xGcFBl?=
 =?utf-8?B?bXBNaVM2NkNuVXFqTXRuSmdHWFJJcUhVUGRqNlA2NC8vQjdKUFJ6cVRNc1A5?=
 =?utf-8?B?VEF3TzA0ZlpyS3h6QVphS1BNY1U2TTYxQm12anVxYmZiUzRXRmt0NjBIQ1pt?=
 =?utf-8?B?YWxWYk9lU1VDckNrRXFPWFI4Zk9oeTRMcWdwdWw5Z2VINFZOSWJIVVhkWE1B?=
 =?utf-8?B?UGs2Z3JsTk1MMWVYZXFoT2V1cVplS2xnU05NRFlaQWtGMlptaVhqdnljZnkz?=
 =?utf-8?B?L21zSWdnZzFBN1hwbnZpODVEc1dGTlErekhLQ1N6SzZFdER5dlhDdmh4Y0Rz?=
 =?utf-8?B?YTF0aFptVTJKbXFXTDRGWTdodFZSWDloTURudHdZR0RvMGxLdkF5SmY1bmkx?=
 =?utf-8?B?TFZSNjNZUzZEU3cxV1hWTlRGUWRiQ09aQlYzOG9PNmpkMzQvcW4ybldOT3Bv?=
 =?utf-8?B?ZTJIdmN0alNvR1VSOG5HeVNZYVZLdkNPaGk2QnlGbTlkZnAwKytCUmtRMXht?=
 =?utf-8?B?VXVDMEo3dXlZY2toamIxZ0JYTVY0Q3IvRjNCa0dYV0FCVFZ5YWFmVXFJWVBp?=
 =?utf-8?B?VHRFUzRFQkNRVE1BcUZCS1dWdU13MFNMWjZhMGVXM1ZBQWFmQ1BSMTkrM2kx?=
 =?utf-8?B?Y2lSVVI4UkEwME5YNERhQXp6TC9iR3FQMFd2cE5hd1JMcloyQkJkclAxUnIr?=
 =?utf-8?B?cTMvZExIZ2JZNThySm5DSlRYaUpFV1RrWndKMVo4NDlLZGd5MGl6TnRheXpp?=
 =?utf-8?B?cWdwR1pmcUdkSWlNQlpuaEZQQVltendlckp4VGFEc1IvWmdMUWhUd1VZbXZN?=
 =?utf-8?B?MVROOFd2Vnl0RlA1dXhJclBsaWtsOGRDVjZvYjJMRzFxVW91L3UweUVMdjFh?=
 =?utf-8?B?MWczK2N6YUwxT1BrclRJNGZkL0tDMWhqSEtwNmJuUWhxMUhKSmM5K1poNTJK?=
 =?utf-8?B?RjloV3U1RlhoUkZOWVpLZUJIUmhCUTVaYzhnUmt4RlhOSEFLSUx4VDJGK3dQ?=
 =?utf-8?B?ZkpGblA0ekFmL1JwWXh4STJ6SU9lUm9Vb1B5T2QrNnpXZEE0TW5VNjQwclNk?=
 =?utf-8?B?SXFPeHg5RlVQb1hHY0NjVmFrelI4dlNPYUgvMDB5NjhUZXcxYmtodFQrcEhs?=
 =?utf-8?B?OVBzQlJaRkI5ME9Fams3SldmVGhYcENZYjVRai83WWNSeGY5UDhEbzJnMzQ2?=
 =?utf-8?B?REdpU1dYUFRXbW1yc2loRXpncy9tVDRTMjdRaDRRNmpaU2xkNkdQMTEwbnor?=
 =?utf-8?B?MnRCQXJaOEU0cm4vWHNBVDRCbXorSUZQRUdOOWx5MHVBNmdBOHJlYjlDTWl4?=
 =?utf-8?B?T0FoRDM2WHdZVlh1SW9HR0tRNzdmZ3FNL09CcW4vYmdaNnkyWVg0b2tLdGNU?=
 =?utf-8?B?UnpnOXdUZm1oTFd3d0MyQ0VXNldRdUdpWnlmV0dBMzJyK0RZcmtoU1YrTUta?=
 =?utf-8?B?MEdEQXp0aVNHaE9XNklqdE9TNVpJQ1EydGtxcFQyQU9XYjZTYVR2WDEyT1RR?=
 =?utf-8?B?Y2QvT3Yrek9lZGtDbTFTeTAzR0c2WU9LeDdVUTB6MFhrT25qNEt1SkxpTlBh?=
 =?utf-8?Q?K9AaCIs/kgaZSRrOfwHxQQY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1816de-fce7-4962-d646-08d9fd3cdcbc
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 17:40:09.4125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c1lYg/cIZZoEC1AsCBxZFy54/b0Al4M+s82BbvjNk1yf5AB5r41b4+iIPSC93ej91NgvGw7gOi9lZr3cbzuYnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2511
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

>> To make it more deterministic I would say configure it like this:
>> 1) If you write a profile to `platform_profile` and the backend supports
>> both DC and AC profiles make it the default profile for both.  This is
>> more like "backwards compatibility" mode
>> 2) If you write a profile to `platform_profile_dc` and the backend
>> supports both then don't do anything in `platform_profile_ac` and vice
>> versa.  Require a user to write both of them explicitly.
>>
>> That means you have a new state of "unset" for the profiles, but if you
>> don't include the state then I think it can lead to confusing behaviors
>> if userspace writes one vs the other first.
>>
> So I don't think any backend support is particularly needed. If a platform
> supports platform profiles, then having an AC vs DC mode doesn't need
> anything special - it's just switching modes.
> 
> On the Lenovo AMD platforms in the thinkpad_acpi driver this will
> trigger some extra niceness to use a separate set of profiles, but even
> for the platforms that don't have this it's still nice to auto-switch to
> (for example) a low-power mode when you unplug - and that doesn't need
> any extra support beyond just supporting platform profiles
> 

Oh - right good point.  It didn't occur to me that if you only have one 
set of profiles that you could still assign one of the profiles in that 
pool to AC and another to DC.

> I like the suggestion on updating both if platform_profile is update but
> I'm worried that it changes the current behaviour:
> 
> - on the Lenovo AMD profiles, the battery profile set are all lower
> power/performance than the plugged-in profiles (by design)
> - with the implicit setting of the dc mode we'd be changing the behavior
> so that when you unplug performance will drop.
> 
> This is (usually) a good thing, and is I think what Windows users get,

Yes that's correct.

> but it's not what currently happens on Linux. To get back to full power mode
> you'd have to disable the DC setting - which isn't particularly
> intuitive. It's why in this initial implementation I made the dc setting
> 'opt-in'....but maybe I'm being over cautious.

It might be jarring the first time, but it's the right behavior in my 
mind.  And if someone doesn't like it they can always just write 
something to the other sysfs file to avoid it.

The other thing is thinkpad_acpi AMD support is new.  Define how it 
works now!

I don't think it affects any other platform profile provider any 
differently.

> 
> Once user space has two sliders the whole point is moot - I suspect I'm
> overthinking this :)
> 
> Ack on the unset state - I'll add that.
> 
>>>
>>> If you read the platform_profile it will return the currently
>>> active profile.
>>> If you read the platform_profile_ac or platform_profile_dc node it
>>> will return the configured profile. This is something missing from
>>> the current implementation that I think is a nice bonus.
>>
>> Yeah nice bonus.  Some inline comments on this.
>>
>>>
>>> User space implementation could potentially be used to do the same
>>> idea, but having this available allows users to configure from
>>> cmdline or use scripts seemed valuable.
>>>
>>> Note - I'm aware that I still need to:
>>>    1) Update the API documentation file
>>>    2) Implement a disable/unconfigure on the profile_dc setting
>>> But I figured this was far enough along that it would be good to get
>>> comments.
>>
>> If backend doesn't support AC/DC I think you should return an error for
>> one of them rather than trying to hide the difference.  Think about
>> userspace - it might want to have say two sliders and hide one if one of
>> them isn't supported.
> 
> See above - I don't think there are cases where this wouldn't be
> supported. Let me know if I'm missing something

Yup you're right.

> 
>>
>>>
>>> Thanks in advance for any feedback.
>>>
>>> Signed-off-by: Mark Pearson <markpearson@lenovo.com>
>>> ---
>>>    drivers/acpi/platform_profile.c  | 130 +++++++++++++++++++++++++++++--
>>>    include/linux/platform_profile.h |   1 +
>>>    2 files changed, 125 insertions(+), 6 deletions(-)
>>>
> <snip<
>>> @@ -117,10 +227,14 @@ static ssize_t platform_profile_store(struct
>>> device *dev,
>>>      static DEVICE_ATTR_RO(platform_profile_choices);
>>>    static DEVICE_ATTR_RW(platform_profile);
>>> +static DEVICE_ATTR_RW(platform_profile_ac);
>>> +static DEVICE_ATTR_RW(platform_profile_dc);
>>
>> My opinion here is that if you are keeping the existing one in place to
>> show "current" active profile and make the new ones to show you
>> "selected" profile they should have a different naming convention.
>>
>> Some ideas:
>> - selected_*_profile
>> - platform_profile_policy_*
>> - *_policy
>>
>> Something else that comes to mind is you can rename "platform_profile"
>> as "active_profile" (but create a compatibility symlink back to
>> platform_profile), but I don't know that's really needed as long as it's
>> all well documented.
>>
> 
> I like the selected_*_profile - I'll go with that.
> I'm less enthusiastic about symlinks - just feels messy.
> 
> Thanks for the feedback - very much appreciated
> Mark

Sounds good, thanks.
