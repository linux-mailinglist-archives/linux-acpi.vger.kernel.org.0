Return-Path: <linux-acpi+bounces-12840-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0634EA7F826
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 10:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A9A16A499
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 08:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A83263F2B;
	Tue,  8 Apr 2025 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MmNDaMQY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6800F263C66;
	Tue,  8 Apr 2025 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744101629; cv=none; b=Epy+ntxf/ENFED4IiJJU3woNOWirNCAmfv3g9852AxmN9T9SQGRRVmkOAeXgLEbJZ+/wvaI1zzlJCveTvFa5HgQq+bTiV93xpH1QOC2arGb91JaN12VR2FsWtHGo9E+Tel3FULuk0VcuwxxlOgQc8iJE7DULd+Vn3azl4shZSL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744101629; c=relaxed/simple;
	bh=NKh2Q8RNcmYqQ1fV7Kb2KYYK7lphnU/7QNq2Pl9UQwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQBweDBkzmyerdDn+5Yj80WDoVWlC833RHeiAHKgrrCJC5ZY+F+PANPpAm7AblIGkFv1wWBwuSkPh4GTT3z1KCJZ9yIClfqaHBLikKhX1y4h1vB0lL8US5HMg9dfbYfsa+Tyq7r968kCq+43nMmDIIXtQnnMT2JWKC64gbpaiHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MmNDaMQY; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744101627; x=1775637627;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NKh2Q8RNcmYqQ1fV7Kb2KYYK7lphnU/7QNq2Pl9UQwc=;
  b=MmNDaMQYM9Ig8vu9sxPu/gfqaNNaFj/kyAHjHEOvDwmtc3ObP9rdF0Mm
   nQYUV/DxBztADS6KYELMTUseZ9uATSSbVxyBt3uxl8jcXhYg96th64K2O
   WgjAVVk/5FxkeECesBKiUV+hPxsHW34u74uTgFl4BSgV6MVutl3kRwV78
   aqXEZJrV8S5JJ60r9nLEsPBhd1W2VVdiULC9TA9ctibfY51TbljFH2I4J
   mgXOchF+6zAN5PUarRmwMUvs9H/+vi5MxB3xG2UXeKKVLKsLTY4E8/TWR
   lSt1WwMHrMrjoBrMsuQC7Zv7RsbFi6EMgqhMdW5IOzdYg5lFAgwyIT1l3
   g==;
X-CSE-ConnectionGUID: AkBlJBPQTjagVbwt2AF+Wg==
X-CSE-MsgGUID: L8+rV3lcT+GGoHU9gHkGXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="49369851"
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; 
   d="scan'208";a="49369851"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 01:40:26 -0700
X-CSE-ConnectionGUID: mcx03MW1QbOi5jIHcu2bWA==
X-CSE-MsgGUID: YH9391qbR6yVY9OFWsZlLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; 
   d="scan'208";a="133357595"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 01:40:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u24VI-0000000ALDU-3Bt4;
	Tue, 08 Apr 2025 11:40:20 +0300
Date: Tue, 8 Apr 2025 11:40:20 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	devicetree@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>, linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 0/2] device property: Add
 fwnode_property_get_reference_optional_args
Message-ID: <Z_Tg9JIP7iSoTujj@smile.fi.intel.com>
References: <20250407223714.2287202-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407223714.2287202-1-sean.anderson@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 07, 2025 at 06:37:12PM -0400, Sean Anderson wrote:
> This series adds a fwnode-equivalent to of_parse_phandle_with_optional_args.

Thanks, but no user. Not acceptable in this form. Also see individual comments.

-- 
With Best Regards,
Andy Shevchenko



