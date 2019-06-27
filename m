Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D31D57550
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Jun 2019 02:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfF0APe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 Jun 2019 20:15:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfF0APe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Jun 2019 20:15:34 -0400
Received: from localhost (unknown [116.247.127.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 140D8216C8;
        Thu, 27 Jun 2019 00:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561594533;
        bh=MJ2KaTKdJNeLe5zaJz4d4Ny22PpPk93/u2IsVDP5gTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w1UNaNgdiGcLVSa46TY2rC43A/omDRFx/nI+uYIIUguEafGhYmsxnoYlOhWYmzNTw
         8QjTpP9GEDj0wrsc3RVvl9OutcwldNGi7gSIUqt0ESbxEucM6L1uwSlX+E6kWt6jiw
         BMjDWG3Z04aCiGPD2o7K/9adsHthTjAwyDYtXzE8=
Date:   Thu, 27 Jun 2019 08:15:30 +0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     broonie@kernel.org, rafael@kernel.org, linux-acpi@vger.kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 1/2] device property: Add new array helper
Message-ID: <20190627001530.GG527@kroah.com>
References: <20190626153611.10170-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626153611.10170-1-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 26, 2019 at 04:36:10PM +0100, Charles Keepax wrote:
> It is fairly common to want to read an integer array property
> that is composed of an unknown number of fixed size integer
> groups. For example, say each group consists of three values
> which correspond to the settings for one input on the device
> and the driver supports several chips with different numbers
> of inputs.
> 
> Add a new helper function to provide this functionality, it
> differs for the existing helpers in that it allows reading a
> smaller number of values than the full array size and checks
> that the number of values read is a multiple of the group size.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/base/property.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/property.h |  2 ++
>  2 files changed, 50 insertions(+)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
