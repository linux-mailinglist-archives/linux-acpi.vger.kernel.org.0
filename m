Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43209664EEC
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jan 2023 23:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbjAJWo3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Jan 2023 17:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbjAJWoR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Jan 2023 17:44:17 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0155F4B2
        for <linux-acpi@vger.kernel.org>; Tue, 10 Jan 2023 14:44:16 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AL3cnH011294;
        Tue, 10 Jan 2023 22:43:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=z1eMwgKzZYWg+gIKyfW2ZqeC1Se4I59i+EF83gvKQDU=;
 b=bVjXorBdCXc+q1u9O8gu2JNkRH8lSfYP2oJR4Eo1JEVPbKm6ymyZ4kJBbEEukxVDRAU5
 sJmDSiBp/euxpL8x/JmM+UWQtTvjMBUfiyFr+eAZFfE6u/BDl0wWAYrq3d67qC8TTOL7
 HHt0Ryg7NpPBRyriEAobGZqvLYdFBeS1tRGnkhKxK1KrWzif9vd/5MkzZIKnvL/LiLD2
 91ppbjIAYuai2amV3k3yMB7XxZh3G+z3U34eQFH9OWk1mCOlntCAeTWxARIzQH1tGqUC
 BcdJYwETXj/InzTqSKg8uej4T3KjsFW8iOg7zptSmxmwaiL4mr4bItJOEp6IJKEXJrdx Ng== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n1fe587t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 22:43:54 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30AM3tpR031773;
        Tue, 10 Jan 2023 22:43:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1gfysbm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 22:43:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=np4H1tPJayw4Jp237kmBUiGdgAECor2Hgf/eEsvUwSOq6vVWswfN4CrWCxcejBMDczRmy3kNMGJSxpI1vQifTM15bIf37TKQcfXYVNSIcdLj1B9FQEuo0dflQ4vobBg8QIB2JBQSo2cM+N39l6HU42HI2Mvrqdrp95aFrDCxCWoWPSexatoubNB/m4WfBqe0aOQ5a7s0Uh8LSU/1Q0DqF3bXFqZPo0GRDMP/k0QOUt+RV8rukQmP4DOoPdBjCbm1kVlQMClvnmPZmnwxKu6wPUedSOJ9yw2bdFphaYaM5PSxiU3Q3pDiULS+Hu2MEHh6ckRYCHm85h6cWnFvJPCF5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1eMwgKzZYWg+gIKyfW2ZqeC1Se4I59i+EF83gvKQDU=;
 b=PvN2rOpG0Fj4Pva+Bmj8hoRXBGbiaRZ3ybJPl3Ed9Nzl5Lcalh7g5uRTLtaLqxaI8TKRxgquKhugsAfYfVYoGCA3fQbKeAf5OP75swezX5b/nuofFc9doywo/DeO1+RgPbbThzTjVeWNTLC3qcvkLyWLwAiltdrjJ34JcdTTNW4JohkQKQcbUCPY8NmXr7Je3d/Z8kDVb3ea0BfLEeooaTN2XtBVFKVqZyYQ+ALuti5OcW+JJHVGTTyrwSgPndSa7MTeGr8rcj3P2Nc64KGAJ63UHcmJqh5HtGrWKUAbxjW3Z4szYwRS5WifM9IWk+OWdzxn6vYjxGaG54VAwqNywg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1eMwgKzZYWg+gIKyfW2ZqeC1Se4I59i+EF83gvKQDU=;
 b=aRXVlIrweGSLgnJk6YSWIDdVDPNWeBhtp75bY7QexPHY1vtIi9C5RQGnGxjyVaLtBFLLQnNprxa0rDv82YSo9kwccCV2VCjuSDoAr2V976nYssMn2iwQgeT4vVf3B/f+TIH3KdApx0ocssKyQAdaBm5nkkB/OguYsXGDe8aJsYs=
Received: from MN2PR10MB4093.namprd10.prod.outlook.com (2603:10b6:208:114::25)
 by DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 10 Jan
 2023 22:43:46 +0000
Received: from MN2PR10MB4093.namprd10.prod.outlook.com
 ([fe80::26ed:5757:23aa:4288]) by MN2PR10MB4093.namprd10.prod.outlook.com
 ([fe80::26ed:5757:23aa:4288%4]) with mapi id 15.20.6002.011; Tue, 10 Jan 2023
 22:43:45 +0000
Message-ID: <1987c2d2-1246-b172-985f-360e5c2c437a@oracle.com>
Date:   Tue, 10 Jan 2023 17:43:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   James Puthukattukaran <james.puthukattukaran@oracle.com>
Subject: Re: [PATCH v3] x86/ACPI: Ignore CPUs that are not online capable for
 x2apic, entries as well
