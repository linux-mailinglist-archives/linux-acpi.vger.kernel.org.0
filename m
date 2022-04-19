Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEABC507106
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Apr 2022 16:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbiDSOxi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Apr 2022 10:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiDSOxh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Apr 2022 10:53:37 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00059.outbound.protection.outlook.com [40.107.0.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20493A5CB
        for <linux-acpi@vger.kernel.org>; Tue, 19 Apr 2022 07:50:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CH5++Js03d0pPcjrSQSCXmkYwe5jP7fsnn+C16QHE5WmoZctrOUzrT2oJHVh7PH4XCDdz16Ssvh+DxQcaP2Gl/mws0vd6U1gz6DjbwuIz+K3eIwi+aabBiS642b1L67c7P9WvN9o+nZvlQimLU71tZgrijJsBNKmxnjOmxhZDII+2FPCLKS+UYt0NgJT5fz5g/O2WJ4sfCiYzOxdzQTam5BuXzSBsBuiW4EfoshgocmQBhh12OaKwayGF4RSIDhEYS8AFGDTl7DCEhSyp+Qmvwh1FeL4ONYOQwgFwvViN+v9eNEBR+jSM5duJbJPV07B0Hx7xr/mN7MX3Ez1gus0oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOVdFqhb1TSaP98xnC2Ll9u+C7/D7kJX+oOl21Uo+Fc=;
 b=AZbwVWBWQW5/4U0owmC7D32ZzYrFo/a+uoF3Wci77FUOiEuISrRhXeymBUsXiXEa3n5KtOPsZm03qhms3MCb8LSVzuKEh8UTpIhUCMeyg778/YDHOXWdqNDKi0G0P26mSYlT2A7sJu4+zbFogKD9a2wQQD09rBydBpbOzWxdWSounvOS8HvsRWXibZuBe/lsaxiRhejMID/WjRN9Ji1twEnbf2gIWmWwloqH1QGzNnnRFhFGjI3DXoNYn8IB+M5OGb5RpIPtp1cU3qlPTJ6TWHQHiA0z2CN0pAS7+/NQoxXy+MCEyHDMR/JNec9+1yCjUNbr6ru4OJAy9yjk9UUCLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOVdFqhb1TSaP98xnC2Ll9u+C7/D7kJX+oOl21Uo+Fc=;
 b=AD/BzTH9IRKPI2wsXIBjyoHLx30c/vG4bdkuLY/uL+SI0qWxKTRAk+ru3wKYVCQhQnYRX2Tdsh20Ug2dYOEgRZs/R9hJCibXvSV2RKQIkyWOsRdXwYaYUBy590cGNfyXOq0o2TK6ePTEAzMpHahmB3z9evIC55DSWpt764SMLZQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by DB6PR0401MB2584.eurprd04.prod.outlook.com (2603:10a6:4:38::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 19 Apr
 2022 14:50:51 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::8ce8:25aa:6242:b565]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::8ce8:25aa:6242:b565%7]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 14:50:51 +0000
Message-ID: <4086c5a8-f4a7-e477-e0eb-c304645a4144@nxp.com>
Date:   Tue, 19 Apr 2022 17:50:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v9 00/11] ACPI/IORT: Support for IORT RMR node
Content-Language: en-CA
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     linuxarm@huawei.com, lorenzo.pieralisi@arm.com, joro@8bytes.org,
        robin.murphy@arm.com, will@kernel.org, wanghuiqiang@huawei.com,
        guohanjun@huawei.com, steven.price@arm.com, Sami.Mujawar@arm.com,
        jon@solid-run.com, eric.auger@redhat.com, yangyicong@huawei.com
