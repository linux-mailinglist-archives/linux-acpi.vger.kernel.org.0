Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4135539E20F
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jun 2021 18:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbhFGQPE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Jun 2021 12:15:04 -0400
Received: from mga07.intel.com ([134.134.136.100]:13356 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231660AbhFGQOn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Jun 2021 12:14:43 -0400
IronPort-SDR: xJg8cG6rRa0qWa0oJtQFo6DawrpOoJ3rb+hHe6A6pSwePtctoIJawAUXqnopFi0ypnmdd/mbVk
 VFmq0ln2hH/Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="268508856"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="268508856"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 09:11:05 -0700
IronPort-SDR: YbmSNma6iUqC07OzWNUuxi1hbN8G5FrRJ110wp3qsnaAmURg7PCHpA5GcZ/GnIqdx+anLH7QGB
 dGU5MWzhugig==
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="447537317"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 09:11:01 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 07 Jun 2021 19:10:59 +0300
Date:   Mon, 7 Jun 2021 19:10:59 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     joeyli <jlee@suse.com>
Cc:     linux-usb@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Christian Kellner <christian@kellner.me>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org, iqgrande@gmail.com
Subject: Re: [PATCH v2 3/5] ACPI: Execute platform _OSC also with query bit
 clear
Message-ID: <YL5FExiUMfHi+K/X@lahna.fi.intel.com>
References: <20210129083241.72497-1-mika.westerberg@linux.intel.com>
 <20210129083241.72497-4-mika.westerberg@linux.intel.com>
 <20210203081415.GR2542@lahna.fi.intel.com>
 <20210607123110.GE22028@linux-l9pv.suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607123110.GE22028@linux-l9pv.suse>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On Mon, Jun 07, 2021 at 08:31:10PM +0800, joeyli wrote:
> Hi Mika,
> 
> There have some machines be found on openSUSE Tumbleweed that this patch
> causes that SSDT tables can not be dynamic loaded. The symptom is that
> dmesg shows '_CPC not found' because SSDT table did not dynamic load.
> 
> [    1.149107] ACPI BIOS Error (bug): Could not resolve symbol [\_PR.PR00._CPC], AE_NOT_FOUND (20210105/psargs-330)
> 
> Looks that the firmware didn't response OSC_SB_CPCV2_SUPPORT after
> kernel changed to new behavior. The openSUSE bug is here:
> 
> Bug 1185513 - ACPI BIOS Error after upgrade to 5.12.0-1-default 
> https://bugzilla.suse.com/show_bug.cgi?id=1185513
> 
> Could you please help to give any suggestion?

There is another one that Red Hat reported here:

https://bugzilla.kernel.org/show_bug.cgi?id=213023

The Bugzilla entry also has a patch attached [1] from Hans, can you try it
out and see if that fixes the issue?

[1] https://bugzilla.kernel.org/attachment.cgi?id=297195

Thanks!
