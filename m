Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31A63CB623
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jul 2021 12:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238392AbhGPKhq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Jul 2021 06:37:46 -0400
Received: from mail-eopbgr60081.outbound.protection.outlook.com ([40.107.6.81]:50984
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238468AbhGPKhq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 16 Jul 2021 06:37:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTm3SDl07QmAlVcZxnNe+MatensVPsPhXJFM4boknTd6KbLRmMRq7VbGh2mqWfFkbjIozVKxjvNmDqxPR92MMHOa2pHkCw5E2x4deq+YPHBhLrVvIKj2IOTR3IV9TNaMHbTk3Nc+ialIAbeRDEUuU5Bz6oLYZ3eb2z1f2I85Qs+vE2WJkrOG3rwfeAQcqV8UBTST016l0M8tQCTleEJwuY1419328yo4btQXXFZdlBjP2ilcJmN8n7gZ7QvYoTTTi/esRJvFvdTusswO/hB57kGO7YZ6dAQ/ZbhNoOkIyiDMgEK6fN7gPpxoRgDd6wfboTryRi50dbgnxeiaLNTfwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNMKsdZKWGfw5IQJPMb17s77G27knseeMjDUhlezk4Q=;
 b=H0SH+viBXXMDxrV5qv55jd9uY0ky5iXzVbrVDtBKxplPYBNeRmH6IUmmbNr6ZTNNWrpbcqdGPgKkKtfNRoiX/r0NfcEmvWii8hNjHpizACx7C9bkjXsZ35Sk2t764sBhnUUU6AtZ7iNp28ABG1yQs3cwWg0xbpZbHwpQ50It0/vTR/bfyQh0oFSjqXfLflIaIwzUoGFXmOMNo+BTHFz/iN2e336uf21rZy5mTc6S0X+V8Ko8+GcQxOVQsK5gpdbmXRh06/rAa5puJU+kIteYRAXKzg+tHXCcORT0VITiXxMwtuFNtLCAKhBIPn8icRaPpE1JSLFAI6fSpv8nepqBSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNMKsdZKWGfw5IQJPMb17s77G27knseeMjDUhlezk4Q=;
 b=QxdaAEOKDJNIjCfu1ZLG7uAHe9qu81NFg0KrpZDSw05ClVtLmp7EMJ0KNPJ/fMhsFH8xp+AR1luMylgzrBUs7KVpNG6ObDmez08mWrflNDgC5HAD7wJDeVAOGUA82WEGr97oPAgerRlP5kmOCf+TjKDqOvFmyefsol3Nzfm8mB0=
Authentication-Results: solid-run.com; dkim=none (message not signed)
 header.d=none;solid-run.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VE1PR04MB7486.eurprd04.prod.outlook.com (2603:10a6:800:1b2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Fri, 16 Jul
 2021 10:34:49 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f%5]) with mapi id 15.20.4331.024; Fri, 16 Jul 2021
 10:34:49 +0000
