Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A98D71842CE
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Mar 2020 09:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgCMIjj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Mar 2020 04:39:39 -0400
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:37699 "EHLO
        m9a0013g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726300AbgCMIji (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 13 Mar 2020 04:39:38 -0400
X-Greylist: delayed 1046 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Mar 2020 04:39:38 EDT
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.190) BY m9a0013g.houston.softwaregrp.com WITH ESMTP;
 Fri, 13 Mar 2020 08:38:59 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 13 Mar 2020 08:22:06 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (15.124.72.12) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 13 Mar 2020 08:22:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrFzaIygurwH7erOWaPz3lcH44bVFr25qro7/8VPWNpHFknP64i0Ydkt3h6Y3N1txY45eeZKlmHKeip/z5xPSLvePG+avrcaiVdcPhNzEuEQfJHGb1P8+HS36R/+rcAOF87J5hFoXgAjHsq8+qrNNfqrcsdhwlqlDzsEY1Br3NVlVrlY8cByDZ5e7QtlvVrDvGSw/EznM33S4otSPdZ40LAUtjdbVNHp7QD5uYCWagZIuwpr0GMxipDa1G0VymySbq+TvUbo6JAoQwD9nrfZxtwsdVBZG6cA0T8A7BbctgkABo8OHjXzuhY7tGUi1q1VDBbYEY7eodw2DUbGBzlfXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQ2QwrsjwO68qNLBjLcW4h7Qd7Rw6/cmti52RchPJ6w=;
 b=nbtSVsjLCtPMbxk4i+NCkZCpprFs05KmXu01KpvoO1mtNTc7q7mFajFfg1CbcZUrY+sq4mAOfqNGJ0zCvXykMWRr0lylt9V9BWy0SS5cOVrrAemAriOWHVFxqKOWxnzcsuoWbAIsj9COwkjqhFWZAgu3NSk9rgxhKIKQ2RayMXi7YFjhlRIEsPn0WNlfWlmKggq3WUJQ9uZWok9c4mYDVs23fo8xzt2Qd0XI+6otDmEmI2DlkeD6H3F5MIOFymZtLG7ZTntEBPsCOR6ZRU6KNzpTAqRkKlKQ3W2yXX4QJyfp6N9jPi/kVayHnFQSQkHxmTuEODqzK7DR7qKzU6L2hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=clin@suse.com; 
