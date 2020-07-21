Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE19227363
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jul 2020 02:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgGUACW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Jul 2020 20:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbgGUACV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Jul 2020 20:02:21 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A609EC061794;
        Mon, 20 Jul 2020 17:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=O8Y/+nsNJHbgYqWOOnWf55XQh5kSU6RsCQr/mG4GMiI=; b=NPqWf5rMuVq6zxbo0VR7p0NyfS
        0nCJycXHEPlbEVuSy5pIrKWVQfChD3zPAHe6jQSOIyYQX2dymRXeJgs5N/tkeCC6k6TH0epLPMA9o
        8iKHfDXIc9yb/cCqiMNVew1gy5257dc2wU4u8E3PoW9DI87TH2F+ZVHCUqIWbW2XtPWovP8pyZwDT
        UxlfEHFzQ1stoGPJ1uL9PjCJg9M7SeNDeOFXqGP0TuvfCDgqNZzIcT3k//T7fqYVITtYWWTH3fVd3
        fWlYkkVjUMhqr+76br50FiFucTEwIB0C15hK2q62P1qJTLUSQuGHukNCYgR2yUCmD8rnWRbu4SzqS
        eJiCC6tQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxfjc-0004JH-TY; Tue, 21 Jul 2020 00:02:17 +0000
Subject: Re: [PATCH v3 10/11] PM, libnvdimm: Add runtime firmware activation
 support
To:     Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Cc:     Pavel Machek <pavel@ucw.cz>, Ira Weiny <ira.weiny@intel.com>,
        Len Brown <len.brown@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <159528284411.993790.11733759435137949717.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159528289856.993790.11787167534159675987.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c825b5ee-ec03-7aa8-e380-6003f33fa113@infradead.org>
Date:   Mon, 20 Jul 2020 17:02:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <159528289856.993790.11787167534159675987.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Dan,

Documentation comments below:

On 7/20/20 3:08 PM, Dan Williams wrote:
> Abstract platform specific mechanics for nvdimm firmware activation
> behind a handful of generic ops. At the bus level ->activate_state()
> indicates the unified state (idle, busy, armed) of all DIMMs on the bus,
> and ->capability() indicates the system state expectations for activate.
> At the DIMM level ->activate_state() indicates the per-DIMM state,
> ->activate_result() indicates the outcome of the last activation
> attempt, and ->arm() attempts to transition the DIMM from 'idle' to
> 'armed'.
> 
> A new hibernate_quiet_exec() facility is added to support firmware
> activation in an OS defined system quiesce state. It leverages the fact
> that the hibernate-freeze state wants to assert that a memory
> hibernation snapshot can be taken. This is in contrast to a platform
> firmware defined quiesce state that may forcefully quiet the memory
> controller independent of whether an individual device-driver properly
> supports hibernate-freeze.
> 
> The libnvdimm sysfs interface is extended to support detection of a
> firmware activate capability. The mechanism supports enumeration and
> triggering of firmware activate, optionally in the
> hibernate_quiet_exec() context.
> 
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> [rafael: hibernate_quiet_exec() proposal]
> Co-developed-by: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-nvdimm         |    2 
>  .../driver-api/nvdimm/firmware-activate.rst        |   86 ++++++++++++
>  drivers/nvdimm/core.c                              |  149 ++++++++++++++++++++
>  drivers/nvdimm/dimm_devs.c                         |  115 +++++++++++++++
>  drivers/nvdimm/nd-core.h                           |    1 
>  include/linux/libnvdimm.h                          |   44 ++++++
>  include/linux/suspend.h                            |    6 +
>  kernel/power/hibernate.c                           |   97 +++++++++++++
>  8 files changed, 500 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-nvdimm
>  create mode 100644 Documentation/driver-api/nvdimm/firmware-activate.rst


