Return-Path: <linux-acpi+bounces-355-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1979F7B6677
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 12:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BEBD02816EE
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 10:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78A1208B8
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 10:33:17 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB6ADDAC
	for <linux-acpi@vger.kernel.org>; Tue,  3 Oct 2023 08:48:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B44CA9;
	Tue,  3 Oct 2023 01:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696322926; x=1727858926;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x8PAGnQYc2NcxY6KGr2gS4Kpd9E+7T9nG0n2qjbE0G4=;
  b=E9Nk42yQdXYVPv9CemGIYi4TtUEjDTDueZJnm4x31IBnn7+Au0xUuaLI
   ZI0QTQc2AW30Sfe7B5J1GZoB4MEMZJRiRqtTuEjqwcWCLysuWUZn+4Xie
   JcQzJl3V/Qk293lvykAMSOO2Ye7MLdcShGh04nyy9w5SVore2/ZSnOLSa
   RVMcZ0E48rYqJssYGxZKuczM3o/RShFy9AkQIy2rHVJipNmk83V+vJVFH
   DjudnMJWJCDWsKaUie2irRZ/WZHpA3kgkLGEZrb8XMs0Lnji7DKUeC0ze
   p5rFivJeJAu3MxMNVLK+Ser5fXMdArpOwRYEu2GfnfurKzU0SS62JKaWT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="380101442"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="380101442"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 01:48:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="727546647"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="727546647"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 01:48:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qnb55-00000002R9j-2xen;
	Tue, 03 Oct 2023 11:48:39 +0300
Date: Tue, 3 Oct 2023 11:48:39 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Wilczynski, Michal" <michal.wilczynski@intel.com>
Cc: nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 1/1] ACPI: NFIT: Switch to use
 acpi_evaluate_dsm_typed()
Message-ID: <ZRvVZylnYeIBDEH/@smile.fi.intel.com>
References: <20231002135458.2603293-1-andriy.shevchenko@linux.intel.com>
 <ec5029b0-553c-4a6c-b2a9-ef9943e553dc@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec5029b0-553c-4a6c-b2a9-ef9943e553dc@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 02, 2023 at 10:27:02PM +0200, Wilczynski, Michal wrote:
> On 10/2/2023 3:54 PM, Andy Shevchenko wrote:

...

> > +	out_obj = acpi_evaluate_dsm_typed(handle, guid, revid, func, &in_obj, ACPI_TYPE_BUFFER);
> 
> This line is 90 characters long, wouldn't it be better to split it ?

I dunno it's a problem, but if people insist, I can redo that.

...

> > +	if (!out_obj || out_obj->buffer.length < sizeof(smart)) {
> >  		dev_dbg(dev->parent, "%s: failed to retrieve initial health\n",
> >  				dev_name(dev));
> 
> While at it maybe fix alignment ? :-)

I don't think it's in scope of this change.

> >  		ACPI_FREE(out_obj);
> 
> Just nitpicks, functionally code seems correct to me.
> Reviewed-by: Michal Wilczynski <michal.wilczynski@intel.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko



