Return-Path: <linux-acpi+bounces-13675-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA01AB2CB3
	for <lists+linux-acpi@lfdr.de>; Mon, 12 May 2025 03:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9EAC7A68F6
	for <lists+linux-acpi@lfdr.de>; Mon, 12 May 2025 01:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F75E199223;
	Mon, 12 May 2025 01:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L4G/wSdy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E69650276;
	Mon, 12 May 2025 01:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747012022; cv=fail; b=RckMLMhccQog5R4Y/DCkZ4INHjDKQZsMi2v7+BjoRDAYsh7HiLHQihEwINXXfq0MPVv0QdIzSyg91ZZDo/GkxcqdI0684JZWFjfuwVjfH0h0HgQBImhfB6O1ZeeQQOO0Z2UexW4JVlbq3wIgxsAmSXw2wZ4hCXFb3OKJmpqZYcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747012022; c=relaxed/simple;
	bh=zyDBC+37KcRuZMlv9drJKNKEG7K6G1PAoIG0OJEsbpY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pbsnRNQitWWXkRbGpPEb7ROAEsrOLVBEfBdNej4c8e+j1cfuKsRPuyoc2fH6DMDKVEyYdq7fGhkLIhpOaDR1ANgB96wkMkbrliZk83lbd2LuhAf0Ovr9EhwjPfuB3uRxlkcAUfgzoAHw25wHsZssMpGqEsuFaezUV/5zR3Jv0cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L4G/wSdy; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elxpPbMIDlAddwNBMwrKEcifwnZWll6jfs64GEJKn6bO3E3oPCDpp1tfZrKn6CbWYoXzPQfdk8gb0jj0N2uHENbnCaH1FERF1KW0rh8UFCeFqXntC7ktPKPdLUjOfJwmeL1/tbDRy29dXcZ9usU5uZEvVNlcJLCv5KhMHy9I5NvJnyT8Dc8tCE/Jawck+c7sYEFzOq8YbkZP5ItC4mXkkU0HiSfrburO5YZOzT/EjSIHkwdhWCr4mXUrwJREiNUw5CyweflriSnESgP4cQjAobf7OmijPVw0SYtz/n9IEBFPJjDLs656aSSQJAPn84SSxCVW4uQYwQ+psxS4yiBn4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r628/BtLY81eWfOhPuc76Iq/POqsBSr5WhbFKccarOQ=;
 b=p9SN88afiCsVy6z+CmZ/9cW3obwwUe3cwk/PYckf0uZBqLbEeRjWghMyQyHQkaDiMMj5xEbRIBEesVUZv4EMBV18j+K0fVUzpFbHmE72iUhMy0NvgxIDoAZ/4cyAtmwTXXKkmeSix/kqctLeJWnkmmY0kskOt62P/oW3DpW2e7IstzyXjjh+djlwJTzj827UUnshYGxLsNaBO3bDqTUforK39ONjWWgEXyc7F737vZ7G9FLS173wNa5uLI4srbXSWSJx+KZFH7TDw3Zc8xgah0Q4yMX7A7qrZoUQOw7SHhbTBZKUCkvV2jEA5Z6iNTiaDYg01EgL6zYwZ6+1OQ8d5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r628/BtLY81eWfOhPuc76Iq/POqsBSr5WhbFKccarOQ=;
 b=L4G/wSdygl6ND+SsuFrK4O+UUv6bVa1/iFf2cZH+yrdYm2TmRCuu4cD7Un3shgX5KQ9r/0Sa2JsBa61VvFsPC3akKW1A4VMVi5qoviLRlXswIfQuFYoXpiAkIsVvrobFigEErXB4/P9w5Lxnq6dJDdoHSYdIyQRYxiM2JeTy9aI=
