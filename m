Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C13F3813A3
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2019 09:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfHEHr3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 5 Aug 2019 03:47:29 -0400
Received: from m4a0039g.houston.softwaregrp.com ([15.124.2.85]:56971 "EHLO
        m4a0039g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726423AbfHEHr3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Aug 2019 03:47:29 -0400
Received: FROM m4a0039g.houston.softwaregrp.com (15.120.17.146) BY m4a0039g.houston.softwaregrp.com WITH ESMTP;
 Mon,  5 Aug 2019 07:47:24 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 5 Aug 2019 07:45:41 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (15.124.8.14) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 5 Aug 2019 07:45:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLWUeI999OBMs/7RXiKv/+fwrfElQXXPDrkvP25LpwOojV1zOEIjU3m5cyiK5vy936Mmapf6nWO+iDBvzHHZFqXKsx8DW4y+9bFcZ/VnEuyJptlKIGsV/l0mQvKKpEwzbBDh47UeLus51KWj5AZt0EntmmW73FZnwj1bzzkGpkk4XKFEIGAKs5smk1ljVTUfppLBqm8bJ49i4AHNrV0Kcw6PWZ3kL9CnMoGClTz7IF7tCSABNzuOs0inLMPKlsZ4csIkaGQMh6gPlZ40qWnE6vT9KgTIrkfl/W68gEM+sm+UfBlYIvsqMXa907sz7FnwgTfDh2cj2YKro/BkcfO3qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxWbUoKL5+EQSrx/T+5USq0PuHQoDgh8hLCNBqp8+f8=;
 b=fEhu0BZZVA/JgkhQ1tSU682VaPdYg+aPi3Xj+BtKMb40r+Iylauzxv13W3NaBzH1OSF/pH+JQL7mkyhVY4Y+cohicbI0KyEaDBY7ON+oEwAcOiJyHkp9QEkzcZLNtwQJ7yIkZXBZ+c69un9J5A6Qvrsa1mS2SSi45w89r7LP9yfzl9pvVA0HvCUaOizwWsDNvwTpcAVkPt7EiNY+bhRixQblLXESAiPJRNbernDYm9esgXAvKCiG3xLVCBzZmUJolUG0FJc32YbTwL9BYV7rAaIMngLZisr2YvARjigWZ7UG8brjlKYdmu9qaGJtxEIYRdz0pibMlNn9tqt75r+3Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=suse.com;dmarc=pass action=none header.from=suse.com;dkim=pass
 header.d=suse.com;arc=none
Received: from BY5PR18MB3283.namprd18.prod.outlook.com (10.255.139.203) by
 BY5PR18MB3393.namprd18.prod.outlook.com (10.255.136.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Mon, 5 Aug 2019 07:45:39 +0000
Received: from BY5PR18MB3283.namprd18.prod.outlook.com
 ([fe80::b587:8197:fcb2:bcd8]) by BY5PR18MB3283.namprd18.prod.outlook.com
 ([fe80::b587:8197:fcb2:bcd8%6]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 07:45:39 +0000
From:   Chester Lin <clin@suse.com>
To:     Chester Lin <clin@suse.com>
CC:     "lenb@kernel.org" <lenb@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "Joey Lee" <JLee@suse.com>, Michal Hocko <MHocko@suse.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] ACPI: New eject flow to remove devices cautiously
Thread-Topic: [PATCH v2 0/3] ACPI: New eject flow to remove devices cautiously
Thread-Index: AQHVMYgfyMERSgIW2U2QrJLhLEHQRKbsYEiA
Date:   Mon, 5 Aug 2019 07:45:39 +0000
Message-ID: <20190805074455.GA25210@linux-8mug>
References: <20190703101348.3506-1-clin@suse.com>
In-Reply-To: <20190703101348.3506-1-clin@suse.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB6P191CA0021.EURP191.PROD.OUTLOOK.COM (2603:10a6:6:28::31)
 To BY5PR18MB3283.namprd18.prod.outlook.com (2603:10b6:a03:196::11)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=clin@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [202.47.205.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a238bac-f29f-4978-9484-08d71978e8ca
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3393;
x-ms-traffictypediagnostic: BY5PR18MB3393:
x-microsoft-antispam-prvs: <BY5PR18MB33933590A8823945D71BB538ADDA0@BY5PR18MB3393.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(189003)(199004)(43544003)(68736007)(6436002)(229853002)(81166006)(71190400001)(81156014)(71200400001)(54906003)(5660300002)(7736002)(3846002)(305945005)(6116002)(4326008)(26005)(6486002)(2906002)(1076003)(316002)(8676002)(66066001)(76176011)(14444005)(11346002)(476003)(478600001)(6200100001)(14454004)(66446008)(64756008)(256004)(66556008)(66476007)(6246003)(66946007)(386003)(6506007)(102836004)(6862004)(53936002)(99286004)(52116002)(446003)(9686003)(25786009)(186003)(6512007)(486006)(33656002)(33716001)(8936002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3393;H:BY5PR18MB3283.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zAuYKitri0MxBmLDDb3p3DxxxNTMO9FNMtGa/MV04WfeiV+VEcK+/ka3oFqAO4gG86G++dyq9/+/zFZ1I68tUAJMp5l8zYNRY8KRU2B3vgroOlcEbCPhGfOWEiY2NkK8pDEgrP2Dmg/NSqKVP37Bh6luVDM3yYZoNKHULCSWgM3m9HgQgKYOdajE37pGUClv2kcmHxaVqA0UBx3zjernsz1CxGz7zVKfS6YfCJS+jvAVx2lfgiNNFdP5wAg8i/ZsFl+jYMtwbwJLLSm+nmsHKz2YHqVPB0mOXMuvbj/Y1VFdgk+gSCVuRNXxFDDkXsSaUUI+sbcxSOz05TKr63bjoPFWN61KOyw6tAD/F/q2zQ5eDkAIzR6gUI4xC9WX6ELlWZL81Rixm+2k9SNmPkJ2D9TO14jkw+C/T07HnOos65M=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23FC4315793E6942B84B7C796541560C@namprd18.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a238bac-f29f-4978-9484-08d71978e8ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 07:45:39.1723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: clin@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3393
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

Gentle ping. I will appreciate any comment on this series.

Thanks,
Chester
