Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A32768FA2A
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Feb 2023 23:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjBHWQq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 17:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjBHWQn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 17:16:43 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEFA3755D;
        Wed,  8 Feb 2023 14:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675894598; x=1707430598;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l3HMKANKT06QhSwevMDgDpXf1tEHYJtuiJZ0WpFg+0s=;
  b=Qxufv5ef15jO3eD8E+vGs90hZd+HmgjanmeLBvuxrF9D8Zo1OOGmrZV/
   2JlPcDYwYmAGwU8N2M/5zDm7tMSKvssPxqET/3MF+VPZ4syrILhWadJ36
   Hf+2bLK53bQ7YW0ld5xqHyCb50ITkiA0nGOJ9W+3HbPqr8rEAysgfvTKO
   GizXtDSfQuPQ2+XplghiCEDeGfgdDbUwKo8KDz1ZJMa0vDWpmQ9DxY/eo
   4Mp7wub7ey0OcSLPfPdHV85QkE3ggZYe9Wg4PWt0F2Xgz9GKYlJxAmd2N
   roIb2Pm4gVQXnXHB3Vt5/Zitu4UkoQzfrpoGoYch/ZCoeWSbDv9jqPK0e
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="394534481"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="394534481"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 14:16:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="810093623"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="810093623"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 14:16:36 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 95F4D1218E2;
        Thu,  9 Feb 2023 00:16:33 +0200 (EET)
Date:   Thu, 9 Feb 2023 00:16:33 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-acpi@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        linux-media@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v4 2/8] ACPI: property: Parse _CRS CSI-2 descriptor
Message-ID: <Y+QfQUflAJHmFI1l@kekkonen.localdomain>
References: <20230208152807.3064242-3-sakari.ailus@linux.intel.com>
 <202302090442.og7NHYTZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202302090442.og7NHYTZ-lkp@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Feb 09, 2023 at 04:43:45AM +0800, kernel test robot wrote:
> >> drivers/acpi/mipi.c:205:6: warning: no previous prototype for 'acpi_crs_csi2_alloc_fill_swnodes' [-Wmissing-prototypes]
>      205 | void acpi_crs_csi2_alloc_fill_swnodes(size_t ports_count, acpi_handle handle)

I was wondering what wast the actual problem here as having no prototype
isn't an issue really. The function should have been static, of course.
I'll address this in v6, but waiting for other comments for now.

-- 
Sakari Ailus
