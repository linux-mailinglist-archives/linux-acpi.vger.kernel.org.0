Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5346CC3E9
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Mar 2023 16:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbjC1O6V (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Mar 2023 10:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbjC1O6P (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Mar 2023 10:58:15 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A97E1B8;
        Tue, 28 Mar 2023 07:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680015492; x=1711551492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7fPOIVZSj3TCOVHNpPirZFp1vZjCF6d5kjRz6Qcnziw=;
  b=l/UDuprClahBfn4/g9gvjd8H/H/+XcBiAKSvJ3dVZKvA0Y/+VPvicyvB
   vEdnQcBdHeFBiukst8FtJjDIEwnPyb9EDM+PmzuTegRaC8QrlOVIbt6s3
   itZlLbqrCnOQgtFQ9JUf8k3fQm3/iHdboDWEIlqSJzRYUIkbRS52Nu2B1
   shSGkkn+D+TrX8KJ7CNCDzt8H/2gfCm6tHV1AYNKGnG8bSdjGSPfHSduI
   HsTK3oXol4sJ+GyqqkC4IdzE50jg4zcgCWsI/SFE290KXH4K18Z7Vt5YO
   0W2JWoWGsStTToHYU6VD8mt6b6LAltETi36B9IQ+Wm40Yecq4/AGqf96z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="342995442"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="342995442"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 07:56:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="634075053"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="634075053"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 07:56:57 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 4330011F937;
        Tue, 28 Mar 2023 17:48:35 +0300 (EEST)
Date:   Tue, 28 Mar 2023 17:48:35 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v7 01/10] ACPI: scan: Remove the second DSDT traversal
Message-ID: <ZCL+QxYmVzFzVe1E@kekkonen.localdomain>
References: <20230328101303.1458570-1-sakari.ailus@linux.intel.com>
 <20230328101303.1458570-2-sakari.ailus@linux.intel.com>
 <ZCL9eWARHqzYuQyV@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCL9eWARHqzYuQyV@smile.fi.intel.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

Thank you for the review.

On Tue, Mar 28, 2023 at 05:45:13PM +0300, Andy Shevchenko wrote:
> On Tue, Mar 28, 2023 at 01:12:54PM +0300, Sakari Ailus wrote:
> > Collect the devices with _DEP into a list and continue processing them
> > after a full traversal, instead of doing a full second traversal of the
> > tree.
> > 
> > This makes the second DSDT traversal pass unnecessary as we already have
> > the nodes we're interested in in a linked list.
> 
> ...
> 
> > +/**
> > + * struct acpi_postponed_handle - A postponed ACPI handle
> > + * @handle: The postponed handle
> > + * @list: Entry in a postponed list
> > + *
> > + * One such entry represents an ACPI handle the scanning of which has been
> > + * postponed.
> > + */
> > +struct acpi_postponed_handle {
> > +	acpi_handle handle;
> > +	struct list_head list;
> > +};
> 
> If you put the list to be the first member, container_of() against it becomes a
> no-op at compile time. Have you checked the code generation if you swap these
> members?

I haven't checked but that would seem like a reasonable thing to do. A
pointer to the handle isn't used, unlike it is for the list.

> 
> > +/**
> > + * struct acpi_scan_context - Context for scanning ACPI devices
> > + * @device: The first encountered device, typically the root of the scanned tree
> > + * @postponed_head: The list head of the postponed ACPI handles
> > + */
> > +struct acpi_scan_context {
> > +	struct acpi_device *device;
> > +	struct list_head postponed_head;
> > +};
> 
> Ditto.
> 
> ...
> 
> > +/**
> > + * acpi_bus_handle_postpone - Add an ACPI handle to a given postponed list
> > + * @handle: The ACPI handle
> > + * @head: Postponed list head
> > + *
> > + * Add a given ACPI handle to a list of ACPI objects for which the creation
> > + * of the device objects is to be postponed.
> 
> `kernel-doc -v ...` complains on the absence of Return section. Is it the same
> for you?

That may well be. These comments wouldn't necessarily even need to be
kernel-doc as the rest isn't so documented either. I can of course fix the
error while leaving these kernel-doc.

-- 
Kind regards,

Sakari Ailus
