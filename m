Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5001E394588
	for <lists+linux-acpi@lfdr.de>; Fri, 28 May 2021 18:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbhE1QDE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 28 May 2021 12:03:04 -0400
Received: from mail-dm6nam12on2066.outbound.protection.outlook.com ([40.107.243.66]:23808
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235511AbhE1QDD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 28 May 2021 12:03:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClgLBrdD9x3xGP7CBpaRl7vs7xBuMLU1BEZZS4aoL1cTucnGi4ACmqWrMiTffFuCUAGhC8y4Pd2w63zDfu63DCiCe+Vh1ai+ZU/5qtA1dpkFggIzBudXM7iqMTjE3ZXnopcA3y3Ea73HdklTCKR/Mhd63wmq1VwBpOHByIB6bOFtVl10MAMYCgxjrfqujFR1HaGg9VeUCDesFnYEmBbB0LyL1yNR0Hq8voE3fY2B9Ktdnd80gnHwvUQsYWX8QBVlHkpuDCzxltnkidCO4aJ0hRsAmTkVlVsggodQKfszFnH5sq0yEZ56cr/7tc1AvviVpW/9pJ1NGVnoPyTWKw3NLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjttfNtKh+4AdlWXaLFUkzwv5tX84lPI7MrAAW2SbXo=;
 b=dzNYa0XK+WObfX7BEtqvGC4E/L9FfBNpWOTzjDecSYITEnWGx/F6fqETFw8CyDt3H/wlt8uxgYiGzatMeuuwW/8HdNVhr2ILMVYe42kcK57Q7U96hm75Cu82kgQ+3OlLsCL8Rvk53QZQaQZ2jKGmNUtm6U3mCce1L+RHjAe9Dg32wU1qhapelcG/hBJb1fnDLbjJ08w1vKdMR0GsahG5Ym2tiI0dD5Ioh4WRDa8v8gFxKUxkaWn+RZeC03uQ5C1pQ//voCRe67wpGA0aK9P8KpxOFnr3dezRhMsx2nFBLxZSjltJoXBC1YRKHMfKdK/s+I2YwgHS75xAuVp3gqYqhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjttfNtKh+4AdlWXaLFUkzwv5tX84lPI7MrAAW2SbXo=;
 b=PyMIXmjSYJflBNI9TbwxpNR6hrx54lbeQfWdali+pkPPDwwO34fBd1MUJ9q7axFHLMSmP0AWciS2L7kkZUIJ2zNFIco+s5pfBZr6Beejyk7F8nb9zRA6vbzFgnFTE63dp0ZQPIHlkSJS55mceEwfGtA+GPsc7kAuA2HwQwMDKaY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2693.namprd12.prod.outlook.com (2603:10b6:a03:6a::33)
 by BYAPR12MB2775.namprd12.prod.outlook.com (2603:10b6:a03:6b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 28 May
 2021 16:01:26 +0000
Received: from BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6]) by BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6%3]) with mapi id 15.20.4150.032; Fri, 28 May 2021
 16:01:26 +0000
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
        linux-acpi@vger.kernel.org, rrangel@chromium.org,
        david.e.box@linux.intel.com, Shyam-sundar.S-k@amd.com,
        Alexander.Deucher@amd.com, prike.liang@amd.com,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 0/2] Improvements to StorageD3Enable
