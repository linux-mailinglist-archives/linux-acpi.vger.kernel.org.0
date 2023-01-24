Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772A5679E01
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jan 2023 16:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbjAXPyG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Jan 2023 10:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjAXPyG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jan 2023 10:54:06 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4480F47EDE;
        Tue, 24 Jan 2023 07:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674575645; x=1706111645;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H3zPqbv+ZDrlbEa+l2wWi8EQBaBRzTzGbvV/PRP5/6Q=;
  b=DUD15fHkDGu7N5LkqVFFEj8hffanuZUCl2QLAeM3hUCyH7NDEtBJjmES
   XjhR4HW8o0XdJP/1tiWDSISpXluXVK6piA3NNjCwmtX47KZhRFtE8/4eC
   CuufLezB3oAMsxWrfatIjdIZapaBfjLzfiPI3eTOh7vCiNsTWpzepqgv/
   cEeMTj0sTAHhAQRPShwPAYxSAuNIzmgBNdQhGkSMerQ2nUxcNLyPwuDrI
   O1DQjmb5NG0ukwIKf45174oXofZbh3ACFYtLuYXYV/Kc5CmHxIax3CvKo
   zsRteI/D7iU9WaVxuh/jIPss14g/0B1U1nOtLnKIoF8zSigkJRKp5lIic
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="327582418"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="327582418"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 07:54:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="692629996"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="692629996"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 07:54:03 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 7F4A3122501;
        Tue, 24 Jan 2023 17:54:00 +0200 (EET)
Date:   Tue, 24 Jan 2023 17:54:00 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v2 7/8] ACPI: property: Skip MIPI property table without
 "mipi-img" prefix
Message-ID: <Y8//GN6Eud77cicF@kekkonen.localdomain>
References: <20230123134617.265382-1-sakari.ailus@linux.intel.com>
 <20230123134617.265382-8-sakari.ailus@linux.intel.com>
 <Y86ncn54H30xyjJU@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y86ncn54H30xyjJU@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 23, 2023 at 05:27:46PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 23, 2023 at 03:46:16PM +0200, Sakari Ailus wrote:
> > For all _DSD properties, skip going through the MIPI DisCo for Imaging
> > property name substitution table if the property doesn't have "mipi-img-"
> > prefix.
> 
> ...
> 
> > -	{ "mipi-img-lens-focus", "lens-focus" },
> > -	{ "mipi-img-flash-leds", "flash-leds" },
> > -	{ "mipi-img-clock-frequency", "clock-frequency" },
> > -	{ "mipi-img-led-max-current", "led-max-microamp" },
> > -	{ "mipi-img-flash-max-current", "flash-max-microamp" },
> > -	{ "mipi-img-flash-max-timeout", "flash-max-timeout-us" },
> > +	{ MIPI_IMG_PREFIX "lens-focus", "lens-focus" },
> > +	{ MIPI_IMG_PREFIX "flash-leds", "flash-leds" },
> > +	{ MIPI_IMG_PREFIX "clock-frequency", "clock-frequency" },
> > +	{ MIPI_IMG_PREFIX "led-max-current", "led-max-microamp" },
> > +	{ MIPI_IMG_PREFIX "flash-max-current", "flash-max-microamp" },
> > +	{ MIPI_IMG_PREFIX "flash-max-timeout", "flash-max-timeout-us" },
> 
> I don't thing it ads to the readability, so I don't know why this (part of the)
> change is needed.

Ok, I'll drop this chunk.

-- 
Sakari Ailus
