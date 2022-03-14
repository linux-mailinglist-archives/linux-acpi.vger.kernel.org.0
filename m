Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E544D881A
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Mar 2022 16:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240636AbiCNPdf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Mar 2022 11:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiCNPdf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Mar 2022 11:33:35 -0400
Received: from mail1.bemta35.messagelabs.com (mail1.bemta35.messagelabs.com [67.219.250.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1EC36B66;
        Mon, 14 Mar 2022 08:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1647271944; i=@lenovo.com;
        bh=GuBxLnLVDfvM7NSq51YwmrO7KAstGY9OGF/75cnjBTw=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=MzrxMo2ko70Uh80MVlJgAWnAqtVyPIAauNBZAbjfjEAiZPxcBNTZ6mf6LF3mtqHQe
         e19ZSAAMFiMapAqZPjdEbs2p2Q6j+x2M06NlHv2snFJ+P7FlcBnQBv/I5ZzgbdS9Pg
         k902tf9s2r68MsiHlj20nLPWih4tX2jfJmgoD06fmePCxckoH0RVGhY6D0ZFt8Aw2V
         pmXJEIkZVSloKs/YXKj0GyeDM3pp3FGd41rIWbH3OdQCcVM4o/VpzakeF8O/zO4Q26
         82yLv9oGi6vd6tnhEiedmyJYaKAA7G3PUgCpl/dBXwlC5u6Urx1LplkbkyAbXXnAMc
         uL3Zywnhx/puQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOJsWRWlGSWpSXmKPExsWSoS+VocueoJ9
  ksOultcWb49OZLJbv62e0WLx+GaPF6j0vmC3mfpnK7MDq0XrpL5vHplWdbB7v911l8/i8SS6A
  JYo1My8pvyKBNeP6ymdsBb3SFavPn2NpYJwh1sXIxcEosJRZ4uCJXjYIZxGrxKdb86CcTiaJR
  d0zgRxODiGB+UwS10+rgCSEBA4zSfz/2coIkpAQOM4o0b3KHSLRySixe+sPNghnElD7reNQzh
  NGiVW/piE4v67+YQbp5xWwldjx9BsriM0ioCrxec0sJoi4oMTJmU9YQGxRgXCJ+88+gx0iLBA
  qcW3vDzCbWUBc4taT+WD1IgJREj/mPmAHWcAssBXojilroLatZ5Vo2L8MrIpNQFtiy5ZfQAkO
  Dk4BO4muaTUQgzQlWrf/Zoew5SW2v53DDPG1ssSv/vPMEI8qSqx4vYUNwk6QaJ5yFBoAkhLXb
  l5gh7BlJY6encMCMl5CwFdi0jomiLCuxJ6JJ6DsHIk5HTOhRspJnOo9xzSBUXcWkpdnIXltFp
  LrZiG5bgEjyypG66SizPSMktzEzBxdQwMDXUNDEzBtaqGXWKWbqFdarFueWlyia6SXWF6sl1p
  crFdcmZuck6KXl1qyiRGYrlKKUqx2ME7q/6l3iFGSg0lJlNeKST9JiC8pP6UyI7E4I76oNCe1
  +BCjDAeHkgQvfzxQTrAoNT21Ii0zB5g6YdISHDxKIrz2MUBp3uKCxNzizHSI1ClGS44r2/buZ
  eZ4cOIkkLy2fsE+ZiGWvPy8VClx3ktxQA0CIA0ZpXlw42Dp/RKjrJQwLyMDA4MQT0FqUW5mCa
  r8K0ZxDkYlYV5OkKt4MvNK4La+AjqICeigedJ6IAeVJCKkpBqYZrUXNhnpOJ3YNKO36mt17++
  1MTkSUSecllcvcJRg4MkXCemb5lNrt3bir+Yjyv0HF25tq5/3IfeecfsLfV5bF/4vyYbW0dvW
  HT4exfZoXXaf6IO5FRfXcZbst5spIzx3zqvIbaKFF3u6Jwosb2yYPCEz5r3fNcNHBleZDvuW2
  izjYGS4VcEloOl2dPHnK65ZTU0eD2SK/OZtVtpW/nbTCp+wqcahnzvYdv0yYw9eM8uM99iOGc
  fa/1ex7NlzSufL0/3+1quWBf8x2c+w/f9e3SKtzaqqORN/TWx1y9624fLOhebZ60IUmnSfCx8
  MUdr3uWz1g582tsvvBej9vlpekMj3fI7Pxtkf+cM5oxYLKbEUZyQaajEXFScCADIvlvtqBAAA
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-31.tower-655.messagelabs.com!1647271942!15420!1
X-Originating-IP: [104.47.26.104]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.9; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 3537 invoked from network); 14 Mar 2022 15:32:23 -0000
Received: from mail-sgaapc01lp2104.outbound.protection.outlook.com (HELO APC01-SG2-obe.outbound.protection.outlook.com) (104.47.26.104)
  by server-31.tower-655.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 14 Mar 2022 15:32:23 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKfIM/Co9uLToLn79qMzLR9eTqnrQktk9pKygI2dF6malv08uAjYohryn7+a45iwR5/0zPCzg1CvI6UGsaiX9CYy6lZRQiHcPsH97n7PD4R+xSKq2wnd7JrN3c6nPhpxh8JYl3GiHpp9bPAQjb2r7+oOP09K9s44P4PrsK2fuTTC1PlkQ8sHPw9Pc+YthCggZ5lc4jXRtKWV3TobkPHiBN4os+LK27AmThI71sH+o08YpTUVkOOjWbrjx2J6onVO7QtQ/y4GAG38O7I99BlgF1+otTbITbotgeggpY9+uIPEGQneYe7hmlz9PRskhjRjy765bNWxqKl0CdUjFrLrXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuBxLnLVDfvM7NSq51YwmrO7KAstGY9OGF/75cnjBTw=;
 b=HiqOBNK9VildaobK/2yyliyUQA9d5ymOZX6uHMfOGBH3WVGixEpJGCAFvIm4uNGxybp/zk/NIHljvtdVxVf9c0Z2nA9WUHw4swGbOoCpuyn1MgPY2ml/JjA3lcEkWe+O+3tCKGPxwMJmLbT4oMiNdKkCtBx7rU88gUfI5trHrvEhjOVPx3hnrDUawwq2xID6UgEFF+yKjl0ksX4Y/FDu3wsmSGiEfLrbru3S1Po0Og3Yx1YLiXG+wI3kNlymNDCOjIp7zjj/CbRSpy31MB3JxvLX+e0dGRGHBakIz1k7sjfuFLGv4EQCCLyVigmB7m89aJLT0BKtGPP+AZ39o4nCSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.232.225.6) smtp.rcpttodomain=redhat.com smtp.mailfrom=lenovo.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=lenovo.com;
 dkim=none (message not signed); arc=none
