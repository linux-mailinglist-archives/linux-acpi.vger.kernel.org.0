Return-Path: <linux-acpi+bounces-1137-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 997F77DDF7B
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 11:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A802804DD
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 10:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06121111A0
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 10:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hj1rc27W"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6510629AB
	for <linux-acpi@vger.kernel.org>; Wed,  1 Nov 2023 10:11:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149EDE4
	for <linux-acpi@vger.kernel.org>; Wed,  1 Nov 2023 03:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698833472; x=1730369472;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1HikYpY5bDw6J9sTp/tKibCTtaIii/z95pWn/L9EKtk=;
  b=Hj1rc27W9rg+RyprpjnqvxsEJW5iOnoksMy8pKo10UXbaxiUsSoj9yh+
   HtHiil9VyXpQESsaMfVVN+ogz/s9z7QDsgWsOPzZmiye3zFQWVu+u035N
   ms0iEUy9mB+bNKTJoF+ZW5h2WW1MCFfSho8u0xdGfZVd4eFcJjCctgaLJ
   RK//q+HqgWLTXjoNQkF1rNHr0QjMunUMshxbFaGP+JmkHtahK9TtU5CLB
   N8pIUFPTBz2X7vLk6N3lpECE6ADNoiEv8nve9p2YMasLDOgQyMcYg2OZv
   XARs8BbOs1InQUTYkdlB0RmoHFSE1Jxqs2rF1RJJVnLzelRFIXbiTQV77
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="367815905"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="367815905"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 03:11:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="884517540"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="884517540"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 03:11:09 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id F0A6C1207A3;
	Wed,  1 Nov 2023 12:11:06 +0200 (EET)
Date: Wed, 1 Nov 2023 10:11:06 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/3] Make fwnode_property_get_reference_args accept NULL
 args
Message-ID: <ZUIkOov2eykf0n1v@kekkonen.localdomain>
References: <20231101090737.1148303-1-sakari.ailus@linux.intel.com>
 <ZUIfp43KYDvpdife@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUIfp43KYDvpdife@smile.fi.intel.com>

On Wed, Nov 01, 2023 at 11:51:35AM +0200, Andy Shevchenko wrote:
> On Wed, Nov 01, 2023 at 11:07:34AM +0200, Sakari Ailus wrote:
> > Hi all,
> > 
> > The of_parse_phandle_with_args() accepts NULL args but
> > fwnode_property_get_reference_args() does not currently, in its ACPI or
> > software node implementations. Fix this.
> 
> The last sentence assumes Fixes tag(s) which I can't see.

Oops. I realised this is actually changing code added in DisCo for Imaging
patches. It'd be better to address this before those.

-- 
Sakari Ailus

