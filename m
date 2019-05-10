Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1F319FB4
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2019 17:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfEJPBX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 May 2019 11:01:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:13081 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbfEJPBX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 10 May 2019 11:01:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 08:01:22 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga007.jf.intel.com with ESMTP; 10 May 2019 08:01:20 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hP71U-0004h0-3b; Fri, 10 May 2019 18:01:20 +0300
Date:   Fri, 10 May 2019 18:01:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v2 2/2] Documentation: ACPI: Direct references are
 allowed to devices only
Message-ID: <20190510150120.GC9224@smile.fi.intel.com>
References: <20190510094603.14345-1-sakari.ailus@linux.intel.com>
 <20190510094603.14345-3-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510094603.14345-3-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, May 10, 2019 at 12:46:03PM +0300, Sakari Ailus wrote:
> In ACPI it is possible to make references to device objects only, not to
> other objects inside a device. In practice this means that hierarchical
> data extension targets must be in parentheses to make them strings.
> 
> Otherwise an acpica warning is produced.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  .../firmware-guide/acpi/dsd/data-node-references.rst         |  6 +++---
>  Documentation/firmware-guide/acpi/dsd/graph.rst              | 12 ++++++------
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/firmware-guide/acpi/dsd/data-node-references.rst b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
> index 1351984e767c8..febccbc5689d0 100644
> --- a/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
> +++ b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
> @@ -45,8 +45,8 @@ the ANOD object which is also the final target node of the reference.
>  	    Name (_DSD, Package () {
>  		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
>  		Package () {
> -		    Package () { "node@0", NOD0 },
> -		    Package () { "node@1", NOD1 },
> +		    Package () { "node@0", "NOD0" },
> +		    Package () { "node@1", "NOD1" },
>  		}
>  	    })
>  	    Name (NOD0, Package() {
> @@ -58,7 +58,7 @@ the ANOD object which is also the final target node of the reference.
>  	    Name (NOD1, Package() {
>  		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
>  		Package () {
> -		    Package () { "anothernode", ANOD },
> +		    Package () { "anothernode", "ANOD" },
>  		}
>  	    })
>  	    Name (ANOD, Package() {
> diff --git a/Documentation/firmware-guide/acpi/dsd/graph.rst b/Documentation/firmware-guide/acpi/dsd/graph.rst
> index 8a9019a38b66d..1a6ce7afba5ea 100644
> --- a/Documentation/firmware-guide/acpi/dsd/graph.rst
> +++ b/Documentation/firmware-guide/acpi/dsd/graph.rst
> @@ -45,7 +45,7 @@ with "port" and must be followed by the "@" character and the number of the
>  port as its key. The target object it refers to should be called "PRTX", where
>  "X" is the number of the port. An example of such a package would be::
>  
> -    Package() { "port@4", PRT4 }
> +    Package() { "port@4", "PRT4" }
>  
>  Further on, endpoints are located under the port nodes. The hierarchical
>  data extension key of the endpoint nodes must begin with
> @@ -54,7 +54,7 @@ endpoint. The object it refers to should be called "EPXY", where "X" is the
>  number of the port and "Y" is the number of the endpoint. An example of such a
>  package would be::
>  
> -    Package() { "endpoint@0", EP40 }
> +    Package() { "endpoint@0", "EP40" }
>  
>  Each port node contains a property extension key "port", the value of which is
>  the number of the port. Each endpoint is similarly numbered with a property
> @@ -91,7 +91,7 @@ A simple example of this is show below::
>  		},
>  		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
>  		Package () {
> -		    Package () { "port@0", PRT0 },
> +		    Package () { "port@0", "PRT0" },
>  		}
>  	    })
>  	    Name (PRT0, Package() {
> @@ -101,7 +101,7 @@ A simple example of this is show below::
>  		},
>  		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
>  		Package () {
> -		    Package () { "endpoint@0", EP00 },
> +		    Package () { "endpoint@0", "EP00" },
>  		}
>  	    })
>  	    Name (EP00, Package() {
> @@ -121,7 +121,7 @@ A simple example of this is show below::
>  	    Name (_DSD, Package () {
>  		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
>  		Package () {
> -		    Package () { "port@4", PRT4 },
> +		    Package () { "port@4", "PRT4" },
>  		}
>  	    })
>  
> @@ -132,7 +132,7 @@ A simple example of this is show below::
>  		},
>  		ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
>  		Package () {
> -		    Package () { "endpoint@0", EP40 },
> +		    Package () { "endpoint@0", "EP40" },
>  		}
>  	    })
>  
> -- 
> 2.11.0
> 

-- 
With Best Regards,
Andy Shevchenko


