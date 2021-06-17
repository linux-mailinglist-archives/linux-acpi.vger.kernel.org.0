Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1903AB9D7
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jun 2021 18:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhFQQoq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Jun 2021 12:44:46 -0400
Received: from mail-co1nam11on2044.outbound.protection.outlook.com ([40.107.220.44]:6999
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230381AbhFQQop (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Jun 2021 12:44:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msBlcOXkcduVWo/j0Miv7Vi25uSCIoG6apPq4pM+1zbhQnUzUt9QiswSBifVFi7Hw8BxKpuzpwCPz9NRJdtQSqZ6YeQglqi8xnyG8rVcBFY84ZyjfLag+aTlfQzN+eyT3atxATc0tHJ4/Mw5xMBbMmQOclcGwad55gwTH4Y2btVdB+pBVIdYBDYZMncr8fgb7sfi+y3Rjl4O6d5E6rwvlznUbTOTcop9uMKINlOOzrjOoMzcYH1aM3gIOjyNgqSaHRTOpFeOGIQ+4rrp0SulCj58+F7KL+a2f9TQEESQMzsFuQy8lZ2Rf1YprE8wviisdhu2VqmxRUt6a27dq9GWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvg4ThrQP34zVE1cX68/K+94tcKqiOiqkrYWMGZYmy4=;
 b=hgGgH0iJvSjXduIva+IolCPKrk21vVWQYzXu9WP7e4Us91ZRpjxfmkNDijsvXCISMigIX67ZkxCYXf7RavvWLC98sr4Id9Rf46R6quU85Cv3fGUqbpsn1115CciP3VxAOmYUb++bpln9rtpuzL55tpFsu2JPg4FZ4+CXkG1lDLHsEMwCC2yG7QiSQzsuQWHBp6MKo+Z+zkT2zCdgyIaf+SBFrBy7fIOqX32iZJRHlNKO4Dr3vsJYtwbthqi6/IS2z1O1E+sTPXLLrQ1uP1GoVwNOx4prx2b3/CKcurtkMn1UPtmT9NXslJsPeO8SJUEgGCgiluJc/8DJZeVEK1HSyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvg4ThrQP34zVE1cX68/K+94tcKqiOiqkrYWMGZYmy4=;
 b=4dT/xN1o0aCD2+q+MWZ9kKrlrbKOFN52ukD+Ct9SxlaeuWYxxQHMP4XyZT5vRVbgxVbyZlLO+oxwPCSNKfnls3UPG4bgnry9TfZDfC/qcz3E7V9UcX9TviiX/OhqtD0q92oz1PosXuk33PjNsAFC4bL7NBdrPsVNOCoUAqwEn/M=
Authentication-Results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN6PR12MB4671.namprd12.prod.outlook.com (2603:10b6:805:e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 17 Jun
 2021 16:42:35 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::9c16:2794:cd04:2be0]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::9c16:2794:cd04:2be0%6]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:42:35 +0000
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Julian Sikorski <belegdol@gmail.com>, teohhanhui@gmail.com,
        Shyam-sundar.S-k@amd.com,
        Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH 1/5] ACPI: PM: s2idle: Use correct revision id
