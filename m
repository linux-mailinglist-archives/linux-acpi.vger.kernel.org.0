Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DDB463ACD
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Nov 2021 16:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhK3QCX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Nov 2021 11:02:23 -0500
Received: from mga09.intel.com ([134.134.136.24]:43998 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230294AbhK3QCX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 30 Nov 2021 11:02:23 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="236066363"
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="236066363"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 07:59:04 -0800
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="459649572"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 07:59:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ms5W2-000bM9-ON;
        Tue, 30 Nov 2021 17:57:58 +0200
Date:   Tue, 30 Nov 2021 17:57:58 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, heikki.krogerus@linux.intel.com,
        rafael@kernel.org,
        /tmp/small/0000-cover-letter.patch@punajuuri.localdomain
Subject: Re: [PATCH 4/7] Documentation: ACPI: Update references
Message-ID: <YaZKBpJi2C/R/6VO@smile.fi.intel.com>
References: <20211130153250.935726-1-sakari.ailus@linux.intel.com>
 <20211130153250.935726-4-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130153250.935726-4-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 30, 2021 at 05:32:47PM +0200, Sakari Ailus wrote:
> Update references for the ACPI _DSD documentation. In particular:
> 
> - Substitute _DSD property and hierarchical data extension documents with
>   the newer DSD guide that replaces both, and use its HTML form.
> 
> - Refer to the latest ACPI spec.
> 
> - Add data node reference documentation reference to graph documentation.

...

> -[1] _DSD (Device Specific Data) Implementation Guide.
> -    https://www.uefi.org/sites/default/files/resources/_DSD-implementation-guide-toplevel-1_1.htm,
> -    referenced 2016-10-03.
> +[1] Devicetree. https://www.devicetree.org, referenced 2016-10-03.
>  
> -[2] Devicetree. https://www.devicetree.org, referenced 2016-10-03.
> +[2] Common bindings for device graphs (Devicetree).
> +    https://github.com/devicetree-org/dt-schema/blob/main/schemas/graph.yaml,
> +    referenced 2021-11-30.
>  
> -[3] Documentation/devicetree/bindings/graph.txt
> +[3] DSD Guide. https://github.com/UEFI/DSD-Guide/blob/main/dsd-guide.adoc,
> +    referenced 2021-11-30.
>  
> -[4] Device Properties UUID For _DSD.
> -    https://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf,
> -    referenced 2016-10-04.
> +[4] Advanced Configuration and Power Interface Specification.
> +    https://uefi.org/specifications/ACPI/6.4/, referenced 2021-11-30.
>  
> -[5] Hierarchical Data Extension UUID For _DSD.
> -    https://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf,
> -    referenced 2016-10-04.
> -
> -[6] Advanced Configuration and Power Interface Specification.
> -    https://www.uefi.org/sites/default/files/resources/ACPI_6_1.pdf,
> -    referenced 2016-10-04.
> -
> -[7] _DSD Device Properties Usage Rules.
> +[5] _DSD Device Properties Usage Rules.
>      Documentation/firmware-guide/acpi/DSD-properties-rules.rst
> +
> +[6] Documentation/firmware-guide/acpi/dsd/data-node-references.rst

To make this patch shorter and any improvements cleaner in the future can you
use labeled references instead of numbered? This will reduce a lot of churn.

-- 
With Best Regards,
Andy Shevchenko


