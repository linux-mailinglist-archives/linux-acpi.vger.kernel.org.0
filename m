Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A583604DC
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jul 2019 12:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfGEK6U (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Jul 2019 06:58:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:64051 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728715AbfGEK6U (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 5 Jul 2019 06:58:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2019 03:58:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,454,1557212400"; 
   d="scan'208";a="185152474"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 05 Jul 2019 03:58:16 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 05 Jul 2019 13:58:15 +0300
Date:   Fri, 5 Jul 2019 13:58:15 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Yehezkel Bernat <yehezkelshb@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2/8] thunderbolt: Move NVM upgrade support flag to struct
 icm
Message-ID: <20190705105815.GT2640@lahna.fi.intel.com>
References: <20190705095800.43534-1-mika.westerberg@linux.intel.com>
 <20190705095800.43534-3-mika.westerberg@linux.intel.com>
 <CA+CmpXt5q93e2TQJzfY4afSEMPWijPU+Ks+cgrVDVqUM4=y3Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CmpXt5q93e2TQJzfY4afSEMPWijPU+Ks+cgrVDVqUM4=y3Cw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 05, 2019 at 01:52:49PM +0300, Yehezkel Bernat wrote:
> > @@ -2054,6 +2059,7 @@ struct tb *icm_probe(struct tb_nhi *nhi)
> >         case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_NHI:
> >         case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_NHI:
> >                 icm->max_boot_acl = ICM_AR_PREBOOT_ACL_ENTRIES;
> > +               icm->can_upgrade_nvm = true;
> 
> Shouldn't this be also !x86_apple_machine just like AR?
> (For FR, we don't use ICM on Apple machines, as much as I remember, so it's fine
> to enable it there unconditionally for ICM code path.)

Yes, good point. I'll fix it up.
