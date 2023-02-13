Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34446947B1
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Feb 2023 15:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjBMOG2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Feb 2023 09:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjBMOG1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Feb 2023 09:06:27 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E0B1ABE2;
        Mon, 13 Feb 2023 06:06:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7BFHu2joEwu4HUzkFD9N0ikQDrmCC4wL8WgnJAaW03KzA5vTECUX8ldoPZEj19aDjiAL/LgTWLCQ/vLsgAZiHr7fkeBVlBafVnYKEMAfojcgXOYflxYKkNsHt79+7IC/lAZuYCt9+LRKhmK5U1H8SdpvbW5d5k4OvNzmenQOtSLL8/n4Au+JYVs52cMd1GIO86WzGWayL3ZNdpaxjDMiGrHcd5pM9atLxTxuWiuJiNXwKjDcI7ib/U43yMWqCpLBNFOqqpaZ2vD0IRTrWIq/iU2a953XRh41i3dlnWP+UMQXoglaqXjksaX8MRu5XGEhjdXNUz8hp9393OpBYQCcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSpYi48hI00TplssZkNsXxwro7N09FY+iaiVfvBiusM=;
 b=URu9FVDiiftQyzPraq97HzuU+0eExA+rwD+nPsr/R7y6XKOIa4F8KRgyBFZvjOuVRa6G5UpdLE0pIiazvFVvPa5HLs8j1EyBomB6iPM0K26rJZ/bOpyFo16vNi30boi4TNqai5VXKZlS5kKblovW9+50WMEhqjx1CXCV+GVDO8YzR5IdAG1dax9EX99zeP+LjzZC71s9UlEdjZ5VyD7ILGIr2I2qcP5wF75l6nOWQuoP/IS5kpSRq0V/kAaSePBAn4t8NXrZ9XUAA0OY9Ty38KFH6AsU2/BSY3hPfjTZcZieP6t+d40WRY9OCzvpzKODtFXOI8bs817j9j604if0nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSpYi48hI00TplssZkNsXxwro7N09FY+iaiVfvBiusM=;
 b=hY1wed7yDDm+KczzVO5G2BWo8R0y9e6DKjjLYBy4IfrbuRwNxivhasgOjPY/xOMpdn0rTzuu7USfdle57ymE1w6B5I48omdofOblmYz7Q1xN6kSzbs7zeY68iFHok5bFPE3XJkjfN6TBORytq4nNZ0FD3ZX8Ck6Wh8CQ7WIVJzY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB7366.namprd12.prod.outlook.com (2603:10b6:806:2b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 14:06:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%5]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 14:06:23 +0000
Message-ID: <ac5f2aa2-e1fb-5335-12f3-9616fb294bc8@amd.com>
Date:   Mon, 13 Feb 2023 08:06:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: RFI: Tablet mode support on HP Pro x360 435 G9 w/ AMD Ryzen 7
 5825U
