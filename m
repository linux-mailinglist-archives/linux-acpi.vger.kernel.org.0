Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52118405874
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Sep 2021 16:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238158AbhIIOD1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Sep 2021 10:03:27 -0400
Received: from mail-eopbgr60075.outbound.protection.outlook.com ([40.107.6.75]:41189
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240296AbhIIODA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 9 Sep 2021 10:03:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+sxcEnApXKsrSShs+lp5J5au1NMPcAVO617FHFulc4vxvfpl6d1qqJWIHHLvF197n46HApVwB029D8+qS/y2O9kpDbIa4mEHIWjehGqEGiHeO0++e8zU/H3o6OSqGarHhhnpnlaDR1Ys6LeZkBNSSpN0axG/NZTwf1mS44mfbRKyDLdFHSmjLqPKVYJQYTzq5GpLbiEBcYhP2OYkljcgfDHlVUusA689WcEgiDu+Rm5TMfCURqwymURzca/ZARvrTDNTpFPLVzgYz+x3ql3IRuMXGtf6Guxd+1hwQw/F/eW84CKioj+7EJTx5XF6X4kg2QhPefWfICvHF27wdCOGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=bOkCo2L4qk//CLErrI0oPSB37vB+kdr+Mfk9xnYCQ54=;
 b=l3X/U84RRm4K8IiySzHQxDoyg6tpscYIY5/9kqyjpgH8GgAH2wTXWYYpQod53miF1wC8v4gQTCu+jeAtQ+TG/EAHt6Oh7lmnr2F4zXGqoYVzs3fPFHMFEsORv+RVGtHSm/BPatruvgdWXhrtq00oeSZYjq8KDpq72rezvqLU4qAbjD3x8nwwF7MJpkHDnT1/sG4hiTjxkDZdHyjPnqI7hHk63Q0waUYOV+++x1ZiRFyhffBggRC3+yLTwpA12xo1+tyBKE0iSUoeHDIIcSw1J/afJcoSjte905cBlyxAtCW0ane1vAKjUPJkQWibc8x8UEOwNWuJDt8FI1tkh98AeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOkCo2L4qk//CLErrI0oPSB37vB+kdr+Mfk9xnYCQ54=;
 b=NJ5d/5x/AAx0WRP2vm1sxxOTLwYSqGFssfCM8NivrKqV6kiMXwAZ1RskuhiyDbM/0fSZzePWh9YpU4WTmiOJptPSZ0qCNyTuNu9KhXbftRXRFWbw5zQMJzC70mkDlOtCamy4I2fvMQclw6wXBBziBuT+/F0cfEJG15MDvot5T1w=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB4653.eurprd04.prod.outlook.com (2603:10a6:803:70::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.24; Thu, 9 Sep
 2021 14:01:47 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::10e6:799c:9d34:fc2d]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::10e6:799c:9d34:fc2d%6]) with mapi id 15.20.4478.019; Thu, 9 Sep 2021
 14:01:47 +0000
