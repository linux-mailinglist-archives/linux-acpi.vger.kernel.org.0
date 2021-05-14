Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B94380A3B
	for <lists+linux-acpi@lfdr.de>; Fri, 14 May 2021 15:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhENNOs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 May 2021 09:14:48 -0400
Received: from mga14.intel.com ([192.55.52.115]:48750 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232217AbhENNOs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 May 2021 09:14:48 -0400
IronPort-SDR: NQSmRFaHJxAXGGHu9X1BhVkN8n3ZwIU/WwUz6HVRtf7gtR0+i5nYYo83Vqnr/S+YUGIWa+NF9f
 NDfO21nCImFA==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="199865020"
X-IronPort-AV: E=Sophos;i="5.82,299,1613462400"; 
   d="scan'208";a="199865020"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 06:13:32 -0700
IronPort-SDR: 74l511Rb9o5gDukdPDL6bOeNbq6KgQcj3lP8iDQqaTWrXmxK5XUlenpjvEJBgSBvCJ8LpyEenR
 NV3AelhCj7QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,299,1613462400"; 
   d="scan'208";a="538806639"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 14 May 2021 06:13:28 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 14 May 2021 16:13:28 +0300
Date:   Fri, 14 May 2021 16:13:28 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joerg Roedel <jroedel@suse.de>,
        Eric Auger <eric.auger@redhat.com>,
        Will Deacon <will@kernel.org>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI/IORT: Handle device properties with software node
 API
Message-ID: <YJ53eBRGXtabyT5K@kuha.fi.intel.com>
References: <20210511125528.18525-1-heikki.krogerus@linux.intel.com>
 <20210514103912.GA16131@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514103912.GA16131@lpieralisi>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, May 14, 2021 at 11:39:12AM +0100, Lorenzo Pieralisi wrote:
> On Tue, May 11, 2021 at 03:55:28PM +0300, Heikki Krogerus wrote:
> > The older device property API is going to be removed.
> > Replacing the device_add_properties() call with software
> > node API equivalent device_create_managed_software_node().
> > 
> > Fixes: 434b73e61cc6 ("iommu/arm-smmu-v3: Use device properties for pasid-num-bits")
> 
> Is this really fixing anything ? I am not sure I understand what you
> would like to achieve with this tag.

Right now it's not possible to simply remove the old API because some
of the maintainers want to take care of the conversion themselves, but
at the same time I also do not want to see any new releases of the
kernel that introduce more users for it. That's why it's a fix.


> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> >  drivers/acpi/arm64/iort.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> With the above comment clarified:
> 
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > index 3912a1f6058e5..e34937e11186a 100644
> > --- a/drivers/acpi/arm64/iort.c
> > +++ b/drivers/acpi/arm64/iort.c
> > @@ -976,7 +976,7 @@ static void iort_named_component_init(struct device *dev,
> >  				      FIELD_GET(ACPI_IORT_NC_PASID_BITS,
> >  						nc->node_flags));
> >  
> > -	if (device_add_properties(dev, props))
> > +	if (device_create_managed_software_node(dev, props, NULL))
> >  		dev_warn(dev, "Could not add device properties\n");
> >  }
> >  
> > -- 
> > 2.30.2
> > 

thanks,

-- 
heikki
