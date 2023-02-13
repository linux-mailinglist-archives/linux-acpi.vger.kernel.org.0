Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAFB69479C
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Feb 2023 15:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjBMOEQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Feb 2023 09:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjBMOEQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Feb 2023 09:04:16 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2062.outbound.protection.outlook.com [40.107.95.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D03DBF4;
        Mon, 13 Feb 2023 06:04:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7bnOO00h/QzAvmoyEDq4Zn7kE3wuXM4yMAnTiqU4aLhJa13B6hrVOA1Wa8FSJFwp4HZ1FYEF4C+xHAvnfedZpyC7aeRDcx47JvDS/nO1d3JLU0gDc12m3czr4A3r//JIIFCwyytr4aX3md0p0OOESuJkGGjLL1cDl0wzCdZb9CSDUt2x82RJTrlYmADuXH9kSqYXOR4nFqTof/kGLO4KUWhuCUscD7iaiq2xT55y8690d9llSymPyzX1GMUsv/ywmg1sVSW2sanRb2iIBWrwuOKEkz6lnnsTY96ukD1pw9iMhnA6P2wGiSfr2gyBCBP4jQasL/zknPhZXatWSMW3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZm8Ye1TVlsm/s/UCmqEEy6v/MDIDxoDrMePProaqEE=;
 b=XvGershRtT2wVK1rsE6+Xf9K+YVMfDgIJziu24JaZ6RCQ7ySyYjHKqigF0GBnGNFTI5yBl0byKIk0vxU7KkrB+KDuMUCJRz0sGOOWuviCEOgUceYQZ7VHQpJsjS8O3a4kn0d+Cqb8euc3XKbviBd6iP/zpmEsvMJFwCaHIeteulns/c7h3K1QH/1dSPkdCUI20+ZisIkYaUFB9ki8OHgVih7svEyiIYe7dVjuJzZLFdNLsT1NmXx/lsW4Zp2GhX1qKgY0SHx/uXCsp4Eqnyh/t/nNNwSFus6qVcxEfhQdd2/MLgX3J2NhlMUTNH6M84JToiCtd60y3dyfAnuW/Wqaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZm8Ye1TVlsm/s/UCmqEEy6v/MDIDxoDrMePProaqEE=;
 b=5AZgU95KMJNAmZJ8Ekh8k1c3GtUBA4/MwgKoQM/3cRs35mpSeIW9Qik93C4ENGQtTxpcJ1UQz+r4sV4Yn19w0lTjJIY8uBcqrZ1Grf24tPoVVhzxyY96qLNwbFstNylNXe6KOmRRwAO3r4KpwdzIpOFVMfb+j4eaUVj6XgSxB90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by BN9PR12MB5034.namprd12.prod.outlook.com (2603:10b6:408:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 14:04:12 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::4e8:93c9:612f:1f08]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::4e8:93c9:612f:1f08%3]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 14:04:12 +0000
Message-ID: <79e4b25a-2b45-e21d-e4a2-f886204d8300@amd.com>
Date:   Mon, 13 Feb 2023 19:34:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: RFI: Tablet mode support on HP Pro x360 435 G9 w/ AMD Ryzen 7
 5825U
To:     Hans de Goede <hdegoede@redhat.com>,
        Carsten Hatger <xmb8dsv4@gmail.com>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     mario.limonciello@amd.com
References: <CACp=KFQN79Rz0CHP-5kwP9Y5Y9bEAoN0eJzoOpSejg6aF9qnpw@mail.gmail.com>
 <233344ca-5df1-abd9-6fb6-c04634f1b401@redhat.com>
