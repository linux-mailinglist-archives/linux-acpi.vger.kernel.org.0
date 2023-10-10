Return-Path: <linux-acpi+bounces-572-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4DD7C415D
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 22:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEAE41C20A06
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 20:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB6C225B1
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 20:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gksTjaIG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8A92745F;
	Tue, 10 Oct 2023 20:03:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50747FB;
	Tue, 10 Oct 2023 13:03:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EM8B4mog/98Ar7LHC151nN6VuZSNyT2OreMXbnh9xn0hTjQz5hEiF6MabmoJEoDNx+SCmeWqDY+Q6xuGLs4LcWt3pQGGb/bUjvRr9gKs4jNuXFrwsAtIERfUCIQQ4vPMf7QQWSdwO8ExRwgwS+SZltTdKtlFd8gKzE6uunIOQM7hPSV0+0pL24L0Cl14LRdNUUwXA3fi6EsEgkw7aFEnGgHTXEdVYPyB3rcw5zCr7AgxyhJxmwMYq5enzpApIZhrLt+GuPNoKmLi2QQHktRQnRgmxldo2ClygbH2ynzaaumwDdwTI038k1+m2SWDCjMHqH/VH7CHCqGdiatAowQ+HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUxIEXdpWjvHucilrNQJt3KojMbevuDw/g2WkUtA5+o=;
 b=LKTWR/DM6lLWtpciTGGzZPWSSkZur7lhrkM2BpkdG88NHCNzQtYXLWlfQwe25eIrpDlXEzqQ1I9V1UzZn8u2Rbxaa75rBj6y98sqbE3DWxe1YuaZGzJ5AgPg17XuRPF3A5NP2gja9NT254ON76rKnwtYct/n8370Gw+abszQgiIHgig8XfK2hNo8uO3Ti9ApJ5+LFG604+HNbJPNq/iApg8cfY97Eblncd7p5cMUWdBzlYVmStaR1t1QfiyTJlR1uVtjMnM/a2naK8cV+oTxSyomCq8efx9W6lzm9bs2TcjqYo7chtKUkOpgJ726aL/u5mdUvUJYBgspRSGKq1dW8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUxIEXdpWjvHucilrNQJt3KojMbevuDw/g2WkUtA5+o=;
 b=gksTjaIGrxa8yCbILhhq50wPFLeS17RhKdsd7xdVAOzfycXpcnUgrUvpLY+nCGS+4gi9GqlGuu+xlbMvb5EILimDXA9m1YIiVpKq8VmFoJ6/a6aQhvaTCIfxJzQI2byUs65aAoQg6D8jJQZct68jSvOaT5g20//G6k5Oit99QUs=
Received: from DS7PR05CA0004.namprd05.prod.outlook.com (2603:10b6:5:3b9::9) by
 DS7PR12MB5960.namprd12.prod.outlook.com (2603:10b6:8:7f::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.37; Tue, 10 Oct 2023 20:03:28 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:3b9:cafe::13) by DS7PR05CA0004.outlook.office365.com
 (2603:10b6:5:3b9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.20 via Frontend
 Transport; Tue, 10 Oct 2023 20:03:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 20:03:28 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 10 Oct 2023 15:03:26 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <rafael@kernel.org>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <benjamin.cheatham@amd.com>, <yazen.ghannam@amd.com>
Subject: [PATCH v6 2/5] ACPI: Add CXL protocol error defines
Date: Tue, 10 Oct 2023 15:02:51 -0500
Message-ID: <20231010200254.764273-3-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010200254.764273-1-Benjamin.Cheatham@amd.com>
References: <20231010200254.764273-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|DS7PR12MB5960:EE_
X-MS-Office365-Filtering-Correlation-Id: 97caa6a6-6a7d-42d9-0359-08dbc9cbf82e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QrUj/H+05Ujr44pJaYcpW1IS89WO7YPHjAuEq59y25ROz/fOEOXUEY3ihXmvDo2aiow/PB1bs+M1i1CIEPpUulFEISiZDIZOaeY2b5cTktPbVVdPabuZy9kK4pQ5YrUESYk1C4AOb5IzIQVLorHS3Haq0tntGvwNII07X2xx5kSHF+vuGtIuUQ6f/MzTJhnbSiUih9BazSX8s+hpeSqJYKj/XiCfTD4TyxgkUzUVmNGv9Y+rkymB+B/3ZcstzOpBkDm/e8un1DONZJ304rvfcvgiB8zGt9V5Ku+MqSBHiNKMHYDNtX11tJ3Kpxsru8/3sk23Ga+iz3GKiox90JHlSB683ggqodXseruhAPBluPrxhcazp+qVg4rFX1MIA5H2GBMdEeqU2jF7z5MgLCJ1m7Zhu5wMUx+lf1I4kRiVtMZ2dAxAFA8Fkij1QmeH5bSKONnvqClDb/MilK8YdETNkSxDAaWWOkeF4ixyRzrEfaVFrgXDSMZiswKI21aoYwLwj+zlgP6uHSry5J0FAVxvImhCxX0QtNgT3TgygnZdiaHm6hCH7Y7n/PGmDWr+1f8Syfnt/8HKXD3gINTWUVgxmXv3rfGbj32K+udeqPDceE9LUGxmMC8PpFE0ayBeJAOh/pVT6L9A0snY73Q9i4NaIjwLdEQLCAzXikqF6vB/OLIPlge+DddZ6p2f7yYMZU+IoSv3YbEA9euQYMctSWAql+uV/tVYCTvCVBFEn8eB4O2M6ERfHmkxHBAVSVSvhRg8rziQvYDILKV6vj94Fkvx5Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(6666004)(7696005)(2616005)(1076003)(82740400003)(40460700003)(86362001)(316002)(40480700001)(36756003)(81166007)(36860700001)(356005)(83380400001)(336012)(966005)(2906002)(47076005)(426003)(41300700001)(478600001)(8936002)(8676002)(70206006)(4326008)(16526019)(26005)(5660300002)(110136005)(54906003)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 20:03:28.1585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97caa6a6-6a7d-42d9-0359-08dbc9cbf82e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5960
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add CXL protocol error defines to include/actbl1.h to be used in
later commits.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---

I made a pull request for adding this support into
the acpica project that has already been merged [1],
Feel free to discard this commit and use the acpica
changes instead.

[1]:
Link: https://github.com/acpica/acpica/pull/884

 include/acpi/actbl1.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 8d5572ad48cb..9741f1c40a4e 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1093,6 +1093,12 @@ enum acpi_einj_command_status {
 #define ACPI_EINJ_PLATFORM_CORRECTABLE      (1<<9)
 #define ACPI_EINJ_PLATFORM_UNCORRECTABLE    (1<<10)
 #define ACPI_EINJ_PLATFORM_FATAL            (1<<11)
+#define ACPI_EINJ_CXL_CACHE_CORRECTABLE     (1<<12)
+#define ACPI_EINJ_CXL_CACHE_UNCORRECTABLE   (1<<13)
+#define ACPI_EINJ_CXL_CACHE_FATAL           (1<<14)
+#define ACPI_EINJ_CXL_MEM_CORRECTABLE       (1<<15)
+#define ACPI_EINJ_CXL_MEM_UNCORRECTABLE     (1<<16)
+#define ACPI_EINJ_CXL_MEM_FATAL             (1<<17)
 #define ACPI_EINJ_VENDOR_DEFINED            (1<<31)
 
 /*******************************************************************************
-- 
2.34.1


