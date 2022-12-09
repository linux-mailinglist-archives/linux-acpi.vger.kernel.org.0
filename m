Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457E2647C8E
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Dec 2022 04:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiLIDSs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Dec 2022 22:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiLIDSp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Dec 2022 22:18:45 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F64A4318
        for <linux-acpi@vger.kernel.org>; Thu,  8 Dec 2022 19:18:37 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B8MJEUE029709;
        Fri, 9 Dec 2022 03:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : from : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=kzaL5/Tr0wCFxPt/Osz5PNYDjPM/pZQTzxZEKc3rk+8=;
 b=LQiNpbZ8kIPJXqUhNiGkqzUpC11OoeK3Wg5HPmufi7ntOZ3fDIExWLnHas0+/0+iJZ+T
 B+76PJ+tY53my5mnp17omGfjhRKPf7euJmhIVejPY5EQFe2GWrOrL72HshJQ7DIWtff7
 vB12SUwR+x+IUg/YKPp1JGQ9e7orrKqfGaEl04nsmlLxRNNCg4qMu7pOG3FsOogxm11q
 sftViNsL1SXjjiHqfflpBtBTlA6qDSgWWUqcEBMPG1VZD4u32SEyOXrRiHuxWGSfJspN
 NYV55ifULl28MZdALMaLjIyOhZuHgRdRBZu6rp4xUhbleKKVdcKauoIM+goaKDubFvie FA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mauf8m7yj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 03:18:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B92rdOH032720;
        Fri, 9 Dec 2022 03:18:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa7f8fgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 03:18:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lF541tmzBKvjMFZI/n8R6rFwBxfsm55u2OASIuSpsb9riXATMaPeT/abectp7LKtS3KVZ7zKKST+V4ehMx9I0B7yskb00i15M6kJ2lyNMYyUvbyQ310yONH1xumNxbhdSTTOGgbAdell0xwrT6uAJ+9EBgNl581/RgCNMwKR3y+LK65UYRb6mL3bL+27ZagUvAfamWpVnhYS5ju2tpxmlcRK+XmCqZX03bmxEJZpbcAXI97QAYRcnsTmLX++ctfQ6gsRKWOjRhnGWSk+I4eZRAUDmBg9htO/k9T/wxYdzBnvhwcoPe3+j/8wbLOlnArZfSc8JxpV6YJisnVWnOekSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzaL5/Tr0wCFxPt/Osz5PNYDjPM/pZQTzxZEKc3rk+8=;
 b=cJWlmaOaW0ok7eOOr9n9simVhE8RnYk74ALoAXQl1uj2IUe4BivlLrKRxMBN4TmJGJDxPDhIoK5/n0Rtsee8RrKg5/m/dVOmTdPW8jvG5RuL2T+ZhrmITwoT4jvPfbyJbOrwtKEEEqhW/RU+9fq07qXN5bOVuTFUXKX0qmIc9TX9Vez0tDu+2RD8XaO1qkVPzKUuYPmvVNphk/FoJS2sodjsRX2XWTL6uvFOXvdO7Qchm0I2e6H52Ouc5bH237J3AkSVT5BYcobePW92Dj+hAIgOkEpMnWanyAzHMZQrFMhKOGNsvNAOiI3j01VwfNNdw40HC8pZpzRwSbrerQ1eug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzaL5/Tr0wCFxPt/Osz5PNYDjPM/pZQTzxZEKc3rk+8=;
 b=TwzBfGzlDEYt6nZdoZI3UwXGs9msvPiHKviT9ZQRYs56BhDSHq/HNts4J9gqBWc8qN+r7huSbmML8xeBdUDwU+Xcbr+vDHs8K3CWqIq9N40ba9Ahv/JuLtdkMJmQ0mzMxsGBnhWl7Sx3L1aXQPHYYwruHYGGV2ASDNIvZDaBRUo=
Received: from BN8PR10MB4083.namprd10.prod.outlook.com (2603:10b6:408:b6::13)
 by SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 03:18:29 +0000
