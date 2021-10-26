Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6B943B8FA
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Oct 2021 20:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238026AbhJZSIQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Oct 2021 14:08:16 -0400
Received: from mail-mw2nam12on2061.outbound.protection.outlook.com ([40.107.244.61]:54785
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236706AbhJZSIQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Oct 2021 14:08:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8wZLUhTNPmhdMaNGhU1Z8AfUMfOHR1OmJQIJj4YfBEY9zrsdDt+obiOimeUtb+DJMj4F2kjFEYQhn0UwgP6fKEjsYKf3BADQ7cGz7/2b5jDkE0ZKKhtSBuhnn684vw94Na5bi5zKcpGA0KvxIOQKVCXOwsD7tRGWJ/s3KUQGi20Q/Y6ZlWthkCASX8AGuf+c6TX3403vUYu7RBc2k/+pxlRj/k3t/nggW3HyEJz5R8qSKeRseDDEoSJkWUSRlYKUzKaMhxeQAuRnlt9NS01EE79wF/mo6432Hm6xGPqM/DNNshe4qwwm8jzr+DQAtlBG+X7B3ZbfYQGtmHrnak/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mP4XNzl48jOty25+JRbaDtNcrDTQeQw3+hKFa7O3WyE=;
 b=C1p2W+XfoxFRmG6H3ndoTKLrvz6Xj0w0+r2tGYVp+gFVFNw2NRujRY8KAW0PhTZUMMVFrULNJJaVTMLELCDuICrV653uKeBsCe9l2DnmeWjtFs7aIprqb4CWtoQ8SrEBwtosoWhuRv3XxM4v/2NkjUTwfL6CnKc6eI7K4NlMbNr5n3uVTdpUmBVimXETgaj9oYgxz9/GeowrsSKNSSshS0rEdo57AK3lE2wErfN240HGWsfAkjPV0uerrU03Zky2gXHikcWF6GxjoqOj21bL05vKaql8CPVPLzdWjcHALco43EwejJTMlN1mwwpURF0LCAWDReBF9ceuubqV7hAdZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mP4XNzl48jOty25+JRbaDtNcrDTQeQw3+hKFa7O3WyE=;
 b=KVteMDHhCLK+jDbFuX9mSXSUI3DEvp+0SkUjx/1b97I3vPJesTMoSeM4yD0UhuVEyFWcr4iR24eBFljKQ+/gSuZPoKCJKr1jJEdZ5TPvHMyTGwzc+54Jz7JdbAWQH5PwRwr6CJ0N/DudsNUwwdSC5MugASAVCjPOAYonPtfheL4=
Received: from BN0PR02CA0014.namprd02.prod.outlook.com (2603:10b6:408:e4::19)
 by BL1PR12MB5254.namprd12.prod.outlook.com (2603:10b6:208:31e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 18:05:50 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::92) by BN0PR02CA0014.outlook.office365.com
 (2603:10b6:408:e4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Tue, 26 Oct 2021 18:05:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 18:05:50 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 26 Oct
 2021 13:05:46 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>, <markpearson@lenovo.com>,
        <linux-acpi@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 0/3] Let other drivers react to platform profile changes
Date:   Tue, 26 Oct 2021 13:05:32 -0500
Message-ID: <20211026180535.9096-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c8ad5db-5718-49bb-2ca2-08d998ab3e59
X-MS-TrafficTypeDiagnostic: BL1PR12MB5254:
X-Microsoft-Antispam-PRVS: <BL1PR12MB525456169758ED7B72C4EDDEE2849@BL1PR12MB5254.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VR1MTYrkOf9tNkbDTUm4SODw4w26NkmmrgERTXwUE4NboCcyGIcQdM1Id3/DNxP0Iy5OEdv/FDpL9K8P7pdncBtTOzJZ72Ehds3Dy/fgX7nPx3yheCsTwBPAcptA+AA05Dd7Uc+H8NK9NeBvzrR42Tyfy7hMblSP1Nsd26WRvCeo6NplLbrBUgbYEJjj/zYGM4RFLON0j7Uiw8luShuyfSeJFKy9mdjcFziPBgH8Gufiz2+gK7nenoqXG9DOiDfWcM8YLTbk56yY+TrSJUqmt2ifjBQXde63m+Jsqjq5TsBhRw5XCUl8pUJj13MzsI1jVf3LMaHzF8pXQ4zXTfMRsM++nLqMuN+CMpr2eJhkkbpcAV7cmt8OF4DsKBdtCjjgVZaJFbHEWpKUTu9AbOiNGkZVz593Sz88NCjznIzu7uYfIpiHXpJanH5PCH5xWejGBfO6cuCNctxkVtfd8yHcnAe71fN3DkIP0C+N5XgmGUfeadGQPvPG33RORziRQYQQiNTFmGhraBdYsgHLYfw29weS6J809AJPnoV7YdLRQI3tpwyG2ts+leXgCc92IUTaH6X04Vn8Kdzu78FPiwCKJUiD6wAOYB2HgJ5ruQRyF/qomEcJrehmdXTh0U6WnIFInR6Sa0YfchcSAMi4tTfoi4z937VLy6op6F7ZoIl3Dqqs71uOUASdyqhHbGqF/sO/6dfSiP03yBUdnP3gZRVvScDBt7ZggLTxYI+oy/nSW6Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(508600001)(36756003)(316002)(8676002)(26005)(336012)(426003)(82310400003)(110136005)(86362001)(7696005)(5660300002)(2616005)(36860700001)(6666004)(4326008)(54906003)(81166007)(70586007)(1076003)(356005)(44832011)(2906002)(16526019)(186003)(83380400001)(70206006)(8936002)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 18:05:50.2027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8ad5db-5718-49bb-2ca2-08d998ab3e59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5254
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Currently only one driver can register as a handler for a platform profile.

This limitation means that if multiple drivers want to react to platform
profile changes that they will need to directly interact with individual
drivers.

Instead introduce a notification flow that drivers can register for event
changes.  The idea is that any driver that wants to can:
1. read the current profile
2. set up initial values
3. register for changes
4. react to changes

Note: currently this is accomplished by changing platform_profile_get to a
symbol that all drivers can get during initialization.  Another idea for
this may be to change:

`int platform_profile_register_notifier(struct notifier_block *nb)`

into:

`int platform_profile_register_notifier(struct notifier_block *nb,
					enum *profile)`

IOW return the current profile value as an out argument as part of
registration. I don't have a strong opinion.

Changes from v2->v3:
 * Add patches to avoid collisions in hp-wmi and asus-wmi symbols

Mario Limonciello (3):
  platform/x86: hp-wmi: rename platform_profile_* function symbols
  platform/x86: asus-wmi: rename platform_profile_* function symbols
  ACPI: platform_profile: Add support for notification chains

 drivers/acpi/platform_profile.c  | 48 ++++++++++++++++++++++++++++----
 drivers/platform/x86/asus-wmi.c  | 12 ++++----
 drivers/platform/x86/hp-wmi.c    | 12 ++++----
 include/linux/platform_profile.h | 10 +++++++
 4 files changed, 64 insertions(+), 18 deletions(-)

-- 
2.25.1

