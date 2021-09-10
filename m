Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAFDA406B28
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Sep 2021 14:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbhIJMGc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Sep 2021 08:06:32 -0400
Received: from mail-am6eur05on2068.outbound.protection.outlook.com ([40.107.22.68]:33632
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232873AbhIJMGc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 10 Sep 2021 08:06:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfvvEcXssd+cn5HCeX5nrTfjdh/zgADi+RWa12+sEaa48Uv23SzLI5ZPXF81oZTxXwvfHMsPI0icL6ph4jl2XKecDcsyiMKk+MOUqV/nYxzWTR7yal04dHIaoUX69G51oyB8QVNoWwfgKCKnSQxAx0OVVKT9PnMjAJ8dgyMgwOSd3RuLiv2JaoB/mKcUlowdoiy2uiLia+dXCztTxkOWFi41r9AngnouD5iy+Y3tb3awRlOVT2x9Ebr/BfqLQQqGSErliqnN9SjuFdtgwBZdPe2PJTKNY6wkXqZVFRs4fVmGdxBpDE5O8bBDUn+dCfFAeAOszFeioruvLgH0H1sTQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=E7o9hMSQwlmvcMlAeT789/BGio77BZQQNif+oEJJqN0=;
 b=Ek8MvhEE3HCUtpjaD/m4wCNFa+9JbnaltvgJWR38GuRo3oZfKaWd2iVRiNfbsPruJ2XlU12W8Y9Bb+RXU0/qApSLLC3dq2T8/WYPkSwlpDCUODynHLqU2BuTVKwnOT24X8hj6a/HaiYAixv4wQ2V/PvOzYtUIj5qK0jfVm0aKFJps9lc9CEa22cKmPHPY7I+id7Jl/b+95wSIxkJkewZpVgaoBVIhbCCRjsNmpJi2noFLW4fvSBVv95TSc+23susa2ZhyobPUcyRFWOe8YePEbHRM/geGw1C7zoQpK5y1Kz5XJOv0vglNzQFFwjkdfbIBvxByLL3V8508z+kNG8akQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7o9hMSQwlmvcMlAeT789/BGio77BZQQNif+oEJJqN0=;
 b=fbFOAY467eBBFymxN2IQ0YrcKtBk2k0GID3StGT8Btv1ZO0l/Sp/1kvAlN66d6TzgkwPNfMNNi//xOy7GO1JLX4eAlG+jAEw18cgQ02BhdhMGbAiDXUJzgmWfXDKU/JeQHVuaJ5IkDn7svEpQ6CWI6zEhAjCbIRbeN0JfKkIj+4=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR0401MB2525.eurprd04.prod.outlook.com (2603:10a6:800:4f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.24; Fri, 10 Sep
 2021 12:05:19 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::10e6:799c:9d34:fc2d]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::10e6:799c:9d34:fc2d%6]) with mapi id 15.20.4478.019; Fri, 10 Sep 2021
 12:05:19 +0000
Subject: Re: [PATCH] software node: balance refcount for managed sw nodes
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jon Nettleton <jon@solid-run.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20210716101602.1891-1-laurentiu.tudor@nxp.com>
 <YPF40t5bhgTFM2wK@smile.fi.intel.com>
 <CABdtJHuKyybhJazpAc8KT54ELtZ319rdb6CbSH6zB5x3NhgtAw@mail.gmail.com>
 <bb009f85-687e-d560-9cc5-1ac4f586a6bd@nxp.com>
 <YPVufjevu5WaaIxQ@smile.fi.intel.com>
 <2a0f7fa6-b164-eeb4-118a-acd57d79a484@nxp.com>
 <CAHp75VcYt+VQq4jp9JdkA4EpGqtks2sP-NRkfSbGj+-Vn5ke=g@mail.gmail.com>
 <c2186f2c-8be0-6f44-e442-8cb8cbd5f2c2@nxp.com>
 <2485ac73-6df6-3939-5ee5-ef650d951054@nxp.com>
 <YTn6dx2rRsLZ6GDJ@kuha.fi.intel.com> <YTn7G/Mgm18JfV9k@kuha.fi.intel.com>
 <ffe89a41-59c3-499b-1553-0c15f386df01@nxp.com>
