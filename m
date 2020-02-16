Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5350816013D
	for <lists+linux-acpi@lfdr.de>; Sun, 16 Feb 2020 01:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgBPAdK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 15 Feb 2020 19:33:10 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37503 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgBPAdJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 15 Feb 2020 19:33:09 -0500
Received: by mail-oi1-f196.google.com with SMTP id q84so13358724oic.4
        for <linux-acpi@vger.kernel.org>; Sat, 15 Feb 2020 16:33:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZLxP729Hj2mPTsunmYYMiOm3RNDMPGpVUrODSh/oP5I=;
        b=RySKHLEfl2ArtRyRLrAT1v01wJEayYKuIwjF+ZbjL4ivTxa7Sh/vDZ+gZH1XAh3aBa
         qzkfEwWstu/sLZa+uI7UOBFLr7I49wtrFPRs9CPzFs924++1PddoQI3NbOSBADiBxTsz
         248JCMYjW6nso+C5v4a7CPrjG/WuhobzImXqBddvNISH47P6QAn5Wih1tj6/NSjiTkwv
         xFXMtGd9Kg9Z8KhR1usaACdkpMKFEdm39f0Mdux5G12+KWfjcnaAbQh4HiQMvXNCSHDV
         4m4+zeg2uUF9JZXCmc4LFVtzCQ3BJv9S3GlEUXKocWsti/o2UBp6FPX4YaQSIfd2xvhN
         2qAw==
X-Gm-Message-State: APjAAAVithokoGq56F4OVn+YWY9hkYbXcpkqRRkMJAxRUgbC0HTnASaU
        69JDfe8Ypff5ia+6i4xiRkU84RMJdXc3to9l4TJM3w==
X-Google-Smtp-Source: APXvYqxGaLbDUS2ch4lNgvgIEV+7yaLdK6FrcKR3wiNqaIEowmcB6iAUePiavt6ggAPiICzRhaP8N+w6gJga+HMUHQs=
X-Received: by 2002:a54:4e96:: with SMTP id c22mr6463774oiy.110.1581813189019;
 Sat, 15 Feb 2020 16:33:09 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2002141734590.24119@n3.vanv.qr>
In-Reply-To: <nycvar.YFH.7.76.2002141734590.24119@n3.vanv.qr>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 16 Feb 2020 01:32:55 +0100
Message-ID: <CAJZ5v0jesX_fz6-1wnNqYqtVE1qtjZhMsq2OW2L6EGvcpLPtsg@mail.gmail.com>
Subject: Re: Linux hangs at ACPI init on Medion P15648 MD63490
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 14, 2020 at 8:28 PM Jan Engelhardt <jengelh@inai.de> wrote:
>
> Greetings.
>
>
> I have a problem with a certain x86 laptop, and judging from the
> kernel's output, this looks very much like a broken ACPI table.
> Versions tried are 5.3.8 (Fedora31 liveimage), 5.5.2 (openSUSE
> Tumbleweed installer) and 5.6.0-rc1+
> (b19e8c68470385dd2c5440876591fddb02c8c402; self compile), all
> exhibiting the same hang.
>
> The last messages emitted by 5.6.0-rc1+ are:
>
>         ACPI: 11 ACPI AML tables successfully acquired and loaded
>         ACPI: EC: EC started
>         ACPI: EC: interrupt blocked
>         ACPI: \: Used as first EC
>         ACPI: \: GPE=0x10, IRQ=-1, EC_CMD/EC_SC=0x66, EC_DATA=0x62
>         ACPI: EC: Boot ECDT EC used to handle transactions
>         <hang>
>
> The full boot procedure is made available at
> http://inai.de/files/m921.mp4 [79MB].
> Curiously, FreeBSD 12.1 can be booted without issues, so either they
> already workaround the issue, or don't trigger it in the first place.

Would it be possible to try 5.0 or earlier on the problematic machine?

You may be hitting a regression here.

> After about 20 minutes, the kernel issues a stack trace.
> http://inai.de/files/m922.mp4 [4.2M]; this seems to repeat every
> 20 minutes:
>
>         Task swapper blocked for more than 491 seconds.
>         schedule
>         schedule_timeout
>         __down_timeout
>         down_timeout
>         acpi_os_wait_semaphore
>         acpi_ex_system_wait_semaphore
>         acpi_ev_acquire_global_lock
>         acpi_ex_acquire_mutex_object
>         acpi_ex_acquire_global_lock
>         acpi_ex_write_data_to_field
>         acpi_ex_store_object_to_node
>         acpi_ex_store
>         acpi_ex_opcode_1A_1T_1R
>         acpi_ds_exec_end_op
>         acpi_ps_parse_loop
>         [a few frames more]
>
> For comparison, a (vastly) different laptop with a proper firmware,
> the EC messages go like this:
>
>         <Fujitsu U728 for comparison>
>         ACPI: EC: EC started
>         ACPI: EC: interrupt blocked
>         ACPI: \_SB_.PCI0.LPCB.EC__: Used as first EC
>         ACPI: \_SB_.PCI0.LPCB.EC__: GPE=0x22, EC_CMD/EC_SC=0x66, EC_DATA=0x62
>         ACPI: \_SB_.PCI0.LPCB.EC__: Boot DSDT EC used to handle transactions
>         ACPI: Interpreter enabled
>
> It kind of makes sense that, if "\" is seen as an EC in the Medion that
> it is not going to work.
