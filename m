Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5366B69A4C
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jul 2019 19:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732038AbfGOR5T (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Jul 2019 13:57:19 -0400
Received: from mail-eopbgr710065.outbound.protection.outlook.com ([40.107.71.65]:52976
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731078AbfGOR5T (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 15 Jul 2019 13:57:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxTubY5R0mhguOqLsX+mggQJ1h/R2jzE+UgRz/ASPij6kkos5c+cz3m0/8cVLRF6givi8RYyR70QQOEy8ag6tDtF9ItKP7vnmw84QYB2PbocVroWBGkvScqH7okWXcy0nAe1Q+QuYEHBv0aNXBg9K3Dt2MbT/fQE2bXCpUjZU+AZmQ+8hiuWA6x0PtcsKOFWFm1zPZpCGkN5jr7wZOzSu4bJegKTvnyq39FqRslBk74e5Ag7EAcqOb3vcjetZwLpnAFcmJ9iuWSj6oo3BNHBfpb2uIIX0ESnn9ojFeDEbqai6/n12nzM+oND13fe4anSQFqYpRz9UD4/CxyscZ1qSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPEHu6kCiSPbTkAF/6l3WZ2mtrQtMm6ZUBtCO4wjaJ8=;
 b=EGgNbiJSvAszfB0XUcKIJZ95Teqg4kJJt/QXUP2riOmWyGgbAcW2Uez3qHsmPBygbSbRrCbFS63aUu/2p5XqhAfHPDVYpys6m5njKHAg8NHa7apCf/pUEfJWtgf/NlYkOr7Z4oCdFHGq0+5wvFutYjMt2c/8ZK0EZk0vMBGslVBgh2BHmIINOOXVSSS3uTaXgeWfU8g5RtxH3RHOy7xb6sG7miP2mLhiA5pPdwwNXC/76XkgutWnlbSJjAUVhvZ7X2GgelKTxs5vJOO5zeoNumMVW59MEHqI00dTfCtyZZK0jkcIcKNLHb/4aR5Sx9giKcA6ylbN4F6mskX+xuHxrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPEHu6kCiSPbTkAF/6l3WZ2mtrQtMm6ZUBtCO4wjaJ8=;
 b=uVQ20nUXC1Jd+HhtBZAtBWv6nRwadQ6xEcAXE6M8l4h0Vrqdw8C6GhmMAU8KWJq1wKzVamogSzTc6AGd7TgZoh3LTepM5+gAVYbV2UOnkvAYCtYGywkskzQDyw4uttsk4+T9J07WiQBAIXVAwnQqFFkYT6/cCykQPnStO02og6o=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2782.namprd12.prod.outlook.com (52.135.107.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Mon, 15 Jul 2019 17:57:16 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::fd06:e03b:2b06:e8d7]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::fd06:e03b:2b06:e8d7%6]) with mapi id 15.20.2052.024; Mon, 15 Jul 2019
 17:57:16 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>
Subject: RE: [PATCHv3 0/6] CPPC optional registers AMD support
Thread-Topic: [PATCHv3 0/6] CPPC optional registers AMD support
Thread-Index: AQHVN057bBT6zB/KfUWS9uFb7V9o2qbIYcuAgAOQCkA=
Date:   Mon, 15 Jul 2019 17:57:16 +0000
Message-ID: <SN6PR12MB263964D82CED789D32AF58F1F8CF0@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <cover.1562781484.git.Janakarajan.Natarajan@amd.com>
 <20190713104619.GA3496@hirez.programming.kicks-ass.net>
In-Reply-To: <20190713104619.GA3496@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [2601:3c2:8280:2327:3414:3059:320b:d027]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ae91538-868a-4271-bb19-08d7094ddfd9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2782;
x-ms-traffictypediagnostic: SN6PR12MB2782:
x-microsoft-antispam-prvs: <SN6PR12MB2782A2C557780DF0E954B63EF8CF0@SN6PR12MB2782.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 00997889E7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(189003)(199004)(13464003)(9686003)(52536014)(6636002)(446003)(316002)(476003)(66556008)(6246003)(66476007)(229853002)(8676002)(64756008)(53936002)(55016002)(46003)(66446008)(66946007)(478600001)(74316002)(102836004)(76176011)(76116006)(14454004)(5660300002)(71190400001)(6436002)(99286004)(4326008)(7696005)(53546011)(305945005)(6506007)(7736002)(33656002)(8936002)(256004)(14444005)(86362001)(6116002)(81166006)(486006)(81156014)(186003)(71200400001)(54906003)(11346002)(2906002)(110136005)(25786009)(68736007)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2782;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fRJjb1JvjW3xJdodAtXkzcpGZnc85cpzTeDCvr/x5qebuU08nIgHJBB8R42I0cstTXKDBnDoRu6xJYDWsFFsdpZoUeKjnAc2/7COCs7n7lsVoAbWLL55iAREdGMjgupV20lhIz+iFiOKe5OOmbjzc/HCtSbiiWIAuiUtAV52KRB0BM2++VgsLHujLtm6uGiCb+BY0QxE90xCP2PXZ02XbhDI1BlqRa9C77hCxfwJbsncLe2t5SGswXXYXHNtvXRYA3F/PVvmvjPmd4fiCZo6wacJzXodoFAy1phRFkIVIQ00LWpDcaelRhgSj840HBwotCCUC/lIVmJ76JELGWBx7CAVkfrqaBD/xgs3YLAyvborXx24RLsYAn6zzFnP3/beqVBske+s2aU2kL44FaRV1Mj9s0QQHWZj1EmIZIK+1lA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae91538-868a-4271-bb19-08d7094ddfd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2019 17:57:16.7745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yghannam@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2782
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> -----Original Message-----
> From: Peter Zijlstra <peterz@infradead.org>
> Sent: Saturday, July 13, 2019 5:46 AM
> To: Natarajan, Janakarajan <Janakarajan.Natarajan@amd.com>
> Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-pm@vg=
er.kernel.org; devel@acpica.org; Rafael J . Wysocki
> <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>; Viresh Kumar <viresh.ku=
mar@linaro.org>; Robert Moore
> <robert.moore@intel.com>; Erik Schmauss <erik.schmauss@intel.com>; Ghanna=
m, Yazen <Yazen.Ghannam@amd.com>
> Subject: Re: [PATCHv3 0/6] CPPC optional registers AMD support
>=20
> On Wed, Jul 10, 2019 at 06:37:09PM +0000, Natarajan, Janakarajan wrote:
> > CPPC (Collaborative Processor Performance Control) offers optional
> > registers which can be used to tune the system based on energy and/or
> > performance requirements.
> >
> > Newer AMD processors (>=3D Family 17h) add support for a subset of thes=
e
> > optional CPPC registers, based on ACPI v6.1.
> >
> > The following are the supported CPPC registers for which sysfs entries
> > are created:
> > * enable                (NEW)
> > * max_perf              (NEW)
> > * min_perf              (NEW)
> > * energy_perf
> > * lowest_perf
> > * nominal_perf
> > * desired_perf          (NEW)
> > * feedback_ctrs
> > * auto_sel_enable       (NEW)
> > * lowest_nonlinear_perf
> >
> > First, update cppc_acpi to create sysfs entries only when the optional
> > registers are known to be supported.
> >
> > Next, a new CPUFreq driver is introduced to enable the OSPM and the use=
rspace
> > to access the newly supported registers through sysfs entries found in
> > /sys/devices/system/cpu/cpu<num>/amd_cpufreq/.
> >
> > This new CPUFreq driver can only be used by providing a module paramete=
r,
> > amd_cpufreq.cppc_enable=3D1.
> >
> > The purpose of exposing the registers via the amd-cpufreq sysfs entries=
 is to
> > allow the userspace to:
> > * Tweak the values to fit its workload.
> > * Apply a profile from AMD's optimization guides.
>=20
> So in general I think it is a huge mistake to expose all that to
> userspace. Before you know it, there's tools that actually rely on it,
> and then inhibit the kernel from doing anything sane with it.
>=20

Okay, makes sense.

Is there any way to expose a sysfs interface and make it explicitly "experi=
mental"? Maybe putting it in Documentation/ABI/testing/?

Or do you think it's just not worth it?

> > Profiles will be documented in the performance/optimization guides.
>=20
> I don't think userspace can really do anything sane with this; it lacks
> much if not all useful information.
>=20
> > Note:
> > * AMD systems will not have a policy applied in the kernel at this time=
.
>=20
> And why the heck not? We're trying to move all cpufreq into the
> scheduler and have only a single governor, namely schedutil -- yes,
> we're still stuck with legacy, and we're still working on performance
> parity in some cases, but I really hope to get rid of all other cpufreq
> governors eventually.
>=20

Because this is new to AMD systems, we didn't want to enforce a default pol=
icy.

We figured that exposing the CPPC interface would be a good way to decouple=
 policy from the kernel and let users experiment/tune their systems, like u=
sing the userspace governor. And if some pattern emerged then we could make=
 that a default policy in the kernel (for AMD or in general).

But you're saying we should focus more on working with the schedutil govern=
or, correct? Do you think there's still a use for a userspace governor?

> And if you look at schedutil (schedutil_cpu_util in specific) then
> you'll see it is already prepared for CPPC and currently only held back
> by the generic cpufreq interface.
>=20
> It currently only sets desired freq, it has information for
> min/guaranteed, and once we get thermal intergrated we might have
> sensible data for max freq too.
>=20

Will do.

> > TODO:
> > * Create a linux userspace tool that will help users generate a CPPC pr=
ofile
> >   for their target workload.
>=20
> Basically a big fat NAK for this approach to cpufreq.
>=20

Is that for exposing the sysfs interface, having a stub driver, or both?

Would it be better to have a cpufreq driver that implements some policy rat=
her than just providing the sysfs interface?

> > * Create a general CPPC policy in the kernel.
>=20
> We already have that, sorta.

Right, but it seems to still be focused on CPU frequency rather than abstra=
ct performance like how CPPC is defined.

This is another reason for exposing the CPPC interface directly. We'll give=
 users the ability to interact with the platform, using CPPC, without havin=
g to follow the CPUFREQ paradigm.

Do you think this is doable? Or should we always have some kernel interacti=
on because of the scheduler, etc.?

Thanks,
Yazen
