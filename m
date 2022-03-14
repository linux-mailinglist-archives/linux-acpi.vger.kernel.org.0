Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8204C4D8A98
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Mar 2022 18:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241893AbiCNROw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Mar 2022 13:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243215AbiCNROt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Mar 2022 13:14:49 -0400
Received: from mail1.bemta31.messagelabs.com (mail1.bemta31.messagelabs.com [67.219.246.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5788C2A263;
        Mon, 14 Mar 2022 10:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1647278011; i=@lenovo.com;
        bh=4D2gqOUwFj/Sa6b20fcWQkeJvZObv6J/QObeSSZRZfA=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=XeMMTgu0/aZXY5igtwDMPkDUOyHkfg/DWwLyKib+Kju17uBuZv4kCa+bQlIDF78UT
         Gusxd4s3O/m5w3hwDR7LjnoI5s1luv4zMz6aZRMKLEtO8GtQPOZwotnleIcx/Oan4G
         YTT6EU+mT20XJ6+nk/3Uz+0XHuDITAH1fTO+gSJ3w4EypusLHG5I2ezj02qcBSaEcc
         mS5RjxWeskUBv8us8V62IsYFQiQFImmNFGtM0FApZ6P3x5JjRGEbTYYSWoOBTg3VfX
         vqqPAeRwJKfOANYWAz4I00PViuoFU2jphI1JiDq4WW07K3P78wRdm9k3TfdHWm+58l
         svSuQzi7pGp8w==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBJsWRWlGSWpSXmKPExsWSoS+Vq7urXD/
  J4NZLS4s3x6czWSzf189osXj9MkaL1XteMFvM/TKV2YHVo/XSXzaPTas62Tze77vK5vF5k1wA
  SxRrZl5SfkUCa8bdb7fZC64pV/xf8JW5gXGabBcjFwejwFJmibcTljJBOItYJab++cEC4XQyS
  Uyed48dxBESmM8ksWrRalYI5xCTxILWFrAeCYHjjBLdh9YxQWQ6GSV+vDrFAuFMYpL43n2MEc
  J5wijR2DAFwVlwajGQw8HBK2ArcXGLehcjJweLgKrE8/WrGUFsXgFBiZMzn7CA2KIC4RL3n31
  mA7GFBUIlru39AWYzC4hL3HoynwnEFhGIkvgx9wHYtcwCWxkldk9ZwwaxbCqbxNc7s8Cmsglo
  S2zZ8gusm1PATuLBrS3sEJM0JVq3/4ay5SW2v53DDGILCShL/Oo/D2ZLCChKrHi9hQ3CTpBon
  nKUEcKWlLh28wI7hC0rcfTsHBYI21fix6WlrCBPSgjoSpy/6wARzpGY0fYBqlxO4lTvOaYJjL
  qzkPw8C8lvs5BcNwvJdQsYWVYxWiUVZaZnlOQmZuboGhoY6Boamuia6xqam+klVukm6pUW66Y
  mFpfoGuollhfrpRYX6xVX5ibnpOjlpZZsYgQmrJQi9g07GOf1/NQ7xCjJwaQkyrsgVT9JiC8p
  P6UyI7E4I76oNCe1+BCjDAeHkgSvfylQTrAoNT21Ii0zB5g8YdISHDxKIrxeZUBp3uKCxNziz
  HSI1ClGS44r2/buZeZ4cOIkkLy2fsE+ZiGWvPy8VClx3psg8wRAGjJK8+DGwRL8JUZZKWFeRg
  YGBiGegtSi3MwSVPlXjOIcjErCvFdApvBk5pXAbX0FdBAT0EHzpPVADipJREhJNTDpS06TX6J
  /faOs3NeD7GcWHTmpfe+ZoWrMqcNb5Y8sWln/di337h/ZlxwNDCqUxArKmFe80vbSO169+N6n
  18qzj12+oW4oYKK8w+yXxJraPr7IB0YOtzWEIndLf3JcZem14qjzjS5158SzL47eXpi+trr6W
  fDsw9KJN0IkOmRSzm8oVF4/c9JhEbc4wYQjWXHHFHWebn3kVfKYK+2v8S/ulWoP1H5mM/a/td
  P18Jnwet1yxq//UhjE5R3K7C/WT18YYh15y29C+fxFLRdsFANtk3MFJGssU/fUKxaeiD0TGBV
  deq507n+WPV7dBycmuj+6MuuA+u5QiTs7L126VfRdvuX/kpAdfw0nF7/i/aCnxFKckWioxVxU
  nAgAfn1/lmsEAAA=
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-2.tower-686.messagelabs.com!1647278009!35225!1
X-Originating-IP: [104.47.26.109]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.9; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5128 invoked from network); 14 Mar 2022 17:13:30 -0000
Received: from mail-sgaapc01lp2109.outbound.protection.outlook.com (HELO APC01-SG2-obe.outbound.protection.outlook.com) (104.47.26.109)
  by server-2.tower-686.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 14 Mar 2022 17:13:30 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O31xrHnpJ50+xiT5ALSeXXE6hpEw0YbklaZXuZQ1hfUZcZ7DSaa+MFvA5/HARykkrYRR3P067aymkIm2fXugXq1UsZwSHcEpTmDrcSuLZI9AQ9q2uP/5xSok+VPSoqvfLn4cMjRonOTEoo1S7+aU9Bm/wxbeY78S8yG3bpuKNU/2++Fj9llT8JvRV+6WhKc5RacR9yvdO+WpaRSppxElxkEVGRRSV5G1Y3P89fwgiS7MJwC3m283hhPA5njnnNEFiQ3llWTXt7N/SQUU3RIT25xlSHwddAzK22BYBraLxNsKbXyyP8t7F4oddHNyCcfNVScVkEDv2M7rXOc8D5AYDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4D2gqOUwFj/Sa6b20fcWQkeJvZObv6J/QObeSSZRZfA=;
 b=UDqhYOMjwG8KBE1zFdvqMqlkDElwArqo/5Kv6USh+j9LKH1YPqV1FIDM6PvH5pB0ZpNKVrljYHBFjNhImOHyR79hQf8ud4pVTOLdEO50RN3uSrfj4m9IdOM1XeaN6pfRoHrVwGV5CHunbREyiVpisie45+2Wc5E0TM+HGi0UugzRrMaB7Ygft2e3qBLv0e+MANdm9JJ0Z01QrIh6uwoQ+m02GIAWhomD3IRCNHzyE+YOr68SGqXDqILioxFCaki0GJMghdXbsxkpzxHztrMJZdAWV2r22Exd/wlX+p9OiuobjhML7O4lCnfEjp4pUX8wR7mdWooiSdY242zc7//qOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.232.225.7) smtp.rcpttodomain=redhat.com smtp.mailfrom=lenovo.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=lenovo.com;
 dkim=none (message not signed); arc=none
Received: from PS2PR03CA0024.apcprd03.prod.outlook.com (2603:1096:300:5b::36)
 by TY2PR03MB4496.apcprd03.prod.outlook.com (2603:1096:404:f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.13; Mon, 14 Mar
 2022 17:13:27 +0000
Received: from HK2APC01FT060.eop-APC01.prod.protection.outlook.com
 (2603:1096:300:5b:cafe::b9) by PS2PR03CA0024.outlook.office365.com
 (2603:1096:300:5b::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.7 via Frontend
 Transport; Mon, 14 Mar 2022 17:13:27 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.232.225.7) smtp.mailfrom=lenovo.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=lenovo.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 lenovo.com discourages use of 104.232.225.7 as permitted sender)
Received: from mail.lenovo.com (104.232.225.7) by
 HK2APC01FT060.mail.protection.outlook.com (10.152.249.160) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.22 via Frontend Transport; Mon, 14 Mar 2022 17:13:26 +0000
Received: from reswpmail01.lenovo.com (10.62.32.20) by mail.lenovo.com
 (10.62.123.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.21; Mon, 14 Mar
 2022 13:13:22 -0400
Received: from [10.38.111.194] (10.38.111.194) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.21; Mon, 14 Mar
 2022 13:13:22 -0400
Message-ID: <e923c8d8-477c-a71e-f30b-9db1f1f0cdc1@lenovo.com>
Date:   Mon, 14 Mar 2022 13:13:21 -0400
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
 <49205849-4239-3558-f377-797e7561848e@lenovo.com>
 <f0d069d0-40c7-b875-0f24-d3a89451d272@redhat.com>
From:   Mark Pearson <markpearson@lenovo.com>
In-Reply-To: <f0d069d0-40c7-b875-0f24-d3a89451d272@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.38.111.194]
X-ClientProxiedBy: reswpmail01.lenovo.com (10.62.32.20) To
 reswpmail01.lenovo.com (10.62.32.20)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50d2c501-df28-4137-b1ee-08da05ddf436
X-MS-TrafficTypeDiagnostic: TY2PR03MB4496:EE_
X-Microsoft-Antispam-PRVS: <TY2PR03MB449628C297EA5A98353E03CBC50F9@TY2PR03MB4496.apcprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: objtw/N2X/aORjvnIJioCk7WTHuXfB/Y7iBQjGNvzLwi7JPXvTCgTegY2bl8r/Z50g9dotM9+eSN8QBlUVzICQOhA0iTHO6cVIZMgBmxyXCg/gH3ZgL/c4FcZOm9VOzWeUB4KAZCe3naKsLatGL7If48wUhckKpoziwKAnX4RYcAaaXabWt/P4l0VfvxzOLNrTBIHtX7omSqnlKyN35bZOQqhnE5+npSTWdJz4gbC0wfm9KlGoze0jYEHjbjo4Z2DU2meIaSVSL3dnFbVm6FeaOverrG/381AzegnNYaHyZyvWKweIIE8aJMNgz/+Hg4NQx0mYQ2LRH3LeUDcklEr/Anlyu9Oo09CxNf2+lGROwohj32uKZ/9/U8JyEIlK1aC49B5uxWGZtC+4mnQqQJ7gr1WlptV3DpCudGo4AHqm9O+rcMda0W8YrPIeHxZRJThyWSOUrMN5rKA/axMPDZbxKtmh+6PI46Wza+QE4Sy4++xrvBmBWyOcezK9JCYqeBgQuCk0LSfAk3g8f2vABfdtZV+rCvC4y0KNIuRCzv8zHDID2+RtoHlTMqwCUINApfZkwyQzvBoYmD+MNU4+bKSh+x6SEfa6nUdpy/H9KZEwngvFRjqnk07OShKFt2toWv5EXDU2AD/h/hzm2d5rgyUNIKkPCc8sUl6KSQkRI90iLCBrRo34pc8n6iEC2VEiBDj5ofz+aikpw4MkI4IvTmMLVt+0EOrsi4TK+o4KVj+1B3S/qFIuo2CEzxFsEl9OZpvqOjrEVFeXa96hDJfrIHug==
X-Forefront-Antispam-Report: CIP:104.232.225.7;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.lenovo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(508600001)(16576012)(54906003)(47076005)(316002)(356005)(40460700003)(110136005)(36906005)(5660300002)(31686004)(82310400004)(31696002)(36756003)(8936002)(86362001)(36860700001)(81166007)(8676002)(70586007)(2616005)(53546011)(82960400001)(4326008)(426003)(83380400001)(16526019)(26005)(336012)(2906002)(186003)(70206006)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 17:13:26.4483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d2c501-df28-4137-b1ee-08da05ddf436
X-MS-Exchange-CrossTenant-Id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5c7d0b28-bdf8-410c-aa93-4df372b16203;Ip=[104.232.225.7];Helo=[mail.lenovo.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2APC01FT060.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR03MB4496
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org




On 2022-03-14 12:56, Hans de Goede wrote:
> Hi,
> 
> On 3/14/22 16:32, Mark Pearson wrote:
>>
>>
>> On 2022-03-14 11:31, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 3/14/22 15:43, Hans de Goede wrote:
>>>> Hi Mario,
>>>>
>>>> On 3/14/22 14:39, Limonciello, Mario wrote:
>>>>> [Public]
>>>>>
>>>>>>>
>>>>>>> I cycled through a few different implementations but came down on what I
>>>>>>> proposed. I considered 6 values - but I don't think that makes sense and
>>>>>>> makes it overall more complicated than it needs to be and less flexible.
>>>>>>
>>>>>> Ah, so to be clear, my 2 scenarios above were theoretical scenarios,
>>>>>> because I'm wondering how the firmware API here actually looks like,
>>>>>> something which so far is not really clear to me.
>>>>>>
>>>>>> When you say that you considered using 6 values, then I guess that
>>>>>> the firmware API actually offers 6 values which we can write to a single slot:
>>>>>> ac-low-power,dc-lowpower,ac-balanced,dc-balanced,ac-performance,dc-
>>>>>> performance
>>>>>>
>>>>>> ?
>>>>>>
>>>>>> But that is not what the RFC patch that started this thread shows at all,
>>>>>> the API to the driver is totally unchanged and does not get passed
>>>>>> any info on ac/dc selection ?  So it seems to me that the ACPI API Linux
>>>>>> uses for this writes only 1 of 3 values to a single slot and the EC automatically
>>>>>> switches between say ac-balanced and dc-balanced internally.
>>>>>>
>>>>>> IOW there really being 2 differently tuned balance-profiles is not visible to
>>>>>> the OS at all, this is handled internally inside the EC, correct ?
>>>>>>
>>>>>
>>>>> No - on Lenovo's platform there are 6 different profiles that can be selected
>>>>> from the kernel driver.  3 are intended for use on battery, 3 are intended for
>>>>> use on AC.
>>>>
>>>> Ah, I already got that feeling from the rest of the thread, so I reread
>>>> Mark's RFC again before posting my reply today and the RFC looked like
>>>> the same 3 profiles were being set and the only functionality added
>>>> was auto profile switching when changing between AC/battery.
>>>>
>>>> Thank you for clarifying this. Having 6 different stories
>>>> indeed is a very different story.
>>>>
>>>>>> Otherwise I would expect the kernel internal driver API to also change and
>>>>>> to also see a matching thinkpad_acpi patch in the RFC series?
>>>>>
>>>>> The idea I see from Mark's thread was to send out RFC change for the platform profile
>>>>> and based on the direction try to implement the thinkpad-acpi change after that.
>>>>>
>>>>> Because of the confusion @Mark I think you should send out an RFC v2 with thinkpad acpi
>>>>> modeled on top of this the way that you want.
>>>>
>>>> I fully agree and since you introduce the concept of being on AC/battery to the
>>>> drivers/acpi/platform_profile.c cpde, please change the 
>>>> profile_set and profile_get function prototypes in struct platform_profile_handler
>>>> to also take a "bool on_battery" extra argument and use that in the thinkpad
>>>> driver to select either the ac or the battery tuned low/balanced/performance 
>>>> profile.
>>>>
>>>> And please also include an update to Documentation/ABI/testing/sysfs-platform_profile
>>>> in the next RFC.
>>>>
>>>> Also notice how I've tried to consistently use AC/battery in my last reply,
>>>> DC really is not a good term for "on battery". AC also is sort of dubious
>>>> for "connected to an external power-supply" but its use for that is sorta
>>>> common and it is nice and short.
>>>
>>> One last request for the v2 RFC, please also Cc Bastien Nocera, so that
>>> he can take a look at the proposed uapi changes from the userspace side
>>> of things.
>>>
>> Ack - will do.
> 
> So I've been thinking a bit more about this while I was outside for some
> fresh air.
> 
> First of all let me say that I do agree that the having in essence 6
> different profiles thing needs a kernel solution.
> 
> What I'm not entirely sure about is if this needs to be something
> generic, with a new userspace-API as you proposed in the v1 RFC,
> or if it would be better to just solve this in thinkpad_acpi.c .
> 
> Now that I've a better grasp of the problem, I'll start a new email
> thread on this tomorrow with all the various take-holders in the Cc
> to try and answer that question.
> 
> It probably is a good idea to wait with doing a v2 of the RFC until
> we've had that discussion...
> 
No problem - and thanks! I'll hold off until we have a better idea where
we are going.
If having some example code is useful though just let me know

Mark