Subject: Re: [PATCH] software node: balance refcount for managed sw nodes
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
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <ffe89a41-59c3-499b-1553-0c15f386df01@nxp.com>
Date:   Thu, 9 Sep 2021 17:01:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YTn7G/Mgm18JfV9k@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0059.eurprd04.prod.outlook.com
 (2603:10a6:208:1::36) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.103] (79.113.48.144) by AM0PR04CA0059.eurprd04.prod.outlook.com (2603:10a6:208:1::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 14:01:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22429fb5-0811-40de-5d4b-08d9739a5d37
X-MS-TrafficTypeDiagnostic: VI1PR04MB4653:
X-Microsoft-Antispam-PRVS: <VI1PR04MB4653750CB1538D83E30F59F6ECD59@VI1PR04MB4653.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V11Em9qI0gfxFkKhziMzmpmf7V21y7TEcynR/FOe5yrZCBaJktOLyinZcKwbUYvdgzUFvxKb4f1NEM17/wFLw4snjshCTZeE7xUV6Z2Nfco6gk8C7wpuEGpqB+bdkGXTTseD8xM1J3Uv0AOC5x60xn6iyCuqG/Vda8frz/6qlfDeDYBo+fi3ujiU8Qf2MgKAFtRMJMLx12c0H+T+yKeNJDHPU9gXG74Byt+wu/FBK+RYm9CsqOUUc8UDxxJ32qWj2f5IR9k/e1MzZe+WbbHFx+BSMyEmIy06Gn3qadyp9P9yoRcbIQVgtQuZFBnSHRjdXrK3KJMH62KzCbnUv/qxSWPHEvec28PkbHbPOe028VDjkryCfAB0M7PI4JCEpuP9I7ANBZQ9rE0HT+B04VZ7Li0ZuCbfaZyiwnsk7FUIRhfyJq8fxRA16ayvu7zj9WyCtVmOElGbo+yiL2ikKLMojaMTOAuY+HpH0aYYxptKjWcOvv0mwEDhImtgbxbJFK6JCVwavHxVdYPHO6BOt2Eq+2Fgutrz9n15Bqy3EvPKcbQyXJ48ParfrALtN84xRbZLGPLoy61StxCz2AKz9cR4m1CU3C8J4J446z8hNffP0ZURYyy0oIIME5bpVoSPYi0uXpPmr0vuklDITgCnc7Z5eGd2bjZql6LV6CENlrwrP9YO8K2fUYVe0wAzrpAIIS4Dw2wnJeQlsiwAY3pswl/ZuurF4uZBKpZGoogb50doDXe9MftDk8Bi0fodwneTl9WvujE1qt08VbDAQDzhCTk7eQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(66946007)(316002)(86362001)(66556008)(38100700002)(6916009)(83380400001)(52116002)(6486002)(4326008)(16576012)(31696002)(8936002)(44832011)(54906003)(53546011)(36756003)(26005)(5660300002)(31686004)(186003)(66476007)(508600001)(956004)(2616005)(8676002)(38350700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHI1dE5IQS82YktTOTdRY1lzdkFobEVJYmVZM244RWNvbVVDSll2anV2M2dT?=
 =?utf-8?B?N2RMT2RQSE5tTThieW92UVVOd2pSSmJReDVQUjJxWWxpdmpRUncrcityZXZ0?=
 =?utf-8?B?WCsxZVVuRFlCOEt2b3gvN3BIYjJKWHl3NXNKSm5QempNYnZ5R1RvdkRlR1Bu?=
 =?utf-8?B?ZW55bWZrdWVONEgvd09TMUxXOTZBUWtYWWs3SW5HcXM5aFlOMXpibG1KZWhj?=
 =?utf-8?B?cG9BdTY1UzBiTnVtWlRvbUwzM29rdkhyajF1VnlsVHZXT1p6WlR5T0lQTkZn?=
 =?utf-8?B?TVlWWnN5SVhRVlU2SSsrNEtZTGNxejF3aUNuUmp4aFV1c3hERkpqUzhiV3Vp?=
 =?utf-8?B?Njk4RGVydHZYM0dITmlINDBWbVgxcFFVditERjRVcTFmTDBTTUEycDVuaEdE?=
 =?utf-8?B?aDA0Rlk3a2dhQXh4dVpLaGY5MnArdDhxbkpPZXdHUCtYbmh3eUdKWkMvbzUr?=
 =?utf-8?B?Skgyd1lkOSsxRld5YWwwTlpsTXQvdWFKbjZSc1ZaL3lmWU9LalBSK3hJYlI4?=
 =?utf-8?B?NmpoMzc5RHpxb3lpcmlhdkQyL1NvMWFRT1kyUnRZNFkyT0liL1k4V2RZblMy?=
 =?utf-8?B?MWd1RG03cjNXeUdWMVJnVzFkM3hVQ0ZqdFdqY2s5K0R0cTBOaHJvd1oydms1?=
 =?utf-8?B?WjVTUjhDVU14YjdvMXZKS0pvRlhmREYrdFpoeXg5cTNLN01RQm5kczc5MmpK?=
 =?utf-8?B?WEZoclZZMEJCWGtpV1pkUElldWVtY2xCREZKTCtOM0pESGFrYnNqNG5qeWdp?=
 =?utf-8?B?dGtNNVJuVlZCcGNNcHB1aEViZGp3eVFaSFFpTHloMzZxV2lKY1hzQWRnMmpm?=
 =?utf-8?B?WFROZ21UbTlNTjliZUdhWE14SGdTU1RJOU9SV0pxWFZUQ2dTdmt4d2U5eGJh?=
 =?utf-8?B?NmtkL3dKNFJnYmk3dy9vOVRjMy9oSmF0bTVrZEp2em5KY1lodGVWNGFEc1NV?=
 =?utf-8?B?YkFsMmNNbWNGMXZOOCtvY1VWUTg0eXZhQXhNVjFqYmVaMXRxTC9UK0lpRnQ2?=
 =?utf-8?B?TWFpUmpHR3JLN3kxbHhmNVZRNXFvWWlHRXc4M0E4Rm5EcFlROVJmMFo3NmVK?=
 =?utf-8?B?d0k0YUpyOGxoOUlaT1piRHkyM0MvRUQ4OXIrSTJxNnBTSjd6WTk0b0dTU3pP?=
 =?utf-8?B?MlE5dmFIcmMvQWF1TVpvSmhoSytwQnZxY2FqRXpJMHE3UDBCTEdmbHVUc1pG?=
 =?utf-8?B?eVhtM2YwY05iZHVkRVV1RU9EQzVJbmU0MGNsRXRSanRFNlBUZ2s0enZDVEtr?=
 =?utf-8?B?TzREV1RnaXlBcFBDdDRUZ0x1MzhiN1lvYnh1RlBBREdTcEdkb0VNdENtOFlp?=
 =?utf-8?B?aXBkZy84OFdwbVlXL0xYUWJBRWM2K3JraHdJemlrRURJU0lEWWlnTlp1cHo1?=
 =?utf-8?B?L0dRUks3SERtakNMVktuRy9mMjRrRVdOSmovZjc3ZXVJV1Q3SFllb3l1WWxq?=
 =?utf-8?B?bnd6ZHlSSzQ5QjQ0MkVvNHhFTWd4Z0xXcmpiRG5jYTg3aWI2eFQwVk83UFlM?=
 =?utf-8?B?dUt5VEJ3bXpqcVhqbGRCaTlyR0pYclZqaExQZWNsMFdRRnczSnZzc1o3QlRS?=
 =?utf-8?B?QTlFUmptMjZPb3VhdFJpY2tLMzJOVFdza3dsL01mbzlNQWRYQjJMWmx0Ry9G?=
 =?utf-8?B?aTRoM3RZeXgyQUJmODJRRTRNYnpKa3dUd0VQcnVpSmxHK3c5S0tuV2lNbTlQ?=
 =?utf-8?B?VUdac3BEekRoTTkvSFlvOEdrSzBFV016dzVPVERjZXRjekFmQitZMUpxN2Zq?=
 =?utf-8?Q?Pvj0oT1VZlyQ+t4xLcSKhgBrTJ850KBo95NUVCJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22429fb5-0811-40de-5d4b-08d9739a5d37
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 14:01:47.6982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aqaUeiJ/+fA9SAn4LNn3MnP0np8YsZDQcm+gMcRxEH+a53eA6+QpKbJukS4Z/y/afdKwRfzK1LMkQJGO6LOHaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4653
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 9/9/2021 3:16 PM, Heikki Krogerus wrote:
> On Thu, Sep 09, 2021 at 03:13:47PM +0300, Heikki Krogerus wrote:
>> On Tue, Sep 07, 2021 at 06:59:18PM +0300, Laurentiu Tudor wrote:
>>>
>>>
>>> On 7/26/2021 10:59 AM, Laurentiu Tudor wrote:
>>>>
>>>>
>>>> On 7/20/2021 1:27 PM, Andy Shevchenko wrote:
>>>>> On Tue, Jul 20, 2021 at 12:22 PM Laurentiu Tudor
>>>>> <laurentiu.tudor@nxp.com> wrote:
>>>>>> On 7/19/2021 3:22 PM, Andy Shevchenko wrote:
>>>>>>> On Mon, Jul 19, 2021 at 03:00:17PM +0300, Laurentiu Tudor wrote:
>>>>>>>> On 7/16/2021 8:21 PM, Jon Nettleton wrote:
>>>>>>>>> On Fri, Jul 16, 2021 at 2:17 PM Andy Shevchenko
>>>>>>>>> <andriy.shevchenko@linux.intel.com> wrote:
>>>>>>>>>>
>>>>>>>>>> On Fri, Jul 16, 2021 at 01:16:02PM +0300, laurentiu.tudor@nxp.com wrote:
>>>>>>>>>>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>>>>>>>>>
>>>>>>>>>>> software_node_notify(), on KOBJ_REMOVE drops the refcount twice on managed
>>>>>>>>>>> software nodes, thus leading to underflow errors. Balance the refcount by
>>>>>>>>>>> bumping it in the device_create_managed_software_node() function.
>>>>>>>>>>>
>>>>>>>>>>> The error [1] was encountered after adding a .shutdown() op to our
>>>>>>>>>>> fsl-mc-bus driver.
>>>>>>>>>>
>>>>>>>>>> Looking into the history of adding ->shutdown() to dwc3 driver (it got reverted
>>>>>>>>>> later on), I can tell that probably something is wrong in the ->shutdown()
>>>>>>>>>> method itself.
>>>>>>>>>
>>>>>>>>> Isn't the other alternative to just remove the second kobject_put from
>>>>>>>>> KOBJ_REMOVE ?
>>>>>>>>
>>>>>>>> Or maybe on top of Heikki's suggestion, replace the calls to
>>>>>>>> sysfs_create_link() from KOBJ_ADD with sysfs_create_link_nowarn()?
>>>>>>>
>>>>>>> _noearn will hide the problem. It was there, it was removed from there.
>>>>>>> Perhaps we have to understand the root cause better (some specific flow?).
>>>>>>>
>>>>>>> Any insight from you on the flow when the issue appears? I.o.w. what happened
>>>>>>> on the big picture that we got into the warning you see?
>>>>>>
>>>>>> I encountered the initial issue when trying to shut down a system booted
>>>>>> with ACPI but only after adding a .shutdown() callback to our bus driver
>>>>>> so that the devices are properly taken down. The problem was that
>>>>>> software_node_notify(), on KOBJ_REMOVE was dropping the reference count
>>>>>> twice leading to an underflow error. My initial proposal was to just
>>>>>> bump the refcount in device_create_managed_software_node(). The device
>>>>>> properties that triggered the problem are created here [1].
>>>>>>
>>>>>> Heikko suggested that instead of manually incrementing the refcount to
>>>>>> use software_node_notify(KOBJ_ADD). This triggered the second issue, a
>>>>>> duplicated sysfs entry warning originating in the usb subsystem:
>>>>>> device_create_managed_software_node() ends up being called twice, once
>>>>>> here [2] and secondly, the place I previous mentioned [1].
>>>>>
>>>>> This [3] is what I have reported against DWC3 when ->shutdown() has
>>>>> been added there. And here [4] is another thread about the issue with
>>>>> that callback. The ->release() callback is called at put_device() [5]
>>>>> and ->shutdown() is called before that [6]. That said, can you inspect
>>>>> your ->shutdown() implementation once more time and perhaps see if
>>>>> there is anything that can be amended?
>>>>>
>>>>
>>>> Will do, thanks for the pointers. It could be that we mess something out
>>>> in how we use the driver model.
>>>>
>>>
>>> Quick (and late, sorry) update from my side. I've spent time on
>>> debugging our bus, did found some issues but, at least for now, none are
>>> related to sw node.
>>> In the mean time, I noticed in the swnode code that
>>> device_add_software_node() calls software_node_notify(KOBJ_ADD) while
>>> device_create_managed_software_node() doesn't. Updating [1] the later
>>> with the call to software_node_notify(KOBJ_ADD) does seem to fix the
>>> issue I'm seeing.
>>>
>>> Could this be a problem? Any comments appreciated.
>>>
>>> One more thing perhaps worth mentioning is that, at least for now, there
>>> are few uses for this device_create_managed_software_node() api,
>>> mentioning here a couple of them:
>>>  - arm64 iort code - this seems to be triggering the issue i'm getting
>>>  - dwc3 usb - Andy reported similar issues here, maybe the issue is common?
>>>
>>> [1]
>>> @@ -1113,6 +1125,15 @@ int device_create_managed_software_node(struct
>>> device *dev,
>>>         to_swnode(fwnode)->managed = true;
>>>         set_secondary_fwnode(dev, fwnode);
>>>
>>> +       /*
>>> +        * If the device has been fully registered by the time this
>>> function is
>>> +        * called, software_node_notify() must be called separately so
>>> that the
>>> +        * symlinks get created and the reference count of the node is
>>> kept in
>>> +        * balance.
>>> +        */
>>> +       if (device_is_registered(dev))
>>> +               software_node_notify(dev, KOBJ_ADD);
>>> +
>>>         return 0;
>>>  }
>>
>> That should be fixed indeed. Please send that after -rc1 is out.
> 
> I mean, resend :-)
> 

Right, actually I just noticed that this is the fix you suggested last
time we discussed. :-) I forgot about it, sorry.
There's still the WARN_ON() [1] triggered by the usb subsys, apparently
happening only (!) in ACPI boot scenario, so +Lorenzo.
I'll delay the sending a bit to try to understand what's going on.

