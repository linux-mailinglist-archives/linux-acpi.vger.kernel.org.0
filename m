Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A89406C96
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Sep 2021 15:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbhIJNCG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Sep 2021 09:02:06 -0400
Received: from mail-eopbgr140082.outbound.protection.outlook.com ([40.107.14.82]:5870
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233185AbhIJNCF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 10 Sep 2021 09:02:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoSYXelmnzwlsWmOq5pq+yaDB+oZK+MNkBl/xdDiDu5ywBgYUcxyosbp6NtxL3PoEN2S2Z5bAHnLF14Qu2S3LCVT42WtKYknGfvKFbeWiHm5V/kWxcnhBMCd6bi3THaxUzJsiz0tU+xQdRKVDOWcy3NUD7mtXxkOVv8IHaRz+EPRc+A3eHEz3s7tLQWi+1gt1TRaWYKumRc5qZ6UgyuiyusA0kEL3yn26rpJInAcABpdfglemu6jzpdE76LNbOh4neu76sXLYYOv5YTcWkyjEsJZWQHC0ick4LSZyHPmhd6JQ+p+cVvHhroZZy7/fEfYMx+EVCZwJX1zGuLDH+DErQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=NhcWnFCeJo8Mq8ZmM2F++qCuw6dsq+/hvGHmieuGxRc=;
 b=b2beBi9K1GM7ZPtCGacC7vsdIKezlnKre7mTO5NVPxb3LmTv5cs+yqyxyWNJPSx25ttJUdhKMRhqoaHeoY0yUFetO2o23F4iqMJNOiq7NKwmWvY4q7nUgyIvTK4etNMNnUW7TZ2y50/YHDw8WagOFX6ttPD2eeDN/duzFhxiMRXoV8FLmBSyR+pEXRlsU/tVolNFAlE07XiUD3t1PevBFx5bItahM8rYIHzqE37l82VxwgrhnUcdlsUlAglSs2s++1Kfv/fGBM/dwhGl3xVwLpuXgWrKaUQM5ttE5Py1vi+lyQWf9cX5eimivSklHbWkbcYPrm+ZTQG7TRc7zT7r/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhcWnFCeJo8Mq8ZmM2F++qCuw6dsq+/hvGHmieuGxRc=;
 b=WzMq67yPcCwmrdpLvGwAGnT5ja42Cnje9G+IcKGV04uMfPijP4z+2AjxERYtnU4RHTNRtJT9Z+siskniK6Xc0mWOhWL2a6iEiOxEBKgFhysGQlDrJFzhJmuE2JGiqLlDxOyGQW2T9PEfAMmHDEOV/uKU0hdupIvgMpqQusy9vek=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB7086.eurprd04.prod.outlook.com (2603:10a6:800:121::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Fri, 10 Sep
 2021 13:00:52 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::10e6:799c:9d34:fc2d]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::10e6:799c:9d34:fc2d%6]) with mapi id 15.20.4478.019; Fri, 10 Sep 2021
 13:00:52 +0000
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
References: <bb009f85-687e-d560-9cc5-1ac4f586a6bd@nxp.com>
 <YPVufjevu5WaaIxQ@smile.fi.intel.com>
 <2a0f7fa6-b164-eeb4-118a-acd57d79a484@nxp.com>
 <CAHp75VcYt+VQq4jp9JdkA4EpGqtks2sP-NRkfSbGj+-Vn5ke=g@mail.gmail.com>
 <c2186f2c-8be0-6f44-e442-8cb8cbd5f2c2@nxp.com>
 <2485ac73-6df6-3939-5ee5-ef650d951054@nxp.com>
 <YTn6dx2rRsLZ6GDJ@kuha.fi.intel.com> <YTn7G/Mgm18JfV9k@kuha.fi.intel.com>
 <ffe89a41-59c3-499b-1553-0c15f386df01@nxp.com>
 <e9bc1397-99b7-a57e-4860-80d146848e2c@nxp.com>
 <YTtR2pLEMFDubtqi@kuha.fi.intel.com>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <56544211-7407-3de2-e30d-d1dbb7b2aeb2@nxp.com>
