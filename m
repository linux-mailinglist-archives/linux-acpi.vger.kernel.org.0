Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557CA29EC65
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 14:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgJ2NDN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 09:03:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:14589 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgJ2NDN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Oct 2020 09:03:13 -0400
IronPort-SDR: TkP6MwqawPcDnjHFMMmoLIhkNfj7Cc9P4/5W839ZUi/OJCD1sRTOyF6MyRR8YgWRQZUYuudbpo
 p0MFzarfXkew==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="156198413"
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="156198413"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 06:01:09 -0700
IronPort-SDR: 3qgQPkOoGiuutHD8VQ1/Hu9BIIB3Y9S/rb3NSoV/a2yephauLRYags68xLj91KBtA06KyyQn7X
 q5xTzf5YHR2w==
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="525500863"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 06:01:07 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id E955220736; Thu, 29 Oct 2020 15:01:05 +0200 (EET)
Date:   Thu, 29 Oct 2020 15:01:05 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCHv2 1/3] software node: Power management operations for
 software nodes
Message-ID: <20201029130105.GM26150@paasikivi.fi.intel.com>
References: <20201029105941.63410-1-heikki.krogerus@linux.intel.com>
 <20201029105941.63410-2-heikki.krogerus@linux.intel.com>
 <20201029111303.GL26150@paasikivi.fi.intel.com>
 <20201029115113.GA2288851@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029115113.GA2288851@kuha.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 29, 2020 at 01:51:13PM +0200, Heikki Krogerus wrote:
> On Thu, Oct 29, 2020 at 01:13:03PM +0200, Sakari Ailus wrote:
> > These functions are doing pretty much the same thing but with different
> > parameters. How about implementing a macro or a few, which would take all
> > the parameters as arguments and return the function to call? A few variants
> > may be needed. Individual functions performing different tasks would become
> > very simple.
> 
> I would prefer to do that as the second step, if you guys don't mind.
> I think this was already talked about, but maybe only internally.
> Those macros should then be used also in other places where the same
> steps are being executed, for example in drivers/base/power/domain.c.

Works for me.

For the set:

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
