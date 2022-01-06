Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD1148615C
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jan 2022 09:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236530AbiAFIXf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Jan 2022 03:23:35 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:47308 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236013AbiAFIXf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Jan 2022 03:23:35 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2067Y3ej014145;
        Thu, 6 Jan 2022 08:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=5AgOVHm7PwpDxGqeUAspYlDYPA6oD6+H0qsCxKjtFIM=;
 b=udjxiT68D6Q1FUfvoTiAHCHvFt8yx8OYxjuDj+S7LJGZgjV4/FcOKtq8xKuVO25QyrsR
 wVqG3MedsJckOh0X9mzx0F/UDZifZpbiCDsXcuPluXSGVLnEImTvT3LHhcU6XhPH1WwK
 7jZriSQUlUfHt5dWPJ7jbcmz2rvPwr7lYNrKSGQKCycC4ky5XHnwSSfOeWfnXnL3kE91
 +uvF1Cm40od5VvBE6tA0EzU+RVo1T8q4VzoWh21g3tUZ+Untd12w4WHaflNY5rdzUhBV
 LiLn22Y3Jy8GqiwiYA56HOaX/PJHjVFBjV+IuQqg1/ZLftQjf5mW1/OgSGQwITPL4OZZ tA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ddmpeh2a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 08:23:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2068Lg78192877;
        Thu, 6 Jan 2022 08:23:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by aserp3020.oracle.com with ESMTP id 3ddmqah3cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 08:23:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5xZ3E+AUy12vfg+RoL3kzDfaqxjKjp5PuFmBWJ3J5LlRooSNbTWo79EoLfX5KhArFQd79ui/8Al3O0LomkJ5kCIfCPARErd8qFsx1Yt7YEv6YxJfw3tcQTxQnVb2piXDXbAYWa6XGlM7vNh2ZCpofWOX1Pn2Xny9pTXAhlZ1F/4C9IW/KSy98R1Zb1OXSEeYgb8btsLuhqCzOI0lso3FkpBwX2P1FWnwyUu/wV7lnXRd7MZ8ZQlSDm7AAtvPHilhWWyv2BOsK4H9VGjKq7Wh8ODxRAocunWychc84LfsP5CdhD+qMD/nqTEtWXsMQlDsKbmk++IGuLBdHrJRsrNIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AgOVHm7PwpDxGqeUAspYlDYPA6oD6+H0qsCxKjtFIM=;
 b=Qlufb3dwppZzCPgWutS1hCLQeJNkb3WUJOTYm/i3PNwu6J2VzTWbMgCqhNxIpNK3s0ossRCx9BYDEhhZDeR/XkxqryVq4WuPnIiFOXFH1IPN4k2JmHZml+zmfv5/ecxU4HrU2jAxoD9AA4PeEnLqp+ht9LXBX5MPEAescwwHCPnEiXw8pAzsntmwcPWrrgqVRj5PHpW9hr15GHL85mQ3w/VSI4eYImAXXG0Mtq+owZ9IUmfu4fq7MEwyHPVCdCazEZ9ozVQe6zeF11bF+w2nisjalxhfOLwTf7RzVqWG8Zkum0xe+Y94+bdE5kRB08ig7umyZw1Agd6KGi+WCJiJNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AgOVHm7PwpDxGqeUAspYlDYPA6oD6+H0qsCxKjtFIM=;
 b=KXGZONFFG0J8iQsjwXlhcrjzbWeo+jyEU1uAZnj2jAaTL5YQYWw7eyGlDauHq0alpMme3P7Nlt3PaHYDJbFyjgSI0Hx7//Ru2fT4bGwD8rPGPTaDacENSgN8PWTI4xd/tM/fLKxW9l5uL33eBmdOEl5ge3tdY5/CElNeJnODjKc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1662.namprd10.prod.outlook.com
 (2603:10b6:301:a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 08:23:31 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4844.016; Thu, 6 Jan 2022
 08:23:31 +0000
Date:   Thu, 6 Jan 2022 11:23:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     rafael.j.wysocki@intel.com
Cc:     linux-acpi@vger.kernel.org
Subject: [bug report] ACPI: scan: Introduce acpi_fetch_acpi_dev()
Message-ID: <20220106082317.GA9123@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0152.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::10) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 003798fc-d504-4804-9926-08d9d0edd24e
X-MS-TrafficTypeDiagnostic: MWHPR10MB1662:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB166215AD6CCAE6E73C1B6C5E8E4C9@MWHPR10MB1662.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rcU4vA8YcSdGR4hEHKnLK/fq3NPkqFfzyrZVCtYo2ezBIHRgkJCenVUukx1pl7Y8jiue8C530oAOso/s7Ie1n3iTEU/ceesEKgsEw6G3ufdqcDGLIASRex1Au8teG6drEAg68TLuWitoo3+ja8QO/jiVjembiLpW4NDzUrUaYC9xwuHssmH8ri8e7oUrVsEM15lfRJKx9rKVmvDWRUfR3y44kwBD0zBjZorY089K1u1MvYVjZX+M3Nj5elM2jOVXzrqYb/6EXwawcMBwRWIF4pAhzloofHGXlxep1c5kOZlKnwFdpDefLgPciCnbJh9R8NZSWptz15DEqOwWoL3nqO4X/2APC/6Mqr3FqVCjzKr477xSqlnhQobBiegum4xZVnf8Zc9tnYIP/tua4TWCWYGYtZbePbZxlbBJ4zicfXcaS0m8DnpShBRKsUBLlzmFtbp37OPogP2C7E14rwftFgFegCAIItGXG3vgb2Rsao/XGtyTwsnqsBZ69KX332V8j3u/r1GmfGrBC91wYrFZbmnSzwP6Y8rk5y4abGNIYQDuuToBAqLCAV2TIk7aJ93Op18zmQTatf4o2Av5Hl5NihVxfB7QoqJAqbkhuyyBpDIted9aAxGtpKizhJohZX8Jj2V9zW3ZE7veibUoeNnTnJPMStim+X/3jT8pSPVeKrM+byCxcA450J5o+YrYtH3hK4QrhaymS5sEg/3kmjiH6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(66476007)(52116002)(1076003)(33656002)(2906002)(508600001)(6506007)(6486002)(6916009)(6666004)(86362001)(66946007)(66556008)(83380400001)(316002)(38100700002)(186003)(4326008)(38350700002)(26005)(8936002)(6512007)(8676002)(9686003)(44832011)(33716001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ar7uiuJsGcs65BBWeTijNfpB7Rdkz4h0IKSYTbs3COvAEUliSQieKvKsOY35?=
 =?us-ascii?Q?jhsIlhMOG9XtSYEaxL/gVSQRKVmit5yesScok09jP8RNlDjHq9ov8iVPQbLE?=
 =?us-ascii?Q?dWFSEC2XewNVZcZM9ZWPemVrvuWdcLG2HEMugzBac3wRSK44Ex8OdEaEluPT?=
 =?us-ascii?Q?6iNMPVzW7UeihqyIacY8KjTE+CGuj1t/S+4OtZxpm97Lmbh18VBnu+Y8SxAw?=
 =?us-ascii?Q?5OfAFYKJsNhchiLVf8geqO1Ilr1pWUyfrfPGM6Z2U0nThXaGnaPtAO7EH0s6?=
 =?us-ascii?Q?taT78bt+SqjbXG9BIFPudFR/3rMpCI9wmuaWRhfihimne1VNCd3F4xPowisV?=
 =?us-ascii?Q?THmLEtyUID4rXFR8vudKP4z4rIYr46kcq+sUoFp+DWLZKINaDCKmHd7+5aAc?=
 =?us-ascii?Q?SOcN7JaVvmiRD0okFOuo2kKd3ilLy93xlVGYk5m58OM89RNqS8E3YzuSrXgc?=
 =?us-ascii?Q?Oxoiqo88o837ZW1hjZSSLM2zqwJTWNSO9IlrpIOuMlTxhZzYhHiFXDfqW5WN?=
 =?us-ascii?Q?7DLd5cBLlkEL6Bj1X84jB4WhcKtYhHfR1JM/tOWgsPYIF+QibajlMJJ5cHqa?=
 =?us-ascii?Q?czrQ5HNEt1qQH3FVaduKyJ2lerRzVc9EZLAZ5dc6IJxZq4kP2JGd4WpZvNbF?=
 =?us-ascii?Q?kUroYINRpBI0YWJnVhH7YEbIbNASMjIosX5IMhX79Biy0U04CkSoQDzU3tNY?=
 =?us-ascii?Q?cdeHca4JVwWSc4d0ESyxeI1m8QJ85qhParqbLZejmv4tiBhO7UFKdl4gRh6J?=
 =?us-ascii?Q?dPGnV9Bz7xtQvxKAOVpzCOLPjIR4x9ePsiyRCpetbk7U5K3A4qMiaZVAwMpv?=
 =?us-ascii?Q?VTxwCjv3QandZuF+9pSVGLTmD8ZC5D7Pm6hfxoIsQPerjOIx7wqyDDUh2wHv?=
 =?us-ascii?Q?35LEwzdVseyiuULLV98nXIi2PivsH9JvxAVYncR91UsG8I0P+yvfRQ6qBMKu?=
 =?us-ascii?Q?CC8eUzruSOg+5SM4k39/zOWsCUNnyUqYSEMFhBifDQxSKER2Z2nnUYA8I0sW?=
 =?us-ascii?Q?m7CKXh5pwtmnkhqnoebsbiL81D3yFSFbVZZeNpn7Ljl6cpbwidKk5q3VPaDY?=
 =?us-ascii?Q?cEy4wHnXKERBOGWvrVGT1c4dizaxTxGCCEGIMbCb0O8v3PQmj/DwoOnHdsmw?=
 =?us-ascii?Q?h0QmbEOjfjoQmGX3M29ZoHmdaJ1hHLX54lPeycjeYUUPTKZZNQqP2IbQuQDu?=
 =?us-ascii?Q?babzFO3dbeIQc1aI679WC/eYyE7DGMrgDpMif5XXNFOLlh47KSQNKGtJusX2?=
 =?us-ascii?Q?h/SONGiCqOT5rJSPBPZs04q/L+xHUfjpSG2+TMQxvrJfU/yo0BTfGzpk/ooy?=
 =?us-ascii?Q?5YwW0d2y0U91xRHAfBm9VuJA46gVHSJdDR6OK0PZtU0OO/JC8G+cT2zVAJlb?=
 =?us-ascii?Q?Tr/YCIacp1/wSq9flNcfd8ZP6JM3bQ75qDtidv/mcaE/QEUQWcOKpaJAxUi2?=
 =?us-ascii?Q?J1qT/NoqGncItbTs4SsupUrREc/GzBxW0F4y0Q4hrhQjgFqVB/MeGIdN2vdM?=
 =?us-ascii?Q?0nNFT+VTWtk6if2nWJUzOLXl2t7y+RrQmrH2zF4LX921+c18UE3iyyKmvnMZ?=
 =?us-ascii?Q?lgpBE8MG5HJ40j4PPlDA/7NK4IgvuJQ6S7TcUrJUqCLRa06zzOBp0IwS7+40?=
 =?us-ascii?Q?oeS5v0fnS4/e9tvksLFNEc3qK2Pec7bgfJzuxppcu5MI8hn+94E/BgmTO9Cb?=
 =?us-ascii?Q?iVI/QFZSRonLKEfRTIO58DOdfTg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 003798fc-d504-4804-9926-08d9d0edd24e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 08:23:31.0078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZiOpylMox7pEYTtvFKq8VLZq3bpZj+EirJaPynKJ92ZJCDutzrJlB25psWVawCR9Xcvnk5xQDGw0vy/sdUUZRM18RRdjnRbE7YKtkRrCjeg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1662
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=879 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2112160000
 definitions=main-2201060058
X-Proofpoint-ORIG-GUID: NoztW6iPufvlBx537cXcjkwUTCR7CjnV
X-Proofpoint-GUID: NoztW6iPufvlBx537cXcjkwUTCR7CjnV
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello Rafael J. Wysocki,

The patch e3c963c49887: "ACPI: scan: Introduce acpi_fetch_acpi_dev()"
from Dec 3, 2021, leads to the following Smatch static checker
warning:

	drivers/acpi/scan.c:2619 acpi_scan_init()
	warn: missing error code here? 'acpi_fetch_acpi_dev()' failed. 'result' = '0'

drivers/acpi/scan.c
    2609         mutex_lock(&acpi_scan_lock);
    2610         /*
    2611          * Enumerate devices in the ACPI namespace.
    2612          */
    2613         result = acpi_bus_scan(ACPI_ROOT_OBJECT);
    2614         if (result)
    2615                 goto out;
    2616 
    2617         acpi_root = acpi_fetch_acpi_dev(ACPI_ROOT_OBJECT);
    2618         if (!acpi_root)
--> 2619                 goto out;

set result = ESOMETHING?

    2620 
    2621         /* Fixed feature devices do not exist on HW-reduced platform */
    2622         if (!acpi_gbl_reduced_hardware) {
    2623                 result = acpi_bus_scan_fixed();
    2624                 if (result) {
    2625                         acpi_detach_data(acpi_root->handle,
    2626                                          acpi_scan_drop_device);
    2627                         acpi_device_del(acpi_root);
    2628                         acpi_bus_put_acpi_device(acpi_root);
    2629                         goto out;
    2630                 }
    2631         }
    2632 
    2633         acpi_turn_off_unused_power_resources();
    2634 
    2635         acpi_scan_initialized = true;
    2636 
    2637  out:
    2638         mutex_unlock(&acpi_scan_lock);
    2639         return result;
    2640 }

regards,
dan carpenter
