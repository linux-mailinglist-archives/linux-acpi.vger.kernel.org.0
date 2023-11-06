Return-Path: <linux-acpi+bounces-1252-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAAA7E219B
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 13:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58BD2280D9D
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 12:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117E4200B2
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 12:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LNFB0DSQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F3F199A1;
	Mon,  6 Nov 2023 11:29:31 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3043BB;
	Mon,  6 Nov 2023 03:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699270170; x=1730806170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dVbgGjQlfi/ag2GwhO/7mrluIesj2NDfOw+Ao81CCzM=;
  b=LNFB0DSQAY5z8PBu1ya2aw1pjbI3+BXOrd/i4jmjgm+CgbGcZ/UPHGf4
   2xmsADEfoolGvIKzoPNFwWRnxx38AeZhV4ETJ6Y97498ienrjmU8YIO+s
   78D+JCde5iqKNsqvaXt7TGVCpuABNTkmGPsgMLSC/z36zLqxiZj14CB8L
   csIn95LzcuU5kodBqsVIpsXO1GIMcp5Uw+vmsgR1theE/NXGlQK3LiWM/
   zTEp+0MXwUkOk0aPMuCkEVROweNNZ7WdC/Gu7b5+5lrCasPZGQggTrxrj
   3MU/VeaTVHA8NMIFnZgR1VkNRzBrlANowkvnWCmByvOivvW+KUN8XNaYY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="386431930"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="386431930"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 03:29:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="762294686"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="762294686"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 03:29:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qzxnH-0000000BmAW-0nCG;
	Mon, 06 Nov 2023 13:29:23 +0200
Date: Mon, 6 Nov 2023 13:29:22 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-media@vger.kernel.org,
	Paul Elder <paul.elder@ideasonboard.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Julien Stephan <jstephan@baylibre.com>, devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4 1/1] device property: Add fwnode_name_eq()
Message-ID: <ZUjOEsQSjom4SdOg@smile.fi.intel.com>
References: <20231103070631.1223643-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103070631.1223643-1-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Nov 03, 2023 at 09:06:31AM +0200, Sakari Ailus wrote:
> Add fwnode_name_eq() to implement the functionality of of_node_name_eq()
> on fwnode property API. The same convention of ending the comparison at
> '@' (besides NUL) is applied on also both ACPI and swnode. The function
> is intended for comparing unit address-less node names on DT and firmware
> or swnodes compliant with DT bindings.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I believe I gave already the tag...

-- 
With Best Regards,
Andy Shevchenko



