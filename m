Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC68447B8A
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Nov 2021 09:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbhKHIJ4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Nov 2021 03:09:56 -0500
Received: from mail-dm6nam11on2082.outbound.protection.outlook.com ([40.107.223.82]:45121
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237325AbhKHIJz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 8 Nov 2021 03:09:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYkDYWoDToFp8QUjuMO80d1/jv5lD0W7v9EREBsNOPDLBGgpnNkTnk8gjl7sB7LXuHTqRxxiiivDPPqQC/xCjnm7T/YRjBj1jkaKLPTbZSZpNcT9HzSE7BDXxtI5FlvYNDaKHbVHFfZMy2px+SzBsqu9Y8JSYflhrW8AFwyvIqP444RZUwykKkceY7MdRobUfQPzw9I/LWQac7i95RVCrYG4X+KE9HCOvK8A25mz/xK2O5NhuE5YAjGlzahAYX+JOIVAcAzWLVOyaHuwhyObXVjLbcsr9a5kJNKT+4I41N41fAAZMRnOinDYT0jacT6YRPuuDHK0LiTvJPGZX0RPQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adnevkwbGqneeJTjA4bwAe9r+AmbAGMumaRg57b5sss=;
 b=Htn3GM/A4Fj5UDl5W+VXe6Nb9sytJyWbSjE9BiYkCV2mOzxPV6rIzLOvBTKX72i7S6Z7m92zvzLwfWjzHPlbxjgc9i/83zA7e/AsJ10ZqCjpmBOXUc2ST6P2DjyDaOi8/HNPbi4k6iKoXbFs9LMa1N4D00zsVl64DhzFRRed3syru0Pe3PO1A0fn6bw7vmqHEESfAvnu7RgVAUjdskpJmsZBy6cdS4I9E8PHgtuTDy3Xd4USyljjHZjr4MMr9NSEGYvzg/eYlO2yryzTISQwnJc8d6deeg9WqPHIcPG1y3JNhQuH6y1yZY0/X+PaXOHp8HK61nNdvILzManOUOpU6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adnevkwbGqneeJTjA4bwAe9r+AmbAGMumaRg57b5sss=;
 b=Z02Ky6wy4QSXZMuiM6BEoyhaQevymD+yAsLijRPVMRuyvgYAwIWJGSeN5TRFQarEkwRrZT3dJLO2/Jxhq7YByPMi5hxKfPaVbXTanBTYV9DkzBkue003S3EZ69KJChJk29eYo8dKmgKu3M6FPpkAlya3ZzhjvVWzPQp74chX1CE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3627.namprd12.prod.outlook.com (2603:10b6:5:3e::18) by
 DM6PR12MB2955.namprd12.prod.outlook.com (2603:10b6:5:181::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.15; Mon, 8 Nov 2021 08:07:09 +0000
Received: from DM6PR12MB3627.namprd12.prod.outlook.com
 ([fe80::549b:1773:f036:9ee2]) by DM6PR12MB3627.namprd12.prod.outlook.com
 ([fe80::549b:1773:f036:9ee2%4]) with mapi id 15.20.4649.019; Mon, 8 Nov 2021
 08:07:09 +0000
Message-ID: <acc78695-9156-7f39-619f-75434bcb3a1f@amd.com>
Date:   Mon, 8 Nov 2021 13:36:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2 RESEND 2/5] drivers: acpi: acpi_apd: Remove unused
 device property "is-rv"
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-clk <linux-clk@vger.kernel.org>, Vijendar.Mukunda@amd.com,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>
References: <20211029063228.578909-1-AjitKumar.Pandey@amd.com>
 <20211029063228.578909-3-AjitKumar.Pandey@amd.com>
 <CAJZ5v0jXnwC-C8mAWtQDtoPko9ALAYhpm3X-TZ5L83ROEUJWmA@mail.gmail.com>
 <20211105222221.8AF8C60E93@mail.kernel.org>
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
In-Reply-To: <20211105222221.8AF8C60E93@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0155.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::25) To DM6PR12MB3627.namprd12.prod.outlook.com
 (2603:10b6:5:3e::18)
