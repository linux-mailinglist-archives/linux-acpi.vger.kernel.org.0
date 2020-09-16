Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E903526CDC8
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Sep 2020 23:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgIPVFL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Sep 2020 17:05:11 -0400
Received: from mga04.intel.com ([192.55.52.120]:8872 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgIPQPB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Sep 2020 12:15:01 -0400
IronPort-SDR: Nxaf18JWAD1ByTJyVNm9jDeywPHSRVNEOfhBN8kgAR8sZO3ecSdWjEA1HHSV6tsQ3Qo57OO6hB
 QHqtaodyW+oQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="156847936"
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; 
   d="scan'208";a="156847936"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 06:27:39 -0700
IronPort-SDR: SD7152pPPAgw2JkHU2xNe/XZCzOPQBL0yRS/KHuGoTxQAXaw1xkwJ7EGEIAKH+/xpKZ6yA/eMT
 taVI80n7V9iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; 
   d="scan'208";a="409556841"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 16 Sep 2020 06:27:35 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 16 Sep 2020 16:27:35 +0300
Date:   Wed, 16 Sep 2020 16:27:35 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 0/3] PM operations for software nodes
Message-ID: <20200916132735.GF1358028@kuha.fi.intel.com>
References: <20200825135951.53340-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825135951.53340-1-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

+Sakari

On Tue, Aug 25, 2020 at 04:59:48PM +0300, Heikki Krogerus wrote:
> Hi guys,
> 
> Unfortunately the last patch depends on this:
> https://lore.kernel.org/linux-usb/20200821131101.81915-1-heikki.krogerus@linux.intel.com/
> 
> Would it be easiest that Felipe took care of these (assuming they are
> acceptable)?
> 
> thanks,
> 
> Heikki Krogerus (3):
>   software node: Power management operations for software nodes
>   software node: Introduce device_add_software_node()
>   usb: dwc3: pci: Register a software node for the dwc3 platform device
> 
>  drivers/base/power/common.c |   8 +-
>  drivers/base/swnode.c       | 569 +++++++++++++++++++++++++++++++++++-
>  drivers/usb/dwc3/dwc3-pci.c | 175 ++++++-----
>  include/linux/property.h    |  13 +
>  4 files changed, 666 insertions(+), 99 deletions(-)
> 
> -- 
> 2.28.0

-- 
heikki
