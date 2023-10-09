Return-Path: <linux-acpi+bounces-543-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A09AD7BE990
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Oct 2023 20:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599A02818F3
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Oct 2023 18:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B694156F2
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Oct 2023 18:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jGyRaUR5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B73B134BE
	for <linux-acpi@vger.kernel.org>; Mon,  9 Oct 2023 17:19:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D4794;
	Mon,  9 Oct 2023 10:19:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHUL70zGivipWn7hXOcEtxd6yr3eVN8QSrgR+OTC2OTQdNbSHOd02L0yIsfm+zyjoS7bZjsS37IzGfqjW+nrL3mbgjYUkuIpcDYGYFq5naXBBDj4YAMfTum3p8aEpqLATOhlnI8qjsZfurvxH8QvTp8u+WVE2norFIZJrwhbRUFuttSAaxLziNqmRsTzEw+t6sMPOte+PGa1fTMMNQQNNFvwJTjnGDHuK9jhSMPUU5EeBdOoJYmdPAnCXxZlXiyhk8cXQ4QWp0TYcaScjefJZGJfug3Vx4CbaGI7tKac2n9CIWcdxKNM1HXR1dkakcCEjPO6liDA/0utWI/AcSkY8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cy5I2jucoEMzyo6VymD6meBrAITop+xJ7h9KkdPX/3U=;
 b=JVHKDbP4JGa2XudTl6TqzOvmvJEtdoGEKdKfi8h8MdhsegDEo91zPiAlyaI7zZ3vEe42z5QrpURfleOEePdHQRbHShIH1R9rOqXffx1xktZ55aEak22L0Z7bX6sWAMI3vPbofHTtem0AOcGVw1czEgvKo+alf99lt8UxHywC61sAwqk+MyIrEsfiPrj7vj9vpVz3eW7gO610AXU4++eaz2zqPwV8LuV6ZSJaWxjIVSIfpvspIdA7I/NVvgATfXfLwbArKO3pwVgaYgKe9nDcy/lV1WEvp080qD+R1DQTaJo5H2g43VvQXBKUZbvsKTXX+bG7q1jKH/fp2ZG7hL+PoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cy5I2jucoEMzyo6VymD6meBrAITop+xJ7h9KkdPX/3U=;
 b=jGyRaUR5WR4aqnXjVXq8f6/pEksdboqshW0DkeRYvE1F8sNG29ptcR3RZxPxo++WThVFHenAiYD3Ke2R234WyDwYCLc+vVOhOtsfuk+z425/0/bRVUfWXPW8kgBPEwgf6n1++SKp6Nd3aITbq/nxupzvx1WUpF01MJYi0ZbrDNS5yECQoksS7g+nV4o1rp08ZDb2dKU6+3S7jaLQ6t5hNuGN7XnsWFiS6bSB8+hLI8ChYE3HGzNTp2l+ScXoPWIshRKX+zFRtWsQXtbvybCjTUmjc3epf2nQoDyk4CkKp3vjosdi5xqj3zdW5BQYfRt43Zg80SKaloH2x2HDYlvRjA==
