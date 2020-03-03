Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4A4C178437
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Mar 2020 21:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbgCCUlt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Mar 2020 15:41:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46034 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbgCCUlt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Mar 2020 15:41:49 -0500
Received: by mail-wr1-f67.google.com with SMTP id v2so6100210wrp.12;
        Tue, 03 Mar 2020 12:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=woDLnQT31XgiRNk9DQZv8gRSvGaIo3mJ0GaQ1nM51GM=;
        b=LHmrPVvlbsRGCO5FAVzOsvmkCEv2jIPik6Jl6Ftr7arZdioMmpaPOAThUL1l/I6Qlm
         3rj35adGbgtXFwUwf7pbRww3k3AGqSDywui69IF7xWP1UPDc7BkDj/x7qFFeQQO2XMaT
         OmsJEhOXGj/onAHf2S2mSCfI9l/k9OkIeaelF98O+FfuHhXktI9X5VBkMaOW5MnUaMnZ
         6qzNk+BbOZV77tOftXvnZ5tZKP24mg04Hh1V6Pan7Spu8rSYDK18lYxF6wqbiFkcs91z
         4UvCbEY94m1D3BI2XUfYe9YihoJfWIkzQHMpkNrJTFVUPU+A7toKSOLo4Zime/TkeSrc
         Maiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=woDLnQT31XgiRNk9DQZv8gRSvGaIo3mJ0GaQ1nM51GM=;
        b=NFqryLiMKMwSbV2gylnL3SBYMSad5kyejJR7NgvJ3h6cGYqYVgyflpu0OI5pSYowYX
         rdx1+0rq6olqff43SMkPQ/s+qlMCnXBdGfqU+4UxFXiBa81skHUz/VHBkq2zdHy3T8UX
         vz9H6I4ph/GtNwpcCRWSXXxV8IADMQaha26nVTUJ5bTsr5qZj/XhVXb8QGd2M9WgPHBF
         TDb7YUT6QjLgbB9Z7Zf2lmRKfMuEwL4FocnzX23YCmeklz6rgGf8x1dbGFcLcsryd79I
         70sZkta+V4X11lMykGHreB5c/oaf95zUvXAVnfddrrh8I97G891Fv5Co4dBZK2SmH0Z5
         bOZw==
X-Gm-Message-State: ANhLgQ3gAgyOa9czZmgP6VvOy0+NxSjytXORnCik2RhnC8Q9eHob1wlB
        SwfMcSZeigoIt32i+aGiCQ==
X-Google-Smtp-Source: ADFU+vsGj6aZ/TvtMwnt6J6I/4YSUsaorDIgFG1wjuPKvkja3v7ctdlD9lfPY1nBMmBmrqWDZEJZfw==
X-Received: by 2002:a05:6000:189:: with SMTP id p9mr7039296wrx.391.1583268106733;
        Tue, 03 Mar 2020 12:41:46 -0800 (PST)
Received: from avx2 ([46.53.249.49])
        by smtp.gmail.com with ESMTPSA id w16sm1387813wrp.8.2020.03.03.12.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 12:41:46 -0800 (PST)
Date:   Tue, 3 Mar 2020 23:41:44 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH] x86/acpi: make "asmlinkage" part first thing in the function
 definition
Message-ID: <20200303204144.GA9913@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

g++ insists that function declaration must start with extern "C"
(which asmlinkage expands to).

gcc doesn't care.

Signed-off-by: _Z6Alexeyv <adobriyan@gmail.com>
---

 arch/x86/kernel/acpi/sleep.c |    2 +-
 arch/x86/kernel/acpi/sleep.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -43,7 +43,7 @@ unsigned long acpi_get_wakeup_address(void)
  *
  * Wrapper around acpi_enter_sleep_state() to be called by assmebly.
  */
-acpi_status asmlinkage __visible x86_acpi_enter_sleep_state(u8 state)
+asmlinkage acpi_status __visible x86_acpi_enter_sleep_state(u8 state)
 {
 	return acpi_enter_sleep_state(state);
 }
--- a/arch/x86/kernel/acpi/sleep.h
+++ b/arch/x86/kernel/acpi/sleep.h
@@ -19,4 +19,4 @@ extern void do_suspend_lowlevel(void);
 
 extern int x86_acpi_suspend_lowlevel(void);
 
-acpi_status asmlinkage x86_acpi_enter_sleep_state(u8 state);
+asmlinkage acpi_status x86_acpi_enter_sleep_state(u8 state);
