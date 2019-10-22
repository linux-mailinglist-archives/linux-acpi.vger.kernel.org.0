Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3CCE0E04
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2019 00:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbfJVWGG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Oct 2019 18:06:06 -0400
Received: from mail-eopbgr130058.outbound.protection.outlook.com ([40.107.13.58]:25815
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727309AbfJVWGG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 22 Oct 2019 18:06:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jixoo6leoerlzSLnfLwDEbJa5v8ti6zfFsM6EsnYMesYr0VVURGlkDJF5IynkKDUP7npWxCqucNg+bL+xoQXeYuAKZlPUKAjMqYQaNAAzzWMiDpsFa2SRc9LY9IBiAUBhjzPGDj2pMP7J2tKZpasxzDf2jNY6RpZ81ZbWuopV6L9FCHppOiFFT5wjuYzH+0ANGldBKknrUt66795/kfAt0UtZowKlRRLVJ5AmpFEv0Zwivk4qVT0plpCMSQtFx+IETvBRNkwM/tIroM1FESG0nXuTLjqDMGCnvxaXSNFKxuwM/wxEoTwYlXptsEZHsFQYdQ4j/DzAkOBZy+NvjJX4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZo0m+B+BonoJRv3to84zMFBHmo+eqJD9WH60UBBf+g=;
 b=RFjB8RurNowuYLUCYdN7Xr/D1/yeVvIjO1IafG4T8eRMqMdNln3YgQcxFx7mwO/G8GSWJ1ExTmMqosQabmsHqbAbPRKdmsBIyAs92g1GzMzpB1NDTZFGVZSP69hudmaSwuTfydDaWAZqV0aPJzLBhcosr4YRF/Bvf1Sel5qsscB5LtgzR6dKe3vBnllpva2gIkczkfDCrfyhlbPOoSwE9JQs8WY60hWJvx+Vcdv1t9XIWl+RDVePTip0hOOEqaJ0ieO5WIJnd+R9XEYwKdYgIbjXJb8mqcu+znmSuqNBJlgsj27c32/FVl4vCacrzXyNmMs38NvDv2zg/uATSFfTfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZo0m+B+BonoJRv3to84zMFBHmo+eqJD9WH60UBBf+g=;
 b=IDeNFZ0UMjH6QWWHhQJLGaWG6YAKS3BLHeyCiJgtYKHN+Gq2oKf3+20BLzkIqnOeR0Y/GMuUZljwC/1HDp1NSFiQcjongHTfkLAYHdYeVnLArCKMgq5k9agtIOgijyCWgNq3YydLE9RVBpv2jEhceoWyTcKxAqZhF9sfyGxQLrc=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB6047.eurprd04.prod.outlook.com (20.179.24.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.19; Tue, 22 Oct 2019 22:06:01 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58d9:b0f7:b31:c05a]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::58d9:b0f7:b31:c05a%7]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 22:06:01 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Saravana Kannan <saravanak@google.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [RFT][PATCH 0/3] cpufreq / PM: QoS: Introduce frequency QoS and
 use it in cpufreq
Thread-Topic: [RFT][PATCH 0/3] cpufreq / PM: QoS: Introduce frequency QoS and
 use it in cpufreq