> diff --git a/Documentation/driver-api/nvdimm/firmware-activate.rst b/Documentation/driver-api/nvdimm/firmware-activate.rst
> new file mode 100644
> index 000000000000..9eb98aa833c5
> --- /dev/null
> +++ b/Documentation/driver-api/nvdimm/firmware-activate.rst
> @@ -0,0 +1,86 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==================================
> +NVDIMM Runtime Firmware Activation
> +==================================
> +
> +Some persistent memory devices run a firmware locally on the device /

                                  run firmware

> +"DIMM" to perform tasks like media management, capacity provisioning,
> +and health monitoring. The process of updating that firmware typically
> +involves a reboot because it has implications for in-flight memory
> +transactions. However, reboots are disruptive and at least the Intel
> +persistent memory platform implementation, described by the Intel ACPI
> +DSM specification [1], has added support for activating firmware at

that's an Intel spec?  just checking.

> +runtime.
> +
> +A native sysfs interface is implemented in libnvdimm to allow platform

                                                                 platforms

> +to advertise and control their local runtime firmware activation
> +capability.
> +
> +The libnvdimm bus object, ndbusX, implements an ndbusX/firmware/activate
> +attribute that shows the state of the firmware activation as one of 'idle',
> +'armed', 'overflow', and 'busy'.

                        or

> +
> +- idle:
> +  No devices are set / armed to activate firmware
> +
> +- armed:
> +  At least one device is armed
> +
> +- busy:
> +  In the busy state armed devices are in the process of transitioning
> +  back to idle and completing an activation cycle.
> +
> +- overflow:
> +  If the platform has a concept of incremental work needed to perform
> +  the activation it could be the case that too many DIMMs are armed for
> +  activation. In that scenario the potential for firmware activation to
> +  timeout is indicated by the 'overflow' state.
> +
> +The 'ndbusX/firmware/activate' property can be written with a value of
> +either 'live', or 'quiesce'. A value of 'quiesce' triggers the kernel to
> +run firmware activation from within the equivalent of the hibernation
> +'freeze' state where drivers and applications are notified to stop their
> +modifications of system memory. A value of 'live' attempts
> +firmware-activation without this hibernation cycle. The

  no hyphen^^

> +'ndbusX/firmware/activate' property will be elided completely if no
> +firmware activation capability is detected.
> +
> +Another property 'ndbusX/firmware/capability' indicates a value of
> +'live', or 'quiesce'. Where 'live' indicates that the firmware

no comma. no period. So this:

+'live' or 'quiesce', where

> +does not require or inflict any quiesce period on the system to update
> +firmware. A capability value of 'quiesce' indicates that firmware does
> +expect and injects a quiet period for the memory controller, but 'live'
> +may still be written to 'ndbusX/firmware/activate' as an override to
> +assume the risk of racing firmware update with in-flight device and
> +application activity. The 'ndbusX/firmware/capability' property will be
> +elided completely if no firmware activation capability is detected.
> +
> +The libnvdimm memory-device / DIMM object, nmemX, implements
> +'nmemX/firmware/activate' and 'nmemX/firmware/result' attributes to
> +communicate the per-device firmware activation state. Similar to the
> +'ndbusX/firmware/activate' attribute, the 'nmemX/firmware/activate'
> +attribute indicates 'idle', 'armed', or 'busy'. The state transitions
> +from 'armed' to 'idle' when the system is prepared to activate firmware,
> +firmware staged + state set to armed, and 'ndbusX/firmware/activate' is
> +triggered. After that activation event the nmemX/firmware/result
> +attribute reflects the state of the last activation as one of:
> +
> +- none:
> +  No runtime activation triggered since the last time the device was reset
> +
> +- success:
> +  The last runtime activation completed successfully.
> +
> +- fail:
> +  The last runtime activation failed for device-specific reasons.
> +
> +- not_staged:
> +  The last runtime activation failed due to a sequencing error of the
> +  firmware image not being staged.
> +
> +- need_reset:
> +  Runtime firmware activation failed, but the firmware can still be
> +  activated via the legacy method of power-cycling the system.
> +
> +[1]: https://docs.pmem.io/persistent-memory/


thanks.
-- 
~Randy

