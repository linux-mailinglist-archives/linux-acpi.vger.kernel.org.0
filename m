Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241F96CC3DA
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Mar 2023 16:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbjC1O54 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Mar 2023 10:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbjC1O5z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Mar 2023 10:57:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5F8E1B1;
        Tue, 28 Mar 2023 07:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680015472; x=1711551472;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yf/dZqK8obUob428nrSpjkJPjM3/65/ufbLKFfE7hSA=;
  b=Nyr5Uo4SriwBSIYCh7QOO0YVoYvPISU9VY66ewgkRw+EOj6g6iZMslAd
   X8ckwfBx4fgkWuHRw07hgLec6Y0ly0X1lnx0Dah7t1SVbUsos6y9tIyTH
   B23q50vBk81HMP7dszXC91zx35SCs0Ne58ER7ufZjVQ42kiBLcinSqRrg
   GkTLmgo4xoHbfrZdsES8e0+vDfzEqg/wAfOa1gLO2ufLU/ffBMZquBp3U
   jHfQs4TmfwzSYyencT5d8qbOwSoPrvKzAXVMzQSPmcpf3LnQrue3BUSNa
   //n1ERB1AsPxPvOZRhIQih5/vEprN66ix66tbHzgtQqw5sPwsRvKiZ1tX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="342995163"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="342995163"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 07:55:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="661194941"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="661194941"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 07:55:57 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 9F0BF11F9EE;
        Tue, 28 Mar 2023 17:55:54 +0300 (EEST)
Date:   Tue, 28 Mar 2023 17:55:54 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v7 01/10] ACPI: scan: Remove the second DSDT traversal
Message-ID: <ZCL/+sOjTVnAzA3n@kekkonen.localdomain>
References: <20230328101303.1458570-1-sakari.ailus@linux.intel.com>
 <20230328101303.1458570-2-sakari.ailus@linux.intel.com>
 <ZCL9eWARHqzYuQyV@smile.fi.intel.com>
 <ZCL+QxYmVzFzVe1E@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCL+QxYmVzFzVe1E@kekkonen.localdomain>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 28, 2023 at 05:48:35PM +0300, Sakari Ailus wrote:
> > > +/**
> > > + * acpi_bus_handle_postpone - Add an ACPI handle to a given postponed list
> > > + * @handle: The ACPI handle
> > > + * @head: Postponed list head
> > > + *
> > > + * Add a given ACPI handle to a list of ACPI objects for which the creation
> > > + * of the device objects is to be postponed.
> > 
> > `kernel-doc -v ...` complains on the absence of Return section. Is it the same
> > for you?
> 
> That may well be. These comments wouldn't necessarily even need to be
> kernel-doc as the rest isn't so documented either. I can of course fix the
> error while leaving these kernel-doc.

No warning is produced here. That would seem like a false positive as the
function returns void.

-- 
Sakari Ailus
