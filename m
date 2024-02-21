Return-Path: <linux-acpi+bounces-3765-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D12E485D0C0
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 07:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CB992863B5
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 06:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD99838F9B;
	Wed, 21 Feb 2024 06:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kcxWi2TL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F207039FE0
	for <linux-acpi@vger.kernel.org>; Wed, 21 Feb 2024 06:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708498618; cv=none; b=rP35sZNIaxzV7gPR3Y1AZUZpXurBAjESfPCE5PWf+b+1ywmjp1pkpV4HXG/Hfkje9NyiCcupxs0QQgVIgTMzeWpkhjGQbVm0A4omtFEG4W75QJMPaFO97BvmV1kJvmN5ePYSQuIoqVmc/UEqhZ1VZhXKmtPhzz3O/NRUI0Ida9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708498618; c=relaxed/simple;
	bh=a4Pw9m4w2DIMWopfY3UNMEgZavR9KrvD4Wn0l6d/B2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhXuvbRDCYi4dopD6AQJvgxGcwEiVc/7EWgTg4j2WtyqSsuttSWzjeuUdBuLbhddcaw5cXxWChJg9S4pO3i0iUH3/GSfTvSXlCaJGXAGq1H/EbZD/t0AFhm7JXaDn8bfLBcBbIMBaDO/sdtSAF1aWYJd061ce459pCe3GMlUoF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kcxWi2TL; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708498617; x=1740034617;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a4Pw9m4w2DIMWopfY3UNMEgZavR9KrvD4Wn0l6d/B2E=;
  b=kcxWi2TLGXz97hbkvbMyeXjMk1jBdy3BJqCwQKL6BdRyLh0WpUKCq2iF
   HLU5VusMQI8aqPE10jMEwfTKufjxUW/57e45kauGYXMAXITQN/EIKXjyF
   XwquPYYa9XUAXo8L6zEU/c16nokpd/WN1CMxbTARQqJme4vefoEVP6TzX
   O8/8wUKmlLjCluRO67VIaTNWw5k6gilXJGbSFdzDOkjSGk4ZZ6PhevtuO
   YLdsnG5GLJVO0ApzMjaH29TM/PKBZJy8NAgFfprVpvs8IPNvOzm5eOjtE
   oZl6FJHzBVA+59TvUlzgqlSty3XjrfK+FM7CrSaFTfFe+TZggmSxLLRzT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="28084177"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="28084177"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 22:56:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="35806167"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 22:56:54 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 3C9FC11F855;
	Wed, 21 Feb 2024 08:56:51 +0200 (EET)
Date: Wed, 21 Feb 2024 06:56:51 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: andy.shevchenko@gmail.com
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 2/2] ACPI: property: Ignore bad graph port nodes on
 Dell XPS 9315
Message-ID: <ZdWes9XxXG1PzYJZ@kekkonen.localdomain>
References: <20240213134606.383817-1-sakari.ailus@linux.intel.com>
 <20240213134606.383817-3-sakari.ailus@linux.intel.com>
 <ZdUl2eg8hM5RkrOL@surfacebook.localdomain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdUl2eg8hM5RkrOL@surfacebook.localdomain>

Hi Andy,

Thanks for the review.

I think Rafael has already applied this but I can send a new patch...

On Wed, Feb 21, 2024 at 12:21:13AM +0200, andy.shevchenko@gmail.com wrote:
> Tue, Feb 13, 2024 at 03:46:06PM +0200, Sakari Ailus kirjoitti:
> > Some systems were shipped with both Windows and Linux camera descriptions.
> > In general, if Linux description exist, they will be used and Windows
> > description ignored.
> > 
> > In this case the Linux descriptions were buggy so use Windows definition
> > instead. This patch ignores the bad graph port nodes on Dell XPS 9315 and
> > there are likely other such systems, too. The corresponding information
> > has been added to ipu-bridge to cover the missing bits.
> 
> ...
> 
> >  void acpi_mipi_scan_crs_csi2(void);
> >  void acpi_mipi_init_crs_csi2_swnodes(void);
> >  void acpi_mipi_crs_csi2_cleanup(void);
> 
> + blank line?

The usa of blank lines elsewhere in the file is consistent with the above.
These are all related.

> 
> > +bool acpi_graph_ignore_port(acpi_handle handle);
> >  
> >  #endif /* _ACPI_INTERNAL_H_ */
> 
> ...
> 
> > +static const struct dmi_system_id dmi_ignore_port_nodes[] = {
> > +	{
> > +		.matches = {
> > +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 9315"),
> > +		},
> > +	},
> > +	{ 0 }
> 
> 0 is not needed. Moreover, it's a bit unusual.

But also required by the C standard.
 
> > +};
> 
> ...
> 
> > +static const char *strnext(const char *s1, const char *s2)
> > +{
> > +	s1 = strstr(s1, s2);
> > +
> > +	if (!s1)
> > +		return NULL;
> > +
> > +	return s1 + strlen(s2);
> > +}
> 
> NIH str_has_prefix() ?

It doesn't do the same thing. Yes, it could be used, but the code looks
cleaner with this.

> 
> ...
> 
> > +/**
> > + * acpi_graph_ignore_port - Tell whether a port node should be ignored
> > + * @handle: The ACPI handle of the node (which may be a port node)
> > + *
> > + * Returns true if a port node should be ignored and the data to that should
> 
> Please, run kernel-doc validation and fix the warnings.

Running kernel-doc on the file doesn't produce any here.

> 
> > + * come from other sources instead (Windows ACPI definitions and
> > + * ipu-bridge). This is currently used to ignore bad port nodes related to IPU6
> > + * ("IPU?") and camera sensor devices ("LNK?") in certain Dell systems with
> > + * Intel VSC.
> > + */
> > +bool acpi_graph_ignore_port(acpi_handle handle)
> > +{
> > +	const char *path = NULL, *orig_path;
> > +	static bool dmi_tested, ignore_port;
> > +
> > +	if (!dmi_tested) {
> > +		ignore_port = dmi_first_match(dmi_ignore_port_nodes);
> > +		dmi_tested = true;
> > +	}
> > +
> > +	if (!ignore_port)
> > +		return false;
> > +
> > +	/* Check if the device is either "IPU" or "LNK" (sensor). */
> > +	orig_path = acpi_handle_path(handle);
> > +	if (!orig_path)
> > +		return false;
> > +	path = strnext(orig_path, "IPU");
> 
> IIUC this can be rewritten as
> 
> 	path += str_has_prefix();
> 	if (path == orig_path)

You could do that here, but now below, without introducing a new temporary
variable and shuffling that and "path". I prefer to keep it as-is.

> 		...
> 
> > +	if (!path)
> > +		path = strnext(orig_path, "LNK");
> > +	if (!path)
> > +		goto out_free;
> > +
> > +	if (!(path[0] >= '0' && path[0] <= '9' && path[1] == '.'))
> 
> isdigit() ?

Makes sense.

> 
> > +		goto out_free;
> > +
> > +	/* Check if the node has a "PRT" prefix. */
> > +	path = strnext(path, "PRT");
> > +	if (path && path[0] >= '0' && path[0] <= '9' && !path[1]) {
> 
> Ditto.

Yes.

> 
> > +		acpi_handle_debug(handle, "ignoring data node\n");
> > +
> > +		kfree(orig_path);
> > +		return true;
> > +	}
> > +
> > +out_free:
> > +	kfree(orig_path);
> > +	return false;
> > +}
> 

-- 
Kind regards,

Sakari Ailus

