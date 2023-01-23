Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39111677D3D
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 14:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjAWN6l (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 08:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjAWN6k (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 08:58:40 -0500
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A392412A;
        Mon, 23 Jan 2023 05:58:28 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 9BABF28088D6C;
        Mon, 23 Jan 2023 14:58:27 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 8B77E2E5C20; Mon, 23 Jan 2023 14:58:27 +0100 (CET)
Date:   Mon, 23 Jan 2023 14:58:27 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Mark Gross <mgross@linux.intel.com>,
        linux-acpi@vger.kernel.org, Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Emmanouil Kouroupakis <kartebi@gmail.com>
Subject: Re: [PATCH 0/3] ACPI: video/apple-gmux: Improve apple-gmux backlight
 detection
Message-ID: <20230123135827.GB2649@wunner.de>
References: <20230123113750.462144-1-hdegoede@redhat.com>
 <20230123120900.GA1924@wunner.de>
 <255bf66e-eb27-af2b-9a13-8b7d4b7b3c46@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <255bf66e-eb27-af2b-9a13-8b7d4b7b3c46@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 23, 2023 at 01:38:37PM +0100, Hans de Goede wrote:
> On 1/23/23 13:09, Lukas Wunner wrote:
> > On Mon, Jan 23, 2023 at 12:37:47PM +0100, Hans de Goede wrote:
> > > Some apple laptop models have an ACPI device with a HID of APP000B
> > > and that device has an IO resource (so it does not describe the new
> > > unsupported MMIO based gmux type), but there actually is no gmux
> > > in the laptop at all.
> > >
> > > This patch-series improves the drivers/acpi/video_detect.c so that
> > > it no longer tries to use the non present gmux in this case.
> > >
> > > Note I'm still waiting for testing feedback from the reporter of
> > > this problem. But from the logs the problem is clear
> > > (the logs show: "apple_gmux: gmux device not present")
> > 
> > Please provide a link to the original report.  I would also like to
> > know the exact MacBook model used and I would like to see full dmesg
> > output as well as an acpidump.
> 
> I only have a report by private email. This does include full dmesg
> output and an acpidump. I will forward this to you in a private
> email.
> 
> The reporter describes their model as a macbookpro8,1.
> 
> > What you're saying here is that there's a fake APP000B device present
> > in DSDT
> 
> Yes that is exactly what I'm saying.

That's a 2011 13" MacBook Pro which indeed does not have dual GPUs.

I searched for other affected models and this seems to be more common
than I thought:

MacBookPro5,4
https://pastebin.com/8Xjq7RhS

MacBookPro8,1
https://linux-hardware.org/?probe=e513cfbadb&log=dmesg

MacBookPro9,2
https://bugzilla.kernel.org/attachment.cgi?id=278961

MacBookPro10,2
https://lkml.org/lkml/2014/9/22/657

MacBookPro11,2
https://forums.fedora-fr.org/viewtopic.php?id=70142

MacBookPro11,4
https://raw.githubusercontent.com/im-0/investigate-card-reader-suspend-problem-on-mbp11.4/master/test-16/dmesg

These are 13" and 15" models from the pre-retina and retina era
(2009 - 2015).  None of them have dual GPUs.  (Only a subset of
the 15" and 17" models had dual GPUs.)  Apple sloppily included
a GMUX device on all of them and it wasn't a problem so far
because the gmux driver detects non-presence and bails out,
but it throws off the new backlight algorithm.

This is really sad. :(

Please add a Reported-by to your commits as well as the list I've
provided above so that we've got a complete record in the git history.

Thanks,

Lukas
