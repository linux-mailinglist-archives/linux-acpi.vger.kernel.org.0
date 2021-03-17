Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2043333F30B
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Mar 2021 15:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbhCQOjV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Mar 2021 10:39:21 -0400
Received: from mail-bn8nam11on2079.outbound.protection.outlook.com ([40.107.236.79]:59457
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232151AbhCQOjC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 17 Mar 2021 10:39:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVDxt5F88QSzSmK5lG3Fycl4n549do1fBDQ2874sWu+suROSy+etncU1nLJUIzKXKx+BXbS16QTugibzXBBfUhdBzz7ZumrxTVLHHh2omdA13GPyt9QJFvDkyC74rCcYEfiLHl/Yw4SwM+WctNVrjTXKf1aA9ngdpPyKILTKlICTxHQkN70iA7V1fTGPuXeAJJualEzm02a5TSW+G7FHBzhsi5uo6L1R+t+AoiaeGVost6TS3TV7+VYN8sp9m5HDXJdPnqoR03DJ/DegyBC9YzLeLlxJtQMm+FZay/60FFN74Jy5zO3TenWwjTUI2JG7lLW7iJwPYcZFxPgzJwKl6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGtzko4HOIwk5a4eO6NuXL071uckrB7N6Q8tKBWOqKM=;
 b=NqUhWDsh2LMQFt5AJogqjXrMoyMwe774ZfGXYZL4Q5zPZli3z/YHVgBc9XYSbtnr6Pvk8qJgIwcghCtplNpoMIGAU091tCDMmetRNlaF15flqu9C974oKDZscIMVnDCjn06dpGLGa5Ho7gNdn6P7qdPZVgnymaJSkChdYZ5vpxKnfgwb6RgbovEgD2ejcan65Wq8+aYeZApSOv5HiDXkgDAFVUGNKF2djrwl2KRvgE0Td7MGuC9H8CRX3RpJqnD4mU1EkYNmCzUnafkJPM0J7yaORM9tT+BM7plI/YXijKItY6HhsfBTLLY4u+PVKJDiJT+xOlgsgMmWM+OK9k93Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGtzko4HOIwk5a4eO6NuXL071uckrB7N6Q8tKBWOqKM=;
 b=MsWM+vi+r3Y6np+udkaYH5ZR+ooL7C3V27RUA/Hab/E4lPp6urk8fhcHJKr7YYkduHsIHKjALq8aNFQoZIiMCX/dM0NKIQxmVB3WcA2G2zx5Qri8zSuv++PDoHQ7obAXnxkW7EMEQd0E67us/h87Ohddj18awHNKkJ9rPvhzq4Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 14:39:00 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 14:39:00 +0000
From:   Alex Deucher <alexander.deucher@amd.com>
To:     amd-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org
Cc:     hdegoede@redhat.com, Prike.Liang@amd.com, Shyam-sundar.S-k@amd.com,
        Alex Deucher <alexander.deucher@amd.com>,
        Marcin Bachry <hegel666@gmail.com>
Subject: [PATCH 1/2] platform/x86: Add missing LPS0 functions for AMD
Date:   Wed, 17 Mar 2021 10:38:41 -0400
Message-Id: <20210317143842.786380-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: MN2PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:208:160::36) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by MN2PR13CA0023.namprd13.prod.outlook.com (2603:10b6:208:160::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.11 via Frontend Transport; Wed, 17 Mar 2021 14:38:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 64c4e4cb-ff92-49df-fb1b-08d8e9526750
X-MS-TrafficTypeDiagnostic: MN2PR12MB4423:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4423742B72BF2D582365E5A7F76A9@MN2PR12MB4423.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fs6orAmSjN/zT0I6qjYGnDYDTXgtlRtZqcSXvuuuOWI/QFrpcfiPwLqtKCErZ391u8YnS1ajDYq88tXkDlngZeH01mxIY7CEJGtmYlXs4Lql/xRuHqCn4Pu0zhRPgFiF4UpSNf+Gz3IA0UTuiZ9735euKgTsTPPolDEFZOxk+Good4OLgWY1VsVpZG1NPMbEQgWD3k+bGCfFfIjbZu1ZOqaBQz7uReH6bXq9/2H+XFDDr4RiN4ZEgORaXqrXtnKW7SeMysWa5wNdhNJPqokxQ+GtsHZPIILj7eMRKL0YYyGv3daGgsIUYlpfBq0Y/d6lXUxKKQnDUQzAelFCRHCzzrf14VA76OlFZcPCo2h2AkwqWOfsioj31RBFeGh2kNt/Z6M0f5vIaEF5xT3F0GXm1KcKPBs9AXdvjZBSqVgrHT8+/O4oGXlgYYff27GYo4Qazp+JyuQaJrkVJst9eGI8XipUNgqi2V7glxQPWuFZSX2z4Or0Jch5P1EHZk5ru55HBwcb+ERqCeN9fLfewn1DJP0Ko9NgjbE25TdXMvrO7F+pEUeUZNuuo/T/pBQMteNBS35kdrCx7gCyWw2UUhwAwiSWPyJ1IVd+aB6Q1LS9TCVajbCznkjGtXTXJM/xf4rNf3UDWJZlHuB93SWVgG4HlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(16526019)(6666004)(6512007)(86362001)(8936002)(478600001)(966005)(186003)(956004)(83380400001)(2906002)(69590400012)(6506007)(66946007)(5660300002)(6486002)(36756003)(66476007)(4326008)(66556008)(8676002)(54906003)(1076003)(316002)(26005)(2616005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SPClogP4TkMXA0VPAD/fPGSq7iJpxicIoOwLyrTVoQqbIOqN0TSUAX+oBGYQ?=
 =?us-ascii?Q?9x/9YxBCVgb1EGa67ILTXEeMEuX8Z1hwm0zfjbpRhNcoBqePsPWWDRl/l4+T?=
 =?us-ascii?Q?E8mIrKWwVnWKXTXXZil39LHdfM6PUFjHoHGlK1N3bgfnX3tfTGHI7GTPaqS0?=
 =?us-ascii?Q?5Wpr7ChCgEhes7LyD5+rzMKUv4OBc0D58yBaPPNuSS7ixbHgW7VB12ZsbJSP?=
 =?us-ascii?Q?BTvVkW/ahxlqIN7vJpON2/Gb59uMMOuaCjSIjWp4+qgYSTllx5kAM/8/a/Xn?=
 =?us-ascii?Q?+yLgpmYRSupa0OiyLnBRvCXEP+0RvhUyJwEZV/crXTIxeGDoVXLgn12h+86Y?=
 =?us-ascii?Q?rdbFuJcK4KKNY1eUZCTQ5nePnaU/T/CD9h4piAOd9VJYW8AY3mqzXkAiDtJ5?=
 =?us-ascii?Q?5eOloYFUu1opN7o8tV6+RnEG7OO1zswlCCX6n8ZMbkxcF4oAh6Jo2DgyKFQy?=
 =?us-ascii?Q?WkGelqoJd7eLhygDkrSqONCs5iEtexcGpQvTvIdPSsjX+47xlkMhEpXZx5BD?=
 =?us-ascii?Q?DvL0FEwjpBPQNbtEP3Vq9eM280DHup62T+CGs0LfIfHKPW7IASoWfyGz7Q+i?=
 =?us-ascii?Q?wIwR2hYx76yYceoKIMFGsmswvCzc4PHtZ/3Uhu1TeL2KhnuUDfkOvSMfafED?=
 =?us-ascii?Q?NsFxGe04oQ2LV+sk7fbo20wPT8E2sL/tRTckJ4YC3NH30tMA5jwFQuLYJNZ0?=
 =?us-ascii?Q?aDB4NmgWeyzVh5YuEYUtU8OWYunBgnnvSoj8Ay+krjHyBkAcz5xcpIoOoEXD?=
 =?us-ascii?Q?1liMiCg8eDKbkb55HfBkbD/L6tPMSGJ5qcHoboZJWeZMQBwNhhjzPbRmiuZL?=
 =?us-ascii?Q?uT4RiOiEvLO7Tztgz1oK1mk/FRPLITolE/9szJNEeI/+x0dUDtblV5hNlr4z?=
 =?us-ascii?Q?Kp3SB3jNoTwIMaIssKmK+iXRU/WZPS12uQD4bWAmjszra6TXelzkXNtF7gB1?=
 =?us-ascii?Q?ROPudxCEYn9rUyb8F4Z408NjapByyEgAlSdK+eBSwpGPPo3svGxZsFJlJ6Hm?=
 =?us-ascii?Q?h4y+iOpEu4/jtFd9LpYLbamt8CVq4eHQuNyMb/RNzKoarsQwnIJZCwpfH4TH?=
 =?us-ascii?Q?PTlVsI0YqbLrAco+klEnRAx+heWO/vgX55Rr6oL2+Mj7mHTQRpYoTShlQYX6?=
 =?us-ascii?Q?aeWF2dvWoV9RcnLcMDC7pxv32iObRVIiAGXTlwqqW4SgicNKGqWudCt9L+ZM?=
 =?us-ascii?Q?oRumf5o+iEbQWvdgXEfn1O3F3IrfbRhnBBQkgv6AlAVox9v5lGnm1/qr+CDv?=
 =?us-ascii?Q?Lqa7FedQAulADrkhVeX8QgwsmeifQGCApALexPv41xmR+ieNKbwjBsTvLHFR?=
 =?us-ascii?Q?yHazYI1X5sfSpXHYEiIaboYx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c4e4cb-ff92-49df-fb1b-08d8e9526750
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 14:39:00.5305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H06n+PbxRQYcUh/qVRO7QnmxL7rWadG+jduCXWaYZVkmUbu1tIbWQQi8tUrHo7iEFVligYsPeokUHnqIWYN3TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423
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
---
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

