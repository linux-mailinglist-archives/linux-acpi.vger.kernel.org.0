Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D5D24F450
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Aug 2020 10:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgHXIe6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Aug 2020 04:34:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:23150 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728030AbgHXIe5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 24 Aug 2020 04:34:57 -0400
IronPort-SDR: Fi8/nuCJfTynplYK4d+NpXldSoLCN/8BHO1oLEsVv+8457aWDXzQavuKZbYw3NZ6ruNuDbbw76
 e5kCeSsclEFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="173902240"
X-IronPort-AV: E=Sophos;i="5.76,347,1592895600"; 
   d="scan'208";a="173902240"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 01:34:56 -0700
IronPort-SDR: i4VuZti8JNghZZaHsaTSIbsR6me8+5YPBVVnqF/G99dTyy2pCzsPuWAfrFUEFWAAFtEGoG+f6b
 4+jynUUE52Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,347,1592895600"; 
   d="scan'208";a="402248684"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 24 Aug 2020 01:34:53 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 24 Aug 2020 11:34:52 +0300
Date:   Mon, 24 Aug 2020 11:34:52 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM: sleep: core: Fix the handling of pending runtime
 resume requests
Message-ID: <20200824083452.GX1375436@lahna.fi.intel.com>
References: <7969920.MVx1BpXlEM@kreacher>
 <20200821193442.GA264863@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821193442.GA264863@rowland.harvard.edu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On Fri, Aug 21, 2020 at 03:34:42PM -0400, Alan Stern wrote:
> This means that the code could be simplified to just:
> 
> 	pm_runtime_barrier(dev);
> 
> Will this fix the reported bug?  It seems likely to me that the actual 
> problem with the failure scenario in the patch description was that 
> turning on an ACPI power resource causes runtime-resume requests to be 
> queued for all devices sharing that resource.  Wouldn't it make more 
> sense to resume only the device that requested it and leave the others 
> in runtime suspend?

The problem with at least PCIe devices that share ACPI power resources
is that once you turn on the power resource all the devices that shared
it will go into D0uninitialized power state and that means they lose all
wake configuration etc. so they need to be re-initialized by their
driver before they can go back to D3(cold) in order for their wakes to
still work.
