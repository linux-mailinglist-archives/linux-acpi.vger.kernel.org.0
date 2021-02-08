Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B88F31427B
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Feb 2021 23:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhBHWBm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Feb 2021 17:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhBHWB1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Feb 2021 17:01:27 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6552C06178A
        for <linux-acpi@vger.kernel.org>; Mon,  8 Feb 2021 14:00:46 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id t5so20907883eds.12
        for <linux-acpi@vger.kernel.org>; Mon, 08 Feb 2021 14:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r89J6l710rUUDBhc44yP9Tx7/jektan0rwuh5uDDLWM=;
        b=dsSy7+QIlUg5fJpnCw9Jd2tbEIKMm1oBaH+E8Z+UF+9JNrqf0vnWP99MMBXL4Dj6qJ
         2cNYA+BKdops1ogWwVks3MoYZa2xMVCy/zAx5/NTrJ3ewbvfS/t5fWZxYGw0+RmygcmF
         hI5ZEcIJZEK4e3zu0GJiHhW92iNKeo+ke7GCsPCmqOYeREGE40sC7zXYKpJvr4dLw3J4
         g9GwkNA0sl5H9aJ8Bqz1l3mKvnuBRSaIAzfLobI1s08Xgm1ev0bRxErIZxgjG4w1w5ck
         fSvWmtuMpa01tpXV0wjl7CYUpZKjXc8K6BhI98L8FuS1cUFdUkkEnqGJA92N4/7fSB3N
         yttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r89J6l710rUUDBhc44yP9Tx7/jektan0rwuh5uDDLWM=;
        b=dtBdn0wRNXNAXuy3jlInrrONyJ6rDFpGtqDRxQMdeLvlEOPEqpnV4M6cH0HvVjRoDm
         7Zs1iZq9kxJsdhM/CrdVmuWHgPX8qzGtHANMzzXZn1otgP5eB654m/dAObKClrl6Nkbu
         LpgL6eodFZNxZD+8aYS2cijoVxi1VbtlmV5BJu40e+dITqkFbq8JqSX7FYVEz4pjvAq5
         5tRbySAHbFKCaolCaEXtmt51r+Do6TuCPacR33hBwQbUGFmPJ2VVnXcZfe8JedCIqfRb
         6f5PGegJeSovQLt/xIACROzhWT+j8f40QLs+yNweTJE7AaBkVvWfFgPLAErdcHhg3W61
         A7jw==
X-Gm-Message-State: AOAM533715AvzM0X9E3HocWuWI7MYMSksxYxHVU1yzsx12yO0ye1cMrB
        6YtRY8B/vdp/RX1TIFRL/qaMxxjSfPVcrJTZrJnpHg==
X-Google-Smtp-Source: ABdhPJzY6/u+KZJ6MZj37P3ZJJx43Erb+zC9cXNDhUnY3tNXxRfpzBL1HuhT2GNObnY0azh1Mn/lu14uXsB7CMBo1vw=
X-Received: by 2002:a05:6402:5107:: with SMTP id m7mr19262106edd.52.1612821645375;
 Mon, 08 Feb 2021 14:00:45 -0800 (PST)
