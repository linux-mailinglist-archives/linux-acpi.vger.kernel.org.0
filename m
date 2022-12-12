Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1D164A560
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Dec 2022 17:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbiLLQ5t (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Dec 2022 11:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbiLLQ5m (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Dec 2022 11:57:42 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01AD2DF4
        for <linux-acpi@vger.kernel.org>; Mon, 12 Dec 2022 08:57:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDtGnHd3YT3r+Mo7rGXIM+A3WngdTQKObJDnS9nXmClRu9y0d9M8H+/oOP9phGjZn5ulfwA8FtFrdFYE/gGrvzXVaWkA7yZ2HFGfMu4y+D+BCOvaTnoo8UBEggF+Wp6iOxDWFgIdJzFzhFhK/ZaZ53uiEv2qCT/NSr6wqAWGPpiTbsi6iYqhW6AvLzkzJ4g9Vmgqq21XXdidcKzXWsoz8JPnnWccV0CXgz2qt2O18zrR6HGib8fmybiSi/B0xaKixakzg0dqezQi/Bg4c8Wb4ESXdkLfEGbZgNE3HXQM3DEkknyaXNwAf1sq+PWAkHZqUt3wOrHAmHB7WP7jocOKCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whUaEeX0TRKlB51e+R1Tywy3bFxAkXhh+epwV8VjBbo=;
 b=k5y/comF2stXZitFw705QU3ngJTZa4jYdlEDzePd7E3ElhAGbF0fZRRobzaY9FQZ1HbTERqYPo93xRW+3QGwEvjp3QufXTnPvOOutLIM9oFrg+UW9kWtZj6/qyqHiHDtlp0MGH/LhXKeDjmLN85s1LemOHAvsvj++x1y6q0msJUXZEYk7+MBATlbDU0znGt5W7i4HlxwjQ+W4Y96OYKxsC97Id9rbpzhYiNLdtinhdWklGemHz5U3/7Np5QvFu1IfaydvOHoX5w+YQJC2EzQSPtpxDerbHiCVPTdxiNxrT7qTA8JgNnBr5GTHFia1lrpHd2WXBGgr9BnoOV5eyWP3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whUaEeX0TRKlB51e+R1Tywy3bFxAkXhh+epwV8VjBbo=;
 b=G4SYbVRPYulY1L+DF51vrBq6rD/XoQm5quno5h1xJy/c8IlIbOsgdJvCkZJ/JwS3DgkSUly83SfihubVjlVmj2kAGBqRBU5UxR5FxnXYicxZFc3ldmMbNt3otGEQe+61V1aOj0/7Cg4CsHgTn/+VlF59RSRlzuHZ4ibH0PEXgos=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3270.namprd12.prod.outlook.com (2603:10b6:a03:137::31)
 by SA1PR12MB7410.namprd12.prod.outlook.com (2603:10b6:806:2b4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 16:57:38 +0000
Received: from BYAPR12MB3270.namprd12.prod.outlook.com
 ([fe80::b770:9062:384e:6908]) by BYAPR12MB3270.namprd12.prod.outlook.com
 ([fe80::b770:9062:384e:6908%6]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 16:57:38 +0000
Message-ID: <64f45c59-8b65-4f68-6cf0-995793de00fb@amd.com>
Date:   Mon, 12 Dec 2022 10:57:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 0/3] ACPI, APEI, EINJ: Add new CXL Error Types
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>
Cc:     "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <20221206205234.606073-1-Benjamin.Cheatham@amd.com>
 <SJ1PR11MB608313CBF490328F8C431796FC1B9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <8f9feb3e-4c32-5c16-558c-7693cc277992@amd.com>
 <SJ1PR11MB6083C4960BC481DE9BEF2BB7FC1B9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAJZ5v0jLdOXtTQx_PF=_QGRTcQjUAU=ZNzaQkDJ7O8bABhF1cw@mail.gmail.com>
Content-Language: en-US
From:   Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <CAJZ5v0jLdOXtTQx_PF=_QGRTcQjUAU=ZNzaQkDJ7O8bABhF1cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0101.namprd03.prod.outlook.com
 (2603:10b6:610:cd::16) To BYAPR12MB3270.namprd12.prod.outlook.com
 (2603:10b6:a03:137::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3270:EE_|SA1PR12MB7410:EE_
X-MS-Office365-Filtering-Correlation-Id: dbb38dbc-2792-4b02-5b25-08dadc61f97a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GbAu3s6L2eUPl/kr0MUYZrgCv/8huKIbChLahxJxucB4/jZ/sPQC6ebo2MVdFh+XZF2CaMG9utTaJY6KTdCxrEZYdYyylDUj1QxJVPmePyujM2FGjQFvsuzmZzfZrEVhRkWgRbmWfRSALm33ZmCAkGugAE+DKM4rsfDLtR6FEfRXgp8zmyQ5QUENyf6zfJAZnsr8IDFOD804FDWGPIkcfgaFIcqHs3jwTm7xHxGF897gsi04qP583tJh2mJ3wBy5azWt1XvIHn7OQ3BlHfarFz8mT1Np2ojaOs/fnxI9etsKwUGfEpHp+AmLToncA33tq4pfm3SWe9k+fMXl1PB414ssnob/s3lXs7uBxhaxz05BE/VjhWMx12PK5Li0Blk5/bPJ+mngsvUoisj3EXX3BeML3fSzYwaPUW/AQ35gW0rxd9X/Ontklzod9xIlJyZerXpN5ogZvN8BOfEBrhrY/ksD4AssxDhbqL53X4PVJhSqh6d5JLtoVfpBk0usoY8f8UcOSsfwjTBEjbOdq/CkxGIzHZXqMjscsErveYa9BUjPsdL+G55b4knCl1IEV6Icv6Z89mDO4ohpx2hSjRL9EWvRQPeRgvBJ0yDmsGYgoo0VFBSrHDlqnGgn1ZzyPTCrrf9QTKlCrv6Rx4SgxdfZWwZkzkDXIb1utPpggGSyKOKevC9sEcUfyacWHUKj/tH6VHwyFn951FsKJFiwhwZ10NTViax8tIDO2mTIrlh0arc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3270.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199015)(66946007)(36756003)(2616005)(110136005)(66476007)(8676002)(4326008)(5660300002)(316002)(66556008)(66899015)(54906003)(2906002)(86362001)(31696002)(38100700002)(41300700001)(8936002)(83380400001)(6666004)(31686004)(6486002)(478600001)(6512007)(186003)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3dmYlVtZC9XeWJNWVNJT0Z6ak0rcFNabVcvOXM4Rkk5MlB2aWhkMlhJOFc1?=
 =?utf-8?B?aTJ0WlRWTVZjOFAyeEk2WXZEcHVtcTNBWUpmWDExRUs2ZWZTNFYzZDYzOFdB?=
 =?utf-8?B?cFZhSHZtZ3ZvUlNsQllka01vSTcyVmxxQUhGeWhIS2tXR1ptanZTSGVNN3NW?=
 =?utf-8?B?MUFqUlQ0WU5HVlowRVBUdXM1NUZBajZqSXNud0RoekQrUWVwUHQvUjZHTHQx?=
 =?utf-8?B?ZTQrY29NTnBXYkUvNTkxcTZSaEtiaklPbWxqZWlqVHFiSFFINnNob0lWdGZK?=
 =?utf-8?B?WUVrbG9kRTNOWmlTYVNSazBXL3Q2S2JxVmYrQk1HeEQzWTlXOFRvNFVRaEk5?=
 =?utf-8?B?dVIxRUZQL1k4Q21lTXRURS8vSkRodUJTZmdPUlFCMUI1aFUvUENZSm95bXFV?=
 =?utf-8?B?bWhHUHBic1VqUEl6UmlqV3M4aVgxb3BQYUxIODVxT2RPUnNRa1dVeDBES05G?=
 =?utf-8?B?K3NrSVZVRUV2bDRYN2lHbUNrcUU2Q2h5bkluL1FQd2h6OVQ4RmlQQUxNdzQr?=
 =?utf-8?B?RlRGMDlNZVIydGpHbGNVUTRvNFZDalQ4YVdYbjVuOGUrQjRacDl1UFhHQVpK?=
 =?utf-8?B?WVV2NmJ1NmNLODBDZ0ZBT3c5MU84TVBnOWN3dStGYi9UK0l0ZFlZcmtuK2li?=
 =?utf-8?B?WGQ4d0c4QVVJUUllYmpIN2hGVGc4ZVMzRnFsRFFseWZMbjFsNjVibWx0U3c3?=
 =?utf-8?B?T3V1UTJoZlYwWnNNczNjU1BNRDVSMEhaQjFONGdoNmtUUFVLckxLdDJUaFB1?=
 =?utf-8?B?MlpPeVNBMXlScEhrUURnRElmT29oK0lmaEl1ZnRJaFlBYU1ZV1J4ejJLcTJN?=
 =?utf-8?B?R0JnMm45YW1pUG4zeDJtNStCcEZzaWx0ZXpzVlNDMVFLRzZKaFZoZkxJUjdR?=
 =?utf-8?B?RFlrY29IUUo4c08rek1aWVdUL1NURzlpcUV6STVnUGNwYjlSQUczWDN3NEdP?=
 =?utf-8?B?eFFiejRETGtGUlRKNlpTaEZ5VWUwL1JsRkp2YURqOWpDY2JRTG83LzJmaU1L?=
 =?utf-8?B?UVVKdkFRS2xyVnVXeWFDZ2dndjc2M1RkZUtDQjZqSk1qa2FubkxWZ0xWRDBO?=
 =?utf-8?B?MWpMdFVUZ2JEK3pEdmI0VzJwUFhoTnEzanUzaG12UUhOS1N2RWdRbXRqQlhp?=
 =?utf-8?B?UmttaU81MmZwTjdqL3dOaCtOdWI3ZHl2K2U3cm9BazR3TXJQMDBwanNqZlE4?=
 =?utf-8?B?V0QzaHNzRUhGdUQvUkpFc0cwYm5ERFhqVzZISzAydFpPT3VzY2dOOG9OWjQ0?=
 =?utf-8?B?emxHK2tKbDBGdE1EQ1ZsUUdROUFWeEQ1Sk9ZNjZMSWJDLysxLzI2YXludU9O?=
 =?utf-8?B?NGFJUlYzUTAyZ0pEWVF6VjE0M2RodlhBZ0lsWFJHM2cxZ2pWQk5mVWZDWkZi?=
 =?utf-8?B?SEFTczd2aWdCN1BTSG9MM0d4MTE1Sm1KN0loQ25uL3NTcE9vQWVHUHBuTjBZ?=
 =?utf-8?B?ZEY4KzIvY3VRVzVIVDUxRUEvakpGVEtsanFOMGhZQmJoT2txTnI5WUs1TjMw?=
 =?utf-8?B?dWxXWXdrTjlJZkVjVCtYWVpUQWluTlVkWVY1bzR3ZFhtYVVHNDIwTjVZTExJ?=
 =?utf-8?B?RGQ0bHNKVTNSaDN5a3FyWitFdFg3cXNLeklaZjYvOFVVVVFJNmp3dDBUTXRT?=
 =?utf-8?B?aTgvTGlDeUQvZUdLWjhTTzl6czZOQmVYbGZlazYyS0pjRnlRUU1UOHdsejNz?=
 =?utf-8?B?ZDNCby9XSzBIREN3aEFVY29JbFlyakZkWmNOK1pZUGxyVHNpbjdHRGhWUm1x?=
 =?utf-8?B?WGNpTU4vRjFHTVNFVU9KMXZWWGpiVUM1MndMcko2K0s2MTI2YlFUbjlPMUE5?=
 =?utf-8?B?RlZLdlhmQnVKMXpnR3RSeE04dnNyQ3VnU05zSXJWZktKMmdoNjJpdm53RzZL?=
 =?utf-8?B?Y0htVTRKY2xTQXJNUmxBSGdvVTZ5ZWhWMWgvZzc1MS9MUHFaMTQ2L0pmdlNJ?=
 =?utf-8?B?VDJaSGJEYU5CU0UrbHRNdFlhNlNndjhWbmpPS3NUU0lGRnZueW45ZGQ3eG9p?=
 =?utf-8?B?Z214NHRRVEdtWkR6MUU2eXE3MXVTM0xyc3dtQTFlak82OVh0MHRVLy9XbFE3?=
 =?utf-8?B?NzZJWW9xY3pFdUVONXJ3VHYvL05VWGRad29XalRkQndMT0p0cTU1R2U4bVNr?=
 =?utf-8?B?QmlXQ3RyNW0yOHNnb2hsWThyMDFmdnIwTk0zQXdFVkxrR3lpZWRjTzJyZWNB?=
 =?utf-8?Q?IBYcPk2uhMhMPQVjmF85kADU1pAsmwlW5BPUVL9s3DTt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb38dbc-2792-4b02-5b25-08dadc61f97a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3270.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 16:57:38.4174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nTEfS1Lk4cpT+WX5gHXx4Fuq5G9TsDGQh6uXd0L6SuypkEi7v8mVuLBkkpMxQfPmrbO8LWIUMJGJeibzGvE+ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7410
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 12/7/22 11:19 AM, Rafael J. Wysocki wrote:
> On Tue, Dec 6, 2022 at 10:37 PM Luck, Tony <tony.luck@intel.com> wrote:
>> Hi Ben,
>>
>>> The last patch I mentioned leaving out added support for injecting CXL
>>> errors, but I don't have access to a machine that I can test it with at
>>> the moment so it'll probably have to wait.
>> Parts 1 & 2 of your series can be applied now (as nice cleanups).
>>
>> But part 3 would just be confusing to users without the matching patch
>> to add CXL injection support.
>>
>> I.e. a user might
>>
>> # cat /sys/kernel/debug/apei/einj/available_error_type
>>
>> and see:
>>
>> 0x00001000      CXL.cache Protocol Correctable
>>
>> But:
>>
>> # echo 0x1000 > /sys/kernel/debug/apei/einj/error_type
>>
>> wouldn't do anything useful (may do weird stuff since the driver
>> doesn't appear to validate the "type" ... would be great if you fixed
>> that while you are digging around in this code :-).
>>
>> So I'm happy to offer up a "Reviewed-by: Tony Luck <tony.luck@intel.com>"
>> for all three parts. I just think that part 3 should not be applied until the
>> rest of the code to go with it is ready.
> I agree, so I've done accordingly.
>
> Patches [1-2/3] have been applied as 6.2 material (with very minor
> subject adjustments) and Ben please resend patch [3/3] when sending
> the other material mentioned above (and please feel free to add the
> tag from Tony to it when doing that).
Will do. Thanks for the review!
