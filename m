Return-Path: <linux-acpi+bounces-21071-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKdSNBSPnGmdJQQAu9opvQ
	(envelope-from <linux-acpi+bounces-21071-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 18:32:04 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F153617ADE6
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 18:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BEDA530B0578
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 17:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59304331A4E;
	Mon, 23 Feb 2026 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="heBYsHNr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59C4330D26;
	Mon, 23 Feb 2026 17:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867390; cv=none; b=QXTwl4HGPH7Ww5p47X7yy1Zz85omNmITtH/4P6fCmudH3gXmiLIOHbSpBV8SeKywvNgdI+Phl/SATVRXZSAgMQoJbdXeaAJhLlKBZa9pS2p9ZHnqUgesfRPZ09MtX6m3VUN0LTS2O+HicoAfu1MxMblq/9jfD/iznWRF7/kmack=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867390; c=relaxed/simple;
	bh=R7ZR2ewU6jnGrElHcur1x/KnVLb5h06zC5kqozFY2Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqRD2KHU8mZo6UI/11zcpFkNLhO7YYZyT2uE6CkfWLpA4GjK4bVOxEPMyE1NfaMB9ksP598yB+11Zl/BGHzhRDK9FGrJGTPQ9czLImcfsDKuadPU24Psg3W9vKfZIA2o5qwASAOPGu0VqAkzKeyz37Ryq0sC+pkHwqwDtNFjxg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=heBYsHNr; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771867389; x=1803403389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R7ZR2ewU6jnGrElHcur1x/KnVLb5h06zC5kqozFY2Us=;
  b=heBYsHNrWNHlMAwLWKEN+Cs6iqhapqOoJISOGWYvC+c2InOGq/VDPl8G
   xw0unCEeT3VeR7JJyctEKErk24JFCCn1J+TIZRIgGnI5jQNDiQBRXmavz
   jwdO+XJL2yt2aR0RXuvnbvSI+YcqkUkWzA6myQgc/bGd4pA+OLfAT5Oar
   /6QACcMPU3LjbekcJwYXnQsmtqjdK6aYlqD1Jmoxj+6C7DxpPli+z2/Vs
   j3xgc45o1zkLjS7isb4d5bVT70uVxlTIwgg4CT3KNycacAqQMx/Ug/cds
   HcjcKlv5mo5HSrEdvOqdoofh7RPzoUXr4++g7LA6QwovL2frqGM78fvO1
   w==;
X-CSE-ConnectionGUID: DTdwnUcdSDqkIM5QYfnUAg==
X-CSE-MsgGUID: z7iv37nDTkOrwaUzuTeRmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="83580297"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="83580297"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 09:23:08 -0800
X-CSE-ConnectionGUID: x8ChZmHNSIOZfmMlxK51iw==
X-CSE-MsgGUID: PxCLBWhOSGyX/YvPUoLdPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="246217668"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.61])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 09:23:05 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 7406E11FC2C;
	Mon, 23 Feb 2026 19:23:30 +0200 (EET)
Date: Mon, 23 Feb 2026 19:23:30 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Len Brown <lenb@kernel.org>, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 2/2] gpiolib: match secondary fwnode too in
 gpio_device_find_by_fwnode()
Message-ID: <aZyNErXB_acR3yYq@kekkonen.localdomain>
References: <20260223-device-match-secondary-fwnode-v2-0-966c00c9eeeb@oss.qualcomm.com>
 <20260223-device-match-secondary-fwnode-v2-2-966c00c9eeeb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-device-match-secondary-fwnode-v2-2-966c00c9eeeb@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,gmail.com,linux.intel.com,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21071-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sakari.ailus@linux.intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kekkonen.localdomain:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,qualcomm.com:email]
X-Rspamd-Queue-Id: F153617ADE6
X-Rspamd-Action: no action

Hi Bartosz,

Thanks for the patch.

On Mon, Feb 23, 2026 at 04:40:53PM +0100, Bartosz Golaszewski wrote:
> In GPIOLIB, during fwnode lookup, after having resolved the consumer's
> reference to a specific fwnode, we only match it against the primary
> node of the controllers. Let's extend that to also the secondary node by
> reworking gpio_chip_match_by_fwnode()
> 
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/gpio/gpiolib.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index c52200eaaaff82b12f22dd1ee8459bdd8ec10d81..7fe1d9ab1281d6c5022b9bdd8909fef2cb74122e 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -11,6 +11,7 @@
>  #include <linux/errno.h>
>  #include <linux/file.h>
>  #include <linux/fs.h>
> +#include <linux/fwnode.h>
>  #include <linux/idr.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> @@ -1395,7 +1396,16 @@ EXPORT_SYMBOL_GPL(gpio_device_find_by_label);
>  
>  static int gpio_chip_match_by_fwnode(struct gpio_chip *gc, const void *fwnode)
>  {
> -	return device_match_fwnode(&gc->gpiodev->dev, fwnode);
> +	struct device *dev = &gc->gpiodev->dev;
> +	struct fwnode_handle *node = dev_fwnode(dev);
> +
> +	if (IS_ERR(fwnode))
> +		return 0;
> +
> +	if (device_match_fwnode(dev, fwnode))

Could device_match_fwnode() match secondary fwnode as well? AFAIU, the
secondary fwnode only exists because it originates from a different fwnode
backend, typically software node, while still representing the same node.

> +		return 1;
> +
> +	return fwnode_is_primary(node) && node->secondary == fwnode;
>  }
>  
>  /**
> 

-- 
Kind regards,

Sakari Ailus

