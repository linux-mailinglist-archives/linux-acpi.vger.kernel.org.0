Return-Path: <linux-acpi+bounces-20349-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7D2D21359
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 21:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F05EF3030DBF
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 20:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8F92DEA68;
	Wed, 14 Jan 2026 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OItHARgI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5CB1373
	for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768423557; cv=none; b=L2MI1hbRcbVSHy7cwoq4udQTM/3cvJ05VqUWR5WZ2zmbsFHNbBZfRzdJ8eGccgICdPHJGdZ8bsrrVYJi3R94vPG+3IA47u2eFTrvPQSs7sVT+2Lil9lgemOEZgMggEiMvh1eItc+dXyx83HprnMKcCb4UKyFXsHTjgcxZLh1ZSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768423557; c=relaxed/simple;
	bh=ySq77G2UGDTwO/aW/4jiBWkfMf63RGdBV5p4dv8noQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGNQNVxOMa+9e4yYXvliq5+otColaiCW3BguiRRD7AqzDEwqOJHwOEJZwsYj39/PBZxhK+RzhUW9ej/ZVirfJZrM7WGojY3NQZzEFTRL0TtWuMUdlY9ibg+QQfEXlqJSilm77f/nNgP6GfgIXex2I6uKmGlB5h54n6PhpuztY+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OItHARgI; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768423556; x=1799959556;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ySq77G2UGDTwO/aW/4jiBWkfMf63RGdBV5p4dv8noQA=;
  b=OItHARgIVbvalWHJdZWT4zFPDBtMK+GAKlZFoCJe3k7xorcRNpx6tLY3
   2yz4EZdKOPs+LR6m8iec6s6nt/n2sAxF1XSEI5dLBBfIU33EXooPuBXOT
   io/CPJ8/tCO7eoBGN1BMqhNepSoIkf7uN5cPe9udbLvVmgCw6EMfgjLD2
   cBjKVToX/LlYJ93NaWmPX6k+CB3nyD7uQfQIT+eiJRSr1va8nO4hSffhl
   4rRz5DqUNvMhDekPVj9+PkDTxHSIlDg9zX1rbR02FWG2vTqmkEfQaQH/L
   CfUww5LP8XrbrGg7oUZvKao5wa53KAUTj1kV/Ot6jcdxO5BDxt+7ExX68
   g==;
X-CSE-ConnectionGUID: 8QlWhZ4gTn6EqW++qnOgNw==
X-CSE-MsgGUID: 97kd0dyqSG2l6I/FprCOtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="80377138"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="80377138"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 12:45:55 -0800
X-CSE-ConnectionGUID: JjYveOiIRAOwBhkFA1GvRQ==
X-CSE-MsgGUID: g1bKBnerRVKTqevG89u3pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="209821885"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 12:45:53 -0800
Date: Wed, 14 Jan 2026 22:45:50 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-acpi@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [Question] Best practice for ACPI representation of
 DPLL/Ethernet dependencies (SyncE)
Message-ID: <aWgAfsycBDc0mlFv@smile.fi.intel.com>
References: <3bf214b9-8691-44f7-aa13-8169276a6c2b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3bf214b9-8691-44f7-aa13-8169276a6c2b@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 14, 2026 at 08:19:05PM +0100, Ivan Vecera wrote:

> I would like to ask for your opinion regarding an ACPI implementation
> detail for a patch-set I currently have on the netdev mailing list [1].
> 
> The patch-set adds support for modeling the relationship between a DPLL
> device (provider) and an Ethernet controller/PHY (consumer) to support
> SyncE (Synchronous Ethernet). The topology requires the Ethernet
> controller/PHY to reference specific pins (sub-nodes) of the DPLL
> device.
> 
> Although the target driver (ice) in the patch-set is primarily used in
> ACPI environments, I aimed for a firmware-agnostic approach using the
> fwnode API.
> 
> Provider (DPLL):
> The DPLL device uses _DSD properties mirroring the definition in the DT
> bindings [2]. The pins are represented as sub-nodes. ACPI example [3].
> 
> Consumer (Ethernet):
> I defined a new DT schema for the consumer using properties dpll-pins
> nd dpll-pin-names. And in ACPI, I intend to use hierarchical data
> extension (_DSD) to reference the DPLL pin sub-nodes from the Ethernet
> controller package [4], effectively mirroring the DT phandle referencing
> mechanism.
> 
> Question:
> Is reusing the DT binding definitions within ACPI _DSD (to allow unified
> fwnode property parsing) the recommended approach for this type of
> device relationship?

TL;DR: Seems to me you are pretty much doing an ugly hack and yes, you violate
the existing ACPI resources. More details below.

> Or should I define strictly ACPI-specific bindings/objects, considering
> that the DT bindings for this feature are also new and currently under
> review?
> 
> I want to ensure I am not violating any ACPI abstraction layers by
> relying too heavily on the DT-style representation in _DSD.
> 
> Thanks for your guidance.

First of all, if I understood the HW topology right — it has an I²C muxer
which has a channel connected to DPLL, which among other functions provides
some kind of GPIO/pin muxing facility — (correct me, if I'm wrong), the
irrelevant to ACPI hack is an avoidance of having proper GPIO controller
driver / description provided with likely pin control and pin muxing
flavours, which is missing (hence drivers/pinctrl/... should be and it should
be described in DT).

Second, ACPI provides the _CRS resources specifically for pin configuration,
pin control (pin muxing as well). In case it's related those resources must
be used. The caveat, however, the Linux kernel has not yet implemented the
glue layer between ACPICA and pin control subsystem (see [5] for more).

It might be that I didn't get the picture correctly, but it smells badly to me.
In any case, I would like to help you and I'm open to more details about this
case.

> [1]
> https://patchwork.kernel.org/project/netdevbpf/list/?series=1040080&state=*
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dpll
> [3] https://github.com/ivecera/zl3073x-acpi/blob/main/sample1.asl
> [4] https://github.com/ivecera/zl3073x-acpi/blob/main/dpllnic.asl

[5]: https://lore.kernel.org/r/20221130164027.682898-1-niyas.sait@linaro.org

-- 
With Best Regards,
Andy Shevchenko



