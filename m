Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AE966E0DD
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jan 2023 15:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjAQOfp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Jan 2023 09:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbjAQOfX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2023 09:35:23 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CB63EFE6;
        Tue, 17 Jan 2023 06:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673966116; x=1705502116;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HNMnGpnGaj1VF+Aiwv/vzdZKqavF6q+jFpmzcTCad7Q=;
  b=RNmVah9R4EcZNzCk4HZ/GdNCa9WHvzRm52VuPe50Queeewphgm8SHZaf
   6B1h16Y++6wota2mcPF7BxaswRhzDhpLfkML298g9668DnMYdTLq8qBJq
   PGu1vbFNR5CokK7ZSIT+NWupDIQcEkBSsnlWWpp9ZW0vY0V0nhlUmtvpk
   lrzYk5xFVaLh49v72IlE3BAZmXGlplrzPfEQh03RGIP8n+R8dRev2MWHo
   SYk5XvGrZh0lMwJbodytU7FyzLZExEvIMu4CiTO+LZeXiQXO9glkk32bj
   ewPPpgCnTruh1SVHcdOaHTg/oHyNg3ZgDcDpiLRF6nxeLlQfqEnU2RKbd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="325982384"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="325982384"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 06:35:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="652568298"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="652568298"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 17 Jan 2023 06:35:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pHn3P-00AcEm-0O;
        Tue, 17 Jan 2023 16:35:11 +0200
Date:   Tue, 17 Jan 2023 16:35:10 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        linux-media@vger.kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH 3/8] device property: Add SOFTWARE_NODE() macro for
 defining software nodes
Message-ID: <Y8ayHuBaK2CZa0LD@smile.fi.intel.com>
References: <20230117122244.2546597-1-sakari.ailus@linux.intel.com>
 <20230117122244.2546597-4-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117122244.2546597-4-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 17, 2023 at 02:22:39PM +0200, Sakari Ailus wrote:
> Add SOFTWARE_NODE() macro in order to make defining software nodes look
> nicer. This is analogous to different PROPERTY_ENTRY_*() macros for
> defining properties.

...

> +#define SOFTWARE_NODE(_name_, _properties_, _parent_)	\
> +	(struct software_node) {			\

> +		.name = _name_,				\
> +		.properties = _properties_,		\
> +		.parent = _parent_,			\

Missed parentheses?

> +	}

Otherwise LGTM.

-- 
With Best Regards,
Andy Shevchenko


