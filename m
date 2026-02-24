Return-Path: <linux-acpi+bounces-21099-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nHyvEdnxnGksMQQAu9opvQ
	(envelope-from <linux-acpi+bounces-21099-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 01:33:29 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A528C18040C
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 01:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D60293040327
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 00:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B52822A1E1;
	Tue, 24 Feb 2026 00:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MG/SzwAd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC7F226CFE;
	Tue, 24 Feb 2026 00:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771893203; cv=none; b=Z4UmsNDBhjpXKDGNUVo+OIEqnZNpaNo2qoyUM57a7fErrdh2S0Q5ltiXBSPfd1vbNu9XGxNWO0kEzfuF9qTwLj4277y6dSY+hlcuHO0QiQL0PrDjuIW2cuQTz6CldhnqevsDZ24UpV5ka2+SpNbIa7aXAuZ47pywZ5sVagTQLUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771893203; c=relaxed/simple;
	bh=8LAjFwluR8WNxqcDxtrU9nLb7Eues+PFs2wZ0u6676Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8X0FAg+JRGnCPTOO4NF4xa5lHnvUdWT2V0Aaw8kFDt3Nk7Xbr80+9aqgTplS7X0q9JwP0sHGegyvZGqaVOygURDz7BOtZm1uyLMLx5nTTtG1mNh1nbC9sxzPk/q3hpQ+U2fgPLc5/213O8fxfT8i1/0PmOog0R21kgJjopEvsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MG/SzwAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DA1C116C6;
	Tue, 24 Feb 2026 00:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771893203;
	bh=8LAjFwluR8WNxqcDxtrU9nLb7Eues+PFs2wZ0u6676Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MG/SzwAdbZSDWUv8ZQC51UudK2nUmf0Rvps6WS3HkG7vdqvzKDQxaFm/cayjdkI5f
	 /hkEcnJ4kXiFGuAjaGIyhIKtXA+26p8Fl3EKv3Uvmbp3T4MLEkQnC+1WzPw39lBZLw
	 HilsnqSag86Yrt5oT17A+I1OpOLP4rJbNf84iV3E=
Date: Tue, 24 Feb 2026 01:33:21 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Zijun Hu <zijun.hu@oss.qualcomm.com>, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v1 3/3] driver core: Split device related fwnode API to
 device/fwnode.h
Message-ID: <2026022443-cornmeal-overstock-cd70@gregkh>
References: <20260223204412.3298508-1-andriy.shevchenko@linux.intel.com>
 <20260223204412.3298508-4-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223204412.3298508-4-andriy.shevchenko@linux.intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21099-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,lists.linux.dev,kernel.org,gmail.com,linux.intel.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: A528C18040C
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 09:30:32PM +0100, Andy Shevchenko wrote:
> device.h is a huge header which is hard to follow and easy to miss
> something. Improve that by splitting device related fwnode API
> to device/fwnode.h.
> 
> In particular this helps to speedup the build of the code that includes
> device.h solely for a device related fwnode API.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/device.h        | 17 +----------------
>  include/linux/device/fwnode.h | 28 ++++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+), 16 deletions(-)
>  create mode 100644 include/linux/device/fwnode.h
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 4ba6ae72ddf6..d2e2745243ea 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -31,6 +31,7 @@
>  #include <linux/device/devlink.h>
>  #include <linux/device/devres.h>
>  #include <linux/device/driver.h>
> +#include <linux/device/fwnode.h>
>  #include <linux/device/types.h>
>  #include <linux/cleanup.h>
>  
> @@ -38,8 +39,6 @@ struct device_driver;
>  struct module;
>  struct class;
>  struct subsys_private;
> -struct device_node;
> -struct fwnode_handle;
>  
>  /**
>   * struct subsys_interface - interfaces to device functions
> @@ -603,20 +602,6 @@ int lock_device_hotplug_sysfs(void);
>  int device_offline(struct device *dev);
>  int device_online(struct device *dev);
>  
> -void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
> -void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
> -void device_set_node(struct device *dev, struct fwnode_handle *fwnode);
> -int device_add_of_node(struct device *dev, struct device_node *of_node);
> -void device_remove_of_node(struct device *dev);
> -void device_set_of_node_from_dev(struct device *dev, const struct device *dev2);
> -
> -static inline struct device_node *dev_of_node(struct device *dev)
> -{
> -	if (!IS_ENABLED(CONFIG_OF) || !dev)
> -		return NULL;
> -	return dev->of_node;
> -}
> -
>  static inline int dev_num_vf(struct device *dev)
>  {
>  	if (dev->bus && dev->bus->num_vf)
> diff --git a/include/linux/device/fwnode.h b/include/linux/device/fwnode.h
> new file mode 100644
> index 000000000000..4fe6107191a6
> --- /dev/null
> +++ b/include/linux/device/fwnode.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _DEVICE_FWNODE_H_
> +#define _DEVICE_FWNODE_H_

You lost the copyright notice.  While not really needed from a legal
point of view, it's not all that nice from a developer point of view :(


