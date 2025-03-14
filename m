Return-Path: <linux-acpi+bounces-12245-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E469A612EC
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Mar 2025 14:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C6EC1B63CC7
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Mar 2025 13:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374311FF7DB;
	Fri, 14 Mar 2025 13:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mvZDvVBs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1181FF7CF;
	Fri, 14 Mar 2025 13:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741959816; cv=none; b=pnZnysTQgr5UrfLohNQ7iaKycFjmk6k/xIMjyEvi5JhA7SsiQ4ALJZg6vyf4wKBb6PYQpUocf8+pu96pEpfk3U+Nss3nxND3Ogo+CeqT6lmNWKscqlLINJ7sokqUO8lwtLKQH2w+kgswvjL8F3HQXhuGOnieeFLFYH/TbPB2/C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741959816; c=relaxed/simple;
	bh=kTLNfjCdUMiwVUfdcdXhGdtLAQHqcxTizJcWuW4lj8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdSw2Mnpw4VLc8+/UUzofJXJjQEoXlvTc08m5AqhtMGZTEhIOfcFFOvMpo6nta5qksZXW3Yu6ay19ab1D/vGR9jX8l2Csd7v1PCOxgzqsoz4fZaRPbl/RZjfY2tHAtqx1l6ZfxkqdcmIAiuP9jLVrEjrDQachi4zx+xH3YnH2V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mvZDvVBs; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741959815; x=1773495815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kTLNfjCdUMiwVUfdcdXhGdtLAQHqcxTizJcWuW4lj8Q=;
  b=mvZDvVBsjF7eAJMVifcsbvCBx/4JCYHUtZIofeXvY9uF/9Rhc9u69p0H
   6mY7E+ZURkGI5yHw+IrJlHPekTX1NIZUCVAEjOPywe8CtYhCNYym2odef
   u/ymsO9uWSaVcQEtokplA/DLnWgD9Oi7JJ8/Uk7cWaIPhCJv7NPR87reI
   2qUg88fEos2lIC4JUcvyCZFKGGpR+Lxfp7CZ0J1PHzszHXLNLh1RDkj5q
   WJFVJsRxvWy5I/JgX29p1DpygSTmGtD5hn4FuZNlZA5E0TfAZX+Oq956l
   QAeT7PwS3IMoP1JpLbtjKghx8AvyJooYdu4x0qiLv2wGigB1DX9Bt2T1j
   Q==;
X-CSE-ConnectionGUID: COIErcAhQ0SwPoqodnxhgQ==
X-CSE-MsgGUID: mZd/Dj2qTdWHuCRdeRZZZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="60651123"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="60651123"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 06:43:34 -0700
X-CSE-ConnectionGUID: 2zWGKLi5THC0SBjWxTjKJA==
X-CSE-MsgGUID: 6RglwHKkSW+QCEeSvVMbug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121015278"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 06:43:29 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 1972A11FA2C;
	Fri, 14 Mar 2025 15:43:27 +0200 (EET)
Date: Fri, 14 Mar 2025 13:43:27 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Markus Elfring <elfring@users.sourceforge.net>,
	Jakob Riepler <jakob+lkml@paranoidlabs.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-usb@vger.kernel.org,
	Daniel Scally <djrscally@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v1 1/4] device property: Split
 fwnode_get_child_node_count()
Message-ID: <Z9Qyf6545DEGiJOU@kekkonen.localdomain>
References: <20250310150835.3139322-1-andriy.shevchenko@linux.intel.com>
 <20250310150835.3139322-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310150835.3139322-2-andriy.shevchenko@linux.intel.com>

On Mon, Mar 10, 2025 at 04:54:51PM +0200, Andy Shevchenko wrote:
> The new helper is introduced to allow counting the child firmware nodes
> of their parent without requiring a device to be passed. This also makes
> the fwnode and device property API more symmetrical with the rest.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

