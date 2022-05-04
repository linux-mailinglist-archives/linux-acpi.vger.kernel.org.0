Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C51051A19B
	for <lists+linux-acpi@lfdr.de>; Wed,  4 May 2022 15:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351001AbiEDOBo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 May 2022 10:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351079AbiEDOBa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 May 2022 10:01:30 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60059.outbound.protection.outlook.com [40.107.6.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2E241617
        for <linux-acpi@vger.kernel.org>; Wed,  4 May 2022 06:57:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7fVr8aVCrU5rSKYbv6WKYSm10tN28BSF81xf3jdpGEf7IO2jiJw8XFn28mO/9w9oHWhRPps908iro93/kpfrugOoWHf6myMOJn7ysvPSrK2r+diPCvanjyvX6pxmaY3+Z3xLHq9/zw/HMbpuZJ5btyY4AwbQxuuNk9U9rtY7fEnOZr695Xiw9XJyO9nODMAd4friGtimqR4zXCYaQYZttClNpV7LTv8ZyEnuuHyhK9yjHd1SVZq6I0o/AtLj4PJQUFAlGaMQgZmCpIdnT3/KvVj8na5FX8GYo81DNE9M3q2b4hFcUWX06sMfXM91jSTQNTAPk0nJtV7tm1vzhQwJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EEn74IEMs3n1Tdkvz1Ot5J851Ilkur8LLomQCZk93I=;
 b=lEBd6z69BukMmJh4ItZfVuBT2D8RgYSIFTWtRLiq/6T9A492zAacnptBsgG+0PQB4si/tSq5332zK3oyyVaejghYXT9EoDGBvjw21AY3wdRRwRsrt3AXFXPD3w6e9yAU6g9g4AlNTrkXxg92FtZpN51/Q3+NQo/+eRD8PYtJp/THT2yIpoUUeW5LISs0Dp+fzS2BmiJGzYZCRv0rWxy8Y7ybC7aZPhlvRE1SNpewgrzpvpSR82JBgoxA9W8NKcLmi+mtH3JxSVdg8cJd9CMF4Z92/4N7DHdJ50cVaK+vWIxRbdoDkkku7hSuU/R/1vxjq7lOFIwZWk+INQbDDywwMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EEn74IEMs3n1Tdkvz1Ot5J851Ilkur8LLomQCZk93I=;
 b=oNLDL1rW50igCzorRt2m1iArqmSSGA6hjgVka18i1Mo0J4AcO0JTn+g/hfmTmrWOMfF6SEkzwxg9yvK2Qg2s1ZtIIrl+wxyGhaP0FF7vach6/4vqqOrvB9HgebcTp29J/kWxvPJEy1S7QWt4GYQ9QtcdVskWrndVuGbICW8ukIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by HE1PR04MB3100.eurprd04.prod.outlook.com (2603:10a6:7:21::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Wed, 4 May
 2022 13:57:14 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::8ce8:25aa:6242:b565]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::8ce8:25aa:6242:b565%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 13:57:13 +0000
Message-ID: <b6bd7101-f5b9-4676-d515-ed4d1ee14e75@nxp.com>
Date:   Wed, 4 May 2022 16:56:51 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v12 0/9] ACPI/IORT: Support for IORT RMR node
Content-Language: en-CA
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     linuxarm@huawei.com, lorenzo.pieralisi@arm.com, joro@8bytes.org,
        robin.murphy@arm.com, will@kernel.org, wanghuiqiang@huawei.com,
        guohanjun@huawei.com, steven.price@arm.com, Sami.Mujawar@arm.com,
        jon@solid-run.com, eric.auger@redhat.com, hch@infradead.org