MIME-Version: 1.0
Received: from [172.31.154.86] (165.204.158.249) by BM1PR01CA0155.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:68::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Mon, 8 Nov 2021 08:07:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41c10182-d924-4b6a-4e4e-08d9a28ec330
X-MS-TrafficTypeDiagnostic: DM6PR12MB2955:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2955E843677015FC2D2D916482919@DM6PR12MB2955.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 23sHpSjFNVwk/0cz3LYf5maRg2X9qW3G12VX0vIkhvhrXCIE4bSc2lPSxE9kmY6ckDDN/6qmhjJ/QuDVxszdIyZaflDD+4AQcGxk48eFnrFwytK2KTgMusB/SxLFnsQ6wpllHvRRN6sukUhf1r+X2nOkWG2NkyWKbLsubCkTJ956XLPathBLzW824w23s+eua89QGxpnXwbNDwhbD9CGwsphpFcOUsHGC60vpFwFybLvIQ2q2Obgzfho8bpTLkpeHHUohrcbUsDTSYvEePfLsyNBUzXBHsYl3OpRQUgcelo59hTepGyVmFbpOMOuHgRSOnGG+XSS2taYa0GATdTSsAgaz+XVL5EKQa3K0DmARCQULA+M34WSw5VTlP1n41zRmRw/KCnrh3YyA5C5kJev/mY1HJBw1xdVZCLOWUEWqAU41ntObLxbylsDT5tjJo4ASyYB7woYYL6ExViB2zxYFAZCgEJJYXylpAGaQcwEw6fuWqmWAh3EAtCkGhTs4S1hhnF4pRNPzIFgYUpAEDeKwG1Whk6FrNhFOQOqcK6FQRi3n+DYoRHiVDAfA7LCxQQfm/Ojy4ZFhxx3nfpGIkPM21uuyhaXfZFb9X9lTGwbZtEVFIDMrLRKmxYqXJT+bZFz5diO1PdX+gZLakFa+M+6C8/wwzEm/VOhEx2dvG0dgQvoHfP8VXXetLJynMO1/O0AOjmfl5orymTWDSj5kLKp6OBESOmcWFVuw4HcR1QOV80=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3627.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(186003)(4326008)(2616005)(956004)(5660300002)(6486002)(53546011)(8676002)(66946007)(66476007)(66556008)(31696002)(8936002)(110136005)(316002)(54906003)(16576012)(508600001)(26005)(6666004)(38100700002)(86362001)(31686004)(36756003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFBQNnJjd3RseTlhTFZTTVNNREJnRmpSTXBXNUttTlZWcmFndks2OVZMZXV1?=
 =?utf-8?B?bmpxVmp5WVdsNWxCODkzY1pwT0sxdTNqVHFQOGFLOXJkbmZsVWFXOThzbDBN?=
 =?utf-8?B?eW5XV21JNHFoWVJtdG9HR08veHAyeUtJZHBGdlhHb1V3NXR4a2ltQXdhNlpT?=
 =?utf-8?B?NmVqaDBaUE9xbFl3T1B2T3hFRTQrOU1HYTZ6RHY4WWZEWlVXSmM0L25jY3hL?=
 =?utf-8?B?d1IxZmpBTm90Y2tESGZ6WXpNMXNac2JFM1Rzb2lSU2hzaTlaQWt5MjJ3bFZO?=
 =?utf-8?B?dG1mTGlORmE0Z0RrTDRGQWlodEpHSGxtdHZoS1FJMC9SdmVmM3UvM2t2ZWN3?=
 =?utf-8?B?RmdnOEZiV2FVem16eVdhR1VTTHN2YkV0K3FTRVN2UmZtRHRGMkZyd3I2aW1v?=
 =?utf-8?B?WHRTRzRVU2NaUzUvZWdoVytRc2lIcjFuVHBoNm9FTEZjKzg2b0FVM1NJQXBp?=
 =?utf-8?B?R0cwaUZCNm1NYWlJVVFRK3gvR0ltbkJKOHRFRzh5RCtxRlN1MmVLYnJ1MEd1?=
 =?utf-8?B?ZEttb202L1EvSFdBOVM0b3pCNDlxTlJwQnJ5azJDOC9kV3locXpPMGViWTlB?=
 =?utf-8?B?S3FQZStaR1JBWFJEYXBJTm04UW0rWXZlUFBqOGgzc3BHcDJFaTNHc2xMdkxi?=
 =?utf-8?B?bS9RQlBjZDVxb0RXYXlqUTNjODlFb3h4NlZIWENWdmVHT3VSdVNFT2ZUUnR0?=
 =?utf-8?B?THlWMnVyWm11NUlEeGo2V091amk2RzlFbU5HU2l5N0pBVDV4VHVhN25iR0RV?=
 =?utf-8?B?S0tMck1DNEpjUDhKNzRiZ29oTkE5ZE5BQU1VM1p0MW5YbGtJMTZOb2NWL25i?=
 =?utf-8?B?L0N3TURENkEyT1pOZnlFVWYxQlE1UTN3R1YxdjBXbDdtMzYwbDFCWFhGZ0Nl?=
 =?utf-8?B?Y1cvUStna0ZpWUVTdlFaVy9PNk55UGs4ek5aRkhEYTRvN2pPTUdFWXRiTmJn?=
 =?utf-8?B?bm5XUXZVZGxZQTU3T2k2dkhzbHVIcEV1TjBkd2NkaWx2L1Qwd0JFSXBDaEFB?=
 =?utf-8?B?Ry9WTkRVZzhNTDl1a29MKzBtbi91aUVVRGsvN1FkQTkxNysyc2V6ZGVKZU5P?=
 =?utf-8?B?RDJRbDlXb0JITkx4Rm1WMHoxVytHbEU4TU9rWUZGQm5WMlliNEJJVFhpa2gz?=
 =?utf-8?B?VzNvZnN4V3gybGxmMzd3R0w4aGhhNFVpdVlsVldtTytSTlQ2ZjBqWmEzbzB0?=
 =?utf-8?B?QTV1cDY0eTlOZCtDa2V1T1FYVjFqQjJScEpEVU9XNjBSOEpWbldqbXFRc2N6?=
 =?utf-8?B?b1cxZGFpc0YvS0ZBWWlkR2RSZVdsTVJROTF4M3NQMmsyczlGcmczRVhCL1ZY?=
 =?utf-8?B?TkRsWGo5anNZdmlzc1QycUQ4NXVLL0N2a0kzMEJ6UUVxaFRZdEVBMmJHUjhI?=
 =?utf-8?B?akNQdzM5N08xcURIZHhvdkRRTnJNWHdBWXl0aFFZRjMrTjE5eVdIeG4xNWlu?=
 =?utf-8?B?SS9NcENXTTdXSE50TFRwaWpsck9HTy9vK3FrbWpMWHIzVmQxY3gzVC81V1k1?=
 =?utf-8?B?TU1hRXhDVkljQWhiVVBsZlRaSS9sNTg0QXZPY3JIenloRGFoVU1ENUZLeUtw?=
 =?utf-8?B?ZXU2UzVQQm51ME1JTE5jSVQwYUVxZ0VlSldiZGhHYUhlZFB4dDNuSlEza2Zy?=
 =?utf-8?B?Wlk4dWIyeFJCNXZJWGpLRlU1RWc1UXRQSkFWSmlRQUlzbzcxMGpVMDJiQ01q?=
 =?utf-8?B?QTJvNWpTN2ZEQ3kvcnVRcTVTR2Q5Z0FURDNUMHd4NzRWcUZMSVFUV0NZQkRm?=
 =?utf-8?B?WUdWN25xWFJDNmVCNkM0c3lFaXhuUjJIRHpHTjJlaGxBU2prL3d2QlhBaXBu?=
 =?utf-8?B?K0hEUVU1am1pcUh5TVNjZmlmdUIyY3VkK1lnWkdqa2pOcnk4R0pxM25IOGxr?=
 =?utf-8?B?bFZxcDBIcVVrSnVOSXB3ZGswS1J3d0pKaEFhb0pNcGpHbGFuNmhFcmRiM2Y5?=
 =?utf-8?B?aHRPbTA2cjVaWUwycFNObUJLTHdIYlBmVWxoOEVzQm9GY0paNXpMK3dERkZr?=
 =?utf-8?B?eUhRclRtZnpVY0c3aS96YnNWWnA5UjEzbit2VHdxbGF6czU1TnNoZ0YrdjJ0?=
 =?utf-8?B?bHBlYjBBeGpjYTFvSlIzTGpKNnE0dVdBZEpmZE1NWUVuOTNZek05RnpTZ2pN?=
 =?utf-8?B?MjdMNTNJRlVZSHdBcEVnSDdjbGVBRms4QytPd1F0Z0pRblR0cUtBZnlPb1hC?=
 =?utf-8?Q?mMFtIKnW+yHyJEyqEwJI8Kk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c10182-d924-4b6a-4e4e-08d9a28ec330
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3627.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 08:07:09.7032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vm/eKcaJnEvO68u2VQPbUtpcp/IXz6BIRT5OQXYkaPYYPbu+yixqs9UBr4VnrRw3JUqcmVc6QpxJOLBUOIjL2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2955
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 11/6/2021 3:52 AM, Stephen Boyd wrote:
> [CAUTION: External Email]
> 
> Quoting Rafael J. Wysocki (2021-11-05 08:02:26)
>> On Fri, Oct 29, 2021 at 8:33 AM Ajit Kumar Pandey
>> <AjitKumar.Pandey@amd.com> wrote:
>>>
>>> Initially "is-rv" device property is added for 48MHz fixed clock
>>> support on Raven or RV architecture. It's unused now as we moved
>>> to clock config based selection to extend such support on others
>>> architecture. This change removed unused code from acpi driver.
>>>
>>> Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
>>
>> Is this and the [3/5] applicable without the [1/5]?
>>
>> If so, I can pick them up once they are approved by some other AMD
>> folks, preferably Mario.
> 
> I'm still lost why we're putting this decision to have some clk or not
> into Kconfig.
> 
I agree it's kind of weird to select clock based on Kconfig but only 
reason to put Kconfig based selection is that this clk support required 
on some older platforms where BIOS or bootloader change isn't feasible.
We have only one consumer for this 48MHzclk i.e audio drivers and idea 
is that this config shouldn't be user-selectable one and automatically
select from audio machine driver which uses this clk.