Received: from HK2PR03CA0064.apcprd03.prod.outlook.com (2603:1096:202:17::34)
 by SL2PR03MB4619.apcprd03.prod.outlook.com (2603:1096:100:64::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.10; Mon, 14 Mar
 2022 15:32:20 +0000
Received: from HK2APC01FT010.eop-APC01.prod.protection.outlook.com
 (2603:1096:202:17:cafe::2d) by HK2PR03CA0064.outlook.office365.com
 (2603:1096:202:17::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.13 via Frontend
 Transport; Mon, 14 Mar 2022 15:32:21 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.232.225.6) smtp.mailfrom=lenovo.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=lenovo.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 lenovo.com discourages use of 104.232.225.6 as permitted sender)
Received: from mail.lenovo.com (104.232.225.6) by
 HK2APC01FT010.mail.protection.outlook.com (10.152.248.157) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.22 via Frontend Transport; Mon, 14 Mar 2022 15:32:20 +0000
Received: from reswpmail01.lenovo.com (10.62.32.20) by mail.lenovo.com
 (10.62.123.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.21; Mon, 14 Mar
 2022 11:32:16 -0400
Received: from [10.38.111.194] (10.38.111.194) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.21; Mon, 14 Mar
 2022 11:32:16 -0400
Message-ID: <49205849-4239-3558-f377-797e7561848e@lenovo.com>
Date:   Mon, 14 Mar 2022 11:32:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [External] Re: [RFC] ACPI: platform-profile: support for AC vs DC
 modes
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
References: <markpearson@lenovo.com>
 <20220301201554.4417-1-markpearson@lenovo.com>
 <65d8cf3b-0eea-0583-fa23-e2c71287fb85@redhat.com>
 <BL1PR12MB5157CDB77675859B7F279578E2099@BL1PR12MB5157.namprd12.prod.outlook.com>
 <7b281a37-5163-6cd7-360e-1c63bde714a8@redhat.com>
 <BL1PR12MB5157125246817A70649C12F7E2099@BL1PR12MB5157.namprd12.prod.outlook.com>
 <1cd4ae24-ae92-302e-ac87-76ef15472a9f@redhat.com>
 <2180533b-c921-5ae4-e6bc-569728a4f990@lenovo.com>
 <c18abb55-6874-6e1e-bdb0-9d96d52987cd@redhat.com>
 <BL1PR12MB5157C14DE5F521D4B5C08366E20F9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <c16ea8ba-5944-0384-4bc3-d5438fe5e1f7@redhat.com>
 <78fc0363-2ae6-bd75-ecfb-606ce411c79a@redhat.com>
From:   Mark Pearson <markpearson@lenovo.com>
In-Reply-To: <78fc0363-2ae6-bd75-ecfb-606ce411c79a@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.38.111.194]
X-ClientProxiedBy: reswpmail01.lenovo.com (10.62.32.20) To
 reswpmail01.lenovo.com (10.62.32.20)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccab5b7a-df1a-4825-da39-08da05cfd4aa
