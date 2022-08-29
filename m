Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941CA5A4556
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Aug 2022 10:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiH2Il0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Aug 2022 04:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiH2IlY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Aug 2022 04:41:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D4C44540
        for <linux-acpi@vger.kernel.org>; Mon, 29 Aug 2022 01:41:23 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27T7Ts1H023539;
        Mon, 29 Aug 2022 08:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=ZgYA+jEGfaRrjp2WISYMm7zCAsgal4U0TK1xS7ETZLM=;
 b=WSfClcVX7c69ueZIAihpv1ODcrnx1yeVARnsUTFTz6NFvupLfYvqyZkUpFbocLLM9VBm
 4816UYHUyTjWk1cyC1uuHFAel8b15gvnRhy2ad+1ASjH5aWdBboUCN0RqOLL/i4QjqdV
 hFuBAcVZRw/AmA7/d8+TdxfzXNqEIaN0ujFOHt9jLhNdWwvyeaNojYvDbX/n17ZZYHw7
 LF33heqLxTAvdpeb8wQkQPRxhZ4FlX3kdjg7oFxiKBr6JzQjVZVvajGmBFqygTETbj//
 qpkYdkcUBvtMFlkvwRJ+31TYLsmK1no6Wbt5yz7whMUKD4HrwOH/PH39C9l8yoaQTD0L oQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79v0jrgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 08:41:22 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27T8PNEZ033518;
        Mon, 29 Aug 2022 08:41:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q200w0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 08:41:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOTDgPgBEmsDvFhbrN4WTKB2cjox6VD/ci3Op4ledP+tfZkGBi1lxBzkYhoJLMg446xnshqSaYo00SJBhCeo9bYPY9A/dwNnys0zSMedJ8hxuKWhAUq4rSvJ4bcMtdjBDvSiP64pNE8QS3t/vbSceins2Dmj7+xZqJX0r2HXj9xM3aEE9vFCmJkRKXlPOG2P+pgIbuVLrhseZdjDOpibIy4uQ5sFzNroXaxkfSor/DzVw2x1299CFxp1ZYKLnpyhrv+T7Rgu9eVLMP9Myz007LHnqGs1+Zs6Z+GwZ1DwzvhFWbrX2BfLIWE4KE+VehsPTmdKQzVyc7ZuVNyKix6/MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgYA+jEGfaRrjp2WISYMm7zCAsgal4U0TK1xS7ETZLM=;
 b=jRS7XtJvBDGUoSaThjBukl+IfOpvAcdtF4pyF50M96Ll9tukBDwm9HbrE+JTM1643NkS3d+5561VIaybRoUP2I6JTUCVm8Q0W8nAy3DQpo7OzRAPSS1QioqVMYPg8CooQA2SbGzF3qvbmepr+MHThPT/lt9fpzgX/6ETtE8x4z8wxnqfUnB5hDdYwNQB+6XLMIB33HpL6GaREbgtO1zZDqDsq1N/HLogKYiBK2OLLn49vm/BMHnldRtdkX8Pw3gKbFBk6/66hRHtjf0gZc3B1zkvBwnik/TIaH0Bfk+PI4XPU01ua0EsLsT5Yy/wiCrcxepebqsyK5k5Vt/blO6TTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgYA+jEGfaRrjp2WISYMm7zCAsgal4U0TK1xS7ETZLM=;
 b=Vbe2WEh7r69nfDe6BBBPIqkNEeOSptabowHrEdqCwe9bc8NMuj3Z6cfszZXdVZA4bFosWvKmLd2/Rr6AKzoXlUCwUrToV5Pa46Y5Oed3ZTYIOVgFV39yD0e6B+I237j1yZPQRNE+Y7Ehxu53AhEOzhrHD4WPWiDTfA8wqlnIxn4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB4962.namprd10.prod.outlook.com
 (2603:10b6:208:327::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 08:41:18 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 08:41:18 +0000
Date:   Mon, 29 Aug 2022 11:41:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     rafael.j.wysocki@intel.com
Cc:     linux-acpi@vger.kernel.org
Subject: [bug report] ACPI: Drop parent field from struct acpi_device
Message-ID: <Ywx7pdtirM9DWMps@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::27) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43235365-a759-492f-ba3d-08da899a3dfe
X-MS-TrafficTypeDiagnostic: BLAPR10MB4962:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xwKQ8LqksyhNhDP51ti9TKac1l6QcfeyfLKBj/eF+kCzq8n0/XT+NjJSRO26p5R1VDP/8AX4KK+PVddlW0gVWsbDA5+KXJQNTCRWsRW5SSYh+lZTU0m/0/D7raxpTHYxchcASc4jNm7+AKOv67AITVwSb3YvIo9WfXkUG1moqkeX7QU2CVA/VRhN8Y14Q/BXFCYRh+9uoNG4GlMGKbjc5w1Y6TzUPXFLmcT3E6ib0Gpr8+Mr34JWzHgoJbu0/OS4M565pwrsA9V5j8IOSErYnYqsOWcGMtFhy3wdXeNwVPM5zMFaeX0A1i6ck3amxuqeH/zgWF3CmHumOVRUjZ8TltPkLcyYm4N0IKlI7lMUTeaI+1wbr2H5n8k4+09kWRI1VSoT9RTN2GFl8C2Nk/bpeYwc4aTNUDQwMBUQfyCitM18A0skJqlVn7utAroUBzUuSodRROZXpi9nLuOZh4+JxTZfDbJ76QCni+hTk7XIQ2dE6UJdXwMdyXm7BhVwBBsXztercOd/PbOFylDoAAcIf8PgqyEU8hToKxNrb1tylwv7tTgboZFPwmAMY8z4/JH63EgzvaACiW5ensMe3mND/jwiEttMVnk9h9FT7chUL/sRXyWqjN4GJ1S4TPiSdflCStvKf1zU9R2+m1h7yb/Vk/lT6ul1qgdQ+hgDgjd4D8NQv4zgCjPce5f8YlYBFQBRTRq6WnJ0bW/DT/eXCoxpZJaN0wqBFhSrxedlooQwZvIYTInGttMOTABE2la8WsikUvhzaukuSZiw7y7jhbrDiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(366004)(136003)(376002)(39860400002)(396003)(6512007)(9686003)(26005)(6916009)(316002)(38100700002)(38350700002)(6506007)(8676002)(6486002)(8936002)(6666004)(66946007)(66556008)(44832011)(41300700001)(2906002)(4744005)(52116002)(33716001)(186003)(66476007)(4326008)(478600001)(86362001)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jsDs/LKlp9MkBOrc14TPDMGQh/vrL+mHbw50n6PGnC74LatuqPWlfrHYm1pv?=
 =?us-ascii?Q?V3BGSPBGz17XmG2OHzIyVNkvTEIB1ssx/CQA2PuJJpuCFNotjRYTFbIG0qya?=
 =?us-ascii?Q?t01R4AjQDVK1NnLiBckhsaPTm5lX9QnXITs2JTbIMxfGEa3xeEc44F06NgM9?=
 =?us-ascii?Q?egMvk7PqX7DCJMAT1Ar4ATOrbiG6bGc640+1K9jbyQ78v95Hbi0+xNOWPiDG?=
 =?us-ascii?Q?CPLcLRx2C5dNKgND/S3C7iTOVemFs6/vMQbleqcOu7MPhvwEd9Kr5jfu7yqj?=
 =?us-ascii?Q?5ZvByY0Qf5t0qZ5WmfBEiu8aZJOIPDakwSBpuBQK6uH6bd3CnlHTw1ramYo+?=
 =?us-ascii?Q?qoy1TkYhWpl1zkQVfO4Em5byib6RATUZBSuvaZwNAyeGSc0f+0vaOz+LN8Ds?=
 =?us-ascii?Q?D2Vx6SM+K8ht9pGgLVw2d/xNph5GPCw0LNBVX1LJQ0v1ZeGtEzqto+MC6yeB?=
 =?us-ascii?Q?pC1OL4SR0wkMrxTz8Zci1RwblblQIHRWGvzK5QhADJYrKGFb+5mQCvJQ274B?=
 =?us-ascii?Q?3Nt0smDw0ptQ5k8b30Qw5FPIpba9EoSCbIZ93MXJYnieOvsZwEZ6vWFb1SsP?=
 =?us-ascii?Q?fy95Wk2XDv3gqsajQwJG6mb8Dc90hFyPkYawh8EiV8lv5AAstMs778/YVgIe?=
 =?us-ascii?Q?Zezg6vfK+C6KZGupVHRJHR4vgcsb6bfwLTppvKvKTVpqDMkBmnbab0Fw9wVC?=
 =?us-ascii?Q?Q4O2lbrbPTEOOgxV/j+vkoBglJLKLb4QIHy4aRCvIx5759TnGXHFWx6U5xQf?=
 =?us-ascii?Q?JrGhfregRbjXdIA0ZAFQjq43ea/QCkfKGCHOTVHqDa866cSlIzeqbnGTK+W9?=
 =?us-ascii?Q?sN/jYVU64X4+8qx5RpwYuOqZYJRIWe8rRLE1KVVTHv4qPHI12+pps/aoqEnJ?=
 =?us-ascii?Q?Ws87KTjrExZNIfk6mERll66Xhc3gUMbtqqOygRonw7P8Ip6N9N3Roa0wr48Y?=
 =?us-ascii?Q?2mQocCdwIqYm62MRsOmPjFa7ig385EVeCxktlTOTA4QVH4c217JUVub8JBdY?=
 =?us-ascii?Q?8Z1YoVJJwlCMHGiyOM/OjmKfVuRnJpMI/hfK1AmTd3+DL8qyjFDYOu/XfI6s?=
 =?us-ascii?Q?GmKsvt7Na4WlludK4mn3tApXmX1EmO+80QJzBZnEJGkG+P50pCBaOdsS5s6G?=
 =?us-ascii?Q?Dt5sEVD0rDViwm0QEpVhwOACGo9Ftd6jcTRST1/WDoKsWrJRVPIyPOZTFYrY?=
 =?us-ascii?Q?u5br5wtt1qTfItGM8hMWWKAKLfGCGFhwlpy/IDuQlqYWBTwpP4THiAKfk/qC?=
 =?us-ascii?Q?zS7PB9ID+mHsP/myxZsRf+ofap4f5c8SUR8WSyh4KSxobYN6lWU2Di7nnrx7?=
 =?us-ascii?Q?8Eb/FHBd5obJmSHajnANGtSx2O6UFPzMnCt0teGsI6SsyKyXKuQmjpx/AuUg?=
 =?us-ascii?Q?WCzeprEkBYfFE0sAkBlP36bgNeXfC4dVgFrATR1m0ZWKSME6T809EWcQbHyW?=
 =?us-ascii?Q?l6m4Rb4jw51UIEF3yBNgD/9X1XdOgYheZY8xn3jZsn7QMyne96A9TtYzCIDG?=
 =?us-ascii?Q?Hcvpznu1TLZJo6hbnMlonm8of5JQ5crTl8CnBtcAoKxZMxmoB8AStmF++zNk?=
 =?us-ascii?Q?EssYJvLNkzZVH3lsRp/jki01Kb+KjbegxIIRu9Kzc1cMPTXidydWJEluxiah?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43235365-a759-492f-ba3d-08da899a3dfe
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 08:41:18.5669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P2vXskaG1s96zqjPshd2lLvOCEdDCm/i9X+9BuCjAEbEEZATaJom3VxaXj4VXIqJp3ghuo317mYx4AVr4SbPYy5ssUTGu7pI3n6AVlfTAZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4962
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_04,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=718 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208290042
X-Proofpoint-GUID: nNb9TbrqSRiJxk6BZr8dIybjc3TCbqtC
X-Proofpoint-ORIG-GUID: nNb9TbrqSRiJxk6BZr8dIybjc3TCbqtC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello Rafael J. Wysocki,

This is a semi-automatic email about new static checker warnings.

The patch 62fcb99bdf10: "ACPI: Drop parent field from struct
acpi_device" from Aug 24, 2022, leads to the following Smatch
complaint:

    drivers/acpi/device_pm.c:166 acpi_device_set_power()
    warn: variable dereferenced before check 'device' (see line 162)

drivers/acpi/device_pm.c
   161	{
   162		struct acpi_device *parent = acpi_dev_parent(device);
                                                             ^^^^^^
Dereverence

   163		int target_state = state;
   164		int result = 0;
   165	
   166		if (!device || !device->flags.power_manageable
                    ^^^^^^^
Checked too late.

   167		    || (state < ACPI_STATE_D0) || (state > ACPI_STATE_D3_COLD))
   168			return -EINVAL;

regards,
dan carpenter