Received: from CY5PR22CA0102.namprd22.prod.outlook.com (2603:10b6:930:65::29)
 by SN7PR12MB6766.namprd12.prod.outlook.com (2603:10b6:806:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Mon, 9 Oct
 2023 17:19:02 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:65:cafe::70) by CY5PR22CA0102.outlook.office365.com
 (2603:10b6:930:65::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Mon, 9 Oct 2023 17:19:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 9 Oct 2023 17:19:01 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 10:18:46 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 10:18:46 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 9 Oct 2023 10:18:42 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <rui.zhang@intel.com>, <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>, <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>,
	<srikars@nvidia.com>, <jbrasen@nvidia.com>
Subject: [Patch v4 0/2] Add support for _TFP and change throttle pctg
Date: Mon, 9 Oct 2023 22:48:37 +0530
Message-ID: <20231009171839.12267-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|SN7PR12MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fbb2967-7262-43a3-2d09-08dbc8ebd4f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IIxoPLM4H2+qZzMxDrc0yoZRLsUIH7UJBE48bAwMHaudTKfNABHZG7TESct/4xfX998V/ALVaS9OBtPIoZJfRt9esLg3AC+XXeGFMOvmkR1rjojmy6h8iIHcKdAGgaj6EVPDFbUCXjUhcbbMp8qJa73S/yyNeR92THDEGjx/jryhRQp4mhZhT6fa5J2L1uZGO3wLGRDZoIWc4F0LYEtNuoTt2QiFCnHC4m+W9BiWw6VzQmAlg3aJxji6CLCr3Iy+qs6UX8ffX/fB3p5GXpk9TJQCboBJThcoXehnQ/NHCSYwfTOrPDfUNxpcj3V1TmCfetDqzTJarobwHUxckT1cIwJcdAj2Hf0ccP4UTooavgn/L7MER1vbMBcy0Zi/Uw54h4oP6iXsOuzKdNKs7VIX9YKAZ1hdkka01kAoHW0OWcQgfuat6IwqiBluYNDT1OiP6EApWoTa1ExLLxoWSmS5gNilHKSw7Fjn7awefhUdvQTqsOegjsS5ImtDtDYBE6b8csq4lftkIbrVg27T5+HiEEGxqeQmr1FuaMSeqp0EfouMbjzFg2dn3iW+J4fb+Li+0GJwS6la2vdGGcFkxKI5RV8xUJfSceI+NFTZvgB9Bx2vD0NbCG675Dx0YcBBtWyx/z5BHu/jt0aJ3r+D7+HqW8JULM8G4/R9antvcLHvhKc69v1lXgAnltK+h+XMSk9/ncbhe1Dbpfjl1rVltfijqAiXkJefD0CujiFTqN34HpZAIfRugLlV5GdtNUKnTu3FqhGxx5CCeIVrFHLteDtDc4jUgopFHEBI2zqBkWuqy5FL6pswMBAN8eCh6+TWonE1FPn4v1Bw8Zn/m9EZtMqTUA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(82310400011)(40470700004)(46966006)(36840700001)(966005)(40460700003)(107886003)(6666004)(336012)(26005)(426003)(70586007)(86362001)(7696005)(1076003)(70206006)(478600001)(36860700001)(54906003)(47076005)(82740400003)(83380400001)(40480700001)(8936002)(41300700001)(7636003)(356005)(2906002)(36756003)(110136005)(4326008)(8676002)(5660300002)(316002)(2616005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 17:19:01.7030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fbb2967-7262-43a3-2d09-08dbc8ebd4f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6766
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch set adds two improvements to get a finer control over the
impact of thermal throttling on performance.

 1) Patch 1: Adds support to read "Thermal fast Sampling Period (_TFP)"
    ACPI object and use it over "Thermal Sampling Period (_TSP)" for
    Passive cooling if both are present.

 2) Patch 2: Adds support to reduce the CPUFREQ reduction percentage
    and not always cause throttling in steps of "20%" for Tegra241 SoC.

Both patches can be applied independently.

---
v3[3] -> 4:
- Patch 2: move ARM code from generic to new file 'thermal_cpufreq.c'.
         : get 'cpufreq_thermal_pctg' value for Tegra241 from new file. 
         : move dummy/null function to 'acpi.h'.

v2[2] -> v3:
- Patch1: rebased on top of linux-next.
- Patch2: use __read_mostly for the cpufreq_thermal_* variables.
        : add static to new function acpi_thermal_cpufreq_config_nvidia.
        : add null function if CONFIG_HAVE_ARM_SMCCC_DISCOVERY undefined
        : removed redundant parenthesis.

v1[1] -> v2:
- Patch1: add ACPI spec section info in commit description and rebased.
- Patch2: add info about hardware in the commit description.
        : switched CPUFREQ THERMAL tuning macros to static variables.
        : update the tunings for Tegra241 SoC only using soc_id check.

Jeff Brasen (1):
  ACPI: thermal: Add Thermal fast Sampling Period (_TFP) support

Srikar Srimath Tirumala (1):
  ACPI: processor: reduce CPUFREQ thermal reduction pctg for Tegra241

 drivers/acpi/arm64/Makefile          |  1 +
 drivers/acpi/arm64/thermal_cpufreq.c | 20 ++++++++++++++++
 drivers/acpi/processor_thermal.c     | 35 +++++++++++++++++++++++++---
 drivers/acpi/thermal.c               | 17 +++++++++-----
 include/linux/acpi.h                 |  9 +++++++
 5 files changed, 73 insertions(+), 9 deletions(-)
 create mode 100644 drivers/acpi/arm64/thermal_cpufreq.c

[3] https://lore.kernel.org/linux-acpi/20231006153612.5851-1-sumitg@nvidia.com/ 
[2] https://lore.kernel.org/lkml/20230913164659.9345-1-sumitg@nvidia.com/
[1] https://lore.kernel.org/lkml/20230817093011.1378-1-sumitg@nvidia.com/

-- 
2.17.1


