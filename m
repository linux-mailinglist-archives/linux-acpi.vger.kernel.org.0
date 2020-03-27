Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1AB8195653
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Mar 2020 12:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgC0L0P convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 27 Mar 2020 07:26:15 -0400
Received: from m9a0014g.houston.softwaregrp.com ([15.124.64.90]:60660 "EHLO
        m9a0014g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726165AbgC0L0P (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 27 Mar 2020 07:26:15 -0400
Received: FROM m9a0014g.houston.softwaregrp.com (15.121.0.191) BY m9a0014g.houston.softwaregrp.com WITH ESMTP;
 Fri, 27 Mar 2020 11:24:54 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 27 Mar 2020 11:23:17 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (15.124.72.13) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 27 Mar 2020 11:23:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUBTi4klK84G2tTmegn2jh08sXiCZ4UqGJRSO7bEdJfMt14/1lbF5fIxJwXTe4/9MttH3MlXVwoaRQ8HUY+MNE0m/hvf1Q++HXZO9V2jgYbgfYXJxY4bDRbWNJfg+iSlx6Z516zklkYuylwS/ujzT+8JgyLtdBfDjKlu1s7qAhJWoepcll8iD8A2VHYmUWaYUqmH2UzmUZs5V5DImBeQt4ofJ+rGvSJyNUUT/9IdXdBY5JJ41xnOjjVe0Ce70af7A52qx0p2Jg6CTh4i10o6xfgHw6pw+/xqee7lpVPeg/tBRY9BITYkCooX4EMqsA2bj2cpaXrSkfqLiFbDjK51bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRBHFEtJQACsjeP8VcZBktMJPDlMlffBomz7GJ6T04Y=;
 b=l3ijcn4Ja2lQxSPQ26T9KGEFFAZkIANzqcyd/gR5pcQNk8a18fQYYFLzAM3XIELZC35ReA37QpX9kj7/7DJlJD0eO3JDyPKbpp77n8zzYWm6Xl3LemglP0IyzTNRND9DWblGk6CldosvVJcTbgOez9E63KSY3AQXsSArugONC88MZVLUFNvSWGffRY4Be5vQlaJs07A10sFmiQXxpDme9Xklkv18xW1rBG3GTyjyzek67B/xrNB1DytfkT8h2Bdi5unHkY/Mr4ZSBSQm+xp0dnHptOhJUOkfdyCT6WUxVuJjWNdL4Su9KP+IfQzhsgDpPsFkxQYvSz23Jwr3T9f4Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=clin@suse.com; 
Received: from SN1PR18MB2126.namprd18.prod.outlook.com (2603:10b6:802:29::29)
 by SN1PR18MB2095.namprd18.prod.outlook.com (2603:10b6:802:31::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Fri, 27 Mar
 2020 11:23:16 +0000
Received: from SN1PR18MB2126.namprd18.prod.outlook.com
 ([fe80::1b1:6ada:da24:d1e9]) by SN1PR18MB2126.namprd18.prod.outlook.com
 ([fe80::1b1:6ada:da24:d1e9%5]) with mapi id 15.20.2856.019; Fri, 27 Mar 2020
 11:23:15 +0000
From:   Chester Lin <clin@suse.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <robert.moore@intel.com>,
        <erik.kaneda@intel.com>, <gregkh@linuxfoundation.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devel@acpica.org>, <jlee@suse.com>, <mhocko@suse.com>,
        Chester Lin <clin@suse.com>
Subject: [RFC PATCH 0/3] ACPI: Flexible eject options to remove devices cautiously
Date:   Fri, 27 Mar 2020 19:22:44 +0800
Message-ID: <20200327112247.17691-1-clin@suse.com>
X-Mailer: git-send-email 2.24.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0162.apcprd02.prod.outlook.com
 (2603:1096:201:1f::22) To SN1PR18MB2126.namprd18.prod.outlook.com
 (2603:10b6:802:29::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (220.141.80.97) by HK2PR02CA0162.apcprd02.prod.outlook.com (2603:1096:201:1f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend Transport; Fri, 27 Mar 2020 11:23:12 +0000
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [220.141.80.97]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73ff1666-81ce-4c3c-75f4-08d7d2413e3c
X-MS-TrafficTypeDiagnostic: SN1PR18MB2095:
X-LD-Processed: 856b813c-16e5-49a5-85ec-6f081e13b527,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR18MB2095E1A6CBEB5A9037DA2F3AADCC0@SN1PR18MB2095.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(6666004)(66556008)(6512007)(66946007)(69590400007)(66476007)(316002)(1076003)(6486002)(107886003)(52116002)(6506007)(5660300002)(81166006)(81156014)(16526019)(186003)(8676002)(8936002)(4326008)(956004)(2616005)(2906002)(86362001)(478600001)(966005)(26005)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR18MB2095;H:SN1PR18MB2126.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KYAik3MXyPlqAdYAT1NtyCiNzn5T8jSh1QXjQz99MXBg9OAF9x6XPfMMG8DcQaH1ERN5iO6S6euAMhxlkUBIVyeHW8qykGt3/DK+iGeszMbgtmOlu2UgPr+WN7tNYwQpZ7R8b5YPRnrxc2uMxs2Q8CSau2SD3kjL2nFbxvRfjUUltxTWw16gZO+UpQ29zTroKWNJx7va/d7RCradqbhzu+y6wVOatJkRJdG/xG3RFDFy/8C6ElTca6H0o5dhWoVo4Llj883MgeVcKddYN//10Aj3gkcpblZXp/5cATFHhtHhTPVZG5vEHfcX+NZqVd8H7s4/A64RJw7N2XsrKrmF4r9kvabG+G3WFJG2dQHTPQpGqjD022wWy9esq1qXVAQ32Go6xSVMw+pUs4UTgBCRZi66tu0Xc2R7xoZB2ERQG4RHSlIT+Q9TFu5FeON05m6AlRZAsCQ/x1GIKw5RcHnzL3ms+swJ5Rssr3NNFHYWYHw5K96lFsltVJIfXJr9Nq2pbTt9QOV0wd2ET7H+x69WsvSuW/Oc45/pt+Htmg84NpGYfO4fQycUFzWVd+uKvBLKPDiXHuKR7SafGoOTyJ3Gww==
X-MS-Exchange-AntiSpam-MessageData: UOItVJD5u/he4AET/+AGrjhwmcGjf5NJ/jXeOQmjXWCw3tDPfsTz3Rq0m36blspYIYmNlE3HFrYfOTqi0+6uBRjSBrxea5F52qzYL0uHtLrM+2PTDdp4KI9crRgOxioOPSQmuM4O6/ddqcrb1WHQOg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ff1666-81ce-4c3c-75f4-08d7d2413e3c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 11:23:15.7060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ruTO1+HnBe1h8w+ypy4YP19iMN4U5wr2WOmfvhzT2DrTOb0nL1KQoRTNwZWV0/e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR18MB2095
X-OriginatorOrg: suse.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

* This proposal is derived from https://lkml.org/lkml/2020/1/2/1401

Currently there are two ways to handle ACPI device ejection. When an eject
event happens on an ACPI container, the kernel sends a KOBJ_CHANGE event to
userland and userland has to deal with offline operation. For other device
types, acpi_scan_try_to_offline() is called and it tries to put target
device(s) offline and then removes all nodes once they are all offline.

However we found that sometimes applications could intensively access
resources on ejectable devices therefore they could have risk if ejection
suddenly happens and removes devices without any notification. In stead
of executing the offline callbakcs directly, I want to introduce an
additional approach, which uses 'request_offline' attributes to remind
the kernel to notify userland that some devices have been planning to be
removed, so the applications running on those targets can be prepared and
determine when offline tasks should be done based on current workload.

This approach is disabled by default so it will not affect systems which
still use the original way. Once it's enabled, the kernel will only
send change events as offline requests of target nodes to userland, so
firmware or userspace callers who raise eject requests will still have to
re-trigger eject events if necessary because the kernel will not track all
targets' offline status actively. However, I still add an 'auto_eject'
attribute for userland if it's required to periodically schedule an eject
event until the target has been removed.

To ensure that eject function can work properly since normal users might
not have their own offline/online handling, I would propose a generic udev
rule to systemd upstream as default in order to deal with change events
and take offline/online actions accordingly:

*Example: 80-acpi-hotplug-eject.rules
------------------------------------------------
# Generic rules for handling ACPI hotplug eject.

SUBSYSTEM=="*", ACTION=="change", ENV{EVENT}=="offline", ATTR{online}=="1", \
DEVPATH=="*", ATTR{online}="0"

SUBSYSTEM=="*", ACTION=="change", ENV{EVENT}=="online", ATTR{online}=="0", \
DEVPATH=="*", ATTR{online}="1"
------------------------------------------------

Chester Lin (3):
  ACPI: scan: add userland notification while handling eject events
  ACPI: scan: add cancel_eject and auto_eject attributes
  ACPI: scan: add a request_offline_recursive attribute

 Documentation/ABI/testing/sysfs-bus-acpi |  43 +++++++
 drivers/acpi/device_sysfs.c              | 154 ++++++++++++++++++++++-
 drivers/acpi/internal.h                  |   4 +-
 drivers/acpi/osl.c                       |  37 ++++--
 drivers/acpi/scan.c                      | 108 +++++++++++++++-
 include/acpi/acpi_bus.h                  |   8 ++
 6 files changed, 339 insertions(+), 15 deletions(-)

-- 
2.24.0

