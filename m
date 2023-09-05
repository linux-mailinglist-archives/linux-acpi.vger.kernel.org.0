Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35945792D98
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Sep 2023 20:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjIESqK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Sep 2023 14:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbjIESqK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Sep 2023 14:46:10 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on20604.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::604])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36D2CFB;
        Tue,  5 Sep 2023 11:45:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDdJj3BHAQRDgCMyUKJktI28Q97hWAFEtEchl6ITb0wYHNB8N8Qw4+vdrrutfJgyvv4Ngyty3fgsQrMix222FKcEdu0MiJnNuBsaJmd87wDeGqoldW76mUbiwl/QYtIvby3utzft8/BabB4L3UN5Llz+SzbppBtN6JrfvYD7l1luFGnA+EkoM06KMZfbheRAV9GvDtc694gV2dnHCEwNKvRNa1X0dPiv+F9hTxLKQ6dI+zYISpGPUBuuGDkkj7aO+0/mE7KCqYl1a0q8uJDFz4jgJN7hxEQ0kJtfaU29pZyfQWgV4qMo+X55sE+F8ay1NjkSRtEqt7llO/psb4NpsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwJYvfRlXToyD+xkMD/NcRPQ5+NlD12l9uuut6vBhy8=;
 b=kEQjvSTJpPolwt+gpJtgf0V++vd1SUz0lVCfIT1Xuoira4Vj/yNdhBwYvSZH7bI9dW7xS4OEHNCgOzigUZfNiEQAvIS9GOAOgU9b75nIuZlHzZmw1TYSZTwgfJQT9eIMaJWzBX7HuZwTT8I3vY3WtQ7q/acQ1Di9fgFskYSUWGeJCoQGYJiljYHgXLLUjB7Pd6Voj53IJdukH6e73s0IYA3cpi/czKv9Um/04TVxIcj3fFvCKNiU/IMT+fyqctNpcoXwLy6dWTSkK/sctW7x3de6RN/XVtc/QrCVqzG+rA94rDkV0InMWG/YGhI+Ygn+OI9mzxWNAeilfV1F0kTXPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwJYvfRlXToyD+xkMD/NcRPQ5+NlD12l9uuut6vBhy8=;
 b=bD34RIBjx3bZpWPRKu893I2YRciEszL782XxbA/W4can58/R+VG/ppn4jETa4XJTxzB7ZRPtkvdP2l96jyEkYwJ+xtqEX0Pe4YPHZAiVME+R+qJ37+N2sBIUPo/iJ2J+2K1dxpetNa89vM13AxNEDQLzqmgtYiqY5ujMO2DLeIQ=
