Return-Path: <linux-acpi+bounces-14986-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5868AF8549
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 03:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C4B01C28497
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 01:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF4C17A318;
	Fri,  4 Jul 2025 01:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RCYc24oy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD8519D8A3;
	Fri,  4 Jul 2025 01:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751593560; cv=fail; b=NG26HFLq20k/gXmjr9J5xVDUpIZ3x9o0EhB8hTJNeyHORBSYkHdeN0lmJTU9r/TVG/Xj4VwVNutW0Vb16RpkfEyrV+jXnRySp4y6P7S3IRPNiDaBYkxy+I+OPrgEu980Fa8MvF7F0qMHKmZRs/mBxw/TXCzu2SUEHHQBdez6D1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751593560; c=relaxed/simple;
	bh=S5LXdlbPoyIrzZmu34G4OGgCMegGB8Zj0LT9RXybxB8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YvSyPDB+719O8QH61VNJkagxB04SXi0b+HxiugKNWdaZsKDJ+baTM4pWbhY+nTs+DxS3in2D8nmoQbEks68XaCxwVJ9FIGfbicrama7/rUUetPXPJB8Vdq5qhHpfKcydkRC/OVWmzmTx9lVbR3EiUjiPKOnHDIlntLBHba/cb2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RCYc24oy; arc=fail smtp.client-ip=40.107.102.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8mS/qxpyTs9o9XjcDnCsrEfznTzd1uKbl2XrDNFzBO76tfPr4ncfr7eDopWAlNC6xjqOZeEzcvAWBeRHPSeyTQMk24kS5GDkzwNXGp7Hv+z5gvphzVDfW8hYfMiS7e7ZmUNahd/z5wbf4lqP9gLUT5IscX4cU6GpnyS6fj+IxBUvXA2gfa3sqTezohk/OXgvjHCfu6aa1UMTG6s1RAjdHBUXj71H719SxRY2l8q/Mv7k0wjnhkNlDZ0X++kbK7OwLhkIPJuPJ7mRe+URHKO7LQ6eB3W99dYcDazVhLRavX9AqHTXZQHTPmINOkMtCNAuUqC5eQT8L0iAOdj6vXD+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=doBRNJB4d745+MUfYjQnsLREIPTw/3Jrya7TI3tGo0c=;
 b=mKYa06+ITHDCHAmgYT6PNq/YocZu2gzM/GcU3Py3mfQHp6k/Srufa7AgwDOnCoyln4rqNSICXdpW0y+GNNn2Yu/fXwNMCU3JMz46gx9L3ItJMYPweIYwe/5G8G1BxwAFIEiXT96utU7pRo4KSE80m93oLUxOiXs762jlGmJ2JrJhlOjFvmf/Cjunxb2Tc3CpcvcE7LcQWt4jAoazgqNDBX4hrqO2qmIwzc7bfOZMjYIUZ0RmEAK48gomq3sijYjllXTNqX1E9NPucgN7T+5aGz/qURd3xpMf0uSnUrPu1ip/S9SFL9X//vRpHzsGSChemcJ9RPGGbNptba204MYouQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doBRNJB4d745+MUfYjQnsLREIPTw/3Jrya7TI3tGo0c=;
 b=RCYc24oyBaUZJrOc7d8XpoNyjP2AMMmofU5eaT1NjfLX9UYCZ9zfZVo7PkG/EUc4iwmwi9EnirbhGIUnmdhb2daPTRDvvhk5RD8m/SiHIsX2xde9uRbfLpXxJr6ptOO40uJasjr6TTvnKyPDEhT6uVItjcpWliAARQ3Qkc96UxI=
