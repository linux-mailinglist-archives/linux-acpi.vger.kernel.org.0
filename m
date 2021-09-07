Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC5C402C48
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Sep 2021 17:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbhIGQAb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Sep 2021 12:00:31 -0400
Received: from mail-eopbgr80079.outbound.protection.outlook.com ([40.107.8.79]:53550
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233451AbhIGQAa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 7 Sep 2021 12:00:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwyPVtaUHplgxSJLWm2dco/tc582HB5wTJgkyHJrdESsDDCZoD1U5n50eThwEEfmR/mMCG7iJIQ+bMmB46zIpsQhqfyTJR/CPsrfjxiANmInG+ZNURqeOXDBoo4Wc9zBBFoN+A7a2ImErsVv1AjNlMJe/MwAZC7Q4nzqCzkwndeT2QrSZP/sbgsNbsOc6TvdUj8QMecyBHKodpbvWtJQuwuH2r5rb5YXP8k73nrVaTS8/9wqkia1KDZYH2cjhhS2s6BBnZNxn8a/+PUd13rBWOgni1vZb3YjqCbwcpfo3DIgPEesqEZQgj+uEVxKOuU+GNXmhz6VTmS2WdWce0uvpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=oQW8hvStZPW1T+5HZNOeARrXXn+0cd7ystpvjn6MMko=;
 b=Z0pVWoLR7zHkH+8wCrKDBQY0edz0dCxgUhuDhanzYO7pSwpj8S+S5DVCPoSwkFZOOLar7XpVzIEDiaPmmLtAkdsc/EUp/YvfXkcOQopZD1ZpWDOXA6nuVlesl0BnyDOgYzipjnvKrg92xs/2QvM4ueU+5GwnsK1E0X9y6k90gwESd80jDXNcXI2aAxmN8vgg4bpVKlL/nRk3xTPS+yFLVffJckGwoXgBotMfJ9c3FsjsdSytThxsqEX4xgMEn+CBPAWa2OtgLdyMr/RiBel4K/u+wM+pQqWHFXQUFqLc9wSR5cvgl9Gxp7igkuZ8RNAzOHYQ+TzhpsqhDaKIULlRNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQW8hvStZPW1T+5HZNOeARrXXn+0cd7ystpvjn6MMko=;
 b=q9xJ8uc0RYxJAiyPO5M4FQPE17Oc2FIT5dm4/aasKlFTCjiw+JLtcIFVU8D998Gs6zrysimmm1GS5cr2EOsfSEOgKy0zZ+x0Y9mpU/IL3GWT3XIW6NJVa292MOypp/Wk+4t0Ml0xF3xmLBO8e8aY5rOrZYSg1eOwnGvMdDErhbY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB7118.eurprd04.prod.outlook.com (2603:10a6:800:127::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Tue, 7 Sep
 2021 15:59:21 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::10e6:799c:9d34:fc2d]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::10e6:799c:9d34:fc2d%6]) with mapi id 15.20.4478.019; Tue, 7 Sep 2021
 15:59:21 +0000
Subject: Re: [PATCH] software node: balance refcount for managed sw nodes
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
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
 <c2186f2c-8be0-6f44-e442-8cb8cbd5f2c2@nxp.com>
