Return-Path: <linux-acpi+bounces-1162-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CFE7DF522
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 15:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B80D61C204D6
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 14:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262A11BDD1
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fh6Erhjn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F95D79EF
	for <linux-acpi@vger.kernel.org>; Thu,  2 Nov 2023 13:13:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C954FD7
	for <linux-acpi@vger.kernel.org>; Thu,  2 Nov 2023 06:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698930805; x=1730466805;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2ALNdI8bCDnpIFbO+iBFkTLUmPxowRb4oKW7CB9UF9s=;
  b=fh6Erhjn+M59aSmfYUq8oSxaEmHh3Y0rkFBll2A2D3x9trHF5yBj+Ly+
   4WMVTXQlSe5D0ekAziQFR/lxWnRfRCHZoq3s9bSlWpoP1780VdAclb9JO
   NuI5fEkFyHkVUt/dXlpQSe2Lae0rSVfw8Lx9sYDlFCPWCcvyEgM3VAIW/
   V2Mbe8b92PqdOwRHxXOcGjmrd8TuEiQkgXY6UaJdJPkuqUOmdhrPOqreZ
   AliZogHoF4ZIO9NBTCc0o+sq/0Spim3gR2k9eZkHZsSY1ZeRmm4Kd2psZ
   vdhwvPTgmL8ZIMZVK0z6smz5RpScGLDdTbWepmX5SD7zdFWrc3Kd2/UqL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="455190137"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="455190137"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 06:13:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="711149714"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="711149714"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 06:13:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qyXVb-0000000Ah4g-43v6;
	Thu, 02 Nov 2023 15:13:15 +0200
Date: Thu, 2 Nov 2023 15:13:15 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 0/3] Make fwnode_property_get_reference_args accept
 NULL args
Message-ID: <ZUOgazh3S-PTNeNH@smile.fi.intel.com>
References: <20231102101316.1186215-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102101316.1186215-1-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Nov 02, 2023 at 12:13:13PM +0200, Sakari Ailus wrote:
> Hi all,
> 
> The of_parse_phandle_with_args() accepts NULL args but
> fwnode_property_get_reference_args() does not currently, in its ACPI or
> software node implementations. Fix this.

One nit in the first patch, otherwise LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



