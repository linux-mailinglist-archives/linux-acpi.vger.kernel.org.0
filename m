Return-Path: <linux-acpi+bounces-1256-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7534E7E21A4
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 13:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308C5280D9D
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 12:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85EE25100
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 12:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k44E0JPg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCFA250F9;
	Mon,  6 Nov 2023 12:32:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B7CAB;
	Mon,  6 Nov 2023 04:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699273920; x=1730809920;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=trKSJFRQ56/vfO4ua26lccDk+qC8F3ce04ec6I2TXcQ=;
  b=k44E0JPgZhHqp69RYmTd+pRUMUwr4/FPNBEfC+RmH3Y4Dadtq9Z+DZpH
   Voemr/eJwycwbOQUNJ6ZGNoo5hqWL6zA9VVaoJ/Prp5/BSMcM/3LR0NHN
   B3oeqFGFxHVPZKbzRVAQMiCVP6u4K03U4J6Wl/EuhQo5XaP+vcK+itPQB
   1VBmE03LZSCtSFYmRslpsQuZO0BLbtejTSfy946EOxLTmU7tQ+r4g+fIv
   029eMYcmywUf4fSZZSpWUEAaBmT78eil9i9RSVJpvOshCHrxXlU/GX0lC
   lwg8uLbY0Dpa47e42m4LtqPGw33YQkkMYu8uCgEP2isVoSAmLFTrBBwAW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="2173673"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="2173673"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 04:31:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="852985262"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="852985262"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 04:31:55 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 53FB511F724;
	Mon,  6 Nov 2023 14:31:53 +0200 (EET)
Date: Mon, 6 Nov 2023 12:31:53 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-acpi@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Subject: Re: [RESEND PATCH v4 1/1] device property: Add fwnode_name_eq()
Message-ID: <ZUjcuc52NRudNola@kekkonen.localdomain>
References: <20231106073141.1250344-1-sakari.ailus@linux.intel.com>
 <2023110623-alongside-credible-833d@gregkh>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023110623-alongside-credible-833d@gregkh>

On Mon, Nov 06, 2023 at 09:45:45AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Nov 06, 2023 at 09:31:41AM +0200, Sakari Ailus wrote:
> > Add fwnode_name_eq() to implement the functionality of of_node_name_eq()
> > on fwnode property API. The same convention of ending the comparison at
> > '@' (besides NUL) is applied on also both ACPI and swnode. The function
> > is intended for comparing unit address-less node names on DT and firmware
> > or swnodes compliant with DT bindings.
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> > ---
> > Hi Greg,
> > 
> > Could we merge this via the media tree?
> 
> For 6.8-rc1?  Sure, feel free to:
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Yes, 6.8-rc1 is the target. Thanks!

-- 
Sakari Ailus

