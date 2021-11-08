Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF0A449B69
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Nov 2021 19:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbhKHSJa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Nov 2021 13:09:30 -0500
Received: from mga09.intel.com ([134.134.136.24]:23229 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234728AbhKHSJ3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 8 Nov 2021 13:09:29 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="232136200"
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="232136200"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 10:06:41 -0800
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="451630202"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 10:06:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1mk92I-004oXR-SY;
        Mon, 08 Nov 2021 20:06:26 +0200
Date:   Mon, 8 Nov 2021 20:06:26 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] software node: Skip duplicated software_node sysfs
Message-ID: <YYlnIpGEmLH5GXft@smile.fi.intel.com>
References: <20211101200346.16466-1-quic_qiancai@quicinc.com>
 <CAHp75VcrWPdR8EVGpcsniQedT0J4X700N7thFs6+srTP1MTgwQ@mail.gmail.com>
 <52df4a97-1132-d594-0180-132d0ca714d5@quicinc.com>
 <CAHp75VebOnrce-XZjOnZiivQPz-Cdgq6mor5oiLxK8Y49GiNNg@mail.gmail.com>
 <1269258d-db4c-3922-776b-f11e6a1e338e@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1269258d-db4c-3922-776b-f11e6a1e338e@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 08, 2021 at 11:07:53AM -0500, Qian Cai wrote:
> On 11/5/21 3:39 PM, Andy Shevchenko wrote:
> >> Andy, thanks for the pointers so far. I was able to trace
> >> set_primary_fwnode() and set_secondary_fwnode().
> > 
> > Can you share the trace you have got?

...

> Then, here are the relevant outputs indicating that
> "808622B7:01" and  "xhci-hcd.3.auto" have the same
> primary but different secondaries.

So, it confirms my theory if I'm not mistaken.

Btw, what you can do in this case is to switch to use fwnode_create_software
node and switch them in drd.c. It will be much much easier to achieve then
full kernel refactoring.

> [   11.233280] KK set_secondary_fwnode dev name = 808622B7:01, fwnode = ffff000838618840
> [   11.241846] KK parent = platform
> [   11.245790] KK primary = ffff0008064b9010
> [   11.259838] KK set_primary_fwnode dev name = (null), fwnode = ffff0008064b9010
> [   11.267795] KK parent = 808622B7:01
> [   11.272000] KK fwnode->dev = 808622B7:01
> [   11.276636] KK secondary = ffff000838618840
> [   11.680489] KK set_secondary_fwnode dev name = xhci-hcd.3.auto, fwnode = ffff000838325040
> [   11.689406] KK parent = 808622B7:01
> [   11.693916] KK primary = ffff0008064b9010
> [   11.698763] sysfs: cannot create duplicate filename '/devices/platform/808622B7:01/xhci-hcd.3.auto/software_node'

-- 
With Best Regards,
Andy Shevchenko