To:     linux-acpi@vger.kernel.org, x86@kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, mingo@redhat.com,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com
References: <ef8c7138-8ed1-d849-0ed5-e629ddcafd63@oracle.com>
Content-Language: en-US
In-Reply-To: <ef8c7138-8ed1-d849-0ed5-e629ddcafd63@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0233.namprd04.prod.outlook.com
 (2603:10b6:806:127::28) To MN2PR10MB4093.namprd10.prod.outlook.com
 (2603:10b6:208:114::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4093:EE_|DM6PR10MB4363:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c3507a-723d-40b5-52a7-08daf35c21a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rPli4UWnLR6YK99biR6arCo772P4Led4L8OreHEGV0bC96e9Exu8zOerY0dF+VH+N4PQz2EvU0w5nq47zCEwfpgGJQsjcHo750BrgxMKetf79usv4MtmLKeIu/6NTsyUlNxhoGhHShrGh1cAzIND8T8xbKB6RFW5i8S7bAup1Cd9tVxtGSEJ75MaR8dbAFPW23FlaerYzKjlbAQ/6s7vtzo6iUFaDjYARztzq/AxL5Jd80mJb7sKAn4kRx8XP6P0bwjElOeKN1wE881oR95CukX6BZTV55n5diy3AIwkqgy2DT2q6GTjDvUmAVGkLZPMP7r5wvc6sNL4VOf2JQaqzfhw7fciJkUSK59QbsnR9M8QTxxM4EdDgO1sISMdoylqEWIP4rVFkHVOZTFeQPq1NWQjMYOXhJiykUG8Zmva4PeyGTyp1Twv7S86Rr7iIo7/ZM3+iMMQIr/xAFyBepAI8KyBlkayc3bqbRzKPk2wR8oTWUWKm7Tky64O1xZ2ZO2dx1qwDPCnuv0p5/OLMDrO7cdDHKVpp6zwnh/anvVdtE+ClccevKurNQ7eYmMnlW3Y5gEMEcXiP6zam/aMg4iA2R0GZ3MwdHZBrd2bjuEN4yeh3POCYXuUgynEuiQsBXlbA0Zc52Aak/OF/6gyfMDJ4AMcxLY/UeOcRF8djlDLe7vYx7MtKdvQVg8WRSqjgsSJ13kFxX54WGW2KTZa9TvphH23aieAMJSd+7hJjTZOE7k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4093.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199015)(83380400001)(31696002)(86362001)(38100700002)(2906002)(8936002)(41300700001)(44832011)(5660300002)(6506007)(478600001)(53546011)(6512007)(186003)(316002)(4326008)(66476007)(8676002)(66556008)(2616005)(6666004)(66946007)(6486002)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm1Od3NDZ1M5cWh4NklRd1FHQU9CYjI4bXNJcnhrdXdhVG1jUU1rcXRkcDZT?=
 =?utf-8?B?TytDTjg2aFVvQlFaSVVOcEg0RWxDYkRXUzkrckdNaE9zMlNGWDV2WDNhZ3BC?=
 =?utf-8?B?dlN3SWp0a3hSdUd6Ui9wZmZJc3FXWWduVXpucWhFM3pFbWp4R1NRUGRVOWtv?=
 =?utf-8?B?cDE2M2pzc1BVdjgxajlJRnlGUC9OczhoQi8yT3RQSk1iU2NPQXNodXVhRkFL?=
 =?utf-8?B?L1B5d1hPMnA3aDN5MlI1WWd0NVdrOVZEaHJmNFhldDNrcmFydkQwVVR2TjN2?=
 =?utf-8?B?VTYvSHpLNGpka3FGeEkzZ1RmZHlhRzdmVTVNb1NLSlNLTHdMQXBxRDNwaGtm?=
 =?utf-8?B?K1pEVTZmQzg4VGU0OC8rekVnUEUzcDF2T2M1bGtEdWNmWElSL0hQd3hlellN?=
 =?utf-8?B?TFZqZ08wL3ZDem5ENWdJWGVmYU5WeHd2a0cvK0VPZUU5Ky9TL0M4cm53UGZ5?=
 =?utf-8?B?NXBodnc4cy9QQ0h5ckV5T1o1eldsaHVXdUhqb1BjdTR3UEVhM2g3SUxsRGJQ?=
 =?utf-8?B?NWllajNUNUp6ZjdzR2RDNUY4bVhnL2ZVRitTTXloZXp3T3R0eXcrTDc0d3hi?=
 =?utf-8?B?bGhrcDVPamFzT2lIdU1qUGM3U24vc2QydlRVdUpxMnVzeVpQKzY2TGdITjFi?=
 =?utf-8?B?OEZSd2dEL21oTXZNNlp4blhIaXV0Z1F4Wm9DSUVHem16SE93WHR4VkJMSjRD?=
 =?utf-8?B?aHQ1WElBdjZsSWlhdEdEdnRxSVpwVU1VemhOeTIwVE9OVkwyYmFacHlueHQ3?=
 =?utf-8?B?cDdtVk9UbFhYc1lpSE43Yk1aNlM3cWErcFA3M0ptN0svNHhPV3VJQVRPR0tj?=
 =?utf-8?B?UG5pQnU3MlhkdnphMW81Vlp4djhFaGdCeGlZSjNoY3hobU1hRGlFTXJMSjZ6?=
 =?utf-8?B?eGYzSzZmUGZGbmRBSGpjY2FhdEVkMWpFSkFZWkdwd21mTGtSMlpWSSs5YkJ4?=
 =?utf-8?B?VS9iTXN4bjhLV3RzT05SUHNGcFFpTXdBTFZvQlcvYU5DYmZrVmZobVJEaGoy?=
 =?utf-8?B?NUkreU1ubmxMdXRRdEpzK3M5NW5tSE9oZVArQ1Z3QW9ndVo4bytia0J0VUp4?=
 =?utf-8?B?WG4zaHFUTGhjekJsYlNFWWQ0anhuTTkvNzZoUWJVWmdmOUl1Z0RMTzl5MGc1?=
 =?utf-8?B?S29EY3poNHpKaE82WmtlQnAxVkJQRVVLTGxYR1UrQWsyb09haTNrSGZNM3BM?=
 =?utf-8?B?eDV2SWRDT0dyaHUrTUsrWkFDS1ByWkt3cnVlK012Ym1FaGw5emcyamRMblpJ?=
 =?utf-8?B?ZUt6YS9Pb1ZVN0xrL2YwMmI1L1ZobGNsbGIrS1BZRk5ZdEo2TXhXQ1V2SWVM?=
 =?utf-8?B?UFZFNXkwUks5b1Z6K2s0K0N4MHlpdkpqQmt6SjNTTWI2c2FOOS83V2NzOGJG?=
 =?utf-8?B?MFpva0tFT01QOENPMjdybmE1ZnM5N2ZaQmJSQVhmS2xoa3lXbkhsWWZrVkJz?=
 =?utf-8?B?b21udzhuOHcwNytRRXMwNWlTLzhVSmtjSEE0alFaK2tEaVhMd2JsL0ZweGNG?=
 =?utf-8?B?TURwT3RDTWlUS3YvMTJoSHdCdXRxMkYyeTZnV2xXcHgwMU45QXMxNE94WWxV?=
 =?utf-8?B?UmJiVEVRYktyV1cwOHBVNjU2RVlvUDRMNEdLZjJSNTFxOVNCN05mMU1kbG9X?=
 =?utf-8?B?cUdrZ1UyU3haL0N2a3pJV1BzVGlvMTZubXhBdXhGTG1aVUdZUExJK3ptOUpR?=
 =?utf-8?B?OElGQlVxaGdWL2g0QzFFa3dublpLWVNzTXZkNEtSTG5rR2wvUDlIUDIrWnlx?=
 =?utf-8?B?ajNiT0tjQXdONXlUWis4cTNMOXg0TElXeVo0VUtSbjdMZVJCbk9ua003bytB?=
 =?utf-8?B?eEdCZStZNVJwc0N1N0g5YWlYT2ZlemVvc083WnpFVXNPSU1iTW5xTnQvQUlZ?=
 =?utf-8?B?YTBDd0tJWlJrOS92eTI4cU1JeEtjRWRmMmJwSExXRG52c1F2N2k2MWhiTFZX?=
 =?utf-8?B?UjJvUjdlcEJ4WjBpK3V4S1ZaUklPaWdiSndLTkNWUmJCWHVRbnBQZU9hVk5l?=
 =?utf-8?B?OGRTaitoM2J2b250cm54TXJncnUyd2lEdnFhZUViQWVoek5HdElNcmVadlRp?=
 =?utf-8?B?eUxTSnpYbjBHNzlTVllJYk9Ianc3MTZsbUEwTHdOcDNqcUI1OGhjNS85bHRW?=
 =?utf-8?B?TFhTdWVtVXZhdWQyeDc1bjl1cnA3ZXUzQXNhSUlwV2swSmtSWU5pb01LeTVs?=
 =?utf-8?B?VVNwQmhBeDNiVE1FQW84RHFhY3ZDbDhiaDgzMU12bGlzNWlJTWJzdnF0WXJQ?=
 =?utf-8?B?d2c0RzdCYnJ6UGphd3lYUGRpYVR3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qDW+g6rbzQYiX4VOuCJJCxRjHEHK6iPhfZqo/XppG7Jsw1eF3JquPIw16C0MsH9L4uuFozv7rMysNB9rIzIfpP021pf+mdUGDYBewcwcnzZqKwsFa9hzfgrOggVjeW6HzFPaoiiso/0cFR9lt+tw0j935gj0v/dfn4pf4n3vTa+D+fZV0sdSGbYYf1OCPWXeShXJUyHNpSGllNIjRL43V5SKPrI0hGkX6w+h2gYxzSSCeDzYsm0EhBuOfTO2CKo5bJQMTAE4E2XXzN6YeKR/Jg/8GwUJsFQpnbRkWenyYJpT/VqJALv9ko+ZXw+tfiqJUj1218Jfo32K+v33n6NIzPPHd0rGPzk4ZgehpPLzU1i/NelrDxFLdv96DiYC3XVQp6L+jUvDPxdHmzYDIMt+jBSv73yFc0LtVh1aB5xlkoGsxjWNURbF9cU61Cp1FRexjZUiR65lja/GPMg2tvIEtod9/J0jH/hYMFe94XCsaKbLIRfZfKHFtePhReFaWR4DzmdOAHY36OVedSXyxmaBAcChJvHHupYtjUU3oheBbp6kwqOAPRcGvJ218PtvX2KIt1ZOXcfXG1ynCerlllAQzA9GhA9il1GxFTXhQYp4g7OSuRmuoseaT/rD1RyIj+GZezp0Gr7fOhw5+Wes4i2D7D6IErbsmG25gdNh2AcWS5uxOVpgO0mpWNquvKpGA9/QjFcp0RQ0OYwgkEAZXnIo9Jo91IGoM93yTEF3cQYzgVHEkWaG4nZkWX3dCSVy9e0Rp5itwMj7uJcykGsosCw0BiCiIELDkpVKBGyQhcT1c6gqCNUQb1fjnosaKWt/cF+aTVWRMZI32sOczGv43nUu8UOwWHdXdkA8ggyx1yVbCzsk80N9TpnQDJNqNiNqivTsaWho2H6Xr9Mn+k7ndCQPBytRtzMkzwAuePDq5KDntnE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c3507a-723d-40b5-52a7-08daf35c21a2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4093.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 22:43:45.7704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FkmI1UgyjWYrBuOQ5SB3R40r1W7RAOfQhnpehFRoSU1q4n4MIQ6C0S4uP6YeE+u87XoHcrMEL/aw9l6Zgax3N8aXvGSx/ok55Rdea1bSvsRaQZUXZhb8v5mmqRgSxvBv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4363
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_09,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100151
X-Proofpoint-GUID: xwgN6TOB1NJwtS2qutppiZIe-dOXp42D
X-Proofpoint-ORIG-GUID: xwgN6TOB1NJwtS2qutppiZIe-dOXp42D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Adding others that I missed on my first email. 

