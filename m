Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9712B04F7
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Nov 2020 13:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgKLMak (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Nov 2020 07:30:40 -0500
Received: from mga18.intel.com ([134.134.136.126]:37540 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgKLMaj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Nov 2020 07:30:39 -0500
IronPort-SDR: h/mViDQNjntVi33CfCi9802VvSsKjBssiZnC31fsH4OzmBt+5zUFMJH8UJW1U+XmgXHIezlU3q
 hePFXvGboF2Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="158078519"
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="158078519"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 04:30:37 -0800
IronPort-SDR: IX5G07I5r7Fa3ycS3E5e+scfE3PD0jywPOjnJeKppnpcjbQyN69YvgGlcmoazDnhFoGNY4hFRV
 c+hfoGsznjng==
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="328481629"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 04:30:35 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kdBlJ-006CgX-VS; Thu, 12 Nov 2020 14:31:37 +0200
Date:   Thu, 12 Nov 2020 14:31:37 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: ACPI: explain how to use
 gpio-line-names
Message-ID: <20201112123137.GA4077@smile.fi.intel.com>
References: <20201112090241.570637-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112090241.570637-1-f.suligoi@asem.it>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 12, 2020 at 10:02:41AM +0100, Flavio Suligoi wrote:
> The "gpio-line-names" declaration is not fully
> documented, so can be useful to add some important
> information and one more example.
> 
> This commit also fixes a trivial spelling mistake.

Thanks!

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---
> 
> v2: - fix commit spelling mistakes
>     - add double back quotes to gpio-line-names
>     - adjust documentation lines layout
>     - add comma at the end of Package list names in the first example
> 
>  .../firmware-guide/acpi/gpio-properties.rst   | 58 ++++++++++++++++++-
>  1 file changed, 56 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/firmware-guide/acpi/gpio-properties.rst b/Documentation/firmware-guide/acpi/gpio-properties.rst
> index bb6d74f23ee0..ae5396a1f092 100644
> --- a/Documentation/firmware-guide/acpi/gpio-properties.rst
> +++ b/Documentation/firmware-guide/acpi/gpio-properties.rst
> @@ -107,7 +107,61 @@ Example::
>  
>  - gpio-line-names
>  
> -Example::
> +The ``gpio-line-names`` declaration is a list of strings ("names"), which
> +describes each line/pin of a GPIO controller/expander. This list, contained in
> +a package, must be inserted inside the GPIO controller declaration of an ACPI
> +table (typically inside the DSDT). The ``gpio-line-names`` list must respect the
> +following rules (see also the examples):
> +
> +  - the first name in the list corresponds with the first line/pin of the GPIO
> +    controller/expander
> +  - the names inside the list must be consecutive (no "holes" are permitted)
> +  - the list can be incomplete and can end before the last GPIO line: in
> +    other words, it is not mandatory to fill all the GPIO lines
> +  - empty names are allowed (two quotation marks ``""`` correspond to an empty
> +    name)
> +
> +Example of a GPIO controller of 16 lines, with an incomplete list with two
> +empty names::
> +
> +  Package () {
> +      "gpio-line-names",
> +      Package () {
> +          "pin_0",
> +          "pin_1",
> +          "",
> +          "",
> +          "pin_3",
> +          "pin_4_push_button",
> +      }
> +  }
> +
> +At runtime, the above declaration produces the following result (using the
> +"libgpiod" tools)::
> +
> +  root@debian:~# gpioinfo gpiochip4
> +  gpiochip4 - 16 lines:
> +          line   0:      "pin_0"       unused   input  active-high
> +          line   1:      "pin_1"       unused   input  active-high
> +          line   2:      unnamed       unused   input  active-high
> +          line   3:      unnamed       unused   input  active-high
> +          line   4:      "pin_3"       unused   input  active-high
> +          line   5: "pin_4_push_button" unused input active-high
> +          line   6:      unnamed       unused   input  active-high
> +          line   7       unnamed       unused   input  active-high
> +          line   8:      unnamed       unused   input  active-high
> +          line   9:      unnamed       unused   input  active-high
> +          line  10:      unnamed       unused   input  active-high
> +          line  11:      unnamed       unused   input  active-high
> +          line  12:      unnamed       unused   input  active-high
> +          line  13:      unnamed       unused   input  active-high
> +          line  14:      unnamed       unused   input  active-high
> +          line  15:      unnamed       unused   input  active-high
> +  root@debian:~# gpiofind pin_4_push_button
> +  gpiochip4 5
> +  root@debian:~#
> +
> +Another example::
>  
>    Package () {
>        "gpio-line-names",
> @@ -191,7 +245,7 @@ The driver might expect to get the right GPIO when it does::
>  but since there is no way to know the mapping between "reset" and
>  the GpioIo() in _CRS desc will hold ERR_PTR(-ENOENT).
>  
> -The driver author can solve this by passing the mapping explictly
> +The driver author can solve this by passing the mapping explicitly
>  (the recommended way and documented in the above chapter).
>  
>  The ACPI GPIO mapping tables should not contaminate drivers that are not
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


