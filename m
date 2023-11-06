Return-Path: <linux-acpi+bounces-1257-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF8D7E26E2
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 15:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73941281471
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 14:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2905728DA3
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BypBjkzp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EE4241F4;
	Mon,  6 Nov 2023 12:32:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B3AA4;
	Mon,  6 Nov 2023 04:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699273949; x=1730809949;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tlgggN3W4d6dfZnKBFVMDarO3TDJrGS0z905ubna8TY=;
  b=BypBjkzpx0ErWnAA1bNnmgAkpdLYMCobupr0bZpfqXbBcpo9Cv9hqXcp
   RaDiDfvF2sMHDnUs9TDCK7lsbtaAgRMfBaRAi4FCTbEIz5jGM44jLok4w
   frT4ORwQ1YccTm49ORjtwH2c8kC+iEqnJmUyYEjYFbzOZ5SdM68EuGiLK
   SkKf+sEE3WGT1TjndfBsjOTItMI2cUhpLSo+viEeQEmDSzxR765BlVQDK
   P8uiTXUGk2Xf3jqV8BGDm0wgCjR3wpx3sSM+L5prRwBzRZa5XtX0wroRr
   Xnq9HZT/xkHCW9dGvU+glS7VFM0StYFKf3TE0UPX7TiVkW6hYH6+GENRF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="393158894"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="393158894"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 04:32:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="712187400"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="712187400"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 04:32:24 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id B256011F724;
	Mon,  6 Nov 2023 14:32:21 +0200 (EET)
Date: Mon, 6 Nov 2023 12:32:21 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Message-ID: <ZUjc1amZ9YfPwpNZ@kekkonen.localdomain>
References: <20231103070631.1223643-1-sakari.ailus@linux.intel.com>
 <ZUjOEsQSjom4SdOg@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUjOEsQSjom4SdOg@smile.fi.intel.com>

On Mon, Nov 06, 2023 at 01:29:22PM +0200, Andy Shevchenko wrote:
> On Fri, Nov 03, 2023 at 09:06:31AM +0200, Sakari Ailus wrote:
> > Add fwnode_name_eq() to implement the functionality of of_node_name_eq()
> > on fwnode property API. The same convention of ending the comparison at
> > '@' (besides NUL) is applied on also both ACPI and swnode. The function
> > is intended for comparing unit address-less node names on DT and firmware
> > or swnodes compliant with DT bindings.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> I believe I gave already the tag...

I guess I've missed it earlier... Thanks!

-- 
Sakari Ailus

