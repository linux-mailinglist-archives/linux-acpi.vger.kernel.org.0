Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B05E43BA61
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Oct 2021 21:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbhJZTLS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Oct 2021 15:11:18 -0400
Received: from mail-co1nam11on2055.outbound.protection.outlook.com ([40.107.220.55]:46305
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235497AbhJZTLS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Oct 2021 15:11:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiJO4Lp+G3N97W8hOsea4Ynr9RpRq1V9yFmUFxZlqHblGyNTIqQoR9Z9ni8RiDW0WAzxUQ5Yg5Rv0lXyeD3sXArS/YLatDZlFaNok64L2nuS2kytgTZh+XomTZ7gNpCng2RLWh69O/LP2ldaK4UFipwsNIzybA/LoQjW4gSRV1SdB7Ke7kEV0hFpSNPXnkhpol2KsWU761do+KXIoqTAmekPukwNxJZ7m3BCZBfLQCDFZPvJ+KxHOO8u7By4S8fiifPDNHK1v0tbAHZDFdeEVX8nA9prhK15+O4wFeS5/ZIRT6MeXFK7iS/SbQM4492LsBMxVwL3vJff82HTIcXAhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNrlQ7sOuILAxGZt4dRDqNuouTBpqvELvDF8Pz4zum8=;
 b=M+O6UUOhsUqG7Ov3s87szUU9ZT7DEGYl0dCFOUkotdKLb95i4+dyqiW5iL2S6mTuAUWNcQxMIwTwvwpouKRiBcXGsQseGiPuhOI7dSOAMmLuu3VtigkBXVMpeP+mB74ngVeGa9+aQybKQwJzcgUg5ImoOd2gwi9VwwoOqyRyBMyi7EuDU0Z7PnuPkF4AGSpMstOhRsxAkz/45GgIjIXi1cbNHHilX7/BZx5HitUYnqZRHP8v7xfpPybPwyAUKmFE4lhKbjA+B7ThJvXzwQeDutooOCfya2Z1Kx9Y8oNQzvd3cumrm2AknSViClKAHMschodzqmUFG3Xr9heTbo1ZyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNrlQ7sOuILAxGZt4dRDqNuouTBpqvELvDF8Pz4zum8=;
 b=H4C84lJGD7DenIAo5+ZbflM9n2TyRduhf3KZAvjRgy4OpNkoYbqBKNhQ3ae41MoP4CnQTHpf9QetN8+9EQrojkWjCDbyWI+TJTYqU3fKJkUXR3+9DvySn1j7vqrim9R+N4PoN/kEiGvpUVhKzaMsp55pN6squKZFkDMlwwGpLe8=
Received: from BN9PR03CA0344.namprd03.prod.outlook.com (2603:10b6:408:f6::19)
 by BYAPR12MB3077.namprd12.prod.outlook.com (2603:10b6:a03:db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Tue, 26 Oct
 2021 19:08:49 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::b) by BN9PR03CA0344.outlook.office365.com
 (2603:10b6:408:f6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.22 via Frontend
 Transport; Tue, 26 Oct 2021 19:08:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 19:08:49 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 26 Oct
 2021 14:08:48 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>, <markpearson@lenovo.com>,
        <linux-acpi@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 0/3] Let other drivers react to platform profile changes
Date:   Tue, 26 Oct 2021 14:08:32 -0500
Message-ID: <20211026190835.10697-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41d5c5d0-c4c5-4192-3785-08d998b40ab4
X-MS-TrafficTypeDiagnostic: BYAPR12MB3077:
X-Microsoft-Antispam-PRVS: <BYAPR12MB30777EB39D4A2634F55DABC9E2849@BYAPR12MB3077.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BnlIOIm8bO/kSH93+A/FoWKGM8XMX2lNCbEDKVBP56hSkx5CcFgdmOALj7niXthlHPzKvFXaZl3rae1cKidjLqq3CMkFc5/C4wuZDVPrC80XGw9EyNrxZ1+Cav77dUfdxf4E+hnU1LHzLrk8gcqTDQhzpJ0SNCbCnjqCMRyqDRq6RChRUCP9AYN5ywSaKVq/eBZyYarvi4bqdfEmdUmzmwyb8cTTYLGsotZFRuorrq0Stbdq6z8tEy3sX/hDr23QajJN8SYh7kaExAfDd5Q4C4swe8bAMTwJM7l20WisNHjaunrHVcsVsh5XrLombjPQ50e+EveWD+wBBdrW2dqQJX6iAS0Enph7k17l8CUrMiktF4n89hF044GKKooe5lfC70WQywAANJUbN/m+NVIC/tCBZWqTZCP5lDTasbE9LyQKEiYgnhhJo3WdwsT7vi7yk5fOmAqSx8wHCIPhAmmiO35/3Z+X3MPpJYF+H64FRvaDr6f4iIHFtRQfFwfYOVD85In0yWJV20kjuBlET8gH2O4QvS3jBXOiOqgrAYyyy+dzitm8l+lrfcD4BG9sznMG/Ycpn6xLHy+YQ+fm/XAg+zU+S1ioQxoqWtXUXjtNamxtmwaqJK2J9sz18HickvX3iiuyJD8BFc5NKE8yvEGPPDGH6MNi1QAr51plR7s8ZpFIqBzTVm/y1j8wioXK5IwhCZR1xfBx7nRES+ZF4BkKogpanBYIQdCKplUSoWGA2vM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(81166007)(186003)(36860700001)(356005)(2906002)(1076003)(26005)(2616005)(4326008)(82310400003)(7696005)(70206006)(83380400001)(86362001)(54906003)(110136005)(316002)(8936002)(336012)(508600001)(426003)(5660300002)(8676002)(6666004)(36756003)(47076005)(16526019)(44832011)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 19:08:49.0324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d5c5d0-c4c5-4192-3785-08d998b40ab4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3077
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

Changes from v3->v4:
 * Simplify platform_profile_notify
   - No need to check cur_profile as platform_profile_get does it
   - No need to track ret as it's unused
Changes from v2->v3:
 * Add patches to avoid collisions in hp-wmi and asus-wmi symbols

Mario Limonciello (3):
  platform/x86: hp-wmi: rename platform_profile_* function symbols
  platform/x86: asus-wmi: rename platform_profile_* function symbols
  ACPI: platform_profile: Add support for notification chains

 drivers/acpi/platform_profile.c  | 46 +++++++++++++++++++++++++++-----
 drivers/platform/x86/asus-wmi.c  | 12 ++++-----
 drivers/platform/x86/hp-wmi.c    | 12 ++++-----
 include/linux/platform_profile.h | 10 +++++++
 4 files changed, 61 insertions(+), 19 deletions(-)

-- 
2.25.1

