Return-Path: <linux-acpi+bounces-9627-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C66389D0B3F
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 09:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731451F223C0
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 08:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17608186E46;
	Mon, 18 Nov 2024 08:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kLZ19gA4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B6D2907;
	Mon, 18 Nov 2024 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731920061; cv=none; b=IdCsJhTFMmuRO/PgwIhBS9EgByaMymNCXVWIwqK/sXaRbzFgB94zwWzxEEJJj6lNVAbF9v/x7qDYof6RfyfsWGecOHJh2Fe9Qz4azcZxYBmxb45+AYhxyVULf9qHMwBPvDey+SrqywxcmxY4z8Rs0QTUt6iJAzaTnmJ2p2HTMXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731920061; c=relaxed/simple;
	bh=/nkoC7NwftY4QWQNAuXltSmyTEaoZqHqU6pXf07AWwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGfE2FvrivwcvNyUiGxoe0eteFH80qJx+yiXZz65RglW1/EwBwX3t7AzUpc7oxP6Jguwd3prgP2fLkXAsm0EdO3wmDZTBhstGDlZArKPDfeJOkl4TVa6+/Z1oq/2fYPT5lN2VHUPpH+h7CLkgrU30nk7W2qTWmEck2SkBRiJeGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kLZ19gA4; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731920060; x=1763456060;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/nkoC7NwftY4QWQNAuXltSmyTEaoZqHqU6pXf07AWwY=;
  b=kLZ19gA40CyZLwB/w/dIEnGX85G8Mai236YV1EOc8/v0RWVxEKqqR5Ta
   Prd6U+ECk7HrKmecJiaUJClQffD2cTQBFxXuMrExMuF+fc1feclxoUzY9
   x8tzfMJqb3ItoGGkgWtPw+jHiMXCrS8dra8TBT3FP92P5nnn/Nw/tsEQb
   yGzkJ2bBbyxcLVMYEhKYHqNGNQo5CPaZOXaILlmDLR4KcnbFSPYkpm6/W
   hfY4kaYgJ3yFsTveV/+zJVYGL2+gu7KzBcE/ebtUdsbXfkLHEutskayP2
   9SFrChGPbt9Mcmwa5NtJtxtCYaakAAv5rLCKQ3wiVi07BeVP7oS8m4u8w
   Q==;
X-CSE-ConnectionGUID: Or/INIu9Rk+3NF8qNdsRCA==
X-CSE-MsgGUID: /WwurzVoSQSBuY4l7GfXmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="43258650"
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="43258650"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 00:54:19 -0800
X-CSE-ConnectionGUID: 1dtxitoBQhiqmvgoC6y2ZQ==
X-CSE-MsgGUID: mTuBJLA4TlyRF75rZn8Zdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,163,1728975600"; 
   d="scan'208";a="89077810"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 00:54:17 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 0FE5411F8D9;
	Mon, 18 Nov 2024 10:54:14 +0200 (EET)
Date: Mon, 18 Nov 2024 08:54:14 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux@treblig.org
Cc: andriy.shevchenko@linux.intel.com, djrscally@gmail.com,
	heikki.krogerus@linux.intel.com, rafael@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device: property: Remove deadcode
Message-ID: <ZzsAtql66f4hd4d1@kekkonen.localdomain>
References: <20241116003253.335337-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116003253.335337-1-linux@treblig.org>

Hi David,

Thanks for the patch.

On Sat, Nov 16, 2024 at 12:32:53AM +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> fwnode_graph_get_endpoint_count() was added in 2021 by
> commit c87b8fc56966 ("device property: Implement
> fwnode_graph_get_endpoint_count()")
> 
> but has never been used.
> 
> fwnode_graph_get_remote_port() has been unused since 2017's
> commit 6a71d8d77795 ("device property: Add fwnode_graph_get_port_parent")
> 
> Remove them.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Both of the functions also exist to span the same scope as the OF API,
hence they should exist as long as the OF framework continues to provide
these API functions. The equivalent OF functions are used by drivers
currently.

-- 
Kind regards,

Sakari Ailus

