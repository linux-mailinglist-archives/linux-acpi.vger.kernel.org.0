Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6260F3E50AE
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Aug 2021 03:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237233AbhHJBkm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Aug 2021 21:40:42 -0400
Received: from mail-dm6nam12on2073.outbound.protection.outlook.com ([40.107.243.73]:54624
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234710AbhHJBkm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 9 Aug 2021 21:40:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0KanBjrTC6cogHtM40Adi81evj8etWNMzwV7xGUOKg4O24WuM3++hQ8rSQ7HIrqMNsOrOInQHe8eJ6MHJaNtFuzYTSBHAsfTYGwwzXKLc7a7/87muMu2p7bH+m0aV5Kppxu2v0ZfUlMT7QlMgJPCez4Mu4m2l4lHfeZUVoY5T7fJMwEsZMgE5Dn+5F9ufLlm12WrIfDJnz0WW85y3B2Bf3+9+fUpuWhfzUHDRo34oe1gt/EbCewphfzqWfjWThgjNTNLlb5ziae5OOhEl0XgtdxK7puSsQghqfWb8dhOMW+JWObym0bCagixVUastCOgxtPvsZ3WBvv9iVSBsSOtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoUwvjFXHpu27ws4KgjuSaN3gHuhrkt4VeNLk/rfoGM=;
 b=QFaXj33kYr/nv/RLgFF1ngiFm38uJFJTSNxbAsLFoPr9jRNZegOa3SYKHMaTvrtAf8Ktfa3sMPvZ05N/jATwnAQ7wxrdoMKF0rTfOJyKNai+9/nsgzRAAOir2+DCJvOgsAuBgZFaEKJFlGGWWQR5ExQ0PYkXsEy0CAeWac3sy8dok7JxfhDPwXbN/HlJ8plJOtKzssBq2ezsnHWUirVRKTGqZB+6kpCj36t5Y/Hgrf8/vLC2M2jTt8NaHu+CQs+JQtwU1nWBzDO7oLPCShYdVSPtM63OlqcM3EzI9mDUxAsnuK0GgrrFY5LufXfr05OqkvOCmqcUl4T1okeV+HF4Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoUwvjFXHpu27ws4KgjuSaN3gHuhrkt4VeNLk/rfoGM=;
 b=dW0vWopr10ZHCYc//jh5BMz4h2gD9NTOjUb4QboLa4Xx4Fzbxsgx2i0WeKND6zO3JAo+FP+7IgKO9HBesTjBpU8tza1qUGbfY2xT2suvPvGTDS8yx5HTmVqPJgJS6jhu5hpYMFDo6SKqsVx0XxnJ97RzKtcEjOTKTVsQr3SuQ20=
Authentication-Results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN6PR12MB4672.namprd12.prod.outlook.com (2603:10b6:805:12::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Tue, 10 Aug
 2021 01:40:19 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::e8ae:ebd6:7f5d:4b36]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::e8ae:ebd6:7f5d:4b36%7]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 01:40:19 +0000
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org
Cc:     Pratik.Vishwakarma@amd.com,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] ACPI: PM: s2idle: Invert Microsoft UUID entry and exit
Date:   Mon,  9 Aug 2021 20:40:04 -0500
Message-Id: <20210810014004.16399-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0039.namprd11.prod.outlook.com
 (2603:10b6:806:d0::14) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AUS-LX-MLIMONCI.amd.com (76.251.167.31) by SA0PR11CA0039.namprd11.prod.outlook.com (2603:10b6:806:d0::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Tue, 10 Aug 2021 01:40:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4672048-4eab-451e-1488-08d95b9fcfa7
X-MS-TrafficTypeDiagnostic: SN6PR12MB4672:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4672244947D5F299478B9902E2F79@SN6PR12MB4672.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:350;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0/u7asKzVAvdLLPkzkz6v7qkr0KyCvh64jSoGnu/WrQkNZrIMH+zCBGhSCYWHLGrCoT8vhcpkTFa093YyPSUUhYryvuBoTbl8NJhaAUJx+qNB1pfPPl9ui94qLZNJ7Okc+/7rtgiXhm9xAxWS0xseyL3yTBggd/0SUCajJ0biaY+9IYDibx0QoRKLmhNa2aESU6Ng4wJa7GdbHuIRl35Z2kRlSZ24fg88AgTSTjGVejdhrB+OKmDA8pzeuxOweh9RftDVvU0fJp+PWFuFiVEoRCqTw8XxIWcPtmwTdnR/1/yzi83Y7RzzuLQRsqFE1EzeFxut2MLCgOvt5Z6rT9PfH6m16qz+NMsNiQOWI/aMfoCcX0hKiUlRnUs0PUV3x0LjEeOtTGneqIMo0BN0+P8aGqJjgZRO77NMIMWbIHD7CDopGeR8gHAuAsd9mcUPF3G7nj4fqQUlrBQTDPCwmOVNJ78cuUXq8rYI0mCgj+OAZHA3SRFyLh0YQEIVejQmir6Tz1pMlBsD2uCdymwN1wRsHzs3KCPTDtqQqLV0CIp2o07vSdVbfhCl+N065/pMDFcI0PoNB2UN5Bh8VQxcrI45KNmClqR/sgtrk7usA6UrD3nJy5Ik2BPD6IqG6+c8LwS0sxC13Z9zKazpJ/uJ9OEt8eB6exoAAuCub99kUiImGl0Th1+mqupazNDPUN4Wq0cwPgWLJH8k1BQ6CnnkdMRUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(47530400004)(52116002)(7696005)(478600001)(6486002)(4326008)(316002)(45080400002)(186003)(2616005)(86362001)(83380400001)(66556008)(66476007)(956004)(66946007)(44832011)(26005)(52230400001)(8676002)(8936002)(1076003)(36756003)(966005)(6666004)(5660300002)(2906002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FeEjf698BIJcS16zugFhDi2irQiZw2fNpxk4z6SB8sdi23ACdStNDoPtzab8?=
 =?us-ascii?Q?nO7N/m0I6Fv/a/HpoVKPmlOMi/Wu+9pOh7WftocU2ST/aWClTQz2zonfw9gW?=
 =?us-ascii?Q?fmIrRqt59hCK9h04ndiHkWJsQgM69bHFrqPasztcM2RwaxN3I9GvCTNJhv9v?=
 =?us-ascii?Q?fTihYQ7jLXSiYTwi4RHOBRBGN2X2dD6mIGjR45FKLByLsruLOeLgx0ZM96wU?=
 =?us-ascii?Q?7Lxg5EA/p0Nrg7TYl6czasDZcbBQxZwuACW7+db2uYPcajDjHDZUo0zJeaCa?=
 =?us-ascii?Q?bXCXTuSx2M32Z99O2nMwAUa+RkfiXMQDFyafydBCDxI3/8C6d6KOfhoUtHwe?=
 =?us-ascii?Q?f4SFZ4FVn36SeDKTpmyutHcPXof+GG6AJEWXf2Za/Dn8+O4BGwQcR3P4fA7X?=
 =?us-ascii?Q?VYxmESnYkY2iONMkN4Sf5lwQHS82FMMAWzh8Y2TJjE26iW2GAG5F6IWJw5Ct?=
 =?us-ascii?Q?rR/c+6aWgrj0Ol1uzTz6gRZXnVHCv8443lBJ0/7FYs5opeprRJkOhMhhiXDT?=
 =?us-ascii?Q?fQbcgSUMiyk5p9/pP/GSK2nKbabVKKBhtQMGWn2vXK5eYHoEAnk2eVgIjmo2?=
 =?us-ascii?Q?QFf0z9qI+YzEzqeAW2lbNSkmk+kK6173c2/3OBVwH7CLUI2vls+qR6C6BG8a?=
 =?us-ascii?Q?KOfWq1HTopXjSkMesoySYVnxSUtkz+waqdLIDyAIWxlmRL3jcUqxvUxHnasu?=
 =?us-ascii?Q?xpHewtdRV/act7I8/Q42nTRN2GclZfC77lBg2jfxLHWZr/vGa0bj/oU37j2y?=
 =?us-ascii?Q?IK+qc2n6AQWRnshWWPYrQKmdcUb+6SAuFE8HBbb6zzW98jIGTnVVIXJWvAin?=
 =?us-ascii?Q?HKzKIiiV75bOvwU00O7nOLRtzQ/yvxpFhe4TOcqSxLhZHFzkffbw9ALlBhPy?=
 =?us-ascii?Q?js3Z+rcHIu1+J0FbQxkWkE0wxUgcjQteYl2uAGExjypUeU6puPfkU4kyh9+z?=
 =?us-ascii?Q?Es0bP0UbAgaevBBUtrfPL0ZA0huvqBOX2SFmeo6r1XxgULcGCcquw5btdRPA?=
 =?us-ascii?Q?6K0qFKZNusoAfu4GJ54Q0zyHYeHaiCSyAgZ+mtnT3+OnIrB2CzZaRSZzsQsN?=
 =?us-ascii?Q?cSwXteUbV2VF75Uz79AdGaV5+w9Fso5G9FA1beVFFACKm/D0yxJCIY7Kqdvr?=
 =?us-ascii?Q?NF3qi+JLGBHTh1V2o56HJtM9VaQT5dIVIIMUnfyOqcoiS5ke31SHsCOFGx8q?=
 =?us-ascii?Q?/bMk4pag9yT8v8wV1PTYGkrrTNFBEgDXUMVEgHUY8Ap/zC5NqYovm4hk8lFP?=
 =?us-ascii?Q?DwowQjTGjR1USMMiVexANlXlNwlOwoO+MsdazvK5LHRfaQ7Nj6Ztv8W5vXZi?=
 =?us-ascii?Q?jktEMrmu9tY0CMzNm0kqVsuT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4672048-4eab-451e-1488-08d95b9fcfa7
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 01:40:19.3049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7ChzYaHGNLOURqDU2r4GX0HKY5C7O5Cd0FCvscpA6/hnHoMjUrO3D7JG7nxcy4WxN39YPeJlDpH6/kvBxPLmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4672
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It was reported by a user with a Dell m15 R5 (5800H) that
the keyboard backlight was turning on when entering suspend
and turning off when exiting (the opposite of how it should be).

The user bisected it back to commit 5dbf50997578 ("ACPI: PM:
s2idle: Add support for new Microsoft UUID").  Previous to that
commit the LEDs didn't turn off at all.  Confirming in the spec,
these were reversed when introduced.

Fix them to match the spec.

BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1230#note_1021836
Fixes: 5dbf50997578 ("ACPI: PM: s2idle: Add support for new Microsoft UUID")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/x86/s2idle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index fbdbef0ab552..3a308461246a 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -452,7 +452,7 @@ int acpi_s2idle_prepare_late(void)
 	if (lps0_dsm_func_mask_microsoft > 0) {
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_ENTRY,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
@@ -479,7 +479,7 @@ void acpi_s2idle_restore_early(void)
 	if (lps0_dsm_func_mask_microsoft > 0) {
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_ENTRY,
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
 				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
-- 
2.25.1

