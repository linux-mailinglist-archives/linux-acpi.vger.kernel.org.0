Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB4A720FD7
	for <lists+linux-acpi@lfdr.de>; Sat,  3 Jun 2023 13:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237169AbjFCLD3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 3 Jun 2023 07:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236733AbjFCLD2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Jun 2023 07:03:28 -0400
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FF3BD
        for <linux-acpi@vger.kernel.org>; Sat,  3 Jun 2023 04:03:26 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id 4150446e-01fe-11ee-b972-005056bdfda7;
        Sat, 03 Jun 2023 14:03:24 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 3 Jun 2023 14:03:22 +0300
To:     Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com, jdelvare@suse.com,
        linux@roeck-us.net, jic23@kernel.org, lars@metafoo.de,
        bleung@chromium.org, yu.c.chen@intel.com, hdegoede@redhat.com,
        markgross@kernel.org, luzmaximilian@gmail.com,
        corentin.chary@gmail.com, jprvita@gmail.com,
        cascardo@holoscopio.com, don@syst.com.br, pali@kernel.org,
        jwoithe@just42.net, matan@svgalib.org, kenneth.t.chan@gmail.com,
        malattia@linux.it, jeremy@system76.com, productdev@system76.com,
        herton@canonical.com, coproscefalo@gmail.com, tytso@mit.edu,
        Jason@zx2c4.com, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        chrome-platform@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net
Subject: Re: [PATCH v4 00/35] Remove .notify callback in acpi_device_ops
Message-ID: <ZHsd-je7kDDpii2q@surfacebook>
References: <20230601131655.300675-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601131655.300675-1-michal.wilczynski@intel.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thu, Jun 01, 2023 at 03:16:55PM +0200, Michal Wilczynski kirjoitti:
> Currently drivers support ACPI event handlers by defining .notify
> callback in acpi_device_ops. This solution is suboptimal as event
> handler installer installs intermediary function acpi_notify_device as a
> handler in every driver. Also this approach requires extra variable
> 'flags' for specifying event types that the driver want to subscribe to.
> Additionally this is a pre-work required to align acpi_driver with
> platform_driver and eventually replace acpi_driver with platform_driver.
> 
> Remove .notify callback from the acpi_device_ops. Replace it with each
> driver installing and removing it's event handlers.

Somehow this thread is screwed up in a sense of linking messages.
Even on the archives there are rather individual patches.

Please, be sure you are always use --thread when formatting it.
Yet you have a possibility to Cc different patches to the different
mailing lists and people.

-- 
With Best Regards,
Andy Shevchenko