Received: from MW4PR03CA0125.namprd03.prod.outlook.com (2603:10b6:303:8c::10)
 by IA1PR12MB8467.namprd12.prod.outlook.com (2603:10b6:208:448::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 01:06:55 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:303:8c:cafe::94) by MW4PR03CA0125.outlook.office365.com
 (2603:10b6:303:8c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.26 via Frontend Transport; Mon,
 12 May 2025 01:06:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 01:06:55 +0000
Received: from qyzhu-os-debug.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 11 May
 2025 20:06:52 -0500
From: Zhu Qiyu <qiyuzhu2@amd.com>
To: <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <qiyuzhu2@amd.com>
Subject: [PATCH v2] ACPI:PRM: Reduce unnecessary printing to avoid the
Date: Mon, 12 May 2025 01:06:20 +0000
Message-ID: <20250512010620.142155-1-qiyuzhu2@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|IA1PR12MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: f9abe12f-d1dc-426e-10cf-08dd90f1498e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Imh8GtMppT2nWQLXBElMSRX61MDPXWhYTw/rNX1vLpxGCYj87VJ2lgqXXkam?=
 =?us-ascii?Q?m0xQw2tIluvlByYsmfd0v6QGMHdyow5jiGP/N71X1jWPJhtWT8ZfUj24Kl4A?=
 =?us-ascii?Q?7NNXHh5AT5A6NnII7lthVx3NkQTQ0pxKxlc3fSfme4IGysFmtfHq2VVHnjiy?=
 =?us-ascii?Q?utdjbF4V9Qmx3C64nvan79SCkVrnZMUR8Qt+8EzhgMWN57zeICfkjY0VYHr7?=
 =?us-ascii?Q?PvQNySr2z3MRl9im7Sy2ob/KwbSHwIYCsa1tNwwigKI4AE6tUyiODb3bSIRs?=
 =?us-ascii?Q?Sk67a22dTvCc2UnPOL5FM1nPtWTJDypXdV7X6tqVfBDOSUk/U4RbnX7csBfH?=
 =?us-ascii?Q?cjfD9ZN2K/TCjoAPZtctw+tLm0o3O2PiwBhPq+cHHJel2PIopdoHhWkn/nX8?=
 =?us-ascii?Q?pz95HWP4rPKWHMmwCSfbY6vY2Cwtop5hyPVJXkoY38jy2Ae2F3YIsGnKiVKc?=
 =?us-ascii?Q?IgVpH8B0Xm57ZuzwMDrtxotqQkq2ys4sDgRVmHiz/fSss3omfNl/4uKYv7+o?=
 =?us-ascii?Q?3R+Mj0kc7MU+CEhlYGjKATVqaBAf6ws+rUIKrK/bGELgSLAK2JAooJfxOSrc?=
 =?us-ascii?Q?zG+TWw+mm4unhdMB8mcs0V7lFoNkoyYNXmAD2FlEnWEXyC9imaB5tUBCMU6X?=
 =?us-ascii?Q?S7zM8/s9p6Pk+xMJygqZzTHluXoYPLHwsFpbidwTeNFp81b/9d30An35KFtv?=
 =?us-ascii?Q?Z8droIibC3SisY76SjO9RqAD2RzKnGbTwoAnrwFoLtmnl4a3UUcSlOE5u8oR?=
 =?us-ascii?Q?jfLksNG0A5SUZKCBGvR3KkaXbivFofoPKpAYhtEoMzOTtS41kCXhW+zYzm6d?=
 =?us-ascii?Q?FVfWSQgaT4lk9d+2sdexpcUEVVcK9x3lZxo3YtaWtPpWfFAXwPQg2OTMBRv5?=
 =?us-ascii?Q?db6TFVf48gNp8dB7cWLWGSmFKYWPYuY8O4RqljK1s4MIwuVdEyBImtxywyBp?=
 =?us-ascii?Q?BT8p3h38QMlENiVbJOgI8QkystoMfQvVVOEkZjHFF4JbKxr0Z0yK23lwNh9N?=
 =?us-ascii?Q?jh3f+v9yRCgCMWnp6j859l3GmzTpHzFge3rKraFK0bIUt1bQVQLkrYESIhM/?=
 =?us-ascii?Q?JY+zifzTp4H8gFuSDcsK2Ljnn/1a6Ic5llugaJMU05ku2LmNPZovBjm5/71m?=
 =?us-ascii?Q?WKt5N1CAlwRARyOJ/Fz8D1ZElyGY7jdO3OHIRG31v9Vd8eKLn2uuv+OTWI4p?=
 =?us-ascii?Q?Tt9LVTfN3UQZaKjrt7WnRI2M1KYYbz2xYf+3px/sTqNLaKWLnuBAapraG8Tr?=
 =?us-ascii?Q?WakPnK6xXZj1fiojAX69VlQaPWgMAqfV5acvmYu7p89SySc8pJBTdlV/t+83?=
 =?us-ascii?Q?nJD3uxx6UluFiw1cbRU+nhPoOsDjnTEwpOjKaiyKEkEem888HUkH8+5zcv9t?=
 =?us-ascii?Q?w1URj1zfprgdZUQIde0zEn5vrtDYp4Z3rr0P2vVp/0wp+/fXm8IC7NpvxiQY?=
 =?us-ascii?Q?hCujU/CWwXyhoHfhTKIILFBCONHwfwtsVpCllEaaScM6rylnZL16AQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 01:06:55.0664
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9abe12f-d1dc-426e-10cf-08dd90f1498e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8467

Commit 088984c8d54c ("ACPI: PRM: Find EFI_MEMORY_RUNTIME block for PRM
handler and context") introduces non-essential printing "Failed
to find VA for GUID: 7626C6AE-F973-429C-A91C-107D7BE298B0, PA: 0x0"
which causes unnecessary worry for regular users.

Refer to PRM Spec Section 4.1.2[1], both static data buffer address
and ACPI parameter buffer address may be NULL if they are not needed.
So there is no need to print out "Failed to find VA ... " to intimidate
regular users.

Link: https://uefi.org/sites/default/files/resources/Platform%20Runtime%20Mechanism%20-%20with%20legal%20notice.pdf # [1]

Signed-off-by: Zhu Qiyu <qiyuzhu2@amd.com>
---

Previous versions can be found at:
v1: https://lore.kernel.org/linux-acpi/CAJZ5v0hv0WKd-SXFhUgYs-Zpc+-PsSNOBu0r7L5TzJWgddtsKA@mail.gmail.com/t/#u

Changes in v2:
 - Reduce the code changes.

 drivers/acpi/prmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index e549914a636c..28a9930267a3 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -85,7 +85,7 @@ static u64 efi_pa_va_lookup(efi_guid_t *guid, u64 pa)
 		}
 	}
 
-	pr_warn("Failed to find VA for GUID: %pUL, PA: 0x%llx", guid, pa);
+	pr_info("VA for GUID: %pUL, PA: 0x%llx not found\n", guid, pa);
 
 	return 0;
 }

base-commit: 92a09c47464d040866cf2b4cd052bc60555185fb
-- 
2.43.0


