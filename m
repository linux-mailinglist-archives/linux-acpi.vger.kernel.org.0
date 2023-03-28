Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7767B6CCA77
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Mar 2023 21:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjC1TMF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Mar 2023 15:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjC1TME (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Mar 2023 15:12:04 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D36730D5;
        Tue, 28 Mar 2023 12:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680030723; x=1711566723;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F28h8BboTlD4hxAMQwVSAaJn2J0QV00xO/MfRS2Fz/U=;
  b=PFHkgPIbAq2Euz983/YaAi8Ugx5FGCSTPB2ZN1JQ/uzWRanCrzZPbNLB
   IYcF+6yNrD24pxE4aRSAWSrPwZRUruAnuGJiTIJvRggwP1e0vK6yk/Wp9
   6tc8oZhejfBObsxwHTxFSqUznxqwGyAKczemklahFb/Tb51Qo6RKqoQN8
   lKAb3exzC0H+jRDlF+2p2rO0miZBtpvC1RR0r/nbIrxnH5GxmceVO47bW
   aNu+BoYXkamOI/5cYfytwLb/XJcZQO3jnxV67lt1cOwvJTGKnSss+vOoh
   mxpsnifOKBBLxLg4iwWi7iOG+pQvLajx60ExlfHm03BWL7bCSNKvE8vA2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="340689653"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="340689653"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 12:12:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="807930517"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="807930517"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 12:12:01 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 6C83611F937;
        Tue, 28 Mar 2023 22:11:58 +0300 (EEST)
Date:   Tue, 28 Mar 2023 22:11:58 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v7 06/10] ACPI: scan: Generate software nodes based on
 MIPI DisCo for Imaging
Message-ID: <ZCM7/nmXMlCawrwr@kekkonen.localdomain>
References: <20230328101303.1458570-1-sakari.ailus@linux.intel.com>
 <20230328101303.1458570-7-sakari.ailus@linux.intel.com>
 <ZCMNAR3VJAzOZww3@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCMNAR3VJAzOZww3@smile.fi.intel.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Adnry,

On Tue, Mar 28, 2023 at 06:51:29PM +0300, Andy Shevchenko wrote:
> On Tue, Mar 28, 2023 at 01:12:59PM +0300, Sakari Ailus wrote:
> > Generate software nodes for driver use, based on MIPI DisCo for Imaging
> > definitions.
> > 
> > During the (sub-)namespace walk, ACPI device nodes are created but the
> > drivers aren't probed for the devices yet. A convenient way to determine
> > which ACPI devices this applies to is to find a hierarchical data node that
> > begins with "mipi-img-port-". These devices need software nodes that need
> > to be present before probing, and can only be constructed once the related
> > _CRS CSI2 records have been parsed.
> 
> ...
> 
> > -	static const char mipi_port_prefix[] = "mipi-img-port-";
> > -	char mipi_port_name[sizeof(mipi_port_prefix) + 2];
> > +	char mipi_port_name[sizeof(MIPI_IMG_PORT_PREFIX) + 2];
> >  
> >  	if (snprintf(mipi_port_name, sizeof(mipi_port_name), "%s%u",
> > -		     mipi_port_prefix, port) >= sizeof(mipi_port_name)) {
> > +		     MIPI_IMG_PORT_PREFIX, port) >= sizeof(mipi_port_name)) {
> 
> You are modifying lines you just brought by the previous patch. Why this mess?
> 
> ...
> 
> > -static void acpi_bus_handle_postpone(acpi_handle handle,
> > -				     struct list_head *head)
> > +static void acpi_bus_handle_postpone(acpi_handle handle, struct list_head *head)
> 
> Unrelated change?
> 
> ...
> 
> > +/**
> > + * acpi_bus_device_postpone - Add an ACPI device to a given postponed list
> > + * @device: The ACPI device
> > + * @head: Postponed list head
> > + *
> > + * Add a given ACPI device to a list of ACPI objects for which the creation
> > + * of the device objects is to be postponed.
> > + */
> > +void acpi_bus_device_postpone(struct acpi_device *device,
> > +			      struct list_head *head)
> 
> Taking into account above indentation, why not to have them on one line to
> begin with?

I'll address these for v8.

-- 
Kind regards,

Sakari Ailus
