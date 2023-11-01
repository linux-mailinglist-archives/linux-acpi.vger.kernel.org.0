Return-Path: <linux-acpi+bounces-1136-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F247DDF7A
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 11:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5CA82802AB
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 10:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6421B11187
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 10:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KlUp3GNS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A00DDA4;
	Wed,  1 Nov 2023 10:09:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30377D79;
	Wed,  1 Nov 2023 03:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698833258; x=1730369258;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/G6YHPcZjKp/CrBMDSSrt2epiYSXFZcrqUWw6QsDyWY=;
  b=KlUp3GNSt7hjbcSsGg8e016t9dyBOk6rqhBFosZgXyTliaXQjhJMOSD6
   I4UftPMPKo/yuCTWvreQlUBq0fl1ZYKYIbnMacGpd56kOT1qFnW02eNXx
   ZyhuFos+ub2Gjhn49hGcB3i7avBEI06sBrdLaVnYbnWW7sIOD/RkvGwlw
   1gZKiG41MTzvLahKw4skJcwPnaFWQvcPGveDG2rbwTRv0dvdmYTxhr4dj
   1jyGEji8nV+oBGwhqlPuECPokwMrdvrR0asSxFJNDzw9V3KoiGJYj6+PJ
   9vDrb3giAAVl43oz53LF979tM1DrEgbHGnAq2Pp00uBzVNSry2XDMX849
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="452756082"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="452756082"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 03:07:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="851533391"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="851533391"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 03:07:33 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id F006C1207A3;
	Wed,  1 Nov 2023 12:00:15 +0200 (EET)
Date: Wed, 1 Nov 2023 10:00:15 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org,
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
	linux-mediatek@lists.infradead.org, rafael@kernel.org
Subject: Re: [PATCH v2 1/1] device property: Add fwnode_name_eq()
Message-ID: <ZUIhr1Wiy96PMEKx@kekkonen.localdomain>
References: <20231101072729.1142578-1-sakari.ailus@linux.intel.com>
 <ZUIfSIWze4llNJfd@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUIfSIWze4llNJfd@smile.fi.intel.com>

On Wed, Nov 01, 2023 at 11:50:00AM +0200, Andy Shevchenko wrote:
> On Wed, Nov 01, 2023 at 09:27:29AM +0200, Sakari Ailus wrote:
> > Add fwnode_name_eq() to implement the functionality of of_node_name_eq()
> > on fwnode property API. The same convention of ending the comparison at
> > '@' (besides '\0') is applied on also both ACPI and swnode. The function
> > is intended for comparing unit address-less node names on DT and firmware
> > or swnodes compliant with DT bindings.
> 
> ...
> 
> > - Use size_t type for len.
> 
> Strictly speaking it should be ptrdiff_t according to the code.

It'll be compared to size_t right after. ptrdiff_t is signed and we know we
have a positive number here so size_t seems like a better choice.

> 
> ...
> 
> > + * the comparison to either '\0' or '@' character
> 
> NUL is a human-readable substitution to less parsable '\0'.

I can send v3 with that but I'll wait a bit if there are more comments.

-- 
Sakari Ailus

