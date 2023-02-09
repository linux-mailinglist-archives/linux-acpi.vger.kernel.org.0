Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01308690619
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Feb 2023 12:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBILHK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Feb 2023 06:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjBILHI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Feb 2023 06:07:08 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C756F741;
        Thu,  9 Feb 2023 03:07:07 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PCDV60WmMz6J7kQ;
        Thu,  9 Feb 2023 19:02:38 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 9 Feb
 2023 11:07:04 +0000
Date:   Thu, 9 Feb 2023 11:07:04 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 07/18] cxl/region: Move region-position validation to a
 helper
Message-ID: <20230209110704.000072c6@Huawei.com>
In-Reply-To: <63e475f2a5fd_36c729455@dwillia2-xfh.jf.intel.com.notmuch>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
        <167564538779.847146.8356062886811511706.stgit@dwillia2-xfh.jf.intel.com>
        <20230208123031.00006990@Huawei.com>
        <63e475f2a5fd_36c729455@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 8 Feb 2023 20:26:26 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> [..]
> > > @@ -1284,13 +1327,6 @@ static int cxl_region_attach(struct cxl_region *cxlr,
> > >  		return -ENXIO;
> > >  	}
> > >  
> > > -	if (cxlrd->calc_hb(cxlrd, pos) != dport) {
> > > -		dev_dbg(&cxlr->dev, "%s:%s invalid target position for %s\n",
> > > -			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> > > -			dev_name(&cxlrd->cxlsd.cxld.dev));
> > > -		return -ENXIO;
> > > -	}
> > > -  
> > 
> > In an ideal world, this would have been nice as two patches.
> > One that reorders the various checks so that they are in the order
> > after you have factored things out (easy to review for correctness)
> > then one that factored it out.  
> 
> I played with this a bit and the only way I could see to make the diff
> come out significantly nicer would be to use a forward declaration to
> move the new helpers below cxl_region_attach().

Don't bother then!  Unless you've already done it.

In the ideal world diff would magically present everything in the most
human readable form :)  What are all these AI folk working on that we
don't already have this!

Jonathan

