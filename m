Return-Path: <linux-acpi+bounces-8709-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE8299A07D
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 11:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36E95288311
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 09:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84619212640;
	Fri, 11 Oct 2024 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mfIqlLPn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC251F9415;
	Fri, 11 Oct 2024 09:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728640481; cv=none; b=ihjAe0qAncmBpQ7A9LVIgtH8EIOYVUjJnzVvKWBNhuFNmpWT4LmxsRWc4obJjqqgQ/TZmLuy56T6ySChbrWzhbUm8bSp1Bj0rvO1vqlwvQucbrlsoHonFi6UcOC+9MDK9GRuaYdNjZuVnHAnIknVg6M7WBXU3jHjARwi9emdlEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728640481; c=relaxed/simple;
	bh=RpeG/rTTMam2yBQbOjZii9wvh/NKHEVnxM1dRWn9JlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ylt8sa7l8Vybv+N5Htvfj3F0BEIZCUnjKsRamvFF3il0ipMBJWI+Su1EiFwXjlevpBdFfuBRQFimrcba1BPVb7y0UccdvZyiRLj/gWbZNyMghO1H969V6AWdC153dXhJO6PRzkr8Tc4WluaF7paRUHplF4FgZUE/pgQ7PaGMpbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mfIqlLPn; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728640480; x=1760176480;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RpeG/rTTMam2yBQbOjZii9wvh/NKHEVnxM1dRWn9JlM=;
  b=mfIqlLPnoi9LKAppMJ7CX049bW+5fOZWs8BvT4rJ+PQX71lIK+SbIQsu
   msQT+VuUPSOn0quMr8wOFuWtzg2tDu3olw42vX3c90VHx+RPHV58CCYXe
   fYmXE1Lut26htCa2hvLijgsG2C4xkeQHJ3NFC1ElSoHHGHl03hAlQmkE/
   5lhWTxzgiatKWHIei1bihXD/xecaJubpdSGSO0brAN5Q/qU6bkIWFKLJI
   TLyt4AQi/4OZO+e37PcZzjwpxQsz9YCDXV7/ds8lQpriEiXhJ6eVwntCL
   Cob+9yKO6UV+kbSWP7rToWjPRxhd+z2ppnFSljSrLjf7v9AsnjgziO7st
   Q==;
X-CSE-ConnectionGUID: i0nAVyW8Tsupl9bz4ipgbw==
X-CSE-MsgGUID: VPiV68kCS3K02/GOagDHuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="38683728"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="38683728"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 02:54:39 -0700
X-CSE-ConnectionGUID: LIUpkNU0QZuYvxJQr0bLDw==
X-CSE-MsgGUID: QB9L8/v6RJuoJrQuGSxeJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="77166591"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 02:54:35 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id C5D1611F855;
	Fri, 11 Oct 2024 12:54:32 +0300 (EEST)
Date: Fri, 11 Oct 2024 09:54:32 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] device property: Introduce
 fwnode_for_each_available_child_node_scoped()
Message-ID: <Zwj12J5bTNUEnxA0@kekkonen.localdomain>
References: <20241008-mv88e6xxx_leds_fwnode_put-v1-0-cfd7758cd176@gmail.com>
 <20241008-mv88e6xxx_leds_fwnode_put-v1-1-cfd7758cd176@gmail.com>
 <Zwi6Dn4yJxst4xv2@kekkonen.localdomain>
 <07ec0837-d7a3-413e-a281-e06feafe7f34@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07ec0837-d7a3-413e-a281-e06feafe7f34@gmail.com>

Hi Javier,

On Fri, Oct 11, 2024 at 10:34:32AM +0200, Javier Carrasco wrote:
> On 11/10/2024 07:39, Sakari Ailus wrote:
> > Hi Javier,
> > 
> > On Tue, Oct 08, 2024 at 06:10:27PM +0200, Javier Carrasco wrote:
> >> Introduce the scoped variant of the
> >> fwnode_for_each_available_child_node() to automatically decrement the
> >> child's refcount when it goes out of scope, removing the need for
> >> explicit calls to fwnode_handle_put().
> >>
> >> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> >> ---
> >>  include/linux/property.h | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/include/linux/property.h b/include/linux/property.h
> >> index 61fc20e5f81f..b37508ecf606 100644
> >> --- a/include/linux/property.h
> >> +++ b/include/linux/property.h
> >> @@ -168,6 +168,11 @@ struct fwnode_handle *fwnode_get_next_available_child_node(
> >>  	for (child = fwnode_get_next_available_child_node(fwnode, NULL); child;\
> >>  	     child = fwnode_get_next_available_child_node(fwnode, child))
> >>  
> >> +#define fwnode_for_each_available_child_node_scoped(fwnode, child)	       \
> >> +	for (struct fwnode_handle *child __free(fwnode_handle) =	       \
> >> +		fwnode_get_next_available_child_node(fwnode, NULL); child;     \
> >> +	     child = fwnode_get_next_available_child_node(fwnode, child))
> >> +
> > 
> > On OF, the implementation of the .get_next_child_node() fwnode op is:
> > 
> > static struct fwnode_handle *
> > of_fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
> >                               struct fwnode_handle *child)
> > {
> >         return of_fwnode_handle(of_get_next_available_child(to_of_node(fwnode),
> >                                                             to_of_node(child)));
> > }
> > 
> > On ACPI we currently have .device_is_available() returning false but that
> > probably should be returning true instead (it's been virtually unused
> > previously).
> > 
> > That makes fwnode_get_next_available_child_node() and
> > fwnode_get_next_child_node() equivalent on both ACPI and OF. Presumably
> > creating unavailable nodes would be useless on swnode, too.
> > 
> > So my question is: what do we gain by adding all these fwnode_*available()
> > helpers?
> > 
> >>  struct fwnode_handle *device_get_next_child_node(const struct device *dev,
> >>  						 struct fwnode_handle *child);
> > 
> 
> Hi Sakari, thanks for your feedback.
> 
> I thought that the difference is not in OF (which either way ends up
> calling __of_device_is_available()), but in ACPI.
> 
> For fwnode_for_each_child_node(), the ACPI callback is
> acpi_get_next_subnode(), and I don't see that the device_is_available()
> callback is used in that case.

fwnode_get_next_available_child_node() also calls
fwnode_device_is_available() and that returns false on all non-device nodes
right now. As noted above, fwnode_device_is_available() should probably
return true for non-device nodes on ACPI. I'll post a patch.

> 
> For fwnode_for_each_available_child_node(),
> fwnode_get_next_available_child_node() is used, which checks
> fwnode_device_is_available(), which then calls device_is_available().
> 
> What's the catch?

-- 
Kind regards,

Sakari Ailus

