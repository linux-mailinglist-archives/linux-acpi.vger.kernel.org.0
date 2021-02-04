Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38F630ED7D
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Feb 2021 08:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbhBDHiC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Feb 2021 02:38:02 -0500
Received: from mga12.intel.com ([192.55.52.136]:61646 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233516AbhBDHiA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 4 Feb 2021 02:38:00 -0500
IronPort-SDR: 3YpOSGzAIzevr1DeNg1PwWKElauNL1cmdVf8A3L0TkopclIYNaiJ2p7Y4T8Qltz49IAMDub/Nz
 NwABROudmJrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="160354500"
X-IronPort-AV: E=Sophos;i="5.79,400,1602572400"; 
   d="scan'208";a="160354500"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 23:36:14 -0800
IronPort-SDR: 1HE0D11MqGxuB/vnTvyxjHd+ignk8EZOayxRZLyOtVDFkMzlY7jUQPJMZyeM6vwRMKAUieXTF5
 trf1zBjVQfsQ==
X-IronPort-AV: E=Sophos;i="5.79,400,1602572400"; 
   d="scan'208";a="357080066"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 23:36:08 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 04 Feb 2021 09:36:07 +0200
Date:   Thu, 4 Feb 2021 09:36:07 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Christian Kellner <christian@kellner.me>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] ACPI: Execute platform _OSC also with query bit
 clear
Message-ID: <20210204073607.GM2542@lahna.fi.intel.com>
References: <20210129083241.72497-1-mika.westerberg@linux.intel.com>
 <20210129083241.72497-4-mika.westerberg@linux.intel.com>
 <20210203081415.GR2542@lahna.fi.intel.com>
 <CAJZ5v0jG3abpNjVorHLx5nNt964QNA+v=uBx-M4r_May0ZfEgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jG3abpNjVorHLx5nNt964QNA+v=uBx-M4r_May0ZfEgA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 03, 2021 at 02:56:25PM +0100, Rafael J. Wysocki wrote:
> On Wed, Feb 3, 2021 at 9:16 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > Hi Rafael,
> >
> > I wonder if you are OK with this patch?
> 
> It looks good to me now, please feel free to add my ACK to it.

Thanks!
