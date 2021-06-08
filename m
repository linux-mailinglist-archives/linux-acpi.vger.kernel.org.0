Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2A139F737
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jun 2021 15:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhFHNDc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Jun 2021 09:03:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:13149 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232625AbhFHNDb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 8 Jun 2021 09:03:31 -0400
IronPort-SDR: 5rmR/6Rk+pZ2dwhzhMdnQ39AlSgj+TdlWs+5TIeDLx/t7g1kFjh0L4qeisBVDZipEBN2zT8JYZ
 J5Pk+kPvJBzA==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="265989168"
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="265989168"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 06:01:33 -0700
IronPort-SDR: O9q71VJczxi+kOh5YnLFJDkvDQ2woJv1TIg7fO7p4XB7SX+3a+nibxJnoU/Dgv+FaDbJba31bV
 QDzj2UYwVkPw==
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="552271151"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 06:01:30 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 08 Jun 2021 16:01:28 +0300
Date:   Tue, 8 Jun 2021 16:01:28 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mario Limonciello <mario.limonciello@outlook.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi <linux-acpi@vger.kernel.org>
Subject: Re: Some SSDT tables are not loading with kernel >= 5.12
Message-ID: <YL9qKDq0bEv3dDjD@lahna.fi.intel.com>
References: <f634a05a-e3a9-93ab-4b87-d41f5ee083a5@redhat.com>
 <93d783c4-4468-023b-193e-3fc6eca35445@redhat.com>
 <a3c05e2f-af1c-ef19-4c9a-6b5b82d2da6d@redhat.com>
 <CAJZ5v0hYnEes7SDqwSqTGKQf4Qebr=gmj_qSQOPWKQzPdpAwrw@mail.gmail.com>
 <FR1PR80MB5051E91269FD36681BB357A7E1389@FR1PR80MB5051.lamprd80.prod.outlook.com>
 <YL5EjVDYLPhRKMIA@lahna.fi.intel.com>
 <209a230c-a7a6-7a8e-0515-97fb534d7401@redhat.com>
 <0f733402-ae3b-b4e7-13c4-e6161f9c7e81@redhat.com>
 <YL9YOlLosVeYfuuu@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL9YOlLosVeYfuuu@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 08, 2021 at 02:45:03PM +0300, Mika Westerberg wrote:
> Hi,
> 
> On Tue, Jun 08, 2021 at 11:50:15AM +0200, Hans de Goede wrote:
> > Hi,
> > 
> > On 6/7/21 9:18 PM, Hans de Goede wrote:
> > > Hi,
> > > 
> > > On 6/7/21 6:08 PM, Mika Westerberg wrote:
> > >> Hi,
> > >>
> > >> Tried now on ADL-P and TGL systems and the _OSC still works properly.
> > >>
> > >> Thanks Hans for fixing!
> > >>
> > >> Feel free to add my Tested-by.
> > > 
> > > Thank you for testing, unfortunately so far from the comments here:
> > > 
> > > https://bugzilla.kernel.org/show_bug.cgi?id=213023
> > > 
> > > it seems that my patch does not help resolve the issues caused
> > > by commit 719e1f561afb ("ACPI: Execute platform _OSC also with query
> > > bit clear"), where as reverting that commit does resolve them :|
> > > 
> > > Does anyone have any other ideas how to fix this ?
> > 
> > The reporter who has done the bisect has commented out the new/second
> > _OSC call and that fixes things for them. So I've written a new fix
> > (attached), note just as before this is untested ATM.
> > 
> > Mika, if you can test this one (it replaces the previous one)
> > on machines with native USB4 support to check those don't regress then
> > that would be great.
> 
> I can test it sure, but first let's try to understand what the problem is :)

FYI, I also tested your patch and it still works on my test system so if
we decided to go with that then feel free to add my Tested-by to the
patch too.
