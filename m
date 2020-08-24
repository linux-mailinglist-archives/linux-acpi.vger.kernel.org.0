Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8E524FF62
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Aug 2020 15:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgHXN7P (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Aug 2020 09:59:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:50751 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbgHXN7P (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 24 Aug 2020 09:59:15 -0400
IronPort-SDR: ck4KHr0GO047tbCIxhmDsmvkoiqgTt4tP1032qn29B05m+IrXvL7Cvy/gvvDtV00MP8UcnScDh
 LDEK2iabOLQw==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="143548622"
X-IronPort-AV: E=Sophos;i="5.76,348,1592895600"; 
   d="scan'208";a="143548622"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 06:59:13 -0700
IronPort-SDR: reFZjxq2YJRZLdfWlm2zwZelqtOY4FgNL+iJsBpyepv/3glq4dFSS7iUojrEqH2YVj3KaNrudO
 aL9CCrVS+yHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,348,1592895600"; 
   d="scan'208";a="402358973"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 24 Aug 2020 06:59:10 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 24 Aug 2020 16:59:09 +0300
Date:   Mon, 24 Aug 2020 16:59:09 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM: sleep: core: Fix the handling of pending runtime
 resume requests
Message-ID: <20200824135909.GL1375436@lahna.fi.intel.com>
References: <7969920.MVx1BpXlEM@kreacher>
 <20200821193442.GA264863@rowland.harvard.edu>
 <20200824083452.GX1375436@lahna.fi.intel.com>
 <2486532.D7zGhtygOF@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2486532.D7zGhtygOF@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 24, 2020 at 03:38:39PM +0200, Rafael J. Wysocki wrote:
> BTW, does the patch make the issue at hand go away?

I asked the folks who have this particular hardware to try it out as I
don't have access to this one. Hopefully we get the results back soon
and once we do, I'll let you know.