Message-ID: <e9bc1397-99b7-a57e-4860-80d146848e2c@nxp.com>
Date:   Fri, 10 Sep 2021 15:05:16 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <ffe89a41-59c3-499b-1553-0c15f386df01@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0116.eurprd04.prod.outlook.com
 (2603:10a6:208:55::21) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.103] (79.113.48.144) by AM0PR04CA0116.eurprd04.prod.outlook.com (2603:10a6:208:55::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 12:05:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c511262-5b44-4dac-d62f-08d97453420b
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2525:
X-Microsoft-Antispam-PRVS: <VI1PR0401MB25259B0D1448CC4A7E04DCC1ECD69@VI1PR0401MB2525.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:397;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GX5VWz2VHhZ7tiJnioyCijuXjoC6M1chUVajNbepoQ2YgKolVWyCScJzSBVKu/KHjWGiblznDRQIbWdwHInQTu/TizbaYDUqYUWBXloIuFeuHtCgQqmdDuhGxoDD8/qASmyBhZ3rF2HwNtHBJVpPiqI+o8hIgzPOWQNme0SYxYYom/qVv4kvN9PojVc256NAIkYR5czIDt1v8S6Z+/ubzKb2jEDM+0T46yM6ybNsRFU68EkCWOI8pdQSVqk8Sptv9vEM5DujbsndpQhNfBf7rgaGCsk+M+T4ehOPhixPyQ4EDzQQklhOIdJApN3YLw0EkcZl412kpInngQ7VXvMLW7lj4ei81zbjobnEESZqY0ail5PcJKjeHQRJOl89O0G86NndyzBc6aDVDGmIKf/Nr0LcjVkwyRecRePJskul19snC3+SwAoc0GS6krw03m29CLywfH1Ct3Is0EqpLK509U1UuSSBtyChOY3+wR82hO8K+7Bpa3MOC8Yh7LFekwqML5jIr5u+itJQ2LVLzUUaxr9tRrFgoIiSTXpbXRmEexITqnkjrIu4TdXiKPZcmnj/2Ye5gtRWq5DJOVIeLksrIvOrxfHr65ka6N57bVahrm5tMFGK+j44tDuHSsaVa0n1XKfZexSr0Qwl+7uO80Py1z0c8biS6pWJQXSCXM/a+2hTFSUQGmn0xDzkRTpZH0MQ63awbNvbujfxbRfuRQpOGTAG1cO5hhpVux03ByZQkV8HUhTXzf8Lp8+/7H1rhPEg+cAAONSC/s7WJNFs0OeW5SG3hBAtS/vDEfRbWNqxTf2FFQ2SMpZrl26HO9VaDt3UWwTf24b23HDHI/gWY/XMLg6yMmZL/TzmB3kLfHEeYz+/RX/iHmIlTtpG2S0sMEww+ZK826dMNTgBbTvqBEMsig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(83380400001)(956004)(52116002)(38100700002)(38350700002)(36756003)(54906003)(316002)(26005)(6486002)(66946007)(186003)(8936002)(8676002)(2616005)(66476007)(53546011)(66556008)(86362001)(5660300002)(966005)(2906002)(31686004)(478600001)(4326008)(16576012)(6916009)(31696002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHlldmRjUWZ3aUczOHYvUEJHcU5UVW8wdDZFZjBmME5DemhLdnRiVlA1cVVq?=
 =?utf-8?B?cE5ESDRJdld1dHB1aXo1dVpTampNcVhxbWZHdTlnYmtKRERaQkI3eklCQnBr?=
 =?utf-8?B?eUZYWkMwRHJUbVFjTnVtMzlmUDFCQWNkM3ExWFJmNVltdXN5WEw0a1F5R3lD?=
 =?utf-8?B?bHZYaGNKZEpVaGszbmcrY2pTT0VrODA5ak9VZFFTWUw5Rk81L3VpcEpPNFNV?=
 =?utf-8?B?ZHd1dTZuSFNtZ2NwTUVrRWZVNEsvc1NtZnArdEVrRWZkWFUxRVIrT1lMRVlH?=
 =?utf-8?B?aEo4M0p2UzFKOEMvVDlsZkVqK2orQW9yUW1IY2ZNSVE4UTY1K0I4Mkh1RTc5?=
 =?utf-8?B?ejF0S3o1dzlURC84RTZPSmZuZDUrN0VwcGFvM3UxMzlRZ0ErcWZFNzNBclBX?=
 =?utf-8?B?Wm1qOGlkOXJvQkNYbjNERzFldG54QlU1czEvaEpGK3YwZGRHb0NPekZWOENl?=
 =?utf-8?B?UFAxS2wrdjQrWGJCMzRObk1RZ2RVVUNJb3F3TFpIYlRSSUtFTHNYWGV0N0dx?=
 =?utf-8?B?dzI5SUdMN25VNmttU2dRUFB5ZlJ4cmg2YnRrT2p2SjBoNVIrUXprbGNpSGFh?=
 =?utf-8?B?R1o2QmRZMHBNTTFSSVZnZm5CelNsN1pQQzZFcTh3WjFuNEdaaEtVVTV3RGlD?=
 =?utf-8?B?OTFySDJSM0NEZGFMUGNqUzkzZHd6SCt2eFI0MlFpa2FUMGQvYlNjSkZNRzZL?=
 =?utf-8?B?MmFpMDRhYmw2SXBmKzVUNmd4Z3VZellvYmlhc2RXZFFtamlpSlM0SUpZNEMv?=
 =?utf-8?B?bXVYTGN5VHdQbStGOXBhSWtlbEt3UW02TENhYlgvZ3VjdzJhaUNxbS82TmZY?=
 =?utf-8?B?RWg0VHVPUkNVUDNWbWZXUW5vNzA0SzIvQk4rUWVPOFNqTkZyb0w5QmhDOU1v?=
 =?utf-8?B?b2JQYXdDUDBkTkpnRVFGcHg0RE5KM0oxMjU4SmYyVEJhU2FUbFozMkRzdGp5?=
 =?utf-8?B?cHJtNk14cWhrQzFWelk0N25nOE55cFh2RlN6SlpMTDYwOWhPZmZwWjhhcU50?=
 =?utf-8?B?b0FMNThLZGdOcFQzY243Ym9pWFA2TVIrTzNUVkN2dHliNkw1RFhoc1NWakdE?=
 =?utf-8?B?eE5VQXpaOXlyTGZoRzBSS3JrMjgzQktnMkV2OVc0Nlo2SDFjZ0JYcnhxR1F0?=
 =?utf-8?B?K2haOUJqcGNKY28zWFJ5QmZ5cDlCWHl0bFFpK3lsLzN4YmswMWlOU0RpQys3?=
 =?utf-8?B?Ykp6TlErVEd1a1N3V25VWGZhcGRmZ0ZJTW14SER0N0MzRzNkUGJVcTlwb0Mx?=
 =?utf-8?B?bEEzTGJUM21NOXc2bnFkOGMvNWNPSU5TQW45eW92RE8vcFdXQVIxRzdWUFNL?=
 =?utf-8?B?S3dJM0gvL0tGY2tSRytkbU8wWGVwNG5jRTlYZSt1MDBHZ3l5ZzQ2amQ5bHdR?=
 =?utf-8?B?akgrY0JCNGMydjlqYU1EYmRlR2ZXbWFaVWhzcC92eFFsc3M2VlJpQzI1Y05U?=
 =?utf-8?B?TVR0SHl3THF6UWVLYzN4VUJHLytOQ1lKQzkwY3hHaTRBZGFQMkVjQ0cyUzVE?=
 =?utf-8?B?YnVUb2FvN0ovNFYwaHFHakdYV1k2c1h1QmpDbTg0NU94clNIVVYyV2FWZVdQ?=
 =?utf-8?B?VkVZL1BxeVU0OXhiek81aDEwNkVOM3ptQjVrWEhnWk5kWGpyS3FTQkFkNFVT?=
 =?utf-8?B?bHVaaXRBVDlHVEhCaGpwSDF0SEx5bWQ2cWp2RDlZWDZoOTBlUlJ1cVhaUElW?=
 =?utf-8?B?TTlmV3Z3bUFNNUdMUEQwWS9pSHBpOGxLR3krZnZWZk9OTUphdGJMcThrTWRt?=
 =?utf-8?Q?5aWbAgJKlCRmnXB2eKYvPQ9NoytkITOOLbC0dsv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c511262-5b44-4dac-d62f-08d97453420b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 12:05:19.0474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D3QwJQSW6IeKUqa0AP4LxJl9MdpQP24Xm0Lp+hxcRRJ4G3h8p06Q1JTU5HRonbUb6tnzP7P8TY9axrJj+X1Aeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2525
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 9/9/2021 5:01 PM, Laurentiu Tudor wrote:
> 
> 
> On 9/9/2021 3:16 PM, Heikki Krogerus wrote:
>> On Thu, Sep 09, 2021 at 03:13:47PM +0300, Heikki Krogerus wrote:
>>> On Tue, Sep 07, 2021 at 06:59:18PM +0300, Laurentiu Tudor wrote:
>>>>
>>>>
>>>> On 7/26/2021 10:59 AM, Laurentiu Tudor wrote:
>>>>>
>>>>>
>>>>> On 7/20/2021 1:27 PM, Andy Shevchenko wrote:
>>>>>> On Tue, Jul 20, 2021 at 12:22 PM Laurentiu Tudor
>>>>>> <laurentiu.tudor@nxp.com> wrote:
>>>>>>> On 7/19/2021 3:22 PM, Andy Shevchenko wrote:
>>>>>>>> On Mon, Jul 19, 2021 at 03:00:17PM +0300, Laurentiu Tudor wrote:
>>>>>>>>> On 7/16/2021 8:21 PM, Jon Nettleton wrote:
>>>>>>>>>> On Fri, Jul 16, 2021 at 2:17 PM Andy Shevchenko
>>>>>>>>>> <andriy.shevchenko@linux.intel.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> On Fri, Jul 16, 2021 at 01:16:02PM +0300, laurentiu.tudor@nxp.com wrote:
>>>>>>>>>>>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>>>>>>>>>>
>>>>>>>>>>>> software_node_notify(), on KOBJ_REMOVE drops the refcount twice on managed
>>>>>>>>>>>> software nodes, thus leading to underflow errors. Balance the refcount by
>>>>>>>>>>>> bumping it in the device_create_managed_software_node() function.
>>>>>>>>>>>>
>>>>>>>>>>>> The error [1] was encountered after adding a .shutdown() op to our
>>>>>>>>>>>> fsl-mc-bus driver.
>>>>>>>>>>>
>>>>>>>>>>> Looking into the history of adding ->shutdown() to dwc3 driver (it got reverted
>>>>>>>>>>> later on), I can tell that probably something is wrong in the ->shutdown()
>>>>>>>>>>> method itself.
>>>>>>>>>>
>>>>>>>>>> Isn't the other alternative to just remove the second kobject_put from
>>>>>>>>>> KOBJ_REMOVE ?
>>>>>>>>>
>>>>>>>>> Or maybe on top of Heikki's suggestion, replace the calls to
>>>>>>>>> sysfs_create_link() from KOBJ_ADD with sysfs_create_link_nowarn()?
>>>>>>>>
>>>>>>>> _noearn will hide the problem. It was there, it was removed from there.
>>>>>>>> Perhaps we have to understand the root cause better (some specific flow?).
>>>>>>>>
>>>>>>>> Any insight from you on the flow when the issue appears? I.o.w. what happened
>>>>>>>> on the big picture that we got into the warning you see?
>>>>>>>
>>>>>>> I encountered the initial issue when trying to shut down a system booted
>>>>>>> with ACPI but only after adding a .shutdown() callback to our bus driver
>>>>>>> so that the devices are properly taken down. The problem was that
>>>>>>> software_node_notify(), on KOBJ_REMOVE was dropping the reference count
>>>>>>> twice leading to an underflow error. My initial proposal was to just
>>>>>>> bump the refcount in device_create_managed_software_node(). The device
>>>>>>> properties that triggered the problem are created here [1].
>>>>>>>
>>>>>>> Heikko suggested that instead of manually incrementing the refcount to
>>>>>>> use software_node_notify(KOBJ_ADD). This triggered the second issue, a
>>>>>>> duplicated sysfs entry warning originating in the usb subsystem:
>>>>>>> device_create_managed_software_node() ends up being called twice, once
>>>>>>> here [2] and secondly, the place I previous mentioned [1].
>>>>>>
>>>>>> This [3] is what I have reported against DWC3 when ->shutdown() has
>>>>>> been added there. And here [4] is another thread about the issue with
>>>>>> that callback. The ->release() callback is called at put_device() [5]
>>>>>> and ->shutdown() is called before that [6]. That said, can you inspect
>>>>>> your ->shutdown() implementation once more time and perhaps see if
>>>>>> there is anything that can be amended?
>>>>>>
>>>>>
>>>>> Will do, thanks for the pointers. It could be that we mess something out
>>>>> in how we use the driver model.
>>>>>
>>>>
>>>> Quick (and late, sorry) update from my side. I've spent time on
>>>> debugging our bus, did found some issues but, at least for now, none are
>>>> related to sw node.
>>>> In the mean time, I noticed in the swnode code that
>>>> device_add_software_node() calls software_node_notify(KOBJ_ADD) while
>>>> device_create_managed_software_node() doesn't. Updating [1] the later
>>>> with the call to software_node_notify(KOBJ_ADD) does seem to fix the
>>>> issue I'm seeing.
>>>>
>>>> Could this be a problem? Any comments appreciated.
>>>>
>>>> One more thing perhaps worth mentioning is that, at least for now, there
>>>> are few uses for this device_create_managed_software_node() api,
>>>> mentioning here a couple of them:
>>>>  - arm64 iort code - this seems to be triggering the issue i'm getting
>>>>  - dwc3 usb - Andy reported similar issues here, maybe the issue is common?
>>>>
>>>> [1]
>>>> @@ -1113,6 +1125,15 @@ int device_create_managed_software_node(struct
>>>> device *dev,
>>>>         to_swnode(fwnode)->managed = true;
>>>>         set_secondary_fwnode(dev, fwnode);
>>>>
>>>> +       /*
>>>> +        * If the device has been fully registered by the time this
>>>> function is
>>>> +        * called, software_node_notify() must be called separately so
>>>> that the
>>>> +        * symlinks get created and the reference count of the node is
>>>> kept in
>>>> +        * balance.
>>>> +        */
>>>> +       if (device_is_registered(dev))
>>>> +               software_node_notify(dev, KOBJ_ADD);
>>>> +
>>>>         return 0;
>>>>  }
>>>
>>> That should be fixed indeed. Please send that after -rc1 is out.
>>
>> I mean, resend :-)
>>
> 
> Right, actually I just noticed that this is the fix you suggested last
> time we discussed. :-) I forgot about it, sorry.
> There's still the WARN_ON() [1] triggered by the usb subsys, apparently
> happening only (!) in ACPI boot scenario, so +Lorenzo.
> I'll delay the sending a bit to try to understand what's going on.

I've spent some time looking into this and it  turns out that in the
ACPI case, device_create_managed_software_node() ends up being called
twice, first here [1] and after that, in the IORT code here [2]. With
the proposed patch this causes software_node_notify(KOBJ_ADD) being
called twice thus triggering the dup sysfs entry warning.
Any comments / ideas welcomed.

[1]
https://elixir.bootlin.com/linux/latest/source/drivers/usb/dwc3/host.c#L111
[2]
https://elixir.bootlin.com/linux/latest/source/drivers/acpi/arm64/iort.c#L952

---
Best Regards, Laurentiu