From:   Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <233344ca-5df1-abd9-6fb6-c04634f1b401@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::12) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|BN9PR12MB5034:EE_
X-MS-Office365-Filtering-Correlation-Id: d763d1a9-0aac-4bd7-254a-08db0dcb2efb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f6WTOJChc48Y9BSp3pW+hzaCOMXGaPXM7GAMcJUoV2k/PKcUuIcOOy2bfcLHBV76NTUuEtwjz4hIkjjocTH+5cffVGnnK42Wpyg/JH0cHik+NSRfCuJAwSFGo2rsYmxLT6yl+QHNxf7vuwDBt73gHxMHLHvwU9HbsK2iDweL5ME7yK1i/KzEGehih7e1PkNaUluIRhKnSLAQLAm7VL+Gree5wcpuee0tXmmKh4rNPyJdiJRWZaDAc4X1/Qn7N7bhrhWAMYZUBbUUaDDr0TXM4mTwutBFgZYqap1eUbYzuH72zSPlRe582i3AV3KItkM7JaZSCGFHHk/976Jj+TOmvkbNhqFme7q0mKQ0SdDFr0MJBgX6l23k5S05/h31XJDJxGjBwdHXlFb+BKHCz6ERPdh3SaNRFzmSFS4GgiPQWZ7swIVoMC+4mOkB46y2azmdERak9u9g05p8gBKlvd7HyHoPrF8li2gAWf0bolhtwpcxOJwIhwC61MZrASJ47i1s7ZXwKbzxlpl1BhkogriMBlBL+gOLumcb9qr4DlbU9kSbEKQ9zqiw65srcirCY0n0KwUhI2SHeeWs92rmZuuoOPM/e2sroKGPh2DzdDAKaxQFCgDun0q+W2HpqzhWFZudnzOxN8aO88BmIDj0+KnaNmAkadS8mLi7sEJMWnJfYYELCMLJmuOAKK0+lEtk1nvJHhs/TIx2m3+PIAEVffX9Nl6VxEgAloGT+3sb7UuBcodIFeZIQXbx0ES9irA/unVOUMzIO6lRpVEvA5r4SGqiC+Z3Yy4M8h7/wQYljAUjVmIwJ4Y1fI87MryIiiKFkWkg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199018)(6486002)(966005)(6506007)(478600001)(31686004)(53546011)(31696002)(86362001)(6512007)(26005)(66556008)(45080400002)(186003)(110136005)(316002)(4326008)(2616005)(8676002)(66946007)(66476007)(6666004)(36756003)(8936002)(41300700001)(5660300002)(83380400001)(38100700002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEc3R3g0RCtNb3FOTnBhMzFWbFFHNG1VN2J5eDVtRTlXQXBSMjdVTzZkV3Vo?=
 =?utf-8?B?S041NEIwK05hN0paTWh4T2lhQjR6bHZmNEdtREJiSURTb3JsdnFRc0tmOTJC?=
 =?utf-8?B?ZUJFRlZ3dFJjUmd4SXMwWDcwQkh4dDMxUUdCSWlOY2pYRTNlTENYeWIrd3A4?=
 =?utf-8?B?MDJ6cWozSnVVK2lzTm9nNkhMZmV3UytBRThtRG9nelArSGN3ZjNsMEU4L0RW?=
 =?utf-8?B?NnBqNVZ6NDhPMVltdVI3UlFZenN5RFhYbWVIVTQ1clB1dnY1YklVa3JUTWxp?=
 =?utf-8?B?aFlSaXRhMnJOTE5Wei9xOGdLb3h1ODZ6cXNMSnNOS1pBaE1RMUN5ZWdIRFcx?=
 =?utf-8?B?MTRxaTdEY0JuRlVKRjQ1YU5QYjFyb0xTMXBjem1oY1UvMm9uZkROVEovRUFi?=
 =?utf-8?B?M2VsRW4zOWFKOGJsT3l1WHZwMmZ1SDR6cC9NY3RHWnlDS0QyYW1DeEE5Q2Jn?=
 =?utf-8?B?a2d1MG1EQlhuYnZYUVYzWWN5akJkZWZBUEFZYTJUSnJmbUZGT3lCYWNadW1w?=
 =?utf-8?B?Rm9nV1FUSmxMNCt0U01qWkw3MStXQytINno1eUdocGRrYnYxRWJDNzB0c0dT?=
 =?utf-8?B?TG84SWlRSFpiQ2MxYnZmaDlpNGwrWHR1QkVRRTJ3aE9hUFVhdjl4SUFHVEhz?=
 =?utf-8?B?OWF1N1JtdnE2Qk1VaG94dGo3NURZSTZlcWc0UlhtYnh6OGRPMFphM1p1RHh0?=
 =?utf-8?B?clltYnpFNlpsMVovV0pqWHZiMkg5Z0pUZFAxa3hENkUvS3laUWsrT2xTTEs4?=
 =?utf-8?B?S0VQTUY1MXc1a0IxYmlnelZ0SGtVUmUyRjZPNzFSS2dTRzdseitFMzdSOGQ0?=
 =?utf-8?B?enlnRnkvTmhBM1BtdUNtUVNMRHB5cHgxZWF5ZUdYS1pZdkxDcWs3MmZ3WTFa?=
 =?utf-8?B?aUZYTTZ2aDVXZzJNLzVacmNuT09hYUFsejhlMm5oZHZ2SW41Y1lJU2MzU0R3?=
 =?utf-8?B?SDlYbklQNTdGYzkwQWZQWXp0L2RaUnJVcHdSb3M3cy9iZ1k0QjNPeFBWNzNu?=
 =?utf-8?B?UVdNaVl4T2p5WmdGSmpFWjVBTVlwS1pXNHJlMCtyazlqTm8vWjYxT1VIVVUw?=
 =?utf-8?B?V1h4dUJBTjV1Nlpibno0SFVMcC9CYldBN0tZOTNTV2ZrSEpBL1ZaSm5TcE9p?=
 =?utf-8?B?dTFNQ1ZSZnZRUW5uRUZYK1pqaEpRcWxCUDRTdWdTTXhJdURLd1FOelVTZnpw?=
 =?utf-8?B?eVNZVDAxM25nQjRJWmFDTXkyZGY0emhnUEhBNXZic3JhQytQY1BNRnZ5ajc2?=
 =?utf-8?B?bUtUUHZKcDZpbk1BTUVDY3V0dC9yV2huUFBONkM4Q0VERUFMNFNZckZsYkZ0?=
 =?utf-8?B?VHFIWk9pU3RFMys4NXNrN2JZZnJEUm9QQWl0L3BqbzJOOXE5SUExMkRCaDNq?=
 =?utf-8?B?SW1xZmdYYWpuTFQvR003L0NITzU0WldEajQzWjlmVGRiMjhIVzdodkN1Z1Iy?=
 =?utf-8?B?U1VxSitBWm01WlcrNEtnVHMvL3VUOVk2R1BIWVNqS3dqTzFTdXVha2Q5OVdE?=
 =?utf-8?B?T29lbVpiS0lnOE9EMFNTYWlwSVQ0RHlVSkJoTmpFOC9yYXExZjJHOTZQUWI1?=
 =?utf-8?B?S1NyTU5wRVBITVUyaDBZT3F1ZWtFdkoxTmZGWlhDbmIzWnpkQWh2Rk1ob3NR?=
 =?utf-8?B?Ykp6VTNYbGswazgybmZYdnFXelNma05LMFZ6aTBBbytMaXNXQi9MU3FKNU54?=
 =?utf-8?B?dlhnYlMyMHV0enMxTTJFSDdtb3AwMDFTWVdiK1BvYy81WStqNDY3QkFPMVBN?=
 =?utf-8?B?OGZxUFBxSVk1T1laaEwwZG93c3REV2VpdFRwT1ZXQmhya3h6OFlwalR5TC9H?=
 =?utf-8?B?QTdKTE5iTXhYNWxTdERlbStvMzQ2bUs2UmRodDEzTXE3STlKcU1jSWdQc0Iw?=
 =?utf-8?B?OGNvdTRFLzJEK0lrQncvek1NOE1NOG14aTM2THF1aFc0bXJKMCtYYkEraUFi?=
 =?utf-8?B?SkM3dHJ6N2VQQjdXUGQrSEQ2aDd0bExTWCtudU05clNZYTk3MHJHaFovUGJm?=
 =?utf-8?B?MngwOVhCSnRYYUx4VVlEcmNJbTdsd0xGbWd0WlNCMWdodDUyS3JVZlI4RUY3?=
 =?utf-8?B?b0syZ2w2bi9QVkFpekw5ZW92MW9aUVFuSnhVRWNnRm4ySWIrQVlyRGtnQllh?=
 =?utf-8?Q?/KjNQhwdxD/54EAbnYpdHTXbN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d763d1a9-0aac-4bd7-254a-08db0dcb2efb
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 14:04:12.1883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lyqz9/suOayvgSrp7MuA/CNrNTeiNgGknTmyveNGdhX1KLyjxW7fSHjJKpxwQyJu5cQOnfniThtkopRDCs/krw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5034
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 2/13/2023 6:01 PM, Hans de Goede wrote:
> Hi Carsten,
> 
> On 2/13/23 11:43, Carsten Hatger wrote:
>> Dear all,
>>
>> I'd like to have tablet mode support on my system, probably by means
>> an linux input device such as implemented in the intel platform
>> specific driver drivers/platform/x86/intel/vbtn.c [0]
>>
>> In the end I hope GNOME eventually to rotate the systems display and
>> to show some virtual keyboard (upon users request), cf. for [3]
>>
>> It appears there has already been a patch proposed  by the chromium
>> team to support device PNP0C60 [1] but not merged to [5].
>>
>> Since the system of interest is a HP Probook, there is already a
>> driver providing virtual buttons,namely hp-wmi [6]. However, the
>> driver loads probes and loads successfully but doesn't provide any
>> additional functionality plus some non critical errors on incorrect
>> ACPI method calls.
>>
>> I've noticed AMD has started to provide platform specific driver(s)
>> such as pmf [2]. 

PMF is meant for power and thermal management.

To my knowledge there is no support for CEZANNE/green
>> sardine based systems (yet).
>>
>> What would be recommended practice and subsystem/folder to provide
>> such capability by means of a (platform specific) driver? At least the
>> CID PNP0C60 seems to be held by Microsoft [4] and thus be common to
>> both amd and intel platforms [4]. However, HID INT33D6 is held by
>> Intel and HID AMDI0081 by AMD. Yet I'm not quite sure if

IIRC, AMDI0081 is used by SFH driver as UMDF sensor class extension
driver[1][2], but on Linux we have implemented it as HID based driver
and is a single driver.


>> iio-sensor-proxy [7] needs to be involved, too.

you mean to say, amd_sfh driver is not switching to tablet mode?

Thanks,
Shyam

[1]
https://github.com/MicrosoftDocs/windows-driver-docs/blob/staging/windows-driver-docs-pr/sensors/overview-of-converged-sensor-driver-model.md

[2]
https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/continuum

> 
> The first thing to do here is to figure out which (ACPI) device
> is the right device to get the SW_TABLET_MODE events from on this
> device.
> 
> Maybe Jorge (added to the Cc) can help with this ?
> 
> Regards,
> 
> Hans
> 
> 
> 
> 
>> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/platform/x86/intel/vbtn.c?h=v6.2-rc8
>> [1] https://lore.kernel.org/lkml/1472628817-3145-1-git-send-email-wnhuang@google.com/
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/platform/x86/amd/pmf?h=v6.2-rc8
>> [3] https://gitlab.gnome.org/GNOME/mutter/-/issues/1760
>> [4] https://learn.microsoft.com/en-us/windows-hardware/drivers/gpiobtn/button-implementation
>> [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/acpi/button.c?h=v6.2-rc8
>> [6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/platform/x86/hp/hp-wmi.c?h=v6.2-rc8
>> [7] https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/
>>
> 
