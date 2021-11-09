Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE15044AABB
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Nov 2021 10:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244953AbhKIJpo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Nov 2021 04:45:44 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:50148 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244962AbhKIJpn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Nov 2021 04:45:43 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A98T4Pl027934;
        Tue, 9 Nov 2021 09:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=PoNemBDxgAfhMpUgmcZoNidIeOvdp0KcV3hPmVgf9qY=;
 b=XF6uEAzcurCXkQkpcGbEBgu8V4a0yMVu/LtoAbGbrKahjsZkO3KjaSWp6S4njgF0tIsS
 rQuoo9/CiegMQODou8+r04HmQjG5TduQXjKED1TliBmd70bh+WhXqpyF3mZjMEfGcqd0
 k0FsPSXX4C9OYOs0zEFBqaf4o3GVwtfOFFjqHpJj6/vU/PAwZSFkqbOr8tRdopRFYJH1
 zeGaMXO1qEYONmkT1iUmp/GojXmZLR5GM7rt63x3uiKaKFnYyUDDH99E6CTyYOjtAcb3
 xEyYBX+3VMvt0qPhqyLbYVCtEcVZizX62E0DXscxx5ymIwcKEicNS8AGaxNP6o2VnTH0 /w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c6st8t34d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Nov 2021 09:42:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A99fOsT137307;
        Tue, 9 Nov 2021 09:42:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by userp3030.oracle.com with ESMTP id 3c5etvcc0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Nov 2021 09:42:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwIVHZ1j2nieDxLRstN508oglq5MxUEobTKBeAtmghmb31MHwPWbFt8QoPxeGDl4rTB66EH6Yk6heX2YNE7LSP4uTAHjj85wzQ1gaABMrU4J2hWw7Mj35yhSrFPhFi4Vu1Uuk3Ub9j2CXfl4Kmw3JuITPtI5rDHVwQeIScwsB+tVB4t1wsZgTcqq6pq6RYEn0ehhI15gaLIN0oskIrB/ukLaUuDmqTNsgzx+5FGzEFculIc+GjL4EnA4Jdm4jCDfCQS6bDWVmKRRBGwwIf2bQX6UAoJDCb9d/vaw4AODI9hBrH3v+YEsy8YadD0CjIdvQ3ufyBgsEVKiUAK9Rjl7pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoNemBDxgAfhMpUgmcZoNidIeOvdp0KcV3hPmVgf9qY=;
 b=gAkjv2smr1YI94NILUPpa9Lp23Hav7vbXWlBoJFhHdkgs1ekc+5Ll9+74O2+brn7iY52r8V3UN4UPd0vks/LbsLVw2h5QI/m5iTmhGvDO5rYc/w11X3Cq/ITmGkGX9lcR5q0NRUAN4urGYv1iy0vNVWm2miBsVHACDkRbg47XjfKj/j5F+5sTAi3HYN6KodRTTC0Hj5AQPSdQq2ZjlFjpMOptxR+hSseAzN9SWri4kThh5maccI9qR82JNSqmqzhzuoDQEXLOXmY44S75zxRn+XI/XRypPSJRiQzGc8XY68lxTaXpjiDQ4/CoWizWoL+pOg3GFMFlyu8rkPup8Gi4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoNemBDxgAfhMpUgmcZoNidIeOvdp0KcV3hPmVgf9qY=;
 b=WwMUaEjYjT6RWbqNzFzg+eleayjY6sApxvY4kY57R5L/I0lGrcCKFSSdTJGKS/UPuprne7VrffeSfpdHVigCiFCIYi+lodGL8KjgjlZYys5TINSOFChLO0uIXSjUt8rL1122pyY9S/67zXiFy3JDXTTkVlpBbnULAXWGdt2f/No=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR1001MB2354.namprd10.prod.outlook.com
 (2603:10b6:405:31::21) by BN0PR10MB5365.namprd10.prod.outlook.com
 (2603:10b6:408:117::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Tue, 9 Nov
 2021 09:42:16 +0000
Received: from BN6PR1001MB2354.namprd10.prod.outlook.com
 ([fe80::801d:52b6:339c:d85a]) by BN6PR1001MB2354.namprd10.prod.outlook.com
 ([fe80::801d:52b6:339c:d85a%6]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 09:42:16 +0000
Date:   Tue, 9 Nov 2021 12:41:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, james.liu@hpe.com, rafael@kernel.org,
        lenb@kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org, linux-acpi@vger.kernel.org,
        James Liu <james.liu@hpe.com>
Subject: Re: [PATCH] ACPI: OSL: Handle the return value of
 acpi_os_map_generic_address() for a non-register GAS
Message-ID: <202111090100.tLRnS1DE-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022011833.24308-1-james.liu@hpe.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0058.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::6)
 To BN6PR1001MB2354.namprd10.prod.outlook.com (2603:10b6:405:31::21)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0058.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13 via Frontend Transport; Tue, 9 Nov 2021 09:42:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76e0a50b-ea4f-4024-d0a2-08d9a36536b2
X-MS-TrafficTypeDiagnostic: BN0PR10MB5365:
X-Microsoft-Antispam-PRVS: <BN0PR10MB5365CB2DE0E23E7B8D1BE0858E929@BN0PR10MB5365.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oOXJxNT4HSgs1bVStEbKqMBzOmAXOv3Fq0Vw2dSdTgsZEk4XduXo2tkM/yoFUqz8L/b0vDime6Tyf5ZzK99h/rUtj9EjJlLbzEsDmBqkSEpsM4EF5aIrA5Mrxh5y+nh8DVDXzv4L+/E9JwXRo1UhUmAopQdCcUEKmRKWwI2rySmpd7NjgybCNrKIET0+qQuva9HawO8g8iMGWbHdldrin6MG3YL7sEBQe1NG1MfrXsL5hxE1gRP/Bpw1ATxYlsu+uhnIAjo9SHB2b9opixGHAmsb/mPysm9XiGvO32DsfSIanQDDGBPyJqVTq55EvNVReEbIspAoHcK6jB9BGkqfR6S+A4OKJkZsNLbNdFlQgE9UiOMlDasqTKuHzXD2odeRGPlQ9AInJKCzz2N6HIB6PsgsaRmzzZvS9tAfoFp05h5f3dbUcKQXEZxlzqgKI8W88PhFsaQnz8xIzPt0y73tdKqIdp+CKEjou0j1yba1w2iCOp53yI3hsCHr/8bXke0FcWO33WKvaVl9qpnMKdDBUA9XcGW25moT0914aHHQ50jVv7T0LYKV8D2h8AZqcb8pUJHLL2ZFWSUA0tUbc7DR/Cb3jGtPUUsiaDeh7H1zbcVHYhQFf6jhJcB+pWBanmCgoCQfjvPraV6w5pU54r0thvEfDV7bYWN86b+IOkagkRbq140jF5hrNBYlfEMnm/VLnxthw6FoL4+ZrqmBNVE+/pg2Ms60dZOaXUCvYdBM1cW3eb/fOUYqeHhGq+5LOlOi39ALYJD5uY2w1nx3Vu42cjDjE4wcRQ8kFpaSZQ1Ud+iRrO9zukly9ES/Sxsv0W8B1pP8zquwo2nkvKAIcJc1zrIaMdgYWTq0q4I2+ILa6bw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1001MB2354.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(8676002)(508600001)(2906002)(83380400001)(186003)(38350700002)(38100700002)(6666004)(9686003)(316002)(966005)(956004)(1076003)(36756003)(86362001)(5660300002)(6486002)(52116002)(66476007)(66556008)(4001150100001)(4326008)(66946007)(44832011)(26005)(6496006)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WZdBmbWbpILVbZYXvV2pRx0VgX4t/cqzWRBpTDyjOtXzozZ1b3qvDvEdnks1?=
 =?us-ascii?Q?1OnVW5Xqwj6DAGhU1+FmvUVEvUMsB4fn3g7WyHxiKIHHPJo+Bt6EJrJW3gsD?=
 =?us-ascii?Q?TKyoC32xT4+thGwZvv6MO3rSZKBcLo17GmWCdi1b7M9HIUZsQDroKhalZiZR?=
 =?us-ascii?Q?/RjXTvuFnyOQEuYuwEoZAr3BJ/BDs7t6S+k4jwSY33cbVZmGRp/gC0CqR353?=
 =?us-ascii?Q?wE0JjzwCqeOVI9X/aSdnuB4w12kp7kGpUDY40pWUe+ZtW3H+KiZMlm9ISS+4?=
 =?us-ascii?Q?PCxCSTCMLmWE+Q0M36gmIWfRsNbgvqzPTVO5Cp3DHnoihVeAGuklsGfO8oQ7?=
 =?us-ascii?Q?45rkCsyn2LBUn5Q5KjIQoCQlJx8PSlpxexgmq2imTgKMIUvvCschn1HroZRD?=
 =?us-ascii?Q?NXdU2XBjTqndJLo7Wi1Eak2E1dtvt719GUKXAjh2nugKi4p8bP4MdkC6N1of?=
 =?us-ascii?Q?j74uBxRt6IMiJ8RvwmgKNm/ipeAjl06O68fut1V0+IYnF1HjuuVmWHsglFYm?=
 =?us-ascii?Q?3hgSc8W5j4Jv3GEH/bCMmdapfoNEFCEW1h1JrGWGxpjaSdhak5/NSsXD5KTC?=
 =?us-ascii?Q?22OV61GWeCD7vetn7iYEQFXfFvv5eOz365ruhOCbDpHi7uQTCF45TciEDTYf?=
 =?us-ascii?Q?1Is88+wIta1GnnhduqNeF45c0snbsiuND4ZEtM4Qd7BLzd10pocrAjQDdpC8?=
 =?us-ascii?Q?yPgK2mYfSFol1+nqa5dfnHq1G1V5jQgX7DzMHfsfG48aD/iVEq0RSnKTKcQr?=
 =?us-ascii?Q?iKxrXIVUB6ZCO9TBsbKQCd2PAnEUxF6lHj3CEs3oYx18J6+rtaKfLCMhNzYt?=
 =?us-ascii?Q?AWkUdJGhU0j4b+a8GnATdeaW5WElnKwrWKZVO15DrDdFtEUE1R315jDRcg9d?=
 =?us-ascii?Q?p9DxD+n8oVTeaharuCvqRMqaF344zTUzi6hgs/tlqmglLW5ssWmN/Bxucich?=
 =?us-ascii?Q?mG9vLPIvYgIWOV5aR9lQTb3QfkFstATj4yBEl7zHoBBv83BP+8bv3VKmSRZW?=
 =?us-ascii?Q?WxGKI5KSxIWHyvNwGxo8rnmPghUp2YpI59KxAETswovu2mgaY+8wf+hXJbGT?=
 =?us-ascii?Q?jhbUr8HwN6YUAeTAgMjHAUXv6a2AWVFIj4c8o9TTc8LQY9UegOdJL0wV6fWh?=
 =?us-ascii?Q?JYyojJrnagdGmhIk8DcNyMejnT1nNwK7C6DOf2wSNmbKHJoLxkzl5Qvf5gsK?=
 =?us-ascii?Q?czM/ZGbjwF+ggwZsUQfKSlw92cN8aUBln17UXDaq3woernC4J6T7Su19EIy/?=
 =?us-ascii?Q?+0fVyhVgFqoNxLC63SNu/eKZ43f8FqL2STM086n0+mcwXuhxBsXcz/j5tQtP?=
 =?us-ascii?Q?ec82J7LTIookxA+6SLBGcPfOQnNhvRllCKqeQTAEPjILA3I1WkyzV7B4WaIS?=
 =?us-ascii?Q?dITdyNfcqZT+rTTlymRA6p3ae62HeAdKzL0jcdNaiHP7XqVBqqARIv23RIqn?=
 =?us-ascii?Q?ytfckT2h+Op8/RgEoyyzhENZgkUSoxvNIJgbL1mzgd5O+IazgCQnhB9vtihk?=
 =?us-ascii?Q?CCQ2OAVTW1O8mNRAPsPf6Juub+UphQtealxWmXWYIp2YrJLyobk4QyfG2PfN?=
 =?us-ascii?Q?crb5h4u1rk4+rLQePVlWIcqb3LOpZr8FKdYCoCSyLmMVGT6jevtStsAYFrIr?=
 =?us-ascii?Q?hGZfL1rCGzk/LjACj3p5SAYykh/W7JdcsQVsv9sm9IxcgEkQgsJxeiddjGYa?=
 =?us-ascii?Q?8d5S076ofiUfRvSntz4qhndv1Pk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e0a50b-ea4f-4024-d0a2-08d9a36536b2
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1001MB2354.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 09:42:16.4822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3wDnQ2W8EEkzEzxpPscmslbm2sjNdq7jUlTg6GHJYZtipHXigmcRFXJNNyC4vSJegBg/6CGQ0zyurR0676dRJnMAZuOSf4lTqL9cmH/DZCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5365
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10162 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111090058
X-Proofpoint-ORIG-GUID: OMfp1DktlRTb48dNsjCkK3fhcZlQ1bR4
X-Proofpoint-GUID: OMfp1DktlRTb48dNsjCkK3fhcZlQ1bR4
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

url:    https://github.com/0day-ci/linux/commits/james-liu-hpe-com/ACPI-OSL-Handle-the-return-value-of-acpi_os_map_generic_address-for-a-non-register-GAS/20211022-091959
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: i386-randconfig-m021-20211025 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/acpi/osl.c:467 acpi_os_map_generic_address() error: uninitialized symbol 'addr'.

vim +/addr +467 drivers/acpi/osl.c

6915564dc5a8ab Rafael J. Wysocki 2020-09-11  453  void __iomem *acpi_os_map_generic_address(struct acpi_generic_address *gas)
29718521237a1b Myron Stowe       2010-10-21  454  {
bc9ffce27962c0 Myron Stowe       2011-11-07  455  	u64 addr;
29718521237a1b Myron Stowe       2010-10-21  456  
bc9ffce27962c0 Myron Stowe       2011-11-07  457  	if (gas->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
6915564dc5a8ab Rafael J. Wysocki 2020-09-11  458  		return NULL;
f0340367a7885a James Liu         2021-10-22  459  	/* Handle a non-register GAS (i.e., a pointer to a data structure),
f0340367a7885a James Liu         2021-10-22  460  	 * whose bit width is expected to be 0 according to ACPI spec. 6.4.
f0340367a7885a James Liu         2021-10-22  461  	 * For example, The RegisterRegion field in SET_ERROR_TYPE_WITH_ADDRESS
f0340367a7885a James Liu         2021-10-22  462  	 * points to a data structure whose format is defined in Table 18.30 in
f0340367a7885a James Liu         2021-10-22  463  	 * ACPI Spec. 6.4
f0340367a7885a James Liu         2021-10-22  464  	 */
f0340367a7885a James Liu         2021-10-22  465  	if (!gas->bit_width) {
f0340367a7885a James Liu         2021-10-22  466  		pr_info("Mapping IOMEM for a non-register GAS.\n");
f0340367a7885a James Liu         2021-10-22 @467  		return  acpi_os_map_iomem(addr, sizeof(unsigned long long));
                                                                       ^                  ^^^^
Uninitialized.

f0340367a7885a James Liu         2021-10-22  468  	}
29718521237a1b Myron Stowe       2010-10-21  469  
bc9ffce27962c0 Myron Stowe       2011-11-07  470  	/* Handle possible alignment issues */
bc9ffce27962c0 Myron Stowe       2011-11-07  471  	memcpy(&addr, &gas->address, sizeof(addr));
f0340367a7885a James Liu         2021-10-22  472  	if (!addr)
6915564dc5a8ab Rafael J. Wysocki 2020-09-11  473  		return NULL;
f0340367a7885a James Liu         2021-10-22  474  	else
6915564dc5a8ab Rafael J. Wysocki 2020-09-11  475  		return acpi_os_map_iomem(addr, gas->bit_width / 8);
29718521237a1b Myron Stowe       2010-10-21  476  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

