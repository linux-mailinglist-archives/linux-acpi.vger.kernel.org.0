Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C10319CB0
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Feb 2021 11:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhBLKeI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Feb 2021 05:34:08 -0500
Received: from mga12.intel.com ([192.55.52.136]:16940 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230046AbhBLKeH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 Feb 2021 05:34:07 -0500
IronPort-SDR: xoXangnJxijt8I7Ce0KeEYR8eIEzTQVBG9106/qWYgiNo1sk7SmM1Ux/yp92nEX+RDLTE7LGKY
 PxeZLspnzlVQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="161536065"
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; 
   d="scan'208";a="161536065"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 02:32:14 -0800
IronPort-SDR: ewelfyhW1zzOTth4TCnY+JHw59DhCjb1xEffkvMCuOvqUF4S+UU523beNBTBomQS3FWZ50Imiy
 rE89pDatRUaQ==
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; 
   d="scan'208";a="376305422"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 02:32:12 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lAVk9-004SQ5-Nj; Fri, 12 Feb 2021 12:32:09 +0200
Date:   Fri, 12 Feb 2021 12:32:09 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Calvin Johnson <calvin.johnson@oss.nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH] ACPI: property: Fix fwnode string properties matching
Message-ID: <YCZZKcILHvVnVuUp@smile.fi.intel.com>
References: <5831274.1ZjA0VymzF@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5831274.1ZjA0VymzF@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Feb 11, 2021 at 07:30:01PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Property matching does not work for ACPI fwnodes if the value of the
> given property is not represented as a package in the _DSD package
> containing it.  For example, the "compatible" property in the _DSD
> below
> 
>   Name (_DSD, Package () {
>     ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>     Package () {
>       Package () {"compatible", "ethernet-phy-ieee802.3-c45"}
>     }
>   })
> 
> will not be found by fwnode_property_match_string(), because the ACPI
> code handling device properties does not regard the single value as a
> "list" in that case.
> 
> Namely, fwnode_property_match_string() invoked to match a given
> string property value first calls fwnode_property_read_string_array()
> with the last two arguments equal to NULL and 0, respectively, in
> order to count the items in the value of the given property, with the
> assumption that this value may be an array.  For ACPI fwnodes, that
> operation is carried out by acpi_node_prop_read() which calls
> acpi_data_prop_read() for this purpose.  However, when the return
> (val) pointer is NULL, that function only looks for a property whose
> value is a package without checking the single-value case at all.
> 
> To fix that, make acpi_data_prop_read() check the single-value case
> regardless of the return pointer value if its return pointer argument
> is NULL and modify acpi_data_prop_read_single() handling that case to
> attempt to read the value of the property if the return pointer is
> NULL and return 1 if that succeeds.

Thanks, fine with me.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I'll rebase the rest I have on to of this.

> Fixes: 3708184afc77 ("device property: Move FW type specific functionality to FW specific files")
> Reported-by: Calvin Johnson <calvin.johnson@oss.nxp.com>
> Cc: 4.13+ <stable@vger.kernel.org> # 4.13+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/property.c |   44 +++++++++++++++++++++++++++++++++-----------
>  1 file changed, 33 insertions(+), 11 deletions(-)
> 
> Index: linux-pm/drivers/acpi/property.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/property.c
> +++ linux-pm/drivers/acpi/property.c
> @@ -787,9 +787,6 @@ static int acpi_data_prop_read_single(co
>  	const union acpi_object *obj;
>  	int ret;
>  
> -	if (!val)
> -		return -EINVAL;
> -
>  	if (proptype >= DEV_PROP_U8 && proptype <= DEV_PROP_U64) {
>  		ret = acpi_data_get_property(data, propname, ACPI_TYPE_INTEGER, &obj);
>  		if (ret)
> @@ -799,28 +796,43 @@ static int acpi_data_prop_read_single(co
>  		case DEV_PROP_U8:
>  			if (obj->integer.value > U8_MAX)
>  				return -EOVERFLOW;
> -			*(u8 *)val = obj->integer.value;
> +
> +			if (val)
> +				*(u8 *)val = obj->integer.value;
> +
>  			break;
>  		case DEV_PROP_U16:
>  			if (obj->integer.value > U16_MAX)
>  				return -EOVERFLOW;
> -			*(u16 *)val = obj->integer.value;
> +
> +			if (val)
> +				*(u16 *)val = obj->integer.value;
> +
>  			break;
>  		case DEV_PROP_U32:
>  			if (obj->integer.value > U32_MAX)
>  				return -EOVERFLOW;
> -			*(u32 *)val = obj->integer.value;
> +
> +			if (val)
> +				*(u32 *)val = obj->integer.value;
> +
>  			break;
>  		default:
> -			*(u64 *)val = obj->integer.value;
> +			if (val)
> +				*(u64 *)val = obj->integer.value;
> +
>  			break;
>  		}
> +
> +		if (!val)
> +			return 1;
>  	} else if (proptype == DEV_PROP_STRING) {
>  		ret = acpi_data_get_property(data, propname, ACPI_TYPE_STRING, &obj);
>  		if (ret)
>  			return ret;
>  
> -		*(char **)val = obj->string.pointer;
> +		if (val)
> +			*(char **)val = obj->string.pointer;
>  
>  		return 1;
>  	} else {
> @@ -834,7 +846,7 @@ int acpi_dev_prop_read_single(struct acp
>  {
>  	int ret;
>  
> -	if (!adev)
> +	if (!adev || !val)
>  		return -EINVAL;
>  
>  	ret = acpi_data_prop_read_single(&adev->data, propname, proptype, val);
> @@ -928,10 +940,20 @@ static int acpi_data_prop_read(const str
>  	const union acpi_object *items;
>  	int ret;
>  
> -	if (val && nval == 1) {
> +	if (nval == 1 || !val) {
>  		ret = acpi_data_prop_read_single(data, propname, proptype, val);
> -		if (ret >= 0)
> +		/*
> +		 * The overflow error means that the property is there and it is
> +		 * single-value, but its type does not match, so return.
> +		 */
> +		if (ret >= 0 || ret == -EOVERFLOW)
>  			return ret;
> +
> +		/*
> +		 * Reading this property as a single-value one failed, but its
> +		 * value may still be represented as one-element array, so
> +		 * continue.
> +		 */
>  	}
>  
>  	ret = acpi_data_get_property_array(data, propname, ACPI_TYPE_ANY, &obj);
> 
> 
> 

-- 
With Best Regards,
Andy Shevchenko


