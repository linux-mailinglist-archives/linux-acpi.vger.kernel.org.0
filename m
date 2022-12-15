Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C556164D976
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Dec 2022 11:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiLOKWf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Dec 2022 05:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiLOKWP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Dec 2022 05:22:15 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A30629801;
        Thu, 15 Dec 2022 02:22:13 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id BCBC130016112;
        Thu, 15 Dec 2022 11:22:11 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B0E4338193; Thu, 15 Dec 2022 11:22:11 +0100 (CET)
Date:   Thu, 15 Dec 2022 11:22:11 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Aditya Garg <gargaditya08@live.com>
Subject: Re: [PATCH] ACPI: video: Fix Apple GMUX backlight detection
Message-ID: <20221215102211.GA5147@wunner.de>
References: <20221215094138.7120-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215094138.7120-1-hdegoede@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 15, 2022 at 10:41:38AM +0100, Hans de Goede wrote:
> The apple-gmux driver only binds to old GMUX devices which have an
> IORESOURCE_IO resource (using inb()/outb()) rather then memory-mapped
> IO (IORESOURCE_MEM).
> 
> T2 MacBooks use the new style GMUX devices (with IORESOURCE_MEM access),
> so these are not supported by the apple-gmux driver. This is not a problem
> since they have working ACPI video backlight support.

Interesting.


> +static bool apple_gmux_backlight_present(void)
> +{
> +	struct acpi_device *adev;
> +	struct device *dev;
> +
> +	adev = acpi_dev_get_first_match_dev(GMUX_ACPI_HID, NULL, -1);
> +	if (!adev)
> +		return false;
> +
> +	dev = acpi_get_first_physical_node(adev);
> +	if (!dev)
> +		return false;
> +
> +	/*
> +	 * drivers/platform/x86/apple-gmux.c only supports old style
> +	 * Apple GMUX with an IO-resource.
> +	 */
> +	return pnp_get_resource(to_pnp_dev(dev), IORESOURCE_IO, 0) != NULL;
> +}

The T2 is represented by a PCI device with ID 106B:1802.

Instead of the above, how about amending apple_gmux_present()
with a simple check like this:

	/* T2 Macs drive GMUX via MMIO, which is unsupported for now */
	if (pci_dev_present({{PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x1802)}, {}}))
		return false;

Thanks,

Lukas
