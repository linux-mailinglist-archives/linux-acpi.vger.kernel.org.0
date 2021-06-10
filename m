Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05AF43A24E5
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jun 2021 09:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhFJHDt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Jun 2021 03:03:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:43655 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhFJHDs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 10 Jun 2021 03:03:48 -0400
IronPort-SDR: ajEhsZn7Cwb6CipBbFpVYL3KHw1k2IBVOy2pkDGWtpom1o3thTvPt9dmDBWXXeut5d+LDm4obw
 WscvlDtTk2TA==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="192556104"
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; 
   d="scan'208";a="192556104"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 00:01:25 -0700
IronPort-SDR: 6RQOvV5aUSdNKCggQCb3f3mm8IfclN31UoGmUwGpS2AIHdOuPjIUSMNnjAN28nrUkZCE5XyIzk
 4hHOL8QyNLbQ==
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; 
   d="scan'208";a="552947025"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 00:01:21 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 10 Jun 2021 10:01:18 +0300
Date:   Thu, 10 Jun 2021 10:01:18 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH] ACPI: Remove redundant clearing of context->ret.pointer
 from acpi_run_osc()
Message-ID: <YMG4vrHB6SwD0/uP@lahna.fi.intel.com>
References: <20210609175130.224274-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609175130.224274-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 09, 2021 at 07:51:30PM +0200, Hans de Goede wrote:
> context->ret.pointer already gets set to NULL at the beginning of
> acpi_run_osc() and it only gets assigned a new value in the success
> path near the end of acpi_run_osc(), so the clearing of
> context->ret.pointer (when status != AE_OK) at the end of
> acpi_run_osc() is redundant since it will always already be NULL when
> status != AE_OK.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
