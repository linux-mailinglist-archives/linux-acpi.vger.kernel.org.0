Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85750681D2D
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jan 2023 22:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjA3VrC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Jan 2023 16:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjA3VrB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Jan 2023 16:47:01 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAA94A1CC;
        Mon, 30 Jan 2023 13:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675115216; x=1706651216;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AS6XNM+z93ekW75lHzwBkDg76Srt1cfNo+hndyrseYY=;
  b=jxPpsUsUm4LXd7oBTzj/tWjCasGFhSPvDKbW+UJ60OzvXX5Tl0DIvA/a
   ILCtBDuNbZXp5P0mKGrRy22vC0SyGrMUmwKQWjeWcOPRlPczym12x8UuX
   rT4fbhKGsfCI9sSxFiehs+wWJEDIHH855X3iJ3JqKf1uUfbXZGYYHkk6t
   +nOEKlL9DlENwWt/GNXq0GovCHRVKvp7YlsXhrSeHVTggrQ3Fyumub+zH
   JCeJ04GhJf7YY3eKitF287mPaYuVpslY8MXV76M2Egs4jUcOlltoHyPWC
   bqe8oxxb32gDwv21lZ1hEO1a+14hvV5kgi6b5EWuU27YpbqybZ+HUlMpD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="308027282"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="308027282"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 13:46:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="727661410"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="727661410"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 13:46:54 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 20E021202B0;
        Mon, 30 Jan 2023 23:46:52 +0200 (EET)
Date:   Mon, 30 Jan 2023 23:46:52 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v3 4/8] ACPI: property: Generate camera swnodes for ACPI
 and DisCo for Imaging
Message-ID: <Y9g6zOfDxrBP0/PP@kekkonen.localdomain>
References: <20230125224101.401285-1-sakari.ailus@linux.intel.com>
 <20230125224101.401285-5-sakari.ailus@linux.intel.com>
 <Y9Oo4L0ToRTZye2Z@smile.fi.intel.com>
 <Y9g0+L4zrdBtcpZP@kekkonen.localdomain>
 <Y9g5ISkhsJs1Dbgf@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9g5ISkhsJs1Dbgf@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 30, 2023 at 11:39:45PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 30, 2023 at 11:22:00PM +0200, Sakari Ailus wrote:
> > On Fri, Jan 27, 2023 at 12:35:12PM +0200, Andy Shevchenko wrote:
> > > On Thu, Jan 26, 2023 at 12:40:57AM +0200, Sakari Ailus wrote:
> 
> ...
> 
> > > > +static struct fwnode_handle *get_mipi_port_handle(struct acpi_device *device,
> > > > +						  unsigned int port)
> > > > +{
> > > > +	static const char mipi_port_prefix[] = "mipi-img-port-";
> > > > +	char mipi_port_name[sizeof(mipi_port_prefix) + 2];
> > > 
> > > I think the following will be better:
> > > 
> > > 	char mipi_port_name[16];
> > 
> > If the array is too short, this will generate a warning but... this is
> > already handled better than that. Why not to keep it?
> 
> We will get the format string self contained.

I have earlier stated as my opinion that it is a lesser concern.

> 
> > > > +	if (snprintf(mipi_port_name, sizeof(mipi_port_name), "%s%u",
> > > > +		     mipi_port_prefix, port) >= sizeof(mipi_port_name)) {

-- 
Sakari Ailus
