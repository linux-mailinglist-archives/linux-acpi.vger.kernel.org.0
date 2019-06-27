Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3F7557551
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Jun 2019 02:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfF0AQD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 Jun 2019 20:16:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbfF0AQD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Jun 2019 20:16:03 -0400
Received: from localhost (unknown [116.247.127.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A97EA216C8;
        Thu, 27 Jun 2019 00:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561594562;
        bh=pwwo17FOMovc2ZCr62QYydIQFeqS0+a7qC77QEGeZs0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KueqM+8mFbhLZA7B6gQxWwVA73OkVt+GigTsbWlhhXFHUHrbb1IkP6cBoMRkxAPyA
         co8Jr2GuCtG2fWNPWzjY6TBV19Lmz/UGI/WJP2M+1pONtIzijrOzie6MMlqJ0MPmAF
         HtYHmndZYBz+U1wTQzFd4VGELg9E8QZmvcNQRdZk=
Date:   Thu, 27 Jun 2019 08:15:54 +0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     broonie@kernel.org, rafael@kernel.org, linux-acpi@vger.kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 2/2] ASoC: madera: Read device tree configuration
Message-ID: <20190627001554.GH527@kroah.com>
References: <20190626153611.10170-1-ckeepax@opensource.cirrus.com>
 <20190626153611.10170-2-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626153611.10170-2-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 26, 2019 at 04:36:11PM +0100, Charles Keepax wrote:
> Read the configuration of the Madera sound driver from device tree using
> the new device tree helper function.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> Note this patch depends on patches that are currently going through Mark's
> tree so probably best if this one also goes through there.

No objection from me for him to take the previous one with this one in
his tree.

thanks,

greg k-h
