Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EE7768A23
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Jul 2023 04:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjGaCtO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 30 Jul 2023 22:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGaCtO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 30 Jul 2023 22:49:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545F9E46
        for <linux-acpi@vger.kernel.org>; Sun, 30 Jul 2023 19:49:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E033960E15
        for <linux-acpi@vger.kernel.org>; Mon, 31 Jul 2023 02:49:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4B4C433C8;
        Mon, 31 Jul 2023 02:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690771752;
        bh=93mjwjWS+5eippvaNeLVIO9fWFBV3HLFIT0GQf3sQ+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OL0virMqBtH3YfYWAvCYF+XBgvacTe7hW77zWfy5W4VJQAPkMIt5mtllp7GYFUkoR
         9ZhSihoOhnDzoTX+6Z7hZfRvWPcrmuFGPCxJyZ700NzYNHTP/7lbwFjdE66pm47XSy
         AVZJp3yhBu5kli5MZPDPaKcYCq0Je/jiJItGnHA1yCeW1OGumamY6RKRVrz9cg+sNT
         3BeaWdfv7vm3oPZ0uuXegBRVM0nQyI92T6lkcDhwr5k4GMkMKfDpYX6n3X7/yFH7nC
         TsBxYYosYpzgMTFaJQygwM5TmtamU6faofBnOwkQDfuHZH2cRUqycj/oOgscUFt51q
         AZdxSYfbcdDgQ==
Date:   Mon, 31 Jul 2023 10:49:08 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     rafael@kernel.org, lenb@kernel.org, bleung@chromium.org,
        groeck@chromium.org, chrome-platform@lists.linux.dev,
        linux-acpi@vger.kernel.org, guillaume.tucker@collabora.com,
        denys.f@collabora.com, ricardo.canuelo@collabora.com
Subject: Re: [PATCH v2] platform/chrome: chromeos_acpi: support official HID
 GOOG0016
Message-ID: <ZMchJBy7zlzP1KMN@google.com>
References: <20230728065438.4026629-1-tzungbi@kernel.org>
 <2b36d93d-16d5-9780-d292-a7d06b6c8e55@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b36d93d-16d5-9780-d292-a7d06b6c8e55@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 28, 2023 at 12:49:07PM +0500, Muhammad Usama Anjum wrote:
> On 7/28/23 11:54 AM, Tzung-Bi Shih wrote:
> > Support official HID GOOG0016 for ChromeOS ACPI (see [1]).
> > 
> > [1]: https://crrev.com/c/2266713
> > 
> > Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> Looks good other than the documentation.
> 
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

I didn't attach the R-b tag in v3
(https://patchwork.kernel.org/project/chrome-platform/patch/20230731024214.908235-1-tzungbi@kernel.org/).
Please review the documentation again.

> > --- a/Documentation/ABI/testing/sysfs-driver-chromeos-acpi
> > +++ b/Documentation/ABI/testing/sysfs-driver-chromeos-acpi
> > @@ -1,4 +1,4 @@
> > -What:		/sys/bus/platform/devices/GGL0001:*/BINF.2
> > +What:		/sys/bus/platform/devices/GOOG0016:*/BINF.2
> Probably just replace the GGL0001:* with G* here and define the G* can be
> GGL0001:* or GOOG0016:*.

Fix it in v3 by appending a new line for "GOOG0016".

> > --- a/Documentation/firmware-guide/acpi/chromeos-acpi-device.rst
> > +++ b/Documentation/firmware-guide/acpi/chromeos-acpi-device.rst
> > @@ -5,9 +5,8 @@ Chrome OS ACPI Device
> >  =====================
> >  
> >  Hardware functionality specific to Chrome OS is exposed through a Chrome OS ACPI device.
> > -The plug and play ID of a Chrome OS ACPI device is GGL0001. GGL is a valid PNP ID of Google.
> > -PNP ID can be used with the ACPI devices according to the guidelines. The following ACPI
> > -objects are supported:
> > +The plug and play ID of a Chrome OS ACPI device is GGL0001 and the hardware ID is
> > +GOOG0016.  The following ACPI objects are supported:
> Looks good. Probably GOOG0016 is HID which has higher preference over
> GGL0001 which is CID if both are defined in firmware?

Yes, I also guess so.