Thread-Index: AQHViSTjqsMfVqNAR0a2lS+zHVHmpw==
Date:   Tue, 22 Oct 2019 22:06:01 +0000
Message-ID: <VI1PR04MB7023DF47D046AEADB4E051EBEE680@VI1PR04MB7023.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 541beb6f-9859-44d1-b975-08d7573c0680
x-ms-traffictypediagnostic: VI1PR04MB6047:|VI1PR04MB6047:
x-ms-exchange-purlcount: 3
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB60470BF8313A646456143A77EE680@VI1PR04MB6047.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(189003)(199004)(478600001)(25786009)(6436002)(256004)(99286004)(55016002)(966005)(14444005)(9686003)(33656002)(102836004)(6506007)(5660300002)(7416002)(44832011)(52536014)(7696005)(66066001)(14454004)(305945005)(6306002)(486006)(7736002)(4326008)(476003)(26005)(186003)(81156014)(8676002)(229853002)(8936002)(6246003)(74316002)(66946007)(316002)(54906003)(81166006)(110136005)(91956017)(71190400001)(71200400001)(64756008)(2906002)(86362001)(66476007)(66446008)(66556008)(3846002)(6116002)(76116006)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6047;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YV4tCrui6NXgSHdYm5FjhHXuhrlMZvZB5aF6VaQvbBNxZztcmGirhNU3RaWCAY3Hk+6ZGaDRs/Gmq1AWdNExeM1WU2Tp8nzFA0DoW9X8A1DP4BkiCUfunSfrL5meqxx+ogm/vItBJFQ7FCiXWLZn6wlSitF3k+76VvongiZ12gbdZCY29ADgaErnkVhgP4JOfXXXEuxvp6sQdNChmzPJQRAMw0Fkj9LjOD84nnhmtYioSuctAPQAe5ZvCPoIct7CQlY4K2n/N8IAyGWPbz2sA4294ZhPlfSqkF/VNPKyJCfQwV8guhrsAqjnGXa8lU+NKXWY0Xi5TNNdoa4B9jzX7mz78/TbsGcnDNbsp4H/w2bcN5iUSwfL3NtmRng7c3xr+FWtEmPdVMCleR9BDsk6WBaFIjTfQNGr5uevPJV1YEkwqAZsHIdgBBMDA27/T3ei4q2EGZVtbpUIlf0ernaUDg==
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 541beb6f-9859-44d1-b975-08d7573c0680
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 22:06:01.3753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uZLh1mNJ1eV7Hzx6dFA+IpOsBkkimMkuhd5EIiT6KOw0lo3AgMKsNrxbRDuD+6mGhvYOyNShHALOe5c/2BH4Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6047
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello,=0A=
=0A=
I've been working on a series which add DEV_PM_QOS support to devfreq, =0A=
now at v9:=0A=
=0A=
	https://patchwork.kernel.org/cover/11171807/=0A=
=0A=
Your third patch removes DEV_PM_QOS_FREQUENCY_MIN/MAX that my series =0A=
depends upon. I found the email on patchwork, hopefully the in-reply-to =0A=
header is OK?=0A=
=0A=
As far as I can tell the replacement ("frequency qos") needs constraints =
=0A=
to be managed outside the device infrastructure and it's not obviously =0A=
usable a generic mechanism for making "min_freq/max_freq" requests to a =0A=
specific device.=0A=
=0A=
I've read a bit through your emails and it seems the problem is that =0A=
you're dealing with dev_pm_qos on per-policy basis but each "struct =0A=
cpufreq_policy" can cover multiple CPU devices.=0A=
=0A=
An alternative solution which follows dev_pm_qos would be to add =0A=
notifiers for each CPU inside cpufreq_online and cpufreq_offline. This =0A=
makes quite a bit of sense because each CPU is a separate "device" with =0A=
a possibly distinct list of qos requests.=0A=
=0A=
If cpufreq needs a group of CPUs to run at the same frequency then it =0A=
should deal with this by doing dev_pm_qos_read_frequency on each CPU =0A=
device and picking a frequency that attempts to satisfy all constraints.=0A=
=0A=
Handling sysfs min/max_freq through dev_pm_qos would be of dubious =0A=
value, though I guess you could register identical requests for each CPU.=
=0A=
=0A=
I'm not familiar with what you're trying to accomplish with PM_QOS other =
=0A=
than replace the sysfs min_freq/max_freq files: What I want to do is add =
=0A=
a driver using the interconnect driver which translates requests for =0A=
"bandwidth-on-a-path" into "frequency-on-a-device". More specifically a =0A=
display driver could request bandwidth to RAM and this would be =0A=
translated into min frequency for NoC and the DDR controller, both of =0A=
which implement scaling via devfreq:=0A=
=0A=
	https://patchwork.kernel.org/cover/11104113/=0A=
	https://patchwork.kernel.org/cover/11111865/=0A=
=0A=
This is part of an effort to upstream an out-of-tree "busfreq" feature =0A=
which allows device device to make "min frequency requests" through an =0A=
entirely out-of-tree mechanism. It would also allow finer-grained =0A=
scaling that what IMX tree currently support.=0A=
=0A=
If you're making cpufreq qos constrains be "per-cpufreq-policy" then =0A=
it's not clear how you would handle in-kernel constraints from other =0A=
subsystems. Would users have to get a pointer to struct cpufreq_policy =0A=
and struct freq_constraints? That would make object lifetime a =0A=
nightmare! But dev_pm_qos solves this by tying to struct device.=0A=
=0A=
And if you don't care about in-kernel requests then what's the purpose =0A=
of involving PM QoS? The old min/max_freq sysfs implementation worked.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
