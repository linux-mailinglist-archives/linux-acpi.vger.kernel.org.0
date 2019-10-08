Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B18CCFBD3
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2019 16:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbfJHODJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Oct 2019 10:03:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:7522 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbfJHODJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 8 Oct 2019 10:03:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 07:03:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,270,1566889200"; 
   d="scan'208";a="193387191"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 08 Oct 2019 07:03:07 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iHq4w-0002Gy-Sk; Tue, 08 Oct 2019 17:03:06 +0300
Date:   Tue, 8 Oct 2019 17:03:06 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device property: Fix the description of struct
 fwnode_operations
Message-ID: <20191008140306.GN32742@smile.fi.intel.com>
References: <20191008132606.56434-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008132606.56434-1-heikki.krogerus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 08, 2019 at 04:26:06PM +0300, Heikki Krogerus wrote:
> Adding description for the device_is_available member which
> was missing, and fixing the description of the member
> property_read_int_array.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  include/linux/fwnode.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 6ae05b9ce359..fc002aacae8d 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -50,11 +50,11 @@ struct fwnode_reference_args {
>   * struct fwnode_operations - Operations for fwnode interface
>   * @get: Get a reference to an fwnode.
>   * @put: Put a reference to an fwnode.
> + * @device_is_available: Return true if the device is available.
>   * @device_get_match_data: Return the device driver match data.
>   * @property_present: Return true if a property is present.
> - * @property_read_integer_array: Read an array of integer properties. Return
> - *				 zero on success, a negative error code
> - *				 otherwise.
> + * @property_read_int_array: Read an array of integer properties. Return zero on
> + *			     success, a negative error code otherwise.
>   * @property_read_string_array: Read an array of string properties. Return zero
>   *				on success, a negative error code otherwise.
>   * @get_parent: Return the parent of an fwnode.
> -- 
> 2.23.0
> 

-- 
With Best Regards,
Andy Shevchenko


