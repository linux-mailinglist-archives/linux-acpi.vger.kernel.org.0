Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E3D644DDF
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Dec 2022 22:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiLFVVI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Dec 2022 16:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLFVVH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Dec 2022 16:21:07 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D86447324
        for <linux-acpi@vger.kernel.org>; Tue,  6 Dec 2022 13:21:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FctN7hy9IFQ3TpuOY+YcJV6+BfjvPZd5tKLkkTGga+j6AI7uzT5vhYr4noFU4E1lwxkAlzleRaORVMCGNUX+f0GhYlsO2pL4udUKco0ZMt87fa1lSBKharnYXrsWnTOZKJqtyXXxNBMvR7jVHKjSjGxQ7/N1vfO88BU6MOMw3VO+4USh5Jx/XIwHhLf5Bdb5WVRt4ZezQ/leA+y54aUepQrFGbx8/rfjA59MA3l9n1DyueVnX4MViVBJWJjmS+0WhU4ahrvz3RXD+L5HzkpgClzJhF1gs/He5IGFRNTLW+2l4U1qCsgrCr0loc5v1Mr4LJ8aMPtrumm76mWC5Oql/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4wOgVicvZoId6YcEQjQXCe3gki9Pfx+i9RjBdxUw7U=;
 b=IdwhgS1W3FkMsWANd6Ehhm8xgs/P8UGPX4x2Hru1frcEkU486tVL6qO/z/YvugOj7JU2HzhU369ycqvjssrDc8+XllRSwdDdq0DxOK5s8dihVbdBG3TmCfYV4Z6fInpzY7EjPrc7eGW5auXB1FDVfIWvZIU+mETAkKIgxLATzBToOSlZ9ZWPqhL6Dw+KLhzS3/BBc+cN7CU+6cxxEoiKXuuDZnLwCiLiesnpwDIP5nZQUlLyTxEzDDQPI99Jmdm+hA6TxO5cJZy5BfN3AMJ+ytnezKAN1t9PGZo3a78dkjWNYMRAQlZdnBETtk4cn1j8IvHtzqw4wGXxE638OqCNGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4wOgVicvZoId6YcEQjQXCe3gki9Pfx+i9RjBdxUw7U=;
 b=KZQt7W3TQjcmIaSA0Agl3WOf5NhsmfrgipyG/lrG3s93ack1xmG6oywYwZ5AgnUgzVtbmV447NHqm9nu7OP77fDR+Xikiu+BlSQFfArrmYnB7C/fUoE+5/LQUZcNyrhaKZF7koSx++FeHe8+uFELO2V7YprPtTxMN222tq1S8x8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3270.namprd12.prod.outlook.com (2603:10b6:a03:137::31)
 by MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Tue, 6 Dec
 2022 21:21:04 +0000
