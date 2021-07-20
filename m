Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D883CF6BE
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jul 2021 11:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbhGTIkV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 20 Jul 2021 04:40:21 -0400
Received: from mail-eopbgr70055.outbound.protection.outlook.com ([40.107.7.55]:64945
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234171AbhGTIkI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 20 Jul 2021 04:40:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnIrjNUSMS1KWUuus5UAywcJJwypwV3hfepkbk74Nkr3OzWizotN00tXjFKwGBhs1g/03EWsEFgFa57+ucG9sp4Mtk4MRcht9ZPnj1s41rBEMskp/6+XkxQp4dtLnMEX3AthQZShEoJRnBkJhD8wXRgbfdGFUya/UqGKfDv94uXkeMzrFRm1HOz+6ZjhQKQJiCJdHWoz9+nFmTwyqFgXBBrJ2Pnfo2HGpW8ZkZDs34nTA8b8g5B0OX7PPLt/H+6RKCgV/h6AyuNkk2/EcA/z/5yDAgDIu3WtsVAn7oKSZcEpqtVQ3755L2pF+56H3J83+A7aATbyL3vlVFzc5J+Yqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iS2kpeFcW+bVu9uFhE4TZFuhs/veKYKrFt3kjITUAGQ=;
 b=LPXMP7se+RWuA+SwUCIzdyM6OrXjVQg3ebDe5irlZzddgqxVLWCwlkW5kD7Vw5SlCyvHtqVMFnz60WocNQVMl3ZXOYSA8kl8L2BgTK8N9jy2mlqTAsovjLvIartywpP1s6smsbSdsbmNSbO/rQhJrJyz5HvaEevqn3K/Yzv3IAWOSEPuY+6DVY495VnT0TqqhLYPxWvwX0hRK52fxyzHq2i/w/NTtwTuTuHQB1jFUseWO79iY3+5KUZav/Lx0jMxCX4v6YP1aMnnCdOZ5+Em1zWSiLdIcVY65hY5qDhijqTwf+KtXH8aFA1/dHy9ZM7hgnLo0pXEnZlIRTnu0Hshjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iS2kpeFcW+bVu9uFhE4TZFuhs/veKYKrFt3kjITUAGQ=;
 b=KHW9BoX90lG9exzpfhV7q0P5YVIJTSCCxt5nv+SHOga8OVLYOdeE6qPd8BE6DzT5uDCh/Xul56jORL5mtRjiA6WEjsQXfAkdCYP2WRyFasy3oL4Kh8MX0JpgwLAZ8IjPNpSf+q73dknugEbJWcaKa0SUS594er0EYbws4FQdUpI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR0402MB3424.eurprd04.prod.outlook.com (2603:10a6:803:e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Tue, 20 Jul
 2021 09:20:43 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f%5]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 09:20:43 +0000
Subject: Re: [PATCH] software node: balance refcount for managed sw nodes
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jon Nettleton <jon@solid-run.com>,
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
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <2a0f7fa6-b164-eeb4-118a-acd57d79a484@nxp.com>
Date:   Tue, 20 Jul 2021 12:20:40 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <YPVufjevu5WaaIxQ@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P191CA0016.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::21) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.103] (86.120.185.232) by AM8P191CA0016.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 09:20:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a2b7696-28b6-483e-051f-08d94b5fa607
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3424:
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3424BEDB5E4BD05D34543D41ECE29@VI1PR0402MB3424.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vI6tavRFl1dNP1c+DygpJSCBXzm3tURWQiZC+XVtXh1GjyvOdl47V8bvIR3B3nZmkvCKHuC+9Ime6s0C4laE4Js+BPKFXjfuw9vAejoPYP1yS3AnqoJOnK79nuY5yB0WXsafTLD7jUZnaFvGhki8Odbdh4cJzS9Dr5ah+U4LdNTdRf4fANsoOMLLaDwvMyuuvc4zBKMrf8OGo+p+elbwgWLBq71NoRHGOQVCTlG4K2ZNIcQPd3nUnEbifc5ZY3MkTX61cbuDMRWPACt05saI7Xb51A+ntusftS4NvK7Vc4JhWU97+5578PXhX9/DS8Oc7ipvJ8OdWVAgNlbuY3aabcM3pQ+6gifGhcqM93aB7LfxDPFSEh3ED+TZNJCCe9vwSohJ3fDHd+W/dJAaCe8vSx7iI9TV7jcTsMgz96TBKfr6eq468Ath/u8gbZgGInkmOcIRVzyoHTp83q0hhG0Wj1UR1TDtFieWeGrPOSlkWOE5kJOzGmsrH/8nvCouT+MhrbgCsVTYJ9eDhXoC1DMEKuFYI/L7Dti96fSvuIA4mq/y46jckp0YhnWTR8e0cqJt+sSdlrichH1ylHE06VJ4j7woqJJtbjuevtdaZYajNg2R2VI2N0y61Su6JU89d4rOHdhEgFmWmvHudk4lA5ffHAtRFz83yPhu/7aQEuKaPLroiqjGzCmkzBkGrSejUgEfetE/qzPvrzg974EiyLEiIXpitzU/c0sedTXaPFibxg5wyEGzJE6iJ/WqTxvT7PGWkmd4tRrGmwd796KlPDeQ3w2LeJhbu1H9X2G8IfLQPnXOkS4mlOo0kF+SI08HetKgGC7N9E0pvPudG3pyOhil/ok6MacvEhiqEoq0HaLq2Ew/Gls92VTLmDHCVew59eKo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(52116002)(36756003)(44832011)(54906003)(316002)(16576012)(66946007)(66476007)(6486002)(86362001)(38350700002)(2906002)(38100700002)(6916009)(66556008)(956004)(478600001)(83380400001)(186003)(5660300002)(8676002)(26005)(53546011)(966005)(8936002)(31686004)(31696002)(4326008)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajJMdTNSYjl4dkZkeW8xTU00U2lkRU54SGJjVmhQa3BiUnFKRnNDN0RxYTQ5?=
 =?utf-8?B?WkszWnllWkhEd2NxdllpYzM2R005Z2JBU2dXVjlxNjh0Tyt6N0c5ZFJiRFpn?=
 =?utf-8?B?MFdNdWRReE9QQURxUnZGNVJDdXY3YkdmVjRwTXZPb2lQOENQWE5KSXdCczBQ?=
 =?utf-8?B?RExEd213cmp0enVWamhIc3ZZMEpiekp6ODhpeGxDcmY4Ty9WV0JzOWliQlZW?=
 =?utf-8?B?bVA5STViTi9RVEo3bzFkZW02TEdBNHBaNDFHVTJZOWNKN3dJc005MW5Kc2kz?=
 =?utf-8?B?TU5VNy92TXNIbjdPdTkvbnZKa3RSR2NOYmNwWVNDMEc2VGFPcUFWMUNXelJ4?=
 =?utf-8?B?aWxOS0JrcmdnWDlvR3gva3kxTVdDaVA5SUQ1dFUrNFhtUkRmQjBGa045b0Jt?=
 =?utf-8?B?cUdWNlZkQ3Y0eWR2UVo5b0M3akdaUVlwY0R1Q1lVbWNEKzVJNk5LcHBRRlRm?=
 =?utf-8?B?WGhhMjJuOUphTDc0MGRlekJCZWsyNTlrM1V6a0Z2RjRSY2VKcERYampMblJK?=
 =?utf-8?B?U04ySStaUE1LbWJoMFE2U3k4MGxoaEZpOFE4ekVRVFYrMkxabk1BU084Z2s2?=
 =?utf-8?B?WHVBQW96TSs5S05wVThDNUNDSTZzU3dGRWJyVkVXdE05NlhxUnlZaXV5SHl4?=
 =?utf-8?B?ZU44aDQ0NGRhclF5YmFPNzlKbkhTejhXaHNrZ2crQ3BSaWlXcnduc2I4VFls?=
 =?utf-8?B?WVdMc2l4Uk4zL0VsYlNqdFEwMi9Zc2IxZ1RFSTFVZVZza1V6TU8vRFRKRm1J?=
 =?utf-8?B?cjFONUd3TVVSeGR6Z0dOUUtzTW5qSG9GZzBBamo2VXZxNG5PMy9Nei9XclAx?=
 =?utf-8?B?RmswZk5kR0ljU2JWTVNWM3NpK3B2cDQya0NxaUREU29sTThoTk0wT05ZN3Qz?=
 =?utf-8?B?dVEvb3BMMm5nZkVQNlJUUTZhM0thS0ZGS3QyQVlkMDloUWZGRmF2QzhmRHgx?=
 =?utf-8?B?UnVyemt0QVJUcE5oTHU3WmVqRzhnVmNQdjhnVlQzejZNck9PSWlycmh3bWpx?=
 =?utf-8?B?cEViWkFiVGV0RFRXejRPWml2OERsNndrYWJVdVlWSythemFjSzFLNHhYRzBD?=
 =?utf-8?B?YmNxbmh6RnRLYjNuMmpBN3Vqbld0cGNVTkNDbjRMblVFcUVKVWNmVGxHakxR?=
 =?utf-8?B?RTFpVkRrMkxiYkdONnF2U2xBeFlpSFVBZGNEWHQ3aUZNcHhqNVF4Z2hSZmJw?=
 =?utf-8?B?Q1g2ckRjR1o0OW9ETTl2bEFSN29yMlBlTE42QWRySVFtOGVldUJEbUhJMm9r?=
 =?utf-8?B?c0xaanNrbU9SM0xxZVFHYk4xc1YwRExtbXJGUU1HdjBURjkrRmE5QkZUWEY2?=
 =?utf-8?B?WVROV0poTGN2ejF1S0Iycnd3S1cyTk1PbU1icUtKdkd2c05DTHFMNTVoNjRt?=
 =?utf-8?B?dUlRbXN0dy9udDRlSFI5UUNjR1BIY0JDZEJPQkNjZmxRSnQ1ZWk0SlVaRE1l?=
 =?utf-8?B?M0VxM2tIci9FVGdPN1Yza2c0aU5za2piTDREdGZkTDlYMDA0b3VSVzJNYVlq?=
 =?utf-8?B?Y05saGVKbWRQRVdCb1hXNWJQb2hFVjVtd21OUnpjaUJocEVFQm50RWJJV1BJ?=
 =?utf-8?B?TUk5bkkxcVBsQnBSSHV1eVJDRDhBME9YSUFHVENQb0hzZi9MdmZyc2ZWVVJJ?=
 =?utf-8?B?RFVxQ1dyLzluRGZrZi9IZnFQMjY5LzNiTVRzLy91cHZiWk9OUEZIVVV0eXhH?=
 =?utf-8?B?b3VORnk4bjIyTFVISk4vQW0wM3FUL2k2NVNGNVp6dXhyZFNVQzRQK0x2Mndp?=
 =?utf-8?Q?ozB8HO38kV+1HjmU33k0kA9qEzGVtix0litaXpC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2b7696-28b6-483e-051f-08d94b5fa607
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 09:20:43.1428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUXJbQkE3ZGR2mACuNd9JLupLkofcBd4XbX+qdWq3dq/QW4imL6umyj0u477HeEBtOMgooQrw+79brN2WXRcgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3424
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 7/19/2021 3:22 PM, Andy Shevchenko wrote:
> On Mon, Jul 19, 2021 at 03:00:17PM +0300, Laurentiu Tudor wrote:
>> On 7/16/2021 8:21 PM, Jon Nettleton wrote:
>>> On Fri, Jul 16, 2021 at 2:17 PM Andy Shevchenko
>>> <andriy.shevchenko@linux.intel.com> wrote:
>>>>
>>>> On Fri, Jul 16, 2021 at 01:16:02PM +0300, laurentiu.tudor@nxp.com wrote:
>>>>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>>>
>>>>> software_node_notify(), on KOBJ_REMOVE drops the refcount twice on managed
>>>>> software nodes, thus leading to underflow errors. Balance the refcount by
>>>>> bumping it in the device_create_managed_software_node() function.
>>>>>
>>>>> The error [1] was encountered after adding a .shutdown() op to our
>>>>> fsl-mc-bus driver.
>>>>
>>>> Looking into the history of adding ->shutdown() to dwc3 driver (it got reverted
>>>> later on), I can tell that probably something is wrong in the ->shutdown()
>>>> method itself.
>>>
>>> Isn't the other alternative to just remove the second kobject_put from
>>> KOBJ_REMOVE ?
>>>
>>
>> Or maybe on top of Heikki's suggestion, replace the calls to
>> sysfs_create_link() from KOBJ_ADD with sysfs_create_link_nowarn()?
> 
> _noearn will hide the problem. It was there, it was removed from there.
> Perhaps we have to understand the root cause better (some specific flow?).
> 
> Any insight from you on the flow when the issue appears? I.o.w. what happened
> on the big picture that we got into the warning you see?
> 

I encountered the initial issue when trying to shut down a system booted
with ACPI but only after adding a .shutdown() callback to our bus driver
so that the devices are properly taken down. The problem was that
software_node_notify(), on KOBJ_REMOVE was dropping the reference count
twice leading to an underflow error. My initial proposal was to just
bump the refcount in device_create_managed_software_node(). The device
properties that triggered the problem are created here [1].

Heikko suggested that instead of manually incrementing the refcount to
use software_node_notify(KOBJ_ADD). This triggered the second issue, a
duplicated sysfs entry warning originating in the usb subsystem:
device_create_managed_software_node() ends up being called twice, once
here [2] and secondly, the place I previous mentioned [1].

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/acpi/arm64/iort.c#n952
[2]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/dwc3/host.c#n111

---
Best Regards, Laurentiu