Date:   Thu, 17 Jun 2021 11:42:08 -0500
Message-Id: <20210617164212.584-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [76.251.167.31]
X-ClientProxiedBy: SN6PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:805:de::19) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AUS-LX-MLIMONCI.amd.com (76.251.167.31) by SN6PR05CA0006.namprd05.prod.outlook.com (2603:10b6:805:de::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Thu, 17 Jun 2021 16:42:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d250c38d-46a3-4e95-6ea9-08d931aee909
X-MS-TrafficTypeDiagnostic: SN6PR12MB4671:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4671B3E9698219D36FC6BA41E20E9@SN6PR12MB4671.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:190;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YKQk+ajq/oYNhq3F/yvdOjsv5lDIThY81yNMFPqr0RT1HVM+31/PpBtsrzKsscwHbtScAv4tNqQ7fkjF2sfJPZb0pOXS4aW1GF0vc1gbZr2n0Dpm6VUGKN4+zS8nx+C9ELPZ4wrIrsLz8KKVzPa5/8tFdu9PAiaMbTVCznU3QqX5ZVR9oohL1QmCrnV3x2kVk6zYns1mpLZ5hbqfyLJ5mkeZFJVLTmv+rftuGadia0ceUHUS6COMXFIaxZeP2IKhtwkBt20ALCS+83cjpLfmBbN18tuz6FhAVkJkwCV4d/qqLserK1+thW74+wIh+AOiB7W9T9BuuOv6EHzFw1SpAiX5JPHI+pygzecIrFDhYwMtexzi5lZcKaDTI6oOuU1vQDcCvRd118NO7BGXXEKsK0F8t1ijlEjnwHmXoOUj5yTEL9naKQGTxKe1xe5RV9EzkJOSK0HRsUhlzEUnPVE0p9UZ50Zb/+ZoDd5zu3xGblX6HSFhAyJdoHX2Sl7mbReeAp338VzSQbVin09a1uxziIeYl+JjptvWKYJYV+5OomVamYSGhbpUWSh4vjhlbm9XOA0KuLX+0ognqbdgpzMGsLHIkNrf6aKS1A0Xlyb/dCHbZy8QDERIxpV52hsNzdnNksmZbpDYpzonZEJECsnM3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(16526019)(66946007)(478600001)(26005)(66476007)(4744005)(6486002)(186003)(66556008)(316002)(8676002)(86362001)(44832011)(6666004)(110136005)(38350700002)(1076003)(38100700002)(4326008)(83380400001)(52116002)(2616005)(2906002)(5660300002)(7696005)(956004)(8936002)(54906003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eWXpBxo+XtroTeXIAVz3fhT4XoDy6YmbquJoMUKkQRR33zAgqw7ySTTu9qMJ?=
 =?us-ascii?Q?bUhc8L0odyRcHKgPRE/c7k+jCnsor9WvYSqah/4Jd+/W01EjncVX9xa8rs+z?=
 =?us-ascii?Q?N+7tK5LeO0+Un4xiLBoMfrdRDrBVB24hROwfxfEPG7Gun7fWNMKQaCQqYWa3?=
 =?us-ascii?Q?awNytpGWcwOpW9ZwcKY63rDSZUk/lUNvMw7OchsJTdmGP8mASxVfVZbKKCeY?=
 =?us-ascii?Q?oYVv/aigLJaK7ZjDa5Xh592DC3f/k3kLwcyDYaLdn4u/fwFhnUHtmBa+Tqdf?=
 =?us-ascii?Q?kA8FbjszpPNJ+IzTWzCQewC6TnmpmfvwxSwjJNzwpri66ZxRuLI9zthHbDz7?=
 =?us-ascii?Q?Y4NjuHWYm0YnsTpyXf6VGD9ptD0zazLm3KwdTp3N9jjTPvImPiZjVqGW/FYw?=
 =?us-ascii?Q?TVE3PNiGaoARprEiW+xjFW8MGa0TvEQGFptg4RVmVAvDPJOa5Zo5005VNTx5?=
 =?us-ascii?Q?2zwnaF+5Rtf5hE1Iq2E3O49LP+79ErFUWS18nvT70JHn2cdOuK6AvMNp79K0?=
 =?us-ascii?Q?tNHqfvIRdeGHhUx/CdjmtDvnEXl+6qKh93ifQ6yJPgpHIAt638v9//IYE7Ek?=
 =?us-ascii?Q?Ws0kQ0z0TMtQAMmEVJTWX45drbh3aSE3rsthjsBI3ZB5f58saEdOsFg8x/1q?=
 =?us-ascii?Q?bt62EHsg6sc7hL03/CyIs9nt6j/BSaj85JNkCZVgX5kV/Eo081MvFKt702/Q?=
 =?us-ascii?Q?tgNdz5jILnDvMZI9vRVvWPkOnuKZCp2kBseR9jSfKVdcZt/ae3GT3dHSdkSp?=
 =?us-ascii?Q?DXi3MeQ8RBamU6nynpXDV7FMVPseBmqVhbOyI6fu1O7vzBYsWjXrvvNloLLQ?=
 =?us-ascii?Q?ifVqJuLtIWiJQ3rb+YR0UQYfZvbi5/90ixQtKB1BH1n/m5Woqm45cALsTibL?=
 =?us-ascii?Q?VHvnrnLpFAkdk1fwysXarNt1JcZ4aP9DO35MlzQsIBkFRLlNDcaXkOZFUB8J?=
 =?us-ascii?Q?E7EbWNcP42jPfo4gp/rlvGDeFVgLXUFvXYjY9rUpYA9EjJ1xraGVouOuwHjv?=
 =?us-ascii?Q?gaQbk/Ad2fXqjSj8pQsuqlD1TRqMid9So7iGH1V4D8GER96/UPS9aCdqyFB/?=
 =?us-ascii?Q?BG70Mhs1EPEmb5zMEJ52jH8fr6kxCSupLPIh6BPow7fFvOt/gc3cFUKdoyne?=
 =?us-ascii?Q?SchOHVPWVvbtC/aLDpoT5jroBKXLRwTlEYtE0RLdyPnBSzDK0oWKfPY1SFL7?=
 =?us-ascii?Q?sRVVOVH3Flmrgo2c0lSImhElyhxoukUfncJ3ZFF5qOSuzzM8Yvppu7pNOAoB?=
 =?us-ascii?Q?TjpCtNh/5Nv7xGqdn5u+Qp+9KITo9iwoYQ85/K4wbDFpypYNLfkuRRz6Qhzm?=
 =?us-ascii?Q?8VK7NWXey950xrwP6Iiq5o3q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d250c38d-46a3-4e95-6ea9-08d931aee909
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:42:35.4361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNIEu4WKxDUllZBT2tzfLemeE41SR/DcTBXPTYhBrRtsg9ZJFi8VQ8ALiCdHmo4o1SN7xBm8+AdfmmXmBr9waw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4671
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>

AMD spec mentions only revision 0. With this change,
device constraint list is populated properly.

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/acpi/x86/s2idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 2d7ddb8a8cb6..da27c1c45c9f 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -96,7 +96,7 @@ static void lpi_device_get_constraints_amd(void)
 	int i, j, k;
 
 	out_obj = acpi_evaluate_dsm_typed(lps0_device_handle, &lps0_dsm_guid,
-					  1, ACPI_LPS0_GET_DEVICE_CONSTRAINTS,
+					  rev_id, ACPI_LPS0_GET_DEVICE_CONSTRAINTS,
 					  NULL, ACPI_TYPE_PACKAGE);
 
 	if (!out_obj)
-- 
2.25.1