Date:   Fri, 10 Sep 2021 16:00:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YTtR2pLEMFDubtqi@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0027.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::40) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.103] (79.113.48.144) by AM0PR02CA0027.eurprd02.prod.outlook.com (2603:10a6:208:3e::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 13:00:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07f60ac8-a1f6-4792-3e9c-08d9745b04d2
X-MS-TrafficTypeDiagnostic: VI1PR04MB7086:
X-Microsoft-Antispam-PRVS: <VI1PR04MB7086031C0A6F181CB6B217C0ECD69@VI1PR04MB7086.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CJ+6CohSjGqpmEACRfd5bWyI0aBLcvVC3vZuAw8XpI2haHvxTEEfmBt4PBVqkP3mX8tjT8nO+muU5pMKmyF8r2JYSTCUYbwDYeWX4YvL0rf/USgglyMhIeH9fu/nMpyaYDNXZD6zEJsLjDytFJDGxwGXRPy5iKyCNy1vLs0exjFfwEo0UWnx0W5JY3coS0OxamB09udKz37To69WhYAXATmb6DXCCzhciwH+IwNtHHvoHlXzZ2xj4wRil4RYQ69H2Udu1PbAC0ZZC0OfYGSEzFS/aTH5vsu4zeH1m0lrVGnp+myvxn8NSoCKSLWF9qOWUb1mLEY0py3ZKJOaP5lTK1VhH9JgwQcxn34syZP2HRhNlXp/5yCsUnNVcHehMpb6NrZF5Yvit9p8EP+ccgm2g9JYOVLSsw+gz9A8QqmYuz5/c2DrJZfIaWWqjIf5ugGrqTRimB20n73EuudX0QKqmurobQK8rGQuw0O0DlASWVtO5OqQTzpamDVQKEUA4riKVrNwQHVIjDURbzR2yZeS2gG8lqfPgv+g+59XKpi6/ZHaVgZ9ie5Yf7m/dt3F2P6nPs8QqldFEpjGhgr4UKtLk7fCJZnHlXx4Y1OarEh7bnqnY0suSK4esQTKLyrwXkK8MMBYGw6aPfJX/wKIVKO9q6tFM9eOVGiidNvMgVDgUI9W4ZiLxRmTBNDXis7D0au1n8rCybeU7xoJR/tZO8Im4Dc+WhgSg4R8I925f3Jo7FzCOuIxvtotVoppjjKm6RHSrqxT2EtzUp6/bym39/BvrZeHlnLVwG/3ll4FZXCoRwQ+BE8D1Dq3LQx5a9azlDtcg22mRFWLnM0xtqrWI/H5VRL8aRv2f+mv64ttUilcmJ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(5660300002)(38350700002)(54906003)(53546011)(66556008)(6486002)(186003)(31696002)(26005)(38100700002)(16576012)(31686004)(86362001)(44832011)(52116002)(36756003)(316002)(966005)(2906002)(6916009)(8676002)(2616005)(478600001)(83380400001)(8936002)(66476007)(956004)(66946007)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlVDL3dCYVNXNDlQenM5TzdBTU5DNkRhSG5tREI1K0h6dS8vMi9ET3VyTlhs?=
 =?utf-8?B?ZVdCOGVBaDl1S25sLyt2eVg4Z3R0L3E1Qkd1L1pLZlZFc3pKQVp2aXRUS1hw?=
 =?utf-8?B?cE5kVTNGVGZ4WnRwMG95WDNZNzZEeXlhejdtQzU5UTZRMEdIT0VXL1pzRWxi?=
 =?utf-8?B?V2xJakk4TzhURlBjM3FrREkyWjFrNHBMRFVHTnRja1d1dUJlWlo0VVRCOXVl?=
 =?utf-8?B?Ylg4ZGxWcWFtdTM4RHJZK3BnL1RhZ0ErdGo2NHNHQi9xejA0L2ZDODdZTXFj?=
 =?utf-8?B?cDRVTERzaTBuR1cwbEppUGpHM0w5VDRLOVNZQ1VvK0lDeXJvUjFlSjdBeEV2?=
 =?utf-8?B?QWVMU3VZN1N3ZUlkYjFxYXZMSk1FSWtmbVhlbnJ1TERVTG10d1hXeWQ0dmJU?=
 =?utf-8?B?YXFhYTNRa29yWmh0N0g1bE1zanJiMHZYeEg0Qlg4ck02SXdoOFF4bGZvVDJ4?=
 =?utf-8?B?Z2Rqb2hIL01nVkhCVlk5UlR2Z25aRWxLSG9zMlI1eTB3WGEzWHBoR0dtLzlZ?=
 =?utf-8?B?d3RkRGp5c3pXV0RMS3BaeVA3NnFwbzVxTTJ5a1puMHg4aE9udkE0Uk5xS0xM?=
 =?utf-8?B?bjJaTmxGQ1pOak1CM082RWVZQ0hsak8rTGI3eUlodlBpeXI5T05vcllpeFZq?=
 =?utf-8?B?RjkzTkdGOVR6bWFTejlJYTdqdmpod0R6dHB3Yk5MU3QvSFpUTjc0U29CUVZT?=
 =?utf-8?B?Ym9DaW1nOXJrVFRwUkNOMWVFWXFFVi9OMWd1ck8wbWIyUG5QdE9MUmJJZXJu?=
 =?utf-8?B?VnB0cVR1VGoxTU83TkozNjdJRWZoZi9NMi9iTnp6ZkRteGFtSHAxSEdaWndQ?=
 =?utf-8?B?eVYrM1ZNV1B0NzZ2V2l4OGtTaWpxV2F2WWEwMWptQzBHUzRnMW1hL3Vic2lv?=
 =?utf-8?B?Zk1aNUlYcUQ5VGZSKzV3dnU2RlZvbFozQk5mcW5mZm5HSFh5UmlxMTYvcUtk?=
 =?utf-8?B?OE9xT2xwUzZRZjRIWkxEM3NOL2ZGMFVBV0xjOWFWaFNsVU44WWFWTTU2dkpB?=
 =?utf-8?B?RWlqNThxSEdna044UjhZZjF4dHEyVExzSjRaOXBKb2VoeGlySXJtUHJGZlRG?=
 =?utf-8?B?U3Npd3lHeXJjNW90MmR2Y0JBdmx5R1VCSkFISERQMzU3SmVGZkYvVC83UzZy?=
 =?utf-8?B?blNGU0FVNHpqSjZOY3hmQjlBUkxJLzFLbENxNkR5T2lqdE9vdDRkQkxNN2Fi?=
 =?utf-8?B?SFRNK1pBZ0NvYkpGVWN0emZLTloxV2luWFdLMU1lWFhLS05IMGRVQkR2TVV6?=
 =?utf-8?B?SjNWMjltZVV3c2NGWXBicmg2QnNvS1J1Qys3WGV3RW12cUhOMHJXb0R5Yjln?=
 =?utf-8?B?czE3ZGNWVERVUTZNZzIxcGlLTlVHN2prY3BObnhISUM1Vjh6RHRZVUROd1NZ?=
 =?utf-8?B?V2Y0bXJCQUpOR0ZHKzdqVDBmdHlpNXJuS3JOUlJJV0dPSlVaekpwb05HeWVV?=
 =?utf-8?B?ZUpmeGp4OVBEZXg0cFVST3orQlJ0NFFQMzZNbDR3QkdXS1FiY013T25iSzAx?=
 =?utf-8?B?VWZBWXpKdDdnZnNvYzNVTSs1YnRVTmRWejh4eGVNZi9KYnZiNHRLS1kwL2lw?=
 =?utf-8?B?Z1RFWSsvdXAwK3BBM3dQUUFTaEUrSjArUTllU05iNmxPZVhOcDN0dFR3RkU3?=
 =?utf-8?B?aVlZU1pPalV2K0lkTEc2T1hQVldtTHZPMmFaMG1RMU1KSTRtSnFOTU1RQ0Vv?=
 =?utf-8?B?MlhjWnk3cGZ1Ky9UNS8wRERZRzF3QTFXd2RYdVZyZkNJY1VRVm9XL0Z2RVBu?=
 =?utf-8?Q?1Tkv39ZxUboHP5scRb9O6b8TkuORStZTMXhQPBv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f60ac8-a1f6-4792-3e9c-08d9745b04d2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 13:00:52.2588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nq9gojN8REcZ54ywumYHlnOfe31x1Yc7hDgpBBTU14I6OW0NtjmgatQvdoB5xpu8zlknBIpP/vyXgrDETCKOMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7086
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Heikki,

On 9/10/2021 3:38 PM, Heikki Krogerus wrote:
> On Fri, Sep 10, 2021 at 03:05:16PM +0300, Laurentiu Tudor wrote:
>>
>>
>> On 9/9/2021 5:01 PM, Laurentiu Tudor wrote:
>>>
>>>
>>> On 9/9/2021 3:16 PM, Heikki Krogerus wrote:
>>>> On Thu, Sep 09, 2021 at 03:13:47PM +0300, Heikki Krogerus wrote:
>>>>> On Tue, Sep 07, 2021 at 06:59:18PM +0300, Laurentiu Tudor wrote:
>>>>>>
>>>>>>
>>>>>> On 7/26/2021 10:59 AM, Laurentiu Tudor wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 7/20/2021 1:27 PM, Andy Shevchenko wrote:
>>>>>>>> On Tue, Jul 20, 2021 at 12:22 PM Laurentiu Tudor
>>>>>>>> <laurentiu.tudor@nxp.com> wrote:
>>>>>>>>> On 7/19/2021 3:22 PM, Andy Shevchenko wrote:
>>>>>>>>>> On Mon, Jul 19, 2021 at 03:00:17PM +0300, Laurentiu Tudor wrote:
>>>>>>>>>>> On 7/16/2021 8:21 PM, Jon Nettleton wrote:
>>>>>>>>>>>> On Fri, Jul 16, 2021 at 2:17 PM Andy Shevchenko
>>>>>>>>>>>> <andriy.shevchenko@linux.intel.com> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> On Fri, Jul 16, 2021 at 01:16:02PM +0300, laurentiu.tudor@nxp.com wrote:
>>>>>>>>>>>>>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> software_node_notify(), on KOBJ_REMOVE drops the refcount twice on managed
>>>>>>>>>>>>>> software nodes, thus leading to underflow errors. Balance the refcount by
>>>>>>>>>>>>>> bumping it in the device_create_managed_software_node() function.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The error [1] was encountered after adding a .shutdown() op to our
>>>>>>>>>>>>>> fsl-mc-bus driver.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Looking into the history of adding ->shutdown() to dwc3 driver (it got reverted
>>>>>>>>>>>>> later on), I can tell that probably something is wrong in the ->shutdown()
>>>>>>>>>>>>> method itself.
>>>>>>>>>>>>
>>>>>>>>>>>> Isn't the other alternative to just remove the second kobject_put from
>>>>>>>>>>>> KOBJ_REMOVE ?
>>>>>>>>>>>
>>>>>>>>>>> Or maybe on top of Heikki's suggestion, replace the calls to
>>>>>>>>>>> sysfs_create_link() from KOBJ_ADD with sysfs_create_link_nowarn()?
>>>>>>>>>>
>>>>>>>>>> _noearn will hide the problem. It was there, it was removed from there.
>>>>>>>>>> Perhaps we have to understand the root cause better (some specific flow?).
>>>>>>>>>>
>>>>>>>>>> Any insight from you on the flow when the issue appears? I.o.w. what happened
>>>>>>>>>> on the big picture that we got into the warning you see?
>>>>>>>>>
>>>>>>>>> I encountered the initial issue when trying to shut down a system booted
>>>>>>>>> with ACPI but only after adding a .shutdown() callback to our bus driver
>>>>>>>>> so that the devices are properly taken down. The problem was that
>>>>>>>>> software_node_notify(), on KOBJ_REMOVE was dropping the reference count
>>>>>>>>> twice leading to an underflow error. My initial proposal was to just
>>>>>>>>> bump the refcount in device_create_managed_software_node(). The device
>>>>>>>>> properties that triggered the problem are created here [1].
>>>>>>>>>
>>>>>>>>> Heikko suggested that instead of manually incrementing the refcount to
>>>>>>>>> use software_node_notify(KOBJ_ADD). This triggered the second issue, a
>>>>>>>>> duplicated sysfs entry warning originating in the usb subsystem:
>>>>>>>>> device_create_managed_software_node() ends up being called twice, once
>>>>>>>>> here [2] and secondly, the place I previous mentioned [1].
>>>>>>>>
>>>>>>>> This [3] is what I have reported against DWC3 when ->shutdown() has
>>>>>>>> been added there. And here [4] is another thread about the issue with
>>>>>>>> that callback. The ->release() callback is called at put_device() [5]
>>>>>>>> and ->shutdown() is called before that [6]. That said, can you inspect
>>>>>>>> your ->shutdown() implementation once more time and perhaps see if
>>>>>>>> there is anything that can be amended?
>>>>>>>>
>>>>>>>
>>>>>>> Will do, thanks for the pointers. It could be that we mess something out
>>>>>>> in how we use the driver model.
>>>>>>>
>>>>>>
>>>>>> Quick (and late, sorry) update from my side. I've spent time on
>>>>>> debugging our bus, did found some issues but, at least for now, none are
>>>>>> related to sw node.
>>>>>> In the mean time, I noticed in the swnode code that
>>>>>> device_add_software_node() calls software_node_notify(KOBJ_ADD) while
>>>>>> device_create_managed_software_node() doesn't. Updating [1] the later
>>>>>> with the call to software_node_notify(KOBJ_ADD) does seem to fix the
>>>>>> issue I'm seeing.
>>>>>>
>>>>>> Could this be a problem? Any comments appreciated.
>>>>>>
>>>>>> One more thing perhaps worth mentioning is that, at least for now, there
>>>>>> are few uses for this device_create_managed_software_node() api,
>>>>>> mentioning here a couple of them:
>>>>>>  - arm64 iort code - this seems to be triggering the issue i'm getting
>>>>>>  - dwc3 usb - Andy reported similar issues here, maybe the issue is common?
>>>>>>
>>>>>> [1]
>>>>>> @@ -1113,6 +1125,15 @@ int device_create_managed_software_node(struct
>>>>>> device *dev,
>>>>>>         to_swnode(fwnode)->managed = true;
>>>>>>         set_secondary_fwnode(dev, fwnode);
>>>>>>
>>>>>> +       /*
>>>>>> +        * If the device has been fully registered by the time this
>>>>>> function is
>>>>>> +        * called, software_node_notify() must be called separately so
>>>>>> that the
>>>>>> +        * symlinks get created and the reference count of the node is
>>>>>> kept in
>>>>>> +        * balance.
>>>>>> +        */
>>>>>> +       if (device_is_registered(dev))
>>>>>> +               software_node_notify(dev, KOBJ_ADD);
>>>>>> +
>>>>>>         return 0;
>>>>>>  }
>>>>>
>>>>> That should be fixed indeed. Please send that after -rc1 is out.
>>>>
>>>> I mean, resend :-)
>>>>
>>>
>>> Right, actually I just noticed that this is the fix you suggested last
>>> time we discussed. :-) I forgot about it, sorry.
>>> There's still the WARN_ON() [1] triggered by the usb subsys, apparently
>>> happening only (!) in ACPI boot scenario, so +Lorenzo.
>>> I'll delay the sending a bit to try to understand what's going on.
>>
>> I've spent some time looking into this and it  turns out that in the
>> ACPI case, device_create_managed_software_node() ends up being called
>> twice, first here [1] and after that, in the IORT code here [2]. With
>> the proposed patch this causes software_node_notify(KOBJ_ADD) being
>> called twice thus triggering the dup sysfs entry warning.
>> Any comments / ideas welcomed.
>>
>> [1] https://elixir.bootlin.com/linux/latest/source/drivers/usb/dwc3/host.c#L111
> 
> I think the problem here is that the secondary fwnode get's replaced
> because the primary fwnode is shared. Can you test it with this, just
> to see if the problem goes away:
> 
> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> index f29a264635aa1..e4b40f8b8f242 100644
> --- a/drivers/usb/dwc3/host.c
> +++ b/drivers/usb/dwc3/host.c
> @@ -76,7 +76,6 @@ int dwc3_host_init(struct dwc3 *dwc)
>         }
>  
>         xhci->dev.parent        = dwc->dev;
> -       ACPI_COMPANION_SET(&xhci->dev, ACPI_COMPANION(dwc->dev));
>  
>         dwc->xhci = xhci;


Thanks for looking into this! Yes, this does make the issue go away.

---
Best Regards, Laurentiu