[1]
[   11.760346] sysfs: cannot create duplicate filename
'/devices/platform/808622B7:01/xhci-hcd.2.auto/software_node'
[   11.770612] CPU: 9 PID: 1 Comm: swapper/0 Tainted: G        W
 5.14.0-rc1-00214-gbf7f1083ebd3-dirty #62
[   11.780611] Hardware name: NXP NXP LX2160ARDB Platform, BIOS EDK II
Apr 16 2021
[   11.787913] Call trace:
[   11.790351]  dump_backtrace+0x0/0x2a4
[   11.794017]  show_stack+0x1c/0x30
[   11.797331]  dump_stack_lvl+0x68/0x84
[   11.800991]  dump_stack+0x20/0x3c
[   11.804302]  sysfs_warn_dup+0x88/0xac
[   11.807965]  sysfs_do_create_link_sd+0xf8/0x100
[   11.812492]  sysfs_create_link+0x48/0x80
[   11.816411]  software_node_notify+0x1a8/0x35c
[   11.820769]  device_create_managed_software_node+0x158/0x1b0
[   11.826428]  iort_named_component_init+0xe0/0x140
[   11.831131]  iort_iommu_configure_id+0xf4/0x270
[   11.835660]  acpi_dma_configure_id+0x160/0x200
[   11.840101]  platform_dma_configure+0xa0/0xa4
[   11.844457]  really_probe.part.0+0x84/0x480
[   11.848639]  __driver_probe_device+0xd4/0x180
[   11.852994]  driver_probe_device+0xf8/0x1e0
[   11.857174]  __driver_attach+0x108/0x220
[   11.861095]  bus_for_each_dev+0xe4/0x154
[   11.865014]  driver_attach+0x38/0x50
[   11.868587]  bus_add_driver+0x1bc/0x2c4
[   11.872419]  driver_register+0xf0/0x210
[   11.876253]  __platform_driver_register+0x48/0x60
[   11.880956]  xhci_plat_init+0x34/0x40
[   11.884616]  do_one_initcall+0xa8/0x270
[   11.888449]  kernel_init_freeable+0x2c0/0x348
[   11.892806]  kernel_init+0x28/0x140
[   11.896295]  ret_from_fork+0x10/0x18
[   11.900062] xhci-hcd xhci-hcd.2.auto: Adding to iommu group 6
[   11.906044] xhci-hcd xhci-hcd.2.auto: xHCI Host Controller
[   11.911566] xhci-hcd xhci-hcd.2.auto: new USB bus registered,
assigned bus number 3
[   11.919702] xhci-hcd xhci-hcd.2.auto: hcc params 0x0220f66d hci
version 0x100 quirks 0x0000000000010010
[   11.929187] xhci-hcd xhci-hcd.2.auto: irq 106, io mem 0x03110000

---
Best Regards, Laurentiu
