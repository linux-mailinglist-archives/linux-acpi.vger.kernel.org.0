Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5A240BFF7
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Sep 2021 09:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbhIOHBc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Sep 2021 03:01:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:18149 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234862AbhIOHBc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 15 Sep 2021 03:01:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="222296073"
X-IronPort-AV: E=Sophos;i="5.85,294,1624345200"; 
   d="scan'208";a="222296073"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 00:00:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,294,1624345200"; 
   d="scan'208";a="610046528"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 15 Sep 2021 00:00:09 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 15 Sep 2021 10:00:09 +0300
Date:   Wed, 15 Sep 2021 10:00:09 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        andriy.shevchenko@linux.intel.com, rafael@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        jon@solid-run.com, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v2] software node: balance refcount for managed sw nodes
Message-ID: <YUGZ+bBpmYa8WUFb@kuha.fi.intel.com>
References: <20210914144409.32626-1-laurentiu.tudor@nxp.com>
 <YUC2q1du1vGjAtsd@kroah.com>
 <70940e81-c1cb-bb06-5184-32f5a36fb85d@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70940e81-c1cb-bb06-5184-32f5a36fb85d@nxp.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 14, 2021 at 07:16:04PM +0300, Laurentiu Tudor wrote:
> 
> 
> On 9/14/2021 5:50 PM, Greg KH wrote:
> > On Tue, Sep 14, 2021 at 05:44:09PM +0300, laurentiu.tudor@nxp.com wrote:
> >> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >>
> >> software_node_notify(), on KOBJ_REMOVE drops the refcount twice on managed
> >> software nodes, thus leading to underflow errors. Balance the refcount by
> >> bumping it in the device_create_managed_software_node() function.
> >>
> >> The error [1] was encountered after adding a .shutdown() op to our
> >> fsl-mc-bus driver.
> >>
> >> [1]
> >> pc : refcount_warn_saturate+0xf8/0x150
> >> lr : refcount_warn_saturate+0xf8/0x150
> >> sp : ffff80001009b920
> >> x29: ffff80001009b920 x28: ffff1a2420318000 x27: 0000000000000000
> >> x26: ffffccac15e7a038 x25: 0000000000000008 x24: ffffccac168e0030
> >> x23: ffff1a2428a82000 x22: 0000000000080000 x21: ffff1a24287b5000
> >> x20: 0000000000000001 x19: ffff1a24261f4400 x18: ffffffffffffffff
> >> x17: 6f72645f726f7272 x16: 0000000000000000 x15: ffff80009009b607
> >> x14: 0000000000000000 x13: ffffccac16602670 x12: 0000000000000a17
> >> x11: 000000000000035d x10: ffffccac16602670 x9 : ffffccac16602670
> >> x8 : 00000000ffffefff x7 : ffffccac1665a670 x6 : ffffccac1665a670
> >> x5 : 0000000000000000 x4 : 0000000000000000 x3 : 00000000ffffffff
> >> x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff1a2420318000
> >> Call trace:
> >>  refcount_warn_saturate+0xf8/0x150
> >>  kobject_put+0x10c/0x120
> >>  software_node_notify+0xd8/0x140
> >>  device_platform_notify+0x4c/0xb4
> >>  device_del+0x188/0x424
> >>  fsl_mc_device_remove+0x2c/0x4c
> >>  rebofind sp.c__fsl_mc_device_remove+0x14/0x2c
> >>  device_for_each_child+0x5c/0xac
> >>  dprc_remove+0x9c/0xc0
> >>  fsl_mc_driver_remove+0x28/0x64
> >>  __device_release_driver+0x188/0x22c
> >>  device_release_driver+0x30/0x50
> >>  bus_remove_device+0x128/0x134
> >>  device_del+0x16c/0x424
> >>  fsl_mc_bus_remove+0x8c/0x114
> >>  fsl_mc_bus_shutdown+0x14/0x20
> >>  platform_shutdown+0x28/0x40
> >>  device_shutdown+0x15c/0x330
> >>  __do_sys_reboot+0x218/0x2a0
> >>  __arm64_sys_reboot+0x28/0x34
> >>  invoke_syscall+0x48/0x114
> >>  el0_svc_common+0x40/0xdc
> >>  do_el0_svc+0x2c/0x94
> >>  el0_svc+0x2c/0x54
> >>  el0t_64_sync_handler+0xa8/0x12c
> >>  el0t_64_sync+0x198/0x19c
> >> ---[ end trace 32eb1c71c7d86821 ]---
> >>
> >> Reported-by: Jon Nettleton <jon@solid-run.com>
> >> Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> >> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> >> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >> ---
> >> Changes since v1:
> >>  - added Heikki's Reviewed-by: (Thanks!)
> >>
> >> Changes since RFC:
> >>  - use software_node_notify(KOBJ_ADD) instead of directly bumping
> >>    refcount (Heikki)
> >>
> >>  drivers/base/swnode.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> >> index d1f1a8240120..bdb50a06c82a 100644
> >> --- a/drivers/base/swnode.c
> >> +++ b/drivers/base/swnode.c
> >> @@ -1113,6 +1113,9 @@ int device_create_managed_software_node(struct device *dev,
> >>  	to_swnode(fwnode)->managed = true;
> >>  	set_secondary_fwnode(dev, fwnode);
> >>  
> >> +	if (device_is_registered(dev))
> >> +		software_node_notify(dev, KOBJ_ADD);
> >> +
> >>  	return 0;
> >>  }
> >>  EXPORT_SYMBOL_GPL(device_create_managed_software_node);
> >> -- 
> >> 2.17.1
> >>
> > 
> > I am seeing that this needs to go into 5.15-final, but how about any
> > further back?  Stable kernels?  
> 
> I think that's a good point. I can resend and Cc: stable if everyone's
> fine with that.
> 
> > Does this "fix" a specific commit?
> 
> I did not found a certain commit that introduced the breakage so don't
> know what to say here. I'd let more experienced people comment on this.

This fixes the commit that introduced the function, so:

Fixes: 151f6ff78cdf ("software node: Provide replacement for device_add_properties()")

thanks,

-- 
heikki
