Return-Path: <linux-acpi+bounces-544-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BE87BE991
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Oct 2023 20:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E158281993
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Oct 2023 18:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21513B281
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Oct 2023 18:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cOLes37G"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE82134BE
	for <linux-acpi@vger.kernel.org>; Mon,  9 Oct 2023 17:19:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE65CB9;
	Mon,  9 Oct 2023 10:19:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUGIhZSgQhb3ro38uvWzPSut+GmGWKwonUl5sGaI3jDG66A4+u3IA/bScnJQ0pN1wjXNiQdph2qk3hdDp8PBKk8WV1ozdq8ox2FAXYLcsGUhR93GXsXw27UZosZAjY7GzZK80bqB8xgrfFlv+L1FRVuZd/UUClLBbuDM90ykyKEaBjwHl1LsQUu6A18+64I2lgyOxp6obl0iphhRkI+HkxjEJMemC5lARGeecp7fXgqUxokhPjLQUJLYRdjgUbScpH2VaccLxJIqMMgRtr9WGW0broMrX/6sR574qJ8F5zS2ejwDPgZjhNUpeDpFZUHlX4KNTcpVUZ619pAbP00GoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDeXdDo90VaiTGL6pyucbmL+eGTtCKZ4n5Z33toR1U4=;
 b=L23XRMfWl2JCYzhJ9umS9gx3SBcs4n9Dtdtd1exwwVApAE4qoDnQYj6zlDsr5p18bTPG4Rp1D3qrqzLfoodpiuOl7/eaJ2DrTA/j6cNL/rJB4ASxi9Ap1YKrawahiaYDK8Cwx6+DT/A7kd379Wo3HWStWixAXJV1af54KD6/eouE3tIGFVgCX0/c+9fk7wfmLdXSLFDSuM+/8N9ih0TKE2LqWP3z5NKkhHsAIzx6RUfcEIEu1IpqwktC9e2rUXahaATLmTBZL25Zz53+AaSrO6N5xMgZUwVHP/H8C4j+t1fBnPnObzY+DhzNw/Unp9B4NiLqyFEbrbfoCbhzwlIsww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDeXdDo90VaiTGL6pyucbmL+eGTtCKZ4n5Z33toR1U4=;
 b=cOLes37GOBeVoowwRSqM1IZ7r7z5gVyjSsUi3ATIqf69b8r3Uj+E22qYZrY61GVxbMzUusPAF27RRruDtMrOuzIXjX9QQLd3nQXWXqjVVTU0NMDONIzT+KkhDIiHgFf4WCMXiH4Udexiv0Oa53YL7FKKWlfW5T1SUnKXTyI14+OGLn3v+b8pCPXiAeZGMhdNeDm8oCP1uw89cVxyhPDscUlFXYomezZl31NsVdYwHi+tBLXNPOyyYPvC+Atuiv6CnBzuYpKe8jUnIX4jSoCW1gk9q7UPvqlaYbme+KIpIc1wTvdxIBH9EsydZo6MYMcMdErnCFQbNNF/ktYhV2ohPQ==
Received: from CY5PR22CA0101.namprd22.prod.outlook.com (2603:10b6:930:65::15)
 by CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 17:19:11 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:65:cafe::2f) by CY5PR22CA0101.outlook.office365.com
 (2603:10b6:930:65::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Mon, 9 Oct 2023 17:19:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 9 Oct 2023 17:19:10 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 10:18:54 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 10:18:54 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 9 Oct 2023 10:18:50 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <rui.zhang@intel.com>, <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>, <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>,
	<srikars@nvidia.com>, <jbrasen@nvidia.com>
Subject: [Patch v4 1/2] ACPI: thermal: Add Thermal fast Sampling Period (_TFP) support
Date: Mon, 9 Oct 2023 22:48:38 +0530
Message-ID: <20231009171839.12267-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231009171839.12267-1-sumitg@nvidia.com>
References: <20231009171839.12267-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|CY8PR12MB8412:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ba80d6e-682e-4145-9f28-08dbc8ebda73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ST1xfje7w+S/tettbRS19238mBFAAQz2ALjRfxU6YGWjHiYJpgbOjoIhRuSFD/rPlAXKQnnCLhzW5atR3DAUgOCo32l/ku0dkoPmzNAC5ONJ4tLDyurZhxHMFFrP5akdub6kg6x0DgHXvWGmROJCigtq8tE0wgjEb6a5naaMQp5fFEtC6CcaHHl4EvA3l6DJrB8EbhsmqftmC6TplkC0iqiPQe6vt/LPjwOjxNcNH96u6TmUoqeEpeEfPcvl1uGcEEOG6IPBBHcgU3C4yzHI+ZtCI3wrxnv68GxpQjokQ/GOmEKbidNTHa3fqz5Mkirb0iw5KbIuht/nb1YXuUtz5vgrVlKm3wLYP7OgB8TybabCq+0arxSXmuRxj/4qyCYbdR5UDCHr5wydecUyKd6bMVL9KmtI4KAEOuYbUtK1f5DpVBQ5uMxb8jIt1tl0LE3TYqndzVqVpwXlPgLSXJ9RVdA05I/qlp3fIWsM0R0c/URe/r17qonOrbZ6T6l/TJdJdaLfiAAgJxh5rgDJ7bfmvIW9GXG/TgoIFuXyNqpGddDbk+0xmJv/w0OBbS3+nfmzRD+SGLj4DTRMDQkDm+0KJdQqcTcWKhEn4U5I8f9xJrzZauwT3iAN4KoX0O77LmG0eFHZEmW0XGnX4Gt6p+1N45n+5fZtP8ZCHf0bwHvfUiXVoK2ywidfooAPU9/JT1B+SI3dHxH5aVr2NzaBLM9exw2UpmUG3RoAFTWRH99+8u1+J8rwmxQFlRlDl0ukLi+lSFa6wSwh75dXR3jivoAccQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(82310400011)(64100799003)(1800799009)(186009)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(316002)(26005)(47076005)(336012)(426003)(83380400001)(8936002)(7636003)(82740400003)(36860700001)(356005)(8676002)(40460700003)(4326008)(70206006)(478600001)(70586007)(41300700001)(54906003)(110136005)(2616005)(5660300002)(107886003)(2906002)(6666004)(7696005)(1076003)(36756003)(86362001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 17:19:10.9531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba80d6e-682e-4145-9f28-08dbc8ebda73
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8412
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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
index 356d577689ff..e360aeebd249 100644
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
@@ -404,11 +404,16 @@ static bool passive_trip_params_init(struct acpi_thermal *tz)
 
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
@@ -904,7 +909,7 @@ static int acpi_thermal_add(struct acpi_device *device)
 
 	acpi_trip = &tz->trips.passive.trip;
 	if (acpi_thermal_trip_valid(acpi_trip)) {
-		passive_delay = tz->trips.passive.tsp * 100;
+		passive_delay = tz->trips.passive.passive_delay;
 
 		trip->type = THERMAL_TRIP_PASSIVE;
 		trip->temperature = acpi_thermal_temp(tz, acpi_trip->temp_dk);
-- 
2.17.1


