Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497A94559FE
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Nov 2021 12:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343656AbhKRLUo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Nov 2021 06:20:44 -0500
Received: from mga06.intel.com ([134.134.136.31]:37831 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343707AbhKRLTZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 18 Nov 2021 06:19:25 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="294979598"
X-IronPort-AV: E=Sophos;i="5.87,244,1631602800"; 
   d="scan'208";a="294979598"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 03:14:20 -0800
X-IronPort-AV: E=Sophos;i="5.87,244,1631602800"; 
   d="scan'208";a="473114504"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 03:14:18 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 18 Nov 2021 13:14:15 +0200
Date:   Thu, 18 Nov 2021 13:14:15 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: Re: [PATCH v2 1/3] pinctrl: cherryview: Don't use pin/offset 0 to
 mark an interrupt line as unused
Message-ID: <YZY1h8DGkqyoh2aQ@lahna>
References: <20211118105650.207638-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118105650.207638-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 18, 2021 at 11:56:48AM +0100, Hans de Goede wrote:
> Offset/pin 0 is a perfectly valid offset, so stop using it to have
> the special meaning of interrupt line not used in the intr_lines.
> 
> Instead introduce a new special INTR_LINE_UNUSED value which is never
> a valid offset and use that to indicate unused interrupt lines.
> 
> Cc: Yauhen Kharuzhy <jekhor@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
