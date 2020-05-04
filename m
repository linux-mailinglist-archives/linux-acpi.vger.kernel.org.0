Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8901C4120
	for <lists+linux-acpi@lfdr.de>; Mon,  4 May 2020 19:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbgEDRJp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 May 2020 13:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730188AbgEDRJm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 May 2020 13:09:42 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B921EC061A0F
        for <linux-acpi@vger.kernel.org>; Mon,  4 May 2020 10:09:42 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id c3so9541818otp.8
        for <linux-acpi@vger.kernel.org>; Mon, 04 May 2020 10:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=i+2pl33LoND8rn0Y7JhGeOTRVPWpQ6iAUIg7IYjQeRY=;
        b=RSKYyByhc+B/qJYIIeWcVTJnYVebWzTt/X13WENuNH3vl26htM3tC+/678WIYTcNZW
         Ah6An8uLH78KIYFnnBerBnB1jWxJx7V9RpZNh0p/PcpOcNQ5VZD1lrX02jPkdHZMUans
         JyWDmvE10S/7Z5436S0/a4rZVc/lnnzSXddKza0QQyj1Chv7HT5OADcnNKgRKPpJqjgz
         FPOm7tHRUvxY0h4oG39JyfBe7tc986/TI9hn2B27UvuSE175IO62QMUR2/ppXFX0eeAq
         HvmECHPi19MnFBQrbUFoYUjfD9ZB/F9yZ8+O2wb82K7H+HvgVB37nQGjf13TF9xCrx74
         +YNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=i+2pl33LoND8rn0Y7JhGeOTRVPWpQ6iAUIg7IYjQeRY=;
        b=SLwqP33kqtqS0DhcDlZCssaKyNN+gj/V0JgeCBwFwrMr/bB61IyMC8FcoMUwYp0T0x
         d7ddFnNUb+act8yPS7SiSwhsTkmYuelqJySRVoTYPltQ0U/P/UeBKqtG4q8cSLElEsDl
         jSPRwKVm3P7eySwa2KJaxxh+6vBQL446yvpDdr+ZwXkUGfELkWGYqCpG3YZviWS+pc8y
         uXl8il7A75/LpzmCCQ2YYiDb1ep/PImeZ9Q6JdFsW6D0gsMdwExU0P6IrCdz3VaFmDic
         nVe3IVd4KJmyQAQmfWUw39xGd479ijS6CL2L9vbhbtWl442Vrr3uHu7oiNZCFHPjsUpL
         zXcw==
X-Gm-Message-State: AGi0PubYj0C3/BG8bZ4TH5+0Y2kz0Y93y/C2xUqHj1t9Gt/hv3lcZYoO
        NLhwvgXn+WkvSTKCyw1+W7V+P1AiESAvmUPbpHyrFA==
X-Google-Smtp-Source: APiQypKXW+FJtDmn09+9G0JZswb8TqwRgVG3w81exM8OTS25LQ22PZbLlhXgmBt4on9QtQZVasvrd4RgJukPl3UW1gI=
X-Received: by 2002:a05:6830:1212:: with SMTP id r18mr15724444otp.144.1588612181892;
 Mon, 04 May 2020 10:09:41 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Chiu <chiu@endlessm.com>
Date:   Tue, 5 May 2020 01:09:30 +0800
Message-ID: <CAB4CAwdqo7=MvyG_PE+PGVfeA17AHF5i5JucgaKqqMX6mjArbQ@mail.gmail.com>
Subject: System fails to exit s2idle by a keystroke on my laptop
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        seth.forshee@canonical.com, Len Brown <lenb@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,
    I have an Intel X5-Z8350 laptop which used to work fine on s2idle
enter/exit with kernel 5.3. After upgrading to kernel 5.4 and later,
the system can still exit s2idle by power button. However, if I try to
wake it up from a keystroke, the system will freeze and then no longer
respond even to the power button. I can only shut it down and power on
again.

    I tried to 'git bisect' to find out which commit causes the
difference, it shows me the commit "ACPI: PM: s2idle: Prevent spurious
SCIs from waking up the system". My laptop can work as usual to exit
s2idle by a keystroke with reverting it on kernel 5.4.

    Then I tried to check whether I can reproduce it on the latest
mainline kernel, the same problem still there. But I can not fix it by
simply reverting. I found the acpi_s2idle_wake() has been refined on
the latest mainline kernel, and I have to make modifications as
follows to make my laptop work.

@@ -1024,7 +1024,7 @@ static bool acpi_s2idle_wake(void)
                 * regarded as a spurious one.
                 */
                if (!acpi_ec_dispatch_gpe())
-                       return false;
+                       return true;

                /*
                 * Cancel the wakeup and process all pending events in case

    Maybe there's something special on my laptop so a keystroke is
considered as a spurious event on this machine? Don't know if the DSDT
helps or not.
https://gist.github.com/mschiu77/de8af6da78be12cf442853e7747f76ed

    Please let me know if there's anything I can help to address this
problem. Thanks

Chris
