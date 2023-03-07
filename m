Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D106AF4C2
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Mar 2023 20:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbjCGTTk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Mar 2023 14:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjCGTTZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Mar 2023 14:19:25 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFC831E17;
        Tue,  7 Mar 2023 11:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678215785; x=1709751785;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/qHYNPrtnGNUaJtPWZh2fXlUM4FK8sV2UsH360n0VB0=;
  b=AhLgQQZ2rzGIcwX0kLphdrKIjIjUruoJ3OMTPbU9DrTBxtAPfH8IZiXQ
   hi8+xVti3uCW7PoUQtzsn9Dw7EZJRzb8KyQFMMRs9jRBat119gxeUi9jj
   w4lyjYnC9GEVtyZ1uxA8utg3UUlAzakkFl5A+cMa/1ulRo1xqR/S5ooeZ
   AU/Zkn9tw5cIRG+Zpvv9nZNoj8K3UtcnlLrOk0GC3UusUIste22Cj0SHq
   gdfl6pWHvELhXfzCDALn1EVPfqjb1rTqz+P2TTUXhdFB6+/wLwbzPKasl
   rEmHBeqPoXPgdNGuUS0b9kIbm+nWm5ccUdzbrbqnJrp8bMCAMNwkyAbh6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="319772496"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="319772496"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 11:02:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="850812332"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="850812332"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 11:02:45 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 33A4912160F;
        Tue,  7 Mar 2023 21:02:40 +0200 (EET)
Date:   Tue, 7 Mar 2023 21:02:40 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v5 2/8] ACPI: property: Parse _CRS CSI-2 descriptor
Message-ID: <ZAeKUDOx3+19gWXH@kekkonen.localdomain>
References: <20230208212712.3184953-1-sakari.ailus@linux.intel.com>
 <20230208212712.3184953-3-sakari.ailus@linux.intel.com>
 <CAJZ5v0gcdYN51O7JkuWrY=hjiovGpMNO=ootp147hFqUwb1CXQ@mail.gmail.com>
 <ZAeJznmM3pPQ/Oga@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAeJznmM3pPQ/Oga@kekkonen.localdomain>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 07, 2023 at 09:00:30PM +0200, Sakari Ailus wrote:
> Hi Rafael,
> 
> On Tue, Mar 07, 2023 at 02:38:43PM +0100, Rafael J. Wysocki wrote:
> > Note: The report from Dan Carpenter has not been addressed.
> 
> I'll reply to Dan --- it's a false positive.

Ah, it isn't. I'll address it for v6.

-- 
Sakari Ailus
