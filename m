Return-Path: <linux-acpi+bounces-12742-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57028A7BA93
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 12:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 361767A9908
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 10:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2480919EEBD;
	Fri,  4 Apr 2025 10:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="epHjAsBH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DE3158858;
	Fri,  4 Apr 2025 10:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743761981; cv=none; b=LFKqN9SHq5jyz53MylO0kuWJqD4hX/kM+ViX8w98Cz+G4z0Tkpt6VwUGSd08e7Vpeoe0yjNA0aUlOErkZJ0i9N5P9YG6DY3vux7lmjZ3dGv8M0gk/geqLk+ZBvLwunxei1gmcsHjm1bMFYFsRPGRUKud4D4tOuP1BVMxt3RK014=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743761981; c=relaxed/simple;
	bh=Wy/T6Pf15uzpPtpms7Xqs6ZaKLFk5BPTUSj9Gkvor04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYCcvQMj537SYLvHwwnwB0LG3plWu3j9WbVHRDaxj51zLk9bSHVoxwKknTvF3nI68KicjSnN9uIz8XGLwx7Im0G5MKpVnePmIhYo3s39/I7dsCTEUq1HN8DwYG3yXCPdpJR62GmdcNiisAWG21WjMrJx+axwuKCATvEgK13qgjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=epHjAsBH; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743761978; x=1775297978;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wy/T6Pf15uzpPtpms7Xqs6ZaKLFk5BPTUSj9Gkvor04=;
  b=epHjAsBHo3Io0V0oi84xXcPRbDsuJrtZ3ZSvOmv/AZ7JB+G+O3NcOFPi
   8yGSaTcoephlPCKtUWjdL0QUQGEMbPTOcpVEpbTyiaNIUL0MQLbxtsjTW
   zJd1tU2so3gsFWwEDQAEdN+SZXeWFTacQCUPqtZNd7W5/+ujnL4g22frO
   9JfDtN8xeOZI1R38atR9BfLesa6icKssAwnk4o2PMLSZo/eKVgGaCGGUN
   2ZVcCvqsQA1KY9UDapa2LMS5MnWayEMqBYs4ztrpvzETy8p4eKXEpPP15
   FOFhR1ShiVkMmS8ZWgChmuDTRt87OySeUnPYcxtIH51qBcWfaB8KoLW2e
   w==;
X-CSE-ConnectionGUID: 0m3N6Hr4QGifW1ovO67zSA==
X-CSE-MsgGUID: 8eJLpvHKTUScyUAMD+U3GQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="44352085"
X-IronPort-AV: E=Sophos;i="6.15,187,1739865600"; 
   d="scan'208";a="44352085"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 03:19:37 -0700
X-CSE-ConnectionGUID: 1jn45cb0SriWsJsIfDqCIA==
X-CSE-MsgGUID: vC6rdrKFSZ6LwLO/FeQyKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,187,1739865600"; 
   d="scan'208";a="132396710"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 03:19:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u0e96-00000009648-1lI8;
	Fri, 04 Apr 2025 13:19:32 +0300
Date: Fri, 4 Apr 2025 13:19:32 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Zijun Hu <quic_zijuhu@quicinc.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 1/1] device property: Add a note to the fwnode.h
Message-ID: <Z--yNPfIz7TqqC42@smile.fi.intel.com>
References: <20250331163540.280606-1-andriy.shevchenko@linux.intel.com>
 <f6dd3667-8528-4597-963f-75e78d7be733@icloud.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6dd3667-8528-4597-963f-75e78d7be733@icloud.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 04, 2025 at 10:59:41AM +0800, Zijun Hu wrote:
> On 2025/4/1 00:35, Andy Shevchenko wrote:
> > Add a note to the fwnode.h that the header should not be used
> > directly in the leaf drivers, they all should use the higher
> > level APIs and the respective headers.

...

> > + * Note, this header is not meant to be used by the leaf drivers.
> > + * It provides the low level data types and definitions for the firmware
> 
> Ack
> 
> > + * and device property providers. The respective API headers should
> > + * guarantee all the required data types and definitions without including
> > + * this header directly into the driver.
> 
> device property(include/linux/property.h)
> 	       ^
> 	       |
> firmware node(include/linux/fwnode.h)
>    ^           ^         ^        ^
>    |           |         |        |
>    DT         ACPI     SWNODE    ...
> 
> For various firmware implementations(DT|ACPI|SWNODE...), i feel we may
> allow them include fwnode.h by their header or source files.

That's the point, yes. And that's what exactly I put under the first sentence.
The device property providers are not the leaf drivers in this sense.

-- 
With Best Regards,
Andy Shevchenko



