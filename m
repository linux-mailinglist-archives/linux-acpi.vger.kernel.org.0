Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D4537323F
	for <lists+linux-acpi@lfdr.de>; Wed,  5 May 2021 00:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbhEDWMy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 4 May 2021 18:12:54 -0400
Received: from mail-dm6nam11on2081.outbound.protection.outlook.com ([40.107.223.81]:50095
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233018AbhEDWMx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 4 May 2021 18:12:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euakcmGg1MjTfr67QzQ7DJwWpMlvmZO/xckoV5asgpVbzZuYEf4c543C4k5Do81vm5VQ8eb5+MsdTivAypFUHc/MCDLd9kKMhFRTFw5cwkf145lCNNZDByEt+Tx22J2RUPjQ2e+8ZRZ2oODEOI3QwaUGXz59yJY/R48n4/9NLG+wULcInVJifya2zBIplOj2++2268hD5OKGKGIngU31gu7si8IvOiCd5PQme5g/eWcjsg8nG1QUzx21j/r+JgeI6zlZZtjloJQFb7nEvvym0fx9ywFdvbql7nPWvdqG4wqBVbajhSFySybtAAMyV5SdqOryfwse9M4exyIZZs7dYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lq1uJWGO7C9jwoCzsd+OpnnimjLWPH+JdmyKfAqC35Y=;
 b=bLiO3THiVE5lXXZpmY7E8/oz7B7h0QV/0mgVlAdpMKS/hIpqj7sD8hUMJBEXTmOLfqlyGuxtiRhy3NPl3wW/vsFPjSIQ86nlQAH3F6lI9p3mOz9tkDt3TMPwFFcnF3yMODsgZZR431y+5ZdHxbtaWFFfVx3vR76XtrDkOzA/d+T5YGMEJnquUlV9oHuXBSA8TyQvtA5xEeazXCC2Pi2tEfwgb1SdhBVdfOhNuoQ/rzxUYn/pFxBaQ4Rn4pQ/6vLBcIVGZJTjS4DiwC5F6Cdcr9n5L+Iz7UA+AZZAVVsgZ8bpi+2WAdFZXNzI96u++dfJdc5/8lM75Zx1nALKOuas7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lq1uJWGO7C9jwoCzsd+OpnnimjLWPH+JdmyKfAqC35Y=;
 b=G2I0Po39O/wUKnSI5kBs12BwO4njkHkFJDvn3wM9m+l5yr4O+SJq7jGE8xU6QEzjZnmR/sTS7bvRFrUxRadcnPxATrrKEobDhgZoejPRB5L7/Z5lnVOtcmOLBPHV95vG1eulWUY42ZbRlJDdFaHavWcbBTTJT5F+R7LfG3FUw2w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4852.namprd12.prod.outlook.com (2603:10b6:208:1ce::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Tue, 4 May
 2021 22:11:56 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 22:11:56 +0000
From:   Alex Deucher <alexander.deucher@amd.com>
To:     amd-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org
Cc:     hdegoede@redhat.com, Prike.Liang@amd.com, Shyam-sundar.S-k@amd.com,
        Alex Deucher <alexander.deucher@amd.com>,
        Marcin Bachry <hegel666@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] platform/x86: Add missing LPS0 functions for AMD
Date:   Tue,  4 May 2021 18:11:40 -0400
Message-Id: <20210504221140.593002-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BLAPR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:208:32d::16) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by BLAPR03CA0041.namprd03.prod.outlook.com (2603:10b6:208:32d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Tue, 4 May 2021 22:11:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8bff29b-1671-4c54-897e-08d90f49a147
X-MS-TrafficTypeDiagnostic: BL0PR12MB4852:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB48527F912C6736ED3CA37BE0F75A9@BL0PR12MB4852.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1KuASdRO5zk1ophXeIUulQoEBpJhxE3Qw5UImoQv9T1v/YiKeUnMmv4OamU0AHAROIkgCN2kBYA7hZN5ZmSrir8GFPrh6Bn5UMN0fsaWIAhBEE7Ny81yiuX5XS1ekS79qSF8VDBoqiDZHPqAtpid5pp5ZCRFnUvH/+2waptDcJwu0W22r9WdvHxEUg2cDpXkqul/zk5fFRVsTuGVhB3vb46sy5/2+44G8bTahJhKi26Rlb2OpMpAx3CJdtQHRiF0STJ+7nCz6OkH6D6yHHe56Qe77nJVOLBZTx8UQkgnf4sv+OpGtKnCXg2v2CTu7VeF4LR73sAfHjCHxLNjAjUqi7PqR8hyyKIaelzHN8xRDkdPa/tziuMRg7wORK7C5toihQSEmwux8esqLreL/Ncq7BAKIkCC02C06Tw/1cgOazUTQNemNmWh3KnBRlKck79hPANlYvB3oWKi54V8zS9WQXv8AzJux+Za6VV+dbkJlmVXGjgCeSHAAJxf2zD49E7lnmJfpJaiKPvK0hUDqC0/pf06iFg3/e8pTk17OVrK4LrWemOJ+FQpAR9fZF4lBOw34r5FHDvkCsESVPQcI5qjpI/DS7hCIWbHDx8YianleuK9hw9wJfabrHzjTSuStaqx71K9y3EQtO+fonTXTVQYZ/0SqhvUkViikJFTmjKOg6uzpmC3x7ygifwvHYzbGF6Q1uEnLfnruIzm1vfdKUOXS/wUwGsRMFKHIDU0KiA7xoo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(5660300002)(6666004)(2906002)(6486002)(2616005)(966005)(1076003)(6506007)(6512007)(38100700002)(478600001)(4326008)(956004)(36756003)(86362001)(26005)(8676002)(16526019)(52116002)(54906003)(66946007)(66556008)(8936002)(66476007)(83380400001)(316002)(38350700002)(186003)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SPl6dD3oatQNQJQJ/ownGGGfd0xaL8bvgZj+njen+2pvZJb6BGe6rOeUDzhq?=
 =?us-ascii?Q?g+XMMximTrS0ihZ2MEcN8A7W5BgJ6iuBmBdawwnfHTBupGBN8WGIfzxbe2RI?=
 =?us-ascii?Q?JzGy+LfIygG5Z6hXEOKgLOQNkhsPnjyLUAw6aj6dV4Ei+k8dzs9pOvaMlt4h?=
 =?us-ascii?Q?VBu1WoNTl/VXHPsghBfy+ZDUbpRMbVw2i9YXm7LdBLvwkbFdNl+UId7/IUl1?=
 =?us-ascii?Q?qKtjOAWqBdTFfybhwfb/RvqzcoM0v+6YVl3jPUSaQkaw8RJ64W0coBYFW0rC?=
 =?us-ascii?Q?BONKjT+uzP+NcLb/5ocWWKxxyk7Dpwy6YKQA5VMTprvA/6l2fzu1++ScPhHM?=
 =?us-ascii?Q?mE4MgPe96Nlfmg4YtODjblRl4M2XfuhF0Du+RBOyRha9DlAOZBL5Tdlv35W7?=
 =?us-ascii?Q?Die/EaFEISURFFHQoALwct0/6qDbO0kZkY3+vtQtILmEduD6MlDNCEvGz6WY?=
 =?us-ascii?Q?GXZ4djeqIOXLNWvKFxm143UW8EukZZVdXxWidLx3Gtdegs8/FHdQDX2t/wFn?=
 =?us-ascii?Q?G3yXiQMQpSwsu3oJH97tUmDUYUVq3+0WGCyYXweA5CZwYzzOIt2AKwRkD0l9?=
 =?us-ascii?Q?QuzgayE/QCUfAaXbICiqLwEL7axcoBnuqqka8mnfeVgSXfKOyPKxrx1SIRW9?=
 =?us-ascii?Q?M/Ikmr7BxyD6q7WYBgr6EW8uoEA7EE92a3LpsudXEerMXqxX0sRXXrkXyjmD?=
 =?us-ascii?Q?UBIfrNaJw1P4uSdXSJiw9CBVuWISHZje5SWrTjSd0mW0E9xXEVjApEuD/YKn?=
 =?us-ascii?Q?CUjQHwhubJAAJmFXpj97WS+/LSV7exhpHJ3r9kZI1soq2UYQW73jZWY/niCw?=
 =?us-ascii?Q?B9sZHKcchQzXEL2Gu7ZGC8deA3bdicby67X4ogW+T/Jb9amRbl5M+4PcZy91?=
 =?us-ascii?Q?d4ZTLbkOnG2ECARBxbTqeDgpTujBmlfk/9GLKxlwjkv9K36PrSuVb6cnjT3y?=
 =?us-ascii?Q?gfLSCIVrEOG8QVqMDRZ6TYXf8onuViwc+pLQsPK8c0QvqJHJq8qd6GTp0uDd?=
 =?us-ascii?Q?7BkFO3rdIWTovRuPjueugTOIsXK0lx/zUiYh3FCbhI3BF48cFJxi+K5N0ENZ?=
 =?us-ascii?Q?h1Z4R4zvETk6FCb7Tb2efFO9TTH+XbjgHgza9bzePEcnVwUgMYaadgSWsULg?=
 =?us-ascii?Q?BSkDHFZSO5vcuh0mVRrf+UM0jASFIrCbH8v6A757R9mzRNBrb4kyL6KU/g/R?=
 =?us-ascii?Q?huW2xInsRt3cZnb1XGuP9BK+lD68zPjMM0loVbKpgN7sK5XEiAzcuA47s7Qk?=
 =?us-ascii?Q?MqBJ70FYtdWLqeTj/qRosTPXiDR9gmzHcgCqMl8WtsHexpVObxbSdRuK71rl?=
 =?us-ascii?Q?XG6hGoGzYjPwlHhOnDY3DpVD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8bff29b-1671-4c54-897e-08d90f49a147
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 22:11:56.5471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4demTRHZc+VzQVS8SBXpCiWIeLjEih0IzBiscS9AfjGFwcAHuC7GylDDXgVmx1rqQ65vOsDOBhPZvGJwTQpaSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4852
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

These are supposedly not required for AMD platforms,
but at least some HP laptops seem to require it to
properly turn off the keyboard backlight.

Based on a patch from Marcin Bachry <hegel666@gmail.com>.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1230
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Marcin Bachry <hegel666@gmail.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
---

Dropping patch 2/2 for now.  This patch fixes several
systems and doesn't appear to cause any issues.

 drivers/acpi/x86/s2idle.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 2b69536cdccb..2d7ddb8a8cb6 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -42,6 +42,8 @@ static const struct acpi_device_id lps0_device_ids[] = {
 
 /* AMD */
 #define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-932122d37721"
+#define ACPI_LPS0_ENTRY_AMD         2
+#define ACPI_LPS0_EXIT_AMD          3
 #define ACPI_LPS0_SCREEN_OFF_AMD    4
 #define ACPI_LPS0_SCREEN_ON_AMD     5
 
@@ -408,6 +410,7 @@ int acpi_s2idle_prepare_late(void)
 
 	if (acpi_s2idle_vendor_amd()) {
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF_AMD);
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY_AMD);
 	} else {
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
@@ -422,6 +425,7 @@ void acpi_s2idle_restore_early(void)
 		return;
 
 	if (acpi_s2idle_vendor_amd()) {
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT_AMD);
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON_AMD);
 	} else {
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
-- 
2.30.2