Message-ID: <2485ac73-6df6-3939-5ee5-ef650d951054@nxp.com>
Date:   Tue, 7 Sep 2021 18:59:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <c2186f2c-8be0-6f44-e442-8cb8cbd5f2c2@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0096.eurprd05.prod.outlook.com
 (2603:10a6:207:1::22) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.103] (79.113.50.225) by AM3PR05CA0096.eurprd05.prod.outlook.com (2603:10a6:207:1::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Tue, 7 Sep 2021 15:59:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07291a11-354b-42d1-cfc1-08d9721874bb
X-MS-TrafficTypeDiagnostic: VI1PR04MB7118:
X-Microsoft-Antispam-PRVS: <VI1PR04MB71187A836E0CA6C9B391E758ECD39@VI1PR04MB7118.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g7BYS9+I8492CRhqh4KkMF5yR+6oUZ99tTvl2WznnPNQCeWH6tnmfouUQCFLja+JXYzbgbNOcNIUdwj58L5O/oqR6TEXkz8KO57sPNjrxcAexqdywwgmX9m8qzToU4LEOWcEVH/kjfXi1hCJS7q1oIai55tsq4XnLWh5FEu2NX+ogiCUvhUbbdSHDUEC++jzfV53n9Ved7TbmQ+t0KxJ+T4qZn2l4wqQYE3EIar7l8SpHPjU2QTpEy04gg7L+XBM04Jp4NfEzz88b+P2urQDtF1f7OlfBbEFrVxN7rXTuszwOeokPlEhK/2jEqBOBHNxrU1lTjtnp6RhkVx4yjj81mLiZBTesVe93DM8tOQ5h94sguxVbS6LVx/9c/jk0Os7GfkGhy4/Cdy18PNs5QVNQOjgVdg4N2C6Zrod3TPGE+I8OqNdwbPvVk0VuQtGCin3Vu8gLNyZU0VlA7WkT842lDIyrYpZKmU12H61XRaPJhb81YpuE8s48w/chH+tlkp5/D7AHbgcdfuhitcaVXe2/hYmf6US7CCn6SY/GFlXaakvNmZ0erIkoqea79HOSupCPEDGcnaUbNTajcCNWC5hTU+elQz6rYH/WG2D4AeWKjvsBz31eEd10eM0spkjB/y2cqLIkPOdmpBOTzYX6iEhK/BORh+j95QH/jAHQl6Wyyf/3y9iUXUqoV/AzyK6KJFFO2Bj8tBpd/MmBicUahQ2ONOoC9jMcmPxGz1hAC5N1yF94F12c5z7rh+i5BVD3PeD8KV6uL/8SMhhzdRPsUTnYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(38100700002)(38350700002)(2906002)(2616005)(53546011)(44832011)(956004)(31686004)(66476007)(66556008)(66946007)(83380400001)(6486002)(54906003)(26005)(52116002)(8936002)(186003)(5660300002)(316002)(16576012)(6916009)(86362001)(4326008)(31696002)(36756003)(8676002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0FiNFBwVTNXamd6S2NCQ3p3ME1tWmh2Vnl1N2lIR2ZVWkZ5YUNuWXVsZUtw?=
 =?utf-8?B?emk0UTUyb2FHSHJBbVBrNFozM2VNSmtXM3Frd2l6blUxSTlrMm80Sk9CaHdM?=
 =?utf-8?B?N2h0R2svKy9tNWJMK1YrVTBCd2ZwaVVJV053UWRjR2k1cUw0YzNXM3FoVTJQ?=
 =?utf-8?B?K3dIRjAzUDlvZDVEWHJqNDgvMnFhdE5FRkQrdzhyckZiQ0o2ZFJUcEZ6NDJE?=
 =?utf-8?B?QVNqZXBNWW1URk1PSTl1eUF5blF2VWhMM1UwVmtBMm5oT2RQUExzNVg3anpt?=
 =?utf-8?B?cFdlNVIwQ3NXUFFzYXR5L2Z1YTByZnNDUU4xQU1LVmVjTGxzOG83YkhOTjNG?=
 =?utf-8?B?WGhiazZ6dmJUWExtOTVFUXZ1akRaUXU3aHRUZndESHNBay9yazhtc0kwbUpN?=
 =?utf-8?B?aWxUTEhMVmtoMFRET3ZETUUrdlhXbk9uMFNrQXIvM2d2cXVxTU1CQmxjV1FP?=
 =?utf-8?B?elJwcHBkdTBiQkVLeWJuenJSKzhhK3BhN3lQUTYvUjdzMVVuSUtWdFB2RzFr?=
 =?utf-8?B?UlozeVU4UkdrajRSOHplaHd5NDhpcy9wYWx1MTBNVG5PYTAwR2JEbkJWakth?=
 =?utf-8?B?VkUvWmJjWVlkclc0VmpGL3hDMm5vWHplZHpzSy9Hci9GdzVZQ2xHQlc2TWdP?=
 =?utf-8?B?M3hoeVI3WG9BNk14Q1EzUzdGUkdVSVJQMXZuSmFhTkVjZjFTRkp3L0IyRlZK?=
 =?utf-8?B?TkNGR25BMmpYOWZqemVtdm15azZCdXJhY0s2SEc0S3JLOGwrOGcwOTUyZFUv?=
 =?utf-8?B?N2ZjS1BDYmE0QjZCWGNNZFVPeE10TW1yQ1B4ekFOUE1aei9NS09CVVJZRW9G?=
 =?utf-8?B?SXIxNFIyd0pvTkpSc3NmNk85LzJ3YXpYRml0WUdkWHcvVUJWWGh6WjFQZlBk?=
 =?utf-8?B?em1jdno2d3JGWG1OOHA0aDd0TWJHc1dyMlRyTVRkbEtzREZ0NFAzVnkzaytv?=
 =?utf-8?B?bWYyczFXTWc5UzQ0MTIzbEE3b3pFMFk1elVnMUl4K2o3U3k5N0FmcVpZQVpL?=
 =?utf-8?B?ZXFxZEJRMWJpNS94bzBaN1AzRGFBQVF4VGxMYUZtMlBKMmlPTU9Id3FUQjJq?=
 =?utf-8?B?Ymo3Mk9pK1praUlYTlorM0s1MEtFU01DSldBeXQxTkFKK0xmQVpJZzBKQit6?=
 =?utf-8?B?NDRudnJyVmVvYU9pTnJWck4wUkhmcHJqOElPOXFiaUttSjd6MEpaTjAzNURh?=
 =?utf-8?B?cThiYWdQRW5oVWNBa0VFdE92Y0FvKzZSaXpqVDdqcG8wNDN4dmhRdnIzcFFV?=
 =?utf-8?B?WEdBVkh6TnFnU01EdFgzVnIrWjdvS2xBSit0Y2tNL3NUcDV0NW12YUZMNGZP?=
 =?utf-8?B?Q2hLV0tUeE5rMlIzNm94Uzh4VEEyY1oyTUNuK3g4RHRWaWpSK2dQTDVEcmZC?=
 =?utf-8?B?OG4ra3MwaSthNDJ6YnU2LzJzeWNMaFVUVkRHQVNGcHY5NHdKL1dXVUtzOWdk?=
 =?utf-8?B?SEpXNThlTUphLy9vUVNMczRORC9uTG56d0RGcXVXWXVkclF3azhOZ1ZPK0ov?=
 =?utf-8?B?RW12ZnJmUWdvL0pIT09hSkZZdjl4WGNnbkdjYjlkaXI3eHhEa0h5TEJaMGpv?=
 =?utf-8?B?eUUrSXRQYTJFc1FUL3QyNWsvTHc4SDRKWHYzNml6SDEzODQ3bnQ0QVQ2S3Qy?=
 =?utf-8?B?SCtWSitpcGZNS2NUMVA2cHR0VWswSDFsZDJ6K1hyaWo5d2xEd0g0Y21Lc20w?=
 =?utf-8?B?Q2gxQ3ptL3MyRW4zb2g1a01wOHJ1ZnJBT0FlcE9kL2RWQm9kWUkvZnVGektz?=
 =?utf-8?Q?juYzvdMkesQNpi6hlu+4dqRTI6ArRKdYemS3hUb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07291a11-354b-42d1-cfc1-08d9721874bb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 15:59:21.5221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oIz+AYjzvbdg50Z4Kk651JxHSOdM7mhmXPQwMS1bi/04T2FqgvS/6lXiy7GWg/9BzO/6DwZ3HdXZWW/HisUFAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7118
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 7/26/2021 10:59 AM, Laurentiu Tudor wrote:
> 
> 
> On 7/20/2021 1:27 PM, Andy Shevchenko wrote:
>> On Tue, Jul 20, 2021 at 12:22 PM Laurentiu Tudor
>> <laurentiu.tudor@nxp.com> wrote:
>>> On 7/19/2021 3:22 PM, Andy Shevchenko wrote:
>>>> On Mon, Jul 19, 2021 at 03:00:17PM +0300, Laurentiu Tudor wrote:
>>>>> On 7/16/2021 8:21 PM, Jon Nettleton wrote:
>>>>>> On Fri, Jul 16, 2021 at 2:17 PM Andy Shevchenko
>>>>>> <andriy.shevchenko@linux.intel.com> wrote:
>>>>>>>
>>>>>>> On Fri, Jul 16, 2021 at 01:16:02PM +0300, laurentiu.tudor@nxp.com wrote:
>>>>>>>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>>>>>>
>>>>>>>> software_node_notify(), on KOBJ_REMOVE drops the refcount twice on managed
>>>>>>>> software nodes, thus leading to underflow errors. Balance the refcount by
>>>>>>>> bumping it in the device_create_managed_software_node() function.
>>>>>>>>
>>>>>>>> The error [1] was encountered after adding a .shutdown() op to our
>>>>>>>> fsl-mc-bus driver.
>>>>>>>
>>>>>>> Looking into the history of adding ->shutdown() to dwc3 driver (it got reverted
>>>>>>> later on), I can tell that probably something is wrong in the ->shutdown()
>>>>>>> method itself.
>>>>>>
>>>>>> Isn't the other alternative to just remove the second kobject_put from
>>>>>> KOBJ_REMOVE ?
>>>>>
>>>>> Or maybe on top of Heikki's suggestion, replace the calls to
>>>>> sysfs_create_link() from KOBJ_ADD with sysfs_create_link_nowarn()?
>>>>
>>>> _noearn will hide the problem. It was there, it was removed from there.
>>>> Perhaps we have to understand the root cause better (some specific flow?).
>>>>
>>>> Any insight from you on the flow when the issue appears? I.o.w. what happened
>>>> on the big picture that we got into the warning you see?
>>>
>>> I encountered the initial issue when trying to shut down a system booted
>>> with ACPI but only after adding a .shutdown() callback to our bus driver
>>> so that the devices are properly taken down. The problem was that
>>> software_node_notify(), on KOBJ_REMOVE was dropping the reference count
>>> twice leading to an underflow error. My initial proposal was to just
>>> bump the refcount in device_create_managed_software_node(). The device
>>> properties that triggered the problem are created here [1].
>>>
>>> Heikko suggested that instead of manually incrementing the refcount to
>>> use software_node_notify(KOBJ_ADD). This triggered the second issue, a
>>> duplicated sysfs entry warning originating in the usb subsystem:
>>> device_create_managed_software_node() ends up being called twice, once
>>> here [2] and secondly, the place I previous mentioned [1].
>>
>> This [3] is what I have reported against DWC3 when ->shutdown() has
>> been added there. And here [4] is another thread about the issue with
>> that callback. The ->release() callback is called at put_device() [5]
>> and ->shutdown() is called before that [6]. That said, can you inspect
>> your ->shutdown() implementation once more time and perhaps see if
>> there is anything that can be amended?
>>
> 
> Will do, thanks for the pointers. It could be that we mess something out
> in how we use the driver model.
> 

Quick (and late, sorry) update from my side. I've spent time on
debugging our bus, did found some issues but, at least for now, none are
related to sw node.
In the mean time, I noticed in the swnode code that
device_add_software_node() calls software_node_notify(KOBJ_ADD) while
device_create_managed_software_node() doesn't. Updating [1] the later
with the call to software_node_notify(KOBJ_ADD) does seem to fix the
issue I'm seeing.

Could this be a problem? Any comments appreciated.

One more thing perhaps worth mentioning is that, at least for now, there
are few uses for this device_create_managed_software_node() api,
mentioning here a couple of them:
 - arm64 iort code - this seems to be triggering the issue i'm getting
 - dwc3 usb - Andy reported similar issues here, maybe the issue is common?

[1]
@@ -1113,6 +1125,15 @@ int device_create_managed_software_node(struct
device *dev,
        to_swnode(fwnode)->managed = true;
        set_secondary_fwnode(dev, fwnode);

+       /*
+        * If the device has been fully registered by the time this
function is
+        * called, software_node_notify() must be called separately so
that the
+        * symlinks get created and the reference count of the node is
kept in
+        * balance.
+        */
+       if (device_is_registered(dev))
+               software_node_notify(dev, KOBJ_ADD);
+
        return 0;
 }


---
Thanks & Best Regards, Laurentiu
