Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2FF28F1D5
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Oct 2020 14:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgJOMGv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Oct 2020 08:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgJOMGu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Oct 2020 08:06:50 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD30CC061755;
        Thu, 15 Oct 2020 05:06:50 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ed2007a48f1cb0d568bb4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:d200:7a48:f1cb:d56:8bb4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1C6591EC02D2;
        Thu, 15 Oct 2020 14:06:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602763609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Mpl8+Br9epfe9HpaSgDMnlNWrP8avR4fzo5zZgyoAk=;
        b=SCWnZ3Y9xl7Hfjubz8IOu+bgDP61HhLoRnXUqmZ2LU0iIf5a8uhbyYkgxqgkNiTPDymcwB
        Jfr3fr7vmstwMHUhu8mJaJ7yDtEvio+8XVemwxU812vhdw401fjgCRZb/K6qgCFkTbM93p
        bCtIvpNYUa8Y/OvMENRlzk0+oTIHEts=
Date:   Thu, 15 Oct 2020 14:06:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>, rafael@kernel.org,
        Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: DPTF_POWER and DPTF_PCH_FIVR
Message-ID: <20201015120639.GE11838@zn.tnic>
References: <20201015095311.GA11838@zn.tnic>
 <20201015095851.GB11838@zn.tnic>
 <d6cdf27b-04ef-7bc8-03ef-2115ca08bffe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d6cdf27b-04ef-7bc8-03ef-2115ca08bffe@intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 15, 2020 at 01:31:55PM +0200, Rafael J. Wysocki wrote:
> Well, they depend on ACPI too and it doesn't look like there is anything
> more fine grained that could be used here.
> 
> Also I'm not sure if adding ACPI_DPTF (bool, disabled by default and
> depending on x86) would help a lot.

So you're saying this is going to be present in current and future
hardware so might as well enable it?

> Obviously an oversight on my part, sorry.
> 
> I think that changing it to "dptf_power" (and analogously for the FIVR
> participant driver) should work.  Srinivas?

Makes sense.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
