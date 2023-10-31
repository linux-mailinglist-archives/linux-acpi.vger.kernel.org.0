Return-Path: <linux-acpi+bounces-1116-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D887DD1B0
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Oct 2023 17:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EF311C20AA7
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Oct 2023 16:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F662030F
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Oct 2023 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GPMB20yu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675EC20319;
	Tue, 31 Oct 2023 16:32:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796BB1BCF;
	Tue, 31 Oct 2023 09:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698769946; x=1730305946;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SAVUUSy6kEq+VaAk+hGdPRfOn1rye2cEo6cJ7P/cJ4A=;
  b=GPMB20yuZylvzt4o/x+pzUgHbVNn8NySAwxBhoUgJxev10vH678C/bSJ
   1XsJIVBbyu9EZNvub8kIWOxJi/iJGKDUXgFB5qtJU3dyKC2o4F5bj0uAa
   qFgyP/mSvheVBnQbOyhuSUEGDLGEQ7uFCJFOkCCFHw3fDBFtQMC18g43Y
   UXaJQ+18S/+f/5xmv/1v7cnlqeDhumbk0PQhUWw9mMHX5OSmFC9iF6GIs
   vPxghSIcmbolfLh7eCJzSTqIvYKo1XK2nXyEe555YLuBMMzkwk1vRqcS1
   cyNOiJLFjMt94UbiuZ0L55ltiJA5ioJPZ0CI04XcxW23E/r+RxlhkS1y7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="1172522"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="1172522"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 09:32:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="851293283"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="851293283"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 09:32:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qxrf8-0000000ACil-13uQ;
	Tue, 31 Oct 2023 18:32:18 +0200
Date: Tue, 31 Oct 2023 18:32:17 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
	Paul Elder <paul.elder@ideasonboard.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Julien Stephan <jstephan@baylibre.com>, devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/1] device property: Add fwnode_name_eq()
Message-ID: <ZUEsEQQTTlXmOHPt@smile.fi.intel.com>
References: <20231031135306.1106640-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031135306.1106640-1-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Oct 31, 2023 at 03:53:06PM +0200, Sakari Ailus wrote:
> Add fwnode_name_eq() to implement the functionality of of_node_name_eq()
> on fwnode property API. The same convention of ending the comparison at
> '@' (besides '\0') is applied on also both ACPI and swnode. The function
> is intended for comparing unit address-less node names on DT and firmware
> or swnodes compliant with DT bindings.

Some comments below.

...

> Would you be able to use this to replace of_node_name_eq()?

Can you point out to the use case? Maybe it can be rewritten using existing
APIs?

...

> +	len = strchrnul(node_name, '@') - node_name;

> +	return strlen(name) == len && !strncmp(node_name, name, len);

Seems like this is reimplementation of str_has_prefix().

	len = strchrnul(node_name, '@') - node_name;
	return str_has_prefix(node_name, name) == len;

-- 
With Best Regards,
Andy Shevchenko



