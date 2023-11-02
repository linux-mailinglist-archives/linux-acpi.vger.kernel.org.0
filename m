Return-Path: <linux-acpi+bounces-1163-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 375377DF523
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 15:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66A411C209B9
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 14:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C811BDE0
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CYPdMhL5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E30314A84
	for <linux-acpi@vger.kernel.org>; Thu,  2 Nov 2023 13:20:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B47E13E
	for <linux-acpi@vger.kernel.org>; Thu,  2 Nov 2023 06:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698931230; x=1730467230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e6aHwyMiyoxk9Evnq/O9zeSURet+KPkl3+6flA/CRC8=;
  b=CYPdMhL5XJUZ/TeQqaMl5RhibcdbdZnd9EbdfpvHOdiY4xYIVnhvRSRS
   CWex3XGCCgboiCEKK51NVSJFIXHZsxrbvI25MarDDp4eVqM7uCRw6Kbbj
   TCHW2i+mdRFUwC8TyMiAmRQNYpefZYkGQOcLCQQHrpHEp8n9gI1NAR3zW
   LSQFrR9cZLt3aJtJSzFhLKS3yazvyVhMHhkeWQrxnsbIWkL/RyjaqJB0g
   9PIgzwXkC2WmEl9YInizAl4gyRJ6lDOB6zdWRgODK4ug+bQ7+QBycfwRV
   X/w9rGc+RuAAl/veHuPmAW88uwydGD9Tz2nxGB1OpCJXstnfV3hQd1GwF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="7349006"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="7349006"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 06:20:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="1008461125"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="1008461125"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 06:20:28 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id AD91E11F894;
	Thu,  2 Nov 2023 15:20:25 +0200 (EET)
Date: Thu, 2 Nov 2023 13:20:25 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 1/3] acpi: property: Let args be NULL in
 __acpi_node_get_property_reference
Message-ID: <ZUOiGdj0W2vdELha@kekkonen.localdomain>
References: <20231102101316.1186215-1-sakari.ailus@linux.intel.com>
 <20231102101316.1186215-2-sakari.ailus@linux.intel.com>
 <ZUOgPZk76fT18F3u@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUOgPZk76fT18F3u@smile.fi.intel.com>

Hi Andy,

On Thu, Nov 02, 2023 at 03:12:29PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 02, 2023 at 12:13:14PM +0200, Sakari Ailus wrote:
> > fwnode_get_property_reference_args() may not be called with args argument
> > NULL on ACPI, OF already supports this. Add the missing NULL checks and
> > document this.
> > 
> > The purpose is to be able to count the references.
> 
> ...
> 
> > -		args->fwnode = acpi_fwnode_handle(device);
> > -		args->nargs = 0;
> > +		if (args) {
> > +			args->fwnode = acpi_fwnode_handle(device);
> > +			args->nargs = 0;
> > +		}
> >  		return 0;
> 
> In swnode case you used
> 
> 	if (!args)
> 		return 0;
> 
> approach. Why not here? It also makes diff cleaner, no?

I'll do that here, too.

-- 
Sakari Ailus

