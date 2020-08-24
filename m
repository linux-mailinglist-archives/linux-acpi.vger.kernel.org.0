Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F2C24FF83
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Aug 2020 16:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgHXOGm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Aug 2020 10:06:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:37576 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgHXOGk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 24 Aug 2020 10:06:40 -0400
IronPort-SDR: a76nrZMX8q/VMZ5InxF4Xb7ZcyNtsDVbaKdBcZcJJD5mUcj3LPex07kzO280VJjTRmsvt9JLgT
 rvV9ocQPAblQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="220172282"
X-IronPort-AV: E=Sophos;i="5.76,348,1592895600"; 
   d="scan'208";a="220172282"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 07:06:39 -0700
IronPort-SDR: UBR208y2ztdF68uc9x4G9cEXpxmIXaqhRHB9iWgBhRLQTwUz19Vli6EmcDgV967+6uowTFo/es
 Ydleu/4Usebg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,348,1592895600"; 
   d="scan'208";a="402362192"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 24 Aug 2020 07:06:36 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 24 Aug 2020 17:06:35 +0300
Date:   Mon, 24 Aug 2020 17:06:35 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        "Kenneth R. Crudup" <kenny@panix.com>
Subject: Re: [PATCH] ACPI: OSL: Prevent acpi_release_memory() from returning
 too early
Message-ID: <20200824140635.GN1375436@lahna.fi.intel.com>
References: <6142241.0H6QnnlUA7@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6142241.0H6QnnlUA7@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 21, 2020 at 07:42:55PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After commit 1757659d022b ("ACPI: OSL: Implement deferred unmapping
> of ACPI memory") in some cases acpi_release_memory() may return
> before the target memory mappings actually go away, because they
> are released asynchronously now.
> 
> Prevent it from returning prematurely by making it wait for the next
> RCU grace period to elapse, for all of the RCU callbacks to complete
> and for all of the scheduled work items to be flushed before
> returning.
> 
> Fixes: 1757659d022b ("ACPI: OSL: Implement deferred unmapping of ACPI memory")
> Reported-by: Kenneth R. Crudup <kenny@panix.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
