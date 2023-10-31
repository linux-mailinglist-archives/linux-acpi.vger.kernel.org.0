Return-Path: <linux-acpi+bounces-1106-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D98AB7DCAF8
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Oct 2023 11:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 167EA1C20B93
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Oct 2023 10:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BCE199A9
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Oct 2023 10:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LnXaAQV3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5730615CA
	for <linux-acpi@vger.kernel.org>; Tue, 31 Oct 2023 08:48:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8110EDE;
	Tue, 31 Oct 2023 01:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698742078; x=1730278078;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uXkV3vl3hug9NMYxNH3bPgLYMhjDGNYVTPifMu6ZOfk=;
  b=LnXaAQV3IAiYOa4BKNU3b60spvR1ujDl/N8eUbOpDHGoHZpJnyVIrTG5
   xiWRCBoHGurl5i+YCFnAG7C7Tm+fVB9t4GucrQYjhPXI6fCd5WN6EQgo1
   x3kSpoOrtVJFuTmr1E7GfCI6CMdqrQnAiT9vqi42UTtR2W5cB3KbP96lX
   rgmbhangmlVUnXwQCstdx8BDkSerYW8t16dSGB7qExfOJV6Bl3tGymdwI
   LzZwnPQ1dL7XsK8MikNXVyp4QulhDUDjbxOpzG+nR42RXv/EAOYrfZ1Px
   8J10jl9INg7qgzCE5bUuY7WLFtp2TNw2Pzz+ggXxDukKG0tTT0StRxBDp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="388061239"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="388061239"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 01:47:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="754068685"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="754068685"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 01:47:56 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id C627011F894;
	Tue, 31 Oct 2023 10:47:53 +0200 (EET)
Date: Tue, 31 Oct 2023 08:47:53 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] ACPI: scan: Extract CSI-2 connection graph from
 _CRS
Message-ID: <ZUC_OQwk_dwNYU_N@kekkonen.localdomain>
References: <2187487.irdbgypaU6@kreacher>
 <3288922.44csPzL39Z@kreacher>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3288922.44csPzL39Z@kreacher>

Hi Rafael,

On Fri, Oct 20, 2023 at 04:36:28PM +0200, Rafael J. Wysocki wrote:
> +#define NO_CSI2_PORT (UINT_MAX - 1)
> +
> +static void alloc_crs_csi2_swnodes(struct crs_csi2 *csi2)
> +{
> +	size_t port_count = csi2->port_count;
> +	struct acpi_device_software_nodes *swnodes;
> +	size_t alloc_size;
> +	unsigned int i;
> +
> +	/*
> +	 * Allocate memory for ports, node pointers (number of nodes +
> +	 * 1 (guardian), nodes (root + number of ports * 2 (because for
> +	 * every port there is an endpoint)).
> +	 */
> +	if (check_mul_overflow(sizeof(*swnodes->ports) +
> +			       sizeof(*swnodes->nodes) * 2 +
> +			       sizeof(*swnodes->nodeptrs) * 2,
> +			       port_count, &alloc_size))
> +		goto overflow;
> +
> +	if (check_add_overflow(sizeof(*swnodes) +
> +			       sizeof(*swnodes->nodes) +
> +			       sizeof(*swnodes->nodeptrs) * 2,
> +			       alloc_size, &alloc_size))
> +		goto overflow;
> +
> +	swnodes = kmalloc(alloc_size, GFP_KERNEL);
> +	if (!swnodes)
> +		return;
> +
> +	swnodes->ports = (struct acpi_device_software_node_port *)(swnodes + 1);
> +	swnodes->nodes = (struct software_node *)(swnodes->ports + port_count);
> +	swnodes->nodeptrs = (const struct software_node **)(swnodes->nodes + 1 +
> +				2 * port_count);
> +	swnodes->num_ports = port_count;
> +
> +	for (i = 0; i < 2 * port_count + 1; i++)
> +		swnodes->nodeptrs[i] = &swnodes->nodes[i];
> +
> +	swnodes->nodeptrs[i] = NULL;
> +
> +	for (i = 0; i < port_count; i++)
> +		swnodes->ports[i].port_nr = NO_CSI2_PORT;
> +
> +	csi2->swnodes = swnodes;
> +	return;
> +
> +overflow:
> +	acpi_handle_info(csi2->handle, "too many _CRS CSI-2 resource handles (%zu)",
> +			 port_count);

I'd move this to where the conditions are, they can be merged.

-- 
Regards,

Sakari Ailus

