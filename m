Return-Path: <linux-acpi+bounces-17059-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3820B7C85C
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 14:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44073A6AC4
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 07:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A0B265CA8;
	Wed, 17 Sep 2025 07:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XoHjjq4I"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90C02AD3E
	for <linux-acpi@vger.kernel.org>; Wed, 17 Sep 2025 07:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758093469; cv=none; b=i9A9meaXDyir8qXKU7PuG31uH8nKlzQhH7T7QC0HgqCtdkNmurgPQp8Ym6OKJh7WhomQuGIrihELesWULUtBo7gvFV9i9ZePuiQBkeVu7DAJAP8Lg1/GnCetScnErpgJP0dJ8UFpuOsp5b8Ux88wKcTow40dD9+csHu90x1phQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758093469; c=relaxed/simple;
	bh=JA9cq18FaLBNmjruk7+at+PWNB0M3EBQ0DIgBUU7zfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtpmXukOjOq0B2wLM1YphJuGfJiOr9ZdTIcDef98TcyHopN26cKgDrQlNLpq+KeZOCDuk3vm7VH4bhAsbpc2JXQ6mM0NhPqHlOj9lwjSHotmWQLg2uD1FCZIo19wXZqN36EPY0KFHIeqGR+Ux70OXu3q9hqu8v3nfDrmx6Y2748=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XoHjjq4I; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758093468; x=1789629468;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JA9cq18FaLBNmjruk7+at+PWNB0M3EBQ0DIgBUU7zfA=;
  b=XoHjjq4IA6nNvSYPRrfjOTjoMp0YusPScGE06F6H8aSzrzvU2RjqbAKe
   NvKb0eJImMe1yJY33HBpwXvizaSF4yhky+IsPA2YjKgX6c1rMnqHFL7lE
   +GfInycV3wrTatU+nD4dzx/Hbm9s/m3TVvE5/svDs9Psc0IqDuJTplbng
   L4bu9cJ2REE2IeZ+V0VuoV7aAqXeZe2WL0ZdspQA0/N6TOrSLPcBPV+QU
   eq3SZrb5w7PBnmca5T9JTL7JVS9UmWl0HvXDnC+fgx8Mclpz0iPuFi23S
   hD91SWB2Org5Vd6gLI0YYp8KJUGOzh2jAIAdBAMQFYWrzBxLxM2N2ttFa
   A==;
X-CSE-ConnectionGUID: 32ODSIIYRoKc3+f2vi12Aw==
X-CSE-MsgGUID: 5JXap7xmTLC/HkH16d3nAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="60454557"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="60454557"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:17:47 -0700
X-CSE-ConnectionGUID: Yp6AnSqcRkC6L2YYZBoTFQ==
X-CSE-MsgGUID: CWk8oPAwT+Ke8B0Hq6gWcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="212323001"
Received: from smile.fi.intel.com ([10.237.72.51])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:17:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uymQA-00000003jq5-2nVe;
	Wed, 17 Sep 2025 10:17:42 +0300
Date: Wed, 17 Sep 2025 10:17:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 01/14] ACPI: property: Use ACPI functions in
 acpi_graph_get_next_endpoint() only
Message-ID: <aMpgltQIdbLKZRv0@smile.fi.intel.com>
References: <20250916160129.3955410-1-sakari.ailus@linux.intel.com>
 <20250916160129.3955410-2-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916160129.3955410-2-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 16, 2025 at 07:01:16PM +0300, Sakari Ailus wrote:
> Calling fwnode_get_next_child_node() in ACPI implementation of the fwnode
> property API is somewhat problematic as the latter is used in the
> impelementation of the former. Instead of using
> fwnode_get_next_child_node() in acpi_graph_get_next_endpoint(), call
> acpi_get_next_subnode() directly instead.

...

> -	endpoint = fwnode_get_next_child_node(port, prev);
> +	endpoint = acpi_get_next_subnode(port, prev);
>  	while (!endpoint) {
> -		port = fwnode_get_next_child_node(fwnode, port);
> +		port = acpi_get_next_subnode(fwnode, port);
>  		if (!port)
>  			break;
>  		if (is_acpi_graph_node(port, "port"))
> -			endpoint = fwnode_get_next_child_node(port, NULL);
> +			endpoint = acpi_get_next_subnode(port, NULL);
>  	}

Can this be refactored to

	do {
		endpoint = acpi_get_next_subnode(port, prev);
		if (endpoint)
			break;

		port = acpi_get_next_subnode(fwnode, port);
		if (is_acpi_graph_node(port, "port"))
			prev = NULL;
	} while (port);

(but it might be a material for further cleanups)?

-- 
With Best Regards,
Andy Shevchenko