MIME-Version: 1.0
References: <20210130002438.1872527-1-ben.widawsky@intel.com> <20210130002438.1872527-9-ben.widawsky@intel.com>
In-Reply-To: <20210130002438.1872527-9-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 8 Feb 2021 14:00:33 -0800
Message-ID: <CAPcyv4iPXqO5FL4_bmMQaSvmUm9FVrPv9yPJr3Q4DQWYf4t5hQ@mail.gmail.com>
Subject: Re: [PATCH 08/14] taint: add taint for direct hardware access
To:     Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        daniel.lll@alibaba-inc.com,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[ add Jon Corbet as I'd expect him to be Cc'd on anything that
generically touches Documentation/ like this, and add Kees as the last
person who added a taint (tag you're it) ]

Jon, Kees, are either of you willing to ack this concept?

Top-posting to add more context for the below:

This taint is proposed because it has implications for
CONFIG_LOCK_DOWN_KERNEL among other things. These CXL devices
implement memory like DDR would, but unlike DDR there are
administrative / configuration commands that demand kernel
coordination before they can be sent. The posture taken with this
taint is "guilty until proven innocent" for commands that have yet to
be explicitly allowed by the driver. This is different than NVME for
example where an errant vendor-defined command could destroy data on
the device, but there is no wider threat to system integrity. The
taint allows a pressure release valve for any and all commands to be
sent, but flagged with WARN_TAINT_ONCE if the driver has not
explicitly enabled it on an allowed list of known-good / kernel
coordinated commands.

On Fri, Jan 29, 2021 at 4:25 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> For drivers that moderate access to the underlying hardware it is
> sometimes desirable to allow userspace to bypass restrictions. Once
> userspace has done this, the driver can no longer guarantee the sanctity
> of either the OS or the hardware. When in this state, it is helpful for
> kernel developers to be made aware (via this taint flag) of this fact
> for subsequent bug reports.
>
> Example usage:
> - Hardware xyzzy accepts 2 commands, waldo and fred.
> - The xyzzy driver provides an interface for using waldo, but not fred.
> - quux is convinced they really need the fred command.
> - xyzzy driver allows quux to frob hardware to initiate fred.
>   - kernel gets tainted.
> - turns out fred command is borked, and scribbles over memory.
> - developers laugh while closing quux's subsequent bug report.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst   | 1 +
>  Documentation/admin-guide/tainted-kernels.rst | 6 +++++-
>  include/linux/kernel.h                        | 3 ++-
>  kernel/panic.c                                | 1 +
>  4 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 1d56a6b73a4e..3e1eada53504 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -1352,6 +1352,7 @@ ORed together. The letters are seen in "Tainted" line of Oops reports.
>   32768  `(K)`  kernel has been live patched
>   65536  `(X)`  Auxiliary taint, defined and used by for distros
>  131072  `(T)`  The kernel was built with the struct randomization plugin
> +262144  `(H)`  The kernel has allowed vendor shenanigans
>  ======  =====  ==============================================================
>
>  See :doc:`/admin-guide/tainted-kernels` for more information.
> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
> index ceeed7b0798d..ee2913316344 100644
> --- a/Documentation/admin-guide/tainted-kernels.rst
> +++ b/Documentation/admin-guide/tainted-kernels.rst
> @@ -74,7 +74,7 @@ a particular type of taint. It's best to leave that to the aforementioned
>  script, but if you need something quick you can use this shell command to check
>  which bits are set::
>
> -       $ for i in $(seq 18); do echo $(($i-1)) $(($(cat /proc/sys/kernel/tainted)>>($i-1)&1));done
> +       $ for i in $(seq 19); do echo $(($i-1)) $(($(cat /proc/sys/kernel/tainted)>>($i-1)&1));done
>
>  Table for decoding tainted state
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> @@ -100,6 +100,7 @@ Bit  Log  Number  Reason that got the kernel tainted
>   15  _/K   32768  kernel has been live patched
>   16  _/X   65536  auxiliary taint, defined for and used by distros
>   17  _/T  131072  kernel was built with the struct randomization plugin
> + 18  _/H  262144  kernel has allowed vendor shenanigans
>  ===  ===  ======  ========================================================
>
>  Note: The character ``_`` is representing a blank in this table to make reading
> @@ -175,3 +176,6 @@ More detailed explanation for tainting
>       produce extremely unusual kernel structure layouts (even performance
>       pathological ones), which is important to know when debugging. Set at
>       build time.
> +
> + 18) ``H`` Kernel has allowed direct access to hardware and can no longer make
> +     any guarantees about the stability of the device or driver.
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index f7902d8c1048..bc95486f817e 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -443,7 +443,8 @@ extern enum system_states {
>  #define TAINT_LIVEPATCH                        15
>  #define TAINT_AUX                      16
>  #define TAINT_RANDSTRUCT               17
> -#define TAINT_FLAGS_COUNT              18
> +#define TAINT_RAW_PASSTHROUGH          18
> +#define TAINT_FLAGS_COUNT              19
>  #define TAINT_FLAGS_MAX                        ((1UL << TAINT_FLAGS_COUNT) - 1)
>
>  struct taint_flag {
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 332736a72a58..dff22bd80eaf 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -386,6 +386,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
>         [ TAINT_LIVEPATCH ]             = { 'K', ' ', true },
>         [ TAINT_AUX ]                   = { 'X', ' ', true },
>         [ TAINT_RANDSTRUCT ]            = { 'T', ' ', true },
> +       [ TAINT_RAW_PASSTHROUGH ]       = { 'H', ' ', true },
>  };
>
>  /**
> --
> 2.30.0
>
