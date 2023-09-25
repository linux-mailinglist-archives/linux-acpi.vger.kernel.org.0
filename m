Return-Path: <linux-acpi+bounces-99-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DD07ADD34
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 18:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0DA54281F46
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 16:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FCF210E4
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 16:32:19 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7856FB8
	for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 15:47:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3C4CE3;
	Mon, 25 Sep 2023 08:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695656858; x=1727192858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+K5Fipx1dZqTJlRL8mpcXqKkwlqbuDzbtNFslPySHKo=;
  b=Df785+r9pwtw9+jKeRX2x1aIjh4b+jN+bMkuHwUGalKPq2tNpbajenCV
   U16XpGRVBrQikPbUAAvSEU8CO/DUuif1095tb33lrgPa3OKo+6uxzQ3AU
   F+MwlxDkp8n7DVErRcunH3udqKpK2VGKglrwTIkcnvjBTFbKz+svCl+zd
   vWke0SQT3pJ0Z3aau5Ae/e9QOJGurnmV2vtZL6kXPPNeKOxAXB0bmxOF6
   AVi9RBSubYyzAUpJRUuKy/MB6vzbqwjtbIbGirf599m5O5sYQzip9uWFB
   Gf8rVvkKH41QwPKIA78Q2btbWvvTQ9hJvr04eG1RrMo/FrSSi+FfFOL0N
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="445394509"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="445394509"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 08:47:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="814019337"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="814019337"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 08:47:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1qkno3-00000000Nnc-1SGH;
	Mon, 25 Sep 2023 18:47:31 +0300
Date: Mon, 25 Sep 2023 18:47:31 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Michal Wilczynski <michal.wilczynski@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, rafael.j.wysocki@intel.com, lenb@kernel.org,
	dan.j.williams@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, rui.zhang@intel.com
Subject: Re: [PATCH v1 9/9] ACPI: NFIT: Don't use KBUILD_MODNAME for driver
 name
Message-ID: <ZRGrk8/0UMd9FuFH@smile.fi.intel.com>
References: <20230925144842.586829-1-michal.wilczynski@intel.com>
 <20230925144842.586829-10-michal.wilczynski@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925144842.586829-10-michal.wilczynski@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 25, 2023 at 05:48:42PM +0300, Michal Wilczynski wrote:
> Driver name is part of the ABI, so it should be hard-coded, as ABI
> should be always kept backward compatible. Prevent ABI from changing
> accidentally in case KBUILD_MODNAME change.

This is up to maintainers, probably we won't have any users outside of existing
model (instantiating via ACPI ID). All the above is "strictly speaking"...

-- 
With Best Regards,
Andy Shevchenko



