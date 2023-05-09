Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EAF6FD00B
	for <lists+linux-acpi@lfdr.de>; Tue,  9 May 2023 22:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbjEIUuX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 May 2023 16:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235381AbjEIUtv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 May 2023 16:49:51 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CF86587;
        Tue,  9 May 2023 13:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683665367; x=1715201367;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=E51vTbxqfe9pTuaL+Otbb55IlTlhk/XxE5WfOD7sxvM=;
  b=kgPbwS+Kgx64cnUDLx8zo9RN8t32TPiRWYFKjVxCrntPvVhbxbIpD6NL
   lf0Rv6sB3w96T6Y3o64RmWCzRBlkhiiARvAfttVdF5ro7VnCHmvPSmC3/
   vECq+J0MXtWKwXd+HVx6ojmgqq8lp+vfdTAeuzVs9Uyi2l8Ab2HaEV+aL
   DviE4OomBcWe3egF9BYZUIFv2Mg5V2P0r5G9Cd1VqT+gBe1yuF+h1Cae1
   PB8GRvwiWkC648tm90QNsEBsr3WuDqmrowQmDIZvNBugt06uNmDI6FRpx
   YJnp+nIAS8ge9U+h0wgnJV80bq7Jg6F/+UTUsW4B64Ubo7tsr6Rgkl3oM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="350081313"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="350081313"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 13:49:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="649486471"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="649486471"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 13:49:24 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id B5BD612279B;
        Tue,  9 May 2023 23:49:21 +0300 (EEST)
Date:   Tue, 9 May 2023 23:49:21 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v8 01/10] ACPI: scan: Remove the second DSDT traversal
Message-ID: <ZFqx0SB71Ht3IpQ3@kekkonen.localdomain>
References: <20230329100951.1522322-1-sakari.ailus@linux.intel.com>
 <20230329100951.1522322-2-sakari.ailus@linux.intel.com>
 <CAJZ5v0gzSjDS16Sq9oAs_9BSEgmM6VPPFF4vrd2cyK++UP7=_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gzSjDS16Sq9oAs_9BSEgmM6VPPFF4vrd2cyK++UP7=_w@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

Thank you for the review.

On Tue, May 09, 2023 at 08:06:28PM +0200, Rafael J. Wysocki wrote:
> On Wed, Mar 29, 2023 at 12:10 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Collect the devices with _DEP into a list and continue processing them
> > after a full traversal, instead of doing a full second traversal of the
> > tree.
> >
> > This makes the second DSDT traversal pass unnecessary as we already have
> > the nodes we're interested in in a linked list.
> 
> The second traversal of the ACPI namespace (it may not be just the
> DSDT at that point to be precise) is not really about _DEP handling.
> In fact, the latter has been added on top of it.
> 
> It is about the PCI enumeration.  Namely, when acpi_pci_root_add()
> runs for the PCI host bridge object in the ACPI namespace, the entire
> device hierarchy below it is walked and all of the ACPI device objects
> corresponding to the PCI devices on the bus are assumed to be present.
> This means that all of the ACPI device objects need to be created in
> the first walk, without binding any ACPI drivers or scan handlers to
> them, and the second walk is to find out what is actually represented
> by those objects.
> 
> It cannot be eliminated in any simple way.

My understanding still remains that this patch does not (or other patches
in this set) change the above. It is just how those nodes are reached:
instead of traversing the entire tree and ignoring the devices that have
already an acpi_device created for them, a linked list of devices of
interest is traversed.

Of course it is possible that I have missed something. The codebase isn't
entirely trivial.

-- 
Kind regards,

Sakari Ailus