Date:   Fri, 28 May 2021 11:01:18 -0500
Message-Id: <20210528160120.9299-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [76.251.167.31]
X-ClientProxiedBy: SN1PR12CA0099.namprd12.prod.outlook.com
 (2603:10b6:802:21::34) To BYAPR12MB2693.namprd12.prod.outlook.com
 (2603:10b6:a03:6a::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AUS-LX-MLIMONCI.amd.com (76.251.167.31) by SN1PR12CA0099.namprd12.prod.outlook.com (2603:10b6:802:21::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 16:01:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a33d7044-42ac-49d2-2347-08d921f1d8bd
X-MS-TrafficTypeDiagnostic: BYAPR12MB2775:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2775B102F06F974DD507BEA0E2229@BYAPR12MB2775.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IUvKQc+SNYzlXl9peqAunY55EepRCXjbbUwth4DYhA3hsRb1iyjJHobrLT1oAKq6qjC03UcLGYRBjlDOuGN0+5wuDeAwWvB1rpKlyk3FATAlhc8P9aGPaok42LMHw5auDj4u8qWpbBpRn2HAWy21QxMKw9FxzTgq/9XDaVM0YoAabWxU5pdkD4LH7crJMoAb01fS70wvIO7Bl7Pcjufvv3df1HR0ymLHrzTz2z0TI1J27YkBAgYv/yRlID+9yi2AMeDdmb7RYAdA/bk0qfg4yKlCrKGSBb8MJxO2TLPu5c5oH9jVYJV7QbBNHeVXASJyK5i0x0j2HOEKU+51t4aYPnsCfPhkfqz0LN2/Qpaa8ZBfQxQiMjSWtv4Bt9N8r2GY70vyjq1P4MFpZKy8EMlpFoKnJucXZLqfNEXcpXFmfIfW6+uriRHoIhK5fCUh948LWpOYY5t8p5Kwj3RV8ABGq7TlCIDC/j1ENqpXGYdyJkBMcIzweYzJ/ZpjAN5vcXnyIYHN/0ZYeAuWeHkOILD3LU2WzRV0GaS/axgG0Qp9dBEDiV3grOGmZJjbXDt+ESrUMFmuhjTT3RQLQ7haeHLYd4dMX7Zk5L8LJADdhwIlVw4r+KA93WZl85OfRBwPSBJ9ewzbw44eN4eD36Xp52OvC3em6dM4mIiK7kWoIJlr0PY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2693.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(52116002)(8676002)(83380400001)(44832011)(7696005)(66476007)(1076003)(8936002)(956004)(36756003)(316002)(5660300002)(26005)(6666004)(86362001)(16526019)(2616005)(2906002)(186003)(38100700002)(4326008)(45080400002)(66946007)(478600001)(66556008)(38350700002)(110136005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PYiqPF2nAJgzNj8t/YdqVTQO2NiYNI5PLOw6xfXZ70jlmi8ScXwuKsIVxv1b?=
 =?us-ascii?Q?Xsmnf0DE50Q6wBJJDoSS45/yso+Id1fjXHTc2AD6jKi0R56Ztc4xQJzCXvYZ?=
 =?us-ascii?Q?DBO7wp1GM8pcoIo85I+rheNwXCExZttxo+0kzupL54ytsLnyGgFy9QV+JpZd?=
 =?us-ascii?Q?4Nl9WnMrr/j96V3KZMfWg7dViDGWdbTozguyAkEcUTSV+7KraWLKOGo8Szoa?=
 =?us-ascii?Q?0BYH1MOqEKp4FuLRSR6U9pwYjb6lFwmWmtnUdLxvkrKjd3nkYl+jvFLEggwN?=
 =?us-ascii?Q?ml/IZHPMDim3XLJXLq1LvWdIpsXjU5HL744k/u07Yphzs/5twhVucGgJy9qB?=
 =?us-ascii?Q?Vqoxx/EM95OjRBRkWVri3fV3F0Tv9uePq7krtJ/x9qXaiq1HmS/kTzld5w83?=
 =?us-ascii?Q?z6KPSgCURZjuJmn1OY7a9Nc6+wz3R4YnPtpJNzh1/3WhQ3uZBk71hVnIrKGZ?=
 =?us-ascii?Q?6eJehozTM7mPVWhNsdINIDQ4IyDw5mqeOGpqzQZGcwck8RIOsIzYThbnbhyg?=
 =?us-ascii?Q?sJLkY+RAEEoads9Hg9PS4FQJOI2qZ5ulZgyBqGCNGUB0M8U8SKaziHqNTNaN?=
 =?us-ascii?Q?GpGLzO4P1u7cM3Rn5HdI/NDGJQRNba0+6gMXTOCqPhAKbTfVJlq4UaHkaOD2?=
 =?us-ascii?Q?HQVRn29LiqEiXVCneP5sWCMCwGPtdA53FxXaCwq4Ct6LxDZxs0Ze2ghzCg+4?=
 =?us-ascii?Q?Jn8U+HZMa9/xZYqpytmqy3Ob/uDV5Uz5WX8epR5/jgm1GXxyoUFQgES1TdWz?=
 =?us-ascii?Q?eUxxChPP90yXkbsliTwRExwTmpoyya76SsZoUAbdyD/5wHKH7nbBzF32DtER?=
 =?us-ascii?Q?3Yqz+rjoy7Jemdgv3yu6hqqK2xKdE/Rep7uIMELq4zxeF8clIYXtqdcnMvw4?=
 =?us-ascii?Q?vLIzrFhsHvc89v+xLIpGkn1mD83l5At0KAbKseE/roiCQqVsF0Y9vretA7NA?=
 =?us-ascii?Q?oAkFpwXRw8iscdIE3hhJe2NYLTlr9Eb1FNWu1Ue07UY2KbmwFpDx1sm/VOim?=
 =?us-ascii?Q?tH0/ghjB284iWcNg2DovblhekloW1cJvN1lGeFizvrXEUEXBl2sSj+g3hU+S?=
 =?us-ascii?Q?y+nybQbgtoQxN0sNSFArFonVKCf3apxyyqENpbvKonQlngOKAvGsLLky2j6j?=
 =?us-ascii?Q?YPTmRJFvS7k8zfEwBZYgaUfcvoalFAvDK4Z1lk8X1S1JC4HwNtfIGQXpwp5C?=
 =?us-ascii?Q?Z9YAeeOVnc6aCHWZRZpwcKMzFSqNPvDqg2Sfbue/aVKgwFHiYBUCgpfelQO0?=
 =?us-ascii?Q?IRKfeIGtW28KLUdPX9e/gTFNJIDZXEGVCoCM8z7RrGGR5VnT97WEFBP+5a/L?=
 =?us-ascii?Q?dHOyyIAlawnVFVYZucN3BsK1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a33d7044-42ac-49d2-2347-08d921f1d8bd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2693.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 16:01:25.8483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6wG54BgfBqthmf6ffD3kEvuWBtIRAFZUAMlTvvpMBqFw1NMqe76UNMKPXWxw0PTIQHsuAfuC/jIypuuuvIFnuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2775
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

A number of AMD based OEM systems have problems coming out of s2idle,
which is rooted in that the NVME device power is cut off during s2idle.

That alone is not a bug - the architecture used on Cezanne, Renoir and
Picasso expects this.

Many of these systems do include the StorageD3Enable property, but it is
located in the PCI device itself not in a root port sibling like on Intel.

Intel confirmed that this during pre-production it was placed there, and
actually for production using the PCI device itself is sufficient.

During the course of discussions on the merits of different approaches it
was mentioned that although originally introduced for NVME devices, the
Microsoft specification makes allusions to non-PCI based ACPI storage
devices as well, so a proposal was created to move this into the ACPI
subsystem.

If at a later time different firmware solutions decide to advertise this
functionality, it may make sense to move out of acpi into a more generic
location.  However both AMD's and Intel's solutions for s2idle also rely
upon calling other ACPI drivers and adopting another solution will require
coming up with alternatives for those as well.

Mario Limonciello (2):
  nvme: Look for StorageD3Enable on companion ACPI device instead
  acpi: Move check for _DSD StorageD3Enable property to acpi

 drivers/acpi/device_pm.c | 24 +++++++++++++++++++
 drivers/nvme/host/pci.c  | 50 +---------------------------------------
 include/linux/acpi.h     |  5 ++++
 3 files changed, 30 insertions(+), 49 deletions(-)

-- 
2.25.1