Received: from BYAPR12MB3270.namprd12.prod.outlook.com
 ([fe80::b770:9062:384e:6908]) by BYAPR12MB3270.namprd12.prod.outlook.com
 ([fe80::b770:9062:384e:6908%6]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 21:21:04 +0000
Message-ID: <8f9feb3e-4c32-5c16-558c-7693cc277992@amd.com>
Date:   Tue, 6 Dec 2022 15:20:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 0/3] ACPI, APEI, EINJ: Add new CXL Error Types
To:     "Luck, Tony" <tony.luck@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "bp@alien8.de" <bp@alien8.de>
Cc:     "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <20221206205234.606073-1-Benjamin.Cheatham@amd.com>
 <SJ1PR11MB608313CBF490328F8C431796FC1B9@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <SJ1PR11MB608313CBF490328F8C431796FC1B9@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:208:23a::15) To BYAPR12MB3270.namprd12.prod.outlook.com
 (2603:10b6:a03:137::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3270:EE_|MW4PR12MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: 523cc381-ca3e-4b50-ac16-08dad7cfc7f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ytgO/B506p8s+e6jwpnh42FwD0Pw6J8ZX75H/N7yk6O+gjFAjFvc4TnGDDpJkZBisJm5TGaSen+Khi0K8fbr5/g2iYQxolbniurBpunt4oH8t5F5vkY84/KAePyF1omL3n50f9p9pGig6Lt0aXErKTbq8xeItVuZ1I8q/jxvqYX/XVmlooe/eKaSezek1p5bmsgptLXqPKiHHwtquhP+7cZPC+W3y8NWVdReVJUnvpsmTr6izHBYGqv1UOiknTqxfxmzUTp1rtq/DUKmdxNfXVkaUURZT1pdMeEMSSMZpkf46W3t6Zwk4OIHxE61Au/ZZTuwQBEuB31w3YiBKAmXqml/hagMm+ohpL/df54TICAzuuQo/RvKGZxFmzn5jR46DAn1E77GLoV1nx9f8Sks5cyFMuh7EYzLl2oYYOfOUuDANm30sHP1NnIV6PmpcJQ5SHO7V2JFJIpRag6k0qsIJfbN7TjqjvRjdQ263puGRjYaKws+lJRlfAkuGcUvw2qNdidEOGKUYjqVMvE2l4kRBOJA1qajFh3XoNezAk8sXCz8NLH9UvT3V0J/Mthgt4IbLGhEHvSNjV7GP5yJwAvAKXrBsOk6G5CHcaJg/WHtuyF59f8Q6czGF2hLGcwbpbzzoHm5O62SGQN2m0RNpcRSQZMfLbArc3uKsshUPf5wFeE1qXoa6HyvA0pdK/I6RMkb5EJwOSAgixb3bFOFlvPhWBHlRPQqMjeonpwU8aObmg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3270.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199015)(26005)(53546011)(316002)(6666004)(478600001)(6486002)(6506007)(54906003)(110136005)(66946007)(8676002)(66476007)(4326008)(31686004)(66556008)(6512007)(4744005)(8936002)(5660300002)(83380400001)(186003)(2906002)(41300700001)(2616005)(38100700002)(36756003)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjF6bUsvMjQ3SEFWanVDYnVpeGRyb3FZWVVmemFHRWpkSzNWY3B5VmFMYi9R?=
 =?utf-8?B?ZDhSdExZTjE5RUd3NGxVdjNzM0E0RDVvV2NXbjNvSVo2ZFQ2RElHRldiTGow?=
 =?utf-8?B?YU5iK0lJSlNpWmEyVFBpa3hRRVJxekFtR0xHUSt2SkZlRHlHYSsxdFYwVzhj?=
 =?utf-8?B?V1hjaDU4RXZ4VG0vRFZiUkV0U1dWcm9VOTIzY1Q5Ym9vd1dRdWFWTEJicjMr?=
 =?utf-8?B?cFBtT3JUdmllcFVSRmttNU1ZbS9ybHdvWERFaVMwdmlUd0ZhUGNrQXMzblJx?=
 =?utf-8?B?eWZvSS9XV1N5VGhFUU1lLzRBSXcxNkVmbHlNTTcxajVzdjFic0pyMjNSazA2?=
 =?utf-8?B?WGp0QWx5b3VXUDJFM1YzamZHY0pwTFNPYnkrRWVaaGtESzRPdXlRMmVxdm5B?=
 =?utf-8?B?cFkwbE9JRkJGY3NFVTYrUlk2NGlDVE13UEpNd2tUMHB1NHZWZUhodnpoK0pW?=
 =?utf-8?B?SWkvTWhvNi9ucnpwQUtQbWRoaDlYWU1yMlF5VEo1WXFoQ2FFbm56WjlqYS9K?=
 =?utf-8?B?UnN6MXptOE9oNXkvQlBPbWIyWVFpaXhCVzVkSm9ydC9xQmllcjRNSzFwRThI?=
 =?utf-8?B?UDYvOGs0bVNBSHJHVUhxNHJ2bnRnMjRiVDRkbGJZMnI1a0RpVW52M21RKzZU?=
 =?utf-8?B?YUVjNHdUR2NyWlVxczh1RkJBQ3l0UEsxWWJvek5td1hDL3BXeCtSWVNhZml4?=
 =?utf-8?B?M3BudFVuZlVQNTB5eUxMVEpGVUY5MTJBQ2lPYXNpQVRFemxvdzNPWmwwWWFr?=
 =?utf-8?B?VndBRFV3RmZ2a003NUUvV0RDSDg4YVZjT0hKWllaUmhyUXBzR3lUTHlYOGFJ?=
 =?utf-8?B?Vy9YQjNDSGJUS0lWdUVSSEQ1a1V5SnFKbjBXdDA0WFFTYXJuZEoydzNtSjAx?=
 =?utf-8?B?Y0U0OEpTaWlEd0lzWm04T2ljc1BFYlh6SUl4cG5tRXhBSFVPbm5jS0tmVlo0?=
 =?utf-8?B?cFFzOVRKakdRb3BmTXE1ZW94a2FicWl4KzdESU0rdWpMT3NtWE1UNmtKT3o4?=
 =?utf-8?B?eGRObDdTTWN1Vzg0QVErZzRMdVo4cjJuanBVZlI0T1Z0NmQwTEtleWFFSi9S?=
 =?utf-8?B?c0RjQ1FZYUtiSW9ERXRzMU9odmtaeFFKbEdFNzBoVjk4OVYrVWwvclZuZlJG?=
 =?utf-8?B?TjY2T3hocEhtcVR1WUlYdm5WcXN1WTZPSm9DemphT1ExcHcyMUNQWjk3SWV5?=
 =?utf-8?B?WHl2QUxhZnFncEJudmxBQks2Z1JOdkhkS0sweU95WHBoM3VUU2s1Z0hXd1NR?=
 =?utf-8?B?N3FXUUt3SEtZOG5oZ3A4SkZFUmVibW9lbURiNU5mbU9PaTltTXRPMjMwK3VV?=
 =?utf-8?B?YytvM3MyV1NQOTlKM0RlWDVxTEFmbFg5a0tOZmloWTROMnFraHpPNmtTQzRV?=
 =?utf-8?B?cWdGemtXUk5VK2hjOU03aHpsbTZNOW04Q2VpV04wVXBKWEI3ZkYzVmkvZ3FO?=
 =?utf-8?B?M05iSGwyalJuZ3FMYU5VVFJKaEtzbXVYY2tWYVpmbk9IMHU0VlRRejVLWktE?=
 =?utf-8?B?MGxaaUVXc20rQ2lLbXQ2cG9FeU50T21iOTZFSHU3djdMNjdZOGVqVFo4dWV5?=
 =?utf-8?B?RXU3SE1vS3R1UjJNRFQxejhxNFVGZGl3SFFxT1FzUFMwV1o0NXdBanArR0pR?=
 =?utf-8?B?c290L3FEblUyZ1Z3ZVVDNm52bkdqUzcvNXVPZEZEL0N6TkNNWlY2YVgya1NV?=
 =?utf-8?B?MlJTeE1rSmVJcldycEhKS3BVeW9ONGhCbTZnMm5ac1RtRVVIQW5pOExFNjJW?=
 =?utf-8?B?dVBrMTdwTzNuMkkyWWJHbWZ0YTJacDV2SFhKTW9oR2wxK1pvZHVuUVNZMDJK?=
 =?utf-8?B?aVVCc3NYNHM4U3BkWm9RbEtKdDhVZG45Vk9xWkpCSzNFcTRLUHVGbGZrTURF?=
 =?utf-8?B?NVlEYVEzOUtYaGdKWUxWOUpadUhuaWRLYW1Kdnoxd0pPeFArVkJqVzBMYi83?=
 =?utf-8?B?QVFNbERvWU51ZnhSSWcwd0k4NVBRSVgvcU1YZHJ3S2UrdzRuMlZ0UGV6bnA1?=
 =?utf-8?B?dnlER1BJbC95L0c0YmxTL1paT0MxSllDVEp3cHZwWTZ2K0lxOTYxemRBR0Nh?=
 =?utf-8?B?SEFNakhFdVVGTTV3UGFJMnNLVFVXZitVSVZKczdLY21BZWRtWGhOZEZadGxX?=
 =?utf-8?Q?3WZZBn9E7g8crV5ju3j+318rH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 523cc381-ca3e-4b50-ac16-08dad7cfc7f4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3270.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 21:21:04.1593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3VYsme5q+xJhQy0aWENIujsEQ7hdN1ptNwqLidj2hcEfvOJ6DJDPMAHLoY5lFQVu9rV83ivCUBbktoxu1KbqwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7141
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 12/6/22 3:11 PM, Luck, Tony wrote:
>> Add new CXL error types so that they are advertised.
>>
>> Quick Note:	
>> I sent out an email last week explaining why I was taking over this
>> patch series, but just in case: Jay's internship at AMD ended a couple
>> of months ago and I was asked to pick up this patch set for her. I also
>> said I was going to add a patch in aforementioned email, but I didn't
>> have a machine to test it so I've left it out. Thanks
> These look like a good start. But will there soon be changes to:
>
> 	drivers/acpi/apei/einj.c
>
> to do something with these new error types?
>
> -Tony

Hi Tony,

The last patch I mentioned leaving out added support for injecting CXL 
errors, but I don't have access to a machine that I can test it with at 
the moment so it'll probably have to wait.

