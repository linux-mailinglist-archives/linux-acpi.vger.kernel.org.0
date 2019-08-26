Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2DD9CC77
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2019 11:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbfHZJU7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Aug 2019 05:20:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:55011 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730679AbfHZJU6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Aug 2019 05:20:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 02:20:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,431,1559545200"; 
   d="scan'208";a="197013981"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 26 Aug 2019 02:20:54 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 26 Aug 2019 12:20:53 +0300
Date:   Mon, 26 Aug 2019 12:20:53 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Raanan Avargil <raanan.avargil@intel.com>,
        David Laight <David.Laight@aculab.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 0/8] thunderbolt: Intel Ice Lake support
Message-ID: <20190826092053.GC19908@lahna.fi.intel.com>
References: <20190819112223.15359-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819112223.15359-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 19, 2019 at 02:22:15PM +0300, Mika Westerberg wrote:
> Hi all,
> 
> This is third iteration of the patch series adding support for the Intel
> Ice Lake integrated Thunderbolt controller. The biggest difference from the
> previous discrete controllers is that the Ice Lake Thunderbolt controller
> is now integrated as part of the SoC. The firmware messages pretty much
> follow Titan Ridge but there are some differences as well (such as the new
> RTD3 veto notification). Also Ice Lake does not implement security levels
> so DMA protection is handled by IOMMU.

Series applied to thunderbolt.git/next.
