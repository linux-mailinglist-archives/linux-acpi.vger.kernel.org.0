Return-Path: <linux-acpi+bounces-12676-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD39A7A17C
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 13:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3576173A54
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 11:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112441F4E34;
	Thu,  3 Apr 2025 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7Be9HbU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4FC746E;
	Thu,  3 Apr 2025 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743678029; cv=none; b=L8z4DcJWsRJSpFiHBn2msKq8BDfCINELptTqwyryX92FBSwByqUlri/fhmB2dSWgHfSIZaoHSKOVd9ogusYpsspqumoQ9kRUW0CXbAskr+dCpt2OszEQQtT4f2t6brrT+IgVmoY/mMpkhDWJvV7oSJrOCUIc2RAnXliONlQfLJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743678029; c=relaxed/simple;
	bh=beaVveygs+qfYECCLnMCgrn+MXb99wkqNXYEFw9FN0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXrJVLtW8PQOEp52XDE+dcONjJuk8ql/Ugc58WszxmnTHNjS2RYsy1l3oiSB8rvOC9vB4H5ImfDJAFip0+bwk2ml6rzv9qc0sWnnt/n28x6j5wiEdBQvVuHbVTX1rcCTFxurzNj/BqfSrXUzQlEYUBGUIR6ow22hMn8mfC1UWs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7Be9HbU; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743678027; x=1775214027;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=beaVveygs+qfYECCLnMCgrn+MXb99wkqNXYEFw9FN0o=;
  b=Z7Be9HbU5fq+iR4VcM8FEQYCf3GEPgW3ZI7rFbsiBips1H6oB0LKfUHx
   VKMCOKZMvVbh6AefxYPkoVDQpUe0aV690LimUeFmR5eWqugaRJQeWYHhV
   dqhLV8wPFRjZCKRBcf1U0IN8DG7lD2dwq16Mpr8EtU1D6DCVtR8xTwdwX
   js+vNMAzPjq1aoy/jjQkL8mjAU31wNHEnzvnjeU2BtVoKFNnZFLRWMDJ6
   SfCs2/uYd8iz1UJlQSNICiYmDc1JhSKBTZBrTC4Zu8TspnUgY7yWTnske
   Sxcpor3+i+HWfJLTeVhCo4iFCeKtlJn1Hnaiwi6xz9bwkAWoC4SGqVIBr
   g==;
X-CSE-ConnectionGUID: tvvk/jwCQBiDwbk5kM3XaA==
X-CSE-MsgGUID: Ya+bO4elTh21rX92RkaLdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="45091600"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="45091600"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 04:00:27 -0700
X-CSE-ConnectionGUID: I79Me/uLTv+M9nKB/GSSBA==
X-CSE-MsgGUID: HO4ryJl8S4SIJw6mnU0CDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="126876456"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 04:00:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u0IJ3-00000008mVd-1vbG;
	Thu, 03 Apr 2025 14:00:21 +0300
Date: Thu, 3 Apr 2025 14:00:21 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 1/1] device property: Add a note to the fwnode.h
Message-ID: <Z-5qRcBOK8x__Ry7@smile.fi.intel.com>
References: <20250331163540.280606-1-andriy.shevchenko@linux.intel.com>
 <b2f13a6d-e876-4cd2-b814-6cbc0b5f862e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2f13a6d-e876-4cd2-b814-6cbc0b5f862e@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 03, 2025 at 06:03:57PM +0800, Zijun Hu wrote:
> On 4/1/2025 12:35 AM, Andy Shevchenko wrote:
> > + * Note, this header is not meant to be used by the leaf drivers.
> > + * It provides the low level data types and definitions for the firmware
> > + * and device property providers. The respective API headers should
> > + * guarantee all the required data types and definitions without including
> > + * this header directly into the driver.
> 
> sorry, i don't understand both "leaf drivers" and "respective API
> headers". could you have examples ?

leaf driver is like almost anything under drivers/iio, for example.
The respective API headers is usually: of.h or property.h (the latter
is highly preferred in a new code). TL;DR: the rule of thumb is
do not include this until you know exactly what you are doing.

-- 
With Best Regards,
Andy Shevchenko



