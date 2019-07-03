Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0009C5E24A
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2019 12:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfGCKoF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 3 Jul 2019 06:44:05 -0400
Received: from m4a0040g.houston.softwaregrp.com ([15.124.2.86]:38619 "EHLO
        m4a0040g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725820AbfGCKoE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Jul 2019 06:44:04 -0400
Received: FROM m4a0040g.houston.softwaregrp.com (15.120.17.147) BY m4a0040g.houston.softwaregrp.com WITH ESMTP;
 Wed,  3 Jul 2019 10:43:43 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 3 Jul 2019 10:42:33 +0000
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (15.124.8.11) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 3 Jul 2019 10:42:33 +0000
Received: from BY5PR18MB3283.namprd18.prod.outlook.com (10.255.139.203) by
 BY5PR18MB3362.namprd18.prod.outlook.com (10.255.154.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.17; Wed, 3 Jul 2019 10:42:31 +0000
Received: from BY5PR18MB3283.namprd18.prod.outlook.com
 ([fe80::b587:8197:fcb2:bcd8]) by BY5PR18MB3283.namprd18.prod.outlook.com
 ([fe80::b587:8197:fcb2:bcd8%6]) with mapi id 15.20.2032.019; Wed, 3 Jul 2019
 10:42:31 +0000
From:   Chester Lin <chester.lin@suse.com>
To:     "lenb@kernel.org" <lenb@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     Joey Lee <JLee@suse.com>, Michal Hocko <MHocko@suse.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] ACPI: New eject flow to remove devices cautiously
Thread-Topic: [PATCH v2 0/3] ACPI: New eject flow to remove devices cautiously
Thread-Index: AQHVMYgfyMERSgIW2U2QrJLhLEHQRKa4tOEA
Date:   Wed, 3 Jul 2019 10:42:31 +0000
Message-ID: <20190703104212.GA5965@linux-8mug>
References: <20190703101348.3506-1-clin@suse.com>
In-Reply-To: <20190703101348.3506-1-clin@suse.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB7PR02CA0022.eurprd02.prod.outlook.com
 (2603:10a6:10:52::35) To BY5PR18MB3283.namprd18.prod.outlook.com
 (2603:10b6:a03:196::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chester.lin@suse.com; 
x-originating-ip: [202.47.205.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 689b17bb-099b-4d1b-95da-08d6ffa326b4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3362;
x-ms-traffictypediagnostic: BY5PR18MB3362:
x-microsoft-antispam-prvs: <BY5PR18MB33623627B25DB45B905B646A9EFB0@BY5PR18MB3362.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(7916004)(396003)(366004)(39860400002)(136003)(376002)(346002)(189003)(199004)(43544003)(7736002)(6486002)(66476007)(1076003)(73956011)(6246003)(66556008)(305945005)(14454004)(66946007)(99286004)(25786009)(66066001)(44832011)(33716001)(52116002)(66446008)(486006)(478600001)(476003)(8676002)(5660300002)(64756008)(4326008)(6436002)(53936002)(2201001)(186003)(11346002)(446003)(9686003)(6506007)(54906003)(6512007)(102836004)(81156014)(26005)(386003)(81166006)(2906002)(71190400001)(86362001)(6116002)(14444005)(229853002)(316002)(68736007)(256004)(3846002)(110136005)(33656002)(8936002)(76176011)(71200400001)(2501003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3362;H:BY5PR18MB3283.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2Xmd6balJUI5kyzecBXkWAvsH/MCpXZojRohI/5U5IuxygzLs0Jq2FRwecsLZr903aP1LoIbYhs7bTreP4CHmtPzxEa9Qy41YUTssZCjmwVfwWS4HM/Sx1jomSja+16eiBYaVsBSkROzU/H+NNS4IcqqQdzs2dM8JA7ZG2sz7tOkWC/yM5w1ml3r0CX6C+mAq2N4jYChUCYYdLzIxxxiwJO/H6+6sRy0b9W9C2VIeA94/+7tT9WfyeVgFCgXsLZ0Dd9UJsf5HD0yw1+LTqO36lxnw9/KxQahBQO8zLDGQZkmD56+SS2D3xgSV1vrOxKMhXWXwZcjUG2M4d8qvVKvrA5Fnum0V5to9Fihz0JQD/GmTmrdhVhnmyjU9jJhrWPfcLH4NCrgwrSnYcNpFO89wWsCS7aZKAQO4GzlrE3S/w0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <202322DE792AC847B615394A6C80F2DE@namprd18.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 689b17bb-099b-4d1b-95da-08d6ffa326b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 10:42:31.7352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chester.lin@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3362
X-OriginatorOrg: suse.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jul 03, 2019 at 10:14:39AM +0000, Chester Lin wrote:
> Currently there are two ways to handle ACPI device ejection. When an eject
> event happens on a container, the kernel just sends KOBJ_CHANGE to
> userland and userland should handle offline operation. For other device
> types, acpi_scan_try_to_offline() is called and it tries to put target
> device(s) offline and then removes all nodes once they are all offline.
> 
> However we found that sometimes applications could intensively access
> resources on ejectable devices therefore they could have risk if ejection
> suddenly happens and removes devices without any notification. In stead
> of executing the offline callbakcs directly, we want to introduce a new
> approach, which sends change events to notify all target nodes beforehand
> and hands over offline handling to userland so that userland can have a
> chance to schedule an offline task based on current workload. The online
> function to recover from failure is also changed, it follows the same
> approach to send change events rather than putting devices online directly
> , which means userland will also need to take care of online handling.
> 
> To ensure that eject function can work properly since normal users might
> not have their own offline/online handling, we will submit a generic udev
> rule to systemd upstream as default in order to deal with change events
> and take [offline/online] action accordingly. But the Hot-Removing part
> still remains so the hotplug function can run to it once target nodes are
> all offline.
> 


Here are default rules we are going to propose:

# 80-acpi-hotplug-eject.rules
# Generic rules for handling ACPI hotplug eject.

SUBSYSTEM=="*", ACTION=="change", ENV{EVENT}=="offline", ATTR{online}=="1", \
DEVPATH=="*", ATTR{online}="0"

SUBSYSTEM=="*", ACTION=="change", ENV{EVENT}=="online", ATTR{online}=="0", \
DEVPATH=="*", ATTR{online}="1"


> To easily monitor eject status and start over an eject process, there's a
> status trace mechanism in this eject flow, which helps to count current
> online devices under the ejectable target, and it can reschedule an eject
> event when all nodes within the device tree have been put offline.
> 
> v2:
> - device_sysfs: Add descriptions in /Document/ABI/testing/sysfs-bus-acpi
> - device_sysfs: Replace the declartion with DEVICE_ATTR_RW and add cancel
>   option in eject_store.
> - scan: Add a retry mechanism when userspace fail to put device offline.
> - scan: Add ready-to-remove state.
> 
> Chester Lin (3):
>   ACPI / hotplug: Send change events for offline/online requests when
>     eject is triggered
>   ACPI / hotplug: Eject status trace and auto-remove approach
>   ACPI / device_sysfs: Add eject_show and add a cancel option in
>     eject_store
> 
>  Documentation/ABI/testing/sysfs-bus-acpi |   9 +-
>  drivers/acpi/container.c                 |   2 +-
>  drivers/acpi/device_sysfs.c              |  94 ++++++-
>  drivers/acpi/glue.c                      | 146 +++++++++++
>  drivers/acpi/internal.h                  |  34 ++-
>  drivers/acpi/scan.c                      | 318 +++++++++++++++++------
>  drivers/base/core.c                      |   4 +
>  include/acpi/acpi_bus.h                  |   3 +-
>  include/linux/acpi.h                     |   6 +
>  9 files changed, 523 insertions(+), 93 deletions(-)
> 
> -- 
> 2.20.1
> 