References: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
In-Reply-To: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0212.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::19) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d19a9a8-98ef-4de3-22f7-08da2213ff28
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2584:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0401MB2584FC37910E34F6EA1819BBECF29@DB6PR0401MB2584.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: En8rN4BkfpBySBJpPW0IaTjVezwV3R9biH2XBmNpb34c5/dJnD1PmKA27qCo0Hi4SxamBMgOTtgFLYxlKRRlAitKC5qr0BIhnpf26V2U3gpbtkg8xjN3obSu54C43m0clrkYuKeDIyCqnJZHxrWBc8SbNpVV5uSl0JHzI9z+E7YDivtZEBnoCvDxgi+LCtSzpa+i0Cn8AZLKDWzeqpyw0c81Yz+5O3C+f/XK37C6XiZizp3VdsmvQtpZsnvF4t7Ii3uU5QaO92SD35hY5F3PbRpL9GPXuhARGQPaugUgKAiEjRHpqzis2gVAamo0fz1RTK92dw9WIl5i+0I+2jEwrfnPd+fvbZQHmedr5CxNgEDGdcsjw8k1nmPQsyTpbJ8gecZY/FwKvaVMqyPGBnGzY/1uL+PivWFDaYLLlVtg6DIJF0YDEEi399JGHQVa2MqYdTMBblaIBI/lDKPQcdJFI57QPIqiXyJ/rxT6O3AA60gk1KzJlD1yQ23KZhEo/nzOn1D6aHlQyXaQB5YTqqnMahbaHx0kqkZlqGYLc+3+cYHMmJwU3KFtpU0H7z8Gvx+WUx9vP+JiHgKQ7hKgJ+4AdtHsTERQJ20wCe0JMI2/ZhEKfkuaQlrXq/GDGzuTbnXYLe61L1HwsCBUBD5svQeRytrLstJeQIr18dn883wXm7M1zQK7lAV6SZ9ktgwhOgXqggRVC/ptPphivRLzJOcedBQhTEMgJcCKj88Z0HqPFd63AsgwC4VZGQ1OPjDXIdNdxkgEhFapGx1y+r+9t+g+UctB+VWOw+QcK5KG+W8nJM6KLuneQf91FCLDiLBRECfX1hygU0OjBDZQ+eRoNrwNwlEetcfgJemuOhU540D1niVp4W/4wBX10WgEnTb+tJqPhAwmWLa6ChS1Fde/1H6LDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(186003)(6512007)(6486002)(966005)(86362001)(508600001)(8936002)(2616005)(44832011)(45080400002)(83380400001)(52116002)(2906002)(6666004)(55236004)(5660300002)(53546011)(6506007)(7416002)(31696002)(36756003)(66476007)(66946007)(31686004)(4326008)(8676002)(66556008)(38100700002)(316002)(38350700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmlaNzA3UEE1Y2xYTWxDcFFUVDNiRVZLTERTVGdmL1pLYUZXbjk4L0RrMHJD?=
 =?utf-8?B?bTlNamloSG54UUJzdWNwVDJUVERLUGNpZERNMmZpNmw2eFhaYmdYeDRjKzR5?=
 =?utf-8?B?Tnh5dVJPSWZPckNObnU0ejBsbDc0VzQwTHZhSmNjdndNeWpzd3BkeW1qYy8r?=
 =?utf-8?B?amlaUy9BWm5nbzlwZW9VM1NMcjBZNEVieGs0eThwWVNxWDdPaDcwTW5uNGdq?=
 =?utf-8?B?QlhTV0lpTTlnbWNTU21MV3FFWnBKdlo5TThtZUltc1Q1eGM1cXhXQ1RvMmta?=
 =?utf-8?B?NXlEVGNadWQxVk81UVN4WGVGQ0FIb013blpCRUZiWEI4RHUzQVl4MmVvMU9v?=
 =?utf-8?B?RDNxekp2d1JUU2FUNXVSQ0Y4SFpTSVZzU3pYSFJrWlBBd3JVUVFKTXdnVWUw?=
 =?utf-8?B?ckFrbDVqTFNSMHo3d2pqaVp6OGp0QWVPU3JGRmVrT0o4UFdUa3ArR29oWjFG?=
 =?utf-8?B?ZVU0SHNwQWVJUWxhVitRWERzL3dpbFBFUkZqcUt1MGZFbG1md2R0RkRSdUZy?=
 =?utf-8?B?Ui92djVMVHBKTUVvdWY2TWhta0IwY1JXejR1bUZQdVpGWEFFM1VMdHFuWlRr?=
 =?utf-8?B?MVd3MHNPY2R6c21BQnFpaEVnRk4vTnVRZUlMdXpHZWc5dWN0N1FZRUJBTnBQ?=
 =?utf-8?B?VlFmeXlhcEJ4MmM2ZUhGa0NFT2xZMjFMMDArRDVCNUFoc0c3WnUveXMzbUVo?=
 =?utf-8?B?Y2JuOC8va3ptOTZ6TWViVTQxS0JrVVVMcW05MG1GdnVIV1dIdy9HU1Bxc0N6?=
 =?utf-8?B?d1ZOV3NibWgrejhuTFlYY1g2UHNHbUk1N0d5UFVZZzVGa3JNaHgxK21PTDcz?=
 =?utf-8?B?N0c5R1A1dzJCZHNMSDBicVhQL0dlemZ5NDhXNExGbFgvSlRmanpyOGJDVHpW?=
 =?utf-8?B?M01VQzQ0ZWxwNXFhVkpkVjlManhRMjdQRStHSTNHNGVJcVU0dFZPU2h1WE1P?=
 =?utf-8?B?Tm9MdDRPSUdkWVhFM1NwS2ZYVng2b1pNeFBTdU1EZmRSQk9LaDIvSmtFL2pB?=
 =?utf-8?B?OG53dTlTY1JtQmFFOVo0dzVHVWphKzZOclhhWTZHWUZzTXYwVTFwend3azhB?=
 =?utf-8?B?QTgrL2F5eUJXZWdicVhPR2lGZWxyWTZHN0JKSlY5RjZ4dHZlazNuU0QyVitP?=
 =?utf-8?B?bGpzYkk2N1JhbkR6a1VvemFWaTNKLzYrdUxGWm1UR3N3T1hURktKdFlYZUNi?=
 =?utf-8?B?NFMyVHJoSkJ6V1FpK05uZFlJOG9VTG1lcDJWNkREdXBtMThWQVRiMHVmMmNp?=
 =?utf-8?B?blRRakpWbHpGbGFrYUlJOGNSSGtNRzZaZ2N1MkxYdlo0YXpJYjF6eklUenVM?=
 =?utf-8?B?dUN3V0M1ZXBUTzV4c0hLZ29ELytra2crSzZkNXpwbUVKckJNNXJvZENkREJV?=
 =?utf-8?B?WGtsUHRkUEZSOUFQZldhWUNxaERrZWlLNk11Rm9VRk1USlZWRWZqc0phN1ln?=
 =?utf-8?B?WDRNRUxkejdUSkMzZ3A3Q0I4blJEaFJROXlUU05tRzhQM2dxRDYyeitCd1JB?=
 =?utf-8?B?Q0xMMlZ0a1JPZVlvamxpRmJWeGd2Qmp0QXExbXJxMjRpVzRTQk1Wa3d2blRZ?=
 =?utf-8?B?RVVwd0JmZjZQL2JxbU1FWkgvZ0dMNFd3bWtEZ1ZRMzgxQUgraXEwMGt5ZEpn?=
 =?utf-8?B?dStwcEF5TUJaU0pqV2Y0T1ZVK2d0MzJWa3dndlkvVWxaTjRkSkdSMkJGSSs0?=
 =?utf-8?B?S1hMZVl1VndOUzdaV3NwNm4zWHpaMUNRVHV1YkdaYUhPWTUyTkJreUdqMFc3?=
 =?utf-8?B?K1NCaCtPWnF3YmFEbE1hbWUrWXZ1d3d4TnA3ZlF0T0p3WW1xL0NxT2J6Tlht?=
 =?utf-8?B?SmYwYmVRM0dSbC9ibkwvRDdJc2pmMkZjRk5reGN6Wmw3YkMyWHZNbGtsbEVq?=
 =?utf-8?B?TTZ6M1FraHEvOEZNU0ltTkdVRXo2bms3WisrVEpVRE1wSzJXaytXQlhPYitR?=
 =?utf-8?B?RWRsZktVanZ5VmJVWXNOcVhZY2NTcS82cUsvdGoyd2VPOU93VW50cjFjU09k?=
 =?utf-8?B?Ry9rL0ZNdzVwQm84YWlVbVlCbWcvU29DTXhRUUZ3RXZkNGxRNmhCQktNZG8x?=
 =?utf-8?B?SUkrbU5lalYzWGhMVk1WMThaZHFueVE0Q3JSOTZmQ0hZSnpVVUY1bDNwU29I?=
 =?utf-8?B?MjZPZlZTV214eUlWYmpkdm52QlFtekR5b2QwTm5Kdk1qYTRhaTZoeHRrZmRL?=
 =?utf-8?B?bVBYYmpkN2NjSjZPd2VKTm5ic2FxWGRWYUZRSVFDSmw2UDNSMGRJdDZpeFdK?=
 =?utf-8?B?N0NBaFE2S05IOENWWnN5ZUhidGdYay82UTdOVmdYSG4zV3pBRmxOdDVBVktt?=
 =?utf-8?B?OFppS3ZkWS81NC9vUVZhNkFjYmUreU9ic25aWjJtZVJkUUtpVEMrK0ljRDV0?=
 =?utf-8?Q?QX0CyNci7hTWlzaY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d19a9a8-98ef-4de3-22f7-08da2213ff28
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 14:50:50.9233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XN22h3IzUJyp5hL2mVOevlZKQNNJYMeI8lWrRhqCtVsfA1MoIR4h0vYQYvEkmNL3We+b/azPJQ0IUxqZ630NuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2584
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Shameer,

On 4/4/2022 3:41 PM, Shameer Kolothum wrote:
> Hi
> 
> v8 --> v9
>   - Adressed comments from Robin on interfaces as discussed here[0].
>   - Addressed comments from Lorenzo.
>   
> Though functionally there aren't any major changes, the interfaces have
> changed from v8 and for that reason not included the T-by tags from
> Steve and Eric yet(Many thanks for that). Appreciate it if you could
> give this a spin and let me know.
> 
> (The revised ACPICA pull request for IORT E.d related changes is
> here[1] and this is now merged to acpica:master.)
> 
> Please take a look and let me know your thoughts.
> 
> Thanks,
> Shameer
> [0] https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-arm-kernel%2Fc982f1d7-c565-769a-abae-79c962969d88%40arm.com%2F&amp;data=04%7C01%7Claurentiu.tudor%40nxp.com%7C2c1805513e0c4509194608da1638a306%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637846729754056888%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=R2Rw4JK1ugTN1QA4umzMuLVem2oS9BZucbvNoZqSJ3I%3D&amp;reserved=0
> [1] https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Facpica%2Facpica%2Fpull%2F765&amp;data=04%7C01%7Claurentiu.tudor%40nxp.com%7C2c1805513e0c4509194608da1638a306%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637846729754056888%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=0aC%2BwZXPL4b0ZWIXw3TGwFE3NqPUMVJ3IbpsxeQF8zw%3D&amp;reserved=0
> 
>  From old:
> We have faced issues with 3408iMR RAID controller cards which
> fail to boot when SMMU is enabled. This is because these
> controllers make use of host memory for various caching related
> purposes and when SMMU is enabled the iMR firmware fails to
> access these memory regions as there is no mapping for them.
> IORT RMR provides a way for UEFI to describe and report these
> memory regions so that the kernel can make a unity mapping for
> these in SMMU.
> 
> Change History:
> 
> v7 --> v8
>    - Patch #1 has temp definitions for RMR related changes till
>      the ACPICA header changes are part of kernel.
>    - No early parsing of RMR node info and is only parsed at the
>      time of use.
>    - Changes to the RMR get/put API format compared to the
>      previous version.
>    - Support for RMR descriptor shared by multiple stream IDs.
> 
> v6 --> v7
>   -fix pointed out by Steve to the SMMUv2 SMR bypass install in patch #8.
> 
> v5 --> v6
> - Addressed comments from Robin & Lorenzo.
>    : Moved iort_parse_rmr() to acpi_iort_init() from
>      iort_init_platform_devices().
>    : Removed use of struct iort_rmr_entry during the initial
>      parse. Using struct iommu_resv_region instead.
>    : Report RMR address alignment and overlap errors, but continue.
>    : Reworked arm_smmu_init_bypass_stes() (patch # 6).
> - Updated SMMUv2 bypass SMR code. Thanks to Jon N (patch #8).
> - Set IOMMU protection flags(IOMMU_CACHE, IOMMU_MMIO) based
>    on Type of RMR region. Suggested by Jon N.
> 
> v4 --> v5
>   -Added a fw_data union to struct iommu_resv_region and removed
>    struct iommu_rmr (Based on comments from Joerg/Robin).
>   -Added iommu_put_rmrs() to release mem.
>   -Thanks to Steve for verifying on SMMUv2, but not added the Tested-by
>    yet because of the above changes.
> 
> v3 -->v4
> -Included the SMMUv2 SMR bypass install changes suggested by
>   Steve(patch #7)
> -As per Robin's comments, RMR reserve implementation is now
>   more generic  (patch #8) and dropped v3 patches 8 and 10.
> -Rebase to 5.13-rc1
> 
> RFC v2 --> v3
>   -Dropped RFC tag as the ACPICA header changes are now ready to be
>    part of 5.13[0]. But this series still has a dependency on that patch.
>   -Added IORT E.b related changes(node flags, _DSM function 5 checks for
>    PCIe).
>   -Changed RMR to stream id mapping from M:N to M:1 as per the spec and
>    discussion here[1].
>   -Last two patches add support for SMMUv2(Thanks to Jon Nettleton!)
> 
> Jon Nettleton (1):
>    iommu/arm-smmu: Get associated RMR info and install bypass SMR
> 
> Shameer Kolothum (10):
>    ACPI/IORT: Add temporary RMR node flag definitions
>    iommu: Introduce a union to struct iommu_resv_region
>    ACPI/IORT: Make iort_iommu_msi_get_resv_regions() return void
>    ACPI/IORT: Provide a generic helper to retrieve reserve regions
>    iommu/dma: Introduce a helper to remove reserved regions
>    ACPI/IORT: Add support to retrieve IORT RMR reserved regions
>    ACPI/IORT: Add a helper to retrieve RMR info directly
>    iommu/arm-smmu-v3: Introduce strtab init helper
>    iommu/arm-smmu-v3: Refactor arm_smmu_init_bypass_stes() to force
>      bypass
>    iommu/arm-smmu-v3: Get associated RMR info and install bypass STE
> 
>   drivers/acpi/arm64/iort.c                   | 369 ++++++++++++++++++--
>   drivers/iommu/apple-dart.c                  |   2 +-
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  80 ++++-
>   drivers/iommu/arm/arm-smmu/arm-smmu.c       |  54 ++-
>   drivers/iommu/dma-iommu.c                   |  11 +-
>   drivers/iommu/virtio-iommu.c                |   2 +-
>   include/linux/acpi_iort.h                   |  18 +-
>   include/linux/dma-iommu.h                   |   5 +
>   include/linux/iommu.h                       |   9 +
>   9 files changed, 505 insertions(+), 45 deletions(-)
> 

I've tested the patches on a NXP LX2160A with SMMUv2 and things look 
fine. Thanks!

Tested-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

---
Best Regards, Laurentiu
