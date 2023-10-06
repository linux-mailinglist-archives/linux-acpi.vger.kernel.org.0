Return-Path: <linux-acpi+bounces-477-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 105F57BBCDD
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 18:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 418361C20966
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 16:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB0028E03
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T/875T5o"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A8E27ECC
	for <linux-acpi@vger.kernel.org>; Fri,  6 Oct 2023 15:36:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553D0D6;
	Fri,  6 Oct 2023 08:36:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTkVgTz6PMV3hO3EdJcsHAXySsQfM7MO3GhKc6aB1fqheqvkv+Jn5b2Iurr7IH7oUDHpXyJpeQzOXyLkXPdaTaAChzNdIi6/Z8RzyEElA4bMlab6UUCXBNIwvijom9O7iG0bvdCN2d4PnvLO8pxjSfS7B7PNZeg5b8mBTfpRIzuV35T9k9SMt2Wt1nRe+3hG7sLZTPFIj+nQmkn+GAl4w18R9HYS67jABWv+arHbm/yLbpuHrJ+Tvd0ODiKtlnF+u62WoY0/fox5BLNaju1eJ84dWGbciEN4DURO1PoJ0zW2+Kuwm16y+p8VvO6wacm8KdGHLZkb7FhC+IhaPMx+JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LWo0M/YykPt0GvmKAzli59scERTYjyVtgnuG5Hk9Fo=;
 b=Dhgfp1q8KwrnUKQb6XcI3p7Bp+b2i1J0+4EooK4IJXP1mFcSxcQDavZdrijX5BprQfATOcVWHJDR4GgInndx1TgRzTCeySzaqJDUtJKaqc9huMomhlgOzwUWqYHJQvpf8YcWHUeCkAeWULb0NdySQEFZ7TY31DCNjSk5fkL9SO8GMTNYXU81UDfItMug4VRBw4bNGj0+GwYkwOMaBqT2lpk4NpNPujAfAvLc+dGeciFeEW87lxSENkSgl2spdyAvl16BqdVpADJF9Pl+LlczIUIqMWHkMfZq+vl1UGzmA8XXZUNQcVWfdBUEOX8VZ8uJYIzErE9iT0yZbqQskrK1ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LWo0M/YykPt0GvmKAzli59scERTYjyVtgnuG5Hk9Fo=;
 b=T/875T5oBibnbnokHboLT1OrBBr0c7j9ncFKxgkoBDwzVi1YRqZu/c+J2oYPKRW0d0V34GmMlHV1xvu4cI4xiA9UWREq8gI7Yw95Bza7Nu2VLgNJoEtK1o+G1xlTYaHdp7OuL/T+ZE2AlYBu3CkC9d2IuKp6w7/JrFmF2CI8ByJ1uPfA1QiLr3CO8C4WyhkWVRreLhMf9UzzeCzpXkyvjOMleZTCWNcSPWEBRGr+YzrQZREfFGz1VLZYiy85S7PMdLNWss+BVfaMAnk05DW7N0g2Cr9q/K2LxUZYyzwRujQeKiKy9rIxnfmEhnwrp52Z3ed5BTXYrNYoL8F8uwswhQ==
