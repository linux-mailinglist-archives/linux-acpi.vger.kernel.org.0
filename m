Return-Path: <linux-acpi+bounces-16926-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA51B578FE
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 13:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F1E188CEC6
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 11:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672473002D8;
	Mon, 15 Sep 2025 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DeKduYF2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E6229D28F;
	Mon, 15 Sep 2025 11:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937000; cv=none; b=gezhM1b7BuVmXMXB6Op9k24t9RapNoWPmIBtSGJmndvUKBBhSqdbHECwMjrCLS1JAoemMCvS83+NH185WGtXE/V+PcK4RN6D9mpOwsOKzq1qjPLUMesZTt9bj1gENZ6gGHZjCj2h4Bq4d3xIA+kzsgjsv93DMASY4VAUS7xqMdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937000; c=relaxed/simple;
	bh=BbKiR4x9sna8ZoHwC/t2IjvvdHFKRovS0mw90zmgzTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgRdBMBEJy7zpKrscujr1MzVMdi6xdprJyrtEnQc0RlJo1aQUiC6K03CK78O3qg9NbvzsM23P9H9Bucq1WB2pdPt92474VNBtN/m66iPUz6lpzZ8ZWdoTtyKAp4rwHpsnnL32HuYrxhWmX8gEHNQnHzbMI5EPAnqA5r6Yx2UV1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DeKduYF2; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757936999; x=1789472999;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BbKiR4x9sna8ZoHwC/t2IjvvdHFKRovS0mw90zmgzTk=;
  b=DeKduYF2B7FI2hyN5Oc+XGXTR41ikpH6okjaghWEi+ib44ta+CNoMUpX
   R5k6qcaygsfC5jpWBRLmghW00X362qdli+ofyScG0yNgzZ3ZWoy1/hV9m
   eCYI+WMKHvK26ggEhgdvOC0lPxfu03IWChFuR0bEZ7ihgibiaefURcvUL
   zBQQJvesehSWGKqv31RgH6g+MSRKigRE46rxTi1cv9zWt/QdVBz0K0kdN
   FNLKDmRvKvW1uiOooYGGvX1P0hV3r5l4UgIOhOjeTOzjdxgM1SdCKAnbF
   6SWImYQzccEsATmWcoJ++/ouXj5AS+f9+4Ct+45J+ev24+/MmJcw+UhC+
   g==;
X-CSE-ConnectionGUID: tcYbhRG4Rm6Qg0C8fHRIWg==
X-CSE-MsgGUID: dCLmx/jVSo+5DUgC5BuKMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="59413743"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="59413743"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 04:49:58 -0700
X-CSE-ConnectionGUID: 9jRVP6DcTGGPJLpmvwWILw==
X-CSE-MsgGUID: lIbEmjunS9G0Ap25zSwHGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="174434116"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.30])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 04:49:56 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 58CE611FCCF;
	Mon, 15 Sep 2025 14:49:53 +0300 (EEST)
Date: Mon, 15 Sep 2025 14:49:53 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 3/4] ACPI: property: Do not pass NULL handles to
 acpi_attach_data()
Message-ID: <aMf9YRHA8jRgMPAr@kekkonen.localdomain>
References: <5046661.31r3eYUQgx@rafael.j.wysocki>
 <3014880.e9J7NaK4W3@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3014880.e9J7NaK4W3@rafael.j.wysocki>

Hi Rafael,

On Fri, Sep 12, 2025 at 09:42:55PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In certain circumstances, the ACPI handle of a data-only node may be
> NULL, in which case it does not make sense to attempt to attach that
> node to an ACPI namespace object, so update the code to avoid attempts
> to do so.
> 
> This prevents confusing and unuseful error messages from being printed.
> 
> Also document the fact that the ACPI handle of a data-only node may be
> NULL, and when that happens, in a code comment.
> 
> In addition, make acpi_add_nondev_subnodes() print a diagnostic message
> for each data-only node with an unknown ACPI namespace scope.
> 
> Fixes: 1d52f10917a7 ("ACPI: property: Tie data nodes to acpi handles")
> Cc: 6.0+ <stable@vger.kernel.org> # 6.0+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/property.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -124,6 +124,10 @@ static bool acpi_nondev_subnode_extract(
>  		result = true;
>  
>  	if (result) {
> +		/*
> +		 * This will be NULL if the desc package is embedded in an outer
> +		 * _DSD-equivalent package and its scope cannot be determined.
> +		 */

I think indeed this happens in particular when when references to
non-device nodes; there's no handle because when you get is basically a
dynamically allocated copy of a node.

>  		dn->handle = handle;
>  		dn->data.pointer = desc;
>  		list_add_tail(&dn->sibling, list);
> @@ -245,6 +249,8 @@ static bool acpi_add_nondev_subnodes(acp
>  			 * strings because there is no way to build full
>  			 * pathnames out of them.
>  			 */
> +			acpi_handle_info(scope, "Unknown namespace scope of node %s\n",
> +					 link->package.elements[0].string.pointer);
>  			desc = &link->package.elements[1];
>  			result = acpi_nondev_subnode_extract(desc, NULL, link,
>  							     list, parent);
> @@ -408,6 +414,9 @@ static void acpi_untie_nondev_subnodes(s
>  	struct acpi_data_node *dn;
>  
>  	list_for_each_entry(dn, &data->subnodes, sibling) {
> +		if (!dn->handle)
> +			continue;
> +
>  		acpi_detach_data(dn->handle, acpi_nondev_subnode_tag);
>  
>  		acpi_untie_nondev_subnodes(&dn->data);
> @@ -422,6 +431,9 @@ static bool acpi_tie_nondev_subnodes(str
>  		acpi_status status;
>  		bool ret;
>  
> +		if (!dn->handle)
> +			continue;
> +
>  		status = acpi_attach_data(dn->handle, acpi_nondev_subnode_tag, dn);
>  		if (ACPI_FAILURE(status) && status != AE_ALREADY_EXISTS) {
>  			acpi_handle_err(dn->handle, "Can't tag data node\n");
> 
> 
> 

-- 
Kind regards,

Sakari Ailus

