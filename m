Return-Path: <linux-acpi+bounces-21312-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEm1AXv+pmk7bgAAu9opvQ
	(envelope-from <linux-acpi+bounces-21312-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Mar 2026 16:30:03 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 409F11F2A43
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Mar 2026 16:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92E03305B95A
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Mar 2026 15:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F27481FA6;
	Tue,  3 Mar 2026 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g2lKT83P"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67814423175;
	Tue,  3 Mar 2026 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772551480; cv=none; b=G2yhSBmBykhXkJ/WADRSzsrTEd0rlpV7VNykf5oFDGhlFZvpJrFRjj/mcYHBYFR71I71Up5Zg3v9Qn85wVgDBHaXwVFBIuw9mbqAN5o7fVtKoe0ggLkHPF+njwf/uNIJJ7vBbSgbjSlVCRECTBlkqkYoLFLgpMpbk0MR4lx3o0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772551480; c=relaxed/simple;
	bh=ezIjOizC8RAT3P5qFtSymLpkn/IPMdhnAN93KcIKjO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxwCw/V3L3WL5bP8x+KQaF700SmT4y7MJTavj/5RcFrRo/lLgwf3wj51xRiEfteu6P9seotXxJIPQty+fb/dizFl70RwAz9Hrq93VUQ6NJ+KEMLU+XjJUt5lpc/Mcupq0KZtOl3fkmCRKw/1+cQ9QYTcY0YKangN3OsvXFaLkQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g2lKT83P; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772551479; x=1804087479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ezIjOizC8RAT3P5qFtSymLpkn/IPMdhnAN93KcIKjO8=;
  b=g2lKT83PCVDXdE/G1YlMMkkjIjJTI4SKcJyJYnBsc1VNm2dXL/VN/Zk2
   lrtowPuerKv5i+UF0PagWc/6uFJI8RDqIvm/tpvufhahuM+lO19DD+dBb
   mFmyzRT3FLICbmEjps6kb0cwYV25JZ6Qn7x+l+2uoxChuI4aHwUkZCM/L
   aE6Sv7c+fy64QjAF+AoLXCO8cdp3op88BgyjeKPxsVFlBb47cZLPHcLbf
   JcqIQ5LfPNqRcHMGuBiWouQi8/+7NQZH1NNprgM6KFLDFoJhYpKadpe0B
   iN+GqlYZ5JMmw55z9MEj1DYNHexlddlah8iEr9bX2zqyjd6a3IiWTeBtF
   A==;
X-CSE-ConnectionGUID: xGE6+JdZQXyak+SI9MqpCQ==
X-CSE-MsgGUID: m5NTSEq/SXy6lmorKSnlTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="73505063"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="73505063"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 07:24:38 -0800
X-CSE-ConnectionGUID: 8EDCa8VCSnelhlWlG1ZesA==
X-CSE-MsgGUID: 5BGaqm/dSdmyx5dAFD99/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="217269195"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.32])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 07:24:25 -0800
Date: Tue, 3 Mar 2026 17:24:22 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Kalle Niemi <kaleposti@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>, Arnd Bergmann <arnd@arndb.de>,
	Saravana Kannan <saravanak@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Linus Walleij <linusw@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mark Brown <broonie@kernel.org>, Len Brown <lenb@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Shawn Guo <shawnguo@kernel.org>, Wolfram Sang <wsa@kernel.org>,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
	linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 07/28] driver core: fw_devlink: Introduce
 fw_devlink_set_device()
Message-ID: <aab9Js6nRaeH3pn9@ashevche-desk.local>
References: <20260227135428.783983-1-herve.codina@bootlin.com>
 <20260227135428.783983-8-herve.codina@bootlin.com>
 <20260302122336.00006bd8@huawei.com>
 <20260303151210.6e8462b8@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303151210.6e8462b8@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 409F11F2A43
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[huawei.com,lunn.ch,kernel.org,glider.be,gmail.com,linuxfoundation.org,nxp.com,pengutronix.de,baylibre.com,sang-engineering.com,axentia.se,arndb.de,google.com,opensource.cirrus.com,cirrus.com,linaro.org,linux.intel.com,stgolabs.net,intel.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,microchip.com,bootlin.com];
	TAGGED_FROM(0.00)[bounces-21312-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[62];
	TAGGED_RCPT(0.00)[linux-acpi,dt,renesas];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,huawei.com:email,bootlin.com:email,ashevche-desk.local:mid]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 03:12:10PM +0100, Herve Codina wrote:
> On Mon, 2 Mar 2026 12:23:36 +0000
> Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
> > On Fri, 27 Feb 2026 14:54:04 +0100
> > Herve Codina <herve.codina@bootlin.com> wrote:
> > 
> > > Setting fwnode->dev is specific to fw_devlink.
> > > 
> > > In order to avoid having a direct 'fwnode->dev = dev;' in several
> > > place in the kernel, introduce fw_devlink_set_device() helper to perform
> > > this operation.
> > >   
> > I don't mind the helper, but the description could do with a little
> > detail on why.  Is it just to avoid visibility of internal details, or
> > is there a stronger reason?
> 
> I think the idea was to avoid visibility.
> 
> It cames from feedback received on my first iteration
>   https://lore.kernel.org/all/20250408145139.293c79a2@bootlin.com/
> 
> I found the idea relevant and so I did the patch.

Yes, the idea is to hide the fwnode devlink related stuff behind the getters
and setters. Ideally, everything in fwnode_handle related to devlinks should
be marked as __private.

-- 
With Best Regards,
Andy Shevchenko