James

On 12/22/22 13:26, James Puthukattukaran wrote:
> Extending commit aa06e20f1be6 ("x86/ACPI: Don't add CPUs that are not
> online capable") to include acpi_parse_x2apic as well. There is a check
> for invalid apicid; however, there are BIOS FW with madt version >= 5
> support that do not bother setting apic id to an invalid value since they
> assume the OS will check the enabled and online capable flags.
> 
> Signed-off-by: James Puthukattukaran<james.puthukattukaran@oracle.com>
> Reported-by: Benjamin Fuller<ben.fuller@oracle.com>
> 
> v2 : use 'enabled' local variable. Also fix checkpatch.pl catches
> v3 : updates as per Rafael's comments
> ---
>  arch/x86/kernel/acpi/boot.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 907cc98b1938..cf2509f9de31 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -208,7 +208,15 @@ acpi_parse_x2apic(union acpi_subtable_headers *header, const unsigned long end)
>  	apic_id = processor->local_apic_id;
>  	enabled = processor->lapic_flags & ACPI_MADT_ENABLED;
>  
> -	/* Ignore invalid ID */
> +	/* don't register processors that can not be onlined */
> +	if (!enabled && acpi_support_online_capable &&
> +	    !(processor->lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
> +		return 0;
> +
> +	/*
> +	 * for systems older than madt version 5 (does not have
> +	 * ACPI_MADT_ONLINE_CAPABLE defined); ignore invalid ID
> +	 */
>  	if (apic_id == 0xffffffff)
>  		return 0;
>  
