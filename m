Return-Path: <linux-acpi+bounces-313-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 687EA7B505E
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 12:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0DAFC2821AC
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 10:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0AAD2E9
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 10:33:22 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E01AC8F4
	for <linux-acpi@vger.kernel.org>; Mon,  2 Oct 2023 09:37:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8991F83;
	Mon,  2 Oct 2023 02:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696239442; x=1727775442;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uRt1ae+PaFLvuL/WtDM9bT7telz1ws3WCIW7qDvGk1I=;
  b=OpqjdQ+RfN2HHXUytaVXv+98kieVoqp66+s0a1hUD1s4lmWNUzzbLgZo
   U+ajP9d2+Cw8demaNymvpvl8erEDdeuKQhB4PV9gcqx7QqnZdh6cxiWfg
   7PX3285lyv9PIjWThNgYmeKtf5xOabs9y7YYPMH8JPM0Jnrg68GUKflkF
   syVqlZmADsHe5uYtXV23WC8E/vgfnFfFnS7k4PSaQMSNALPLsRJJggCZv
   jgn9juTo09AcD5k+v4ie5b13q8C7iMuuj6ltn0uY+GyyisJD4AcXMp5LF
   dawsqdGxC71LCL2D1wrP++KDnaJJ2WmqTNzbtVEkImY1m2S6V216irOVG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="361987748"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="361987748"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:37:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="997573837"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="997573837"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:37:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qnFMO-000000027Z7-0xKM;
	Mon, 02 Oct 2023 12:37:04 +0300
Date: Mon, 2 Oct 2023 12:37:03 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michal Wilczynski <michal.wilczynski@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, rafael.j.wysocki@intel.com, lenb@kernel.org,
	dan.j.williams@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com
Subject: Re: [PATCH v1 1/2] ACPI: NFIT: Fix memory leak, and local use of
 devm_*()
Message-ID: <ZRqPP9xT9fqrZLQS@smile.fi.intel.com>
References: <20230926184520.2239723-1-michal.wilczynski@intel.com>
 <20230926184520.2239723-2-michal.wilczynski@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926184520.2239723-2-michal.wilczynski@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 09:45:19PM +0300, Michal Wilczynski wrote:
> devm_*() family of functions purpose is managing memory attached to a
> device. So in general it should only be used for allocations that should
> last for the whole lifecycle of the device. This is not the case for
> acpi_nfit_init_interleave_set(). There are two allocations that are only
> used locally in this function. What's more - if the function exits on
> error path memory is never freed. It's still attached to dev and would
> be freed on device detach, so this leak could be called a 'local leak'.
> 
> Fix this by switching from devm_kcalloc() to kcalloc(), and adding
> proper rollback.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



