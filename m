Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168D4554C15
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Jun 2022 16:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354489AbiFVOCC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 Jun 2022 10:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357822AbiFVOCA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Jun 2022 10:02:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6868837BD1
        for <linux-acpi@vger.kernel.org>; Wed, 22 Jun 2022 07:01:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D7DF1042;
        Wed, 22 Jun 2022 07:01:55 -0700 (PDT)
Received: from bogus (unknown [10.57.36.82])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8DD53F792;
        Wed, 22 Jun 2022 07:01:53 -0700 (PDT)
Date:   Wed, 22 Jun 2022 15:00:42 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/3] ACPICA: Add support for FFH Opregion special context
 data
Message-ID: <20220622140042.bjg72oxjo43l2rwo@bogus>
References: <20220616090106.2154906-1-sudeep.holla@arm.com>
 <20220616090106.2154906-2-sudeep.holla@arm.com>
 <CAJZ5v0j0Ayb3KGpfxuuXH9CHUrt8rupVg5OK=r6hqZQEYm3jFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j0Ayb3KGpfxuuXH9CHUrt8rupVg5OK=r6hqZQEYm3jFA@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 22, 2022 at 02:50:08PM +0200, Rafael J. Wysocki wrote:
> On Thu, Jun 16, 2022 at 11:01 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > FFH(Fixed Function Hardware) Opregion is approved to be added in ACPIC 6.5 via
> 
> s/ACPIC/ACPI/
>

Fixed and pushed in ACPICA PR.

> > code first approach[1]. It requires special context data similar to GPIO and
> > Generic Serial Bus as it needs to know platform specific offset and length.
> >
> > Add support for the special context data needed by FFH Opregion.
> >
> > FFH OpRegion enables advanced use of FFH on some architectures. For example,
> > it could be used to easily proxy AML code to architecture-specific behavior
> > (to ensure it is OS initiated)
> >
> > Actual behavior of FFH is ofcourse architecture specific and depends on
> > the FFH bindings. The offset and length could have arch specific meaning
> > or usage.
> >
> > [1] https://bugzilla.tianocore.org/show_bug.cgi?id=3598
> >
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> This looks reasonable to me and I see that you've already submitted a
> pull request to the upstream ACPICA.

I assume you would prefer me to post the other 2 patches once this lands
in your -next. Worst case I would like to get the generic patch in along
with ACPICA changes, I can then route the arm64 specific next cycle if it
gets too late for v5.20

-- 
Regards,
Sudeep
