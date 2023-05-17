Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A21706739
	for <lists+linux-acpi@lfdr.de>; Wed, 17 May 2023 13:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjEQLyr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 May 2023 07:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjEQLym (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 May 2023 07:54:42 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98D861AF;
        Wed, 17 May 2023 04:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684324468; x=1715860468;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VV4lVVp+iP+G9ezqwsFzO1KAxbwweS5JtOfRMkSNvMM=;
  b=io7yZYmnwl7HhRPm4G7QWLLDiroUFQCjIoOYPmnyZHCm/BRci88jldfb
   ClQ3nQteaKHcdzU7ZKvtHMfZoMh4UhgMcuy3iYAigIOz1/LFEcq0Z3vF1
   u0W9FlQ0JXAxs2NPtujo24lawUL9V406hTqOb11/ZbajX1v+z+wY0cHtt
   1TqxFsKLk/MDHEk7ajtg+x1nyT+s5MwTEjcBmBv/hIR2uD3dysB1fgFrR
   oVwpwI1xenOiAwiThCjtywmpU2nRCBy+c57I5kPD3cmzvC9kjevVRUeUW
   NQDNCMgegQa3AWg7mf2rbG8ss0mQqdqSoGOgBnwACsZ3Ou1kweo5Yzqvt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="331351717"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="331351717"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 04:54:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="771435358"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="771435358"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 04:54:27 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id B6570120279;
        Wed, 17 May 2023 14:45:11 +0300 (EEST)
Date:   Wed, 17 May 2023 11:45:11 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v8 05/10] ACPI: property: Prepare generating swnodes for
 ACPI and DisCo for Imaging
Message-ID: <ZGS+RzCGl7Y3p6N/@kekkonen.localdomain>
References: <20230329100951.1522322-1-sakari.ailus@linux.intel.com>
 <20230329100951.1522322-6-sakari.ailus@linux.intel.com>
 <CAJZ5v0gxqs3+ofqX0PGmM=3HOi96ioyYJis+RL2oACPq6rggEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gxqs3+ofqX0PGmM=3HOi96ioyYJis+RL2oACPq6rggEA@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

Thanks for the review.

On Wed, May 17, 2023 at 12:53:43PM +0200, Rafael J. Wysocki wrote:
> > +       list_for_each_entry(csi2, &ctx->crs_csi2_head, list) {
> > +               struct acpi_device_software_nodes *local_swnodes;
> > +               struct crs_csi2_instance *inst;
> > +
> > +               local_swnodes = crs_csi2_swnode_get(csi2->handle);
> > +               if (WARN_ON_ONCE(!local_swnodes))
> > +                       continue;
> > +
> > +               list_for_each_entry(inst, &csi2->buses, list) {
> > +                       struct acpi_device_software_nodes *remote_swnodes;
> > +                       struct acpi_device_software_node_port *local_port;
> > +                       struct acpi_device_software_node_port *remote_port;
> > +                       struct software_node *local_node, *remote_node;
> > +                       unsigned int local_index, remote_index;
> > +                       unsigned int bus_type;
> > +
> > +                       remote_swnodes = crs_csi2_swnode_get(inst->remote_handle);
> > +                       if (WARN_ON_ONCE(!remote_swnodes))
> > +                               continue;
> > +
> > +                       local_index = next_csi2_port_index(local_swnodes, inst->csi2.local_port_instance);
> > +                       remote_index = next_csi2_port_index(remote_swnodes, inst->csi2.resource_source.index);
> > +
> > +                       if (WARN_ON_ONCE(local_index >= local_swnodes->num_ports) ||
> > +                           WARN_ON_ONCE(remote_index >= remote_swnodes->num_ports))
> > +                               goto out_free;
> > +
> > +                       switch (inst->csi2.phy_type) {
> > +                       case ACPI_CRS_CSI2_PHY_TYPE_C:
> > +                               bus_type = V4L2_FWNODE_BUS_TYPE_CSI2_CPHY;
> > +                               break;
> > +                       case ACPI_CRS_CSI2_PHY_TYPE_D:
> > +                               bus_type = V4L2_FWNODE_BUS_TYPE_CSI2_DPHY;
> > +                               break;
> > +                       default:
> > +                               acpi_handle_info(csi2->handle,
> > +                                                "ignoring CSI-2 PHY type %u\n",
> > +                                                inst->csi2.phy_type);
> > +                               continue;
> > +                       }
> > +
> > +                       local_port = &local_swnodes->ports[local_index];
> > +                       local_node = &local_swnodes->nodes[ACPI_DEVICE_SWNODE_EP(local_index)];
> > +                       local_port->remote_ep_ref[0] = SOFTWARE_NODE_REFERENCE(local_node);
> 
> This looks odd.  Is local_port pointing to its own node as a remote
> endpont, or am I confused?

This is a reference to a software node that will be, in turn, referenced by
the "remote-endpoint" property entry in the remote node. Look for
ACPI_DEVICE_SWNODE_EP_REMOTE_EP a few lines below these.

> 
> > +                       local_port->crs_csi2_local = true;
> > +
> > +                       remote_port = &remote_swnodes->ports[remote_index];
> > +                       remote_node = &remote_swnodes->nodes[ACPI_DEVICE_SWNODE_EP(remote_index)];
> > +                       remote_port->remote_ep_ref[0] = SOFTWARE_NODE_REFERENCE(remote_node);
> 
> Analogously here.

-- 
Regards,

Sakari Ailus
