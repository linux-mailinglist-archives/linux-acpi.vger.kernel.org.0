Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E215212F3EC
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Jan 2020 05:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgACEzj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 2 Jan 2020 23:55:39 -0500
Received: from m9a0014g.houston.softwaregrp.com ([15.124.64.90]:59576 "EHLO
        m9a0014g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725890AbgACEzi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Jan 2020 23:55:38 -0500
X-Greylist: delayed 917 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Jan 2020 23:55:37 EST
Received: FROM m9a0014g.houston.softwaregrp.com (15.121.0.191) BY m9a0014g.houston.softwaregrp.com WITH ESMTP;
 Fri,  3 Jan 2020 04:54:37 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 3 Jan 2020 04:40:07 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (15.124.8.11) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 3 Jan 2020 04:40:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1tdnruQGhnTbqeafjj3B6GmvkR5ZsNrjkHrpCPl/m0gd9b3n2BvC/kaPoXgUQ42+2cidAK0RNiTHS/8BJynDwQXKJxCWmvp9YXSJznVzOB4U4EYDzC3C2DV8ZESy/Mg33Rt0KJvYNk/MZ6rBOAqt7YbDCSJxvFRrzYqZzpDpw6IshUrg6kz+A+AV9KDTtlfQnCrVNJ53yE67g2FEPPaH+rPyD5e1da2iDl9jldeY783yh9WEru7Uq0yX4GiT97CAeDE9m1r33BRdP+69P+TS5U6PuLsW6d++Psm5ZYLGDsdjMkU71IRZ+QOoPzOTnUnKTP00XcW3ff6XV5BsQjS9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4ktohHkmkfuuTJYEJt9aysA+6YbXyav3gMMUtdA6to=;
 b=WntSE7lc2Vw2ogNatPNQdOnM60WiCg6yZBvtKIepJaZZNc4VFOXjQ/6d4AVRvTiEEwOQOZ3bLEUk1uZAR0gSF1V1efGTNUf/9aG2JVFwfg5c6Sj2I+8S8o9ME1ZhzJeWcJCRA8kBHXdLOP/fM7IjpwOnHWB5+SADV3P5JCl2nELJ0Vk4TELtwxidCJF+9NKtlunNeOyTnhfoje6H4tUhhqF9aMT9tXV9jfd83384/bsdL8x+iqR7pySNT9AgR8Q/2GBfeRO4Op331W0l2tDNuHBxiSAJPsG8efV0/11qquW37yJbPUYEn60XHlCiJf7Swme4jviCHfsRAs3xGF4oUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from SN1PR18MB2126.namprd18.prod.outlook.com (52.132.196.157) by
 SN1PR18MB2205.namprd18.prod.outlook.com (52.132.193.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Fri, 3 Jan 2020 04:40:05 +0000
Received: from SN1PR18MB2126.namprd18.prod.outlook.com
 ([fe80::68a8:34cd:7c1c:f49d]) by SN1PR18MB2126.namprd18.prod.outlook.com
 ([fe80::68a8:34cd:7c1c:f49d%3]) with mapi id 15.20.2602.012; Fri, 3 Jan 2020
 04:40:05 +0000
Received: from localhost.localdomain (60.251.47.115) by HK2P15301CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.1 via Frontend Transport; Fri, 3 Jan 2020 04:40:02 +0000
From:   Chester Lin <clin@suse.com>
To:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        "erik.schmauss@intel.com" <erik.schmauss@intel.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joey Lee <JLee@suse.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        Chester Lin <clin@suse.com>
Subject: [RFC PATCH v2 0/3] ACPI: New eject flow to remove devices cautiously
Thread-Topic: [RFC PATCH v2 0/3] ACPI: New eject flow to remove devices
 cautiously
Thread-Index: AQHVwe/eOeHpkaonVUCr6B3rboJ5kA==
Date:   Fri, 3 Jan 2020 04:40:05 +0000
Message-ID: <20200103043926.31507-1-clin@suse.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2P15301CA0007.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::17) To SN1PR18MB2126.namprd18.prod.outlook.com
 (2603:10b6:802:29::29)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=clin@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.24.0
x-originating-ip: [60.251.47.115]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99d2f4d8-26f4-41a8-e323-08d7900700fc
x-ms-traffictypediagnostic: SN1PR18MB2205:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN1PR18MB22052B496FDBDA55E5EE380BAD230@SN1PR18MB2205.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0271483E06
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(199004)(189003)(43544003)(66556008)(66446008)(16526019)(64756008)(2616005)(8676002)(956004)(186003)(52116002)(66476007)(55236004)(36756003)(8936002)(478600001)(54906003)(81166006)(110136005)(6486002)(71200400001)(6506007)(69590400006)(107886003)(2906002)(1076003)(4326008)(5660300002)(66946007)(6512007)(26005)(316002)(86362001)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR18MB2205;H:SN1PR18MB2126.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lAu9pf8lqXL5vPQPgRID6oNxKSvAmOQRe4Gqv40mxsCnM4PVRuSWFIeXyAHNE0wcqUfRx50/sWEfqJCFQcn4drTwgYniM2omZhalZLB3E2LOCLp+PgHaz1MlDsT7srn8YODNi+iNk169ZKCjyi7fUK87Fplh63F7h2byHip5nv455SdV1o2Nyp2G7JrrMcYbE5/PIYmdGZOwG7GUQ/JSIrqFMKaRVdx2CwYFdUjUkZ75a9eXfGkNNeIzZ2MW3fYJCLxzZ9BzSUt6gOH7p7tokru9AdSwVP6Jc0EEcwmJjxXIaCcLBAWIciCfry8DerZEZbx/Fv8p/meLGvJC7J8m1hs+HJlkIDzDiik5GO7mHVXtzc77BQZDu3fBqtUDJCEjZfkgozSVQv92ISrKVMuQfGgch7QkjHAjRDBDW6yl6zC/Pk0RpaknHYFrMbKzNlZIz53Z1nuYwYMcSnWsnMckcCZUsAsycVzqwWwFYTKE+z/uXa/OW9RVG1IZvph6+JEHKypImCDMQly0NBsiQVtoMw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d2f4d8-26f4-41a8-e323-08d7900700fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2020 04:40:05.4097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lv96x31+hDVpk3mhWjBw6nJ534zV+9nGHV6XXkRcxEE3bHP0WHYBwiJzbqVYMt5s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR18MB2205
X-OriginatorOrg: suse.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Currently there are two ways to handle ACPI device ejection. When an eject
event happens on a container, the kernel just sends KOBJ_CHANGE to
userland and userland should handle offline operation. For other device
types, acpi_scan_try_to_offline() is called and it tries to put target
device(s) offline and then removes all nodes once they are all offline.

However we found that sometimes applications could intensively access
resources on ejectable devices therefore they could have risk if ejection
suddenly happens and removes devices without any notification. In stead
of executing the offline callbakcs directly, we want to introduce a new
approach, which sends change events to notify all target nodes beforehand
and hands over offline handling to userland so that userland can have a
chance to schedule an offline task based on current workload. The online
function to recover from failure is also changed, it follows the same
approach to send change events rather than putting devices online directly
, which means userland will also need to take care of online handling.

To ensure that eject function can work properly since normal users might
not have their own offline/online handling, we will submit a generic udev
rule to systemd upstream as default in order to deal with change events
and take [offline/online] action accordingly. But the Hot-Removing part
still remains so the hotplug function can run to it once target nodes are
all offline.

To easily monitor eject status and start over an eject process, there's a
status trace mechanism in this eject flow, which helps to count current
online devices under the ejectable target, and it can reschedule an eject
event when all nodes within the device tree have been put offline.

v2:
- device_sysfs: Add descriptions in /Document/ABI/testing/sysfs-bus-acpi
- device_sysfs: Replace the declartion with DEVICE_ATTR_RW and add cancel
  option in eject_store.
- scan: Add a retry mechanism when userspace fail to put device offline.
- scan: Add ready-to-remove state.

Chester Lin (3):
  ACPI / hotplug: Send change events for offline/online requests when
    eject is triggered
  ACPI / hotplug: Eject status trace and auto-remove approach
  ACPI / device_sysfs: Add eject_show and add a cancel option in
    eject_store

 Documentation/ABI/testing/sysfs-bus-acpi |   9 +-
 drivers/acpi/container.c                 |   2 +-
 drivers/acpi/device_sysfs.c              |  94 ++++++-
 drivers/acpi/glue.c                      | 146 +++++++++++
 drivers/acpi/internal.h                  |  34 ++-
 drivers/acpi/scan.c                      | 318 +++++++++++++++++------
 drivers/base/core.c                      |   4 +
 include/acpi/acpi_bus.h                  |   3 +-
 include/linux/acpi.h                     |   6 +
 9 files changed, 523 insertions(+), 93 deletions(-)

-- 
2.20.1

