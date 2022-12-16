Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF00764F10A
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Dec 2022 19:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiLPSga (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Dec 2022 13:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiLPSg3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Dec 2022 13:36:29 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1652B19B
        for <linux-acpi@vger.kernel.org>; Fri, 16 Dec 2022 10:36:27 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGGhc9m019738;
        Fri, 16 Dec 2022 18:36:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : from : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=HouIJ9OOfBGcpLartBbNVZ2BR+NyiEwMzF/orzI4UD4=;
 b=WuarnJ/l212KxRyVZhCUJnu3xIwRIXcIjjQ3SVyaDTotMgNZ1d2jdXxNOeXfyv3ysy7M
 R809j6GpehhSbhrCXzinzj5oxC1c77xgk45qQ8XrVkNZet+FLm4oFkvMYZcph7OXyQTt
 Zibk49MXUvIrunCcTVCsKSURdB+851OXGC58yHpXviSt0XUsKqIM0YC8arAa6oxn5axY
 WHhiTCQn377m1VekQfu6aC1uXgl88Nu0sGoWlzmWp+WnMxPvWt/fUj7B2QFvxaYp9vrb
 sNZJSWKqLS4NJbUA6zmZAPjEGjLwLOXBGZ4/ElSZhqavdl7Tg3pnb9EpXAJ3Gnd62UiN vw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyex05xv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Dec 2022 18:36:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BGH6b2g034926;
        Fri, 16 Dec 2022 18:36:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3meyeqwt70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Dec 2022 18:36:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KX9isYsQKRf1FzNDY2Qs3tH/NwmuCQ0c0ecs/9yN/SEJLfWUcCWVecO0+PPUL0Cb8we0P3pFGg+I6B4ccS/13qlyqtVijOuXwDrjx7iOMH4M7NWbQEW50e4+8a8o9tu6FT1f6buFZPrnpUgbpwoSCY3l8khdv1t+PTF+TTv+JDEx0jMO92B4+JA2XicJMJAL/QsZbzTowjEtVRlczFtX7Apl//AJhx4nPc06pY53YBEh4t8FPV632TvnkEO/vhkGhCEbV+zMlrvcoXuu9ib2ztLwX45fmb+f2XamLFtnuXsKe+cbQ3u+yUFC3i3+I1es2x8jf6HMhaY6bbrDsNxrQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HouIJ9OOfBGcpLartBbNVZ2BR+NyiEwMzF/orzI4UD4=;
 b=iFMc6T0XX1edjZXxyx2fU6x23pTtvQJClglCgVczWhjUiPtjWqd3bsHMHSxhmyDXD6D8523igmAwOXPVnPr8+ZdOCw2FtGuBZKMxoyADG8+FV0kqXC4sjoY7SvAtD2H3hf8h92R5OQpa0LZtpHhTxIGcQM9d6TMiJKDzTmtXEZp0pZG2VDiFcTFiml8s4URxCtgceZWnMSSp2iCvvRRWH/d9BqjqqtrmG+f+VBe8lbJ486+0by+xqWvxnMfHBf/mNuPt5sQ41RvunSxMgdwwIySI3wAsl8P/CyKhLP5/XfmZlH8FNpmH8U+Kxbp+3R0HTlvDKXxn9V5dp0s7F+iKFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HouIJ9OOfBGcpLartBbNVZ2BR+NyiEwMzF/orzI4UD4=;
 b=Q/EoPiLVC0qelHcFXo4dNYypz2k30+qCEnQL2VyGPJoFW+msHuNajPyVIVlGANZEfZq2YEouGMrORca5BCPLNhAKNH9h5KOpUQ3W9gHeugEJgEyYHan5mrVqsBYPx/OIYZQh9y3hZwitE/ew8J5ob/tOmL/0tyf947gDKg2BB3w=
Received: from MN2PR10MB4093.namprd10.prod.outlook.com (2603:10b6:208:114::25)
 by SJ0PR10MB4622.namprd10.prod.outlook.com (2603:10b6:a03:2d6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Fri, 16 Dec
 2022 18:36:22 +0000
Received: from MN2PR10MB4093.namprd10.prod.outlook.com
 ([fe80::4293:a4c:3ca4:cef1]) by MN2PR10MB4093.namprd10.prod.outlook.com
 ([fe80::4293:a4c:3ca4:cef1%4]) with mapi id 15.20.5924.012; Fri, 16 Dec 2022
 18:36:22 +0000
Message-ID: <a90ed996-95c9-9fc8-93b5-bcc733618eeb@oracle.com>
Date:   Fri, 16 Dec 2022 13:32:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org
From:   James Puthukattukaran <james.puthukattukaran@oracle.com>
Subject: [PATCH v2] x86/ACPI: Ignore CPUs that are not online capable for
 x2apic, entries as well
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0121.namprd11.prod.outlook.com
 (2603:10b6:806:131::6) To MN2PR10MB4093.namprd10.prod.outlook.com
 (2603:10b6:208:114::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4093:EE_|SJ0PR10MB4622:EE_
X-MS-Office365-Filtering-Correlation-Id: d16823ae-7dd6-4435-ee21-08dadf946e1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aAdsb+El+CLpSSWRnbW1Hh7Ni/FDOFPvvgmElWCTMDb10MFU4lTQiC3DtWZ924WCdNbaXjQVoPQonjfmThxROzec+a8qO5X7gWDBySoOR/56la9cUqvqShhjAm849fUOEmAobutpTYbC6dsJ30vijIwJ9KIZDK0vTcCitY6IRsk81aUfxVlCURU6+bTPF7XzRrTJhqzLz07M3huKdI4w+t2RdWtQdp3myw9F0gdQiNBOV0vNCJHeFz/RVEpP9GHFbZWqHhWRTeWWBgRpNNpumxFJXWMTdnjUfuZncgpkT5PZxfo1NOsM43IJUl+zS2MavglRPFED9ka+4EaER4pwjqOZvrvXehXASfqJgcTyjt6mqreE9DP7ae4S2Yqjz3tCXb12oWThA7TXw0ueuilKsie7AEntMfTbSdpdM+4Lp+Hm+gdN4VnscBXYD7CW6YtuSJSfIBcfFP6BM4IatBMMIi4gYtQMO3AY5JGmEvp7c8rhVhUidsIESCS5Dvgu8xxVD9Ig7N9QD40fAHDgUB1N8+kBvM56re3s+Xw96kp+M/7R6PxXbU4NJwDgE275QP0STXREMIzMbQBHSokr+UkO2fHgKurv2qG3Od/4QecKdAlnHafr39iW3k8aDUkheqsrkb92mBWto7SXe18EQOTWFLwJgpAcOhez+SdPLGfPgrG66YrLIdeMMc7/gU0rO854hiwcHCTrR7MFKpsJcvMOSTZiuqTIEx+/4ZTH7EEEC3A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4093.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199015)(6916009)(36756003)(86362001)(478600001)(316002)(4326008)(8676002)(6486002)(6666004)(44832011)(66946007)(2906002)(66556008)(66476007)(8936002)(5660300002)(41300700001)(186003)(6506007)(38100700002)(6512007)(26005)(2616005)(83380400001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU1XT0JackRGbWxkQkRVWHZIaHlsQUR3WXpIcnlXTUNJSnZJUUVvOWFSKytG?=
 =?utf-8?B?U2d3ay9MYUt3STUydFo2OGdIUnIxYWluUDloTDJIaTdlRFE5SkVzZnNsdXEv?=
 =?utf-8?B?MjlhQTFoZWc5T05GM0U1TTQ5QTQ4alliRlZhUjlWelJBN25DWGUvcGM2bVhu?=
 =?utf-8?B?cGpBbHpjNU9wZWxsRmRVNEk5SXJRTGhHaUc1blYxbDhCOUtTV0JZS1cwTkdJ?=
 =?utf-8?B?eHdndTkxWGhpVC9LWGF5MmlDZkw4eEFCRXJVQUNVM0Rsa21XaDNqSmVhRHdn?=
 =?utf-8?B?Qk5WN2pOZGpHR3UyeFNUSi9uYkZLbVFPSlhwajNqL2JUT05FVkRVSGRIMTM1?=
 =?utf-8?B?b2ZxUzk4NGlGa083SFg5MExTelhEQU1kbkpJa2RNUkt5dFFkUjVZaWVFbUpZ?=
 =?utf-8?B?bFpBOFBwQ3ovcGlmTDNBUXpwUGxaZldVUi9vSW13ZkNwZ1NTNG9DTUFwdkp5?=
 =?utf-8?B?NHZMcFFIUWxibjgveFZjbWFXQ0IvTllrZlZrUnlMbkVvZWlKL0xYSzZ6NjVw?=
 =?utf-8?B?c0lQOHVEN0MyK1BnMk8raW9ZbDNVQXU2T0o3dW9xeWJXRDhhYVp1MlBRQzhs?=
 =?utf-8?B?VlkrYTNPQ2hhMlV1RVQwVmcwT3lqZW1BbElkSE9ZU2NYSGs0dm9DdEllbFRH?=
 =?utf-8?B?QXprSnRuT1ZPdG1MeWtMenFjVFVBOFB5d1ZQVTBPbHI1NG9DSE5wTG91dVc1?=
 =?utf-8?B?T1lhaFhGV3U4RElWWGdBRnZGMkR1V3Bra3hNVktMcjRkZ1g5cEVHT0NQZ1JO?=
 =?utf-8?B?QVhyY1RldFYzS2NJYnJpeWdTa3VUSTdZR2lpOE5SVCs2aFBMZm1DaUNRSFU0?=
 =?utf-8?B?dTVGMFgwOTNpU1VRdmRaVUhNMmZ4bDNqcWU3ZXk2c3ZCRmI2RFFSNWFuNjR4?=
 =?utf-8?B?L3NrZHY4KzhqTFRCZnlQQmh6cWozVHhneEJta2k5Zko1WHZwUDRCckpqeGNk?=
 =?utf-8?B?cTZVclQ0KzR2NjJpM1R2SFhwSEI4VVQ3MFNTYUc2SlgzanRlT1diVnlSNW16?=
 =?utf-8?B?Z3ZpNmtGVmtEeW50RVNQcXBiOTNLdVJDMHE3WGVaR0tJUzZPMHVSRkkrVkQr?=
 =?utf-8?B?QTNvMWJWTGpaQ0hBVlg0bnJWemZFMWNJdVlob3FlWTVGT3RtcmFJQnNueDli?=
 =?utf-8?B?OTg1RG1HRmIzMXZoZ3oydU43QlN0d2NZdFl3QTFQVm1uVkxpaEl6MXA5M3Ra?=
 =?utf-8?B?R3AyY0I5ZEZLblEzczZPbmp5d2JsdnVEem1Dem1SeTlkK2R6RkF5eVphUVN0?=
 =?utf-8?B?Zjd6d0VUSHJSL2plRnZTckFKYkN3eGtQOWFoeTlqaC9jbHZCSnBaamdVd2ZU?=
 =?utf-8?B?V2RDelMzTU95QWdEeTV1Z1drSVBXWTdsdGM1SWoyTit2Y242SWRIQjU3MnRv?=
 =?utf-8?B?RnJZSk8yOUFqbWpMekR5NDJTTVZXQllWbVNPNEpoU3pscWptcWRhQXNJNGJT?=
 =?utf-8?B?cUNmTkRJNGIzZEhWcHlsUy9aamY3N0RDYTBXRUVGcjF2Ty9SWHluelhvMnFL?=
 =?utf-8?B?b3BWaUN1c1hBWWNpR1RlaTEwUWc5T3A3WThxZ0NCVkF1N3FoZzdWS1Z1Q0d6?=
 =?utf-8?B?d3hCZFppRUc1clUzYnNNejNSQU1QalRPd09ScTh5QjV0TVZYVXBYSERpejZ5?=
 =?utf-8?B?eFd0MzlkWGtFUGpVekFZdjRSNi9CTjZvUFhPeDhCYjJXK3FaQzg1TUh2UzlM?=
 =?utf-8?B?NjlsK1RHNXk1bk5pU2tabHVveWd0VHEwVGJqanQxWVk5NEpMMjE3Zkg4UHd6?=
 =?utf-8?B?MGpwOG1SQUhlODkyRmFnZlprQnM2MFRyTy96eVdtU1dMWTBHclgzSkNLVitZ?=
 =?utf-8?B?azBuS2RTR1JmdzlmUk44VXlrVWMvQVhydTZuSEFLaExJelZ3V1haWEhPL3pF?=
 =?utf-8?B?UDBOZGhqckNoeUlMOEFTSGE3Q0tRMEFTMjZVUXRyNGdpVlFmaS9pbXdSTGdq?=
 =?utf-8?B?dCtsc2tpS1pPTlk5ZWZRUzBFR2JwdXlTcjlmTGRxWE5NUlcwWTRHeDgxK3Nw?=
 =?utf-8?B?SktQRHZ2NWpTQlFFVXNhK1U5ZVhWVGM4UGh0QlljczB4Q1AyQ05seUh2Z3pq?=
 =?utf-8?B?UVdPano2bVgxQnR4SGhSWlV6UGt3RTl0VzUwZ2JJT0RIc2ZlZGdIRVVseElQ?=
 =?utf-8?B?YjNWQWFEeUxlWFBJSVhkbmcvZ3RLYUNnbzlzL2dvNFU5Z29jZFZuVUgrZ1hk?=
 =?utf-8?Q?Gi0FbRsvttAeEUT/aJX83Uw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d16823ae-7dd6-4435-ee21-08dadf946e1d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4093.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 18:36:22.3361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KqrpYw435HakEXbeHRtxAOTHaGYE/lEn5cKSLwwi2WWxFO1XVrNUf3pgist7I7//2pTfvDAYqZrLQz0ZduVHdEPyJAuvc5gWkxzte/qtxVPL9dGE3Jq/WNXhaXfXAqei
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_12,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212160162
X-Proofpoint-ORIG-GUID: RvWSQS8_klH0MUilJnlODdLDUNcqhQ6x
X-Proofpoint-GUID: RvWSQS8_klH0MUilJnlODdLDUNcqhQ6x
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Extending commit aa06e20f1be6 ("x86/ACPI: Don't add CPUs that are not
online capable") to include acpi_parse_x2apic as well. There is a check
for invalid apicid; however, there are BIOS FW with madt version >= 5
support that do not bother setting apic id to an invalid value since they
assume the OS will check the enabled and online capable flags.

Signed-off-by: James Puthukattukaran<james.puthukattukaran@oracle.com>
Reported-by: Benjamin Fuller<ben.fuller@oracle.com>

v2 : use 'enabled' local variable. Also fix checkpatch.pl catches
---
 arch/x86/kernel/acpi/boot.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 907cc98b1938..35d8c8654b42 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -208,7 +208,16 @@ acpi_parse_x2apic(union acpi_subtable_headers *header, const unsigned long end)
 	apic_id = processor->local_apic_id;
 	enabled = processor->lapic_flags & ACPI_MADT_ENABLED;
 
-	/* Ignore invalid ID */
+
+	/* don't register processors that can not be onlined */
+	if (acpi_support_online_capable &&
+	    !enabled &&
+	    !(processor->lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
+		return 0;
+
+	/* for systems older than madt version 5 (does not have
+	 * ACPI_MADT_ONLINE_CAPABLE defined), ignore invalid ID
+	 */
 	if (apic_id == 0xffffffff)
 		return 0;
 
-- 
2.31.1

