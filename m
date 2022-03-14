Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E89C4D7E4E
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Mar 2022 10:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbiCNJOD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Mar 2022 05:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236683AbiCNJOC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Mar 2022 05:14:02 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A155F6F;
        Mon, 14 Mar 2022 02:12:51 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id DEF78100D587D;
        Mon, 14 Mar 2022 10:12:47 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B63014ABF3; Mon, 14 Mar 2022 10:12:47 +0100 (CET)
Date:   Mon, 14 Mar 2022 10:12:47 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>, linux-acpi@vger.kernel.org,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Goswami Sanket <Sanket.Goswami@amd.com>
Subject: Re: [PATCH v3 1/5] ACPI / x86: Add support for LPS0 callback handler
Message-ID: <20220314091247.GA28904@wunner.de>
References: <20220314050340.1176-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314050340.1176-1-mario.limonciello@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 14, 2022 at 12:03:35AM -0500, Mario Limonciello wrote:
> Currenty the latest thing run during a suspend to idle attempt is
> the LPS0 `prepare_late` callback and the earliest thing is the
> `resume_early` callback.
> 
> There is a desire for the `amd-pmc` driver to suspend later in the
> suspend process (ideally the very last thing), so create a callback
> that it or any other driver can hook into to do this.

I'm wondering if this can be solved with much less code by either
using device links (a device link to amd-pmc from everything that
needs to be suspended before it), or with a notifier chain?

Thanks,

Lukas
