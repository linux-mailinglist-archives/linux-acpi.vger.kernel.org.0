Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A56448B768
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jan 2022 20:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbiAKTfw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Jan 2022 14:35:52 -0500
Received: from mail-mw2nam10on2060.outbound.protection.outlook.com ([40.107.94.60]:43649
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235731AbiAKTfv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Jan 2022 14:35:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEqHQbdN4wdnHBma3smH3QO0OshDeD9ks1sTCNq5fbc/w4brZhd5jluTahSmI5AwQ0c0Qu6yBqRm/05hhtR1ro+ORHJESpZ3FcXn1w/jA+4ojXa1jjhtsEyoPhw5ys7v7dBSZ+A+eeJGy4dK0XrmYQHzE2HMt4v2A/m2j4ySwLWMXFDEDRNXB0gtDRHIUEm12D8mpDsQ319cioDWd88/bGyYXUO7qVSsYDIR/ZA0qXCE++fVjtWCDO9/7PoBmf6hLlJuvwU/pG45ads+eZIxKDkAGPFlpHXm5WIjNjozv9rZnfeOLkyrxSDEvmjUrHd4B2iul1HZplxV0Ryz+gmXlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBF/+xcUC7SYy7n6pS34IPqj2HMmC86wwahTNRmNGi0=;
 b=ZxcLruqDE7rmLcquF78RHJcW1oHwvkiJkiDAhqVOJ+Kmj2DNmwtrLpe8k1AGxi/hk/dfdpWURO5vFNRl9ZFSjGzgP2LyrBzWqCnRpPC5Y5qm9Pmdb+zQIYkTJsjVVMvQweNMg2zEbqg2ynEaHJmpDroF8sEL3rlKqJQTm2KILaFbsNiXTFRva8Ug9/QGYmkqI7IrkJZArfUAG2Nqm3+klzhe/tMPdtl92B4GcWprkkvPfMLXHpr75HvwSRts5R7g1mdgg9P31CEdJU+n/5siIWtyj6sDj1HpEPq4ZO5ZOVSAbIzqaWewajygKjwjv600mjwDEHEkAFxnU2yRdAEk9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBF/+xcUC7SYy7n6pS34IPqj2HMmC86wwahTNRmNGi0=;
 b=FRO4VjoO1oqrpEnWxBssMw6rUDnE96hQNMq7BGelO8shyCOQz1oPmAveX59ldt2mA0wEz4kS3hwJVtiHEinMkd+zWeu2+IGLCa5aOR0Zt+8S4TajO8XUMnr+WYoNF/KzVW068Y8GeETIZWYKyajBmLyfNoCAxWQxXieuulGRy8Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BL1PR12MB5125.namprd12.prod.outlook.com (2603:10b6:208:309::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 11 Jan
 2022 19:35:48 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f%4]) with mapi id 15.20.4888.009; Tue, 11 Jan 2022
 19:35:48 +0000
