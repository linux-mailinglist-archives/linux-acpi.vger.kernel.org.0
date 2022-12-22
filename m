Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F33F6545F5
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Dec 2022 19:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiLVS2D (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Dec 2022 13:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiLVS2B (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Dec 2022 13:28:01 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0136513CD1
        for <linux-acpi@vger.kernel.org>; Thu, 22 Dec 2022 10:27:59 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BMFiGBh004854;
        Thu, 22 Dec 2022 18:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=6Z3GAHqzE2up3uvq9qtcPS7z5x7s2ytstksL8saIOLw=;
 b=K94QIn27RxsKN5pjlrS3pkej81IMxcGVYWZwtJmpIex5PzfqWvk7fZPTdx/Th8P1G9WS
 LDFPctGJqwz9B3B7/k45WO3JetirV4JkXsvdjm6q4WLkGJNzheFapNgZBX7dAsivB8mw
 rYfo9OrA2aKhXEh7rUFDJLA629KR7nsqeL35dHhpZt4PeK0ZdSaJ4e1CMUlO4SHPwQzR
 fEr8ZDf4RwzcPtcbBiygF8qfRR8uCxQjNdBd3f0lK78oZkZuoIRof06onAObn2HT7KWg
 ISzR6T6OvwhvxclPJT3dlC4g8qQbr+gOu6OrgxXaTtcseOj5WgZTK95SpbpGXYdbow4Z aw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tr4cxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Dec 2022 18:27:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BMHoNcc015759;
        Thu, 22 Dec 2022 18:27:54 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mh47fc1xg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Dec 2022 18:27:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQmlq3p7xmdoWnR17k5kPPv/BUQsmAW+v+Zqj8HEgwTAVE/QKmVPDM1Pqz2NJElIva97qKhmWVFYf5/Dp9NoTo0qBNj78t58Q8hCgWbS0ASXmf9K5DJQF1IkKu0X/85/4huGVfIy/P/aajuPlsm//cXhduixosFrXHFReQoxCq0bDPwdavjDNyLRL5AzhYk0aV2N6lRtykOTg462AlwIkHXpaRVUDKMwl4+TAi1pC5LMqavtNE527WhlWbHKnlHP6rlC3F28akGVWYnG3A65qbx/xZB/5NKXtTvCNR2ThxsQzmyEH3zpiqR+wcPCQy8+sXxA3uI2W9i5Xn4isAiHJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Z3GAHqzE2up3uvq9qtcPS7z5x7s2ytstksL8saIOLw=;
 b=H5aQyX6hwEGhIoJI6Ppaw/pzBcoBte9tpHYnEa1d5k4uUR/msGiwqY1KLQ4A5jFLi1Ye/MpV0zyMbJXYKHanuseXrZv8LxVqe5+8n/pM6vi+h9n+PD8eSBLp7qx/aj9RossNDqFnyMxMXSyp3JSA1oVQzEJWTBR8QPejN7eVA38Stb5Mhg039TdIkF0BIA3p+/JhilBez9Xtj8evZZQrDYIv6fYEbLT1oHzyoC3tlymg6EVJW1dN1HyKzoE5tMRnBctzZ6Q3p1LTXBiB+fJ1AB2WjbWqZS6u31gXaWNBd9LUKL0c9R2kTDK22SyHD8w5Hm/p6IAVTsmEb8PS/xVnWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Z3GAHqzE2up3uvq9qtcPS7z5x7s2ytstksL8saIOLw=;
 b=uaHm+cbajmAog7nYkid5zKEQaqw9BROyyDz2Q/2DskrqyTXUt9FRotcLrOh+MVex/1IYBiE+l6RKkeAGW9elN6XiycIOE6ZQakx01c+EXPAHsU3zRCgkc1hMwB3NYlcXNzxJUaV03RvMhMJ7DoVnDvGJP+KuJozT+mZzVhtsVXo=
Received: from MN2PR10MB4093.namprd10.prod.outlook.com (2603:10b6:208:114::25)
 by SN7PR10MB6617.namprd10.prod.outlook.com (2603:10b6:806:2ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 18:27:52 +0000
Received: from MN2PR10MB4093.namprd10.prod.outlook.com
 ([fe80::26ed:5757:23aa:4288]) by MN2PR10MB4093.namprd10.prod.outlook.com
 ([fe80::26ed:5757:23aa:4288%4]) with mapi id 15.20.5944.006; Thu, 22 Dec 2022
 18:27:52 +0000
Message-ID: <ed640d2e-d4e5-afcd-414d-0e9184049314@oracle.com>
Date:   Thu, 22 Dec 2022 13:27:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [External] : Re: [PATCH v2] x86/ACPI: Ignore CPUs that are not
 online capable for x2apic, entries as well
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org, lenb@kernel.org
References: <a90ed996-95c9-9fc8-93b5-bcc733618eeb@oracle.com>
 <CAJZ5v0iY_TgF2tN2aOK3HrahauxY6DP1rbTumgTmZugBjqfomA@mail.gmail.com>
From:   James Puthukattukaran <james.puthukattukaran@oracle.com>
In-Reply-To: <CAJZ5v0iY_TgF2tN2aOK3HrahauxY6DP1rbTumgTmZugBjqfomA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR11CA0016.namprd11.prod.outlook.com
 (2603:10b6:5:190::29) To MN2PR10MB4093.namprd10.prod.outlook.com
 (2603:10b6:208:114::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4093:EE_|SN7PR10MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: b3514393-d50b-4f3f-daa2-08dae44a3c6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UN7yiU0e8EWd+7Z6lKhCKJvQu6ls/ktD3x7EVW+F1fGGng7OWokidSBBrixW30dJ6/eioiHa22Rs+4TAiSd7GTeEEB2+On6ll2pFsL7D+NsL09ijMe6HJvKSrghV9EmB2hXJiaR8aKw5ef32BwXeszCCTEkrYhkvPeDaqsGP+bofUwGAr96UnSzvqVRFtX2wQcS74MlSSI0tRr5LiKZegA3tMHujW4rtoOTY1G/rDzX0iS1rSC1FW+iPMO2cFz5Yg2i55uggXtPOl5sbMBEphtOeqrcQVkd2edj3m0oCvpICwddZBN/OLEuEgY2nLcqPHkzybKTVmhpqSx2OOlnMHkR3XrjeGj/DlLg6TYhbiqvv3PTbWYwjmdpj/veGtUm+B85oC7vAOB0upX/JhmwZRxIuK+TWZuxzW5SsQoygFTJT3J646arYQyxGekVvWn8gY1sfy4MI6BX4fUMZZmVpo62/JMXYnWxbfgErTeWkqD3Xr41Uaz27Elj3FcjmEcfOCq86HEbP69skXj6H+M2lb3uGtiV8LRPtiClMF6BBR0nlxzkwRDJp/EWGLLQ50vnmoeysk6RHivo1TkXxX8Tj4zRRC9KSXv3Npq2GcZ/HU6/IBGWpgo/IuheUvONF8F92kp9S3zhZnNsA78aDFB3IykPqODk83+tXgot0OyaZASbBL/EDrO8fj8hVUpt08h8z7AixCLdrpdXUS9pvPj4Xunyb9MxCmaTYWq0HE2NPUqE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4093.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199015)(8936002)(2616005)(38100700002)(186003)(6506007)(6512007)(6486002)(53546011)(36756003)(478600001)(83380400001)(31686004)(66476007)(4326008)(5660300002)(8676002)(41300700001)(86362001)(66556008)(316002)(6916009)(31696002)(2906002)(44832011)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWt4UE40UWRsdW5vMDR3NXZaS1NPUkZiaFJuQmV2d21ZVVVCY29qdHEyY0hF?=
 =?utf-8?B?V1B4Q1dJcEtLeUdQdDYydmd3c3MxSkE1cUxzaTlndmxhTFA0WTJLRmRSM3A5?=
 =?utf-8?B?eGJCTDF2MUorZHBIclhPN0IySEEvMjFtc1gwelV5UmlvRFQ0dHFDcGtRbnI4?=
 =?utf-8?B?TjFkSThVNGpRaDA5c0VVL283ZklFY2QzVzU5bkFHbTEwcnBEYmNTaWoyZElS?=
 =?utf-8?B?Y2o5Uk5ia2dJZU1FdXNqNWdGNG1zY00xa244cW01UUphRUFaNVY5TWFkamZB?=
 =?utf-8?B?V3BSM1dTdHIwa0M2Q2h1NmNtNXBxdEZUTDY2SEc1Rk1GcjVncy94UFVzQ2t4?=
 =?utf-8?B?aTk2ckMxamVZTDlGQm85em9rN3NvMGFNU01UM3k5TVpPNTBUMVEyaFkxbUtX?=
 =?utf-8?B?T1RTQkdhMWhzRXBobEdtS1NGWUY0cUY5RktPMHV0dUViYXFWVk1DeXlkTW9O?=
 =?utf-8?B?RkxMb3JhamxhYTVFSlF4Njd1VGI0N2JLS0Y5eE51Zm8zQkIyaTFCUUgyZ1E2?=
 =?utf-8?B?NCtoWDBjT1N3SEFFWDJSRmt6OE1uYUxtYzhISmFLQ1hTSVV5aGtBZElIcnIr?=
 =?utf-8?B?c3NuSDRwLzI4UVBiUjQ2WnV6T1pBOENYNjM2SWRZbVhkcllJbkJMaEF4aW5S?=
 =?utf-8?B?Y1pmbzhoZ3p6UXFGbE1rNzhleWFWemx4Wm1lQjZITFRQSUtIdkVSQmxkTFZx?=
 =?utf-8?B?Q0MwZ3Q0RUFNUUlZNFEwMWk0aW5uRjRhS1dLTTNMcUkrNVRFOGJoMGUvQnBo?=
 =?utf-8?B?aVpoNmVidis5Q0FEc3gwNkE0SDgvYksvNFJFdzFOaVB3T0dTd0pGNWJPWWpw?=
 =?utf-8?B?MDQ2S0NGNk5TY1ZmRzNYZXRhU3ZBVlNTZGEyYVVVZXdjdDdzWVNLT2liVnA2?=
 =?utf-8?B?Q0pTL3hYcnNQMUpwY0Jud2J2aHFQeWpGeVM1eEhXUGpCS2ZiQVNvZytObE5h?=
 =?utf-8?B?Q3daa2JndTJudzJlNTJqU1hJemxWY015Szl0bHRFTURGbUVyeDZXUm83UzQr?=
 =?utf-8?B?TnowL3hLMVRra0toK2hZaVh4c1oxT1JDdDl0aWsvZUVtZ21FQVM2U2gwcmFB?=
 =?utf-8?B?Rk1UNC8waGFkR20wUytDRThsOHZaWjVCVVJtSkwrSXlMS01KRkxuak93eUxS?=
 =?utf-8?B?dUNwYkFaVmlXRFJQUGRTRzZEYkdmbHNwRldqTFNQVXE2dUEwSDdsZGwrUFpt?=
 =?utf-8?B?cXVQdWZzMVA1TUhqT1hPTjRFK3hOZndDT0lwMHQ5YlFmRWVPZjBHck5UOHZY?=
 =?utf-8?B?UFBTNktsS1JSTWZ4djhrS010djRyYU9haG9aY3pjaXM3RmlVeVB2K3ZYZ2pL?=
 =?utf-8?B?QnJXV3hBWW12L0hBQmw4NlVRODkxYmJ2RjRZRmJHS0Vad1g3T0diR0FQS2Z4?=
 =?utf-8?B?WG9HRGtLazZjT1o0YVFpUVRBbWJRTkNGVVdjdGtRNHg5V1hrYVdJanFGdUJD?=
 =?utf-8?B?czR1TnY4RzBNZEQyNHY1bWxONlFpa1BsaDMxQjJFZDJHd2wzU05hL284Mzhi?=
 =?utf-8?B?b1dFbmN0Y0UzZzRuc2lTTjlPQjBUYnFnT21jYWVuRHB6WDFkWVd5NXI2aEFm?=
 =?utf-8?B?QW9lNkkyOVA2elpPdnJKOHBLbmh3aVdqNUNEckxtY0JkalR2VWhhWGN6eHlW?=
 =?utf-8?B?bGJYdEhlZ1hxcVNOQkNKQWdzK2o3KzZtbjFkcmZlRGFvcUxPUWxFNE5aNnda?=
 =?utf-8?B?aXRDSW1zU3R3dmFJbUxKOWpCWGtVT2oyNkJsMCtac21CeEtaL2s2MkhqYnJw?=
 =?utf-8?B?bExIRVR2WWhvT3RQQ0s0amlpVTcrU2NMQjRYMWhMdzNpYm5YY2ZGbEREcHNW?=
 =?utf-8?B?aDlCbm1QdlBhVERjTDZpRlpPdlJobUQxMDNONWZ5VitOb0hlM1kwa2hERXc0?=
 =?utf-8?B?ME13MnNNVm40MUk4V0tWKy9iVlV6Sm9kd2ZIMnMxSGhQQTFvMEZ0TVNoY1Vt?=
 =?utf-8?B?dk1ZcG5zdzFnTU5YaUdtb3ZnMzBxSXlCdm9RNjNEeHQxWllUVDFiUXBxU3Qv?=
 =?utf-8?B?b1A0OEVkdkE5L0NaSDVKZzcwcnhhS0ZzRlBUZUJZMDFMNGxsckhOWm5URFlF?=
 =?utf-8?B?QVVFM1BBelVPM3ZhbzNIbzhSc2lSTng4VEljYWtXWjgvVWE0bUhzRDhaOWtt?=
 =?utf-8?B?UE9aTUxwZGRRTGZVN2Rna21iYTdrVkFUdWVMa01idzNZQk5uMk1VL1B1Tlpm?=
 =?utf-8?Q?Bqol1URHs2CI269VVsVd159s7ftPI6634k1TFIvi9X8l?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3514393-d50b-4f3f-daa2-08dae44a3c6b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4093.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 18:27:52.0635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91pkTfJxbV+GDCQISzaNwIpXXLF2eAZ2+9yKu6cG3C03VyTMDQquIi5TeRg/CWC5lhrOixMVBc3CS+DpFLdY464xvmqB31VsQDF73eaah620KCcPl2BRMzSqvi48pDdN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6617
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-22_10,2022-12-22_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212220157
X-Proofpoint-GUID: Ar-UxxA0LKPXBIm32uQUUQkoYLDMya3L
X-Proofpoint-ORIG-GUID: Ar-UxxA0LKPXBIm32uQUUQkoYLDMya3L
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

thanks, Rafael. Accepted all suggestions. Sent out v3 patch
regards
James

On 12/19/22 09:24, Rafael J. Wysocki wrote:
> On Fri, Dec 16, 2022 at 7:36 PM James Puthukattukaran
> <james.puthukattukaran@oracle.com> wrote:
>>
>> Extending commit aa06e20f1be6 ("x86/ACPI: Don't add CPUs that are not
>> online capable") to include acpi_parse_x2apic as well. There is a check
>> for invalid apicid; however, there are BIOS FW with madt version >= 5
>> support that do not bother setting apic id to an invalid value since they
>> assume the OS will check the enabled and online capable flags.
>>
>> Signed-off-by: James Puthukattukaran<james.puthukattukaran@oracle.com>
>> Reported-by: Benjamin Fuller<ben.fuller@oracle.com>
>>
>> v2 : use 'enabled' local variable. Also fix checkpatch.pl catches
>> ---
>>  arch/x86/kernel/acpi/boot.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
>> index 907cc98b1938..35d8c8654b42 100644
>> --- a/arch/x86/kernel/acpi/boot.c
>> +++ b/arch/x86/kernel/acpi/boot.c
>> @@ -208,7 +208,16 @@ acpi_parse_x2apic(union acpi_subtable_headers *header, const unsigned long end)
>>         apic_id = processor->local_apic_id;
>>         enabled = processor->lapic_flags & ACPI_MADT_ENABLED;
>>
>> -       /* Ignore invalid ID */
>> +
>> +       /* don't register processors that can not be onlined */
>> +       if (acpi_support_online_capable &&
>> +           !enabled &&
> 
> Is the line break before the "enabled" check necessary?
> 
> I think it would be better to check "enabled" first anyway.
> 
>> +           !(processor->lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
>> +               return 0;
>> +
>> +       /* for systems older than madt version 5 (does not have
>> +        * ACPI_MADT_ONLINE_CAPABLE defined), ignore invalid ID
>> +        */
> 
> The formatting of the above comment doesn't follow the kernel coding
> style for multi-line comments.
> 
>>         if (apic_id == 0xffffffff)
>>                 return 0;
>>
>> --
