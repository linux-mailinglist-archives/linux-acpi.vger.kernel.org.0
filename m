Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252474CBD27
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Mar 2022 12:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbiCCLxM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Mar 2022 06:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiCCLxL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Mar 2022 06:53:11 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801AB3B7;
        Thu,  3 Mar 2022 03:52:25 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 223BjXAi013834;
        Thu, 3 Mar 2022 11:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=a5MhkO+mx5/kopAznKGNy9l7REhNp+DfDeCMNXniA0s=;
 b=fFyu7l6ZzgiVHtI1KNNX3WfW3hCccgtQaLByp4/fn+AcZMDdUT2mPvo9uk1He8Qc4FgS
 11J6KpxcmhKdScRXDbJctVnCkaw6+NYthWQEYc80ZIahoKOGbRQuXuzQxf/lsNJF5wub
 xvnXTGPzOb75fw1pzbO/kZHjK6QjoSGZIuaBykbHNjAcHTc+pZrn/adHXmyGaOwk+UpW
 9ObL8b3MhsFR2h8IsnbVGgJGi19aB9bdK3SAwuuBIiYqNfnC8Nm3QZ/ohwPJureQ0ns6
 uMIU3N7/DxwMJkpL2QruIODoEV+ljR/u4+Ufy+LGdi3xGaogNiHLJ5MRHZt/NPFaQNbc lA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh1k48k3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 11:52:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 223Bou35190194;
        Thu, 3 Mar 2022 11:52:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by aserp3020.oracle.com with ESMTP id 3efc18fb6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 11:52:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNv04koBZKkbJErXpkvPZR7lpPZuP1quswdLcn+RulKG0sM3OWMDzhRgBoDSYrJQgBj3UTad8gvjJUEbBn97TDGDpsq0x/tRfP0CAJlPUK52hBWpDsMe+dt0lLhXbWEQZLld6v5QWH22F70hBFhz41zecIebeODmD0eCRIYNZNsGDus4q40FDK2mLVjzFDeRiQs2UiBqsBaK5Yz3pjytkqNXN5lQtyOqH5L3BBms8Z5nA4V1hLxtI27QnBGz7k9JOa6B0gyxO5h91e45XnkeZlUVnQyQFf7iYe5XHf+PE2v0zvGkLyB3CU+jAnHlWOf16KLuUM2mBS1wEc4g1TIKJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5MhkO+mx5/kopAznKGNy9l7REhNp+DfDeCMNXniA0s=;
 b=ofosQZfWRMT1A8mrB7QFB2HvDgngnPG7VKvw/enDDMcIbQLfPIFNBumHwv7NZqBPphr8nYrC+/KGjoV8Vs4WbI5KrsArd+Ynb8fAxfYiMVzGlMQZwZj2aDOvXlA1yRaM6BDnHdN0enrdpszYGiiBbtRGgI5qDWWpFP4r5vEojVqBeiWWLmdm69hjpRmqjLz6rPfs13Ro9TZvoLxw9NdCrMR53syUUA4R+GNMBulWOh2eRebkw2zyO8c9sTsKWy2RcLdPHYfZ7FU0vDVQZxktL1xQl/Mp+FO/amvs02divW4LxofzJfuunon6rLwgpQKARjvg4qygi5lu/eQI5QP+Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5MhkO+mx5/kopAznKGNy9l7REhNp+DfDeCMNXniA0s=;
 b=AgtfM+DjunbeSEih/3HgwS/lULE5Jc0kKhBsUP5dTdoe7vAC6sJSNWyQP2DA8YME0GtOowfWVbC4qYti627n9q/NTEN/vk5sOBkuOvtLIeFUJEPDo3H3NHXS/uwdX7PMR8VITE/DkoJhYw6m8aIPw7No77jDC0jgBfBQJWOQTKk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB1384.namprd10.prod.outlook.com
 (2603:10b6:903:30::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 11:52:14 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 11:52:14 +0000
Date:   Thu, 3 Mar 2022 14:51:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Mark Cilissen <mark@yotsuba.nl>
Cc:     lkp@intel.com, kbuild-all@lists.01.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [rafael-pm:bleeding-edge 113/118] arch/x86/kernel/acpi/boot.c:1394
 (null)() error: buffer overflow '(acpi_dmi_table[6])->matches' 4 <= 4
Message-ID: <202203021037.WWnG44C5-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0062.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::35) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6728a567-6e4e-4bb7-28ee-08d9fd0c4242
X-MS-TrafficTypeDiagnostic: CY4PR10MB1384:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB13848969242A312C73F84D888E049@CY4PR10MB1384.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g4KYzVHX6EEnLpkwrxJIJFxFSL9hdvpfW8xvxF0aTmXS1wKDHXQQaFDDIeZTAvq2ZIxKqEAay0TuKygRfxYRLXD9SH+PUOBJOw8qSB9LWtVDd5uDbNRUOdenQftd2e8FXE8to9uJotptp+H5gbszO201CZuMtfAvihvS869BBEH/KCPL3DkWmGboBAZkxEiZfIsGekxvHwlUInp+aKDlvZjvb0aRFYgBwtMXDMlfYZ7QLW88Na/sh3pLPdwdpYqaONU/ck3bvCFA5hGvs4klVN/X59qgH8l0V3chuT3HBT7HMlpNS0B7hos0GAdXSFfJzGDTuF96/V+7yO5VzNSZYMf7jGMubMi9ntTl29qRtkhZzagFKJCjzDGsnXEiRKYLkj/viYBUTHaFvaprJwYTB6DmBuSE7v9d1/VKdHDo3lt/Ay+kf5+e+Kpj8sVAr7851ysQtvfjW/GdQlUC3zO8TY7YzRkXejZRtdQHhKpXGFlEV+7z7ngfQPgOLSPXDVvp585iCkuUlW8sWy4E2DFVgWEfnwgP8SsfcYYYew202CfsS/uBaCbsK87lgG7VlYEj6v+uEe772eeEUgOlB8gD4lBSJHf+T0dFfoftlAIMTX6LkTsEkyING6OrQVDUmBCxIbMKtuQDNk32onM6Qk3mJ0XnUS+wooIYsA5pTZLaaFwP1k8Zd6GOBp/Srk+EfMCuVEmnFDdTgS/Jnk2uQnmmQrWTgKG8kbSOLZ2d/YXqDWoGq7wNjavmBwWh59RdCiRTBs8ZU7d++yyU0dW/YxzGDePWCawH2GoharOeu5EMwJpjPCnHZvUatoruPF6FXvjfcM56afszI/2c96+W/1rorQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(6486002)(966005)(38350700002)(38100700002)(508600001)(5660300002)(66946007)(4326008)(8676002)(66476007)(66556008)(36756003)(316002)(6916009)(83380400001)(26005)(186003)(86362001)(54906003)(44832011)(1076003)(2906002)(9686003)(6506007)(6512007)(52116002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bm52Rv1DAz0GZiAsznLJDOH0M5jh92dZ8zpQ5DpfRrAJ1UVfr2a38aaniKtC?=
 =?us-ascii?Q?9wGkLxSV4FnwYQTb2KwP+FlG1ZeSWcTJjJvPwJiI1UYnt3XZU6mk/jIWBd5g?=
 =?us-ascii?Q?EXiU3NT79iWv7GpuOToNYHoa7S8XLk3oiP5bXA5+UiB9kh7zh5voXhrQEseV?=
 =?us-ascii?Q?kY6l4py/tNeiXuwybXrISLyQhvpIgc8nBq1J8lDOV53gSenfqjofbv+6j3rb?=
 =?us-ascii?Q?fhhQ20NYQcU1uOZZbeCFBl67akLd81oj4J0rLUhfVzueWCBAn1rbs2z2j5uq?=
 =?us-ascii?Q?qFxU+QSTAC1/0/PUPGOqV4z4RitoENtUPy+XEkwb5noV5z4Z4SGinWQitq/b?=
 =?us-ascii?Q?N+6WZagri/45cZR9hu5odeC9Y3Y9zwEfj0yScRfAfkXVQsIMZXd86acwG4vY?=
 =?us-ascii?Q?5TV3c7epHrIL/d8LZVTi3m46EGc/Qru24tgHzOexaJh1xhP9NZY2aX5ylhic?=
 =?us-ascii?Q?mXlHpCBzkbkjD2rD+KmeJYVluKnmBFUPui9kMacG6YINv+QiyYbU8iJFG9y0?=
 =?us-ascii?Q?t23rNB0QPJgxlA7ORquDvm25kyw1z28dxLBRsC6GwOfdCideI/9zPhu/V0Az?=
 =?us-ascii?Q?/LNGJ/Ybk+Q6M4AvUC+rT6kEobhuA242e+Z3xIWFp3L3JFER2hvvaUHgIhkw?=
 =?us-ascii?Q?ON+NtwklH+K9B7xy2prXqjoV5ctVs/PwVTTDQPxEOpEy0gTYiSivf5EKhZUE?=
 =?us-ascii?Q?6x84NKtQiFTRI7xk2N05YMbTWVGUvWQolD388T3azaHP++TIYCBg+jRloZJG?=
 =?us-ascii?Q?faOJrd/0wGWwpNTyRpMFOIWwMnS6kZc3+3KfPoasQM9O6IxrnyCXTkWjmtM5?=
 =?us-ascii?Q?oDJGYnntnbfxtm8zr/z+KCqGgTPzGGXyaV8BxKObTPn+4xWYAYoerdHkc4sh?=
 =?us-ascii?Q?9uwNR9yUe7+SEBccJIsQvf2emdPYcM3Ze0L+yl/ayZDdQ3rYfj2hBGzz5Wo2?=
 =?us-ascii?Q?IgXLrudlWFEJaD+qOssflj8E3crTbmwPo3qycbrX1lTedrET/Bba1RHU/TKL?=
 =?us-ascii?Q?JFTxNLB2naXI8SdlWWCoAlw/k3LDWerI68AGXXGGkcRmWV9VwSERB8VmijD1?=
 =?us-ascii?Q?cya0TbQmcaNfUfjr2A5QGv43q7m6jENqKIVl1oPYxI+84sD9cvDJFE2Zc9EQ?=
 =?us-ascii?Q?S1BBPG+IpWuHvIL1fDWxJQ3Pv3uEvWO6TbsyByXKqvOSu8hjTR2FzH9aVf92?=
 =?us-ascii?Q?/B+dopg9pVEVIqIGg/wD+qP2kh0ieMVAXKk8IqCmtnsQGSrKwZqq/+5IHQnx?=
 =?us-ascii?Q?oPOcTwIPv4KkB82FVMjjae83H1SPS9xJwZ/qctFGWnIozU12YqPwhayaJfjy?=
 =?us-ascii?Q?TiO7EeZc7HUsXj/A8x9VUvn/GfWjbJ0BIf1aWTh57RTA1tGo+dcZ4Yl0JZOy?=
 =?us-ascii?Q?Q7LSpvYie+BUEA6vZ7KXFG9oxEifLr2G35RRE3GiUL01n4AxnJQr+2UmOkrn?=
 =?us-ascii?Q?5p0801Gy6IP2fod4Jt8N2jOANCLgFvX6engLRa7Pdksf53C/CZAcPHdJFfzf?=
 =?us-ascii?Q?kt7jHgI9H78EmLDSAfKccvjRRg8kwI4HrqAQ6JODLT8nrfTkKw7o4gyATlC4?=
 =?us-ascii?Q?t/ZpZ1uDAV42bU7snWDno3Iiz5bqFuS6TXbK4W77TjCvB6+K4pGHmhW/5xj1?=
 =?us-ascii?Q?Tths4TIahA4nfQV+nxpl9K8Q2yR5P+Y0d9wIDUvW2p0pOQEk2tZ6oMgUeg9U?=
 =?us-ascii?Q?QtpOfA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6728a567-6e4e-4bb7-28ee-08d9fd0c4242
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 11:52:14.6921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aV1i4lQorAYtARLIWvqJ0OGTlklQFs9KqKEYDW+BUSBIxIRhDn70KIQxxzX6HEgc5f+TM4VFRq3EVY4wZRxs9TCkNGGy+bMDt6TZyMW9X1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1384
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10274 signatures=686787
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203030057
X-Proofpoint-ORIG-GUID: NebTWMNLhVIK9a3oESM09yiCDxENAUpE
X-Proofpoint-GUID: NebTWMNLhVIK9a3oESM09yiCDxENAUpE
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   f7307721a01f4f14d21c699b270a870370cf34b9
commit: ed00b2b8d737f87a2437d7bd7c7f90124b50da05 [113/118] x86 / ACPI: Work around broken XSDT on SEGA AALE board
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220302/202203021037.WWnG44C5-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
arch/x86/kernel/acpi/boot.c:1394 (null)() error: buffer overflow '(acpi_dmi_table[6])->matches' 4 <= 4
arch/x86/kernel/acpi/boot.c:1394 (null)() error: buffer overflow '(acpi_dmi_table[6])->matches' 4 <= 4

vim +1394 arch/x86/kernel/acpi/boot.c

6faadbbb7f9da7 arch/x86/kernel/acpi/boot.c  Christoph Hellwig 2017-09-14 @1394  static const struct dmi_system_id acpi_dmi_table[] __initconst = {
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1395  	/*
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1396  	 * Boxes that need ACPI disabled
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1397  	 */
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1398  	{
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1399  	 .callback = dmi_disable_acpi,
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1400  	 .ident = "IBM Thinkpad",
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1401  	 .matches = {
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1402  		     DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1403  		     DMI_MATCH(DMI_BOARD_NAME, "2629H1G"),
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1404  		     },
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1405  	 },
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1406  
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1407  	/*
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1408  	 * Boxes that need ACPI PCI IRQ routing disabled
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1409  	 */
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1410  	{
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1411  	 .callback = disable_acpi_irq,
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1412  	 .ident = "ASUS A7V",
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1413  	 .matches = {
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1414  		     DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC"),
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1415  		     DMI_MATCH(DMI_BOARD_NAME, "<A7V>"),
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1416  		     /* newer BIOS, Revision 1011, does work */
4be44fcd3bf648 arch/i386/kernel/acpi/boot.c Len Brown         2005-08-05  1417  		     DMI_MATCH(DMI_BIOS_VERSION,
4be44fcd3bf648 arch/i386/kernel/acpi/boot.c Len Brown         2005-08-05  1418  			       "ASUS A7V ACPI BIOS Revision 1007"),
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1419  		     },
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1420  	 },
74586fca38109d arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1421  	{
74586fca38109d arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1422  		/*
74586fca38109d arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1423  		 * Latest BIOS for IBM 600E (1.16) has bad pcinum
74586fca38109d arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1424  		 * for LPC bridge, which is needed for the PCI
74586fca38109d arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1425  		 * interrupt links to work. DSDT fix is in bug 5966.
74586fca38109d arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1426  		 * 2645, 2646 model numbers are shared with 600/600E/600X
74586fca38109d arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1427  		 */
74586fca38109d arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1428  	 .callback = disable_acpi_irq,
74586fca38109d arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1429  	 .ident = "IBM Thinkpad 600 Series 2645",
74586fca38109d arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1430  	 .matches = {
74586fca38109d arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1431  		     DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
74586fca38109d arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1432  		     DMI_MATCH(DMI_BOARD_NAME, "2645"),
74586fca38109d arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1433  		     },
74586fca38109d arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1434  	 },
74586fca38109d arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1435  	{
74586fca38109d arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1436  	 .callback = disable_acpi_irq,
74586fca38109d arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1437  	 .ident = "IBM Thinkpad 600 Series 2646",
74586fca38109d arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1438  	 .matches = {
74586fca38109d arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1439  		     DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
74586fca38109d arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1440  		     DMI_MATCH(DMI_BOARD_NAME, "2646"),
74586fca38109d arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1441  		     },
74586fca38109d arch/i386/kernel/acpi/boot.c Len Brown         2007-03-08  1442  	 },
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1443  	/*
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1444  	 * Boxes that need ACPI PCI IRQ routing and PCI scan disabled
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1445  	 */
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1446  	{			/* _BBN 0 bug */
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1447  	 .callback = disable_acpi_pci,
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1448  	 .ident = "ASUS PR-DLS",
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1449  	 .matches = {
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1450  		     DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1451  		     DMI_MATCH(DMI_BOARD_NAME, "PR-DLS"),
4be44fcd3bf648 arch/i386/kernel/acpi/boot.c Len Brown         2005-08-05  1452  		     DMI_MATCH(DMI_BIOS_VERSION,
4be44fcd3bf648 arch/i386/kernel/acpi/boot.c Len Brown         2005-08-05  1453  			       "ASUS PR-DLS ACPI BIOS Revision 1010"),
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1454  		     DMI_MATCH(DMI_BIOS_DATE, "03/21/2003")
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1455  		     },
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1456  	 },
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1457  	{
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1458  	 .callback = disable_acpi_pci,
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1459  	 .ident = "Acer TravelMate 36x Laptop",
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1460  	 .matches = {
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1461  		     DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1462  		     DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 360"),
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1463  		     },
aea00143a8db8c arch/i386/kernel/acpi/boot.c Andrey Panin      2005-06-25  1464  	 },
ed00b2b8d737f8 arch/x86/kernel/acpi/boot.c  Mark Cilissen     2022-02-23  1465  	/*
ed00b2b8d737f8 arch/x86/kernel/acpi/boot.c  Mark Cilissen     2022-02-23  1466  	 * Boxes that need ACPI XSDT use disabled due to corrupted tables
ed00b2b8d737f8 arch/x86/kernel/acpi/boot.c  Mark Cilissen     2022-02-23  1467  	 */
ed00b2b8d737f8 arch/x86/kernel/acpi/boot.c  Mark Cilissen     2022-02-23  1468  	{
ed00b2b8d737f8 arch/x86/kernel/acpi/boot.c  Mark Cilissen     2022-02-23  1469  	 .callback = disable_acpi_xsdt,
ed00b2b8d737f8 arch/x86/kernel/acpi/boot.c  Mark Cilissen     2022-02-23  1470  	 .ident = "SEGA AALE",
ed00b2b8d737f8 arch/x86/kernel/acpi/boot.c  Mark Cilissen     2022-02-23  1471  	 .matches = {
ed00b2b8d737f8 arch/x86/kernel/acpi/boot.c  Mark Cilissen     2022-02-23  1472  		     DMI_MATCH(DMI_SYS_VENDOR, "NEC"),
ed00b2b8d737f8 arch/x86/kernel/acpi/boot.c  Mark Cilissen     2022-02-23  1473  		     DMI_MATCH(DMI_PRODUCT_NAME, "Bearlake CRB Board"),
ed00b2b8d737f8 arch/x86/kernel/acpi/boot.c  Mark Cilissen     2022-02-23  1474  		     DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
ed00b2b8d737f8 arch/x86/kernel/acpi/boot.c  Mark Cilissen     2022-02-23  1475  		     DMI_MATCH(DMI_BIOS_VERSION, "V1.12"),
ed00b2b8d737f8 arch/x86/kernel/acpi/boot.c  Mark Cilissen     2022-02-23  1476  		     DMI_MATCH(DMI_BIOS_DATE, "02/01/2011"),

There are only 4 elements in the .matches[] array.

ed00b2b8d737f8 arch/x86/kernel/acpi/boot.c  Mark Cilissen     2022-02-23  1477  		     },
ed00b2b8d737f8 arch/x86/kernel/acpi/boot.c  Mark Cilissen     2022-02-23  1478  	},
35af28219e684a arch/x86/kernel/acpi/boot.c  Andreas Herrmann  2008-10-22  1479  	{}
35af28219e684a arch/x86/kernel/acpi/boot.c  Andreas Herrmann  2008-10-22  1480  };

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

