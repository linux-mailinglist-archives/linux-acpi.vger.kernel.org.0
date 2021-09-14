Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6184A40B457
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Sep 2021 18:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbhINQSz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Sep 2021 12:18:55 -0400
Received: from mail-vi1eur05on2067.outbound.protection.outlook.com ([40.107.21.67]:35169
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229461AbhINQSw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 14 Sep 2021 12:18:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoAo0PUBqih0ZTURqv/x7+wppZVbI3A91cZNh50cS/lFvd+yWY6GwfDtBmdd4LT2kItbQspSpEH9nxfvMFoov8aPiloLMPdAT+Ch6iEw/K8r1K8UWA7w+d48aoQfJxGiidGa2IjwUF0cSYsE4lyVKTtzCLzkSwxLXHrlGxaBPkAH+YazDmPFSCAun8wOzx0yXR8/7Ao2t1rwyWUH4ioT19LnwStQdcD1CsJmYnJCDcdDIS/BNx3FRXYqcm42viK2rMVcmm+T2j4lH+plCCYaCLGW5DnO9zFw/DzWGyRP6h+RHF/JQO0zh/W+b8twefIFLpcI804tcUDOhOoqCHP1KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=G9pM2xuKkukcK/SegGdvgmJfi9ppd4HHJlfkj+0hwvA=;
 b=EbXVm2nxewpttOeIyTWVOEEGLlyAa1DUOB79BiRDJ4EdwRBrJVMZ3KIgV5Re1KQb0HAwLMJCJ+qkIAwviP/nTuozpGZazgGDBeIbViscj0mQyYctv3ye7e3eJ8HgD1AJyisMnDiwSuYT6c6Vjk3Co1eiSZAVByHeBN9l2aHzSoJB3/O9HRFuvSXwJrqNHjVIXuWIT1BLns2FlkVMITNCqOUXtfGr2cxuSsrPbCPvfbuwpjNsC6lLXg0yOLz0wIetMrkdtXw8EE6EDxxfwjrkzZ9j/Gbh/Cmha29eI7eSyS5NqnDgiufasg3oIkVfJkyCwYoburpMEu0RXD7F2m7PLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9pM2xuKkukcK/SegGdvgmJfi9ppd4HHJlfkj+0hwvA=;
 b=YnNzaCEI793MgoIl2SnMhPaORGpirUd5e6vuIeAW+kIMp4W96eB47x1YsVea604SqQ65sk3f3F4KMjqj31pHXNMiseupomy3qIxQnoH2mQcNWjhUEuTYfTdmsOSHG5fMQufPsHmimb3eLOoHnvZ8X3SVT8Me9BRQ5YOSnosFeCw=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB5584.eurprd04.prod.outlook.com (2603:10a6:803:d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Tue, 14 Sep
 2021 16:17:31 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::e948:b382:34fc:c923]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::e948:b382:34fc:c923%7]) with mapi id 15.20.4500.018; Tue, 14 Sep 2021
 16:17:31 +0000
Subject: Re: [PATCH v2] software node: balance refcount for managed sw nodes
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, jon@solid-run.com,
        lorenzo.pieralisi@arm.com
References: <20210914144409.32626-1-laurentiu.tudor@nxp.com>
 <YUC2q1du1vGjAtsd@kroah.com>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <70940e81-c1cb-bb06-5184-32f5a36fb85d@nxp.com>
