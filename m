Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A69227388
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jul 2020 02:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgGUAOj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Jul 2020 20:14:39 -0400
Received: from mga18.intel.com ([134.134.136.126]:64427 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbgGUAOj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 20 Jul 2020 20:14:39 -0400
IronPort-SDR: Eyls2rWrgATqyxWN8WEi5foDj5j5ztW6/eQUNv68uF1Tlln6Rz56k96viR/pKMq00Ng/w6KNVA
 DipgGSprCnOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="137520567"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="137520567"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 17:14:38 -0700
IronPort-SDR: foNkcki2lFSIZ7ICl68+/Uv+Z8LhfdF3TbQkArE+tXh2W9usFzXiWXvq7ZPsgkEZeY9/370sPA
 H62qxJyEVYiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="287729158"
Received: from vverma7-mobl4.lm.intel.com (HELO localhost6.localdomain6) ([10.254.51.48])
  by orsmga006.jf.intel.com with ESMTP; 20 Jul 2020 17:14:37 -0700
Message-ID: <a6892924b53e8610753a13fa506099558f0efc6f.camel@intel.com>
Subject: Re: [PATCH v3 10/11] PM, libnvdimm: Add runtime firmware activation
 support
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm@lists.01.org
Cc:     Pavel Machek <pavel@ucw.cz>, Ira Weiny <ira.weiny@intel.com>,
        Len Brown <len.brown@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Jiang <dave.jiang@intel.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 20 Jul 2020 18:14:37 -0600
In-Reply-To: <c825b5ee-ec03-7aa8-e380-6003f33fa113@infradead.org>
References: <159528284411.993790.11733759435137949717.stgit@dwillia2-desk3.amr.corp.intel.com>
         <159528289856.993790.11787167534159675987.stgit@dwillia2-desk3.amr.corp.intel.com>
         <c825b5ee-ec03-7aa8-e380-6003f33fa113@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 2020-07-20 at 17:02 -0700, Randy Dunlap wrote:
> Hi Dan,
> 
> Documentation comments below:

Dan, Randy,

I'm happy to fix these up when applying.

> 
> On 7/20/20 3:08 PM, Dan Williams wrote:
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
> > diff --git a/Documentation/driver-api/nvdimm/firmware-activate.rst b/Documentation/driver-api/nvdimm/firmware-activate.rst
> > new file mode 100644
> > index 000000000000..9eb98aa833c5
> > --- /dev/null
> > +++ b/Documentation/driver-api/nvdimm/firmware-activate.rst
> > @@ -0,0 +1,86 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +==================================
> > +NVDIMM Runtime Firmware Activation
> > +==================================
> > +
> > +Some persistent memory devices run a firmware locally on the device /
> 
>                                   run firmware
> 
> > +"DIMM" to perform tasks like media management, capacity provisioning,
> > +and health monitoring. The process of updating that firmware typically
> > +involves a reboot because it has implications for in-flight memory
> > +transactions. However, reboots are disruptive and at least the Intel
> > +persistent memory platform implementation, described by the Intel ACPI
> > +DSM specification [1], has added support for activating firmware at
> 
> that's an Intel spec?  just checking.
> 
> > +runtime.
> > +
> > +A native sysfs interface is implemented in libnvdimm to allow platform
> 
>                                                                  platforms
> 
> > +to advertise and control their local runtime firmware activation
> > +capability.
> > +
> > +The libnvdimm bus object, ndbusX, implements an ndbusX/firmware/activate
> > +attribute that shows the state of the firmware activation as one of 'idle',
> > +'armed', 'overflow', and 'busy'.
> 
>                         or
> 
> > +
> > +- idle:
> > +  No devices are set / armed to activate firmware
> > +
> > +- armed:
> > +  At least one device is armed
> > +
> > +- busy:
> > +  In the busy state armed devices are in the process of transitioning
> > +  back to idle and completing an activation cycle.
> > +
> > +- overflow:
> > +  If the platform has a concept of incremental work needed to perform
> > +  the activation it could be the case that too many DIMMs are armed for
> > +  activation. In that scenario the potential for firmware activation to
> > +  timeout is indicated by the 'overflow' state.
> > +
> > +The 'ndbusX/firmware/activate' property can be written with a value of
> > +either 'live', or 'quiesce'. A value of 'quiesce' triggers the kernel to
> > +run firmware activation from within the equivalent of the hibernation
> > +'freeze' state where drivers and applications are notified to stop their
> > +modifications of system memory. A value of 'live' attempts
> > +firmware-activation without this hibernation cycle. The
> 
>   no hyphen^^
> 
> > +'ndbusX/firmware/activate' property will be elided completely if no
> > +firmware activation capability is detected.
> > +
> > +Another property 'ndbusX/firmware/capability' indicates a value of
> > +'live', or 'quiesce'. Where 'live' indicates that the firmware
> 
> no comma. no period. So this:
> 
> +'live' or 'quiesce', where
> 
> > +does not require or inflict any quiesce period on the system to update
> > +firmware. A capability value of 'quiesce' indicates that firmware does
> > +expect and injects a quiet period for the memory controller, but 'live'
> > +may still be written to 'ndbusX/firmware/activate' as an override to
> > +assume the risk of racing firmware update with in-flight device and
> > +application activity. The 'ndbusX/firmware/capability' property will be
> > +elided completely if no firmware activation capability is detected.
> > +
> > +The libnvdimm memory-device / DIMM object, nmemX, implements
> > +'nmemX/firmware/activate' and 'nmemX/firmware/result' attributes to
> > +communicate the per-device firmware activation state. Similar to the
> > +'ndbusX/firmware/activate' attribute, the 'nmemX/firmware/activate'
> > +attribute indicates 'idle', 'armed', or 'busy'. The state transitions
> > +from 'armed' to 'idle' when the system is prepared to activate firmware,
> > +firmware staged + state set to armed, and 'ndbusX/firmware/activate' is
> > +triggered. After that activation event the nmemX/firmware/result
> > +attribute reflects the state of the last activation as one of:
> > +
> > +- none:
> > +  No runtime activation triggered since the last time the device was reset
> > +
> > +- success:
> > +  The last runtime activation completed successfully.
> > +
> > +- fail:
> > +  The last runtime activation failed for device-specific reasons.
> > +
> > +- not_staged:
> > +  The last runtime activation failed due to a sequencing error of the
> > +  firmware image not being staged.
> > +
> > +- need_reset:
> > +  Runtime firmware activation failed, but the firmware can still be
> > +  activated via the legacy method of power-cycling the system.
> > +
> > +[1]: https://docs.pmem.io/persistent-memory/
> 
> thanks.