X-MS-TrafficTypeDiagnostic: SL2PR03MB4619:EE_
X-Microsoft-Antispam-PRVS: <SL2PR03MB46193B76034EDCC258F6A5EEC50F9@SL2PR03MB4619.apcprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9BuXvMRbAoRXWUbTn3pvqbiiqsV7VT4Sblwh8lEhnJQgj5bG7JqDLUN3HwzWj3uGcnMm3IwLY+zVEDgZrDtfFPgH3Mi83TF3V1K6EJLIyBdWYooIIYJNraylkABqHRzw83j0MiaOakVtkoDoGr/8wdN3Cd5LGZrBRBZ0gp4JJ0nAMfOgMxYRsbMlkzq6dERbndQ6zQqbUNDbvmUc1A/kprBSRnnDVVEv+n94HM+Hr2CjmvNZ2ZyB2URzQvUbHhR+FeUmKaJkpYvP1gVex/I8lllKKKtbb6XBMLDyhmQqnPI4ixwK/gbaAqJRG91JHglEca8bQoVLyIeBXvt6qLOqGvctGGyog13L0lSPNCMIV32KAM7gUP08ihK56B1CoRnnFPulVKX+XZ4EWiO6aZW3IW+qDLfWevX1Hs7x0ipVkgb/RQTfqid7wOGbA/5HqqEK/gM+Jjghw5cfvM1lTghWbNnazhkZGqnSvFPZiCH8AyPChxJiwy/DU1Qt3C+V6ND3qwsqI6mOVIZLnnnyzBETHl8qn5Qs/JFtzJ7FHTzuKYzFa27FYNlWYsw8bp7UbRyCxHckU/bDUPZi+CE0VJnc+coa1JitECWUHsgx4Wl3nvHXNnmSRLSrgmupCHB/JX0kRG/Egy3JDu1eklZ98Hw+MarH6pTe71z9E8ROK/UF6tofT11Y33o7IMKosJhICtprSemKegXLsrZILPEE/XySPs5GTGeu51VxpQyMBF/Po/XcPNzxm8Xu69psTeM0bgDFbK3a5PC4oxMqDhdD0cm+fg==
X-Forefront-Antispam-Report: CIP:104.232.225.6;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.lenovo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(47076005)(40460700003)(26005)(31696002)(36860700001)(426003)(336012)(86362001)(508600001)(36756003)(31686004)(83380400001)(5660300002)(4326008)(36906005)(54906003)(110136005)(16576012)(70206006)(16526019)(82960400001)(82310400004)(8676002)(316002)(356005)(53546011)(81166007)(70586007)(2906002)(8936002)(186003)(2616005)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1102;
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 15:32:20.5370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccab5b7a-df1a-4825-da39-08da05cfd4aa
X-MS-Exchange-CrossTenant-Id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5c7d0b28-bdf8-410c-aa93-4df372b16203;Ip=[104.232.225.6];Helo=[mail.lenovo.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2APC01FT010.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR03MB4619
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 2022-03-14 11:31, Hans de Goede wrote:
> Hi,
> 
> On 3/14/22 15:43, Hans de Goede wrote:
>> Hi Mario,
>>
>> On 3/14/22 14:39, Limonciello, Mario wrote:
>>> [Public]
>>>
>>>>>
>>>>> I cycled through a few different implementations but came down on what I
>>>>> proposed. I considered 6 values - but I don't think that makes sense and
>>>>> makes it overall more complicated than it needs to be and less flexible.
>>>>
>>>> Ah, so to be clear, my 2 scenarios above were theoretical scenarios,
>>>> because I'm wondering how the firmware API here actually looks like,
>>>> something which so far is not really clear to me.
>>>>
>>>> When you say that you considered using 6 values, then I guess that
>>>> the firmware API actually offers 6 values which we can write to a single slot:
>>>> ac-low-power,dc-lowpower,ac-balanced,dc-balanced,ac-performance,dc-
>>>> performance
>>>>
>>>> ?
>>>>
>>>> But that is not what the RFC patch that started this thread shows at all,
>>>> the API to the driver is totally unchanged and does not get passed
>>>> any info on ac/dc selection ?  So it seems to me that the ACPI API Linux
>>>> uses for this writes only 1 of 3 values to a single slot and the EC automatically
>>>> switches between say ac-balanced and dc-balanced internally.
>>>>
>>>> IOW there really being 2 differently tuned balance-profiles is not visible to
>>>> the OS at all, this is handled internally inside the EC, correct ?
>>>>
>>>
>>> No - on Lenovo's platform there are 6 different profiles that can be selected
>>> from the kernel driver.  3 are intended for use on battery, 3 are intended for
>>> use on AC.
>>
>> Ah, I already got that feeling from the rest of the thread, so I reread
>> Mark's RFC again before posting my reply today and the RFC looked like
>> the same 3 profiles were being set and the only functionality added
>> was auto profile switching when changing between AC/battery.
>>
>> Thank you for clarifying this. Having 6 different stories
>> indeed is a very different story.
>>
>>>> Otherwise I would expect the kernel internal driver API to also change and
>>>> to also see a matching thinkpad_acpi patch in the RFC series?
>>>
>>> The idea I see from Mark's thread was to send out RFC change for the platform profile
>>> and based on the direction try to implement the thinkpad-acpi change after that.
>>>
>>> Because of the confusion @Mark I think you should send out an RFC v2 with thinkpad acpi
>>> modeled on top of this the way that you want.
>>
>> I fully agree and since you introduce the concept of being on AC/battery to the
>> drivers/acpi/platform_profile.c cpde, please change the 
>> profile_set and profile_get function prototypes in struct platform_profile_handler
>> to also take a "bool on_battery" extra argument and use that in the thinkpad
>> driver to select either the ac or the battery tuned low/balanced/performance 
>> profile.
>>
>> And please also include an update to Documentation/ABI/testing/sysfs-platform_profile
>> in the next RFC.
>>
>> Also notice how I've tried to consistently use AC/battery in my last reply,
>> DC really is not a good term for "on battery". AC also is sort of dubious
>> for "connected to an external power-supply" but its use for that is sorta
>> common and it is nice and short.
> 
> One last request for the v2 RFC, please also Cc Bastien Nocera, so that
> he can take a look at the proposed uapi changes from the userspace side
> of things.
> 
Ack - will do.
Thanks!
Mark
