Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088D6463F75
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Nov 2021 21:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240247AbhK3Upp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Nov 2021 15:45:45 -0500
Received: from mga17.intel.com ([192.55.52.151]:36171 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233340AbhK3Upo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 30 Nov 2021 15:45:44 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="217007662"
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="217007662"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 12:42:23 -0800
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="477257865"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 12:42:22 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id C2F1120399;
        Tue, 30 Nov 2021 22:42:19 +0200 (EET)
Date:   Tue, 30 Nov 2021 22:42:19 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, heikki.krogerus@linux.intel.com,
        rafael@kernel.org
Subject: Re: [PATCH 3/7] Documentation: ACPI: Fix data node reference
 documentation
Message-ID: <YaaMoNdtcOAICs/u@paasikivi.fi.intel.com>
References: <20211130153250.935726-1-sakari.ailus@linux.intel.com>
 <20211130153250.935726-3-sakari.ailus@linux.intel.com>
 <YaZJiAYTFOGgoCAt@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaZJiAYTFOGgoCAt@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 30, 2021 at 05:55:52PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 30, 2021 at 05:32:46PM +0200, Sakari Ailus wrote:
> > The data node reference documentation was missing a package that must
> > contain the property values, instead property name and multiple values
> > being present in a single package. This is not aligned with the _DSD spec.
> > Fix it by adding the package for the values.
> > 
> > Also add the missing "reg" properties to two numbered nodes.
> > 
> > Fixes: b10134a3643d ("ACPI: property: Document hierarchical data extension references")
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  .../firmware-guide/acpi/dsd/data-node-references.rst      | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/firmware-guide/acpi/dsd/data-node-references.rst b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
> > index b7ad47df49de0..166bf9a944bc8 100644
> > --- a/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
> > +++ b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
> > @@ -5,7 +5,7 @@
> >  Referencing hierarchical data nodes
> >  ===================================
> >  
> > -:Copyright: |copy| 2018 Intel Corporation
> > +:Copyright: |copy| 2018, 2021 Intel Corporation
> >  :Author: Sakari Ailus <sakari.ailus@linux.intel.com>
> >  
> >  ACPI in general allows referring to device objects in the tree only.
> > @@ -52,12 +52,14 @@ the ANOD object which is also the final target node of the reference.
> >  	    Name (NOD0, Package() {
> >  		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> >  		Package () {
> > +		    Package () { "reg", 0 },
> >  		    Package () { "random-property", 3 },
> >  		}
> >  	    })
> >  	    Name (NOD1, Package() {
> >  		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
> >  		Package () {
> > +		    Package () { "reg", 1 },
> >  		    Package () { "anothernode", "ANOD" },
> >  		}
> >  	    })
> > @@ -74,7 +76,9 @@ the ANOD object which is also the final target node of the reference.
> >  	    Name (_DSD, Package () {
> >  		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> >  		Package () {
> > -		    Package () { "reference", ^DEV0, "node@1", "anothernode" },
> 
> > +		    Package () { "reference",
> > +				 Package () { ^DEV0,
> > +					      "node@1", "anothernode" } },
> 
> Can it be rather this
> 
> 		    Package () {
> 		        "reference", Package () { ^DEV0, "node@1", "anothernode" }
> 		    },
> 
> or this way
> 
> 		    Package () {
> 		        "reference", Package () {
> 			   ^DEV0, "node@1", "anothernode"
> 			}
> 		    },
> 
> ?

How about:

		    Package () {
		        "reference",
		        Package () { ^DEV0, "node@1", "anothernode" },
		    },

-- 
Sakari Ailus
