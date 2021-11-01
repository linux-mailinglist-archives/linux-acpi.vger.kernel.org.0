Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500F3441B8C
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Nov 2021 14:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhKANRR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Nov 2021 09:17:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:60652 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230417AbhKANRQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 1 Nov 2021 09:17:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10154"; a="291848434"
X-IronPort-AV: E=Sophos;i="5.87,199,1631602800"; 
   d="scan'208";a="291848434"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 06:14:43 -0700
X-IronPort-AV: E=Sophos;i="5.87,199,1631602800"; 
   d="scan'208";a="500034763"
Received: from yingze1x-mobl.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.255.28.120])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 06:14:39 -0700
Date:   Mon, 1 Nov 2021 21:14:34 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/4] drivers/acpi: Introduce Platform Firmware Runtime
 Update device driver
Message-ID: <20211101131434.GA32880@chenyu5-mobl1>
References: <cover.1635317102.git.yu.c.chen@intel.com>
 <a318e4edc13e5a3ff95b901871b8929746535715.1635317102.git.yu.c.chen@intel.com>
 <YXkn8aBvAVEXxgdp@smile.fi.intel.com>
 <20211101093320.GA18982@chenyu5-mobl1>
 <YX/NwEdw26wzKFvQ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YX/NwEdw26wzKFvQ@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 01, 2021 at 01:21:36PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 01, 2021 at 05:33:20PM +0800, Chen Yu wrote:
> > On Wed, Oct 27, 2021 at 01:20:33PM +0300, Andy Shevchenko wrote:
> > > On Wed, Oct 27, 2021 at 03:07:51PM +0800, Chen Yu wrote:
> 
> ...
> 
> > > > +	guid_t *image_type_id = &img_hdr->image_type_id;
> > > 
> > > efi_guid_t ?
> > >
> > efi_guid_t is a 32-bit aligned guid_t, which is for the case when
> > efi_guid_t* arguments are 32-bit aligned. And it is for 32-bit ARM.
> > Since this code injection is only for 64-bit, the guid is not required
> > to be strictly 32-bit aligned I suppose?
> 
> But the type of that member may not be guid_t. So, I expect not to see guid_t
> at all here or as a internal member with the export/import GUID API in place.
>
> See, for example
> d1c6e08e7503 ("libnvdimm/labels: Add uuid helpers")
>
8b03aa0e0e5a ("libnvdimm/labels: Add type-guid helpers") I suppose. Do you
mean, since the label is not delcared as uuid type, then need to treat the
data region as a uuid. But it is actually not a formal 'uuid' type, so uuid_t
is not applicable here. And this also applys to the case in this patch?
> ...
> 
> > > > +	ret = guid_parse(PFRU_UUID, &pfru_dev->uuid);
> 
> > > > +	ret = guid_parse(PFRU_CODE_INJ_UUID, &pfru_dev->code_uuid);
> 
> > > > +	ret = guid_parse(PFRU_DRV_UPDATE_UUID, &pfru_dev->drv_uuid);
> 
> > > Why do you need to keep zillions of copies of the data which seems
> > > is not going to be changed? Three global variables should be enough,
> > > no?
> > >
> > The guid information is embedded in each pfru_dev and only calculated
> > once during probe. I thought people try to avoid using global variables
> > if possible?
> 
> Use your common sense. You might have a lot of data duplication,
> and this data is definitely not something that needs any kind of
> serialization / personification / etc.
> 
Ok, I'll switch to global variables in next version.

thanks,
Chenyu
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