Content-Language: en-US
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Carsten Hatger <xmb8dsv4@gmail.com>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Jorge Lopez <jorgealtxwork@gmail.com>
References: <CACp=KFQN79Rz0CHP-5kwP9Y5Y9bEAoN0eJzoOpSejg6aF9qnpw@mail.gmail.com>
 <233344ca-5df1-abd9-6fb6-c04634f1b401@redhat.com>
 <79e4b25a-2b45-e21d-e4a2-f886204d8300@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <79e4b25a-2b45-e21d-e4a2-f886204d8300@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0016.namprd08.prod.outlook.com
 (2603:10b6:805:66::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: d62163be-a814-4432-052e-08db0dcb7d59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z6TpYXEx8aJyM7K5cRF88QTl7sFxsa+4YSRMMjSIX1d8cwZJRZXnY0kqj+5COg1FjKioCS7eSHPYz75J2iz6hrZ3FjdFQgYB7FZ0cYIpFGjrwz1wOoVlkea29IgqET4ELxUc+AcA1JFw9G4PYj2LlaiVbKMII69fxufLsT2HmiOKYD8YzyB/EXBuy1c3aWK7UVW7TNyN8LXGGfKFwjJGQengbqWtddrEnxU1/J/zlF3w2x3fqQ3Ay2fK6+4dlslGS+vd1OugzI7+Ox8RkcQ+7kON0sl1SosywSj56yBORuGgQ9n0sq77Tq+uJalNWR7hcQqSkJ8cDqfan0aF6yxA2DSFuBRDg6bD0HKkHNyloo5YdEG9JnGuRv1jifbCRYoYAR2A/OLGPyqOg60s8Zt/YvhytG1k4m9sZzExdgG3KAIDL50TPAAC+IFskvDbIzuMP11zJXwrrQDvX0MQl8AX+J1B8M4VGLVhFN2mpA7vPEawq8sj+Ojj0M4ZeHASQg9MyIDZjNmK8uBW0/4dnB3Gbp9nGYap0adkaujCJM8YlVbk4Gzy5JjtDerO1Gz32YAK1N6wFrdBNFNTZEzobBjTe2KRpDMppDUmlmWGRlHOXMUm6MocKXiTdZPNa9voPDV2VXO63nXsW0t4St6e7X1R09FgEBpmKrvn9+4KoBI/2ZQIJWSf7NjLfTmQYXxmHCnzI261L4Wk5e8c0O0G2mYyGc8vlYKfThtaQM1hHXvtnWbFrwWUpCnQfu0P9Rc/ZvzCjXzfjTQc1ol0N7B6nnsVmaPphYtI7yR4+iiMFPXOQnQiG1d/Rniq6hyB+CynvxXh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(451199018)(31686004)(83380400001)(36756003)(86362001)(31696002)(8676002)(66556008)(66476007)(38100700002)(66946007)(2616005)(6512007)(186003)(478600001)(6486002)(110136005)(53546011)(45080400002)(966005)(5660300002)(316002)(6506007)(41300700001)(8936002)(2906002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGN6bHdPYlNaTXpNUGRmd2sza3I3ZTFzd2oycmFvVE5sMHQ1ZXBucG16eW96?=
 =?utf-8?B?akRGNFI3RWc5N3dQSytRUzdvWWtwM0I0ZUJBV01PZXg4Vi9jZG80TmUzRVo1?=
 =?utf-8?B?N2tENnBoa1UrSHRtTktDbXJqaVE4KzlJM0pVTzZKVGxSN2RnRVE5NDZHU0hJ?=
 =?utf-8?B?LzFuVjNkK3c0YWdhT2NjdnYyN0JiOVprN2RIV05hTkMyMTZUZURYUmFKUisy?=
 =?utf-8?B?akRVb2lKN2RWMm1JNEVtaVpRTnQ3c0ZUM1ZUOEd6MjdhN0ZkWlhyY1lLdjAx?=
 =?utf-8?B?WU5aMHVJbmRIamdFRm9Yb3pDbWJsUDA3dElYNHc5RFV4VHdZSkhRRkdscmU2?=
 =?utf-8?B?em0zOER2NFcvNk50MDlBdEtFU2ROMUJjWTlSMFFhNXp4YmRvUU5va0t5b1hM?=
 =?utf-8?B?RWxNa0xvYWY1YWUrbWdnenJJTDZOMmZGcjU3RmZ2cmpvRnRDdzJPaGNqdHhF?=
 =?utf-8?B?dXJrYWxKVGZqbHlHeFNwZldCdDlDWXZUOFZXTFNSYjdGbkNhU1hyMi9iWDdQ?=
 =?utf-8?B?cFRzVzl2dExlY1ZkYyt3SUlleXdaMzR0ZU5uV2JmVnRIL2luR1lEY284bW96?=
 =?utf-8?B?blpxbFVPdFlNbWJyM0tWTDlaT2dnTHZGVlFpZTV5enZTWFZKNFhBcFVxQXQ4?=
 =?utf-8?B?VGdnUXFlZ1NNSmgzMjZENmNEYlVXMzFCSkJ1RVU0ckFxYkhPQWpDZExnUWI1?=
 =?utf-8?B?aGd4OVpoMjR4RTRXYVltODVQVHVxTnhIQ3FWbGdIejRubmNxaVBxUFNJNWtG?=
 =?utf-8?B?bjA5ckg2bDFoM2dyaG5kM1JhbW81QjBvSXpFc2Fsa2ZUVzFPUGZ3Q1VKWURF?=
 =?utf-8?B?dGJIaTgyN1lSblIvNlB6a05sYVdIK3FNSFFOaTJFQWIrSXZ4THROb1h2a3pa?=
 =?utf-8?B?LzVLRVM0L1VKL1V4OGhkeGxJK3ZsazBpNTBkcHBtZW9XWGpzcnFEekNXNlV4?=
 =?utf-8?B?bGNvS3R2WGJyVS9HR0o5SlJpZlpMN2xUNDhsYk16YlpKVUtxL3NFMHAvRXlu?=
 =?utf-8?B?eGViZEhOK2hPbm1ZVGhmMGJqRHk2WGkzb0wvQ3F0ZGlYS3lQcStzVk1IZEhU?=
 =?utf-8?B?TTdFMWNiRmFKd0RSMi8yZFVMNTM4MEJxVE1ObVdjeEhsYmhhZFNYSExrV3p1?=
 =?utf-8?B?UEU0RXRETWs5MjJvN3lLZWxLL3pscldvaENrVTd3QjBiRmw3aHVDNTdxUmZn?=
 =?utf-8?B?U3ZYdE1ZUzZBalM2NzNzeVZ5WTB4WUFsVkdLT0pJN0Y2czA3VjFCeHBVWU1m?=
 =?utf-8?B?b2VMK2JpdExBbFZrOTYwNnZXUEUzbVFDcG50djI5R2l4bkc2YzF4MDE3Rkgx?=
 =?utf-8?B?Vno1Ry9qeGNVYldPbDRJM0cyQ0JVY0xFcTlwSlgyU29ERTd3UUhwRlBsTGpS?=
 =?utf-8?B?Ny9jbzl3Y2NBSHY4UEh5cUIreXlPOUNUNWQrenM3RllhbU1CUy9VbkgrSVRa?=
 =?utf-8?B?L2JZM0NFUGl6Mm9Ec1ZSZ2RFaXVMaGxwOWd6c0VyV1p4ZUIvZi80QU01YmNF?=
 =?utf-8?B?NWtQUW5BRmdpMDNrdUNZRzNDbk42Sk1yNjQvaHE5UnBhSkZ4SmRudmx5Y3hW?=
 =?utf-8?B?SnlkNXZyV1l5NSt6czZaeHNxVGVSeUtSOUFSWXN6S3owdEtpRXVUbjNBdWVL?=
 =?utf-8?B?dWRkZ1pVbTlUdGVtOWkxZ1ZXNlBsdUN1Q0xLbG9ydVJoOWs2RDdXbHFKZkU3?=
 =?utf-8?B?WHNKaUcyaXNFRHdOVWtRVnRUTnlUSXpmSUE5NE1GREI1WEFBWFplYkFESFFQ?=
 =?utf-8?B?U0E1NXB6NzAzZlpuM1FvL2xVaXpUVmhSZFQrMzM0RThwaDhwaEgxcGJpbUNi?=
 =?utf-8?B?ekkzK3B2ODBEbVJVc29EQlNmMW9ZeEdDV3RUbDhQOG5ZY1pnZjlwNmkyMHpG?=
 =?utf-8?B?NEMrOWhPS05CK1NqZGxsTit5OC82aGJCQ2RsdUZWRGhYdmVySnpRc0NzMitK?=
 =?utf-8?B?MG9yNHJlTGc3VVU2MGNYVVZxSWtBWExyS2dQbmJZZ2Q3Q1VEYzgxSFFySnRz?=
 =?utf-8?B?bnFLL1d6WTkzZmMzYjlFTmpSNHEwbExiRWI2R1lVVEFpSkVKVHVLRU5mZmh6?=
 =?utf-8?B?VFkyOU1nZTYxbTlrQmhqMzhySW12VUowR3FKQ2tjeW9mbnBiMFpMM3o3S1Rs?=
 =?utf-8?B?WHFadXc1MDJwNXRRcEtCYVpjcXlwWFIzbkdjRWNMUmF5cHlSWXdQRHRmQldC?=
 =?utf-8?Q?ywnTDt3QXRuLjLMxdkNhwPkXnGMY8aAG52tgKSOKl46W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d62163be-a814-4432-052e-08db0dcb7d59
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 14:06:23.7440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AM/yyu8TBOE+oHstI2h2LoYoS1boptymGBvAtE2MCqkEqXpM84ofnPdLclrPx14844ZCLA7Hlq2jyXTdkOI8kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7366
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 2/13/23 08:04, Shyam Sundar S K wrote:
>
> On 2/13/2023 6:01 PM, Hans de Goede wrote:
>> Hi Carsten,
>>
>> On 2/13/23 11:43, Carsten Hatger wrote:
>>> Dear all,
>>>
>>> I'd like to have tablet mode support on my system, probably by means
>>> an linux input device such as implemented in the intel platform
>>> specific driver drivers/platform/x86/intel/vbtn.c [0]
>>>
>>> In the end I hope GNOME eventually to rotate the systems display and
>>> to show some virtual keyboard (upon users request), cf. for [3]
>>>
>>> It appears there has already been a patch proposed  by the chromium
>>> team to support device PNP0C60 [1] but not merged to [5].

Does your system support a PNP0C60 device?

Or you're just mentioning this patch existed?

It might be useful to look at an acpidump.

>>> Since the system of interest is a HP Probook, there is already a
>>> driver providing virtual buttons,namely hp-wmi [6]. However, the
>>> driver loads probes and loads successfully but doesn't provide any
>>> additional functionality plus some non critical errors on incorrect
>>> ACPI method calls.
>>>
>>> I've noticed AMD has started to provide platform specific driver(s)
>>> such as pmf [2].
> PMF is meant for power and thermal management.
>
> To my knowledge there is no support for CEZANNE/green
>>> sardine based systems (yet).
>>>
>>> What would be recommended practice and subsystem/folder to provide
>>> such capability by means of a (platform specific) driver? At least the
>>> CID PNP0C60 seems to be held by Microsoft [4] and thus be common to
>>> both amd and intel platforms [4]. However, HID INT33D6 is held by
>>> Intel and HID AMDI0081 by AMD. Yet I'm not quite sure if
> IIRC, AMDI0081 is used by SFH driver as UMDF sensor class extension
> driver[1][2], but on Linux we have implemented it as HID based driver
> and is a single driver.
>
>
>>> iio-sensor-proxy [7] needs to be involved, too.
> you mean to say, amd_sfh driver is not switching to tablet mode?
>
> Thanks,
> Shyam
>
> [1]
> https://github.com/MicrosoftDocs/windows-driver-docs/blob/staging/windows-driver-docs-pr/sensors/overview-of-converged-sensor-driver-model.md
>
> [2]
> https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/continuum
>
>> The first thing to do here is to figure out which (ACPI) device
>> is the right device to get the SW_TABLET_MODE events from on this
>> device.
>>
>> Maybe Jorge (added to the Cc) can help with this ?
>>
>> Regards,
>>
>> Hans
>>
>>
>>
>>
>>> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/platform/x86/intel/vbtn.c?h=v6.2-rc8
>>> [1] https://lore.kernel.org/lkml/1472628817-3145-1-git-send-email-wnhuang@google.com/
>>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/platform/x86/amd/pmf?h=v6.2-rc8
>>> [3] https://gitlab.gnome.org/GNOME/mutter/-/issues/1760
>>> [4] https://learn.microsoft.com/en-us/windows-hardware/drivers/gpiobtn/button-implementation
>>> [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/acpi/button.c?h=v6.2-rc8
>>> [6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/platform/x86/hp/hp-wmi.c?h=v6.2-rc8
>>> [7] https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/
>>>
