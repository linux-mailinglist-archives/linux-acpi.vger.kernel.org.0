Return-Path: <linux-acpi+bounces-19712-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6981CD0030
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 14:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 847C8308A38A
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 13:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B68B2EF646;
	Fri, 19 Dec 2025 13:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q7P0ZyJl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D631A254E;
	Fri, 19 Dec 2025 13:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766150023; cv=none; b=a1DxpYdUqq9llIqaWWEvUNxJPEZsE6nkA8S1ULT5lcKU3buFdyJ3xPHfh0l2tIBMj0uL3ukE5191fFvg0yToPh5hhRiPpw8C0GyKZIENwijedPSfwWjnZNWmJsQD4cfSjXxBcQAIyps9d2MR5DIF8FacEawflIIfIQIuCPOrxP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766150023; c=relaxed/simple;
	bh=jqI/RPyO1rh+Pm0hKPIxm8bbSMvGFhlsfehRbazn0HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoiJKQfxI5TVIxW9Y34ElfgfJZkpUnMGyXLegY06suctYlcwMR9rbWXj/8yQIJ5YSHTYfVjmQhqAdghRKq+NjxoxQTQLWmnLXcSXog5EA6ECcd064JlXivcKVk6SlGHx6tT9EGLMDARj4fmTEoDDZxsoA5OIUmMPynMKIhZORHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q7P0ZyJl; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766150021; x=1797686021;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jqI/RPyO1rh+Pm0hKPIxm8bbSMvGFhlsfehRbazn0HA=;
  b=Q7P0ZyJlHX33RD8kQ3U0jdpxVfK7N8IK7dD7anNoNYMJVlPJzCLBQ3p8
   g0mkrm2lLdlJGDjxuUQZy7z+KQZ5FUhiXSbAFynlRn1WlAdEgUO489tMl
   Gs0WT9vmfTSfTigK9ZAyXvJGH7uforGe/NbL8/sOBNgQHhR0OtP4P54Ce
   wkuclQpWYzbE69dlgiCjJbb0/yC6k6m/DCWqGBGfvV0Bfril/aX09EG0+
   Tj06c8EMTPUeSieA4kY6wrN4x08qhcjqdh04P1cqlDGHQDCtOQeveVD1q
   OcrrybeO6WaPa4dZdHBvlm/Xp7g9rCudmdOTzbf8KeykD6NuquZXxZgtj
   g==;
X-CSE-ConnectionGUID: lSKZ/WrLT6i/U3NoASPJ9A==
X-CSE-MsgGUID: 2Fjsewu4SoqabJfcR+dwrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="71955664"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="71955664"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 05:13:40 -0800
X-CSE-ConnectionGUID: UHvncvahR5+5Eo0n+m3GQw==
X-CSE-MsgGUID: XEUiQEhuRdOkVkRzT5wmXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="198620554"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO mdjait-mobl) ([10.245.245.34])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 05:13:37 -0800
Date: Fri, 19 Dec 2025 14:13:27 +0100
From: Mehdi Djait <mehdi.djait@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, linux-acpi@vger.kernel.org, Kenneth Crudup <kenny@panix.com>, 
	linux-media@vger.kernel.org, johannes.goede@oss.qualcomm.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 1/1] software node: Also support referencing non-constant
 software nodes
Message-ID: <erf3c6r46lscxeqj3iqc24rkzpuuwrdhob7isva523pxtxtoy4@45gxuhkdbubx>
References: <af773b82-bef2-4209-baaf-526d4661b7fc@panix.com>
 <20251219083638.2454138-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219083638.2454138-1-sakari.ailus@linux.intel.com>

Hi Sakari,

Thank you for the patch.

On Fri, Dec 19, 2025 at 10:36:38AM +0200, Sakari Ailus wrote:
> Fwnode references are be implemented differently if referenced node is a
> software node. _Generic() is used to differentiate between the two cases
> but only const software nodes were present in the selection. Also add
> non-const software nodes.
> 

it works for me.

Tested-by: Mehdi Djait <mehdi.djait@linux.intel.com> # Dell XPS 9315
Reviewed-by: Mehdi Djait <mehdi.djait@linux.intel.com>

> Reported-by: Kenneth Crudup <kenny@panix.com>
> Closes: https://lore.kernel.org/all/af773b82-bef2-4209-baaf-526d4661b7fc@panix.com/
> Fixes: d7cdbbc93c56 ("software node: allow referencing firmware nodes")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

