Return-Path: <linux-acpi+bounces-13407-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B58AA5E9E
	for <lists+linux-acpi@lfdr.de>; Thu,  1 May 2025 14:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4550A3B385D
	for <lists+linux-acpi@lfdr.de>; Thu,  1 May 2025 12:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824F018E3F;
	Thu,  1 May 2025 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HuvSm6lZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C549D3D6A;
	Thu,  1 May 2025 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746103601; cv=fail; b=MESSn5ZZIHadK5nWCeuvXl49rqNSTfNIvOH9sRULnYUCGGBPahUYo1rht4PhI8Nsr3Plp5rFAXsf3tS3s6g7CcXxUZeGJBSHgSZtbaCTdyoVQ+YaImosTnMY75q2YETp8d1CsA/cUqjNCQgLksYGUXINpadYjbcJKMH8K86cguI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746103601; c=relaxed/simple;
	bh=ZA8HeV7LYZsws/xjeoZjClguMYrXrdGTaI52ekjYlJw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MKCXMv1vEdwKZ0Temmyj34+WQekKtBX/r4FF9uT83w7OTTcH28VySYCMgaaQy6tho2TzI76OGogiNhzV4fKsTodJQKzeLGIJDsD+D1DIF49bvCRXPhfdtRPIpSrPv/xHVdJgf4oLSkYVdbkMLErP3ookLbwhHCP4hCBMW4pUxSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HuvSm6lZ; arc=fail smtp.client-ip=40.107.95.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=liz6JsdIpFNI4nnRub9wYMyo09QiIDWqWsZxJf+/XK2COzGChZT+k/Q5jjUl1WNTzeFZrLMP2UjMd27e3xUQRxQCTehk45HJ2NzVUiXowySrv8mLETt5dolkwh9q68yU8TW8hl1zJwb6sXp4S8lJvxBEkCxKfpyKYelezUkhekABjovHMRirx3NTHqYYhsbjkCW7nYLLcD2er9v1pMx55bHO1NTCcxmTnchJi0iycYY6v2Xb5m6z2dv3AkJjhYxI9dbbkyoeQgM83A4BwmI8fRq+3ms0Mp0U2RWmvV4RosTgTlLce1TkOUceA23gwgKUhXThdKHzTK/n/MZsRr9PIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMBh1+i6EFP4LgL+AS7h1EvUqm2Afmoyd01bG8d6ZHg=;
 b=SyDCF8CqRU/NxUWU1/y8qqgmDCRi7lRjj1ZsamutpyzbZaiTahard9d/6cwVV1ggJFpwL3bgBn0dwhPcQJrHJQXnTntD3FVuS0Gt2TvUpCnes2Gh7x6djjKM5mriSxLDYaHO0b82rQiscq0uBs+D2vi0p2vI/OIzX8PlGd4k/PlAkFefI2ImkhCMteix0fOEn6dewF5AFPqeCBPqF/8UJThepQNocgF6WLRAEXOyvCaJFQzxbcysMM9RH4mT/1T1vPC3taORgZZJAU1sUgyfCfXcIEiYMSzqyQ1gd9uGBs40md+xesjQDDJCCujFBGkg23PT6GymXZPGPlj6qDoJEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMBh1+i6EFP4LgL+AS7h1EvUqm2Afmoyd01bG8d6ZHg=;
 b=HuvSm6lZGgMCE4AwdR7StgHlnGHmVK5b1O+O68hFrZze3WH7E0OnXlcK4sWOYM/OxJnR0k6Ueniy2oXVGbd/QpkwwqeMT3HG3TVY19b3Mh0dhOT6+qD2u9yG8962NDYr1AHfMdtBLNpyFW2/o6M36Qc3Nw6cQjAQEF8sDa8h3R6aks6HraL9qwtpdD7xwxOBthk/XivtWtc7avp5bxmPSIzxyjH12a9pf9yZvc6vAqZsfYe/RjDh9PRh1J0ipeB8WJJx1+ZvItxQK2qzTI9aIZVe7+xy2EuIr9F5AomX2BpDlmMIh2WwLDTFilkIoGcSeCtGa8iUKA0tBbJH41iPyA==
Received: from PH8PR15CA0015.namprd15.prod.outlook.com (2603:10b6:510:2d2::23)
 by DS0PR12MB8198.namprd12.prod.outlook.com (2603:10b6:8:f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Thu, 1 May
 2025 12:46:36 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:2d2:cafe::b5) by PH8PR15CA0015.outlook.office365.com
 (2603:10b6:510:2d2::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Thu,
 1 May 2025 12:46:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Thu, 1 May 2025 12:46:35 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 May 2025
 05:46:25 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 1 May
 2025 05:46:25 -0700
Received: from moonraker.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 1 May 2025 05:46:24 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Sudeep Holla
	<sudeep.holla@arm.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] ACPI: APEI: EINJ: Fix probe error message
