Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D2F278E68
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Sep 2020 18:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgIYQ2K (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Sep 2020 12:28:10 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36540 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbgIYQ2K (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Sep 2020 12:28:10 -0400
Received: by mail-ot1-f67.google.com with SMTP id 60so2867344otw.3
        for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2020 09:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U6CM7qovD6SxevYMnn9s2q7euoAeXU0g3Mj2lAowh6k=;
        b=E/TN3bR9ZcQTcCXHQzW7EvuXLb+agUKBP19TVdUrrv/Kkemq4AV14XL0dtLK1t7Tl2
         Jhu7DCLD0c02h+1QCc+mhMHsqn4bW5tCIY3/UEftrY+Az9DyQsu4RW+WbTtKAVGvd8Ri
         j5VOroo8NEwea7GLp1bdjupZlWLbrCs2y7cIOdwQjc0CTOoqFUIPiNdFG/puK3/vR9wp
         RC2MHAIbVrm4NfLuY23nodMdWIV5Vf7sBAS3dCI03E8oqRlBTqc61LwwT0XGmT6E5sU0
         6dWmL9Xh8H6Ax1TtnFtfyrxhUrZ0DIJ8V4tFNT06Hz/e10rjzmSBZhDm5u52leLVJIOk
         ohKQ==
X-Gm-Message-State: AOAM53177MZgBNztHr5KvKEQLhIUjqjp6dhlLlEIQa2J7HGUpRIDXAk0
        5ON0gOAPqodUa0JHpeKrpLoWSn737rxSQO7DDK9+N7QC
X-Google-Smtp-Source: ABdhPJwalKLenOQWJ89uC89+lNmvQ8wTC61b5CShdH8t1dsC+sLHyGe5QYXJTg9Z0b6/IwaJQjEy8TYjMObJyyK4M/8=
X-Received: by 2002:a05:6830:1f16:: with SMTP id u22mr850734otg.118.1601051289526;
 Fri, 25 Sep 2020 09:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <1600916227-21805-1-git-send-email-guohanjun@huawei.com>
In-Reply-To: <1600916227-21805-1-git-send-email-guohanjun@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Sep 2020 18:27:58 +0200
Message-ID: <CAJZ5v0gNf9wSgL9FLZjEucTmtDeXWKKghT2JviQOM9F6LF96MA@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] Cleanups before decoupling ACPICA debug with
 ACPI driver
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 24, 2020 at 5:12 AM Hanjun Guo <guohanjun@huawei.com> wrote:
>
> With the evolution of the ACPI driver code, lots of the ACPICA debug
> functions such as ACPI_DEBUG_PRINT() used in ACPI drivers were removed
> away, this makes some of the ACPICA debug code in ACPI driver as dead,
> for example, _COMPONENT and ACPI_MODULE_NAME() are useless without
> ACPICA debug functions.
>
> This patch set will cleanup those dead code before decoupling ACPICA
> debug with ACPI driver, should be no functional change.
>
> v1->v2:
> - Remove patches that not for ACPICA debug cleanups, send them
>   seperately, this patch set only contains cleanups for ACPICA debug
>   functionality.
>
> Hanjun Guo (15):
>   ACPI: cmos_rtc: Remove the leftover ACPICA code ACPI_MODULE_NAME()
>   ACPI: LPSS: Remove the ACPI_MODULE_NAME()
>   ACPI: memhotplug: Remove the leftover ACPICA debug functionality
>   ACPI: platform: Remove the ACPI_MODULE_NAME()
>   ACPI: container: Remove the leftover ACPICA debug functionality
>   ACPI: custom_method: Remove the dead ACPICA debug code
>   ACPI: debugfs: Remove the dead ACPICA debug code
>   ACPI: dock: Remove the dead ACPICA debug code
>   ACPI: event: Remove the leftover ACPICA debug code
>   ACPI: PCI: Remove the unused ACPICA debug code
>   ACPI: proc: Remove the dead ACPICA debug code
>   ACPI: processor: Remove the dead ACPICA debug code
>   ACPI: tiny-power-button: Remove the dead ACPICA debug code
>   ACPI: video: Remove the leftover ACPICA debug code
>   ACPI: wakeup: Remove the dead ACPICA debug code

All applied as 5.10 material with minor subject and changelog edits, thanks!
