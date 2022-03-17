Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0B04DC1DA
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Mar 2022 09:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbiCQIul (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Mar 2022 04:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbiCQIuk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Mar 2022 04:50:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732A61CAF19;
        Thu, 17 Mar 2022 01:49:23 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22H8PvFm030868;
        Thu, 17 Mar 2022 08:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=gfJq5F/JlcsvKTLZs1PIv6N9oo0bHxhA46oSndFlneE=;
 b=oQo9q+VVvOhgfa9Mm0MjjWNg/qV3u+81k2ITieWV/UFU0o6DaScW5mofv+yeWAMLWy+z
 cDNrvTqnZemr5wmhSLKKG8VaIYrd+etfFgmPTDsb3J8lUuyzmk98TrOW8a3fTdGvV9V7
 fC9ApME7NQw7Izfq7HeGTwBZBVsefclf444AblQ7wPnTwgfUIBfVBrSfpjGK9owRfC1D
 5A+gEL3YfVE+YXlSoadjIshKTsfHZxJ1CiqyUSCJoQXrfvXuwJwmyWs6jej754CtTQc3
 sXCvjkrj+o+pY4seXBbNf9etpGpsxzZGjjm0K8WPAKdnWm8zm37/+uPysas+bnsZuaDc HA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5s6rq3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 08:49:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22H8k5YW177051;
        Thu, 17 Mar 2022 08:49:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by aserp3020.oracle.com with ESMTP id 3et64m635r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 08:49:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/+OqEGSfOkfuZwQGArlVhKJBNAFxyQxXwi0sOguYjeRYLkh26t3sVkbaSZJd3NNgp6O1gw4e16V4xp7KRxVqVxZDTPm7AjdQJBGV3ti6VDsfFAdht23a3csaWZIKlPrKoHETmNkJ4oqjVxdR4G8P1JlMYWm/VXAvwcbj4OON+wghfaTJ3JSuZ/AouXwEFLM7Zci2v34E6stm7Ah2y8EGZ4WsfkUQT89MW3tejktgItxNOSKsGIABNA8UtKj2Zy9e9BN4avpu6lH9lrLVqbHdaIiCuXkBYu9KoxqlOL/JTt2+xhgALwEifjYj/FN+oYL4wylKCqVBNmR4OWgkQiGSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfJq5F/JlcsvKTLZs1PIv6N9oo0bHxhA46oSndFlneE=;
 b=EOVq/+oa2pSZN8y77S7H9/COUTlbv6LibfVSZ4tl8vtbKwy4xS0DSG2+1thgYI9JKKR2zGwzkvPv3NXrl76NFFAUI+QnZ1sqQgRqoQRO7jDy7zFGJkqJ8UkvM2BPljUBAh6yNy5Fh0Om9j3qiTcrFpruoLD64P2NR3p5y9bBUPcqrxdnEppU0EB9iLlg3bUncaE2teulSa74sOBo+xokLFeCH03c4U3PDR/fsjmtTAtwO8rSIwop0bN/AYB+T0bqFcpm2wqh8D2peiw22Fy3DLRU5UbbHw4wz/97T1Fta13KY1cE8SYlJOlaELMfNq/CaonoV3h9+uvP4ik0OyW7qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfJq5F/JlcsvKTLZs1PIv6N9oo0bHxhA46oSndFlneE=;
 b=fIrAKHLNg8c3okz+Sgp/H922ILOBqet6jlUd9phTIktNvPmYf5EOba4eybGfER9TmqCoweu01nKPKM9q+7cREQNIkNMQNejN7A4jU2TdcxByjI0kEPVJ5c4vOLo+ueoEnS/5q+I4Nw0WMiGkUYVVgkJ9T2oNmrqZx/G57OwiXjY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB4685.namprd10.prod.outlook.com
 (2603:10b6:a03:2df::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 08:49:11 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 08:49:11 +0000
Date:   Thu, 17 Mar 2022 11:48:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>, linux-acpi@vger.kernel.org,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Goswami Sanket <Sanket.Goswami@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [kbuild] Re: [PATCH v4 1/3] ACPI / x86: Add support for LPS0
 callback handler
Message-ID: <202203171657.uF7h6TEG-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316212924.5619-1-mario.limonciello@amd.com>
Message-ID-Hash: NI52B4MUIJNC45QE5RL3M4GLARLZUKWE
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0016.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::28)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c92f817-e82d-44bb-4140-08da07f3017b
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4685:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB46856807C2F923A2D11C67908E129@SJ0PR10MB4685.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qs3Z84FUofC5bHZRH+xyoJJpBKg4HzZvDfIOUxqnrDQU6MDKD/n1xi3Ie4yG7z21DMMtVZ6X1QyuJcHkIekS80gp4nwGyEEsgIyrcZKdhjklysS5951G0M4tZ2pPgubH1JqB8C0z5NXw7vMiqmwuXH3iHkm/MAOcF6q1wlu55f8EbLnYKtKLAmJ1gY6Et1M0KeiCUFf6lV8S1Etq08HcUFYLfkN2uUAh7NSyeaEwEzkz2y5SyOhaRdwr+XKDKD6t2L166GCAN4s3qvFXTftJuz7oQp0mtY4NjjWZSZpHhw5vMrn7j8YgkqaE3rQ0vatsKcKmuLu6YUesU0VpoquYiwOFFmxfRYwz1DrxgGjcAwcEfnWDcvTQMVOGanivfQfY7wh4grSTRVjFikD49WyeQwwaY21kSVqqXZG6z5UWEYak2WJc+xcH53MxjK04+S7O32p1kzGNSQ0znVvh+01MJRG5vGpH5ag1LyJ7z5wSInFZ1hYWlqA9uAGayi9VhbdhTqPNJnSIZfA6Zuq8L0+ZZ+bdBh1YrqPkPy93xSx9eid5h/ohdvdWY7qUzJ4WfdwlDrjR4mZj9evFzqx+b7tFSlh/yDFV5Ky6WTMh2r1e+ukJr6kkOYmRpj29qkDj/aIeAXpYuTVzZhEY5KQcyvuFkGhwEm65Mozsce6TtAiYizfaUB4e1z6Hw9CrlkleWBb6WBR90XdgPs3gKWEFUCuKameWYnnbiOPc5pJWuPN3kSu7JfhNTMDGgZc0V2IMbxwAVtNviMxZIQ9Hgcl3Wv+rvFfOATSK6uzTsRk2ipoMd8ZcbVDvUc9+KERAhgrVGqGiCEMOx9xuGHipbWPik61khg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(8936002)(66556008)(66476007)(5660300002)(54906003)(4326008)(66946007)(7416002)(36756003)(4001150100001)(8676002)(110136005)(83380400001)(316002)(186003)(26005)(6512007)(45080400002)(508600001)(38100700002)(9686003)(38350700002)(6506007)(52116002)(2906002)(6666004)(86362001)(6486002)(966005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IAuyLP9D7mUOF6IQpqlC6cnSTyQgkiPu5CN+8IB7/dhJ5t5Y1SC3lKXgCm3b?=
 =?us-ascii?Q?lnIsl3+UhT2tmXPegVLbvvPD+lt9XCxZlSfdg7QVIfAuJRsX+8n+E3/j397i?=
 =?us-ascii?Q?7qTFVIl99quGl3/20T443/WAYPDKX12B9Nx3k5EQgMkmwOhrxs4hiMYvEgwC?=
 =?us-ascii?Q?PhdOONtoJ6gu3L4qILSCWFyjfwHdxKqorkXDrhNgvWAzUdRf0BOyvqQWngrv?=
 =?us-ascii?Q?1cMzBGzDvMm8VMPDYRrYTyEasUYQhuoMGH9OuOo04tLV9jIL5mrBD4fBLBLp?=
 =?us-ascii?Q?NuRm6aV3SxcJ9Sn2pHlLNfLG5EYEVTpY9wq++OPFdfMma2Ad6GDMQb7I6AhT?=
 =?us-ascii?Q?XjyOP+0vG79+7bVBnxfFkXjb2b5BL20dNneLm1yGxcGSuzaBJ8hArRwHhhU/?=
 =?us-ascii?Q?C3AYA+1j9LbMjn5IHBKhp+LgB8+jWu+V8alK1OTEDu+byX4GaeW6gta8Vh71?=
 =?us-ascii?Q?NKVBzx51/UPF3EbE01tCyoWLH/P/54JLBk14fduJtb/MB/OvuJiwrcDbn9CC?=
 =?us-ascii?Q?50LyemBaQilY8or5K66GI7Raye9uFeSFQ1DaxJJkpsk0AxJEbRpo35TTT4xg?=
 =?us-ascii?Q?tXeXDIcRxaf+2s+S6xgMSSDOuC7pRgPsxOdy9g2HwanMGuVbeJfNzIn+jox8?=
 =?us-ascii?Q?gKWXDUrTZT8FXQUtsl64urPPZpLwdvXqy208kZxmwYcd/r0MW4uqOBQdWj1p?=
 =?us-ascii?Q?05xsEaC7POMB625oYHrrVsRgIsJdTvbVv7dqE8Aw5t4wWmAD8qqOZmeLfAE9?=
 =?us-ascii?Q?6X22BMVhLN5FXJYf+IYHRabDbAs6kNkVP5IIPvenPkuqeEUolmCq++cONkey?=
 =?us-ascii?Q?pUHpFhY40xXsU6YKp3HlnmnmrnraR83E2SlA1U3dsIrdvEkW+YFxYO9ScwIy?=
 =?us-ascii?Q?Hpt9NuyGDO/HAdt4i1LHAWES/R9a4u68MGmp+Hg3oac5nmDblxyArKLw4aYZ?=
 =?us-ascii?Q?kdvMH4/MCxPoeGnZfcrwBrJXOy56q3/sfa3N62QqKLyXPYnTiwepD1nuHuwG?=
 =?us-ascii?Q?KJFtE5ZwatlLe18/OKDnN+pW60DwsYVNoirpXlJ4Jwd1vju4yz4Ba6y0DGQm?=
 =?us-ascii?Q?H+wbkExbnxVW/knRjqAbH8n11e057Sbq99l79yJFsgctAILja9gUgNTqNcP6?=
 =?us-ascii?Q?NyxsEcp7iqyCQWJiVCbdnm5PUJhYKbprBrZIdUSo2EjTZkyEJZbYhYIQZpBx?=
 =?us-ascii?Q?/iFov4yQvV8gfjq1Xq62hWRAW7ktWGuH50s44lF8ZoNsJ9Dtuyn5LYCuQn6z?=
 =?us-ascii?Q?YvlSrnUa6FUNWoEneGgrgkaULDVAHrGeHgSaB6qdvTJZxe0VtBHM+on0v+jV?=
 =?us-ascii?Q?kaDU8FI4ivrs5EEpExvpBqLogtzKKzhML1V6u8QqfZCUgb9EdCM8eLRWqsD6?=
 =?us-ascii?Q?vOMpIgnTD99E7xBdNE/GZsNQyGYGryVZBk6XBeVq+Ci0lwB/bRN/Syw6Rvuh?=
 =?us-ascii?Q?01+/RBnxrvxvdk3v23zww1UfmFsljp9Axni2DicvHAei5n/f4KWrWQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c92f817-e82d-44bb-4140-08da07f3017b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 08:49:11.3867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/YjACWqvTLgQukVa+3ZZk5q2Wco+q0IBIVzNstCwQ03wg/RMaZKS+sx1wINkFJwARS94xNmCkeeGltA6QEhSCHLzIPb8eam6v/eMLGiJXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4685
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10288 signatures=693715
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203170051
X-Proofpoint-GUID: WjP5IXRladg0OIgd9oBANO_ulQA0Uw3b
X-Proofpoint-ORIG-GUID: WjP5IXRladg0OIgd9oBANO_ulQA0Uw3b
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Mario,

url:    https://github.com/0day-ci/linux/commits/Mario-Limonciello/ACPI-x86-Add-support-for-LPS0-callback-handler/20220317-053103 
base:    a32cd981a6da2373c093d471ee4405a915e217d5
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220317/202203171657.uF7h6TEG-lkp@intel.com/config )
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/acpi/x86/s2idle.c:478 acpi_s2idle_prepare_late() error: we previously assumed 'handler' could be null (see line 479)

vim +/handler +478 drivers/acpi/x86/s2idle.c

fa209644a7124b Mario Limonciello  2021-09-01  474  		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_ENTRY,
fa209644a7124b Mario Limonciello  2021-09-01  475  				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
fef98671194be0 Rafael J. Wysocki  2020-12-17  476  	}
4be2feac72a3ad Mario Limonciello  2022-03-16  477  
4be2feac72a3ad Mario Limonciello  2022-03-16 @478  	list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node) {
4be2feac72a3ad Mario Limonciello  2022-03-16 @479  		if (handler)
4be2feac72a3ad Mario Limonciello  2022-03-16  480  			handler->prepare();

The list iterator can never be NULL so there is no need to check.

4be2feac72a3ad Mario Limonciello  2022-03-16  481  	}
4be2feac72a3ad Mario Limonciello  2022-03-16  482  
fef98671194be0 Rafael J. Wysocki  2020-12-17  483  	return 0;
fef98671194be0 Rafael J. Wysocki  2020-12-17  484  }

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 
_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

