Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7AF3D54BE
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jul 2021 10:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhGZHS4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Jul 2021 03:18:56 -0400
Received: from mail-eopbgr60040.outbound.protection.outlook.com ([40.107.6.40]:24640
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231940AbhGZHSz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Jul 2021 03:18:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J51n72Kp3EK2LKMDkdJ2e0O+mo2M4R51UQVZQPviXxkCGJAZNZ/wWks8/s8tsj6VjS3zppxHTDOkVfuXGWoSKHYMVt/TxUnX/s0PoVz4JbrD9lqWV9TJ7JGyMeZGMKM0TzwCqNxTXQ1POwmUkxYhCXXGkWK7bOtGpAszxNnB9Q4ORQXHqtAI8gq7cn9EbOPVn3EPQUz7eKhxtSw9/Kmoz80pJBmP+sIEyyWm+5vr6T/QfNs1QJZMHTstap1vSEzaNbIBIPYD9ttTQr3Sz7yxVo5PvISFTGGy1p4OBLdqfBs4ibMgYo8zvjI3YQpCVBFg3wmm0mSJFMJ0BY4sEoFXog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2ldD/eRJgSKI5DgrZszZ9XFsTtt2flWHW5DnOWRDFg=;
 b=cRtsj+YP6u7GFPM8mxrqKzQ0YEIGmclfl/Uzrdk+1glAi4Dth4LXhmplcCcDJKdZOt1Fy9QXIFd/e6JaWebXwMXtwbXMcmRNb5t+47aiaflLk7KdkHbGvsu1DjavUA3XsIHNvK0OUtVjQepoblSj64IFLkGr40qP9zAFYUkobUAvqr4FfKNh4ZCRR3qkVitqvJsRuIXYySatSUe2Scex2XONF0H/hnQw9jNd7l+xYVwnVYyTyMy+Em/38GO5FAWOuEjrHryRYWNlWcmL6SGHWo0Mllz0gGXrbVONvb05AjtgIc26Eg5HLWBMXJpst/20k8BsDcTgreDKDC4jKHgAtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2ldD/eRJgSKI5DgrZszZ9XFsTtt2flWHW5DnOWRDFg=;
 b=WqSmjFlQPKT/9dwA/5eZ2bY2T5SvDda5Ufa4LN55mCmiK926W612p2kd9FbEvuUHIMFx/lf7wcYSjz73GkzGwp7QySQwwJ1OM0Jpk6nr1fV1r+/YewA+UAzzdz8+hipamm1rmBoecuEnEnrEPqbPIwaRo/7g87HzL21jmyMjfxA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR0402MB2816.eurprd04.prod.outlook.com (2603:10a6:800:b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Mon, 26 Jul
 2021 07:59:22 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f%5]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 07:59:22 +0000
Subject: Re: [PATCH] software node: balance refcount for managed sw nodes
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jon Nettleton <jon@solid-run.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210716101602.1891-1-laurentiu.tudor@nxp.com>
 <YPF40t5bhgTFM2wK@smile.fi.intel.com>
 <CABdtJHuKyybhJazpAc8KT54ELtZ319rdb6CbSH6zB5x3NhgtAw@mail.gmail.com>
 <bb009f85-687e-d560-9cc5-1ac4f586a6bd@nxp.com>
 <YPVufjevu5WaaIxQ@smile.fi.intel.com>
 <2a0f7fa6-b164-eeb4-118a-acd57d79a484@nxp.com>
 <CAHp75VcYt+VQq4jp9JdkA4EpGqtks2sP-NRkfSbGj+-Vn5ke=g@mail.gmail.com>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <c2186f2c-8be0-6f44-e442-8cb8cbd5f2c2@nxp.com>
Date:   Mon, 26 Jul 2021 10:59:20 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <CAHp75VcYt+VQq4jp9JdkA4EpGqtks2sP-NRkfSbGj+-Vn5ke=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0072.eurprd03.prod.outlook.com (2603:10a6:208::49)
 To VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.109] (86.123.59.131) by AM0PR03CA0072.eurprd03.prod.outlook.com (2603:10a6:208::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend Transport; Mon, 26 Jul 2021 07:59:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b43c454-fb18-4b29-338c-08d9500b4787
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2816:
X-Microsoft-Antispam-PRVS: <VI1PR0402MB2816B226108A9409E0E12DABECE89@VI1PR0402MB2816.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pO5VwKsrFKGH8StoQ1xFbaxQ3S96wiGTCMIpFg7fEUTA9Dh3KWgs2dBgrFoE6ePs8gQtLJlydop6LXUI3b3qIhiOELR9AgUS3dPn2NPIu/o9ReSqdyBA5T9dAAkyluQUNrAW2TAsLzQXoV8sa8ncSLIOni/3lVdRZMwcGuoJR/gzJeFUyLk8qfGUDuoXSwAuBO+IaJOA13GLZU/AWasTYjv7J0VDu/zIIjHhGelTixX9c55Za3sC5JGMe0NR2+YRSMSmkWZn6GwAIe5u9aNEsASco78+jXcIxOtmOPJ2aR1sN/AaXP98erET33H4WA0IGNKJl1Bh4+kkOCQWO+byPt7q+Aw2XjRlw1HKwzGbbgL2sic1YjBhHFXSXfhtPhedtqHTVMUWEcZWAmgsVRcg0epVpmugMXxjDFpKn2m0PxlndCDqcOKw2Kxmo7xwSJuN0EpO/EofdoHiVlbCySaDGizr2NsDCaUON8xOLDwU9pkbVQiHp3fLATmvadVlEJ190M2/pMG8cgJgYI2f2nPwZpI+28vJp6nn/ymLG+G3Vok/KL104j9OoMH5kr7sPcf+0zAvEFcwSzgSrnzcHZtc0MQmgvyhlKhZbZDQI+IRIGafFetAzDLycuyW2mid+Jtks3bJPt/yRfxoI0rP7S214ju6Rj36R8/Z7kYzhMJ3UjzkQxKmsKAVLahsxhUT6wWNOyR+Nc2EstULn7YD2EvmFuC+Byg8+ZMfaVHgzAfNxLk476F1z63GtGtk/Di8gHl+qfAdFEcKHC96IcZExVG0ZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(376002)(346002)(136003)(396003)(186003)(956004)(38100700002)(2616005)(38350700002)(66476007)(66946007)(316002)(52116002)(2906002)(6486002)(478600001)(53546011)(26005)(16576012)(66556008)(44832011)(86362001)(6916009)(31686004)(31696002)(8936002)(8676002)(83380400001)(5660300002)(54906003)(36756003)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGd4anRqelZsL2V2dmFVbEJrL294aEVMclU3b1ZRNUpTWGQ3RHJ4Rjh3ekNy?=
 =?utf-8?B?WEZpc1pWOUVLQzRCOFltRkFUcEFaV3g2cWpvNng1NzVGSE1LRUNsbVZKbWVI?=
 =?utf-8?B?a0ZTN1EwQm4xbENqbWRJUENoOEpUYXRmYWJEcTQrYTgweVdhMFd5bFJsL3k4?=
 =?utf-8?B?blF5RnNKT09wd0pZM0Jwd2dEazhITHI4d3lydVM2c0hPYlVZQlRmUEVmN2Nh?=
 =?utf-8?B?SkFZNDlSeTlDMThlTDdLZzJKL2JYeEhtQzRQMStmTFNTSXNyQ2FQREdMVjQ5?=
 =?utf-8?B?YlZPbUJsOEE2eU1FUDlrdFEyRFE0YTFCaTFTU3FxUmJyU1ZFb2pkRjRrR2hP?=
 =?utf-8?B?dFhOR04vNzZHSG5nQVNPckNTM2F1MjVTQ0JnUno3OUZSTUw1ZFVkZFBwVHRq?=
 =?utf-8?B?RWJ1d2JDL2FpYTlhR1MwcitOaWNLRDdDaFAzcUVOYWdCeHN0bFdmY1dacTB3?=
 =?utf-8?B?eU43bDNZYVpUQW1wRTlVUHNFQThQbTVhMUI2N1lYN0lqNFljSTBtRTVtK3hU?=
 =?utf-8?B?VUgreDdIZTZYcXprdW54Y3ljWUxjeC80bDBhYXA2ZC9rbkNUS01lUWFTSk9h?=
 =?utf-8?B?blhKYTU3MFJaRUFndkxWR2YyNEhBZzVlekVrQ2o1V01WYWsrU0Vic3NJY1dr?=
 =?utf-8?B?LzhqNVlCSzczZXUzNlhhaGFzZG9BTmFBVVVtQURzT1NwNzBKWlRpQzFUZk1h?=
 =?utf-8?B?SUhJNTRZMEhFZ0pCdWpmVnhTWmRmMDdlOGYvWFEwMkNnYUNWTU1KK1FDQUlz?=
 =?utf-8?B?eGZJU1VPZVQzaDVvclBSNFR5b0xreHRXMFh2UFN0RndPWnpUSitxMmZwcldj?=
 =?utf-8?B?bHZPbmRNQ0l2bDA5VzdmdWdWMXJwMnBsL2ZTeWRyREVGREtQTFA1c3g2T09L?=
 =?utf-8?B?TWZmWW1hdE53dG1jVzNrU1p3K1Y1VVNzOTRhN1RkM0RKUjRibWVMMlAwKyt4?=
 =?utf-8?B?bXdUcGNKZjVUdGdza1c1aHozR2hVL0kzZUZCQTl5Z2EzSjl1eTJ1RVdlVDlX?=
 =?utf-8?B?QlpqYlFHMkpCcmlTMzFkZy9nVzJ4TmNYamZMTWcyYjJ3ZU9mVU1vWFh4S085?=
 =?utf-8?B?azRQZFhlbVh0anpXVmhTTHZHUmlHQVYzZWlFLzZXWFNqcGlFeEdid0dXdGxK?=
 =?utf-8?B?LzY0c2pPUmV1UW5mdXBWMVcrZ0dXUkFFOGd1RzAxenBqczMwc1JJYnJLd21M?=
 =?utf-8?B?M3VWWTFZOFFiMDVaekd5emNaSkFpajErajU0a2hveCtDV2l1R2FBSmFtSnJY?=
 =?utf-8?B?STlpNDlweElYdWpiVWF6NUswem5XTGIxQlg1SUV1Z2liM1RBdzhpSHZqMlhu?=
 =?utf-8?B?QndtRUZNVzA1WXdBSm15ZGVLZmd2M1hjZ1N2SWhHVDRCYm1yOWNyZUhPTEMz?=
 =?utf-8?B?SnRpUkJISlEwTGlEdWV1QlVFZkViZjJRRlgrbjJCUk1QQkkwMCsvOXB6aW1k?=
 =?utf-8?B?WnFKd0VBTWxpZjJ6aTJIUHp3TVJOS2JVQjNteUVSTjRmOEpXRU9jSjRNbmwr?=
 =?utf-8?B?TTRwOGxodXNzRUswOXlrdEdvdU10Z1puR3oybUUwMVdIVk1aem1WV2tvcmJy?=
 =?utf-8?B?b3AzSGppZHkwZlRGcWNSVkpBdFRZU3BhQjVCT3l6cFBjYzlXMGY2U3JONS9n?=
 =?utf-8?B?U2xOSjd1Z1V4ODhZNmZxWDJBVFZJdHJoSTk4azdHY1kybXJuV3ZyM3VnMUNS?=
 =?utf-8?B?dGZ1c2h4VkFrQlpjbVYrSTQxMVRVNEtCemoybWh2R0xndzQ5TnRZNnpXY0Qr?=
 =?utf-8?Q?HwUttHnEcgnENeVJdoPJFfB0uixP4bR4jknmatx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b43c454-fb18-4b29-338c-08d9500b4787
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 07:59:22.6160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: avG8N5B6TSfNWdEuGqzVFmzoEWBPv8O/3QxMZ6QsFHXIqRPWDqreGsqwunZa8r1xqqTC5word6lP3p7AS9AF5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2816
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 7/20/2021 1:27 PM, Andy Shevchenko wrote:
> On Tue, Jul 20, 2021 at 12:22 PM Laurentiu Tudor
> <laurentiu.tudor@nxp.com> wrote:
>> On 7/19/2021 3:22 PM, Andy Shevchenko wrote:
>>> On Mon, Jul 19, 2021 at 03:00:17PM +0300, Laurentiu Tudor wrote:
>>>> On 7/16/2021 8:21 PM, Jon Nettleton wrote:
>>>>> On Fri, Jul 16, 2021 at 2:17 PM Andy Shevchenko
>>>>> <andriy.shevchenko@linux.intel.com> wrote:
>>>>>>
>>>>>> On Fri, Jul 16, 2021 at 01:16:02PM +0300, laurentiu.tudor@nxp.com wrote:
>>>>>>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>>>>>
>>>>>>> software_node_notify(), on KOBJ_REMOVE drops the refcount twice on managed
>>>>>>> software nodes, thus leading to underflow errors. Balance the refcount by
>>>>>>> bumping it in the device_create_managed_software_node() function.
>>>>>>>
>>>>>>> The error [1] was encountered after adding a .shutdown() op to our
>>>>>>> fsl-mc-bus driver.
>>>>>>
>>>>>> Looking into the history of adding ->shutdown() to dwc3 driver (it got reverted
>>>>>> later on), I can tell that probably something is wrong in the ->shutdown()
>>>>>> method itself.
>>>>>
>>>>> Isn't the other alternative to just remove the second kobject_put from
>>>>> KOBJ_REMOVE ?
>>>>
>>>> Or maybe on top of Heikki's suggestion, replace the calls to
>>>> sysfs_create_link() from KOBJ_ADD with sysfs_create_link_nowarn()?
>>>
>>> _noearn will hide the problem. It was there, it was removed from there.
>>> Perhaps we have to understand the root cause better (some specific flow?).
>>>
>>> Any insight from you on the flow when the issue appears? I.o.w. what happened
>>> on the big picture that we got into the warning you see?
>>
>> I encountered the initial issue when trying to shut down a system booted
>> with ACPI but only after adding a .shutdown() callback to our bus driver
>> so that the devices are properly taken down. The problem was that
>> software_node_notify(), on KOBJ_REMOVE was dropping the reference count
>> twice leading to an underflow error. My initial proposal was to just
>> bump the refcount in device_create_managed_software_node(). The device
>> properties that triggered the problem are created here [1].
>>
>> Heikko suggested that instead of manually incrementing the refcount to
>> use software_node_notify(KOBJ_ADD). This triggered the second issue, a
>> duplicated sysfs entry warning originating in the usb subsystem:
>> device_create_managed_software_node() ends up being called twice, once
>> here [2] and secondly, the place I previous mentioned [1].
> 
> This [3] is what I have reported against DWC3 when ->shutdown() has
> been added there. And here [4] is another thread about the issue with
> that callback. The ->release() callback is called at put_device() [5]
> and ->shutdown() is called before that [6]. That said, can you inspect
> your ->shutdown() implementation once more time and perhaps see if
> there is anything that can be amended?
> 

Will do, thanks for the pointers. It could be that we mess something out
in how we use the driver model.

---
Best Regards, Laurentiu
