Return-Path: <linux-acpi+bounces-1722-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0DB7F393E
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 23:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01F5B1C20BD0
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 22:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D30584FF
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 22:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cwayz2uM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99209D50
	for <linux-acpi@vger.kernel.org>; Tue, 21 Nov 2023 13:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700602355; x=1732138355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=H15loaM//v1sRA37P8a5lK90PXDmJV0zOOHkZ75YynA=;
  b=Cwayz2uMcsMkQvJtHpnhEy/rI8EuANHygRlbeF6RXKhysgQRJKBMPekg
   XHqKylb4Z1o2yezIKFOlu7mDHS9tIfc0BGFAY1gxKsALfE6xyvGTh5Ww/
   KexqSgbA3LhTD5N3LMvOFuJgajtB/WJF/nubMxQiEjcVvBB1b+2KOPIQZ
   1RgYDmgRAOP1DuZHvNXLUCCkbh66fVwgEjiHBo8ZkWhlTeDE6ClGQB4hq
   ftSJbKxqKSzK7zz3O5PxDRygMOnsosTBZO99W2VcGpo4VnPvHvs1Ro5XS
   rQFBMvSFzxmjfFlJAnYScmKWZWtFS4CKRBAy+UIlKS4w0XRZYyG7VO/Bf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="391704083"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="391704083"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 13:32:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="1014035978"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="1014035978"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 13:32:33 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id C8B7212019F;
	Tue, 21 Nov 2023 23:32:30 +0200 (EET)
Date: Tue, 21 Nov 2023 21:32:30 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org, andriy.shevchenko@linux.intel.com,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v4 1/3] acpi: property: Let args be NULL in
 __acpi_node_get_property_reference
Message-ID: <ZV0h7rfvyTX4tG3t@kekkonen.localdomain>
References: <20231103083625.1229008-1-sakari.ailus@linux.intel.com>
 <20231103083625.1229008-2-sakari.ailus@linux.intel.com>
 <CAJZ5v0hB=6mLp3ZKOoF=_+wJ-crraXtMaZ7ZNhZ_Gfg2SU08Ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hB=6mLp3ZKOoF=_+wJ-crraXtMaZ7ZNhZ_Gfg2SU08Ww@mail.gmail.com>

On Tue, Nov 21, 2023 at 08:36:08PM +0100, Rafael J. Wysocki wrote:
> On Fri, Nov 3, 2023 at 9:36 AM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > fwnode_get_property_reference_args() may not be called with args argument
> > NULL on ACPI, OF already supports this. Add the missing NULL checks and
> > document this.
> >
> > The purpose is to be able to count the references.
> >
> > Fixes: 977d5ad39f3e ("ACPI: Convert ACPI reference args to generic fwnode reference args")
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  drivers/acpi/property.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > index 413e4fcadcaf..93608714b652 100644
> > --- a/drivers/acpi/property.c
> > +++ b/drivers/acpi/property.c
> > @@ -851,6 +851,7 @@ static int acpi_get_ref_args(struct fwnode_reference_args *args,
> >   * @index: Index of the reference to return
> >   * @num_args: Maximum number of arguments after each reference
> >   * @args: Location to store the returned reference with optional arguments
> > + *       (may be NULL)
> >   *
> >   * Find property with @name, verifify that it is a package containing at least
> >   * one object reference and if so, store the ACPI device object pointer to the
> > @@ -907,6 +908,9 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
> >                 if (!device)
> >                         return -EINVAL;
> >
> > +               if (!args)
> > +                       return 0;
> > +
> >                 args->fwnode = acpi_fwnode_handle(device);
> >                 args->nargs = 0;
> >                 return 0;
> > --
> 
> Is this series waiting for me to pick it up or am I confused?

Yes, please!

-- 
Sakari Ailus

