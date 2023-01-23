Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FCC677DA2
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 15:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjAWOI2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 09:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbjAWOI1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 09:08:27 -0500
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Jan 2023 06:07:52 PST
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D29E24114;
        Mon, 23 Jan 2023 06:07:51 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 67420100DA1BD;
        Mon, 23 Jan 2023 14:49:07 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 352D22E5C2B; Mon, 23 Jan 2023 14:49:07 +0100 (CET)
Date:   Mon, 23 Jan 2023 14:49:07 +0100
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
Message-ID: <20230123134907.GA2649@wunner.de>
References: <20230123113750.462144-1-hdegoede@redhat.com>
 <20230123113750.462144-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123113750.462144-3-hdegoede@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 23, 2023 at 12:37:49PM +0100, Hans de Goede wrote:
> --- a/include/linux/apple-gmux.h
> +++ b/include/linux/apple-gmux.h
[...]
> +static inline bool apple_gmux_is_indexed(unsigned long iostart)
> +{
> +	u16 val;
> +
> +	outb(0xaa, iostart + 0xcc);
> +	outb(0x55, iostart + 0xcd);
> +	outb(0x00, iostart + 0xce);
> +
> +	val = inb(iostart + 0xcc) | (inb(iostart + 0xcd) << 8);
> +	if (val == 0x55aa)
> +		return true;
> +
> +	return false;
> +}

Something like this, and especially the large apple_gmux_detect() below,
should not live in a header file.

Why can't apple_gmux.ko just export a detection function which is used
both internally and as a helper by the backlight detection?

Thanks,

Lukas

>  
>  /**
> - * apple_gmux_present() - detect if gmux is built into the machine
> + * apple_gmux_detect() - detect if gmux is built into the machine
> + *
> + * @pnp_dev:     Device to probe or NULL to use the first matching device
> + * @indexed_ret: Returns (by reference) if the gmux is indexed or not
> + *
> + * Detect if a supported gmux device is present by actually probing it.
> + * This avoids the false positives returned on some models by
> + * apple_gmux_present().
> + *
> + * Return: %true if a supported gmux ACPI device is detected and the kernel
> + * was configured with CONFIG_APPLE_GMUX, %false otherwise.
> + */
> +static inline bool apple_gmux_detect(struct pnp_dev *pnp_dev, bool *indexed_ret)
> +{
> +	u8 ver_major, ver_minor, ver_release;
> +	struct resource *res;
> +	bool indexed = false;
> +
> +	if (!pnp_dev) {
> +		struct acpi_device *adev;
> +		struct device *dev;
> +
> +		adev = acpi_dev_get_first_match_dev(GMUX_ACPI_HID, NULL, -1);
> +		if (!adev)
> +			return false;
> +
> +		dev = acpi_get_first_physical_node(adev);
> +		if (!dev)
> +			return false;
> +
> +		pnp_dev = to_pnp_dev(dev);
> +	}
> +
> +	res = pnp_get_resource(pnp_dev, IORESOURCE_IO, 0);
> +	if (!res)
> +		return false;
> +
> +	if (resource_size(res) < GMUX_MIN_IO_LEN)
> +		return false;
> +
> +	/*
> +	 * Invalid version information may indicate either that the gmux
> +	 * device isn't present or that it's a new one that uses indexed io.
> +	 */
> +	ver_major = inb(res->start + GMUX_PORT_VERSION_MAJOR);
> +	ver_minor = inb(res->start + GMUX_PORT_VERSION_MINOR);
> +	ver_release = inb(res->start + GMUX_PORT_VERSION_RELEASE);
> +	if (ver_major == 0xff && ver_minor == 0xff && ver_release == 0xff) {
> +		indexed = apple_gmux_is_indexed(res->start);
> +		if (!indexed)
> +			return false;
> +	}
> +
> +	if (indexed_ret)
> +		*indexed_ret = indexed;
> +
> +	return true;
> +}
> +
> +/**
> + * apple_gmux_present() - check if gmux ACPI device is present
>   *
>   * Drivers may use this to activate quirks specific to dual GPU MacBook Pros
>   * and Mac Pros, e.g. for deferred probing, runtime pm and backlight.
>   *
> - * Return: %true if gmux is present and the kernel was configured
> + * Return: %true if gmux ACPI device is present and the kernel was configured
>   * with CONFIG_APPLE_GMUX, %false otherwise.
>   */
>  static inline bool apple_gmux_present(void)
> @@ -57,6 +133,11 @@ static inline bool apple_gmux_present(void)
>  	return false;
>  }
>  
> +static inline bool apple_gmux_detect(struct pnp_dev *pnp_dev, bool *indexed_ret)
> +{
> +	return false;
> +}
> +
>  #endif /* !CONFIG_APPLE_GMUX */
>  
>  #endif /* LINUX_APPLE_GMUX_H */
> -- 
> 2.39.0
