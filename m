Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB2F4DB668
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Mar 2022 17:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357414AbiCPQox (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Mar 2022 12:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357477AbiCPQow (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Mar 2022 12:44:52 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0833C2611B;
        Wed, 16 Mar 2022 09:43:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7quM+HD9CS2w+wABF45Z+W7jr6jRzFjYhYWFNKXkVogkaxw5zWI044rqqWvP7q29Q7kd3wG+MfP4hJy0lVGVZDCRyZofT6RTxmHWtnBGRbIJeVi0yxGsja1eAh2SJMskLLuzLA5Qv2H0kFf2E9y5YsxrFIzIxGpGJ4U/IltHkjlqULigEm5liylChP/U7KwXO4l1j1bZTaHasdy6nRml5EUnaQGvGUF5+tWvDzuFJXEchg8oxsV/ZQocm3hrTFWvOYaoWf74+ISLavDNf64dNSaN8QOebWuwm66SRgyumftHbXSOxDL6DF91J+H7VxWiUVnnTw2vyNcdK1N2L3yeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClPxBAiMcueFcHZRjmbEXSqnDlk0uKid3WE6Z9vLuJo=;
 b=Wb4NbLKlDzT3Iavv8K8Y31aENOlHgaom9Y9oxktFnUlVHbG1adIRWWPqSSsJxgbgJvky3p8aEzJ/YfwLemRYH+H38D587PlU9ZCtTFGMHXrOozXwgRuAs9Z3QqKxnQbSSgEsMKEbotiCzOGFHwndQ65ZWfKivR0MspoQGItsBnq3hH8QrG3EhYyPhKOcA1nIGa/A62cyRdZxUBj1ny0Xog2otCgVPu7D08OjTE7VbUuG6ucyHxYeotNeNOE/57qIwUo0wQ1fBiOiDB2mUnea9TwAbmY97f8A70Bqe3sCw4o3RwtYCFfTTI9zxUjX9sGH4WqTJ9+iBV1NuMphJtBSEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClPxBAiMcueFcHZRjmbEXSqnDlk0uKid3WE6Z9vLuJo=;
 b=CxjVQ3VCkp9cU9utjd0lK4vuqazVPS6sAqh7sfrlh4edVYfsRRIzH0obk6LDX/ed8kGJ6In+ehXh9NdJL/Hj/4HRbqS5YYqH3epq0lTntLADkNBtkEL7PajZWgp2aUUHlxAe7L/nn2jSdbpQIYnojLgCQ8/hszPHhC3tyN3kHoE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by PH0PR12MB5402.namprd12.prod.outlook.com (2603:10b6:510:ef::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 16:43:29 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 16:43:29 +0000
Message-ID: <29058b59-80f8-b29a-c54c-b58779c329e0@amd.com>
Date:   Wed, 16 Mar 2022 11:43:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 1/5] ACPI / x86: Add support for LPS0 callback handler
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Goswami, Sanket" <Sanket.Goswami@amd.com>
References: <20220314050340.1176-1-mario.limonciello@amd.com>
 <0101142d-3ea6-a47b-be26-76aaaac46b0a@redhat.com>
 <BL1PR12MB5157664C2AA7D80E7DF48EC9E20F9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <8841ecb6-6c2c-164f-76df-54c4410faa20@redhat.com>
 <CAJZ5v0gFzDAKHxDLf7Wq52fcGPx+jTWMqBb9oNWuqOSDJrgb1g@mail.gmail.com>
 <CAJZ5v0jArF+J7UnpAkF-qzS1EqVxuaf7UZYYQV7T_XR3T5tTHw@mail.gmail.com>
 <BL1PR12MB51571612A9594F5B759EDD81E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0jQKPS-jfRC17SOr_YS=MjZ7Fi62zDyOcgYT4GSzdg-sQ@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0jQKPS-jfRC17SOr_YS=MjZ7Fi62zDyOcgYT4GSzdg-sQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0307.namprd03.prod.outlook.com
 (2603:10b6:610:118::8) To BL1PR12MB5157.namprd12.prod.outlook.com
 (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 775ec1bb-fdc0-418e-7019-08da076c193a
X-MS-TrafficTypeDiagnostic: PH0PR12MB5402:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB540207D88A8F96D5BA6352D1E2119@PH0PR12MB5402.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X7k7ISP3sozMydYbHiPvHBHpCNTxryzt0ejBHqC6b0KlsXdhEtOc7J45rDjWEHCEa/kAe8KmOwaJT9tGLXn1uHd6KI+/a9LL8ofA28CnGW+5Wqbg/AOS/6jUIydUgZIGVhjIo7gDoHa1RAerXdbpJwNDyxPGv7TtYMFA07UcwTdlCkymCs/c6JdY7xnEyTUrhfqpz8LhqkC/fZwhEJg0b5DGuQGSw4m8J3xcm2ztNBOREKRHB5XSfKPKeMJZWyJypitxV9QAFlK9iEgTAfyO6oTN2WN7x9e8qon77OsgHZACK6wPMHCA5EXb0EO0IFPMF2x7zYEpkYhElDZZJj0IMb6K3rWUHbCpyRuYtBBQunWT0Y1jMPAmGg/QgGV4A6It1tRgExjuiVDRDjDzh1AFeC6tMIogCI1Dy8KGO+Cv5ZPPdVdqWSw7b+bDSw04cXSmdhHGVFDJJJjeUAVqCIsLmZYg/zFYCG0ztTlzFgwXqiAHkQfIEtUN21yx/czQBlz0C98IO2Ct2W0b7ipOFaf3PuqKPgxT/pnoqiDbB2HOarfHMVhm71KOwQ5sqLy5NZtsshXyOSaIDF+5CmBVMn4luDbVcizMS5aW4KPXGIT5VdNFONtddU9L4cd5J/VT94dVgtzP7SdyYhbc+H6jGHnND7tdECadWduDuQMluxrze3ORsgIt5RVuGoiafkh8ABO25IM2Up1Y96q4pVty5Wcv44c/qdl5dUzYtnXN5/r3jTn1LqHiIOVubugdmaLp5Sv6YJBenheqrI+x1fYKGUAypmc6OXMSr7f3CV741Ez5XuwesomWt0GfQ4i1dvY9cQ97pV1FOl6EhLLlYwC/M3KN9NnOtdw27Kjg58o8Sr7pIGBEW8uZu4gr78vGFtXeiH63
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(31686004)(8936002)(966005)(6486002)(316002)(6916009)(36756003)(6512007)(6506007)(5660300002)(6666004)(2906002)(54906003)(66556008)(66476007)(66946007)(8676002)(186003)(26005)(4326008)(83380400001)(31696002)(86362001)(38100700002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vnp2MWQzdEtWMTdCejh2QXpKZW1rbVIzZlFBWkRzbmtPWmxLd3dTajY1c3g5?=
 =?utf-8?B?d1BTbmUrelV2VFZORXZkMDROc2ZTeDhsNG9lRXlXa2ZxcmdpNk1BN24xSjNi?=
 =?utf-8?B?N09oNzlWZ0NlSlNsWmhtSWxmZlNPc1p3Nm5pWVdtK2ZmRzcvNTZWUGozVDZ3?=
 =?utf-8?B?TTMyUS8xMEpQRG1idDZxTUlramJPMEpkMksycmNXVk93bXlEcHFtTG9qdzBM?=
 =?utf-8?B?bFNqVjNvUWVFK0VQZVo1VGkvaXZteE9DZXc3WnowMTl5VWJWakJ4RDZKZjBn?=
 =?utf-8?B?UDNlZ291WU92elp1cTBCVWhlR1VUUGo4MHc1ZHlMdkNITS93eFNxaGJuS3NZ?=
 =?utf-8?B?TlBIVzZHSHRzdG9WbS9pY3pEbGgxY3BkTFdnUU9rMWJHcWwvcS9wL1QvNWhD?=
 =?utf-8?B?d3ZoM0s2Wm04MCtIQitOenZBWWd6K2Jmd2c4YnlWa3NoajZmWGlKSTFVUzhu?=
 =?utf-8?B?YjVyUlcvOEsrZGdKNXRvRmxNaUM3N2R2SWxZVjAxTXhqRmljZFY0R2dPQTd2?=
 =?utf-8?B?S01RWE9KS1FGNDNOMklVQ2dkZVNjY2FpMXl4ZkI1RldOVGE0QTlRSlFKRVdm?=
 =?utf-8?B?SFcvbjU3Y1RVdjNXZEVTUlJ0R0VvVTlnWDBRWjU4R3ZRbFFaMzRnRXpNYmlJ?=
 =?utf-8?B?cWtKNElFSS8wS0Y0aG5ORXFJQlFDUHZ6RHJGd011cjdIVzdONEJIb2FWNWZZ?=
 =?utf-8?B?elFsSUF2Uit5cDcvaEpKc1F0bTJZZXR0aHJ4SHFabnkxa3FKWUdvSTZYa3Bn?=
 =?utf-8?B?MzIwY1lTcmx1SUp4ZFNHS0l0L1BTT28zUzhSdU00RmFtdkFyaVJ3R3RmenNx?=
 =?utf-8?B?bDhVTUczMnVVTXBnWlRwVVpCZ2F4ZkplK05GcFB6YndjWnJmQ01zV3FKZE9k?=
 =?utf-8?B?T3ZsK2grVmFHZXhFSldKak5XNzlXSy9NWkdmZTMzeVFCdGlRTzlpa1lYT0hk?=
 =?utf-8?B?T0tMdWM1UEZJaFh2ckhybjNyQVBkV0sxVFFydGNTMitBM3E3VUtGcjREMVNX?=
 =?utf-8?B?T2VaNFNsZ3VyeWFFWkFRRHJjVkdYRlVoSDVSZlVRNnpFcWZTVXQ4L1dHSndZ?=
 =?utf-8?B?TzRxK1QzRitJb2YxQUxIaHJ6elZxbVZjWFJVWXdwc29uUHpQR1JZUVp0ZDFt?=
 =?utf-8?B?S3lhK1gxU1lKZzJmcU5nZU1NTlRxWlJRRncvU3ZiamlOZEIxQXI2ckkyNzYw?=
 =?utf-8?B?aHNuNUlFa0krTkw4RVhOU1JkeGlqR3dZTEdoek5oUEdNL0lESTIraCs3VE1R?=
 =?utf-8?B?VUwwV01BMzdBeDdKdnpWNGhhQWU4Ui85NGp0YUk0N2V1UGFaZklFdU9jMTVM?=
 =?utf-8?B?Y1BXeUVPbW1lcGdzbE5BSHMycFNzbTB4ZHB1MnBEelZQZ2RsdzJMT3Njc3lL?=
 =?utf-8?B?SzN3NVlMeFArak8xanh2ZGptZ2pYdFdIOHdnSjhsb0JZZm51Yk5Oenozcmh2?=
 =?utf-8?B?RzhodG8yL2dEYmtLT0FURHRwNTNaRnBvTDlFM205eXBCblB2TVRtY29kOUd1?=
 =?utf-8?B?M2l2dnJXNml6TGJKN1MyVjBsZVlKa0xzbGlwdHZRZkxrT2V6aExCdlZuQkpj?=
 =?utf-8?B?NXIrYitTYkFlOGlxaFJhb1pUeWFRNXo5OUtzaVIrUnYvSzV1Z1F6VzdpRWVu?=
 =?utf-8?B?TzBaUjhET0Q1dDdRT2F1SlloYU5LeVZ5Y2kxOFlEMHg1RUttRDNxS3V1aVdD?=
 =?utf-8?B?VWRpWW1wSDBvdEtkend4STMyenhrQlBiOE9oRElQdi80bXdXSUZhbklVQ3Vv?=
 =?utf-8?B?amxGYWp0ZzdiN3RaT2Y4Vlk5SWJDb3JzQXd5QXo4UlM5R0VSTlgrclhXYWoy?=
 =?utf-8?B?dENjM0RheEtFQVk5bFFCenQ3RWkrb0U0L2JwR3BMRmMvS1gyV0ZrVXZaNXJt?=
 =?utf-8?B?Rkh2WnRJdS9Ea1NNS1laUWtjR2RnZFVvangxdEI5R09iYzd1L3U4UWREMXgy?=
 =?utf-8?Q?sKvDZgv3+uSalGytbyEvHGw8QsY0JADe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 775ec1bb-fdc0-418e-7019-08da076c193a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 16:43:28.9356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hGRKC8rBC7TX1/hWVR7BGO44UTB+BBl1bMjpv0E5tAcfcgsYA8xSN3lBGa5owj3/FGXw6hd5gM5iwVx23YI50A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5402
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

>>>> My preference at this point would be to use a notifier chain, unless
>>>> that's not sufficient for some reason, because it appears to match the
>>>> notifier usage model.
>>>
>>> Well, I'm actually not sure about that.
>>>
>>>>> I pointed this out, because making this change would also make 4/5 a bit
>>>>> cleaner. You are recreating the same struct lps0_callback_handler on
>>>>> stack twice there, which looked weird to me.
>>>>>
>>>>> Note if Rafael wants to stick with the approach from this v3, then
>>>>> I guess that the approach in 4/5 is fine.
>>>>>> Rafael - can you please confirm which direction you want to see here
>>> for this?
>>>
>>> So the idea is that the PMC driver's "suspend" method needs to be
>>> invoked from acpi_s2idle_prepare_late(), so it doesn't interfere with
>>> the suspend of the other devices in the system and so it can take the
>>> constraints into account.
>>
>> The reason to do nothing (besides a debug level message right now) with the constraints
>> information is that at least on today's OEM platforms there are some instances constraints
>> aren't met on Linux that need to be investigated and root caused.  These particular constraints
>> don't actually cause problems reaching s0ix residency though.
> 
> Why are they useful at all, then?
> 
>>>
>>> What is it going to do, in the future, depending on whether or not the
>>> constraints are met?
>>
>> The idea was that if constraints were met that it would send the OS_HINT as part of
>> amd_pmc_suspend/amd_pmc_resume, and if they aren't met then skip this step.
>>
>> It would effectively block the system from getting s0ix residency unless the constraints
>> are all met.
> 
> Why do that?

I guess to both of your above questions this begs a comparison of how 
things work in Windows versus Linux.

Windows Modern Standby has this concept of "SW DRIPS" vs "HW DRIPS". 
 From an end user perspective you close your lid or you click Start 
button and hit sleep and the machine is in sleep.  Whether it's in the 
deepest state is "invisible" to you unless you're running a sleep study.

Windows will at this time requests devices to go into their deepest 
states and will continue to monitor them against the constraints table.
When the constraints table is matched a uPEP driver is notified (this is 
the _DSM stuff we have in Linux too for "deepest state") and then it can 
do as it pleases.   ON AMD's platform this sends OS_HINT.  OS_HINT is 
meant to be indicate that the OS is done with all it's suspend actions 
(caches flushed, devices in D3 etc) and the system can "try" to enter s0ix.

Windows will then also distinguish between different types of wakeups 
and have different behaviors for them.   There are wakeups that can be 
treated as keep screen off, and then possibly go back into deepest state.

"As soon as the SoC wakes and the platform exits the DRIPS state, the 
CPUs start running code again. However, the screen stays powered off 
unless the interrupt was a result of user input or connecting to a power 
source"
https://docs.microsoft.com/en-us/windows-hardware/design/device-experiences/transitioning-between-idle-and-active-states

"During the Sleep state, specific value-adding SW activity may run"
https://docs.microsoft.com/en-us/windows-hardware/design/device-experiences/modern-standby-states

So from the time that I clicked sleep in the OS, I might NOT get into 
the deepest state (HW DRIPS), or I might have gotten in and out several 
times.  If a device driver failed to put a PCI device in D3 for example 
I would not be able to enter HW DRIPS, but the suspend wouldn't "fail".

Now to contrast this to Linux when I enter suspend all drivers will run 
their various PM callbacks and devices will go into their deepest states.
* If a driver fails, the suspend actually fails and you get an error 
code to go investigate what happened.
* If the devices don't get into their deepest state by the time you get 
to the s2idle loop you don't get s0ix residency.

As you can see at least for AMD's platforms OS_HINT is sent too "early". 
  That's why this series exists in the first place.

So with all that said; why look at constraints at all if stuff is working?
 From this design at least on Windows constraints are supposed to be a 
safety guard that you don't start the HW process for s0i3 process "too 
early".

The last commit that is getting reverted in this series is an example of 
what could happen if the process is started prematurely.

> 
>> Given we know some OEM platforms have problems in current generations
>> with constraints it would probably need to be restricted to this behavior only on a future
>> SOC that we are confident of all drivers and firmware are doing the right thing.
>>
>> By passing the information to amd_pmc we can keep that logic restricting the behavior to
>> only those platforms that we're confident on that behavior.
> 
> Honestly, I'm not quite sure why it is a good idea to prevent the
> platform from attempting to get into S0ix via suspend-to-idle in any
> case.
> 
> You know you have to suspend.  You don't know how much time you will
> be suspended.  The constraints can only tell you what's the
> lowest-power state you can achieve at this point, but why is it
> relevant?

Having thought through and said all I did above, I do concede you're 
right with the Linux approach to sleep the constraints really don't add 
a lot of value.  If a device fails to enter it's intended sleep states 
the suspend will "fail".  If the suspend succeeds but the constraints 
table doesn't match, it's just a hint where to focus on problems.

I appreciate your thoughts and I will drop the constraints passing patch 
in this series.

With that intent of dropping that would you still like this reworked as 
a notifier chain or keep it as this design?
