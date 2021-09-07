Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2869402BB2
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Sep 2021 17:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345175AbhIGPZE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Sep 2021 11:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344974AbhIGPZD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Sep 2021 11:25:03 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26571C061575
        for <linux-acpi@vger.kernel.org>; Tue,  7 Sep 2021 08:23:57 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D7D46735;
        Tue,  7 Sep 2021 15:23:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D7D46735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1631028234; bh=tceuoqLCbBFi1wF26LSs4mfr8Ji5ZyYIiWgS4g2Nw28=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Y3UwR/UCsHOVfoocFGfI8/D0TdbxHDngUtgeoq/0/QrYbVbUU2MiSF3TVHCcqk0em
         eJArinU/agJlFsU8Pi/2WQKW+jIgfTbPSWgqif6Na9MoPDL+mdssmr/RD+OpPORljy
         BIUb5NyGap0D4LghrmCCuj8UnYsufEWADl4YNCV0XJRrbjff+haY0w94KD/znFD6Ce
         FonzB9IoSYW6KdprtCm2mW5Pd9UifctoAVsS6q1hPoN869X3fllOfYCufIVEpByn8+
         gVE7wdhzIXnoJvnql360vQRZXSTkFq+pjQrNYNbkd39bfrygVXp9igEg3IOR8hdpTf
         OWQKkkUHvZKpw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Chen Yu <yu.c.chen@intel.com>, linux-acpi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 1/5][RFC] Documentation: Introduce Platform Firmware
 Runtime Update documentation
In-Reply-To: <c135a9bf742f3c2181650914f40ce563d7a3dc48.1631025237.git.yu.c.chen@intel.com>
References: <cover.1631025237.git.yu.c.chen@intel.com>
 <c135a9bf742f3c2181650914f40ce563d7a3dc48.1631025237.git.yu.c.chen@intel.com>
Date:   Tue, 07 Sep 2021 09:23:53 -0600
Message-ID: <87sfygtnna.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thanks for adding to the documentation.  I have a few nits for you...

Chen Yu <yu.c.chen@intel.com> writes:

> Add the Platform Firmware Runtime Update/Telemetry documentation.
>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  Documentation/x86/pfru.rst | 98 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/x86/pfru.rst

When you add a new RST file, you also need to find a spot for it in
index.rst so it becomes part of the docs build.

> diff --git a/Documentation/x86/pfru.rst b/Documentation/x86/pfru.rst
> new file mode 100644
> index 000000000000..321729f46737
> --- /dev/null
> +++ b/Documentation/x86/pfru.rst
> @@ -0,0 +1,98 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +========================================================
> +The Linux Platform Firmware Runtime Update and Telemetry
> +========================================================
> +
> +According to the specification of <Management Mode Firmware Runtime Update>[1],
> +certain computing systems require high Service Level Agreements (SLAs) where
> +system reboot fewer firmware updates are required to deploy firmware changes
> +to address bug fixes, security updates and to debug and root cause issues. This
> +technology is called Intel Seamless Update. The management mode (MM),
> +UEFI runtime services and ACPI services handle most of the system runtime
> +functions. Changing the MM code execution during runtime is called MM Runtime
> +Update. Since the "MM" acronyms might be misunderstood as "Memory Management",
> +this driver uses "Platform Firmware Runtime Update"(PFRU)
> +
> +PFRU provides the following facilities: Performs a runtime firmware driver update
> +and activate. Ability to inject firmware code at runtime, for dynamic instrumentation.
> +PFRU Telemetry is a service which allows Runtime Update handler to produce telemetry
> +data to upper layer OS consumer at runtime. The OS provides interfaces to let the
> +users query the telemetry data via read operations. The specification specifies the
> +interface and recommended policy to extract the data, the format and use are left to
> +individual OEM's and BIOS implementations on what that data represents.

Sticking to the 80-column limit is preferable; it keeps the text
readable. 

> +PFRU interfaces
> +=====================

Underline lengths should match the title text, or Sphinx will get grumpy
with you.

> +The user space tool manipulates on /dev/pfru/update for code injection and
> +driver update. PFRU stands for Platform Firmware Runtime Update, and the /dev/pfru
> +directory might be reserved for future usage.
> +
> + 1. mmap the capsule file
> +    fd_capsule = open("capsule.cap", O_RDONLY);
> +    fstat(fd_capsule, &stat);
> +    addr = mmap(0, stat.st_size, PROT_READ, fd_capsule);

These will not render the way you would like; you'll want to use literal
blocks for the code samples.

> + 2. Get the capability information(version control, etc) from BIOS via
> +    read() and do sanity check in user space.
> +    fd_update = open("/dev/pfru/update", O_RDWR);
> +    read(fd_update, &cap, sizeof(cap));
> +    sanity_check(&cap);
> +
> + 3. Write the capsule file to runtime update communication buffer
> +    //kernel might return error if capsule file size is longer than
> +    //communication buffer
> +    write(fd_update, addr, stat.st_size);
> +
> + 4. Stage the code injection
> +    ioctl(fd_update, PFRU_IOC_STATGE);
> +
> + 5. Activate the code injection
> +    ioctl(fd_update, PFRU_IOC_ACTIVATE);
> +
> + 6. Stage and activate the code injection
> +    ioctl(fd_update, PFRU_IOC_STAGE_ACTIVATE);
> +
> +    PFRU_IOC_STATGE: Stage a capsule image from communication buffer
> +                    and perform authentication.
> +    PFRU_IOC_ACTIVATE: Activate a previous staged capsule image.
> +    PFRU_IOC_STAGE_ACTIVATE: Perform both stage and activation actions.
> +
> +PFRU Telemetry
> +=============
> +
> +The user space tool manipulates on /dev/pfru/telemetry for PFRU telemetry log.
> +Sample code:
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
> +According to <Management Mode Firmware Runtime Update>[1], the telemetry
> +buffer is a wrap around buffer. If the telemetry buffer gets full, most recent
> +log data will overwrite old log data. Besides, it is required in the spec that
> +the read of telemetry should support both full data retrieval and delta telemetry
> +data retrieval. Since this requirement is more likely a policy we leave this
> +implementation in user space. That is to say, it is recommended for the user
> +to double-read the telemetry parameters such as chunk1_size, chunk2_size,
> +rollover_cnt in data_info structure to make sure that there is no more data appended
> +while the user is reading the buffer. Besides, only after the runtime update has
> +been run at least once, the telemetry log would have valid data, otherwise errno code
> +of EBUSY would be returned.
> +
> +[1] https://uefi.org/sites/default/files/resources/Intel_MM_OS_Interface_Spec_Rev100.pdf
> -- 
> 2.25.1

Thanks,

jon