Date: Thu, 1 May 2025 13:46:21 +0100
Message-ID: <20250501124621.1251450-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|DS0PR12MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f619ec4-ec15-4c3c-0408-08dd88ae3545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7lnpc6OFptny6Yfupm4Qtub35MqCGH0zMUGivB5z3TIdtn+xbO6bxt3DnheI?=
 =?us-ascii?Q?PRbMv9QJJ6/POSxOF2FYdc2+fAjvwMe6WZPAEYB88EsAqDms6UqiyLvO5Kq7?=
 =?us-ascii?Q?2UoyFbCRmV2qfuB4vQ+nibYYyFYBEG4/375dFlx+6ItTCn/29XzmEhpBJ7di?=
 =?us-ascii?Q?FMS/9FTVEKZGKLTezX/+bqvJuJdwqSGvo03W9aA+8MMHNbeYX05MZiCvCRc6?=
 =?us-ascii?Q?9rLkG4pGD36QERgcjXKUvq6EIxccQBZQk41668+1AGZ/A5N/l7foPZlXi+GD?=
 =?us-ascii?Q?thzuhNgN343JXITLjyz+HcrqwgE7cWtfA6UekKFyiTAPaFy7OIKT4CHPsnwl?=
 =?us-ascii?Q?fKgMbofuQCc8v4woAaxNAmmL1dulRddjL4MpvWZlKXcskluwdyPfNTPIHBjc?=
 =?us-ascii?Q?gRJ4+D7UR9UBv+F6c/WcL78q6hzOdBNwlJhqFRm70mzzYEl9IOZz47xQgudo?=
 =?us-ascii?Q?rVSmPpWgBaartuAtDv3dX4tigPk2CLW01oKJ2NRvukYXjArQSDcY5FAGuS5x?=
 =?us-ascii?Q?kUt7eMXdJ6TihSuXlbLpSDD7/KTgNeVdyiX/tD0bkdoAG5KvZcEJeiPsOo2g?=
 =?us-ascii?Q?9kaFSbLa1hjQ+5CkW+opH7aiN68AWpy5Wtx/5zwRLWScuF+1kO15Z4Q6u0t7?=
 =?us-ascii?Q?Q5wlMXVVa8NU0VajYQ6p+kmEC/q3Xo5nn+RbF0CZnvVO2Ucq8Zhn9oeeZPGC?=
 =?us-ascii?Q?DvEF++LnpO0Fs6PCTRnPsezEqU9wqD+j6nebTKviNsGbq9PyPvKCci6P2ID9?=
 =?us-ascii?Q?wETNV3YDTClleNy/JUCx+J4bT20+dSCcJ+2oPTBbMTC4GV8oPQVuf1m+zEHR?=
 =?us-ascii?Q?1MbV+b+hh+FnXhrf2bz+yMIgyRXAS/soLYGHECDPVf8+JrNONbTiWyrWNufw?=
 =?us-ascii?Q?0Dl/mxvJDV2CYZJbnvImsqjns9tncmw5tiLQIXgM91jORCrDszzz3igXj+kD?=
 =?us-ascii?Q?c5s6tp7uGOpyzeXWq7yW1aSFyjbz8Qp86+M9H93MUOLEfn9yV3Yq80xooxy2?=
 =?us-ascii?Q?a7yP2J5Jg0KKH8WhT0/eEe8kkEOqf2u6fB+JpLoiCBJlByYtI1qVZHunGlTC?=
 =?us-ascii?Q?MWxg7aXK8AWcFOsw9V2B9YyNJdMmq8ZTuh+9dked3sgAAqc3wGvVVKbAt9sn?=
 =?us-ascii?Q?ddvKhIyYxSEEi/5MYuJrbVRQmh0oi1mskKY6LDPTGc8xyn/KmLdxVH9e0DCy?=
 =?us-ascii?Q?61/vUcSy6O0UXX40luQvMzpwOJVGHCZ3omut6L2oumN2mTtoqVLGzjQlrplu?=
 =?us-ascii?Q?6jOQya4gQpgjlkV0KwXWwiIzn8/P9caQSrowMAjp/9axfcLPxF/BKlbcvt/m?=
 =?us-ascii?Q?OdX5TFJ1SW+3+KPJnQgiiuP8Z1lHuZVB27uaVqidaIjpiArCPEB3owkOACPF?=
 =?us-ascii?Q?JOwVOF/eLeP6g6Uj+TWMyCkGIgjBKNRcfoKBtKkWiNv1vz48a55z0qVrkAck?=
 =?us-ascii?Q?5DbWu7Zf6Kssm/rT9T++ow4/jnwfDaPyiZfGnCpIijOot40GVhEto7P1JsG2?=
 =?us-ascii?Q?CVaOTQCVqFWoS3Kt3Qe0xsvzSd43C7waqm2+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 12:46:35.4439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f619ec4-ec15-4c3c-0408-08dd88ae3545
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8198

Commit 6cb9441bfe8d ("ACPI: APEI: EINJ: Transition to the faux device
interface") updated the APEI error injection driver to use the faux
device interface and now for devices that don't support ACPI, the
following error message is seen on boot:

 ERR KERN faux acpi-einj: probe did not succeed, tearing down the device

The APEI error injection driver returns -ENODEV in the probe function
if ACPI is not supported and so after transitioning the driver to the
faux device interface, the error returned from the probe now causes the
above error message to be displayed.

Fix this by moving the code that detects if ACPI is supported to the
einj_init() function to fix the false error message displayed for
devices that don't support ACPI.

Fixes: 6cb9441bfe8d ("ACPI: APEI: EINJ: Transition to the faux device interface")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/acpi/apei/einj-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 7ff334422899..ea4fef3a9bb5 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -755,11 +755,6 @@ static int __init einj_probe(struct faux_device *fdev)
 	acpi_status status;
 	struct apei_exec_context ctx;
 
-	if (acpi_disabled) {
-		pr_debug("ACPI disabled.\n");
-		return -ENODEV;
-	}
-
 	status = acpi_get_table(ACPI_SIG_EINJ, 0,
 				(struct acpi_table_header **)&einj_tab);
 	if (status == AE_NOT_FOUND) {
@@ -886,6 +881,11 @@ static struct faux_device_ops einj_device_ops __refdata = {
 
 static int __init einj_init(void)
 {
+	if (acpi_disabled) {
+		pr_debug("ACPI disabled.\n");
+		return -ENODEV;
+	}
+
 	einj_dev = faux_device_create("acpi-einj", NULL, &einj_device_ops);
 	if (!einj_dev)
 		return -ENODEV;
-- 
2.43.0


