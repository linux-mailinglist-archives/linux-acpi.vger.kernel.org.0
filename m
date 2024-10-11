Return-Path: <linux-acpi+bounces-8703-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F36999C22
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 07:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F532837E1
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 05:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495711F4FB2;
	Fri, 11 Oct 2024 05:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aUTTCd2O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B141A2F26;
	Fri, 11 Oct 2024 05:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728625175; cv=none; b=YH/niysU5o0eNMoVQTGZLrsX/jDhxphuzmNkltR/8SR+KUE2lEkOe0ZpaosVgCLWbU/myODsFufLpJNI5joDBXMBsPT7jcvSjNuYA2s2Vy3fmepnDcaDUF30vzmHSPanDXNY8aTa9QYoFQ8HcUB8OtS8XNyrHowyxerahRmNJuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728625175; c=relaxed/simple;
	bh=+d42UvkUBu98QAceADfnNLgwqRMi7KeH8jtCFXIHtv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqqCn0VBEXrTSrbm/ujMwmAISZmAXU3kvXCBaUOLpYkzIaLENABOrp+yNAcjzQoK/JWyeDn5rJDXWUPSZ4RCLoxDtDKsIN0/F0e9Qa22Yrw2PApCLx9kF7vtfu4+i1QMBfavFDTwF63ucaJRNT0ivNgxjrsros7H+1bKom8tap4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aUTTCd2O; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728625174; x=1760161174;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+d42UvkUBu98QAceADfnNLgwqRMi7KeH8jtCFXIHtv4=;
  b=aUTTCd2OjDuOfv9+GwLO4AWEVRPjRhuuumNTlNZwukzjcYAo+VIYZrNT
   cYAkFMkrDSBDq1m3QPImGtQX/BdogWsZlta37/GU3RsPAkMo6QoYByMfv
   GbFqfdEPWxoEfnlrFEEf5mzIVZwDulCgIg0bF1ZDdxXWS58oWf2YKx9WD
   Q8N9Yp43TM9W5zIjHceTdsyUBWsgr0eBDRCxGfGMHb0oxg5NCRHihyFBP
   Yd3CdLic1p/RrWD9A8G+ADtmKaSGpMsItTN3hEckZBQR2/hMvNGJLIWBm
   4Y2Ph8HmOcakw0DY7CghUGMstZVKf5z8f/GyREiq5i8Zqxk4eZQh2mm31
   A==;
X-CSE-ConnectionGUID: /Rfvx4KcRcyPkcLNs/NJ9g==
X-CSE-MsgGUID: 6CYZGIpPRxKVD0upnjqI4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="27824747"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="27824747"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 22:39:33 -0700
X-CSE-ConnectionGUID: CjJQ2kg9SW2lgwlQLQSKYA==
X-CSE-MsgGUID: QF+qDOJ5TA6Re0RbSQUttA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="107673577"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 22:39:29 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 57B4D11F855;
	Fri, 11 Oct 2024 08:39:26 +0300 (EEST)
Date: Fri, 11 Oct 2024 05:39:26 +0000
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
Message-ID: <Zwi6Dn4yJxst4xv2@kekkonen.localdomain>
References: <20241008-mv88e6xxx_leds_fwnode_put-v1-0-cfd7758cd176@gmail.com>
 <20241008-mv88e6xxx_leds_fwnode_put-v1-1-cfd7758cd176@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008-mv88e6xxx_leds_fwnode_put-v1-1-cfd7758cd176@gmail.com>

Hi Javier,

On Tue, Oct 08, 2024 at 06:10:27PM +0200, Javier Carrasco wrote:
> Introduce the scoped variant of the
> fwnode_for_each_available_child_node() to automatically decrement the
> child's refcount when it goes out of scope, removing the need for
> explicit calls to fwnode_handle_put().
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  include/linux/property.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 61fc20e5f81f..b37508ecf606 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -168,6 +168,11 @@ struct fwnode_handle *fwnode_get_next_available_child_node(
>  	for (child = fwnode_get_next_available_child_node(fwnode, NULL); child;\
>  	     child = fwnode_get_next_available_child_node(fwnode, child))
>  
> +#define fwnode_for_each_available_child_node_scoped(fwnode, child)	       \
> +	for (struct fwnode_handle *child __free(fwnode_handle) =	       \
> +		fwnode_get_next_available_child_node(fwnode, NULL); child;     \
> +	     child = fwnode_get_next_available_child_node(fwnode, child))
> +

On OF, the implementation of the .get_next_child_node() fwnode op is:

static struct fwnode_handle *
of_fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
                              struct fwnode_handle *child)
{
        return of_fwnode_handle(of_get_next_available_child(to_of_node(fwnode),
                                                            to_of_node(child)));
}

On ACPI we currently have .device_is_available() returning false but that
probably should be returning true instead (it's been virtually unused
previously).

That makes fwnode_get_next_available_child_node() and
fwnode_get_next_child_node() equivalent on both ACPI and OF. Presumably
creating unavailable nodes would be useless on swnode, too.

So my question is: what do we gain by adding all these fwnode_*available()
helpers?

>  struct fwnode_handle *device_get_next_child_node(const struct device *dev,
>  						 struct fwnode_handle *child);

-- 
Regards,

Sakari Ailus

