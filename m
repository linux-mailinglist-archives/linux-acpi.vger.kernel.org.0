Return-Path: <linux-acpi+bounces-314-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713207B505F
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 12:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 09372281120
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 10:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35141C02
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 10:33:27 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491E0C8F4
	for <linux-acpi@vger.kernel.org>; Mon,  2 Oct 2023 09:38:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45B591;
	Mon,  2 Oct 2023 02:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696239505; x=1727775505;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EKeqTQ7lBi8p0ds3MCDEOA0gTab2eJ95FzFsr/E1n6o=;
  b=X34ptVaB7wNYWA2sNbvdGAtGQNYh2ZEsdtYD5iHE0/COoszRyiwVDjQe
   Jm4CFUWv8IZUqdppAajngRRsUdGh9AnaLmL6pre2gDfJ2JOJ+2MvMj1dZ
   nqokmDZZQDuX+Ya4roNjnRg4jH3j0eq7SdOn7x+p1Xa0mO07MdDbXLMl4
   CYyQ8NM9Uw5KL5irCLaA0BDktRYvL8pG+MHCGOcuTxIIM4lVdiqZLXuIQ
   3q/LDb43YaWesQOEDZ7EFWHQtSj39Bx0RMVq79DpFfteC7taN717Lzn0T
   6QptztR6cirdpv6Jb0kmG5kkTXlR+9aaxt7NT0Zjmd7ezZ2TLD8FNPLaP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="382516181"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="382516181"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:38:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="1081591596"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="1081591596"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:38:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qnFNc-000000027aE-1EzC;
	Mon, 02 Oct 2023 12:38:20 +0300
Date: Mon, 2 Oct 2023 12:38:20 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michal Wilczynski <michal.wilczynski@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, rafael.j.wysocki@intel.com, lenb@kernel.org,
	dan.j.williams@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v1 2/2] ACPI: NFIT: Use modern scope based rollback
Message-ID: <ZRqPjLfITntN3cKr@smile.fi.intel.com>
References: <20230926184520.2239723-1-michal.wilczynski@intel.com>
 <20230926184520.2239723-3-michal.wilczynski@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926184520.2239723-3-michal.wilczynski@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 09:45:20PM +0300, Michal Wilczynski wrote:
> Change rollback in acpi_nfit_init_interleave_set() to use modern scope
> based attribute __free(). This is similar to C++ RAII and is a preferred
> way for handling local memory allocations.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



