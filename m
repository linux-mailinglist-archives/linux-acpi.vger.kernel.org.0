Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07D7536444
	for <lists+linux-acpi@lfdr.de>; Fri, 27 May 2022 16:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241214AbiE0OfP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 27 May 2022 10:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351571AbiE0OfO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 27 May 2022 10:35:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512951207EC
        for <linux-acpi@vger.kernel.org>; Fri, 27 May 2022 07:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653662113; x=1685198113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CiTYn1wW0gvORwdQpXzS7/V74U8WT0tOtfYOr9QDV+k=;
  b=OH+tZ8HTNUStfyhItsakN5IpjqkS3h/1furFz/EIanGt+5jD1KW2e1Qy
   yzRTieY/460yTqFQczkqIvd4JRO7mrdgCJyqzkxZJ/1pRG4HC8Uzh1T0o
   cU6TyqErq5XTm5aRWfHdYNaww+VlnOpB+68W5d6yWfkCW/07fqIQb6MSK
   +Vhub0hJ2+bavvjZLKqWuYwU/fFDfV0RR0tL1VQ1XVw8nNUMUNHOsndhh
   tIqHt2W+u1k9Kqm/wJEboNQqFJBLO4pWBOEw5Ip4Ui50zWuEf0OhN9vaf
   MRNocAzpCQO/2Hmh/KbtfHIJmttJwP2Ml2WnMPB3IiwP0QtZzWle6fMp9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="335144499"
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="335144499"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 07:35:13 -0700
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="528136228"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 07:35:12 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id D5BB52057F;
        Fri, 27 May 2022 17:35:09 +0300 (EEST)
Date:   Fri, 27 May 2022 17:35:09 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH v3 2/8] ACPI: property: Tie data nodes to acpi handles
Message-ID: <YpDhnT+vFYn7oDbq@paasikivi.fi.intel.com>
References: <20220525130123.767410-1-sakari.ailus@linux.intel.com>
 <20220525130123.767410-3-sakari.ailus@linux.intel.com>
 <Yo5lRKqFoyL4BUNy@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo5lRKqFoyL4BUNy@smile.fi.intel.com>
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

On Wed, May 25, 2022 at 08:20:04PM +0300, Andy Shevchenko wrote:
> On Wed, May 25, 2022 at 04:01:17PM +0300, Sakari Ailus wrote:
> > ACPICA allows associating additional information (i.e. pointers with
> > specific tag) to acpi_handles. The acpi_device's are associated to
> > acpi_handle's in acpi_tie_acpi_dev() in scan.c, do the same here for the
> > _DSD data nodes.
> > 
> > This allows direct data node references in properties, implemented later on
> > in the series.
> 
> ...
> 
> > +static int acpi_tie_nondev_subnodes(struct acpi_device_data *data)
> > +{
> > +	struct acpi_data_node *dn;
> > +
> > +	list_for_each_entry(dn, &data->subnodes, sibling) {
> > +		acpi_status status;
> > +		int ret;
> > +
> > +		status = acpi_attach_data(dn->handle, acpi_nondev_subnode_tag, dn);
> > +		if (ACPI_FAILURE(status)) {
> > +			acpi_handle_err(dn->handle, "Can't tag data node\n");
> > +			return 0;
> > +		}
> > +
> > +		ret = acpi_tie_nondev_subnodes(&dn->data);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> ...
> 
> > -	if (!adev->data.pointer) {
> > +	if (!adev->data.pointer ||
> 
> > +	    acpi_tie_nondev_subnodes(&adev->data) < 0) {
> > +		acpi_untie_nondev_subnodes(&adev->data);
> 
> I don't know this part of the code, but this looks unusual. Shouldn't _tie()
> take care of proper error path itself?

It could, but I'd need another function for recursive use. You're basically
asking to move these two lines into a new function called from here only.

> 
> Also, it's a bit strange to call _untie() when _tie() wasn't called.

How does this happen?

If you mean not keeping track which nodes have been tied and which have
not, it could be done. But there's no harm from detaching data that has not
been attached, it's a nop.

-- 
Kind regards,

Sakari Ailus
