Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB1B712ED
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Jul 2019 09:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732760AbfGWHc4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Jul 2019 03:32:56 -0400
Received: from mga05.intel.com ([192.55.52.43]:11117 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732747AbfGWHc4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Jul 2019 03:32:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2019 00:32:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,298,1559545200"; 
   d="scan'208";a="188783936"
Received: from jiajial1-mobl1.ccr.corp.intel.com ([10.255.30.115])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jul 2019 00:32:54 -0700
Message-ID: <1563867173.2455.50.camel@intel.com>
Subject: Re: [PATCH] int340X/processor_thermal_device: Fix
 proc_thermal_rapl_remove()
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 23 Jul 2019 15:32:53 +0800
In-Reply-To: <CAJZ5v0ik4b0LZ_WwscvZ_WibaN89DWCy-J1KZCJCCkh5TiGXAg@mail.gmail.com>
References: <3270289.QqOHTbhTGK@kreacher>
         <CAJZ5v0ik4b0LZ_WwscvZ_WibaN89DWCy-J1KZCJCCkh5TiGXAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 二, 2019-07-23 at 09:30 +0200, Rafael J. Wysocki wrote:
> On Mon, Jul 22, 2019 at 12:23 PM Rafael J. Wysocki <rjw@rjwysocki.net
> > wrote:
> > 
> > 
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Passing 0 to cpuhp_remove_state() triggers the BUG_ON() in
> > __cpuhp_remove_state_cpuslocked() and the argument passed to
> > powercap_unregister_control_type() is expected to be a valid
> > pointer, so avoid calling these functions with incorrect
> > arguments from proc_thermal_rapl_remove().
> > 
> > Fixes: 555c45fe0d04 ("int340X/processor_thermal_device: add support
> > for MMIO RAPL")
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Zhang Rui <rui.zhang@intel.com>

> Any comments?
> 
> If not, I'll queue this up along with the other RAPL-related fix
> (https://patchwork.kernel.org/patch/11050999/).
> 
> > 
> > ---
> >  drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> > |    4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > Index: linux-
> > pm/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> > ===================================================================
> > --- linux-
> > pm.orig/drivers/thermal/intel/int340x_thermal/processor_thermal_dev
> > ice.c
> > +++ linux-
> > pm/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> > @@ -487,6 +487,7 @@ static int proc_thermal_rapl_add(struct
> >                                 rapl_mmio_cpu_online,
> > rapl_mmio_cpu_down_prep);
> >         if (ret < 0) {
> >                 powercap_unregister_control_type(rapl_mmio_priv.con
> > trol_type);
> > +               rapl_mmio_priv.control_type = NULL;
> >                 return ret;
> >         }
> >         rapl_mmio_priv.pcap_rapl_online = ret;
> > @@ -496,6 +497,9 @@ static int proc_thermal_rapl_add(struct
> > 
> >  static void proc_thermal_rapl_remove(void)
> >  {
> > +       if (IS_ERR_OR_NULL(rapl_mmio_priv.control_type))
> > +               return;
> > +
> >         cpuhp_remove_state(rapl_mmio_priv.pcap_rapl_online);
> >         powercap_unregister_control_type(rapl_mmio_priv.control_typ
> > e);
> >  }
> > 
> > 
> > 
