Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7E94C481F
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Feb 2022 15:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiBYO5k (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Feb 2022 09:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiBYO5h (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Feb 2022 09:57:37 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC2315BE74
        for <linux-acpi@vger.kernel.org>; Fri, 25 Feb 2022 06:56:54 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F17EE12FC;
        Fri, 25 Feb 2022 06:56:53 -0800 (PST)
Received: from bogus (unknown [10.57.3.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE37D3F5A1;
        Fri, 25 Feb 2022 06:56:52 -0800 (PST)
Date:   Fri, 25 Feb 2022 14:56:02 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Ray.Huang@amd.com
Subject: Re: [PATCH 1/2] PSCI: cpuidle: Move the `has_lpi` check to the
 beginning of the function
Message-ID: <20220225145602.63pjqkrhadcrzh2k@bogus>
References: <20220225031255.3647599-1-mario.limonciello@amd.com>
 <20220225031255.3647599-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225031255.3647599-2-mario.limonciello@amd.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Feb 24, 2022 at 09:12:54PM -0600, Mario Limonciello wrote:
> Currently the first thing checked is whether the PCSI cpu_suspend function
> has been initialized.
> 
> Another change will be overloading `acpi_processor_ffh_lpi_probe` and
> calling it sooner.  So make the `has_lpi` check the first thing checked
> to prepare for that change.
>

You need to cc arm64 maintainers and get their ack to merge this via ACPI
tree.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
