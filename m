Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FE8373C40
	for <lists+linux-acpi@lfdr.de>; Wed,  5 May 2021 15:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbhEENWA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 May 2021 09:22:00 -0400
Received: from mail-mw2nam10on2068.outbound.protection.outlook.com ([40.107.94.68]:40928
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232706AbhEENV7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 5 May 2021 09:21:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mw6YEN8dvhlNOAragUJDHT+YEuMALrZ/RtgkPQsL8GaThO0o8LM7T7G/HJty9OerzYq/xaS0vpapczEUvz6TK/6wlp+YKG7Z0Y6FdEXRfFaaXgwwS33JZoB1ewyDOas5iVeLmXYP7zKjF8D1c2IG9KKOhVfWryMCOVp4AxvQOe7JcjoGYfUT5yocwRMSjxgexOXFbh7r3WSlVupFDpp67bna/fb++uRKw4OflG9Lj80J7FkB4ek7k8Uri5+Cod2QEvbKtWCKb3s65DVPMtRTKKVUJDsQv/wbIPxlonz4/gZpSLAr5KMQzRiuD1ovGPRl3u2SxcPofllEbExM5mvU2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sY3xorEUYyHWFmAW7qdoMcFuVsXsY2VfbnLgic923Ms=;
 b=f2Xg1tfnavah/DYawNNNL2hNolxxXGjDSNuHUD8ZK4FKj8gFFz3+ftdbsqhqzv499oEiY9sn7/6Hzz+BaDv31K/g6nBl+cyCqb+RL3zxrgyV/SlNnS+kG0LENKhlssxx0l9lHEJl8SbePv3vj7F6uQlTv6wFEfEWWb1AA2Dy8s2JlN+EaNb4wcEwEnAf0W6RuzlysILWsc/mnSKNW6xY5DBsQiYT1HX5F4FGiA8PPEbYW3v1Ici9Vyz13luuqczM73Uym2Y7FyMtUlqjq3OyKQjCcJrnlL9qoPFNiEXQgwco23e6y8PyhWpycX6KPbycyufXt5rCg8yTYK/L/O/74Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sY3xorEUYyHWFmAW7qdoMcFuVsXsY2VfbnLgic923Ms=;
 b=w0tTYoZwYAGsIkCcFpeBINpwXaoYylHT61tenGC5HVf5KVlIjR+78w/PwHCf5fmT4zFs0D0nraf1lp7t94jbXEAZ1MTr0izDYYHMaDF5CK7D7epiEpUc9qFSkjbkF3vYEPxwDfRtHn955Q8932Ydo2A7cy4dcKIa1ApI8O+BQsc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4914.namprd12.prod.outlook.com (2603:10b6:208:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 5 May
 2021 13:21:01 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4108.025; Wed, 5 May 2021
 13:21:01 +0000
From:   Alex Deucher <alexander.deucher@amd.com>
To:     amd-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org, linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, Prike.Liang@amd.com, Shyam-sundar.S-k@amd.com,
        Alex Deucher <alexander.deucher@amd.com>,
        Marcin Bachry <hegel666@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] ACPI: PM: s2idle: Add missing LPS0 functions for AMD
Date:   Wed,  5 May 2021 09:20:32 -0400
Message-Id: <20210505132032.601097-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: MN2PR20CA0025.namprd20.prod.outlook.com
 (2603:10b6:208:e8::38) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by MN2PR20CA0025.namprd20.prod.outlook.com (2603:10b6:208:e8::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 5 May 2021 13:21:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bbfbabe-a1b2-4b35-425b-08d90fc8a0ce
X-MS-TrafficTypeDiagnostic: BL0PR12MB4914:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4914AB70EDB887086455CD5BF7599@BL0PR12MB4914.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 045+upPdon9Q/u1olabKgWBkV82m3mCLup1qF0qcgeVg8GQLjT0p7NWNH2LmpL9wRUW2S5PmVYiRJWLx23M2K0bP3f7F5+G3cAzmIGbd93Y6TGveKkvCplZsvsVwdg1BqP4woJno1VCaB3SLsoXy1SaJCnyABghi91WfvaX9w1AiplfxIgXj+wvxNaHOSbIbdQ9Tz2+ougrSMHjKSc2SmxB3sw34RwvEXHCjyPXH8GioZzm7DXdXsZgNXM2AfQkBA83cpDQe7qmKR34xYz5WSBuM2qlE1tKzRmZAKFyZJ0HCaDXBVGxdzlOTYq0pPyWv1G6S2NqwiMOE0Qxhpu6VQsrm3UZLw6RA+gTieX6HlW+SQZJHtlfQJb6UEaq6Z5MOgvir1ySb9TwjyBr2bGeLWOQVw7j3qB4f/m4mhZ4N97np1uvlKEH1prI1vm5dhvZYffbpMk85YthW7qmx7vVPID8MrVsLKJoo3RhPvGqk+MUOiuP9C/3cKtVhz88VlZBlUcH8+vMe2aNikUYQrTebV0hdkWCyCy2EsD/hw58Ykj+V79iGHNebyKbke4ktakwTEZ3MRNhK+gczFBHVmLkh501jQQOFcfIGVpnasv3mUf2Y2+JNYifdC8mN00ImhODO+nRL/SzHjVdN8SWLAv3tXe9W2irTYiMcWphu81J2nwERSdlwovO5VR20NOE904iGdGXoVTw1vBI3ABvcjVqMMe9ZfoJb4z8tFnkZJkjkMKM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(8936002)(26005)(966005)(478600001)(52116002)(38350700002)(38100700002)(6506007)(6666004)(83380400001)(316002)(8676002)(86362001)(956004)(36756003)(54906003)(66476007)(6512007)(66946007)(66556008)(16526019)(5660300002)(6486002)(2906002)(2616005)(186003)(1076003)(4326008)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?L0ftiIEO/iVKh/i2uZvDVL1pSzc/ZHbSsmyxH6S3k+KzmNyvIt3vn6n8Moup?=
 =?us-ascii?Q?WeD0X4CRpV9dAXlOmCTxjI9Bwy8Y0op06kafgy0IaLpbHD1wu9fe6jrG8qd0?=
 =?us-ascii?Q?CihtW4HqcBgtpTzK95Yun/wN44gL4Dh/ZSrIHDqGxjPYZb1VM+9rsMa1Q+HX?=
 =?us-ascii?Q?C7pSisW0viU7XNMmVZXpU5AJ3kvzCM6NDFNizPWeDJILWqxpQ9tDpAS48Ddw?=
 =?us-ascii?Q?/WR/4TkKEJFBWpLrLoVZbhRsrRl5bpwZkFSO/Tz3JP+60oa3fXdByUrQvMH4?=
 =?us-ascii?Q?u1waTVSgUkWUGc+5pIMCTp1Vdd18izXhKVACQsrgTkNBTPo9O7iE8R4yk8TD?=
 =?us-ascii?Q?ZkiVCUlLijvTJu+qq7OnU6JSvnUfo8NaijzcXK0aKXtphPY1zaKMk5k2rrOQ?=
 =?us-ascii?Q?vwS1KxzsgdfZORhNIpXQdsEIJuCxmJM4DXLyLYg0QfE/W1RghhZg7bRzxbPD?=
 =?us-ascii?Q?mEuYmVcq5QHwKRrlq/7kPjIL6GgGlrv1ds6/Z787YLK0RUYdcJOpJtJK2U57?=
 =?us-ascii?Q?0L5VXb3E2Ddf9doS7GTgGX/gXuElM7BgDlk8D8pPO3YqorxbYVzeNId1oSYv?=
 =?us-ascii?Q?IXhlgIIjxrtPHIc8plQD5sP0xA3Isd/FepH/54tJfgdi0K7evTMLPdjLbIIA?=
 =?us-ascii?Q?wVSwCMeGRBugm7AnlrEG6cU6xXL+/BokVHetZ7galGwHvsThYxLfhaqCRyFe?=
 =?us-ascii?Q?Cec/o6YggZIekUVj5azAXSeRLsP1VOHFqlHaedY5n7DBvW4pi1e00zIDSZQm?=
 =?us-ascii?Q?Buisca9G+QM1YcnyH0lXD/vpnq0lRW0jxmhRJlV0/SEvOU0FZfGprdsh3n2B?=
 =?us-ascii?Q?XE9zeA952BeWg1HWaAYSa1sg+EFvRKDu1Q+uzEtfHd3lgWXO04abfqlPjTMW?=
 =?us-ascii?Q?BbBytqLZ0TaoTEdfavuLRQrTODl+WsKJlr3Kw/Nu8LNI+ndhjKFL3zXz2M5F?=
 =?us-ascii?Q?o3T0ZlC3cHw2JLlqTbqprg8JMWypbb7wXwKqpejsj80hIA3sW8b82TBteVia?=
 =?us-ascii?Q?YnwzRwpupY++WZKD57P3VwNZMU9L9xivioWgta4dWNLvQcpf0HJiE9OD65Qk?=
 =?us-ascii?Q?Z1i3EBm80Prk3ADqZb84KwRFu23mBgMMS6XKeqYLLSd8TQZDix4Bc4/AAcFc?=
 =?us-ascii?Q?97AVjl3Jkr5WK4GLSu6EP/swJBe2MhJsw98hT9FZWZlLqO1BivpUwZhvgU7e?=
 =?us-ascii?Q?BBF9wlXiQBDvZ7I6Sw7zjCPoCJAoh2OMybfxWHse0JJMPo1+7ZXGS3icxiti?=
 =?us-ascii?Q?kJa+fhInoC+1yxec87ZYoo74eevl+0r0mJjRLtEkqF4qKdwUsGn2dRStmWPi?=
 =?us-ascii?Q?Ptol9aCpnwtFV4Mk/4gWKV3U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbfbabe-a1b2-4b35-425b-08d90fc8a0ce
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 13:21:01.6478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6mwEWcPwRvzt72TOBOYs8f34Jt0E6KuxM3y3SDj9k99NNUUM81SU9rp2USJnsteE2hq5ftmg+uFIVaiulNLxqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4914
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

Resend with updated subject.

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

