Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA553CB5BF
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jul 2021 12:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235911AbhGPKM5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Jul 2021 06:12:57 -0400
Received: from mail-db8eur05on2070.outbound.protection.outlook.com ([40.107.20.70]:1440
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236734AbhGPKM4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 16 Jul 2021 06:12:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wnprda7lmWKIr3JvDR6oydm4IzresaJWbo3n2fChuFeoDfpgTa1eVttiOuKTpx+5W1xzMbRrodaCmxW7EEIuzpZ9ZW2bh2jUTvIKWPMLq0RViQ1SPmUEatmeLScJnwlvJOeimJScPnuyOYUhL9ZIRXk2psEZwgJhLL8i2JYgAcpGni+cnyNjht6aHGHXIqwBKf06Z+5EAnYGqJd8C210i7JBsv5S8hTDYzV3ap3YoFgWUCoT/OJGYE20VT+NJm1X2VROswJfMaDZutqG3yAKlNxL8AC7Hmu4T/kQr9iexriqLRCKUIyOKgxzUmSi6OuNvYdBJ2sXJF0mAljIoy1mHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWaPwfD/D7jaUQ+09KUaKd6qxiNGS7QReLjO6Ig5I/4=;
 b=H7jjIhnaI9AWLulmge/ISssFXG838wLuqU21tPFixV9imxbM24Yi7e9Jcd+5a+5TGEKclA0krJojPTlERRJqRDy/UdJ/MBMsQvQQxSa34L2ZZGrpU01ADAoONY6z+3jsGAsiych0BlJaSNHnJAUuFc9pSIYRAhYTzksPn4yExiZ/J1YmQtIKRvDnhuNX1OBynOtH7up9Ku+6lftP6b2YJ+EufyIH/kC2pNPh/suLIEhHLMN8HmdjUBPqRQMLtws+XyKFJWIsZNtYc3gKhuFHz7jlmqBbjt/QU/1aP+X/LFOmbwcO9uVwzb53mHo66koPypdK7I/sj+5m3kTguwapuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWaPwfD/D7jaUQ+09KUaKd6qxiNGS7QReLjO6Ig5I/4=;
 b=jBc/H4MpPHBbUxCk+aPoxUm351aMS3li1SsQJpU7U+ZeQ/70wqa+e565AdWUf6pDRf++SBUyYCxWFCQDxuhfSUtXCWjx5KPdmeTARbJCd1IzD0izP129rD5YbaUxTPDFOMe7M6IyilM+crrdNLZLXALund/aDkQoq+l64x++xvI=
Authentication-Results: solid-run.com; dkim=none (message not signed)
 header.d=none;solid-run.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB4720.eurprd04.prod.outlook.com (2603:10a6:803:52::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Fri, 16 Jul
 2021 10:09:58 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f%5]) with mapi id 15.20.4331.024; Fri, 16 Jul 2021
 10:09:58 +0000
Subject: Re: [RFC PATCH] software node: balance refcount for managed sw nodes
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, jon@solid-run.com
References: <20210716081711.7638-1-laurentiu.tudor@nxp.com>
 <YPFSHiHZzjwJD2PI@kuha.fi.intel.com>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <54836f5e-8180-2bfe-58be-7e232ab42f1e@nxp.com>
