Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E07234703
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Jul 2020 15:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbgGaNgq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 Jul 2020 09:36:46 -0400
Received: from mail-co1nam11on2063.outbound.protection.outlook.com ([40.107.220.63]:49825
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730448AbgGaNgp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 31 Jul 2020 09:36:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdU7AexYeoB3UCMOTWYjftuvNVGgE9Ec+eiwOHVO4glYDWMPXdUrDJAF7v18t60qarXIYn9bFfA/vazl1ggjDSGAmDYonKt9Meo0HfkmTjw1FFsToL8Kg0p5hrdhOTrZD7k0NsVZ2u9veU3yhI1WGgXBchuBsdvgktBLfemMdvRo6Y5upxJf3ZIQj5BBHYb/GF56dLc/cO1s7lPldA9FeCLq/1tk6xWr/iugirOkS6vcMzJB4XSIxEN4ga7mIXmJylO7yeQ3hzxfR8yCYsY+u6Ld3i/2+MyCtDXyETvP4PjOsEY4CnuYx+9XkMaXXBojrdfqXyl0WM00I5UmXgK6Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMWnHgql7PQgxAcGhB3FbkbBCsQk0pqWEdreeU+XIOE=;
 b=HfHPrEG7AOYivsBgJynml7e8MckH0Cmf+QzbS9j12ttKCz3m5nN8SHiUh6bUqye/ZPjigo6RM+mW/W4oHVql8aX/zz5u1kR7P1d7RUeV+/u8bvElGtTxM/JD4Q2ykeyk5ZVRhQS5d2TVuJDU4A0N1U7rbC+IWSJP+5HYxooFsG8Cv6P3iT5W2q0Z3lYVX1OZJHIdAicbimXCcEt39GBPKtPiBppmyNQgWRj5qgejFTR1F2Sqf1N0wndTfGXP96qYGxdI73LD5qAjAlQ79Ojb96rZ4n4x3QES94rADWa27Q+FCtmau8XM2JQ4AMOO5zMomYU5Hu5ztW/7Q55NeJLuBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMWnHgql7PQgxAcGhB3FbkbBCsQk0pqWEdreeU+XIOE=;
 b=pjreoHF7qvUQhW8+82jJFJ3iiolhpA/PtX1cdbHwb5G4p4vkn86AOYlQqMJ7/Y38ESWof3ppMseCALKPrZze+WdRBZXLp30aeENRS98JvnHU/EW0dWOZqHQ31xgqltgT5zcFvKFoGtHues7iRHVfk4EQ7E+1Ho4m3T85/L/0WQM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0188.namprd12.prod.outlook.com (2603:10b6:4:56::12)
 by DM6PR12MB3257.namprd12.prod.outlook.com (2603:10b6:5:184::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Fri, 31 Jul
 2020 13:36:43 +0000
Received: from DM5PR1201MB0188.namprd12.prod.outlook.com
 ([fe80::4df1:4ad8:38cd:128c]) by DM5PR1201MB0188.namprd12.prod.outlook.com
 ([fe80::4df1:4ad8:38cd:128c%7]) with mapi id 15.20.3239.020; Fri, 31 Jul 2020
 13:36:43 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
To:     akshu.agrawal@amd.com
Cc:     sboyd@kernel.org, rafael@kernel.org, rjw@rjwysocki.net,
        lenb@kernel.org, mturquette@baylibre.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, rahul.tanwar@linux.intel.com
Subject: [0/4] Extend AMD SoC general purpose clk for all versions
Date:   Fri, 31 Jul 2020 19:06:00 +0530
Message-Id: <20200731133604.12512-1-akshu.agrawal@amd.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::14) To DM5PR1201MB0188.namprd12.prod.outlook.com
 (2603:10b6:4:56::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from local.mshome.net (122.179.42.211) by MAXPR01CA0072.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Fri, 31 Jul 2020 13:36:40 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [122.179.42.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 70c3b6bf-dac5-4e7b-6658-08d83556c339
X-MS-TrafficTypeDiagnostic: DM6PR12MB3257:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3257E36EB1B6714FB73295BCF84E0@DM6PR12MB3257.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sYPwIj4oSv3TECtLU4Pe1ta0OQEGEBh5Ek2X2FpyRPhmhC60Zict5EqL1e3KeAGzJ7a17U7jmbX/e1KWlmmte9UseBFUCDajDHyRrZOOjg0WnyJP+4QytrP/JBzoDoSq9JABeVrQC7OJlUtLk1gIWUY3wa/tBxvtChCgEoBvmzpmO+7ErrXwAIFDDoMPsREY3mw8KPyl8zPDrgwVGwuo5wCeKyr1ZLtDOvvVkn0Fbsva1YS4LJrUST8002Qn7lZ+/4KysFtDXTnQMIloYB+fXWw2AyHGyfiNMIYFRIqYS3cPfRt1DoFS8dngJjPEq9zu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1201MB0188.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(66476007)(66556008)(66946007)(4326008)(44832011)(52116002)(36756003)(6506007)(34206002)(2616005)(316002)(956004)(186003)(26005)(16526019)(37006003)(1076003)(6486002)(478600001)(6666004)(2906002)(8676002)(83380400001)(4744005)(5660300002)(8936002)(86362001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: jW1sIuxzhmI3vL67M1PAhH3uAc/f+4PnL6kgbMO7pLW4KjYI7NLO4c9vCRQGlDzgsZk3Rez3IFiRTtJmL4vmvsebUEnYJLMfL4rfx9u+wvaFDEZBDYxrlP87YsHz8bhZwDuRvwpMbmR8ffYzrpl2ptyC8JQE8h3tLv7/WFGH0svn0fRyzfAhcfYvb3WH5oSXrL8dIRa5xJpGNBW8LuG+8U0B0/pjnqK4ZDKLsPtqGohtVNKLbXgU4GtV3yfVsOKMdhpgawG9iCe+OR54lCcL9K+VqJ5Gm6qT8pVv+PCbCT/4j8jBjhEbDdpaM6i7WCBenjbaT1SqQnq4Ltb3nHbKZNHrk2nwsEOhZWZkDRbRoCKpS8xBk9f6gV4JRuQH2LTR29+7/zYFtWrpqEPS/Go7A8eDE2SbYOzt8UUOtMT2HfSlPJCxrZvrzbh/eoB9T3lKLBsDhfuDUUYyPz29gl3IfrXVPiv3z0rws3+lRLoYyEjYLLWphp0fHQPdxT+Pytf8d+zKJ1C/wBhJ1a8wM3mOYWHzXnMpki3xu7MaYdI7+ONSnVhsQDsDs6tY+fXJBcuZWJMfra79FyZw8NhQlBHQzX7rM854D4p7mZqzOPcl7U5G5w59siskMgIZebSxQsRvdeNwz8wHxCaA6qI8P4YvMQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c3b6bf-dac5-4e7b-6658-08d83556c339
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0188.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 13:36:43.6731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jl4qGKvTzNw+YW2Bkigz1pT4FfYlIG1RWGIMDaEJ3FZmyoGf3wj/SRPDTs+O8ULTaDW9Uu622s/Tvpje/rXp8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3257
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

This series of patch does the following:
1. Changes the name of the AMD SoC general purpose clk
from ST(a version of SoC) to FCH (name of the IP).
2. Then make the drivers support both older and newer versions of
SoC.

Thanks,
Akshu

Akshu Agrawal (4):
  ACPI: APD: Change name from ST to FCH
  clk: x86: Change name from ST to FCH
  ACPI: APD: Add a fmw property is_raven
  clk: x86: Support RV architecture

 drivers/acpi/acpi_apd.c                       |  18 ++--
 drivers/clk/x86/Makefile                      |   2 +-
 drivers/clk/x86/clk-fch.c                     | 101 ++++++++++++++++++
 drivers/clk/x86/clk-st.c                      |  78 --------------
 .../platform_data/{clk-st.h => clk-fch.h}     |  11 +-
 5 files changed, 119 insertions(+), 91 deletions(-)
 create mode 100644 drivers/clk/x86/clk-fch.c
 delete mode 100644 drivers/clk/x86/clk-st.c
 rename include/linux/platform_data/{clk-st.h => clk-fch.h} (51%)

-- 
2.20.1

