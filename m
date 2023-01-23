Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48912677DDF
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 15:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjAWOXi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 09:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjAWOXh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 09:23:37 -0500
X-Greylist: delayed 8074 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Jan 2023 06:23:36 PST
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBF824106;
        Mon, 23 Jan 2023 06:23:36 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 7478328088D6C;
        Mon, 23 Jan 2023 15:23:35 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 653972E4EC1; Mon, 23 Jan 2023 15:23:35 +0100 (CET)
Date:   Mon, 23 Jan 2023 15:23:35 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Mark Gross <mgross@linux.intel.com>,
        linux-acpi@vger.kernel.org, Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 2/3] platform/x86: apple-gmux: Add apple_gmux_detect()
 helper
Message-ID: <20230123142335.GA31736@wunner.de>
References: <20230123113750.462144-1-hdegoede@redhat.com>
 <20230123113750.462144-3-hdegoede@redhat.com>
 <20230123134907.GA2649@wunner.de>
 <9fc84f34-669e-a89c-52d9-c714fe8e4e49@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fc84f34-669e-a89c-52d9-c714fe8e4e49@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 23, 2023 at 03:13:28PM +0100, Hans de Goede wrote:
> On 1/23/23 14:49, Lukas Wunner wrote:
> > On Mon, Jan 23, 2023 at 12:37:49PM +0100, Hans de Goede wrote:
> > > --- a/include/linux/apple-gmux.h
> > > +++ b/include/linux/apple-gmux.h
> > [...]
> > > +static inline bool apple_gmux_is_indexed(unsigned long iostart)
> > > +{
> > > +	u16 val;
> > > +
> > > +	outb(0xaa, iostart + 0xcc);
> > > +	outb(0x55, iostart + 0xcd);
> > > +	outb(0x00, iostart + 0xce);
> > > +
> > > +	val = inb(iostart + 0xcc) | (inb(iostart + 0xcd) << 8);
> > > +	if (val == 0x55aa)
> > > +		return true;
> > > +
> > > +	return false;
> > > +}
> > 
> > Something like this, and especially the large apple_gmux_detect() below,
> > should not live in a header file.
> 
> I understand where you are coming from, but these functions really
> are not that large.
> 
> > Why can't apple_gmux.ko just export a detection function which is used
> > both internally and as a helper by the backlight detection?
> 
> Both the acpi-video code and the apple-gmux code can be built as
> modules. So this will break if the acpi-video code get builtin
> and the apple-gmux code does not.
> 
> This can be worked around in Kconfig by adding something like:
> 
> 	depends on APPLE_GMUX || APPLE_GMUX=n
> 
> to the ACPI_VIDEO Kconfig bits and then cross our fingers
> we don't get some Kconfig circular dep thing causing things
> to error out.

Can we force APPLE_GMUX to be built-in if ACPI_VIDEO is?

Would making APPLE_GMUX depend on ACPI_VIDEO (instead of
"ACPI_VIDEO=n || ACPI_VIDEO") achieve that?  I believe
APPLE_GMUX would then inherit the setting of ACPI_VIDEO?

Thanks,

Lukas
