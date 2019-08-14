Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 667288DA27
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2019 19:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730979AbfHNRPl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Aug 2019 13:15:41 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44551 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731157AbfHNRPH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Aug 2019 13:15:07 -0400
Received: by mail-ot1-f67.google.com with SMTP id w4so9078659ote.11
        for <linux-acpi@vger.kernel.org>; Wed, 14 Aug 2019 10:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=01Ayf9LgEcMv7V+WI2AsTnek5WUaEhOAgw1TLPT5Lg8=;
        b=cUY4bV8z98fFrOSFWWEdErQVDghtf844gc08EquK79TWPwgrs8cts9QORhUbmj84w6
         f6m4/lvh33jikA+ZGM+tRxQ7toWhgXNf/hwvBLPgnKwiBbxG/hNFcYj9+6y8trNIYobL
         ilhTnpmaW/fEejmEK013Y8FFlYqMK/zF/v1CwFP79IdFl+ufYbogIYsXzDf8W3I4UxKF
         r8v0YXlyRRhd1ggXnCn4S6QZLyTNrwzaOdCaJg1+ES5vnUy0kZjxLEi49f9BB2aexwxP
         eHVzRfwa+CreiMnCsgeyIj4Uq36gE0EIt5XlCqU8y22UxzWojnwOuHQRKsdXe9SxFPNa
         DIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=01Ayf9LgEcMv7V+WI2AsTnek5WUaEhOAgw1TLPT5Lg8=;
        b=Ojx796Fm8cZz4f1fjvYPx/wii6xvBXYCDQIuBL6qvZ7XZ+wawpqQBqBHTkOzEx3Iff
         vHMajGQuJThe5bso/4dmh+4HBfNf5CVc/eVMi7CaorrZwqOR9EtBD8Autgfowfer78XY
         1t0ci3OawzO7IzcW1BGweTefImoZJnotfLuYg74NpIH1JE8XSP60O8b9lhUlbm1FH3jS
         /Qu6cZwkapHCyEcfCXJbX6xip1vk30b1d9PWoubxtlLjdphRek/faz/p68W4RdL4bOVn
         T5kreD59woXaSRYplhC2u7jOy9n9b3x4Tq+IiRzeekW5sKrCCbzxaAtUFCh0TwtgovoG
         ZVtg==
X-Gm-Message-State: APjAAAUT553U3HWXaK5BA8fOX9+qkSgIvPps8LQ5rEaZqJrhy/243ub9
        q5zuy1syMr7UPhFTdcO+PY4V0umylbJ+W8Mj6s+kzA==
X-Google-Smtp-Source: APXvYqx0J+BLly1ZtoTkIyMRX0f+EWksHL1efdejnhvFvA6o4jTrFb7cWvdHrOwDDKU8F7aJNPtUW/N21twPL0yxhHI=
X-Received: by 2002:a6b:8f47:: with SMTP id r68mr1046835iod.204.1565802905873;
 Wed, 14 Aug 2019 10:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com>
 <20190808000721.124691-16-matthewgarrett@google.com> <20190814072602.GA27836@zn.tnic>
In-Reply-To: <20190814072602.GA27836@zn.tnic>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 14 Aug 2019 10:14:54 -0700
Message-ID: <CACdnJuuOhuw71GDwQOrPQxUexpvpZNJocr6m0dYzJw+MMaVKWQ@mail.gmail.com>
Subject: Re: [PATCH V38 15/29] acpi: Ignore acpi_rsdp kernel param when the
 kernel has been locked down
To:     Borislav Petkov <bp@alien8.de>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Josh Boyer <jwboyer@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Young <dyoung@redhat.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Aug 14, 2019 at 12:25 AM Borislav Petkov <bp@alien8.de> wrote:
> #if defined(CONFIG_RANDOMIZE_BASE) && defined(CONFIG_MEMORY_HOTREMOVE)
>
> false and thus not available to early code anymore.

We explicitly don't want to pay attention to the acpi_rsdp kernel
parameter in early boot except for the case of finding the SRAT table,
and we only need that if CONFIG_RANDOMIZE_BASE and
CONFIG_MEMORY_HOTREMOVE are set. However, we *do* want to tell the
actual kernel where the RSDP is if we found it via some other means,
so we can't just clear the boot parameters value. The kernel proper
will parse the command line again and will then (if lockdown isn't
enabled) override the actual value we passed up in boot params. So I
think this is ok?

(Sorry for not Cc:ing x86, clear oversight on my part)
