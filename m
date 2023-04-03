Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6337F6D4E2F
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Apr 2023 18:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjDCQlV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 Apr 2023 12:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjDCQlT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Apr 2023 12:41:19 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E9A1717
        for <linux-acpi@vger.kernel.org>; Mon,  3 Apr 2023 09:41:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D42JRCCROXWWTHttnFHbAH7/Zc7RsjJGjCK04UpwVk1FdYfotHGq4cw2IyhfDOywp9wk/rqvZz+r0KJaloK7HJJHYR+CSCz46o0HZHGUPHQGVr/z132uxshiHlYWtoeu8oag2QXLDR1dZOfNoKEaGOx3ctZL9w+YkbnXVgfBOQjq17VuZXMiENrQW/dJbaoxgb8hIUZxvGk2EIrCb+f/uSapzmiHxeD2nVSUt1Er+5rQ0You9vccxTTqY2J8sNJ+ebbWpkMf7c+yhypCM94Lut6xKH2XLbiOX0QQAgWdx4EPH8n4Qz5OvuMdTJC3kjLyJFq7m6WOthDypmjjy4zrxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=on86ywwLtBS9LYq0UnpHAqjl1zEzobk6c4vxRoGa7kk=;
 b=S7lqTHNzpvY7BKC22nPtbfyjqyPyBY1yuvXSHdBQJVfjpLSv2GLvuKAzT/KOGbytpRLdpJuSAYIdwnt+FPdwP+U2KLWCDk0r8VSFD1lVz6FHK/msZn3gHtNBHeC7sip+HHMG9vaEEn63MFoboaWnJEvXzKSJ98FPvLicWYUofYIC3S+Z64e4gf5kYImtwZzxM0ATZYbddxtcTGaRY4/I5MFjGMDVRB2Gyw9zGJP/h/mMr9MPKMjT8dBo4sWU8WR44au4zqS/oTIJ8bZSablgN2dgtyJgO6jEb94i1GNvDc73vTayWEQd8HYapAqa80cN9MYY67HPTSbdyucRazOxbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=on86ywwLtBS9LYq0UnpHAqjl1zEzobk6c4vxRoGa7kk=;
 b=KfkZuWIHfaDsRxPQDJ+nHO/51AxJKQHh9q2LhWgxYCgdQkesv5XawWg7+4uQtNBbZgkcUX/IMNTZYvuVe4z5z+icYfR52njyZg0yEwbEiOXVImftJqFtO728lhm9ayAEabvjDtnj5ZfvpYL7T1nn11x+Bc4eO1LwDjU82dxT2hI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB8334.namprd12.prod.outlook.com (2603:10b6:208:3ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Mon, 3 Apr
 2023 16:41:15 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe%2]) with mapi id 15.20.6254.028; Mon, 3 Apr 2023
 16:41:15 +0000