Message-ID: <3e09ef49-6645-59d8-5e66-1640c4ca91de@amd.com>
Date:   Tue, 11 Jan 2022 13:35:46 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 0/3] On AMD platforms only offer s2idle w/ proper FW
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "bjoern.daase@gmail.com" <bjoern.daase@gmail.com>
References: <20220105193910.25678-1-mario.limonciello@amd.com>
 <CAJZ5v0g-q4SLfK65bvWum7+OQZgbNQs47Pu3y-BCs9Px2C3Jag@mail.gmail.com>
 <eb3a323a-a4bb-bf8a-e642-88a2f68eeda7@amd.com>
 <CAJZ5v0hCVUNNgxn3bnn-mDKuYwnHSnOjwwXWiMJrv41dWuqCJQ@mail.gmail.com>
 <BL1PR12MB51443949D250B3963AEC1224F7519@BL1PR12MB5144.namprd12.prod.outlook.com>
 <CAJZ5v0iSR7rCpF3HKR_O0EUg7n80RM=oXm5MFh6f=DJZF+hWQg@mail.gmail.com>
 <BL1PR12MB5144434DE31017304CAA43FBF7519@BL1PR12MB5144.namprd12.prod.outlook.com>
 <e1a43f9b-e4d0-5df6-cd32-1843a1bd1b29@amd.com>
 <CAJZ5v0jiKfFE1pFS-vGefYpHdsUvRxrzUY-dbyvkPA1Ehssg-g@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0jiKfFE1pFS-vGefYpHdsUvRxrzUY-dbyvkPA1Ehssg-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:208:2d::45) To BL1PR12MB5157.namprd12.prod.outlook.com
 (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6dbffb7-8c2a-4dfb-74fe-08d9d53991be
X-MS-TrafficTypeDiagnostic: BL1PR12MB5125:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB51252E4706AC8813BC54E691E2519@BL1PR12MB5125.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VHI/CDWH3H5owy/1NK9xQk2gGBQxK5hXY5JsRtlBMvRiNWkj9FTlOUWxml3vmJrHKiT/FLVahPubJDxmytAILqHi+HgPLc3m5IhsH8JFlvKDRrJkvD5RfnPW1mF8quQTDq9kiiR/+nJl10r95jHuH5gcFkWwcRNo5upp+dZywKz24NfQTRgLHiJ5TBpTz9gwJ20Ug4W7wbaztNmYB2CTFcqo6yHT5NGokC5gLisFqOlVT2QzV/9aD/l3mgk41efqheTYoxeDkcAw/pggPyrfwiFSOb1GS9fLHOIBDVqrNGHJLMe8QtPBl1iJlHVeAkNzpSa/RDH4D54E/5eleL6/UZmYQjoozp++cilU+xcJebZaRlq1UnEKeakMGJ70wIzQluIwZDDCjMUVGrdBN3YpQSQGXUGKBbdvdtTqh5k+RuyXoU8FAtlYGmMeE5PEmiIJfITDbaiuRvfhu6rUXygOvw1n7YhiNEytvJijJVvjiQ7dat6Ch3Lw+A6ab9Nm+xoTZjTl0VcODDKyZpgxwtOD/xwMrwfEe1ZFfp4TUe+KF1S98C34PJ/jhWSGLY+qvfqWqbdhg2n/OHU9VPIABSRr5ibmDx0Z2aQWnUPCDrKQIYEW6b3pU8BbN6godg5+dAZc1n1y3c0AKSRKKd+N9P6zXIwynidHxtpL8ey+j/zo+cGmEGofbiGI7Ic0HtoB4eCSev5SDyEc6P7AQ6bf8UpN0Dr5Hlyhoi8wUNnW/LkFgDhxKUZ2DN/9fGWOAWiaIeA7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(6506007)(4326008)(508600001)(8676002)(2616005)(86362001)(186003)(31686004)(26005)(66946007)(5660300002)(66476007)(66556008)(31696002)(6916009)(83380400001)(38100700002)(2906002)(6486002)(6512007)(54906003)(316002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXlsNVE5OTNoTUZuTnZBOER6OVpHZ3orWVh4clJEMkpDakJhZGF1WEpDZ2x1?=
 =?utf-8?B?RWFKdy9zanRrZ1E4TXI4V0ZaMEYvZ2x0L0hzYXZNRndPY29ZYitPazdUN28r?=
 =?utf-8?B?UjllVnpWZUpPTzVWcHhrYTY3dTgrWEczWnJuY3E1SXdzeUV4WXZYdmdzZ2hP?=
 =?utf-8?B?Q01ML095eXBFVGdzdXZxak9QajlPTlVRZ0gydFViSDNOL3NRNzVCTi8xV3Vh?=
 =?utf-8?B?UW5vL3lNejNqQnIzV3laR2dUTE5VVWRwWkxjRUtlVzZqRDBTQzNHdXQ3QmEx?=
 =?utf-8?B?Rk9MY2lVNFM2MU5TNGpvVG9MTGVVQzVvT1c0NklwMkEyQmlnMzFzSmJzV3Qy?=
 =?utf-8?B?ekRHeFZwOHUwS3JDS1hPaVpIZU1kb3N2UTBzcjFjamwyLzNtK3U4SkRaNDJR?=
 =?utf-8?B?WVVwUlBKZjRGWW8vZEYxblE0UkJLM1hNVlFvbTdsZDllZ3h2QXA5dmFuZ0NI?=
 =?utf-8?B?MUNTUEd3dWdoMWZJbFg0VW9tTEc4ZW0zbGNITEZnTGJCRTRDTFpYYlBKOHRF?=
 =?utf-8?B?bjhqS0l6T043NG5wVEdJUkI3VXZsOVVKeGtRcHZQenJxMzhoZ1hxNnBCOHFv?=
 =?utf-8?B?bk41YThHVHc0eDhSZFNQcVVNUXhRREtJUjhEMmlYbGVLczlDQjZWbnl4MUtN?=
 =?utf-8?B?OXhVRDAyanF6Rnd6eVhMMUVzSTl3c3FUUno3T1drUkZMQjJLRVlnRW5tSlBm?=
 =?utf-8?B?NXNhT2s5SWF6ckg4SldubzhUbmRBQ3VGVjQzQVo5Q3pMb1N5RVl4SWJZQVdz?=
 =?utf-8?B?SENYamEySnZWNUt1U3oxemtBcmVFOTE4N0UvZXl1YlhVUFBQQlh3WGNxeFlh?=
 =?utf-8?B?ajBabTI2NllvUVBmL3VIYVZJcXAwSGxkNUJkWFFDdVgrUnZXSVhJZ3dFZXpi?=
 =?utf-8?B?aFIxZTVQR2EweStPZUs0bEIvT1RNa2lUNUtPODBOZGpFajNzenJ0Ym5tYVpH?=
 =?utf-8?B?Wk1memVNb1h3WElLRVlrRURjN3dBTlJHOEJYaU9BVXFhTCsyQlhLZGYwd2dN?=
 =?utf-8?B?MUovREpyaHlrcDdaWm9aM21YUlFaQjlacVlhQUtJZVcwSVBSOTVEZ0RDKzA3?=
 =?utf-8?B?S0pUbkxpOXFwWUZIbXovSzg3OXNKUjNXZ1BjSjNFeDJLa0g4aC9NV2toZC9h?=
 =?utf-8?B?dURnVzVpYmZPYWE3QllsRlhiWlFQRXNoVFQ4ZjBWc2kxQ0dTKzV3RmlDbndp?=
 =?utf-8?B?RmRWc1hoNE1ucWs0d0NacGRicHBPc1ZrNEEzUVNsRGtNb1hiWHN4TERvb2Vz?=
 =?utf-8?B?dFN6WnpRREdRejZZUWJYUEhGelFkenJsUFc2YlEvbVI2UWQzaFlBZUt6Uzh0?=
 =?utf-8?B?SmE1dE05cWx2SEdycnczYVA5a1FiNDNyQTRkcUkxZVNxL0o0RTJhekc2Ukgz?=
 =?utf-8?B?UGkzL3A3UHhHMXl5TGJQWUV0T0QycHd6eDNwelc2R2FMcGVWT1d0QitHSlps?=
 =?utf-8?B?MmcrU0RMZjJ1UkJJM0g3aWR1M3V6aVd2WWMvSndkdU9XLzQ5V1V1WjZDRWs3?=
 =?utf-8?B?cXdvS1llSW85QmZMNmd6aUJTaWdIeWxZUW9obDVTeDh3MHRKWURiakNJb2dL?=
 =?utf-8?B?UDVlR3hqRFdyc2tLM0tKbVFYNGM0SU45WWFyaHgxelBKWlpxVCs2S0d3M2p2?=
 =?utf-8?B?VUpxS2ZuSk1nTjY3NmhQVklHZ2UyQnREM2pybDdYYkZTZkFtTnFtaGhaWmVK?=
 =?utf-8?B?N2N6TDdEWURHOTJPUnpWTTFJVnBnQ1NTNGZ5anZGUFVrelBoZVNDOS9DRHJ6?=
 =?utf-8?B?WnM0SUUzd00vblNqRnJCSjdwVHJSZjMzQTdRdjlLOE1iQVVpOTBWRG5nemQ1?=
 =?utf-8?B?TFlMcmgzalVDdVhZNFMvaVVWRnBJS2pBRDZjM0h2RkExUVZ1OXd2azkrTzly?=
 =?utf-8?B?RXRyMHJjREZLaHV1MkZ2V25MVlRmZE5xVTJNbm5GVkxWOGt1M0VzV1FLaWxr?=
 =?utf-8?B?MkQzM0FDaUNTUlJ0SVJIUXY5UU5lWEJJbGNjZCtMbThoanNoT2ZzeTJoRVoy?=
 =?utf-8?B?ZFZRWmpGUml4Mm5GN2FpYWlXaU9sejBmVDM1dWlocDY2RHBwemhXc29TL1Fw?=
 =?utf-8?B?LytsZjd0V1NEQ1pIc0RPUllHMkYzZ2xCK0dBYmlXNTdnNHVOWmljZFpnalpq?=
 =?utf-8?B?WWtxWFJaV1Qrd3E1TktrRnNNanBnS3djOGx6MUZPeUtOZU81Skg0dVRmYlNH?=
 =?utf-8?Q?9PUkX9gRj50pvY+zJ7JCn0E=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6dbffb7-8c2a-4dfb-74fe-08d9d53991be
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 19:35:48.7634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9QrEMNaWxpT/r3E76pMt2O41CBNqmVc5TkSYZWhHVi4hVb8X6llht2Cz6/qEENGOr7IR81y6GmPq4ZpUQ8CoTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5125
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

>>
>> That's why I thought my patch series made sense.
>>
>> I guess another (antisocial) response would be to to return false when
>> the suspend callback for amdgpu happens and dev_err mentioning that
>> firmware support is needed for suspend.
> 
> If you want to avoid exposing s2idle at all in some cases, you need to
> change the sysfs I/F in /sys/power/ so that it doesn't expose "s2idle"
> in mem_sleep or "freeze" in state at all.  

Right now they make it so that s2idle isn't exposed in "mem_sleep", but 
"freeze" is still exposed in "state".

I'd be worried about breaking userspace with taking "freeze" out of state.

> That's much more intrusive
> than just failing every s2idle attempt (which is what the patches do
> AFAICS)
As they stand right now when the BIOS is set to S3:
# cat /sys/power/mem_sleep
[deep]

# echo freeze > /sys/power/state
Returns a failure though.

And then when it's set to Modern Standby :

# cat /sys/power/mem_sleep
[s2idle]

# echo freeze > /sys/power/state
Works

> 
> Do you want to do that for platforms supporting S3, or for platforms
> that don't support any kind of suspend at all?

You know since this series went out 
6dc8265f9803ccb7e5da804e01601f0c14f270e0 was merged.  This will probably
have cleaned up the problem state that Bjoern found in the first place.

So this is really a philosophical discussion now if it's worth offering 
s2idle in /sys/power/mem_sleep on AMD systems.

Admittedly this has been an APU notebook oriented discussion.  Platforms 
that don't support any kind of suspend (like servers) will get caught up 
in this and could no longer do s2idle either.

With the assumption that 6dc8265f9803ccb7e5da804e01601f0c14f270e0 helps 
the problem state I'm leaning back on we should add some warnings to let 
people know how to help themselves for power consumption if they did this.

We can probably put those in amdgpu though.