Received: from BN8PR04CA0021.namprd04.prod.outlook.com (2603:10b6:408:70::34)
 by SN7PR12MB6669.namprd12.prod.outlook.com (2603:10b6:806:26f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 01:45:54 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:408:70:cafe::53) by BN8PR04CA0021.outlook.office365.com
 (2603:10b6:408:70::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Fri,
 4 Jul 2025 01:45:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Fri, 4 Jul 2025 01:45:53 +0000
Received: from qyzhu-os-debug.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Jul
 2025 20:45:51 -0500
From: Zhu Qiyu <qiyuzhu2@amd.com>
To: <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <qiyuzhu2@amd.com>
Subject: Reply:[PATCH v5] ACPI:PRM: Reduce unnecessary printing to avoid the worries of regular users
Date: Fri, 4 Jul 2025 01:45:36 +0000
Message-ID: <20250704014537.84202-1-qiyuzhu2@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJZ5v0j9J-4-dv=0QxEPxYDS_epnjT9dGCNoZA0LpiDZa7sy8Q@mail.gmail.com>
References: <CAJZ5v0j9J-4-dv=0QxEPxYDS_epnjT9dGCNoZA0LpiDZa7sy8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|SN7PR12MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b7ce673-ffbb-4eab-d1bc-08ddba9c836c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jADMxvtK8sF4I9d2T952NqrFw7/fQ+kr448DTnt4dOZd+Nm/nE5z+bf3MBJs?=
 =?us-ascii?Q?grkGk1FMJDAjtemiXr19HqIhlqPwy+3I/8981S7JGkuhWEc7VVY2OnsxrYly?=
 =?us-ascii?Q?fMeV6MskQcje8ntR9on7BkcRhBWNOHWNXvct0feJ4YdAZq+HOcQLIJMfX70G?=
 =?us-ascii?Q?SHLXGM6UpedJD1SL61EKkse0Dj9svKLT95EWMWYWNqr9hXPaLHdENr+j52XL?=
 =?us-ascii?Q?0B35pOkxdUnLVrJVdXq0FRL90XYe9XORJrTS9yqgcfN7myr++ii2u8G6cUB5?=
 =?us-ascii?Q?RrGUdmgxvt7YPoio2U7cpYqHDBxAaBk+De4zpxj4AnXDjsJyMq5G7M0EKXMG?=
 =?us-ascii?Q?PNHj7CS4R5FLxoZmBo4dBZNjk8lW9nMSg5iqHZRHRfH3se8L4ZfEPKn9TSgU?=
 =?us-ascii?Q?B7rig2TyU3caMzm+Pp1fGKeJOrsr40BoVdtTMhTem5cOsMYU95dSfpUlDjA5?=
 =?us-ascii?Q?q0UJMwepE+WcWTxQSHJgwZFT9DURTOSe/2/IlVuJCEXQU6tioEeYVyRb0sxU?=
 =?us-ascii?Q?qIJO1JvSUJJ/XEZjBN9Qho7LlOZWFOYdhlgi687PY10yRoDhHT+8t3gLBeeh?=
 =?us-ascii?Q?YzzCEbVqP+P03Q2sk3ht6WRAAU9v/dbA6o9zasASZ2+vLhI43QhagDRAR8g3?=
 =?us-ascii?Q?vz/2YdfkuleYGG4V/HX75iENmvavks/kR0hcQtEc2QPSzCdT9c+47SA1Ly92?=
 =?us-ascii?Q?rauXgN6AkHukk6B6SAcrbwObsWygPsQGkpMp5l/k2FewQA++bLhV5QlRFc9E?=
 =?us-ascii?Q?JM+18ZJ5/HD4/ZbczNtt7vEXS7pxZWqo06LzFixFDwnTZsHyc+5h+V5/EL0S?=
 =?us-ascii?Q?aTkNtXn2aOoglQZ0ONJTKFXnim6UdZU4Icj/D93G3v/U1GVL5NPOpTRL9vGc?=
 =?us-ascii?Q?JURVTS+AdDiywEbvzIfYETYWoBvKyEg3pNosFZy2fM1v5hR2sHSuff1tM65w?=
 =?us-ascii?Q?vh+F7Wm2woqZ5HNRwD3MYZ07zFOfSlM76bz3MndgBQq3ET8Ty9jDrOdzAFW8?=
 =?us-ascii?Q?pRO+DTq1ZrXXmQU01PYPtB6qvIPgx8l0YymK+973f4pV42CBPtg+ABFvS13O?=
 =?us-ascii?Q?KoBQZAsuVR7M98mYxwQr70bue9mOkNjiBF8eqFc3P2FM/jxmjz9JnSLlZcga?=
 =?us-ascii?Q?3RzKxmHVtqgTkDOtqu4wsDait4LypemXqwnPPIlIw/n7z0fYCGWc9WELVqUM?=
 =?us-ascii?Q?2TrcSfbvdw5KkeKbEv3lA9Qegoak0RFG400TNffVH5XXtka+rUKctGmi1cDk?=
 =?us-ascii?Q?6sIom3kKd3AH5C/FrLol7oZuVjrbP/5RZakUo5z/3vZ3SXexrQbAMwLmi40G?=
 =?us-ascii?Q?YzVbDQmxEueuHUd/umxfotbmSt8Gapyh4yvf9p5VNEwkaS//BOR+XoN9RGIQ?=
 =?us-ascii?Q?U00m/gD3EMa96B06MhA515I9k8MGsK9Df/475NKu0ypNiZ7AVyFFjHYfrL0/?=
 =?us-ascii?Q?vaByXCzCPkRpCqoC066LOYqtcvBD/Y0jXUaRnxObUK8OCOm5LxkrDrB8kkYe?=
 =?us-ascii?Q?/Lb6N3AZVM+SZveOOlpdOtlg95HJZVHyT0y3kXHimzG9R4m8LjQASUqLmg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 01:45:53.8081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7ce673-ffbb-4eab-d1bc-08ddba9c836c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6669

Hi,Rafael

    The patch v6(https://lore.kernel.org/all/20250704014104.82524-1-qiyuzhu2@amd.com/) has been submitted,
    Please have a checking, thank you!

Qiyu

