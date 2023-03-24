Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2891E6C800A
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Mar 2023 15:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjCXOjM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Mar 2023 10:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjCXOjL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Mar 2023 10:39:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8CDC26192
        for <linux-acpi@vger.kernel.org>; Fri, 24 Mar 2023 07:38:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6682511FB;
        Fri, 24 Mar 2023 07:39:37 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 386133F71E;
        Fri, 24 Mar 2023 07:38:52 -0700 (PDT)
Date:   Fri, 24 Mar 2023 14:38:49 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Robert Moore <robert.moore@intel.com>,
        linux-acpi@vger.kernel.org, kernel@pengutronix.de,
        acpica-devel@lists.linuxfoundation.org, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPICA: Make check to install handler more obviously
 correct
Message-ID: <20230324143849.2y4rdnes3irhw2b2@bogus>
References: <20230324075854.458341-1-u.kleine-koenig@pengutronix.de>
 <20230324095329.3oat5nuqhuqqycsr@bogus>
 <20230324105938.p4olsh27uy5zdbbv@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230324105938.p4olsh27uy5zdbbv@pengutronix.de>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Mar 24, 2023 at 11:59:38AM +0100, Uwe Kleine-König wrote:
>
> My motivation isn't big enough to even read that. If the usual kernel
> workflow doesn't work for ACPICA, let's drop the patch.

:(, but ACPICA is reused on other OSes and hence the need to be a separate
project. It is very similar to the way DTC changes are done elsewhere and
imported into the kernel.

--
Regards,
Sudeep
