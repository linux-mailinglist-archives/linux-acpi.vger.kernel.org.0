Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6FE5E23F
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2019 12:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfGCKlx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 3 Jul 2019 06:41:53 -0400
Received: from m9a0002g.houston.softwaregrp.com ([15.124.64.67]:40029 "EHLO
        m9a0002g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726628AbfGCKlx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Jul 2019 06:41:53 -0400
X-Greylist: delayed 1261 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jul 2019 06:41:52 EDT
Received: FROM m9a0002g.houston.softwaregrp.com (15.121.0.190) BY m9a0002g.houston.softwaregrp.com WITH ESMTP;
 Wed,  3 Jul 2019 10:41:50 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 3 Jul 2019 10:14:40 +0000
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (15.124.8.11) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 3 Jul 2019 10:14:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=O+0Ga6uQdrHlCl3idY9Tp61S3TMB0Tc2Q6JKJbC8qzkZ80k6iQB1KykeV6oXhueiqff3bxW3wAoOfrQI7w6BIX/0dzR9UfaEG5O/QPDGFwt1k3wKlG1vDDi2UFzOVEwERweyq9gJ+k4g+N2NZOMjXBx0GqnrXhOp2n8eZh8doYs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4ktohHkmkfuuTJYEJt9aysA+6YbXyav3gMMUtdA6to=;
 b=tklb88eqRCxouYcapPcPN+TIOZWoHnWgOQRAsC44yl1EBOCw952zCqqqNxwLTP4c+PA2On62/ikl0oTKmVGjCPZGkBNF2fUZ7PWOFRyyxpg1uR6CFbX8lBgEodBYEQntjUxuLyL9FUNYVq8hJBORkLfKl9hz3LFJ5vVlmUJmUgI=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
Received: from BY5PR18MB3283.namprd18.prod.outlook.com (10.255.139.203) by
 BY5PR18MB3156.namprd18.prod.outlook.com (10.255.136.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Wed, 3 Jul 2019 10:14:39 +0000
Received: from BY5PR18MB3283.namprd18.prod.outlook.com
 ([fe80::b587:8197:fcb2:bcd8]) by BY5PR18MB3283.namprd18.prod.outlook.com
 ([fe80::b587:8197:fcb2:bcd8%6]) with mapi id 15.20.2032.019; Wed, 3 Jul 2019
 10:14:39 +0000
From:   Chester Lin <chester.lin@suse.com>
To:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Joey Lee <JLee@suse.com>, Michal Hocko <MHocko@suse.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chester Lin <chester.lin@suse.com>
Subject: [PATCH v2 0/3] ACPI: New eject flow to remove devices cautiously
Thread-Topic: [PATCH v2 0/3] ACPI: New eject flow to remove devices cautiously
Thread-Index: AQHVMYgfyMERSgIW2U2QrJLhLEHQRA==
Date:   Wed, 3 Jul 2019 10:14:39 +0000
Message-ID: <20190703101348.3506-1-clin@suse.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB7PR02CA0035.eurprd02.prod.outlook.com
 (2603:10a6:10:52::48) To BY5PR18MB3283.namprd18.prod.outlook.com
 (2603:10b6:a03:196::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chester.lin@suse.com; 
x-mailer: git-send-email 2.20.1
x-originating-ip: [202.47.205.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe8bfa6e-e9ba-47d5-0424-08d6ff9f41ab
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3156;
x-ms-traffictypediagnostic: BY5PR18MB3156:
x-microsoft-antispam-prvs: <BY5PR18MB3156E1ABFDC1CF2EDC801E789EFB0@BY5PR18MB3156.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(43544003)(189003)(199004)(64756008)(478600001)(14444005)(66446008)(186003)(66556008)(73956011)(3846002)(66946007)(476003)(53936002)(26005)(2616005)(66476007)(256004)(316002)(7736002)(1076003)(2201001)(86362001)(6116002)(50226002)(5660300002)(71190400001)(99286004)(71200400001)(54906003)(110136005)(36756003)(107886003)(44832011)(6506007)(386003)(6512007)(2501003)(14454004)(2906002)(8936002)(68736007)(6436002)(486006)(25786009)(81156014)(305945005)(102836004)(4326008)(66066001)(81166006)(8676002)(52116002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3156;H:BY5PR18MB3283.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: izvrRTqB32CvgBdp4cbbbHfV/ATC7k1aZLk6P7hwTai+s4xTVrzfr+aDcELyFAF4InXJkW7/3onV101MCnv8EJ/yBRvYMFNhvSidC4CspB2CuBnSlpbkGj+//xSTMpPpisRwUIuwSRQ3dzMZkgOYpP2iSSNtzZjw3YMo87zzgl6wXHMpUcxGk6xMIyfKyduKjUCxn7P50CDXr2pddjA3xG1iuoEpP8ooFM06cBTCA8KnRHrFNj214pRAOWCN4r2gwYGVglaPjJCz1/H5tUrtFXtClA3lYGAly4asTo1nV3inwDpa3EQxIPLiBH+/BjNvS6tkooyXj1/KREiGwcECtkK1Xih/LGNivzfac8ogSdbVV37ERKquzNGABK4cAdv6tYDZDN3qWH2crrsYj3gFLPdaC2AmzEd0WhA1igaFf3s=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8bfa6e-e9ba-47d5-0424-08d6ff9f41ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 10:14:39.5368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chester.lin@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3156
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