Received: from SN1PR18MB2126.namprd18.prod.outlook.com (2603:10b6:802:29::29)
 by SN1PR18MB2334.namprd18.prod.outlook.com (2603:10b6:802:26::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18; Fri, 13 Mar
 2020 08:22:04 +0000
Received: from SN1PR18MB2126.namprd18.prod.outlook.com
 ([fe80::1b1:6ada:da24:d1e9]) by SN1PR18MB2126.namprd18.prod.outlook.com
 ([fe80::1b1:6ada:da24:d1e9%5]) with mapi id 15.20.2814.007; Fri, 13 Mar 2020
 08:22:04 +0000
Date:   Fri, 13 Mar 2020 16:21:45 +0800
From:   Chester Lin <clin@suse.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     "lenb@kernel.org" <lenb@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        "erik.schmauss@intel.com" <erik.schmauss@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joey Lee <JLee@suse.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>
Subject: Re: [RFC PATCH v2 1/3] ACPI / hotplug: Send change events for
 offline/online requests when eject is triggered
Message-ID: <20200313082026.GA4725@linux-8mug>
References: <20200103043926.31507-1-clin@suse.com>
 <20200103043926.31507-2-clin@suse.com>
 <1702691.vqsIMzBuNn@kreacher>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1702691.vqsIMzBuNn@kreacher>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-ClientProxiedBy: LO2P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::23) To SN1PR18MB2126.namprd18.prod.outlook.com
 (2603:10b6:802:29::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-8mug (111.249.38.188) by LO2P265CA0011.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:62::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16 via Frontend Transport; Fri, 13 Mar 2020 08:21:59 +0000
X-Originating-IP: [111.249.38.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5cf9cdf-eacb-4daf-3d7f-08d7c7279bd2
X-MS-TrafficTypeDiagnostic: SN1PR18MB2334:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR18MB2334DFE79EBADB56D6E9CC18ADFA0@SN1PR18MB2334.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(199004)(53546011)(2906002)(81166006)(52116002)(8676002)(6496006)(54906003)(478600001)(8936002)(66476007)(66556008)(81156014)(6916009)(66946007)(316002)(33716001)(4326008)(16526019)(186003)(6666004)(9686003)(55016002)(956004)(1076003)(86362001)(33656002)(5660300002)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR18MB2334;H:SN1PR18MB2126.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DYBgRGT90xJEYccVNcE76zyfwliPtUsgs58hWJbXjZ+yQCfFL8+6lchPejtpZny+OLcmhpXohoHSiNr6N16tO3m4QMwJrJxXSoY55McoSMwtn3bvDIlVX2EEXU5EAPFDjUoUAYIjMlPx4L7rVzq/BgSlKJ0GZ37a3QwXcYzNziNW/Nm6M8BNAM0WoOZ4ui/9on62WJQQydJvDKNhm5QLM11cSRWrKJuvb7ppuVQYqVzff6g6JJKhRozEwEP2Vxis29vUB6R5lwKkSOnBd3CLPg+W/TEuZMqZuC4wfXbb2HWlozmA4MKJMghWUISGU7HSmBiC7z9slJrpEX9lHmih6M7jJWg5vwkU8BEKSinjwQc7I78YmoODFQKe5Qv6obfGhmLcwmYEvnwhIp/wz0tjOVTcF2i28hGAn5W8DE90Y0IzWWogcdkGEY7jaeULmHgC
X-MS-Exchange-AntiSpam-MessageData: JX9t1hgeAOV6+MDEK9iqbOxiYJo/DrNpkfAf+kkwS3XkCphpaH+vgh1lpOWlxH4JbVwwPV20MmmM69hcb2Tj9Xs3Jduo425Jl80QjRnszphvk/oFov/qNa0hIhGix6VosHb2ZM7R3xh/s81lAp/5nw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d5cf9cdf-eacb-4daf-3d7f-08d7c7279bd2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 08:22:04.1365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: feLljllCVy2hfUQaFqYeHuJ7eXTjTWgxfXaL99QBFGGLR+sVz1mRms7qeYEdYGi/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR18MB2334
X-OriginatorOrg: suse.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On Wed, Jan 15, 2020 at 11:15:08AM +0100, Rafael J. Wysocki wrote:
> On Friday, January 3, 2020 5:40:09 AM CET Chester Lin wrote:
> > Here we change offline/online handling in device hotplug by sending change
> > events to userland as notification so that userland can have control and
> > determine when will be a good time to put them offline/online based on
> > current workload. In this approach the real offline/online opertions are
> > handed over to userland so that userland can have more time to prepare
> > before any device change actually happens.
> > 
> > All child devices under the ejection target are traversed and notified
> > hierarchically based on ACPI namespace in ascending order when an eject
> > event happens.
> > 
> > Signed-off-by: Chester Lin <clin@suse.com>
> 
> So you replace the old flow with the new one and make the new one mandatory AFAICS.
> 
> Thus if anyone has relied on the old flow, they now need to switch over.
> 
> This is unfriendly and generally unwelcome, so please avoid making changes like
> that.
>
Thank you for the reminder.

> Instead, I would consider adding a device attribute to allow user space to
> opt in for getting offline notifications for specific individual devices (by
> setting that attribute user space would tell the kernel that it wants to
> get offline notifications for the device in question and it would take
> care of offlining it as needed).
> 
Thanks for your advice. If no one is working on this device attribute [please free
feel to correct me if I'm wrong], I am willing to implement it and will send a new
RFC patch for code review.

Regards,
Chester
