Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758EB25E53A
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Sep 2020 05:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgIEDQO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 23:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgIEDQO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Sep 2020 23:16:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57646C061244;
        Fri,  4 Sep 2020 20:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=hzcswmMwNT559dhICIggfDQsKXgz2tnBEKWAXq1CvMk=; b=EbPjQKy5mHuEsRvHD0LtSju15w
        e/POC6OtiTd1jGuxH1WfatomtddnS4izVIfMw4H7ouCTmd8YCzYovYM/hDgKKtLpmGK1aQUzEMfqB
        ubipMtPQPfHcknIORAAyBQWzbiZnBOmQ1L9ujgYEmrcjuLii5bb1uHyGMPshwQANL3vk1eDVMiBBL
        N1bwF2asqr7X7j9AJst6mllFwwCySdPeKyNKjLL1OLt6vpsQTe1suGXGgFv/RqBoGLSi5DwqiyIBj
        sjD/8VNv61TTlqDto46NALwdTuTz0glQPDLcZXZNRntCUjHjwvGJhMOlT04F0gay9iBeF29i0awXB
        fX5Mrh0g==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEOgQ-0001Ei-9v; Sat, 05 Sep 2020 03:16:07 +0000
Subject: Re: [PATCH 23/23] Documentation: gpio: add documentation for
 gpio-mockup
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20200904154547.3836-1-brgl@bgdev.pl>
 <20200904154547.3836-24-brgl@bgdev.pl>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <26ea1683-da8f-30e7-f004-3616e96d56b3@infradead.org>
Date:   Fri, 4 Sep 2020 20:15:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904154547.3836-24-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 9/4/20 8:45 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> There's some documentation for gpio-mockup's debugfs interface in the
> driver's source but it's not much. Add proper documentation for this
> testing module.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../admin-guide/gpio/gpio-mockup.rst          | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/admin-guide/gpio/gpio-mockup.rst
> 
> diff --git a/Documentation/admin-guide/gpio/gpio-mockup.rst b/Documentation/admin-guide/gpio/gpio-mockup.rst
> new file mode 100644
> index 000000000000..1d452ee55f8d
> --- /dev/null
> +++ b/Documentation/admin-guide/gpio/gpio-mockup.rst
> @@ -0,0 +1,87 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +GPIO Testing Driver
> +===================
> +
> +The GPIO Testing Driver (gpio-mockup) provides a way to create simulated GPIO
> +chips for testing purposes. There are two ways of configuring the chips exposed
> +by the module. The lines can be accessed using the standard GPIO character
> +device interface as well as manipulated using the dedicated debugfs directory
> +structure.

Could configfs be used for this instead of debugfs?
debugfs is ad hoc.

> +
> +Creating simulated chips using debugfs
> +--------------------------------------
> +
> +When the gpio-mockup module is loaded (or builtin) it creates its own directory
> +in debugfs. Assuming debugfs is mounted at /sys/kernel/debug/, the directory
> +will be located at /sys/kernel/debug/gpio-mockup/. Inside this directory there
> +are two attributes: new_device and delete_device.
> +
> +New chips can be created by writing a single line containing a number of
> +options to "new_device". For example:
> +
> +.. code-block:: sh
> +
> +    $ echo "label=my-mockup num_lines=4 named_lines" > /sys/kernel/debug/gpio-mockup/new_device
> +
> +Supported options:
> +
> +    num_lines=<num_lines> - number of GPIO lines to expose
> +
> +    label=<label> - label of the dummy chip
> +
> +    named_lines - defines whether dummy lines should be named, the names are
> +                  of the form X-Y where X is the chip's label and Y is the
> +                  line's offset
> +
> +Note: only num_lines is mandatory.
> +
> +Chips can be dynamically removed by writing the chip's label to
> +"delete_device". For example:
> +
> +.. code-block:: sh
> +
> +    echo "gpio-mockup.0" > /sys/kernel/debug/gpio-mockup/delete_device
> +
> +Creating simulated chips using module params
> +--------------------------------------------
> +
> +Note: this is an older, now deprecated method kept for backward compatibility
> +for user-space tools.
> +
> +When loading the gpio-mockup driver a number of parameters can be passed to the
> +module.
> +
> +    gpio_mockup_ranges
> +
> +        This parameter takes an argument in the form of an array of integer
> +        pairs. Each pair defines the base GPIO number (if any) and the number
> +        of lines exposed by the chip. If the base GPIO is -1, the gpiolib
> +        will assign it automatically.
> +
> +        Example: gpio_mockup_ranges=-1,8,-1,16,405,4
> +
> +        The line above creates three chips. The first one will expose 8 lines,
> +        the second 16 and the third 4. The base GPIO for the third chip is set
> +        to 405 while for two first chips it will be assigned automatically.
> +
> +    gpio_named_lines
> +
> +        This parameter doesn't take any arguments. It lets the driver know that
> +        GPIO lines exposed by it should be named.
> +
> +        The name format is: gpio-mockup-X-Y where X is the letter associated
> +        with the mockup chip and Y is the line offset.

Where does this 'X' letter associated with the mockup chip come from?

> +
> +Manipulating simulated lines
> +----------------------------
> +
> +Each mockup chip creates its own subdirectory in /sys/kernel/debug/gpio-mockup/.
> +The directory is named after the chip's label. A symlink is also created, named
> +after the chip's name, which points to the label directory.
> +
> +Inside each subdirectory, there's a separate attribute for each GPIO line. The
> +name of the attribute represents the line's offset in the chip.
> +
> +Reading from a line attribute returns the current value. Writing to it (0 or 1)
> +changes its pull.

What does "pull" mean here?


thanks.

-- 
~Randy

