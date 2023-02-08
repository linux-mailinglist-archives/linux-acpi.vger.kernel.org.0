Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F4A68F3A4
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Feb 2023 17:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjBHQo1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 11:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjBHQoU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 11:44:20 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149524ED03;
        Wed,  8 Feb 2023 08:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675874646; x=1707410646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kh+ojvZ6ewps1Bew/oIQ4leqYP22Cqk9o0XzJVM6qyo=;
  b=LaD35gVtKFahVpoUiWqxivcwIv3yI/m/oZJAA1JSoZh+OVXbQVMn2i43
   olFWJEvQooHOC5mx7FEOblDdSlVMf1K/62hFAezn01HJANYRewlcr02tO
   2Zsjzaugmv4I9WbCg7E44g3vnaV3cCTupAfpe5G3XnaYYJmYYY+ux9Nnx
   WIGGhDzDaCzQhKGGL/YFRIWzuhMG5lJpnxvqDsV22A9TXC6XGXFANTUb8
   GIwJK3439yAdxy8X/ThGpZ7UoXxAI7Exwf6TCwzt6nCmtdGlHrV1XE/SV
   Tu3Hwnyv0WUWErk0eTU3t7rHPwUvGj29jR1S4nXpwC7Bxg0vdAFENiqIC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="392244363"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="392244363"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 08:43:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="669243606"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="669243606"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 08 Feb 2023 08:43:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pPnXk-004DHk-1D;
        Wed, 08 Feb 2023 18:43:36 +0200
Date:   Wed, 8 Feb 2023 18:43:36 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v4 2/8] ACPI: property: Parse _CRS CSI-2 descriptor
Message-ID: <Y+PROE+7o8yuoGB6@smile.fi.intel.com>
References: <20230208152807.3064242-1-sakari.ailus@linux.intel.com>
 <20230208152807.3064242-3-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208152807.3064242-3-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 08, 2023 at 05:28:01PM +0200, Sakari Ailus wrote:
> Parse newly added ACPI _CRS CSI-2 descriptor for CSI-2 and camera
> configuration. For now, only figure out where the descriptor is present in
> order to allow adding information from it to related devices.

Nit-picks below that may be ignored. Up to you, guys.

...

> +#define NO_CSI2_PORT (~1U)

A bit unclear why this value. Is it bitfield? Then GENMASK() would be better.
Is it a plain value with a type limit? Then (UINT_MAX - 1) probably the best.

...

> +	ads->nodeptrs = (void *)(ads->nodes +
> +				 ports_count * 2 + 1);

Now this fits one line.

...

> +	handle_refs = kcalloc(csi2_all.handle_count + 1, sizeof(*handle_refs),
> +			      GFP_KERNEL);
> +	if (!handle_refs) {
> +		acpi_handle_debug(handle, "no memory for %zu handle refs\n",
> +				  csi2_all.handle_count + 1);
> +		return;
> +	}

In a code above you used "1 + foo" approach if I'm not mistaken. Why here is
the difference?

...

In some code comments which I removed before remarking you forgot the
grammatical period.

-- 
With Best Regards,
Andy Shevchenko


