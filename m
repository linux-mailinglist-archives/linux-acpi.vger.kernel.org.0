Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4FC6545F4
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Dec 2022 19:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiLVS0b (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Dec 2022 13:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiLVS0Z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Dec 2022 13:26:25 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C973664E7
        for <linux-acpi@vger.kernel.org>; Thu, 22 Dec 2022 10:26:24 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BMFfOpm004987;
        Thu, 22 Dec 2022 18:26:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : from : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=VWUXcQb2XR0GvnaiEDp1vNePCwJMuL36Var8SQTpM8M=;
 b=H6vC1w72WKinl4D4gd46QwsBu8xBDGcZVyoXsWmxlBz3MvCj9pXVm+svGCcZXVDoe8Ab
 1SW5xyPer9gICs2bB2HXU0ptX4sT7LKt9WUwh8A7/Cai8HjQTfpreSxJ8HCcq5Doie7m
 hEiPYEa4vPJu+IfCqyWQFIYe9om3phzB2mI4cWwnTjuGX9oNv2iYqlN1Se3pjFqLLNGk
 sp8HhjKqxQS/o1T2bwsZkx7+FPoO8FlkuJhnEbSV2ld6AdllRchK3tUKJ9HXETaiCHNv
 dAxfC2WlV+ghRGm0dyFaRLetC18/0ByFfeCFqDNr0+NXqCB0fFmzSuy01/CejRlVtKTy 5g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tpvb2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Dec 2022 18:26:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BMHWMkj003180;
        Thu, 22 Dec 2022 18:26:21 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mh47896ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Dec 2022 18:26:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LESyWJbYfxY2jmFP3NVHjTA9s4CPQatvaC7ECIa1pDZ6/dkN1Ey5qe747WMzw4Qg7PeBsy6cV3G2ACQG5RgopXCy8xVIskSDUgsXUAKv/vFGgqz29CBvWu+h0vINz8iGxfzeJD8UnrZjZ+i3F1Vwjml/SjaTumXa3ywvE9/DvZoI3dadL6SOjdCYtWPEEjVAPgWyvCE6Yoalbn0roBs3Lfk4qlvRoypl8GByiyAl2KL5InSthDlgQh0yaT6Xe5KwGCAYJyENuIkT2+Djus+ifUfRvbQbXKqjelsa5NVRjBzNuXreVY67NaovX6VXX9mONVhqJYUGOLEA5wKg7suQ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWUXcQb2XR0GvnaiEDp1vNePCwJMuL36Var8SQTpM8M=;
 b=V7e5W94y4eHbkCr/3vXfDkGdIAhO3vhlm7XnAGV2e3wtveLWquKQjmW86uU0cAzBt1zAbeftIDQ8bnTf9Mf/3SJgBAENbUR5LRsaw7D/99oNj3glbAXD2kj2282wqnfjKIzTW4XoyVPhBXENtP+EeuruUiAltN+qmmsLw7QxC8F/R4FNTXiIgp23ioiUvxqPEZ6RkVd8FngLYEdNkC1nNlVUfX5yf5jJUSYCfUgH8azZL7h+ZzYuiXcHgdXodp1jeixCZEXYxM1hRz4Q+yc94VLn+B9XFa7jeRX76GjIGRrmFmJuzxzYrmIBUflvIF2xDfkBcfvLMX9Nf5Cyg2HPng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWUXcQb2XR0GvnaiEDp1vNePCwJMuL36Var8SQTpM8M=;
 b=DtZYrG7A8WugclZ2grlYGOCdYV0IGqRzN7Hn2yR8iN1WGXEXbUGY7KHPSF+avML4NBU5f1B1UElSLmV57tA1pjuQJqOvbq+ovr0jeT4/BUELiANiIgHjvLh8RQuPSKESCcXdq1xruCyL42vOErvmEj+4vXogNawcTDW/0MP8lRU=
Received: from MN2PR10MB4093.namprd10.prod.outlook.com (2603:10b6:208:114::25)
 by MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 18:26:19 +0000
Received: from MN2PR10MB4093.namprd10.prod.outlook.com
 ([fe80::26ed:5757:23aa:4288]) by MN2PR10MB4093.namprd10.prod.outlook.com
 ([fe80::26ed:5757:23aa:4288%4]) with mapi id 15.20.5944.006; Thu, 22 Dec 2022
 18:26:19 +0000
Message-ID: <ef8c7138-8ed1-d849-0ed5-e629ddcafd63@oracle.com>
Date:   Thu, 22 Dec 2022 13:26:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org
From:   James Puthukattukaran <james.puthukattukaran@oracle.com>
Subject: [PATCH v3] x86/ACPI: Ignore CPUs that are not online capable for
 x2apic, entries as well
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR11CA0048.namprd11.prod.outlook.com
 (2603:10b6:5:14c::25) To MN2PR10MB4093.namprd10.prod.outlook.com
 (2603:10b6:208:114::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4093:EE_|MW5PR10MB5738:EE_
X-MS-Office365-Filtering-Correlation-Id: 5627f844-239d-48fa-194b-08dae44a04eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ha3bX997Z48XQ+lfsVL9LO2xWKKh339AQiPmg6N1iBdMtNu8vFC1ADH4jiAkPywQUOUUSutGgc6sNsHK6OnEBlp9xLv2B7KPgusJsvtg4rtUjOs7fJuwDxUhjgvAje9k4vXZizxHOZESJRO933WM5SsLEQeM6GqkOsPh7oNSIhVpVzBXlIUZnCa8//kVa6AqYSPICOLXKBeQusJIYqd/mONkDfovUrc9wQ3F260ZPR/8xSwVcubX3jsmgRtGMycLlvMLvBJifBHecio1wMuNEM6AKc65TteuKqWCFUXMlx+tdK0VV2Ryo5faW7pMgLGCqQZR7Bye1EGz1u9Sp0hzQ3L+G8yK9URwHpbOA7EWLJMeLDURU7nvmWLxvcCmz0TIMWoy79rhDCv9eBsKBUlnOdn5LybcUJ/oUvro2TnZ5ZSjT3anchIv6AbohrvBrsXsoQRda86GSqmNUs9C6x2rmaHGRSDC8556I02nZ9/VFC6Wm1WY9jN/EpaCVdcdELfR5wq7Mk8rHE2j9mXn+/YfD4tmYMot0mete6fIV5qOlsXPdhmxccNUWozHNZ1pl5jr0LGna+5adOE7Jeznx7tBAcfJHIHnprJrWFLIrDfy/XuwKmcBtQWzSNHOxYtJR9fJBE8nMDaL8dOwc2rW9cx2yHqzxRYySR/+v1WUcIZggkGWfT4mEvpxSmr91oU+DML2qQ+JAr0QjRtO6vupQ+2c29yPznuCEjG3Gy86IdU8Rgk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4093.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199015)(6506007)(66476007)(6916009)(6486002)(478600001)(66556008)(316002)(4326008)(8676002)(6512007)(66946007)(2616005)(186003)(8936002)(31686004)(2906002)(44832011)(83380400001)(41300700001)(38100700002)(36756003)(5660300002)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHh1YTNvTXdqNWpualFiU0V1a2EwaGhNTFdwZnZURFlOcVFCdS9qYml2elEv?=
 =?utf-8?B?Z3JRdUxmTGV5N2FkU0RVNi8waEk5QlJRcUxyUXVGSTdrUURvS2V2Qi9PbFZH?=
 =?utf-8?B?aTZpVXNKY3VXQnBZaXlvQWNMQkNGTGxieVJ5OUtqOFBvejJmWGg2MUdsczIy?=
 =?utf-8?B?SWx0YzduREVFSnFaenBlK3JrdnArbWhxOGVsaUVKNFhZUHNHeGRsTnBwR0lW?=
 =?utf-8?B?dlVHR1M5N1ppSXZOMm1hWWxxdUhkazl3SlJnOW9Gc3VaalprWmFacTNqbmNn?=
 =?utf-8?B?eEplSnFGQWJFTThWU2Q3eEhoaUhxM2crTjNBSG1NVmdLWDRXTDZQMDExUFdV?=
 =?utf-8?B?RkprK0xoL0o3T2hSZHl3M05zeU1kTHBDd083bWtBVlpyL2d6N3RDSTRIMkYv?=
 =?utf-8?B?bHJpVkFBemZXQWQrdlVFZzZkSnJrcG0xb0FqVGlxR3dDTDhJeXJEQ21pUDJj?=
 =?utf-8?B?WXQwOGxjQUFFVll1SEJFRW1nK2l2a1ZuTlNyODJtdFlQdUwyVUFneVdNdDk4?=
 =?utf-8?B?MWJyOTdudWExVHBBcVdrYThJU0RkeEx2TCtic2NZUmxSd2oxMlV3SHo2US9h?=
 =?utf-8?B?WDV3bzJCUjNwNFl1Y0xWbUVqWkRsL2tqZ01MQjkwaVV5S0JEeDhBSzFWVnBQ?=
 =?utf-8?B?WEFwUzBRb0R5NHAyV0JlYjdDcTJyTXRrT3J2UXlRVlp1N0lncStOanBXSHU1?=
 =?utf-8?B?dzRQcFFVRzNuVWo2ZzVJZWxYR1pub0pXaGJKVlFGbWRTbk9UWDk5WlVwckk0?=
 =?utf-8?B?Vy9nNmd0K1VDTzZEZGRFTm9zYW9lWlN2UFdURTFTSmpIa3FDMUw2TThjWUlP?=
 =?utf-8?B?VG5yQnJGcDcwSm5OblhqVGFxVlZqT1ZWQno2RWIvcTlPWnVTUFVPSW1mSXlh?=
 =?utf-8?B?OFI1UkdXT0VTZTN3Vkhuc21IMnNpNVFseFV6SjJRcjd0eEREYmJ6Tmx0OEEv?=
 =?utf-8?B?QkZWSE5RMjJEQ2hPV3l3RG5MckxxVHY5dnpvV2puRUFyWXdkZXVlQldHcW1F?=
 =?utf-8?B?Tzc3VERHbkxRTm5OL2Y3bHpwemVZTmlIdDRHZEFkc1VmV3htOWY1WEdiREJa?=
 =?utf-8?B?MHc4NGl3b01TN1V1bzRvZ0lyNmpkWng2ck92RDhxbndHVHlZWHZvQ0EwemRZ?=
 =?utf-8?B?TWJBWEthb1VITTFFaU5RM0I2NllqU0h2MDR1S0hzRGU1ZWxrUTFqZGFHQUhh?=
 =?utf-8?B?K3VWV1pkbHVsYXg4UnlYdHNvbWhHOUtmY1ByTkp4SFdoNFVxNVc3NUFIdmNm?=
 =?utf-8?B?TlljNlhEZFQ3b0l2T3Jkb1dtVjB0QkxLUHdQTFBwM2hvTSs3cmVnbkdKbmxl?=
 =?utf-8?B?L3ZKNzVpS3RyVnRLM3lDM0RMQjZ5QTNKQ3hSM0pLS0lKOEFxVXV3QlEyb3pO?=
 =?utf-8?B?OG43Q1UyYWNFTCswakRvbG5JdGMyUk5TTHBRcC9jODRhYkZsOGFxUEFUN0hl?=
 =?utf-8?B?REhMWjdpQ3lxdlcrZDFjelN5OVYwd1FoNHpYNVhjTlRKS1QrWTQrNkUrSnd1?=
 =?utf-8?B?eTZ3cUVpUk9WQzNobWdKZHF6ZUZ6UjJSeHZIT2R0VVNvbURtb0Njc0FKQmRW?=
 =?utf-8?B?cTMzNmcyVWNONkt1TG9RWFFQNUhIL3dtMUJsQnVHTC9QVXVWYU9TVXp6b0V6?=
 =?utf-8?B?R1dYRXF3UXBvNnpvejJhVitBV2wxVzFBTzU2enRtSjZUZ2FuZWdIbWVEWTIv?=
 =?utf-8?B?QXZUQll5dnV3VE5OdFQ5MjJoaldnUjdCZEVUc2UxMVhESFZwVFpRSC91Y2ow?=
 =?utf-8?B?UExqUzVDL3pRNkd4YlZRM0VtbzJCalR2cE9YREp4V2NmWFB3Uzh4VHFTblZN?=
 =?utf-8?B?c2UzVVNMS1FNNWZtWEViTEx6ckYxb3FaU3NMWUFsQy9jdFFNb2JUREN0aVg4?=
 =?utf-8?B?OXFXUG5US21DcTNmSU5xRzlVQUgxWkxCZURrdm03cXZCaG5rYjQzajRzL1Bp?=
 =?utf-8?B?VUU3SFltUUJsTWU5enRmQ1hId3ZySVVBaGJnbXFybXNiOEI0QkhEM3pScTFp?=
 =?utf-8?B?cnJZYXJnQzdyTDQ1azJOZVZvUS96czhNUzgrNTdKREJhTllqSEZmZTNzRUp3?=
 =?utf-8?B?SVJ2em1NbGRTZnA1djZGNnI1cG5qM1dLK1hsQlhLY2hodkZFdk15L2ZOZHlx?=
 =?utf-8?B?dUF4TTBhMmhycnhucEFRMUhDRzNGNGg2Y3h1YUJTMy9sSXA3Z1cyaFpQMC9q?=
 =?utf-8?Q?WaLBojmMJtUZh5xhsfQ12MUoNfaGubFN8dPZthkiDsr0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5627f844-239d-48fa-194b-08dae44a04eb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4093.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 18:26:18.9294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBbzAkMRz+1FTvlvXGMxWlJ1F8WNeXBonqyzNHkGvwlY+H2hF/J5VqN3qd++s3sYxhnHA/R+eQw/9T/wFZyg+KMmE9mfGR6zAbtozZyQqQ4UlzkUvhJnnsLaWh1CIt7O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5738
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-22_10,2022-12-22_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 adultscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212220157
X-Proofpoint-ORIG-GUID: rsOeSfKwm6n2_sksl-G5IorH8VKeEyI6
X-Proofpoint-GUID: rsOeSfKwm6n2_sksl-G5IorH8VKeEyI6
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
v3 : updates as per Rafael's comments
---
 arch/x86/kernel/acpi/boot.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 907cc98b1938..cf2509f9de31 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -208,7 +208,15 @@ acpi_parse_x2apic(union acpi_subtable_headers *header, const unsigned long end)
 	apic_id = processor->local_apic_id;
 	enabled = processor->lapic_flags & ACPI_MADT_ENABLED;
 
-	/* Ignore invalid ID */
+	/* don't register processors that can not be onlined */
+	if (!enabled && acpi_support_online_capable &&
+	    !(processor->lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
+		return 0;
+
+	/*
+	 * for systems older than madt version 5 (does not have
+	 * ACPI_MADT_ONLINE_CAPABLE defined); ignore invalid ID
+	 */
 	if (apic_id == 0xffffffff)
 		return 0;
 
-- 
2.31.1

