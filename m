Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 797F08BE02
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Aug 2019 18:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfHMQKl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Aug 2019 12:10:41 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:47169 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfHMQKl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Aug 2019 12:10:41 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id EDF5C102F35CC;
        Tue, 13 Aug 2019 18:10:38 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B05271359A; Tue, 13 Aug 2019 18:10:38 +0200 (CEST)
Date:   Tue, 13 Aug 2019 18:10:38 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Raanan Avargil <raanan.avargil@intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 7/8] thunderbolt: Add support for Intel Ice Lake
Message-ID: <20190813161038.tip2u2z22xqnmfjl@wunner.de>
References: <20190812123847.50802-1-mika.westerberg@linux.intel.com>
 <20190812123847.50802-8-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812123847.50802-8-mika.westerberg@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 12, 2019 at 03:38:46PM +0300, Mika Westerberg wrote:
> +static void icm_veto_begin(struct tb *tb)
> +{
> +	struct icm *icm = tb_priv(tb);
> +
> +	if (!icm->veto) {
> +		icm->veto = true;
> +		/* Keep the domain powered while veto is in effect */
> +		pm_runtime_get(&tb->dev);
> +	}
> +}

Hm, don't you need memory barriers when accessing icm->veto?

If so, I'd suggest:

	/* Keep the domain powered while veto is in effect */
	if (cmpxchg(&icm->veto, false, true))
		pm_runtime_get(&tb->dev);

You'll have to declare icm->veto unsigned int instead of bool
because thunderbolt.ko is compiled if CONFIG_COMPILE_TEST is
enabled and there are arches which do not support cmpxchg for
a size of 1 byte.

The other bools in struct icm should likewise be unsigned int
per Linus' dictum:
https://lkml.org/lkml/2017/11/21/384


> --- a/drivers/thunderbolt/nhi.c
> +++ b/drivers/thunderbolt/nhi.c
> +/* Ice Lake specific NHI operations */
> +

Again, can't this be moved to a separate file for maintainability?

Thanks,

Lukas