Received: from BLAPR03CA0132.namprd03.prod.outlook.com (2603:10b6:208:32e::17)
 by LV2PR12MB5991.namprd12.prod.outlook.com (2603:10b6:408:14f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Fri, 6 Oct
 2023 15:36:41 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::7e) by BLAPR03CA0132.outlook.office365.com
 (2603:10b6:208:32e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.31 via Frontend
 Transport; Fri, 6 Oct 2023 15:36:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 15:36:41 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 6 Oct 2023
 08:36:30 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 6 Oct 2023 08:36:29 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Fri, 6 Oct 2023 08:36:26 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <rui.zhang@intel.com>, <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>, <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>,
	<srikars@nvidia.com>, <jbrasen@nvidia.com>
Subject: [Patch v3 1/2] ACPI: thermal: Add Thermal fast Sampling Period (_TFP) support
Date: Fri, 6 Oct 2023 21:06:11 +0530
Message-ID: <20231006153612.5851-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231006153612.5851-1-sumitg@nvidia.com>
References: <20231006153612.5851-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|LV2PR12MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b01857f-7399-463e-1126-08dbc68209de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o4puynI/JPKJfnRr1n3DPP9IQU81aR9PNb967cBatA7jHszo20hIyU4SLqOmb/8lZvqZbPoOeR5a7XHeghU1FLzx6BNejv5IAv4i3DnyzTMysDso0PyedGnROqLEG/lNUuX81DoLi53MjQl0/LNxEyXELw80er1mdt5GXVl9DFrC/poAKwGSmBV+xjSdcWEg7WOpiMWFqLpzhMupz0+DR5cMd0j0+LIAaMWKZQAEAEc96rLXUw/iwFgQuxiSMYCt31uimZY29VVdiG7tWVE0LGx/v+KbYqUhjMTKCxgMdJ6CCkn+rMsb3m8Kgl+dofKvPgyro/KT/mfCfiDUKQk5Ybpi0ul41CRCcYeUCa3QDsnxV7p6sFXzjvQlk7YjgA+Qjqij4vThUgjeh4hpJk3lyEjLlyCVGOga5t0MqKbymutnHEbUWbZAyiOUP2C9EuaMdSUuJbX6r2MOuQ9IvS7YDg8RxYxzjBfD0crWVO3XOBYTlFgXDG5O00Ec0OGRHGaWc+liBZYNdu3b+746odfFwCq2MwPVOtpArUyfaeVkPbYFozBQqboFfNOzw5Vg20wy16mrsHMf4obr5SVT28sRK+DTrcwQgEzKfaMQ4W6+0giGSOPChlod0uo/5i4ZlrlIkfsHJBAMgloJ4spFcBxXdIn8sb1ZQ6dVmmWtnYA8dOvMFuITWOEdtoDXQV81XvAF/EqAlU2upLxC6wfsdDTLh2v+scaHm7oE8KOaH0XzCmg3NG4YD4ORpfzVklj+DQUywin+euCR+I4dcZ4K6cmJjw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(1800799009)(82310400011)(186009)(64100799003)(46966006)(36840700001)(40470700004)(40460700003)(83380400001)(107886003)(2616005)(1076003)(336012)(426003)(26005)(47076005)(36860700001)(54906003)(70206006)(70586007)(82740400003)(110136005)(316002)(8936002)(4326008)(8676002)(5660300002)(41300700001)(7696005)(6666004)(2906002)(478600001)(40480700001)(36756003)(356005)(7636003)(86362001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 15:36:41.4778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b01857f-7399-463e-1126-08dbc68209de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5991
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jeff Brasen <jbrasen@nvidia.com>

Add support of "Thermal fast Sampling Period (_TFP)" for Passive cooling.
As per [1], _TFP overrides the "Thermal Sampling Period (_TSP)" if both
are present in a Thermal zone.

[1] ACPI Specification 6.4 - section 11.4.17. _TFP (Thermal fast Sampling
    Period)"

Signed-off-by: Jeff Brasen <jbrasen@nvidia.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/thermal.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 5c21079fbeb6..7eccb36c184a 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -90,7 +90,7 @@ struct acpi_thermal_passive {
 	struct acpi_thermal_trip trip;
 	unsigned long tc1;
 	unsigned long tc2;
-	unsigned long tsp;
+	unsigned long passive_delay;
 };
 
 struct acpi_thermal_active {
@@ -409,11 +409,16 @@ static bool passive_trip_params_init(struct acpi_thermal *tz)
 
 	tz->trips.passive.tc2 = tmp;
 
-	status = acpi_evaluate_integer(tz->device->handle, "_TSP", NULL, &tmp);
-	if (ACPI_FAILURE(status))
-		return false;
+	status = acpi_evaluate_integer(tz->device->handle, "_TFP", NULL, &tmp);
+	if (ACPI_FAILURE(status)) {
+		status = acpi_evaluate_integer(tz->device->handle, "_TSP", NULL, &tmp);
+		if (ACPI_FAILURE(status))
+			return false;
 
-	tz->trips.passive.tsp = tmp;
+		tz->trips.passive.passive_delay = tmp * 100;
+	} else {
+		tz->trips.passive.passive_delay = tmp;
+	}
 
 	return true;
 }
@@ -909,7 +914,7 @@ static int acpi_thermal_add(struct acpi_device *device)
 
 	acpi_trip = &tz->trips.passive.trip;
 	if (acpi_thermal_trip_valid(acpi_trip)) {
-		passive_delay = tz->trips.passive.tsp * 100;
+		passive_delay = tz->trips.passive.passive_delay;
 
 		trip->type = THERMAL_TRIP_PASSIVE;
 		trip->temperature = acpi_thermal_temp(tz, acpi_trip->temp_dk);
-- 
2.17.1


