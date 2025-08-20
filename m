Return-Path: <linux-acpi+bounces-15865-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F053B2DFBC
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Aug 2025 16:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B7A189119B
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Aug 2025 14:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A4D2DECA1;
	Wed, 20 Aug 2025 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R8UgzY2f"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D622DEA61;
	Wed, 20 Aug 2025 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755700951; cv=none; b=JT7kBEgUzlJHI6GtsFEEjPriQSV1VgN7+4yNGE9l8t9xj5DJUbp/3nxHipJuLTBpWthpiOIiyB3Yy4VOS4Lxxtm2wTn795Qi9i2ooWIsJ0bVPPoRSwNb4ARhrQZfiiCw/u5thT9u6GBQ03aOKazYLa2KphdAhshtLwKYYr7bH6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755700951; c=relaxed/simple;
	bh=0gKp/AFQ6m78tlQIdTDtIDcggV7Ya5QNvm8nvwpsFNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fh3/6Pd8praFhJjZzG4s5eEdo3dCeTFqJePwCaMQ+Hi+vzbe2O9ch7l8HnskRJ/5hYvSKiHcw3HSLV94ubmAh4CbkbdL0t5w0B7dlWXyHC0niTbaUTQiVrhTnSWXDLI2YwZ1gZTkJhXGVUDdBxDHV3+6RTWsgIjEyVD7icPK5Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R8UgzY2f; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755700951; x=1787236951;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0gKp/AFQ6m78tlQIdTDtIDcggV7Ya5QNvm8nvwpsFNo=;
  b=R8UgzY2fJGPknDEz2Ticf4TN70zbiPbyY5UknLECnLoz0b5elopBCRSj
   rmjGDKLf6pHg55G8fNSMzsKQ8/N/1EwnVkZrFCpHy6jKzGmD7JkPQ5tlv
   X6nBWYD9LQ9aXD9dQmoSQQ8dLVk0QgtINJwl+67YAzGew0rzY2tNL03fC
   2jDT2e7j46ltrAD13e1NTdKYe4H4nkKVUArfH3ulEja5zm8QjJzLczppG
   cVr6nJ6M1QHGmXILPpmsELDoUrgqLEAQovcjWFr4YJddi1Aak7t80WrdG
   FHszNZhVyq1y3Jw9VZ5rinM5ZXCcb0F3pxXcBgi6o5HAwryTswsYE7PAk
   A==;
X-CSE-ConnectionGUID: xo0DaE4zRH+aWO0M4F1VtA==
X-CSE-MsgGUID: GU8acDaYQ3aLuF9LZYllxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="56998517"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="56998517"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 07:42:30 -0700
X-CSE-ConnectionGUID: WNplai92SVyoBkC8iQa2BQ==
X-CSE-MsgGUID: h+FDO9+KQHmrl4/YJ+7ELA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="172408812"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 07:42:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uok1B-00000006xcZ-1WD8;
	Wed, 20 Aug 2025 17:42:25 +0300
Date: Wed, 20 Aug 2025 17:42:25 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] software node: Constify node_group in registration
 functions
Message-ID: <aKXe0VnhLlhllHba@smile.fi.intel.com>
References: <2zny5grbgtwbplynxffxg6dkgjgqf45aigwmgxio5stesdr3wi@gf2zamk5amic>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2zny5grbgtwbplynxffxg6dkgjgqf45aigwmgxio5stesdr3wi@gf2zamk5amic>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 13, 2025 at 11:03:52PM -0700, Dmitry Torokhov wrote:
> The software_node_register_node_group() and
> software_node_unregister_node_group() functions take in essence an
> array of pointers to software_node structs. Since the functions do not
> modify the array declare the argument as constant, so that static
> arrays can be declared as const and annotated as __initconst.

If it compiles and works, no objection from me from code perspective:
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



