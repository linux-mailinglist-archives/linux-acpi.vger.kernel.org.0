Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FD0677A99
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 13:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjAWMOt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 07:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjAWMOt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 07:14:49 -0500
X-Greylist: delayed 344 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Jan 2023 04:14:48 PST
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E91218140;
        Mon, 23 Jan 2023 04:14:48 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id F1E092800C981;
        Mon, 23 Jan 2023 13:09:00 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E5AD02DEC14; Mon, 23 Jan 2023 13:09:00 +0100 (CET)
Date:   Mon, 23 Jan 2023 13:09:00 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Mark Gross <mgross@linux.intel.com>,
        linux-acpi@vger.kernel.org, Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 0/3] ACPI: video/apple-gmux: Improve apple-gmux backlight
 detection
Message-ID: <20230123120900.GA1924@wunner.de>
References: <20230123113750.462144-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123113750.462144-1-hdegoede@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 23, 2023 at 12:37:47PM +0100, Hans de Goede wrote:
> Some apple laptop models have an ACPI device with a HID of APP000B
> and that device has an IO resource (so it does not describe the new
> unsupported MMIO based gmux type), but there actually is no gmux
> in the laptop at all.
> 
> This patch-series improves the drivers/acpi/video_detect.c so that
> it no longer tries to use the non present gmux in this case.
> 
> Note I'm still waiting for testing feedback from the reporter of
> this problem. But from the logs the problem is clear
> (the logs show: "apple_gmux: gmux device not present")

Please provide a link to the original report.  I would also like to
know the exact MacBook model used and I would like to see full dmesg
output as well as an acpidump.

What you're saying here is that there's a fake APP000B device present
in DSDT and I have a hard time believng that.  We need to find out
what's really going on and how macOS handles this.

Thanks,

Lukas
