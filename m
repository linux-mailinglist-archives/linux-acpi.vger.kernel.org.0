Return-Path: <linux-acpi+bounces-1349-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8B37E5202
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Nov 2023 09:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6CE280FE1
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Nov 2023 08:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37832DDA2
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Nov 2023 08:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gMEiJPnG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FC5D50C
	for <linux-acpi@vger.kernel.org>; Wed,  8 Nov 2023 07:37:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB7FAF
	for <linux-acpi@vger.kernel.org>; Tue,  7 Nov 2023 23:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699429035; x=1730965035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x/raDEBbRkXnOAEXPzYOnMKk4JozzaBVvftuLz/c7aY=;
  b=gMEiJPnGTi2IwSDoaP+xY4gYCES4n0GA7rMMUoTm1UINyLcQogRaedrW
   2H8JJ3YlmPpd9DxG+p58FQJswTB3U4ClrPA/YrS2lPx+BK62Pzvj5cDQz
   HnefFAK2hvOunqrqopY3HiRCQn9TnVJ3I5xxzzwV3+g+kZSWkwRN9fK8k
   pLJfSTVlWGluqZRPv5R3aQzZE0aGYZHHX39jaH+CPbfB4jrX4s1mnzdl3
   ukWQi43vQzPyaR4nKTBVMqk4OJDhAf3Sx6OWF7A+6iz9LW7sWj9K3fZ/Y
   yiKkVJ6jTAuSFIa1Q4OXxFe7K9mnEZfTw4+FhCEGrpX1CAp7wcNP3mJh7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="392577976"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="392577976"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 23:37:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="886582641"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="886582641"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga004.jf.intel.com with SMTP; 07 Nov 2023 23:37:08 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 08 Nov 2023 09:37:07 +0200
Date: Wed, 8 Nov 2023 09:37:07 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, andriy.shevchenko@linux.intel.com,
	Daniel Scally <djrscally@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 3/3] device property:
 fwnode_property_get_reference_args allows NULL args now
Message-ID: <ZUs6o3hovkAjHMcV@kuha.fi.intel.com>
References: <20231103083625.1229008-1-sakari.ailus@linux.intel.com>
 <20231103083625.1229008-4-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103083625.1229008-4-sakari.ailus@linux.intel.com>

On Fri, Nov 03, 2023 at 10:36:25AM +0200, Sakari Ailus wrote:
> All three fwnode_property_get_reference_args() implemantations now allow
> args argument to be NULL. Document this.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/base/property.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 8c40abed7852..8667b13639d2 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -508,6 +508,7 @@ EXPORT_SYMBOL_GPL(fwnode_property_match_string);
>   * @nargs:	Number of arguments. Ignored if @nargs_prop is non-NULL.
>   * @index:	Index of the reference, from zero onwards.
>   * @args:	Result structure with reference and integer arguments.
> + *		May be NULL.
>   *
>   * Obtain a reference based on a named property in an fwnode, with
>   * integer arguments.
> -- 
> 2.39.2

-- 
heikki

