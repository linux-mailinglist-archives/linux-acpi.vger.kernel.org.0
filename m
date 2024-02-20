Return-Path: <linux-acpi+bounces-3741-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D7385CA96
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Feb 2024 23:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B421C2142A
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Feb 2024 22:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94E8152E05;
	Tue, 20 Feb 2024 22:21:17 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46123151CF4
	for <linux-acpi@vger.kernel.org>; Tue, 20 Feb 2024 22:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708467677; cv=none; b=Up4+q4ac1dkQkI/nwPOL29vsAn9BKEq9BhXZcRez0pAI7JwulBo1jHAKR9VR9ID5HwGmfZFuCbspNgQQvhl7qAn6Bxs0JquBzlJSfGe1UbI1Z1EUcTm4cj9JN7PrPrqncciuUU9rF0Hfbodr5P4uupE2N2nijcHK1/1lGnaRGA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708467677; c=relaxed/simple;
	bh=UI6nc//5LaUt0b1ovboOTheF0mpKCsj6wpGdgtd8tvY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWAGJCDpMD6W0MAsfzl7V91PvAqHE/wd3DmZ+K4y7X6ox+TcxTseFTDZgaQlthA2MWe7zU9H2pd+jElovHVwKK+/zEb1uUyIx11tF/QqVOchiUQq4BRwEBjDwtbF50twepODwMyij9TwqC9z0wzbL5MAEIdWJJfRD7wGWHKNEV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 5b49f83f-d03e-11ee-b3cf-005056bd6ce9;
	Wed, 21 Feb 2024 00:21:13 +0200 (EET)
From: andy.shevchenko@gmail.com
Date: Wed, 21 Feb 2024 00:21:13 +0200
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 2/2] ACPI: property: Ignore bad graph port nodes on
 Dell XPS 9315
Message-ID: <ZdUl2eg8hM5RkrOL@surfacebook.localdomain>
References: <20240213134606.383817-1-sakari.ailus@linux.intel.com>
 <20240213134606.383817-3-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213134606.383817-3-sakari.ailus@linux.intel.com>

Tue, Feb 13, 2024 at 03:46:06PM +0200, Sakari Ailus kirjoitti:
> Some systems were shipped with both Windows and Linux camera descriptions.
> In general, if Linux description exist, they will be used and Windows
> description ignored.
> 
> In this case the Linux descriptions were buggy so use Windows definition
> instead. This patch ignores the bad graph port nodes on Dell XPS 9315 and
> there are likely other such systems, too. The corresponding information
> has been added to ipu-bridge to cover the missing bits.

...

>  void acpi_mipi_scan_crs_csi2(void);
>  void acpi_mipi_init_crs_csi2_swnodes(void);
>  void acpi_mipi_crs_csi2_cleanup(void);

+ blank line?

> +bool acpi_graph_ignore_port(acpi_handle handle);
>  
>  #endif /* _ACPI_INTERNAL_H_ */

...

> +static const struct dmi_system_id dmi_ignore_port_nodes[] = {
> +	{
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 9315"),
> +		},
> +	},
> +	{ 0 }

0 is not needed. Moreover, it's a bit unusual.

> +};

...

> +static const char *strnext(const char *s1, const char *s2)
> +{
> +	s1 = strstr(s1, s2);
> +
> +	if (!s1)
> +		return NULL;
> +
> +	return s1 + strlen(s2);
> +}

NIH str_has_prefix() ?

...

> +/**
> + * acpi_graph_ignore_port - Tell whether a port node should be ignored
> + * @handle: The ACPI handle of the node (which may be a port node)
> + *
> + * Returns true if a port node should be ignored and the data to that should

Please, run kernel-doc validation and fix the warnings.

> + * come from other sources instead (Windows ACPI definitions and
> + * ipu-bridge). This is currently used to ignore bad port nodes related to IPU6
> + * ("IPU?") and camera sensor devices ("LNK?") in certain Dell systems with
> + * Intel VSC.
> + */
> +bool acpi_graph_ignore_port(acpi_handle handle)
> +{
> +	const char *path = NULL, *orig_path;
> +	static bool dmi_tested, ignore_port;
> +
> +	if (!dmi_tested) {
> +		ignore_port = dmi_first_match(dmi_ignore_port_nodes);
> +		dmi_tested = true;
> +	}
> +
> +	if (!ignore_port)
> +		return false;
> +
> +	/* Check if the device is either "IPU" or "LNK" (sensor). */
> +	orig_path = acpi_handle_path(handle);
> +	if (!orig_path)
> +		return false;
> +	path = strnext(orig_path, "IPU");

IIUC this can be rewritten as

	path += str_has_prefix();
	if (path == orig_path)
		...

> +	if (!path)
> +		path = strnext(orig_path, "LNK");
> +	if (!path)
> +		goto out_free;
> +
> +	if (!(path[0] >= '0' && path[0] <= '9' && path[1] == '.'))

isdigit() ?

> +		goto out_free;
> +
> +	/* Check if the node has a "PRT" prefix. */
> +	path = strnext(path, "PRT");
> +	if (path && path[0] >= '0' && path[0] <= '9' && !path[1]) {

Ditto.

> +		acpi_handle_debug(handle, "ignoring data node\n");
> +
> +		kfree(orig_path);
> +		return true;
> +	}
> +
> +out_free:
> +	kfree(orig_path);
> +	return false;
> +}

-- 
With Best Regards,
Andy Shevchenko



