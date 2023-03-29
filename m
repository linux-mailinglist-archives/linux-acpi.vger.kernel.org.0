Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0278F6CEBE8
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Mar 2023 16:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjC2Oms (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Mar 2023 10:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjC2Omh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2023 10:42:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF06527C;
        Wed, 29 Mar 2023 07:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680100798; x=1711636798;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3NttE5BNRRHkYv8L0n4zDMIxvYTz4HVcbyOMOkKTkhM=;
  b=ROmox7AtzT/bY4JpSOj76hihYY7MxSLHt+4CqwBnlzNeZNwI4L5d96QW
   Reb380vTgj+0zI1b9a7AIgao4cGqiW8J2FQsywdHpKdDNoWGpFuTSa1BE
   pqT4vOV9QWM6wRN7X3qucbZhh+sd9s+yhmw0q2RAejpfv5BFiCB1CZmY7
   ZPHPxfBJrmL5ZuGcDklwIK8UwqiF518qJt4lbDstdsdoO39Kf2Xjf4F3q
   mdRvin9VPqDy+A6FwHQd8OPRvA7DV/dMpx61CjygWMl00ZXj54XP7eE3L
   HLXoElelyt1kjBx5srHZIHquW8pUpe1nyZfS4SfPUtJsRROoHkojZJV4i
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="324797641"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="324797641"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 07:39:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="661621396"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="661621396"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 29 Mar 2023 07:39:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1phWxu-00A3xf-2h;
        Wed, 29 Mar 2023 17:39:54 +0300
Date:   Wed, 29 Mar 2023 17:39:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v8 05/10] ACPI: property: Prepare generating swnodes for
 ACPI and DisCo for Imaging
Message-ID: <ZCRNurnKqOgF2PJV@smile.fi.intel.com>
References: <20230329100951.1522322-1-sakari.ailus@linux.intel.com>
 <20230329100951.1522322-6-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329100951.1522322-6-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 29, 2023 at 01:09:46PM +0300, Sakari Ailus wrote:
> Prepare generating software nodes for information parsed from ACPI _CRS for
> CSI-2 as well as MIPI DisCo for Imaging spec. The software nodes are
> compliant with existing ACPI or DT definitions and are parsed by relevant
> drivers without changes.

There is discussion is ongoing in the previous version of the series for this
patch.

-- 
With Best Regards,
Andy Shevchenko