Subject: Re: [PATCH] software node: balance refcount for managed sw nodes
To:     andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jon@solid-run.com
References: <20210716101602.1891-1-laurentiu.tudor@nxp.com>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <55ac2007-ddad-c17e-e7d1-ab68c889461e@nxp.com>
Date:   Fri, 16 Jul 2021 13:34:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210716101602.1891-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0192.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::29) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.107] (188.25.97.226) by AM0PR02CA0192.eurprd02.prod.outlook.com (2603:10a6:20b:28e::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 10:34:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5445a4af-87aa-41b5-7df5-08d9484556d4
X-MS-TrafficTypeDiagnostic: VE1PR04MB7486:
X-Microsoft-Antispam-PRVS: <VE1PR04MB74866CA9BB661079F41AD84AEC119@VE1PR04MB7486.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B8x7dvKBkehU+tHwOAQVpYLPurHYJ/Jnt2Ymfw11eU9nAXArvjf5Ok9vg0+uhQHd0WLxBgFSA1FNhct5kCEWahiut7rg/AQwMBuVT27RFRsBaw2CX1KyTYTh/9uZyFa9Yx+MykaqdxxGXHVDrFBHM2kvg4fT9btnItMva6as7zZg9eQ2kqtvljS3uT/uR3zBf1zdEB6qdUcl9LSDCCsNES9DDqKudbFSjieBTOuTK1oHNEBo0of3imxt+IKhq4x1xQ4scPcn28K3brF3FogokzHHeLD9Qa2X/S1fNtXpOAqDQqCj/WIZV3OaIZbUodE2QqeZpWxNrF2cN8+ONJZi85SD1qvaMts1orU3OO+biBPsUT6cjn38Y7FOfq6IO/mEs1sWjUJiS9zKEjXLQxBA7i+G1bqbSgCupi6PCuYvDCiaiGquAfwbfRgoB1qIoQ+OSQzRxf5GWeDI5YJTA/E3UOSdcxHo8MMXkuUn+cqXf8xZcgmzXL2hH1PmwC/hoH/8glbZbQiFXdcVebsPQqh+r763jkskHYfQm9NgIMMbtWMgtSfIrdHo3BrEnRLaMg/uL81wuC/9/6YyMfl+RjmFyY+oxQeAUk7HbiU/5JCYEcMFvyRZEDVuik4REYTTHeLrK27wsx39+2KHE1e2b6mHNj1elCVwF/JWR7wXN7nrWTpoT82mguTQfGYk4mbF0fxmMRtshF7ya/msUVF9H0F3b2QG1qweo2ozsHOkeZPeR7Mq/a6n2oKcDXe2ILWnjkYVNJf8RsE1grwl6JR9CdnqSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(478600001)(16576012)(8676002)(4326008)(44832011)(38350700002)(6666004)(38100700002)(53546011)(8936002)(2906002)(83380400001)(2616005)(26005)(36756003)(31696002)(31686004)(956004)(6486002)(52116002)(86362001)(66556008)(66476007)(5660300002)(66946007)(186003)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWVyaFhtUHhveUhjNk9UWFFNK2h4cjVTaHVuMU41VDM0VHJZd3p4dnh6WWR6?=
 =?utf-8?B?Q0VxUWpRaXBuMHlFaXR5K1IrUnlXbVdhUUI4YWZDSE1xRzRzQTBxbnFaTWFh?=
 =?utf-8?B?WGNrQnR5UUJ0M1h0MzRUWExOKzVjTE9rb3JGaGMycklQQUhabndBZGxqNGg0?=
 =?utf-8?B?NjlQeVdJY201MVBwTWFRZDhoVTRJMWUrSlFGakhiNTRNOFVDekdCZDJ3b1Zl?=
 =?utf-8?B?OTB6T1hrKy9KSGJWcm5xYUVDUWU3VzRHS1dRbGJGK1hSV3lpQkNBancwVDdX?=
 =?utf-8?B?TUFsd0xPaWFjNmRDbWtXSVdnOWFqd015K0lWb3FGQU9hcUlBVithcHRXajhw?=
 =?utf-8?B?M3dpZFRYeXVENFBjdHkwQnljQzFyZWpDSjNyaVBEUG9ab3VNaFM2NHVHV21t?=
 =?utf-8?B?czA5K2dJcE0wYXNpdXJYa0M2bHhqZlBSNWhuNWt2OWdzd3RTM0hvbnkxZkps?=
 =?utf-8?B?VEpSYkcyRFFTNEtLcDh4RXdXUVZocEV1ZnB4TUJKa0JtLzJvc0NiR1BZcFUy?=
 =?utf-8?B?WER1ZVZoUnc2N0pubFhkbHl0UEVkMFJidjl1cFcyRkk2bkVPMTJnZUFSbGFo?=
 =?utf-8?B?YmhRbUpRRmtRUSs1a25vZjFjM1BOd2UzQUUrbjV3Sml3Q2QzZ2pHRWJIeXNl?=
 =?utf-8?B?NU5lQzllUHJZTEZDVUxlancvNFVEdWJOQ2NzU25rR1c2YzhzdmJSRE5KN0Vn?=
 =?utf-8?B?dm9reEk0SCtwVEVLcmRlWFZWYkw0UHNRTFRlbzA1OU5WbGRxTDRkQjVNUDZs?=
 =?utf-8?B?RncyMnNVaGxJT2VSNkZCVzJ2QjBjQzRJbzdRSDVQeitDV1hKb0wvQ0dMb0gy?=
 =?utf-8?B?alAyZTBTbDA4MTgvelhtcytsaTNCcTZzNjRGbXkxZnlrVWlHMjBaR0pxZFVX?=
 =?utf-8?B?MFZUc2ZpQW9KSThkZG81OU41cWlXTW1FbmxZdEJJRnBUb0JEby80ZlE4ZEtP?=
 =?utf-8?B?M0dEN3NnSiswcE5TNjBraVZzVVo4ZDJ5RUtGbWZGaGZ0TlU1QXBpemJNMGdV?=
 =?utf-8?B?aTF0a0U5RW5xL1FkUzFRWllEeUV4bFZEaGpLQmtNdW9TYnIrakNjRWtLL0xu?=
 =?utf-8?B?KzBuTDVZcWxaUDIxZkdOTE16WWRyZGJtbGM2NEtSdnl6ZVdqWmJyOWw0TG1a?=
 =?utf-8?B?aisrd203Z1FoRTNjYnJZWDBLNVBUc1dVWCtZMFJaTnRVLzdRckdDeGRPMnhm?=
 =?utf-8?B?ZEpSdGZyYm84dCszM2tBQURDbjI2NXZEQm1kY1N5Lzd4cVBCOGdxdlZnUWZi?=
 =?utf-8?B?RVcxZ3JyYU8yOGVOY1dvb1FnSXF6amt1ZSt0a240TlZYYnR2WlgrckhvRDlC?=
 =?utf-8?B?UmxiWnR1NnlQd0c2Um5NZUROeTJTM2V3UTZpWjZySi80bnJ4eHB0UzdpT1lU?=
 =?utf-8?B?OVJ0dXBQUDVCZmE0NGRiWTlJL0UzT0s3TUtXRjZBd0lTSkMrcFFKYmZra3Zq?=
 =?utf-8?B?RkVIeEQ5dXRmSVpQMy9ySVV2bjE4RGMxY0NIZ0svd0tEdG01dmJuS01BYjVU?=
 =?utf-8?B?OVNqVXB5b1d5eWpxeEd3WWRoMG1UNGZJN0o4NTB2ZjdZa3c1ZFMzdGJrdE9D?=
 =?utf-8?B?ZGxFTm9mcThBYWQ3VFlrNzNWam54M2UySmxJQkFLUi96endLMGxrVUdTWTN0?=
 =?utf-8?B?V3EybTZHZ0NnOEdBMWJkbU5BNWgzbWJ0M1FESHhQejBlSDl0NGdHMVI2eXYx?=
 =?utf-8?B?bVVPSlAwdDd4RG9pZStMUVBxcGNTY0NjVGd2VjZPdnkzWVRDUWh6dDRFY3ph?=
 =?utf-8?Q?O54RuM9rFZwA+aBYfPICx+A7YcOx8OhCPuvq86B?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5445a4af-87aa-41b5-7df5-08d9484556d4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 10:34:49.7454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /6H+Cw1lR8CoNF8E/hFGmE/CbWWy0kbsq/iCjHlcuUuYrY5F7t6wT5I9pAPa34fZ0fgFRhcAGQEVvjkRfppuwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7486
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Didn't notice in the first place, sorry about that. I now get this:

sysfs: cannot create duplicate filename
'/devices/platform/808622B7:00/xhci-hcd.1.auto/software_node'
CPU: 3 PID: 1 Comm: swapper/0 Not tainted
5.13.0-next-20210701-g5859a372a858-dirty #62
Hardware name: NXP NXP LX2160ARDB Platform, BIOS EDK II Apr 16 2021
Call trace:
 dump_backtrace+0x0/0x1c0
 show_stack+0x18/0x28
 dump_stack_lvl+0x68/0x84
 dump_stack+0x18/0x34
 sysfs_warn_dup+0x60/0x80
 sysfs_do_create_link_sd.isra.2+0x104/0x108
 sysfs_create_link+0x24/0x48
 software_node_notify+0xf0/0x148
 device_create_managed_software_node+0x90/0xc8
 iort_named_component_init+0x90/0xd0
 iort_iommu_configure_id+0x94/0x190
 acpi_dma_configure_id+0xc8/0x140
 platform_dma_configure+0x94/0xb0
 really_probe+0x70/0x2f8
 __driver_probe_device+0x7c/0xe8
 driver_probe_device+0x8c/0x130
 __driver_attach+0x98/0xf8
 bus_for_each_dev+0x7c/0xd8
 driver_attach+0x24/0x30
 bus_add_driver+0x154/0x200
 driver_register+0x64/0x120
 __platform_driver_register+0x28/0x38
 xhci_plat_init+0x30/0x3c
 do_one_initcall+0x60/0x1d8
 kernel_init_freeable+0x238/0x2ac
 kernel_init+0x24/0x128
 ret_from_fork+0x10/0x18

---
Best Regards, Laurentiu

On 7/16/2021 1:16 PM, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> software_node_notify(), on KOBJ_REMOVE drops the refcount twice on managed
> software nodes, thus leading to underflow errors. Balance the refcount by
> bumping it in the device_create_managed_software_node() function.
> 
> The error [1] was encountered after adding a .shutdown() op to our
> fsl-mc-bus driver.
> 
> [1]
> pc : refcount_warn_saturate+0xf8/0x150
> lr : refcount_warn_saturate+0xf8/0x150
> sp : ffff80001009b920
> x29: ffff80001009b920 x28: ffff1a2420318000 x27: 0000000000000000
> x26: ffffccac15e7a038 x25: 0000000000000008 x24: ffffccac168e0030
> x23: ffff1a2428a82000 x22: 0000000000080000 x21: ffff1a24287b5000
> x20: 0000000000000001 x19: ffff1a24261f4400 x18: ffffffffffffffff
> x17: 6f72645f726f7272 x16: 0000000000000000 x15: ffff80009009b607
> x14: 0000000000000000 x13: ffffccac16602670 x12: 0000000000000a17
> x11: 000000000000035d x10: ffffccac16602670 x9 : ffffccac16602670
> x8 : 00000000ffffefff x7 : ffffccac1665a670 x6 : ffffccac1665a670
> x5 : 0000000000000000 x4 : 0000000000000000 x3 : 00000000ffffffff
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff1a2420318000
> Call trace:
>  refcount_warn_saturate+0xf8/0x150
>  kobject_put+0x10c/0x120
>  software_node_notify+0xd8/0x140
>  device_platform_notify+0x4c/0xb4
>  device_del+0x188/0x424
>  fsl_mc_device_remove+0x2c/0x4c
>  rebofind sp.c__fsl_mc_device_remove+0x14/0x2c
>  device_for_each_child+0x5c/0xac
>  dprc_remove+0x9c/0xc0
>  fsl_mc_driver_remove+0x28/0x64
>  __device_release_driver+0x188/0x22c
>  device_release_driver+0x30/0x50
>  bus_remove_device+0x128/0x134
>  device_del+0x16c/0x424
>  fsl_mc_bus_remove+0x8c/0x114
>  fsl_mc_bus_shutdown+0x14/0x20
>  platform_shutdown+0x28/0x40
>  device_shutdown+0x15c/0x330
>  __do_sys_reboot+0x218/0x2a0
>  __arm64_sys_reboot+0x28/0x34
>  invoke_syscall+0x48/0x114
>  el0_svc_common+0x40/0xdc
>  do_el0_svc+0x2c/0x94
>  el0_svc+0x2c/0x54
>  el0t_64_sync_handler+0xa8/0x12c
>  el0t_64_sync+0x198/0x19c
> ---[ end trace 32eb1c71c7d86821 ]---
> 
> Reported-by: Jon Nettleton <jon@solid-run.com>
> Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
> Changes since RFC:
>  - use software_node_notify(KOBJ_ADD) instead of directly bumping
>    refcount (Heikki)
> 
>  drivers/base/swnode.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index d1f1a8240120..bdb50a06c82a 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -1113,6 +1113,9 @@ int device_create_managed_software_node(struct device *dev,
>  	to_swnode(fwnode)->managed = true;
>  	set_secondary_fwnode(dev, fwnode);
>  
> +	if (device_is_registered(dev))
> +		software_node_notify(dev, KOBJ_ADD);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(device_create_managed_software_node);
> 
