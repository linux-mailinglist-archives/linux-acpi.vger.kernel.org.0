Return-Path: <linux-acpi+bounces-476-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9772B7BBCDA
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 18:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C80941C20966
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 16:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3200628E0A
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i44/OyAz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12062273D3
	for <linux-acpi@vger.kernel.org>; Fri,  6 Oct 2023 15:36:36 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172379E;
	Fri,  6 Oct 2023 08:36:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7WJDXboVDNe3jqDDRP2pwll/qL+/NNeKcsZsF0VUClqJGJCXtaZ+66J671Qxp4BRv8vprb8RT78qD7vzk04HDWxEIcF8oN2RU6n374PxMGs+999FcPjNNfuLi97pKIzrOzF90SwgQLnoU5CVJ4wnDvHGvw3AlOC46cPcSwhWNH8Y67eAUPZ4XTFLiwqwxR9AmQLuuv81DWtsjaoqmAa3n3I0rxrgGO2l0TobxsGCNOIj8aRCHW/A9B+gdzYYFvzPy0DqlEO0HYoF6EQ1SrifLuzsSeSsBCQ2ipKRCB0RWSl4HWv+pvDy7oVQ44P5d0YVoDAubJolcHzZYONwP4WKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkvPqeTMSwnZAs/RrWayu+sGMZRp1pIWoWOCzjD9opc=;
 b=YkR40YNg7ZXJo/s4R6XqNok3wxNFmch435vq5YN0UE7M0h6SA0Hn/23aSSN8CKiGuPxEi2rRevKp6Xt3/bIE3loqQXj0uD0XR4g++vXc/L/QOvenCHJ7QD5Xn41aRjrZ8f6Y17+c+dGRCcMjmPxjP6WlC6b7S5zqKIEXexFrbbYzkY+ko73bTWb3nUjTSM/TKYjAR8RYlI2hfSiYmQKWuQEeiilxkSl+Rx5okCfK6jMxW6Ink4zoqrkXtGa8NswVXfZiFu+8lC/dbR2LgInvSY71ybhZE06raBFwBc5ZQnExjePzucEOT9/2TnvQlXgMikKO1Te/4KV1dEHBZWdOAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkvPqeTMSwnZAs/RrWayu+sGMZRp1pIWoWOCzjD9opc=;
 b=i44/OyAzwqcPuXURcGn8hVcOPpIZDfm8Jm0mhpYmSPDdEeQkTXCUThe6PCuMy8ZCoBZVEXHhQ6HdhzUy2RAIEWGSNdIm+u5iFCILP6eYI+FvprY+OW2sjg7hj9N+eprIdfiGhRFTIK5iMLInab72BubPWP13g9lzPiM6Xnlsf9JtisBPW4DrJA8lcE1PWHHP/OyuURUiymMe3X8WRWuOnoD+b4Kp0FhZ1Z/ZlzmmzBypVWGX3EdlB3xy9Hh5iEJsY1L4KMLkCo69FNxnKW6yUjWy+cavrKsaeo/fHKXQmGj/k//XhpyXFACmg/xymQ264dnoxHYooIqgupTbL5XP2g==
Received: from DS7PR06CA0028.namprd06.prod.outlook.com (2603:10b6:8:54::33) by
 CY8PR12MB7362.namprd12.prod.outlook.com (2603:10b6:930:52::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.37; Fri, 6 Oct 2023 15:36:33 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:8:54:cafe::79) by DS7PR06CA0028.outlook.office365.com
 (2603:10b6:8:54::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.31 via Frontend
 Transport; Fri, 6 Oct 2023 15:36:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 15:36:32 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 6 Oct 2023
 08:36:20 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 6 Oct 2023 08:36:19 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Fri, 6 Oct 2023 08:36:16 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <rui.zhang@intel.com>, <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>, <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>,
	<srikars@nvidia.com>, <jbrasen@nvidia.com>
Subject: [Patch v3 0/2] Add support for _TFP and change throttle pctg
Date: Fri, 6 Oct 2023 21:06:10 +0530
Message-ID: <20231006153612.5851-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|CY8PR12MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: 37d65f38-1dbd-498c-5aaf-08dbc68204ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6q8kaxYMkWiQHQ+rwHBwRZpft+dtxIt70hKP79uHCPkmzja7nycreKwB2v2erkela2uOZyCflKIxoiUbfIEV7jWDZqkeTChHBlWib8V13f4o7ZXo0IiuMgTksbJenUM/pBQdkivvoCrWHRdUSRFZ7vsqm809AZZsqtNsEOjzf9FbIR1O1Oo32wvS8F0qgdVDFOfRUAU1Bzp/tdhp5vD44IDJv0IDfAb8Ii3DZy0IdvNVewtr3C7/yuHljwTD+zVl2luDx36ID4oUoZwtc8tDRtd++9CX0u3tqQOsfIpSFTQLSjT3zjjyN/8qhJUvNIe4wmV/UcTqJD3+Ox8YVi72lpr5mvccb80oaFURASgXnhfw+vjuJjkUVCPnHI2uoMS5sgFJOtJT9HTZQbdsbgBB7iWqP9uocobAxL6ZsX4O152OdH7W3tqzlmr5+RpgY8uHxtqpMUTEK8JtXRM/LONRVnudRXQZtGyUqy9QZA+z7jCqO7dcAxU84JMjibbq7PAoSGq1kMVJ1LWxZvySI34ldNYCpi/zbt1fzHLaC4adN3ujbDktx3W+VsaWjiwjtmHbq3sf8jyv9wTqR+XBDin6k4akT6qaSiA251lTpg856EHDxUkOmSySEwDE/jDetiDyI5k9P4OMVKs/aC/TcodN0Po6Kv1fBBRSrPhOoMMSyUj5mdKiD4qQFhThy+07Og5ddBI8nNBfyzpU/rgbrnpa9FfVABGVXfNkmNoRGekxE8x0u8ZXqVnFsDfovQBidal9XeEGFY/5OjOqDgYO/KfodnVbuct4XSmcwmpk/ue+iMj8LtslYvrcOwPXsBSRh1DVKU4rbUU/HrQE9nsA+9Q2Dg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(186009)(82310400011)(1800799009)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(2906002)(4326008)(8676002)(8936002)(5660300002)(54906003)(41300700001)(40460700003)(2616005)(70586007)(70206006)(110136005)(36860700001)(40480700001)(316002)(36756003)(336012)(426003)(7696005)(6666004)(26005)(107886003)(1076003)(82740400003)(47076005)(356005)(83380400001)(966005)(478600001)(86362001)(7636003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 15:36:32.8350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d65f38-1dbd-498c-5aaf-08dbc68204ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7362
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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

 drivers/acpi/processor_thermal.c | 43 +++++++++++++++++++++++++++++---
 drivers/acpi/thermal.c           | 17 ++++++++-----
 2 files changed, 51 insertions(+), 9 deletions(-)

[2] https://lore.kernel.org/lkml/20230913164659.9345-1-sumitg@nvidia.com/ 
[1] https://lore.kernel.org/lkml/20230817093011.1378-1-sumitg@nvidia.com/

-- 
2.17.1


