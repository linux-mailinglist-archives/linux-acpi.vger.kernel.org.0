Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C2023174B
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Jul 2020 03:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbgG2BfT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jul 2020 21:35:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:6431 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730117AbgG2BfT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Jul 2020 21:35:19 -0400
IronPort-SDR: J6nrg5ZV2i6tp/dHjEMSSHNElqWo7VGGnMQhLFr63+4a7knAxY8SZsTdLqaEpE9rjypcNQUqHf
 oWvzaH2YXCPQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="150512010"
X-IronPort-AV: E=Sophos;i="5.75,408,1589266800"; 
   d="scan'208";a="150512010"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 18:35:11 -0700
IronPort-SDR: YNsFNSmhqfBBgmI35x/2O7/pNXoR+a/bwag1n6Mwd4MKRcnT4XpSjxN7jGO6jeRF7/XLdB/SmJ
 NIW6+0gsiTZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,408,1589266800"; 
   d="scan'208";a="364700282"
Received: from vverma7-mobl4.lm.intel.com (HELO localhost6.localdomain6) ([10.254.21.148])
  by orsmga001.jf.intel.com with ESMTP; 28 Jul 2020 18:35:09 -0700
Message-ID: <25cb1c0c35d2ea2aa233c1db726abd86dadc54c0.camel@intel.com>
Subject: Re: [PATCH v3 10/11] PM, libnvdimm: Add runtime firmware activation
 support
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Pavel Machek <pavel@ucw.cz>, Ira Weiny <ira.weiny@intel.com>,
        Len Brown <len.brown@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Jiang <dave.jiang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 28 Jul 2020 19:35:09 -0600
In-Reply-To: <CAJZ5v0jb87PnwVXKuvgFeP=c-BGstc4YmANGpbOOnXi-b1oL8w@mail.gmail.com>
References: <159528284411.993790.11733759435137949717.stgit@dwillia2-desk3.amr.corp.intel.com>
         <159528289856.993790.11787167534159675987.stgit@dwillia2-desk3.amr.corp.intel.com>
         <CAJZ5v0jb87PnwVXKuvgFeP=c-BGstc4YmANGpbOOnXi-b1oL8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 2020-07-27 at 14:37 +0200, Rafael J. Wysocki wrote:
> On Tue, Jul 21, 2020 at 12:24 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > Abstract platform specific mechanics for nvdimm firmware activation
> > behind a handful of generic ops. At the bus level ->activate_state()
> > indicates the unified state (idle, busy, armed) of all DIMMs on the bus,
> > and ->capability() indicates the system state expectations for activate.
> > At the DIMM level ->activate_state() indicates the per-DIMM state,
> > ->activate_result() indicates the outcome of the last activation
> > attempt, and ->arm() attempts to transition the DIMM from 'idle' to
> > 'armed'.
> > 
> > A new hibernate_quiet_exec() facility is added to support firmware
> > activation in an OS defined system quiesce state. It leverages the fact
> > that the hibernate-freeze state wants to assert that a memory
> > hibernation snapshot can be taken. This is in contrast to a platform
> > firmware defined quiesce state that may forcefully quiet the memory
> > controller independent of whether an individual device-driver properly
> > supports hibernate-freeze.
> > 
> > The libnvdimm sysfs interface is extended to support detection of a
> > firmware activate capability. The mechanism supports enumeration and
> > triggering of firmware activate, optionally in the
> > hibernate_quiet_exec() context.
> > 
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > [rafael: hibernate_quiet_exec() proposal]
> > Co-developed-by: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> 
> IMO it's better to change this to
> 
> Co-developed-by: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> and please to add
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> to it as per the development process documentation.

Thanks Rafael, I've fixed this up in the branch I've prepared for the pull
request:

https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/log/?h=libnvdimm-for-next

> 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-nvdimm         |    2
> >  .../driver-api/nvdimm/firmware-activate.rst        |   86 ++++++++++++
> >  drivers/nvdimm/core.c                              |  149 ++++++++++++++++++++
> >  drivers/nvdimm/dimm_devs.c                         |  115 +++++++++++++++
> >  drivers/nvdimm/nd-core.h                           |    1
> >  include/linux/libnvdimm.h                          |   44 ++++++
> >  include/linux/suspend.h                            |    6 +
> >  kernel/power/hibernate.c                           |   97 +++++++++++++
> >  8 files changed, 500 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-nvdimm
> >  create mode 100644 Documentation/driver-api/nvdimm/firmware-activate.rst
> > 

[..]

> > @@ -464,6 +466,10 @@ static inline void hibernation_set_ops(const struct platform_hibernation_ops *op
> >  static inline int hibernate(void) { return -ENOSYS; }
> >  static inline bool system_entering_hibernation(void) { return false; }
> >  static inline bool hibernation_available(void) { return false; }
> > +
> > +static inline hibernate_quiet_exec(int (*func)(void *data), void *data) {
> 
> This needs to be "static inline int".
> 
Yep I got a build warning for this and also fixed it up.

Thanks,
-Vishal


