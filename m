Return-Path: <linux-acpi+bounces-380-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFECD7B6BCB
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 16:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 934852816DD
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 14:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B278328BD
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 14:35:40 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AC41548D
	for <linux-acpi@vger.kernel.org>; Tue,  3 Oct 2023 14:09:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D1595;
	Tue,  3 Oct 2023 07:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696342157; x=1727878157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Pwk/VZxlKOZi/7FoSiOwBQdjVQGNzZH6YXHnKj3nPAo=;
  b=cKll2msomjn9dliCeSgLc+ov15r4fVOd5DoO5jJEY6cbsVxgBgsCxgHB
   9P//bwhkJYnmdyJ9BGrIZ3d5+OFfjeoP6QsxOHFr4ktbYFBzTGhj1csNa
   tcu/ssyl+4UrCQ52TNBmy8rodV0GlbMHyDgP2aBGGJRtWT5iHt2MrXaSl
   buBjW+Lf2HEScVxMCa78B/NF7HwZEts9DByTBD/e/qLatOxQ1lGJACRSQ
   FRxiGvfQby3gYF/ARgpPKv9crlKhjGTLr3docU+bWk6V/IW+l8A0jnT61
   isHMoTnOJfnHQTVfwOIL57s0Gevp54ewjL0KttuW6BNAK5yQ4CYyIav1p
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="381765116"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="381765116"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 07:05:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="841363465"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="841363465"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 07:05:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qng1H-00000002VPj-3mwS;
	Tue, 03 Oct 2023 17:05:03 +0300
Date: Tue, 3 Oct 2023 17:05:03 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 1/2] ACPI: property: Allow _DSD buffer data only for
 byte accessors
Message-ID: <ZRwfjywiffWxWnX5@smile.fi.intel.com>
References: <20231002134630.2601294-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0ib_N_ojhoC_z9YCOgmT7q2zy1jMBAFc=pmBmrX-j5Drg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0ib_N_ojhoC_z9YCOgmT7q2zy1jMBAFc=pmBmrX-j5Drg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 03, 2023 at 03:59:26PM +0200, Rafael J. Wysocki wrote:
> On Mon, Oct 2, 2023 at 3:46 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> > +       if (obj->type == ACPI_TYPE_BUFFER) {
> > +               if (proptype != DEV_PROP_U8)
> > +                       return -EPROTO;
> >                 items = obj;
> > +       } else
> > +               items = obj->package.elements;
> 
> The braces that are missing here (as per the coding style) were added
> while applying the patch.

Thank you!

-- 
With Best Regards,
Andy Shevchenko



