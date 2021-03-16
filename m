Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D9E33DE0F
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Mar 2021 20:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbhCPTre (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Mar 2021 15:47:34 -0400
Received: from mail-dm6nam10on2059.outbound.protection.outlook.com ([40.107.93.59]:40928
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230526AbhCPTrB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 16 Mar 2021 15:47:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5sT5E7afBMEIyH6bKwR2VHPfts7R+buKTxe8U7p6DmMgaePvIn31pv6iVjypFHPjESymwAUUpAZFfJ8wxxuhIplLvII1Myqh4+12sMOKvEMOfFOX2N0piITV/yQiZnGWh5hurMd3X2G9k4B7A9hOoejmXhmRFmDylTcFyGa3fZbuad8txOSguITct+ArgchDLeYX17ZvH3D1KChn53zUHdQU0VG4+gOJpOWgdpcWvCubUpmLLTu9NcFhPIunhkh0Jm5AdaD2+nNNBWU3BGLAjt77N/YIRQkw0s9R83FvJr0eS/r3vrTiMZ/bRWW83yxyKzQK6hS/KyHUPkbeLJHHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaMuIgOu3qGCjr45dldYDhvi7o9xP3pHG5FlCdSFQO8=;
 b=JfzDphWFJKKaN0ldLPlftt3cI3vDGOOkci6jyAn5TSHlH1oOMWGRuwusZjL8mw9f4n4Qw3RsafzN3pbDPGbp7x77ZGScBXbBtgkgjjNgUbxHR1A+/qQolpHRS3eT1PXKlfDAK1vzOUTxgujoQYNRdz8AOYnQvm/+/uXlewOD7ZItaiVDvBtQCWy5cZ5jEncduYZHsQwHb1AcBx7Do2jNahs328Pwmu+JwJdLodnmzYdwePnRvGfSjn79I1ECDu4F9r/A14duEdJTEKwZpe15MQmVZgd56/v1wzT/V+gMWwukNuJHV5hSLi9I5gEjh/OoKSRlaOB/CuXLWFLjeVZXSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaMuIgOu3qGCjr45dldYDhvi7o9xP3pHG5FlCdSFQO8=;
 b=bKeltOutlygTJfCrYudN8CnSpREzDgo/JU8jhjicM+fV0KcNkIatYUabEhaiXtkIAR7goq9oJYztOY8iYFqLz4sfs1eBAj4gxh6nYf8VIV1ttSkOE6asZV2inyrikqIJC4SpHw4xIYRA00dxaGxHzJcDldGfGqccps//Rj32QmY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4503.namprd12.prod.outlook.com (2603:10b6:208:264::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 19:46:59 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 19:46:59 +0000
From:   Alex Deucher <alexander.deucher@amd.com>
To:     amd-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org
Cc:     hdegoede@redhat.com, Prike.Liang@amd.com, Shyam-sundar.S-k@amd.com,
        Alex Deucher <alexander.deucher@amd.com>,
        Marcin Bachry <hegel666@gmail.com>
Subject: [PATCH 1/2] platform/x86: Add missing LPS0 functions for AMD
Date:   Tue, 16 Mar 2021 15:46:38 -0400
Message-Id: <20210316194639.287216-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: MN2PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:208:160::17) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by MN2PR13CA0004.namprd13.prod.outlook.com (2603:10b6:208:160::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.9 via Frontend Transport; Tue, 16 Mar 2021 19:46:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f3ed7972-7bfd-4b41-4701-08d8e8b44374
X-MS-TrafficTypeDiagnostic: MN2PR12MB4503:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4503C5732EECC93DF7544458F76B9@MN2PR12MB4503.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QU/8DjuJYmaM6wWXfw6h3rO0FmeMbrz3CtwNQCp4BIpk4Om8lOAWN/8EIpe3po8rlCEO+3Upi2TNwozzDLI7eMAL50nqeh//VALSeAxriE/pgNYKxTC3g+i/cLCBb4bolf5z3ECgA9IqnroSaJSPexNokoW7Qz75Hs1RZqlrNPm6mMU3wFCPhcqtWqmQmgr7bP3dAqlliHpgw/xPcdQ8MOxGH2KH6TMnya9K7Iy0LYb5MMrW8+Fe1ExgX/PVaG/z8SFegMxXzzFTnrCabLX/aZziDgKYTLxpc/yUtqd+Sjjql/18bsZGMCsmIGhxc29YEBDlck21snrA8C1nwUnKVO5thgQmrN2Y5k7Adxz/O+o/Hdw82mhoKswQb8ErWdX/eXVIq9W76F0VNyRRU1suQhNaCUUCcHQQIy1h76WoiJafmK0PmCv+SrYaJKe8P/+9Jg75twzJkbRuW3LgqJbqIt4JZaIgMux8+xMYLLxRLPVwabG9tJqgNF5xCygjhmePdPDdvHFiWRRxod054R7L6KipwogrOpf3LbXcCoem3u/l945cqxlrxow5KiLqTEem7r5gvP5txOjasNoOHNthwxu/Rb6MMivfBOm4T2ATZn++6/WFK7D73OK7rSP1U5FnvGt4t+rJqGvoJT+FFZJUpdidAMabPR+VT9kLxGrkgYw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(2906002)(69590400012)(1076003)(6666004)(54906003)(6486002)(478600001)(86362001)(5660300002)(66946007)(26005)(2616005)(966005)(316002)(66476007)(956004)(83380400001)(6512007)(52116002)(16526019)(6506007)(4326008)(8936002)(186003)(36756003)(66556008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?TqMqyyY8xTiNl8x8Rb4cmv6cMI/IhCPiKawJy6+JIFAtgYJPlB6dNJlFxy5p?=
 =?us-ascii?Q?hBtw/E3qEBYH03GTONhp/4AAQOsuRGNViZFTeywbcZFiajxERgZz3pGzihno?=
 =?us-ascii?Q?mVFssdzgo25p1B7l9CSMj9IqjdOvIZ70EjyDnuzLd9BUKXMrAG82KNr2EDKU?=
 =?us-ascii?Q?NXfdeLFU0b9JAQ4H7ny7IOdMHq/SPxWHZOCi3ZZOccZthEC0UNKNljSC00OY?=
 =?us-ascii?Q?bvO9o9gCadLyXOqHwpbS/sxFfl5G6yVIsSBYcywqch4LBwTEy4ggXp51bIRI?=
 =?us-ascii?Q?63PYrfhtbm8urS1zgud0xnpHQOaDkjtGKpQX07jLMEpgaKKHrFwh2NfExxWM?=
 =?us-ascii?Q?y5Un9AEs+V01rzV0y7wWDAcDWxDd3dVaSFJv26bme4YppTrPg6oL+KU4TZ8P?=
 =?us-ascii?Q?IjYGAMIF0/KyCNfPjaFRzOZkwrnuvyf24HEjRn/qHSSs8ubEU7y1WsdKy/cE?=
 =?us-ascii?Q?DWMqmHvhNjDSk0lCoE+uMAqXBA+flltWbMG3SnhzQ9L+Vadg5gW/A5i74I3b?=
 =?us-ascii?Q?JQvfpdkY6xetvb6dKbtQ7Ymh1KFNf8/dpOT9Ev+21siXaFbtOX6FqBB2yqv0?=
 =?us-ascii?Q?Lz4iTmhXzIRgKO6ioJ9pW1ujwCgrhPiLnW2QXzYoI6rKz2lVUzVn7c1nePAQ?=
 =?us-ascii?Q?PJTfdY40bXUWe+wMkK+jVDTsgJaCQiFg0KPiio/t/3560ezqyA2Jo5k1jbe2?=
 =?us-ascii?Q?wtPfHAxW0jd0rr+vKxA1rJd3fH0DxeYngdFvg9cPdoIFZwEufCr6rzqZCvs5?=
 =?us-ascii?Q?4zcbDlGTajJMht+/jSvnOIg3v3MaoYHSNXm8994qJN7iWuoahBtlj+Tsilc+?=
 =?us-ascii?Q?omZCl1OsXmFCgEKKC7HQq/8Gfvvfdu4EewR/Qj8ExtQcuM55lW0ZSmBxgRjz?=
 =?us-ascii?Q?c8k8dVC4PJL/2s1wRh6yCzZc1x2Rtz+PHOorcGYn4OSBMpwKMc7YiVieTmrZ?=
 =?us-ascii?Q?ThwO6HnOpQGi59yePT3bS7VKCPTIG3++zX/1qfEAP4qvTmXvxjer9Ge0hbeQ?=
 =?us-ascii?Q?o/8c5UE7XgLwv3NukZZUll42QhNZihtaJUFnPLcneEGtP2pBrS+90lyiHm6f?=
 =?us-ascii?Q?YU3dbWqSDYzhfq8HAKseBHmPgOUH2/vISlwuWRvTtEKBNvyY2cGejZT7CFVC?=
 =?us-ascii?Q?zsp2lIFfarP2RdWegbTaGi8s+AlpLecAMSN6j/rbTq/45w2YT4tgYlxn/YSd?=
 =?us-ascii?Q?+7NzApnQOkXNF5HHlwCrRp1jamtze0hLt8hoyjxmT0rhq6C8Pf9xfUC/CDiP?=
 =?us-ascii?Q?WQoGEznpqCQK6XAva5KQ+L6sqltI1kUt72X+a7q6APEdBQGmVMKJx4QIlFXS?=
 =?us-ascii?Q?VEwr4cMH/mUUrLka1xuqDfof?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ed7972-7bfd-4b41-4701-08d8e8b44374
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 19:46:59.8596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oBCv4WTz8fMLpqr9DkzG7xJPxxY3X2Z4D/0iQYPg6ElTgn9N0XvTMrmDvxkKucMlZCX9qyGuDUhR5YYl74JZWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4503
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

These are supposedly not required for AMD platforms,
but at least some HP laptops seem to require it to
properly turn off the keyboard backlight.

Based on a patch from Marcin Bachry <hegel666@gmail.com>.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1230
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