Message-ID: <25d3331e-a72f-2a92-2a1f-8ea189f1ac7e@amd.com>
Date:   Mon, 3 Apr 2023 11:41:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 0/6] ACPI: video: Fix missing acpi_video# devices on some
 systems
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Daniel Dadap <ddadap@nvidia.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
References: <20230403160329.707176-1-hdegoede@redhat.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230403160329.707176-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:208:335::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: fd226656-f0e2-4979-83ce-08db34623dbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p1SgEvpFRcsncpYdSQj2KCbEXavjyWqx1DTt3dimm289gB4q79a7zyk/3pYT928Kr7mPWAHvxZp4jXpKGuKeKgAacFYvQKHh2kI9HIy4/VTtKCYqs0Xu0kKdTIGbMkJg3BwuQTJnHQEMaKz9UiVWG8KiIgnxuf11QnLrUW7bxAqByWJtuR8YW7wwh+ncS6h3/a/aRTKI6WomEd1pVofGzjFyH2NRmrTGAt+cCFmG9uycTqSHyI8Ssb/UgiEZDOaXgd8B0gJrzugH2vsEBAnwGrObz6jvw0eJHTBM7rUGBrcZAtLey+TQzrA95/tBHg7hHO/oBTWGd1d9CsCBlRta25wSzrZ7aSMRJGUs/ckDoyOCIRXEBx+bkD7UrlrWU9AVuccj8DFGGGjG7gJOgEOFcOR2RUfNV/tb8XhFCSnAF/qjUi6jI1mfQG2OBxQsbC78j5QEBc825xrknDOSrNyVPKJdcqQb8VDWb6F0VESBMd+Lu0ZF2iFHRgm61LhuSjzMEe0TWqoFHnT1MhQZ90zFMZ47MwKRh7EuPtj04czITyHl03wbMmWibhw0SFjqhONhaHkBNVgv27rZMGGyRfd/3Zhrt7+Ma1FrzjjVhirwfMXRLGDrwbZkJ7iAcit0FqXnydv2IlCPe7hBwV2sg0/WEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199021)(186003)(66899021)(53546011)(6512007)(6506007)(26005)(110136005)(31686004)(54906003)(478600001)(38100700002)(36756003)(66556008)(86362001)(66946007)(66476007)(83380400001)(8676002)(4326008)(316002)(31696002)(2906002)(41300700001)(5660300002)(6486002)(8936002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0Y3cEx0SjNJTXpkamhyTVQ0UHo2cFRTek9JUXhnVitZeTUyYTJhVnVGK09r?=
 =?utf-8?B?QTBGRHIrempkL2VydVhaRFlBUGFvbFU3NjhnQ3RtdkUxZk1LUUIxSzJSMml4?=
 =?utf-8?B?aXBabmhtU1dIdnh4VlBRTkpRMVd4ZG8rREJNYmE0b3pzclRnaTdjTkVaZzFp?=
 =?utf-8?B?cHk1cTEybks4MmN2ejFRZnhWVGw3QmdhT2hZUW1HdUNmbWRqZ251cmd2MjJj?=
 =?utf-8?B?WEtUK05WRi9rWDRxenJ2V01CbFMxQnlaalBQeWg5bHlPclR0MWZPN00rZFJN?=
 =?utf-8?B?QmZFbzNJYjNjL3B3RVZDL2FRbVQvd1hOWjJsTm5oRU9aTmlzNkNPb2twd2JY?=
 =?utf-8?B?dFliazFKVmh5eThURVZxUHlRUnZ6MXNxb1I5VWY2VC9ZMlJIa2toRVZNSGI3?=
 =?utf-8?B?OVI5czJhNW1XV3B2bVlRUmdaZWc5cG9OQzdBejlydmhlVmJQcjUzS09xRHJV?=
 =?utf-8?B?dzljdlJBWlBlejVaQ3VNOFpzQXBuVlc2TUtJVEUwTEJ2dFY4dnlBK3o2V09P?=
 =?utf-8?B?Q09pSmdaWVpVZ3V0c2FEUzRPdEluVVBOcTgyd280eEFPZWNTV3ZNNmZFNElx?=
 =?utf-8?B?ME9zQzE4SVV6RWpGb3NEOTkzalZucWxUT1NZdFFSWTNKNFBMc3hlTDJsRkls?=
 =?utf-8?B?SWJDZmRyM2NsR0pwMVpuK0s5d3R1UjIzcGE1aDJhbjdFeUh3Z08yRFBpUGRB?=
 =?utf-8?B?K1lmZlY2WjRMNHBvMTc2OHpyNEZ0bjBFZll2NVQvSHBqMjlmR3EwSlBwN1pT?=
 =?utf-8?B?WFlmRXR1WjhSeXNOOU9GYmFKY3RpUGhsVnEwNzhyYnNSSitaZXd1dlh2RFFR?=
 =?utf-8?B?N3l0UDdROElMaStydVlqT28vUmwxK084b0pTblVZTkgwTktzbTg0QVoydk94?=
 =?utf-8?B?dTAzTm1uSlRsTzZYSXhYdnpsVFpNWk5yTERXdzZhU3lQdVQxZUZWMWJFbGJa?=
 =?utf-8?B?eHdlSm9yQzlQUG1mMVAvMm9LSU8xd2s1STRIbC9CV3NMRVhhcXZ2NGZFeG1m?=
 =?utf-8?B?R1ZPK2xENHBydThudW4zbnV4K0lHWFU3OEErZnhlRS9yK1MvMDN6WXVZYjJk?=
 =?utf-8?B?ZnltdWNhaUM5RWtwTS9EdjFsN0dYam9WQU5ZMVpPT0xUMWRLcmd4aXYwZHV4?=
 =?utf-8?B?ejNBZXE5ZEZha2tEclIwOCs2N0dGaDFFb0FlS1BFbjRSL2tqQ1lTenN1b05s?=
 =?utf-8?B?eUZ2eEhVWUlXZG9wUHhwOFliVVNueG1UQmhtWnBsOVltYWZHUXg1c3BUaUlw?=
 =?utf-8?B?MjlxV0xiaWxEbURDWXEvcXFRMWRIc3JrQjdmV0hzdmdWNVM1UmphY2ZsQTFD?=
 =?utf-8?B?UkVaWDVVb1BveW9CMkFrQkxxRzhoTEpweWZyZFBJYzFFWkIwaHczTXhMb2ZM?=
 =?utf-8?B?ZS96VVgwbFhaZVMzQjJEUE82dGdGalM0cEUxV3U3RzBWem5Td1hHN1RZcTQ5?=
 =?utf-8?B?TEIzTXpJVzk3VDlBR0RPSTZhTkl6NGpwWEE2N0lmUm0vcDR2ZmZvWnBXRFh0?=
 =?utf-8?B?U2psWndERkJkcUFGTmkvMVpmMU1NZnZ5SmU3ZlVvVXU5Qzl4bUh3Y1BTQzFO?=
 =?utf-8?B?UmlRUVVQQytxQm41cEladndmOEx6SCtJb3B5c0tmUlVHSUhBZXhQbVhlK1N1?=
 =?utf-8?B?T2kzRG0rY3N0VDlWRy9mRE9HZWo0SUI0cEN2cVRzTkhHdlB0Y1FMRmp4bVNH?=
 =?utf-8?B?U1F3NnNIMjZzV0tjVGF2YmZSOHJSOTNhTkdVNTJxK3NDL0VTdWQxMTg0Q2pI?=
 =?utf-8?B?eHY5eFpKalU4TC83ZzJHNlNYMElqR1VxVDQzTzFTSEF1SVdiclp3UzJEWkQ0?=
 =?utf-8?B?UkFJelJSL0RKNEk3azV6bmN6RmlsTUJsRlpZWXZyelNSM3BVQVBRZGpmVUFv?=
 =?utf-8?B?aDBGU1NNZytzUlUrcDdsVncxTm1nN25UbklneWZkQitmLzlXVkpxV0QvbDJ0?=
 =?utf-8?B?RkFGV09IR0o5R3ZYa3V1SStOcnhwcEJXL2I5emtuRnQ1VCtEdUxLcFY5NUov?=
 =?utf-8?B?bWNMU05aejFZbU14RUtURkw3RHllWGE4ZTZNNCtvREdUeDhxZnkyZTJVY2lh?=
 =?utf-8?B?V1NlY1NpMjUxc2txV3FyWDNaanNGZCtJQUVnU0phWjBId280cWYvdmVZK0Ev?=
 =?utf-8?Q?5EzldUXdUnUTiulpABXFkVpAL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd226656-f0e2-4979-83ce-08db34623dbf
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 16:41:15.1692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /2lUAG0Bx6JxHlz6FMj7KmM9ft4/N6OF2XT5Xb1FSWHZQY/4SJ3kJnq0133cudBbdcje+OUI8GtduKkJAv95rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8334
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 4/3/2023 11:03, Hans de Goede wrote:
> Hi Rafael,
> 
> This patch series consists of 2 parts:
> 
> 1. Fix missing acpi_video# devices on some systems, currently in kernels
>     >= 6.1.5 and >= 6.2.0 acpi_video# backlight class devices will only
>     get registered (by default) when a GPU driver asks for this by calling
>     acpi_video_register_backlight(). This is causing backlight control to
>     be missing on some systems.
> 
>     Patches 1-4 fix this and ideally these should be send to Linus for
>     an upcoming 6.3-rc# release.
> 
> 2. Now that the dust has settled a bit on the backlight refactor we can
>     do some further cleanups. This is done in patches 5 + 6. Note that
>     patch 5 depends on patch 2.
> 
> Regards,
> 
> Hans
> 
> 
> Hans de Goede (6):
>    ACPI: video: Add auto_detect arg to __acpi_video_get_backlight_type()
>    ACPI: video: Make acpi_backlight=video work independent from GPU
>      driver
>    ACPI: video: Add acpi_backlight=video quirk for Apple iMac14,1 and
>      iMac14,2
>    ACPI: video: Add acpi_backlight=video quirk for Lenovo ThinkPad W530
>    ACPI: video: Remove register_backlight_delay module option and code
>    ACPI: video: Remove desktops without backlight DMI quirks
> 
>   drivers/acpi/acpi_video.c                     | 53 +++--------
>   drivers/acpi/video_detect.c                   | 87 ++++++++++---------
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 -
>   include/acpi/video.h                          | 17 +++-
>   4 files changed, 71 insertions(+), 90 deletions(-)
> 

One minor nit on a patch, otherwise:

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
