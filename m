Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A375533813
	for <lists+linux-acpi@lfdr.de>; Wed, 25 May 2022 10:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiEYINr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 May 2022 04:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbiEYINq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 May 2022 04:13:46 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF6737A07
        for <linux-acpi@vger.kernel.org>; Wed, 25 May 2022 01:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653466424; x=1685002424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vax5EiY99gs3t6yNzUXRADqAwb8U1aZ++Ac8ZB344mU=;
  b=fQYqfu2FrP+YM695fKLOjko3qTjkm/38ag9+JHItXkaKmciMQ9E74OXb
   3C/Sn6+D7lf+XF8ydMjLFiIS89G9oYitNfQn0Qq4B44CDusXU3lAr1wpH
   Y9wLfkKtkFDbBzmJuHYmf9mDNgkaN4Fvdut3aWEVnMBUJCpWbf/Lx+OuO
   UI34FXZEr+GM0/2hVxbrsJ3ArkO8dH9CceuhiCiKP9F5wRhkfnLnhMpMl
   lalmwLXR659/5ziOcDxp712k1DEqK0Ci59Y5z9tFbJMj4P+WR8sXNCBZJ
   Cif1/exkyVHpflTiBiwhgpGIl4IYRJp/BX6ZtJ6f6dOYbz9aXBqvhQz/3
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="334396034"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="334396034"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 01:13:44 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="548889496"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 01:13:43 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 0F5A02057F;
        Wed, 25 May 2022 11:13:41 +0300 (EEST)
Date:   Wed, 25 May 2022 11:13:41 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH v2 7/8] ACPI: property: Add support for parsing buffer
 property UUID
Message-ID: <Yo3lNXr0KcJmq4W9@paasikivi.fi.intel.com>
References: <20220520061148.21366-1-sakari.ailus@linux.intel.com>
 <20220520061148.21366-8-sakari.ailus@linux.intel.com>
 <YoelpPVmLoKL295p@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoelpPVmLoKL295p@smile.fi.intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Fri, May 20, 2022 at 05:28:52PM +0300, Andy Shevchenko wrote:
> On Fri, May 20, 2022 at 09:11:47AM +0300, Sakari Ailus wrote:
> > Add support for newly added buffer property UUID, as defined in the DSD
> > guide.
> 
> ...
> 
> >  static bool acpi_enumerate_nondev_subnodes(acpi_handle scope,
> > -					   const union acpi_object *desc,
> > +					   union acpi_object *desc,
> >  					   struct acpi_device_data *data,
> >  					   struct fwnode_handle *parent);
> > -static bool acpi_extract_properties(const union acpi_object *desc,
> > +static bool acpi_extract_properties(acpi_handle handle,
> > +				    union acpi_object *desc,
> >  				    struct acpi_device_data *data);
> 
> Looking at the first one, can union member be const in the last one?

The object contains _DSD properties that will be changed if the properties
are of buffer type --- see acpi_data_add_buffer_props() in the same patch.

> 
> ...
> 
> >  struct acpi_device_properties {
> >  	const guid_t *guid;
> > -	const union acpi_object *properties;
> > +	union acpi_object *properties;
> 
> Probably this change explains on the above question...
> 
> >  	struct list_head list;
> > +	void **bufs;
> >  };

-- 
Kind regards,

Sakari Ailus
