Return-Path: <linux-acpi+bounces-2565-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457A68198BD
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Dec 2023 07:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0274C288571
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Dec 2023 06:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18B711C90;
	Wed, 20 Dec 2023 06:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IzkWYlnJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F75F11CAD
	for <linux-acpi@vger.kernel.org>; Wed, 20 Dec 2023 06:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703054469; x=1734590469;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zxE285B/scUTezPbVmr7HygFJL7m6hgXtlPPuiRxIe4=;
  b=IzkWYlnJRUSZvn5EfwZvuOR0lKjOfEa2vYclhBr9dmJgwJ/n7t+vf36s
   VT9ID9WyvTWtTY0MezwvXIHYIE6deOHBA+U8Gg3vAw9qecplotL2mjSbW
   A8g1zxTU5QQpPQkg2BDMexjUddDfqzsCG7oJP4R1zJ5dU4Ybq5yzaak0V
   Elt+oBb5mjI4Ny1s16t2Hh6ct4nqcsEXoSvs+pIgbh00PDoGzn0Et9ue3
   HYbmWmEJ2JDB3vSuYrEb+ZAT819JIg/n4LzSOiE2i1zhIcvJu0uT/qys8
   poY7nxzWu988vETOIPCESvS0hyBXVt1C2rRHRYS7HVbaiGdqNXUceCAG0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="14460575"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="14460575"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 22:41:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="752446673"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="752446673"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.86.247])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 22:41:00 -0800
Date: Tue, 19 Dec 2023 22:40:59 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: nvdimm@lists.linux.dev, Ben Dooks <ben.dooks@codethink.co.uk>,
	Dave Jiang <dave.jiang@intel.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] acpi/nfit: Use sysfs_emit() for all attributes
Message-ID: <ZYKMe8ZEAS6qHIlD@aschofie-mobl2>
References: <170303851337.2238503.5103082574938957743.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170303851337.2238503.5103082574938957743.stgit@dwillia2-xfh.jf.intel.com>

On Tue, Dec 19, 2023 at 06:15:13PM -0800, Dan Williams wrote:
> sysfs_emit() properly handles the PAGE_SIZE limitation of populating
> sysfs attribute buffers. Clean up the deprecated usage of sprintf() in
> all of nfit's sysfs show() handlers.
> 
> Reported-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Closes: http://lore.kernel.org/0d1bf461-d9e8-88bc-b7e2-b03b56594213@codethink.co.uk
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>


Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> ---
>  drivers/acpi/nfit/core.c |   44 ++++++++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 

