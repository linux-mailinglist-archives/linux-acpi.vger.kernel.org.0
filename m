Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA80F1D0BB3
	for <lists+linux-acpi@lfdr.de>; Wed, 13 May 2020 11:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732448AbgEMJPk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 May 2020 05:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730334AbgEMJPk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 May 2020 05:15:40 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11053C061A0C;
        Wed, 13 May 2020 02:15:40 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A4EB8379; Wed, 13 May 2020 11:15:38 +0200 (CEST)
Date:   Wed, 13 May 2020 11:15:37 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     Joerg Roedel <jroedel@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        evgreen@chromium.org, dianders@chromium.org,
        Daniel Kurtz <djkurtz@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/amd: Fix get_acpihid_device_id()
Message-ID: <20200513091537.GJ9820@8bytes.org>
References: <20200511103229.v2.1.I6f1b6f973ee6c8af1348611370c73a0ec0ea53f1@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511103229.v2.1.I6f1b6f973ee6c8af1348611370c73a0ec0ea53f1@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 11, 2020 at 10:33:36AM -0600, Raul E Rangel wrote:
> acpi_dev_hid_uid_match() expects a null pointer for UID if it doesn't
> exist. The acpihid_map_entry contains a char buffer for holding the
> UID. If no UID was provided in the IVRS table, this buffer will be
> zeroed. If we pass in a null string, acpi_dev_hid_uid_match() will
> return false because it will try and match an empty string to the ACPI
> UID of the device.
> 
> Fixes: ae5e6c6439c3 ("iommu/amd: Switch to use acpi_dev_hid_uid_match()")
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> 
> Changes in v2:
> - Added Suggested by
> - Fixed commit description
> - Decided to keep `p->uid[0]` instead of `*p->uid` since the data member is an array instead of a pointer.
> - Used clang-format
> 
>  drivers/iommu/amd_iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied for v5.7, thanks Raul.
