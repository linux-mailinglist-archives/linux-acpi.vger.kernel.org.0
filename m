Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A78C6C7C05
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Mar 2023 10:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjCXJxg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Mar 2023 05:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjCXJxe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Mar 2023 05:53:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B725212852
        for <linux-acpi@vger.kernel.org>; Fri, 24 Mar 2023 02:53:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E54211FB;
        Fri, 24 Mar 2023 02:54:17 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 659423F6C4;
        Fri, 24 Mar 2023 02:53:32 -0700 (PDT)
Date:   Fri, 24 Mar 2023 09:53:29 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Robert Moore <robert.moore@intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, kernel@pengutronix.de
Subject: Re: [PATCH] ACPICA: Make check to install handler more obviously
 correct
Message-ID: <20230324095329.3oat5nuqhuqqycsr@bogus>
References: <20230324075854.458341-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230324075854.458341-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Mar 24, 2023 at 08:58:54AM +0100, Uwe Kleine-König wrote:
> The loop
> 
> 	for (i = 0; i < ACPI_NUM_NOTIFY_TYPES; i++) {
> 		if (handler_type & (i + 1)) {
> 			...
> 		}
> 	}
> 
> looks strange. Only with knowing that ACPI_NUM_NOTIFY_TYPES == 2 you can
> see that the two least significant bits are checked. Still replace
> 
> 	i + 1
> 
> by
> 
> 	1 << i
> 
> which shouldn't make a relevant difference to compiler and compiled
> code, but is easier to understand for a human code reader.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

You need to submit this to ACPICA project first.
Documentation/driver-api/acpi/linuxized-acpica.rst explains the process.
Refer [1] for details for similar suggestion by Rafael.

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/all/CAJZ5v0gPUBFzuFiRWW8KHAwB1Agy+Le=CWuRD0RTr4MkNeEmQw@mail.gmail.com