Date:   Tue, 14 Sep 2021 19:16:04 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YUC2q1du1vGjAtsd@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0202CA0022.eurprd02.prod.outlook.com
 (2603:10a6:200:89::32) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.238] (86.123.59.117) by AM4PR0202CA0022.eurprd02.prod.outlook.com (2603:10a6:200:89::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Tue, 14 Sep 2021 16:17:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dda70a0-6bb9-44a6-0d01-08d9779b2714
X-MS-TrafficTypeDiagnostic: VI1PR04MB5584:
X-Microsoft-Antispam-PRVS: <VI1PR04MB5584AE28DFBE6482C66F23DAECDA9@VI1PR04MB5584.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XB5lvWZIY21c3R2jZWrpqbSVkeMQP4kZT3XeopGAApS7hmxG1lRGIB/JTdGPJYGcFy/o8JzvpY+a66fEDcXD7pCNc0H22enVxyOX3uhbsdSBT/eJku7YOeurRFaAocgGGdyRSORZBZrHkz8+pa2L3glQ5S6yNp7Qb1pxzdOh1kTM5FMyelZuW4x1H+ZcsEb2ku5+Wcz6G+iQrys94EeDTkPXdva0K4DBCcYgX+kZ0IOXO38VObijlOjmhUhbZPQ1M/QH63K0irmuOn+xxXSsiSJR3wtzTlmB95Jl3CvEcozssScr8W673xFhB8dClQj030H2GRmlgHgrBd5QxWnSoDH6EM6Jj/Y2DAqJFqSF//Kn/TZtlShRBqtJIhxfsQCz/LH2ynZqqSY8nCXdspoykKuZOwdJouyZfwsYH7+znY8aCdbjhS1ngEDm8nOVDl84aUVjQIE6IgjhqOtALY8hip4AiDoJqDwkOUSlz9g4YyoSbvUELYwrppQy/3ah0/sNbwY3Wo555a4NfRAVZsvTkVPJ474KwJIGN9Pvb34aSCdo+XSHcpXle5YDYNX9XaGxruQYguZ54V4N3VltB128kn6m8W0eDIoqfIrVDyUWloqR4ZK1RUv07SJVjkCnX9FxBOmUQ9Ki1s9FkvMJXGuUt+BBs9MQYhlDz4z+AvZpZEhRZEc/or9mPZVUzS8RS3w/CBO/GcnJtEIidusn5yMSlwdcxM3B9uUXlwZYeq0ETSBKXv9gT6sAfdapIRsZWMYvsSBGiyiJbDRK6LL75fpc1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(6486002)(26005)(53546011)(38100700002)(6916009)(38350700002)(186003)(4326008)(31696002)(8936002)(956004)(2616005)(86362001)(6666004)(66946007)(2906002)(52116002)(44832011)(31686004)(316002)(16576012)(8676002)(36756003)(66556008)(5660300002)(66476007)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3JXOXRxeE0rL0s5RzNYVW0yL09MbC9WUDFnVmc5WE1oOHdRZ3dKQkpTN0Nj?=
 =?utf-8?B?eGtzbVkrU0c5RW0vUzZRK3FDdWRvWmxqSXFlUTYvemxuazNzTlZycFo5UHFK?=
 =?utf-8?B?eXRNSkJITXliM3RBaW5uSUEvUmw0ZkVSZ2JISEFmTXlkUk9uVkZVOWRIcGlR?=
 =?utf-8?B?S3ZwOU9RZlVpcHByL2ZUbk15UXB0VGZncTdvcnY3MnNUblNUcFd1WUZJSG91?=
 =?utf-8?B?SUlwN25RRStTWHVNdXRBQ05rcDNTZXU3TEJxOUM0UWpWeFNUMG9qZGhEWGov?=
 =?utf-8?B?TDNXeVlUSldLQW9JdGhPK0NWRFY4bWR4QlYyNzRPYTFIN3E1REFsSm92R3M4?=
 =?utf-8?B?Tkpod3RWUG1KK25XNXVCMUJETnhWVThQTzJ6ZGdBcmNvd0s0MzNNTklaQW1l?=
 =?utf-8?B?Tkh0b1FsTlpQbTREak50WXZkVFo3Ny8zWmVHK2grcmE0TXpuN0ZMK0c5YVdP?=
 =?utf-8?B?bGtsSm4rN01UOXVzR1o4Q2Npclp5a3JGRVdTcEwxUXJvVEFGelBWZmU0TnpD?=
 =?utf-8?B?aWNUU1doRVVKbXZ2eDFjYTNkQnl3VFd5YU1xVUIxWURXRERuUC9CNC84djRm?=
 =?utf-8?B?SVpFT053R2h4ODFOamI2dHUyWnVkZWRqaDJtOFZ2U3FPamNxSVBqUmFoMFhG?=
 =?utf-8?B?aE9jR1BHU3JrSGVITFZBaUFKb3A2WERvNUpYQS95dDFQVVlESG0zNkJQajZv?=
 =?utf-8?B?a2N0RE5XOG1wTjBrMGNsaVhHZ05TSVFrT2F6QWxkUFo0VUlCNTZNK1cxRE1N?=
 =?utf-8?B?YW9BRTBpZDNzU1pQK3Iyc21FYzBWakkzbnZmSEtsUWFqZm12OHhLYUEwaEY1?=
 =?utf-8?B?a0syMDRibkpWTitvbkJ3cUY3MTczM3g5UkxXRFltczkxblVMamJUZFNic2d5?=
 =?utf-8?B?RWF3R2YxczdiY2tLY2RSc0JzaEFVRTV2cy9mNFBOZ1NyME4vUm02VDdtYUps?=
 =?utf-8?B?a0ZyN09kWTBkcHV4N05lbkVvWlZQMUdkUFRjcUJNR0VYUXRTY29YRFpiVG11?=
 =?utf-8?B?UWQyU1pyN1MvRDdjTDBXYVdoaFhSV3hTL2tiMXByWDdWT3FZRVd2WDUveGVT?=
 =?utf-8?B?TklvR1p1dHBjazFPZDN2QmRwbFhSbXZEOCtQck96cit5SFhpK29NbmFlck1G?=
 =?utf-8?B?QllLaFRqelF0cHRFaWludzVORzBPSzVCVXNyVTYrMFE1Vm4rVDloQzNDdjVG?=
 =?utf-8?B?T1pwV3NmQVFwdEpHZE11VUlQTG5tb2RUbjJWQW1pc1AxTzRYaUFrWWZlYXhN?=
 =?utf-8?B?bGcwS1RiQzFIZ3AxMGxIYmMyTk5zbTVGeWwzUS9PTlJsUVFDcUZ3WXZaZnR0?=
 =?utf-8?B?N3N1aUhmRTZrSFpyTXRvMXVrblZEMGU2TDgzNjNVMjJSdXJaOFBBTFZOK3Fs?=
 =?utf-8?B?b3RZMWtDeDJIVGZEcHVEUHZMaWhWbzNMU0ZsM21JaTlpaHdkOEFPVkp1czBD?=
 =?utf-8?B?NTJSWmI3RVJ5SU0wamhCUTczc1pSR3dhS2FvV3h0QlA2amFtUVRNQ0pGL1VI?=
 =?utf-8?B?UzdjWkdVSnJTMXpMUCtRQTdZZTVBTVZBU0dIblVTR2hJQ0JBejdmY2p6MVpl?=
 =?utf-8?B?WjlkN2JCb1JibU95NG8rYmFjUEc3Q0tKRmtMTnR1eTNQeGEzRERZVVZVTFVs?=
 =?utf-8?B?NHJKUjlxSWtKS1p4NUtPYWpZN3YybWswS3pFWjZ5dEQvNzdGckdwOENjWDVm?=
 =?utf-8?B?RTY2R1VKMUdWVEhHN2hYUkJKbE8zVlhQUEs3YnkrTmlsaWVhUXFlSzJGYkJl?=
 =?utf-8?Q?ygV6s3bwb7G0hI3FYOwsmpOBB8vPTaBEv5jwOle?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dda70a0-6bb9-44a6-0d01-08d9779b2714
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 16:17:31.0696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1DWraIZQr33E4dIHCe/znxRXuD9yX/f9D0UTA6lQmODnPJ6t7Q8mYbKC5bX9FGnLOB5ubgIQz1k2baMvsTu48w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5584
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 9/14/2021 5:50 PM, Greg KH wrote:
> On Tue, Sep 14, 2021 at 05:44:09PM +0300, laurentiu.tudor@nxp.com wrote:
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
>> Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>> ---
>> Changes since v1:
>>  - added Heikki's Reviewed-by: (Thanks!)
>>
>> Changes since RFC:
>>  - use software_node_notify(KOBJ_ADD) instead of directly bumping
>>    refcount (Heikki)
>>
>>  drivers/base/swnode.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
>> index d1f1a8240120..bdb50a06c82a 100644
>> --- a/drivers/base/swnode.c
>> +++ b/drivers/base/swnode.c
>> @@ -1113,6 +1113,9 @@ int device_create_managed_software_node(struct device *dev,
>>  	to_swnode(fwnode)->managed = true;
>>  	set_secondary_fwnode(dev, fwnode);
>>  
>> +	if (device_is_registered(dev))
>> +		software_node_notify(dev, KOBJ_ADD);
>> +
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL_GPL(device_create_managed_software_node);
>> -- 
>> 2.17.1
>>
> 
> I am seeing that this needs to go into 5.15-final, but how about any
> further back?  Stable kernels?  

I think that's a good point. I can resend and Cc: stable if everyone's
fine with that.

> Does this "fix" a specific commit?

I did not found a certain commit that introduced the breakage so don't
know what to say here. I'd let more experienced people comment on this.

---
Best Regards, Laurentiu
