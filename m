Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 028A4175B33
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Mar 2020 14:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgCBNIi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Mar 2020 08:08:38 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:57521 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbgCBNIi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Mar 2020 08:08:38 -0500
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id D9253240009;
        Mon,  2 Mar 2020 13:08:33 +0000 (UTC)
Message-ID: <4f231582f5981411d79610d8883e74208965b440.camel@hadess.net>
Subject: Re: [PATCH v3 2/2] touchscreen: goodix: define GPIO mapping for GPD
 P2 Max
From:   Bastien Nocera <hadess@hadess.net>
To:     Peter Cai <peter@typeblog.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Date:   Mon, 02 Mar 2020 14:08:33 +0100
In-Reply-To: <CA+Zf_0fBX3YBVsiJbAGdtFp-428uwsRS3oncZCytSvxw8rXO4Q@mail.gmail.com>
References: <20190831030916.13172-1-peter@typeblog.net>
         <20190902124352.12291-1-peter@typeblog.net>
         <20190902124352.12291-2-peter@typeblog.net>
         <daeec373292e14c6aea179ddf690a5dace6c83f7.camel@hadess.net>
         <CA+Zf_0fBX3YBVsiJbAGdtFp-428uwsRS3oncZCytSvxw8rXO4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.35.91 (3.35.91-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 2020-03-02 at 20:10 +0800, Peter Cai wrote:
> 
<snip>
> Sorry I forgot to notify you earlier, but it turned out that the
> manufacturer of the device has already applied a fix in their ACPI
> table after this patch was submitted and discussed. This patch is no
> longer needed.

That's nice when it happens, thanks for letting me know nonetheless :)

Cheers

