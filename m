Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BAB35F29D
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Apr 2021 13:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350557AbhDNLfZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Apr 2021 07:35:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:16156 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232069AbhDNLfY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Apr 2021 07:35:24 -0400
IronPort-SDR: Qsj014cOJnYFUeEIw5fXuAa7FIogtoNJuy4yYmPNgFlbxpFEQwb8Jo05wl/BIvXxjr/IuBiS7K
 Lm9pHVCnmeVw==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="279931720"
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="279931720"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 04:35:01 -0700
IronPort-SDR: 6Oc8hCUQ5OB3w7UeCQOSf8wfQ4KqG9pk5f56OMXThcachX8Y4M+Sar7znTNCW9SsONT5Sf++nb
 HT/MU2hA4ddg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="521961851"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 14 Apr 2021 04:34:59 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 14 Apr 2021 14:34:58 +0300
Date:   Wed, 14 Apr 2021 14:34:58 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] software node: Allow node addition to already existing
 device
Message-ID: <YHbTYuMSyzPKXGoB@kuha.fi.intel.com>
References: <20210414075438.64547-1-heikki.krogerus@linux.intel.com>
 <YHayP0cTOGMSoPNR@kuha.fi.intel.com>
 <YHazQ33v4PY8kRHd@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHazQ33v4PY8kRHd@kroah.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Apr 14, 2021 at 11:17:55AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 14, 2021 at 12:13:35PM +0300, Heikki Krogerus wrote:
> > +Greg
> > 
> > Sorry about that. Should I resend this?
> 
> No worries, I can pick it up, thanks
> 
> `b4` really is nice to use :)

Yes, it's a really nice tool.

thanks,

-- 
heikki