References: <20220503163330.509-1-shameerali.kolothum.thodi@huawei.com>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
In-Reply-To: <20220503163330.509-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0176.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::13) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28e883b6-be80-4aa9-3be6-08da2dd5fdd4
X-MS-TrafficTypeDiagnostic: HE1PR04MB3100:EE_
X-Microsoft-Antispam-PRVS: <HE1PR04MB31008D0DEE781C79F5A8B540ECC39@HE1PR04MB3100.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fmG90a9Vr59tFLh2eXerG8Sdhp3hmOzbfRPB1hgkZOauMMoS8VuCwPbewKYANJWd1rGG7WwRMdhKqt5bypupM41YM4LGB3u+xf/nJhZeLVdplfZzWp4UUGsrMvtZgKBxnHeJmrXw6UBIS1iXx6pIllqQ2MzkovOVsRyQT6SMllkT7gGIjkwGWoYLvH/FT3pSUz6S0kElN2QB030jTM/SLk3qNqqXsJyDSZcUz2Sogz/8Y/ZbqXwAZnfYIJOq+/RmuGN7+1T0dkRBPu2NOq01Kag8dAJ+HVl8frZUvcmG7FCvu8qWW+kLGn7mCDp/ngPOg2b8mf7hj5Ai1UzqRGh+0aFHazUqiMFXpFAQxB5CP1oH8qxq3k2euQgb1Mi6Q754A4R8FcOsiRqsyu1oRBKZgKqPSZYsTfp4o31cxXcm5npu/lUE4hAQsO3hXFpKGoh+tkQtwUTqDqwzGVQsQ342o4JKDj/NxQO1nAEsQTgwAwLVhyQbaw00VNziNFF7djg4MedQfmqla5jgqxWYgPb/5n+oQ8xqO59X9dRowlTCXySQ0kcsSIIGP5w2Fcfd1nFyqT/jCf4YuuW+qBCKEAgD0+6nx13V37YUJYGXLzqsVm4M3dBhKCXeQeTeHUBW+9xendocFnZJk2mL42Ibz7GSnjnGIcM0KThjcL0YjTFfe+EUhA0hjEUtkjwf5rIo8JynS23WpGIs8Q8/Jdk72iOgWbcLrLomtsiwBIDsDE1rFR857nBB6sSh5ABYnXjaxbsYX1hXDSqbiuDxi2vhHzNAGaECu6OZyeXKGVAHEivb0Wk58HI3kfHWgPzDz5aBYtSUd5LES6Umsn0AZAQUicL7lrZqXwkue5pyAQ01kh5JLov68apku/OUGdaqt9Jkn482ojn06zeBfpV7t8JmxqaMTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(66946007)(4326008)(66476007)(2616005)(66556008)(8676002)(2906002)(8936002)(186003)(7416002)(45080400002)(966005)(31696002)(31686004)(316002)(83380400001)(36756003)(26005)(6506007)(86362001)(6512007)(6666004)(44832011)(38100700002)(38350700002)(55236004)(6486002)(52116002)(53546011)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1JjM0p4eE9uY1QvaDRnRWx6VmNNYWJRbmtWOVMrQm14bCtmcWJSSWN5Lzdx?=
 =?utf-8?B?Q3hZOFlBWUlQRWUwL2FRQTZaRzNOdE5RWjBzYlp3Yk1PdGtac2wrbmQvOTJw?=
 =?utf-8?B?VVY3YXV5aGdwMDdZK0gxamgzd1d4L1VPL3diN1dla1lhQmIvRzlWd3Y4M1Bo?=
 =?utf-8?B?QlNTTFF4VzlKTWJXbkNTMERibjlyZUdveklsTVgrVHR5R2ZKVzhwMHVhdjEy?=
 =?utf-8?B?eG1QcUc1cm8xTmpDWllCS3RBWVRCc20vSnhuMzFLdG95K2xncHhJTklqZzdr?=
 =?utf-8?B?dHBpanhQclJYV3dseG5yY29tQzdLTUpEcXhLeEphNzd5RFFMd1M3MnhjSzBp?=
 =?utf-8?B?NlZwLzcwOTBoakIxQWdDU01jVTlGclVURHJWQnVFS0NVUUszZk1ObkVSb1pG?=
 =?utf-8?B?SGd6YkV2aDdReG5meXBRSW04U2o3OVJnZ2NOcUxlTUwrZVY5aTI2Y3RUZVFU?=
 =?utf-8?B?ZmZxMmk3WjR3SXZXaCtqKzFXWWoxRHNsNHcxWWJLSUtxa0dmWGpiTnl4QUlu?=
 =?utf-8?B?VHpDbGsxVE5BRFhyZnJkT2hKMEo4N0tsUEpVbFZRc2J4TXZzVWRmYndTVndE?=
 =?utf-8?B?SEkwREJGZ0FVM2FYSENXaUZITDBkTklrRWx5UDk3dHlGelQzRkV2dUE3eWEx?=
 =?utf-8?B?Rmh5VUFET2trU09wWkhnQWx6Q2RFOFA0QXNNazBwalBYU29KRVFPRTNIblZH?=
 =?utf-8?B?dUFzVzkyUHZGdHpJNkJqMytPNXYwN2RjMWMzUXg2dndPaU9XaU1ZdnBXVHVM?=
 =?utf-8?B?WjB2dkNnVG9DZGczbTdQSXp0SzZXZmpnSWdscWRrNE5mZUp6Wit3aHAzWWNk?=
 =?utf-8?B?V3krM01OSnExOVpEbUxzVUd5aGtLc0lMV1RUWGttaW1pRi90WHJsQVV0T2Jv?=
 =?utf-8?B?R2IrZ1R3Yk5leEtNc1ZVdUdKc1NZYnF1VFlvV05qOVlnVDYrTmFncXZRTmI5?=
 =?utf-8?B?blNWZ0FHNE8zcGdXTkJ2MjdXRXdVL3RtWktEeldsc2pUODJjM2FSai9JL1Mr?=
 =?utf-8?B?WXFXSXV4S0w1SnRpc080a3V5SDVNVUlETmc0THh0NUwzUGREVnRGRkhRbGVZ?=
 =?utf-8?B?cmw2eGkyWTdWT25TbTFKNkpwNDRpRGQ3dnNvQWFKdlMrN3Y5MW1raFBuajhz?=
 =?utf-8?B?RHpGT3d5YldaenVEbXZlcVpPL0h6N0ZiTmJ4R3AvT2JBWUdFSktZVmxvOVpY?=
 =?utf-8?B?MHQ5bVFsV2dEYjRjOXJzZ0dTTUxUakFNdHBoOVJyS3pON3lXSHhxNXFPUTE4?=
 =?utf-8?B?MjFVT294VW5DeTRyMU1xWUNyZnoxUks0S3I2V2RzSnJaeHBvSmRzd242eFcy?=
 =?utf-8?B?cXNqdFFIVHJQRFNlaEZQeFYxd1A3ckdjL3o0b0NQYXFNYWUyZFBzRExnYXc5?=
 =?utf-8?B?czAzRFBRVkkyVm1RNUd2Y1NWblRrTE5nUGpSRElGeHk4VWM2bW9Cbjg2Zndo?=
 =?utf-8?B?WWd0djRacE8wOEt4QzQwUFVsRGttMjFydTNOdXh1OFhpQ3dVRkErcHRJR0Nq?=
 =?utf-8?B?REFXOUIxNGhGcVdpR1pBaTJhc0NJMmhReDdrSWxreUE1ajhOZ0hLR1E3RE1r?=
 =?utf-8?B?Uk5sR0daQTlRMTNMZjZDbEUwUHRwOWhlUG82bDVTcStNMGFuOHlGYm5HeTJX?=
 =?utf-8?B?bnMrdHBhTm1Fc1FFOUxtSitERVZjRXcyN2k3a1NhaGdCNHlDUEl2NHR4allX?=
 =?utf-8?B?V1FPWnNnc3JBOXlZaWptZS9kaURteW5VT243cFIvK1Fhc2IyczZCSUhHK1lz?=
 =?utf-8?B?OHE3Q1NDbDl5ejNLSngrckFjaXB0KzNnNExaVVpOK0pJSjg5Z2pvZ2lCd2dF?=
 =?utf-8?B?K1MweitMNVc4WHlQUDlKK3habkZtUS9tOUJuTTNEOXJ1bU04TDBUWk1CbDlr?=
 =?utf-8?B?SlJHVmJjdkswMlMvMGRwczF2cHpVcDNRa0I0VVF2WVlDbTNFYVRnVkc2MmVS?=
 =?utf-8?B?ZjUvZkFxTGdsRlkxeTgvOGNrR21ZczdLM0wwSys1dXk2eGJYazlWSW02cysy?=
 =?utf-8?B?UHB3UURJdWcvRFBMQkt3dDdZRnczMk9pNkx2aXg3d0wvNmEwMzUxYWp1V1BG?=
 =?utf-8?B?RTNrRTZUS2FCNjVMdGlnTFBZWDR0Q0cwMmtuSTNLbXY3cmpQY1o0cUdDY0M5?=
 =?utf-8?B?aGtUeWd6Q0tMVndjWm15TGJDeE1YcUJweDBxNUxtcGhxS0IwNkpQaC9xNE1v?=
 =?utf-8?B?Wlc5OWovSy9JR3c2cGhhV3NWbXpVZFN6Sk9FY2wwMTJIdkpkeXV2ZzJEbUNR?=
 =?utf-8?B?ZDZFME0xTzI4b3FEZVlYWE5JMDVxZitSaEJFU2hnU0diQ24vZ095VHc5bHlz?=
 =?utf-8?B?SXc0cTF1ajRsYTF5L21YMHVURDYxMGNCYkdnM2ZieVVEcDlQYVJXMXBLV2wr?=
 =?utf-8?Q?xgcn0rRQjmVvm8OQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e883b6-be80-4aa9-3be6-08da2dd5fdd4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 13:57:13.8518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hs0jPXh4Nb+wjt+IXQouBCDK7c8zixa6PKaYMKVi5ciT/W2Frbp5Ib3vjBI2KvQIXS34hQ802PlWC/EIVeFK8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3100
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 5/3/2022 7:33 PM, Shameer Kolothum wrote:
> Hi
> 
> v11 --> v12
>    -Minor fix in patch #4 to address the issue reported by the kernel test robot.
>    -Added R-by tags by Christoph(patch #1) and Lorenzo(patch #4).
>    -Added T-by from Steve to all relevant patches. Many thanks!.

Tested on a NXP LX2160A with SMMUv2, so:

Tested-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

---
Thanks & Best Regards, Laurentiu

> Please note, this series has a dependency on the ACPICA header patch
> here[1].
> 
> Please take a look and let me know.
> 
> Thanks,
> Shameer
> [1] https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F44610361.fMDQidcC6G%40kreacher%2F&amp;data=05%7C01%7Claurentiu.tudor%40nxp.com%7C8157d32925724ac9bf7908da2d22c1ab%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637871924543316157%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=DdYCpg%2B7NW%2Fb8FBYOEsmlYV88kwN0K75AF9Y7%2Fg2BEo%3D&amp;reserved=0
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
> v10 --> v11
>   -Addressed Christoph's comments. We now have a  callback to
>    struct iommu_resv_region to free all related memory and also dropped
>    the FW specific union and now has a container struct iommu_iort_rmr_data.
>    See patches #1 & #4
>   -Added R-by from Christoph.
>   -Dropped R-by from Lorenzo for patches #4 & #5 due to the above changes.
>   -Also dropped T-by from Steve and Laurentiu. Many thanks for your test
>    efforts. I have done basic sanity testing on my platform but please
>    do it again at your end.
> 
> v9 --> v10
>   - Dropped patch #1 ("Add temporary RMR node flag definitions") since
>     the ACPICA header updates patch is now in the mailing list
>   - Based on the suggestion from Christoph, introduced a
>     resv_region_free_fw_data() callback in struct iommu_resv_region and
>     used that to free RMR specific memory allocations.
> 
> v8 --> v9
>   - Adressed comments from Robin on interfaces.
>   - Addressed comments from Lorenzo.
> 
> v7 --> v8
>    - Patch #1 has temp definitions for RMR related changes till
>      the ACPICA header changes are part of kernel.
>    - No early parsing of RMR node info and is only parsed at the
>      time of use.
>    - Changes to the RMR get/put API format compared to the
>      previous version.
>    - Support for RMR descriptor shared by multiple stream IDs.
> 
> v6 --> v7
>   -fix pointed out by Steve to the SMMUv2 SMR bypass install in patch #8.
> 
> v5 --> v6
> - Addressed comments from Robin & Lorenzo.
>    : Moved iort_parse_rmr() to acpi_iort_init() from
>      iort_init_platform_devices().
>    : Removed use of struct iort_rmr_entry during the initial
>      parse. Using struct iommu_resv_region instead.
>    : Report RMR address alignment and overlap errors, but continue.
>    : Reworked arm_smmu_init_bypass_stes() (patch # 6).
> - Updated SMMUv2 bypass SMR code. Thanks to Jon N (patch #8).
> - Set IOMMU protection flags(IOMMU_CACHE, IOMMU_MMIO) based
>    on Type of RMR region. Suggested by Jon N.
> 
> v4 --> v5
>   -Added a fw_data union to struct iommu_resv_region and removed
>    struct iommu_rmr (Based on comments from Joerg/Robin).
>   -Added iommu_put_rmrs() to release mem.
>   -Thanks to Steve for verifying on SMMUv2, but not added the Tested-by
>    yet because of the above changes.
> 
> v3 -->v4
> -Included the SMMUv2 SMR bypass install changes suggested by
>   Steve(patch #7)
> -As per Robin's comments, RMR reserve implementation is now
>   more generic  (patch #8) and dropped v3 patches 8 and 10.
> -Rebase to 5.13-rc1
> 
> RFC v2 --> v3
>   -Dropped RFC tag as the ACPICA header changes are now ready to be
>    part of 5.13[0]. But this series still has a dependency on that patch.
>   -Added IORT E.b related changes(node flags, _DSM function 5 checks for
>    PCIe).
>   -Changed RMR to stream id mapping from M:N to M:1 as per the spec and
>    discussion here[1].
>   -Last two patches add support for SMMUv2(Thanks to Jon Nettleton!)
> 
> Jon Nettleton (1):
>    iommu/arm-smmu: Get associated RMR info and install bypass SMR
> 
> Shameer Kolothum (8):
>    iommu: Introduce a callback to struct iommu_resv_region
>    ACPI/IORT: Make iort_iommu_msi_get_resv_regions() return void
>    ACPI/IORT: Provide a generic helper to retrieve reserve regions
>    ACPI/IORT: Add support to retrieve IORT RMR reserved regions
>    ACPI/IORT: Add a helper to retrieve RMR info directly
>    iommu/arm-smmu-v3: Introduce strtab init helper
>    iommu/arm-smmu-v3: Refactor arm_smmu_init_bypass_stes() to force
>      bypass
>    iommu/arm-smmu-v3: Get associated RMR info and install bypass STE
> 
>   drivers/acpi/arm64/iort.c                   | 360 ++++++++++++++++++--
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  78 ++++-
>   drivers/iommu/arm/arm-smmu/arm-smmu.c       |  52 +++
>   drivers/iommu/dma-iommu.c                   |   2 +-
>   drivers/iommu/iommu.c                       |  16 +-
>   include/linux/acpi_iort.h                   |  14 +-
>   include/linux/iommu.h                       |  10 +
>   7 files changed, 486 insertions(+), 46 deletions(-)
> 