Received: from BN8PR10MB4083.namprd10.prod.outlook.com
 ([fe80::cc4f:335:2ca5:7abd]) by BN8PR10MB4083.namprd10.prod.outlook.com
 ([fe80::cc4f:335:2ca5:7abd%6]) with mapi id 15.20.5880.014; Fri, 9 Dec 2022
 03:18:29 +0000
Message-ID: <c9b08eff-88b3-e52b-ae3e-ed44bfb81091@oracle.com>
Date:   Thu, 8 Dec 2022 22:18:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org
From:   James Puthukattukaran <james.puthukattukaran@oracle.com>
Subject: [PATCH] x86/ACPI: Ignore CPUs that are not online capable for x2apic,
 entries as well
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0170.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::25) To BN8PR10MB4083.namprd10.prod.outlook.com
 (2603:10b6:408:b6::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR10MB4083:EE_|SJ0PR10MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: 16f1aea9-5cfc-4216-22f1-08dad9940b42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ei1Xev6KNTK8Z4sUObgQrZHF/zeJ3WIUt2EH+r3B89xL7vTQd5Xn6MdqRcAkkmenAH4nn+ohAnZKPW0+vj6m16D18tKBCUk7AXW4i5F+lkktJb9hvvjQ5oT4smbV0d5N6p6CGP3fXk0CAWqvaUkIj98iyAJRhq5CrDNpzk5whymGfQTw8mFUc5yhBfvHyAfLEHgPJluloUM/5sxxpyPirgxrZlnf+JHr9y3zBrC2bf21OhznQJr680yF4BflFEzk6jEkg62wLz5vRIgqkVGzMng71w6qafjp+AnLVM56ZqzOUblAPVtG9dI4Ai737vq08fNQSVJfy58Q4tznpslXHaQvVZj1vbRCX1JT8MzpuqscljXpFFZVO5tTIIaV1YBCcIFwWOYECoFMvm591MSqbYNsgungH/RA3Pr/QhhxXZR/3sLnRrXyk3FIveBC/kaEnlVRN/6HCvsPQj8Mdda1x5TSHOhDMhjWFTujiuDYy+gwLY4aBUQMM6okNXPnxBC0CK5koTw+RYC62L2U+i1KbgAfK3SX3ONNON19JvgKnHNfrjx7sAPUy5PWmXrloWG+jwG5HRkC7bcVP5WSCEu1aLbg8hVYmckmI/DKK6rvA1aiA22X81xrvor4JMbUrCgu0kSpOi8m+7+sS0Ac2a8fIihWzuUguWnVduWhQK7hrhgw7O04QaAOIf08AipnCNO7d5aQt0feupFJdSRTpjOa+tnL8qiPDgAHcbtVqOocIyQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB4083.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199015)(44832011)(8676002)(38100700002)(36756003)(66476007)(31686004)(6486002)(6916009)(478600001)(31696002)(316002)(4326008)(41300700001)(66556008)(66946007)(6506007)(8936002)(5660300002)(6512007)(86362001)(2906002)(186003)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1NDcGlxT0FnSGFBeHQvU3hiaWtEVDN4SHFOUEllUERNcEpQL2NxNlQ1aHdM?=
 =?utf-8?B?OG9GajcyVkEyYlRyRWVVQ3ZOUHNwVGppZFEvYkx0WldHL2t6a2JxOGlCWHRt?=
 =?utf-8?B?a1pHNGpyYmFEMzhJY3JFeTlYaWJHT1RsTC9MVVhXTHRtSkw5czg1bHdrclJ3?=
 =?utf-8?B?TnNyRTZVK0M4N1A1K25wc2FadnlrTUljRjdza3RISWo3b2hoQVRKbVdHMUIv?=
 =?utf-8?B?UndweDVRNkxGbDhiQmQrWFcrSVY4ZmFEeW9PWi9yeXAxYXFKaytobjU4NGZW?=
 =?utf-8?B?TnZ0bE5LNWVCTTVHNU5FL3VBdzB2U1ZuRjg1ZVpTMFkzOW9tM1VIS2p2K1Ja?=
 =?utf-8?B?VTluMjFPaDYydlFWRldvSDhwYkQ4OWNhTk41QWVzcmFCRXk0UDZDb1hiS3BO?=
 =?utf-8?B?UFRqdUt6VWlPYmhVZnVjWTZ4NTN1dTRWVjhLbjc0NWJtQVBvM3JEN3UvUmNN?=
 =?utf-8?B?RUJWNVcvcnd6cVZvMzFaeHBsT2RZTGRpM3YzVkxuOUo3SEdNUVJKNkx2aTVR?=
 =?utf-8?B?ZEVzTHh0bzQ2YVJ0K1h5anhyWFdoNnF6MjdnSGpWTEU0TEtjNVhTN2RDOXBJ?=
 =?utf-8?B?cnRUbkNWUW90RnhubFB0ZndRWWdrR2JnZ2JNYmZLbXJBMXRVVy9POHZVaGVT?=
 =?utf-8?B?Z2dUTGJoUm9xd3VMek1ON2tMRVN1RzhnbFpjQXBkNlJuM1o3SG5va0NnRjdC?=
 =?utf-8?B?N0VtOUhuWS9pRHk3T0IyNlI4UlMvZTlaV0dHNmJRaWV3K2V4c3lIQ0UwS3VB?=
 =?utf-8?B?SkZjcE1FWGw4NUtpbEZLblFyOEhoeUJKZU1rMm1CcXJjTStCOTUwbHpKRFJ5?=
 =?utf-8?B?Z3YrVC9kdGxVeGNBWXFBc3pYYTIrUjA1YkF1WlgxeXN6eTZoTVM0bHNKYlZ2?=
 =?utf-8?B?MzkyeXJhbk5pQjl6YitwekhMWlExYk15cDFQeWlxT0FBclpBQTZLdTgreUM1?=
 =?utf-8?B?VGRDV0JLeTlTTkQ5RWtJSnN3eUZMSGpnYVNDSEdXeTh4OTRzRWlZV2JLdmt2?=
 =?utf-8?B?MGtQMTBudW1FZmxaVjdndE5VWEEyK1ROWXRQOTNETERLdjN4MlpZWXVQdEdU?=
 =?utf-8?B?bEkxd0FFY05qRnZsNHNFNUw1Qm9YM1pjdFlxZXVGVTh6bjFibVdSQUhaSUNY?=
 =?utf-8?B?NkppN0NqN1NybDEvYW0vUnFUNW5LTjdna1FleHZ6OWlMd2NtU0h3d0Yzb1Iv?=
 =?utf-8?B?OGxUSVR2TTBEY2VqblU2T1QrdEVXdVZGejg1c1FZMUFmb0xYaUl6TTRLaWlv?=
 =?utf-8?B?SzJiRE5BV3VldHpSQnkvNGFaZ0NZS1EyUWIwdDdxNThZQWdXY3ZSMVc2V2d6?=
 =?utf-8?B?UHdBN2hycUkzQURiYy83T2JzU3dva3Zmc0lwYm04d2pUNGlQUmdyQVJWSHZZ?=
 =?utf-8?B?VndjT3ZsRW5NRjFEY0c3cmhDNnJ4TXMzYi83aFhRWitEZ24wb0FESnVwS2tI?=
 =?utf-8?B?NlRIVXovOXVSak56M0NTdXh3NkxscGppOHlXbm5sRkprSFpFWGlDZWtQV05M?=
 =?utf-8?B?eWpSYS83dUcvZWVtMmt5WmpycEFYUUxaNnlFd1NKT2xpcFVjRC8zeS9nd0VS?=
 =?utf-8?B?WkJiY2Zoc2EwNGVXRGJNQ3FEMUdkSmo4NkhMRElWOE4rWnRuN2ovdlJqNk5F?=
 =?utf-8?B?MElndnUxMHNDNUlFaGRVUGZ1bitKQjYwNGMyMFVpZm1CL2J1UjMzN2p0ZjFU?=
 =?utf-8?B?aEVKRlRwOXl1OTNrcHlzR20yVU9OQ0pzQTN2bWVzdEU1UERLOU5xTkU2N3dZ?=
 =?utf-8?B?VXRCaG1hWmtqbUp4UTBMa3lPYnNVeXNuWndpWWdtRjdmQ3BUbDJubnFldTJM?=
 =?utf-8?B?TTJFTnlNSnIzYytlczZKSTRtczd6c3pWbVkwVzZNK01temJPVUhGV1owZ052?=
 =?utf-8?B?ckNZWGNyWDdlUEt3ekNKYjFVMERJWHB0OUpqaGRadlJCaWF6WmpwL2RQU0Np?=
 =?utf-8?B?VUZaLzhZWUlyYmdWQnJlcVl5MkNESFEzSGNwWlVzVGtkeld2OUltSHJ0Qm8w?=
 =?utf-8?B?emM2WmxRa2k2SkhxU1pUUHFkR1A0RVUrMkhUMHcxdHBWYkN0ak5xTVVPYU4z?=
 =?utf-8?B?bVVVZG9Pa1hzczhrN0lZaE5EVWcxRi9XckwyTGVlak1BZFhpZHpOeHQ0eThT?=
 =?utf-8?B?Z2lQRDNxNzNha0pYbFVYSEJOS215QURLcUhvVnVScFNlVm9OV01BcS9raFRD?=
 =?utf-8?B?dDRmMWlUVjFBL0ZUK3AzS2c2SGN4eEtBSXhvUXczOEtYTlhqTjR1eFd5U3h3?=
 =?utf-8?B?NVRuUG96cFBOOThhRVRHZlZPTy9RPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f1aea9-5cfc-4216-22f1-08dad9940b42
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB4083.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 03:18:29.4867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5QIZS/xm5u3BaCXej/m1O/3CaVfVX/xgHKLFgeolYVIw9XKZh9eV87aZuQgn04+MkstsX19G5aADr4tGZCn/BXUHFaAwql5OzPcjyM9Jqn6IhJbXpQNrrrEnYwlpTAXB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5613
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-08_12,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212090026
X-Proofpoint-ORIG-GUID: wWg3URXOdJfUSJ4c5XXWx4Z0cf7CMiWr
X-Proofpoint-GUID: wWg3URXOdJfUSJ4c5XXWx4Z0cf7CMiWr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Extending the patch commit aa06e20f1be628186f0c2dcec09ea0009eb69778 to be
included for acpi_parse_x2apic as well. There is a check for invalid apicid.
However, there are BIOSes with madt verison >= 5 support that do not bother
setting apic id to an invalid value since they assume the OS will check the
enabled and online capable flags.

Signed-off-by: James Puthukattukaran<james.puthukattukaran@oracle.com>
Reported-by: Benjamin Fuller<ben.fuller@oracle.com>
---
 arch/x86/kernel/acpi/boot.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 907cc98b1938..6dc46909bd9a 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -208,7 +208,14 @@ acpi_parse_x2apic(union acpi_subtable_headers *header, const unsigned long end)
 	apic_id = processor->local_apic_id;
 	enabled = processor->lapic_flags & ACPI_MADT_ENABLED;
 
-	/* Ignore invalid ID */
+
+	/* don't register processors that can not be onlined */
+	if (acpi_support_online_capable &&
+	    !(processor->lapic_flags & ACPI_MADT_ENABLED) &&
+	    !(processor->lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
+		return 0;
+
+	/* for systems older than madt version 5, ignore invalid ID */
 	if (apic_id == 0xffffffff)
 		return 0;
 
-- 
2.31.1

