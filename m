Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202F068889E
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Feb 2023 21:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjBBU5b (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 Feb 2023 15:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjBBU5a (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Feb 2023 15:57:30 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA42C8692;
        Thu,  2 Feb 2023 12:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675371448; x=1706907448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TCgQ2FwJI4SqepKilWQYS52/MJVdqef7Y8qGfEgHImM=;
  b=gsoIlQ4JY6LlI9yUzHIq7T5Whnr/SPOjJ3lqGmnplpdhtbt3vM4HQmyL
   NfcyqHpwl2lAhBdgo72VHyO6unsxYIfDcRf7BVm6edVk5ZsrQiRWW8SBU
   cEiG8mt/jo1LL/aXInA3vKX0x1pC/kSIz93RCg9ejw1GUVFeNOd7lrENj
   38T4nnNCytgXsXotYXHJ9wwy4+v3OO8W2fSC1DPfsxABoJf6Wku+1l9HM
   TcATRJq5OpKMEPRugDm2TTkYfgZDZY3K5pYEou1+YPS0tDcXK6lCg7ZV6
   ZOjn3NPUJQYrKNBGxVLdE6j0tLgK2j68qAl7yorKUSJj3PedC3OpsdqE0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="308214380"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="308214380"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 12:57:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="774054302"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="774054302"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 12:57:26 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 1F6821218E2;
        Thu,  2 Feb 2023 22:57:24 +0200 (EET)
Date:   Thu, 2 Feb 2023 22:57:24 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v3 2/8] ACPI: property: Parse _CRS CSI-2 descriptor
Message-ID: <Y9wjtAeah1wvf6s3@kekkonen.localdomain>
References: <20230125224101.401285-1-sakari.ailus@linux.intel.com>
 <20230125224101.401285-3-sakari.ailus@linux.intel.com>
 <CAJZ5v0j88ywL020VCRC3Un+yyDmFP6davrwmK8xOCQYeGktemg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j88ywL020VCRC3Un+yyDmFP6davrwmK8xOCQYeGktemg@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

Thank you for the review.

On Thu, Feb 02, 2023 at 08:57:04PM +0100, Rafael J. Wysocki wrote:
> On Wed, Jan 25, 2023 at 11:41 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Parse newly added ACPI _CRS CSI-2 descriptor for CSI-2 and camera
> > configuration. For now, only figure out where the descriptor is present in
> > order to allow adding information from it to related devices.
> >
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  drivers/acpi/Makefile   |   2 +-
> >  drivers/acpi/internal.h |   7 +
> >  drivers/acpi/mipi.c     | 320 ++++++++++++++++++++++++++++++++++++++++
> >  drivers/acpi/scan.c     |  16 +-
> >  include/acpi/acpi_bus.h |  11 ++
> >  5 files changed, 351 insertions(+), 5 deletions(-)
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
> > index 0000000000000..269a6965d56e6
> > --- /dev/null
> > +++ b/drivers/acpi/mipi.c
> > @@ -0,0 +1,320 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * MIPI DisCo for Imaging support.
> > + *
> > + * Copyright (C) 2023 Intel Corporation
> > + */
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/list.h>
> > +#include <linux/module.h>
> > +#include <linux/overflow.h>
> > +#include <linux/types.h>
> > +#include <linux/slab.h>
> > +#include <linux/sort.h>
> > +#include <linux/string.h>
> > +
> > +#include "internal.h"
> > +
> > +struct crs_csi2_swnodes {
> > +       struct list_head list;
> > +       acpi_handle handle;
> > +       struct acpi_device_software_nodes *ads;
> > +};
> > +
> > +static LIST_HEAD(crs_csi2_swnodes);
> > +
> > +static void crs_csi2_swnode_del_free(struct crs_csi2_swnodes *swnodes)
> > +{
> > +       list_del(&swnodes->list);
> > +       kfree(swnodes);
> > +}
> > +
> > +void acpi_crs_csi2_swnodes_del_free(void)
> > +{
> > +       struct crs_csi2_swnodes *swnodes, *swnodes_tmp;
> > +
> > +       list_for_each_entry_safe(swnodes, swnodes_tmp, &crs_csi2_swnodes, list)
> > +               crs_csi2_swnode_del_free(swnodes);
> > +}
> > +
> > +struct crs_csi2_instance {
> > +       struct list_head list;
> > +       struct acpi_resource_csi2_serialbus csi2;
> > +       acpi_handle remote_handle;
> > +       char remote_name[];
> > +};
> > +
> > +struct crs_csi2 {
> > +       struct list_head list;
> > +       acpi_handle handle;
> > +       struct list_head buses;
> > +};
> > +
> > +struct scan_check_crs_csi2_context {
> > +       struct list_head res_list;
> > +       acpi_handle handle;
> > +};
> 
> All of the structures above need to be described, including what they
> represent and what they are for.

I'll add comments explaining what these are for.

> 
> > +
> > +static acpi_status scan_check_crs_csi2_instance(struct acpi_resource *res,
> > +                                               void *context)
> > +{
> > +       struct scan_check_crs_csi2_context *inst_context = context;
> > +       struct acpi_resource_csi2_serialbus *csi2;
> > +       struct crs_csi2_instance *inst;
> > +       acpi_handle remote_handle;
> > +       acpi_status status;
> > +
> > +       if (res->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
> > +               return AE_OK;
> > +
> > +       csi2 = &res->data.csi2_serial_bus;
> > +
> > +       if (csi2->type != ACPI_RESOURCE_SERIAL_TYPE_CSI2)
> > +               return AE_OK;
> > +
> > +       if (!csi2->resource_source.string_length) {
> > +               acpi_handle_debug(inst_context->handle,
> > +                                 "invalid resource source string length\n");
> > +               return AE_OK;
> > +       }
> > +
> > +       status = acpi_get_handle(NULL, csi2->resource_source.string_ptr,
> > +                                &remote_handle);
> > +       if (status != AE_OK) {
> > +               acpi_handle_warn(inst_context->handle,
> > +                                "cannot get handle for %s\n",
> > +                                csi2->resource_source.string_ptr);
> > +               return AE_OK;
> > +       }
> 
> After this, remote_handle will be the ACPI handle of an ACPI object
> representing a remote CSI-2 device IIUC.

Yes.

> 
> > +
> > +       inst = kmalloc(struct_size(inst, remote_name,
> 
> This line break is confusing.

I can unwrap it, resulting a rather long line, but I guess that's not an
issue.

> 
> > +                                  csi2->resource_source.string_length),
> > +                      GFP_KERNEL);
> > +       if (!inst)
> > +               return AE_OK;
> > +
> > +       inst->csi2 = *csi2;
> 
> A pointer to the entire csi2 structure is stored in ints, so why is it
> still necessary to copy remote_name and remote_handle extracted from
> it to the additional fields?

csi2->resource_source.string_ptr is a pointer pointing somewhere else (DSDT
binary I suppose?) and we're making a local copy of that here. The purpose
is to not rely on this memory being available later on.

> 
> > +       strscpy(inst->remote_name, csi2->resource_source.string_ptr,
> > +               csi2->resource_source.string_length);
> > +       inst->csi2.resource_source.string_ptr = inst->remote_name;
> > +       inst->remote_handle = remote_handle;
> > +
> > +       list_add(&inst->list, &inst_context->res_list);
> 
> So this adds an entry to a list of "receivers" pointed to by the _CRS
> for one "sender"?

Correct. (Usually "transmitter" is used in this context, but same thing.)

> 
> > +
> > +       return AE_OK;
> > +}
> > +
> > +static acpi_status scan_check_crs_csi2(acpi_handle handle, u32 nesting_level,
> > +                                      void *context, void **ret)
> > +{
> > +       struct scan_check_crs_csi2_context inst_context = {
> > +               .handle = handle,
> > +               .res_list = LIST_HEAD_INIT(inst_context.res_list),
> > +       };
> > +       struct list_head *list = context;
> > +       struct crs_csi2 *csi2;
> > +
> > +       INIT_LIST_HEAD(&inst_context.res_list);
> > +
> > +       acpi_walk_resources(handle, METHOD_NAME__CRS,
> > +                           scan_check_crs_csi2_instance, &inst_context);
> > +
> > +       if (list_empty(&inst_context.res_list))
> > +               return AE_OK;
> 
> At this point inst_context.res_list is a list of remote "receivers"
> pointed to by all of the CSI-2 _CRS entries for the device represented
> by @handle?

Yes.

> 
> > +
> > +       csi2 = kmalloc(sizeof(*csi2), GFP_KERNEL);
> > +       if (!csi2)
> > +               return AE_OK;
> > +
> > +       csi2->handle = handle;
> > +       list_replace(&inst_context.res_list, &csi2->buses);
> 
> And here, csi2 represents a "sender" device along with a list of
> "receiver" devices pointed to by its CSI-2 _CRS entries, right?

Yes. I can add comments detailing this.

> 
> > +       list_add(&csi2->list, list);
> > +
> > +       return AE_OK;
> > +}
> > +
> > +struct acpi_handle_ref {
> > +       acpi_handle handle;
> > +       unsigned int count;
> > +};
> > +
> > +#define NO_CSI2_PORT (~1U)
> > +
> > +static int crs_handle_cmp(const void *__a, const void *__b)
> > +{
> > +       const struct acpi_handle_ref *a = __a, *b = __b;
> > +
> > +       return a->handle < b->handle ? -1 : a->handle > b->handle;
> > +}
> > +
> > +static void crs_csi2_release(struct list_head *crs_csi2_handles)
> > +{
> > +       struct crs_csi2 *csi2, *csi2_tmp;
> > +
> > +       list_for_each_entry_safe(csi2, csi2_tmp, crs_csi2_handles, list) {
> > +               struct crs_csi2_instance *inst, *inst_tmp;
> > +
> > +               list_for_each_entry_safe(inst, inst_tmp, &csi2->buses, list) {
> > +                       list_del(&inst->list);
> > +                       kfree(inst);
> > +               }
> > +
> > +               list_del(&csi2->list);
> > +               kfree(csi2);
> > +       }
> > +}
> 
> So far, not even a word of description of what's going on.
> 
> > +
> > +/**
> > + * acpi_bus_scan_crs_csi2 - Scan a device and its child devices for _CRS CSI-2
> > + *
> > + * @handle: ACPI handle to scan
> 
> "Root of the ACPI Namespace branch to scan"

Yes...

> 
> > + *
> > + * This function does a number of things:
> > + *
> > + * 1. Scan an ACPI device and its children for _CRS CSI-2 instances. The
> > + *    instances are stored for later use.
> 
> This is not just the children, but everything under @handle, because
> the callback doesn't terminate the walk.
> 
> And if @handle happens to be the ACPI Namespace root, the function
> will scan all of it AFAICS.

Correct. I'll change this to convey the traversal isn't about immediate
children only.

> 
> > + *
> > + * 2. Count how many references to other devices _CRS CSI-2 instances have in
> > + *    total.
> > + *
> > + * 3. Count the number of references to other devices for each _CRS CSI-2
> > + *    instance.
> > + *
> > + * 4. Allocate memory for swnodes each ACPI device requires later on, and
> > + *    generate a list of such allocations.
> > + *
> > + * Note that struct acpi_device isn't available yet at this time.
> 
> Why exactly can't this be done after the struct acpi_device objects
> have been created, but before binding any drivers etc to them?

It could be done, yes, but you'd have to create all acpi_device objects
before any of them may get probed. The data is gathered one _CRS CSI2
descriptor at a time and all remote devices aren't knon before all have
been parsed.

> 
> > + *
> > + * acpi_scan_lock in scan.c must be held when calling this function.
> > + */
> > +void acpi_bus_scan_crs_csi2(acpi_handle handle)
> > +{
> > +       struct acpi_handle_ref *handle_refs;
> > +       struct acpi_handle_ref *this = NULL;
> > +       LIST_HEAD(crs_csi2_handles);
> > +       unsigned int handle_count = 0, this_count;
> > +       unsigned int curr = 0;
> > +       struct crs_csi2 *csi2;
> > +
> > +       /* Collect the devices that have a _CRS CSI-2 resource */
> > +       acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, ACPI_UINT32_MAX,
> > +                           scan_check_crs_csi2, NULL, &crs_csi2_handles, NULL);
> 
> So the result of this will be a list of "senders" where each entry
> represents one device along with a list of remote "receivers"
> connected to it.  Is this correct?

Correct.

> 
> > +
> > +       /*
> > +        * Figure out how much temporary storage we need for counting
> > +        * connections in each device.
> > +        */
> > +       list_for_each_entry(csi2, &crs_csi2_handles, list) {
> > +               struct crs_csi2_instance *inst;
> > +
> > +               handle_count++;
> > +
> > +               list_for_each_entry(inst, &csi2->buses, list)
> > +                       handle_count++;
> > +       }
> 
> I would suggest counting stuff while creating the data structure, so
> this extra walk would not be necessary.

Note that the number of entries in these lists is typically small, no more
than 20 in total, so this isn't really taking much time. But I believe the
counting can be done equally sell elsewhere, too, if you prefer that.

> 
> > +
> > +       /* No handles? Bail out here. */
> > +       if (!handle_count)
> > +               return;
> > +
> > +       handle_refs = kcalloc(handle_count + 1, sizeof(*handle_refs),
> > +                             GFP_KERNEL);
> > +       if (!handle_refs) {
> > +               acpi_handle_debug(handle, "no memory for %u handle refs\n",
> > +                                 handle_count + 1);
> > +               return;
> > +       }
> > +
> > +       /* Associate handles to the number of references. */
> > +       list_for_each_entry(csi2, &crs_csi2_handles, list) {
> > +               struct crs_csi2_instance *inst;
> > +               struct acpi_handle_ref *handle_ref;
> > +
> > +               handle_ref = &handle_refs[curr++];
> > +               handle_ref->handle = csi2->handle;
> > +
> > +               list_for_each_entry(inst, &csi2->buses, list) {
> > +                       handle_refs[curr].handle = inst->remote_handle;
> > +                       handle_refs[curr].count = 1;
> > +                       handle_ref->count++;
> > +                       curr++;
> > +               }
> > +       }
> > +
> > +       handle_refs[curr].handle = NULL;
> 
> So the above basically creates a flat array of entries that each
> contain an ACPI handle of (an ACPI object representing) a CSI-2 device
> and the number of other CSI-2 devices that it can talk to.
> 
> But one device can appear in multiple entries, which is why it is
> sorted below and then the entries corresponding to one device are
> aggregated.

Correct.

> 
> > +
> > +       sort(handle_refs, handle_count, sizeof(*handle_refs), crs_handle_cmp,
> > +            NULL);
> > +
> > +       /*
> > +        * Finally count references in each handle, allocate space for device
> > +        * specific ports, properties and fill the _CRS CSI2 descriptor
> > +        * originated data.
> > +        */
> > +       this = handle_refs;
> > +       this_count = this->count;
> > +       for (curr = 1; curr < handle_count + 1; curr++) {
> > +               struct acpi_device_software_nodes *ads;
> > +               struct crs_csi2_swnodes *swnodes;
> > +               size_t alloc_size;
> > +               void *end;
> > +
> > +               if (this->handle == handle_refs[curr].handle) {
> > +                       this_count += handle_refs[curr].count;
> > +                       continue;
> > +               }
> > +
> > +               /*
> > +                * Allocate memory for ports, node pointers (number of nodes +
> > +                * 1 (guardian), nodes (root + number of ports * 2 (for for
> > +                * every port there is an endpoint)).
> > +                */
> > +               if (check_mul_overflow(sizeof(*ads->ports) +
> > +                                      sizeof(*ads->nodes) * 2 +
> > +                                      sizeof(*ads->nodeptrs) * 2,
> > +                                      (size_t)this_count, &alloc_size) ||
> > +                   check_add_overflow(sizeof(*ads) + sizeof(*ads->nodes) +
> > +                                      sizeof(*ads->nodeptrs) * 2,
> > +                                      alloc_size, &alloc_size)) {
> 
> Please try to split this conditional into smaller pieces.  As is, it
> is almost completely unreadable.

Yes.

> 
> > +                       acpi_handle_warn(handle, "too many handles (%u)",
> > +                                        this_count);
> 
> And the warning is utterly useless except for debugging.

It is there exactly for that purpose. Although this isn't a serious matter
as such, it is very likely to signal of a bug (most likely in the code).

> 
> > +                       continue;
> > +               }
> > +
> > +               swnodes = kzalloc(sizeof(*swnodes), GFP_KERNEL);
> > +               ads = kzalloc(alloc_size, GFP_KERNEL);
> > +               ads->ports = (void *)(ads + 1);
> > +               ads->nodes = (void *)(ads->ports + this_count);
> > +               ads->nodeptrs = (void *)(ads->nodes +
> > +                                        this_count * 2 + 1);
> > +               end = ads->nodeptrs + this_count * 2 + 2;
> > +               if (!swnodes || !ads ||
> > +                   WARN_ON((void *)ads + alloc_size != end)) {
> 
> Why WARN_ON()?  Is this so important?

Sanity check. There are two allocations there with a different lifetime,
and the size of the other one is somewhat complicated to calculate.

> 
> > +                       kfree(swnodes);
> > +                       kfree(ads);
> > +                       acpi_handle_debug(handle,
> > +                                         "cannot allocate for %u swnodes\n",
> 
> Say "software nodes" in the message and please mention CSI-2 in it too.

Yes...

> 
> > +                                         this_count);
> > +               } else {
> > +                       unsigned int i;
> > +
> > +                       ads->num_ports = this_count;
> > +                       for (i = 0; i < this_count * 2 + 1; i++)
> > +                               ads->nodeptrs[i] = &ads->nodes[i];
> > +                       ads->nodeptrs[i] = NULL;
> > +                       for (i = 0; i < this_count; i++)
> > +                               ads->ports[i].port_nr = NO_CSI2_PORT;
> > +                       swnodes->handle = this->handle;
> > +                       swnodes->ads = ads;
> > +                       list_add(&swnodes->list, &crs_csi2_swnodes);
> > +               }
> 
> The allocation part above can be done in a separate function with a
> description of what's going on.
> 
> It is really hard to figure out what happens here from the code and it
> shouldn't even be necessary.  Please explain what you are doing.
> 
> > +
> > +               this = &handle_refs[curr];
> > +               this_count = this->count;
> > +       }
> > +
> > +       kfree(handle_refs);
> > +
> > +       crs_csi2_release(&crs_csi2_handles);
> > +}
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index 0c6f06abe3f47..50de874b8f208 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -2423,9 +2423,12 @@ EXPORT_SYMBOL_GPL(acpi_dev_get_next_consumer_dev);
> >  int acpi_bus_scan(acpi_handle handle)
> >  {
> >         struct acpi_device *device = NULL;
> > +       int ret = 0;
> >
> >         acpi_bus_scan_second_pass = false;
> >
> > +       acpi_bus_scan_crs_csi2(handle);
> > +
> 
> This effectively adds an extra walk over the entire ACPI Namespace
> which is pure useless overhead on systems without CSI-2 descriptors.
> 
> I'm predicting that server people who care about boot times won't like it.

I'm certainly fine with doing this with fewer walks, but it requires
parsing the _CRS objects (as earlier in the patch) during the same
traversal than devices are created. But any driver probing must be
postponed after this traversal so we have found all the devices with CSI-2
connections (and created software nodes for them).

This is so by design, only one end of a connection has any information
about it.

> 
> >         /* Pass 1: Avoid enumerating devices with missing dependencies. */
> >
> >         if (ACPI_SUCCESS(acpi_bus_check_add(handle, true, &device)))
> > @@ -2433,13 +2436,15 @@ int acpi_bus_scan(acpi_handle handle)
> >                                     acpi_bus_check_add_1, NULL, NULL,
> >                                     (void **)&device);
> >
> > -       if (!device)
> > -               return -ENODEV;
> > +       if (!device) {
> > +               ret = -ENODEV;
> > +               goto out_release;
> > +       }
> >
> >         acpi_bus_attach(device, (void *)true);
> >
> >         if (!acpi_bus_scan_second_pass)
> > -               return 0;
> > +               goto out_release;
> >
> >         /* Pass 2: Enumerate all of the remaining devices. */
> >
> > @@ -2452,7 +2457,10 @@ int acpi_bus_scan(acpi_handle handle)
> >
> >         acpi_bus_attach(device, NULL);
> >
> > -       return 0;
> > +out_release:
> > +       acpi_crs_csi2_swnodes_del_free();
> > +
> > +       return ret;
> >  }
> >  EXPORT_SYMBOL(acpi_bus_scan);
> >
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index e44be31115a67..a05fe22c1175c 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -360,6 +360,17 @@ struct acpi_device_data {
> >
> >  struct acpi_gpio_mapping;
> >
> > +struct acpi_device_software_node_port {
> > +       unsigned int port_nr;
> > +};
> > +
> > +struct acpi_device_software_nodes {
> > +       struct acpi_device_software_node_port *ports;
> > +       struct software_node *nodes;
> > +       const struct software_node **nodeptrs;
> > +       unsigned int num_ports;
> > +};
> 
> No description?

None of the structs in that file (or generally elsewhere in vicinity) have
any helpful comments so I was just following a pattern. :-) But perhaps
these would deserve some. I can add them here, and see if other places
could benefit from them as well (plus your comments earlier in the patch).

> 
> > +
> >  /* Device */
> >  struct acpi_device {
> >         u32 pld_crc;
> > --

-- 
Kind regards,

Sakari Ailus
