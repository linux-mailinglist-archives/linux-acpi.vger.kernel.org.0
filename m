Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80B6245AD5
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Jun 2019 12:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfFNKpP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Jun 2019 06:45:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:1446 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbfFNKpP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Jun 2019 06:45:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 03:45:14 -0700
X-ExtLoop1: 1
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 14 Jun 2019 03:45:12 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 14 Jun 2019 13:45:11 +0300
Date:   Fri, 14 Jun 2019 13:45:11 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Furquan Shaikh <furquan@google.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        rajatja@google.com
Subject: Re: [PATCH] ACPI: PM: Clear wake-up device GPEs before enabling
Message-ID: <20190614104511.GC2640@lahna.fi.intel.com>
References: <20190516193616.252788-1-furquan@google.com>
 <13361760.nMXA0SR1Mq@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13361760.nMXA0SR1Mq@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 13, 2019 at 10:24:41PM +0200, Rafael J. Wysocki wrote:
> This patch may cause events to be missed if the GPE.  I guess what you reall mean is
> something like the patch below.
> 
> This should allow the kernel to see the events generated before the GPEs are
> implicitly enabled, but it should clear them for the explicit users of acpi_enable_gpe().
> 
> Mika, what do you think?

Looks good to me. I also tested this with two TBT systems (Skull Canyon
NUC and Dell XPS 9370) using ACPI hotplug and it did not cause any
problems if I boot the system with device connected.
