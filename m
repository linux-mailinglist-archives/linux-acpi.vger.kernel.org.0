Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B11C115CE3D
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2020 23:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgBMWnZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Feb 2020 17:43:25 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:32875 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgBMWnZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Feb 2020 17:43:25 -0500
Received: by mail-ot1-f65.google.com with SMTP id b18so7308773otp.0;
        Thu, 13 Feb 2020 14:43:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y/I0tTkwJibmul9vKP2bADMtVfoWuV76rC3/FPcX9E4=;
        b=aNuq3//3MDk4sUxxOQe4nS8vmpJT5vb2AU1rOxevDyKke1x01/KftLnrGEazceydiC
         QnHUEa+qlw2rjYHXulA04pcSMMcqFhAbQtBCVf/s+FS/AzPUX84chpukYoSd+RYHVB1v
         mKU1b8ePDFoliOa4X3Lq0bclgGwwamqouLjfWvJxi3nEa7WAdN/zVFD5wjnVB6KhxgBx
         w5RViK6nntKwmFhHf7Gj7Z1eN9rHejYeOjd8yfs3rPXIWmkickqA9kLuR4K9ZSnG/glI
         50Nla5lLbwp6lZZUCdfiegfYYm/i9QznYrIqhwnHBmc9UTiH/6b7NuggeMeTBfeF3tzR
         QULQ==
X-Gm-Message-State: APjAAAVQsZg5dhfvq9N5a4/PRHRuoAJJBufbRUXlxXyMFAvxce0unhQ5
        D3lCD3ZY+R3Eom0E/PCBvotVtKoOznlRv6sAfn8=
X-Google-Smtp-Source: APXvYqygqKjtDa2NahYmvQ09yEI1RbucOaFU5niv7YahP2CObEy3GlvCokICWQmUDX7aUPfgnNkSzsfK6+GvLzXDiGk=
X-Received: by 2002:a9d:67d7:: with SMTP id c23mr15298990otn.262.1581633803551;
 Thu, 13 Feb 2020 14:43:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1581463668.git.josh@joshtriplett.org>
In-Reply-To: <cover.1581463668.git.josh@joshtriplett.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Feb 2020 23:43:12 +0100
Message-ID: <CAJZ5v0iRhHuw=AdTj1G_D17L1uvO280UhCZChgs8Xax=Uw9ZgA@mail.gmail.com>
Subject: Re: [PATCH 0/2] ACPI: Tiny power button driver
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 12, 2020 at 12:36 AM Josh Triplett <josh@joshtriplett.org> wrote:
>
> Virtual machines often use an ACPI power button event to tell the
> machine to shut down gracefully.
>
> Provide an extremely lightweight "tiny power button" driver to handle
> this event by signaling init directly, rather than running a separate
> daemon (such as acpid or systemd-logind) that adds to startup time and
> VM image complexity.
>
> I originally proposed a change to the ACPI power button driver to
> introduce an optional path to signal init, but Rafael expressed a
> preference to have this as a separate, mutually exclusive driver
> instead. The result did come out much simpler, conceptually, with the
> added benefit of being able to disable CONFIG_INPUT entirely for a
> kernel that exclusively targets cloud/VM systems.
>
> The first patch in the series just moves HID definitions to
> acpi/button.h in preparation for sharing them with the tiny-power-button
> driver. The second patch provides the driver itself.
>
> Josh Triplett (2):
>   acpi: button: move HIDs to acpi/button.h
>   acpi: Add new tiny-power-button driver to directly signal init

Applied as 5.7 material, thanks!
