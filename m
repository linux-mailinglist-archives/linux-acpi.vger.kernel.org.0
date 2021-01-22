Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249583003CD
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Jan 2021 14:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbhAVNIf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Jan 2021 08:08:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:48896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727681AbhAVNHS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Jan 2021 08:07:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D25F823437;
        Fri, 22 Jan 2021 13:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611320798;
        bh=tfzZDV6BabD9McvWGN0PlXOqslllEMVxmRnAQZ55t6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=At6WTS2FQyJ+ucD8GTkXsfZE4vFz/zio8CzysVlcqS24co3n6lQYtLv/9I5UaqKJR
         gt1CsnK/j1ETZ+GjoOKPATfVkBiomgY7XSyDkPjAD2y45ehWa+J22QS1UaydxRHqGa
         alK0ETa7b1eE7/AbKRv8lCRBpxXmuuVF6mQl4+7o=
Date:   Fri, 22 Jan 2021 14:06:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     rjw@rjwysocki.net, AceLan Kao <acelan.kao@canonical.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI / device_sysfs: Prefer "compatible" modalias
Message-ID: <YArN3Gec5h6jPxWq@kroah.com>
References: <20210122125302.991591-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122125302.991591-1-kai.heng.feng@canonical.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 22, 2021 at 08:53:02PM +0800, Kai-Heng Feng wrote:
> Commit 8765c5ba1949 ("ACPI / scan: Rework modalias creation when
> "compatible" is present") may create two "MODALIAS=" in uevent file if
> conditions are met.
> 
> This breaks systemd-udevd, which assumes each "key" in uevent file is
> unique. The internal implementation of systemd-udevd overwrites the
> first MODALIAS with the second one, so its kmod rule doesn't load driver
> for the first MODALIAS.
> 
> So if both ACPI modalias and OF modalias are present, use the latter
> one to ensure there's only one MODALIAS.
> 
> Reference: https://github.com/systemd/systemd/pull/18163
> Cc: AceLan Kao <acelan.kao@canonical.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Fixes: 8765c5ba1949 ("ACPI / scan: Rework modalias creation when "compatible" is present")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/acpi/device_sysfs.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)

Thanks for fixing this up!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
