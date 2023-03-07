Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C606AF490
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Mar 2023 20:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbjCGTR2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Mar 2023 14:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbjCGTRI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Mar 2023 14:17:08 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438FF86AF;
        Tue,  7 Mar 2023 11:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678215653; x=1709751653;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=S4RJ9WV3ukeXoqOZE7qlB6cyEe66HwaxfubTo7zIFuM=;
  b=SKZN6+lGOH61mvU2zH7u6XKUOp7WJwxby4VbDn776Xrg48idgcedaHKQ
   XObvUcVKDxktpUlv5y+dW0J7vEy+NC3KVCT0djVConZLjtAgRb1igzQ4V
   lf5ALprHE1FPdvZhSaiFyaX8c/RnZ/pd93qP5rsMeNoRcwBcWpCQOht6g
   +BZ5RoiS3TdUwW8GZdjAPDoQ7uavq000tYEJsoC1I6dWF4nmF6Ru40NEU
   6VhZuepQJQNoHcwZcT/RYr88Ido9cKqxQRcM8pMrhf4NHXkYYhnnowI28
   B3kPFoWYOLs+aZ+T2rQgRLyBiA/zbyn7jCB7gbKI/9CU+htJS9/7nnqKQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="400766664"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="400766664"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 11:00:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="706912124"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="706912124"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 11:00:33 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 92B2612160F;
        Tue,  7 Mar 2023 21:00:30 +0200 (EET)
Date:   Tue, 7 Mar 2023 21:00:30 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v5 2/8] ACPI: property: Parse _CRS CSI-2 descriptor
Message-ID: <ZAeJznmM3pPQ/Oga@kekkonen.localdomain>
References: <20230208212712.3184953-1-sakari.ailus@linux.intel.com>
 <20230208212712.3184953-3-sakari.ailus@linux.intel.com>
 <CAJZ5v0gcdYN51O7JkuWrY=hjiovGpMNO=ootp147hFqUwb1CXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gcdYN51O7JkuWrY=hjiovGpMNO=ootp147hFqUwb1CXQ@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On Tue, Mar 07, 2023 at 02:38:43PM +0100, Rafael J. Wysocki wrote:
> Note: The report from Dan Carpenter has not been addressed.

I'll reply to Dan --- it's a false positive.

> 
> On Wed, Feb 8, 2023 at 10:27 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Parse newly added ACPI _CRS CSI-2 descriptor for CSI-2 and camera
> > configuration. For now, only figure out where the descriptor is present in
> > order to allow adding information from it to related devices.
> 
> This should contain (a) pointer(s) to the relevant specification material.

I can add that for v6.

> 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  drivers/acpi/Makefile   |   2 +-
> >  drivers/acpi/internal.h |   7 +
> >  drivers/acpi/mipi.c     | 358 ++++++++++++++++++++++++++++++++++++++++
> >  drivers/acpi/scan.c     |  16 +-
> >  include/acpi/acpi_bus.h |  11 ++
> >  5 files changed, 389 insertions(+), 5 deletions(-)
> >  create mode 100644 drivers/acpi/mipi.c
> >
> > diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> > index a5b649e71ab1b..a98fa1bc15548 100644
> > --- a/drivers/acpi/Makefile
> > +++ b/drivers/acpi/Makefile
> > @@ -37,7 +37,7 @@ acpi-$(CONFIG_ACPI_SLEEP)     += proc.o
> >  # ACPI Bus and Device Drivers
> >  #
> >  acpi-y                         += bus.o glue.o
> > -acpi-y                         += scan.o
> > +acpi-y                         += scan.o mipi.o
> >  acpi-y                         += resource.o
> >  acpi-y                         += acpi_processor.o
> >  acpi-y                         += processor_core.o
> > diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> > index ec584442fb298..1ec4aa92bf17a 100644
> > --- a/drivers/acpi/internal.h
> > +++ b/drivers/acpi/internal.h
> > @@ -282,4 +282,11 @@ void acpi_init_lpit(void);
> >  static inline void acpi_init_lpit(void) { }
> >  #endif
> >
> > +/*--------------------------------------------------------------------------
> > +                               ACPI and MIPI DisCo for Imaging conversion
> > +  -------------------------------------------------------------------------- */
> > +
> > +void acpi_crs_csi2_swnodes_del_free(void);
> > +void acpi_bus_scan_crs_csi2(acpi_handle handle);
> > +
> >  #endif /* _ACPI_INTERNAL_H_ */
> > diff --git a/drivers/acpi/mipi.c b/drivers/acpi/mipi.c
> > new file mode 100644
> > index 0000000000000..33d50df831933
> > --- /dev/null
> > +++ b/drivers/acpi/mipi.c
> > @@ -0,0 +1,358 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * MIPI DisCo for Imaging support.
> 
> I do realize that the last patch in the series contains the
> description of this code, but it would be really helpful to put at
> least some of it here and update it in the following patches as the
> code gets modified.

I'll see if it could be meaningfully split, with some going to this patch.

> 
> > + *
> > + * Copyright (C) 2023 Intel Corporation
> > + */

...

> > +void acpi_bus_scan_crs_csi2(acpi_handle handle)
> > +{
> > +       struct acpi_handle_ref *handle_refs;
> > +       struct acpi_handle_ref *this = NULL;
> > +       struct crs_csi2_all csi2_all = {
> > +               .crs_csi2_head = LIST_HEAD_INIT(csi2_all.crs_csi2_head),
> > +       };
> > +       size_t this_count;
> > +       unsigned int curr = 0;
> > +       struct crs_csi2 *csi2;
> > +
> > +       /*
> > +        * Collect the devices that have a _CRS CSI-2 resource. Each CSI-2 TX
> > +        * port has one.
> > +        */
> > +       acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, ACPI_UINT32_MAX,
> > +                           scan_check_crs_csi2, NULL, &csi2_all, NULL);
> 
> I still don't like this walk and I still think that it is avoidable.
> 
> At least I don't see why it isn't avoidable ATM.

In acpi_scan_init(), the ACPI tables has been just obtained (via
acpi_get_table()), and the second table traversal in acpi_bus_scan(),
acpi_bus_check_add_1() will, in turn, create devices that further can be
probed.

I guess we could look at the "mipi-img-port-*" nodes right under the device
to see whether the device is expected to be a CSI-2 receiver. I'm not sure
if this would bring a performance improvement or further degradation.

Another option could be to opportunistically initialise a device, and once
encountering a "mipi-img-port-*" node in _DSD property parsing, bail out
and postpone initialisation of the device on first namespace traversal.
This would mean adding some extra error handling in e.g.
acpi_init_device_object() callers.

As the proportion of devices with CSI-2 connections compared to all devices
is expected to be rather small, the second option would likely bring a
performance improvement compared to the current implementation but it would
be somewhat ugly to involve property parsing with this IMO.

-- 
Kind regards,

Sakari Ailus
