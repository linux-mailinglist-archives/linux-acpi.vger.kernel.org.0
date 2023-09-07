Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49731797CA2
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Sep 2023 21:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbjIGTUY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Sep 2023 15:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjIGTUX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2023 15:20:23 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF49B2;
        Thu,  7 Sep 2023 12:20:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQUqF5cq34r/Fu39qENypIXVs8/8WJdeWHz0w7BoOWIRqmLg5KMgx6qiYSOfehZRB1ZSNPvBpXC0Ekg562Mi0w91KWwNNMiQgY+phQc93dUF+oa3ne+dS4l19TnxgIglisHJqMVmOsMgOjuRBc20jgKYtneX5msnysBqQSD+hUI7T1kfVIHgze/S1BgtiJfqo44D6n4AWjy3NXh+dNjhej7/AC10JOcwtdJYt79Yyqv+7urpHa0edOTeRq51jF0iFKtt3rHDQCmeMk1+u0QlQqqSwPqx66UPedZQOVDxxewrOKtstk1+7a99Rl5TMgUUKlzzvifeAoVX4RQRidtmZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqhVyZnCpHLh+Xi0sT4a+34gKljUFALXq0Ad36lVqjo=;
 b=C8AwHP0KLfTkJjNXIt+huv3HRtDz5SeJsnKJtzO7wAQxo4G42u7rT38NYh+geisVTf/9RXnkyuDdLUwMcpLM3rKWgwzgRsyaQAO0GF7uHt/lFrtMD2lQNzGgDY5MXY77+5gIXRmzsobhGKd9yVuss26dOeRT2RNBbfGN4Q1jvKEIrGMgzfFmcg2iZl2UqEpoYzuF2OEGD1vXI70f0HHEh4W4dxWrLqFXs7CksNfedyEhCeqwt/9kDbINb7AbryZKIsWBT3pdEQhm7GHjC4sLmTBatoJwvcK/elazqk7w4uj1gLmVZScYAOEi3YtIl8KO1BX6ek7XxnF8aDiO7QG59Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqhVyZnCpHLh+Xi0sT4a+34gKljUFALXq0Ad36lVqjo=;
 b=uG3KC0I4bS/smSHudzBN8RM7loTJ5lwhyuKMWd9jBaThEQCN+8asiXXYc/P/B9kT3hFWhSpN67Vhab8aDmyDcGOsuANeB9KwNzgUQP2Hbsi07IuotCG8u2C3iF6/I2/TqjNQCEc7osvCH8ijjAaVcN7cLwEEiLaSDunBBfyt0xw=
Received: from SA1P222CA0020.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::21)
 by IA1PR12MB7565.namprd12.prod.outlook.com (2603:10b6:208:42f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 19:20:14 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:22c:cafe::30) by SA1P222CA0020.outlook.office365.com
 (2603:10b6:806:22c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Thu, 7 Sep 2023 19:20:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 19:20:13 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 7 Sep 2023 14:20:07 -0500
From:   Ben Cheatham <Benjamin.Cheatham@amd.com>
To:     <rafael@kernel.org>, <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC:     <bhelgaas@google.com>, <benjamin.cheatham@amd.com>,
        <yazen.ghannam@amd.com>
Subject: [PATCH v4 0/3] CXL, ACPI, APEI, EINJ: Update EINJ for CXL 1.1 error types
Date:   Thu, 7 Sep 2023 14:19:53 -0500
Message-ID: <20230907191956.674833-1-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|IA1PR12MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: 695b4303-7b28-47c2-6659-08dbafd775f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HwvcpSf0T7VjUVeJsFKzjyRbGQzdJ+Vw/AFhHALlRwyCg3Xg++KEdWJnqnVhxGyTv7TBk6SFULSScn4WcahBDsiUU+H/tdnB81uz0A46qwrZ6u3ZTuLRSgaSpv2whaI4nUpVQ++U+B82A6wtZKbzUS2yd5sEyDbF5MuwdXyxxPYjbW35Plxz+JcPBU71OPikhXcaaO8S9TSTPRXnYHGIydWkj+iIEoYodmHO0EQFABAk0LnYqvEZNzSgYaVkqa80BeZHmG8X4YHjPp2uRtyzQa+ofgc9iHKWws4deMIhH8bPg8xjOSJxu+JnUThSpY5YCOZqqkUjaFQxF+0biZfoyzqJQ0JBE/iAPQNUTrKZSGUSpRszLOPZ8bZa8SR7+tZmV5Q0bH98FmELEXLRlrfOD8PctDsJpYaV4xyefXutNU/bUbD2StrRURWXBAGCXA9dco5go/3Gr2mHuQvOly52ep4k9zSwyhFgNfVlh3SoemCsO5wOvinvruvSTu/J9/AJSKM3oa3G/LaCt6BNVOmsWWjTvNKq6bJitGlbj1EBe7jHBmEpyJnQaofpTHiW1S9x+MV3NypqTaK4k4iyllGuvGhNmxwJSrwkHvhkq4QV3+0qxDiD9Tr40wI1HMWWKaKpPC7IxHQaNhxG/bNWfdHxPo8UcY7OAKkxzS2D4hsUA6XKCKZXYMrvRoDjB4ScisnPsTxubVISp6+/oAQ1LMwI0iBj+l66Nu4LP6nIKgr/sGdxTC9FjPZ5awP5DoTUX8mgefBG2nIj8MhR87E13SqCWL7yjcX0oKoOWVwfwiRlstg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(82310400011)(1800799009)(451199024)(186009)(46966006)(36840700001)(40470700004)(82740400003)(7696005)(6666004)(1076003)(966005)(83380400001)(478600001)(41300700001)(15650500001)(426003)(16526019)(336012)(26005)(2906002)(110136005)(54906003)(316002)(70206006)(70586007)(5660300002)(4326008)(8676002)(8936002)(2616005)(40460700003)(40480700001)(47076005)(86362001)(36756003)(36860700001)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 19:20:13.4409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 695b4303-7b28-47c2-6659-08dbafd775f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7565
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

v4 Changes:
	- Fix kernel test robot build errors
	- Add imply rules for CONFIG_CXL_ACPI and CONFIG_CXL_BUS in
	  EINJ Kconfig to build the CXL support correctly by default
	- Change description of building CXL error type support
	  in EINJ documentation for brevity

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
 .../firmware-guide/acpi/apei/einj.rst         | 25 +++++++--
 drivers/acpi/apei/Kconfig                     |  2 +
 drivers/acpi/apei/einj.c                      | 24 ++++++++-
 drivers/cxl/acpi.c                            |  2 +
 drivers/cxl/core/port.c                       | 52 +++++++++++++++++++
 drivers/cxl/cxl.h                             |  3 ++
 include/linux/cxl.h                           | 18 +++++++
 8 files changed, 129 insertions(+), 5 deletions(-)
 create mode 100644 include/linux/cxl.h

-- 
2.34.1

