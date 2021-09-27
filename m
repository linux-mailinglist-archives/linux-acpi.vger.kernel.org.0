Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1096419CA9
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Sep 2021 19:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237262AbhI0Ras (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Sep 2021 13:30:48 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:43793 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238321AbhI0R2s (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Sep 2021 13:28:48 -0400
Received: by mail-ot1-f46.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so25399070otb.10;
        Mon, 27 Sep 2021 10:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NGpjyQ+zJXVEsYPGA2Ugx59FHWjXwG00/ucsJLecqZ0=;
        b=vdN2OVO3rY/CYTBCfKTO9GSEKEMnXQ/nWM6Zp7HIOJ5tTMPOEfALn9ymkW52zpiz7y
         3q400Lu5Scb+YI6cnyst6Km6LhFKt2jIdJlBCaUFCsURReeTy5rY8Kb1oGvMGIvVmg+T
         oO18RdG/ZQfg8ZlD9XL7HOFCk6gaa4XlLfAwDY1yfQlNeQesn33f5SGibnA25BpqdOZF
         2OyRBJBGdNycR2Q3nl7COGCn+66NYm599wcqvF0JJhdkjROz/P3JqiYBc/t7zfbQ/Ygw
         tRx7+JBO/isD3QYQZbX9t9RjxAhLf9gw/Z9MaabhuwuQU7g/WHNWTswnYyGNpyGhJnoU
         Gzog==
X-Gm-Message-State: AOAM5335Kl5EZIBVr46EryrX/ehqIuRXs4GKTj1E9FtAkQzFpxII91FU
        ytQLG5VuFinF9FsFjw4970c70ShJSUSq4QT2bGY=
X-Google-Smtp-Source: ABdhPJyAnY0vsgCY1m7GqG39dofuhpTzB+7Q0yRwhHdXi/LusxLfoXqtRSqJXgbavAbW8CJnU4t8Yt69+Lc3FinSF1o=
X-Received: by 2002:a05:6830:82b:: with SMTP id t11mr1026186ots.319.1632763629962;
 Mon, 27 Sep 2021 10:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631802162.git.yu.c.chen@intel.com> <084c590593cb18fed03c6631fb9f39dcfaf66d53.1631802162.git.yu.c.chen@intel.com>
In-Reply-To: <084c590593cb18fed03c6631fb9f39dcfaf66d53.1631802162.git.yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Sep 2021 19:26:59 +0200
Message-ID: <CAJZ5v0hoXc=ha1Mv_yWMX7L8q4DzaXL4wagKqQy6RBcF8Qe7JQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] Documentation: Introduce Platform Firmware Runtime
 Update documentation
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 16, 2021 at 5:53 PM Chen Yu <yu.c.chen@intel.com> wrote:
>
> Add the Platform Firmware Runtime Update/Telemetry documentation.
>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v3: No change since v2.
> v2: Add a spot in index.rst so it becomes part of the docs build
>     (Jonathan Corbet).
>     Sticking to the 80-column limit(Jonathan Corbet).
>     Underline lengths should match the title text(Jonathan Corbet).
>     Use literal blocks for the code samples(Jonathan Corbet).
> ---
>  Documentation/x86/index.rst |   1 +
>  Documentation/x86/pfru.rst  | 100 ++++++++++++++++++++++++++++++++++++

The location of this file is somewhat questionable to me.

The interface described by it talks to the platform firmware via ACPI
methods, there's nothing x86-specific in it.

Besides, it is hard to say who's the target audience of this document.

>  2 files changed, 101 insertions(+)
>  create mode 100644 Documentation/x86/pfru.rst
>
> diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> index 383048396336..3791fabf964c 100644
> --- a/Documentation/x86/index.rst
> +++ b/Documentation/x86/index.rst
> @@ -37,3 +37,4 @@ x86-specific Documentation
>     sgx
>     features
>     elf_auxvec
> +   pfru
> diff --git a/Documentation/x86/pfru.rst b/Documentation/x86/pfru.rst
> new file mode 100644
> index 000000000000..29fe0e518e6d
> --- /dev/null
> +++ b/Documentation/x86/pfru.rst
> @@ -0,0 +1,100 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +========================================================
> +The Linux Platform Firmware Runtime Update and Telemetry
> +========================================================

The "The Linux" piece doesn't add any value here IMO.

> +
> +According to the specification of `Management Mode Firmware Runtime Update
> +<https://uefi.org/sites/default/files/resources/Intel_MM_OS_Interface_Spec_
> +Rev100.pdf>`_, certain computing systems require high Service Level Agreements
> +(SLAs) where system reboot fewer firmware updates are required to deploy
> +firmware changes to address bug fixes, security updates and to debug and root
> +cause issues. This technology is called Intel Seamless Update. The management
> +mode (MM), UEFI runtime services and ACPI services handle most of the system
> +runtime functions. Changing the MM code execution during runtime is called MM
> +Runtime Update. Since the "MM" acronyms might be misunderstood as "Memory
> +Management", this driver uses the name of "Platform Firmware Runtime Update"
> +(PFRU).

In the above paragraph it is not necessary to mention the "high SLAs"
at all.  IMO it would be sufficient to say something like "The PFRU
(Platform Firmware Runtime Update) kernel interface is designed to
interact with the platform firmware interface defined in the
`Management Mode Firmware Runtime Update
<https://uefi.org/sites/default/files/resources/Intel_MM_OS_Interface_Spec_Rev100.pdf>`_
specification."

> +
> +PFRU provides the following facilities: Performs a runtime firmware driver
> +update and activate. Ability to inject firmware code at runtime, for dynamic
> +instrumentation. PFRU Telemetry is a service which allows Runtime Update
> +handler to produce telemetry data to upper layer OS consumer at runtime. The
> +OS provides interfaces to let the users query the telemetry data via read
> +operations. The specification specifies the interface and recommended policy
> +to extract the data, the format and use are left to individual OEM's and BIOS
> +implementations on what that data represents.

I'd just say "The primary function of PFRU is to carry out runtime
updates of the platform firmware, which doesn't require the system to
be restarted.  It also allows telemetry data to be retrieved from the
platform firmware."  And the part about how the PFRU telemetry is
supposed to work belongs to the description of that part.

> +
> +PFRU interfaces
> +===============

Because this doesn't really specify the kernel ABI, the part below
belongs to the man page of the tool that you're going to provide.

In order to document the ABI, please add a document to
Documentation/ABI/testing/ along the lines of
Documentation/ABI/testing/rtc-cdev

> +
> +The user space tool manipulates on /dev/pfru/update for code injection and
> +driver update. PFRU stands for Platform Firmware Runtime Update, and the
> +/dev/pfru directory might be reserved for future usage::
> +
> + 1. mmap the capsule file.
> +    fd_capsule = open("capsule.cap", O_RDONLY);
> +    fstat(fd_capsule, &stat);
> +    addr = mmap(0, stat.st_size, PROT_READ, fd_capsule);
> +
> + 2. Get the capability information(version control, etc) from BIOS via
> +    read() and do sanity check in user space.
> +    fd_update = open("/dev/pfru/update", O_RDWR);
> +    read(fd_update, &cap, sizeof(cap));
> +    sanity_check(&cap);
> +
> + 3. Write the capsule file to runtime update communication buffer.
> +    kernel might return error if capsule file size is longer than
> +    communication buffer.
> +    write(fd_update, addr, stat.st_size);
> +
> + 4. Stage the code injection.
> +    ioctl(fd_update, PFRU_IOC_STATGE);
> +
> + 5. Activate the code injection.
> +    ioctl(fd_update, PFRU_IOC_ACTIVATE);
> +
> + 6. Stage and activate the code injection.
> +    ioctl(fd_update, PFRU_IOC_STAGE_ACTIVATE);
> +
> +    PFRU_IOC_STATGE: Stage a capsule image from communication buffer
> +    and perform authentication.
> +    [PFRU_IOC_ACTIVATE] Activate a previous staged capsule image.
> +    [PFRU_IOC_STAGE_ACTIVATE] Perform both stage and activation actions.
> +
> +
> +PFRU Telemetry interfaces
> +=========================
> +
> +The user space tool manipulates on /dev/pfru/telemetry for PFRU telemetry log::
> +
> + 1. Open telemetry device
> +    fd_log = open("/dev/pfru/telemetry", O_RDWR);
> +
> + 2. Get log level, log type, revision_id via one ioctl invoke
> +    ioctl(fd_log, PFRU_IOC_GET_LOG_INFO, &info);
> +
> + 3. Set log level, log type, revision_id
> +    ioctl(fd_log, PFRU_IOC_SET_LOG_INFO, &info);
> +
> + 4. ioctl(fd_log, PFRU_IOC_GET_DATA_INFO, &data_info);
> +    Query the information of PFRU telemetry log buffer. The user is
> +    responsible for parsing the result per the specification.
> +
> + 5. Read the telemetry data:
> +    read(fd_log, buf, data_info.size);
> +
> +Please refer to tools/testing/selftests/pfru/pfru_test.c for detail.
> +
> +According to the specification of `Management Mode Firmware Runtime Update

I'd say "According to the ... specification," (ie. without the "of").

> +<https://uefi.org/sites/default/files/resources/Intel_MM_OS_Interface_Spec_
> +Rev100.pdf>`_, the telemetry buffer is a wrap around buffer. If the telemetry
> +buffer gets full, most recent log data will overwrite old log data. Besides,
> +it is required in the spec that the read of telemetry should support both full
> +data retrieval and delta telemetry data retrieval. Since this requirement is
> +more likely a policy we leave this implementation in user space. That is to
> +say, it is recommended for the user to double-read the telemetry parameters
> +such as chunk1_size, chunk2_size, rollover_cnt in data_info structure to make

It is not clear what you mean by "double read".  It looks like you
wanted to say that it was recommended to call the
PFRU_IOC_GET_DATA_INFO ioctl() before a "continuation" read in order
to check if more data was available.

> +sure that there is no more data appended while the user is reading the buffer.
> +Besides, only after the runtime update has been run at least once, the telemetry
> +log would have valid data, otherwise errno code of EBUSY would be returned.
> --
