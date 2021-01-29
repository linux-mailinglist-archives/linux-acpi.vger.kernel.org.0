Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5DE3085A1
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Jan 2021 07:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhA2GTd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Jan 2021 01:19:33 -0500
Received: from mga11.intel.com ([192.55.52.93]:29718 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231939AbhA2GTb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 29 Jan 2021 01:19:31 -0500
IronPort-SDR: DT43D9rssgf04TyoFu5YOD7RxMfjAgnbJbPnQmp45q+g4VxqrazauzfBScsZeV0uY+CKRVHWUf
 I8WPrrXx8Evg==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="176866991"
X-IronPort-AV: E=Sophos;i="5.79,384,1602572400"; 
   d="scan'208";a="176866991"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 22:18:44 -0800
IronPort-SDR: VFaM2B8K9x3usyhBeO6wtZO7zzpw8hTROdsgwpXHeg6eFNTXSYUbjeq56/Rkg8t34iZ9Do6oy+
 Z+yaB/UyAsqA==
X-IronPort-AV: E=Sophos;i="5.79,384,1602572400"; 
   d="scan'208";a="389171781"
Received: from chengpol-mobl1.ccr.corp.intel.com ([10.249.170.29])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 22:18:42 -0800
Message-ID: <b472e686163f21624d6bafd3db0807f7ef0f8ff0.camel@intel.com>
Subject: Re: [PATCH -next] acpi: fpdt: drop errant comma in pr_info()
From:   Zhang Rui <rui.zhang@intel.com>
To:     Joe Perches <joe@perches.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Date:   Fri, 29 Jan 2021 14:18:39 +0800
In-Reply-To: <955a079a3d15228ce9aeba8720dccae2dc7dfb7c.camel@perches.com>
References: <20210128232528.21117-1-rdunlap@infradead.org>
         <955a079a3d15228ce9aeba8720dccae2dc7dfb7c.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 2021-01-28 at 15:56 -0800, Joe Perches wrote:
> On Thu, 2021-01-28 at 15:25 -0800, Randy Dunlap wrote:
> > Drop a mistaken comma in the pr_info() args to prevent the
> > build warning.
> > 
> > ../drivers/acpi/acpi_fpdt.c: In function 'acpi_init_fpdt':
> > ../include/linux/kern_levels.h:5:18: warning: too many arguments
> > for format [-Wformat-extra-args]
> > ../drivers/acpi/acpi_fpdt.c:255:4: note: in expansion of macro
> > 'pr_info'
> >     pr_info(FW_BUG, "Invalid subtable type %d found.\n",
> 
> []
> > --- linux-next-20210128.orig/drivers/acpi/acpi_fpdt.c
> > +++ linux-next-20210128/drivers/acpi/acpi_fpdt.c
> > @@ -252,7 +252,7 @@ void acpi_init_fpdt(void)
> >  					      subtable->type);
> >  			break;
> >  		default:
> > -			pr_info(FW_BUG, "Invalid subtable type %d
> > found.\n",
> > +			pr_info(FW_BUG "Invalid subtable type %d
> > found.\n",
> >  			       subtable->type);
> 
> Another question would be why is the pr_info when all the other
> FW_BUG uses in this file are pr_err
> 
Here, this FW_BUG just means an unrecognized subtable is found, and it
should not affect the other subtables that are already supported by
this driver. So that's why we didn't use pr_err.
In fact, I've just posted a V2 patch, 
https://patchwork.kernel.org/project/linux-acpi/patch/20210129061548.13448-1-rui.zhang@intel.com/
and I prefer to continue processing even if this FW_BUG is detected.

> One would think it's at least a defect of some time.
> I would think it should at least be pr_notice or pr_warn

I'm also okay with pr_notice/pr_warn here.
This FW_BUG should be really rare.

thanks,
rui
> 
> Documentation/admin-guide/kernel
> -parameters.txt-                        1
> (KERN_ALERT)          action must be taken immediately
> Documentation/admin-guide/kernel
> -parameters.txt-                        2
> (KERN_CRIT)           critical conditions
> Documentation/admin-guide/kernel
> -parameters.txt-                        3 (KERN_ERR)            error
> conditions
> Documentation/admin-guide/kernel
> -parameters.txt-                        4
> (KERN_WARNING)        warning conditions
> Documentation/admin-guide/kernel
> -parameters.txt-                        5
> (KERN_NOTICE)         normal but significant condition
> Documentation/admin-guide/kernel-
> parameters.txt:                        6
> (KERN_INFO)           informational
> Documentation/admin-guide/kernel
> -parameters.txt-                        7
> (KERN_DEBUG)          debug-level messages
> 
> 