Received: from MW4PR04CA0276.namprd04.prod.outlook.com (2603:10b6:303:89::11)
 by MW4PR12MB7192.namprd12.prod.outlook.com (2603:10b6:303:22a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Tue, 5 Sep
 2023 18:44:21 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:303:89:cafe::11) by MW4PR04CA0276.outlook.office365.com
 (2603:10b6:303:89::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Tue, 5 Sep 2023 18:44:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 18:44:20 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 13:44:18 -0500
From:   Ben Cheatham <Benjamin.Cheatham@amd.com>
To:     <rafael@kernel.org>, <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC:     <bhelgaas@google.com>, <benjamin.cheatham@amd.com>,
        <yazen.ghannam@amd.com>
Subject: [PATCH v3 0/3] CXL, ACPI, APEI, EINJ: Update EINJ for CXL 1.1 error types
Date:   Tue, 5 Sep 2023 13:44:03 -0500
Message-ID: <20230905184406.135851-1-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|MW4PR12MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: c90bb555-0fd2-4a9f-8e23-08dbae401df7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pTC0x0gQtLv2j3tGNMDq8YG4atua0sTGno+Wn2IhqzssZhCR2l2J32FV5JhXuI1nIniCu8xYaMqRr2uPEoPnRjXUOk+fxtifGrqtIvl2A+/2sfxP22KEcwzVj8uroi3SosTZiGhIHEocWRPZP6NK6bKU/DT3GA8CWc2dRegWN5eB3fplZmxYi8YOgig3QFbOPL1I0s0kv7c+h8sejTj2aHnqtDI6lv+4MK0sW0l6xg1g3bQgnJ01Cgx8PhRUx4tVam5fw8EndXAFWPiFzsHXqSJdCIZorCgjq4a9OQDr3M6J/UbNDg4mSTK1Pc5dDIaYrTLwT89h+fys+XBla5ScOiWsqIij0+4kfUfhBimQh65YoHayBVR7O8dQhNwFVePettf6HoQqwtiIyOr3KaNVA2OdG7fDhCFof93AzK0o3QuEqseZ2DJQW6+a/sVkROz9WTu6rvKCXDaTbqkMDpZ4SLvljThKYWOF1RZuaPF13Kt4Ws/v40pAsCMB9uhwbWl+cIHrMv3atBqbRqJtLfAwI7JorhvupqF+/aFY4qFylzEat0Bn3r1IqwaSdZAagN/NrrYfpeSAULnDIIxZ38d3e3Nz18S5JaKj+VsfNg5ILlIwJIeShfEV4all7gCUQ6jWh3PCcs25NwTeqNay83mEZMjzPY1ZV7ZgeXpWpcY5QJmUjK2opUkk5Wp+4MtmpbcytAfxgY95dlkZD+7MkP+D+GpgQpNQ5Pe2X/wilIoO8VGRtP9Bqhwwu4BKr1jZI0Lm3q4IWO/0WmHgVK26y54LzQ5tq3nCWTIqXvFYVS8JSaI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(186009)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(8676002)(8936002)(5660300002)(36756003)(316002)(54906003)(110136005)(2906002)(70586007)(70206006)(4326008)(36860700001)(41300700001)(40460700003)(7696005)(26005)(1076003)(16526019)(40480700001)(426003)(15650500001)(47076005)(336012)(82740400003)(6666004)(81166007)(356005)(478600001)(966005)(83380400001)(2616005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 18:44:20.4772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c90bb555-0fd2-4a9f-8e23-08dbae401df7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7192
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

v3 Changes:
	- Add sysfs files for finding valid CXL 1.1 downstream port
	  MMIO addresses, along with validation of said addresses
	- Update EINJ documentation to include relevant information
	  for injecting CXL error types
	- Dropped Yazen's from tag

This patch is a follow up to the discussion at [1], and builds on Tony's
CXL error patch at [2].

The new CXL error types will use the Memory Address field in the
SET_ERROR_TYPE_WITH_ADDRESS structure in order to target a CXL 1.1
compliant memory-mapped downstream port. The value of the memory address
will be in the port's MMIO range, and it will not represent physical
(normal or persistent) memory.

In v2 [3], the user supplied the MMIO address for the downstream port, but
per Dan Williams' suggestion [3], the addresses are predetermined and
the user only picks the error type to inject and the downstream port to
inject into. In order to inject an error, the user write the error type
to the error_type file under the einj debugfs directory, then writes any
integer into one of the files under the cxl directory.

[1]:
Link: https://lore.kernel.org/linux-acpi/20221206205234.606073-1-Benjamin.Cheatham@amd.com/
[2]:
Link: https://lore.kernel.org/linux-cxl/CAJZ5v0hNQUfWViqxbJ5B4JCGJUuHpWWSpqpCFWPNpGuagoFbsQ@mail.gmail.com/T/#t
[3]:
Link: https://lore.kernel.org/linux-cxl/20230403151849.43408-1-Benjamin.Cheatham@amd.com/

Ben Cheatham (3):
  CXL, PCIE: Add cxl_rcrb_addr file to dport_dev
  ACPI, APEI, EINJ: Add CXL 1.1 EINJ error type support
  ACPI, APEI, EINJ: Update EINJ documentation

 Documentation/ABI/testing/sysfs-bus-cxl       |  8 +++
 .../firmware-guide/acpi/apei/einj.rst         | 26 ++++++++--
 drivers/acpi/apei/einj.c                      | 26 +++++++++-
 drivers/cxl/acpi.c                            |  2 +
 drivers/cxl/core/port.c                       | 50 +++++++++++++++++++
 drivers/cxl/cxl.h                             |  3 ++
 include/linux/cxl.h                           | 18 +++++++
 7 files changed, 128 insertions(+), 5 deletions(-)
 create mode 100644 include/linux/cxl.h

-- 
2.34.1