Date:   Fri, 16 Jul 2021 13:09:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YPFSHiHZzjwJD2PI@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR05CA0076.eurprd05.prod.outlook.com
 (2603:10a6:208:136::16) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.107] (188.25.97.226) by AM0PR05CA0076.eurprd05.prod.outlook.com (2603:10a6:208:136::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23 via Frontend Transport; Fri, 16 Jul 2021 10:09:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0096d205-cc08-4c93-d018-08d94841de0c
X-MS-TrafficTypeDiagnostic: VI1PR04MB4720:
X-Microsoft-Antispam-PRVS: <VI1PR04MB47208AC83D0AEB956E177257EC119@VI1PR04MB4720.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s5XFW+QsPFDqTtXfSVwLdeUR7OUi64Xl0nQHBsBnCtfASi+rdMzWRG6IUt34MfG1Es6KGJTlvi8PIl13/EUt63sVWn4gLio/6HC1/NRIdGVR+b/+fdD+OzcYa/X6QfYlKWOxt8z+06rgq+eRPk197oh81RSIJ0DR8L+7xB/0dqFrH4hhvfS2+lVL7Xv1QwLM5djsgCe1jhg+4wRHdaWv1Aqsur9IwnqwyV+uCrX6ec2hF4+0aVWIOdTJxRL42Znc3bXWNJ7P5mxh6l+CJo607blYYbH1+lEC+VLQEP+IyEeznlpenqRkuSiZb2gxJpM0rTpyv3GsOR3QVWGMWM9BHaOWkRS6btsSRlPyofktmUubjTv8R6rc2pSu+WEV2CXfiNYGQIA3CgYbvS0uWTd93BY1wHLoGSDiv/cx4IyGn9HniE7SQ7IEtwr3lxAmyp5bjCiYJWnJpqjQ2h8okkyWgbkO8n5qsdhZWg3bxYX4+Q7xakgCTd/FFtCYXR20bxquCQpFV0nftI+bhCCPFBDg1zDDaOumtf5h29FMua609ZWu5/6nfSUU/bAv7utaYj7eSgGJdsdbI3itItr0DP3IDUEaZfZVyW5fZf9iakPZDYXJ0MaxybjUzvW6gYvO1KlZCPIjD1BQm7BgdANVfEsY2UE2OQN3tkvWV88plIW3A9yl3+2akopNA4W3c6BwPWzkThVH/TiBiMuYyppCO6rpG8GyqbJd6MCcEUIW9pM4fl+B5JA3HKZXgZrh0QQ6WgFFiPXDo1CoO+Iq9/C7lQgUPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(2616005)(52116002)(44832011)(956004)(4326008)(66946007)(316002)(16576012)(6916009)(66556008)(5660300002)(8936002)(66476007)(8676002)(26005)(31686004)(6486002)(2906002)(31696002)(478600001)(86362001)(38350700002)(53546011)(186003)(38100700002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bldhbTlKNUJUTDdzM3pqVkNJb1lpbHhIeVhJNmNNdXVyTXlIUHZLbndqYURP?=
 =?utf-8?B?YmJJNmxiTDNqMU4xb3ArWXpxZWtjNHVsZENRUkMyckV4Vy9rOUhKOGRkNElY?=
 =?utf-8?B?azA2SjkwYVAzdTVaYUZSNkd0TGlrWHZrQ0hoOEpkTTNvd1NvMzRxaCtBdFpO?=
 =?utf-8?B?bFFQR2V3K3Q1RXBnLzVsbDJHY0tBSVVacjdYTDFIeHhHTFNSNVozUVI0cWdW?=
 =?utf-8?B?TXJTaStGemVMbUNPRUZFLzZrYW85L1JWWVVVdVhHREVXLzFSTTcwc3d1VFUx?=
 =?utf-8?B?eVdKU1BiWlVDVUF0MFhpaVhZVys4ek9tMWJpWnVESkwxakg1QzRRb2hLRmhk?=
 =?utf-8?B?UUo1d1pqTHJBRTRpL2NsWHlGdkFiMVJYaU5JS1AyYnlFT1VxVGRvZU9Yamkx?=
 =?utf-8?B?ejRoUlA4bkxsaWViR2F5N2ZHb2RYaWszcHVvSDNxVjVrK1hjRkY0a3JNUHhE?=
 =?utf-8?B?V05yMENJOXZuWXM3YTRLZ3p3RFRXd01iK0RQdFgxa1duTUhlWDhYdW5QQ2N1?=
 =?utf-8?B?TGR3NzA2TDNpZTQrUUdpL1VZNllscUtpcE04QUJmTit6dDNRQitPR3UvWWt1?=
 =?utf-8?B?ckxROWlGaFE2d0M5Y0wyNzIzazV3ZlEwOFIwYlNBeDY1K0FwaTRjeXdoelk1?=
 =?utf-8?B?Z3NzZHd0Ti9vdExVc1dGSEtEL0VGWGs4SmltWGZZQnZqYTVDeEhDTm9Vamll?=
 =?utf-8?B?TjF3NUY5a28ybWlDaHBCMFZUMUlnNEVYL0wwazI4d2ZNeUhrdkZyRmx5aWcx?=
 =?utf-8?B?QXVGR3J0R1RxMFFpNnV4Y3UrTjVHb3ZOTFBUWGx1Ny8wNU85dHF1SXJTNE1I?=
 =?utf-8?B?YnRlUURqTmYySElqVGpZZEdSOUJTNDZ5Mm5uc0dNc0ZGT2NxSnlTSXlDYjUw?=
 =?utf-8?B?c1BoRlRDbG9jZVRmMEd4V0tEdXcxMk8vQzVqcGp5OFFGelJyWmlXUmNHZmVw?=
 =?utf-8?B?L28yN0JaWlhSS0Z6MGVTb01QcWZSb1E5WktZdmxFSXBLc1VNbFFEcCtHRXdj?=
 =?utf-8?B?Z0paRDAyUnJCM3Y2dkh0Z3RjUlpKT3lmeW1pVDA5ak1mZmdteDFmMlFnTVJ0?=
 =?utf-8?B?cDhCRGJJWlpjZy9aZlE3eXUvMEtVN3Y3SjAyYlF5WEFzQkJ5OHQrZTZ5RERi?=
 =?utf-8?B?eEh3T3Z5aENjbFliMVRGdStPZG12UEpXMHZyUHd0YmRFd0VibE53RFJmQ0tp?=
 =?utf-8?B?UHdxWVYyMlR0SHRPTVRXTW1rQ2laeGpPNGp4UUZONGhHNzdxNkpTYkRJRll2?=
 =?utf-8?B?UnpoTXJZTXR0aVhwaDY1MjVFZzZJSzNCT3I4aXBqSXlzTENXdEQwaUEwRTRu?=
 =?utf-8?B?TjQ1N2txZ0hHMzJENTEvU2VEeHd5SW00b3U3Y2Y4eUhUTE9zZ1JXRVd2eHFm?=
 =?utf-8?B?N0FFb2NDenRwWm8weHFxaE5GaEVJNmRsRzlBNkpLQU83ME80cjQvZjZRZSs1?=
 =?utf-8?B?Q3ZwOUhPVnU4YnBsUHVuWGZsRWcxcWxqU3Awek5WeUJLemhaaGNnd2I3SzUw?=
 =?utf-8?B?M1FSd0tEUVczLzVlU2xqNGYyWmw0YVk5UlFVRlFrUVlBUzEwYmVIVy96TGVN?=
 =?utf-8?B?eTRyTzN3UmJKOERIMmhmd1VJRnlUYnd5czNJamxmdFBMbUVTREZmVVNBQm8z?=
 =?utf-8?B?UmhMUE5MOFZlK3NmU3NuOE5CWXMwc0dIZjFiVGdrV3NNeHdyL1lOekM1Q2Ny?=
 =?utf-8?B?Q0JQVHpVOXZMYmpaT2FuQnQ4UTk3YVBqeUFvMFNlZnFQLzR4MmVEa0FvOTJM?=
 =?utf-8?Q?I0t3CRnm/uHmlTX8DXCmPnEVdunr1hXmRhS6eef?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0096d205-cc08-4c93-d018-08d94841de0c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 10:09:58.6540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uPFi2KAgk17anqhUICKq5ppSUAFOXHtOniBpQe1eNRGmtg/MjSAD2pQ9Z3igKWYvusuuV49wTpxG04gDao6qTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4720
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 7/16/2021 12:32 PM, Heikki Krogerus wrote:
> Fri, Jul 16, 2021 at 11:17:11AM +0300, laurentiu.tudor@nxp.com kirjoitti:
>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>
>> software_node_notify(), on KOBJ_REMOVE drops the refcount twice on managed
>> software nodes, thus leading to underflow errors. Balance the refcount by
>> bumping it in the device_create_managed_software_node() function.
>>
>> The error [1] was encountered after adding a .shutdown() op to our
>> fsl-mc-bus driver.
>>
>> [1]
>> pc : refcount_warn_saturate+0xf8/0x150
>> lr : refcount_warn_saturate+0xf8/0x150
>> sp : ffff80001009b920
>> x29: ffff80001009b920 x28: ffff1a2420318000 x27: 0000000000000000
>> x26: ffffccac15e7a038 x25: 0000000000000008 x24: ffffccac168e0030
>> x23: ffff1a2428a82000 x22: 0000000000080000 x21: ffff1a24287b5000
>> x20: 0000000000000001 x19: ffff1a24261f4400 x18: ffffffffffffffff
>> x17: 6f72645f726f7272 x16: 0000000000000000 x15: ffff80009009b607
>> x14: 0000000000000000 x13: ffffccac16602670 x12: 0000000000000a17
>> x11: 000000000000035d x10: ffffccac16602670 x9 : ffffccac16602670
>> x8 : 00000000ffffefff x7 : ffffccac1665a670 x6 : ffffccac1665a670
>> x5 : 0000000000000000 x4 : 0000000000000000 x3 : 00000000ffffffff
>> x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff1a2420318000
>> Call trace:
>>  refcount_warn_saturate+0xf8/0x150
>>  kobject_put+0x10c/0x120
>>  software_node_notify+0xd8/0x140
>>  device_platform_notify+0x4c/0xb4
>>  device_del+0x188/0x424
>>  fsl_mc_device_remove+0x2c/0x4c
>>  rebofind sp.c__fsl_mc_device_remove+0x14/0x2c
>>  device_for_each_child+0x5c/0xac
>>  dprc_remove+0x9c/0xc0
>>  fsl_mc_driver_remove+0x28/0x64
>>  __device_release_driver+0x188/0x22c
>>  device_release_driver+0x30/0x50
>>  bus_remove_device+0x128/0x134
>>  device_del+0x16c/0x424
>>  fsl_mc_bus_remove+0x8c/0x114
>>  fsl_mc_bus_shutdown+0x14/0x20
>>  platform_shutdown+0x28/0x40
>>  device_shutdown+0x15c/0x330
>>  __do_sys_reboot+0x218/0x2a0
>>  __arm64_sys_reboot+0x28/0x34
>>  invoke_syscall+0x48/0x114
>>  el0_svc_common+0x40/0xdc
>>  do_el0_svc+0x2c/0x94
>>  el0_svc+0x2c/0x54
>>  el0t_64_sync_handler+0xa8/0x12c
>>  el0t_64_sync+0x198/0x19c
>> ---[ end trace 32eb1c71c7d86821 ]---
>>
>> Reported-by: Jon Nettleton <jon@solid-run.com>
>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>> ---
>>  drivers/base/swnode.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
>> index d1f1a8240120..907616ca487f 100644
>> --- a/drivers/base/swnode.c
>> +++ b/drivers/base/swnode.c
>> @@ -1113,6 +1113,8 @@ int device_create_managed_software_node(struct device *dev,
>>  	to_swnode(fwnode)->managed = true;
>>  	set_secondary_fwnode(dev, fwnode);
>>  
>> +	kobject_get(&to_swnode(fwnode)->kobj);
>> +
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL_GPL(device_create_managed_software_node);
> 
> We can't increment the refcount uncoditionally like that. Would this
> work instead:
> 

It works, thanks for the suggestion! I'll return with a non-RFC right away.

---
Best Regards, Laurentiu
