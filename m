Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6006D463ABD
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Nov 2021 16:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243122AbhK3QAU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Nov 2021 11:00:20 -0500
Received: from mga07.intel.com ([134.134.136.100]:35931 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243132AbhK3QAQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 30 Nov 2021 11:00:16 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="299636611"
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="299636611"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 07:56:57 -0800
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="609177366"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 07:56:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ms5U0-000bIp-AD;
        Tue, 30 Nov 2021 17:55:52 +0200
Date:   Tue, 30 Nov 2021 17:55:52 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, heikki.krogerus@linux.intel.com,
        rafael@kernel.org,
        /tmp/small/0000-cover-letter.patch@punajuuri.localdomain
Subject: Re: [PATCH 3/7] Documentation: ACPI: Fix data node reference
 documentation
Message-ID: <YaZJiAYTFOGgoCAt@smile.fi.intel.com>
References: <20211130153250.935726-1-sakari.ailus@linux.intel.com>
 <20211130153250.935726-3-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130153250.935726-3-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 30, 2021 at 05:32:46PM +0200, Sakari Ailus wrote:
> The data node reference documentation was missing a package that must
> contain the property values, instead property name and multiple values
> being present in a single package. This is not aligned with the _DSD spec.
> Fix it by adding the package for the values.
> 
> Also add the missing "reg" properties to two numbered nodes.
> 
> Fixes: b10134a3643d ("ACPI: property: Document hierarchical data extension references")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  .../firmware-guide/acpi/dsd/data-node-references.rst      | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/firmware-guide/acpi/dsd/data-node-references.rst b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
> index b7ad47df49de0..166bf9a944bc8 100644
> --- a/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
> +++ b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
> @@ -5,7 +5,7 @@
>  Referencing hierarchical data nodes
>  ===================================
>  
> -:Copyright: |copy| 2018 Intel Corporation
> +:Copyright: |copy| 2018, 2021 Intel Corporation
>  :Author: Sakari Ailus <sakari.ailus@linux.intel.com>
>  
>  ACPI in general allows referring to device objects in the tree only.
> @@ -52,12 +52,14 @@ the ANOD object which is also the final target node of the reference.
>  	    Name (NOD0, Package() {
>  		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>  		Package () {
> +		    Package () { "reg", 0 },
>  		    Package () { "random-property", 3 },
>  		}
>  	    })
>  	    Name (NOD1, Package() {
>  		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
>  		Package () {
> +		    Package () { "reg", 1 },
>  		    Package () { "anothernode", "ANOD" },
>  		}
>  	    })
> @@ -74,7 +76,9 @@ the ANOD object which is also the final target node of the reference.
>  	    Name (_DSD, Package () {
>  		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>  		Package () {
> -		    Package () { "reference", ^DEV0, "node@1", "anothernode" },

> +		    Package () { "reference",
> +				 Package () { ^DEV0,
> +					      "node@1", "anothernode" } },

Can it be rather this

		    Package () {
		        "reference", Package () { ^DEV0, "node@1", "anothernode" }
		    },

or this way

		    Package () {
		        "reference", Package () {
			   ^DEV0, "node@1", "anothernode"
			}
		    },

?

>  		}
>  	    })
>  	}
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


