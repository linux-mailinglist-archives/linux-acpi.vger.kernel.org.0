Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FF5468665
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Dec 2021 18:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355552AbhLDRH5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 4 Dec 2021 12:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345234AbhLDRH5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Dec 2021 12:07:57 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479C8C0613F8
        for <linux-acpi@vger.kernel.org>; Sat,  4 Dec 2021 09:04:31 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x15so24908730edv.1
        for <linux-acpi@vger.kernel.org>; Sat, 04 Dec 2021 09:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R+IHFqT+1cIu4d25MxA/33I5hw37sbqf3L8hQmO39cs=;
        b=gdi/hrEsdJa+MtfK1vcA4icU4vcH7+xTuMkSP1+Kea3LWAERjc6zptW/sunycSyp5v
         7GO/CviYc2t+irIBL4f5IVweYDR37BBXHv0XPvKNO3yTVOTfhx3PLAdMKNBU8l/5h01P
         gMrZXiGARkAf9jAbSY4vCAHvvk4TJ3KY/gPhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R+IHFqT+1cIu4d25MxA/33I5hw37sbqf3L8hQmO39cs=;
        b=GM5Gu1XIhIDN83VUWGzVi9egfBdpqQ3KiIrp31C9oVf/XBcWAMQ17NmtiIiZVqiUsP
         K/YYnBH/UMcamGMLkuJviUVwcsrwZ1NPUn8BiMTEIhk3gY6aJqIDYNH3M7YMn3erdahe
         QoWnMXbZGpFrnmXJxzofx0PrqCDsZGF74TwKvZ3+KnM4Sr+FSBAOUZuGPfl/8ZoJXSyt
         0DS41SjMJ2uq6PkyquqPwMHEyLihnWMIce83KTymLGBM8F0OTGj4cVmUuq8Tf6LdQ/tw
         u2e6V6BKqzGoaQV4eX1U4xCKxZo/9SUzDMZnpL3Mcf3S9lq9tq4ZNaXBMfhdPbi222sN
         ohmQ==
X-Gm-Message-State: AOAM533Z7EkdEofi3q9fJXp8GYGYPji8fOMwC4KzhZ/UcTeBpoxLoBR+
        aFqT13bflo2DlYGLNPevtzDnhC4n7/vDaldM
X-Google-Smtp-Source: ABdhPJzCWRDjRnobSGieb+avx8ArXpAhaRw0MNj5vEt/NOK7G016dkX53tDYltwXNziQguMgosIDFA==
X-Received: by 2002:aa7:d695:: with SMTP id d21mr36673979edr.378.1638637469348;
        Sat, 04 Dec 2021 09:04:29 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id r24sm4148821edv.18.2021.12.04.09.04.28
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Dec 2021 09:04:28 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id j3so12801150wrp.1
        for <linux-acpi@vger.kernel.org>; Sat, 04 Dec 2021 09:04:28 -0800 (PST)
X-Received: by 2002:adf:f8c3:: with SMTP id f3mr30048229wrq.495.1638637467944;
 Sat, 04 Dec 2021 09:04:27 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0hQaF-ANLc4JO=Ub_JMsqLFpZev_gmpb=NPpg=zmqcauA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hQaF-ANLc4JO=Ub_JMsqLFpZev_gmpb=NPpg=zmqcauA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Dec 2021 09:04:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiGbtmc+FoUjcgaQRavL=B=rfTmA_VhTtGpmhmk2873cA@mail.gmail.com>
Message-ID: <CAHk-=wiGbtmc+FoUjcgaQRavL=B=rfTmA_VhTtGpmhmk2873cA@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fixes for v5.16-rc3
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 26, 2021 at 11:38 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  acpi-5.16-rc3

Hmm. This may be unrelated, but I don't think I've seen this before..
On my laptop, I get

  WARNING: CPU: 4 PID: 95940 at kernel/workqueue.c:1441 __queue_work+0x2f9/0x3b0
  Workqueue: kec_query acpi_ec_event_processor
  ..
  Call Trace:
   <TASK>
   queue_work_on+0x20/0x30
   advance_transaction+0x1a1/0x500
   acpi_ec_transaction+0x15c/0x410
   acpi_ec_space_handler+0xd2/0x270
   acpi_ev_address_space_dispatch+0x216/0x2a3
   ? acpi_ec_resume+0x20/0x20
   acpi_ex_access_region+0x1dc/0x255
   ? acpi_os_wait_semaphore+0x48/0x70
   acpi_ex_field_datum_io+0xfd/0x178
   acpi_ex_read_data_from_field+0x12e/0x171
   acpi_ex_resolve_node_to_value+0x1fe/0x281
   acpi_ds_evaluate_name_path+0x75/0xe9
   acpi_ds_exec_end_op+0x8f/0x411
   acpi_ps_parse_loop+0x495/0x5bc
   acpi_ps_parse_aml+0x94/0x2c2
   acpi_ps_execute_method+0x15e/0x193
   acpi_ns_evaluate+0x1c6/0x25d
   acpi_evaluate_object+0x12e/0x226
   acpi_ec_event_processor+0x63/0x90
   process_one_work+0x217/0x3c0

and it seems to be happening at resume time.

This was when running a51e3ac43ddb, so not the very latest git tree,
but recent.

Maybe I've missed a report of this?

               Linus
