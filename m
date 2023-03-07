Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB856AF604
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Mar 2023 20:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCGTof (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Mar 2023 14:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjCGToD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Mar 2023 14:44:03 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AC22F786;
        Tue,  7 Mar 2023 11:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678217591; x=1709753591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/8xr/6vCKXEptaDSxqxgFJ49+TaHfzYHxqxl/h15CDs=;
  b=A1UVKcc9m9/PS41UP6aQS81ACgiZQV6vFzK6X2cJfa/sUbuUnbUdR+iJ
   l32DWelsXcMC4CNQLcHMrdXi8okIYUwqzp/y66K88d9opdfjXIktwLMZ7
   Jtw2c7tTVI3i7bPpgODrkXEGVRoJorpigDt7BBH4ZkT+JzNyW8pUeuE/1
   9xkVDQU6GjAvTKK8/HGIsyM5fPKuJJK2FIMELTfvuP7uz095J80QEPD93
   7gvLB6kKXIwRjVhtXWxfXoLsg2qzz/OFPdIFvhtKlt/BXV3rEMYr+GHu7
   mXnR7dBNowcAWPyX9Cmw5D7gSBDlT0ReaU9ZIDB5IHBufC1umlGjY76EJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="324261140"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="324261140"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 11:33:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="679063724"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="679063724"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 11:33:09 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 6C51C12160F;
        Tue,  7 Mar 2023 21:33:06 +0200 (EET)
Date:   Tue, 7 Mar 2023 21:33:06 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v5 2/8] ACPI: property: Parse _CRS CSI-2 descriptor
Message-ID: <ZAeRcqwGLno2IDXj@kekkonen.localdomain>
References: <20230208212712.3184953-1-sakari.ailus@linux.intel.com>
 <20230208212712.3184953-3-sakari.ailus@linux.intel.com>
 <CAJZ5v0gcdYN51O7JkuWrY=hjiovGpMNO=ootp147hFqUwb1CXQ@mail.gmail.com>
 <ZAeJznmM3pPQ/Oga@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAeJznmM3pPQ/Oga@kekkonen.localdomain>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 07, 2023 at 09:00:30PM +0200, Sakari Ailus wrote:
> Another option could be to opportunistically initialise a device, and once
> encountering a "mipi-img-port-*" node in _DSD property parsing, bail out
> and postpone initialisation of the device on first namespace traversal.
> This would mean adding some extra error handling in e.g.
> acpi_init_device_object() callers.

What I think could be also done is to collect the handles with these nodes
to a list (requires struct list_head in struct acpi_device) in order to
create the devices after tree traversal.

This approach might be usable for even getting rid of the second pass
altogether, with the tradeoff of requiring a little bit of extra memory.

-- 
Sakari Ailus
