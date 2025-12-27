Return-Path: <linux-acpi+bounces-19869-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F17CDFE56
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Dec 2025 16:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B23BE3000F94
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Dec 2025 15:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B90246781;
	Sat, 27 Dec 2025 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E0Aw/Txt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E0A2405FD;
	Sat, 27 Dec 2025 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766848995; cv=none; b=ZAeF3o77hsN6cW2lWWzRuRXXTXi5kJHXDomCZYdYv/Fo9u7xFBpVkfqeGtlFm6Mye+xBLfTlN95Roq2NaKvAnkfZjz/T1L75+8RY9+3SJA0kEQv/lHBPzU3YJHCuv64Meu6E5bUUqpJPY8o1PwFBHpPQjINc/QGzRqOdBpytHUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766848995; c=relaxed/simple;
	bh=aJCJjb0+vGt4+ke4RYGQuIVdravL691g4gCMLHSWxVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/83sQ5XJzC+KVumCF3gPaBU9HwoBAwEDT61T94Tsc+Tbn4+/3RwNi7nM4IQ4uqoJLDpjAkhNZg6bFELjUZ/ToiKMKIb5yiQUkY1l8JoSu91a+ON45ztNgnNkSE0CV0MOBtduCgVkp225gcurE0Tj6rir/vowo6pIm5ABTISXlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E0Aw/Txt; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766848993; x=1798384993;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aJCJjb0+vGt4+ke4RYGQuIVdravL691g4gCMLHSWxVU=;
  b=E0Aw/TxtfyaMGJkc8tO2SNhCraBaoHre7jBxn3sH9OdS9SOYkwJyZ9v8
   fUrY4O8F9gHUil+M0yQ7b/k2MURVTwR0OTzRIqzpPGYD7dT+mx4xl+1bo
   MC1hwPGFMBvg9kxecOvGPVk0WvvQU811RfeaMZpmCDwDXmsuPTGspLHRf
   PpwFDoFnjYP0DguPhjK+s4jmgsAqre8l7amJFiKZn3b7cm3vOuf0sO3j4
   o5EDUrZaZT9vHPPFudXE4ZXMuQoE7YBJrJ5RKk+ufk0kSuQzG07zy4NTU
   hm2kZELGeNnVF0pgCpAvlGUBzI2fWVL26WRa9Glp0MWjvEp74b6NECizZ
   w==;
X-CSE-ConnectionGUID: ORbve7AXTC2d0u5t50UfPg==
X-CSE-MsgGUID: /psJm/G9R0uC/CZV64M3Jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11654"; a="86126524"
X-IronPort-AV: E=Sophos;i="6.21,180,1763452800"; 
   d="scan'208";a="86126524"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2025 07:23:12 -0800
X-CSE-ConnectionGUID: 11YvjeQCR7iH9CwO17WT/A==
X-CSE-MsgGUID: zw8bgYMMSQynvdDaJYGddQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,180,1763452800"; 
   d="scan'208";a="205481126"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.211])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2025 07:23:08 -0800
Date: Sat, 27 Dec 2025 17:23:06 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Lucas De Marchi <demarchi@kernel.org>, linux-acpi@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [PATCH] software node: replace -EEXIST with -EBUSY
Message-ID: <aU_52lcfC8NzmFp5@smile.fi.intel.com>
References: <20251220-dev-module-init-eexists-linux-acpi-v1-1-af59b1a0e217@samsung.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220-dev-module-init-eexists-linux-acpi-v1-1-af59b1a0e217@samsung.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Dec 20, 2025 at 04:55:00AM +0100, Daniel Gomez wrote:
> From: Daniel Gomez <da.gomez@samsung.com>
> 
> The -EEXIST error code is reserved by the module loading infrastructure
> to indicate that a module is already loaded. When a module's init
> function returns -EEXIST, userspace tools like kmod interpret this as
> "module already loaded" and treat the operation as successful, returning
> 0 to the user even though the module initialization actually failed.
> 
> This follows the precedent set by commit 54416fd76770 ("netfilter:
> conntrack: helper: Replace -EEXIST by -EBUSY") which fixed the same
> issue in nf_conntrack_helper_register().
> 
> Affected modules:
>   * meraki_mx100 pcengines_apuv2

As I read the description the problem is in the kmod/do_module_init(). If you
need a clear way to distinguish that, use some unique error code in the kernel
module loader. I fully agree with Greg that this is a slippery slope which
leads to -EEXIST to be forbidden in the drivers which is no go.

NAK.

-- 
With Best Regards,
Andy Shevchenko



