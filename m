Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEE16154BBA
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Feb 2020 20:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbgBFTOi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Feb 2020 14:14:38 -0500
Received: from mga09.intel.com ([134.134.136.24]:61764 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgBFTOh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 6 Feb 2020 14:14:37 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 11:14:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,410,1574150400"; 
   d="scan'208";a="345087488"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 06 Feb 2020 11:14:33 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 06 Feb 2020 21:14:33 +0200
Date:   Thu, 6 Feb 2020 21:14:33 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.de>,
        Guenter Roeck <linux@roeck-us.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, Tom Abraham <tabraham@suse.com>
Subject: Re: Forcing non-ACPI watchdog driver
Message-ID: <20200206191433.GU2667@lahna.fi.intel.com>
References: <1580915129.23547.3.camel@suse.de>
 <20200205152435.GE2667@lahna.fi.intel.com>
 <20200205163048.GD25403@roeck-us.net>
 <20200205163831.GG2667@lahna.fi.intel.com>
 <20200206154532.359086d6@endymion>
 <20200206145602.GQ2667@lahna.fi.intel.com>
 <CAJZ5v0i5+DaFM22jW=dS66JHK5=ydvMf4dBuJTMvGoNSZLOL3Q@mail.gmail.com>
 <CAJZ5v0hOyVNt0up7kErOnFSeCu0yu=MhJp-Yqo4+M49W0bgZbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hOyVNt0up7kErOnFSeCu0yu=MhJp-Yqo4+M49W0bgZbw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Feb 06, 2020 at 05:00:43PM +0100, Rafael J. Wysocki wrote:
> So queued up now (with very minor changes in the subject and
> changelog), but I will rebase it on top of -rc1 when it is out.

Thanks!
