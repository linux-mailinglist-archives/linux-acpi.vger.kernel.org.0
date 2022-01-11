Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D9348A496
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jan 2022 01:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346011AbiAKA4i (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 10 Jan 2022 19:56:38 -0500
Received: from mga05.intel.com ([192.55.52.43]:62857 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229701AbiAKA4i (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 Jan 2022 19:56:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641862598; x=1673398598;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HFUd3/d50X45y8Ud4VwrANlmEf9WLntADXATJ1Z091Y=;
  b=ELGGsFlEPHOL+TuqxgDtqoJANgUxs3qb7rdYN32a51JkpVCNiOS7hdHQ
   Jjra1ohOZu+IGr2q9262gBi5oPct6oTra7CnuH+DYSvVNsUTuYBcwsLKI
   DNttmdnqeeV0UYAKdOlyT+QmUzGBth/g7sjV+IcmTjwsHQS/x11fTOWgY
   Hxg+ke0EUUMa7xPr46oa9XZuSznTRGXOD9cUqX1XRpG2bKEWuwBCGG12z
   qHurW82ym+t/cqCrokM103jOzwzzU2ceguSxeuXft+8nLT75z4KnySCId
   Q0jHnXY6cipYYa1A9Wa0/fj3WhihXtslSgs8B+wrUxUTsg6pfr8yZex4M
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="329713752"
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="329713752"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 16:56:37 -0800
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="622876040"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.186])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 16:56:36 -0800
Date:   Tue, 11 Jan 2022 08:56:02 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ACPI: pfr_telemetry: Fix info leak in pfrt_log_ioctl()
Message-ID: <20220111005602.GA987335@chenyu-desktop>
References: <20220107073407.GG22086@kili>
 <20220107134617.GA895400@chenyu-desktop>
 <20220110061713.GA1951@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110061713.GA1951@kadam>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 10, 2022 at 09:17:13AM +0300, Dan Carpenter wrote:
> On Fri, Jan 07, 2022 at 09:46:17PM +0800, Chen Yu wrote:
> > On Fri, Jan 07, 2022 at 10:34:07AM +0300, Dan Carpenter wrote:
> > > The "data_info" struct is copied to the user.  It has a 4 byte struct
> > > hole after the last struct member so we need to memset that to avoid
> > > copying uninitialized stack data to the user.
> > > 
> > > Fixes: b0013e037a8b ("ACPI: Introduce Platform Firmware Runtime Telemetry driver")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > ---
> > > When you're adding a new driver to the kernel then please use the new
> > > driver's prefix instead of just the subsystem prefix.
> > > 
> > >  Bad: ACPI: Introduce Platform Firmware Runtime Telemetry driver
> > > Good: ACPI / pfr_telemetry: Introduce Platform Firmware Runtime Telemetry driver
> > > 
> > Thanks for pointing this out.
> > > Otherwise it's just up to me to guess what prefix you wanted.
> > > 
> > >  drivers/acpi/pfr_telemetry.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/acpi/pfr_telemetry.c b/drivers/acpi/pfr_telemetry.c
> > > index da50dd80192c..9abf350bd7a5 100644
> > > --- a/drivers/acpi/pfr_telemetry.c
> > > +++ b/drivers/acpi/pfr_telemetry.c
> > > @@ -83,6 +83,7 @@ static int get_pfrt_log_data_info(struct pfrt_log_data_info *data_info,
> > >  	union acpi_object *out_obj, in_obj, in_buf;
> > >  	int ret = -EBUSY;
> > >  
> > > +	memset(data_info, 0, sizeof(*data_info));
> > Just one minor question, how about moving above before:
> > data_info->status = out_obj->package.elements[LOG_STATUS_IDX].integer.value;
> > after the sanity check of the _DSM result?
> 
> I guess I wanted to keep all the memsets together.  I feel like if the
> data is invalid, then it's going to be a slow path and it's not worth
> optimizing that case.  If the data is invalid then a little slow down is
> the least of our concerns.
>
Ok, got it.

thanks,
Chenyu 
> 
